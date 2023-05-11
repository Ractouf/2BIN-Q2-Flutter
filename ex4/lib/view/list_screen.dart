import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/article_view_model.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, viewModel, child) =>
      Scaffold(
        appBar: AppBar(
          title: const Text("Articles"),
          actions: [
            IconButton(
              icon: viewModel.displayRead
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
              onPressed: () {
                viewModel.switchDisplayRead();
              },
            ),
            IconButton(icon: const Icon(Icons.abc), onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, "/form"),
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: viewModel.articles.isEmpty
              ? const Center(
                  child: Text("There are no articles yet. Create one!"),
                )
              : ListView.builder(
                  itemCount: viewModel.articles.length,
                  itemBuilder: (contexte, index) {
                    var article = viewModel.articles[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                            icon: article.read
                                ? const Icon(Icons.check_box)
                                : const Icon(Icons.check_box_outline_blank),
                            onPressed: () {
                              viewModel.switchRead(article.id);
                            },
                          ),
                          title: Text(article.title),
                          subtitle: Text(article.author),
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/article",
                            arguments: article.id,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              viewModel.deleteArticle(article.id);
                            },
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

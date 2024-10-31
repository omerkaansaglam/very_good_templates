dart pub global activate mason_cli &&
echo "It may prompt you for your password to delete the .mason-cache folder." &&
sudo rm -rf ~/.mason-cache && echo "Cache cleared." &&
mason add -g arteria_flutter_template --git-url https://github.com/omerkaansaglam/very_good_templates &&
mason make arteria_flutter_template
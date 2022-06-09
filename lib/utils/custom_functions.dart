class CustomFunctions {
  static String getValueByOperator(String queryName, String queryValue) {
    switch (queryName) {
      case 'start with':
        return '$queryValue%';
      case 'end with':
        return '%$queryValue';
      case 'contains':
        return '%$queryValue%';
      case 'exact':
        return queryValue;
      default:
        return queryValue;
    }
  }
}

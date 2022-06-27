class NewsModel {
  int? id;
  String? date;
  String? dateGmt;
  Guid? guid;
  String? modified;
  String? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Guid? title;
  Content? content;
  Content? excerpt;
  int? author;
  int? featuredMedia;
  String? commentStatus;
  String? pingStatus;
  bool? sticky;
  String? template;
  String? format;
  Meta? meta;
  List<int>? categories;
  List<int>? tags;
  String? yoastHead;
  YoastHeadJson? yoastHeadJson;
  String? jetpackFeaturedMediaUrl;

  NewsModel(
      {this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.content,
        this.excerpt,
        this.author,
        this.featuredMedia,
        this.commentStatus,
        this.pingStatus,
        this.sticky,
        this.template,
        this.format,
        this.meta,
        this.categories,
        this.tags,
        this.yoastHead,
        this.yoastHeadJson,
        this.jetpackFeaturedMediaUrl});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    excerpt =
    json['excerpt'] != null ? new Content.fromJson(json['excerpt']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    sticky = json['sticky'];
    template = json['template'];
    format = json['format'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    categories = json['categories'].cast<int>();
    tags = json['tags'].cast<int>();
    yoastHead = json['yoast_head'];
    yoastHeadJson = json['yoast_head_json'] != null
        ? new YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid!.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt!.toJson();
    }
    data['author'] = this.author;
    data['featured_media'] = this.featuredMedia;
    data['comment_status'] = this.commentStatus;
    data['ping_status'] = this.pingStatus;
    data['sticky'] = this.sticky;
    data['template'] = this.template;
    data['format'] = this.format;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['categories'] = this.categories;
    data['tags'] = this.tags;
    data['yoast_head'] = this.yoastHead;
    if (this.yoastHeadJson != null) {
      data['yoast_head_json'] = this.yoastHeadJson!.toJson();
    }
    data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;
    return data;
  }
}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Meta {
  String? spayEmail;
  String? jetpackPublicizeMessage;
  bool? jetpackIsTweetstorm;
  bool? jetpackPublicizeFeatureEnabled;

  Meta(
      {this.spayEmail,
        this.jetpackPublicizeMessage,
        this.jetpackIsTweetstorm,
        this.jetpackPublicizeFeatureEnabled});

  Meta.fromJson(Map<String, dynamic> json) {
    spayEmail = json['spay_email'];
    jetpackPublicizeMessage = json['jetpack_publicize_message'];
    jetpackIsTweetstorm = json['jetpack_is_tweetstorm'];
    jetpackPublicizeFeatureEnabled = json['jetpack_publicize_feature_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spay_email'] = this.spayEmail;
    data['jetpack_publicize_message'] = this.jetpackPublicizeMessage;
    data['jetpack_is_tweetstorm'] = this.jetpackIsTweetstorm;
    data['jetpack_publicize_feature_enabled'] =
        this.jetpackPublicizeFeatureEnabled;
    return data;
  }
}

class YoastHeadJson {
  String? title;
  String? description;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogDescription;
  String? ogUrl;
  String? ogSiteName;
  String? articlePublisher;
  String? articlePublishedTime;
  List<OgImage>? ogImage;
  String? twitterCard;
  String? twitterCreator;
  String? twitterSite;
  TwitterMisc? twitterMisc;

  YoastHeadJson(
      {this.title,
        this.description,
        this.canonical,
        this.ogLocale,
        this.ogType,
        this.ogTitle,
        this.ogDescription,
        this.ogUrl,
        this.ogSiteName,
        this.articlePublisher,
        this.articlePublishedTime,
        this.ogImage,
        this.twitterCard,
        this.twitterCreator,
        this.twitterSite,
        this.twitterMisc});

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    canonical = json['canonical'];
    ogLocale = json['og_locale'];
    ogType = json['og_type'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    ogUrl = json['og_url'];
    ogSiteName = json['og_site_name'];
    articlePublisher = json['article_publisher'];
    articlePublishedTime = json['article_published_time'];
    if (json['og_image'] != null) {
      ogImage = <OgImage>[];
      json['og_image'].forEach((v) {
        ogImage!.add(new OgImage.fromJson(v));
      });
    }
    twitterCard = json['twitter_card'];
    twitterCreator = json['twitter_creator'];
    twitterSite = json['twitter_site'];
    twitterMisc = json['twitter_misc'] != null
        ? new TwitterMisc.fromJson(json['twitter_misc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['canonical'] = this.canonical;
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_description'] = this.ogDescription;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_publisher'] = this.articlePublisher;
    data['article_published_time'] = this.articlePublishedTime;
    if (this.ogImage != null) {
      data['og_image'] = this.ogImage!.map((v) => v.toJson()).toList();
    }
    data['twitter_card'] = this.twitterCard;
    data['twitter_creator'] = this.twitterCreator;
    data['twitter_site'] = this.twitterSite;
    if (this.twitterMisc != null) {
      data['twitter_misc'] = this.twitterMisc!.toJson();
    }
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  String? url;
  String? type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class TwitterMisc {
  String? yazan;
  String? tahminiOkumaSResi;

  TwitterMisc({this.yazan, this.tahminiOkumaSResi});

  TwitterMisc.fromJson(Map<String, dynamic> json) {
    yazan = json['Yazan:'];
    tahminiOkumaSResi = json['Tahmini okuma süresi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Yazan:'] = this.yazan;
    data['Tahmini okuma süresi'] = this.tahminiOkumaSResi;
    return data;
  }
}

class Graph {
  String? type;
  String? id;
  String? name;
  String? url;
  List<String>? sameAs;
  Logo? logo;
  Image2? image;
  String? description;
  Publisher? publisher;
  List<PotentialAction>? potentialAction;
  String? inLanguage;
  String? contentUrl;
  int? width;
  int? height;
  Publisher? isPartOf;
  Publisher? primaryImageOfPage;
  String? datePublished;
  String? dateModified;
  Publisher? breadcrumb;
  List<ItemListElement>? itemListElement;
  Publisher? author;
  String? headline;
  Publisher? mainEntityOfPage;
  int? wordCount;
  int? commentCount;
  String? thumbnailUrl;
  List<String>? keywords;
  List<String>? articleSection;
  String? copyrightYear;
  Publisher? copyrightHolder;

  Graph(
      {this.type,
        this.id,
        this.name,
        this.url,
        this.sameAs,
        this.logo,
        this.image,
        this.description,
        this.publisher,
        this.potentialAction,
        this.inLanguage,
        this.contentUrl,
        this.width,
        this.height,
        this.isPartOf,
        this.primaryImageOfPage,
        this.datePublished,
        this.dateModified,
        this.breadcrumb,
        this.itemListElement,
        this.author,
        this.headline,
        this.mainEntityOfPage,
        this.wordCount,
        this.commentCount,
        this.thumbnailUrl,
        this.keywords,
        this.articleSection,
        this.copyrightYear,
        this.copyrightHolder});

  Graph.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    name = json['name'];
    url = json['url'];
    sameAs = json['sameAs'].cast<String>();
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    image = json['image'] != null ? new Image2.fromJson(json['image']) : null;
    description = json['description'];
    publisher = json['publisher'] != null
        ? new Publisher.fromJson(json['publisher'])
        : null;
    if (json['potentialAction'] != null) {
      potentialAction = <PotentialAction>[];
      json['potentialAction'].forEach((v) {
        potentialAction!.add(new PotentialAction.fromJson(v));
      });
    }
    inLanguage = json['inLanguage'];
    contentUrl = json['contentUrl'];
    width = json['width'];
    height = json['height'];
    isPartOf = json['isPartOf'] != null
        ? new Publisher.fromJson(json['isPartOf'])
        : null;
    primaryImageOfPage = json['primaryImageOfPage'] != null
        ? new Publisher.fromJson(json['primaryImageOfPage'])
        : null;
    datePublished = json['datePublished'];
    dateModified = json['dateModified'];
    breadcrumb = json['breadcrumb'] != null
        ? new Publisher.fromJson(json['breadcrumb'])
        : null;
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
    author =
    json['author'] != null ? new Publisher.fromJson(json['author']) : null;
    headline = json['headline'];
    mainEntityOfPage = json['mainEntityOfPage'] != null
        ? new Publisher.fromJson(json['mainEntityOfPage'])
        : null;
    wordCount = json['wordCount'];
    commentCount = json['commentCount'];
    thumbnailUrl = json['thumbnailUrl'];
    articleSection = json['articleSection'].cast<String>();
    copyrightYear = json['copyrightYear'];
    copyrightHolder = json['copyrightHolder'] != null
        ? new Publisher.fromJson(json['copyrightHolder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['@id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['sameAs'] = this.sameAs;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['description'] = this.description;
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.toJson();
    }
    if (this.potentialAction != null) {
      data['potentialAction'] =
          this.potentialAction!.map((v) => v.toJson()).toList();
    }
    data['inLanguage'] = this.inLanguage;
    data['contentUrl'] = this.contentUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    if (this.isPartOf != null) {
      data['isPartOf'] = this.isPartOf!.toJson();
    }
    if (this.primaryImageOfPage != null) {
      data['primaryImageOfPage'] = this.primaryImageOfPage!.toJson();
    }
    data['datePublished'] = this.datePublished;
    data['dateModified'] = this.dateModified;
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['headline'] = this.headline;
    if (this.mainEntityOfPage != null) {
      data['mainEntityOfPage'] = this.mainEntityOfPage!.toJson();
    }
    data['wordCount'] = this.wordCount;
    data['commentCount'] = this.commentCount;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['keywords'] = this.keywords;
    data['articleSection'] = this.articleSection;
    data['copyrightYear'] = this.copyrightYear;
    if (this.copyrightHolder != null) {
      data['copyrightHolder'] = this.copyrightHolder!.toJson();
    }
    return data;
  }
}

class Logo {
  String? type;
  String? id;
  String? inLanguage;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  String? caption;

  Logo(
      {this.type,
        this.id,
        this.inLanguage,
        this.url,
        this.contentUrl,
        this.width,
        this.height,
        this.caption});

  Logo.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    inLanguage = json['inLanguage'];
    url = json['url'];
    contentUrl = json['contentUrl'];
    width = json['width'];
    height = json['height'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['@id'] = this.id;
    data['inLanguage'] = this.inLanguage;
    data['url'] = this.url;
    data['contentUrl'] = this.contentUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['caption'] = this.caption;
    return data;
  }
}

class Image2 {
  String? id;
  String? type;
  String? inLanguage;
  String? url;
  String? contentUrl;
  String? caption;

  Image2(
      {this.id,
        this.type,
        this.inLanguage,
        this.url,
        this.contentUrl,
        this.caption});

  Image2.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    type = json['@type'];
    inLanguage = json['inLanguage'];
    url = json['url'];
    contentUrl = json['contentUrl'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    data['@type'] = this.type;
    data['inLanguage'] = this.inLanguage;
    data['url'] = this.url;
    data['contentUrl'] = this.contentUrl;
    data['caption'] = this.caption;
    return data;
  }
}

class Publisher {
  String? id;

  Publisher({this.id});

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    return data;
  }
}

class PotentialAction {
  String? type;
  Target? target;
  String? queryInput;
  String? name;

  PotentialAction({this.type, this.target, this.queryInput, this.name});

  PotentialAction.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    target =
    json['target'] != null ? new Target.fromJson(json['target']) : null;
    queryInput = json['query-input'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    data['query-input'] = this.queryInput;
    data['name'] = this.name;
    return data;
  }
}

class Target {
  String? type;
  String? urlTemplate;

  Target({this.type, this.urlTemplate});

  Target.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    urlTemplate = json['urlTemplate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['urlTemplate'] = this.urlTemplate;
    return data;
  }
}

class ItemListElement {
  String? type;
  int? position;
  String? name;
  String? item;

  ItemListElement({this.type, this.position, this.name, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({this.embeddable, this.href});

  Author.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class VersionHistory {
  int? count;
  String? href;

  VersionHistory({this.count, this.href});

  VersionHistory.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['href'] = this.href;
    return data;
  }
}

class PredecessorVersion {
  int? id;
  String? href;

  PredecessorVersion({this.id, this.href});

  PredecessorVersion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['href'] = this.href;
    return data;
  }
}

class WpTerm {
  String? taxonomy;
  bool? embeddable;
  String? href;

  WpTerm({this.taxonomy, this.embeddable, this.href});

  WpTerm.fromJson(Map<String, dynamic> json) {
    taxonomy = json['taxonomy'];
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxonomy'] = this.taxonomy;
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class Curies {
  String? name;
  String? href;
  bool? templated;

  Curies({this.name, this.href, this.templated});

  Curies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    href = json['href'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['href'] = this.href;
    data['templated'] = this.templated;
    return data;
  }
}
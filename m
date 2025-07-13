Return-Path: <linux-kernel+bounces-729017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC363B0308F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B924A181F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7127978D;
	Sun, 13 Jul 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MoOMLLNP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA45277C88
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400347; cv=none; b=qozeBvKXzN3A6n1z5BI7nTUPxnACoIRGzR/Tw/QLzr8iE0bzSCLE5Pu6AT1akRQBls1RVqNmdBgHay/+4U8jDQ0i6bxTuiDynwjJEGUkN/NKn8Jp6irDtbCPbuq6rmXLhJYHFtM8sfthrAG52DgCEke9JaKnTi//hCGu4tzXdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400347; c=relaxed/simple;
	bh=3jbICsVpA2/tf5f0WVhMM1PQ4J75Rl/Lh/mqHkdc5+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMufCDKrQYXHsywM6/tXobEX/JudSN78Jr8WKSiRcKIuFpGQGrGdYF4XWYuaB5ehlWzf9rG8UlfQzfN1e+MHT6EO5eJp3fLELlzo9+xSUjN2XWfZbe0LVD8HQWkOJp2+30vdlEyupJb0uOsO1zSI5WzEOdPEICXJrRFnxTwQ0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MoOMLLNP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=3jbICsVpA2/tf5f0WVhMM1PQ4J75Rl/Lh/mqHkdc5+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MoOMLLNP5+RH13BwADejGnwVLUifNeTfK54NPEvPkmTyPX5Bo7x8Z2NFVXKFK1jqW
	 d/+CDUMg7/Jp/NKlb23xvOeiwr6rSIit2yXsUPX77hbYOxcrTIV+mjLxg8mL3mpWhp
	 ZZBkSCnsBQ81ciIw6hyuifHnyzuUjRED8E+WpUXE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:18 +0200
Subject: [PATCH RESEND v2 6/7] samples/kobject: constify 'struct
 foo_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-6-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=4840;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3jbICsVpA2/tf5f0WVhMM1PQ4J75Rl/Lh/mqHkdc5+8=;
 b=5lR+dSVgSfO9u++R6+i1FkWThVVt6k2ougLCPMN5V+bmkGwwRU5wHZfpqNrhJs5isOLGSUuHQ
 75NZoIw74pcDJZNcvUISxzv0NMscri17mJpR3XBcCd5ertMwTOF0jyt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Showcase and test the new 'struct attribute' constification facilities.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 samples/kobject/kset-example.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 7d8c68763ff8af696cbafaed1d5f1b173bb4860e..cbcfa628cc2801a7c4fc0d868898c4cfa539825c 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -37,10 +37,11 @@ struct foo_obj {
 /* a custom attribute that works just for a struct foo_obj. */
 struct foo_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct foo_obj *foo, struct foo_attribute *attr, char *buf);
-	ssize_t (*store)(struct foo_obj *foo, struct foo_attribute *attr, const char *buf, size_t count);
+	ssize_t (*show)(struct foo_obj *foo, const struct foo_attribute *attr, char *buf);
+	ssize_t (*store)(struct foo_obj *foo, const struct foo_attribute *attr,
+			 const char *buf, size_t count);
 };
-#define to_foo_attr(x) container_of(x, struct foo_attribute, attr)
+#define to_foo_attr(x) container_of_const(x, struct foo_attribute, attr)
 
 /*
  * The default show function that must be passed to sysfs.  This will be
@@ -53,7 +54,7 @@ static ssize_t foo_attr_show(struct kobject *kobj,
 			     struct attribute *attr,
 			     char *buf)
 {
-	struct foo_attribute *attribute;
+	const struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
 	attribute = to_foo_attr(attr);
@@ -73,7 +74,7 @@ static ssize_t foo_attr_store(struct kobject *kobj,
 			      struct attribute *attr,
 			      const char *buf, size_t len)
 {
-	struct foo_attribute *attribute;
+	const struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
 	attribute = to_foo_attr(attr);
@@ -109,13 +110,13 @@ static void foo_release(struct kobject *kobj)
 /*
  * The "foo" file where the .foo variable is read from and written to.
  */
-static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
+static ssize_t foo_show(struct foo_obj *foo_obj, const struct foo_attribute *attr,
 			char *buf)
 {
 	return sysfs_emit(buf, "%d\n", foo_obj->foo);
 }
 
-static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
+static ssize_t foo_store(struct foo_obj *foo_obj, const struct foo_attribute *attr,
 			 const char *buf, size_t count)
 {
 	int ret;
@@ -128,14 +129,14 @@ static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 }
 
 /* Sysfs attributes cannot be world-writable. */
-static struct foo_attribute foo_attribute =
+static const struct foo_attribute foo_attribute =
 	__ATTR(foo, 0664, foo_show, foo_store);
 
 /*
  * More complex function where we determine which variable is being accessed by
  * looking at the attribute for the "baz" and "bar" files.
  */
-static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
+static ssize_t b_show(struct foo_obj *foo_obj, const struct foo_attribute *attr,
 		      char *buf)
 {
 	int var;
@@ -147,7 +148,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 	return sysfs_emit(buf, "%d\n", var);
 }
 
-static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
+static ssize_t b_store(struct foo_obj *foo_obj, const struct foo_attribute *attr,
 		       const char *buf, size_t count)
 {
 	int var, ret;
@@ -163,16 +164,16 @@ static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 	return count;
 }
 
-static struct foo_attribute baz_attribute =
+static const struct foo_attribute baz_attribute =
 	__ATTR(baz, 0664, b_show, b_store);
-static struct foo_attribute bar_attribute =
+static const struct foo_attribute bar_attribute =
 	__ATTR(bar, 0664, b_show, b_store);
 
 /*
  * Create a group of attributes so that we can create and destroy them all
  * at once.
  */
-static struct attribute *foo_default_attrs[] = {
+static const struct attribute *const foo_default_attrs[] = {
 	&foo_attribute.attr,
 	&baz_attribute.attr,
 	&bar_attribute.attr,
@@ -180,7 +181,7 @@ static struct attribute *foo_default_attrs[] = {
 };
 
 static umode_t foo_default_attrs_is_visible(struct kobject *kobj,
-					    struct attribute *attr,
+					    const struct attribute *attr,
 					    int n)
 {
 	/* Hide attributes with the same name as the kobject. */
@@ -190,8 +191,8 @@ static umode_t foo_default_attrs_is_visible(struct kobject *kobj,
 }
 
 static const struct attribute_group foo_default_group = {
-	.attrs		= foo_default_attrs,
-	.is_visible	= foo_default_attrs_is_visible,
+	.attrs_new	= foo_default_attrs,
+	.is_visible_new	= foo_default_attrs_is_visible,
 };
 __ATTRIBUTE_GROUPS(foo_default);
 

-- 
2.50.1



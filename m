Return-Path: <linux-kernel+bounces-812897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F69B53DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97BA167A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE7369353;
	Thu, 11 Sep 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvnaixgf"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61712E8B6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626760; cv=none; b=oQi9ICztSOYh1cEO284yQnN6JM36lQJ+QLKuSiUZ7KP5S6Sdy1Ta8oX3Q7lye3lzl+YW16YAr5zILfefBf0YVKfgzQyg7orVEhuQDwiB05/mNzw+WKs5PFS+TyKj6Cgyy08Hdn0yp4HdXOF6iAQrP7W7Jk8aDiJmxqlitDESgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626760; c=relaxed/simple;
	bh=4Li+TNbKcqL0TAB0esACJFmyA2n7TEQJyXht92HSZD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQdhcWhJ/a1fvmVf7mT55leJwLsG/j45OSMsjtHvc+rPWnn7S441rXqRXfaea7RvlEGVMLi+Q9x482kDXXJIfeveCzfqlzaqQS2Zt2csgkMe0TBzIwQQHl7cSPs6yoKIObgcvEyC1iDZey48qNpafizVHmYd4wJDz4C+3YpSvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvnaixgf; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8876de33c86so96212239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626757; x=1758231557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wygi4dkCvAxIjLq/ioBbAIy8T8pr9875pW4yDSmQbI=;
        b=Gvnaixgf3HQoc7R7OOSHFFFwqslPC9AZQIAz+/Ue83afqWprX9/rsB1a7AZqe7UzCx
         O5tALsjEubFATuDTUwHYTlKwkKBBXua8DljY3YEBkCO+uEz1WiNsAB7iDEXhz8hu3dXD
         F+1iCxo6yi2VYi32RxkoxID4llPXFPc6EFeinGNUa/8rH+8Ap9kT1CBBoqeSRrZEcigv
         EvtzTJxqWVzeUlB1ZEd3Qsu3JqM4MFJfqHzQJG3RjN0z85auSK2bIbBjdYCa3bV06tJq
         oG1Z7lpod3/cFJyUsmnoLq9FkZ/Qz85vuXyLehtre8wUQz4afd9oyV1Q+fCoYfx43hwf
         FV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626757; x=1758231557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wygi4dkCvAxIjLq/ioBbAIy8T8pr9875pW4yDSmQbI=;
        b=luJ1kRl4e/SvmZwETKgDqJjcmSZlk9D5EgeQJ7tl20COCOlrKbJ3abkNrny6xgdd52
         qIvcbKI3YcMq8dHmoAkXaY0QmTEkjroRE2gVbbnEI0Oro16ONaDZ9iJ80rU3eIG6yFhk
         XVN0mhX1kMXlihvHJWONaTL68uG+1GEPFkctH+OIX7AJaJdB6an+YxGp0qbQWYbqWM3B
         azWH+n9nKqwA3kVQzg64deKQCCJt4ifWk87FbZJ8ftglnDFopUl0rAXjjvtF6Dzm+EoZ
         B9AVLuMtYXcKsjOHa7OgOaB6xqkJyJ4g4Tcq/7dS3tskdtFghTU6F7VevqT9OsJOFG8k
         eJvA==
X-Forwarded-Encrypted: i=1; AJvYcCXX87QXI7HfGrsoNnS1O8oSQhzUnWtM3/nLucotZNfqrauzbgGrDgBbptC7funsCJVS94KkS3ETOnRP2Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKA0Vf8oxb7vrSyeQHs/zx231YnSsbAfQXBhhv3SAuvWiNVaN
	45bF0ErsSYT32g8Du0vznLKr55RKE5jGKQgDMSYHzmy3bHIT6t5XqmIgEUWLWw==
X-Gm-Gg: ASbGncuvJ0WHlkEMvJ7+MyuJHHqlLsIVc15kcftHHO91znz1wvihgjVghVveqv2Kk9r
	S7LJA7zNg5xTlKH7+/IEHtlHSiwJj/fnKvS+I11ObM/qRRCipV5077SyilqwASBuOie2q9n4Tps
	uidDfQYtNsTIqRB08y8vRbdVNd9upIFMsc0LYa3Qv85cQIE+MuYCrEu9FOLsjCuhC1IFi1m70Xf
	LbwS3V1299SsfvMLzY8mpAI3EsfWRtUOcySp+ckrs8FrnjUmSRpnJXjuJVupXCVViQDp0ThmtXJ
	aL3lUq2UWpVmEMvxpb8CeYVdN3IjszpPq8Y2QbxH/WKrQvE+ThhNxbEe7nMMFFS5RjF3uFTPJRr
	T+rMfJLWuNSP4rtcnw48EEOdea4mPuRgBHsUWxiPqdHw0eqkhbgKF+vlUuCkc8d2d0NgYmDSmTV
	FjON0GUiUt/zA1Nw==
X-Google-Smtp-Source: AGHT+IFDuJTgWowbFr7V5CKbhNLDixBhshWBZCmuQhefQH8Gegnt5Fq4qn7wJAtpl0LQpZzCKq4dDQ==
X-Received: by 2002:a05:6602:7216:b0:88c:30f3:32c9 with SMTP id ca18e2360f4ac-89033c6d33amr134556439f.15.1757626756762;
        Thu, 11 Sep 2025 14:39:16 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 29/30] dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base)
Date: Thu, 11 Sep 2025 15:38:22 -0600
Message-ID: <20250911213823.374806-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The @_base parameter in @DYNAMIC_DEBUG_CLASSMAP_DEFINE exists to
de-conflict a second classmap definition from a first, by setting
different .class_id constants for all of the second map's pr_debug
callsites.

This gives the same _base param, and thus more flexible usage via
@DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base).  So now 2nd classmap used
can be deconflicted from the 1st used or defined.

1st the range-checking logic is refined into two distinct macros,
@ddebug_class_map_in_range() and @ddebug_class_user_in_range(), which
are then applied to the lookup functions: @ddebug_find_valid_class(),
@ddebug_find_map_by_class_id(), and @ddebug_class_name().

The @DYNAMIC_DEBUG_CLASSMAP_USE* macro API kdoc is adjusted accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 28 ++++++++++++++++++++++------
 lib/dynamic_debug.c           | 21 +++++++++++++--------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 588e03e8d157..d1e38158c485 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -87,7 +87,7 @@ struct _ddebug_class_map {
 struct _ddebug_class_user {
 	char *mod_name;
 	struct _ddebug_class_map *map;
-	const int base;		/* user offset to re-number the used map */
+	const int base;		/* offset .class_id range to share space */
 };
 
 /*
@@ -235,15 +235,31 @@ struct _ddebug_class_param {
 /**
  * DYNAMIC_DEBUG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
  * @_var: name of the exported classmap var
- * @_not_yet: _base-like, but applies only to this USEr. (if needed)
  *
  * This tells dyndbg that the module has prdbgs with classids defined
  * in the named classmap.  This qualifies "class NAME" >controls on
- * the user module, and ignores unknown names.
+ * the user module, and ignores unknown names. This is a wrapper for
+ * DYNAMIC_DEBUG_CLASSMAP_USE_() with a base offset of 0.
  */
-#define DYNAMIC_DEBUG_CLASSMAP_USE(_var)				\
-	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0, __UNIQUE_ID(_ddebug_class_user))
-#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _base, _uname)		\
+#define DYNAMIC_DEBUG_CLASSMAP_USE(_var) \
+	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0)
+
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_USE_ - refer to a classmap with a manual offset.
+ * @_var:   name of the exported classmap var to use.
+ * @_base:  an integer offset to add to the class IDs of the used map.
+ *
+ * This is an extended version of DYNAMIC_DEBUG_CLASSMAP_USE(). It should
+ * be used to resolve class ID conflicts when a module uses multiple
+ * classmaps that have overlapping ID ranges.
+ *
+ * The final class IDs for the used map will be calculated as:
+ * original_map_base + class_index + @_base.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _base)			\
+	__DYNAMIC_DEBUG_CLASSMAP_USE(_var, _base, __UNIQUE_ID(_ddebug_class_user))
+
+#define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _base, _uname)		\
 	extern struct _ddebug_class_map _var;				\
 	static struct _ddebug_class_user __aligned(8) __used		\
 	__section("__dyndbg_class_users") _uname = {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 97070ddf31c6..486aa68670d8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -169,6 +169,12 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  _di->users.len);					\
 	})
 
+#define ddebug_class_map_in_range(id, map) \
+	((id) >= (map)->base && (id) < (map)->base + (map)->length)
+#define ddebug_class_user_in_range(id, user) \
+	((id) >= ((user)->map->base + (user)->base) && \
+	 (id) < ((user)->map->base + (user)->base + (user)->map->length))
+
 static struct _ddebug_class_map *
 ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class, int *class_id)
 {
@@ -189,7 +195,7 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 		if (idx >= 0) {
 			vpr_di_info(di, "class-ref: %s -> %s.%s ",
 				    cli->mod_name, cli->map->mod_name, query_class);
-			*class_id = idx + cli->map->base;
+			*class_id = idx + cli->map->base + cli->base;
 			return cli->map;
 		}
 	}
@@ -197,8 +203,7 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 	return NULL;
 }
 
-#define class_in_range(class_id, map)					\
-	(class_id >= map->base && class_id < map->base + map->length)
+
 
 static struct _ddebug_class_map *
 ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
@@ -208,11 +213,11 @@ ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (class_in_range(class_id, map))
+		if (ddebug_class_map_in_range(class_id, map))
 			return map;
 
 	for_subvec(i, cli, di, users)
-		if (class_in_range(class_id, cli->map))
+		if (ddebug_class_user_in_range(class_id, cli))
 			return cli->map;
 
 	return NULL;
@@ -1146,12 +1151,12 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (class_in_range(dp->class_id, map))
+		if (ddebug_class_map_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	for_subvec(i, cli, di, users)
-		if (class_in_range(dp->class_id, cli->map))
-			return cli->map->class_names[dp->class_id - cli->map->base];
+		if (ddebug_class_user_in_range(dp->class_id, cli))
+			return cli->map->class_names[dp->class_id - cli->map->base - cli->base];
 
 	return NULL;
 }
-- 
2.51.0



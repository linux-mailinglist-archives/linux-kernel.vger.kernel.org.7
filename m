Return-Path: <linux-kernel+bounces-847316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FEBCA83E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85F71A664BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD02F6571;
	Thu,  9 Oct 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F30PyS0b"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F1253957
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032761; cv=none; b=Qx5vi1RpGCbuUaQs4Ogi8ZKthQ4a1wSSCB74hUMSDh6QIYZTPoPEcmsAKQsiXzqcXe2COG0iXtqhz4Wf0IjiMcl+pYrBcRiYUPsRVad2DazDMqgOoETSxsv0I9+B8E3nLZXYXNn74sHI5V3tktizUqKjWcd1aN2t5Ar481WDDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032761; c=relaxed/simple;
	bh=fzEy8dmuUHYtFgbqFz4KTxTrUz512mMe8qEdjC4atfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dclonlZYHfi+Jrjf82iLGbYPI3wrrocn/yLwrLSOSjBkO4FnFNSGvhaP1CbU1shSIsvf9RfG4xTu6Iz6E2STMTDw+Ev25np2hYSytNYaYk0uKXx8hK7oaPbQT+KPtFLLI7iUjucxNTRuWtA97QASNM2TGs0Ibv0TVT2yUWvk5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F30PyS0b; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42e726431bdso6886775ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032759; x=1760637559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJonn1UQmdMquLncDUtZUHutcCuWRZij3zF+8bzYpyM=;
        b=F30PyS0blaUihB05HCGIXVWzSAGnBq7sIuIv+ogmvIq6w38EXg4UFzGLHnjjpSlMuF
         OrCXqG7+1JWd93+W7mt/LBQVZZdR+mF8ln+1k52BZ+qgJ7867gVUDa17cBqFP1+l6+On
         P1ho9aTMW4QGULBimGjyetrSLi7ciYKYXugJnjYMMyZRMl+yJaaXOCvdMT5zzhxQX8vb
         Bj1mAXedv2EMkfh3T/uKqG3ce5PIP8daV8GJeWU6vU6QP+GqQQBYKRABPwCeIriLI+My
         1juQvkMwiOX0goJ0EFs/Y3+h1QZugKVWFTgikvr2B6BrEYT58B93UzQYV9hG/t6/lcyM
         7eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032759; x=1760637559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJonn1UQmdMquLncDUtZUHutcCuWRZij3zF+8bzYpyM=;
        b=dbicSwfhb6rS7nHbu9pxI0eTc8Oaa0UaCf/bcMplNYmXwOfKeoIZM4nWn7ptm3xtgW
         FTJCgdjs+34/mOhFw8oU1iUvAocG6rBWEAcX3CdWk75DlSvZctWY4jiWHAfnQwkWdyAh
         wFS/myROr7HupXX/9ctcX39Q7ml0UJZkPrEWCiUrzqwBY00BfPAlfEwiIZND65LA5hxD
         743SYfBrIatuyZC4uwvY1TzqyD6UyoOjSYgIww6j5MIdaw+fQW3aSeFBQdRKE5Hz19Yn
         tDLQMK9u0CFknAwqK9K3Eoc8/uDCw2ozN/ojZ+G55rj4ph8jgCbeb6ikqsr1il0is80J
         4dZw==
X-Forwarded-Encrypted: i=1; AJvYcCXY9ytkqeJelTApjc4PmFKFkBkHwW6nixRq0+vN+T0sMACDXMLB+n7C9bLG7ynmiuEa9as9nYvNVNzVjyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwg92h2UQuS1SEMGct6LJ16fgT5Qd7ZdVDE6QLsbKTqSGNeGhu
	Yk1l3zGNI0fDvWfSWvd9mFYnG5uzP83O7hIn/+S+2yvfgYLYVgGMvlhC
X-Gm-Gg: ASbGnctlzwJlHhum7jsf/VLvS62DC+LKuWdMmslGpkONeRJpi31QSeGcU6E94k91ZKE
	m68xn2hkjP9FcwP3RjN3i+JpRlqf0u5hVCgqpRBq9ltIEQHS5jFbwcSL/nt0SiB1AFIMq2q7i7y
	UVFae8vt/yaf/j9KeuIofRoGYK+3VGCMtSgXK9RgOy2KiQ3cQKfZsjRhEBIeBHPg3WJomQbL078
	50unU7OKjptUzqynKbHluMSJdoFmNZQTWva68DDwDEGCJSQs0WSIQFFYTrW5+456i2ghgbrhibV
	30ui8sVP0WS5Df6LVn+uzuFTswXu9yJljoN4gfuP3ObMe4Zr+3fFfEjt/LBaWuONiqHxcwLcNLL
	ebZ9+J3m32j3NSIHxFJ9UlSxDNZ1pfjCqsh03gSLzSKAsiEp3QyaJuzO6NZk1G5wYmlslSIGoR2
	f9Np4fmPjaVuQ+nQZ0vIKgLe7CUnmSNubEOVLq3Q==
X-Google-Smtp-Source: AGHT+IHVKXFMusdqiPmDW/wzqUDYexOwse+E0pYDfFVpPjytm/THWwTC1XlwfHUx8Qo1uHRSZGwKQQ==
X-Received: by 2002:a05:6e02:2489:b0:42f:9649:56b4 with SMTP id e9e14a558f8ab-42f96495934mr16480345ab.13.1760032758628;
        Thu, 09 Oct 2025 10:59:18 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 29/30] dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base)
Date: Thu,  9 Oct 2025 11:58:33 -0600
Message-ID: <20251009175834.1024308-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
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

@DYNAMIC_DEBUG_CLASSMAP_USE* macro API kdoc is adjusted accordingly.

TODO: This is just an api placeholder, it anticipates a possible need
that may never arise.  The normal way to add a new classmap to a drm
driver would be to define the enum to avoid DRM_UT_CORE..RES vals.

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
index 6e0c978bc7c4..68bd2dbdacfb 100644
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



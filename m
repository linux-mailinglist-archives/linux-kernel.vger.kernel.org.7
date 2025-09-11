Return-Path: <linux-kernel+bounces-812883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED48B53DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9202F18861CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877852E36F8;
	Thu, 11 Sep 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmm6NWQQ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB912DECAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626746; cv=none; b=gVafb0LZXoIUL67l5nxcrGKz7KQJ3mFqFkmIKCVqnpcrFvNf9Xf9S06VbO9HWBlL26fXjkNEEZBNBs+1eIiXe7wHHZVKiV/BUaDkSG6gsoztJfgcpJab56Ly6H8tjJ5PFAUxKEaZ2S2lHqwLwoN5n5C1uHRiD3YyGjrGcojTbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626746; c=relaxed/simple;
	bh=r8UBXOkqI1wUpvB2qPeAbF1uurUqBO2vhuylqV/W/o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9gfU+VCC51GbRUI0mKF7VmhCoqi7EQKL175S3WfrMyjt03zo08Hlw4fe8qgTgI1JDfNKYPmU/btDeir/uHIoD250s5hvK7BrCjBBrHqWOurZFwiWaOdNVlYci8mUK2Mwf6zZiBCGmhEMFahcophsyfK4wU179kHOYzaG0K1QB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmm6NWQQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so42963139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626742; x=1758231542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uMeonYavxOTIJl8DB+R0rzIUn8Tw7J2bJttoO2WoIw=;
        b=Pmm6NWQQwOelg+QzpHfQ9AWJi15dAqULlQ3fBImmnbKbudb/EFKinWjJwuLxhM4wMe
         mXgfMYHKb4iXWT2bJEkrXEfI9mh+trKFFdoXVvz8kSqut/7gVMXYXYdzTVDHuYU1fwy5
         I08JE2/xJ/WSI9DCFqq/nN3GIZ4RDpZABuL3hzNGF/Cg9vzICjplnD8ivgGsrOJdGFyZ
         cs2q2JMAdSU2UOhcf2T+PBe0qcb55evZiKcMYM+ahLZEbYUdx8F+IEVAGfKfpSJH3qIT
         A6Y4Vy9UWjSeeCMSkF4g9OhbOxkJ7t+2Ro8jVM2sqRuM7NzNfYl01vcFw1cgWk3dI9xK
         B/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626742; x=1758231542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uMeonYavxOTIJl8DB+R0rzIUn8Tw7J2bJttoO2WoIw=;
        b=SeoBWu/CEZorDXtHN3H9gPCvvQS5FGMMTFO0Pu5zCUSHF0BoRt0OMjz94j6bsJrMjc
         2pyTs4LHnCc2+/eiUoG48RpjXyPOzZFc0VbcwbZ97LIVO0pt4PSb3n6/6lTPlSol9au2
         oBod5wwU5YpK16FeJevroU7H0SmRNB/LbW7CmZyYfrcLlqL++7wCVBgoB5RyvvlL3zo5
         AfOxFu67Eqo2OyOzCQVyOudv00o9D9XQ2z9xrK1kJTrBMVZQMLriOmbQfp1KoCTvjpe8
         fpRLsSvan6BmJi03owy+vRuLVeFisyza7vYD+myZ11fffVgxEjfh0ccAd4VVZk7hBugL
         QeFA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Hfl0lKgkghGtJ7HkG+epMJ4jyzG9FMKDX+p0jSudt7IEfYX0yYVQY5F6VXg+B80g6UhB8qEuVutPtKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxym1dRsmxHOMOas6C8qFoUxGnQX8cj6OFtQoX6J4PhG3h04DSX
	MJCHRmsOfxAiOYIAmFj+UQWo+UMYfr2pJ5QSvK0OAeMB8iUaO8VyHbEl
X-Gm-Gg: ASbGnct6SPMx4MxB682gyApP06XTrkl7e9xT786iPrOAOWU1YPZF7l5OKZ0IfjPWUWm
	gDqbqDfldyi+UZqBE8m+s49VsEYmyl1e5XMY0fffYAPnewJb16mRyl6zOzH9bAEMcpglx/v3xkC
	VlSNrnmrIn4CfJOAV0ReyHsJ/mOkddPuRXuZQCd/D473tkBWT0XICioeQ1Ua5fwhEHbi1h+3c9F
	BZqG6MdGXdX21Azyjtov5ru8ANGK24vZgJpUTf4CYpl8/9zJ5c9p0MpXvOeojEwjFC3vzb4j7dw
	sQzDSKlYNwL8WqLVxqUzgilzyGHNgJH+JvhX8+oDNjYBjLfxYw30rH000JxVsqfcRox05t82t2P
	eMvgAgKpzjhKLc5g3ino6JnOKMLWdVUzW+6Pig1ohJ1O8DPSs9ISTO3rJO6YDoCBWFIbcEaBESE
	slmwsWiTSt/84dFg==
X-Google-Smtp-Source: AGHT+IGQ53s7SCfV02RG8LhrjQG25CQK+DSHXv9b5XXq8JnTsaMNv/q7RAwPD286ZeUutu0RD3Td4g==
X-Received: by 2002:a05:6602:48d:b0:887:56f5:26a2 with SMTP id ca18e2360f4ac-890352a9a52mr121716039f.14.1757626741460;
        Thu, 11 Sep 2025 14:39:01 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 14/30] dyndbg,module: make proper substructs in _ddebug_info
Date: Thu, 11 Sep 2025 15:38:07 -0600
Message-ID: <20250911213823.374806-15-jim.cromie@gmail.com>
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

recompose struct _ddebug_info, inserting proper sub-structs.

The struct currently has 2 pairs of ptr,length fields distinguished by
name.  Several for-loops operate on these field pairs, soon many more
will be added.

Looping over these blocks by respective field-pairs is repetitive and
fiddly, differing only by the field-names.  Before adding a 3rd
section and compounding the fiddly details problem, make proper
substructs of each section, with the same named fields.

So this patch does:

Adds 3 "vector<T>" structs, each with { <T> *start, int len; }
components, for _ddebug_descriptors, _ddebug_class_maps, and
_ddebug_class_users respectively.

Invariant: These vectors ref a contiguous subrange of __section memory
in builtin/DATA or in loadable modules via mod->dyndbg_info; with
guaranteed life-time for us.

Bundles these 3 vectors (subrange-refs) into struct (reformed)
_ddebug_info, where they're __packed to close the paholes introduced
otherwise.

The common fields allow improving the for_subvec() macro by dropping
the ugly num_##<T> paste-up.

Also recompose struct ddebug_table to contain a _ddebug_info.  This
reinforces its use as a cursor into relevant data for a builtin
module, and access to the full _ddebug state for modules.

NOTES:

Fixup names: Normalize all struct names to "struct _ddebug_*"
eliminating the minor/stupid variations created in classmaps-v1.
Also normalize the the __section names to "__dyndbg_*".

struct module contains a _ddebug_info field and module/main.c sets it
up, so that gets adjusted rather obviously.

The __packed attribute on _ddebug_info and the 3 contained structs
closes the holes otherwise created by the structification (which was
my excuse for not doing it originally).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v2 rework towards front of series
-v4 rework after stubs-macro
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |   4 +-
 include/linux/dynamic_debug.h     |  40 +++++++----
 kernel/module/main.c              |  12 ++--
 lib/dynamic_debug.c               | 107 +++++++++++++++---------------
 lib/test_dynamic_debug.c          |   2 +-
 5 files changed, 87 insertions(+), 78 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a..6fbdee197821 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -365,8 +365,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	BOUNDED_SECTION_BY(__dyndbg_class_maps, ___dyndbg_class_maps)	\
+	BOUNDED_SECTION_BY(__dyndbg_descriptors, ___dyndbg_descs)	\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2a6ebc3c1459..bf686d1ab012 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -82,30 +82,42 @@ enum class_map_type {
 	 */
 };
 
-struct ddebug_class_map {
-	struct module *mod;
-	const char *mod_name;	/* needed for builtins */
+struct _ddebug_class_map {
+	struct module *mod;	/* NULL for builtins */
+	const char *mod_name;
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
 	enum class_map_type map_type;
 };
 
-/* encapsulate linker provided built-in (or module) dyndbg data */
+/*
+ * @_ddebug_info: gathers module/builtin dyndbg_* __sections together.
+ * For builtins, it is used as a cursor, with the inner structs
+ * marking sub-vectors of the builtin __sections in DATA.
+ */
+struct _ddebug_descs {
+	struct _ddebug *start;
+	int len;
+} __packed;
+
+struct _ddebug_class_maps {
+	struct _ddebug_class_map *start;
+	int len;
+} __packed;
+
 struct _ddebug_info {
-	struct _ddebug *descs;
-	struct ddebug_class_map *classes;
-	unsigned int num_descs;
-	unsigned int num_classes;
-};
+	struct _ddebug_descs descs;
+	struct _ddebug_class_maps maps;
+} __packed;
 
-struct ddebug_class_param {
+struct _ddebug_class_param {
 	union {
 		unsigned long *bits;
 		unsigned long *lvl;
 	};
 	char flags[8];
-	const struct ddebug_class_map *map;
+	const struct _ddebug_class_map *map;
 };
 
 /*
@@ -159,7 +171,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	__section("__dyndbg_descriptors") name = {		\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
@@ -242,7 +254,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * macro.
  */
 #define _dynamic_func_call_cls(cls, fmt, func, ...)			\
-	__dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
+	__dynamic_func_call_cls(__UNIQUE_ID(_ddebug), cls, fmt, func, ##__VA_ARGS__)
 #define _dynamic_func_call(fmt, func, ...)				\
 	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
 
@@ -252,7 +264,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * with precisely the macro's varargs.
  */
 #define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)		\
-	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,	\
+	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(_ddebug), cls, fmt,	\
 					func, ##__VA_ARGS__)
 #define _dynamic_func_call_no_desc(fmt, func, ...)			\
 	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,	\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c2c08007029d..8515a6184be0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2689,12 +2689,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
-	mod->dyndbg_info.descs = section_objs(info, "__dyndbg",
-					      sizeof(*mod->dyndbg_info.descs),
-					      &mod->dyndbg_info.num_descs);
-	mod->dyndbg_info.classes = section_objs(info, "__dyndbg_classes",
-						sizeof(*mod->dyndbg_info.classes),
-						&mod->dyndbg_info.num_classes);
+	mod->dyndbg_info.descs.start = section_objs(info, "__dyndbg_descriptors",
+						    sizeof(*mod->dyndbg_info.descs.start),
+						    &mod->dyndbg_info.descs.len);
+	mod->dyndbg_info.maps.start = section_objs(info, "__dyndbg_class_maps",
+						   sizeof(*mod->dyndbg_info.maps.start),
+						   &mod->dyndbg_info.maps.len);
 #endif
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ddcaa87f3b02..53ce28255426 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,17 +39,15 @@
 
 #include <rdma/ib_verbs.h>
 
-extern struct _ddebug __start___dyndbg[];
-extern struct _ddebug __stop___dyndbg[];
-extern struct ddebug_class_map __start___dyndbg_classes[];
-extern struct ddebug_class_map __stop___dyndbg_classes[];
+extern struct _ddebug __start___dyndbg_descs[];
+extern struct _ddebug __stop___dyndbg_descs[];
+extern struct _ddebug_class_map __start___dyndbg_class_maps[];
+extern struct _ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
 	const char *mod_name;
-	struct _ddebug *ddebugs;
-	struct ddebug_class_map *classes;
-	unsigned int num_ddebugs, num_classes;
+	struct _ddebug_info info;
 };
 
 struct ddebug_query {
@@ -138,8 +136,8 @@ do {								\
  * @_vec: name of a sub-struct member in _box, with array-ref and length
  */
 #define for_subvec(_i, _sp, _box, _vec)				       \
-	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
-	     (_i) < (_box)->num_##_vec;				       \
+	for ((_i) = 0, (_sp) = (_box)->_vec.start;		       \
+	     (_i) < (_box)->_vec.len;				       \
 	     (_i)++, (_sp)++)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
@@ -162,14 +160,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
-static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
+static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
 {
-	struct ddebug_class_map *map;
+	struct _ddebug_class_map *map;
 	int i, idx;
 
-	for_subvec(i, map, dt, classes) {
+	for_subvec(i, map, &dt->info, maps) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -194,7 +192,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct ddebug_class_map *map = NULL;
+	struct _ddebug_class_map *map = NULL;
 	int valid_class;
 
 	/* search for matching ddebugs */
@@ -215,8 +213,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->num_ddebugs; i++) {
-			struct _ddebug *dp = &dt->ddebugs[i];
+		for (i = 0; i < dt->info.descs.len; i++) {
+			struct _ddebug *dp = &dt->info.descs.start[i];
 
 			/* match site against query-class */
 			if (dp->class_id != valid_class)
@@ -609,14 +607,14 @@ static int ddebug_exec_queries(char *query, const char *modname)
 }
 
 /* apply a new class-param setting */
-static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
+static int ddebug_apply_class_bitmap(const struct _ddebug_class_param *dcp,
 				     const unsigned long *new_bits,
 				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_map *map = dcp->map;
 	int matches = 0;
 	int bi, ct;
 
@@ -652,8 +650,8 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* accept comma-separated-list of [+-] classnames */
 static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 	unsigned long curr_bits, old_bits;
 	char *cl_str, *p, *tmp;
 	int cls_id, totct = 0;
@@ -723,8 +721,8 @@ static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
@@ -811,8 +809,8 @@ EXPORT_SYMBOL(param_set_dyndbg_classes);
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
 
@@ -1063,8 +1061,8 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = iter->table->num_ddebugs;
-	return &iter->table->ddebugs[--iter->idx];
+	iter->idx = iter->table->info.descs.len;
+	return &iter->table->info.descs.start[--iter->idx];
 }
 
 /*
@@ -1085,10 +1083,10 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 		}
 		iter->table = list_entry(iter->table->link.next,
 					 struct ddebug_table, link);
-		iter->idx = iter->table->num_ddebugs;
+		iter->idx = iter->table->info.descs.len;
 		--iter->idx;
 	}
-	return &iter->table->ddebugs[iter->idx];
+	return &iter->table->info.descs.start[iter->idx];
 }
 
 /*
@@ -1135,12 +1133,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct _ddebug_class_map *map;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for_subvec(i, map, &dt->info, maps)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1174,7 +1172,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1226,7 +1224,7 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct ddebug_class_map *cm;
+	struct _ddebug_class_map *cm;
 	int i, nc = 0;
 
 	/*
@@ -1234,18 +1232,18 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for_subvec(i, cm, di, classes) {
+	for_subvec(i, cm, di, maps) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->classes = cm;
+				dt->info.maps.start = cm;
 			}
 			nc++;
 		}
 	}
 	if (nc) {
-		dt->num_classes = nc;
+		dt->info.maps.len = nc;
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 	}
 }
@@ -1258,10 +1256,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	if (!di->num_descs)
+	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
+	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
@@ -1275,19 +1273,18 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	 * this struct ddebug_table.
 	 */
 	dt->mod_name = modname;
-	dt->ddebugs = di->descs;
-	dt->num_ddebugs = di->num_descs;
+	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
 
-	if (di->classes && di->num_classes)
+	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->num_descs, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
 	return 0;
 }
 
@@ -1434,10 +1431,10 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 
 	struct _ddebug_info di = {
-		.descs = __start___dyndbg,
-		.classes = __start___dyndbg_classes,
-		.num_descs = __stop___dyndbg - __start___dyndbg,
-		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
+		.descs.start = __start___dyndbg_descs,
+		.maps.start  = __start___dyndbg_class_maps,
+		.descs.len = __stop___dyndbg_descs - __start___dyndbg_descs,
+		.maps.len  = __stop___dyndbg_class_maps - __start___dyndbg_class_maps,
 	};
 
 #ifdef CONFIG_MODULES
@@ -1448,7 +1445,7 @@ static int __init dynamic_debug_init(void)
 	}
 #endif /* CONFIG_MODULES */
 
-	if (&__start___dyndbg == &__stop___dyndbg) {
+	if (&__start___dyndbg_descs == &__stop___dyndbg_descs) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 			return 1;
@@ -1458,16 +1455,16 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 
-	iter = iter_mod_start = __start___dyndbg;
+	iter = iter_mod_start = __start___dyndbg_descs;
 	modname = iter->modname;
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg_descs; iter++, i++, mod_sites++) {
 
 		if (strcmp(modname, iter->modname)) {
 			mod_ct++;
-			di.num_descs = mod_sites;
-			di.descs = iter_mod_start;
+			di.descs.len = mod_sites;
+			di.descs.start = iter_mod_start;
 			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
@@ -1477,8 +1474,8 @@ static int __init dynamic_debug_init(void)
 			iter_mod_start = iter;
 		}
 	}
-	di.num_descs = mod_sites;
-	di.descs = iter_mod_start;
+	di.descs.len = mod_sites;
+	di.descs.start = iter_mod_start;
 	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
@@ -1488,8 +1485,8 @@ static int __init dynamic_debug_init(void)
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
 
-	if (di.num_classes)
-		v2pr_info("  %d builtin ddebug class-maps\n", di.num_classes);
+	if (di.maps.len)
+		v2pr_info("  %d builtin ddebug class-maps\n", di.maps.len);
 
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 396144cf351b..8434f70b51bb 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -41,7 +41,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  */
 #define DD_SYS_WRAP(_model, _flags)					\
 	static unsigned long bits_##_model;				\
-	static struct ddebug_class_param _flags##_model = {		\
+	static struct _ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\
 		.map = &map_##_model,					\
-- 
2.51.0



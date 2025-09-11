Return-Path: <linux-kernel+bounces-812896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF4AB53DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69CDAA4BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4336932A;
	Thu, 11 Sep 2025 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgdNqFFY"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B5321457
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626759; cv=none; b=Xt4OgKoCUtejJASotgc3s9jXzZLm8tbPUMMNQlJb4QQyGRkQgEjMulupcohLXTXJ8g24xVY3v50JVp++dL6K79Wzz/p3Bam8CPPsl2n1QqjDd2wlBUd9SsV6501c7R7Yt9WpW6MvD3JUNE1pH+ho99x8nQLcDAugzYo4EkWfrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626759; c=relaxed/simple;
	bh=uFz8RTfQXvdzGLIr/58GeOXYAXhBAFxU1Y27KGB5G5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+a+ffsdI1Ds+8cEa/+XUPCd2VSGJU0xjmkTAV+X67oFt5aGrOw+rJrUj/PGgt1wM4UjgS74QnJ+dCrJDCSrkq7KFRpMKNicibFpXkJR3y1HDsdmSWDp3izivxa3ZPFqoQ7062xnx07SLDY6AfvrKmLU+q0jVgvAUIx+JiPP51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgdNqFFY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88735894d29so34848939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626756; x=1758231556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S7bi7VcWuEj01wDDSALGaeIND7R7q38N/1Wb1VeyTU=;
        b=SgdNqFFYLcGMsxKZ2B/w5HFBEXTgx2RDH649JEOHRFlG3ckTRPYzLj0jojOGr8XjjR
         Ex2A6cgp5T5Xj6//qKrchiZzvyPCqVqJh91YT8Wq25NRgVaYhzYrF0PHigfSvC5HEZuR
         +sLMBgcVakKqz2H5d+v9KAJsv/8VztavrX6706s6sp+ybWAVDtrLSXwY7M0WSbgt7q6O
         fEGi6+YlZYgFEfXrtQYlriovrC0O5CrViX912rIYlZBGteX9EFhbCftQjKmNR65r2Ao8
         2EiK82woahTucgiDtoJYm1D0cJWXlf0BD2wapEmupa68ZZppbcym8Cbo3VMN8wD7gNfP
         d3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626756; x=1758231556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S7bi7VcWuEj01wDDSALGaeIND7R7q38N/1Wb1VeyTU=;
        b=T+XVs4C4YXlgCN+NauqHK4ArLGWLjSjX52JqZ5QsDlgqYDKsv3yZV7MBnmVX0XdIF3
         SH3vyfe7Bwlq9FKQ/CAekBH+AisD6hH8u4KmDtP9l94kOkR/0gtuRjZGVlqwlIps4831
         cyA7ZUcQ1OeyfjdZhQ6HFwCj8h3t/IyzLTS9ovKHm7o31oSIM0p5zk4Z91WXzz5zu5di
         dnNaS0tHqmzS1GDCJl4B8wCXIQ8oL2vNo/TuqH0BZsqPvyGV27ftmiqh/ejxZkjML0tQ
         yOt7NAgokkyI1KfYX0yTQF5VCBozJ6oIhuFTkTmSuGjdRPvAaGCmIb33hpVaNFuoyHJ1
         HM1A==
X-Forwarded-Encrypted: i=1; AJvYcCVi2FI0TTnB7T0Ro6KXajGI9dGlq/XbVIclqoQ9kkCAY4fvrZY/7xWffXP4fiM1SPew5zmd2/9Fyj4EH3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxowYECkCDE1Zalykfy8I6PteOn4/AyVRahcYp2OPuHRgj9FKP
	NnZWBItK9rvwWyEG/NdAVF8vKzGanUtj+4gEqQH+I+hvcLQnB2Jj9Njl
X-Gm-Gg: ASbGncsJdmUpLvMi5wkGInbObdcGa/4j8SNF1vt3JaOd7vZuWQDlLwUnFusxv7kGqGk
	SjVQVSVz1jjEDa88BJfcDujEN/9Tj5vZ9oAgsQMYmkjq4Z0wj629wmlm362HzPSAsa75UR+vZnh
	7a/cjLiYtiPJ9bwXcZwImrGTx1/bckb0DKVigGsMbQEJQprCvCvMYE4Bq8fMZ0kBzbwXEuiABbk
	K5ok0yp6ESgzFwl1XsFzcZXnrGgDxfqOPyPQQLzrbKsNTfcOKK17q1WOYcI6gV4stcCLzN1ZqlH
	7dmmNJzmNG/L+b4cncXRmyDtwTSiuwUvasmaXGsJgYBH3nGM+xEfwFNM/uDg45K6Ydsb4jid9U6
	O2pkb5Rhgqpq4SEs2BEpSJX0kXfgw1mDzLGTPS4313OXKu2bqxZMXOed3RTNJmkFZtdnWN1tyTV
	05Xa/JkUqFy+QiMg==
X-Google-Smtp-Source: AGHT+IE9D6mkMC7heM4taNKCXmh5N3pln1pJxHrNZt0ot5Rg7t6LQ4stcoY3I1h9nS7nDe01oxTFOw==
X-Received: by 2002:a05:6602:150c:b0:887:7662:d5f0 with SMTP id ca18e2360f4ac-8903378d5c0mr116584739f.5.1757626755768;
        Thu, 11 Sep 2025 14:39:15 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 28/30] dyndbg: resolve "protection" of class'd pr_debugs
Date: Thu, 11 Sep 2025 15:38:21 -0600
Message-ID: <20250911213823.374806-29-jim.cromie@gmail.com>
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

classmap-v1 code protected class'd pr_debugs from unintended
changes by unclassed/_DFLT queries:

  # IOW this doesn't disable all of DRM_UT_* categories
  echo "-p" > /proc/dynamic_debug/control

  # Instead, must name the class to change it.
  # Protective but tedious
  echo "class DRM_UT_CORE +p" > /proc/dynamic_debug/control

  # Or do it the (old school) subsystem way
  echo 1 > /sys/module/drm/parameters/debug

This "name the class to change it" behavior gave a modicum of
protection to classmap users (ie DRM) so their debug settings aren't
trivially and unintentionally altered underneath them.

Doing so was 2-step:
a- all existing pr-debugs got .class_id = DEFAULT - ints need a val.
b- "class DEFAULT" was inferred unless a class was explicitly given

This allowed all previously conceived queries to work the way they
always had; ie select the same set of pr_debugs, despite the inclusion
of whole new classes of pr_debugs.

But that choice had 2 downsides:

1. "name the class to change it" makes a tedious long-winded
interface, needing many commands to set DRM_UT_* one at a time.

2. It made the class keyword special in some sense; the other keywords
skip only on explicit mismatch, otherwise the code falls thru to
adjust the pr-debug site.

Jason Baron	didn't like v1 on point 2.  Im not sure he's changed view.
Louis Chauvet	didn't like recent rev on point 1 tedium.

My view has crystalized: drm.debug is ABI and API. Therefore dyndbg
"doing" drm.debug must deliver the same operational guarantees; namely
that drm.debug=VAL is accurate and true.  Convenience or wishes for
no-special-cases does not matter.

The new resolution:

If ABI is the blocking issue, then no ABI means no blocking issue.
IOW, if the classmap has no associated sysfs/kparam, ie no PARAM,
there is no ABI to guard, no reason to enforce a tedious interface.

In the future, if DRM wants to drop or qualify this protection at
compile or modally at runtime, we could talk.  But thats their call
for convenience.

So classes without a PARAM are unprotected at >control, allowing
admins their shortcuts.  No such classmap usages exist yet.

Anyway, this patch does:

1. adds link field from _ddebug_class_map to the .controlling_param

2. sets it in ddebug_match_apply_kparam(), during modprobe/init,
   when options like drm.debug=VAL are handled.

3. ddebug_class_has_param() checks .controlling_param

4. ddebug_class_wants_protection() macro renames 3.
   this frames it as a separable policy decision

5. ddebug_change() calls 4 when needed.
   IE when applying a class-less query to a class'd pr_debug
   here we need a new fn to find the classmap with this .class_id

6. new ddebug_find_classmap_by_class_id().  called when class-less
   query looks at a class'd pr_debug.  finds classmap, which can then
   decide, currently by PARAM existence.

Historical Summary:

-v0 - before classmaps.  no special case keywords
-v1 - "class DEFAULT" is assumed if not mentioned.
      this protects classes from class-less queries

-v2.pre-this-patch - protection macro'd to false
-v2.with-this-patch - sysfs knob decides
-v2.speculative - module decides wrt classmap protection
		  seems unneeded now, TBD

NOTE: protection is only against class-less queries, explicit "class
FOO" adjustments are allowed (that is the mechanism).

CC: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3 - new patch
v4
- drop fn-scope map var, with 2 local vars, renamed to purpose
- fix for NULL ptr case.
- Add loop-var to reduce many "&dt->info." exprs to "di->"
- add 1-liner postcondition comments

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  14 +++--
 lib/dynamic_debug.c           | 114 +++++++++++++++++++++++++++-------
 2 files changed, 100 insertions(+), 28 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4ceb69f0e493..588e03e8d157 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -75,6 +75,7 @@ enum ddebug_class_map_type {
  * map @class_names 0..N to consecutive constants starting at @base.
  */
 struct _ddebug_class_map {
+	struct _ddebug_class_param *controlling_param;
 	const struct module *mod;	/* NULL for builtins */
 	const char *mod_name;
 	const char **class_names;
@@ -259,7 +260,12 @@ struct _ddebug_class_param {
  *
  * Creates a sysfs-param to control the classes defined by the
  * exported classmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in a private long int.
+ *
+ * Since sysfs-params are ABI, this also protects the classmap'd
+ * pr_debugs from un-class'd `echo -p > /proc/dynamic_debug/control`
+ * changes.
+ *
+ * This keeps class-state in a private long int.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
 	static unsigned long _name##_bvec;				\
@@ -272,10 +278,8 @@ struct _ddebug_class_param {
  * @_var:   name of the (exported) classmap var defining the classes/bits
  * @_flags: flags to be toggled, typically just 'p'
  *
- * Creates a sysfs-param to control the classes defined by the
- * exported clasmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in user @_bits.  This lets drm check
- * __drm_debug elsewhere too.
+ * Like DYNAMIC_DEBUG_CLASSMAP_PARAM, but maintains param-state in
+ * extern @_bits.  This lets DRM check __drm_debug elsewhere too.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
 	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 283d86115eba..97070ddf31c6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -197,6 +197,48 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 	return NULL;
 }
 
+#define class_in_range(class_id, map)					\
+	(class_id >= map->base && class_id < map->base + map->length)
+
+static struct _ddebug_class_map *
+ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
+{
+	struct _ddebug_class_map *map;
+	struct _ddebug_class_user *cli;
+	int i;
+
+	for_subvec(i, map, di, maps)
+		if (class_in_range(class_id, map))
+			return map;
+
+	for_subvec(i, cli, di, users)
+		if (class_in_range(class_id, cli->map))
+			return cli->map;
+
+	return NULL;
+}
+
+/*
+ * classmaps-V1 protected classes from changes by legacy commands
+ * (those selecting _DPRINTK_CLASS_DFLT by omission).  This had the
+ * downside that saying "class FOO" for every change can get tedious.
+ *
+ * V2 is smarter, it protects class-maps if the defining module also
+ * calls DYNAMIC_DEBUG_CLASSMAP_PARAM to create a sysfs parameter.
+ * Since they want the knob, we should assume they intend to use it
+ * (in preference to "class FOO +p" >control), and want to trust its
+ * settings.
+ * This gives protection when its useful, and not when its just tedious.
+ */
+static inline bool ddebug_class_has_param(const struct _ddebug_class_map *map)
+{
+	return !!(map->controlling_param);
+}
+
+/* re-framed as a policy choice */
+#define ddebug_class_wants_protection(map) \
+	ddebug_class_has_param(map)
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -210,35 +252,45 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct _ddebug_class_map *map = NULL;
-	int valid_class;
+	int selected_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
+		struct _ddebug_info *di = &dt->info;
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->info.mod_name))
+		    !match_wildcard(query->module, di->mod_name))
 			continue;
 
 		if (query->class_string) {
-			map = ddebug_find_valid_class(&dt->info, query->class_string,
-						      &valid_class);
-			if (!map)
+			struct _ddebug_class_map *mods_map =
+				ddebug_find_valid_class(di, query->class_string,
+							&selected_class);
+			if (!mods_map)
 				continue;
 		} else {
-			/* constrain query, do not touch class'd callsites */
-			valid_class = _DPRINTK_CLASS_DFLT;
+			selected_class = _DPRINTK_CLASS_DFLT;
 		}
+		/* module knows "class FOO", if given, else class _DFLT */
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
-
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
+			if (dp->class_id != selected_class) {
+				if (query->class_string) {
+					/* site.class != class FOO */
+					continue;
+				} else {
+					/* class-less query, class'd site */
+					struct _ddebug_class_map *site_map =
+						ddebug_find_map_by_class_id(di, dp->class_id);
+					if (site_map && ddebug_class_wants_protection(site_map))
+						continue;
+					/* allow change on class'd site */
+				}
+			}
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
@@ -635,6 +687,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 }
 
 /* apply a new class-param setting */
+
 static int ddebug_apply_class_bitmap(const struct _ddebug_class_param *dcp,
 				     const unsigned long *new_bits,
 				     const unsigned long old_bits,
@@ -1086,9 +1139,6 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-#define class_in_range(class_id, map)					\
-	(class_id >= map->base && class_id < map->base + map->length)
-
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
@@ -1213,25 +1263,36 @@ static void ddebug_sync_classbits(const struct kernel_param *kp, const char *mod
 	}
 }
 
-static void ddebug_match_apply_kparam(const struct kernel_param *kp,
-				      const struct _ddebug_class_map *map,
-				      const char *mod_name)
+static struct _ddebug_class_param *
+ddebug_get_classmap_kparam(const struct kernel_param *kp,
+			   const struct _ddebug_class_map *map)
 {
 	struct _ddebug_class_param *dcp;
 
 	if (kp->ops != &param_ops_dyndbg_classes)
-		return;
+		return false;
 
 	dcp = (struct _ddebug_class_param *)kp->arg;
 
-	if (map == dcp->map) {
+	return (map == dcp->map)
+		? dcp : (struct _ddebug_class_param *)NULL;
+}
+
+static void ddebug_match_apply_kparam(const struct kernel_param *kp,
+				      struct _ddebug_class_map *map,
+				      const char *mod_name)
+{
+	struct _ddebug_class_param *dcp = ddebug_get_classmap_kparam(kp, map);
+
+	if (dcp) {
+		map->controlling_param = dcp;
 		v2pr_info(" kp:%s.%s =0x%lx", mod_name, kp->name, *dcp->bits);
 		vpr_cm_info(map, " %s maps ", mod_name);
 		ddebug_sync_classbits(kp, mod_name);
 	}
 }
 
-static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *mod_name)
+static void ddebug_apply_params(struct _ddebug_class_map *cm, const char *mod_name)
 {
 	const struct kernel_param *kp;
 #if IS_ENABLED(CONFIG_MODULES)
@@ -1251,6 +1312,13 @@ static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *
 	}
 }
 
+/*
+ * called from add_module, ie early. it can find controlling kparams,
+ * which can/does? enable protection of this classmap from class-less
+ * queries, on the grounds that the user created the kparam, means to
+ * use it, and expects it to reflect reality.  We should oblige him,
+ * and protect those classmaps from classless "-p" changes.
+ */
 static void ddebug_apply_class_maps(const struct _ddebug_info *di)
 {
 	struct _ddebug_class_map *cm;
-- 
2.51.0



Return-Path: <linux-kernel+bounces-847303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3F6BCA805
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F230482E34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC622EF66E;
	Thu,  9 Oct 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU78dLVB"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766422ED855
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032748; cv=none; b=rx4ePgTRV7kw0gnJUz5ODCMtTXmdPGi86sUinf94JoHqZWvOEuj3Wo0fW5KJkyHGqs4iI1p2UVDCs0vssDnuAVW9c+83GLMS504pwnO5bcGSb/TPwdZARrKI5iQo/nnB/jj2VG+DsP/ncWuHP0KHGGG3p4wYPJ6lj7hipzem3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032748; c=relaxed/simple;
	bh=6WeSLIcdWxH0KnY4snBRfJjiQ+Ag9hQk04tWp5V1Fhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlyTGUBcfhmRc8N9/strdCAwwXBSroZ74HqGZ322O5KBNXv/2tlgT0kU7cG9N/+At1X9PaEaNS0+VspmbyIMVFCxUIAotA7XKl6qStpNEAA5TVRLtjZ27W7omMhPCt7EuDm/L58EZdW2DwfijeVNxnNuxASO1MaJzdZ9ULy+cVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU78dLVB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4259247208aso9027095ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032744; x=1760637544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGD+sflpYLyKJkUQPBfbt5KFEJrqeRR2/XNh6nVffG4=;
        b=cU78dLVBtTpR4k6m4lhbMNHppKFamM2My5Mf2g+ivgRwWTMtZ9lS6gX3SvmdzkIY/p
         F3xLvs39W/hqJ5J0ciBmL2bj/bl3xUELnwKdKZoYAGrXxLPpu4l2m7TT5HTMFDtt8SSW
         CpoT0Toa/lWqljq2k8nkp1Qxz2d0v1Qd/bh4JmpgHhJKpdk3/lD9TEBebwzfnNmAe6fL
         JSDDb2jh+uVw/e/keXzULfkiH2dbKY1AFb2P5VfB18VUxR3p8AV2KoRfJN7UHLbM7QhF
         sQSBFfL28HFqzXQM4wEEOuEYnCotaNJcnl7CWiBEP8dzzIoCKh3gcsYZMh8ZqpQDyGLX
         E5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032744; x=1760637544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGD+sflpYLyKJkUQPBfbt5KFEJrqeRR2/XNh6nVffG4=;
        b=M47rkpUC6JjCjktYbb45dluxVFtnZPW4IFvgNa/NSrb7ifMLbgd506uZucupflhfIJ
         t7xbJ4NcBuYQJMbnzCNbXBV7rhWIQISHoxovBjQvJoGlZHxR1kmdICQYhUk/ecdVWWT1
         1OFXvperoPjM6olXUGV/NVyPfOerYGWPEZiEUatA4Lc7MzvpI0oSj69l3SIrvMnXRUbm
         6A2Wr7j5ZPxSBJiN2gDhNKbvpoXN+NdSHbuQ/5v5b9DQ9cL+bd2Tp58xplKvOOcUgijE
         kGXgirAQinRjy2lkiCuWUkhJVLtqQzzHXIDZfmdpuEmZLpZPM5+AoL89f8X+kHIMPiW5
         R7bw==
X-Forwarded-Encrypted: i=1; AJvYcCVOuTyPP6OvSUI7NtjGeX4lmy8ReSeNoqsTK0bc8OZV7YLfWvjwahHv4H/w7MbROkCyW17ajqlnFPBkZgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0o3Pqg6XxtnYTBpJQCwXuJSYZPV9uPjo2w23uApPJQVVEHe7
	C/vuc2arepoypPXTo8fi6G+FpU9Gtq2fQfbLaO3XHl23U0z3Ot01OD7fKH0/Og==
X-Gm-Gg: ASbGncsBLJDPJHKGKMxDo7S3KbubsKj90XiSAYkG4tUIX16Om8GlOPxsxGmoThoOLm8
	zFvvP11h/hbtbWI2ekz1jYU7fbQGzRGbHjdFBduZMUkeBUyC5jEEq+qln1pCH0Ew9Ed4TSleHhe
	rpl8tLMZ/s4rRhFEGSBUoyNHnRl/A36GaM+gkZrHKJfvBnXFATkRuHxZhUFpW7UH7wnQeC9xRZP
	xArb8n5gLcHHkKwR2HTH1p4Pl0cRlyMv4xrYQwP8zn76YRC16y4CxsMlPpC8huRwZ3JVpCv3+hL
	qrhgvvlGb9GAkiGSN3Y9Nt/eL1j7O9H7KboRLTBpu5GZRd73lX4UKmbDPmrskPPdVeVA0T31B35
	LICd4NyZDG33TRxbb56b+5fdaQp6G3ISLeYfpVsq+8wW+HqwXNjCA6ekAr8jS4via2t5XDV/iXJ
	np8OvmfQEatEgwC7f5cPnqucy8WdRaqKzofFo/zHpemTYaVxDB
X-Google-Smtp-Source: AGHT+IHC/pYrpkk1pQ98omx2cEKQCK33DHJq6/oaRwjrGFF6/pxWMHlOMffq90TfVlz60FjVdMse8A==
X-Received: by 2002:a05:6e02:2783:b0:424:866:ec6d with SMTP id e9e14a558f8ab-42f8736d251mr82921515ab.12.1760032744234;
        Thu, 09 Oct 2025 10:59:04 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:03 -0700 (PDT)
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
Subject: [PATCH v5 16/30] dyndbg: move mod_name from ddebug_table down to _ddebug_info
Date: Thu,  9 Oct 2025 11:58:20 -0600
Message-ID: <20251009175834.1024308-17-jim.cromie@gmail.com>
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

struct _ddebug_info already has most of dyndbg's info for a module;
push debug_table.mod_name down into it, finishing the encapsulation.

This allows refactoring several callchains, passing &_ddebug_info
instead of &ddebug_table, and hoisting the "&dt->info" deref up.

ddebug_table contains a _ddebug_info member, so its users keep access
to mod_name, just now with "->info." added in.

In static ddebug_add_module(&di), reinforce the cursor-model by
dropping the modname arg, and setting di->mod_name at each caller.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
-v3 more s/dt/di/ internal interface changes
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 45 ++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bf686d1ab012..a5602fd23d8a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -107,6 +107,7 @@ struct _ddebug_class_maps {
 } __packed;
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 } __packed;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bbbdb8aba071..09f19155d7f0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct _ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -201,7 +200,7 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard(query->module, dt->info.mod_name))
 			continue;
 
 		if (query->class_string) {
@@ -269,7 +268,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  dt->info.mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1133,12 +1132,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
+static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
 	int i;
 
-	for_subvec(i, map, &dt->info, maps)
+	for_subvec(i, map, di, maps)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1166,13 +1165,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   iter->table->info.mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter->table, dp);
+		class = ddebug_class_name(&iter->table->info, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1224,7 +1223,7 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
+	vpr_info("module:%s attached %d classes\n", dt->info.mod_name, dt->info.maps.len);
 }
 
 /*
@@ -1241,7 +1240,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 #define dd_mark_vector_subrange(_i, _dst, _sp, _box, _vec) ({		\
 	int nc = 0;							\
 	for_subvec(_i, _sp, _box, _vec) {				\
-		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+		if (!strcmp((_sp)->mod_name, (_dst)->info.mod_name)) {	\
 			if (!nc++)					\
 				(_dst)->info._vec.start = (_sp);	\
 		} else {						\
@@ -1256,7 +1255,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
+static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
@@ -1265,20 +1264,19 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
+	v3pr_info("add-module: %s %d sites\n", di->mod_name, di->descs.len);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", modname);
+		pr_err("error adding module: %s\n", di->mod_name);
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name lives in .rodata and is
-	 * immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, name (as supplied in di by its
+	 * callers) lives in .rodata and is immortal. For loaded
+	 * modules, name points at the name[] member of struct module,
+	 * which lives at least as long as this struct ddebug_table.
 	 */
-	dt->mod_name = modname;
 	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
@@ -1292,7 +1290,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1355,7 +1353,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1375,7 +1373,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1473,7 +1472,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1484,7 +1484,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 
-- 
2.51.0



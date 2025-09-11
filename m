Return-Path: <linux-kernel+bounces-812884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0BBB53DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026AA18922EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE72E7F04;
	Thu, 11 Sep 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaZQL/iN"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A32E62CE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626747; cv=none; b=uW9TfZQZTNnqMqMNnRhtMZdn3Lf9brWeMs8s0xEIAaMJsAy12bs3GgxakSXd6I94fMMgVT9hkmHT/w58OuMjDJ4GGIsNY8i5gAN8JzYjB+RhAJacol3IXZvEetvQqPOXPjp2IYmN8iZ3RB7IhsbTxaVHLJ0NIVpI1U1ZtOOFxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626747; c=relaxed/simple;
	bh=6WeSLIcdWxH0KnY4snBRfJjiQ+Ag9hQk04tWp5V1Fhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egeH7R+rKpQAzH8XG50Ie3U4Ex3CL+Z5JmthEPDjfFi3i1B44dqNGvFaxg5yy3ghTubFv4WuKbfKj69U29jGg6/att5amWm29swN1jCXleCdUBETE1h6L9afOOSIAC/RnDtCKB28C9kPCb9bhouINFSxGthYmZQmaujLYmhR5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaZQL/iN; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88f49be4c21so34967039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626744; x=1758231544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGD+sflpYLyKJkUQPBfbt5KFEJrqeRR2/XNh6nVffG4=;
        b=IaZQL/iNI4HBsUw+wT0nMIl4adV74OJBx6Umgr1tfWCoSl45+EP5cYfXA7G/Xr4Bec
         VkgfycWEkm/V92RVF1FwM1qtnl2fHwXvsTc1K0aIB7cyGOh0aGOD9kiGvzTHupHcfh1R
         SNndOAiaf2cXO4xSZRaOspGxdDKh4AsD7M1LW+Xb93dJImfNXqyhJB3Pdxrq3rD0f91X
         H8Ic8/zwmYiHseCkUt4QLMZY6Ggpq/Y89EuuEQXnvCMTtJOYEV963lRcdzZyHVFaPQur
         VJw1xR3sMeh06Q2hGNdQ+0FoYjs5WHSCaRNy4dSNqJ2HGnbPPEZTNRgvRRZR/DQQTFMq
         lWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626744; x=1758231544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGD+sflpYLyKJkUQPBfbt5KFEJrqeRR2/XNh6nVffG4=;
        b=ilVgyRiaqAC9hbSzUKag80WS5mM4nGYBq1Em/cBF9EEuPqAsBYT+OFuW3d67ywxKmc
         vdf18uQXVC27MFM/VsmQ86HY4yO3vn343r7swVMoVzlqbqKUjzzZzetd8CyC4Cp7azQo
         Nvqx/V1Sx8uV2ZZs0mSTSyCfI4jYu1NYBeIytq1Wp1z907BretQh4USQOjxf5QOKdOMm
         21/T5AVduHOZ7wP5jpy5K7m0jc/9FBWFJSTHJBHxMlvQn9/Fk1oxG3auQ7Z22KGsv4Xd
         ZWttIaHaj49mQxiUpu7dQtmMQi/NSpohNYbXXBA0OUFGgNj6arVJmTBYiLTwV7ijTvUy
         2Jdw==
X-Forwarded-Encrypted: i=1; AJvYcCX9AsrMYL62g79n+BTCLGcg9fM5EgVMWhdjB0+1JQEGcOQZU/UNRjjsuGcWAR+QLmV6uAeh5dL83uH/St8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSd5nnjLzfvIAXTvawiWbkl4PbAbz+HxCwNfIvvi8LRxoRbRb
	rb83b/FaSn64qE/lDbz8raGuUUdDynczBaE9rgDEF8gX6Na28jxrCxBLzMsOdg==
X-Gm-Gg: ASbGncuanWNmibODTnwY9A4NMWaVsK8tVMTH4QWWNdCjO0/RXGUGKGvoIOZk+AO5X1e
	bAyazyNhoVbmuRuFaDmHJmOkGbfeZQLH4WOdSZJdcXnuk0TGBScos4GrxhKAs2kbYE1Wv7Hpw75
	tng2mMhPn0af1xbdQAnQO6cJYqyKrjlrcNEC6Bc6vOE8fBpQNXHdFxjf/SQ2BWsKlMiUnAoss+N
	85wBgJTmvH7QaM0uXuJpgWDhrtf/Ob1gagZspPh+vgQitEnOx81x+9CgTubGLtMCmGWBJHjVvON
	BGD+Bkf5p4G89dAJ52P47dhUDxviVQot6tVnx3+aJwpEwCFi6y+8rZSpBjsXFKqlN3wo0UaQ8Ce
	FBJe4mMDAPOoOaYT5sLYTTvQPBwEIOzSpoKS4jynkgxD/36lHc+OhvNU24DSlH0NE0gRyDrF0ko
	e3h07bPJqC2EvDSg==
X-Google-Smtp-Source: AGHT+IGPTmfL1+pCXLOTpBUodDtAAGyn92kEQZ3Cnaeq6TthwPSBlWGT4RJ3RXRXhAb5DaKeihjwZA==
X-Received: by 2002:a05:6602:2c94:b0:887:5ebe:bb9c with SMTP id ca18e2360f4ac-890349f737amr126136739f.14.1757626743677;
        Thu, 11 Sep 2025 14:39:03 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 16/30] dyndbg: move mod_name from ddebug_table down to _ddebug_info
Date: Thu, 11 Sep 2025 15:38:09 -0600
Message-ID: <20250911213823.374806-17-jim.cromie@gmail.com>
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



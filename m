Return-Path: <linux-kernel+bounces-847297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F25BCA7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD13C3C2F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF852EB5AB;
	Thu,  9 Oct 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnntBQsD"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE42D7DCC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032741; cv=none; b=abNVbgReigXpIw0Bng72cbm9yMWjBbXSN4om2jOdFUH8mHKQKFYFLlvpDKb9ApxZ0C0pffk6cfIcar4ZgJkZxLOBacX6ZEdL7dDUQQVhJNTuYiggJBqhH7KELTUdi530CuTYMf2tXh8SGYp900YGu01zSye2XuK9S572WKW4ZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032741; c=relaxed/simple;
	bh=rK4z7rclwfK0c037dAKPfOpjg7IlFZUJaEv9EBcl1IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYOvMxsheFhTbl6FhoLAtHLtcdy7p88JbdK6DC2iaKO6PgwZzc1GMPuAqIVMpkXhQMv+MwoIznBYVPuhuwihPw7cQqkSNQAzGCO86iACvDXv7ZomX0eWYUSyOf1sN9nlFCY4VYK5yxKcOBGK+mINA2vs99QXV+lBDo1Ju2y4RDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnntBQsD; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so104062539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032739; x=1760637539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxIlY2yM45eMQeCF3YJ//hYD95SXkEqZOPug5RB/i/U=;
        b=mnntBQsDKA47enZ9GwWPvaR53nz59MPy7W8HEhL5lIJvW8D8nQL6jD9EtiRi1vWVFG
         Iu+cutlVIspV9mNgjS3iO1Y2adhFEAhwKeKiRMPyt5oFH6gpgoBGDjTaxLJlRfrJ5oOF
         S4qieEZspZoFsbl1Di7ceEhtASNfg0V+xROFzCEwMbpDl81tDxOtRcfZtlwU8wyGRK8C
         MKvDSkSjPtgmW9NMqvxMrQnsZshfwsoH1qaL+M3ev63talUj3vK9IIt9Q1Sfm8xIiVtN
         FZ+/tGUA553gTKhh8J252Ip5cyQ9KDwOsfWngNgU3XGX1mHYpoBME1k1AaPsdRWAftSQ
         l5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032739; x=1760637539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxIlY2yM45eMQeCF3YJ//hYD95SXkEqZOPug5RB/i/U=;
        b=oOgvREp9qtG782KhB0IK4Z80219XVq/1+RTz+8XZ41H7RmHhyf3xSArUQpqcghdaNs
         6Nv/xh85MpuVZ6E7ulyeOli6/wg6BVpZtfrODdZsVv6Fw5/z3bwOCs3N/S0Q+hIAJ4So
         JDdDl+DXL9gvhEyL716Bbik7NAW0cwqFDJXq/k/0qgj52gyqjb19anV0vIlvSfsKbgUP
         dUCqxaaKUlMGlYi0fXauIzZ1YPbvVUkLPA/b4L2Hn2AddaneSL6hKUlNT+wCF6yQYUR0
         Euv8hraDeZ0ZWJLybPCfdfkAB1eC/XFLGplEHQmcJ0dF1k8eadItQC73YbYnDBCXotAx
         jFmg==
X-Forwarded-Encrypted: i=1; AJvYcCUekaSIHi2OibuoyrWwN/OqEOdDClQLKfqNcv1OneMApU+mVTOvmpOvXpoS0NSm+YEVHABIa6ARMgg9nVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWj1B3mLpZKMEJk45bZERdeXDIGpQxftTmkm8SbLX5w1k2pMjz
	DzmNS23s518PajhEe0S896YQUL/0hR6PFpfYVzQgPlbhXXopcKyt3b2R
X-Gm-Gg: ASbGncvJRYnE+2cjQJmvYiCYok0eQ32rPHFKlw7REiuqrBjaVN6tV768/Vh/Lc1ROoB
	+XOaYPJ+025IJxe05aA4svbpqezcS1ljvw7QmnW2QvCYpFa1z0vF5fGEyS1set7LG3kmvVyFfuT
	53gog5queqI7LHCj+TDhWsKq9l036bFNMCBRhcX9pAtzTEC2BjQ55aRCriKEyRvc7AD5sUIDGTE
	jabR0rnEe4PZAQOpdCh4LAQYfh7r/BpaWGY91vrkSkOHWfpRMmGz+OM3QdTz70fzlXNfsFF145L
	HL9hPWRbXke25yhxGEcF3lu/zGnIY+vVFSmA4l6ZtDSwGRlx4Ur3MJ7LptfaHadzrtovyv2vq3r
	mlGeucfe++67Y6t3rWf1SY2ghhve/dI4wXt1fHwYN0o6ZVZKzhThADvx44a7No0HTYlqHXuKFPR
	PilaJAZRQmpnSMmFLiZTTZJyG2ZSvi70Zb/5u65A==
X-Google-Smtp-Source: AGHT+IG/cmjH+ejsk6u3zL7NqZFd6p0hdxUlyoppBv2HNZg9hLOovKTP3lD4GsgDf5vDx6aTtSU7lw==
X-Received: by 2002:a05:6e02:174b:b0:42f:8c7a:8bd6 with SMTP id e9e14a558f8ab-42f8c7a8e79mr63542915ab.8.1760032738804;
        Thu, 09 Oct 2025 10:58:58 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:58 -0700 (PDT)
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
Subject: [PATCH v5 11/30] dyndbg: replace classmap list with a vector
Date: Thu,  9 Oct 2025 11:58:15 -0600
Message-ID: <20251009175834.1024308-12-jim.cromie@gmail.com>
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

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members.
The "select-by-modname" condition is reused to find the start,end of
the subrange.

NOTE: This "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie at least one step closer to ddebug_init(2),
which already splits up pr-debug descriptors into subranges by
modname, then calls (1) on each.  (2) knows nothing of classmaps
currently, and doesn't need to.  For now, just add comment.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3- drop __outvar as promising magic it doesnt have
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 62 ++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ac199293d203..e458d4b838ac 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -83,7 +83,6 @@ enum class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 08d095dd19ef..283926530a43 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link, maps;
+	struct list_head link;
 	const char *mod_name;
-	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct ddebug_class_map *classes;
+	unsigned int num_ddebugs, num_classes;
 };
 
 struct ddebug_query {
@@ -148,12 +149,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							  const char *class_string, int *class_id)
+							const char *class_string,
+							int *class_id)
 {
 	struct ddebug_class_map *map;
-	int idx;
+	int i, idx;
 
-	list_for_each_entry(map, &dt->maps, link) {
+	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -164,7 +166,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -180,7 +181,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1122,9 +1123,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1208,30 +1210,31 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt,
-					 struct ddebug_class_map *classes,
-					 int num_classes)
+static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
 	struct ddebug_class_map *cm;
-	int i, j, ct = 0;
+	int i, nc = 0;
 
-	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+	/*
+	 * Find this module's classmaps in a subrange/wholerange of
+	 * the builtin/modular classmap vector/section.  Save the start
+	 * and length of the subrange at its edges.
+	 */
+	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
-
-			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
-				  cm->mod_name, cm->base, cm->length, cm->map_type);
-
-			for (j = 0; j < cm->length; j++)
-				v3pr_info(" %d: %d %s\n", j + cm->base, j,
-					  cm->class_names[j]);
-
-			list_add(&cm->link, &dt->maps);
-			ct++;
+			if (!nc) {
+				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
+					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
+				dt->classes = cm;
+			}
+			nc++;
 		}
 	}
-	if (ct)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+	if (nc) {
+		dt->num_classes = nc;
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+	}
 }
 
 /*
@@ -1263,10 +1266,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1379,8 +1381,8 @@ static void ddebug_remove_all_tables(void)
 	mutex_lock(&ddebug_lock);
 	while (!list_empty(&ddebug_tables)) {
 		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						      struct ddebug_table,
-						      link);
+						     struct ddebug_table,
+						     link);
 		ddebug_table_free(dt);
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.51.0



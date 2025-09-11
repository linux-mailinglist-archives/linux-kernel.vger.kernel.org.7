Return-Path: <linux-kernel+bounces-812879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED70B53DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8BA5A638C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4B2DF14C;
	Thu, 11 Sep 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSM8DLyH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438A2E2850
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626741; cv=none; b=sDpuZj2qGywP77YBhqG90AZm/vfBmu9wAg7rnLs7YoCYvbE7h7ft3kdwNJB1gJsa5trl4outa19/SOaQqnAQSeKI57yMTtxSRMo43/5vuABwzccLikWItWliugjt+KuHNU/+Q4kH/vIvUSxNJVWg8DmrK5EnnTzech6xjf3gjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626741; c=relaxed/simple;
	bh=rK4z7rclwfK0c037dAKPfOpjg7IlFZUJaEv9EBcl1IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVZAmpTpHgW61XogDzo6idfjHvE3z0SpZxJRFC3P91pYjnOLaQg7HyTaY029yBqrsGAnO58rd1nMUPoTph/UicinWSnKrocA2EJtqUA3T/EJgucMJIpiYzvxB27/t92qywzql+IbD1+8vKDuEDfP989VqAVYBqnlkap8LFhMqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSM8DLyH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432e27c77so33075239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626738; x=1758231538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxIlY2yM45eMQeCF3YJ//hYD95SXkEqZOPug5RB/i/U=;
        b=eSM8DLyHjIznDZrogEYR8xeo8Zo/qcbAK7eQjbDIZwf0rFiTpsyM/DZ2KEO7X7h72V
         vjeyq2a9/7uzc6iBgsbFsSPXLfb+2Y9Oc5tXW+/KHoU1wY9kQ5RIIZvBxhIBTViMad92
         fERo1OLZBJC5um1mkQvQdhPUX9LV42bUhIHPceCGkREc1Excp6cHqCPFmGq8SUztIDmX
         ScQPlR8zJFPFFKcB+JcYkUzyZE2L7nhw4ADutmWyE8XErC8Is7Rlmab3HZ5sVH9uvp2M
         o+aZEmH7kAEYXTOHKr2sI7Q8JYrRubcHQQ6aMhzD7eDfF8biEYaMDFVLgNAE0wiivUV6
         uQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626738; x=1758231538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxIlY2yM45eMQeCF3YJ//hYD95SXkEqZOPug5RB/i/U=;
        b=aY5IqQUQ5FugksHQXCMzGwT4atFtoU2uZzQ9P8tamG4gemLDSWuLJ28mxAiXU1H5Hs
         5XRxjjOkCtdPhdrAiK+9x6PWMlG7aViQThCbZ7gVg6z+Cqn14U8OAOLlbBThTdjjh7o9
         qfPTz8tfLkI46N9MPFsHTNq8I7QQajY2AXfyaf29ehqGZkuVYHPMYOw+33wS3QaKdAYU
         b83wOzMEDV77JzTw8wqYBo482yGsLdmgP290rECrWP2WsjFfjLAtIlKwiXz825/pLT5G
         8ObdKkaDPORsjtJuB+JS/bIHWCc4P62LJWsPp1HVBqvKiuNEXVomHo8bWfhLxSRDATGk
         B0HA==
X-Forwarded-Encrypted: i=1; AJvYcCWc9qNRzbf/1ho/Wu0X2sq+onQcPp1JpElJQbFDs1e0jm0fxsKg2FSq3/gn0GBcODT+dJ3C3oiVUZyWUEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3hZY06r65YczGeeQLcXpZvcIQRtvYmM24ObYVGYPZaFN9JuL
	fR7GZUZ9wIFevmL/nc+vb8GyFk0dRfhwKTY3T3n/fhQwkOEf2v9m3sOxVV0rzg==
X-Gm-Gg: ASbGncsGPKt7ip3wFbr+llGsljOmGd2a6mwcjrv35lF1WTiwZ9z+fCnnWZcFlK9IXiZ
	qLf8zmq7PtxF4Z4o27gbG/mjN1X8y2FErH9yP5DSGmbgdcC3KCeds78CUG6L/mE9LD4X3efS0sG
	hoIUgfP2wg72iO/2keCTx1GBpKJnRLJPr0w0gw9yNfsDh9W47OXlymHD8v1uxRvQRCqBvXTSlUa
	9zSi1Kwd4hWfzVEnFKw2I82O54ZJxlEVLz+huXK99OP+7MQ4Z6v6OUWpO5tgDT0OO7+uM3tA/rP
	QeB1tGDH5BXLJsTNPPcFmULpinTbXMOVcvvyENRSbYwaIXa3JtN4XKCie0bd+xIQfF4jhXf1NDe
	4OmwjGiJ7yyzFQE46JXkJel8bO2P51zterybkbnK388jbpLqfmxFysmdHlFlMUn7oyKWn5vXgih
	eBUNo=
X-Google-Smtp-Source: AGHT+IGCUUKaqzOUldNrJ2pIH/y8mLgaqS+P+tG9o2ue3Ar7AFF6BCqwAirhaPjPphM2vwo7H6z7MA==
X-Received: by 2002:a05:6602:7192:b0:886:e168:e087 with SMTP id ca18e2360f4ac-89036ec048cmr93840739f.13.1757626738402;
        Thu, 11 Sep 2025 14:38:58 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/30] dyndbg: replace classmap list with a vector
Date: Thu, 11 Sep 2025 15:38:04 -0600
Message-ID: <20250911213823.374806-12-jim.cromie@gmail.com>
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



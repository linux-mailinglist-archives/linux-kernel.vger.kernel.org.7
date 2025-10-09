Return-Path: <linux-kernel+bounces-847302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B483BCA811
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339671892889
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87752EE5FE;
	Thu,  9 Oct 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijMVa3ef"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E402ED17C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032748; cv=none; b=YLu/+O2F762O1YIvGXvY41RGxI6wz0qLAxq0Ipt7y07LUA3WWgO4UpCZJfKwrv9RaqS4pPqgXVr/B1vh3saHTEypcMGsaizEZlVd/E4qvBvJW3sbOHqXKIDQRkcBVtyRV8J7mvOevV/uXx7eHui0t9Q4HU4MN3quOm4X79sbpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032748; c=relaxed/simple;
	bh=zvTNU21/57sLu7CPtDOAy5ER8/SrrXIEsXuQaR053aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj+4NcQLHcjsxzHbtLzd6Fe0X8dpLMw2YfYrE+NWAzWnR9Njtnnr31QDwEc5dPtgfZtSxViZu8K4FnnXIqRnNn3O4+LGefXmCT9sPSjQP/+oU2cgzqtmOpo5A2ySi/hnPRpe50B00AJ7VWWl/4F0U5FwqwgL/6MS5R/8CWe6xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijMVa3ef; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-425911e5661so4815695ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032743; x=1760637543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foiN7sqtth4khBjBEFbfAhEsiysHlMC95zuU+aZAUrk=;
        b=ijMVa3ef0bsPyRPs2cr1A7bZGmvo2jbn5oZnGK2roqm0GrGmBbDGsZmdRaaOkxlhyD
         +OsF9ZmFODZbZdnLb4xYTaauwjKfXR/WD6wqFEp2CNmfx3/9MLIV2MmUjd2BF1ucwCBp
         QZ6EVgEyqwC9NmLH0ygjoCNWmDmD+GrOYTIU1FCu9KQkiDKQ8tW1rLYPWOgTgaE9RVN1
         uNN9vVxetaJemWINNJkHSYkQMLw1R+svs097qnsIyIYIu6VYCiwaj2gjMycJHj5YWNdU
         udkQI2jF0g/dAxw+J0I1C2nbK7P5vsnrx5Nt8znygJZBjZE4Xza+SSZ88bBcCW3aJcPZ
         uGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032743; x=1760637543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foiN7sqtth4khBjBEFbfAhEsiysHlMC95zuU+aZAUrk=;
        b=daFv+scEaqGB9eYTqBJdyEFdl9acygxofHLyb/IGM359rfWXTc4MfLn+FL4IX7tFrN
         zKGh7ErDewZll1pqA5CuTF56NQR8SIaEry4K5eweNe7vmc1+6C63TX1cG/RMuHpSXm4K
         CLOq/A44WHV7/VOqPyFVru9FhLzjZsIktcu60kkdw5fJbAuHVQKgLa59cn8BEIveiB6v
         I5q9uFuib+/8j3ozf7OVhH7auxr+kcOnG+UYTag1i9s24YqChhkvB0Hen1FUi7YR10gs
         5sM8p2LtoA+oHktn02oXF83fcgci0xbJyUqzBDZ+ZYR6SHG2tJxhKkI6EyeAntxGQoZL
         e84w==
X-Forwarded-Encrypted: i=1; AJvYcCUqs3QvrIy/PIJ7qnOMqEr/yBi/p38CCIsEynE0DC0QiZfWQerb157Eg2SaqDj6b9XHWolNgszK+favyJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2i2SHLQQvG60gqg2G0gYNK2zH2kN3Pr871p+SEWjkjk6khrN/
	MeRBfLLGF++yOum2pKh3WmbPNEHeb3rKuCbGfgJasXPqRUhJkqDIVPev
X-Gm-Gg: ASbGncuKMM8+MEZYljTdeRbZcQNL1Ef9e/JhY0Th8+L8qybuEVG++net6iGvPyJ5LaL
	jJmJvLyWMQePW+dqkkjoaQFaoBPhd5H8hQAJ/X7TFoY2tzuQHMGLUl16WjGJEo3hgy0Oj3qHdbA
	s0iO9ChMNBgQbj/Bd7RkLz8KhTx6uCWIqpFQu6/7gx6G85f96QZFhKPbY8dElMPIj5pFHYJ+TtA
	UZ0PWC+Tm0vjTaeOSZLL8iPnNshn2gJazde3GuLVtS/FmPUjj38l8zjn7NNYpK/diW/PJrGtxL2
	vussBZei1tx/xC5pvH1YemTKGVqtfm7Z2kfas19Qp0qKT1/Rb6LYjKHj2Cx1nyY3UNlLSoTvsv7
	UB/zaecXs8GUuQda6/ygkEr+FPHRwHSz6fSmg+zEvaYn/2HZnnwJh28tjko3R1ZcsbAXrgOQO7m
	kUZCeeODbxr/Cmp5RnXyE54o+KrLCieTNR3HwZOg==
X-Google-Smtp-Source: AGHT+IEXrf0bXn6pOGAetXvcTVTItgA/41FlLlYPAXC+Ci3frkzz6F6WaNaH9mI22d7vbWJNi23HhQ==
X-Received: by 2002:a05:6e02:216d:b0:42f:8eeb:499d with SMTP id e9e14a558f8ab-42f8eeb4a47mr41838465ab.8.1760032743223;
        Thu, 09 Oct 2025 10:59:03 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:02 -0700 (PDT)
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
Subject: [PATCH v5 15/30] dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
Date: Thu,  9 Oct 2025 11:58:19 -0600
Message-ID: <20251009175834.1024308-16-jim.cromie@gmail.com>
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

The body of ddebug_attach_module_classes() is dominated by a
code-block that finds the contiguous subrange of classmaps matching on
modname, and saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which effectively does the same for builtin
pr_debug descriptors; segmenting them into subranges by modname.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 56 ++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 53ce28255426..bbbdb8aba071 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -161,8 +161,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1224,30 +1224,34 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct _ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
-	}
+	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
 }
 
+/*
+ * Walk the @_box->@_vec member, over @_vec.start[0..len], and find
+ * the contiguous subrange of elements matching on ->mod_name.  Copy
+ * the subrange into @_dst.  This depends on vars defd by caller.
+ *
+ * @_i:   caller provided counter var, init'd by macro
+ * @_sp:  cursor into @_vec.
+ * @_box: contains member named @_vec
+ * @_vec: an array-ref, with: .start .len fields.
+ * @_dst: an array-ref: to remember the module's subrange
+ */
+#define dd_mark_vector_subrange(_i, _dst, _sp, _box, _vec) ({		\
+	int nc = 0;							\
+	for_subvec(_i, _sp, _box, _vec) {				\
+		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+			if (!nc++)					\
+				(_dst)->info._vec.start = (_sp);	\
+		} else {						\
+			if (nc)						\
+				break; /* end of consecutive matches */ \
+		}							\
+	}								\
+	(_dst)->info._vec.len = nc;					\
+})
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1255,6 +1259,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1277,6 +1283,8 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 
 	INIT_LIST_HEAD(&dt->link);
 
+	dd_mark_vector_subrange(i, dt, cm, di, maps);
+
 	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
-- 
2.51.0



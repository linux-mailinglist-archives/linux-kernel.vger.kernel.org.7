Return-Path: <linux-kernel+bounces-812882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA7B53DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C60188B9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BF2E716E;
	Thu, 11 Sep 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvPAJo2L"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8072E5B2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626746; cv=none; b=Gm8Udv7t2t6LPM0UzvtgpM5XuEF0CzaiObSaNa4lJXIRQMNQgj/cuXQd5jPly01Y4EUoVCZRaXR1i5cpE2uCKUB7IWqgl2MJIxgM4xnhH9b5Q+TROsDPh/azwYQC+DRirSpHLuulZS/ByHY0Lqw+ShR9VGc5CcyC8pc9VfpLQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626746; c=relaxed/simple;
	bh=zvTNU21/57sLu7CPtDOAy5ER8/SrrXIEsXuQaR053aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWZnPS/ffJ+ZlMu8tLfcV0qkR9ozjZ/wazgH7SYxQp9xzsk5txVuHsLRDI+IgpOuiqfSjPvhxMArNqjvA2E4EdooSbJBU8S3FE85WZGlctvS9sFqWSzaBSuJ/dBtFtnc5GVxvztlq6S3XRE168Gio/LlWbusxxUJJUoAELdR1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvPAJo2L; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88703c873d5so31198739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626743; x=1758231543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foiN7sqtth4khBjBEFbfAhEsiysHlMC95zuU+aZAUrk=;
        b=GvPAJo2Lr+jvV2E/WGvhpZdXstpLs9dQQRU/C0ywtDmuCMnl2ALuELnLJV1g+YsQf1
         cLAS79yUQdLu42H43uMgMYK3cJi5Js0wcpTUT7vg2MreuhdlvDy+P5UakJZ90QSPbfHv
         XNE74d9e5t9ZeHinyYnzW2xp6qjW9/PtRIg0ChiuX7TZSpIKNeUCGF5Ozh/a04x2EOIe
         QwIKrEDHkZ9El4DflLYqOxFPTY+5mwnOPCYNA1JGNLtW1peYbXSBKW9pSQMGYjV3ZXoN
         MB7HvNl/D5HX2749VoGqdKEt63TsITq+wcbARSzzyyAwbzRMMhPJysmDfFUVuVDXlSQ6
         J/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626743; x=1758231543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foiN7sqtth4khBjBEFbfAhEsiysHlMC95zuU+aZAUrk=;
        b=lBjxxLHcJYb/YPauWn174OkYkIKDbeyAyDzoDHiLz2DCOw2rZRzNaLiLpxVPCbgoFA
         +pjVE6d9aulCMLzpxJvcArdyanLfij+VCJuH+01r5vWTsLe+w8uAURF5SCgW6cejYv94
         wrDm6zlDdsk3VGDsjbUsrnwVkCQDDRIbuXoWdKfpMgcltcE9Uit7UGleE8N+fCbyel3D
         4nvLF+S2GB2NJT8phrldoZmgUZh8LZmLAKVPNTmLQn1wJ2URjfn+6Dj0FH0HOEAlkli+
         /ROWxKC/O5NbKQSRZ7k+vy6z7tpvDlIjTA59itQ09AjddswoQIGyEUYZKFLAB6pzpOLg
         JirA==
X-Forwarded-Encrypted: i=1; AJvYcCUKQTAJTG5+KnUp3BC0ft2Bf9D0xFFr2lh8QzLZDni9vPviMOsfbZgOSR7LNTEIJlvxOFYQ1NPc5IG5ESk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlu9A6daRSYlUhWm/4j5YOAEgfgPFLrJabaQTmvMPq+t5YVb31
	WkLHUshSry+DtitkgrAVvG/N9tCInRuOUG3Cg5wx+g5KQ9NsmxFAsKz5
X-Gm-Gg: ASbGnctEDoM+oZNbBhgqWVhSeRGzUZJxTjP+IEQjCPxqTiVFh80HlLql/xZzhDM6LoF
	6Y9SQmZZ4e0HiiumD22Ve8hfdcJrZiZ830uDIGaFwgctdBzMtdVqrUzIUAW5Qbca8zXBRKIvzo6
	drwrC62neEYtv+QGXmYgj+f7J1P0wBpmi1a6YwIlk4z83cUzmkxDMgboBW4M5jl0OraCheX2t9Q
	8AHUcmLBm65Qpgd1tolERyjx0WWbTmiXQbC78GNHR8VxzFzVujQ+vcmSkjqXxd/jekYCPE1z7n0
	EI9AvAlZw5bLVfjyJhmPfpmK82ZTpu6xVOhSJLcdt3ct9e3Ck+UxQdKQoNCM738Ax4RsjiwCu0l
	qLmS8QIguBfQfCUvhRuCvv1r73u5VSBTri0KcDdXIwenyHE+9biEe1UvmAF+mw6AgpZdYgPJWA0
	edYUE=
X-Google-Smtp-Source: AGHT+IG6bNiWR/GEXPQU1VwlGR3gL03B4V2LHYK7NtoK3MBviqChFxmGl4CrN3XnjiQoxU8RId2mew==
X-Received: by 2002:a05:6602:483:b0:887:62d2:4622 with SMTP id ca18e2360f4ac-890369e764dmr120056139f.11.1757626742688;
        Thu, 11 Sep 2025 14:39:02 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 15/30] dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
Date: Thu, 11 Sep 2025 15:38:08 -0600
Message-ID: <20250911213823.374806-16-jim.cromie@gmail.com>
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



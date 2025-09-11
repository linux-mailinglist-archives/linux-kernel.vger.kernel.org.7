Return-Path: <linux-kernel+bounces-812880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA50B53DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1736F1890BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D52E5B0E;
	Thu, 11 Sep 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWDBw6uA"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7D2E36F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626742; cv=none; b=nyWpdKb2XKfXCFHrXzKnC9uPdudG/fbU0QI/YKwfqCqFDGej2ySwKyWWurTbVYSPg2oVmjoomXayU/pUaV/gGXfpHPZ3lfVMa8kzSSAwMzs2oWG21+5Rd913PPggkttvwXUz2w8dIJ/K+aTI6BHaawPwusT9wxZgpdk3LuT2YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626742; c=relaxed/simple;
	bh=mz4pmSNtikpHGQKcU360KSG8B6f7Exi+ES9uDoE62vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n53O4t0N1xRtg814Q4zxl3tu406pRqAzYWAq7xCW7kLbt/KCa+N2URU/9IMmX6RVVtpGgBxYgQw6c0cFzW+XyESJb9M7nyHf9Ga/guIMuEvqDX1cwxc4lxHvRXMSQWEChEJ//1cJZrS5p71ge6SczG+c6jpLw+jWjZ6LLeVuIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWDBw6uA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88762f20125so88064439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626739; x=1758231539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
        b=NWDBw6uAX/Ff7XGC+OjNRLuJ34J502Q590TnlPN875rFd1sZ/jcZPDEHIfo7qvZVX5
         PIZKEaMPFicFIZfkygIGPIHdaWjxx+1vyAF3aEEFhucL+T0rKgc15M4+NRAVmwgc8ho7
         LuVjJPDblyFklCFeOLvjCOqlO3yga2tip2bhT5ycYhMfl1ZeuyL6Vc0pG8hFePDCBt3N
         3IgGDK9kRNpJq422AlzFivdmo4YkkDTV2m/amBOYokX7At2ch7Dl2izwOBzG5zjQznjF
         /zaffJzpXiR3u1ZsaaSHHEQgXUuBzE0av/sOoG3BHr6VIthcDxlX605R/f1qJa3sOMQm
         NI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626740; x=1758231540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
        b=L805ZqwXkew+zN4L/5x/GeUPXupgZDm37rsf5M98FFiL5nPe7dLrEyReif5Rl1yJlV
         DEMkkXrvioN7JSqjPQCf6zIIRcCGtw8QflW/NZ3oY/pOGgNPdaZyeklEDYkDiw0FwcMN
         OmLBnx4kFfsL1mwa2SMZOJgylGcBOYjFpfulYVQmTX8Ofd2KW8Yk5E+MwRDFFHavg/DN
         AyC5zvga08YeMHWG7UartyiqH2ckNyqWtnqQ2tSy3nvMOdjG8fOwMtLhwEzyYkwXoZnn
         e4U8WnaiE5kgRF1U8rIrLOPV3ffEBiZDPARq6JoB0jE9Hz1/sEk1jsE/0bZox92uFOS1
         D4+g==
X-Forwarded-Encrypted: i=1; AJvYcCXGS3s3bPPSdnI2yqgtrKrf8JJr+s+4nQxcmU0sQYyx0pSDbM3M4VFfyK8nXnCrplVKaEvdpTTAf3Pl/cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gFa0vw+i23GzEa9l0CpXm1Fzjfs/2bXH4Jut73aM7sYUbI14
	MD781uiCciVw7/Xp4vxDOufK3o8iPaz+csW+Rn2/6TjOoHL9tQgMBhK0
X-Gm-Gg: ASbGnct3zhq8ZEjuNxPs7zCL5RyfUXcW/ztDdybl0Ep00JpfCSi8T5EG2MM0KbxwlRD
	v8k+3NzBPkEAQ8tBBcOIJ9QA/lBfIFs7T++Cqq5yTcsGc0sr6w5A2iGpfRZKi0t56Yhv9SshNlY
	VLPCJl9H62mVHB10azvGSHLw4do6Ee9K6Au8uULveyZZtxKRjYf4HaoW7so1+x+Vcn4P1E5h1IS
	3CASiJxvyJTe2P8FImPIevjy9eZFDajqCF7j3zjiva/bzhsgdsvjueA+A2ioFI5aVNji6q5Gxk6
	gkjjsZ35ytw8BI4rLM99mK1UppvNRIj9SxwYQeyAX/YD9rcaCJLddd7tew6IcjhKKSXKR9v0PSh
	5vPL2/Rw/i8JXEMOY4O6JLLWC+eQCHIJmHIfJA+Z29CfJveHgn0W+QmykCW1I+EbICyAiMMxUN1
	J5TzQ=
X-Google-Smtp-Source: AGHT+IGdKubNvCzkSRxRI0QKSMony/uatnUWgsFeYs2+bRkQDBiR4PdkBuI4Dyt3fdUN3mrh5Ya4ug==
X-Received: by 2002:a05:6602:2351:b0:887:1472:e991 with SMTP id ca18e2360f4ac-89034be4658mr105297139f.19.1757626739562;
        Thu, 11 Sep 2025 14:38:59 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:58 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 12/30] dyndbg: macrofy a 2-index for-loop pattern
Date: Thu, 11 Sep 2025 15:38:05 -0600
Message-ID: <20250911213823.374806-13-jim.cromie@gmail.com>
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

dynamic-debug has several __sections, each with <vecname>,
num_<vecname>, and it iterates over these with a 2-index for-loop.
These loops are fiddly with the 2 names.

We have only 2 such loops now, but are getting more soon; lets
embed/abstract the fiddlyness in the for_subvec() macro, and avoid
repeating it going forward.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 283926530a43..ddcaa87f3b02 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,6 +128,20 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a sub-struct member in _box, with array-ref and length
+ */
+#define for_subvec(_i, _sp, _box, _vec)				       \
+	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
+	     (_i) < (_box)->num_##_vec;				       \
+	     (_i)++, (_sp)++)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -155,7 +169,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1220,8 +1234,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-- 
2.51.0



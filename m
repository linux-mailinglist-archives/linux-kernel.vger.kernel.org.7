Return-Path: <linux-kernel+bounces-740003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F12B0CE71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170B56C1218
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F0824679F;
	Mon, 21 Jul 2025 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVAzUULk"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C68239E9D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142097; cv=none; b=cQqRk2z83pKM/jsqwy2TV4j/YmbWSu3Dxk/Qayd7c6ye94N0Z5HcsCAKPW+4ag8kS/TUCfZzatxYSmyC9Dfky2jVJw20C+TsCXO0+IC0nX8RqSffxYJ3Sm50kWMpbIwv47UAiSF77mOL3Us2ryVAz4DHGqYJgBy3lEoMBxlhz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142097; c=relaxed/simple;
	bh=UN4rM5hSM612Ntka5m+9qaQLIFIDkO8ZOE33vUGogn4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nkX1g+W589owgrLpMfYdECqLSiVRV+YAYzi4nNrlzCW/w/q1miZBrl7oUX/yvlwe/JB0Ou/e+BsfG22CnIaRc51M3LxVpdN69czSgG5LOL1DIPOVei4QehyFLerdZJ4+NcGVaZugz1AT38jMx4JJDKSXgxhYb8DJGdX1utEtwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVAzUULk; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-613a798c02cso4388079eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753142094; x=1753746894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xXBnVk6qsaIHtsi5KaWL0Tm37PrBVTirM3nxRY2cB/o=;
        b=GVAzUULkBfU6+iCzm+RBb5g10p1UWrkqg2Hh8HwMZ8+t87lR8IdJI1oowOO8Ql4Cl0
         tQSCcmpGigz19snEuifpf14nXlIV074hW8ZuRORu9uCu40C/wTd2LmxgXguzvtCRWSiS
         QqQ+rGcoWx4KgdGFTiJUB++qG7sh9kJWLTpEeP6/2+1Z1uP10Y3YfcXzGFz311qIyuqS
         6l6tt8m47vUlhFcllXxWxkYQ6l+2LrA7b2O23AjElPv9enEacz1fs/mZSrg1dZF3Igb9
         EU9MDCCaUcKGiMZDPC/HlgRmKmMeCA1+aH28QbeH/3GW53cDCOk3JTfWpZqVFOSg976U
         pcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753142094; x=1753746894;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXBnVk6qsaIHtsi5KaWL0Tm37PrBVTirM3nxRY2cB/o=;
        b=lzHDjT3IoN8W1aHBKyrqgP3PLjjJugJiZr9jLRQzli5zxcBWMOAsCZdbT2E4VQN1mY
         KGe6sAA2lWHxvRz08azgpL3ZP7HXkGtXFPE/2CuBK1yvsrM0Vf5SVB/8A7g1SP5UNeAP
         sp94brSbyOXKa60bZmUYKffpNhKZRYfyPwpJoqM+b00C57MJGi9CQ2FO5ZpVy+YcaILs
         Fsa59Wea4wA2zPRQtleDnPER9BAb57iI738vgFo/hOsYrHDHCZRxgEWn6jy4JjWSKztO
         5saabGS8LxbI4/ab1d8PjEgcms0BLtLdHRO+XrDpSQvgjF00kMNWfTaHfSkqK3M5f+0s
         KZBw==
X-Gm-Message-State: AOJu0Yz3/uhatcL5Es27j2noJ8mJ2f2mZPXnEVaeLlzK6KfAsftLdjwA
	r7KziBUx18PixElBg2WMIobG/tbVcgiQUCnqc8m0TYWgd/BCtMFNTlCD9NPi+5UA/yTvYK52D64
	rSdyCMU4f57JRvDKseJhQhYpeFD+kNI09tME/Y5bO6MaopiPT2gZ3PruOzpF+7lmVil5vNElnOy
	WqM3zajRKai1SjOItqMxWZxW1L3e+wLk5hscfNvkfUikwRVA8drg==
X-Google-Smtp-Source: AGHT+IGMKLV1x5xZ7JDSHPDet7I+qw3GykVwjJAn/Mv4YnYEOpveYHm53GdN0Jyr59vodnBELRPhkugyP5Tl
X-Received: from oacwf6.prod.google.com ([2002:a05:6871:d606:b0:2d5:5a26:d92])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:658e:b0:2fe:f4f4:8506
 with SMTP id 586e51a60fabf-2ffb224849fmr16473692fac.10.1753142094527; Mon, 21
 Jul 2025 16:54:54 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:54:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721235449.1316533-1-ynaffit@google.com>
Subject: [PATCH] binder: Fix-up binder_alloc kunit tests
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Kees Cook <kees@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Do clean up that was requested in reviews for the binder_alloc kunit
test series [1] after it had been accepted. Add a copyright notice to
each of the newly created test files, as suggested by Carlos [2].
Replace instances of snprintf with seq_buf functions, as suggested by
Kees [3].

[1] https://lore.kernel.org/all/20250714185321.2417234-1-ynaffit@google.com/
[2] https://lore.kernel.org/all/CAFuZdDLD=3CBOLSWw3VxCf7Nkf884SSNmt1wresQgxgBwED=eQ@mail.gmail.com/
[3] https://lore.kernel.org/all/202507160743.15E8044@keescook/

Suggested-by: Carlos Llamas <cmllamas@google.com>
Suggested-by: Kees Cook <kees@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
This patch is based on top of char-misc-next.
---
---
 drivers/android/tests/.kunitconfig         |  4 ++
 drivers/android/tests/Makefile             |  3 ++
 drivers/android/tests/binder_alloc_kunit.c | 51 +++++++++++-----------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/android/tests/.kunitconfig b/drivers/android/tests/.kunitconfig
index a73601231049..39b76bab9d9a 100644
--- a/drivers/android/tests/.kunitconfig
+++ b/drivers/android/tests/.kunitconfig
@@ -1,3 +1,7 @@
+#
+# Copyright 2025 Google LLC.
+#
+
 CONFIG_KUNIT=y
 CONFIG_ANDROID_BINDER_IPC=y
 CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makefile
index 6780967e573b..27268418eb03 100644
--- a/drivers/android/tests/Makefile
+++ b/drivers/android/tests/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2025 Google LLC.
+#
 
 obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 02aa4a135eb5..9b884d977f76 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Test cases for binder allocator code
+ * Test cases for binder allocator code.
+ *
+ * Copyright 2025 Google LLC.
+ * Author: Tiffany Yang <ynaffit@google.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -12,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/seq_buf.h>
 #include <linux/sizes.h>
 
 #include "../binder_alloc.h"
@@ -104,40 +108,33 @@ static const char *const buf_end_align_type_strs[LOOP_END] = {
 };
 
 struct binder_alloc_test_case_info {
+	char alignments[ALIGNMENTS_BUFLEN];
+	struct seq_buf alignments_sb;
 	size_t *buffer_sizes;
 	int *free_sequence;
-	char alignments[ALIGNMENTS_BUFLEN];
 	bool front_pages;
 };
 
-static void stringify_free_seq(struct kunit *test, int *seq, char *buf,
-			       size_t buf_len)
+static void stringify_free_seq(struct kunit *test, int *seq, struct seq_buf *sb)
 {
-	size_t bytes = 0;
 	int i;
 
-	for (i = 0; i < BUFFER_NUM; i++) {
-		bytes += snprintf(buf + bytes, buf_len - bytes, "[%d]", seq[i]);
-		if (bytes >= buf_len)
-			break;
-	}
-	KUNIT_EXPECT_LT(test, bytes, buf_len);
+	for (i = 0; i < BUFFER_NUM; i++)
+		seq_buf_printf(sb, "[%d]", seq[i]);
+
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
 }
 
 static void stringify_alignments(struct kunit *test, int *alignments,
-				 char *buf, size_t buf_len)
+				 struct seq_buf *sb)
 {
-	size_t bytes = 0;
 	int i;
 
-	for (i = 0; i < BUFFER_NUM; i++) {
-		bytes += snprintf(buf + bytes, buf_len - bytes, "[ %d:%s ]", i,
-				  buf_end_align_type_strs[alignments[i]]);
-		if (bytes >= buf_len)
-			break;
-	}
+	for (i = 0; i < BUFFER_NUM; i++)
+		seq_buf_printf(sb, "[ %d:%s ]", i,
+			       buf_end_align_type_strs[alignments[i]]);
 
-	KUNIT_EXPECT_LT(test, bytes, buf_len);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
 }
 
 static bool check_buffer_pages_allocated(struct kunit *test,
@@ -308,19 +305,20 @@ static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
 	int i;
 
 	if (index == BUFFER_NUM) {
-		char freeseq_buf[FREESEQ_BUFLEN];
+		DECLARE_SEQ_BUF(freeseq_sb, FREESEQ_BUFLEN);
 
 		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
 		*runs += 1;
 		*failures += case_failed;
 
 		if (case_failed || PRINT_ALL_CASES) {
-			stringify_free_seq(test, tc->free_sequence, freeseq_buf,
-					   FREESEQ_BUFLEN);
+			stringify_free_seq(test, tc->free_sequence,
+					   &freeseq_sb);
 			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
 				  case_failed ? "FAILED" : "PASSED",
 				  tc->front_pages ? "front" : "back ",
-				  tc->alignments, freeseq_buf);
+				  seq_buf_str(&tc->alignments_sb),
+				  seq_buf_str(&freeseq_sb));
 		}
 
 		return;
@@ -380,8 +378,9 @@ static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
 	if (index == BUFFER_NUM) {
 		struct binder_alloc_test_case_info tc = {0};
 
-		stringify_alignments(test, alignments, tc.alignments,
-				     ALIGNMENTS_BUFLEN);
+		seq_buf_init(&tc.alignments_sb, tc.alignments,
+			     ALIGNMENTS_BUFLEN);
+		stringify_alignments(test, alignments, &tc.alignments_sb);
 
 		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
 		return;
-- 
2.50.0.727.gbf7dc18ff4-goog



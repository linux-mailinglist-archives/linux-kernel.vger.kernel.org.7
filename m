Return-Path: <linux-kernel+bounces-730649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D189DB0479A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B567A4E21A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2426B942;
	Mon, 14 Jul 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/IR6SC3"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3A277803
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519220; cv=none; b=pLIkz2XP8B1gRzml8y/XAeQeNNEBZFZ2IVbkJ+lvJ5ImqyO6xc54GJnlCMgJId4sFWd0aiC4kMav0rZ/+BCtGgh3g+LFVnKH5n4Vz1VAa3FdciVFXXSKvm19dGcXvsZH1OQXGp7O8v9adP/EOBeiQ7amrAidT9LMAA6yaXiXv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519220; c=relaxed/simple;
	bh=yWmNmWgvKvda0eYoTS5d0V7bZ75rInx7GtYuQcH7ugI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGJ03PeMjPdcnTaP0/Xife2bclqFrCz9rroSmFpj2ZC5Titis43gHRE7PFyF8KvSwKXKrQN6fsxHmCiJx9ygy0tERHv8TjX7p1tF/9k2TmyX+za2OYW+8sHfOKzChYXtyEvdjkV7GLLpM3A8Hb21eApru241iAyDThlaaOg1Wbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/IR6SC3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so45731925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519218; x=1753124018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIXYjl4Oy7cLC2gt6wngeVcZAy4rgnTDnLgmQ+C2I1Y=;
        b=1/IR6SC39VOp2NB1ftf7oGUlvbLe6odkxWZ8GrX2sVKAIf3MsSp/1a8eFXoT7yQ3B7
         +3qNqQPMOprAe8tp1qvwNUNXurg4XBzIYjXd9g/gch/dJ59D+rtVI881OzwqxmJkdqHF
         zS+nqf65SgNKS1RG3gpN3eaOIrCmkYyg3LDxOqk5yyak3mdRakdrj7WUyLdauVOADWRg
         ST1ML8MCpmAfp5z8q2BQKaI+NgO4z/98iI2inMy1L2lFWgtBJ87YSmfwbI2FXKZcBGun
         xASo/Ej2sv1lpx4DfQtUyxNn0cM+eTzWh5zykJKWPmePUOsVeowEtpyEr7k71J35IqPe
         3+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519218; x=1753124018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIXYjl4Oy7cLC2gt6wngeVcZAy4rgnTDnLgmQ+C2I1Y=;
        b=uQSJN2LQerfuPF0zsOSXspoLt4Gaw4Cb596K2VxJtL/FyU1sCFnYQFXTInKBbrv0dC
         Chq54rRPpa0u48cB/6rKwI+I6rxcSGXU8Sj0LN8MXNHP08nja4k5W5Tv7GExOVh/40A+
         y8tFLqvAXLgtZmzzRcct3bXwyJVUrEKtVL6RdT0VDkwJdvQVRvhx/oY83ejt5d9xiavm
         6ZEmpZCe9CVj2H+pLBM+/WC5cNLbwbag577fQnygUDg10LkxtiqQXVSsWY7ahAsXZXdu
         Cafi/QNwxXIVA7WK8S6vn5/vqSWSZ5FsMLgVonkhoK3ePFDXTnF4XRZ+n6UzpreFPAbX
         VeCA==
X-Gm-Message-State: AOJu0YwY9yQvDohLHxnmH0uLoIU5F7nIFRd/KVMY33V4W3FBZ0ZfVJzq
	VSCy+q4XUyBgoha+jRDyCCbPv/RhuM62j74YOA3mrOsbS6fmR/tNN+f8n/bQMp4yILVb85gef5m
	JjeW95QByAnH9C5lF/iMDs4nq9VJT3JKTPY+Dm063dYZhTHJjg75f4ypSJG7neG6WCU6gNSB7Ht
	ZUlNkr8s2zAU2e+qEXJ7qmE8Fc6a8BhEQOTRKAGYk6svLoXbCaEg==
X-Google-Smtp-Source: AGHT+IHkdxQBkNJ9u5fZvf31QYZmJmI78/imSoERcG85hl6ZxFXWcMCdQ6WF5agEQ/mYR3aMFUmQE1c5Wzd8
X-Received: from plbi11.prod.google.com ([2002:a17:903:20cb:b0:236:8084:af9f])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa7:b0:234:11f9:a72b
 with SMTP id d9443c01a7336-23dede96972mr178592455ad.50.1752519217585; Mon, 14
 Jul 2025 11:53:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:15 -0700
In-Reply-To: <20250714185321.2417234-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-3-ynaffit@google.com>
Subject: [PATCH v3 2/6] binder: Store lru freelist in binder_alloc
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Store a pointer to the free pages list that the binder allocator should
use for a process inside of struct binder_alloc. This change allows
binder allocator code to be tested and debugged deterministically while
a system is using binder; i.e., without interfering with other binder
processes and independently of the shrinker. This is necessary to
convert the current binder_alloc_selftest into a kunit test that does
not rely on hijacking an existing binder_proc to run.

A binder process's binder_alloc->freelist should not be changed after
it is initialized. A sole exception is the process that runs the
existing binder_alloc selftest. Its freelist can be temporarily replaced
for the duration of the test because it runs as a single thread before
any pages can be added to the global binder freelist, and the test frees
every page it allocates before dropping the binder_selftest_lock. This
exception allows the existing selftest to be used to check for
regressions, but it will be dropped when the binder_alloc tests are
converted to kunit in a subsequent patch in this series.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 drivers/android/binder_alloc.c          | 25 +++++++----
 drivers/android/binder_alloc.h          |  3 +-
 drivers/android/binder_alloc_selftest.c | 59 ++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index fcfaf1b899c8..2e89f9127883 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -26,7 +26,7 @@
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
-struct list_lru binder_freelist;
+static struct list_lru binder_freelist;
 
 static DEFINE_MUTEX(binder_alloc_mmap_lock);
 
@@ -210,7 +210,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add(&binder_freelist,
+		ret = list_lru_add(alloc->freelist,
 				   page_to_lru(page),
 				   page_to_nid(page),
 				   NULL);
@@ -409,7 +409,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del(&binder_freelist,
+			on_lru = list_lru_del(alloc->freelist,
 					      page_to_lru(page),
 					      page_to_nid(page),
 					      NULL);
@@ -1007,7 +1007,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!page)
 				continue;
 
-			on_lru = list_lru_del(&binder_freelist,
+			on_lru = list_lru_del(alloc->freelist,
 					      page_to_lru(page),
 					      page_to_nid(page),
 					      NULL);
@@ -1229,6 +1229,17 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 static struct shrinker *binder_shrinker;
 
+static void __binder_alloc_init(struct binder_alloc *alloc,
+				struct list_lru *freelist)
+{
+	alloc->pid = current->group_leader->pid;
+	alloc->mm = current->mm;
+	mmgrab(alloc->mm);
+	mutex_init(&alloc->mutex);
+	INIT_LIST_HEAD(&alloc->buffers);
+	alloc->freelist = freelist;
+}
+
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
  * @alloc: binder_alloc for this proc
@@ -1238,11 +1249,7 @@ static struct shrinker *binder_shrinker;
  */
 void binder_alloc_init(struct binder_alloc *alloc)
 {
-	alloc->pid = current->group_leader->pid;
-	alloc->mm = current->mm;
-	mmgrab(alloc->mm);
-	mutex_init(&alloc->mutex);
-	INIT_LIST_HEAD(&alloc->buffers);
+	__binder_alloc_init(alloc, &binder_freelist);
 }
 
 int binder_alloc_shrinker_init(void)
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index feecd7414241..aa05a9df1360 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -15,7 +15,6 @@
 #include <linux/list_lru.h>
 #include <uapi/linux/android/binder.h>
 
-extern struct list_lru binder_freelist;
 struct binder_transaction;
 
 /**
@@ -91,6 +90,7 @@ static inline struct list_head *page_to_lru(struct page *p)
  * @free_async_space:   VA space available for async buffers. This is
  *                      initialized at mmap time to 1/2 the full VA space
  * @pages:              array of struct page *
+ * @freelist:           lru list to use for free pages (invariant after init)
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
@@ -113,6 +113,7 @@ struct binder_alloc {
 	struct rb_root allocated_buffers;
 	size_t free_async_space;
 	struct page **pages;
+	struct list_lru *freelist;
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 486af3ec3c02..8b18b22aa3de 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -8,8 +8,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/mm_types.h>
 #include <linux/err.h>
+#include <linux/list_lru.h>
+#include <linux/mm_types.h>
 #include "binder_alloc.h"
 
 #define BUFFER_NUM 5
@@ -18,6 +19,7 @@
 static bool binder_selftest_run = true;
 static int binder_selftest_failures;
 static DEFINE_MUTEX(binder_selftest_lock);
+static struct list_lru binder_selftest_freelist;
 
 /**
  * enum buf_end_align_type - Page alignment of a buffer
@@ -142,11 +144,6 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 	for (i = 0; i < BUFFER_NUM; i++)
 		binder_alloc_free_buf(alloc, buffers[seq[i]]);
 
-		/**
-		 * Error message on a free page can be false positive
-		 * if binder shrinker ran during binder_alloc_free_buf
-		 * calls above.
-		 */
 	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		if (list_empty(page_to_lru(alloc->pages[i]))) {
 			pr_err_size_seq(sizes, seq);
@@ -162,8 +159,8 @@ static void binder_selftest_free_page(struct binder_alloc *alloc)
 	int i;
 	unsigned long count;
 
-	while ((count = list_lru_count(&binder_freelist))) {
-		list_lru_walk(&binder_freelist, binder_alloc_free_page,
+	while ((count = list_lru_count(&binder_selftest_freelist))) {
+		list_lru_walk(&binder_selftest_freelist, binder_alloc_free_page,
 			      NULL, count);
 	}
 
@@ -187,7 +184,7 @@ static void binder_selftest_alloc_free(struct binder_alloc *alloc,
 
 	/* Allocate from lru. */
 	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
-	if (list_lru_count(&binder_freelist))
+	if (list_lru_count(&binder_selftest_freelist))
 		pr_err("lru list should be empty but is not\n");
 
 	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
@@ -275,6 +272,20 @@ static void binder_selftest_alloc_offset(struct binder_alloc *alloc,
 	}
 }
 
+int binder_selftest_alloc_get_page_count(struct binder_alloc *alloc)
+{
+	struct page *page;
+	int allocated = 0;
+	int i;
+
+	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		page = alloc->pages[i];
+		if (page)
+			allocated++;
+	}
+	return allocated;
+}
+
 /**
  * binder_selftest_alloc() - Test alloc and free of buffer pages.
  * @alloc: Pointer to alloc struct.
@@ -286,6 +297,7 @@ static void binder_selftest_alloc_offset(struct binder_alloc *alloc,
  */
 void binder_selftest_alloc(struct binder_alloc *alloc)
 {
+	struct list_lru *prev_freelist;
 	size_t end_offset[BUFFER_NUM];
 
 	if (!binder_selftest_run)
@@ -293,14 +305,41 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	mutex_lock(&binder_selftest_lock);
 	if (!binder_selftest_run || !alloc->mapped)
 		goto done;
+
+	prev_freelist = alloc->freelist;
+
+	/*
+	 * It is not safe to modify this process's alloc->freelist if it has any
+	 * pages on a freelist. Since the test runs before any binder ioctls can
+	 * be dealt with, none of its pages should be allocated yet.
+	 */
+	if (binder_selftest_alloc_get_page_count(alloc)) {
+		pr_err("process has existing alloc state\n");
+		goto cleanup;
+	}
+
+	if (list_lru_init(&binder_selftest_freelist)) {
+		pr_err("failed to init test freelist\n");
+		goto cleanup;
+	}
+
+	alloc->freelist = &binder_selftest_freelist;
+
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);
-	binder_selftest_run = false;
 	if (binder_selftest_failures > 0)
 		pr_info("%d tests FAILED\n", binder_selftest_failures);
 	else
 		pr_info("PASSED\n");
 
+	if (list_lru_count(&binder_selftest_freelist))
+		pr_err("expect test freelist to be empty\n");
+
+cleanup:
+	/* Even if we didn't run the test, it's no longer thread-safe. */
+	binder_selftest_run = false;
+	alloc->freelist = prev_freelist;
+	list_lru_destroy(&binder_selftest_freelist);
 done:
 	mutex_unlock(&binder_selftest_lock);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



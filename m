Return-Path: <linux-kernel+bounces-778485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEEB2E660
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA02E4E22CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26F28C014;
	Wed, 20 Aug 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv/kAlA6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C429257AFB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721306; cv=none; b=UPoV3u8cVxAChhCIhB6VV0AlBeOBYdbEb6FG1fxt97ruA7cvFCJemdnYUjHyV+PeNiY4wtRi/caxIuCaOIuOtHM6CJVt3OzgqjVwyQy1vpaAGgArms57AACtu8TIeYKgpQPEoRHqUUiO7gqA7vlI2PNLdv2/S0c+LZ748lljXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721306; c=relaxed/simple;
	bh=f7C61sFGnQkcWPO9Mws+3QM8wkhIV7gb+xt3lOjyEn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7P/ZY3megxipF3Bmi+Q3dwcqy3tMcBi40ndpf4DOr8XLYpS3pKKDWe73mTxln+b91DKewn4vVeTqtw4wtPp7byFkh6jVWCr/Mn9PLDcluOaVCBNue9MNDbmEApJhjIYPQuFnDar3xH5FDUZnrC1IqeizUIuEXcZLCUTg3JNasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv/kAlA6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e434a0118so428390b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755721304; x=1756326104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfVBeq8pl0QP8g5U6AiE3ib+c8wqo++gGMPp1Ed/A9A=;
        b=hv/kAlA6wFjLgHjXfz5gUpUfS8t9eEq64bWftnQmENoYiQmhtgsweEWxJ5Xn+AkVBT
         TXz3Da16A3YMu6cbqRR/qlkm15r+EzFPcFggA2XC7n1JORSaH/S3XGFDUhof1ldBLRf/
         9loh38t/X0UOWJYMeZW7lEyRCJKdmiP+3BK+7SRXBFEUKsqmW7NzRaM1aU/f8Zw8HLth
         Zj3TOO1g/gotrJclI1vT66jwRHOieUkA5RzTlkXzYMzMrFO39swBexXBh8kod2EqfCr5
         b2uleO9JDlPx78kIN5TJsz8M4Etb7o0ED7YssQCT25KFiYZiqGQlTAjgcmTqmG0zQ/Mh
         GLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721304; x=1756326104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfVBeq8pl0QP8g5U6AiE3ib+c8wqo++gGMPp1Ed/A9A=;
        b=V/x6qG4v6ViYD7F89vesjel+KwpkGEjcLosBmz3e4Plp4QD1gkX7CV9a3QN7G7jsPL
         wWdmOP05H/Gm8gLW1dcn8Du1/LWPpku0X6C5RMpOK1i52WG8KvvtQlR27E7nLgXFjAiH
         4ip2EFhT3PGe0E67kMZ9OJLxy4BY699IcchQy66LKRWlfqNEZcIgZgTlf82k5jgiqxAt
         Qhbp7wAuccl4PXKUyT3NQvpHRhOqyAtU/E2im3FGWA2UA8CMps3MRnKe4eNVKvJCcPg+
         QIw6hkpK2bQOQP8drVHQF9fwmFnv0vitduAnawL5+G9PLqgH5TT1jMT7U9V2ZJX6gmfG
         xEOw==
X-Gm-Message-State: AOJu0YzlfSnq3NASO9AZhPtzHJ9kreznkh4pnak31qoKcuG4yijeuwJH
	TS2EnLoizyg0YZGAr+DofV01wVo6eGcR3S2DxtssXd8JObf5O5M5oy3H
X-Gm-Gg: ASbGncvNRnA9D7OKrd7CGExRivkrw3z7+CJXy7z1W7wtBc+O6HhdARFPwRDHxI60eQw
	JgQTJYAVDi7ZI1YFX6D3bU/v22C5rVMIirQu9cKMVIQle6W/iS1l6Ul+IENIKdYlRQTGzqs4Asr
	QjUZV1Zhhqeh7EHTJyTMUb6aKNHIbz1/BIpXbedglyliPztQ40rtVBTrH0uJuLj9z7lAht7q/1N
	+CRszNw9fy1lV4wjkRRVD6JTgIpbjui2JNApfffGl9ZEvf21vUYpQJnWzDskolsjZPD5zR8Q2Hp
	pbLdhMRcdTnKRsxOht6wHth7CI1pRLkxBsrq0Oe2jo/Rzmm1bES6Ceug8BXLWZsmTf4CpbOsuU9
	kp2QGIFZOIqjWxuev7B1UNnqGDynIm7r5eBgPgkNqUhPuFKNCbgtRqSCrnXJlkLXn
X-Google-Smtp-Source: AGHT+IE7ppi3rTM6S8pDhkBCrus98JT267r9X2CkaixyAbQTz839FrOVIIRUDZc1sYahqTZpBZxHTw==
X-Received: by 2002:a05:6a00:a93:b0:76b:d8c8:2533 with SMTP id d2e1a72fcca58-76e8dd5fad9mr6590344b3a.24.1755721304107;
        Wed, 20 Aug 2025 13:21:44 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76e7d0d0ef9sm6222261b3a.12.2025.08.20.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:21:43 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] mm: tag kernel stack pages
Date: Wed, 20 Aug 2025 13:20:29 -0700
Message-ID: <20250820202029.1909925-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have no way to distinguish a kernel stack page from an
unidentified page. Being able to track this information can be
beneficial for optimizing kernel memory usage (i.e. analyzing
fragmentation, location etc.). Knowing a page is being used for a kernel
stack gives us more insight about pages that are certainly immovable and
important to kernel functionality.

Add a new pagetype, and tag pages alongside the kernel stack accounting.
Also, ensure the type is dumped to /proc/kpageflags and the page-types
tool can find it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/proc/page.c                         |  3 ++-
 include/linux/page-flags.h             |  5 +++++
 include/uapi/linux/kernel-page-flags.h |  1 +
 kernel/fork.c                          | 19 +++++++++++++++++--
 tools/mm/page-types.c                  |  1 +
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 771e0b6bc630..46be207c5a02 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -201,7 +201,8 @@ u64 stable_page_flags(const struct page *page)
 
 	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
 		u |= 1 << KPF_BUDDY;
-
+	if (folio_test_stack(folio))
+		u |= 1 << KPF_KSTACK;
 	if (folio_test_offline(folio))
 		u |= 1 << KPF_OFFLINE;
 	if (folio_test_pgtable(folio))
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d53a86e68c89..5ee6ffbdbf83 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -933,6 +933,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_kstack		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -995,6 +996,10 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
 	page->page_type = UINT_MAX;					\
 }
 
+/* PageStack() indicates that a page is used by kernel stacks.
+ */
+PAGE_TYPE_OPS(Stack, kstack, stack)
+
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
  * (see mm/page_alloc.c).
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index ff8032227876..56175b497ace 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,6 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_PGTABLE		26
+#define KPF_KSTACK		27
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 5115be549234..c8a6e1495acf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -440,15 +440,22 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		struct vm_struct *vm_area = task_stack_vm_area(tsk);
 		int i;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 			mod_lruvec_page_state(vm_area->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
+			__SetPageStack(vm_area->pages[i]);
+		}
 	} else {
 		void *stack = task_stack_page(tsk);
+		struct page *page = virt_to_head_page(stack);
+		int i;
 
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
+			__SetPageStack(page);
 	}
 }
 
@@ -461,8 +468,16 @@ void exit_task_stack_account(struct task_struct *tsk)
 		int i;
 
 		vm_area = task_stack_vm_area(tsk);
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 			memcg_kmem_uncharge_page(vm_area->pages[i], 0);
+			__ClearPageStack(vm_area->pages[i]);
+		}
+	} else {
+		struct page *page = virt_to_head_page(task_stack_page(tsk));
+		int i;
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
+			__ClearPageStack(page);
 	}
 }
 
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index d7e5e8902af8..4031fdbad3e7 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -127,6 +127,7 @@ static const char * const page_flag_names[] = {
 	[KPF_PGTABLE]		= "g:pgtable",
 	[KPF_ZERO_PAGE]		= "z:zero_page",
 	[KPF_IDLE]              = "i:idle_page",
+	[KPF_KSTACK]		= "k:kernel_stack",
 
 	[KPF_RESERVED]		= "r:reserved",
 	[KPF_MLOCKED]		= "m:mlocked",
-- 
2.50.1



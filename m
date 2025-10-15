Return-Path: <linux-kernel+bounces-855094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC7BE0357
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A71F4FB0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD02298CD7;
	Wed, 15 Oct 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+G6nPHc"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460A325495
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553419; cv=none; b=MbWD3jytZpDc6JXXLycLOB7tcf3burO7NLzRpooul/41elGRIUAJMl4gaqQxCkYP9wQWauzrJW7ewaydN9qOHEWL8PB5kngfzzntGsFMsCja28z/kRS52DEZTPaW/1z/lugiQ5mIkLJY8Omv2icKEOBLt5IMrJpfysd2MpkO0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553419; c=relaxed/simple;
	bh=HB6Vqw+7ydLWXhhSbVTw/E6GHFLSYol5gBxI60dhSzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRcr8LSDU30JgmnrH9KBpyw+/b1szqJ19OX7ds/qZ4zi+laRgpD+aulOD5fozTXNFoevKe4BsoCIAMxP2niQF5zWoMiIbh6L6fz0IFQ2JEo8wxI6WptdcjtzAvHDs/BcwKVXn85X8wKgzi6/MvS7nyCiiGZRhsAivKWPvqW9kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+G6nPHc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55118e2d01so8541732a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760553417; x=1761158217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKpGbUmSzOj72WrP0EnxSLypc0IcqdMmnVFCtJZuxlU=;
        b=o+G6nPHcjcWWadM3g5SS3Cqv66ZKbivDPfTj0kdazFzaRry8B0WiGhpO++wmhEkbKn
         9CMnGbOlAQCAJMeHKTk8HcI5gBdJ64ZEEbmKOa7OxfnVtQjhApcKgDVq5c3aOMHtMn8B
         lvP42SqCjcjIn/BRSWw3k9S4tt+wolYehvq61YR6JPVKCeT5oqF+wMfozywBUwjM7TGB
         C1tp92JHFVa/sovUQr2CjwHvoltE3t7Wa2YHNi+LRM4+inkv01RqW0bo3VgZZ2GQMNFt
         YfSvocudUk5ksmWRER2UKl/OtldTw/JRR95V3HZMq7xUbtnMg6Khv+waL52j2hM3Gjen
         J9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553417; x=1761158217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKpGbUmSzOj72WrP0EnxSLypc0IcqdMmnVFCtJZuxlU=;
        b=n6EiBCOuEOc9n5mizq3BrIt8bWMQl2k7Sds68aV7L50W7vK+FCyWjtrEAjYqylzwEj
         ZAZhsx9Le1+ttztKv+3yEEtU96nu40pOZw/7IynCbbuMQXL74QeOmjXr1iAInIAAyH1V
         Lc3P6wW/LySFFn7DK83sJeQXij5qd8DaEhSSiSqAeYz5t53PYkSSIi2plpHrYNsktQIp
         gxPIYLwa3+GD/k3z2AtgMdlVdx5jXMG22mC6E75MX1ZnGlG8Y50TahWhQqESWS6mE7vb
         cq1dYRijykCfKqb2LqNQ/3ASnBF4eGSmMlBXoVKwB9ODnRb+s/YOybQtbaKhHvH781pd
         eDLA==
X-Forwarded-Encrypted: i=1; AJvYcCUNhjx5XYIfXF6cNR91eOAhbztyCdG+lFV32bTFUqzK7a1uHnxs/0ci4GCRjQlO+QZD2rPlMe2a+dZ81fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXP13dKK5wZEbeijcu+6A8yWJV3qy0VKKUa6xqq7I4SpGGwAQ
	JUy7dTP+C/xyCRyKU3UmFCbT/OyafD10yGmP9wZyQeabe5sCFSghhb1JxrnHWnKP3c5DYpp3PH4
	7rEjQ1A==
X-Google-Smtp-Source: AGHT+IEYhWHuql5g9/FhU8JjSG5gGZZVyTNmxSEqKWgRSuyQCnr845g5xH8NjCRtjZ4IdBmCOokrTClIDdk=
X-Received: from pjg7.prod.google.com ([2002:a17:90b:3f47:b0:330:7dd8:2dc2])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8b:b0:2b1:c9dc:6db1
 with SMTP id adf61e73a8af0-32da813457bmr38309016637.12.1760553417387; Wed, 15
 Oct 2025 11:36:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:35:52 +0000
In-Reply-To: <cover.1760551864.git.wyihan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760551864.git.wyihan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH 1/3] mm: memory_failure: Fix MF_DELAYED handling on
 truncation during failure
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.or, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"

The .error_remove_folio a_ops is used by different filesystems to handle
folio truncation upon discovery of a memory failure in the memory
associated with the given folio.

Currently, MF_DELAYED is treated as an error, causing "Failed to punch
page" to be written to the console. MF_DELAYED is then relayed to the
caller of truncat_error_folio() as MF_FAILED. This further causes
memory_failure() to return -EBUSY, which then always causes a SIGBUS.

This is also implies that regardless of whether the thread's memory
corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
memory failure within guest_memfd memory will always cause a SIGBUS.

Update truncate_error_folio() to return MF_DELAYED to the caller if the
.error_remove_folio() callback reports MF_DELAYED.

Generalize the comment: MF_DELAYED means memory failure was handled and
some other part of memory failure will be handled later (e.g. a next
access will result in the process being killed). Specifically for
guest_memfd, a next access by the guest will result in an error returned
to the userspace VMM.

With delayed handling, the filemap continues to hold refcounts on the
folio. Hence, take that into account when checking for extra refcounts
in me_pagecache_clean(). This is aligned with the implementation in
me_swapcache_dirty(), where, if a folio is still in the swap cache,
extra_pins is set to true.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index df6ee59527dd..77f665c16a73 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -922,9 +922,11 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
  * by the m-f() handler immediately.
  *
  * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
- * The page is unmapped, and is removed from the LRU or file mapping.
- * An attempt to access the page again will trigger page fault and the
- * PF handler will kill the process.
+ * It means memory_failure was handled (e.g. removed from file mapping or the
+ * LRU) and some other part of memory failure will be handled later (e.g. a
+ * next access will result in the process being killed). Specifically for
+ * guest_memfd, a next access by the guest will result in an error returned to
+ * the userspace VMM.
  *
  * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
  * The page has been completely isolated, that is, unmapped, taken out of
@@ -999,6 +1001,9 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 	if (mapping->a_ops->error_remove_folio) {
 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
+		if (err == MF_DELAYED)
+			return err;
+
 		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		else if (!filemap_release_folio(folio, GFP_NOIO))
@@ -1108,18 +1113,19 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
-	/*
-	 * The shmem page is kept in page cache instead of truncating
-	 * so is expected to have an extra refcount after error-handling.
-	 */
-	extra_pins = shmem_mapping(mapping);
-
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
 	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
+
+	/*
+	 * The shmem page, or any page with MF_DELAYED error handling, is kept in
+	 * page cache instead of truncating, so is expected to have an extra
+	 * refcount after error-handling.
+	 */
+	extra_pins = shmem_mapping(mapping) || ret == MF_DELAYED;
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
-- 
2.51.0.788.g6d19910ace-goog



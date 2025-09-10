Return-Path: <linux-kernel+bounces-810524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB774B51BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF47545D04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E712322DCD;
	Wed, 10 Sep 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhQLMmvm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77809327A3A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518496; cv=none; b=f4NrjabjfteL9CJiO64K6H234oYnG3RiZM5m1c6FyuQSr4IgaJt9GAc63NS3SrRrjCx7un5U4JpiunUl7YGOyAM5bmvzEmUcaW34i9xSZmB8mwnw1B7WAw/FQlo0md1bJb8JRoN3odRNdZ2vpS4ANjK7lo/8MY2DU0fuAEhTJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518496; c=relaxed/simple;
	bh=ylywEWdpuWY9ksOD7npdckXIkyDG0CoNTtEKj9xRWlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSZaLVzvPUdDe/pyzlH1cG4CBDAhtki5IaAsh+DkBxPccshOv/TM5ZRRNtqC8tXSXdFhF/QlIfuYgjllwB+wm4SrIlqmUGoFYg0OTmuuufEpoNtTDTIkZdg7E9YIRpomcGwpGdBrsKMFbzG7gru+46MAqgODHISWfZkkU3W4f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhQLMmvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A1C4CEEB;
	Wed, 10 Sep 2025 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518496;
	bh=ylywEWdpuWY9ksOD7npdckXIkyDG0CoNTtEKj9xRWlw=;
	h=From:To:Cc:Subject:Date:From;
	b=rhQLMmvm6dRoXeNpFCfCLVpoY7KvfC8BQX1DDVQqPnV+bvyH28j+DR3zV5mNbG15k
	 qII2i91velnS0+nJmr0iQjTnd1tzaXScjDorFCIqvs0rH/xxjofCBUdJWiHvW4F+G6
	 ugswwcbJzFRZGRl2CqG1tCXrMAenb8EFyarnsSanweQl1BsoXWnzlZ/+Pac0y+5Kdl
	 wHduKm9o9OU3V/y5/Cuv7Wh1LpDiBF7l3vJPhld6lR4lX2gTvzJhWWoTcgnVQr3dD/
	 SpRiF5H8Shzux16IcqivEpu60ih9iK6IJKRCPO/N1gpPtAz/wIT8YFOZ01/9O4SnXb
	 F5ocWTAWcmZKw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: make sure folio being restored is actually from KHO
Date: Wed, 10 Sep 2025 17:34:40 +0200
Message-ID: <20250910153443.95049-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When restoring a folio using kho_restore_folio(), no sanity checks are
done to make sure the folio actually came from a kexec handover. The
caller is trusted to pass in the right address. If the caller has a bug
and passes in a wrong address, an in-use folio might be "restored" and
returned, causing all sorts of memory corruption.

Harden the folio restore logic by stashing in a magic number in
page->private along with the folio order. If the magic number does not
match, the folio won't be touched. page->private is an unsigned long.
The union kho_page_info splits it into two parts, with one holding the
order and the other holding the magic number.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..68eb3c28abe41 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -32,6 +32,22 @@
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
 
+#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
+
+/*
+ * KHO uses page->private, which is an unsigned long, to store page metadata.
+ * Use it to store both the magic and the order.
+ */
+union kho_page_info {
+	unsigned long page_private;
+	struct {
+		unsigned int order;
+		unsigned int magic;
+	};
+};
+
+static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
+
 static bool kho_enable __ro_after_init;
 
 bool kho_is_enabled(void)
@@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned long order;
+	union kho_page_info info;
 
 	if (!page)
 		return NULL;
 
-	order = page->private;
-	if (order > MAX_PAGE_ORDER)
+	info.page_private = page->private;
+	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
 		return NULL;
 
-	kho_restore_page(page, order);
+	kho_restore_page(page, info.order);
 	return page_folio(page);
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
@@ -341,10 +357,13 @@ static void __init deserialize_bitmap(unsigned int order,
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
 		struct page *page = phys_to_page(phys);
+		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
 		memblock_reserved_mark_noinit(phys, sz);
-		page->private = order;
+		info.magic = KHO_PAGE_MAGIC;
+		info.order = order;
+		page->private = info.page_private;
 	}
 }
 

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.47.3



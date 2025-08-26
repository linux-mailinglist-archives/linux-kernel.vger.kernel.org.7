Return-Path: <linux-kernel+bounces-786127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D36B3555B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46791B20818
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E432D0C63;
	Tue, 26 Aug 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdgKK5NM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C42F6594
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192792; cv=none; b=KUCxlFSQEABkZxaWpmCQdd4Y4VHX2xODBA3zxqcchZs2VYzbOiJn0T3F72jrZsnj119blhdTShgIuY7Gk9ZKfLN1WmLOQmR0qUJ9wm7b27ATZRFw7wcLLlsMFh2Dah4ho9fnGjz59AR76dXtUPKAfkvADZwFxEq0LftCQE1P23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192792; c=relaxed/simple;
	bh=+PZJcpckpQZWq32DLv7x5km52DGDqx/XmxaGBNY8ZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBzqTb4sA0Fgh/XInxFdIDyxrlfUx9BuWo8KYc5JuUNcVvFn4OpYbUf+rn8eq+numgiEb1an/9NVT/JuVNtRk+dxU9gpg9dHyU4uZ6wF+qh2tyzKiYLjbwom3D32L/78mUW8I7wYFiEVc+ISEcUfVjx4ngrv5N0EbSC9zYTTkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdgKK5NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C343AC4CEF1;
	Tue, 26 Aug 2025 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192792;
	bh=+PZJcpckpQZWq32DLv7x5km52DGDqx/XmxaGBNY8ZqU=;
	h=From:To:Cc:Subject:Date:From;
	b=sdgKK5NM1tDNEgsXTnvq26XugvjucYJ4kit5xOKN5Wgc6IfvlszRa9kW/Xm7LZp+z
	 LQxaOCLPZ2w8VapMKHiCS5KgiTdoEg/i0dvwuLrugGUrkQiMjcFrJCS41a7/dOdr+6
	 B2pWCbGoPveA9UmX1RheYgCyXtac850SQ1beWjkinM+m3x6Nd9ll8qQfTYzcXHpSWH
	 1J8scG50xjhxtgfxf3oESRFjWKdUeexMU20z4ZcW9yjlKb86572kU4Zpv9XFiIqdT4
	 g5wOD3VYOj97N0VjdfQK0coteGLeU2+/lhfhEdGFuHKNFX2nraAaMrtuvR9Ko3yO3o
	 qtOZzpNkIVjfw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memblock: fix kernel-doc for MEMBLOCK_RSRV_NOINIT
Date: Tue, 26 Aug 2025 10:19:46 +0300
Message-ID: <20250826071947.1949725-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The kernel-doc description of MEMBLOCK_RSRV_NOINIT and
memblock_reserved_mark_noinit() do not accurately describe their
functionality.

Expand their kernel doc to make it clear that the user of
MEMBLOCK_RSRV_NOINIT is responsible to properly initialize the struct pages
for such regions and add more details about effects of using this flag.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h |  5 +++--
 mm/memblock.c            | 15 +++++++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b96746376e17..fcda8481de9a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,8 +40,9 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
- * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
- * not initialized (only for reserved regions).
+ * @MEMBLOCK_RSRV_NOINIT: reserved memory region for which struct pages are not
+ * fully initialized. Users of this flag are responsible to properly initialize
+ * struct pages of this region
  * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
  * either explictitly with memblock_reserve_kern() or via memblock
  * allocation APIs. All memblock allocations set this flag.
diff --git a/mm/memblock.c b/mm/memblock.c
index 154f1d73b61f..46b411fb3630 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1091,13 +1091,20 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 
 /**
  * memblock_reserved_mark_noinit - Mark a reserved memory region with flag
- * MEMBLOCK_RSRV_NOINIT which results in the struct pages not being initialized
- * for this region.
+ * MEMBLOCK_RSRV_NOINIT
+ *
  * @base: the base phys addr of the region
  * @size: the size of the region
  *
- * struct pages will not be initialized for reserved memory regions marked with
- * %MEMBLOCK_RSRV_NOINIT.
+ * The struct pages for the reserved regions marked %MEMBLOCK_RSRV_NOINIT will
+ * not be fully initialized to allow the caller optimize their initialization.
+ *
+ * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, setting this flag
+ * completely bypasses the initialization of struct pages for such region.
+ *
+ * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, struct pages in this
+ * region will be initialized with default values but won't be marked as
+ * reserved.
  *
  * Return: 0 on success, -errno on failure.
  */
-- 
2.50.1



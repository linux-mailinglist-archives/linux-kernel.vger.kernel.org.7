Return-Path: <linux-kernel+bounces-883480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE71C2D8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E54EE5FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EC314B86;
	Mon,  3 Nov 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP85rxHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05452882A9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192963; cv=none; b=h4HvomWBprY0nMCIDYibi2xUDLJnfBtDHzjTA4FWshGI8Fxd9Uo/hTcoTBLg3NBJhJRgUU/RL1adUruVsXQK0d+5IWae+WhuUMhBBwnSC9tMAQqOsjgqdX8UGMTxce+dFH/rXGctPBmMenEw4selIzMHBc/Jw83+8CA3MFv0Edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192963; c=relaxed/simple;
	bh=BW3nIFF3ejh4ARubY8O9vgvGP+ux/Zl54hpiB5TaeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOHDCav6g/Onccw698jInpB5SUFEK7PH17dH1ukoFxhdo+yCJr/guZkUgopk8yRGMMeoPF9jkE81Zc2de3lTqmPgskrV/GvNt+dO89hrwq3e//efM5t1p1oq7gzMR1xijUidtU7o/vtyXWh2nZRNy66mNLIAAtgezObOh1brM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP85rxHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FBBC16AAE;
	Mon,  3 Nov 2025 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192963;
	bh=BW3nIFF3ejh4ARubY8O9vgvGP+ux/Zl54hpiB5TaeKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP85rxHj43C1QmClK8ydP/bgZqswAFc42oKCQ54TrICWgUj7GK2OkmKpGHZLFDuuv
	 14CnmrqrWsbN0Tc2NEsq4z4VD1Smh+jmRndB98xJzaJ6Hrqaq3a2QBhNTBQC0vbi2d
	 9KCzSphtvVWw5jHiwPGcYSxyw9awUJOT/B9B4ruG98mvH8AW6c03H7qnUZGiPc+YsJ
	 K5Uw1ebrjxDlVFP5DYUcL5niMxwv5foGeTmX3JjUh+7YKh06RG1SbV75BqgHSvdX7P
	 o2JO+UpEXblcyaVwJdlve7y55XjhQER/XqgbzXiSDlx9hmbknSJSiEh7O/750ReEi7
	 +rrOUX2DFlXIQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kho: fix unpreservation of higher-order vmalloc preservations
Date: Mon,  3 Nov 2025 19:02:31 +0100
Message-ID: <20251103180235.71409-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kho_vmalloc_unpreserve_chunk() calls __kho_unpreserve() with end_pfn as
pfn + 1. This happens to work for 0-order pages, but leaks higher order
pages.

For example, say order 2 pages back the allocation. During preservation,
they get preserved in the order 2 bitmaps, but
kho_vmalloc_unpreserve_chunk() would try to unpreserve them from the
order 0 bitmaps, which should not have these bits set anyway, leaving
the order 2 bitmaps untouched. This results in the pages being carried
over to the next kernel. Nothing will free those pages in the next boot,
leaking them.

Fix this by taking the order into account when calculating the end PFN
for __kho_unpreserve().

Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    When Pasha's patch [0] to add kho_unpreserve_pages() is merged, maybe it
    would be a better idea to use kho_unpreserve_pages() here? But that is
    something for later I suppose.
    
    [0] https://lore.kernel.org/linux-mm/20251101142325.1326536-4-pasha.tatashin@soleen.com/

 kernel/kexec_handover.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index cc5aaa738bc50..c2bcbb10918ce 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -862,7 +862,8 @@ static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur
 	return NULL;
 }
 
-static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
+static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
+					 unsigned short order)
 {
 	struct kho_mem_track *track = &kho_out.ser.track;
 	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
@@ -871,7 +872,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
 
 	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 		pfn = PHYS_PFN(chunk->phys[i]);
-		__kho_unpreserve(track, pfn, pfn + 1);
+		__kho_unpreserve(track, pfn, pfn + (1 << order));
 	}
 }
 
@@ -882,7 +883,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
 	while (chunk) {
 		struct kho_vmalloc_chunk *tmp = chunk;
 
-		kho_vmalloc_unpreserve_chunk(chunk);
+		kho_vmalloc_unpreserve_chunk(chunk, kho_vmalloc->order);
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 		free_page((unsigned long)tmp);
-- 
2.47.3



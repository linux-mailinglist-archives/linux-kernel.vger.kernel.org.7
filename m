Return-Path: <linux-kernel+bounces-882715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A953CC2B37D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD783A625A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D23002A6;
	Mon,  3 Nov 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq8xyZaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597263009E4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167729; cv=none; b=nPKBIAxYYF+UcA9F1dK6rSVbje6wO6gnajxkgpNhUB1Ju+LbalPdXPULjrgxWCimhLrGN5r0kBVfgpt5aBeYpfmgNGEhQRGwlUTqTjmSJ4wIHhNSCryFuDI3N4SPvZzG1WPtBJYVkbM1oeX8S/gwRLWiASBGM3GQ1gh1uiQ/WLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167729; c=relaxed/simple;
	bh=dBEGE7Q2FKfgjAlIXnLQQ3kv27gx1kpdPQtSwVZaBLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEH5wfRYxRob1DG02B8oRYYkMYOfh1WCAEvUMxgQIXAslA/9XClumz1hsRDanwQS1fGTw8GDOv8bnokMyAMRTQFZwo+fkADm4dvTIJ5OmVMf3uR9Ydagb+I7dYS5llZVURlrv9vdiDGRfrkjOv2onCZjFW8Cr0h+M4r9FOQVDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq8xyZaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AAC4CEE7;
	Mon,  3 Nov 2025 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762167727;
	bh=dBEGE7Q2FKfgjAlIXnLQQ3kv27gx1kpdPQtSwVZaBLg=;
	h=From:To:Cc:Subject:Date:From;
	b=Zq8xyZaPRCiSAPW57VhpsgAiTBwBqP6XkDgxOvn5vZzA1sYnqgh0RK5mD5wnjGYGK
	 Hu0MC0hbd6ILJ24QPsYjK8AvwJlo6q3ygStghGvD32c6OmXG8C5HjncIMB9PZpxato
	 J4d2LnumJHSpZbzkzdQ0c+4R7sixgMQU/dRonIMHaL5Em2sFwnlppVzwgrIZhsXuG3
	 Og0dec424Y3aGwlYl0f+1ns2Q6LnPqADoaWiu6OjG0zo0fVswYDtBIWirBCBfuYtW2
	 Ex22L8WzhNXm3fHjLOWEViWi8YdGBaF1JvcxixiNfx8swlRvyHsquMloLFfUCHjitS
	 seAV/qWGeefQg==
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
Subject: [PATCH] kho: fix out-of-bounds access of vmalloc chunk
Date: Mon,  3 Nov 2025 12:01:57 +0100
Message-ID: <20251103110159.8399-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of pages in a vmalloc chunk is NULL-terminated. So when looping
through the pages in a vmalloc chunk, both kho_restore_vmalloc() and
kho_vmalloc_unpreserve_chunk() rightly make sure to stop when
encountering a NULL page. But when the chunk is full, the loops do not
stop and go past the bounds of chunk->phys, resulting in out-of-bounds
memory access, and possibly the restoration or unpreservation of an
invalid page.

Fix this by making sure the processing of chunk stops at the end of the
array.

Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Commit 89a3ecca49ee8 ("kho: make sure page being restored is actually
    from KHO") was quite helpful in catching this since kho_restore_page()
    errored out due to missing magic number, instead of "restoring" a random
    page and causing errors at other random places.

 kernel/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb4856..cc5aaa738bc50 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -869,7 +869,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
 
 	__kho_unpreserve(track, pfn, pfn + 1);
 
-	for (int i = 0; chunk->phys[i]; i++) {
+	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 		pfn = PHYS_PFN(chunk->phys[i]);
 		__kho_unpreserve(track, pfn, pfn + 1);
 	}
@@ -992,7 +992,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	while (chunk) {
 		struct page *page;
 
-		for (int i = 0; chunk->phys[i]; i++) {
+		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
 			phys_addr_t phys = chunk->phys[i];
 
 			if (idx + contig_pages > total_pages)

base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.47.3



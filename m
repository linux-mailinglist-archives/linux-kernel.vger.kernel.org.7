Return-Path: <linux-kernel+bounces-823336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE4B8625B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6851CC0FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9E3128B8;
	Thu, 18 Sep 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kddnwzKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BC30F958
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215182; cv=none; b=q0fdO7CLjbBSZFTrKtDpQw81S2eA+Otc77k/1t/0+pK0PxPo3B+VE/g3ufMB6MVvLlHE1daha9zbE98Ur+VUUkQvMxW9qRUemwXD+sjjtG2ZtP58kUmLjJbGcxnjxNlvJKFr5ZmY8nC81QK2zmRjDBchI75UkwOWfSoeCTIxeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215182; c=relaxed/simple;
	bh=HucGv7/mPLt2Tx4zSzeFM4REnUTmnwAtJbV9JCXao8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnfI5NzCkedoOcsh56j94fDrFk2CkKVOacAD/hS8MOHBK7B87Wup067ecIA/QYw5gaA26b35I7NRKDVyPjZn/dkQBiaZJkmDm4lWdAdLgPJXhISGgap8D3WmhniczsKbscBY0baK5DEFOpI+lKjzM3EgV8FQPF7qe8NMv4rTs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kddnwzKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2EC4CEE7;
	Thu, 18 Sep 2025 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215181;
	bh=HucGv7/mPLt2Tx4zSzeFM4REnUTmnwAtJbV9JCXao8E=;
	h=From:To:Cc:Subject:Date:From;
	b=kddnwzKmWI6C4Iu4GwObwD7eXUpHqQYaFf7UiiYU4177NZNU04zwGvlNXcj+sq5X3
	 uA7hgyoOmSazGv3banrkOt/qWABfc7CLpjL/7U347ksm1J7Ud28eJBOwjRf5eatN9y
	 7wJaZCFymw0VBIn/f+SyZFIIc/MTsxN41PtvW9iY9H8LEgkHjxdkGcj66K6IPyjLRx
	 HbWRLZlb1MIzKWrSWDZnw2deKMmyfjgXNMNH+rIKt8LBbyJYTnPiKcii6GrH6/qAJE
	 SP18i3039/LM6CD6gCk+g1VHd6vYur7zsOcnTX1m8ZszHjw5f4D9Not7u7Z3sFRbR9
	 D75747c3a/Rqg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: only fill kimage if KHO is finalized
Date: Thu, 18 Sep 2025 19:06:15 +0200
Message-ID: <20250918170617.91413-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kho_fill_kimage() only checks for KHO being enabled before filling in
the FDT to the image. KHO being enabled does not mean that the kernel
has data to hand over. That happens when KHO is finalized.

When a kexec is done with KHO enabled but not finalized, the FDT page is
allocated but not initialized. FDT initialization happens after
finalize. This means the KHO segment is filled in but the FDT contains
garbage data.

This leads to the below error messages in the next kernel:

    [    0.000000] KHO: setup: handover FDT (0x10116b000) is invalid: -9
    [    0.000000] KHO: disabling KHO revival: -22

There is no problem in practice, and the next kernel boots and works
fine. But this still leads to misleading error messages and garbage
being handed over.

Only fill in KHO segment when KHO is finalized. When KHO is not enabled,
the debugfs interface is not created and there is no way to finalize it
anyway. So the check for kho_enable is not needed, and kho_out.finalize
alone is enough.

Fixes: 3bdecc3c93f9f ("kexec: add KHO support to kexec file loads")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8079fc4b9189..5ff959a90165 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1242,7 +1242,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_enable)
+	if (!kho_out.finalized)
 		return 0;
 
 	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
-- 
2.47.3



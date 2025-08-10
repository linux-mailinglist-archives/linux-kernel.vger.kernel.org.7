Return-Path: <linux-kernel+bounces-761533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0BB1FB7E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F9A3AE30A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F432727F0;
	Sun, 10 Aug 2025 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="qsvkyIZp"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7B25B30D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848337; cv=none; b=vGnYrMbxUCIopI9ja6Rqb5//bCHnocLjQP2A5SxGGiFDbwLo0TrhFNia/KFaZwX8fH2+Fjtw4ubQd0bXpvAv2sagqhE3fUDeknek4dgIrtBcPHs+HilQ1geC3GQQCr56vZr5tE/DFeUSrC+y+JJX0r8VA4Bxgh2or1hm7V5Qj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848337; c=relaxed/simple;
	bh=/AEyR74Z1Ij5U5ah5UGLYz23mjRlu/GGeINpMHY5pW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u/eDfTjhzrWxorqHzpv4U5g5ENXjAF/aJRQ+a5DRVEuLwuM+V4VfY3pd4xR0gpJdzy+A5LWU+P0rel4nFTPwbyMWuy0xmNPfBQQKlEtNeWQoxpttQZXMQlYcg0k3DJby2V7sYPNtbw7/vRJMbBYyfBcyWkZkb0C1/LTsKAdi/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=qsvkyIZp; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 6940F104C1F1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:06 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 6940F104C1F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754848326; bh=/AEyR74Z1Ij5U5ah5UGLYz23mjRlu/GGeINpMHY5pW0=;
	h=Date:From:To:Cc:Subject:From;
	b=qsvkyIZpjPKuHEO9rKOke+0TW/l0TGCQyH8C+x/ZuKckirvoLFXWGsBj1+uxX+8yO
	 EYBSIYSq23gqSvi0d7Aao49v9YnlQ46YKcFqdSfpjU3VThu7ac2e+Tb0Ub6GloPIri
	 gbWfufLMaR/jVGGqLJ1zVpnEITN0d4zG1tXKysZY=
Received: (qmail 19730 invoked by uid 510); 10 Aug 2025 23:22:06 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.133356 secs; 10 Aug 2025 23:22:06 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 10 Aug 2025 23:22:04 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 9D60F360081;
	Sun, 10 Aug 2025 23:22:03 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 65E0F1E812F4;
	Sun, 10 Aug 2025 23:22:03 +0530 (IST)
Date: Sun, 10 Aug 2025 23:21:58 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jgg@ziepe.ca, leon@kernel.org, akhilesh@ee.iitb.ac.in,
	michaelgur@nvidia.com, ohartoov@nvidia.com, shayd@nvidia.com,
	dskmtsd@gmail.com, hch@infradead.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] RDMA/core: fix memory alloc/free for pfn_list
Message-ID: <aJjcPjL1BVh8QrMN@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure memory allocated for umem_odp->map->pfn_list using kvcalloc()
is freed using corresponding kvfree() to avoid potential memory
corruption. Match memory allocation and free routines kvcalloc -> kvfree

Fixes: 259e9bd07c57 ("RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/infiniband/core/umem_odp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b1c44ec1a3f3..572a91a62a7b 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -115,7 +115,7 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 out_free_map:
 	if (ib_uses_virt_dma(dev))
-		kfree(map->pfn_list);
+		kvfree(map->pfn_list);
 	else
 		hmm_dma_map_free(dev->dma_device, map);
 	return ret;
@@ -287,7 +287,7 @@ static void ib_umem_odp_free(struct ib_umem_odp *umem_odp)
 	mutex_unlock(&umem_odp->umem_mutex);
 	mmu_interval_notifier_remove(&umem_odp->notifier);
 	if (ib_uses_virt_dma(dev))
-		kfree(umem_odp->map.pfn_list);
+		kvfree(umem_odp->map.pfn_list);
 	else
 		hmm_dma_map_free(dev->dma_device, &umem_odp->map);
 }
-- 
2.34.1



Return-Path: <linux-kernel+bounces-761443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF962B1FA21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E3BAF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59302580CA;
	Sun, 10 Aug 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="uKEzDTD5"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5282550DD
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754832863; cv=none; b=IBYgWp5wAOui0gy36IBb7emQOK1V92+VY+/b2l75NuxvLakM4CThr5I/kaMXvsmPnhOwuziQk/pHc38n2QQQKtXhxGdnjqZnPh+alIYficlo+hEqMTaU46G67Q/6C1XR8yhlykOrfu3w3JeZQHCK5JJ+yvCxWK3tSIumMAIHddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754832863; c=relaxed/simple;
	bh=Qd98IcXForaGHqWydw1PQXOwfE0+jt60T1QofX//ck0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oLKXnGUSvcY+BS9ZEmMrntXiI5Tu5JgLMI7CSqrw0xPWLgiDitaz6zoHZfPex025H/ITzdf3DE0H0yC9ktDSN/8f1sG+lh+3Oi2iCdF6nqDjBz5YWXBBEqrAviWSTHTW3qjOH0PO6jMuXU3pAC7fUMWtt+o7t4lV75YGn17Xmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=uKEzDTD5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 0D2C8104D0D6
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 19:04:10 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 0D2C8104D0D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754832850; bh=Qd98IcXForaGHqWydw1PQXOwfE0+jt60T1QofX//ck0=;
	h=Date:From:To:Cc:Subject:From;
	b=uKEzDTD5W/4LA9UiT3MOyOY2rvaVgxsh5k/xC0ZKFsp/3WghSLCmIvWU/2RjpKK/J
	 xIQwSMq7YwwTQ5ljwI9ObSEPSGNtlqyJW/kWgvUv4BPKuUchDuNOZPu/eNFGf3Y1p8
	 Sn0PpFxbC7yl/r/dkQqiChbI8JbVQuRgFWuhFOu4=
Received: (qmail 13254 invoked by uid 510); 10 Aug 2025 19:04:09 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.12802 secs; 10 Aug 2025 19:04:09 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 10 Aug 2025 19:04:07 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 06EFA360082;
	Sun, 10 Aug 2025 19:04:07 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id C26CB1E812DF;
	Sun, 10 Aug 2025 19:04:06 +0530 (IST)
Date: Sun, 10 Aug 2025 19:04:01 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, praan@google.com, baolu.lu@linux.intel.com,
	nicolinc@nvidia.com, jgg@nvidia.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] iommufd: viommu: free memory allocated by kvcalloc() using
 kvfree()
Message-ID: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
Ensure the memory is properly freed, as kvcalloc may internally use
vmalloc or kmalloc depending on available memory in the system.

Fixes: 2238ddc2b056 ("iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/iommu/iommufd/viommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2ca5809b238b..462b457ffd0c 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -339,7 +339,7 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	}
 
 	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
-	kfree(pages);
+	kvfree(pages);
 	return access;
 
 out_unpin:
@@ -349,7 +349,7 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 out_destroy:
 	iommufd_access_destroy_internal(viommu->ictx, access);
 out_free:
-	kfree(pages);
+	kvfree(pages);
 	return ERR_PTR(rc);
 }
 
-- 
2.34.1



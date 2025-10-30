Return-Path: <linux-kernel+bounces-878103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8DC1FCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E13B47F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5D33F360;
	Thu, 30 Oct 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h8a3X963"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B62E6CC8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823230; cv=none; b=MFASfUsLTHLs7t7lZ8GnF9ULQq0uDzGeD7NhlxK0WYg+PUL3SXy+hilHUWLZdyB+CVaGJBqzaNlMvH4iwQg2RaGZtkRApSTeXSODAjntIbSw6XLmGv0E7sTiNvt5xpmVo+QIIm7AQuygHDLm3/UyAdRllsj7Wqd0iY1yZvFuRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823230; c=relaxed/simple;
	bh=UMgHCQUu8cOFMbnecxRXWBDMtD529aws4Ow+KFvMMrU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dNdk5Y5DQCodDgTs5VMoOUtBiVAFy8VLla3czXBr1hI6Ux7P1reN5ErhfA2Ut2lGxRjIQgUteAvlOqdNgL5TqEeII/pNcVRoJxclFYFktV8a4z99yL9wLnsF9iyQ7DF5d3PIroPRIM7L8P+AO+C/Z02Hyig4rbTRGkk35nAkvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h8a3X963; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1030468b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761823228; x=1762428028; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jBUXjI+VAuZkH4C/pJW07Y7+zKzm2v+t+cHIswPHfk=;
        b=h8a3X963C6Mcl5XIwQoF5UHlxjtI4k/5wtxzqieQslBNE6aTqVzRcW8dwflRztDK35
         R9qZ6JlmODiyqTTgynox8Qdw+RTxtQzGlHcbjHfXMySJe7EOUtuED7gs8OQgyVpUa1W5
         X51YDl1bMCJdk8O2kht45Hn7tOExOxT6uiSAiAzr3Dc2Uw3u8wdvy3WgHth4iqJhvGTb
         c6BPMMCP3hg327BHZ6LahTZq+gEjniSswaxEZZgqE+0HYzX/h6yeulodxhcwW5dfmWFe
         8Sule4v9lGbyjS9h46C8OUnzTHclwj+xnXNTjorNHS+xttl92HRKFYJC/tpoL2mcchuR
         I5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823228; x=1762428028;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jBUXjI+VAuZkH4C/pJW07Y7+zKzm2v+t+cHIswPHfk=;
        b=eMt8ay3O9I2L0b1Es8ffoa7nVo9GUe6AhBCdh5qru3OJym18w1haRNxnq6zkGEqQyc
         u4j6WElX7CjGSWMiZqikr9xEdWfBDmZAKupBekFDpvpG9/moVKgJnsHhy4GbTmqg6D0O
         NUhS5FAForILilTQCz+OMPpCI5FqhsIrD6fLx69d7dVniYr3JZ5MqiTNSEMetZlZv8N2
         /yW7uWPe2/iAoE7uLBVzrEqMSyNMpqSB7RXDu9ShsO6v9U9YgNOOpAS7fkU0pOPBFest
         /uNC/7luq7PYFq1wv19K0lpJKfaGndUPVIaE8+0JNo6QJCNp6VrJ6/BHeA/zB9ZRGpNx
         yChg==
X-Gm-Message-State: AOJu0Ywk8SGP028MRh8NaP+BWT6Gjtpto7NgEYqiwaP/D+gIRPysQwdn
	lXa4IDYDdcZFkdOSP2DI0Med+gxv1Z6/xN29Ip4/zLgGZ6mS1M+YgrbYJeWM8CNVe8k=
X-Gm-Gg: ASbGnctD/yktNEh/wrs5E20ZhEjwjiPC7FWcqyEof39Rkc1RxrixJkV67+HwBFVvIDI
	B8S/Nay0EuDu7BJutxco1IduHk/gmSPqOStVsk1bh8glbO1afut30Was5WResQjwAP3uLjwdQJh
	4FwLwOdGpZRnpX5IkCYSWeJ8jBogXHTSrLyjVRPw2G/hYgsOZh6F7cpj5b0qZPmIODBZASNFmAb
	FMDq5YM+oGr8HQxKgNi+usw1eSm3jGSGTI+/rlo8K/38UEOvHsnY0tujZUye3VtAMSP3Ab7Zzus
	NlFncGYLvCfVvrYxQI0l29lF71ky2B2Eq5f6qJIN0dxulZgI1zA7y4x5DnPZhABT0gRpwGpz8Lu
	n8GSURHy/vttQNTLl8lJsIRBc3Cveq7KsdtKhl2Y1atZ3vTibedgjCI7frHEoqApLXV62UEQP8l
	OhJHAJo/pQepddsf9KTiW25U4p5mXIjSZn
X-Google-Smtp-Source: AGHT+IH9/DKVPYn+/MtW7hYEn3RJ/PWJk9L0OYkwwgKcNwxO7lRzqwX9cQVK9GtmiMJWH3FziLvB0Q==
X-Received: by 2002:a05:6a00:181b:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7a621813833mr4031294b3a.0.1761823228287;
        Thu, 30 Oct 2025 04:20:28 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm14777024b3a.62.2025.10.30.04.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:20:27 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: stable@vger.kernel.org,
	joro@8bytes.org
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH 5.4.y] iommu/amd: Fix 2G+ memory-size overflow in unmap_sg()
Date: Thu, 30 Oct 2025 19:19:56 +0800
Message-Id: <20251030111956.308-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since npages is declared as int, shifting npages << PAGE_SHIFT
for a 2 GB+ scatter-gather list overflows before reaching
__unmap_single(), leading to incorrect unmapping.

A 2 GB region equals 524,288 pages. The expression
npages << PAGE_SHIFT yields 0x80000000, which exceeds
INT32_MAX (0x7FFFFFFF). Casting to size_t therefore produces
0xFFFFFFFF80000000, an overflow value that breaks the unmap
size calculation.

Fix the overflow by casting npages to size_t before the
PAGE_SHIFT left-shift.

Fixes: 89736a0ee81d ("Revert "iommu/amd: Remove the leftover of bypass support"")
Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

We hit an IO_PAGE_FAULT on AMD with 5.4-stable when mapping a
2 GB scatter-gather list.

The fault is caused by an overflow in unmap_sg(): on stable-5.4
the SG-mmap path was never moved to the IOMMU framework, so the
bug exists only in this branch.

Regards,
Jinhui

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a30aac41af42..60872d7be52b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2682,7 +2682,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	dma_dom   = to_dma_ops_domain(domain);
 	npages    = sg_num_pages(dev, sglist, nelems);
 
-	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, startaddr, (size_t)npages << PAGE_SHIFT, dir);
 }
 
 /*
-- 
2.20.1



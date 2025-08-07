Return-Path: <linux-kernel+bounces-758577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5242B1D0F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EBD3AF4C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE31A23B0;
	Thu,  7 Aug 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="QVOUtWvJ"
Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A388524F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534238; cv=none; b=EvoyNMeYPUtuby9eFvB8RLEf1sc//NKYDFecDcmiBXGgatuVmzzsZzvJpuVPR3ByX5OIc/vcrZBX0khkl824nChzCvGJWFVAY/TEZaFg0GXluYz4JiOA77aF6nkkQVIHWSsR9ySG8bYbod7bfB9rmpblKj8+rKyQOG53LlaiCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534238; c=relaxed/simple;
	bh=/rN/HmM3ZdTXW8EncKDZvcOeakQ8W9MXCc9EUMcxCxo=;
	h=Subject:Message-Id:Content-Type:From:Cc:Mime-Version:To:Date; b=jeU5pfK/97sb492aDYmfhSiZCIL9ScdCsmtVpHvrrj4006lDZtq6fWxlfNIkV+eyHQsiSzOme7q6Xxxq6DkjAAE8BJORfHQpgUsaoz8yiefpeLQn+tyFjhHv3/3f+voWYr7nKao23JFSZDJ5MMSPnBRexQEVQGB14EPzBx6BsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=QVOUtWvJ; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754534227;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=tvpUwXpgi4bbfw65gWC7ncSTc2jcTFdcUIgVdaFTeCY=;
 b=QVOUtWvJyGPJ5k4E7xighwdtybqSJQioP8gY/XWRsVuSjrvt21VZ9kcwYKrQPpY7aSPacc
 OiT6eHf813urrPL8ddkclM2zIQY11+WloarM3UdVoaKFHmzNuUaBQxMnl6nsWpKVrJ6qbE
 RT0MbGZcilSeXzzJh55xIBWjUDbrizpEyRL0Vk3X1rRppjnCs5nFZzB12W50x6WEPZOfq/
 SLmTNdazFzFqV2z6ddjZugHWzaIjgtdC6NXjjLiLyKI1ZyRZ94fvu60rgbtJnC6svVm8eq
 BD4SAHpMH8AUnRZdFPg0sxp7O6XYVcJ6FIFBbdrHK7ls20AvazAl+crsBWogjw==
Subject: [PATCH v2] iommu/riscv: check pte null pointer before use
Message-Id: <20250807023557.6482-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+268941151+b015ca+vger.kernel.org+huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Thu, 07 Aug 2025 10:37:04 +0800
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <tjeznach@rivosinc.com>
Date: Thu,  7 Aug 2025 10:35:57 +0800

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

Check the pointer before using it to avoid the bug. Now, when
iova_to_phys is called with an unmapped iova, the kernel will not crash
here.

Changelog
---------
v2:
- Update change description
- Add "Fixes" tag

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
 drivers/iommu/riscv/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2d0d31ba2886..b0186faa0300 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	unsigned long *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+	if (!ptr || _io_pte_none(*ptr) || !_io_pte_present(*ptr))
 		return 0;
 
 	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
-- 
2.34.1


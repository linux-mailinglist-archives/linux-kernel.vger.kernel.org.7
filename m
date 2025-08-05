Return-Path: <linux-kernel+bounces-756267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30552B1B214
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C5168DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E021F4612;
	Tue,  5 Aug 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="eOlhwhHo"
Received: from va-1-17.ptr.blmpb.com (va-1-17.ptr.blmpb.com [209.127.230.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0D2E36FE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389990; cv=none; b=oZ5vKetmnDcfmMQkBuR1BgJAq3JkSSyXxvF6ztuZicy6WAWbpRw4YENFeqfqD1lzj9IkkA1XmpefG5wlCfnEarIO6U+vRKbj5v9fUI5zbQmHtBYMMYri34nrPSvaN8DZV58ZYTDxG2TX/pFIgkQKGW419vjhunHfsA2dCHC1hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389990; c=relaxed/simple;
	bh=bA++dzmXc9zStBySJ35CM0F4lIfN36Koam3LxsbW69A=;
	h=To:From:Subject:Mime-Version:Content-Type:Cc:Date:Message-Id; b=ekwXDI5RoAxACW8YhVGP9qq+Y/S/OkcPupHNPu2k7eVXO1EpHLlaglQk85QutRcoqiwZrVIe/LbwyVuObpgfv2t82f9jOu7whPEFdAgIMA8F5wPpVUt1gHdG80/0y2oxczibzLlsBr3chSOv1SslYrTmPW1Bz1hG8ANy82cOs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=eOlhwhHo; arc=none smtp.client-ip=209.127.230.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754389072;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EWKh/6dZIglI4fJ1iIweOgozO4ucjLIZAOOQ2PsOGzc=;
 b=eOlhwhHoPO5IBQyQIFRLTkXvGQ8+90am7CYZ4hRhF4gb+JMOZiKFAXZd9bg8Yj0jWvm5xm
 dQh8TT2HIDJaAQhCDDM9O/NDajYGAaGelIOHr3dOEtvh65zx3NUROsivz/KWZZ3srKQIrc
 X9OitQ4KVBUbLzu+zQMGNQl58kv8mvwVPjToDam1oOxs1JS+Rje1VNuMWh9fVFT5tmq8tg
 8I4QPMTEiVe3kDelIb1V/Jyxaa6PaUz0q1aubsQ+ATOkQxaMhBYRskBenoPHJmBVgpdRYW
 6niNcqsoUT55E7wx9DBh7pJThYWYbUqMyaICA/PHQ/FOf6AvrBTVOMmtbUQshQ==
To: <tjeznach@rivosinc.com>
From: "Huang XianLiang" <huangxianliang@lanxincomputing.com>
Subject: [PATCH] iommu/riscv: check pte null pointer before use
X-Lms-Return-Path: <lba+26891da4e+332ba7+vger.kernel.org+huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 05 Aug 2025 18:17:49 +0800
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Huang XianLiang <huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
Date: Tue,  5 Aug 2025 18:17:41 +0800
Message-Id: <20250805101741.30819-1-huangxianliang@lanxincomputing.com>

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

This commit just check the pointer before using it to avoid the bug.
Now, when iova_to_phys is called with an unmapped iova, the kernel will
not crash here.

Signed-off-by: Huang XianLiang <huangxianliang@lanxincomputing.com>
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


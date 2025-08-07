Return-Path: <linux-kernel+bounces-758600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C801AB1D13D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24E716C205
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0019E992;
	Thu,  7 Aug 2025 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="xOr2sX/L"
Received: from sg-3-15.ptr.tlmpb.com (sg-3-15.ptr.tlmpb.com [101.45.255.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634471E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537599; cv=none; b=VOgMWzP18x1z7VGmnzLd0G/ttBWjpVoMdr/qVUPPs6jGZGGqhSh/Epstt4OBmUhKjgE5X6Qwn8+LOtH5HaLsNRF66VmN2MT5+v6dBxB5/b7wUL9Sio28q5ogj40g6TugsRbOuJYnWQUZJSiabq8wemuiWHP90P3drT8AJsBCwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537599; c=relaxed/simple;
	bh=hRea0IlzPQc+TJfL1Mi5sGTdqpcPUvPxWlNW9eL5ugw=;
	h=From:Date:Content-Type:Cc:Subject:Mime-Version:Message-Id:To; b=VBs56GwZcf3MYHCXaxE1Sl6v0JGuFXxXJ8neSaH0wXWkcLT/P3EGnRhIkfyyp+NvE1edOdRG35qE+5urP77cslDGK8rpr0aP7TPNKASGRPQHhdYJow0Cf3iiFoenBYqVWIBGiGZnp7crVPT0VasMaIYH5d4GKk0j/Z7PV0uBwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=xOr2sX/L; arc=none smtp.client-ip=101.45.255.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754537583;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xiMJCuJpfu6nMJUxvjNUYm7BQ48UmD6tw9atHX3Jh5o=;
 b=xOr2sX/L49NQuZgliY/hmBvgx78stHE0DNsz0zQHrIgBKfnvxmFbI96XjvQqIWIZhpZfWp
 ihvtsiyXBFf+kR30lTSOocqiTrMNMZ7EWflIfNRiplRiHW++KWVn8bzKCecKAVqCcCo+sh
 uQJibh92yw9NSaL0F7JsY6Yc3C9ZY/FX/GQBz3ugLTufAPCJYuXakKNNSE8y1zyQdiN94Z
 nBuOt8vOpF+ovNOOCLNtGSEbNxE44DRfv6VPqS/l+ZE7cnN9jafJmKxI97YIe0mlgC/TFv
 QgQE7550pp9yvEm2Nprost4hgTYFPgYZZU+Or7BNQe8ssaEvg40S+tt7Hq+ZVg==
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Thu,  7 Aug 2025 11:32:52 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Thu, 07 Aug 2025 11:33:01 +0800
Subject: [PATCH v2 RESEND] iommu/riscv: check pte null pointer before use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
Message-Id: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+268941e6d+83d74c+vger.kernel.org+huangxianliang@lanxincomputing.com>
To: <tjeznach@rivosinc.com>

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

Check the pointer before using it to avoid the bug. Now, when
iova_to_phys is called with an unmapped iova, the kernel will not crash
here.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
Changelog
v2:
- Update change description
- Add "Fixes" tag

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


Return-Path: <linux-kernel+bounces-770360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431FB279F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC1E624973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFA24A066;
	Fri, 15 Aug 2025 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="2iDbgEaC"
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65E223DDE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242202; cv=none; b=PLPZ+yz2PuKNuzgiIdTBGREzzB5ehw3rNrknmLQ+Mba6hdfXAbrl4tW57DjMdNCsz1PYZE5+pz5QcJyk/kpKUAeGTNdZQUDDkhDma5QNHroHVDu8U1e7gtI/iG7MWdxKrZRxGLs+m3fjV9HlOtT9Rs7A21qcD0E7kKbLJg1H6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242202; c=relaxed/simple;
	bh=FEACYy9HciCk7f/5NecNwlRJptivHxOIrgKeSvawKG8=;
	h=To:Cc:From:Message-Id:Content-Type:Date:Mime-Version:Subject; b=eX9UXw5ZXniwrHBKEZKOwr1KRC2D90xwoxCIJuOruOKmE4VaZDzU6pVlqtk0cXqA1g4mxHYgbydaOM33AuubhN4N8jc6EpPFWVau6f45XyNLlqN/UdUmE26t/Al+KJiyxcOR2zXSN3Hcc+CgmdQdFd7V5osEaw2oT1Em0kpmvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=2iDbgEaC; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755242147;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=u3BbbksmnmXq0AbRcTT4ackl1TDUHe8HK6woHx/2uqg=;
 b=2iDbgEaCpPPcWXjSL4Pztxo8WwmrxppsUZQ6cT+rLjtehUCyfl809Q+svoxOdUDlVZRlE/
 j1sGBm/tKdkEGetddnDXLiETRACLmuAadYxK19lK4LESgSDHKS0ORMV3GXg1j5F3YWTi5k
 v55+vLqH6pHcRr481q+yN9JKhQoCfKzs7pCy2yF3U9aYTKL+iXX8i+BzleF6a9JNmVKr6I
 Ls2iB5/uQJ6l2CzldgCHd0aTBpvT+kW6hCY24OsXdt6Gq3Tqg10lumAbNDW5sEzlQeC5z+
 pOQ7yKQeHtmn6CxbuTcTkED9Z53DWdaFJvPc9wqsCpRY3Gz22nnDgPopp5lMsw==
To: <tjeznach@rivosinc.com>
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Message-Id: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+2689edea1+e03807+vger.kernel.org+huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Aug 2025 15:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 15 Aug 2025 15:15:45 +0800
Subject: [PATCH v3] iommu/riscv: prevent NULL deref in iova_to_phys

The riscv_iommu_pte_fetch() function returns either NULL for
unmapped/never-mapped iova, or a valid leaf pte pointer that requires no
further validation.

riscv_iommu_iova_to_phys() failed to handle NULL returns. Fix by adding NULL
check before dereferencing and returning 0 for invalid iova.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
Changes
v3:
- Remove redundant pte validation in riscv_iommu_iova_to_phys
- Improve subject line to emphasize prevention

v2:
- Refine problem description
- Add "Fixes" tag
---
 drivers/iommu/riscv/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2d0d31ba2886..0eae2f4bdc5e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	unsigned long *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+	if (!ptr)
 		return 0;
 
 	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
-- 
2.34.1


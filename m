Return-Path: <linux-kernel+bounces-777074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591DB2D4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493F85878BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D82D3EDE;
	Wed, 20 Aug 2025 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="IgYdjih8"
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936523AB9C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674634; cv=none; b=WS2d66p7j7k4Ku9YqaMOge6spIOEvyZaufKNhqG3oIPfarQVdvHIMRpCKj8yvMOzJnQXe6d1W/2K2TOOrfHdYPVOXeXD+IZJ4ToIyL8DHhtjyHBebqrUvc4Tg6IhV7uzY2/jhyJo4PxbTZRle+dCalO7Ae72p+0FzdEDZqwcR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674634; c=relaxed/simple;
	bh=2FatlzUiRJAMOJ1x6bR+ebEF2y9NwuQIqBshjOfdc14=;
	h=Content-Type:From:Date:Message-Id:Subject:Mime-Version:To:Cc; b=KOvxkGnVVBsoVG0xfbvqj4xwb3QSimRt9fehXCjApQHXiBS0AEMoFf7WGFx0E0Myx6vFB4apzbkNhngA/MOkOME3gGJmn6+Bcx3Jp6mSgdDUoJJsiwqDIFzI8mspsq2VE6GNyvnDk1M6mrDVZtuOyJPe8jM7OTxhVBasHkdKX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=IgYdjih8; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755674578;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kZxmK5a1KAqXLehUVFYamep8ylDTy8+Ik5zqiesTQDU=;
 b=IgYdjih8GFgXd6SQ7J2LREnUtlpk4CyEinPz89A6jfxoWT7MLKIPG5kLzwpvrZKgIWjkXZ
 XNr0/Cb4kMsDAP0Und0ltZhp36ebGxNWEiir+IMvZEFMbBEVLYiubafr7/5q6dM4e3sTH0
 EsTdik+gW3KTIQR9t2alMhzkTTudM8YybE52d0P0XCJ5dJaGLKrYa/gIBXDt45Tu19RcTT
 iOVISBM75NAR/PHSeJJ4ab0h7/ehCdA6EydL6My+SYGd0GjDIwQJw5xtkPTeMiwInJIrX0
 Ms/ogbfZTd07l67plJsZGscyYYAWgVkLlGr5SWolMyhTq91SCGSrPcUkkVGoww==
X-Lms-Return-Path: <lba+268a577d0+621a05+vger.kernel.org+huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 15:22:55 +0800
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Wed, 20 Aug 2025 15:22:48 +0800
Message-Id: <20250820072248.312-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
To: <tjeznach@rivosinc.com>
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>

The riscv_iommu_pte_fetch() function returns either NULL for
unmapped/never-mapped iova, or a valid leaf pte pointer that requires no
further validation.

riscv_iommu_iova_to_phys() failed to handle NULL returns. Prevent null pointer
dereference in riscv_iommu_iova_to_phys(), and remove the pte validation.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
Changes
v4:
- Change the summary as Markus recommends

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


Return-Path: <linux-kernel+bounces-715712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39AAF7CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CA37AF7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82E22173A;
	Thu,  3 Jul 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gpx643r9"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E79230BF8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558129; cv=none; b=E/FLbfAov5pZCj+jq9HlHP/otLyeB7EAGr7kXs6Tvf2GtFhhO0KvXTIUPkSYzVBL7tguIdXkK2uLpcTx6QgD1Hpl8LEFnPHc8y4kpSC9RI7ZOO2ZOodzGN+7cU78X8zeNlGJ7WHmtmC/Hsj0VZ+HcA4shcrVdxCAr96n2M1HpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558129; c=relaxed/simple;
	bh=nQeCwW0sIhB4YSiVTJZbaxxqRdc1CiQwMRpV46aHtMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0pHVsgJM1qYVfZViS2iNz2knVp/hi8/6ynUQ/gU9KT7jFWXJUY5T3i40G18+J9zM4eQQydjk37ZVIIvtk6dhAzduGs/08XuIOEvNSG/IXRxm3Moy6t/zSvXXoChRovqhCmYnVlKcUence7JjNLZVs/akMRiIGRsorY2fgTzGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gpx643r9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from gem-name-lb-02.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D97E21246DE;
	Thu,  3 Jul 2025 08:55:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D97E21246DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751558121;
	bh=hYFFRmg1fk5w9c+W6QdrEd1mE/DY5idb/tDfsZDIQaI=;
	h=From:To:Cc:Subject:Date:From;
	b=gpx643r90WFLo1HXR9rP4Ox61uNLZqKYJCHg4qp2oWuJm7NleEsMezwrzO6ZGbD12
	 JGUviT/3wm5bW79izJJ/juoghlGSJrrQx5ZIMQHs4HRVX+cnTI41k0LeuSF8s9JeNA
	 o9HZLOwrqrGD4jFzhn6ptZgTiVly86oJTEaEgq9M=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	iommu@lists.linux.dev (open list:AMD IOMMU (AMD-VI)),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] iommu/amd: Enable PASID and ATS capabilities in the correct order
Date: Thu,  3 Jul 2025 08:54:33 -0700
Message-ID: <20250703155433.6221-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the PCIe spec, behavior of the PASID capability is undefined if the
value of the PASID Enable bit changes while the Enable bit of the
function's ATS control register is Set. Unfortunately,
pdev_enable_caps() does exactly that by ordering enabling ATS for the
device before enabling PASID.

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: eda8c2860ab679 ("iommu/amd: Enable device ATS/PASID/PRI capabilities independently")
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3117d99cf83d..8b8d3e843743 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -634,8 +634,8 @@ static inline void pdev_disable_cap_pasid(struct pci_dev *pdev)
 
 static void pdev_enable_caps(struct pci_dev *pdev)
 {
-	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pasid(pdev);
+	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pri(pdev);
 }
 
-- 
2.43.0



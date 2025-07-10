Return-Path: <linux-kernel+bounces-726233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443CB009DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260305A489D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132CF2F0C68;
	Thu, 10 Jul 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gg5I6Q6g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5A1D7E54;
	Thu, 10 Jul 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168261; cv=none; b=tImf3dH2iqxAse2ygPPvGdDIiduDxLwIbpcettHnOJLWDcn+afWYSX4DgCgCq5rX8LHl2vCx1cbiufccB65t7ir3IdqdyTM9IxeIi77xzoF0SAF78wKZeygyTvSFntaQKPInlXvWDMPsxgG6droaphvBBWzOl4BRB6GG0ArBZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168261; c=relaxed/simple;
	bh=8XpapmhY8UopZbodhwTeJ69XyG4wdv6aSdyJhuQlXAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAOFpIXEs5CYwM8t9kMvd5Y3GxjDn58nGc1rmE0+bsSeitKGMi0anLp/5GJxO9r2XBTFgeM23RvQBbQguXN0sYeclJEi2voSCBhti9qx3n/hlnqnsawgO5QE11eIKNDJjp3NedxeqKysixeoks4FpjBzBsM32qbAAJ6jPmUAhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gg5I6Q6g; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHCGp6029661;
	Thu, 10 Jul 2025 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=QeDtzMAPhaz+5khh+8shhtcKmhhhB
	6VlXl3AbLWSByY=; b=Gg5I6Q6geRr+H7uaBN8+7JVSN7bK6hnx8SBT0382PS5SD
	DbnI/vsy7AhOiZoAFvddcwUyT7FLVa2Cu/bbxs6Dr2o5qK+ydGu+UQ9IcjYNWfeG
	BGYMMxyqtZm0vx4RaLyF22XVc/PB65H+x9E6sqTj6OavCOeru9xN3S7Zaknn9k4J
	Aqcrkfpz57aESWM36QjT4io+TYxJtlPk87D4k7SlRR5QxF8hbj07tkIhK1WtmHLQ
	oH5ZSEtJixq/0WAOehbV7ornlEpOzt222SHdqip8pXNDL8Kv/4pxjREp+Nz0JvKi
	YOpNwsYFg3kmyuOj4HFa45jIHNdhm+y5uzDYrKCKA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47thq3g0mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:24:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AG980G027323;
	Thu, 10 Jul 2025 17:24:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcjf6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:24:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AHO6Nk033535;
	Thu, 10 Jul 2025 17:24:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgcjf5m-1;
	Thu, 10 Jul 2025 17:24:06 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] phy: qcom: fix error code in snps_eusb2_hsphy_probe()
Date: Thu, 10 Jul 2025 10:24:02 -0700
Message-ID: <20250710172403.2593193-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100148
X-Proofpoint-GUID: XIChbFydYMJSwpcmHNNxdFHVAwqTGiqF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0OCBTYWx0ZWRfX6e8IzWggny3q Qj5FCrYHaDmZbj56585ZAQuEnInqZ1SutAThIvw4iEI/nOXxzq12YL7fy7TWcsulKeKxobnr1PQ ntef2tHX5ta0UeQVsZ51OSEOshTO6I+VQ5xplxt1V+bRZ+5b3KIdJ0YCJZA+XNQxlIPBHrV3BUa
 V5611TnEXNg21kRe2Gp7Svy422wGUBKWh1XnlkOsksGtbYnMesIsC8qPeIz8iTBqku0IboYLTjt walKMlMIhEN5VUClruznNR3T5caOFIdrfQfHlhLHvP2up3umttxsfQ4PPPtA5AFqrxuLGC0n9bI Do2Rb8GBsqe5m5a3yl5ZNGO/c07r3RqrFCwwdl6HGzPuWgA83lchh9VnZRCvG8ZLL+2boUuhrK/
 yNE1laZxl3NfriBmNaitdwfg7hlfC74LHH2zbNqIiqK21Ix1F5Ng7d+a3iBraADZo7DGNWHl
X-Authority-Analysis: v=2.4 cv=RoLFLDmK c=1 sm=1 tr=0 ts=686ff738 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=A5vd3UQz4cM7NqX-iokA:9
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: XIChbFydYMJSwpcmHNNxdFHVAwqTGiqF

When phy->ref_clk is NULL PTR_ERR(NULL) will be a success. Fix this by
using -ENOENT when phy->ref_clk is NULL instead.

Fixes: 80090810f5d3 ("phy: qcom: Add QCOM SNPS eUSB2 driver")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aDCbeuCTy9zyWJAM@stanley.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static-analysis, only compile tested.
---
 drivers/phy/phy-snps-eusb2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
index 87f323e758d6..5e19532bef3a 100644
--- a/drivers/phy/phy-snps-eusb2.c
+++ b/drivers/phy/phy-snps-eusb2.c
@@ -568,9 +568,11 @@ static int snps_eusb2_hsphy_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (IS_ERR_OR_NULL(phy->ref_clk))
-		return dev_err_probe(dev, PTR_ERR(phy->ref_clk),
+	if (IS_ERR_OR_NULL(phy->ref_clk)) {
+		ret = phy->ref_clk ? PTR_ERR(phy->ref_clk) : -ENOENT;
+		return dev_err_probe(dev, ret,
 				     "failed to get ref clk\n");
+	}
 
 	num = ARRAY_SIZE(phy->vregs);
 	for (i = 0; i < num; i++)
-- 
2.39.3



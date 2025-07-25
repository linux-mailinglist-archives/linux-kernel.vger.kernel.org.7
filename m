Return-Path: <linux-kernel+bounces-745457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D42B11A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF67BAE88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8820127B;
	Fri, 25 Jul 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="JyiTJ1fD"
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA121FC3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433401; cv=none; b=LTMzZSbdmOJoPYMwvf9q2CGL04RwAPN1EwXmCKb4Y0J31dqZMKMN2Wa3scPHEk6O+JAnBQsmUD6L2dZKgIh6SVZwealM68NfiCydYMRT6fEbFq9Km1G5EBCJfrvC3oDJ2NRG/+Bjl0cIZ+lIRIzueUGghSCib/IGmpq0xTZCl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433401; c=relaxed/simple;
	bh=DgudFAr7p+t76bJMfc4BjnbZuVWo1ZU+/SClggvoUdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8ri7pj+iS6Mdi/0vGLD0rxSHLs93MzMAYUFJ79HLZ58W4oD8L1ahwSkoTnO4c42k2ujc1uAI/WPVOj1e2J63e4Mg0d839Nt2ugfszDsWLK3Pufn2cIQOhgepsLQodiDyZswdC2Z/LjaeE2/Mv/AIXk3fePNEIs5oCgRohVvuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=JyiTJ1fD; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0382794.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P71V0G004927;
	Fri, 25 Jul 2025 04:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=podpps1; bh=4x8Y8o1TqVh46b7zVbS+AEaUUdZ4AZhwmgb08
	SoOMcs=; b=JyiTJ1fDLP1+wxMGl2K31L9nUZMIoMtkmf2XJYcCMBjyJ/GQqzGy8
	Lli6OeE6MvqyPntvoegFwtJ1si8cyjtXgC4a/2DPAlrb5iXdv9tW6kcr9GfQcoio
	ANHcctRb87cQ9sPTqHu1efpWw2IckdARe3u0pgHmXj9SFqQN0PJ8d9yfMB+X3fkl
	sO2Dca7o7CyQtDmbmgT+vZlYVTAGe6yI/gJdLA3vakMoaVs6NIsr0uNmpEWQGd42
	Cay4igKnLo0MLYd6R2vu5XRTcieSQRIptVit0NmkrUOofh3ujcur2YB8INzNRwhR
	ow6MkQao6BqrMwwHdefZz62QjmtLtk5Ag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 483w3jgxjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Jul 2025 04:46:46 -0400 (EDT)
Received: from m0382794.ppops.net (m0382794.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56P8kk4F030189;
	Fri, 25 Jul 2025 04:46:46 -0400
Received: from relay2.belden.com ([12.161.118.81])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 483w3jgxjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Jul 2025 04:46:45 -0400 (EDT)
Received: from pps.filterd (dcric1ppa02pb.mcp.local [127.0.0.1])
	by dcric1ppa02pb.mcp.local (8.18.1.2/8.18.1.2) with ESMTP id 56ONTLte017715;
	Fri, 25 Jul 2025 04:52:07 -0400
Received: from chbrn1lab0001 ([10.1.2.1])
	by dcric1ppa02pb.mcp.local (PPS) with ESMTPS id 4806pvqc31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 04:52:07 -0400
Received: from chbrn1rnd0001.netmodule.intranet (chbrn1lab0001.netmodule.intranet [10.121.114.100])
	by chbrn1lab0001 (Postfix) with ESMTP id D15C33A01C7;
	Fri, 25 Jul 2025 08:46:42 +0000 (UTC)
From: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
To: linux-kernel@vger.kernel.org, afd@ti.com, s-vadapalli@ti.com
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Subject: [PATCH] phy: ti: gmii-sel: fix rgmii_id mode config
Date: Fri, 25 Jul 2025 08:46:40 +0000
Message-Id: <20250725084640.845760-1-aleksandar.gerasimovski@belden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=722
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250074
X-Proofpoint-GUID: 8kN7q0lqcXysx9vW3LLjc4Rd_wIPI3YJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX4A7sAu8s/bRR
 EDUbk/DmCg1ohigLEUN7LcQivZOwWzVBg/sHZhZHYqxDkFR50eDjXzkqX/k5Fu6jdUL1cxjPLGW
 SsNKaIH0YeseNn+lSpHQV5eV2WXEmKseXzpwDk+HzmYX6okzc7h5TrW8WxWncUSQlxaBCtVzmd8
 WHqZgEDaDwiES5cY4b6r4yWlp33ym928LsVGAOvKWysU/OCz5TEzjNRg0ulRyYuAi7v635pz9BH
 a43BlgBl9bkJW+7YHOiQIDMcii1q3dDVa5/5L91IvUKKfTPrB3f8GBAbKa7NWCTppnvtc0m2Tij
 DFkmL+6kwzP88Xy9YGkLP0QVLjZtlVA6KGqKTVE7HwxB5xn4XmAVRICPx3Byi+Nv+375LKErmhx
 tVbhbF0IeYp87DQMXO6vPW1DTjvYmGOGIUBrNxu0DGQTHb0Pfw9C4IL0BsJut6GuXStDzId2
X-Proofpoint-ORIG-GUID: SVgQy44b3ZPEFpRIwzEreTrJP3Abn5zY
X-Authority-Analysis: v=2.4 cv=LKVmQIW9 c=1 sm=1 tr=0 ts=68834476 cx=c_pps
 a=cuOCxa8MntS3/AsasmU/aA==:117 a=cuOCxa8MntS3/AsasmU/aA==:17
 a=Wb1JkmetP80A:10 a=WDlp8lUfAAAA:8 a=MSXI9gdaubPL58eQSmAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 mlxlogscore=943 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250072
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam

Without setting this bit the RGMII_ID link does not work reliably,
we have found this thanks to the U-boot cpsw-nuss driver that is
setting it. The bit is undocumented in the AM64x reference manual
(see CTRLMMR_ENET1_CTRL register).

This problem is not visible if the Kernel is booted by a U-boot
with enabled networking, in our case we see the problem as the
U-boot networking is not used, and it is disabled.

Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 41 ++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index ff5d5e29629f..60a1312acf33 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -210,19 +210,44 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 = {
 
 static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] = {
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x0, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x8, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0xC, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x10, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x14, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x18, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x1C, 0, 2), },
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x0, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x4, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x8, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x8, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0xC, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0xC, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x10, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x10, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x14, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x14, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x18, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x18, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x1C, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x1C, 4, 4),
+	},
 };
 
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE),
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
-- 
2.34.1


**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message. If you are not the addressee of this message, you may not copy, use or deliver this message to anyone. In such event, you should destroy the message and kindly notify the sender by reply e-mail. It is understood that opinions or conclusions that do not relate to the official business of the company are neither given nor endorsed by the company. Thank You.


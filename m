Return-Path: <linux-kernel+bounces-866564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99053C00180
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE83A6018
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F93054FE;
	Thu, 23 Oct 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RhTUnpO8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AXofmzhd"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556E2FD1D4;
	Thu, 23 Oct 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210250; cv=fail; b=MsGaepMXzgFBGSPNMAvlFitihMjSPXT7+7Y6eiXUyc6jFUlWwRx1Qm6u0u8K0GQugHdLM/XzrU/vPZXWNTP9SAm9xFMplQTf4RpvZDOabI/LW+0PXWRq63W9vuUCctlLIjmHoekFkGF6gFVf8pVgZW7B93S6S4OF9TRX4MlYyXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210250; c=relaxed/simple;
	bh=X2NUeq8DltSOp6jvmf/MicoPi9mhvxFiLq1Nw7G5Xzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dinkeWmv8btZITSGCylnh8WParN2BShdni//BFN1/w+1T4E7kGnvIz3HPByFrNorktRy+gIWLplUEeyTk/F8A8dFcKNMhshyszl9XfQFUAbQL4gIbLMh/8GAToCtToRzTg3BGaslp3LnAbOiPt8frpukZQT7hGOtpRTYghgFUFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RhTUnpO8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AXofmzhd; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N2GQ6t1651041;
	Thu, 23 Oct 2025 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=DQRy9qEUdAJn3wMDFJ0cqoKPUucNlA5I1DF+HbKSbEM=; b=
	RhTUnpO8vXwIawhidobrQfXw5V4U/dEk1QmgSCnFPqr0gUxXiL5wrwbejv75pVwz
	oPpjeySUqg65IaAD4qThYgaP+K1kPCF1uaItOjJOdVgqU139N2ZDOIKI/4eWIfIe
	92lYOiIKEo5jCRyeBCTEJ2AfKsr7X7aM6jf9woLSdmnBt8BtT3RltXMei4eNAtOb
	1cr25RxHbVzo0d3taImPGoxhRx8Krmb6ImbnU4rFyFGZlbRPO9p4P+ON6JH+B7Fv
	dVEijzbOvuaYIdexHcmNoiXRk+ZWZzw34BYktWtcXt5CTMM0H1GVM81cOXmtXzuz
	GxVA3y7EYQvKbSmJwy5JUQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023128.outbound.protection.outlook.com [40.107.201.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x15ODmXcLHJ3KtPuRpdCd0ET7us3Pw8ZgPo21qJ9gNKS/ciZInATX+9Cq4xfSWm7f78UY+NB3i6MOfD4oXthFQzLBiT5axrxuVq02i+IRVy8+39aieEKsCIw4K7GvJPcqMtDhjseHEimxUNVoumdcLCCNau0Iy19WJ6fk4VgZKhLH9YxujEJc29Px/W8CTp+57wUH5kwIn3bMv6l7fx4htpY3d00CrqZjPeZgZIMMpTw6fgurhNaXfQ8IcPSl3ThgnmIiYE27XjHu2BQJlPvkdW4JRKvyt/PffkpOtI64TLoG4qp8yoHsMpzdC5NI2d5oVbfJt9oBzN0TooF2lmOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQRy9qEUdAJn3wMDFJ0cqoKPUucNlA5I1DF+HbKSbEM=;
 b=S53j9RZV/25p1znmLxMA0Nx/snp618FBSlEFcrG0uKkTPdEREyAcMPMkvSIn7KCZmvyeGzx/KbA4jZOf/TV01wQo8Riv9nm6YD6fQuhxDculgi4JPFrYf28WoeAI6ibzWHzTeXn68tjXK6emKUC6uaOzFBUkKgitP23Y/FO/0oKfGfNh/awhOXG+FZCJAy7j2mwsYJhjx+zO1B9wtbGdCeBRKoZFWS7w/cikIEuMnEdPcJgEsi34l8XCAzNQ51CQ1GBKidGtpEinl+ult65AAfSQSdDwPBAmCw3+o7CiKErhAqMiHXzq+dTOwaXy6hk0NLbSkuvOQr+qmuNFzPOerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQRy9qEUdAJn3wMDFJ0cqoKPUucNlA5I1DF+HbKSbEM=;
 b=AXofmzhdx74ZtrXZZe0m6s3EMEuM5J5iTQbRbuUuLg134+3hiV2KJS+lS9eFj/1vVCKIezIr61BvBPQTFBG/tSNJRFEaF7yqux5UcDSEHVvGoFaU/W1HvqMBOjQEnDdqUBA325h+boF4nE8nyCvxsZGSOjZDvGSL/FevyaklUAw=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by SA0PR19MB4350.namprd19.prod.outlook.com (2603:10b6:806:80::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:44 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::39) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Thu,
 23 Oct 2025 09:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4A4EA406555;
	Thu, 23 Oct 2025 09:03:41 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E6F48822542;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v6 11/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add SPI bus support
Date: Thu, 23 Oct 2025 10:03:19 +0100
Message-ID: <20251023090327.58275-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA0PR19MB4350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d363b4c7-e8ff-42ec-5fb8-08de12131134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agM4lJXCurz0QD3ZSFAsByKGoksuUuxFTLXJq1VFdgUHox5qEgks2squ48QX?=
 =?us-ascii?Q?n/8Q39/oxBwj6xTMmFcuvuOdQoCximDf96ckTfy4H6VFQn9SrJlMz1WIziWT?=
 =?us-ascii?Q?dn9+0f0ALEDZGJhkoFWN/mxt24SrikKe21vO7Hg19oNPemwANexB7gm1Hjj/?=
 =?us-ascii?Q?+wvdP1XzqPj38MvBlfSThtVn2E+24y0gMp/I6tEGdk0cIKyzJGpZZJ5E+NZY?=
 =?us-ascii?Q?vLleZni5ba7JeSsViSXquXtpEkB58D8oOaHtGlW2pdGZoellF9V6geLQVsvC?=
 =?us-ascii?Q?vcW6XxB2R5cu5KLrfkygIVTVeVDogZUeP2zvbkmIC7hxLi2DONfjKM2X5Qvw?=
 =?us-ascii?Q?cwW8VaBsm+ZbvzAUpd511ZX3sCW5/ZBH1h0IEJvoX9QCjeu7rFvue86aAPbg?=
 =?us-ascii?Q?rgxkuR/oTsMAH6yGUjP4q0EhgpubzjQGVJOvxMr49iKQWahEsVmNGE1R27a1?=
 =?us-ascii?Q?TsmcEAp+aJT37o/Vzn9gSpDgm4dbQOrL8s53jud6YFfyVNRT36dsItJ9n7QC?=
 =?us-ascii?Q?3xiir3nZqsI6gXzIyjZsrrGAX+Ov3krOba7S3wi6s1byEzeqY4GP/Ipo+rYc?=
 =?us-ascii?Q?0jtEz/tClqlBeGuhS6m0RAHhCtWsxiiS4WG+tcBgkWxMh7VNQQbFbe7fH1yZ?=
 =?us-ascii?Q?oMNxuVlaNzrafkAFsTji8TxyBEFASmzY1rTUjXhOa7srkSCXhTEgE5E+yto4?=
 =?us-ascii?Q?qpPytW8j734OTrwH2+ea3pXQHABuDh+A3A+8rCvAkVq8dH9pWB5sj87qC7jK?=
 =?us-ascii?Q?6dzKAcCFQYu/n9ALIbccQl9EwqtqErm2vEYE9MsyGaPYPSITIntdw+bJmm+3?=
 =?us-ascii?Q?J2dUZPWxe6NzLL+judmFKkR+jEotRk3ZD21Sp4wlzG/NugY4CjcUPvxY4c3+?=
 =?us-ascii?Q?Xpdz7Go6RJADC4/W9IvbsvBpSwft8FqlXC5Fa7MIZhs67XMQAVADy8Udarus?=
 =?us-ascii?Q?skA51E/HNg0cJYTu9vLSiylF+r6VPXh8JPViOLyDZ9P2A35w5NCOd36p7Fiv?=
 =?us-ascii?Q?Q0Kp58WD3Skq0NOejJPGKNca0wKF4qoo+p7X/hW+7KFrhYYzltIwPpY8B5Np?=
 =?us-ascii?Q?p1yTxmIsgjk3UQJwgPUlMYH3ZWDqUtU7ABGv3bWbgZaFiAf3kbjWyj+jq6Ls?=
 =?us-ascii?Q?ZKarnwB51L9WR3yJ3l+B9Mw5bIEuwLaiKQC6+zHs5mqPa9P2IZa2BXrgiotb?=
 =?us-ascii?Q?RY3nM5q1HwmwzjdfMZ+r4TnwxDLq+SA8WlKcbRmCulsjq2iXeK19Gz4IgHTN?=
 =?us-ascii?Q?dLBNy+FeIi1lWTa7Yj6zdAHpDLDg5tKRYtgABMXErEfA8xugBIgADrjN9nTj?=
 =?us-ascii?Q?2oCpxkekxQveMUwVPNBcleL2TcQA0a3Ar0+q36mCBwT5T/Ds5s9NkDeLfFe8?=
 =?us-ascii?Q?fZKwRybKVS1g8CgQBLFUcMBaTOTutmhFoLQjUgBYY+ll1AGqXbNIrt7UMDTF?=
 =?us-ascii?Q?z0D0yEmfMJbXWvvbaMIZAs0u0JQj5GMHGll4vhuHrRbBuKtB5NRI3X0GK8t6?=
 =?us-ascii?Q?UHf++fJI7KWgewFC5vwNqv/fUyBbvKE3Ti6vj/WfQwp5WSxtab37j2ZRjSw2?=
 =?us-ascii?Q?Kp+fLNjxK43gTADnfRI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:43.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d363b4c7-e8ff-42ec-5fb8-08de12131134
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4350
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef72 cx=c_pps
 a=oKUGrOEB3UyG4cVvJxNfUA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=X-c6eRqKsKgCxGUBhFIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DG7eHpaiVGQ2rw66_eh6MIYncyI57Psi
X-Proofpoint-GUID: DG7eHpaiVGQ2rw66_eh6MIYncyI57Psi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX0vwZbDP1XJtU
 AI38+KLD1Yq6grzgqLQ0r2dyKCMJ+WqB2/UE21OzUjtyAGJef/mH7dnFY1lFT4qSL5Te2ztiLrY
 i8x+6fnSfHjAzVrWWH5co4UmXc3DI9QxCNxYpVTNX4zPKq2bqsuP64eUF34NfxHBIJcPbAeY4k9
 u3Jz3is4Daun+7tdtMpwHGCm87HN0uq5hW4ICsadq6TBDm+U/aiP56ar/qd46Tszn0+tXuiysES
 8kRlxMHRQYvLoUlZkAtxoS9m3aj+9X2B1jovGtkRcfxa72ylqFgV21q4Qt+D5gw8OPO0v17lqxz
 qPWoJCyT1zkcjO6dFtBRlRkDHoGLSw9NX7Xsnogl4LaHczGpS+rLHrcpiOqtGilmzqv1zGJCRCy
 CJpWSHaHe9pGIlsZ+DlGEmn7Nf5txA==
X-Proofpoint-Spam-Reason: safe

The CS530x device family supports multiple control interfaces.
At present, only the I2C interface is implemented. Adding support
for the SPI control interface, operating at up to 24 MHz.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
index 04ed197f91eb..7600fff0e3b7 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
@@ -15,6 +15,7 @@ description:
 
 allOf:
   - $ref: dai-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -30,6 +31,9 @@ properties:
   reg:
     maxItems: 1
 
+  spi-max-frequency:
+    maximum: 24000000
+
   '#sound-dai-cells':
     const: 1
 
-- 
2.43.0



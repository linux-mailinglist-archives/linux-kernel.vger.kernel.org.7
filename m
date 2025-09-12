Return-Path: <linux-kernel+bounces-813742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C30B54A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FF3B9CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B112FE068;
	Fri, 12 Sep 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RoHolevO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Io/777ju"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396482FD7BA;
	Fri, 12 Sep 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674017; cv=fail; b=t3xelleiuUNYyUpw8o6M62OqWIGK7GEkYmFWobbLZ0gf57Is5ilgOLflCvcqjP/jhIi6Y007xfglNWx41Yny6X9Z4LULxoU+//qzUcoyJuG1EgPWpUWfuhzBzsL1W09LTdLgq/z8GIWpQ46EqaCe6/x/aTBrA5pcLJ31PE7cS1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674017; c=relaxed/simple;
	bh=hejgFMZ6SJpSLn7WVT2lz6EDKGlLtr4UZoIwPrhUSpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6PWmRqL1cLLRWFlOjFwuVjVRgZ+eSDz0G0MVk7M3y9hoMPJbu7IiYvFp8zhKiD1RbI+0kSv1HuI7bay/leI9blHpcroaYR69Ceuc/9jSrap+F+tlDHxi8qyZuZsNxHiuhw7kE9+b+t4bgeR5nnKTRbnlKquG3F+1XMKzmELukI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RoHolevO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Io/777ju; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C5xnu03622022;
	Fri, 12 Sep 2025 05:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=E1DsybW3NZqMAzLrKvgIt1J5ziTHhieST30kVUsXLHY=; b=
	RoHolevODJxYJENHcO6YeEVbcs/ZRFbYIs1FursFHci9KYDh8whbi/o1/yJV7gbc
	xTCZnUWW8uhJawhFmk8zQ2nqM5lpFqFz1975FNryfrXv8M3tqcdCmPb4pjzaar7J
	w9uCe4Wn4RfoRzdiAURsFeelqFmpyPaoiehUA7lBvJT42RNLl5uE83y2lsFZMMgP
	npbdRz0tKHA2sCOC2fuKsDE+Ll1EIPRCdmNFP5QI2Fu1IS7UG8+Ct/T1IUROGekw
	SE2bFLD7ZaY7wvEG3KHPdEVU55fPlx2uW3WlZfWw93N/u5QpKa5EKgpytWmQDVle
	bV3AXbaYJbv/vxQVAJJhhw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2139.outbound.protection.outlook.com [40.107.92.139])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 494due099q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:46:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb7AAQNi9wPT7YpUmJnkG4ZDCHlymyNvHD8UMM0xYVm24b+UjBzyp4ezptX91Ef7+e1RlbnNoL5qptMtv+HyoJ+El9ylDZqoPP8W5+SK0T3QLU0GAcxd/uRM7MWukAHaX4FaCH5+HcEEXPVPQpf5s/VshvzUI+VGNnNY2w6eha1HpQOla51nThbGhBWfWKcGPFxUNO9MhoYEF0oTuKvg3vAt5ETt/QHGzGkZx9um76Bc25in0oPZv3KEYrt0DW0x3i6mAu56NEvVwcLFh0shCBfYfG35IbIOg0XykgmWPI7BRpX/ylUUu2YNamCKK/2KPqBuArQKi9d2I+pesaqaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1DsybW3NZqMAzLrKvgIt1J5ziTHhieST30kVUsXLHY=;
 b=d/FVAC7JOs+SDNGtTCfFhPNwcet+GYCpeeEb0ajfnpD4KYwy4uA1gPyapLwID/dcdfQI9BDhiXNUDfFXlHtEIxD7e5Sp+Agft7FjLN3nkyj1ug9ZyWt8IRSzi2CFqyxOFfsbnWyNLlV4Ia5JbeCJgGRdGeFEMN9k6CXt8d4LAj47aSPdq6orp7WwcNi7HGFTxjfTLnLZx+ZtOACvtp1NbgTLvXSe5vlL81xoGVbEo293qdy1sxrHK+AquXA/9DGNnNWbO9OsNgVe5Q01NB190ZsWh6jgG5o28cO6vBikLxr7ZaAbcG/uNBuQHJBc4q4pfGq6JXMfNV2oR29m6OfL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1DsybW3NZqMAzLrKvgIt1J5ziTHhieST30kVUsXLHY=;
 b=Io/777juaotywcaOePeB+X1b6C9O0EIrRUwmY0+1wxoaa33lQZ7h2FuRXkb/BizTLJ4AzmA5Vt6yK1ZG48Js41zSyr58jcfUwTzTPD49+dQ1S5y9C0eTHAjO0tCTJzGrnOamdqR8Fy55vhypEdPZvUn8aXVmiA3tLndzBTPXjd4=
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by PH8PR19MB7096.namprd19.prod.outlook.com (2603:10b6:510:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 12 Sep
 2025 10:46:48 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::f8) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 10:46:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 858D1406542;
	Fri, 12 Sep 2025 10:46:45 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4CF49822548;
	Fri, 12 Sep 2025 10:46:45 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id property
Date: Fri, 12 Sep 2025 11:45:37 +0100
Message-ID: <20250912104612.361125-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH8PR19MB7096:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57905b20-39cf-4be2-1cb3-08ddf1e9ac06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzU3vCcxWjBZUpymh/MOFwg5H+XI48YI/4FASVXphBg90TRDycMrkqxvtocn?=
 =?us-ascii?Q?oWFl+dW9J4wKBHTqSwbHOBNz8IHKvk+bPeIVWlj1MtNjH52GITQ/FkcVzGYt?=
 =?us-ascii?Q?NBRtEVjSt/7YW2OVf5whKzKTGfrP6YeroIBTL6j+s+TltJp5LePoG+VajS6d?=
 =?us-ascii?Q?ed5Nrsgl7a+XrWo+qOA0JhkGf+plZSmlm3Lgndz+eD/1ypPvYsnc4sCzQKrN?=
 =?us-ascii?Q?BQcMLOdh3IH+O9FJwAf5+G1CM1qPkXKi1ctnJh7cdMEs/++vxTPZZ+d8mLo9?=
 =?us-ascii?Q?t+uFhrOyHw6bvD8Nu1wo3G/uQ1Le3frdGr5RREgTBnH3bah2l+UbA7f3g5ei?=
 =?us-ascii?Q?I7b/WqJrrgF4M7586Ju9t0MmNFPojF9sdaQg3SabMgkLVjj3B6v19NKoib5F?=
 =?us-ascii?Q?6BxvZ8dQKllQBqeVD02mQG8MWnn++6DQRJPK++7W5zbhkEADJN10S+xvTnDa?=
 =?us-ascii?Q?HnY+JAr92Xnstj29P+CNyIeMuMWSbsjDKMXr3QP5ePm8EMMNusHuWdxRMLrd?=
 =?us-ascii?Q?T8U5b5IWSFjE8QG0/PjCceJN4OMltYsNBIPKD+3KtpNZSlqbMOmkOBsPTOXL?=
 =?us-ascii?Q?J50svR8YulRilh6K3ZlNp2XkxKPJNkSdlL0Domp85gC/mG6Chq8OH9Rz/+CF?=
 =?us-ascii?Q?WB4fTUMZeqYdWLo4z/BVv8DnoIrFKYoZp74vamrDw9LbkKGLFylQkIpC0MT3?=
 =?us-ascii?Q?qKAI/WFqjEWsKCngDFWktLNxXvv4rT1QKCOyEy+HDHhBc3WwBuNvfM055d3G?=
 =?us-ascii?Q?EYvgN/t8ajGegH6iL7oiWsOUhhj3iyuaeUAbToFd/Tt5+Pro+dPy/OdPj4O9?=
 =?us-ascii?Q?ylavR/PciPRNt60S1qNCzdfmwHCa2qfFHm26rMuLlcZAVQkvlWXbBs8k3Cdh?=
 =?us-ascii?Q?6RbcbPhru6Gu8mnsL5jnqjJRt9nX5t3A+BehZOqLmrH63hiR+2ZdtHhcrqxx?=
 =?us-ascii?Q?j9uvFuCO9nu/Xp0lXDo9ISN/hEnmFBakrZkEuUQfAP2sMANkIiYoTp0szqnP?=
 =?us-ascii?Q?5Xb7x4ESCRkPsXJJq4M7xSTCGKwbU21zofL68LY5ByipCaK32jLWe5pj1wNW?=
 =?us-ascii?Q?oxABUizbddvM5VlxYIIlznakNQu66ybAtwdzJdRS6i56bim/11pWfmD170Ht?=
 =?us-ascii?Q?DkvuGBv5ILdsfcgOAt+NLXB6hPy32qgUVYZ/LFUJU37RZtxo+5rHlUogu6Ga?=
 =?us-ascii?Q?wd0GL/qOffv+/vFn0mi/fPj2DUapKOurVoMEMzcLoG5TN7TFNMXFCLdOVbcF?=
 =?us-ascii?Q?HooKUmuE/g9Tp6nI8PnvYc/rED6oEC/UnIRl9Jjv9nihxG3ay2qRMTWweUE9?=
 =?us-ascii?Q?6+IqKOuT0kOkvaqzpgs/bxRHZ7jjPunln0yyj6EHOqbo85bS0guFckoKSPEV?=
 =?us-ascii?Q?/L/UpB8Ti4fwixmZm9jCldpBnEMgAuIJ4n6pYTZ5ZgLs/3E/anZNtB4wn7OY?=
 =?us-ascii?Q?yXlvCwAHlydTSfZgJCW2HyCu3eeH/2iLZQHhyNWCyI7UTfDrRUnTIMIwajuY?=
 =?us-ascii?Q?og2Nf5Oo2rsbUAxBy5R66ao3qlTtbthqY6wY?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:46:47.0086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57905b20-39cf-4be2-1cb3-08ddf1e9ac06
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7096
X-Proofpoint-ORIG-GUID: 3rUJpoolFgCZH4TyXIowNDZRtAQAcEoh
X-Authority-Analysis: v=2.4 cv=F9NXdrhN c=1 sm=1 tr=0 ts=68c3fa1d cx=c_pps
 a=CSn50b8RGEFHcAyh4RVFkA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=0ppagkgUUUj6NgXC_5sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwMCBTYWx0ZWRfX5CEWD71TEXU5
 3Pa4wqLCUKdEEOnTNXftV+t6ArIBb9i5MXEzoAeorlR29Fj8JyEhvPbY9AgLpLuOyQ0x4dCf9/x
 ZdCt1A74v24kxwLtH7K6lZDX0O1yOlZBtLkE2JrrOSb1zZh8ydZbDTFv/GThvgirNcyKsbtYm2T
 ZBTLvxDKpaA4TIusNwe0V/lfMlVyVoalp+O8xLmR+aYTjHvPxPSHxDwgxMC4PRtLs12/xxOgF5h
 3riMFbTnYmWMp3Pth9bcGU5VC/avbVBhTCEl2wifVxd76mqRGWS1+ccgrw8Gx07LAL5w9tRnlWO
 6WMCKNYCOhMU7cYsCkOq7xdoxEwaNmpq9wKVQYUR+DS3isDUR9g6iu4o4ylTm0=
X-Proofpoint-GUID: 3rUJpoolFgCZH4TyXIowNDZRtAQAcEoh
X-Proofpoint-Spam-Reason: safe

Add new property: cirrus,subsystem-id
This new property is used to uniquely identify the system if device
tree is used, to allow the driver to select the correct firmware and
tuning for the system.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 14dea1feefc5..a9eb9bd7ad9c 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -151,6 +151,12 @@ properties:
     minimum: 0
     maximum: 5
 
+  cirrus,subsystem-id:
+    description:
+      Subsystem ID. If this property is present, it sets the system name,
+      used to identify the firmware and tuning to load.
+    type: string
+
 required:
   - compatible
   - reg
-- 
2.43.0



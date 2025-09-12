Return-Path: <linux-kernel+bounces-814434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38926B55410
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A1E7A4CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C0259C9C;
	Fri, 12 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EbXXuYnO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="aA92s82O"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CC23C8CD;
	Fri, 12 Sep 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692101; cv=fail; b=YsIUdLn50ROcZzgfJMPcG+WRfGcWq3EjzZRUvTyrTvhAISgFl07VbDbUcIq9GCfP0+jqfQUe1T8VAmQH/4i+P/Rc6H1BrKR6hN+W61jUJ1K7RvXCBoaOKjEvlXzJBVMsPbwmvnnnqWHnlgME+t7LwZFTs3zhvvJrCi4iV2y2EZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692101; c=relaxed/simple;
	bh=1/zSuMZAyT+s4GkuNDfHmBgROLKXVWlmMONU+/27Fzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsreSlFRhJBRY1n3HzMW2jGG0iGjKM9YFMY05OMrNYBeowYfn7PEmepiMcblmNTIlkGt9Yjc+5IIlOJUAm9f+ka6X77Ika+TtYRuEt+K4DQ/h/xTfiGkRDBjf/4TCQhB0NPTaAMrd1uJxUncLmQLwseWBEsDRmteeVDQTNLYAfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EbXXuYnO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=aA92s82O; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58CFb2Lt643006;
	Fri, 12 Sep 2025 10:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=x2TQ60a1xMDY//xKwOTZkEz3RfAt7+UF0yrzkFIBZhE=; b=
	EbXXuYnOyv5AvE5wGn5FD9hEFX6nRlOMCYPJWJKEBy6Kq/k6AqH9Dicg0YGEhvxE
	GEmBGKQusWI4Kmu4bnVVGxn6yCsgn68tcbMnt4ZsawKmg1kNMI8i71zCM7cU1iHs
	kSemzDkERBCSrfKva8BdNdbj1ElVICk//mm6CkiZrnY3woKqc727PavFZODOGn6y
	JLc7mfsuOXpt+TZpKgdnQN7jhNYCLHUahvL95Ckj6Q4RNyO28EPdjQ2kpxrv6JY+
	Km68sVqkAOZQGcV/FvWAvWjUWTOrNSFy9hHW3S5DKnFwROBW0IcJ6/5/TDPWk6x1
	VRcsq6e2f8fCn21fqHuvIw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 492q6td5yd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:48:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxShsQ0gKYi02n58jaF0fKZj+vNlmz44qUaRB/xTt+GjLfEGOISyqEXcgEfBcIVy/aV6fzSXeKwQfZZxws0SVlld1DUJ2e/qj7WxIl43/bME1FrtzBEawb+9878K5ZvBFvEb6wUSOjSctOIhQeu49A/UxyIjyyrPs2bd/klzwmgBoqdTuHW5A05YWBy6Nof2p4EMppfXf46aAVnszh6c42XKR1V4D4rOclceHz8q61wIDueCPFUOXPaAq0jV+HI/yxe/xqiGpUYJ7B44wBdQLkrr4YzTPttYv+GbUa3Su9WCYqi/TEhGQPjfyou8tLL3jmlTpQBvqcmYQA36BLWJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2TQ60a1xMDY//xKwOTZkEz3RfAt7+UF0yrzkFIBZhE=;
 b=qpAPZqxOc9fSfz2psS5YDchKYZs6pmBey22f3kaigNh3QNkKFcsUWS4ecBzpCogVR/D74udyOiLPDJ6AI7Sqea+VxYNpUhM5SErRUjjkoEjnFvvsRdpYEU3AiuO6ZTRT83gWB4VEeWm1Q48Px9X/qs9KVsjGHRYSCw1AHoJfnNLkPQC4h98ZR3dEB8uYzW4hFxhE/W2fJL2fIYwilPHq7CKW40PApYeDlgjeFhyINeQfIece4du9252SueBOZdcseQaN1W1qwAB1HmfbOQUL6zt/A5dhzrAdKowCBAH7uiXg0/IlH/LrqEbkwoXwLy5AVPEWOU/s0budbZI82s5Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2TQ60a1xMDY//xKwOTZkEz3RfAt7+UF0yrzkFIBZhE=;
 b=aA92s82O7NebSzXUYVYinbqsPZxBPyd6ktQd9kyJKLxybKDmtlelFdw4/K/oPcWdqCrpD5XU7yeA7SHSsfH8S2ytetFT15BWJUqGNrpANwikiMPBRfuHxJjfPFM4jAc+n/36wEiNmeqjfU0Tq28NEWqXRQn9p/mVL9Cqy8B2cng=
Received: from DS7P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::19) by
 SJ0PR19MB4478.namprd19.prod.outlook.com (2603:10b6:a03:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:48:12 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::d0) by DS7P220CA0027.outlook.office365.com
 (2603:10b6:8:223::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 15:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Fri, 12 Sep 2025 15:48:10 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B9E63406542;
	Fri, 12 Sep 2025 15:48:09 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7E91682025A;
	Fri, 12 Sep 2025 15:48:09 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id property
Date: Fri, 12 Sep 2025 16:47:44 +0100
Message-ID: <20250912154759.279661-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912154759.279661-1-sbinding@opensource.cirrus.com>
References: <20250912154759.279661-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SJ0PR19MB4478:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cfb5fa54-668b-4e4e-7532-08ddf213c6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KfNgAPy3n0VD4fIPWaWI3GQ3dgdrNhB8SRY2R0NGEGJmWyW7c5QHVVYYiAcr?=
 =?us-ascii?Q?dSTxSIXZPm9Syrq11EAu/2XjkV9lTZpVm4OLJJuKENYZkY7WHOcPdVVuiPb6?=
 =?us-ascii?Q?AEeJLNVR9QLekgRevY3ceF7KOwSn8ppttDuREu7KJA7edHKuEclOBJzjbVk9?=
 =?us-ascii?Q?4QL6WDA1090FXQUtJCrtfgoqN+7hhN0y+6rZ6RB9WChUmUo0FFGrU8zKzQXn?=
 =?us-ascii?Q?x6AyYtKwSswNCvJxJnU23605pAN6QL+3KVKy/smjryiPcjxbMDFrgFg1CNa3?=
 =?us-ascii?Q?C7iOXsQLukJqZ8eXltFZsvrhTedf3wFpjIjTypTDBRzGV0TrKJejVCUcfuPU?=
 =?us-ascii?Q?1uVj+/fcBvkH8w+MzSLKS7f0SSP+DVG2Vc08DHL1BPrAIcyKDmgwgYdf0ymi?=
 =?us-ascii?Q?lGgcDtB6N+j7DlJmk7s0SJYK6Ma/ugmjQh0khkyWB1vJkFs1wOtFlkFRr4OE?=
 =?us-ascii?Q?vxWZgsYdmibBDkzqGrwLH/DwVuFRTOmLpgs0s+kuxYF2OxZN+GR8SJ3+B1pF?=
 =?us-ascii?Q?xrJ4bMlE6W8H0tSGo7g7Ibi8lgGUO3ZkX/WsPMAvECWQBv0PWUbUSgzAC+zt?=
 =?us-ascii?Q?WpDJyuQQjSnLr9FAbhcg4s8z+Y9A8aK53TqXrAq4hYcT0Kc8sQHwPe4pWlBH?=
 =?us-ascii?Q?lernSeMgPpnQYt38Dy5PtKYa1m/Z6K+38jSAl3FvyiUWEnChV59dYOKGnETn?=
 =?us-ascii?Q?lkkkh3bSpq/9/gwU6T80OBe5a8u6wAwBXA2L/yKzzJRQXchiJqmnJ9ls9XDJ?=
 =?us-ascii?Q?Iu01ex4ss/XfrxL3uA5K+OZ3TqqMDcSVH485nTPfLYMG7hAW8JckHiO2xH5t?=
 =?us-ascii?Q?X0ownHOERp/vVFUqKTaneDvnhMGUVfIq1MRYBfQtzYAgLuxlgpjF8TFhQsR3?=
 =?us-ascii?Q?J4XYFqZxwg58QrRRBrNqNkJvYxP43nxCuZaLV1+nRbpxp3kFKEigbGpbhWaN?=
 =?us-ascii?Q?+D5StIqBuxg03p0oXwEf8k73kLgjCun3SMk3/KkG4goW7bQR0J2t2jERc8Le?=
 =?us-ascii?Q?4vQn4hENUnnlyNLuwZoTPABZirKXoSc1Otiaf/vGmFzMYsGEYz0Hr+FXIBjE?=
 =?us-ascii?Q?ci/OrLCO1KyXn8iOrWNrEvWZ40qPkWxeHaSDdCHoySpPevcEmzbTCl+2JYxf?=
 =?us-ascii?Q?DhpvxdNH05H/iNXOpejmBx5i/PqKi1NIUN5cV06yu4RD8Q/R1sJipsrqeTTt?=
 =?us-ascii?Q?QlMChRqbyJ2AYkI6n7qkxbLh1sN708iwlQEeEYKKZJKgpYuj+iHgCJLpngKt?=
 =?us-ascii?Q?+zzYO2qhhHtm6kyPYd44JFP9PHbpTcld+yf0zIxAgNlqQuLYqT1G8qRcze7U?=
 =?us-ascii?Q?CHCNpQL+td8Arux9TEVqZ69hh9lsYZQkCyWQqBV/3WMTfSTAmhRfXo6nobou?=
 =?us-ascii?Q?rLzc68cZZOqUAp+0E+6ztIPLCge99Z5Y5HhFUbiQkRhgqtue4H08FtSZlTbJ?=
 =?us-ascii?Q?w4lPNGFrr4V5mZTW+LYFOwKBS8FWvKZSadvLCIcveJ2OTx65Z9V8afc3BJ+P?=
 =?us-ascii?Q?FyFFKUxZ0PpYeUn0xIO5UXNJCtsnWD9dBufw?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:48:10.8917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb5fa54-668b-4e4e-7532-08ddf213c6e1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4478
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDE0NyBTYWx0ZWRfX5Jz1aKnWpgve
 h84S30rNJ7WPcMoN+xkVFEjqNyf63jC7cY+6Z6zwiLNe7XLwhosrH4ZXbFrSRMUFw0ccnaUYWjf
 nulJQIQeq/RJ8q9IT8C/9EfmmPJl/3kpaaJzsKrkq23mmr4A1loHiv+QCAq1M6TL6vLjTRnSFWV
 oUZI9EkgCun8GjPaJqSXQkBqJcCa+nlMC1YBc7x/8mc/bXTOqXtrTmRRH8pdeGZDkNf/j2gVL69
 eJkn1vxg4VvCgxQrP2dthujjpTHoOr05qdYy6QTQCRoGCix2Z0pnB7rxliSaVFNzGV6NvYCqV6i
 PogFxg4klmfTex3eubR9CcGl3uPdzrpqkJdXTlkqWy8EJ58vTNTyw1x9KJ3fO0=
X-Proofpoint-GUID: mihHy2QxKY10x9j3M65amatav1Xd-Dbn
X-Authority-Analysis: v=2.4 cv=X71SKHTe c=1 sm=1 tr=0 ts=68c440bf cx=c_pps
 a=rpzdijBBfSkI3xxH5MEd0g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=pTMMdCdBRh1H00hwDNUA:9
X-Proofpoint-ORIG-GUID: mihHy2QxKY10x9j3M65amatav1Xd-Dbn
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
index 14dea1feefc5..e6cf2ebcd777 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -151,6 +151,12 @@ properties:
     minimum: 0
     maximum: 5
 
+  cirrus,subsystem-id:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Subsystem ID. If this property is present, it sets the system name,
+      used to identify the firmware and tuning to load.
+
 required:
   - compatible
   - reg
-- 
2.43.0



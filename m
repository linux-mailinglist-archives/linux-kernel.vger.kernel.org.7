Return-Path: <linux-kernel+bounces-821202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47857B80B54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9824F62199E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB0A336294;
	Wed, 17 Sep 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OG1nAHx2";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="KwPg02Dx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB031321270;
	Wed, 17 Sep 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123825; cv=fail; b=j5II7FoySFkHjB8MaERE6K5QJkcHp2fOxcm85V+WIK9z3usn5S2khn8rkaqDAVWgYH+zwsf4exCgpnKxNvNGkgC3f6AgXP4oW6F2VfHDt6cDlIMKtYBYPBszblID5YWm/jTC9bWApb2eYRpeACtRu6CmaKd/icSOM8+9XhywGMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123825; c=relaxed/simple;
	bh=hb9k9GIiOLV4EqtNlX0bvO2OPBH7h/3vknX8bFP+kKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkNu0sA8jYQ4JnwIhzdfVPza6aF8mMhev03H826ZpTRi1/VReE39HWRTT4EbTp1JnbGJkKofpcSP6+1CoYD4IhjxiGcedXp5IEV2m3RpSALngodKtwUaeaNLTaihO18D+Wa91ikmEgqlqDuR7E3QS7VVcuTBpGoBytkMBAQ/l9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OG1nAHx2; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=KwPg02Dx; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58HB3h4d2718932;
	Wed, 17 Sep 2025 10:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UGwGFK7zg49rvcd4vRo4ph0J9LpOaUGovnHas9zl3kk=; b=
	OG1nAHx2hoD7mbYneFwHiFiz2/OM8sNTXcEBK/IJay0GvdZWYru/iXXpYq04wwUs
	6B5YYQ7eQ2jaFUFl6LVzyrNTD7G4bk8t98NhJwA7P/0t6pxTKsgK6o/tyT4YzVYv
	UKhCKoG1K4HwMkvop/jsZNXMNb92EOSvyQtFQ4COtemPhrdZh5hMwBer6xiOJNAS
	Q9Cd2c3n+H3xMhdLyKA320xmjsDl+DFt9vMVk2dXKDwL6UgdhY0XB/I5VAzIKwtl
	/vX5dEz6DhaiVoRVH8pJ2JNxWN8koSeg6g39tHoWNFSoptaPrKL/NjZpwRTIv8kT
	Hsl9tabjUrqqcA2FhOopyg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2108.outbound.protection.outlook.com [40.107.100.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 497fyks9sy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 10:43:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiF/Ch79QgmHC7VDto5Gk2kUB/GjUESxP9RCyeNmSRVQc7YtaBo5tTBr0VCZnDDaFv7Mj7A3SjChmObT/loWiL/W+yt029LJyWt1M7McwvJCRTiLseXeOo6EKCcc2MOcjWInKiJ7UCYMYa+em6H85/E3T5yUw2PR5AttwUieI/enIWNGX7JdiSjMgTGspuxu5KSfwCEDWOPgkmKnVM6mWbcENCIxAyfHFQ8geM43EXq6IucfNAdVhn4qvCRpEcWC8238mSNJ6OHaFU5ohGunpyVHgAFdq13vFhBlK12eKpcSlu1hQG9nIaK6gmJYPnbSEHUXRn37k/ZmigvcPVimjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGwGFK7zg49rvcd4vRo4ph0J9LpOaUGovnHas9zl3kk=;
 b=xW49bSG8ljSJbk1Y52DJdm9AYqerPGBx6oBH0waiSwx73jVGjr2P0fGzRsfo4WWzuqPbOhZRSqoOOz59JamCQURrEK4S7moUPxzqKjIOZvAgF8BBaqMeC50QRgIM3i+EIdQbuEXoVZCXr1ceQuyPfHNX7xhWZ6n5Ex2hAz5z1FRELEKN0XjU6zr+54fwqmhNMHHTT0JkB37RIX8tihyjClhC6jhfo9T2BDau/L1XCQsOFKCxK9Gt5pgTkrl0Adj5jTA84HLGMQu7xQ+crM9MCbAHagB6yMWMmz65KWo4YwZhRZrDwukMiOIF1Q08S7FN4LZ5hjVYQi5JgpK8iM5Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGwGFK7zg49rvcd4vRo4ph0J9LpOaUGovnHas9zl3kk=;
 b=KwPg02DxLH7mhn/z+/a+dsATB3FEN7TdbyxGNB+SQZFl7z2ts06xNb3yQyiRCy3D2w3ncmeD8eovvXOSJWqSPnob+UTLL3SQkOgPVPcvqADC46pMWc2Qf7f3MWJGSwkFaxjOIovTMFUa0mEvXFVM4IXfroNXHf4c0zK53rP9ZQQ=
Received: from CH5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:1f1::24)
 by SA6PR19MB8537.namprd19.prod.outlook.com (2603:10b6:806:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 15:37:32 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9f) by CH5PR03CA0005.outlook.office365.com
 (2603:10b6:610:1f1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 15:37:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1468F406544;
	Wed, 17 Sep 2025 15:37:31 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CDD7E82254A;
	Wed, 17 Sep 2025 15:37:30 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id property
Date: Wed, 17 Sep 2025 16:37:11 +0100
Message-ID: <20250917153722.94978-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
References: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA6PR19MB8537:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90b0a11e-5a7f-44aa-4f89-08ddf6001e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1BXv+mR3ZkTcerSIIfpNwf8Eat0qL0aIi/zf0UNdBgguWBnp1lfCrcPGSnq?=
 =?us-ascii?Q?VaIsfnvGe0noY2P7ysryAbr/WcqpzA/EL/b7v6euW0zGsO8VYW2SKyzrfFdO?=
 =?us-ascii?Q?1AMXUqV6JZEBkAeqWsUcoXRU9Q3OOQfv+14ktxQfvo3+KdXOWrjH+NZP7fAQ?=
 =?us-ascii?Q?AnKFPnr5/LmoUF+3u/ODXb3Y8iEAJF0OwsEjByzkeHXGQepuITZzVVubmvRj?=
 =?us-ascii?Q?8IaLOMc7DXGV+BTwS4iZdcOV4RV3IyImEAS+vfqxX5Z/m1LztiIuT1kbCC5R?=
 =?us-ascii?Q?2fdmJWQhU3i15wSg+vieqGM/Vf2N9lvKamdbZiKJDmZdBV/7Y+6g6uXW3qNQ?=
 =?us-ascii?Q?K3bl8FBQVKHRU5Jv6+9BLVzA8urc8bN8hmZ84GO1ogRDZbYVjmTPmJtPmYiP?=
 =?us-ascii?Q?HaSnVLU0/91T1F9d7jyI7JuKfn2xk8WQtBZfY4kR2c2N1oTM+ZxT8cqfLJot?=
 =?us-ascii?Q?6+BMjHxBT9PVQ+8KpLEggij20GJnZ1iyBRBFDvIcRE4SwBzULmMQWd5CwD/y?=
 =?us-ascii?Q?vKiJ3Q7GwEvbdOwv35OUMmMHtsUnRxV9BWRtuWUNkvm7N6zylNS8VDz1Fhfi?=
 =?us-ascii?Q?fLAOdw4EtzBQ5ApOY5XlZl3YExTFMhBqtDjC59sWq/XlKlIA/X3hMC6V2sOl?=
 =?us-ascii?Q?OjcLASyd77Gf05ew+FeEztoXHyhA/un5kNkZqF/JeJ9HUlfT6Sl4LsWPWPQ2?=
 =?us-ascii?Q?a0um37FtsQfRevm39oKgAPvuG0x+M3+hPc0TR//BaQdIIhRY4P9JQlYjbUnD?=
 =?us-ascii?Q?56silJUUSegDWkxbCFA4Gw1QldgIBYkX5Ltq4lKdpaGRRjy3kOw4igg490nl?=
 =?us-ascii?Q?+YqBlWtcb1VYOKSKZ152Drlcwg9SG/Qd0Hu0X5NVGy78rHgrdXvvCqIkZTVW?=
 =?us-ascii?Q?p32VXIFIHiHABtc2b+PuPwUiBgfp+qHY6UPjoW/GbMrRb7DRCws+yh7fbtZW?=
 =?us-ascii?Q?6lV4ASwupG6zq7ALG4O7osucx+ChKE5GM9IP2EvxDO8zIjmoF2QT97FMCGm4?=
 =?us-ascii?Q?8Sec3e04cB+FHtCILr9yVV1+wt2PNzxLPgqmKR3+jWfZbcUYEOFtQDel7tD5?=
 =?us-ascii?Q?IfsG4LvsU0r76783KXFJB74+AVrzJZbL8V+wZcITz2sk68V+zLgrZxE9e3QX?=
 =?us-ascii?Q?jzf5V0OcyQir+lxB9eoWYezK9Vg5xw8LJp7oXwBXHge6ywAZZeiq+IaM9YrF?=
 =?us-ascii?Q?JuUwQmjpsF3lxLOp2IkTvofgL+CprrShE/A5yjweNufLBGL4XeIhST0Ca26W?=
 =?us-ascii?Q?qctOTsAbKdpOXnyny6Hn+rjOX4S3FRINHaNPbiCAPee/sAilllJs8yw/s16H?=
 =?us-ascii?Q?XC0Esz7fA7VndabWBdo1HRrupWUE6MFTV1Jtm/UBMxIHCglzl2Wtdib6CPUX?=
 =?us-ascii?Q?oOeyAp/JPwOXeUBP2adzkxUszWTSoJkgq4fgOnPmDOWc1ls2nQcojAiEa3KO?=
 =?us-ascii?Q?5WzykS6IRZlsmYG0gYY0Sx8mGGyTArrtoTeg5noC6h5Dg59QXHFlG+cSj5Jf?=
 =?us-ascii?Q?fdG4r76h5Eys/8MaJ82b6QwPuZc4wFN1H+KQ?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:37:31.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b0a11e-5a7f-44aa-4f89-08ddf6001e1f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8537
X-Proofpoint-GUID: z_T-o6_oAwZ-dm9_M0uQa-feoGxhISHE
X-Proofpoint-ORIG-GUID: z_T-o6_oAwZ-dm9_M0uQa-feoGxhISHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE1MyBTYWx0ZWRfX/OzH0XDZVSuk
 +YyVMsKnCHKmILWYL84mcR1PPpqhAGxl8AmDoUmlUi0GXJgG+ivPPQAOyOUnMQOgNqNQOHTxIjd
 Dg10ZgeibaKNk/j0cnWkWxVHYPNQBmX5o+nZd2M/RI2ewFR+j2CWInrfd2hlAUtPc0ei8h+rwFm
 mLMDjrjQTTKlUxBmoqhpW0b3QuMYKMMIXA3g4nBj6dr3HK76gJQeJE1h55m1yaQocdOmf8etu9f
 WzNwSzXCAkiNddd4fHGjh4UjPILlhmVjMq9jI1roVVYBAgzdZbyTit0c8tU7ozY2tuYWpaPoR5g
 1z6zZssgz6K7GLUGmTTLL4N/0dulpW1F65KpeD6v7fiQJ+w64hXnxK5alaBE+0=
X-Authority-Analysis: v=2.4 cv=KvRN2XWN c=1 sm=1 tr=0 ts=68cad72b cx=c_pps
 a=jQSJrZTB3+cRIPJ8FcCqfA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=pTMMdCdBRh1H00hwDNUA:9
X-Proofpoint-Spam-Reason: safe

Add new property: cirrus,subsystem-id
This new property is used to uniquely identify the system if device
tree is used, to allow the driver to select the correct firmware and
tuning for the system.

The DSP driver searches for a compatible firmware (and tuning) based on
what it is able to read from the hardware.

However, the SSID is based on the system, and cannot be read from the
hardware, therefore it needs to be read from the Device Tree.

On ACPI-based systems, it is able to read this from the ACPI _SUB
property, and to maintain compatibility with the driver between ACPI
and Device Tree systems we need an equivalent property.

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



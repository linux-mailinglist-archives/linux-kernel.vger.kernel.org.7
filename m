Return-Path: <linux-kernel+bounces-777922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF340B2DF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528E13B171F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE18275878;
	Wed, 20 Aug 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HSvSH+Sv";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="do4AONlN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D42749DC;
	Wed, 20 Aug 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699758; cv=fail; b=TZzStOSMfH2Px/S70dJx5gmStZB7mfJpUfyLVqEEqlNvmJHJFI8SaIh8Pt7xzN0MheYtXG4f+zc+5o2QcwWJZEwq0yxwCbi4sBU7vcKbQBfBrsA41oC8dUf3YoizcUq7HMnCwqDR2IPHldsvnboZJLhDkLNREzqIA7+WXQVjTQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699758; c=relaxed/simple;
	bh=GS029dBGkUJ5wcU+SMmuG1dTaS7p3HGmvJXmbGYxgAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COWLvqHcML4x3NcHhbDpIggUbpNvQqP87zGd2daVheaxab81ev1e91F4520o+muyf6bBXpiuH6ON+QmHmyk4/T/J5bQWqBMfxvrKwgsPWXm9kWtVwkqiYgLPuTXwxfOBIQRibPl20EOpZlHYLQOSVFLa2UZtfhzuxUq8P7jEL9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HSvSH+Sv; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=do4AONlN; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJZ5mq732100;
	Wed, 20 Aug 2025 09:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=e9NS5kNU27Tt7turoCZde94e0Hvdmv+pGQEiOI3SXMc=; b=
	HSvSH+SvkVhAEks4eiMWlSR0gAK3aTbRjkmkLpJUPo+v5tlAD6sf+uWdBfEQVKje
	0h/dR58/5NHspH+iXcVBwcz5HUZIFr7nF+hFPzKKQeri6QsjUfCnubBmGoaEzEGo
	YJp35noxPcPPM4BvNeitaabj+TlhDq1LUdrP8AvIn2DCyWtEJj8QqG+rV+GtYdMd
	2U9CnXkVV26PyomDBOyLp8WTIMTSYdlTZ0mD5Ay4e66N4wid61GUMVKH77mxf4Nv
	uLlIwpFLVP/iXXQFwwqYeq5gEVnyG63zZaSRQbluMjwjKGkvrdl0PGBf3xrltQ5+
	scjhz1/xv8zMNNvkBlpNPQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2117.outbound.protection.outlook.com [40.107.93.117])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48myd59c7r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:22:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFkKL9vPgefe+s3AGQlGcd1MkpPfyDMo1vhRpkTrdPvLtW39OoyoGsaGMO3NtsPpPqJeU6Kz0CfNye5SC9XS2XW4O3UZIYwMUNk8cBzZV2TS8/4ZtGF42ZSYFztgQK/xfUvnS8+A3fadyey7RRTD9FvXvO65rNytHSfIfi/Q/4aPOFS9Nr8IEdeYGFutSAebDbbXh1d05LGHHIuGpVHhUmj8tIqHK9kmGDmE7jo86o4z6N9gMMYu/WMWcsqNitSdkLYgmiGlGk+pxHgc7OVlqWn5RkfSvqXEG9vbTO5B5BQiPHyAW9IBZ2WrIw7x2E1pSiOIAXVkJbklBCx/ZN0Xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9NS5kNU27Tt7turoCZde94e0Hvdmv+pGQEiOI3SXMc=;
 b=FgF1Tx/qgVaDfz9efLdycCBlrwWZAyrJHwdvHGXwNXtYNnqml2/T69J3djD6806ks6yr+80kL9DYNPv2vknRhoNLvQWJdaZK1MJVIHbrGLSjdFxiJz+NvO+arJApZo5z9wSbhYoCio5MSXYbo646RsY6yxFg2xpBv4Iqi6b38v+YK7Miyxo1ndnLydIxPuJwyVg+Gyo72bULIvHSnpp0d3xlpaOC2vfYz3NQNI5R3gkIA5dItzi2ij5AYtPQ521+oiS1HGdskraRNH8LLq4rPmJDG/4LF1E8Yts0O5O/MirnhYmYUGQV7GEnGhcsPoflhK/qIfstG+fETkCmeHnvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9NS5kNU27Tt7turoCZde94e0Hvdmv+pGQEiOI3SXMc=;
 b=do4AONlN3wVxtpf0Hy8eBDrjRq7VRaD/imGeakOk1T5+qf8uPOtLwLmbzmKe2DFHZQJWgA9FjYlO1G0mOxkZVRQ6wb8JEueyTyzVFujNqSJ17QX2fm1HCWyqL5ibgBk5isYIniCGOFC1rTyKST2IPKOn07SgSjyA19cVO2bExjI=
Received: from BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26) by
 DM8PR19MB5318.namprd19.prod.outlook.com (2603:10b6:8:9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 14:22:30 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::a3) by BYAPR01CA0013.outlook.office365.com
 (2603:10b6:a02:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.0
 via Frontend Transport; Wed, 20 Aug 2025 14:22:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B68A140654B;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8EC3382024B;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 1/3] ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production silicon
Date: Wed, 20 Aug 2025 15:22:00 +0100
Message-ID: <20250820142209.127575-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
References: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DM8PR19MB5318:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52924fac-1db2-435d-66e2-08dddff4fefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u6WG3YpSmr8WXVXjL9NhJrp4wL104Rnt+Ur4x54kfwIbl5qdzIGvaSLmOLl+?=
 =?us-ascii?Q?7lLlMLpJB0TmyNwPfsmmLaLbxSBG7vnbrqgZyJYUEzGcix7Zf1+/vP/A97cT?=
 =?us-ascii?Q?Z/P7Kqv+b1skhpelI6i+5s9eKQBl5uHc3Ki3Sgn+4pzP3jDMqoJsvklm3F8U?=
 =?us-ascii?Q?RaEF0A2P1kDmq3dbTTdctpjWY5fbMr1aXt4cdo4YdDt1OKQsHQknN/glv/fL?=
 =?us-ascii?Q?LAt88KkGwN9l7g6r8Fl2L7gfsQILxF3HKXBNYZOzmoX+DyZY4IVT+ySkQh4y?=
 =?us-ascii?Q?8f/KE9zJJxMoFmn/QsX3ByxrlNWwi7LKsA0tNYBw85pqxU6CadySYR1aJZfj?=
 =?us-ascii?Q?DXkC7wmdSXIZfn7/LA+8rrJVMb3IqmGwlRPI1JpRGydIL0TewSoraWJ1983E?=
 =?us-ascii?Q?/vb5JGZ/hbkns810h8gR4V7QV5saVTBTLQtzhBFw0DZtbKNgYsHF7LCE9r/P?=
 =?us-ascii?Q?DvOXDV8QnBoxeut1NTOaJzoiPWGQoMaTHaxLGu/orU8TM6oqKWw5kS3tDE+S?=
 =?us-ascii?Q?w6NMz+5jQbBn7CWeDjXG7CnflUsuPpEJ51WZL1S65lCJp+DYz9jwXLRvq6R3?=
 =?us-ascii?Q?YN4RZ3FJ4sXuRLm7WuROxIHT8pe3ZZ5YHN+AAHtgsnU+tlVOZ0k+OGFqyFhn?=
 =?us-ascii?Q?+gNLdqQkXqWcV0X1gmyHZleNWuVlSrP0aU3Qiiq8vTtbNff1+dUyAJCVU81B?=
 =?us-ascii?Q?njUxguylHsH9rA1ktf2kaL24zsFpPghEldktXDkTXcaigDMkaF7XSh7KznTF?=
 =?us-ascii?Q?wOX4ChEs3U8JXv6bU0aXXneHc9uNBgqnAPZ0OX40BTkMbxSB7vk7Exa15l3a?=
 =?us-ascii?Q?MjXExgekK6tVsz6oCRV8yPEyH4y2hvQDPH1xZri90XKU3VkdZnGNBTmR8z8z?=
 =?us-ascii?Q?oMUYrfGro42BUkK1J9JFVAPyH822+Z0AFAgLCY2+WL8nyK1ZNNV4SONi2aMs?=
 =?us-ascii?Q?xHcdcVpiF+8qlFWfo7I1b2ugR59c/AWgmna58mlbToZ39NURQBVVMlE9zasw?=
 =?us-ascii?Q?ND8hZbxUggYfSdNHygt10F4jIfSZF+HjTUkDf1Ls0nTIh0zci71NHk+YbiJt?=
 =?us-ascii?Q?KHsXLWKs3ScMauPS8UQEx9mwg7ebcjCfQw4MEjNik1txUOzBVRz9MNY6f3dB?=
 =?us-ascii?Q?fnBpcYgJKsfqH7uC0FxMh0RilxpreWl6k6+p+s3PBQdTffKOJA/5SiQb9FEZ?=
 =?us-ascii?Q?SURlp0Arn/goBly+096Zx6LS9IzpfryZtecXeGtn5UgaIbW7gz/Eh01auogg?=
 =?us-ascii?Q?UW8KgM/Nm+rmuNxECajSLfhrdun5IBfL3XjcFUzBZbyDPgiaPkunK6vUw70l?=
 =?us-ascii?Q?xE+lYgd36nJB6gO7+O/7E0dN3vFxix7ENqN1G/ASPYGNbMVhnpsNqHZJciOX?=
 =?us-ascii?Q?gDXmlZsd70W5KT4oXXoKij1B7wMs43iAVhflJNXZSIcJ95hqmwJJOyv6BvRG?=
 =?us-ascii?Q?bbhBY4zxdHWg3j3owsr7WWjMW4BG8j9TliqH1R+56r5eP0fH/hB7XihSzRnk?=
 =?us-ascii?Q?7v36ltJphtHW+WKY8vrIJ4NVyhKBoGD9ypbJ?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:22:29.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52924fac-1db2-435d-66e2-08dddff4fefb
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5318
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEyNyBTYWx0ZWRfX2gB6X40ni9tx
 kXefR5nCLAuHOKVsxKji64Kb/0WXytnQ8Xsm8CE+wf66YibgVvOoVTHJFsacX3P5YEUf7vKn1IM
 cy3ZLfo091QL+cji31QaSPi1m7IxpN5i7R+6SFi7NxwMRvZPIgYqj2wPWxbv1tu9EZEV8Qx3mKR
 nUYWeT8zFl/ckRoqy9RbWbtS9+w05eAr/kooQ8xGMZtQ0XMqfZ0oqVmSmIBrxaASb9b3Cu72lkT
 DhZspo6mjZnQvXLhDhDPxDJh675jOqhdPk+KUBz6OC0SpffxF6+F0AmREAke9TR3HDcz/uZF6uD
 LDdQA4MnHeXlFBjsGybxDydrHV1y9LnC3IMCUTI6EHDCunxVTr9FJ/Oc8zOYSpej4W0ylYfZdu7
 m5X+kr+Hr765Cm747bmZRMjibx5NTA==
X-Proofpoint-ORIG-GUID: k8VMv5mjsDTfGWXjHS5cvQtUeHzl7km7
X-Authority-Analysis: v=2.4 cv=EpWLbScA c=1 sm=1 tr=0 ts=68a5da29 cx=c_pps
 a=V5ewXRdnxiNdZ1vyn/l0PA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=x4YA3FrS6Vl5HCi3FGUA:9
X-Proofpoint-GUID: k8VMv5mjsDTfGWXjHS5cvQtUeHzl7km7
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. Update firmware addresses, which are different.

No product was ever released with pre-production silicon so there is no
need for the driver to include support for it.

Fixes: 978858791ced ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l56.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e17c4cadd04d..f44aabde805e 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -107,8 +107,8 @@
 #define CS35L56_DSP1_PMEM_5114				0x3804FE8
 
 #define CS35L63_DSP1_FW_VER				CS35L56_DSP1_FW_VER
-#define CS35L63_DSP1_HALO_STATE				0x280396C
-#define CS35L63_DSP1_PM_CUR_STATE			0x28042C8
+#define CS35L63_DSP1_HALO_STATE				0x2803C04
+#define CS35L63_DSP1_PM_CUR_STATE			0x2804518
 #define CS35L63_PROTECTION_STATUS			0x340009C
 #define CS35L63_TRANSDUCER_ACTUAL_PS			0x34000F4
 #define CS35L63_MAIN_RENDER_USER_MUTE			0x3400020
-- 
2.43.0



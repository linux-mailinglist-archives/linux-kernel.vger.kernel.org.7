Return-Path: <linux-kernel+bounces-856417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B013BE41DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C219C34DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F253451B0;
	Thu, 16 Oct 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="rETdjdNq";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Je1Ptm7T"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409372E425F;
	Thu, 16 Oct 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627233; cv=fail; b=F+GwdwQXwlbspBenLgu2Y/gtyBaPgrWKVwYw3SEhs60Bch4Nd9uWpSvHyNx3G785rWNf8EemV9eyWW2Pyq0GUS73KcSlPVS4oH2JoiZvQUBMIx5SpJhgEX/VmYvTiZdm7SmvJqDyZckE+3VE6p2AVu3LIF+DPdIpgtkV1F5O91E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627233; c=relaxed/simple;
	bh=j1/JfaUynQS5YhJdWhynXdxrAsl3zV1neejK/cIFmUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIMlQO1CUPLGJMrGwg2q3SOCFI0xknTqzMp2koN5CzC2P6Zf5FSXya/voyJWV+tYl/rcCt6blCi6iz8l/V8eF67TqZRcnQEkO4IZXPN3FfaF+AJ/gdfaON0roBsRKfUuj3PN3Z4DkdHfBLRc+CNYNwAChl70PbdRVTrAA1X20qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=rETdjdNq; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Je1Ptm7T; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFL94017904;
	Thu, 16 Oct 2025 10:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0Be4SjiecGpXAYgisOQlhoSOYRPo+Nmpv2hSgtWAfYA=; b=
	rETdjdNqcnmVHradJLyG5GZeC1xK9A94z3yah+rdwAINNQ7IlwVy378H1QJpNKsU
	sXL7dzoqUxE+DeVPULCum/5VyXhO4oKyfsk29N5PD85xbXKItPCc0VYdNHQhNXtF
	6pxtKVlObfy3UMYFbpngxAnD30iPVakttUxBhsgVXdDS7yLvlqWIBZHcI+2lryII
	gvJik61+YrDxFrg4BxeNn1pLdBOL/jNm/kwjg8M2IS9EmHL2Lc9KY5T4R8Tc7mA5
	bEh2aq/JoUKf+hY8bca0VH2PoXYQx5N2xtjQKCEj/rqeokKy59eAwEpc/VBMZnbJ
	dQB4ynUhzY+xDvrTNlJPVw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020136.outbound.protection.outlook.com [52.101.201.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mng588-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:07:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/Wy1TfDFomR23KrS3U2i+QO3MEcjDVXQydGsN2DY/a2CSyDyNVidAsrTkR/vLPYYlfTdtmrt530gjgSe/EjqP874TVnbtwPDqykkON03DaM9hWkSa/jzdj3VNTv7uuN8UA6fQwKHMc1LueCNNdKAZLjBVItPBQMeRlTYHPMszo57Z0Kyw5vaTAQPkh1Q54YkeSC5k+20hQeOXvHcctrzjZo9nNO3XiZIRUQJH5Sk2wLBB265bcEUGkcvY1MRLl4HwBl2G2KmpTjpaCTaUbRGSRueitz0nTEyyFBt7t/U5rPdcaOeK6PrzqhhedftX+NXLu6E+9+WNZmH2VR7j/KlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Be4SjiecGpXAYgisOQlhoSOYRPo+Nmpv2hSgtWAfYA=;
 b=pv2mWrMfzTg0FiWwEWz1hL7sVnW3pw9idaycYKAT337UgO2Kkc4pDEpGto3OUUoJdrH80f5fDIit2PA3Gj2t6oZ0xVbcKHfNhWCEp2hQCPwA9ahowpJ0RzhxvDh/haBGx7HQneqUsMGdBKQtLqiPEtUJYDbaitVaGxzsgmoLIElKrt6yKK/LOH3p/KhgVyMzfzF0zmFgZWWxT3XhR1qM257+2B9CfhZEb3RlMzxoBh5+k8dojv5xBKhcwpYaaQGvcmMyCIHkAkYOu7+qQXGrwNf2hFuNmlPMNxPXUqDzepXWu2Bdyne5wtZsNkGIT1TODRX0HfXtsaVoDA2CWPatWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=amd.com smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Be4SjiecGpXAYgisOQlhoSOYRPo+Nmpv2hSgtWAfYA=;
 b=Je1Ptm7TezoW8PuvzaEbhFPBu6HRFn/YqONuNX6fwavU3GoSow06a14vt4VnLPq9EP6EbEkdjfvFbX4LTpifb+QlyP034NQZVWs5O6uv7mT4pncZ6duppfPaw5bkCGNaM+fLKrJSZz5B8U9jgHdcYx5k+iF+qu/DQRpJHrM0mvw=
Received: from CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6)
 by SJ4PPF6E552E27F.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:07:02 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::87) by CH0PR07CA0001.outlook.office365.com
 (2603:10b6:610:32::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 15:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 15:07:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0322040654B;
	Thu, 16 Oct 2025 15:07:01 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C2452822540;
	Thu, 16 Oct 2025 15:07:00 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
Date: Thu, 16 Oct 2025 15:06:48 +0000
Message-ID: <20251016150649.320277-2-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016150649.320277-1-simont@opensource.cirrus.com>
References: <20251016150649.320277-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ4PPF6E552E27F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19aba060-1e42-440a-29ed-08de0cc5a963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/PQM5kIzvRk0PA4VSiFbZcJCS6+2VfiQnDeozB3QesmEYByFTOI1jwHPU8o?=
 =?us-ascii?Q?IC2sWfmMz5fwv5ZX+ec0GlLb9kGaovBJ+z2F8bkE0/eMyPGKRQhchiYb+zEq?=
 =?us-ascii?Q?O5Qacpm0J8lbdzHNBdS6+DK8s1iUOijWD0SzlycR2NTAaLW2LES2H/+QhOBB?=
 =?us-ascii?Q?bN4bjJN9xphCYLWwvabHleX5tgG/w0XriPlYbeXeMuOiSLHdAH7Eql9smbRB?=
 =?us-ascii?Q?pRA6H3FlV6CCStqg6RohveAsmDKZkkPcoymLebXtMYvSBU01jMs8tm4kJHTe?=
 =?us-ascii?Q?tT4jAlc/+uEudLWKorb4eSHUT/s9cgEsPuhuhopkasv9H9bpaoy7mGrpmMQi?=
 =?us-ascii?Q?lMeyDDszqJWfgaUChtsFxo5QlpZgiXvw3o/xweMd6YUrOsrfwIG6aA7V75xo?=
 =?us-ascii?Q?IYC6Q8ZFffY7h6v1cvLCaVrDa8+CYHhYSC70Dbw/pV3tkA0TBBEu8mligFfA?=
 =?us-ascii?Q?x8knuf7iOomRfN2lSSa5y+7rXbrniDEnhpQxb2R0pTIapIGlfEItYiOJNvtK?=
 =?us-ascii?Q?gEUccEXjHxs0rdnGEjcXn2wXorTGsnlEqX4UQfcVrMLvRSITYFMFc6QOSF6m?=
 =?us-ascii?Q?QkdKl0VIdqAqTSv2uaKhU0uxPKkdE5vPVjpLgNa0BuFqorm9SqKy/lD6Ucvu?=
 =?us-ascii?Q?0hkuSiku74nUFw1uUIk1UDuEETysccUKqigGYLoRU7nBdGhyzgpckG/Jd0VK?=
 =?us-ascii?Q?ZjFMYUAO1uf0leLtXUrHisDh4CLbhxjTj/ascWZ7mBEk4VsbwVI57VUh8eJz?=
 =?us-ascii?Q?BNIEZSjF6ct04G4XIQQxRfsg6PyzzQk/dVPCXNMIaGMZfB8Gmp4MSTkbzPmY?=
 =?us-ascii?Q?GUCtjyBYNPqz+/FSDoDWpxk+bFcw6jzPIyx8rEDxDFnApjxoZi/zBKknBwKd?=
 =?us-ascii?Q?iGDfrynDwYbyODWexYmEWyfUl1wt+2SHslj1dQ2ijtYVcaGIBuZEwFXVPRxl?=
 =?us-ascii?Q?Y94HG3fyGQ1el43egK80bmXBTcgNV5/NCo9pzQrvNYK8mRc8MQmq+hCWRgG7?=
 =?us-ascii?Q?P2JRPfK54k5ay4GjvknTS0kNy8rEWjOg3al5L8gju8k4TFBMdVF+oC5y5tCO?=
 =?us-ascii?Q?vdJrh+EON/Mxsa6mxxD0gk5yHEutgmSVLUxxSYC/2cMAtLkpE+LTVraS3I+J?=
 =?us-ascii?Q?s49gJsGKLYEpfglG6cCWFSuhCtd9STXAU+n6dwP73pAt+kzXK3Ahr4u3m6Jw?=
 =?us-ascii?Q?5ibE8n7h+QXiqOnPrYAaiyeJ1iPAMMNmEH4L/eRYdFJYKCB7U+ESwO6SD8RM?=
 =?us-ascii?Q?a8cJuC9xsu22KWUm+NKi9spW7kEl1/B16mMsS70HjdPxrCoy69lP7qbV7C+c?=
 =?us-ascii?Q?iyrHzi00cv/c7L5UPQJMsDmJFko9vtWAWrx5MjOAtQcd4hITw8cdkUDwNf5s?=
 =?us-ascii?Q?wfxB/exL1cYzObJS7kchr8t0t3lg2YjZX3l2y9m012/z2jYrpV1NtERtExEg?=
 =?us-ascii?Q?QgT9gr4WV35U3YXILMIP8LT3+IvljUfHl+C31pUC+XIDIBMPP75PbEP68XWE?=
 =?us-ascii?Q?pFKLml7r3FHBvo7MpYs1SDt2GmtxYuJ5ADFSLgVLdo76tmNI1EHKkALPquji?=
 =?us-ascii?Q?VnKvJ9CfpiuChS9xdRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:07:02.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19aba060-1e42-440a-29ed-08de0cc5a963
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF6E552E27F
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f10a19 cx=c_pps
 a=SjKxu3n00dGHhKqS4WZ18w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=vswpecHw7tACXd9wy68A:9
X-Proofpoint-ORIG-GUID: pri5k_Cco_oTHjpiy1-bOSTUJt9WFO-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDExMCBTYWx0ZWRfX07wYr1N3w+Ba
 yoUedyZHIDAUmmgEEkvJtlQm8HoED7DyAjrRYdxaT3w/vX5dWVaYxq+GY4CocbHIrcthUx5JH9e
 jNofWGtQ7WKflgRO4zVaHTF1pLYu1LiSVpk+Q2dSaY/MbCzg2JSTx7ibVc2D0WLjfr4RJQmF+ha
 ndGpnAMAiPi305LDahxKdoi9Lu3H7QNqSuP07MzMbLJWIiXoQ+hpA5WZUQr3156Hb05elSzj9jU
 3RdbqXh4N7O7/TtuSEZsmxfcJfZQOaY+KE9qpaVu3mjE2diht31hv8Xl4MnD1eXQH8gzkNAqFxs
 hIg1N6OastxveBQQqQU7lphOTXMKNZ4DvqJLFVPlZeVPMZXl5fnjbx6Zghfko5hvwQSB32PUNe8
 v24OEfNGz+NVVgtcmhPv8C74VHBOcQ==
X-Proofpoint-GUID: pri5k_Cco_oTHjpiy1-bOSTUJt9WFO-L
X-Proofpoint-Spam-Reason: safe

Extend the ACP machine driver to propagate the PCI subsystem Vendor and
Device IDs so that they may be subsequently used as an SSID.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/amd/ps/acp63.h  | 2 ++
 sound/soc/amd/ps/pci-ps.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 90fc016dac0b..62cb6bef17ab 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -370,6 +370,8 @@ struct acp63_dev_data {
 	u32 addr;
 	u32 reg_range;
 	u32 acp_rev;
+	u32 subsystem_vendor;
+	u32 subsystem_device;
 	u32 acp_sw_pad_keeper_en;
 	u32 acp_pad_pulldown_ctrl;
 	u16 acp63_sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c62299b29204..3a20cc10d61f 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -335,6 +335,12 @@ static struct snd_soc_acpi_mach *acp63_sdw_machine_select(struct device *dev)
 			mach->mach_params.links = mach->links;
 			mach->mach_params.link_mask = mach->link_mask;
 			mach->mach_params.subsystem_rev = acp_data->acp_rev;
+			mach->mach_params.subsystem_vendor = acp_data->subsystem_vendor;
+			mach->mach_params.subsystem_device = acp_data->subsystem_device;
+			mach->mach_params.subsystem_id_set = true;
+
+			dev_dbg(dev, "SSID %x%x\n", mach->mach_params.subsystem_vendor,
+				mach->mach_params.subsystem_device);
 			return mach;
 		}
 	}
@@ -617,6 +623,9 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	adata->addr = addr;
 	adata->reg_range = ACP63_REG_END - ACP63_REG_START;
 	adata->acp_rev = pci->revision;
+	adata->subsystem_vendor = pci->subsystem_vendor;
+	adata->subsystem_device = pci->subsystem_device;
+
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
 	mutex_init(&adata->acp_lock);
-- 
2.43.0



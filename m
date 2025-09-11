Return-Path: <linux-kernel+bounces-811202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C1B525D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EC1BC85AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6A1E47CA;
	Thu, 11 Sep 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gjyJdOym"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4E214813;
	Thu, 11 Sep 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554674; cv=fail; b=aA2vFGyQDJZZV16XfggXiVlTpuraMfTXEn0wvFAmQEwFhKjfvkYGkVduWHsufejEAtAPsE3EiX5FU6c9tehVpn/IsXPxy70uUhmOR1fJq0xstutYMlzEGmVPyDQRD3VPZyvSjzv0Wa3f4zXWYX3DI6Tc1fnRKx9/BO/smRfPxvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554674; c=relaxed/simple;
	bh=Tr73nPJh2mw5ljC7rm6s9qcVlZX2kWFVaUESft0noAI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ij3TiEttLyhYNhTZf5y6QMXMdiEeNc/vGHhSE5IwV5QKylQNO0NFbrg8j0AoVFyOoPIrXuzXFDd4gCsDDqcvHHuh8ALEo09PrUq341bZbpW73cRzmY8aaQ3DhThGcKDr6B0pSmyJrXuM5N1euFAJ1j7mIxyjVKJ5lSTWNjXwKEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gjyJdOym; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si2q6r7g7/sUvxv0402ZT1/xDeyXqWu2XkMTCQAy+O0ROEv6Q/QMZOUoU0XcMeRI2W1tcbwv/8UJ8M1t3B6Vx+Yk2shCRNNKmrTbLbP3Vkhtj5Ss1JxpFY23u2oWmj5BDMtwoUTVnrK90DPIM3wmqCGrQQTey9K2if97vigoWcgKEVhKhIiZ/fYXMQdy8SsofanteHC+7CnP4+YPGy9ko0VB02N8lhrwnw15O/r+Imv9W3we1ZX+DK5RxJWaqzboHfQNLzt+MuWIzp6vny8DX1o/OQDLD4j3PpfulwYdNvylnN3cMWIj3fnzqgqM0R0QZpprWG6sXHwtbWqe9tPplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kvkmZXoF8gznpNs+BEzMV3vb0mB8s1IO8VXvKVXGpQ=;
 b=N0Dp5YZlBVIEkiqt0AbudVf3wyKKO66gdciqcneFJr8U1u/+oOXOCdCh15fuOnGekGNuCm/4Pnwb8OAan9mS3Zj5mWilwtFtuaaBkJS5cDOZoeXRfjaLz+IhZMWw4YakadZN+/doUO2bqHRkooAhmFnGYi9K5REQyyYlG8kg0lOr5/jPBMOBSP93sjc17+zBg5tykN5ajjrMNk9/gleDYFXEIbdjDBA1Cn9XyuX5twe3Fxe5vQSoovZJmOe5j7ZpQZsdiaNdnZv7XKH38NPCjcB5vIP+vOO1HHHUrHLgZZZ63yg4MZ8VqQYx6eWHELZTepSxwRBbvhlZzb2a4m5shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kvkmZXoF8gznpNs+BEzMV3vb0mB8s1IO8VXvKVXGpQ=;
 b=gjyJdOymeTfjJwZCBca3qAvHsEIPtr21Hb7TMDfF+uO0fdagGA6JMOMP2b8k9GkpARUQxYCAUfd+CDDrklIa/jFfODMc1qO+NoPVJtSXuTMLCYlSvk2IK6h/hCimsdjLK5uRC8bg2gbfohyy8U6xz7+KSBBx8OP2Fepp0+VHuh5AopOHQi0b90srZdcU6KJ7DJOb99cRfD7fUQFvzIOWisYiq4mtNo2DTLGQqkliwopowWq5LJ4i1SfD+ksfpd1OUuyaeb11g/EFTtlqyz8y+lnfPFdMsm8esw8J0fHNmCscPN205xyyggF9XTul0rWyxfy81Mp+52zajm7PJWaqcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by SA1PR03MB8083.namprd03.prod.outlook.com (2603:10b6:806:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:37:51 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:37:51 +0000
From: yankei.fong@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 2/4] arm64: dts: socfpga: stratix10: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:37:24 +0800
Message-Id: <b81326e74f23b4babe03f5812ab01b0a8c78f32a.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|SA1PR03MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ffca57-d230-427a-19ab-08ddf0d3d239
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BaWDie4d/RZlQ4C+2RUTVoQaaG6xTehNgSanavnwjVqjWEKwtTSgLKuAsX0+?=
 =?us-ascii?Q?fI7OqY1r5rczAwuxbly1W7lVrhpVs1Q6CFh5CvXiwkavoKY57EWN22fbNlRS?=
 =?us-ascii?Q?3NNSt0ShhoCGr8SxcZ33B3EKqkKL/djuH63xHjqnUb4EiFLRyma2x4TUhutN?=
 =?us-ascii?Q?+rKTSegdjBYhc5JiIXkoQo7+2koKWgXI1hDvxmaqwsgcrRgvVEz5TgLwDkok?=
 =?us-ascii?Q?Aaifz8pUMI7gqL6Bt2J13hcg90bTNlZ4hBaNrjBa0OO0wmF/Jw2nuX7l3MJP?=
 =?us-ascii?Q?vpWl0EQwuI8QjTMhRoy+JFEbTRcvlSffpoE6ZqoyGJfYmERJeXbYp8SmNDDI?=
 =?us-ascii?Q?97ONHV/MxxOWSGwx03SMWCCMDrzVIntwGEoFaxa0PgF3sFp6tRcmTKSjtGlG?=
 =?us-ascii?Q?Qi01D7UjWNHsKVQcfQlAiA3hp1HfLZfmgg/wcE9JIEAFwHeV0GfHYR3kc+aS?=
 =?us-ascii?Q?ktBS5fCTc9Wlp6M2nZ7B2PWwFE7tGshHlhfzRTz2W5bJZkQAoQSKsv3nh6ot?=
 =?us-ascii?Q?7GjH0dCi8J0zBKaXqIr8f/ndeeI0KRHnusxk5dt98jFGc+ciSixcVDQAK4C9?=
 =?us-ascii?Q?WW4eEq8CGEzS2yVtGPaV8Vb8s0pw5RDt9o1wg5Nqsn0fc1DbYBpyzSvy2Cr1?=
 =?us-ascii?Q?iAhaOtsvpZPjRayWgaOepI8hd2RD53Fdr43dfHOlb8pwTOOLiM4C5PUKfKxC?=
 =?us-ascii?Q?6ObvnCG2TszbVucvIe+MgqeY/+MRbzl6orBJuZW7Rd2aOXB9A3vp1Yef17EP?=
 =?us-ascii?Q?EqDh377131Pxokgqwt8zc/XHQ/REF9TyWJeeQ4h5aKbIvovhH1fNozNl++7K?=
 =?us-ascii?Q?ei+/lr1ywt25xegXAjJYaiIv0CJeobxrMMqvUl6LlREDRN2VrqDWAqwbdtxt?=
 =?us-ascii?Q?bhatVVnJve/pVN0o4ZrYimEsyzGCKSYaVcT8d8ijoUOmlo3WikB99S3YDtq4?=
 =?us-ascii?Q?gI6lWPhNhHM3qiI018kcWmzJ8yeKUWLiWTFiIZ52/di8gGQjzIYSDtqJkaXX?=
 =?us-ascii?Q?treToQaYvw9oj0XcxFPuiu4t3MoKIBDLCwEM3vsKLmRHyF2xyhIL3/3OFNQ5?=
 =?us-ascii?Q?PVEeLdEcAkUMbip50PRAaUTZx+b//tmpaVsgHNoblUCnd7wY6XqbbirOAwX7?=
 =?us-ascii?Q?HzoFVCvLK61HrmuVRZKKwrCahWf/vOC9RvalzdT8oEpP4c987ukukZPE+oGm?=
 =?us-ascii?Q?hpWQaXDvnzwb5J1vkae5x3lFP5hPv8p1IjLm94QgnrrZsrvPDpzmVnxHdhnn?=
 =?us-ascii?Q?ZnpmQqyCeypxXPzZzABAtg/fbsqh9jNwuLi61qIZvBoM7UwI0+vk3L63/1/c?=
 =?us-ascii?Q?u8Xr8cnJxRm329MnhIOm8GtpmAFSM85n+8s6eqU+lcC9O/ecQrIMBP6rdZhd?=
 =?us-ascii?Q?U0pBBAnTVeUTbL1drnitvw7JIPGfJyKcCxoZaSFkZ5mR/oBU5hY8P0p8rtAz?=
 =?us-ascii?Q?xSWulafqeRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QbpIPAg4AWvamvR7C6L2GqH+2ZDwJDZ4dh3upTfmW/ra7/2IaUByMRxBF7AN?=
 =?us-ascii?Q?ocxweZ8QOKABJ4D4kvPQRLGpxQu706kJ11xJHAv/Oz1QDBT7D5kqg2BrGMGc?=
 =?us-ascii?Q?iOsR58sYFU0au6prpc6fs9yLYz4t1B3/stqRrp9D1Mv2BHR+2aAG5AyjsK4O?=
 =?us-ascii?Q?EblUUi7CWWve5TCX3+woneL1NuXnovpR29SBH4J3lt+QMkvDS9RofGS3Mb4f?=
 =?us-ascii?Q?aOCQHc48svcPYE1dDSkPEkHcbPyfyVblwzbZ+jau6K09eSvGKhjVbUASW+Mo?=
 =?us-ascii?Q?vo3r/hE1jl1CPAGSPwhmu6wIQZhsA/4GYiyO7iSSZ9KD8n9/GVw4PPuGDycL?=
 =?us-ascii?Q?f/m19DnXIBw1uVI66HWXWJD+34h2Xp3Vh3QEYPxUBod5pAZO6njlYliOWpYF?=
 =?us-ascii?Q?SkAgh4ucDRnCxPMlotEmCTlC8IUIaqQO4PJwOO2HTVp25BPW/2kJa40MsVxy?=
 =?us-ascii?Q?dIl53fgUbz9iIJgjvkYN4KW8ELVjIHlZzMaPXFrzidmlS+nfA/KVFI66+YQb?=
 =?us-ascii?Q?4TjL//3vz6F0HGyjRgXR8MI025yn80/gHrfCg0AcsBN0GOQmbRUFaL6Yo3+a?=
 =?us-ascii?Q?7WRiqJN194A0AIwMLshf/UMUTJ4iknXc+xnIAHWVAsragSM038wD95zfF/uG?=
 =?us-ascii?Q?kQgpO32BAy2lIegRUHAF7Yqte5xv9+vKffQuveQt+2Fithob//WEoQjN1hzD?=
 =?us-ascii?Q?eMtFP5dSBdmarBZpzw9bBk3XkBG6UdJLDIWJ0fn792+1Dkwvo4q6WtrzhAnK?=
 =?us-ascii?Q?n2ri6EREFr+0fBKVGvvIHwckKyhXGF12ao0T6j+/84LXwOpxqm/Uq1Dqg70J?=
 =?us-ascii?Q?G44d7tneSpSw7LqQFjVWzQQUbTvBcMkqJtgySSvKpGSPcMqIcAiAE5c3WVi2?=
 =?us-ascii?Q?f/wPzpPJH+F1OuqutlZvizvsHfqaZ4cULYKSRifkUIaVj6bsuElcM0bI56zt?=
 =?us-ascii?Q?I44VYPIaH8nibuAtBup6jJXQj8JtrD0KeVp7BhbLC0lKlbBA6TMUg7e3Qmun?=
 =?us-ascii?Q?BbiG6gkEFqS146+wcizimdK/e0Fp9NxQ9xdWSG7lYfHPAtjE3Gqk71+QxXbZ?=
 =?us-ascii?Q?6WGq08/8LqlgAOecYZL7cZRTr2dmXdnpoFgOvfpIcDeuTGcObPwZ2dLyKIUf?=
 =?us-ascii?Q?K6gBubQns95oll9PGKyyazzekEoiDCLQPdbmh3NbBoPf72r53oI7IBefyjSW?=
 =?us-ascii?Q?z+VefzFnifilaTAP0dnpZPNV4xen2iM69dci4iL4HJpmr6/qcSkQDP6PUgFj?=
 =?us-ascii?Q?ENqItxJZQ2CTe/SydXISxeO/Xeo1rwV/5d0Bi18nCvHXwuxuLY1PDACKIMNN?=
 =?us-ascii?Q?XPLOnOMIhiJ9qZzeALShmWzmWbpuayZ+358EpeWihOKO8skN9HeDLWs2lQj2?=
 =?us-ascii?Q?6+koT3wujczZVvU9ia2aSuQrpZWdO/kYG5THXz9pWeoarsVlN+v5g6ZzP7MC?=
 =?us-ascii?Q?+0O6ujg6y3Je9ai/YL5KDo/HrRsXxajyy/SDhtsuHlcKgIedQeglfKhTwiNn?=
 =?us-ascii?Q?40dfbId+nv6fcq3ta48dRWSNcaa9qB2LO501fyFAAYHkpI5TFCUyMEysW6py?=
 =?us-ascii?Q?5E0GR5lTOW7TjehZgTNFDcwjBv5dpHgMlQAf8ZX6?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ffca57-d230-427a-19ab-08ddf0d3d239
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:37:51.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sticjR/kyNiLeDrTQZGf12tgycGr3shSpDkmWb0b2X50N0ZbqNEm4mSSw6trgbLcA0W3JM3qht/eOpdL8UipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8083

From: "Fong, Yan Kei" <yan.kei.fong@altera.com>

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the
stratix10 device tree. This update configures the SPI controller to use a 4-bit
bus width for both transmission and reception, potentially improving SPI
throughput and matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 4eee777ef1a1..6ff6ea0c6b2d 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -190,6 +190,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1



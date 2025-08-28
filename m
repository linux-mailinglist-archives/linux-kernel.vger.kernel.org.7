Return-Path: <linux-kernel+bounces-789949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B6B39D43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01431890A04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10430F954;
	Thu, 28 Aug 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qdSSxH4o"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013032.outbound.protection.outlook.com [52.101.127.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3530E85C;
	Thu, 28 Aug 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384025; cv=fail; b=skXf2LfxaxcyqPATKbSG+0dta4HaEcAyQ+phzXBpJclP1/x9zMT52WRO+bQga4pi4TsgzSc+SimrxJMBLgV04UN13kndSRqi+hwclQP5rg+IPmeGr8EDRSo4HLNyjbIG64E4e9/hKcJvaOa4qe0b88jp5jl/eEyBpEbOYGNfId4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384025; c=relaxed/simple;
	bh=m6UqP/WxcHkSlrp/ME2N1jUWO4EkWMUysC64Rc0Tpag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hH9JdASFey8FFwNk6FyRQUWjny7HRoe1dpv5r7oIQqFpzgMsru+P/1P5UMxghO3jt1xwg4qIfJ4YSecYg1GIigbK+uEYv8poKa9dfHNI4rB+3JURNMrmmXLxwnW14Q1+9YemH9pS1V4SWLeb4IQFR2/OEMk0k1EskhxAzLoAF4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qdSSxH4o; arc=fail smtp.client-ip=52.101.127.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mazfSsatzh86D19bLeFltEVHdTE/gAe4qYKBc+MbBi3wrIzFVnbJ0rdFM1RM6K6jmqyY1wFqbBy5YNF+dY7h9XWP9zOVNvtkZ2Auobde7ojqn7+uoIeLyKETo2nAPWxE6x/z/ZMn1zohXUUYZAfxepSltvNcu1E06HhZygMze6oukTXji8tD+euv1zxo8k+Ap7MWFQuLN2SUFTphIh8iJpGB5xlYcG4llXVYb4X10cTe2a/lujUSiI/1d+fRdExXU4jwwtm07046T84FKyPtKye+SJ6KwMF9OCP3jz5LE0+rHie4XYjxPqNB5Ep73qa3GQLE9KvL+UlIKxw/2/M7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+VVy0KUhlcA98WHEyI5lZWy+jXmjrmQXKWYacVcAr0=;
 b=cPtWA6H8Q1duOfTSEGiHW5qve74da6HSXpfQIZ2hpMQzUzAcPbMa0qBcCZoSYExJmfC9nbZGfKUkONuo/ptEz7R0e29pq93gZzR/Xacum6Hiti8cpOrux0p1AaJHeAHlc1JRSWNVIxp4KMD/Awl0x0OwuRJZ/Rah1jDTDOqf3uGBtkyn5jGpsd9CLB7NfIgyw63uTNYC7tzKxtwDFCp+upUDE7YvOu4+GZkyxqJo3f13vcfVLCi6hvDpe9LcDslLP0u5MKimU2c2/I8s7G/Kk7TCNyPXJexFGL0D6uLQaInS+CoqbzkIdCix5llqIrgkjPYWmePsfozg2lUMsuO0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+VVy0KUhlcA98WHEyI5lZWy+jXmjrmQXKWYacVcAr0=;
 b=qdSSxH4oAcXre2Zkr6s3qaLBge2QW9KfYr0fidht3RscnYWFCOsm4AAyD0kVT6BPwU2hEqLGh1HXURaHwIfpVWa4umUKZAKJWGN6xYjvMVRoW3qvPF4scWUOyk8B6UTR3qov30hg7GR3awrLHsZ44f/c7BiolcDj+zbCk4MO8j0/SVRcn5v6vVZmnSqa6onukNTTPaiZ2o13ltvx+I81/0DATtnf6R61KcuhkkVGGTdVnE+FSGFG4Xx+bYJuLk1XXj65P5Ske3om3H8KzyBzx5gJKt6Knmi0AdyFRjJ6mwuN0gG84KJDiCD6Hrq7yg2ncfUwGkpC/UJLzBJxyTbdRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:27:01 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:27:01 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] platform/x86/amd/pmf: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:26:48 +0800
Message-Id: <20250828122649.39574-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: c7610576-7191-4df1-03ca-08dde62e3033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ltEEmLjvV9Bi+zPjtGbJGFrqoHBCTx1CE2Qs0we8saVm1VOGEShsp4PK/SYN?=
 =?us-ascii?Q?eCsWpQy/dzAxDNuoON9Js55g4YF2N371YHsrVO54vdx2QXRgowupc6d4cKbk?=
 =?us-ascii?Q?APO2zf/CZFM1Wm8U/tNf0I3tdXsiCCKXFRWWbkmdf9221YNyHZUNF9p54Qq2?=
 =?us-ascii?Q?DrNQw9X1WEivlWE2k9uTidg7kYpsyt5XhdTjjA3wcKooWDMQlsw1mf9qNtx8?=
 =?us-ascii?Q?hvq7cdAjixDJCJEUNHtJ+WOHMWQbCtQF8bVPyIlTev7NtuvSMEI7ntBVf1im?=
 =?us-ascii?Q?Gx7FJSb98KrpNCCPbVcEivL6XMA7d1jETfsZEoBxDF9Yrax5Mx20Vafx7UKp?=
 =?us-ascii?Q?OLstR9S9QwB/M0m1uxMyTKUNM0vY9IXvq7nJtiFUUno/vP4buasUFl8g3Hoj?=
 =?us-ascii?Q?FtQDOPbO9IARdiReBnYzW7He35Z7R/A50MW+TN8QQ9zwGzWaF4GN3MQXO/b8?=
 =?us-ascii?Q?+yPyph92EfJJ240utUrS6HFWa5WZViNyWi125rKbmrMYs3smv7dM16lBFKVO?=
 =?us-ascii?Q?BHtDCwvyJcCR2ZuEou6lF+FgBFCormIHJGtuuxfz2yUFRG6VCz7DqhFqZmnR?=
 =?us-ascii?Q?7apCFT11I0Ax7i1CFh/5h3Ee/kjwGqJLTMlhuTvg91k8iyoWpGtcP2byE1rq?=
 =?us-ascii?Q?skkf8FpuDRUCKf7OF1at96/2JoYdv1zz2UvOHupUnhmNtEgxhKy//iwhP0ro?=
 =?us-ascii?Q?PigbvQHJxu5lNZ11s6uJkry3XCaVORuEHxatfmGnJOxd68MsnnNEq8I0c6Yl?=
 =?us-ascii?Q?dqie+qrxNxcYrmUWP8cNdStvnAIAH3nraVFvX2mGT1tA2Ogzdrgwt7gDUvGV?=
 =?us-ascii?Q?3FihUaKjuer2L9PiNJHmTe6i3Yme4jw+3AIKY0nkHb0tJe+3nHd5WaqfsaFO?=
 =?us-ascii?Q?Pr0PWYUtXHMIlVtUjLk3poBUCGkvqWsxdWihjXRz7sWd2eqQHphc39pLMhkq?=
 =?us-ascii?Q?tQydcRwQXlt5LfewRzTxVStrzxaiZtofXJt+CG/TZqnPj66JpZKpcJ6mBXaT?=
 =?us-ascii?Q?MGFULb0UleqwAn8QkWyqrzatttZvMMTBRHJ+ck1qDYJ6rptUO3O2vXHd36hG?=
 =?us-ascii?Q?/hWRE2QJvNaFkmjCBmrtKG3oraheh7NtJUdxd3HdY6gjheP67KBVHG8o0T+C?=
 =?us-ascii?Q?ZfgwxtkVhlkeGAijvsjM4cKSLqHQIvxoJCcljGpxIN4WtqDEcxXcdpet6pg9?=
 =?us-ascii?Q?3OzyQqCRaEVWorFmvA0B5i82jy2c4m4FIBFGM8mkSymtKYTuPvHsgoU1F19I?=
 =?us-ascii?Q?tEIoqHPOwuJOh67D5PW/VVrvrPzu3XCtnaKwKERqm7svZhmGxWubfgNnitIQ?=
 =?us-ascii?Q?/Ad7Swr0ahuUTykl8vDqaf/hfpRO0nQBHmsFjf7e3439ypqT32P1l382xMh7?=
 =?us-ascii?Q?GIkX+50mb1Fksu/xH4qmrKvQc4yE4HQPdHlKfCiJigrjWEOQm4+s88wiU9Wr?=
 =?us-ascii?Q?vZ13cH0uZlpkxz4ciAWjMY9EeuQJrCBKSAAbkAWJc1bPIRPk9Nr7DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SoaMBhgaVWqSwz4i+fzKUj/i2lQZKvyNUYZRe8cFU4OzGXHMVje3OHOk0rQu?=
 =?us-ascii?Q?MzOYb//kOowkkALroerZ1SWrB4b3jKVYfkB+c0c4LPK0HhBHipPXDpxaWbg7?=
 =?us-ascii?Q?j0T1RTMrKI4TQeBUyT18irBPDdqpvt+uDd7DTY0g3UDcPeCfKnuaXlXzvn5q?=
 =?us-ascii?Q?vVStuzFlYKowTKBuMxbnY8ndlb24r8QLlXbDpKilzcbznli1A1vehOiWD3zz?=
 =?us-ascii?Q?hTIz0dHu23zSAWcDwPjZLzQB1HUEffsuac10XBW1IV31hE9aEpipCKzZSknL?=
 =?us-ascii?Q?ocFn0S4dILxU1SuwYgEqplx934vIjlPFAf7fgxs/0jKaxQId6KI3PBUTzq0r?=
 =?us-ascii?Q?HPy4yQLLYfhkVWqbpK2sLdvJVcHWwBn5y9ncPEpWoUUp0HNzlwhJjsD7ZELH?=
 =?us-ascii?Q?dWRdopmNY9OqNPFaDcYTKGz1krXeVsciYnyHQe/gIDWMcWM0bISqX2buTb7H?=
 =?us-ascii?Q?qBxVIxb5Uvp/GscZEXFfgFIBdr51VopSX9jXIH/Bf9nUjGThFfwC3SmEiFNr?=
 =?us-ascii?Q?AAcpHXZQlJYAW1TQKTZrP9/S8lcBVrA3W+DorNIuGaUKTlycH2/lovG3vpsq?=
 =?us-ascii?Q?tcH42xKa7mXPrzP0lEm1w9F6wXS6el9lz6y/Pi5oK3nAL1gAZokB5xw2yZKJ?=
 =?us-ascii?Q?amQiGpZ54RqEzlJirEUyRIFDDtJ6xIHPbhPRyZOTpik1i/B0esaOyp4We7Vi?=
 =?us-ascii?Q?ist48zdsiEUbKd+0RZZM88H/HTlxLHkFAE0oHWyF7IkcsUEJtCqwFXLz30sA?=
 =?us-ascii?Q?JRwDQUretkYoiFernsfY08cwDXJxQFE/9GKrHYO136pozwWbnD8P52u65+Hp?=
 =?us-ascii?Q?EBGp6wgQmsSZsf8n6DEKwArIe+Carr7YYsSy3DhREY1h0lna+BIYj2GvTDt/?=
 =?us-ascii?Q?RXX3cYy0p87+0HWLTpQ7mmvfcDFpG8tCA2HOg/GdCYDDbumf0BkJw2UdBr22?=
 =?us-ascii?Q?MJcJ5SylkCndbdmRuuk/YHsO8QblZGXWiX+ZYnv4Cjp66uEBPHSx9RoHhivB?=
 =?us-ascii?Q?609c7VdsaXWnro+f2E+W3gxX6L2pPRCgXHoZ5osurJUWfiItcNoSdOteASJs?=
 =?us-ascii?Q?lXFCbHXW9bN1e/EvHyP/ayig+hZvtNZF5kbuCOdRSjcW5+/ijZBaKNM2Ba6h?=
 =?us-ascii?Q?agPiMsX9/3BzIGgutP+NIt8VBTFhqUyiBPjEEtvz/9X4iYpBBirO6WCTJ71v?=
 =?us-ascii?Q?WHwkF7tRANka+bBygmtE6ihxj3ETYOcURL8pjyqYCmHDzqsk5gza34Qx/qgi?=
 =?us-ascii?Q?mQsEKGOug/X2aL7h1hu9NYY99JsN0yc+7lzdhgXnMHWnxDuAbfF6pwFoijnt?=
 =?us-ascii?Q?XM9GWmYIQzXY311c021XMScGren4g8yK/VLF2Z5DLDY+mtHyDWa0VJEireyo?=
 =?us-ascii?Q?diNR71QozYe5IkP/5q0dAf2T2E3uh/Hb+WUGQYngwqOWxzgGlYKeT659GEvk?=
 =?us-ascii?Q?eZoUKlsxJAymdizIxoDNfCQZlx8iHNkAE7ICJ+uk2Odan0yZ95+2S904r8iF?=
 =?us-ascii?Q?WyzKGkYPwum4aDC+6SSXCKL7BU6mvyk6kT29cPrvPs1GG5ldbUbuDi776wcg?=
 =?us-ascii?Q?d8GASWNgf37eumIUgmzOXdGs9jfgUMesVCtMqqz+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7610576-7191-4df1-03ca-08dde62e3033
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:27:01.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0WiwJrMPQFdboG6S9wF3ZYCqKrr8HaXIs8HmFHwTBRnOAQdhgtHmsxvbDpdhNzDZrZSnuS5urvkhUVVxDC7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/platform/x86/amd/pmf/sps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 49e14ca94a9e..c28f3c5744c2 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -283,7 +283,7 @@ int amd_pmf_set_sps_power_limits(struct amd_pmf_dev *pmf)
 
 bool is_pprof_balanced(struct amd_pmf_dev *pmf)
 {
-	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
+	return pmf->current_profile == PLATFORM_PROFILE_BALANCED;
 }
 
 static int amd_pmf_profile_get(struct device *dev,
-- 
2.34.1



Return-Path: <linux-kernel+bounces-884213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1BFC2FA07
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C68B634BB63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA3308F19;
	Tue,  4 Nov 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Hc1boBfo"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA43081BB;
	Tue,  4 Nov 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241498; cv=fail; b=SOFzpkG1GRR8Tq8k4oOclYnlis5EjzvYFFEjqoz/mdYntDImvEjw4UGxrnypppT9fzNII54u+HmWlujkq2Xj4QuJ+tiolyv4CB7SIVyr6PrepxEbcXMU1Bkw+lJUKJnMqRqHGMnh3JrZ3FbkHpnGQwT3kxDaJZ71hOVOOpu0ISQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241498; c=relaxed/simple;
	bh=ieVjmEfNMPLwqXwKutE33v6CoFrYCEmZ9Iyz46MIM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/YORzzTP4iV09+NDPuz0jC063I7NpMyKAceGF8mHdNHTy6EY6cez9vb5z0toMQL7vF3C1l5sLiComWFnaZUxOLZfDsoiTKHnfQV8jsInDR8aklDNPUAUG1WDbQGGdz8TAMarIUV1j3d1iIJCzkukduulvIaAhNhLsodCkkAbF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Hc1boBfo; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyA9LM77bwh3qECsVXU3JWOiKw47PO7aYkKV8UvBxHNYXlr4jVnc++dyq4mmaZNGGlIV6hTTIJlUtF380l1YEpXlc6/Q5UPJWnAr+2inczRFQU2ERpQkG8cdGUbdLXSg/5K5TRNdAhXJhyVjwEo5nKZxB/zq4nph3g9FD+ohjoTS+d9YPkhUKNoj2yV3d1hrSWpLySxIkrO6B1pEPxyuVH9gvBI2DKDhfhrF0BkHtUdcNKjqp5AHUvSQ47TM7Z59Iw+8ncAKpPPrzPubJDb+HDou9RXQwnEjO1t4/73oXO3xI5uJjAo4hkll9euQeElB3XsnJUcIaSd0PqTmzG+WyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2bYY5KeRRIPaUzN5FrkXxgZK51y3igr/g481RudNto=;
 b=EpJPJjeMwLccc7N+XfcaUWd/G+aPWBql1mNp6MVnTlbINBcp5IFMldBjsoZ1zbttjNBR33Bgs/xwxM2DmuESBg2yk48gTRnn7itlI6mLrpP2njxE1H68Bn1C/FHBdAzz2FLfdWiWseNERRHT6Nv6Z/d3Z3Z7FAuU/sgXZkbgpSqCCExS8zRONtd2FQ1o9KPO2UUT5llRX7C7T1fNObZ8hJElq3OpnDpp9iOSaUiaHFKxLM1FP7i++olJr8dAmQTu13sTF9WaDQ2wrmjXRCOkuRsQS0aVNooWfUhQbovAo9ymSu8dipf04e2m0FcZHTWT7x6gw4og7vnkJbqTxIH1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2bYY5KeRRIPaUzN5FrkXxgZK51y3igr/g481RudNto=;
 b=Hc1boBfoyPhTSB5B7kAFKHM7PtN86wnzTJ8UW5h7oy7cZdmJeiIfTVTcWypjHul4igL/9PMJ/rCrZpEoo9X8LUR0+SEAcVvf5m2U0Fjz3GEqaCq3G7kdqCf8L2akvbFC8oIq1VFOqaIBKQEuRlKi4pR2L9VjCRYpIDbp1h7cyWg5F57fzYmF5JypQ8cM0DnEFxqzpbYlQ36UsB7etRVG+oxkPudkkgvMZhl5yZX/ZFa2ERCORnSFsdrN0z17rWXLxSOKAwmyHCdldi322RGiBno2PgMEm4WBDQtdXNGThy9UNrDGPBsYofZ8jR9Liy5e8axy/dVijwZ4CqE0UGldvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 PH7PR03MB7509.namprd03.prod.outlook.com (2603:10b6:510:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:31:34 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 07:31:34 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH v5 3/3] i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI
Date: Tue,  4 Nov 2025 15:29:08 +0800
Message-ID: <482d540722a98c2809d8275445aaa544b565bf85.1762237922.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762237922.git.adrianhoyin.ng@altera.com>
References: <cover.1762237922.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0016.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|PH7PR03MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: afa7045f-d949-4336-3bb5-08de1b742e94
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cN4nsm7BSRtoJ71StVG1xyIAPvm7Pk+V6V23ZEDnuqLSKwKJVv3eXQ1bICM?=
 =?us-ascii?Q?Kv7Lrv1KSpabGhQhqmLjUSGnaVqgrv80VtL78ZjLACDRO+OMdHo02Jgc5aZ4?=
 =?us-ascii?Q?SbWKHs1Hh8aSuKIC7KqQJl8Jk/3YlSNNEzLpSBLK4aSYlLr2j5x6Om414O58?=
 =?us-ascii?Q?yqlUF0KOS98mOcARvwyS9sUlN7M4PJhTh3J1UzH67FCYO7Tj71ksBclgtbDQ?=
 =?us-ascii?Q?Q180p/+4EvEJdoz8dwUDTSih+LFYQMc2FmGvjjcrVrevx/Y/RuMC1hh3cSnI?=
 =?us-ascii?Q?mABQRfhrRIyK7XavNXFn4EwCjMUdcSUZSBwNgqr0A+lwO/rt3MtwYFw1Pj3Y?=
 =?us-ascii?Q?qV8zGR1CD/jEF1sOK7taG+PFnk4MWVZII3fZklkwZarWDudP46w71zuKmI1V?=
 =?us-ascii?Q?iKo8wLwXWliws6RPUxCxHmri3CVSMTfXWD4SzKxxCn/xpBVy7KmAx3h1lJBi?=
 =?us-ascii?Q?Gctou4JJdhC3KjLGmLM2SrYEOP8kUWrPKnrKhe8nrqmQO2ynWTV1cfq3hzeY?=
 =?us-ascii?Q?zlOWWNp3zEyS+Y4eqCVdLZrm7QmhpPP+brWvRR+5gcErhBEd8YTCCqhcQMpD?=
 =?us-ascii?Q?5bzXj9779svhsBpbatnBu1XLHWIdkD85s7JU6Jh1zVXF51ltEoNUJwbjQQ4m?=
 =?us-ascii?Q?i29R4um5zgiKRdplXJmUb8cGl8XZy4iN8qe0WiT82ncUFO62pXUanHbXklFC?=
 =?us-ascii?Q?NyZPEfo3WaZvE5PlXAFXrcj2bkx4y6/JOd7s5HiQE3SAPuTZ7nw8puXj3qiG?=
 =?us-ascii?Q?oz7mqxC1J9cGY8ljUCEneKk44NOoILU1NaW6K64litbYLrqMMETNA74HGrRj?=
 =?us-ascii?Q?EsH79hIgyXZVD15c/gm9cKwOj/oZV2Dg+0/5d/NElefydK8A/9O+Zd6pzlUp?=
 =?us-ascii?Q?71Pj9QvT2A1cwB4OayGJH2VshAPPwRU2+FCE4Fvkx6wiD+yElHKKhFHXYP5O?=
 =?us-ascii?Q?HOaLBLNnk4KVq8SZAg8JSovpXunnsxXY4dSXDMlQy9XNCpdd8X55dm70IM3q?=
 =?us-ascii?Q?u5dUATsNUgxMpoOzlHSmPSu5c78gKzpaIKV+xnWTudC5WulAySRWrUmtENCU?=
 =?us-ascii?Q?vB84d6TMnKXU+Eh5B32uFmHOmJNRKJbsuLAej0zhsfPQXL67OWjLk3hO8X0C?=
 =?us-ascii?Q?z8xQabck4RJjL49aXsoi0xL+8eHwORP5n7ikoKRlOpTAEu6lipsWJ0zfrGAl?=
 =?us-ascii?Q?8oxXR2nqNggrmNqwUuX72qPxOhkI8Dv7CYN/R+hoNKzeB9yNZEFailOUhrdm?=
 =?us-ascii?Q?1zp26cjacRW5RA+f+/oHF2sEyzxy1q3XA8AG6Igsp2QSI40rpdd82W2+rssv?=
 =?us-ascii?Q?ZFRnB3q0eshvhN4zGJ6ziEIdU39g/qi0cHCr24Ji+dM9wNpgFuB8c4DHz+Vn?=
 =?us-ascii?Q?LhX/ZRz1+X3CngZj6jqcC7xccu+iueuujWwb37znXpGb8Kb6079FOYiYJcKL?=
 =?us-ascii?Q?ANnkQWIUIYXrQBTphptfEJb9yLwr8gObet4i64MGpaFwWpo+78sb1SQzvmmn?=
 =?us-ascii?Q?dh+Hk4IfjISjZlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7BjrPT9Un6VrbnAWhD7SGGI2wWxCf0VjkOq59ZYb0VsBy9CThFOMkLBv/iKF?=
 =?us-ascii?Q?e+cbWJqXbpGQDgSs/FEmheJB6iTpIFbZN1n0c2QUg3yzg1lHWinwp3BA7751?=
 =?us-ascii?Q?psFgYVAW+P+6azmRO2Kq72pBokf1PtgdzZsJaVmTNE8BYI96hLw+dOKPm9kF?=
 =?us-ascii?Q?ic0cxfpP+ku2snZMZCU/LiiaRu2eupbfgLzQjATJ4Edkr82mdycp35dLxoNl?=
 =?us-ascii?Q?p2iBTUXMvIqceqfiTxBTZkiLa7d6ddlSXj1ltbvpPzp4k5dq/lffG2Z47gKO?=
 =?us-ascii?Q?7pIR4FeMVYN4xC5JHUnqEJc60zLJf8R1lCn2V6/1e2CpGxxG4ebvEVzkcYGQ?=
 =?us-ascii?Q?JtAWHG9E/cVp3v9gzjp9ukXsKrBj3J+sNTZqs38pzgBExTOMS/Vo0Ub11dH9?=
 =?us-ascii?Q?qeiGIk/jH2D23aARV3Kyym6G8RzATGt6Pgf6Fv8NEBK/ydEyCBcyYrCKoGNI?=
 =?us-ascii?Q?Y0r8TStt/LGssc0pFB5x2FvqHB1ueci5aLpbQln43/6ACgC15dPemDTSrPSr?=
 =?us-ascii?Q?rPcLvO9AlDvr/zHfrTY8zeGaFuIHhyDSxacl2rmnx6tDejGDQzTP1RF6Iu3I?=
 =?us-ascii?Q?r9kFFcGzUyJftaRxYWDF7fiLRXYg7L8mXaTvB+zl01JJjmPfdYYfoFHnJHgS?=
 =?us-ascii?Q?waY8ZA9zB7qYtNM9Lnz3VbolcZmcPmsKRY5MBFgrZZ0mOhVQnags9HVL1Jj9?=
 =?us-ascii?Q?aJytGgdsMgH68QUDxsGo2H2lh5w1F65HQ5r9piQkILcj6lqJK7YSPhytJ8lX?=
 =?us-ascii?Q?78mx+IIjOzGrmba3ivy0SGysEVBBl1DVqAw2ngNNhEhVCxgYGBxZsZvJ7hQo?=
 =?us-ascii?Q?K1wHwczo2pUm6ycGRX9Psszezwf6C1WvMyLZR9+e3THycRBCk2SVIyOGej0C?=
 =?us-ascii?Q?HS/3cjweCltkgIiM8/A2V3NwZsD0CloEje0XYjjL3STYfhaesd+Xge5omnP5?=
 =?us-ascii?Q?DLE8W5M9yg3Ekl87ABUq6mzc0toGvvR+KWANR1FLL8xiVJOqp1VOTpDOkr1Y?=
 =?us-ascii?Q?HlNF3t48ql63cyvWuYgHNuOq0oJPL6I61Ued+FH/F+FI48Rs4ZDO2y/uQK/D?=
 =?us-ascii?Q?FEk6y6miVCVsf2K46S7trExEj0l+G+MJxYghgc6j+Y1BRHj8XmuDNq8EDpVd?=
 =?us-ascii?Q?trxGyvUpUeD+l2TDa6XnVkcCaL12afRVjCMyNf//ag9n+XaOCUClDIVQeokl?=
 =?us-ascii?Q?BQ1o7jeI7I7JBwV04Stdyyf0AyaJNKdZboE+p4rm3Y5YxuTA5Wrbl6aHvIVO?=
 =?us-ascii?Q?a4VGC5ag+tSH1w1Zpap8TdNDbPgY5RvsNLO3IXKICC3yzEu2ZTjpzvJotdfw?=
 =?us-ascii?Q?LH3jtzdWS+ZAN+VX94AMqIxXMxut55XELIqJRlRTsnTASKCq13cK8+Ew3ahf?=
 =?us-ascii?Q?TBcBvYHVvVQQ0g1FrQEpPqfx/UWAeC5xPRrXaENUPpttwml0HMCrV0l4exO2?=
 =?us-ascii?Q?+NzcqpjRDo3CY4a8zrmAIQUnmN60ADo8gZbThx8OX2rU53LuiBLWwYm19Tsk?=
 =?us-ascii?Q?ziRoFXfkl/LeMM9bYtSHXF1QQMZbgkfWcQxyhLoDjUbztRWP4QMR+d5zz8u8?=
 =?us-ascii?Q?3/QIgfNlPqRLMHLDuM1Jh63VoVwal5ywf3XCAPir0nanGnpy7WTnQxAoKHS3?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa7045f-d949-4336-3bb5-08de1b742e94
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 07:31:34.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QISoBzrLRdodjlSm0t3dEV+jb3QZ36NMsz0csUdwYkx8o+AeKdtIy8P1saZQvBShQ/CtafEf9rslLF2K6T5v+WgbhZgjqG6H0VG3/XRCWao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7509

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

When running compliance tests on the Altera Agilex5 SoCFPGA platform,
the I3C bus can hang when a slave issues an IBI after the DAA process
completes. The DesignWare I3C master enters runtime suspend once DAA
finishes and stops driving SCL, preventing the IBI transfer from
completing and leaving SDA stuck low.

Add a new compatible string, "altr,agilex5-dw-i3c-master" and apply a quirk
that keep runtime PM always active on this platform by calling
pm_runtime_get_noresume() during probe.

Prevent bus hangs triggered by IBIs on Agilex5 while maintaining keep the
same behavior on other platforms.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 31 +++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..276592a8222e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -228,6 +228,7 @@
 
 /* List of quirks */
 #define AMD_I3C_OD_PP_TIMING		BIT(1)
+#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
 
 struct dw_i3c_cmd {
 	u32 cmd_lo;
@@ -252,6 +253,10 @@ struct dw_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+struct dw_i3c_drvdata {
+	u32 flags;
+};
+
 static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
 					   const struct i3c_ccc_cmd *cmd)
 {
@@ -1535,6 +1540,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 			struct platform_device *pdev)
 {
 	int ret, irq;
+	const struct dw_i3c_drvdata *drvdata;
+	unsigned long quirks = 0;
 
 	if (!master->platform_ops)
 		master->platform_ops = &dw_i3c_platform_ops_default;
@@ -1590,7 +1597,18 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
-	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+	if (has_acpi_companion(&pdev->dev)) {
+		quirks = (unsigned long)device_get_match_data(&pdev->dev);
+	} else if (pdev->dev.of_node) {
+		drvdata = device_get_match_data(&pdev->dev);
+		if (drvdata)
+			quirks = drvdata->flags;
+	}
+	master->quirks = quirks;
+
+	/* Keep controller enabled by preventing runtime suspend */
+	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
+		pm_runtime_get_noresume(&pdev->dev);
 
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
@@ -1617,6 +1635,10 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
+	/* Balance pm_runtime_get_noresume() from probe() */
+	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
+		pm_runtime_put_noidle(master->dev);
+
 	pm_runtime_disable(master->dev);
 	pm_runtime_set_suspended(master->dev);
 	pm_runtime_dont_use_autosuspend(master->dev);
@@ -1759,8 +1781,15 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(master->dev);
 }
 
+static const struct dw_i3c_drvdata altr_agilex5_drvdata = {
+	.flags = DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
+};
+
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "altr,agilex5-dw-i3c-master",
+	  .data = &altr_agilex5_drvdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.49.GIT



Return-Path: <linux-kernel+bounces-882557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF67C2AB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64C63B4ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1BB2EBB93;
	Mon,  3 Nov 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OtMRd5sO"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422F2EB857;
	Mon,  3 Nov 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162029; cv=fail; b=nk1S3QjsRrTBqULPH/jlB202D9B0U/YlMH6b+TcoxCos9UYbnLyRe/4cPQZ0ToHEyyb4OyW8e1sm22uRz473Eyz/iVtqJXebpkRKgWK7BYdlxWQa/nQjoN/n9Y/jsuyrJbhz1coGf2z+JdOp6ohOubgu2fyiGWzJkOF/TFJk/Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162029; c=relaxed/simple;
	bh=0Q+kUd+s88o3dpaTecFnveH/kIX9/Bdguwi1c2/165o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VbDIaxhKzWlR2TIXgXu6PGWZM2BnQRiXN7U6XFlnShnHGS49dD/LnAR3KStRQttyHZu5La/PuTQDpCe2qR7f7wY7FG1byDYISRwRsnRVFoDxv/4XJ3vBwvzKoyG64Mb4WGIQW7zJ8OQNVOjw4kZUYiTGPRqQiLqUIzz86Vb5DQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OtMRd5sO; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag3yw7md/HXGALykAQHji2/UghCac0KEi5TdmGzpyQ8Uj9bl+0XKZE2Or4noVC2lut8kKXjIa6gVXHeVuJu4lvxX6HSUzLHD7MpBG0x7q3vpgFRdqZa/bFilrSw9S3ohjg/n4QbmIfZOdF/q3V/6NO3XT2YuV4Txjw41MYgqrco63HRAtynFSRTEEi4KQjk+oBrdat2X7CnkaaXfrklBvML8DQ+rxcH61hs3yik4u4QowaejjW5VLe2S2ipGGs9BoDTTZS96YOgD4DRE3m5gztnzkQds7J8DS9WJBYGbB1XyyQOYcy+jbNSLIkqPcjf+Nl0+zTuLWWJxkLYkGgAMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPK7I2LT5n0ok0gTQxFoVcsOJ32jCSrYKBelLufnswk=;
 b=wDS//k7RoXh+lFp20wAkJiFRGW+MlynvNEqP0GrqrvIQye81EnKLt0My/IyQgNeTixxBxdHXQcmmcAAQi/5dx0XVYuFurpzXGM1LuPuTcxzYloiRXLSgmUS624/3QT7cdKDsnDkgCPq40ffXioqdmthJeq0EzHBuU8PVVb0kUOOhtcp+YEF5cZ17GOxbJsfxSPnHRTzO2rig1yh3QAFJobbC9QtF2ulM0bmhaymZCoi1x35j8R2sJTTVvanw6SA34nVHpQ1bRk9GobjHzDHwbM7y9U5gPEzIz7Q2Dj1oKfiV2XAaNHLY+qOvoWFwP1v27zEQh6pFMQ1p1Tg9nb3udQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPK7I2LT5n0ok0gTQxFoVcsOJ32jCSrYKBelLufnswk=;
 b=OtMRd5sO8BoxQWgkOaU90CMPxre6EkwP/YYMI8zEMhxQ/7tM6RqzWtmLajx152GiROJ4NRQndNbcy7RYGWmGnS1cAxCsOTIiTvrTua2a+Ytuhh4HuyBfgfMdXGzqXjc2jV1wTB6MqdKkMi9BGOwfUdNofuIHyY2ECTyRQslfPxT+ul7I8qY9haNTQOf4nsheiYTljtDXmtPqajtnsNA+eQAvexkXlUx/E9exRGW9NQYPAt8vF6eqXu5wyYfzObIjA31auawoI3HAuYMZEe+mujvJOSiHHLziU9g0nYKemJM8J54EXZWvHM9hCRUE0i4ejAN4z93KfAQLfQKHHwU1ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DS0PR03MB7252.namprd03.prod.outlook.com (2603:10b6:8:117::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 09:27:06 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:27:06 +0000
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
Subject: [PATCH v4 2/3] arm64: dts: intel: agilex5: Add Altera compatible for I3C controllers
Date: Mon,  3 Nov 2025 17:24:27 +0800
Message-ID: <ac9eb45581525f1f3aaffa46a73927038ea8a9ae.1762161408.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762161408.git.adrianhoyin.ng@altera.com>
References: <cover.1762161408.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::9) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DS0PR03MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c997adf-640d-4624-e7b6-08de1abb2778
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJUT7ZIArtdD/PO7VdI3Z4F2HQF16CBm+fvEJFeYs01BttP3dU3sjt3rTzDF?=
 =?us-ascii?Q?SmmLLljtsPNX6KpXHR/v+85xwJ2rOZJWAaYSj5RCL3Wv1oNaoyJxTjcm5z+5?=
 =?us-ascii?Q?psJE208mla4Wy+gokm0NhMLLxqb4kFdNu7kBFjDmef95sm+in0p4msqKMCPN?=
 =?us-ascii?Q?BOLVxsNuFSWCXt/2xKzOqoEtfiwAK6HhtFWqICJ96HaS3qdarE9p1rmtDDj+?=
 =?us-ascii?Q?EOW3FYtwNyiW34e4ERHQcZrRlE647KI8CYQwYs02sxO/w08KKiEYsT3j7iOp?=
 =?us-ascii?Q?PXMWIq/mNepDDsHxnhYQOuhtOQcHzI/sr6KWUimSFzYq5zOVHAvQDSiaXE2V?=
 =?us-ascii?Q?OhZ6HgjmAi+M6RzHHkSw9E0Xejd7/t5bSPBBlDEiy0XwvoR+FrDhGa5HY0kH?=
 =?us-ascii?Q?ao8NUYL0HdIao54vnQrTD3CvvELpFbc1fD5NAZr4AwmV9JUi17CHmo5rQH6E?=
 =?us-ascii?Q?2Oym3KsjteGWbsMINrTY4ewpziAGu3E/C26H37A3hJSymzRzF6yITOabBzNP?=
 =?us-ascii?Q?s+vz7RNAOYmCj+tV7qmjD3Z5zkqygUC4WeNBeGuTABjlPvwUJmBIISmBIUkD?=
 =?us-ascii?Q?3d4Xspptm51IRABesqy0w0h3OeEDtGXUfS62vVZ/lTD60txfeMF/+QCVp/ov?=
 =?us-ascii?Q?k2oGPFW1x0kWagS5S5MXcL8ksnZxIVxbfUHAilLftowXSPb5l+wZRQ3QT4uP?=
 =?us-ascii?Q?WW3TzEswrPINmQFJfMPJvGjS8TiDsUVIkbulIeEmRkTZ7sE+1Dkdl3pFRW3F?=
 =?us-ascii?Q?229iwoLTNWSffDtSSpr1gM0A6UJbQDFi9evT9iNZz0ETV9oLwJHYGPGiTi1n?=
 =?us-ascii?Q?EBAcwIWewkpeouYtTVH52kH+tMP52ZsDfD9EN/ZdYnGx9osgnzAmXebIOi5u?=
 =?us-ascii?Q?DZzAX8iMDzf4Wqh1sbHe1s1Tf3gu3gfTrVyaBcV+uEA3woJNM8mIj/Iq3kvu?=
 =?us-ascii?Q?zpB3T3X0myG+bJgcVU1Trvq7gn9KhEbCry3wE579haDKygzhBEo2gAzw8qSg?=
 =?us-ascii?Q?EUbZ+c8blZ3JE2u74HUgZCCN8MGSVrB1jZDduxPuuNh1e2V9UJUNmCZQRkQB?=
 =?us-ascii?Q?/rFBvVtXJ+YX3P9DIAxrK5xFS137UR9XAZBd6Eub8u8wMP66eamy77rhBs44?=
 =?us-ascii?Q?y1hYZwDxBxJO13w9vSG/4pnOr+AqQyqA58KCkjayat5e3fc8zBXkByc3X5Hg?=
 =?us-ascii?Q?AOTz1SS51OvfAzqnIahIu+EzUYR9gak2pLYRO6amUybbGjsJ6bAuO0hSmwHr?=
 =?us-ascii?Q?+rUSA/lp9gAEIocFyXj3gHGVqhaZq7/cWYtLw1tpU0C8TKvtr8cyResmXFck?=
 =?us-ascii?Q?yrEMi6CRKxy/sUs0IoS0cso9vZ+RthnPd6yVG43N1+WmpULHEqqd49hjHiEA?=
 =?us-ascii?Q?fDs+TWA+rAkf0SY19gJoclrS1LEIIAuXcBmlDnlB2E94zDKFWawNSO8oEsPK?=
 =?us-ascii?Q?iB6+fbHnfBShEx0TMSKV1/TEyZKkJ4BNPrLeoxgiK6PPMMfI3Jznzv/+YFYQ?=
 =?us-ascii?Q?wq2EYOUm6K/c6J8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xu70pi6/0KUiWbPYL+ynbZSCwuIBhFT/Yr20AbiQ/DWZs5c7a8kXuaidY0Hd?=
 =?us-ascii?Q?fIqbKVSqMBk3FI34F+9OW80JQTHCCLZkb2PGhkD5MAqndhVwLwIjMS2Whstf?=
 =?us-ascii?Q?bMu/yTMjfN3yyg7myowYIXEaX3Eheh94qFLfuBqgLv9eHDHoNfufVk0xOhOX?=
 =?us-ascii?Q?SGJGU0YuAZn29Gmjrn8BFAPud0LOhAJA2Z9YRPfRG73u2QVbm2K8NKommP3B?=
 =?us-ascii?Q?hI8brGE/qB6MxdAWZAu7dCYCdy102XQNj+4RCuWS8C0VgyP12d0a2Jxb4wQc?=
 =?us-ascii?Q?vDBoVcMGLN08Atb8+I9c/idSEJzZhhLEhn/TQ0oxY5iTCqIuQ2OBGItIAyeg?=
 =?us-ascii?Q?/RMEnkmtfaEvWcMXzFvsoX4jwRMH38FIBXWn5FUD7BcFdjcI4NxNL6pxsjHA?=
 =?us-ascii?Q?9wuk1Iko38QDGAV/mHRJAZK6FMzc4xTo2i33N9E6dgICG0s7rwZRmSK6tA8c?=
 =?us-ascii?Q?I+3G0SgEmIyuE8G7wrgPwECu3GayIGMKQ1TiqvnH+cU9NM+4Grm+3jHYncqD?=
 =?us-ascii?Q?h69JR7sh1WlJ0UYMTLzhRjUlGrosRXYVuM5HVUanSg44OaUmVSa6kYvhI7kX?=
 =?us-ascii?Q?VZq8Qk3dhkku4f5ueV1K4FbHAEXBVbicRYON+mAwaexoiYYscz2+71EDhOkX?=
 =?us-ascii?Q?aEyHgwa1CQS++SQfSaZmRsXp+cgBmFvb6ZdEhOscizcTQPJZGVD/rtnRJCV/?=
 =?us-ascii?Q?uQVrgJvoKcKtRDn4nOCmk5ySmpn0TWGshJXCi6CHB9V3rxs+EMS/GPhKs5D8?=
 =?us-ascii?Q?mhOW596jLYGEJPfdxMGedEYQzoDa8WOEzuQSB3OBao1JQ3Ll7ljEAjLr8xPT?=
 =?us-ascii?Q?4L0MLed129f03Fh3JfB3ZR8tIwL967kTkHg7VMLzs+W4Y5v0nONEZZMaZbNm?=
 =?us-ascii?Q?ONw8j9z7EpWPT/y5CqMTmq7tlMAgHgBIPTo5BiOeetFOD/ZH7i/eR6LmhVFO?=
 =?us-ascii?Q?7MK1RqHyhyMxzRd+JgR7wfxGHy67NEViyjERXfz0k0jX/cAgx8blkNVHYUSr?=
 =?us-ascii?Q?hihxvJV3nBu+WgBMOnYwg9oUz528vssyNFJspl0EoTpZAIvmFAR3ZqFXjfw/?=
 =?us-ascii?Q?Gekx37M6aDdJKe7bKkINPUwUOUbn0LBdez0FOe025Z9fymmGtjbVWrD3MW0Z?=
 =?us-ascii?Q?iQqsHZhAbNGmnXyIhPr7vVW6+REfD8vsrFLHNdyi0cCCAInO2n1HS00wVFc+?=
 =?us-ascii?Q?DEnuINuwV/vaEmZMXFf2MrzvRyxSbfVkrYQp9kWdFztXLdiaYsoYPSrnL/Uk?=
 =?us-ascii?Q?NxqxE0VpSV70brFINY/eke53PBSTydo8QEF461a6jDw2Qe3XP1KZ4dPm6mqG?=
 =?us-ascii?Q?Vfbx5EpblH7ySWkQegHbU6LFGhdhZY5jttGun/cm+NgbbY7TkYwAv3m0LBym?=
 =?us-ascii?Q?XuubPF1Koe41idyxT/0oDN2xABO27WWxz2f1uZdxKBgfioi+MJFSa2yzGeY5?=
 =?us-ascii?Q?7jsZ5GCOZP4mjKoxEhQ7fTl7McuzwfIs1jD1eH9ecfSKTtHZ3bJ3DR55LM/3?=
 =?us-ascii?Q?/0Oe/ucKdORlzutmM3Dd+EsVhxD4kdeEZ42BYkaBH/XbxuauDv5ryChHbY+g?=
 =?us-ascii?Q?xSoeZNRa8UzYAskC65igilVI61G/tJbCp/Tx9Gp8A5OwCwq8/eTyCX+01RxR?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c997adf-640d-4624-e7b6-08de1abb2778
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:27:06.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2gWZZZiAeS3nurPOuBzwkFZAAZsgQdXvGwRtxrZ5moZhF+1cuu7cQgUsfkWkGLLKvkpMy5LIW+RZQ5xobB6uGK88H0jUDv36q8ZeTy2bKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7252

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the "altr,agilex5-dw-i3c-master" compatible string to the
I3C controller nodes on the Agilex5 SoCFPGA platform.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..5c8ad5e9b248 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -203,7 +203,8 @@ i2c4: i2c@10c02c00 {
 		};
 
 		i3c0: i3c@10da0000 {
-			compatible = "snps,dw-i3c-master-1.00a";
+			compatible = "altr,agilex5-dw-i3c-master",
+				     "snps,dw-i3c-master-1.00a";
 			reg = <0x10da0000 0x1000>;
 			#address-cells = <3>;
 			#size-cells = <0>;
@@ -213,7 +214,8 @@ i3c0: i3c@10da0000 {
 		};
 
 		i3c1: i3c@10da1000 {
-			compatible = "snps,dw-i3c-master-1.00a";
+			compatible = "altr,agilex5-dw-i3c-master",
+				     "snps,dw-i3c-master-1.00a";
 			reg = <0x10da1000 0x1000>;
 			#address-cells = <3>;
 			#size-cells = <0>;
-- 
2.49.GIT



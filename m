Return-Path: <linux-kernel+bounces-763816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE289B21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF65E1895629
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2842E2DE0;
	Tue, 12 Aug 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bzteO4hH"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFA2DEA6F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964629; cv=fail; b=Nk10Bq6wL5RoDHr94uZ9yjThp7feYAKyYvI8df+IDQRcI/FJFd4qHxZPBnpKSIQxQbIMbU58t+30P/RX12CvQUB/xo9COAmXHk2eujhi+aRET7XjjvHMIJxA9XROAkasIIOOK8/ct4tBaO5IiwEwC9m95Bu6v/XBdA9wgchvtFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964629; c=relaxed/simple;
	bh=aKXxxKIHMXYDYJPXqlfdFiSTUrJB42EX9UTD7bY0a8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RAaqGPX8j4Qe6hOsUauwvpbh6YyTtTtYIPpDEz4xKh0cykc+5NP+Uof1igP18VPdhPT1aPbOHxbAmHv9tEswn5mIQMXt5yNQBn2zecrV7JBcr5YAW4fNkuigd9rqWPYb/ZIbE5SGe0Wnvz5Tpb6l8JhvckVG11L3TePzPVIbnu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bzteO4hH; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0MHXuV/3nndpbwDxZtFSPML1wuGtzzqh50a5TXzJuVHHvA5Ru16fhjysrV8uxFBMKZY/iVtoQlK7hvw6GmpqEHmC09of75oqXAl2uM6vlh6OjKyObod5ArOozXATp3ae7V0o646QdfSFk/QM8CAnHAdYCvHtOzSaT9x/iw2zztQFzcW2ns557XDHIaVUCRYn60u76KGtMBC0iukIsFECD4H8a4hvlE+kat67tLJf0U22WRuXNsbR/TAe5ggNq/tsGgUg0Nioonh7/t0oupSA+Xo3McOYjotXNJrLMFGSzi2jIVgpJ8gqqs4cVyTHR7E6vO3oY7uVCs+xF92GsC0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDu8STYElf8M1xLTrj3SAudrPYVC2osmJ+TAx26Lzbw=;
 b=pT4COylHyl2l3UTcab2VLTkEtfkH7NIXG8L8miKLbYzZfXchdaak5J7gRLDS9Qe8Sk8+DEMxHZePsfqOc5M8Rv9ecGN2w/wFHA+O5c26pdLXtgewA/jpV+B8+Z2FcEj1IC+vutnb6GYSlKyKFIwh0YYN5AzeISLwGamy6ChjS1gq0iyRkKoTGtCe0i6hIKP+7Y0hJvYKTct/ljHItC9fdyuBoAWnIuavF65fByUH5C1Rhr0aBGpItGQLVSO63baedk/mRHxWSK7HAfhAtf4N34JUchX/Wt6Vvi6F5een52P4K0ZJXCDCdy8CQFmKLxLz0bqyjF9LxjDL/2Ny3v+vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDu8STYElf8M1xLTrj3SAudrPYVC2osmJ+TAx26Lzbw=;
 b=bzteO4hHSpjNsX5/QmOQxkPeb2xlNatTV0ND/Ti9rSnEQJbjY6IOzLYf5cxJbifyf9KUXFHz9/ckUM10cpOcT8o30QEGmSAAz/smYl6D/gFqfxU+d1FtPUGulcZBf4uj7jN6inmxh5tJoAkpilkE08LTBcRfAl4FR63Llatfk3v0ADV1H2iqD/I9ySDzpwWxoOxw9um1Ld9OXmxAHbFsB4479ko6fiAmhPaFGXujbA3wPeajXe60995l8/T7D/jAveunET5qB6S/rKSlrUU4nWEdV2EJq7nE4I1sNt4/5Bavys/YqueyNGCgyfIqRKoNTMkKdHgkBZNRrP/iLobxQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6733.apcprd06.prod.outlook.com (2603:1096:820:fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 02:10:22 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 02:10:22 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org (open list:UBI FILE SYSTEM (UBIFS)),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2 2/2] ubifs: Simplify the code using ubifs_crc_node
Date: Tue, 12 Aug 2025 10:10:08 +0800
Message-Id: <20250812021009.414756-3-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812021009.414756-1-zhao.xichao@vivo.com>
References: <20250812021009.414756-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c829d5f-f8df-443b-6eb9-08ddd945648e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LY2mcn1Y2E2qsjQTEEcYqmQCXR3+d7y2Z6Vc8NxgtMcGm48nHb0GZHpeNExj?=
 =?us-ascii?Q?18gknXk3dQA5CGxZdlBgMijMtomeuBVWZ2NzjC5nzXd0QIGYg1x5eHbmsrWo?=
 =?us-ascii?Q?aJ0Nvwanbn8R+VZ7K0PQhkuyrjNGgnZ9lRV7VJMX96zpNYiIs4D20opMGz7s?=
 =?us-ascii?Q?iKXdn6RRzUtNTcm1zjy0PbmGDSztOjPoB/RO+Q3iWm/Hvc8EA0nxi2z+NW0f?=
 =?us-ascii?Q?Cp/ugYWj79htNbFoQED9UvPOhIuN0Pow//o8ibvd4vOjE43IWNYsQ/AbSxrp?=
 =?us-ascii?Q?McCyVCydOjyEjYGqtjPMK7R7tQexhzbTmhVAJYRyyUSXVYMql4XP+L7GAPfl?=
 =?us-ascii?Q?QDrs89j7HlBZ/KfmXTnBwb9u6yeDYjeln/utS3i/yretLaKT/jpERVQ49mI+?=
 =?us-ascii?Q?J5KlOEuYmrS49sh3L5nnm7Bc4+Y5F464r2F0FL44ztFTCROhiGIsUo2RwIXu?=
 =?us-ascii?Q?wnLw7Sk+AaC4SyedbjTx8W8jtexXcERV9F3D4N8TeZUHf7kqJ2LvCsNQnJ63?=
 =?us-ascii?Q?lgsAcm0jVtCjM/6Uj9uEK5NpNa4iT07l+U40vBTPrqINsLlXyI0GquGL3sOp?=
 =?us-ascii?Q?GDIMDAS6rp6GEDce17V0UuPMo43gtnCxIiJ7R+ZICTbz+CTHxu//sY6oAyhh?=
 =?us-ascii?Q?UAb/1jmPPdtkbzo60akWy7nNtCA2OjxrygHm7yKqlSC28BEBEa9Cs/LosXDl?=
 =?us-ascii?Q?+BcXtJkfhq7+Mef0Voztg58M8OvcU5cuNaYPYqi5IQV8Nt8jROeRqlg5RWUY?=
 =?us-ascii?Q?Do4bEgX43W3ybFOYcj7deML1x6RNfJe1h9hEeDnaj/4TkawjXsK7byEwbM/y?=
 =?us-ascii?Q?N041Hv7m+a0SxjgMIVhMDqxN/nV87pe2yaJ9yCrFidIWexgOvgi3R2UC36Gd?=
 =?us-ascii?Q?SE+qJHKKKWSEWSd7utXF9Pa3rHEaqgIuFFlqj1N2ijXCQ8Ostcue/8nrbX83?=
 =?us-ascii?Q?iutmzwg7hWocvx2qqqIs5D59BbaO1rVyjLHTM4ya3WCXt2tu5/UTnpd6jF+r?=
 =?us-ascii?Q?NtxYJ6jK+gsjs8wxVOo2JYVe5KcK4TDSC/KI5pM1RXoft/wfWWSWGO30hCFT?=
 =?us-ascii?Q?hqZmpUqSvwH8zVedyF3cBYJID3ufVevQa1p1aNvKP28sKntD86cVpSXay1Q+?=
 =?us-ascii?Q?YBmGR3/fcUAfznysMaBwZBrz63yRArs00wMWvi/+MGf77bd0h2FmzXAaTKh0?=
 =?us-ascii?Q?JNbl7vxDV+qA8rLt/RhWh/vfsS+2jPuJ8olzYix+n4JlKTccFgm5tWCc5kb+?=
 =?us-ascii?Q?nfw9EXml6GRqFyKhRl5wOUcb247qVbtn4yQZAt8ineA05/7KKvh4u3X1xuG6?=
 =?us-ascii?Q?D72OTO/L1i0mspaz+YvrOhdDmng3yuc4cbpjqqfTu3POe9y4q6y+AnT+8RI8?=
 =?us-ascii?Q?IHD4qClSU8XAWISZlFFZGt1ptmvo74zeQTtyUKeGR2HXOMkJcNebBkYFnfC6?=
 =?us-ascii?Q?j6+8euWwPt06S9R3oCxDufGb/w3PvZxAA0wacpN8D2pPrb/R+rqAxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpOqzEFhVX/ZZQbOx8E28wcUoC+75C50Yyzae6Vm3GoejRs0m5UZw+wwqH6I?=
 =?us-ascii?Q?ghU9fSzgD7PApQw0NRxrLHjTJS8ls3f7OvUu3iOwyCRknOXqeKRzy5RnLzjh?=
 =?us-ascii?Q?PF2woAO6EDfczPQU2FabbpvJTZu+sn0MWnZL6bB/TiHumlUuikDd+/UHaVjz?=
 =?us-ascii?Q?6eFP2TTKK80yZ8HKPY3Q1vBcDFFpbg6S9WSUu+DROJolmBYtqbVUkxzd4aB+?=
 =?us-ascii?Q?rC4BhXxacRgQhsIjXW3kX4FMLi9mAnfzOWcVlQ3tpdnWq4OQp6IJoAjE5uBO?=
 =?us-ascii?Q?lOQ9Mk5nrHlmfHQE0s7xicgaXq4rAgIG/W+Vf27RvzHwhLAMaFXyzZjqnIVN?=
 =?us-ascii?Q?aWTjJO66HyamflZ1lcC9VRWujC7cxJvC3OSe4i3Ke3kUdbv6gC7+68l75J7S?=
 =?us-ascii?Q?Q+V322S2gOndeAx90KOuYXen5YTzN7LAw8Z86cN8AQgcv8UBgEBp/lJNC2Fa?=
 =?us-ascii?Q?42O51O/Y5eejX3J0AfQusW0iGGBYZorC0mafPK/vRtpFMAXy22NhQeCoMI0J?=
 =?us-ascii?Q?cC37wGN0moXGlLvAxwFAFNjJVeXbgCpVYfbv+fKAgYxAXZfyTaSPlkRQswE0?=
 =?us-ascii?Q?sKXRzZnletdL33JrnFOcqxeAXU2Z5+ltr1NleE0SQi0BWexXkGGSeeWfElYP?=
 =?us-ascii?Q?Lf3Fdmw8/SR9XxXLmz/q1s4JqGCdlrf5WYL/8Uci4XGJq1fKFtd3C9TLFlP7?=
 =?us-ascii?Q?BUkDQnDt5nYMnbjuVTap6kO7fWWK8Rog4vx9BR2SjFbpMRCicQFCH9965JFU?=
 =?us-ascii?Q?B4aqbTdXTQhhwHLSMySKWlsN7fxc2djS6KqqJWoUVDCedhkGYtXAsos0uxI2?=
 =?us-ascii?Q?DM6WvwtN7Uj5ZUm/lTsgNzsbafBvytb7NreDP4zmLjZI/be6B2vfoKu/mMgp?=
 =?us-ascii?Q?XPRu67W0qila+F2e5bdoge9/GvXjyyAjmzE4/kB0StUJkzStDZ8ffPiaR/J+?=
 =?us-ascii?Q?vnhKkttMFrxkGrc2DLIlENAlp0OH8ChwdfWKxMlJDYFENIDix4K356C6Rp3P?=
 =?us-ascii?Q?fL83GgaWaV/e5O3+8Hw4ur6oYwdIMYlXyx6wUP/FumoSmY6i6fOxwe4KbrRG?=
 =?us-ascii?Q?gCUZy7EHAetAtmomGZzMnqfLcocLxzcDMa0eZ7Cfqg5cYvEkO9n+O3IGiNkJ?=
 =?us-ascii?Q?+6YG2Fr9DjsypG29ge8zXP/0Hk7VccDv0nu/8Ekzl1MrHiCLoRu6wbTXDrCJ?=
 =?us-ascii?Q?uAGydoY2ZmWIWSh3g4ojAk1WBRUuKHanw7WYeWCg/Xdxjz/QDlC1pammVdUz?=
 =?us-ascii?Q?M8jCg99qbUhFK558gMeQn2hlhSQLCGaopgdhHtc3ClkH6ugHXmFbYbzQtCrv?=
 =?us-ascii?Q?qAhxz0oQQMl17sytRPkA7vJBKHYohv1bRqdkWJGWW1rSKWF3+zfZMQzt+SBI?=
 =?us-ascii?Q?XXVtKV/kuhhZ7S3jtkIxeMFaVUnrb0z+aAB3E8r1cZtQCPMsc7FWgxytq2/j?=
 =?us-ascii?Q?yv9YouOr7LScbdatpCD35tOP7vLxGIL1D323m59qIh3dTzydi6YCFqjrpuJB?=
 =?us-ascii?Q?ly5JavHBip7zpzioujdJBLcIfxwkfua7UqVmt+cOywj3x/mjFKpoRzgHoEa8?=
 =?us-ascii?Q?fP4ewHBrRd+21S+RKwdaaq6qaXjHpXOspCjrt/I1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c829d5f-f8df-443b-6eb9-08ddd945648e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:10:22.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68ZNNgWMb7ZLRKjbQdVLlWnf/1COy+3VlAzd9upHQcVlmWyCQpZEnIgeXRFO+PCI/ULoiCOjCEF11/aFDwS0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6733

Replace part of the code using ubifs_crc_node.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ubifs/io.c       | 9 ++-------
 fs/ubifs/recovery.c | 4 +---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index e0dfe6827d65..6c6d68242779 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -327,8 +327,6 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
  */
 void ubifs_pad(const struct ubifs_info *c, void *buf, int pad)
 {
-	uint32_t crc;
-
 	ubifs_assert(c, pad >= 0);
 
 	if (pad >= UBIFS_PAD_NODE_SZ) {
@@ -343,8 +341,7 @@ void ubifs_pad(const struct ubifs_info *c, void *buf, int pad)
 		ch->len = cpu_to_le32(UBIFS_PAD_NODE_SZ);
 		pad -= UBIFS_PAD_NODE_SZ;
 		pad_node->pad_len = cpu_to_le32(pad);
-		crc = crc32(UBIFS_CRC32_INIT, buf + 8, UBIFS_PAD_NODE_SZ - 8);
-		ch->crc = cpu_to_le32(crc);
+		ubifs_crc_node(buf, UBIFS_PAD_NODE_SZ);
 		memset(buf + UBIFS_PAD_NODE_SZ, 0, pad);
 	} else if (pad > 0)
 		/* Too little space, padding node won't fit */
@@ -469,7 +466,6 @@ void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
  */
 void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
 {
-	uint32_t crc;
 	struct ubifs_ch *ch = node;
 	unsigned long long sqnum = next_sqnum(c);
 
@@ -483,8 +479,7 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
 		ch->group_type = UBIFS_IN_NODE_GROUP;
 	ch->sqnum = cpu_to_le64(sqnum);
 	ch->padding[0] = ch->padding[1] = 0;
-	crc = crc32(UBIFS_CRC32_INIT, node + 8, len - 8);
-	ch->crc = cpu_to_le32(crc);
+	ubifs_crc_node(node, len);
 }
 
 /**
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index f0d51dd21c9e..b36dc9b032f4 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -1406,7 +1406,6 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
 	union ubifs_key key;
 	int err, lnum, offs, len;
 	loff_t i_size;
-	uint32_t crc;
 
 	/* Locate the inode node LEB number and offset */
 	ino_key_init(c, &key, e->inum);
@@ -1428,8 +1427,7 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
 	ino = c->sbuf + offs;
 	ino->size = cpu_to_le64(e->d_size);
 	len = le32_to_cpu(ino->ch.len);
-	crc = crc32(UBIFS_CRC32_INIT, (void *)ino + 8, len - 8);
-	ino->ch.crc = cpu_to_le32(crc);
+	ubifs_crc_node((void *)ino, len);
 	/* Work out where data in the LEB ends and free space begins */
 	p = c->sbuf;
 	len = c->leb_size - 1;
-- 
2.34.1



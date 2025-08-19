Return-Path: <linux-kernel+bounces-775796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A8B2C519
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD8F164B64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BFC2C11FB;
	Tue, 19 Aug 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fvBGz7vi"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214C2C11EF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609150; cv=fail; b=CKGszoaTFDL9BgufM4aJRL78mctkn/xRH3/3bHsxukph+XYx9+Ks9P8vvfmwa5bAkQaJ+HMkoFn9Q1WAhseo1bg57PNM7qk+p2K4M1ZBb4jUXKAhLO3+uRAHDa4LDUEe+wm8AUz6n5TlpqGVpZmSwbQrVtM3e1QnBbeCUCuZvxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609150; c=relaxed/simple;
	bh=DRtDnJ8dMYn/seOE7F2UzjzyPdpUARnOl+WRv65XHSg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=II/XIIiOpKpL1doEYUipDGK+wWA9G2helE8uonbBW+9s8j3js67QPPtcOV5RuXD6bXnUhSHYoD+Ds6aUi81lvJsGiIqbe4VxyvwoBRTGD8TiooYlVhkAkwQ3m+2qpPqJbR6kSPBMPjw6dSG9+QdOcC9YVQdE0AdWuAmPykgYNHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fvBGz7vi; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSeHV5Ur2vJ6VZL0uRmk0zQWVroKJSroI3w11MXU/TljZx/LmvaG3nrvPOKysJ36D1/Jq2P4kLPx/+mVgrmO59FKWXR1lYmdTBIh/qnZx0QirzOAvz/KXrX9o9F4pmDI82FsNzLwJ5OBmheQgqgK8WLqyv7eUW8lUt1DilR/9Kk5FLq7rnohSdwRVamz+XRGXJqUwUyXyHWo8TvSkCekiyRt6MdQL9AHTXg5EGZyjt8btiJEYilecj1hn368T0tRzjkuugAPksfGQUZhM7DATcAyVUXjmRMNaYtm1WAi/NRkpfVmyn8BsiJHw+9SG+Y38b9xsIDPKGd83730sLoNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYhXrRc/OCgbjPUAyIutKc/cKWG4c48UOVxuuFYaAhs=;
 b=YPGLoTEES6cVHx7/vtv8yWixIsrGNpkz7ewpxqUCOYZVIAXfQPaNYokvPwkQUn32KIBRZXdU1C4UQJTx5oPrTLbyBMPvg+RortWeZTS3Oxuml0t2qN2inA7iIbdMiKYy/sqoaiob4x5XlsqigxkeHuwfYDhMoywEt65tnqskKTaLHPKiUXVApw9+3jNxEu1OF7nozui9fGnNwxv/7HRUPWTWddhCmpG/Qm9Q/dE7Kc0zEFmBBJFUk79ooYn8Y7XcQ/JBtH18OtGi0cKte4ciyR2Qg4P6u7NBF/ZWnETqdRBfHdmuEI+oSDCFTQ8KHqapuzSpBMGuDJvf7mL7mjGu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYhXrRc/OCgbjPUAyIutKc/cKWG4c48UOVxuuFYaAhs=;
 b=fvBGz7viGmKJyQVJpRl8odGAmnoInL9e/smQJHT4E/c1hDRYwJafueyCyGC2A0KItkDUzYeVxYHhT8ORUmmC5VPkbaZ64ZeVZyevk9GGsiAsj7Sl2vh+naTV845aaTW44H8tVpIJa9WV22u7WiiKLKpZt1+VDVHQHHKrcK1pgXylqnJmqr/9eryvjIorySWnxOV214ynAxVaXqwWOUwpD+JBYob2VvV1Lh16BYQfkuaCjo3CteVDHOQUvR7lGRM2xWCXicrLZHeVFc3VmyxzlQCYLRghuiMZ7Y/dNk4D5pZ8K9KxzgLHVZZFONILmep296z38cel4ldcdEb2vX+4nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KUZPR06MB8028.apcprd06.prod.outlook.com (2603:1096:d10:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:12:24 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:12:24 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] staging: gpib: tnt4882: Remove redundant header files
Date: Tue, 19 Aug 2025 21:11:54 +0800
Message-Id: <20250819131203.152724-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KUZPR06MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f8670b-58ab-4236-5340-08dddf220982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?an1EToX9ugjdQGEQy/ATjwuUoIH0o/+WK679VdI7re2xdMOr99faP4/DczBQ?=
 =?us-ascii?Q?HNtJktYF3yBgUg+A9VYSgR6oim4xmmA6brh7emjVLC/o/ncOMk/w/l4zxYzn?=
 =?us-ascii?Q?DQDVaVJejSlALkgaPK2ziw8CJPnv3rvXEZjQmn5QsaRNABeW50o5SXLdNprc?=
 =?us-ascii?Q?La6e0PlQLZWXd0CM8YZY/en1PotHtgl7Zl6RNsZ5CBXLQplYMHN7L942XxND?=
 =?us-ascii?Q?0GquWAw9IzIMHmZeidYFuT2DpJLoYF+/HWvHT0M5e9kSXtgWr4HqpNL1VNYx?=
 =?us-ascii?Q?TNkQBPiht7rXdykKi5pHLayNKPDXIkfuCkLHZwEXVE9Kyk35J6ITxTr0Tnz7?=
 =?us-ascii?Q?Awm0fiaSOSNB5g1mDfd4zK+ihV1ehUnCmsCGL6j717bnx4VlOYhG33BwB4CF?=
 =?us-ascii?Q?5pEFNcBIUJKe8PAWYvDvq03ZVNO3gfpfutl6qRZyZtNl4x19qGU9J5iyD/ZK?=
 =?us-ascii?Q?fqcRuI6smEIt0JdB4sFZLBlB69MLjsl6tlk0tLStl01ZvO32kV/Q1Zot52wI?=
 =?us-ascii?Q?BgidVuWE4/OTnUKD7Ioy9EsoCKfQErTd1T4Oy400o66aL7cKqU20CKzbZ7Mh?=
 =?us-ascii?Q?9VVBfWtrg6KD/h2vpVA/2JJVoxlWbHtmN6bhkXaHqzIOfY4bX6DbQdHewKBS?=
 =?us-ascii?Q?kH/p4q7A0lSHgAyHjgLhPcVau2kaJrsRsUj+P666BizlCsdg+F7wM+oB0S97?=
 =?us-ascii?Q?nfrcqRr8A4G+/8gIwLGIIxcz20nytUKr3o6N07LIxxcGvXPmyjq9sFrnAen2?=
 =?us-ascii?Q?UcYhw3+CrP7dBBrnnVW6QPkFcxntSzYVCkO5Gq1TvoJgDNTqxOG4a5n97wWv?=
 =?us-ascii?Q?rPKAcgilr5d2hHhX7E6lan+j7pwXBFfazzQN5uCYqW52oI6sp2DcK/RXdLtB?=
 =?us-ascii?Q?Q7zmHfUDK7M3G7CyNQBBeJd/i/UYC2lFlZ73AxP/QrqHrLVJZhzgPWULC1GG?=
 =?us-ascii?Q?dopkn4wGYYSe82zpM7hy4z4HBnola2IDJGA+ovU9XOqHC6jYTSqfsMn3tHsE?=
 =?us-ascii?Q?fja6iyZ8LKo8hD7Slnzw5NQc+l5SDqAAuNsOsdNFvGOxH1naSk4XKMdyXQVw?=
 =?us-ascii?Q?tzIUlqsApw4G5acULHz9fQgcC/Ihtz+I3eiaKI9HPhVNsfdT/FehA1rPTLfg?=
 =?us-ascii?Q?2vi+73QyZVIB0sQlswp7rYtgBM5xAZ5exYmmQh3rJlpi577zkn/UPB0X8Df9?=
 =?us-ascii?Q?PNrMLenzYCWeViDHFIsrnVkqY2l0VcnbBRxQdBdzzTyW/GoGvSyfft+GnB8Z?=
 =?us-ascii?Q?Q4W3N6p2ASKgRyb2xDTBBBbRJshlPui2ZS7KqXBr3elT//8gP5sYF6V8k6Xz?=
 =?us-ascii?Q?5s7iz3CtmIZTJ85dyJVRr/sfwT1fDCf17vrSFqZJfrJJjGXavOxzlQFaQyM5?=
 =?us-ascii?Q?JoZeGZY2of6hDiRgPui5tVzqDsFaa9gs8e6Y6JYkF05b/gYuP4ytjtYHnS+r?=
 =?us-ascii?Q?FXd6Yl1RfzLFIaF+dGy6+EQ72m9Qv3vHx5uRAkwC8Rxd6epuM1iatA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cPjmXozIq5xbXhjjWixo2PN4IOZrQyopyVyhkSMXqrK0s2C1rzgXulEACj46?=
 =?us-ascii?Q?fj/kQZK+5/+tquh4EPxzLz99UmV1g8p4JR2nu+1IO2GrWHjp9auiNXNy6BCw?=
 =?us-ascii?Q?VJZyxtpPCHAoj999I9YOLLwoh1fHIgYByA5toPsFjGyKOA4IW42oNfv+RnTB?=
 =?us-ascii?Q?gaLLVlQtcZLZrY8U/3iGZw6xInENU2GkIQRswhSsOEYnF+ekW7Jm8oYeTohL?=
 =?us-ascii?Q?j4cbnr3bV+5L2hz5QVciIz25Rpot/3c4HpvQ2Lh/A4BOawDl4rICq4UyX08e?=
 =?us-ascii?Q?j3rIxzPL3pMWItl+MJjI7ryHfiI21hdKqjz+8ZLP28h2UbZvzHsU0DTbvNEP?=
 =?us-ascii?Q?CS8wZscZXkyseBrEp3nkGfY90TZstiYAk209nhKn40vqbBUEApFqfpW3nQQb?=
 =?us-ascii?Q?YsLPFYLy3aHZRaZwRlvy6Bn/N8+/WOdsvua1RUeyUcVZq0baHAqi5D07RFXK?=
 =?us-ascii?Q?2pd75zknyoWm5XLzLZ68rjij0aKnl8bsDrgbA6zcVNpzW3Kep2x17PX8t+8R?=
 =?us-ascii?Q?Z+S5sBcbTofsjckHInPYAEVX7WCDSnFxYkNbbI/UjMSS3Ib8YHtesQM5W9hO?=
 =?us-ascii?Q?Buev2MGgZMkt5ZmOTV85uBQENyWNCERWqD3fuLHNzrkCMD/TuaERn/0QhQBe?=
 =?us-ascii?Q?AFpHu7cVfg/Idi3tH89PhodzI+hx5yX+W0IBwV/ctydfj84FWYwCujBnFsvf?=
 =?us-ascii?Q?5a2pDNsPyjcIb6RpZJR5UDyIoTFpNYRmZK5TcoMMQ3GCE+RirR6M5jW3YrFD?=
 =?us-ascii?Q?g27V6kVPLkIPCVfB16YRhgPnXFgUFH2Y0aQyokKH4JCB7ie4DsVxFcDDjj65?=
 =?us-ascii?Q?wcx6t3gpP4sTFi19sd5BJNvjRAhf8xZcrG3V6s4h+zvg4AotfmxUr8PfpUd3?=
 =?us-ascii?Q?/lJa+VKcfM/zx9E/gbNie+gnWioXLTPOUH/JWCAVRMYVdqfVfeb6iz9qjVAX?=
 =?us-ascii?Q?JRskOsnZ1pHYYtYl96dXiuW7rjUwdg0djIulZobZ4dE5hWBJRnUGGTDisW1X?=
 =?us-ascii?Q?nzJ7hWA5pbKddrGoA3zDAbA+LZxNzKoqe806IbYoFQyDFQZ/CZBEHgLSdv58?=
 =?us-ascii?Q?rh9e8MSJSvX8ecdPwA6W7FRULcHJHsm/oPfn2DfX2Gp8KcmVhYbRgbUQY+sq?=
 =?us-ascii?Q?AWXrGvDuZu0q1hCJ5IPJ6bOd9Xl9EOcBNUdzqgi2iTm5IPxXJkkvMK/TN1gw?=
 =?us-ascii?Q?v57hcE5+z+UVnUHQg/mKMBOqFzafEQZ3iVE/hiifD+xF5h0ufAQLWXuI/gjm?=
 =?us-ascii?Q?E19J046OaI0pvQiLqdYcY3gFG25KfTaztsNdSmueaYdsQrtxdDdIvcV62p1g?=
 =?us-ascii?Q?p1Mc5d7dNt0z65O5McWkFyJffIfpYwHUhqUyc+Zr0wKOCEx7zbWAPBxJnEP7?=
 =?us-ascii?Q?NaowPFfuCikIKtbiyW+SaMYvpK0r4rf7kweEUM3vonVJNNDlamBPtDz1wvAo?=
 =?us-ascii?Q?Uk8T1C8C9rxIkzx7V4lbLzATe+o8So631KNSiLwUBgk8csBvlTw20PHA3khp?=
 =?us-ascii?Q?NtK8a5E8KBB+vt5kLw6U1uj6uHYGO59gP4xws2dsBT8yt/y8Kgwt0t1JguEU?=
 =?us-ascii?Q?cRyFu8kmbX52eecKPcrpsx//JDEvCDYUfyZHKZJx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f8670b-58ab-4236-5340-08dddf220982
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:12:23.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoM3i71ESTdoaDf1LOzyzpyqCsbvEWZk3oeF/C4u4WbPvMDQAwhZ3HMdl3Uxq3OgIiJugEPH959FPxpbULyzNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8028

The header file <linux/ioport.h> is already included on line 12, outside of
the #ifdef CONFIG_GPIB_PCMCIA block. It does not need to be included again
inside the #ifdef CONFIG_GPIB_PCMCIA block.

Fixes: 0cd5b05551e02 ("staging: gpib: Add TNT4882 chip based GPIB driver")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index a17b69e34986..5ab46a25e025 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1522,7 +1522,6 @@ static void __exit tnt4882_exit_module(void)
 #include <linux/moduleparam.h>
 #include <linux/ptrace.h>
 #include <linux/timer.h>
-#include <linux/ioport.h>
 #include <linux/io.h>
 
 #include <pcmcia/cistpl.h>
-- 
2.34.1



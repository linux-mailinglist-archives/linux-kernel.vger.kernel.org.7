Return-Path: <linux-kernel+bounces-762332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC186B20502
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9859C420D66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89908227586;
	Mon, 11 Aug 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="juYGfpaK"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012031.outbound.protection.outlook.com [40.107.75.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001741F09B3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907345; cv=fail; b=DvxnOlzLxxdXPvTC4Ul4d+ZpO5KSc6OrNg2WgRZZwdER2J0nZ88IVrF1yAjyGdoYIjJGYFpt9m7cPWTJQfPRpD0SglsOQIWO55qZbjpOr6na+G0HmOSRLdd/mpBpzpfHtwaDI4YB117yEnbETmC2ikYhIS+1jBKW94MSIaKoCGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907345; c=relaxed/simple;
	bh=L3eyIk9SU4hghdgC6xaDEBeeTWQc2bDCscnETvYxchI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hIRsUXvVV0X+PmQhiACDZqRiK8g0g/dRfbneV1n+oWj/TShNuIGCE8psaQKucz/o5FOr1/Xlm8hultPa0TPOxTOA0xBQKGgQPvqoqWmw+7VxbH3Vo0Yl9E23VBv2CtpOGqpB4XQ7wWp0S9qS8RYs3XfAHLcymTJO9Gl1OBonLco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=juYGfpaK; arc=fail smtp.client-ip=40.107.75.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0p4UAztGFkr+mRCYpBqM9/KdDefVPNyoyTs1Y6Fht3H/u5v7Kver/u9Y91qXw791d9SqzHEZV2DNQIXjJyEW1MRsWI0Jba6n2F3+UonmC7vCE7osRPlzDX+tlzZYzI87smT//yDKflmIABITBlaJ4EJg6QNnYRZlRwqd0ektCspjY2/KZmWNyfef/Z14+yJnvPv4NZpr6j4meaSABXxN8SIS8FUOssjeIaNYmNP9uvN8mkuomYdESpsKN+tbgvye86FMq/9P8X+8bLSiTznlob12wx1+uJbukcQMjLNye1KcO2YLwwwzejwmTBVj9cxr9Wbt/ptPUbFgq3AyLgq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drfoqLXgESDz/JOFf986G9nCLLOt/JX7jjq27L1HlkQ=;
 b=wH12VQ2T+eiWCBAggGwgd1gkjUvABU+AVH22rYbzlY68sWinOe3sGMNyNpKRsrO/Sn5ApdROxB/xhuwzB1av1gFGt8OqCwdb9jQ+7K+devophUCHf/LC+u7OlRkvaD0FjF0O2SdK/6k1OtVXTxiwdwYPD//eiP2GQBzd1mhMXeO6dYh2hG4lTbkXkNjmDfykGfjmHI13LZkh8vOtVVhDCcc6OOwIvFA8nd0ioLDTolPOBomCqkYTvikrNYyMVJHfZTGAwW9SOSnGjDk3UAm/PYwFj1bPusm5hkqBjhiYZi5kKAYFhVWBT3l+lOZpzp0bxyaJ2c7e/7YLMT/lEYkzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drfoqLXgESDz/JOFf986G9nCLLOt/JX7jjq27L1HlkQ=;
 b=juYGfpaKAnKifycUk46KfAcCaiUd30JTrM70j0406smAwmOtLt/jp9pqbwNSccmwkGHHWIbRSXBs1OhOHjd0I46wBNVjT5CUq4pyqph4+GWY7uabIj/OAM35q4UPcp2QwUvg/i+ZMNTqqUjPK7eBCFuggq/RpXf2RtFLGMZrFtRT45rmOcFXywwlPjqIoeI/sXGPX038kpCj2pyCObjd8VfJw9WnZeXmV+p/AlX74amlDyTJfALciWsdZGkR21W4ImAwTqjRe1b93Zj2NEicJLaDblQ58g3is0ndQsy8emSxXgP1fqrakOuGzUWoh0/KkFa2eBNt5KewyM0zwsphKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5453.apcprd06.prod.outlook.com (2603:1096:101:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:15:39 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:15:39 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: richard@nod.at
Cc: chengzhihao1@huawei.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ubifs: Simplify the code and remove unnecessary parameters.
Date: Mon, 11 Aug 2025 18:15:29 +0800
Message-Id: <20250811101529.436635-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bab43df-799b-430b-c342-08ddd8c00538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b16WtHmuNKFJ+p+6xmmW+wAP2DCiF65u+hx7lPmYFsM6pOAvSiyPuD5cj9L6?=
 =?us-ascii?Q?SfI1B0RB8jZqcUsPl00bFMwpnSwaduY3U7IeucMSJ0ULEzhGbJvS8ccKHIEe?=
 =?us-ascii?Q?mZF+89zyTJw003saFTlIdsl9XqEf4CJz6/cRkpBGu/d/EZpq088oywZgu4U8?=
 =?us-ascii?Q?jwIUVSfSpnEED9epoCoWhHFIYC15BPZknBQB3SFVHDer7jQKZ03kL8vl/+Cb?=
 =?us-ascii?Q?pdQhGZ6B17sIBQSHxWJi32/Rujv3OptTX0wiYYJ83k+bNmoU15+OegH+MuA5?=
 =?us-ascii?Q?Eqeefb42eroiLiyMF4LMkYwI1udeqcG6YMVQ1JNvWJqRWTG1+vAsQH4TyHVQ?=
 =?us-ascii?Q?IZD5qqg5ylBC7u5ztJ+QwBFSuKt12ntbMj70Prlqn65GKLTTN+NTY7LqwArk?=
 =?us-ascii?Q?drgGOyWPi0VV2a8SfgcCgGvSh1QB6RobJjnM/M3qvdugqZuVfxg9uDijjLEi?=
 =?us-ascii?Q?JkRV45iPfaJYgMpTcpRx6/vvxJWn2p84caddR4kJzNKH6sCn4RxPoFTpvZ42?=
 =?us-ascii?Q?SZXI8NYkaqTgmviE13jPJQ2NfonciaaJTpAwvBKXidv/AXliODWqNtIqmBlt?=
 =?us-ascii?Q?gmHBHW9B2ZrZWTHNm0qoPCRb+xED3vzMuUtP2IMXwnGUc/odd2nqF39b/TEF?=
 =?us-ascii?Q?6EWk9J9QvtWxVkVdHuXtKQ5VGt3PQjESXsaAmnkYKDxpUPexmxRWoq8SITfB?=
 =?us-ascii?Q?IRLSzRt+Dc/FMwxKtiiyrf0H62JgFzi+6k1MB/1qKOmZf35CUzwDwzWd0QKZ?=
 =?us-ascii?Q?tOvdxecEpBJn7kvoC1YyZ7Hyk4InmwC2bnnc3KgXz3aSOvlCMaGkfg3jsxt5?=
 =?us-ascii?Q?DxJmUIOelz9iZIvHU+mntXICymFlj8jEQ+KlpJ+l23F6k3os54ag0BLpk1IK?=
 =?us-ascii?Q?PWqY7Y3Y8dsUd+f/J6kAl9Wgc2qDNQYOGK/Dq17nIoJdWVV0HhS2wPBJtqUU?=
 =?us-ascii?Q?3tG52CBW/5IlONRin6VgjkdehFXSDmU+lqDBmxFAC+ZiExv15wL23aUJqR82?=
 =?us-ascii?Q?PlprWU2TGFeqkWHbG25SQrsuPafBDy2qLfhHTeCHSmEjWJ/FH7TSInMZIIcT?=
 =?us-ascii?Q?E1lDef5LV1fx9ni1/UHTXBXjzRrvgYVORoPzjSllX9N1x7K55KYwW+6M28o6?=
 =?us-ascii?Q?Z9AY8TagCQJWFDXsVavWYxcrzLYXzjySgCYBD3yscp2bcoTPf6lUAGpq2PDU?=
 =?us-ascii?Q?Fi/kaPni0/j2V97ILyKsu2LkRGGs6OPG3Bv0W08FJ+p9Qrzesay8ZYxB5Dci?=
 =?us-ascii?Q?fvAnkXBG4Sb+dyElN3b5t8V+UrFJKUe0p+4Xgt7s3AfzwUK1gJZhsLQS1Qcf?=
 =?us-ascii?Q?UzNAg0/+hntT019SailmMtHn02ioBn3whML6G3w2Gmwef1YHAiw8A28D76HE?=
 =?us-ascii?Q?QtaXOvX3fOinye7t6432zaydEiaPKzjIxkXPZ2eMXmPU1NV7pS6mCTwC5SYV?=
 =?us-ascii?Q?39op7VgukD6vnk4AXClrgmP4JZhxojEfPiLcspnSS9j4+ykrwscybA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L1VVG2HTEKEnElKSTK00EZlsZ+I7ab7gGxmWqyhybqkmQ1fTyJOv9V4nq88N?=
 =?us-ascii?Q?1irciQsZdxXEv5NP5qr4yqfWVDDIeImEjCY1inJPp6jfr5PRVZSyvjNNa2zv?=
 =?us-ascii?Q?Kt7wxAlS3EnluaT6ggi9a3fRIYmnWA2NVD8nsuEzy8uctY+5NbVSYx/Kr3Vq?=
 =?us-ascii?Q?/ZpDDD9NZAS+dKJ9Ky5qnN8EapCZNcMnJBkH/lu+rys786a/AQdwobRUzKsU?=
 =?us-ascii?Q?01He5pdAWer1P1AR8WW/cBaq4x0NNFAFWB+GXOWXO5ZJlEUlmbcNfBU86Ry8?=
 =?us-ascii?Q?FjiWO0UMO4pmVg6BJgiZMWN0k7y09/HHf7g/+t1R7XXMDkDVbgxNfbpgZtzs?=
 =?us-ascii?Q?w3ZRLgjWlIUIG2qbR6NqRO2IQLI9RF0Isy5mlTlKL5n1S1wrzWWt0O4bAljr?=
 =?us-ascii?Q?r08P5VqRkqbD/lW4KhH4h0DEEb+/xifcOTIPjJmoMi/TT2zD0tvpY+7JVXRp?=
 =?us-ascii?Q?1idiz4rUUdP2I5ZnAQnVcCs9fU0tPUsK99xR97z9dpj4vC1h3SZaRokXVzSk?=
 =?us-ascii?Q?9nQTRiK0pB8UTZlRqKijpL2NzRBTxgzROyApPw421x7VT7TnM24E44iiajDw?=
 =?us-ascii?Q?hDnhNB9lhoxy5SszgGQ7ac3ZaZZ6ttaIeJACbxDmqE8DIc7T8yQotc2KRd7Q?=
 =?us-ascii?Q?X6OgSHZMKnnQp/bG84EMcj2UvQ60dabedo/PFczk+iRoJkiwS4o7F8e701zc?=
 =?us-ascii?Q?EpQjiWVtdmuKM1WvDB5bR8bPJEQ5JfPgucxDZxrIXdXecg8XrOGTPJhklNIu?=
 =?us-ascii?Q?HgSt6AdWv9M68NBBP7h6EUax6d2d4N5Iayv3kfcfSSLHfm/NbJ0OppW5bLRU?=
 =?us-ascii?Q?iA7wpe1EI5z9C125nmCsOJR0l6+dUmTcV/lz5V1eneyCVXZWCcQzyHZAKHKY?=
 =?us-ascii?Q?a0nF77bTx/iYZn6NbE+dos1GpViosOPPlqY/YYRecLF/GZgJAhCKfd8z1Rsu?=
 =?us-ascii?Q?bk3GfhhgKM3NO2fzriryWUuADYqgSBjpWLwWWcP+DndpiTyCixg00co5gVYY?=
 =?us-ascii?Q?4xV52yrBMnWl/BWShh6HTJ0q0TwgYCH1oGsZld0rDoh/MDyHZ43Ela4LHw76?=
 =?us-ascii?Q?jKWPmMpl+4FqMztYv/zHHFeYGgUe1nThRdFHPcV4UQnZHKYkhDz9ctX+CSW7?=
 =?us-ascii?Q?aDXtW0P+3QU27zwjKPWPgzB3hjNJeoyYFCyjTMwSvP7jx5MepLN60p+e3vHE?=
 =?us-ascii?Q?/YQr8NYrQqAZmWrWAlNy34Q5ijwv/jcNaY10gVHuQPsF9UaZnsRsRW0+GV4Q?=
 =?us-ascii?Q?a4QWKzjTSgY4h50VDhgToLG1g/BlloXAoqCqxUaXAB442GQeWxlIoFrndqPm?=
 =?us-ascii?Q?vrjnHgQg0ZVXuWxA/N9wxXTsEjLYk13I9TVTnhJ/nuL9/fCMgs2DZQYjH5Ki?=
 =?us-ascii?Q?YvLaYjRlv/uY0ZgNm5jyGASFHj8OJo6AGDURRjIBoLzYUJo+ozZVIrlGGcL7?=
 =?us-ascii?Q?rSDstBLXv0WOP6256icpaQ0BeiU7YV3imvRicVw6uFI3d25/OPs89BzzUl+c?=
 =?us-ascii?Q?In3vV7q6jyUhsWPXvd/mpLzdCAi/o+CrxxkJlrlRrOOn+FJUGKbHbk3G/9ie?=
 =?us-ascii?Q?+iWDiy0xey+lR2GtTHvH7sJLIQ2lK3snp+EMJN+g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bab43df-799b-430b-c342-08ddd8c00538
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:15:39.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbidT0wRmUJz6ttCix9zHFJgNSBDTO5R4dQQRBheswcviMAAqMx8x5Cx6XwoC+kpSxxoKi/XS0qw2QrdHEAfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5453

Remove the parameter '*c' from the ubifs_crc_node function,
and replace part of the code using ubifs_crc_node.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ubifs/io.c    | 13 ++++---------
 fs/ubifs/ubifs.h |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index a79f229df475..6c6d68242779 100644
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
@@ -395,7 +392,7 @@ void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
 	}
 }
 
-void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
+void ubifs_crc_node(void *node, int len)
 {
 	struct ubifs_ch *ch = node;
 	uint32_t crc;
@@ -432,7 +429,7 @@ int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
 			return err;
 	}
 
-	ubifs_crc_node(c, node, len);
+	ubifs_crc_node(node, len);
 
 	return 0;
 }
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
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5db45c9e26ee..5d172509091a 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1743,7 +1743,7 @@ int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
 int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
 		     int lnum, int offs, int quiet, int must_chk_crc);
 void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
-void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
+void ubifs_crc_node(void *buf, int len);
 void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
 int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
 			    int hmac_offs, int pad);
-- 
2.34.1



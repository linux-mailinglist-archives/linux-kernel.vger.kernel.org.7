Return-Path: <linux-kernel+bounces-762583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D258B208AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C579B3A4582
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12B268688;
	Mon, 11 Aug 2025 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dvynH+88"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013012.outbound.protection.outlook.com [40.107.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345D3C17
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915054; cv=fail; b=TuQDqCXfoUIHn8dJE5L6/vsXi+mdr0YTKPH7kIXOA3N20cUZMOGtXtJ0wFI7JrjTbfLgm3OB3QAoN3jXBORQRr0FE657u/KzlVGOvzom/N6WWcC/m6xhDC79RYLuZXI1t14LvbmptNbJnlvtIWy0VHCIyESFfndEc1ylYr260cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915054; c=relaxed/simple;
	bh=hbzmPOl3ZRftdrPLKxCvCg3+CrwjJw5h3MYQ7X3HGFc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jCe15PilaB1OPqarUXrcGDnk9xBun/F9m2NQ4XTURXRMSWtzOG2kgMB2OIaN6c+NI9AyGNtQxC/2omCWAcsKj3ghB8MVHx3ef31Lp9YHERRogioqUpjgb9LfF29D4NxUTdOcPZmCxRghM+BDcMMMd/Z+Mb1eUBMocsVA6v/3twU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dvynH+88; arc=fail smtp.client-ip=40.107.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRIEYeLRd/jbQt1OcN3bUV+plc0zA1hX3/xsW0Fbca+7Rzxxz0gfrJMGNNUeHtxyIeLvRHnfdr7/P7jIaDlrpyGWlVl3wtIhC19XaymTquTI+KCwerIMIakwHOh6WyKDj7sBtpv2LShKP4T0/j0mJbrWg2S5spOuy8skR5z4DCSC51BVg8bnSz//xtwR6qe93Xti5d2juSkGgDnVGaZN1zrfzHLkHIobvk+mvYaYQBsi80rAQk5Db9EZJLz/uCppeu0CBCLRy/4dKJxxQTDVECt+qraBAjTiS7J6zje7TOW+HC9tAnV0f0t6bi0IADbtUAjWbclGTWVbsUlw8ORDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pQ9qNmVkjIMLuLIAgz3doSw0oUbDZuZjaNeWwVDXbg=;
 b=KXk7dzK13xpdZkMrFn8BIDYkbeIYRtI5hZvBcksCd141Ae8+eCjHI3rCmvwmCnYjrj8Xk6cuQ1fEmybIIi/sYfJfKD6BLdJz3me1QjNNY7u4Vk1hFxXgdzAyDNyEZvvtSeYKVmSuamLtKHEub9rFOpt77nOSrE9tFS3nsV3dnlX+aJIcRVTct+I3+Eqs3e23KJHzVqTUKWoFumDLTzsnryJZeWPeNWWzBFSjREAUnkiyIT45pDU8vIxAEsbkv1kj4aikfvuNfUkT2x53WjwBSPauf7J5hBMM7Mxm6w54Njwv3mQohCp2NmeC+o65GgJxNL0YvkoQ0RxHqfRyzvz4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pQ9qNmVkjIMLuLIAgz3doSw0oUbDZuZjaNeWwVDXbg=;
 b=dvynH+884V6cXqe1BGAAEPT48r+kcZC9eurnLXQQUnq4hnQGksOhghOCC3U55Uhk6jH/CiPPSwP8uezY+6eicNz8SMW4TtGsUcilnowzN715B0VmX7uegWRNnkGyPNFMF0MyOrFg1S7uNv1JW0U/zux+Ovj5qu9J34Dv/3Nq2Q86BWgRxaQlziQtrb0GWqC6MYvMb8Ue4EFcXxPhf8wkkPWXeZ9NeuycPTtomwJeYlzUrgvgnTln4y5Q7ogn9LgFxeg9/lxFsBFFdt2FxHB6CQgJP6kAgWYKdmB9PONZ1rJdH/jXfexTNUK5ZzPgQA3ufYj2XTn4Atu3Gsek4JA1TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB7172.apcprd06.prod.outlook.com (2603:1096:405:b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 12:24:08 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:24:08 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: clemens@ladisch.de,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] hpet: Use str_plural() to simplify the code
Date: Mon, 11 Aug 2025 20:23:58 +0800
Message-Id: <20250811122358.542190-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:404:e2::14) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 80033986-6261-4dfb-1ada-08ddd8d1f870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HrcSylLpW81JCuWESTzWxkBizCy3g2q+8sH27U8yTp98yBPPvPZNjNWBPls2?=
 =?us-ascii?Q?24LEM26VqrQZ0aA6OMz9CFXYQXTB1fpNt9Mc2gNoA6+uZu0+QXu5IQzcAwt5?=
 =?us-ascii?Q?uCswOuI/uQF4VER07+2W9aWWtMliNJ62Ui9YYEr3ns/5Jq0TVPN1VQcgj6Go?=
 =?us-ascii?Q?nmAQW4s7VliAEAr51alAUSvi19Jolw5TOMAAlYqnlFfpYeAMreLgNADH8ZGa?=
 =?us-ascii?Q?Ca29NqChjuRKPvL/Uv25xvqdcG831ikZsrFQpeDzcgEHWqL1BPo1xNWRCct7?=
 =?us-ascii?Q?Sd5UvBaHvwmL8XJ9yNfqzd82Gphj2q9N+1/0pHwpmuEUPmIGg1eecfdCIoBe?=
 =?us-ascii?Q?1bhZ9Bo+ymCqfI+nvG0Z42ZQ3AI97GPiGe/URu4AVYx77oUZMnj3y4QVHyjG?=
 =?us-ascii?Q?vgOSUNo5mSP0CP50Mn1MzPw6QnGWiLX9gdRPTppoaVBXIYkJp39uyb5NCyz/?=
 =?us-ascii?Q?1+Vk3MMnBo0/1UXfyeNcoiXP6Lg6s/OdlJ/NRaJ675TaAVcBatlgIhbETqES?=
 =?us-ascii?Q?GynN0WegTexATV5d7AaK+9n3/G2fR0Kf4h/hn77O12/cqTKVscVBShnsPKoG?=
 =?us-ascii?Q?h2k4d1WabYWHckgxz262DTcicQin9Z5hnWk0I5mWV8pK0lT4y/0/BaKCOnAz?=
 =?us-ascii?Q?Tw2bfAvusA68H2Ghqeqlf7uwiybmrz8iilnDosWyzqlNd0Oy81xAxFm6TWYA?=
 =?us-ascii?Q?ngab0BNGgIpWW8MhrUpqTKJK/c5052RdH4ZQoGG4Z9PVIwePvob9G70VPNUm?=
 =?us-ascii?Q?o7gAwseqybxaEbKyNl5+qXQnp2Li/XPQZgHvZj47i6+jBaza/HrocrWBNEPw?=
 =?us-ascii?Q?Sbs6gH0JC5FX0CtvwcGlcIDk10g3ilN56T+p7uD98W1WVUQm0ksQQKTXFwWB?=
 =?us-ascii?Q?piBLzrT0fILV9JFxfPPeTEWFBHilh5gZyfFD5RFqzVVKcj9L0dEAgnKjVv2u?=
 =?us-ascii?Q?tBU094PuzS+qWHDY3YYKMG9DFBrvXVydnDjSL40Y/tjDE5biqnSV40WXvpw6?=
 =?us-ascii?Q?K7J42+Hzge/u/OKXHS5dcG4rcwI4rU0nd5rKqmrvujsHt2ilQ8iqT2vpF76+?=
 =?us-ascii?Q?hN1RT+UdVlixO2b5Hm6PnrByPsL+WQwRFIscH2MugnYse9wD5XHjkjIZCX/t?=
 =?us-ascii?Q?yCEFToSE0yYtKAIuPezYQFrARJ4uIDcMDRS8HQZXZbr4MIP5K4G12356l+iX?=
 =?us-ascii?Q?b2XQp6p9pOz8IoDWelicsyDn47cvqIo7NbvM61uBvjb/MBF+HYfhHsTW9VNT?=
 =?us-ascii?Q?w8gYOTl7VCT8+AEtZAH4p4g5iGMK1zJOpGl+K6JoZq2WFAif+dyAhEYlVnaD?=
 =?us-ascii?Q?CCX0foMWG+UZuJD9En3fyDgFJUoA3etM95Xc5BIdjhLPEV6H0n4rXIC/irxo?=
 =?us-ascii?Q?68PjbRnZ6ZqxJHx6HIPL28bZE2rJtmq5ZztREyW4WwyF2M2X/7XRwRrnrYzW?=
 =?us-ascii?Q?/4azHd7WlKsPrm2NfXic3XijUnKKVUEtGSbYudsvGkKsHD60oyiVSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nn1JaG0sXPFJWqyBge4DGWm6MmA27PqlKyOmpBDvEsU666Kt1j/1oXIJ8CJh?=
 =?us-ascii?Q?hylKnwgnFXvgkhmcRKLAuC2DM6nHdqpoFQime6/ghvVYKA0eWTurABv+Tl+h?=
 =?us-ascii?Q?JPKHpG5r8T9c22W3I4yOcHTEzz3kpwKZpeaWBsZA1NPQfqw1E3/O8fgU4I7/?=
 =?us-ascii?Q?tiKYdG9UbAQLx1pYHUdVjI+J4Lp7j0wHMCBeI2Vex51JitEmUDErnyS4xfaq?=
 =?us-ascii?Q?n9JUkbgspmP/lsrWPJvggT2lhZkaVtVlb93XKap8y0nhbFO7UvQjLhFCH+0k?=
 =?us-ascii?Q?Vpm+LCS5mU2ACKcyodN468Bs9nREM2/cAN+ttyWecTvExwOzv6bHgp2J3/SI?=
 =?us-ascii?Q?l2y0eHo4n1Eg0si4t+1SlMYNQVUHAJr6TZwG462niaSmiiLeEwzyD/2/lRzm?=
 =?us-ascii?Q?vg2DHvNY3ItXhnC2+q4MkmdWaEYZNKLovc0lhWupDMe3VRnBQR62Vn0M86QM?=
 =?us-ascii?Q?clVvolQlW3WHAVjX4JgdejoCFVSo8gLSqAqO0iCNFnZJHcBlk3UlJoG+iAXy?=
 =?us-ascii?Q?sO5BRIil6A3uhU1APwzc4prQbh2PC8/Sj5MAPJBVzybrGpSSINQ/20gv/tuU?=
 =?us-ascii?Q?7NONZHHIC1F6ZsVHa9ltI8Y2jFYpcDPkiVofSZzSHfawqrOlXqCRbYpWBruc?=
 =?us-ascii?Q?S/bQirfMeKUf9YVCZxEmOMzBUVnpQNEbQ4PMGFrNmnySqfQREqm0CepJ9gwh?=
 =?us-ascii?Q?R6srP/6bKVbvor66ykdoIjp+rleCwn57azjQbm67qgn142ncNVM0y+mapJ6L?=
 =?us-ascii?Q?y/F3Q3giJ72hISOUW4TdKuziWlD9oJ0mlOM9BtcL7p7Z/HTtqpAuPT1FvLVI?=
 =?us-ascii?Q?8LLRX31qI+QRs0SgNCRvynrFRE2FCwPTCgiO/nkOxHR2T22eYqRmDBeaOoN8?=
 =?us-ascii?Q?UuY1zlY0txylRx/EPBE/Ftc+xjs5gDQjurG53Rcg8tND+CYdZ4un+my6ZYEr?=
 =?us-ascii?Q?PFgRCeD97bvVUjCk9Xh6n7Ct430vRcHtenvzzlE2rb0D/30Mh91dW+BxHYQx?=
 =?us-ascii?Q?6rMBZKxkWA5lT9ikH6DbVfe1EA5FTLuGpJRkA9YumXjz3y7lQ99YNS8ExM8+?=
 =?us-ascii?Q?vzbAMueICOkbptUKTs70flNK1/3xUTf/IqcGXeRxMnuPviluf3yMEydCHN9R?=
 =?us-ascii?Q?6qBHav9+q4ran+eUEM2KMpXdVIoayJmeCN5+fjYmtZnnMNm6O+A4g38VLZam?=
 =?us-ascii?Q?aYgyUl11OfXQQCN8UPvjAosihR6o4GloXSQbF354OiUzJDo5enSYdsocIsHn?=
 =?us-ascii?Q?2H5tBt1Vz8vI3ckYG/tgYDcK8aZFzIz3pmuKUuh6PUrz2RiDB5zOpxAbgglU?=
 =?us-ascii?Q?oWB3eamy4Kh3SQffOImOixAlFrlZuL9/U4rhtmpFpmiwoENISIyniGdBKhTr?=
 =?us-ascii?Q?4ts5+2Jo24UwMdLfbs8SajsUlHA6+RldCNSxhEIv4Q6motm53ltPKijMuk9T?=
 =?us-ascii?Q?Z9z1PYlp7HoseYmhzcUJ6w9T5QtolGvoP/2JqoOD3DwHb7WFB5BVQcRYRDQq?=
 =?us-ascii?Q?6nx6Lim9yGiOrMbaj1yDYlUe89Je+1GintHlyTleDGi7AF+7qR+mXx/LEJdG?=
 =?us-ascii?Q?TciwsDlQxcik3si9EzjQZSQr8vLkPS/aBR/ku+sR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80033986-6261-4dfb-1ada-08ddd8d1f870
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:24:08.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inqPIRKFB8+RVvEEUBrjG8VMlQhuGt0Q8ghIQ/XLWtXRrUYQ5jzfz0XHopT/m4e3yEq8/J9G0plPF7PzlDG7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7172

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 0713ea2b2a51..4f5ccd3a1f56 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -867,7 +867,7 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	printk(KERN_INFO "hpet%u: at MMIO 0x%lx, IRQ%s",
 		hpetp->hp_which, hdp->hd_phys_address,
-		hpetp->hp_ntimer > 1 ? "s" : "");
+		str_plural(hpetp->hp_ntimer));
 	for (i = 0; i < hpetp->hp_ntimer; i++)
 		printk(KERN_CONT "%s %u", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk(KERN_CONT "\n");
-- 
2.34.1



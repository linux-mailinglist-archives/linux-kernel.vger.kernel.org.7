Return-Path: <linux-kernel+bounces-761768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFEB1FE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD957A50ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679191F4CAA;
	Mon, 11 Aug 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QeK1Fr1n"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012019.outbound.protection.outlook.com [40.107.75.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9E2C9A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883955; cv=fail; b=JBOgCBzjajrTtk56HoXErALismt7YlEiYc4LiZdAG0coAOjs40K2LZuuEzRT7xohfJP+E+h+thJNxwXsukzvm6R5bbZU4vhE5noDiJjKMM3a42UZ4lL6lhu5/1+keOQTEDsB2tB5YXb+LZO6Mrtrye1o3c5C3LlspWPyy+HSWT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883955; c=relaxed/simple;
	bh=+UYt7i+l5/nhsA0GTnLNFlSOj1DgvLOBz/HAI8enen0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dqSr2WvJb3ScGvDLDtKBRuEYHmqqCAQAjfjHe8kfXHPwiSlHl96M6gcFopPPc8wD2uWPBFAAvvqoNUjYrtw5/MMdPBV5ckIytLPjizlz54ElFCcmyZKPZhKXyqXt5xqLYg0miUPy5/Rh40lPjaFGBcRM3Lj5sJg2LBHYhjuGvJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QeK1Fr1n; arc=fail smtp.client-ip=40.107.75.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWflXp2TKEjTYbDGtEaOgX4GcOj+WqhVPG9QJew0cSYQHbCpnSAiRoDjaU+Mz3EHT1HhM4FF3PvHoK3c31jXygFXrOWmiRvDbUKjgCd7Pmf/BXCY6bopaZKk9wzj317ZCzUHdmkgfOowv35/O7i00r15sqG3ECf/XnAHFQET43/T3iEZWNFDwoI9BdO2nSNeDh+0PHv/pGwZJq8zTOKNbnlrfaNJl8zOFkjGvLKHJiobWfnL8kb7SG8QGxqXqicaO/UkHhsesVHDSa0aHMMQCEa/N36aog51EXVPBaXWEEipUZzZCB6vyRqm9UWd50C+xmEWljYwynFihBfAUmWjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd2g7NdD2ly/+nkDZ1IJ3aju8hiSBlKW4IQD/+eWYlI=;
 b=b1FN0t8X4OIYKfIO5BctTeSGFjDsuqNKl7TPDjST6lLfmhpszWtqnx0ru2PI3b8A++CNAYmhTLVCGdeIEyqLwtWO76Rd3+Fq1pK9A3QXiFUKIHq6+8lXs63enaW4xNQP2AIA9uQhOrdfBcbnVZjWWk8nqcPjmpXu2D2Ww+t5BjvafPr7TZ7FxYfd3FFZveFSyMce2RW2hp6fHUYkihB6h7GHIFGHa0vPNXYdKLoLUDRI0Ypo9mbiq9Z7BAPewsdNNpMIXVVf59/Xoy3vu2X7JXFD0zCfQN8Fljtrk+IF/stnlNkFKTSC+VNgdrs1mrqW1SS4+385F+zE5ZJ5QOdxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd2g7NdD2ly/+nkDZ1IJ3aju8hiSBlKW4IQD/+eWYlI=;
 b=QeK1Fr1nYjpqrHXkuNAGiSBn5yPnP56juiKZRAjfIc5nt3L5ErtF8amr9c8WTwAQZ71NCgs7iymoxcX22mnR4OLcO9GgYB+iiyJYjkz8RTivitbYqxhCcf3DyNGoTi7uEQnCok+Rxc44oAWMQu+WZ0fgcQHDLzG9PIlW748Yx+6cBHtfy8rWnDVBRGwTToPmM2Y6FoOk2aZ+B2WnG2qZvK+KjNCQmpdh0IAPz3RIokRfBQeqkmIZIZ77ynl1b4uban209w1CdN7/FQGVuXHUYdzq/SWy5eZPc4ObLU9g/t8/QtAcYiaQpQ2bjr1rNn2Ext3Kgbb9RnbjhniKng/cHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6017.apcprd06.prod.outlook.com (2603:1096:820:d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 03:45:49 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 03:45:49 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] soc: mediatek: use bool as the function return type
Date: Mon, 11 Aug 2025 11:45:39 +0800
Message-Id: <20250811034539.175237-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 4533af37-8bdf-428e-c4db-08ddd8898ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GM1n1tXNueuYiN3SU55MdAAM9q1trmNsOvme1Wf1eH1oXL0WYZZ8RC41I+aN?=
 =?us-ascii?Q?qN9iKIQgJGjsqKgTOYk/EgYx7yx/HCV2mR95gi3VCWHdAMw0ZK1lWyflTwAD?=
 =?us-ascii?Q?tyfJZYer+f2cppQV6u/dNsXXIlbzXykv93W4mW+yIa3dwQf53bqFat9wvEu+?=
 =?us-ascii?Q?umqcyGhdq6hGbLYLonoCLJRhVoh1vVEUgkxOm6yCuR5BNE4VFpCjxgfv4fY2?=
 =?us-ascii?Q?ZK9S28cysevN2u1iK/SjoFUezlQLz+Ruabim+AfisfUgjO3GfXK1dMXSBZjx?=
 =?us-ascii?Q?ZadlSjZwg3OSAXZgRvNm+x3lok5VPDxM1bSwJgg/Fpj2z5oAifkW4SQkXOpr?=
 =?us-ascii?Q?J2BsAlM6x96QbI1TSIIboIeCzWd/V8wHl/W9SdH0ugDzor8IM44EdZYLf9U2?=
 =?us-ascii?Q?rXXyn8IGTqoORgkmptM3roOfsdWNKcFdaEnk+HKVoutQHD9PDC7QmV66rDv8?=
 =?us-ascii?Q?O1Dy/ezGPzLL4pglGCkbFFqu+n8HouOS21JiQem/7gUpHVb41PV/Sh3Qizue?=
 =?us-ascii?Q?OzCxIjTfv+OIQVCJLqwW7okX11JjcSXxSqTdF0nhbD/waXWNZD4nXZ3axukO?=
 =?us-ascii?Q?YDEeYsOGV5ZYK64vgglOMyAhOSCue3caX6BPH7ug4Ys+HzSToF3K+ytwVcDp?=
 =?us-ascii?Q?P2nKjxAaK54yE3TNFiW5zEdMYG7sUyVrpSTWUK2lJEuQ7/FN28cF/p6u/xx6?=
 =?us-ascii?Q?FbQsRQ8rzOWIfT8w2NeT9jcLYCT8XjXk9qk3nIMTJvZAX5mN4dUWhfDQNEmh?=
 =?us-ascii?Q?bvmNhgKOE3nZ/Nbpp5d/+giKgF0iegkmgfVxcBLK8A+ds7F35rriO9xdLxlv?=
 =?us-ascii?Q?FnKHz+ekOYFH0bHUr3xGgrY05tHrhKvo5VChR4F6PXLnPbEqetvTsGnmIWQi?=
 =?us-ascii?Q?X6t9Aj5LC62BIEhQkI02rRMWR8QdNo8bLgrJmTFsqeAdX7o3UGK7jsMZ1YrO?=
 =?us-ascii?Q?dXhEvY3ARBy1gs+sJ/qYsnB79q5fSO95WOy9BDDzV1fsN0MtKAtwON3tbGrc?=
 =?us-ascii?Q?vUVaMpLSYE7TAozmtre7eei7NMhua88tfuVMGGjeHEr2sVlLwmC5/nQjKvoT?=
 =?us-ascii?Q?tXeoODXuwtIopvhjwnAzkpQQZFKhwShY268154thrZBh8TP7BMjwTQK/a2B0?=
 =?us-ascii?Q?I/5QV86T67DAPaaCdXl72Cgo76aocEPTmVqgNQUucBz8I+pS+a2l8lbTMGsx?=
 =?us-ascii?Q?r7tHqGmhj9j0yHIIy67Opke14vbOpxpIhjN6OirSCwZhpK1gPnREobohbReE?=
 =?us-ascii?Q?VSOLaQ7Vwm511AF+suiLDLJWP6fR5NWh2P+P+J02EGWp9tTHZNeyFdJFdI7X?=
 =?us-ascii?Q?T6kiFtyhoKIUnVuZa2nRb8ZNeF6MikR2UYVJssSG27HVL3Ql7DuiXU3mnfpI?=
 =?us-ascii?Q?Wti6phmM2ykOpuOy5PkIVTcQ1QVigrzsVCzeVFYfobhNcvVBe5EJhwiG5d5I?=
 =?us-ascii?Q?XrRBcZHB0xRsf2vvvHN+Il38ZDG4VCsjvbpjLA3k9GO/GUim0DUdMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iIms6YEESILCy0aPTXi+W7veSVmudphv3Yt8MBSxaobWQq548bbgaYbALwp?=
 =?us-ascii?Q?faI1krXdYPVKMUpmMBiybG55D3GYPfu/vxscMv1IMjQiE92df9PUVzYU7x3E?=
 =?us-ascii?Q?6xKlkAQ11IWPS/FmXqP4lOLLeEMa3IQfaGI/f+wDYpi8/C3NjJT3niCARm8k?=
 =?us-ascii?Q?+xhJiB84IChaCKJAVKNedN4ad1uYgzaboleqxuOZntSZomwIi1hDdV79qbAH?=
 =?us-ascii?Q?7IHPCSvD1qbYk9pbuUsiw1SMUepovcBuXz9J3Cr8F3jum2dDyASmnD5Gw7Ka?=
 =?us-ascii?Q?wiODgROxCYAqOAvtCOdDr9+skwN1q9hypZv4hGdDs5TYXQeL2xnjg+DpAkEm?=
 =?us-ascii?Q?yTG4O1DHJQ2PGxEPoQe1pExRvr/+sN3fBTYNNbuC9mJIQoiZG3UF7YvMZkdt?=
 =?us-ascii?Q?ZgacvEVJDYUb1seGEYi80KSkN8Y0BZv9xtYJ6MfPQVovpgajScXRfXUqZZPS?=
 =?us-ascii?Q?vzoTEx3TnuCC3SCqL77ZuoFaLvO8YdiERqjgjN698a68vlB2pgEVqH269RB6?=
 =?us-ascii?Q?+mT7w7DzYokGks9x+skBEj5tnsY7Dv97SQOB6JMzCjUNS5P7xIx/bMzaN+r/?=
 =?us-ascii?Q?40Dr116pZfeG0GlEQLinu9WCBmv9InWsuiRb0ln3+8UpKssH8/rxmMD+19J7?=
 =?us-ascii?Q?fZVbIE9vQmgGfOyV52lVr1zfTqpOaLj+hDfgG/GxzsAO15nV2KyBZ5bQzCy4?=
 =?us-ascii?Q?9Mxjz3mDItXm9FNNzDi50QdP32cnqfCc9KFtWsOmA30pURacUPP+sZWe9fUA?=
 =?us-ascii?Q?LCN3nSi6yRBU4Y/jScBZEHGbzHjXXW4RvDKsgyA7+A886SwYlWXWRjLaWSBR?=
 =?us-ascii?Q?eoUOUKr6kZDC8lgYg058vodAcH+cbBjMLULwFALAj0wEJE8TC/w9yc+PYCfX?=
 =?us-ascii?Q?z3NJ7+6gCSBK2xy+c7Ob2bjZHVpTmL8l4j8niKJvK3rsNL/iymzWgbtaMXcP?=
 =?us-ascii?Q?Rf3n9P9Z2BZKL4CYtJO7nW/HsL3fxYSKCsse5zj3zemPbS8HALBQ6kiFg0ZI?=
 =?us-ascii?Q?6iHSpQGCpTuZ7Tg0ZW0UyQV8TVIcoVlJaYuVu0eW+IGtWR7L2yVX38MM+Q8u?=
 =?us-ascii?Q?z9cgPRCYwd+8XE99/DQdNHj8EYWiDqguJZx8Td2yuAb+LiK345jDz4JPIH4m?=
 =?us-ascii?Q?QaEnneuJl+Tz7ZPBUcVGX+dSWJg5xk9t/mI2Nxwl2W6nQ9YcwovFOM8gwwWf?=
 =?us-ascii?Q?34lZoyVYKlOTDbPVosn2M9cyfLg7DHZITAqssry3Nwz0jX7rJ0KQR9/kAsZo?=
 =?us-ascii?Q?ljrC0XaR6JXRBiAJ065oCfTG1ueDGtWwfO6Mtp+nICS5HAgMHAalErY9v6oi?=
 =?us-ascii?Q?saEtCLaXgwTxd65zamFuEDge+6C5UEc87AzKpk+fCYes1tVOt6Ovkhv8s9OP?=
 =?us-ascii?Q?Am1zAzMyWnbVXq31I7wr7BDAKFTwButcX0IDGutdYbhzYnNoTKkUHyI6j9eW?=
 =?us-ascii?Q?uEnv5u7+R/x4SmuLwJQ7mjkjG6y4HVGjXw9/2wb72nwEwgjOIY/zQbpcNfKP?=
 =?us-ascii?Q?/EIw47pdKjXH1nRhacWnOFwaS6d/sQVasEutwYZSgUn6crwiQK4saZdWreqb?=
 =?us-ascii?Q?DXd+e5elI4PUJJUg3z0RBL0mS0UEWTAa1XIhUhEw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4533af37-8bdf-428e-c4db-08ddd8898ff1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 03:45:49.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zO4mNsFJ89nUrWNxtdNNb6S2+EiwPWVi5AP+vu6/hl9hmr3l6XMs+MOxt6GlWrN/NyuQ9IiNEugPqoGn+Braw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6017

The function only returns true and false, and the places using the
function also expect a bool return type. Therefore, the function's
return type is changed from int to bool.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f54c966138b5..33254a979156 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -109,7 +109,7 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
  *                       info to VIO_DBGs registers.
  *
  */
-static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
+static bool devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
 {
 	void __iomem *pd_vio_shift_sta_reg;
 	void __iomem *pd_vio_shift_sel_reg;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-779449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE85B2F43C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F75E5142
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BA2EF657;
	Thu, 21 Aug 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ElF3/JDf"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013012.outbound.protection.outlook.com [40.107.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9C2DEA75
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769144; cv=fail; b=GNOP8nuFDl5dohJ298iLpK6taz1ipuF/G6lasj/D6WhiWXgKA78DRm+DVIhirkt14uSAwOR/UQwyvTkwJzZyZofwclLsCnq/HaSVTx84Gtjx/Phv3bHtOzrztLUIUylQBly/k6Gvc4Xodl6wuV7JDQFsD+hurLGvG0Z3tG8B2Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769144; c=relaxed/simple;
	bh=XZEqYdxnu3B6tfObj7b49h2u+QYFPJGTL9EWZ/U1pUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rL1iSLc+0tIncDvirBCT6DcqxIIgCC6S5/+TzUiKKfWBXdrF5K4HNWrSSnkENjoCdCYaeDctW9Rsfh1BON3HYEdSVAhPo0kzZelZGrz8I3Gy+n0f72iEn3d+FqBTUu2sFlS/N+wAtNiuj73K2WmtHYWP4pjlQjpcLNZrQgcFK0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ElF3/JDf; arc=fail smtp.client-ip=40.107.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhhMi5RO9gkrkUqtJTBGHdd1NRrCDEdaYakNE05WKMYWE5NamHxoxGwBar6By7y2zf7FI/CrGNfNrr+fu2uK4vILfcHHjoTPogN7vtw9/+n7NV9IFFrl1evfFP1/6GzSHYrVLdR5UPbOCrl9lZJphXKWrF+hSkQr3gQZTW1S/KiX3eVyHdWvtWJZdLv/m3jr40+/6n3kG0gjDi1YlnAvb9SmXkyqokrFDB3TP/WTDAFtfiTg+UMO0R4MD98toa4cjtuhFUyqMMfKnCv8YWTU2VJmxDzH6mCHgPj8Sk79imCq7bM99t0mX2LqGdDD94Qd/mMxx3IhMGg6+L6xX3QyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iGahPqYxbW/zJM8DzLMLUn0YbpA9j2mv7/AVHnsq08=;
 b=NGZRpfn6To4ZRwyDejyrvci/bu2uQLD1EhSSW9glwBxJIy5SmPySOaWhVJbSAvtctKdRiREdcgXclCVrL+Vg2InR2A59UKHHEo7ZnfpxxqUTiYxIWEVQyiE+fFDb318xq/HZotQBqOdkEtbQRbrkMsz4tYahCxrEtFOlQzVbBRBkwwxdUsgl3F9vePZyK/RqzYH8XWc6tqAbuLrQEVcHd92CaMPVSM4f0tCo2bLO7Wpa/ozQ9/Xb6W14BHUqN59UTL07VfNLHf9F8fWB/nSAB6bv+2GV1KvYownPRQbvzoCPgF8naOGsdj5GLMP9ldsQPJF40mwS1kxv67rGsW7dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iGahPqYxbW/zJM8DzLMLUn0YbpA9j2mv7/AVHnsq08=;
 b=ElF3/JDfR4Bb//5tLc8mWRATZolnCNWScKR+enF7CsfE//JbYuRlUzuSqJ610+MTME0nN+l8Np9gioK7YUO3zd84L8i6bH4CcSD2xSXzFF2SAiAlrxH1udlwtgjNOxfD1k/3vVwBrdLiNr5MHdYMZgGFm84cWmb+wa6OJ22FsG8MXOLaReQgM9h8ktqBKaam+etB9bZ7lZVdmdY23UexgZhTpCsdmfU5G4pd+jipqDW/WuAUvorZCH07le87CX2OUM2GpvtueVMCh/jwGOxENkxkj0JfoKxzdgc/j/3XzE9nIdO9tFYXEVh4vkImNhEySzgQbf5GEvD+Rw0D7vRAWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR0601MB5448.apcprd06.prod.outlook.com (2603:1096:820:c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 09:38:59 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 09:38:59 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 17:38:45 +0800
Message-Id: <20250821093845.564496-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR0601MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 46149e95-d572-4b2c-83f3-08dde0968e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/u/UzYs5SPnDB1lBAg1AlnDbXNTx0XAWH5vbYkJMBcCnWaSx0S/T8/e7l6Gm?=
 =?us-ascii?Q?84Q4mv+ybClqKjh4u85UMVzl/87EcCA2CNa8Ge2/OwDh635FL+t56VuUUH1k?=
 =?us-ascii?Q?BxtKwvy2MPRZTk2NyZ36UNKFytCwjRoT+6Y8I55/3RUZ13l5hwiUIoA2vJTp?=
 =?us-ascii?Q?VtUkJoOzbQ/FeYGuThJdlIvMFROHqOpM4MF1yMIz75oj/36PzDMh1hi/5Qko?=
 =?us-ascii?Q?P5QLz7tgs1V4umfEUfNgFY3GguOkFv2QDRtB4gkP/rB60C5hj3fKZ0OBq8UE?=
 =?us-ascii?Q?AO/QJ5EncnIRQxJFwiTGsRgXABkN0eNNR7iMkNDsxZpOH2d86Tj5umrhc44m?=
 =?us-ascii?Q?lw7+evHd/GMj6gUMFoXaaV/NaB9P3va/fUAqbYBEBwDwV2SFo+cwFLkozu6V?=
 =?us-ascii?Q?OdnARPZdHnVOe6MxpSlvM3JsAYzxjNJAh+sNFqyHHYfPaXh2HyGrr23OP00c?=
 =?us-ascii?Q?TU+NtJFLFNNKvz7FnsHOM1JvVLJxpsbqhfeBZUY7WSk41nFUu3ba062taED+?=
 =?us-ascii?Q?o8xu2kt/kjYVTpWZPojaND0XjvzEss2A1t1WBonByLtiAzJX3SY1J8NFxInx?=
 =?us-ascii?Q?5GinCH0PORF42/SonB1gih000+US8EGfZ11IeC89g1EFCqDJyJeTA4W+2wZU?=
 =?us-ascii?Q?ern96k2stF03dud8o85UdPtQiPPPL7tKnjtl1OeI9IaKMjIcilCKEKlqJfGI?=
 =?us-ascii?Q?tG8OH5prRIsyyKMPOZQifoH1A/LLCTw5usEIhNEpl3f8imIqZHl3+6zTmxmL?=
 =?us-ascii?Q?p7XneW6yDJ54/qHeb6EBKTU20imHpLX9Zy7R7ACNNDn8aFseuEBxGPxDGsNY?=
 =?us-ascii?Q?hI7NHx5viWzbcM4BB6gs55FMTt74xPLDqQAJbbuy9O1D9OBCobznURZg75lH?=
 =?us-ascii?Q?LSPclfq8k9XxdLfErb0VQUAPYLe9jbt2UP77uhoysX8m0QvcqPtFp7lFHV7Q?=
 =?us-ascii?Q?Pt+B7/u8u3LGS9tjkXpqXbeUXo+nSQMO1h9oMJlYVZPrHnFmN85TL+ntSuI/?=
 =?us-ascii?Q?uHf9xnf7iHPS6PGrXR+r9evaGEGzO1l9GRJSxwbnFEEDcOwSgwqRHP4BZT1R?=
 =?us-ascii?Q?PieskHHp1/IteyKzEd/eWy0HPgh9wlE47A6i1BgmC4HntHH0lmM3HSA/DsH3?=
 =?us-ascii?Q?YAQAw1ag01cat/EQoQrkEW5yDMQmZCCD6CKa3ex27LdwCbbJGyRx2nEFb5xl?=
 =?us-ascii?Q?nFCTmoZcVpo75fFJZaMJwlBvptAji0Dk2w+YAljTm9n2mTMAU9YsY3G5sJFs?=
 =?us-ascii?Q?qkpBpE4zwb0erXq7EKAs/SMraZ2DxsyzEAXzHAzbn2TvKckmPmFjee80NRlB?=
 =?us-ascii?Q?0mM71AR9VlcvOGQPmvrEc8XzaKUctSGMjI6O9pzjPCOCRdZPE+Gd8zs/5URH?=
 =?us-ascii?Q?q7iU1FrB2CdYdH2KWzYRmWiVMSHk8ikEbh5vobeOfl9/B0mJJL+afwLKowF+?=
 =?us-ascii?Q?P1zhPtR4voxE7aNguKetOIpbpEVQ8cbqzBEwT2jb5bfFkxDqtDm9rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzsshRNr2oWHbrhn6jS3N1HzA2fL3Iznaa4d/qWSLVO2dKFMaK9LEQxOU6wc?=
 =?us-ascii?Q?B8yy8qMnJ84F2SrWCC6jtL5RcyD4lCLJbq6Nf4+e9X+X49omgPYlT2R4JCDn?=
 =?us-ascii?Q?8N14Ard6X68C2cyqbL3ByUsg5XfxLUf8PChX86uiAPKSdv4/dw8Y4OJ+6Xw+?=
 =?us-ascii?Q?0dBX5mNE60rzjbO0+JAfXnUzhmDcUcE4EPQjCqivKYCJeM5exEb6vx99qtis?=
 =?us-ascii?Q?HRm5Z6QFyhQTUFjyYxUdCOgZtI3wqgeBCFm9v7GUb20Hne7D8oQUb5wqBuom?=
 =?us-ascii?Q?jwvjx7aKiwjAYtl1FBzSegDUQtkF7F1CbPFZ9aUj57ZBOStfmx0T6mOejO3A?=
 =?us-ascii?Q?v2iXUfG8Db+zfoNuctuEZb+DXbvSQCNC19HZ6Z01aIdcmPp7rhPJ2LqMwCWq?=
 =?us-ascii?Q?rK4kACpItp5lLDZZ6HIfZMQxOmwos6hYD1yyM82Gio+9wqEydnH4is+3BXsn?=
 =?us-ascii?Q?mg12C0lDdWsYexY2eI6ThZApe0XyOwzvL3w7vCP7O5a4GbH1C18Fd1gm2nvP?=
 =?us-ascii?Q?SLdimO/mN7NVVgvbSA0kKBVug319pQvudZn4pi5pPVRMVCFT6O2NV54vu4GX?=
 =?us-ascii?Q?RJZiyZGwzew3fA10M1O62W7xH1ZpsA/vWm6O7yHrdZ4BM/wGQ7DkN/PzJFti?=
 =?us-ascii?Q?VKZ6xgakwUcgQPP69tgZR9T14RjOuO7Tr0Sos3+yuE2KURjV2josZqM72PqQ?=
 =?us-ascii?Q?Gdh3fcI0O5hrOmL5KZ/rJaccpfkx6T7qOt6XVfRaK+JnUUzmpwmv0KISgfZv?=
 =?us-ascii?Q?bom7IrSaJLcBd/IZC2yrfhlnzi2kSgKwt5yS/p/XJlPV/L0HqFENq7V7rxur?=
 =?us-ascii?Q?s8Uh3zdj/FSvjsqJ6m1K9uG57SQ0t2Q1zbmMClmSyUkBnKISw6SN882BxXub?=
 =?us-ascii?Q?/FFj5VkOOf8lGb5Y+IQXrE9+Nu9EZKEq43ojhRB7TMclNtgijLZnS2dQgCU4?=
 =?us-ascii?Q?UZkzDLX+Y2taOWJI4tYZh5G2Pz5G7M3PYSQBkxSoWbnWfa9/UTs8p2Nyy9sN?=
 =?us-ascii?Q?5OrMgG6LBv0B57coqhm7H6ajwt+RRNMv/H0dDP9I1tCxg64RG3IVk0E+tc45?=
 =?us-ascii?Q?8x/Gsa+i6nDqD3F5UEYYneV5iSYgWPlLlL6qphEddptogje7ml5nmrdd8w8Q?=
 =?us-ascii?Q?W31NGj9Leq15X5Zd16XiPafd/Xec2s3iS25xtnc9Kvq0tJ5g+7J/E4uWyai6?=
 =?us-ascii?Q?n/NN4C8rswZwrvcCQcqY4RIXGLQqnNo/DYfZHUSMwRPQOfbN0BjayKoDYGEM?=
 =?us-ascii?Q?gi/aNSZv0zb8FUJE5E2EXDBedi7KSbAVbj7fwxYAeH4PQIcM/iOLRk85PnX6?=
 =?us-ascii?Q?fPZ7rgQ4WPLqDGnwitEXpxL+QIMQad7imJXiHu+8Du5jCCQ0iRz/vZLG9I4b?=
 =?us-ascii?Q?MQI9FvF8YSxeKNStK8gqHu1Z4pneFo0Wt3cVMgsqkRWND34ZvrjeMb9pVKhJ?=
 =?us-ascii?Q?mMbafkoyMTLKEX5hQp64jqbNHx6c2Wyj4peTvnCxCqAeZPBptGxOfqqp6LFO?=
 =?us-ascii?Q?GViQqscg612pZAINsX6q+Dnqki5JBc92Hp0nBOMghDJU5ebu0BWy7VXsy5bU?=
 =?us-ascii?Q?ilQqRsDMnXOuHwNOP9DD9AK0S6irHrw+Id0v5oPl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46149e95-d572-4b2c-83f3-08dde0968e54
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:38:59.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxyHXiP7907GMScThhiBQw+y+ZUNqKfA7jNJOPUVgaKoOW4edRAKJZncgec7E86zNe97vECFz3HD73XzEEh37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5448

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 360d88687e4f..2a54adeb4cc7 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -578,7 +578,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
+		return -ENOMEM;
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
-- 
2.34.1



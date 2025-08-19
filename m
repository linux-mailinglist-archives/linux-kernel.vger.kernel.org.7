Return-Path: <linux-kernel+bounces-775640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96598B2C2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6B3527F27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124233470A;
	Tue, 19 Aug 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FULystRt"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013071.outbound.protection.outlook.com [40.107.44.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002FD338F47
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605438; cv=fail; b=Yyv/rWF+7VnCZKrQEDa7M8l3yPWN0o7ZqIzgL+kL0eZF+l5IUzYY5ITCyubE/x9+CFQcMCZA2T1m+ee9iizmcCPch37RhvHKKEsiANdaE6U7sTLoQnWVPAX2XjDHX8+Qyq+a6+B7A13WrbDWsMS6Kh11kljomZcq+Fp3dhELO10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605438; c=relaxed/simple;
	bh=hwqNmDGtjxR0fNM4LJFALwjqPGALLsvXrrJYLM1Wp3M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mXSJ2T7PpR5ofoMkPpzNwCdtvcqzoAK3poyv3brV6Jj6+xb+/tZat3dqBJQy7citfgO2WjF3FauuKgE4XxzmL0VIqzxTk6gyQaOe7woA3dyJYSYc40Q8mWabllXB4ZpEzoEVPwP2CKHEbwWGhAXoaELLyemXYJslkb/+aV+8g6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FULystRt; arc=fail smtp.client-ip=40.107.44.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVPfcHgeJexGeYH4urACyeqcMBW5Cr3WMtK0v5zAnq1BSU0PNmfePXYoCakbwCWYAfnjH1iaCtOjXx8ujFv8BZFEWtbT0Uh9GVkcbf0GVT6TT8p3gOdEf5mDeYZt1Obvxjq4d7tB/ky0soW8lg2S7pB9VH76W6CE88rQ3DWxH5gEQiiMPPiOTXpBNuac5PJ+YHkJ1NhbPocNMGwVwfOZR3ZWosFI8nBa3vMVG8cG7yZh2zfJ/7f/tn4ZEUEZPf79FIthUCUFfKsBF1jsaQUu9YONB+nz4Z8IVY9TuOjxKcz76ptXxSzZpCyt4TNGSTsoDFhBAeAqKoYYEuHJs7Tixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMPBPEAAPYZzUtaISIqA1EjqBiUFg0mdLTpobHxLZ8M=;
 b=wzgIS1e7Q9UPqYYPuWFeL8D/nsCEtgo+Xt59oh6WSWe87u2N4LcSJwz8u+z+Do4Fah/6HCIATtu1d9RPD0VszGnUkumxrrOd/tZzs2yGpQTAYDzm4FzVyL/TqoGggo0x73XDZDN/6cnwEXo5ID1NGEAII5+UK0VvZuSogpbVvBGk9e5av0POFQGDgBkw7Q7dk6uC6lny6WgJ6K9sqxF8Ji+gaCbzXpp3uDB1jsYEIRKXZ5a5z02BI86b4gwBxJF36ZmzM/qvt7mErvBd/2UTMiwTOnvqHv6A2V4PvaCVJsRf2W8p9FQLdXrAZey2FeRuhRHfMS/CBrH/YmQdn6H4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMPBPEAAPYZzUtaISIqA1EjqBiUFg0mdLTpobHxLZ8M=;
 b=FULystRtWlideqsb5shdDPz92lnYQ0FBrlEKZmlGJ4fTYlQCNMMoe1Gys8Gv7l09IAMK63CEJf0c1u0HqmlVe9KvYUCApRQX4j/pNxQocjVTsNwmSppfz7fgN01nq4bCnvVIABS2gbfCtcW+39sEjCiVLUqGrHHRSCvMU/rUDNpfL9uki6F3ag8b1wSFSyOL5XtWTcC62i0u9q90sSBJEc8p0mmuk6BwwxC7beUcgPjkMJZSZ5N/tHgUDPQt046Jd1XXroBV67h09PIXtqW/PnSBwyuIQOMgLblv5NzsNAJhYsfljtamTy01ib5MWZ58pWtJJp3BPnMZcGm3gHs+OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SG2PR06MB5381.apcprd06.prod.outlook.com (2603:1096:4:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:10:34 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 12:10:34 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: nm@ti.com,
	ssantosh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] soc: ti: Remove the use of  dev_err_probe()
Date: Tue, 19 Aug 2025 20:10:23 +0800
Message-Id: <20250819121023.608298-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SG2PR06MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: c79865dd-3b27-4467-ce5d-08dddf196679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kupfEt2gubbb3Gla8aYhHMgfjPlUYnqXcoRCGZlQRr5Ge3aDxOJUs+/jvB7a?=
 =?us-ascii?Q?k9RMdGybD0wqC5xZw2e++FdSqi9uc1eO2Jhj0BtYT9mGPmqONOdsWHmP6IzC?=
 =?us-ascii?Q?GjaXGkXjsHdInVW/UF0dJTxeLM1OcqgLR11WoscZEYmRy2/6mRGrgUxO8d8j?=
 =?us-ascii?Q?3/KNlNDzHC5toiZ8lbbRv23YNX/Q1jUE29oedVbFoIdBSipPIo/tBTcI1g2V?=
 =?us-ascii?Q?nNqLn82BMzlrwqFFpsoGDav5WrZwO6iGhSRfWooRkhfEXKP+X/+Fh9wNblq7?=
 =?us-ascii?Q?ARkNoXBtG8D53Eh+AJLRcGRq6gYp8WvguUusTtqq4w+uBO3tWIlA2+LjFc7n?=
 =?us-ascii?Q?KA10opAZvVnQn5Rj6RriCgG/mZUwJig/woX9KnzQdEGEYWbX/d2VVT2+JH+l?=
 =?us-ascii?Q?KI8bbqgDSL/ZHbXewf7m80vWLkab9qZLZlrFoyCPa28kS+D45pQLLIr9u1qR?=
 =?us-ascii?Q?LLDZwMVKJ4apmaJZXps6HG5UckZUCNxCr/YnGFnpsTrcCRr+MCdWHgwLGESG?=
 =?us-ascii?Q?WCrtUCKs0Yyo2GwmZ9ZZhbNp74QxRKLPj3ijsz5xZNbbixoWm9y+Gz7X/UoU?=
 =?us-ascii?Q?fVfroC+LVfJmE4AaaeXvWH7aAKkvHUejnAXCQKo5JjHsNvQ7lYqmjZTAlYh7?=
 =?us-ascii?Q?xENVlhE1PlDeebFnSUSi0RhhIx6c4+KtWpEiP8WyKZknYY5F7PR2IShDO+pg?=
 =?us-ascii?Q?3SyNBb1Pyljg8t/V+VnMCQMsHtWTgUfjUpmOftdIwTw9boZ4IkMEb/g8FfBL?=
 =?us-ascii?Q?6ORPworxy/Fl0gr1ddvIr7WrbMRVd10jktGKrueuq0y7CZlLnsVirDr1MmjB?=
 =?us-ascii?Q?kV695u03EcsPNZBxmiT28ZENRLWkRPXuKlR9DiYsH8kawNlcTqUg50E4tOAi?=
 =?us-ascii?Q?0tOrkBkWKfMhW6IYVCbnoWd+nHfM8EnT8YAD8bmqH9+TWkWGOccutvuAxRJI?=
 =?us-ascii?Q?F1J6MFdPR8sTV/bjDSD2B2rbO7fG/29WjT+ok8XtsFtLtwOFuMiEBi2mNTWY?=
 =?us-ascii?Q?AXzCGPMvbPF2eJEG9rOY17i5KVAp5cL6AFMHMCjZ+9EK9hXnAbKNQSZ2zAR7?=
 =?us-ascii?Q?ixWqvqjREWcucF2DVT7tAlabau/uVBNLCCGkPk5jhBYt6iWaa5BVxltaGgjI?=
 =?us-ascii?Q?CQxsEDrV/VSq66xImEwXqYjbo+yf79OrGgccr7WMKyyZa3Je0INz3TaOwLyD?=
 =?us-ascii?Q?PY3r/LoZ030ecgwbI1UxcUI3nkY5HnbXaVg0aX2Wg/es3L1V7QRtirrgvAfT?=
 =?us-ascii?Q?BTJCisD7CHuZwW0D1EpLCuSdSHhAp1HhobvLbGiTaz/aBIk2runmEFKGywsE?=
 =?us-ascii?Q?OgFBXvqb8ikGHGXBYxFcwGMB5NUB9GrLWP1ysgryqM2AjDfeJOlfPqFDuR+7?=
 =?us-ascii?Q?GpyYS/Hv/wcJa7yDVl5yzXmTHlkDqk2ZH6D+a3yQaiPpgUWiNe/ltwByIXHs?=
 =?us-ascii?Q?roPKeghwAfkTvufrokncyn3MRohDz26+EibCtOu+DUeYSIDoc00Blw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrlU7xOPxVqYrFqsECGc9LbxO5rvzUTIT9sMnzldePJIv4IWuM8YkvXZpF6H?=
 =?us-ascii?Q?PJfqv9AIsobAPLwKi7jPTs6S7aaGiOuhIo5akXIISUyHJcUTMo5LzP/LLShd?=
 =?us-ascii?Q?3PeDZHvDU60seS+L9BSDQuBHpaw+jFQe1Floecg7YhlYnS9rV3AJlwY/pnlC?=
 =?us-ascii?Q?oR1TRdBNjDkJdjViL8gS3STVkDjfnzIFx0chwMAsd6q6Z9KG9wRqGxnu4KUL?=
 =?us-ascii?Q?kVCFBo5gOBRWpyeW0k+ijwrj0+/IYFu+FYJiTrovElxgX8DNkElAb9h7Z0Py?=
 =?us-ascii?Q?onK8B0EUmIeaC2nuRuHJMMVlFA/o9zidihvq3HBB6Ciypl3U7zmlwAkXye8g?=
 =?us-ascii?Q?FOiCorAZ+neJ7DnV9kaQ27q0xovrZ2rY2XvIqTC7PJPbwL6kXvGqxcCM0HOO?=
 =?us-ascii?Q?tc6HIS5h9oatqyIOEmiMCqj4QUfYmgOu4FH2/a+TcyQYXqHtMEVbsYGcyjfZ?=
 =?us-ascii?Q?9k2eE2T0oM92M2zR7crn+p0e/gTFjMAZTnQ5m+uP3kBK/W6fB86hH+wI6ZI6?=
 =?us-ascii?Q?R5MhrBc5cp/DFLxN4WhuyRcQVVwk71imGp5lRhUcz7S7vGuPZ18REev3Bipz?=
 =?us-ascii?Q?emi0f9C543x5oCc0j5g2GVgy8yd6Nwq64o/SJuhK+Dq+I42YRuHPuyaEPnJe?=
 =?us-ascii?Q?S8Pfsl+7P08LVE2OLwnbTrAjzLUK63197e3WqAhte0NZox8XHyXKSEQVRJGE?=
 =?us-ascii?Q?i6+hunMi+ljCYit12uJNdvfg2QToj1JLD6LCyRAefUXPxKmM/2ApV13WI9WH?=
 =?us-ascii?Q?nW1NJ+IpeozCFkut2rNampJCLS22Ky7rNADGPwGba9fZESzrG69cpTHDFyL/?=
 =?us-ascii?Q?aRj4t6sS9gYhaof0Ds1A42TwOlN4Cz1bk0D/PvVQ+130an/nVBECAkYaK2da?=
 =?us-ascii?Q?aWFPWiCw6qM+NNj0NkZbU/fb+REObKXDS7Bqj0bN/UZ+ydJ65AGWmmqIA+Uk?=
 =?us-ascii?Q?GkhmQmgmnFUjfzfoj/izx70LhyaKO75TeXE9Yiwpoez6hRjcnkR1MR/+KVov?=
 =?us-ascii?Q?b6+ItdEPaXBImIHw7fxRIjvtT0xKN4oumOj7JePEaLqBbgoWotJSrgFe8pS4?=
 =?us-ascii?Q?9NL2cndxIEkiSKTEvAP7bdtWtdgNyirXgOH3Aq4IX/rwOwMfNnalsHsYMMPV?=
 =?us-ascii?Q?cXfNjR8/ChlvV1etLAUQFpv0/TzD/mYsjCUo6pphvpquyHFjVewUvkQ3yHJs?=
 =?us-ascii?Q?QW4Sjfb6aC4Nxg0L6Ej3xVhY2dskncyi1fe+ylF4uFdR0+C3q5pFN8mpqh8i?=
 =?us-ascii?Q?5dyYr3LLlhZFOtoXW3eunQPf6V+PMDN5bd43tB7agO607l9EuVAm+unpzyx2?=
 =?us-ascii?Q?LGtMsmoKl+H71QHIXQRJsssucyfaYFvUD9z74szaPR0PICBH18WfkRp9l5Am?=
 =?us-ascii?Q?bmsI92dN85SBE9PLWyfpj5+3MQ046QskJDhDfxsMKDTET9aD/P4NW83JdBz5?=
 =?us-ascii?Q?bnRoKqZMZXNCr03NHQCBlRuDLRWZN8g3Q/FMYZIySx7Tj3oc15TmPkU//3w8?=
 =?us-ascii?Q?sLdGmh2AoGVTN3dRIkGkZMwVrV9cwWxBfvXIU8RaoNBdDTZhf9JpMrD3ZZ/B?=
 =?us-ascii?Q?8YWiV5hqwG1UIPbIqC9pGCCCEEJqOECez952r4gO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79865dd-3b27-4467-ce5d-08dddf196679
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:10:34.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0OZ8mvYP752KFpRUsQFKGi/GihpSLZs2jywn+Yy4ZWymS/ifrIVDRzHumKQG85IORziN3MccI08hM9ZDoRFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5381

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/soc/ti/pm33xx.c | 7 ++-----
 drivers/soc/ti/pruss.c  | 5 ++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index dc52a2197d24..24f8df1c8ebd 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -408,16 +408,13 @@ static int am33xx_pm_alloc_sram(void)
 
 	ocmcram_location = gen_pool_alloc(sram_pool, *pm_sram->do_wfi_sz);
 	if (!ocmcram_location)
-		return dev_err_probe(pm33xx_dev, -ENOMEM,
-				     "PM: %s: Unable to allocate memory from ocmcram\n",
-				     __func__);
+		return -ENOMEM;
 
 	ocmcram_location_data = gen_pool_alloc(sram_pool_data,
 					       sizeof(struct emif_regs_amx3));
 	if (!ocmcram_location_data) {
 		gen_pool_free(sram_pool, ocmcram_location, *pm_sram->do_wfi_sz);
-		return dev_err_probe(pm33xx_dev, -ENOMEM,
-				     "PM: Unable to allocate memory from ocmcram\n");
+		return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index d7634bf5413a..8bd1dbc84fcb 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -443,9 +443,8 @@ static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
 		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
 							resource_size(&res));
 		if (!pruss->mem_regions[i].va)
-			return dev_err_probe(dev, -ENOMEM,
-					     "failed to parse and map memory resource %d %s\n",
-					     i, mem_names[i]);
+			return -ENOMEM;
+
 		pruss->mem_regions[i].pa = res.start;
 		pruss->mem_regions[i].size = resource_size(&res);
 
-- 
2.34.1



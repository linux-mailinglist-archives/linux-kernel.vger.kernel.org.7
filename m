Return-Path: <linux-kernel+bounces-770938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE6B280B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4B81CE5636
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55C301031;
	Fri, 15 Aug 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QiRKeaDc"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013061.outbound.protection.outlook.com [52.101.127.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9A433AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265018; cv=fail; b=Co4GO2sz7FfDeYqnJutII3oYS6zXG5+qyAp0vrOx+L8F8ODqwj0kNEYvZjyT57u2trlSilcTxvClBvfZBCu5AU7TjwJ1EoHg2CEUQrCk6eVBBdX48i0bH9OY66r68CsL1AheD8xpcMD07MFw4gVGmYI9hp20Exzqzuolhn5SjaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265018; c=relaxed/simple;
	bh=fKFIeWFYdx+7tzXwoKuKOdXz94S2sVTKEviLrr6pEx4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UqMPXU3MgMbAFaR8bu4WBCzLG4QwsJZHFMs+AG3k25rrHCFlQkU5oDlzZKHq5l4ml91Jhp3HS4chflnCsOQcg1ZEBOW/z3n3UPGDLXHKZPTrpNo/5lFf96Khka8S4ySfZ/DfTtC60MzUNtkUXG/sV4vYrdh4mMvkZQPGsO8Q4ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QiRKeaDc; arc=fail smtp.client-ip=52.101.127.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBQgj8EAMVMrb3k1ZM11E03sgP8Mmxis0u3AhVMKVh6ecWgOkuOQ9Shk71FMdUezuBvc3OvywJeTcrNedJvn1oh0YRLAOdjJ0pVd486POJ4OY32MlP3MEks5x3MIWAvD1LZW8GtQ3/L95ugHL84dd8kBGwdkQhfbDrGzTnodGRAtjwiLUBDT33GLw1XXTLJljr/ffgVWV6HqXWTCGfJjeVt9QtIIWFhsN+fb5chRIaE7uNZDRaCM79NeNC8emD1q6lA1jjO+gwnoZh9mlRgb0goYZ3x/J0A6XOkQGRY60zkT+E6LtpUunmrJ21piT/btCXguWQRIEBY93YQLwvcDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KULFvgfDBnVZopY9OrLOC2udHnpFrGwGBrPGa8ckE0=;
 b=QXoX6xBkNM/AZswkypg8brwqXwoS6uuRvrzc/r6DqMBgxK/2zjTUUPyz2YFbpcEp3bE8q5+vSvJEdiuBYptGlBENgHilkEHA1kQrmIqpNRUgD6pErSPmOh3qvM1gDQWIdxbCsh/ykCdMPRiY6lodIXm4hgwtXICsPjdN9ApDBcVnnOryhp0wTZUOD05wFWSX01Fl6F/VzSdga08A78aMYmMpxbwsTRKen6CbylwOUGLVj1h0akBcGzY3Wv7in3ITEFfVwiPL0Oe6JTIVgiJrmhOORbY9ZAmOKDGmS4mn/gSV/iGwZlfdPloNUONekS9unvqs68SnUPq1czAQ+9IcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KULFvgfDBnVZopY9OrLOC2udHnpFrGwGBrPGa8ckE0=;
 b=QiRKeaDc4qbOa8nIzbdLl1MCvnVY5+lswL2nZCIoKahP2KAPNCKQUL7aIbg0I9nryFe72f09TgeQvkOUPEIhf0xrQoBfHH+MCfbwtmsX2Xgfek4mYbzxKbLVh8NPDPijGKL0f2BYAhuJ4DCDs0S3kXEO7szT9c50/xJkTvec8+qGYf3nXTkeuNptXd2yCkfPiun/cDoBL1VKcNkMzAgRg2B67preqVytMtJUWzll8Px3jQVir1OocdsgE7hbi3GwvOLeLxsSYMdbAZrSWaXqpgypwNvPzFc66187gjbAi5byoTZctqIvhz+/OoX3GuvQsKJvEwA3yW3GudRrpjrh5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by OSQPR06MB7277.apcprd06.prod.outlook.com (2603:1096:604:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 13:36:53 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 13:36:53 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS),
	nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] drm/nouveau: Replace redundant return value judgment with PTR_ERR_OR_ZERO()
Date: Fri, 15 Aug 2025 21:36:43 +0800
Message-Id: <20250815133643.418089-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|OSQPR06MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: da61e9a1-c95d-4620-4b3b-08dddc00cb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VgbV4XTUmshr9HUnMsrEZITpn1JcO3laWHUZlr6QWouQeJ4GtUxBe78Acp5?=
 =?us-ascii?Q?qKxSwg9uajTLvRM1OHzuPnrO8dxhocMfu4oI3p7tqX9Fs8bioSMgQyR8lLBE?=
 =?us-ascii?Q?OLa4b9eyjlQy22y+oO8cLAFEynh8pxqo8iM8i9oArCDr5uVog5bPFy2PMVj/?=
 =?us-ascii?Q?4lTK+pGJokXx2nIWq4rKCSgEzWsRanK7j8qY6wS0Lmax1KSTojvblVI6cn/V?=
 =?us-ascii?Q?w2o8rVofYTRdtdNfk0MAqtwVFTeBnZBt/uBhcu6LCQqiwXUujOaVw8Q/ZDnz?=
 =?us-ascii?Q?VIJq6ZMsIT1xk8ToNCWVeM5SzOZR2Hglt1Gtf9liQFMAS73geuDFp6Vix9R5?=
 =?us-ascii?Q?x4w9fSJo8sCqQBz5Af9xht2YuUjFFpBu6A+91oIPcVZHN3n2tGERrnfp6eh7?=
 =?us-ascii?Q?VLnQxnlK+noHC7VcskQuWZxtwpGK20lMOD9Y1fsaLtb1FHfm44I9JjPGUD/n?=
 =?us-ascii?Q?m1kHfRx7tkwS5z1zJ03YgkEizD2/rnPdtwBC5gkKvTIa4kVWUdvrIgNSmK6j?=
 =?us-ascii?Q?B+qs8U0osPXL5NG/ys+1joVSW47NpyBuL73xX9WsktvxdpmZpxjlmguXoccW?=
 =?us-ascii?Q?+/zpThnPX18aOyKhMb1z+pMEiCb8Rt8UN7RDHdKcuXHrWDvaNHoykI8GpbzJ?=
 =?us-ascii?Q?Z+nZnDxzVskv3RPbfVW1chinA+YsqpI3zgqtnj8p9XJQNuGvu8BuPV/xeNov?=
 =?us-ascii?Q?ktz345NruYD7JErfBV4eH3Uq4AkcsjwEaMtyGjMQWgrymSedcg6SkQ4zSJY+?=
 =?us-ascii?Q?An/MiDqHH9LtPciQ7GrJmcUwUgTRmhfOsnyy+zWZyxjSepjNVmd83Iej1B/D?=
 =?us-ascii?Q?HKx01Yr9TE3Z3ZA3F498C/CuMfi5TvcdddHZuuYIbjDsmFKyMddzi2yu5iin?=
 =?us-ascii?Q?eULJdzHZTNcmeBhv5J5dbDHhiCx2ZJ5WcYgb56hf32ad2dsHryKb3Ivec2g/?=
 =?us-ascii?Q?Msc7TSsMPJVVqqUUSXRa9lpkhmRqP54A12P7WSnuVKcMJEMDORfQ2jg8cj3b?=
 =?us-ascii?Q?XVKCQ85EClubntHLGT2NLczL13XVqLf3mX+TseFNCgY9yo4W2FSRAn9KOnZ+?=
 =?us-ascii?Q?WT+/YBQn7CpCkZUeycrUQLPrLCc4nnUB1TkSlX37VHlM3rGy0aB67GR+76u5?=
 =?us-ascii?Q?1QA1bmHa23rDE4+w8eOs7jlQ5Ngq6qXCRD9DtGNpLtVO5aTnI+Lr6xX9BM8h?=
 =?us-ascii?Q?rfJjprGRWNItdg0pWxbdPK2f7Hku2fQ5bIqP1G9P7rfntdtrbSOttkLtiQwZ?=
 =?us-ascii?Q?94gOuKs1VpN5+9jcckkkOy4Q9w9/pd9fKcXO/18/kdUGuRM6XLVfyQpgos3P?=
 =?us-ascii?Q?aCBxq+8MLON720wbXtpaMsNkiAf79iAwEZ5qoYH0Ed0+zfKwg7wQzAAU0j+W?=
 =?us-ascii?Q?ELWrD2yuLU8WSQcQWtplsj2bKnewWoZScONp8NMjTrxOA2LpUNIkXv2FdXrH?=
 =?us-ascii?Q?YWT0JsGzrZmrLThzVIMowDcJLvrPQglPXnQPWWuY9SqYqaRHBG3y1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qfmpysxa0d9ijVGCbwpxDu6pGQbWSQRw3Mcosp78TxLsycq1gBeS7FWk4JNa?=
 =?us-ascii?Q?DaZbo07qrmLau1mn6o/WiytjDFIpuvYvsRdyKBU73LhvegLxczRuEzQy7TJa?=
 =?us-ascii?Q?Wx9ZLGR9VqhgQIa9TKIlb6hRJ/f9lPwcJ6IObjcZPFZl6Qcf9GR5Z8VMjC/o?=
 =?us-ascii?Q?P3s0P6QROAyOLU4t57bFXRGElOpsMaLQo9vNxtfCesBJOfiYRoKDA6ihh+03?=
 =?us-ascii?Q?ExW3DuZm/Thg7dganmqU0ygLvb67/wY8c6LfOKXGJn/0DNlhst7W1Ey/9dma?=
 =?us-ascii?Q?z5Khu8WfNDkiHCQ8jaR0ykwYwJAHCS6IoRn7Pq62kGMnsuKZVgxdy8sQcsSP?=
 =?us-ascii?Q?0ghPEnEd92YVFuI/laEbI5NAdBQitKMgWKTtzV5ctBTNjjlqnI0JbVHFoz/A?=
 =?us-ascii?Q?SMh/FnRvPckr/oidD8U713Bn5BPrMPt8v01xIUrVnacAj0mGKyi/0AIzMXRc?=
 =?us-ascii?Q?SgFmu6VSN2Ns+LR1IRV4Rb+CjxDQDX+OjMfFZVWIC92tjzXBqC8uRFEJoa2o?=
 =?us-ascii?Q?vViKen+YDbs6m4ND1AMQftLo433IZ8WDqio1btSwLn0e9qLW5nMLpT3Yot/s?=
 =?us-ascii?Q?wrwQNetzV+fXMUhpQLi0xFSJ7Huwgs7lF/M2FdFoW3uDpEBPiV5fypC4OJ9M?=
 =?us-ascii?Q?HcXzBJLQVT51rFTmDuoil8OzjjzBxycOwdaxVSsstLnL1g9WUA+EcFPgXLuS?=
 =?us-ascii?Q?Tb1M3Vg1Gf0ovYXuh5MGveDCfy6mV7z9J4HlR9TnEtYL1DKzq/xxJUiSDTsx?=
 =?us-ascii?Q?vFr5KH9XxUyZq7zZlaUKZyL4a831FQRNYeWqWK1ewd6gMg58z+QDNYU5E5lw?=
 =?us-ascii?Q?AFls602pPbzFoMIaXKOhSBUnYzi80BvTG6hdpwgXxOTHmByo4FugLb0w3JRL?=
 =?us-ascii?Q?EOTibMaRW36FDcy4h/PBFhKxkNDGpX2XldIaIxkUfUf2oBVxuPl4QCqbmt40?=
 =?us-ascii?Q?HUrppNx/9ouZ1LbkjCBXM6RBNKPwkqVKSJ7f+ENI46Y1cpYXE0UZJSflSeyr?=
 =?us-ascii?Q?et0RVjg2bX8G0XgaAthltJgmTPCh/0dgc9u+5YcFVYuWH+25gIHAQNZ/q5HX?=
 =?us-ascii?Q?0joWdia+ckGwN9XBXcA90aLI2aFvDdTO6SVtp58tEje7Z16/M1QtqzO3XmHE?=
 =?us-ascii?Q?DE8qr2SUBEHu52tWLAG7jfw119DkG7sO2B0figzRTwR9XMPhTgKr21ld5BCD?=
 =?us-ascii?Q?RDrcVl26z+YWH/j/UfFPXr/+ftGQpndsdZ7UDM2gOLFcWD4XTb6Y6hjKI2hY?=
 =?us-ascii?Q?Qj8PCUqTIwnqtBV2WGLT1f3WGiSppNiBVE/13ej2uq+vHW6SI73qgSb14wYS?=
 =?us-ascii?Q?25MylPas9eRqPV+vKp8IU9/THM/GHhS7WdQJrAyiENQk/f0n3MEE5ZG7NXEl?=
 =?us-ascii?Q?lq3LxNA/NfZeb8nGDmRMJ33VIgP0akIu4f9vaw3oiPvuFJbAjTV0Y3EJJUMG?=
 =?us-ascii?Q?BjiZsB5OoM0mrXtkMyDIoI663cEj0DqEespZGXGz9+Uw09f9yJOjRz+m/mat?=
 =?us-ascii?Q?lZYy/AeZ86GAp9ao8wf0J375vO2F7OGoGFKVrwHWOilMVEB26o4HhkqlMuhh?=
 =?us-ascii?Q?tbPdzG4LIQoIjyKbtjBKQpdgz/bjqUZcu20JrY4+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da61e9a1-c95d-4620-4b3b-08dddc00cb58
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 13:36:52.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjGomE+vH0WwnQLdsIU+yqbGvSNMCXjy1iiICiltxHDs7iND2U6nuqQcwRZdT6ExcXZ5GPgrJkUQ/2tX5F2s1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7277

Replace redundant return value judgment with PTR_ERR_OR_ZERO() to
enhance code readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/gpu/drm/nouveau/nouveau_platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index a5ce8eb4a3be..8d5853deeee4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -30,10 +30,7 @@ static int nouveau_platform_probe(struct platform_device *pdev)
 	func = of_device_get_match_data(&pdev->dev);
 
 	drm = nouveau_platform_device_create(func, pdev, &device);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(drm);
 }
 
 static void nouveau_platform_remove(struct platform_device *pdev)
-- 
2.34.1



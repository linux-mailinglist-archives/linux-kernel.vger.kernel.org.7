Return-Path: <linux-kernel+bounces-756066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C4B1AF96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8932F3B47AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008F21CC40;
	Tue,  5 Aug 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Gpu0tUZv"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E61448D5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380035; cv=fail; b=GYzvKgxNBa0KvO7wlZdONksgsQ4Zz1q7+YcA/G2gcoroa+nQW0j/CQu+LaXbwpD8kruQ/ygruzZxuBqwtZIzXVkxjNv2tPrBKccg5OCA4rhRnb6gEvY9A/c6K59uZqb5O7cvnHQ61cVAizJtgYjWETvGHRFqZpncTOHUydPte4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380035; c=relaxed/simple;
	bh=UJ+G1OuDNdhnlClSt/aM1tvM14Unp4VM3jDxzoXUgsQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYkd9bvBNeM87Gh6KDvnrZF62jJFDwugkCAodYZmR5EdwMwQezLhihruZlqUKlSOu4fIL1CmbvyqzC+pHc31zprLNn1bQYYMXJ7DfZBhw2j/ED4o4Z141YxafLjMCdsbAWu9XVW87j7iPZJ9syhie4H1SnfizXAuEFA2U1eHaQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Gpu0tUZv; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ompc+GSMyLMNxKpyPzeAA2bOEMn8kTY03/RfmgHdGodRmHT3RkVzox7xZLVT6gfWhGjnY778848CSFJXvcvACZR03idujbajdaZul1u+ZM0aYaqbHQT0P5NfKLi60L8Krm+ydlpNedo0k5LmTXZmWyG3k8E6WBBzupRyqsVygN/MRTIj1G0NV1KHV9Gn8qVGMpb2sbtUDmpNnn20vJABeskrYs6UUkszC/JTzpz/1ciMzy8sXPxUjn/gnDJ/vh7S1D2R+H2TaI7U1+cWxBMbEDhJEVMVYK6QqGvFkPIgWCEmxKN2pS1LD8CxSqLc5W8OBe6gcvpB/JJedGDKals7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDAjcnbMjD/heZ6y0Ct4cKCslg+z001Ib2s8+PvATIE=;
 b=fYjxYRG56alGatL9DLaQVPfgVtaDksX4uqqT/mid12FHSDjJlhU/w0EggJP/bLSn20q0Jf+QfGzEQVVNXKvQDkdVIwyOSnVG7NZXMdE1y7VhWltnJpzvcF0uRrjbTX0FO5xaTM3pGqB6zsBmuAu06t74ULUAZdeMdlhx8BXQlbpixOF+8/p9pMc6izdW7XUPrNDLG+giykeUX9C4jRi8CzSK6y0GozOma+YSMjZr/HiOg0rPfZF23VBfISJfVj3cPHMW6BoJw0NcEtS9sPmKiz4Spi3e4/GUsYN4SV3MveFoOQDDyS5pl86LLPlrZs/ZtAWMsQrxbnSHKR2iMiQqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDAjcnbMjD/heZ6y0Ct4cKCslg+z001Ib2s8+PvATIE=;
 b=Gpu0tUZv1nRgEsj2Nz8N8lSddk1YEDUNkIuHRqc4mxPtaEKFIFrip9Mx9ofyZXVu2cWtH8KZ8lV4RGwL/NlGCV1F2HLh9FDmfbS3tAQSx03cXvCXqQk/wKa6HxmcqAOOIevAo2JNpoIsmG2/kwGbi54kVcPsKWtpgnwgtajt70P/lRC5SmbWJpzlFObWZdMgzrxKlLcU3RU+3WnFHLEqea5E4qEH105zXqXuShJQ51dOAfd8OcMuxCtuXoMRHcNDSNhh1sL3r9wxK0aXJwV3MdKvN/+NfhLVHHKby/SMgxWVce7/3dwHDUr2+yrqAfUrH7Qqa+rr9HDjCYm0L4zn3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by OSQPR06MB7278.apcprd06.prod.outlook.com (2603:1096:604:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 07:47:11 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 07:47:11 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] drm/i915/gem: Remove goto label that are only used once
Date: Tue,  5 Aug 2025 15:46:16 +0800
Message-Id: <20250805074645.625911-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805074645.625911-1-liaoyuanhong@vivo.com>
References: <20250805074645.625911-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|OSQPR06MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: ade31dad-4825-49bf-16c3-08ddd3f44939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DCoKqnyh9vEfV5a7k4Pa1m+CyXuhqMMyYDjuUoKjpatLs8hysi0IBBC24Rap?=
 =?us-ascii?Q?I7nob2dvo9cu/rnQR4sVOym1xRJSUUHdO1IW4roYduzQre2mKA4cc7oiUSUp?=
 =?us-ascii?Q?DaYREVWUuEcRCJfsxUrEQv5iAVM2QNx6Cxs/GEbXFrbWb1TRBERLVRWthJ+4?=
 =?us-ascii?Q?OitiFXTqrzevuXG1UjbEP/HUd9mvIN5H0aYAls3UKeAxDHv14wvtcFTgy3uq?=
 =?us-ascii?Q?t3/JP3yOLDC/zPGsCvlU0F7ycgmuNZ80jQRKJoO1Yn2Efo2VV6RvV6+QlR96?=
 =?us-ascii?Q?OKNHl8A+Tqwpcpacdmx5Zq8wO8/Ga1gUgDbA8G/voHzMWDb6wPaRgOLFfwUI?=
 =?us-ascii?Q?Y8GHwPVUwAUpAOMNAsPgHIaVftMclXh3biyu6Nq4VZ8yh0vSnVrtPLJWxmn8?=
 =?us-ascii?Q?uNhswIXK+BT1j+9mYt+5EF78ZocuRKOnmSfGsgyhXkGPxayakeOW6jVjOCMO?=
 =?us-ascii?Q?uNiumgRbx3fxiiIQzkKjBIzOY5jzwaeQ6Pu7dkRMCO6ilLddjPS0CdfGUUbc?=
 =?us-ascii?Q?qpk0jynywqEKj7ofdb9WI3VhrnW5RfceQG5+IaM2HgnV5FXBVBFt3twZMrr8?=
 =?us-ascii?Q?txA3EnCuPHmcN1zXTm0yu8FBdJJxUdrtCk26IAtIdIMAaJoWJm7DqA37em8/?=
 =?us-ascii?Q?Hg4IZqrpKnYnqBi8lMmfxQNRAhXttM7gCxO4QMOipYf4sU2js7+8zi+BcnXN?=
 =?us-ascii?Q?pFyT6NPb1Efb2Thv+4Un9M9VU4nGJNFER8zfVRLHp4H0FYBTfyNs3PfoDg0B?=
 =?us-ascii?Q?FCdoIykBjk/n4EQcYHF0feFgSqEnirOF2goMAMXtHaZt87ifO0hlL/588nEH?=
 =?us-ascii?Q?tzueyOCM2iLsA7A9MF1muOQFCxl+h8MYU3K7tg849yvdQkg+vq2qPacGLoFS?=
 =?us-ascii?Q?8SircoiLnzAb7b8cXRsdc2OWz49l0MfeL+FVWiPlGbtzZYUC82RdvzijZ7Zm?=
 =?us-ascii?Q?bHzxSuiq9+TPMLGyLkDtwGLMinyhFoLzWZjMJ/76kIvcjd5SYgwhxUiRWqhJ?=
 =?us-ascii?Q?SCUVoHP0lIWIZ/f/pEVwktRm+zwIffR18jhG1xr48T0EaxeLcUMgMq86VjnD?=
 =?us-ascii?Q?RHj5nFDnfkZnehzs2PDVP3E+qxaaY8wZvDUlZ/UyKSCr/6V9QUDBSyJ6k1tE?=
 =?us-ascii?Q?c0yjuoYLa9w3y4T702Sp3++KKwztk4V1iWqTJJkS1YhILoDGIAVQFy6V6/Uo?=
 =?us-ascii?Q?BeJfKDj6gL1CCfUFjDsGF2kDqZ1O8o/4yY3k2qrWv66hYijQAsTIw54lFuci?=
 =?us-ascii?Q?4zbwsKHpi2EEMdfT48TiBePosRnndqO6+hZLUhz3cWYxSsRDPWmkNUdbAb2+?=
 =?us-ascii?Q?+bCZ4JFs6Io2Nzs6DopYhFedgZdF3Fy7NqHZCDZtwGF/wFzUMk2shrmtshEM?=
 =?us-ascii?Q?a7XMi8Vk2ndg/iRgFULW4PO5DgMVwfE24E0qmLWf7T/Mq/7yayC8z5huMSvI?=
 =?us-ascii?Q?5WOiI4KxQpTVUWzczCOgNAZZRdg+dhhXRvz2S4pwcvoJjxoBGQ+x36pj3wci?=
 =?us-ascii?Q?h0rnmUU1CX8qV0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3rQ6/YoUN+nj6yKX9obKT5pO0w19e7tpRbOmQ75ZlSP4ooIIsDs+pw2Q+BUw?=
 =?us-ascii?Q?3TFAoXOKan1KIUrD2HGmGm2TTQcssiNwwwXliHmxRDI4VL6rXuhuoq7heDLm?=
 =?us-ascii?Q?3TfuT1weYHGm2+YMRAn+rgmgJRPvfha1z/ygnu0wxGc47dytvf3/LeI1aIq/?=
 =?us-ascii?Q?wgMToAYFJ7sDyti5gM7qdubvdnq8DYU0Ah2ukWRooGelejqggmrYIxxJ0zAm?=
 =?us-ascii?Q?mADNkhqxc0On4LnFEOFqt0TbEbCzs5lH+AHPgKKA4dy/GB1NqURBtmfG3fDC?=
 =?us-ascii?Q?Wr7+3HL3m1d5H5GeIzmt57NtwPayRxCkrswM6AnV7Or7oFHJ9HBx9WR0VhMf?=
 =?us-ascii?Q?pG3La9ulwj1S+pK12fyXUAXswXsXKzi5lNzzHhzPgh6mZGyoUK6mIA7GMWGs?=
 =?us-ascii?Q?zARNkH0q0JVrTn8NS7qcLVZcXkTyoeomcPOmdzZQfaC/tldmOPu/EvUY70/N?=
 =?us-ascii?Q?XY782LoKxfDbbQY4Bjq5x/8mTm1LM5wfwfMYXdxZiVPDLD01brDDU/WMYlsC?=
 =?us-ascii?Q?qCPsygQufKJepF8C4znFTaErMR0NN75ArI9vWtxoUfDVV88Wg9CQWjekhqIp?=
 =?us-ascii?Q?YJPoi4zoKmGk8FfmFypEr1x4jDHwEIMfJJokfsSp+8JiTWWgxAN/DZFUFSGe?=
 =?us-ascii?Q?KcD8YWHe5j0TcVduVY8pgjL4Jb7shWm5LnIY1kkGDPOD4Qghsoo0im1hculo?=
 =?us-ascii?Q?zlF9LBhWEryLF0hXPrZ7152Rh96YwDc8ASDBn5PP7dscbPQuYJ0ly6U5ijdU?=
 =?us-ascii?Q?ZrVN48N/iK0fT9leiD2ojuFUPrpDcpxmtdQESyGB+OjLkb+U/sP9LPypyEpQ?=
 =?us-ascii?Q?WIQztgxQyw8qN9WuzaDlxUnQr9yZJ1XOi89D8f04DmtBbdqnMnwZT1tvc7pf?=
 =?us-ascii?Q?dlFlkZm2rDLMCdSM4lXfPgG+vPErVEyrte0XVZ9yxKrDC1JluQ8XpSREgb6m?=
 =?us-ascii?Q?g5i/pBYPkIWXz0lmpJPep5ecOqYUNrhMLtbY0RYVX0R26VYPbV9EOSHodWlT?=
 =?us-ascii?Q?1FqM24oPMwdmxUru2Yw2/XxcGugHSIqwqjFmNcDIzYCk3Z241AANgsa2luzx?=
 =?us-ascii?Q?ptnk7e7AkVwy+j3xJdNXrIGAsjoHlaYjzsISC9HM+jLSxsQW1lubU/ZbPw6H?=
 =?us-ascii?Q?lj3LrpWfHszW0YjBMs8ZqjW+4AcFCvcZsdTFPlZERJzTUESLcRLQ9RmjqvSB?=
 =?us-ascii?Q?YYYEsm95aXWaUfURh7eSQpwDgtj8KgIa/blfRwW96HFoB2TFGmFfssFYLyUX?=
 =?us-ascii?Q?QnjXUdptIqpShVQvk6G5O5OkapLW8vW5pxvq31vItcbZPDtiRI1PG7vjD271?=
 =?us-ascii?Q?xmnfKBjL9ynP2wooTy7zoO97TTdSKZaWAWDhesNFOlTMMLbGWiRsk8M7gual?=
 =?us-ascii?Q?xbhb2aESweHOeOy4D/xuwLXT6wERNJo8k7inX3v7IGMIF5s6oSHMxVvbvPqf?=
 =?us-ascii?Q?dEIdOd1oF4G0HYBxmqBJMyzkgBZ/bRfFGYBExn0NGEo4k0atH/UJbmNKAMf9?=
 =?us-ascii?Q?Ae1VxH68l4RHwv1lXBdYbpR9mU1TuYYjou03T6chcQlfMKZTa3LpPB0oQVVP?=
 =?us-ascii?Q?6CGrWAPsEYv7/pq4YIJu3etwRiXnU3HIxqwqbuBi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade31dad-4825-49bf-16c3-08ddd3f44939
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 07:47:11.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC44k6YF4Nsd/JMvCWNqnpWifk82c/9Fh52suTIuaiTk9CzzU7owiNUncAu9KAfhmWLlG/xLS5Igv0ZSnPGwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7278

Remove unnecessary goto labels to improve code readability. 

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_region.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/drm/i915/gem/i915_gem_region.c
index 636768d0f57e..539d1716d454 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
@@ -92,15 +92,13 @@ __i915_gem_object_create_region(struct intel_memory_region *mem,
 		flags |= I915_BO_ALLOC_PM_EARLY;
 
 	err = mem->ops->init_object(mem, obj, offset, size, page_size, flags);
-	if (err)
-		goto err_object_free;
+	if (err) {
+		i915_gem_object_free(obj);
+		return ERR_PTR(err);
+	}
 
 	trace_i915_gem_object_create(obj);
 	return obj;
-
-err_object_free:
-	i915_gem_object_free(obj);
-	return ERR_PTR(err);
 }
 
 struct drm_i915_gem_object *
-- 
2.34.1



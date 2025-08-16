Return-Path: <linux-kernel+bounces-772078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD6B28E85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7F01C84708
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723142F28EE;
	Sat, 16 Aug 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AxR0Kbiy"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DF2F068D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355090; cv=fail; b=IBLaa5aW1NEod3dj9ouVp/gBGS/aT1f3B5+ITNZFYPX6K4gqPVlwOV97p9+H7mDYdE5T4TTR6lUU89ooF/nffJZG6ZREL2rcav/k07g6TLmc1vOEcLEmkav0yW69uzio15/5mTNchpXD/gSzS++2R0Ah1wr3MDCZjx9v1WjIOaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355090; c=relaxed/simple;
	bh=/nEtiQogYw9wxEsHshncI+wg3Ayiujf0K7vXUtl34ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KllGwuF6Gee/LPlYHkOX+kLKSZaQJfUv0uHj3KeHiSFYGLvjutNHLBgSWYxiZQUaCCgEavAzTy3DW6x6OXMJkSL7uZg4/QarGY0phMvkhtsfMTr2RLLagxeE2/kEnwyxgIVEkhe01pMbTEDjJC9BhRn0XXHhK8JXMLcMvmwjAnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AxR0Kbiy; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXXYMSLAQVOmAAl4sl2XzijQDxxQj/QegeBJGcX2Xm0G6hGGUE5c2SkyEQoOjCDw8CY/gKR2VuTxS7QWSYnsjz7p1GwRlJ2BlXnHtfzBDKr+XiI0vlChQ1x8ZLjbrF5ror/xId522N9FqNIf49pMV1Sr0AuzHeZrDKpkDvjorz7kKZuyTxwet8FjoxGqyLkpAxyGPu1L5/QqU3GtUksZk5qDXQUJsU4ygklVCDMXfZyfngRHmUarhty+NN2W1O7AcKT0rB6xsscp05e1y+qx2wEVJ4YI+L/BiG/lxl2cn4lT9ob+mAPiy3c7/mpmaWveOYwHBwXMtaU7bfcvNKyAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfzZxXYCpjOJ45++5AasoZftqQIskZvEeyMrFI+lQDg=;
 b=SHltsVOJcxHZfmPoOPIhy1bPkZtG05dS0fWEQxUwW58soqoO2jSqMyOuVxsaIjfWZaP7cRKG4Dh5Nu8m0UoubkaK30mVIgRViD7VIwICLoAG9AoFjQOMIGukJ7KOEuYh+vdMh00OIAadNIKXLvqemeJ6D3sgy8uAzQBkyeOS/AIJg6jxYuymvu0attTSC8Kv6gkNju4ZxXawdWPsPMNLVbZWvGXgWPVuw4HS9aeOEjJbIWg1d7JmkTR908sVEc5SgQM4FB955+shghCgm8HSk6dSE+/ee4Yzt1hEvgEt9WbdOyb++SX1UHiqQG11t6YZd5GDoTwQZ5AkJWXzBt+XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfzZxXYCpjOJ45++5AasoZftqQIskZvEeyMrFI+lQDg=;
 b=AxR0Kbiyd6i4DMh7eDtW1ivKdbdk5DCB9BKPMY4f4YtgY5lW+gtZfqn7bGqeJYxluESo+VQ5gQnbjRf9eA24IHyUCVdVaWr6+2QYggSO3h5OeunJCUej3fr+z0Td0KPvSLVThUPXyd29qNZWGThP1JhFhNcmgcbNQP8ud/LMC4we1fKPOpcU+CRtonwGXFmbInZ/RtsgaCc9ID2Bp68+rGjdVmvAnhtrN7aj39YEdD8k9NTrhK8t2VqeBppFMvYqRZ+6vAUuPbkqbdURd2++3jAFhw+xeyZi73HvMdrBILxD+EcTFV2QbnuDVnJb2u6miVBu6/e3b7UA+GmFOm3O0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6771.apcprd06.prod.outlook.com (2603:1096:400:459::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Sat, 16 Aug 2025 14:38:07 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 14:38:07 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 2/2] drm/radeon: Use vmalloc_array and vcalloc to simplify code
Date: Sat, 16 Aug 2025 22:37:51 +0800
Message-Id: <20250816143752.397973-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816143752.397973-1-rongqianfeng@vivo.com>
References: <20250816143752.397973-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c1c786-5ec7-4c01-215b-08dddcd283f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SX0Bfishxi9eyUg4+ubDW8pXjJuHmLFGtjQF/y/tVBJYhtv7dd96mZ180vvs?=
 =?us-ascii?Q?ZvORZ5V0zXr1lwI8e9leiimbmbUOOm9b48wzjfiIayh7UwJmA9sEunRZFunr?=
 =?us-ascii?Q?/kUBHzBnPZGvQf4o4FLcZBL1fvbP6+/+1mFmoA7hJaVk9EZd1Hp4ewqHOzBL?=
 =?us-ascii?Q?qSyvMzhQWMvKaIWlf4xrcG2wsiwWx6BemNQcLvfiMEBlSgK+C1JjRO13NKFv?=
 =?us-ascii?Q?OammtT5Alk0oihIS6t4i4va7U0R8p8jlK3jDBsk2J7XBig/acTZptdmHxInS?=
 =?us-ascii?Q?VI5c621eQ4fF4pwftoQaaZ8neH4An8uACuVdIm/Xmc76htlE8TByQVKVWCnO?=
 =?us-ascii?Q?WpWCm+f+fIGe8nU+4qKwglUfK2aPr7JZHuKQXFA7WAg9Dce+8kl9cgprTqrf?=
 =?us-ascii?Q?JlP65AWgUZcYJ+yRirso9PGlhMXE//QO1UgNXKYEluH0NYNJc2Fl49PjTcC9?=
 =?us-ascii?Q?dRhr8fxq065yOGG+AF+UFZZcxrTCfyiBEfrs8qpdHGRDMY00a3qW6hmUC7FE?=
 =?us-ascii?Q?sNC8D4w+q2UHBodYAepm7TsQMc/cotIaahBpLxTqTXhix37h1mkdj46sImvB?=
 =?us-ascii?Q?cZwX4pstYahyUxTWDUw2DzmI14UCTtfzu2C8saaQcKLJuFav7wbmlE8gA/nn?=
 =?us-ascii?Q?YM2QDdKCRXzQ950eeT3j0yJK9PsMRnp/z+8ku9i2G6ZMUZ6O7Dj/73tWz0ib?=
 =?us-ascii?Q?hAhF5iZLxsgDqGN/Yy6qeHuKTs8gWjGT17RQblZBa9o/2WMHB874FbYrdevn?=
 =?us-ascii?Q?BgAXuscgzfgHBpH2/pz8w12Q3raK6+1wN1k0/opFTT6e9AtgMWbeYNW8f1lO?=
 =?us-ascii?Q?CEs1mwhjqlKBXAVXdbuhuo2PeKEi2KtXJpKtEoqdQOgeuf2R7m2Op9YK1Yhz?=
 =?us-ascii?Q?5JPeIBe2+xBJGFjbs9cgHY3/uDQ0tFuuN9liV2lsYhCISDh8fjN0HwyjEg7e?=
 =?us-ascii?Q?AUleocaCq+cvwjbgRlhGrKt8i+74fFY4BLF6nVo+xnzQYpHfyfDFIxXBeF5b?=
 =?us-ascii?Q?vPOsKNlpwMp1Bkum9Gyc55U/fBt2DASNtZBZ9cMcS5VEJBvE9BE70ocW4WGH?=
 =?us-ascii?Q?F3NkcIYNkwRT3i5SJvHKhx+5GSUThQiH2mavtaR/dsoDMCjT4ZWaHjuI+pPv?=
 =?us-ascii?Q?qmHfD1V3HVcDO8Bov/xApOQJ85IuEq9ebPW1vXE3yHk9C+wpGGAqha9ihh4K?=
 =?us-ascii?Q?MyPljCrZs8ivR6GQtatdZouE3OhxP0Oeg92gCTnI081OG04HTKt1AKvJQBWe?=
 =?us-ascii?Q?CPVFgFXkz8uLuPMRGXMhTJsvJo/QJW0sdlN5HHeJeaeIL4UQdKGxSlPFsq+Z?=
 =?us-ascii?Q?ZAebcUSjktOgU1TZ++5T+yAb+44YtkV9DxiB40N1p6wCA9f6WaghC632OxqV?=
 =?us-ascii?Q?Uqw6JvfmTzcotOWpM42XXoR6U/6qVHGu11G5Sz2SLCi5X0rAabuPw6qg4Zad?=
 =?us-ascii?Q?1liU07kztjtF2QCftyEq0119Z8mskZmxPzuZJp5RASTD39fb37eBTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ql+wF2B527eBeCJr2XAlk8/t+xVeLwED0EvtrUi5zvlmyJzhP/K7Ma+MvZJc?=
 =?us-ascii?Q?Aa9Ie9wXk5fyxsGasAPHuHAi6AAfH5YwDg7lXZg2coHx2Rf7WPFFJaybJL+9?=
 =?us-ascii?Q?tP82U2HYWI8WwpVVA5Sq3itWHQYnDrUgLipgacORSCGIikJFRX7bCdXjUBaU?=
 =?us-ascii?Q?QOfNcR84upLzRUPGPpGak17q6wTqEpl+dgYEA/IbIS1Ph/AqwwYRyXSLttVd?=
 =?us-ascii?Q?upttEZVJLld6jCu/poFhAtbc90Nkvd32Wm4ebhMVbfgvW7Ab5zVsE1StyrtE?=
 =?us-ascii?Q?0kPTZdDjl8q4PXQUR2RcYUyBJBRWJU72k2rSLoxtSvg+ChKUV0bQGmvCP6S7?=
 =?us-ascii?Q?hjpSJZyw7Qsf0AD4NYp1EtAIfre7piFNTy/EKSP6TXwL+nWrmfjMtxFnNGZW?=
 =?us-ascii?Q?81FR/RuxesQH3wQzR5sF/pWWbUDa7QSjXubUmy0mJXFgnc7eW81CPdKCrImR?=
 =?us-ascii?Q?Hjij13hf5xqVGpbBZoE6PGiFmHOdPNKGDUL3zcEZWI7+84jp4dUlT9U1xpWV?=
 =?us-ascii?Q?xtCWgL+yJUIoSQEy9cRt+F3JMRSDM9ZrgwxyxbXQF1wrewfrisuPMHJXzmeh?=
 =?us-ascii?Q?812IOMVfOPEURVqiXXSR+E02bMQ8cXunavrY7Mz8FjYl18vwoTpgmHJPsiRy?=
 =?us-ascii?Q?fATzKDQn9BGBkST81vXRT9s/abrg5RtaDSKb6YbwSxPF9TeTEieRYArdDQ+5?=
 =?us-ascii?Q?4zWFqsG/MVpcdxuha8X0nJu+bROVuKOsBdGgSxh2C4zM4ymfOoSQx+VvXsUX?=
 =?us-ascii?Q?VJnlFZV7vxL9u3lTQd75l8I0+eZhFabBP9OU/mvwJvuIS/52sjeU5kciC5Sb?=
 =?us-ascii?Q?FwsKKR0L9rg0F0/suX2Rxr+UjrUoAAgmG2OJhwMJHp1sCYTkQBJqznj0Ogjm?=
 =?us-ascii?Q?RMs8W/pn2coZNi/1McFIGy6ujxB0rVfILOnol8wT+2ENoYlrHTAbrHQt/44V?=
 =?us-ascii?Q?p3815UusZbX8rkGVpphHVy0yMvWZUWLHp95A+aCRZQPv86XLXeAOJ2kt/I6L?=
 =?us-ascii?Q?RyltjhKovXthjH9HZ0ducf79PXpODTP8Ye2DOwj4i4aymtVexM2qssQ9RDbs?=
 =?us-ascii?Q?qld8eFO8MIHLShWWdDYqjbnOvc887KMkCjMF923mWd8369p4oB4yk663B8fu?=
 =?us-ascii?Q?Z/96QFm+QbV7bgcL1l6t2pQX3iU7x5chRGxJnCYYhWyGdsw8QIQqwvv9gMxM?=
 =?us-ascii?Q?GVlqN+ahiroJuPVkA3JAckPMNxqhyieRXqx/ykzGYKXaKXyuSNX2esY3FF0Q?=
 =?us-ascii?Q?yXjCq/kUTNfsZpa8a//t8FPApo1t6Y/7PiKJ7WMvTtuwcz4X5IMrJNSNYB0J?=
 =?us-ascii?Q?BdKkNAio7fjo78yIYXBZ3Jh3JLPNELplFEIsC40oXf0EpqalLWRhgdXjroVX?=
 =?us-ascii?Q?Uo//z+aQI3Fkq9l4FIMLJbq2pcaXsELTVLpmweduH3qNNuLjjpXaV8ctZSxN?=
 =?us-ascii?Q?vzowhso+6Sbqvk28fb+GeMD0k8WJHYUDjd+jpwJR2yAm5vXFd35ORuab87TJ?=
 =?us-ascii?Q?1mt2aOCp1jRJNPavGGgyYT+jAJqI0eQS9lnWtrRc9UaGEzxmpKe0ACX7IT+v?=
 =?us-ascii?Q?Iq5a25YPMtz57dVR5UPUwP4sfVp1As8A5gWmNQF+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c1c786-5ec7-4c01-215b-08dddcd283f9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 14:38:07.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSIciEVaW73pAhg6eIF9wremiGp5qe+o9opZ/sw79NasrANn9odo5eOnXUdoCepvsjHxXFg4IhbDLrUedaFXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6771

Use vcalloc() and vmalloc_array() to simplify the functions
radeon_gart_init().

vmalloc_array() is also optimized better, resulting in less instructions
being used.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/gpu/drm/radeon/radeon_gart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index 4bb242437ff6..acd89a20f272 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -346,14 +346,14 @@ int radeon_gart_init(struct radeon_device *rdev)
 	DRM_INFO("GART: num cpu pages %u, num gpu pages %u\n",
 		 rdev->gart.num_cpu_pages, rdev->gart.num_gpu_pages);
 	/* Allocate pages table */
-	rdev->gart.pages = vzalloc(array_size(sizeof(void *),
-				   rdev->gart.num_cpu_pages));
+	rdev->gart.pages = vcalloc(rdev->gart.num_cpu_pages,
+				   sizeof(void *));
 	if (rdev->gart.pages == NULL) {
 		radeon_gart_fini(rdev);
 		return -ENOMEM;
 	}
-	rdev->gart.pages_entry = vmalloc(array_size(sizeof(uint64_t),
-						    rdev->gart.num_gpu_pages));
+	rdev->gart.pages_entry = vmalloc_array(rdev->gart.num_gpu_pages,
+					       sizeof(uint64_t));
 	if (rdev->gart.pages_entry == NULL) {
 		radeon_gart_fini(rdev);
 		return -ENOMEM;
-- 
2.34.1



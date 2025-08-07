Return-Path: <linux-kernel+bounces-759200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7133B1DA05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704DD72824E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490D264602;
	Thu,  7 Aug 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="a+0zv4bB"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013070.outbound.protection.outlook.com [40.107.44.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3230227EA7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577593; cv=fail; b=iG7pNFJPeeZ2cjWYsRJQi4PRGji2U/8qYCPIaY8qOfSUUyP3xlatpRBUNup1QKDFgBLTjlDiFQrRcIVGLxkTtTQwgDtJkAGj5wVVw8d1uCbQijee5JwIny1x6rNb7jO054kn0OgW5hXPvUa2UwC0+EXOiwKf9Y+7WjrBgBOfKoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577593; c=relaxed/simple;
	bh=/5p4IUtoyj4NHFEse6F8jfRGltY28BSi/Z3/h7ljJfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcCZfzW7b2CMkFy+4cRXk1gAwbpKmDSKXrpIdERKYI64nzl71gtB28prHzr3Ch7yfDX0B8RNU0pE8gvuXrjQCJfAhqUj1AAa9n1XIh7+hX3+KzZ1qRZDrhjGBG6zeAvxkOWRjkBS3pVmpUfN8elUq5BaqKUpHXVvVdBCdQhi5Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=a+0zv4bB; arc=fail smtp.client-ip=40.107.44.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evZgME9blvwakt32k0mzgZnDcE3eJ/Eri8/3LVdEiubsZsBQV1f+HIzpMhTVECmr07jti1R4wN+inbYJcInefykmULERxIotC1A5QzIyQuZz37lzqlfZRVB/hQpQkfEVC/7W4OUfBbzCfaB6/m0C45jlm23ARWVpAVPzWL6ul7McAQPTKOum0Sd4mQ5Wxr3Zg8bDraVWHkmQTrNmjU1lVCC0Hr7TYajGHoI/6CLbXBEZy/0iaa+ux2tABg0ffjU01Qd0kCNO92MNBCQbEIzYjkNuQsTNeMsvb0eQfu2d+X3rMiCdpAirgQDx284s7poKdyRECQxMFx9ImnYkEwJOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOBKUpBIOeZYHOIwV4YWdPIFVIXc1ykcBXhbqcI27GI=;
 b=MdcPXypKXVg7uDcF/8bozx6Wr3M0xfoQfR0Bp2HyscAdOXVPWpVNSB0bzCIUGhFyGXmnQVGpVrjVkztnorDh3NZ477YAj18bAeQ5Faz/v2YYVJgC7Aq0kgXg0CTwpp1jJnKWzm6FFcC5oZx9APHqQnNrIPJ7PV/8uXO8NeZNhyY/umgninep9OOhsrrlqRqUmcmwBPifDsC5Y/b3bZe5v6R5M0cP0lXhnwlfCoM5IYHZh/YPvhAf97qV3z0jKqo4NnaFDLGahZlXwkFFGQ6gbc+Gf/ZPs3Vaj3AUF0fIKLBM4yvu7g4+VDTvpkov2bebO7pG1+VP/4k+GjMA9RIPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOBKUpBIOeZYHOIwV4YWdPIFVIXc1ykcBXhbqcI27GI=;
 b=a+0zv4bBntjoiqVW9HbCbpvXNQRgj/JoZtkfgzNf8UxscYrWylNaPJAD5uV0PGOeJVf9iBqDVSIiogtXtAdD/3pVTfnMDRQvUibh93DncEToDXs5EHPdOwvJ5yhFyUEGNGUANczeBO/Zqw8W84OZtNU+PPZiXys5kGAz0VMeYTZdV+hqhnA/L2+QepZmvWAFccFeRxwJhuqNx0JFXVmbMw46y0G9cqKRWPX4HZ3q29DZQju57ERXuwziLz1hq4nFbGPHSWNbrmMPwapQE+skBCs0Mox9+wI0lXbZVIyzFzrz9KlRmT44X79Awv3OJAJiMwuirtT0lamsbD4bNEdT6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB7175.apcprd06.prod.outlook.com (2603:1096:101:22a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Thu, 7 Aug 2025 14:39:49 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:39:49 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: willy@infradead.org
Subject: [PATCH v2 2/2] drm/i915: remove redundant __GFP_NOWARN
Date: Thu,  7 Aug 2025 22:39:11 +0800
Message-Id: <20250807143919.575439-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143919.575439-1-rongqianfeng@vivo.com>
References: <20250807143919.575439-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 78805613-54f3-42be-a917-08ddd5c042fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w1/jwoMEkhnGeTPLlj+/u972X0qxqFCcS0r2k6dKGNH0NfNj4PxS602jdDGw?=
 =?us-ascii?Q?qiCSdL3iouXGjPmYXgwmtc/7hGrNp/0+zRQYWl7uwYylw5exjDnxCB4lqYqv?=
 =?us-ascii?Q?lzKngCS82T3K950LBUhs5nHwn2TOzxTOxKSuUhJ0tTqebsXZ5UWYcRM/O8y8?=
 =?us-ascii?Q?g9xoxD5mepkQp8DjKWBYbDPPO3udLrqnJ5gemnYecSIfdiYTqr3aTUDMdGRk?=
 =?us-ascii?Q?zn3gH7Y42ws9k8QvV6eeUqPCCna9CsCAhTmeeMh6lnLaZoz4Bpxgq+xP+IcE?=
 =?us-ascii?Q?Tat8KUSkUQARwxMq/Bbtr3lnFIcXNh3TJJGp7hZ0hJu08FUw+CIBYNb9Y4eD?=
 =?us-ascii?Q?ZycrP1ZlqFylRbkoSiIzAQERTy6Rwo+4qyzsdKzSOxDTgny/rV6TwtW567jz?=
 =?us-ascii?Q?NByEXFcoWHNW2J03nl283Li7dBR5lbAGQLAtrQ4jPlkD25jTAuwh7fBwAdP1?=
 =?us-ascii?Q?UY8DjYCNSpWMWoo7O6PsqwwhooRP1xY8QJkUQGYcN6jXQVZVjiJCib9dtRh6?=
 =?us-ascii?Q?Q64gfOYI6CgjvS80OQk1z3A+37GIp/ZXpGX8sl2EaUUh8TMmPXncaiyV5gft?=
 =?us-ascii?Q?IBdAzTARTYaVWLrb+BMa8mWRJwtUMKZmDPo1ARE493ho9Z+sbmN/j5y8mjfj?=
 =?us-ascii?Q?6Tb8zb3/vNr9QX3sg/PNydbvnQ8FOWBMfkX+n6c5QuJ0aSbdDA1TEZ49DGrp?=
 =?us-ascii?Q?omhw5ybMLSc1wGVrvABobjToVbWHPOxHHEpecEi15ukdDH2IX6TKbjCOH2Y4?=
 =?us-ascii?Q?oHhLjgmxPGhJix1Hnohzq2GLBuzeU+4vAQbqk5DHJH1jQJiFQTke2e+S+aW1?=
 =?us-ascii?Q?yx0EIlCDxIdqAFdqZeT7/RASrI7QnoOUgZbTijP+vTWXMmXLW9EOu4yWQnIK?=
 =?us-ascii?Q?YC25eqJt6vbIVU3/8fCFAoIxfjXdUVYU/foXmhWQO/2QPDz0XKFkTIuP1l41?=
 =?us-ascii?Q?Z/nIEavbHIj5MbnB9IA60xBzOZpCYO2sYUMwE8ZKzOj7IZ7q7fU1jlLWfgHJ?=
 =?us-ascii?Q?FYgZtLtPXYlVeihHRWCWBJfsNnpX2bb7xJYWBHCiw2wAnTJ+a3MiqQ+t4X88?=
 =?us-ascii?Q?zbvTty/NXEmbv+que05Mcinbvnx28Er0XyCCe2VcteEwZ/QMt+bTCscR+DGi?=
 =?us-ascii?Q?NHtAq7U76paJ1XbRx6Q1D4TZ1DDGFrXhBdZk61dvZNdjSypPIo17c6zpq2sN?=
 =?us-ascii?Q?drDEn+mt8KcBGjgFpp6zuXererhn03Ia12fITiUCPr5vXrRuDgGgvQzf/+Nh?=
 =?us-ascii?Q?QIJnZCPfkgeNZXYOUXQjpdSK/Q+nWlm89zqlr0JR/YwWrAsHrwUy7VwEjDE4?=
 =?us-ascii?Q?m9vrqXdiG7XpmJFtQ166k4YFOqMSwJaVigdNVLdUB1iOsuYSEtck5RLK5MXk?=
 =?us-ascii?Q?oeixGqXSbvjvGdII+3eI6yB4H6YFEZmv2haiTAsgx6mo5YgPQNrMFE639ZVQ?=
 =?us-ascii?Q?zcuRu0Khb0nREL3be95L2y00Lk702So1PXz+tsDUMZXpFGnnQwUT7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vO3+cLrJR4ltvmARoLigsyyVX70DkGrGhGs2tZPudcXqQAHouqre9eB7567h?=
 =?us-ascii?Q?i1ACtoMCJbOq+pk0UiaVRfTNIztyWxe6AvmfcV+gAjOeBCeYKT6bIggPy1i4?=
 =?us-ascii?Q?yNorpH7MpUV7HKXDcSlkZLFlLx3ARr97zklg5AGvplmd/4kZSTHgT+y7G1TW?=
 =?us-ascii?Q?N+diiOP8lWJFbfg0yns8LSuFdimidOYd3P7NWi9xatqMYxnw48v5bvftiEkS?=
 =?us-ascii?Q?BM3MkjNbyojrJvxJ5jkOjzhnXIu9eV5VtkifU606ZCVwKx6T5t8V9/Xfp6Qa?=
 =?us-ascii?Q?J5v9K0rp0QjolA0Esxt9qTXLoDti3aAXslPsEJ8rB+/HnYUWeTYAZNlii+ui?=
 =?us-ascii?Q?gQYlTSVQmLx8Sugt2BVOAoyqtpegB2uNw+sCRS3lVF4qjahgpSNpinLYfMes?=
 =?us-ascii?Q?lS3UAD0RuwaJXovckGeCt53tVVJucEbmFck0Fr1Tc0IOk8XoTTNXC2R1fBDm?=
 =?us-ascii?Q?+vuJYvlWX3SpzWXR7LGKlutnjENd3I5smNj0GAHaSh67r0qEBZBmPn3MQAwU?=
 =?us-ascii?Q?x9atLoDzxkfHkOM1fpsnGvtF4ee/GQ5fSnGWmc6xQIohHWk6IA5KQDKenuok?=
 =?us-ascii?Q?/dPg5yFCV3UypRxR9b3m9aNV/0Ezte1lQDPEmO+p3xB3eW0eigXpkG54r0oF?=
 =?us-ascii?Q?B5EhRHJBEE3hBaUAYNc8E8/ELLBEEbE2ou+GnH+K8GB7bBqIpY67xFoolexh?=
 =?us-ascii?Q?hkRckIKpx3wTG+ei9wJMcBJLvcBjOb+xlvmUtacFhaW1495CEV7Jw7pRylh+?=
 =?us-ascii?Q?Mcl+m4bkUn8YtlXmfdgTQiSVkOfpIRZ7eaHDRqIRztKjkQQ7c5A0BgmZnjg1?=
 =?us-ascii?Q?9Sip7Gbgz5ybtNhXzleDBxAsBMtKcqTmm3CPs/WwjfOXswVdNdcTn2yPYf+6?=
 =?us-ascii?Q?7ZL5FlWI4/OQyP4tQbbrogEotxTrqCXWy8OU570NHeWWUvtECRwnvhS9rLhf?=
 =?us-ascii?Q?BYUoLjeiy7nRyFE9KQ5altwArP4cNTNEJ1aYKT0HBAs8XV9B3r08cq35erlC?=
 =?us-ascii?Q?/rVdf7uUlp6RcR66fRc67jEo/ZJFsbWrZbs2rpoyP3lxe/YUTPH4bvB9vHCe?=
 =?us-ascii?Q?ZSjmEwJMX5egKPS1CQ02piqt2igqs1pGCsWiczaGJurccmcQCKDkVT117kr3?=
 =?us-ascii?Q?WZ5Er6ge5X6WckzJcotjVgh4OUdmZWqc7pwlbd11P00MJ6G95bzoMcSPCD0h?=
 =?us-ascii?Q?0/s3VdAYs5ZhNXOB3NOWTZ6vU1qV3dz54XKaz4hf7sN0uozOpnxwv9HUljur?=
 =?us-ascii?Q?Uouf/3/n+OXqXulMNhKm8C+noLrCQB7aBaP2XYSpDym0XzsHblyK/KlFmzMC?=
 =?us-ascii?Q?sU+t0KgWOKOYSIRb4vy1tDfogBxljX2WkuU1RePQWG6REA0Uo3ZyU5nl06ZM?=
 =?us-ascii?Q?+awL3ddjkCqtQ+5hdM5fGwtMrf3+8YNvvV6J+OF0fNLiHwy+r3aumXt1ltug?=
 =?us-ascii?Q?24eIiImbxGaPbo36z+lilHs1AaNu0cE7btd0fYMKpW0KqOHw9ra5XMD+5qgt?=
 =?us-ascii?Q?vh6PuSbgXhErHaNr9vNJEuZQ9ZpThf3D504hpFLHjuEQltwc7iKUUshrA2Gz?=
 =?us-ascii?Q?xyCXGoLWvQ5Kf6KGYryI9GVSIYd3NsMeVK+mqwRM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78805613-54f3-42be-a917-08ddd5c042fe
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:39:49.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3YV5bPdmoDB7CI5a7p9CsOckYS37RsDLbDT6PiE4+Kj++QQS8ld5wxzNj7fGUqQwkl8Q8ZR1xjod7uvsD5g7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7175

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
__GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c | 4 ++--
 drivers/gpu/drm/i915/i915_active.c               | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 8d4bb95f8424..22432912db2e 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -220,7 +220,7 @@ static void heartbeat(struct work_struct *wrk)
 		goto out;
 	}
 
-	rq = heartbeat_create(ce, GFP_NOWAIT | __GFP_NOWARN);
+	rq = heartbeat_create(ce, GFP_NOWAIT);
 	if (IS_ERR(rq))
 		goto unlock;
 
@@ -282,7 +282,7 @@ static int __intel_engine_pulse(struct intel_engine_cs *engine)
 	GEM_BUG_ON(!intel_engine_has_preemption(engine));
 	GEM_BUG_ON(!intel_engine_pm_is_awake(engine));
 
-	rq = heartbeat_create(ce, GFP_NOWAIT | __GFP_NOWARN);
+	rq = heartbeat_create(ce, GFP_NOWAIT);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 0dbc4e289300..402043cd84d5 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -727,7 +727,7 @@ int i915_request_await_active(struct i915_request *rq,
 static int sw_await_fence(void *arg, struct dma_fence *fence)
 {
 	return i915_sw_fence_await_dma_fence(arg, fence, 0,
-					     GFP_NOWAIT | __GFP_NOWARN);
+					     GFP_NOWAIT);
 }
 
 int i915_sw_fence_await_active(struct i915_sw_fence *fence,
-- 
2.34.1



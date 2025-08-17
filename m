Return-Path: <linux-kernel+bounces-772495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF0B29362
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D8A7A2654
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE02980B3;
	Sun, 17 Aug 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dBE1p6FA"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013036.outbound.protection.outlook.com [40.107.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DD243367
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439006; cv=fail; b=OycJjmRQHlKNDoBM9STsy5lf3ilnyvnoZ8Il5D8bxucZ579X+qMYiyKG36rRaYdzdlfMgEzaMdE7SuCpXf+ckOxKMHzjIqaad9PampOAX+J7gPZKAQBjQJVzw1z+K9la/4oBnJ4Y/mXR4rBrOsHZficQzMKFKfQ5vwbJyZjwjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439006; c=relaxed/simple;
	bh=kMyjFUadO7puN2DsazLprVPZUvymbyfAFxzJIOiVpr0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pTMflJIa0xk6JIXtMZVU7xLmJHu03JlGe7SR8PEUNMw0GKcCnczCmPe9OGo5aZFXERm1pS5NlrbJDtwCAM8dRhJXaPhXXcy/k9GyOL9lOpHAw0lkatXtp/VB2ONlMnRZdzCz+kgWAtIm+Nt3USpFsPGuwpv1AV5ouMj95+Uy3sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dBE1p6FA; arc=fail smtp.client-ip=40.107.44.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsTJRlYoar3VTxC2sy01vpcQXSLnu8qSqPlfoTso3xHPXKQjMZDh/jVuWUlICLyViLjw8qeCm+Qd60IaFx2WAcDW8XUJVgHWahP07kcQ9FtleaICX0SuWs6c5nufa/4bb7EdULI8VIjjs/cFA1dxW5bnRJLk7+aY7iDDsxV4aGtnC3MR8KXPDGRkI7i0MPMpqpuEfm7bhnxAjFKo6lGGCUw2yow6ZNE7Sdqmx3XGNFpkBCYIymZ0u+Y+mp0ZYwRyNhpOeq55SPvRLPX8lO19HJvML4NVmajIWfZ5vnV/n8f/DynTPuSkScwO9oEOzf9TdQMO/HFi4b+9yB7qBiflJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c7s240HmoW4JMMe9tMRozUpzRLFaIGVnw8pTXGy78I=;
 b=r3s2Nlx2zKrrWGWkj+6Y8TRMMUhxd0ZG1psX57LVPLM9n96O1Peu+TORJBkH8Ih8LPMnCjG81YseQHohRODkUDjkX67+MMfFz9CiM5j2pZXZx4G33D+1lZEuXx6m+bfz6cGtX8TVKrdlLJ6NuFfKXb3RkTa4eLMSTnptafnc2Kr45RHzeZFPukIHbA7B3Y9QBT0NsuRGeiPDoS8a4EiuknmSsvMKnCDjBoSMR35XHVDm1Z9d6b7lQLgSlO5UjqiTPX+bObGhL8e96F/4jzmQtZYwCV5TYo39bDicNODd5deyVDgWMx/UhxWBi5CZkayDQDKP6BqRNYi1w5w87I5Inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c7s240HmoW4JMMe9tMRozUpzRLFaIGVnw8pTXGy78I=;
 b=dBE1p6FAq5KSF7qkVlLFow2xNj4kgL6npnFFqsmknSRb1EoVvfKJzrETsSZa+QYa/55dlhPnBjEPyhKJpiJRTWOTQ4J2//HHUTqAes9gGJfKZV6s1iwcMziHFhce/LjoIZhHspr2B9J3FcGDVHufVdbpTLQI/qJ8P1TzgAbmADpvmNEJ+kNNioy/FQDeaQFHrimr7Bp1vnQbTpRJGczn6ih65Xj6rOXPh13sdTRTFApgM+GamF8bFIOAiwKNa76HX53jYCCcNlEoli0ZsDbvJ/+QYlhEH1hUWEsINg5bevc9MGch+Ron9Nj7C4FDJBxD1KHa3EW3iIkXiexWrGEO7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE1PPF7CF8E8E0B.apcprd06.prod.outlook.com (2603:1096:108:1::41f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Sun, 17 Aug
 2025 13:56:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 13:56:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] futex: Remove redundant null checks for kvfree()
Date: Sun, 17 Aug 2025 21:56:26 +0800
Message-Id: <20250817135626.162124-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0029.apcprd06.prod.outlook.com
 (2603:1096:404:2e::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE1PPF7CF8E8E0B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f01a078-ef56-4195-7b0d-08dddd95e265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+SLEKjTHC2pu2lwMDOSMEkcj1SRFlGdEzNLv20nIAZYs2cg9XCOC6gGHt0l?=
 =?us-ascii?Q?v8v0bKqbUYq5WrYHHZGiQD22s8Zm4goPpdw6aIf8ZNMl7BD4ZQ8IJ1hK2oSr?=
 =?us-ascii?Q?oAccPnSz0pB8Rf+ozavqohTW1m/n/FyiRCqx4mCTB1Qt6jZvdtAnpP4DwxjW?=
 =?us-ascii?Q?W+Dy4Ue4GjFBvgfNmPheRV4rsZOajVHbJcCW7IqFOnGWFnMhAboaPOr+dd1w?=
 =?us-ascii?Q?80DP+KSoIWSWQrjKvpRohcIl4/E8/BUg+3tRcqXVV63ec3nIGsXqdo7NUEML?=
 =?us-ascii?Q?HajCF915W/wAVx6HVEz2uIoiwWzSwJw4EopmVVqhNFGdqqQG+9cjWEw42HNd?=
 =?us-ascii?Q?hL6tuV049Xd5OmhoOo1bSbdpKVmBOWfQZ4N9YlrHqYTiWBdRsWRCEfhlGFSS?=
 =?us-ascii?Q?jFF2YR6RBmckNjAR//SaF6gNXGnslIFteZhWhdhget8+oUwAJE0DIxtcXFN+?=
 =?us-ascii?Q?iL3bUVg7XXW/60CjChKf9azUUVKkNf6OPPMmnbxgh6F/BScfjs2327sJFbA9?=
 =?us-ascii?Q?o81yKW/UahQQK/XGOS0AYFufkBhiAK4UtlonC9wL1rkevGA5nyzkkOX+qO2D?=
 =?us-ascii?Q?CRJtVHDRZjic0BCd57Wh5BVxp4jH/yXJbuiVk94U5W7Kp3PINXCvQDcZsY2H?=
 =?us-ascii?Q?3PYVdA3z6XMzxMzX/i58290MUi6nDllyTYOUFtYI0k+JjSoPY2ax3XI6Hb0/?=
 =?us-ascii?Q?UZ/aM0UW2iTOH5iRLUvdhfzF/5IZY9LcgwfBW0E7H061ObJkCUEuZRLRjKDN?=
 =?us-ascii?Q?QHhsf8hTHu4CLv1TiaM0HnhaRIfNp6OUNLBmJMgmQemx+ipIkQyPYLtF4AtB?=
 =?us-ascii?Q?KRy7gMN+7SYAPYjc4tLIFtPeOPqgKGJl131piT5lu9lnPZn3hJUpzUEj2Rec?=
 =?us-ascii?Q?q1urtBOhjsUu1YSle30k0P0oYu+XE9Auz2liDZgMophb/v/50SMeZVs3EJ+G?=
 =?us-ascii?Q?VqLx3c6FM237XQ/+rLVEtEnphT1F3+tz2w2zrcSzOQvTWkpYXWAHStqokAiT?=
 =?us-ascii?Q?3F0mlup3gMMa4iw9PHvfGTu8BqzazZzdCk33LEjbC204+eCQhtbAVjxJB2kb?=
 =?us-ascii?Q?xDtCCcLtnd979UNCGGW5zMmKgNOMQLkoGIoiUlby02I11NjPMWtG+UV00toV?=
 =?us-ascii?Q?/h+5hgW90jGuW0aCHJrabxYDm/JpHgjynO5zc3WU24tqeeV/vYdJ6K15SZIw?=
 =?us-ascii?Q?oYd9ZAO/sF/zhGpEvkXptHsnNxSoy9n6WDiZBqXBjROsh+8UfmcSzeKls1w3?=
 =?us-ascii?Q?pD5r7r6ZqhCLCFOiyO9lwE9aZDUmaQsGkQaHd6lTOEPM7myybU5IBZr3fI1f?=
 =?us-ascii?Q?sJafJEuQUu8vKePl+rTmyjoUBs1mIbSa1d9ME2CQIQBhN7NTpvVKSBL38NaI?=
 =?us-ascii?Q?7Hh65nfpv6zIuJpHVoWHSHn+w8A2nIZpkKJUo42db+rVsLnun5EQ7TVLbJfw?=
 =?us-ascii?Q?T0PMRMYevUIAsoIj7wWJaVBI/4MSgXIcBxFQhyVBRtqsmS4btrj++g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwUK7y6Xeswk9ujKLJZso6Rt6e/KUs6KUkw53hf9k+TD0rW6SETIIQy4EwXY?=
 =?us-ascii?Q?eks6ep3XuAo8dEyXVV3azDLYy1e/Xm8SOQuP20BBfXqO7oBJ7dr0IhXZI6fX?=
 =?us-ascii?Q?Bs8z8cZtobYQeQCJoCER1L8eVQRlt+E3OcU0wFPE0iIMw2EzIidRBRiwd7EB?=
 =?us-ascii?Q?cY0fG/kdwrE4rfgYsWPnsJarXvRpz8VUqnNkV430wwRGW6R/oTVpF2Gb3znH?=
 =?us-ascii?Q?0euqsVSikLKElfn8/5j37dc/gD1S2d4M1oFR3HM8omgOABLsesTjOW02885b?=
 =?us-ascii?Q?DbnvZwDEdGrUE7fh+NXok+42QcASs9+d/omsEqYzTo/b2M/Yb8v/Oiicg/wU?=
 =?us-ascii?Q?l+ksLCRinVHw/1K2+6Y8SzOKpfWTY2VzqAQevOrWvundzSoOtExJvlAEYXAm?=
 =?us-ascii?Q?1WurIY5rCADfFDdRzD6bEi0ZnBfHhQhPiyV/q6p8MB2xfTX9p7BKUofGb3F4?=
 =?us-ascii?Q?mYfaYW7CB/kgusVZjkmfQcgCWAbozfscIGnQ6x/cVim3qd43uxElgjZmUPkj?=
 =?us-ascii?Q?99qN0JATFdDW33rGXSZ5YJzNDlE1ngtIeoMCe/9aWjq5TVEdV9mDV3h9rU6i?=
 =?us-ascii?Q?2F19+ClOQ1gzlBjaF5Bzu9MB5jdz/NaOfp8ziCMwJisGJIejKVc4t/u0VIY+?=
 =?us-ascii?Q?b6ETZjd4QJsFnn1fa2AsoXeJSmWOLRqam+Vb3vedF6nh9wMLSnMg2jAc2PK8?=
 =?us-ascii?Q?gpMF4m+HM5n3ne1dgspWuzh27TfQ3mnav1/htWbuEitX28oZ1KCixp006NC9?=
 =?us-ascii?Q?LIQPsbxDiPl4/Q08E0wmM8mQmp5uUWN78Dj0RNBnuE3rcilNlz2KahRbe5ls?=
 =?us-ascii?Q?j2/FaIRkY4ep/2IgXiftGJE8fdLZfrkVg7fu6Qt/Nvh53E6I+y7O9Xx3TiI4?=
 =?us-ascii?Q?OvyJsVuB0FJtpcq4PAoNx9svgEez+KJcrw92i2Sc66LZNvxW6WBTwlc7hGRg?=
 =?us-ascii?Q?bhiH+PMXLf3ifwY8U+rgKVu3lvuhp+0S9MqzVPVlFPqkl5ruwNkXsa5ScNPa?=
 =?us-ascii?Q?EGw+hbwvpKUk67AfOl6ZHWaw0YRu5Ay5+hRFPvKJJMp2n4NU73LE4xZU6qwu?=
 =?us-ascii?Q?USzR5sr9B0Nkx+RWngKNumy5kC7vOnnhaGwjupbzhKAO7VgcMx4+Xl0SgIvo?=
 =?us-ascii?Q?hOnK9UPRnfjJ4eiwt0uNtDKQ/IHP3VWgLO/L4DPlRCjEb+rQ7sN5hjjhX3PZ?=
 =?us-ascii?Q?HGMh8yKqy4fMQExJ/Wk8iD6ScJSvHDAw9ogDET17oUUykieW1EcejsmgMZGT?=
 =?us-ascii?Q?hY2OpobO2jbgSLUV6lzOwQxc6JDE01xgkYP65C76rBivw/lFZg+rntd7KIWA?=
 =?us-ascii?Q?FO1fLKUlO0hFi5QMfH6H4odqBN8kDpbrDs+v8hE2i70FbohyTungZoAomiRl?=
 =?us-ascii?Q?B2fYxBSujyw28QwZcXZLv38e2Qs/lPvLAOmucWdyQVJfGLUi15NXQlSTSeAe?=
 =?us-ascii?Q?YNQEm86axRyXzM0e9DeJUAsgHg6ZN6b3Bpgzd7hYeFdNMawM4u7XSXSEjZka?=
 =?us-ascii?Q?oeSoNAtum/PTU/bI/VH6WwUTIA3/2gRYa8snMdm//sOySia8DMnZ0h/Fbvtn?=
 =?us-ascii?Q?k87QHELE6iVC1TIxfVB2hX5uys/XM0IsZ14Pr0lX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f01a078-ef56-4195-7b0d-08dddd95e265
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 13:56:37.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxskzqtqJ4EmrnQzNis+Eq6AyScYIxWJkHs7Ap1jn/DzSMW+lJ5EoT5quMFaIWNFyDRakrO0wuhmrtpl29JA2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF7CF8E8E0B

Remove temporary variable and conditional check in futex_hash_free(),
directly freeing mm->futex_phash with kvfree() which safely handles
NULL pointers.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/futex/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c..ea96795aa4a7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1733,13 +1733,9 @@ int futex_mm_init(struct mm_struct *mm)
 
 void futex_hash_free(struct mm_struct *mm)
 {
-	struct futex_private_hash *fph;
-
 	free_percpu(mm->futex_ref);
 	kvfree(mm->futex_phash_new);
-	fph = rcu_dereference_raw(mm->futex_phash);
-	if (fph)
-		kvfree(fph);
+	kvfree(rcu_dereference_raw(mm->futex_phash));
 }
 
 static bool futex_pivot_pending(struct mm_struct *mm)
-- 
2.34.1



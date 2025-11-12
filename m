Return-Path: <linux-kernel+bounces-896893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB14C51713
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE818875DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912DB2FF17F;
	Wed, 12 Nov 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JN0eWofl"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF22FF659;
	Wed, 12 Nov 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940714; cv=fail; b=g8Sp8G3dCE2Fd8cqp+ULDrqDblPTH0mmEGZGkF8DJKOrZGTN3jNKot3ySLGr2TIAN4vKN7ZMxGG1Pjra414zIG6M8X/dgOsBdzP4KEgmWuRXILHK/FF65r2YHFhLDdDY+cT4FS/inBiRA08NQcEqu45IIiFJ4tFhqxhkTdquboA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940714; c=relaxed/simple;
	bh=r1Uhon2aTyj1FGJK+wCDkf87+eTqKTZSMJ3GWmUxtTg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f+sDGiYMWC2qUVJOUkZ2F31ifnVnSGUv2Ev3RYurq+Bz+aZYvmKvU1/BcxiFsR7ESPQen5rwWE5cOf6GKKO6BEEx2a7thkjpGEm/A0YGMbX0yrAixocQ1V2LoLi9CxoziyvyqPKEmgqssvRLaKESn1JfoRNOPAHwgEGi1nj9cDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JN0eWofl; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd8Yoypz16kPdWuaYzmOoe7n0kyabDRUhZ+JVsEUwnOqxY93HWsLK1hyEv87h28tV3iSfX0ALlF4GBI8mYdcklUYpa2HnYg/KBHCWOVTimp5WgcxXkkJ8rA9VnfcWM/2acVEIXYHLso9ML2H8jJCnh9QgN98TSNAu41cVgozFyRC9TleIMJbXunwuHwxmAzSz0VJSvwswbk+a2hxyGaiXOuBsTsMKkxcN8zRVz+dGOHUUXg3gjBObi7mo4OUjv5jYfu0P9RrAqmvMuVbIqq8T8WSQaDIQRGWQvCdQWWyDGN2aPVSS0/mdrILK3Alr/x3lDXX7RVTpzkmi8JugG9MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuW5LM2hT68L6/aTQRhVW4RU+z/orBkZXjpdXPEghdo=;
 b=v+mIOWmEmlcX07NaZOzQPustO48Ai9gTbJHweq5Vo1G9FfDd9IYHp5zA2+jndZRfQue0SKuQX9rtOymXzxgR74sZbSCDjKBKN0FISDHenxPnpffTjGgLyyJO/ldZLNNVZoDWudvAF1nTLKOP+VvkUVhT86WXVkVrjHGp3ozOqHRH9vWVw0Xn7OGFdhHBDXdERhXSyV1BE8G8uiaD60SE3gorXoJDA7I3lLXarxr+S7wZpu97zKsfKmjN3GElCflioL+LsQActvNf16rCngzvm525J5XeNDRvy1rUZr15nMopPpWr03P8u9/9cGnJIhbP1AIDEDK4TLvaVXihzwKYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuW5LM2hT68L6/aTQRhVW4RU+z/orBkZXjpdXPEghdo=;
 b=JN0eWoflPCDHpPMUiwZmTK/LZ2dAdla1ZNFhDHKBhsz9qSPwQvlj4T+SDukXcYRcpbA2kxTCquzSL2XGG+YQJlKJ01b73MdwccQbx4Bgqc2zBX5WI33Cmm/MtnG2lF5Mah4APzxwlCHcssHLKoqRLBopnonBiFV6nmwRo2RXkjACYVZcXkgDjZDI8nJPvxh8zt/CScwDnaFyPgHBpvpaIGJ4tubxP4vMrCXbXmwhS+CSxqUZqFU7WM3YJhCOHC2s3y5qWqNUZ788r7nZZYsiOXhJ3QhPJRRE1VCzp8EuqNgDjQHGTKWUgKqVNBwQdH4KcEDKHn+KWdFQNZZyFFxLnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 09:45:09 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:45:09 +0000
From: Colin Ian King <coking@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] liveupdate: luo_session: Fix spelling mistake "incompatibale" -> "incompatible"
Date: Wed, 12 Nov 2025 09:45:06 +0000
Message-ID: <20251112094506.11356-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7db2a4-3487-4c92-4fe9-08de21d02af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkCIZks1wlgsYzSODe4mn8/l9kMgjFSeQSYNJ9auw5rdPSikT9SulpJCpPjT?=
 =?us-ascii?Q?K5dXbEh3EzH67gZcJ346jALChIlVXPb8QmcgrkdOdbQ+K0G/O2e7DXsetCHO?=
 =?us-ascii?Q?3Kba6vIWLn6ipEtSaYP6xgQ9nMmmnzLBTw12W0GzaEIbDqS1NdTzzoqo7OHx?=
 =?us-ascii?Q?gsdaLhDl9j+DD2pEoV72XTC69sMC7vPS7aZe8HgCHk0O0Rqpxo066VHd2SsU?=
 =?us-ascii?Q?eBpBDmjbqhLdpnmNTLxM0XU/TfelNfoDwikhf0EjGJC8zQvBDpgMAIf+9BUg?=
 =?us-ascii?Q?9Pl29sJ0icQzIvrP1VCLFTuYULuSE40arStID6Z4JSW+or7rbs+hHE25qF8+?=
 =?us-ascii?Q?wFhGUpNrY+0eas1QXwBf1IMsU011z2n5j1nEzNWHOeHhPz2l9YVI2Ycwksb9?=
 =?us-ascii?Q?o/H9CgflBMezeAae4SifPpADEsFRsmGX40GSM8dBve03DAdq4KiTMoeAAEmP?=
 =?us-ascii?Q?FmkzC+6ZCtKeXajm8eiwm2DyMW5hpLhztNCOha4E56d2pg9eTbC3rbp43hYK?=
 =?us-ascii?Q?A8AMnKanmVC3iBnPdyO0wQ7LEsG1gINAAhgSEMGeP5bU887xpEA4HTFinWXj?=
 =?us-ascii?Q?OZiMXCoVysHu+NlBTYLxicvvs+yA2H+XLnija+RkFZRFeJPDFYBZq9yGrWJm?=
 =?us-ascii?Q?Rp5Cehe0FovY8r8AFaN+VzmvLJa34FSBegpnVkYLOyBunt5Vedss2Mm/7UYh?=
 =?us-ascii?Q?oFlBDGZiBfQcpkhqDxj5l8YhKnCmYJ3WYiugCeHPODzdNv6hJ++eChdfAGGO?=
 =?us-ascii?Q?EjaLwcVSRJ4o3xKAvEJAeoMtaKiJnUp5X4HOE+kGXZ3Tezw5Bza6r004jC7A?=
 =?us-ascii?Q?0JclKsZ/6+Tx98jjxmbGmxNJOQqaIS7A/xOTEnSDjevRjm78cnxLgMIIZYFk?=
 =?us-ascii?Q?jawPsvXYBOyJevwrk+yQdpl4nQNEduOUvl4sdWledXljZHTKdSUUFbPK4a74?=
 =?us-ascii?Q?qtB6Wg9JSPvpeC3ZujJJF4BfyFI8AJDky2XEn6INpu+z9V1vqYNoDJ2SIqyB?=
 =?us-ascii?Q?Es7rU5QQUZW/Areuqcv4iTF/z4D7nR8UkCGN9AD/fnjo9c4rE4JGZjgxTUQq?=
 =?us-ascii?Q?A5iusIfdCvaSY3DMDwxOvWltdjjHy4hNFJYgTm/Cz54p58KZPOomUil9Tp2I?=
 =?us-ascii?Q?/pOziFhIwbnHBzI3nNVeDdFzjWFUUyYanZGhZGTdDe19ZMngDCGshbASZLOY?=
 =?us-ascii?Q?v6LXeCQWzW0eBgTW97gK+v5iFL4VSH4vFmTErQkrnHCKNZXA2T0H2Cvkh2bP?=
 =?us-ascii?Q?9L1BNxfxnXOAr7jajO/JBy27ie/iEdj24vee3bVb9feJ+9Co3qHNEDV+Rdjr?=
 =?us-ascii?Q?8zGbLPmHYOK4vxQ10n5sakL/5FvrtWdo4OZ8AgvUw4I2QnQ5QkwKQbtGL8Db?=
 =?us-ascii?Q?S0phUT/ktv6qkDyJscAW8hOANt36iKdjYIlOvCXotr68TI6C0wPDHQugrksJ?=
 =?us-ascii?Q?DBq0/B8bBca2dM0SisAiSXbQAGwOO/pn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkQOvDSAy3QNGUDHNJeNv2KoPMEpQQGY4Vbi2T3gMlyX8bI9rqMf/yxhUw7i?=
 =?us-ascii?Q?ngHixCYnq5jdiVWcSBFKN9o2UP+qaPEJR/zDl1l6glACPFiIkEFKR7+kIfyZ?=
 =?us-ascii?Q?P865uOXaOMshkY/JfP7RFtgWsFRdT/XJ7vk4TQoRcXMq0lWxq/FXmdbGO0FX?=
 =?us-ascii?Q?xu+pHKtPaYaaGVPaKsu86ysCtE8IQ+CvAXmRsTbQbF18o/atKCHNCbhEqY1s?=
 =?us-ascii?Q?UTUDAP7el8aJ6crOf4f7VPKYmntCJ8qzMJ4Ai56gnD7A/10Oq1kFB2kvdp1m?=
 =?us-ascii?Q?+WhsS6SExJkFB45cChSXZrmWMzwa7EUWOO2zBr5gr4Tsk3t137u5I/y5HMf6?=
 =?us-ascii?Q?1rtvI2cj4Y/4hzonYiCEnOaE/lVbLB05/yEO4/w2jROlaA9HM+ssXHEifn7a?=
 =?us-ascii?Q?2pctxX+1TdWjykyDThJD1ftYAUiTkXlPqfEWRwCwOQTTK8NlgGvmZQ4pv6nE?=
 =?us-ascii?Q?GpppHB0cHDWUhK7G00uFuXJ4+6mKMlXQ1Kv0gxRSHlydTjMQgdm382LXem53?=
 =?us-ascii?Q?z2y6LJuWkFWGxtQxGUPmS7zXd6MosD3kyd9uv2WwQ5s/OpSRWTSEOYg66FKT?=
 =?us-ascii?Q?0I6gZ04oKAM1LsHzEW/bjZr3nNz07d5Q54H2IM0oyyG6S1w2fBH3ZsR3y/c/?=
 =?us-ascii?Q?jCF6PVXhQR4fEHrNga/w50wtqQyYUk36VJw43+0WOIJul+n0ZwiIZeR6fXBQ?=
 =?us-ascii?Q?/PnmiTfGcjphtUqoCA3JGW58IJOPL4n74WMl8ztTgM0q4n0MEg93NIC3YoP/?=
 =?us-ascii?Q?psK8yBQ1Kuj+cC7L0Tj7Eair7idh72on71hZb8MEYc30I5ZpGAPEa8UUQWxw?=
 =?us-ascii?Q?KlY6Pj50s5LwCqLyw91fLPs9iWpFqnfKkwq/KgkXKICAyuIfk8/mca+s0dHy?=
 =?us-ascii?Q?B+TIPZiMtNZzagydqkQJ8hTv0INad1uJsBw7L2lebt+207LQBLCOT916c8m8?=
 =?us-ascii?Q?Qj7wpOyuOSrQVE+NaCI93HPgshWlxui/TQIvXDUWVNa6HteARQ/Khk5i3t4Z?=
 =?us-ascii?Q?7P0zd9OhHvoORsfvKJMeYPn869+L+stU796YvJo5kGT9C1QGhQqKR2tIQsU7?=
 =?us-ascii?Q?OeSIj/yQ0TeHbMZE0s0p1Jnk67awNpQmofHNvOwFXkKEfHQyn0Q5IywFD+LK?=
 =?us-ascii?Q?y5XfQY3KpqjBwcI3q46LSOBpBJ5h00bzwQRw/bNb+zBG+u25YyBT/uwvAbk7?=
 =?us-ascii?Q?ezfDOulGVqLr0s5CqQ6rYRt8WRHrP10x0hr1mHtbqwV27KdGwFdrriVsgeQ6?=
 =?us-ascii?Q?3CiPcRqq3Q1CoVIypCzzjcarNHU2wHRbvyVp2+4bIj6Gxn03nLHbHPFAOKic?=
 =?us-ascii?Q?byG9e1VQVN+HAno5PTJcvot2FC9PFQ5Ynkjcln0BoYh0HO+h3ztAlmnxGyKc?=
 =?us-ascii?Q?y0jQSPaqDPv2PBwhBj2B1DGcfhS/9+/fVZpb4wROhJQGM2ZTYFB7u+v/NzFw?=
 =?us-ascii?Q?pLKYtTrJFYipEMhFXI7tp+mRHFQPL1SBU00iPBmnrS4m01hfXV+7kV0ja/54?=
 =?us-ascii?Q?84ywG2aJIOdeRG1x8awnTBx82VazZBYw/0u6T4tKXJvjRNvmIWh/4p+70sxl?=
 =?us-ascii?Q?+e2D9B4vXj2ddMkj6TQVt6rNJkH66pDzo7HuMBCA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7db2a4-3487-4c92-4fe9-08de21d02af0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:45:09.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSvRmmdzvSgzlg7+dRcZtetwMgUA8IuNNUp2kq2sMDIw1AY3tZaGE9SzzPQxU0iVeDa7yTedQVNyrL4JbwMFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 kernel/liveupdate/luo_session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index ec526de83987..4924c091c08d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -471,7 +471,7 @@ int __init luo_session_setup_incoming(void *fdt_in)
 	err = fdt_node_check_compatible(fdt_in, offset,
 					LUO_FDT_SESSION_COMPATIBLE);
 	if (err) {
-		pr_err("Session node incompatibale [%s]\n",
+		pr_err("Session node incompatible [%s]\n",
 		       LUO_FDT_SESSION_COMPATIBLE);
 		return -EINVAL;
 	}
-- 
2.51.0



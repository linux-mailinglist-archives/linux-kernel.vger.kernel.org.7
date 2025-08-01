Return-Path: <linux-kernel+bounces-752846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5807B17B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C6A80C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144A18991E;
	Fri,  1 Aug 2025 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QiWSy/Ui"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012006.outbound.protection.outlook.com [52.101.126.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D692C9A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754020765; cv=fail; b=QLIBoDAEV02ooXbSjSuybxCK9lMZfEWrbyvOYJ+JRehvnLitMTvFHHSog8s8C7EyyWar5nhalVZ9vGnU/se9o9sVlDGyxPxmIZME7AkapZNCuJThTbEEQvELNbx68p7Qk5T1FjKiJdaHvzg8ABa68DrwqX+fHCxuwn4IIYiPzhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754020765; c=relaxed/simple;
	bh=paSgtB1kpxMGUH1eili7YlTzCcGfIJaChX64OLgLqfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T+Adj7YUl8uzEt4NJpfHtikKH43vyqC55U1pg569OAuVXDw/08zYg+Fazv5cI593ccRyGgq9z27TbWLXChW2b5vMP22AL2F/t33dqv4egnJXmFpHcNa+E7FchhBPuCa9SlyRZc71W+/2aG4yZ7mG4HeKqqSUd3kkwO+ELxS+UPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QiWSy/Ui; arc=fail smtp.client-ip=52.101.126.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQx8SZ5rX8y71rzGBGEv58SxyreRrFNvifUslK6gBRrStil/wDa6ZwAZZ+IpLGDx/riHyDWjHc9rLrFYkRogxNaHSqSp7D1ZHfFOJGORKYAC4gfEkFM6GetZlbJmrSrjdX8qXiTHMIItzG7DbXLF1Zz4w7u6a5Fbx3s8jI/FtbtHhW643/2qE1ucFuUR5WZZuP96eL2XANR8oGqLSo1M8K2rwm6NuAOFUuqAV+ecx8Yi++zu2ZtPFfBtpdHLInpIcYxGoG4tgVhpohGgqgWfcKMBOvEhTqWgcnbIB9tV5kiNfsOBR5/lzt0DlRwxmqtVv9Wx2NVqnZJTs0DiLZZUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DknHghObVEPfhfiIllmJ3CT7JxHFEjLtUXVVF53QHFQ=;
 b=yFj5jyeCZpfcI0Zdt5zWXioXIW5GzpZii1kS75PpJk98XzLlgCMhL80SIzZJjWucC5C29IJi5UHkvK698dnkKay6px2tupUDZMlw1ylWXyxsUwu5OLl3MdNkZEt2gghJOrYa9uYifxzs83VaSVx1GEZyD097UmzOABWYCmaH9+Q4MssNtx/zp2F8aqc/Vog3DpjBDHYZ5AnrKcJKi5NGSIGgVvRu/6Y0sfn/Xkvz6kd70GgqRlU9FxiTvNPH0/uq8Dd6ux7r4cz2aK5FI4E2GTd8q5hkehUsxa4A1YR5JQi9CSBdQcjX3Dh69QK/ivrs/qEmlJWP7rmy+/u4jya0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DknHghObVEPfhfiIllmJ3CT7JxHFEjLtUXVVF53QHFQ=;
 b=QiWSy/Uijkjx9+xuYMI1Yusu6WHOEpmJAUFgRP7tW43TZr/1dubZtF+HqFerBTW+2SnOMQacHgs7RRjsVr2JvmXP9huIog4ixl0d0S4InoPEf7Zlh0PGlYu4jUx1WWL2khXuXC/xkYXX9TQbnynnBtyniihq1r8F68obTJhocN3TnF5Fe7ED+KKKtIRgwjwH8JAnbNn6/Ra66+QG7pMXB/NWWYjVGFEDmmi7re0zx9X0NTZNCu3N4LAa+ppmEnQ6xhPbzznq7g7+VmwE/iE8JAQmaZckh4pqhfnWBIRs2xbzO309fsLI3/bHZFg2xK9aFd857BxAfSsLp/gYHceG3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by TYZPR06MB6771.apcprd06.prod.outlook.com (2603:1096:400:459::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 03:59:19 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 03:59:19 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] powerpc/64: Drop unnecessary 'rc' variable
Date: Fri,  1 Aug 2025 11:59:08 +0800
Message-Id: <20250801035908.370463-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To TYSPR06MB7008.apcprd06.prod.outlook.com
 (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|TYZPR06MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c112de9-d0fb-4799-1fc0-08ddd0afcab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3Bf9oMiWMKWeaTCHN/x40Sde8Nxi2yz9zFqxrE9wq/haD6jZDmAxtVUlZ2h?=
 =?us-ascii?Q?FqcWJ/fwaMKMaKF5u09G77QYAdZYsjVFFVJi4RW7meFtTVDHvYt67DrF1gGM?=
 =?us-ascii?Q?/OOI5bWElOFCSGmmy5+ze8+lv5YVsLHgmSdAlpOysffOUKWxS9NK42ifroC+?=
 =?us-ascii?Q?P6gWDeDKyrVx0BjmTHkW25j2iOOksvrqRRpORDHM2X3kFuuMPruuNQBHK3K2?=
 =?us-ascii?Q?YmpueLSqL8uDMxahbOQitMQH3cCLELJL/gf3vp8pmOcTddPIX2gO8vO92VEo?=
 =?us-ascii?Q?g65sNcN6dOBEWUno8SEtXL1MvAnpxmYEKq9Ns2CdTGHUYmm0VyEIKYfiTRtv?=
 =?us-ascii?Q?9dhCf3C4V0k90wCiiPe62zm50XgnkbHYWTovSiCggSm5hK0g5aYXc0ql20pp?=
 =?us-ascii?Q?I3kID4fCCz4U8J9sGrn56U//WMgx5Gnobhgrx+C1CIIGVAe6tmZnax/QgDUy?=
 =?us-ascii?Q?ziVcvajwfGabSoF5DuRrfnNZ9fe43sZhVDj8NFphKCBQuZ3dwnmGqTkajKcu?=
 =?us-ascii?Q?e8STfptvploWpIiXUtCeb50s5ton/WBPSp9kJy3059q2XGWvIwyxZfzwvapR?=
 =?us-ascii?Q?yILPvJ2kqi76tZ3Qb/7ylNTd/fhweAq07C/p10nmMaYXK871R7j5bRbCOE9P?=
 =?us-ascii?Q?DQIYrCuVKPlAsb/MfWL531fBPYr7TD3j+ZYV7V4rxs9l8i1j1lW22EXIky1e?=
 =?us-ascii?Q?8MVAkQwYGOFIffakkU37qAifFpsj/G5AAc8n6OCdJtN2o24J5I3W9LMzUEqr?=
 =?us-ascii?Q?8DWapuqKQdBa+/89uDHqK1bPWEnXbqmQoy8CaIuWg7CDmb2b3zXuHrVY9Izf?=
 =?us-ascii?Q?p3OqR3VsU+pwg+6k/5S3qrWsNIF44h0AqaLbigb9ZeKOAM1R3S0GjtdzKntb?=
 =?us-ascii?Q?/ZWzs57PKFiatP1efrlPLCKvaAC4jElOpvghdd88aW3BjypomVYcAK/mxxkZ?=
 =?us-ascii?Q?oEqanvqJpA9oZiH1uGqErvj33kbOlUavdkfwiJv+eTFqrvJh9v9t5dpUvkJk?=
 =?us-ascii?Q?G0pyVO6gMBWBdKYWLmyq1Pg3VZZUKnRxf/WBetEwLeI2UF3Bj9euazFw1foN?=
 =?us-ascii?Q?1zlUdF46wrAmc6Ox7/NJNDazq3kKc/ZZ3iOFkf5uxtfJwQcHsCaq0molpKin?=
 =?us-ascii?Q?iIou4ZMRGrf/6mjnt85Dj55usjyuez4W8ZGTwE46sDC57hVdqZKEPHyu16p0?=
 =?us-ascii?Q?jXRLC0T8JAuQyKpJmrm2jOlLf9mw75Y4CBlXDdJwC6Z3lO7SSd0snHv79zS1?=
 =?us-ascii?Q?pWoFVGlGTAtzPY+nrEwZDzvup6/L6CpjxeP61xIjIxmLTPgEFrD+vB0hyXRh?=
 =?us-ascii?Q?vx9MgiqUSaQ6vkxvAvVq/xOy7NDSgIIlMRc/piskvDKSyXUxuYRra1tc+KXU?=
 =?us-ascii?Q?f0pIsmMpuAP3hsfjP9UH6gRToolmwMi6yhWTHqMeWJ6D7I2IoVfXLY+mUfQP?=
 =?us-ascii?Q?x1o2b8FxHxnTKkydkmCADOr2KsTODIIcujznysSo2tli5ORXPD6z/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGM+rSuH1YmXwKOEXxn3bku3FgKzcJvUlksHw4Cv4hsoGtvdboAc+DbnnqNW?=
 =?us-ascii?Q?GLO11qlviqwFQzwfAgHDB5aKJzHocVnOrGj1NIH6cxK5LyHCuCbOY1AMkX5+?=
 =?us-ascii?Q?0vjNIQXIRj2a+rNmykLXoBVE6pVpZiSVZLo1qYi/m/HlVZJE53TGtNigZ5EA?=
 =?us-ascii?Q?kJelYGoNxidTL4ConY7Zq7sD/whNiAlZAMrkGM3mLMnGNrnrEoWX5WX4/80z?=
 =?us-ascii?Q?mib6x8Lspn82JTyoJJHQK/rdp3IUH6s6OpCgCG+qo5vGAASuYBwI13U83MoL?=
 =?us-ascii?Q?w9gBX2dQAkIuikQ3xBsvsOElK6nA0AwcnPArpWVg3poNBQIhuk+CNfU1IRT0?=
 =?us-ascii?Q?xx3i5z/UipDiVylc/6S4lTEfEEWw2YAjokvVpkZLeeXifsgw1OSnVz/PRGDW?=
 =?us-ascii?Q?4lkubOToA+gXxl3jd43892HRpbIVEnFauR+43kdKgm13jMjGglqjoCLgYgDG?=
 =?us-ascii?Q?bJSJSUfvw7aXIDW71VZmXyyjDglH+IjRI+RRXu7JmoIq+PqnpJdKcFO94jyA?=
 =?us-ascii?Q?e7f/UKibkhdvPEPQxo9PnQjbIMZiol2ZQf3IBdEsdgHY4fmNGhPPyTyRq5sQ?=
 =?us-ascii?Q?tgr6ks5I1l7n7ohVzrWAej+88bsfbaq77VGu+RCjBlyyRWEkO3UPDVbk/ILZ?=
 =?us-ascii?Q?4z5KHcso6YXgNIEouQC0ZtVAG8CDgfrhd0k4Fe8y97QA6Ytx3qbAdkdRZDyo?=
 =?us-ascii?Q?v/FnjGapZD9eRBKcacjbbiYM9gIVBNaYjIQ5b1R5JGoTJcL0c1QXvNxkz6xb?=
 =?us-ascii?Q?jP0CIDOn8tDTcyBqUix+dTub+89K3MeR3uVxcKA64igo5LZPTCcLUVldYyEr?=
 =?us-ascii?Q?CIPcus5cbXvrUFiq8aW09AFXn3l7AR6vhovDZF+mnx0FFXje9lEh/AuLJfbn?=
 =?us-ascii?Q?SFIGUI9Ed/nLVKDKdLPeKZhuQmptTgqzSIW9cQsYDWEV7nVvFmVLAhhPfIhP?=
 =?us-ascii?Q?j5z7CAyHjqq9Nr0ZM3Yf1Pi87JpmVP+diqlePK6bq0+8e8aVaV2q7DS8Sbyj?=
 =?us-ascii?Q?pCwxxfOKnmWf5nxhpRZveeGcOU4JGPyrn/f67QVCaesP8Jvkc5nExCZkBCB6?=
 =?us-ascii?Q?2wkskezirhQB0aXOUMhoHb2ZPIgIAwdYaGwgbl7THtgie9WRafxzYbBKId7r?=
 =?us-ascii?Q?8MLuS0TtfIRz3DKRYBvFxd2YZZoPi2xDnfo12yzxrbirK45WHaWuEzbGI9Gb?=
 =?us-ascii?Q?bHdQILUEkfm4y1wlwfp7+njR7206DjdC+eoGrF/RlMjPDKOD+zcT0QnR7QdU?=
 =?us-ascii?Q?Uce1Fx4Njw5eFriVp1ekUgChNMbgUvRTi+DZEJlUv8FEOdYJgaMyW4SzXksX?=
 =?us-ascii?Q?+j8l7U5g+4hrkzhS4c0XBK8BUbUyvl9WEyLeeyFvKdQDJSFsaJX9+RlzaioV?=
 =?us-ascii?Q?rMU8ycFpd25O3GK/167UvpfH5wkdE6X9iBxHQ8apUP0rGm+injty9Z0G9sJO?=
 =?us-ascii?Q?MREFM9G30xoI45YRgtxuQFkOxlTj2wnJ5RIiIO2TJwsaZP3h7eiMvw3Ugwx1?=
 =?us-ascii?Q?tJq58PfRuHplUVurOFSUh8VjI3hSOtr2ZNSCk3RIZ2TSYWOEMwLVHwuYXgtn?=
 =?us-ascii?Q?whZNHEAzi0bf0RbCNZMrSujXGQFA3jgP4/oKoFvC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c112de9-d0fb-4799-1fc0-08ddd0afcab6
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 03:59:19.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzgV+k/khfkF+tVUlayHQXO90bn+vgTny8IBPyamIHp7Y6egMFH1bLlADZmCivbHMWHp3kkRXRHY1b/fgJRy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6771

Simplify the code to enhance readability and maintain a consistent 
coding style.


Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 arch/powerpc/kernel/setup_64.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7284c8021eeb..8fd7cbf3bd04 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -141,10 +141,7 @@ void __init check_smt_enabled(void)
 			smt_enabled_at_boot = 0;
 		else {
 			int smt;
-			int rc;
-
-			rc = kstrtoint(smt_enabled_cmdline, 10, &smt);
-			if (!rc)
+			if (!kstrtoint(smt_enabled_cmdline, 10, &smt))
 				smt_enabled_at_boot =
 					min(threads_per_core, smt);
 		}
-- 
2.34.1



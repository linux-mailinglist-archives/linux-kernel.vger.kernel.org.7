Return-Path: <linux-kernel+bounces-773782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70391B2A914
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C187BD0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0B33A033;
	Mon, 18 Aug 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="g3KMW526"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012031.outbound.protection.outlook.com [52.101.126.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DC3090C5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525740; cv=fail; b=LqauzQGudcauQt4HpHixBnJ1J61I0t4vPuAj+0ZrDnZyuw/DT7GQFDPthJxKbjA2BwwasxAPbYAQ2QQPSfHUoy3JDgyZeN7kvoWCxx8ta88Xye9Z/EQ6k8BZc3KzkvSvXkN7sdYf1Bzr9EDuBpApxjScRIds6S0NYPeMavhrInE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525740; c=relaxed/simple;
	bh=gMno8lckPiPvj4JVP/4TVLeUYnVgaNNkdqM28HEXR5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=inHbvnNWyKADT8Uzfst+HjWR1xhhxOHBmbdovKQHPT7lm94U96wMj8M5S4hYUfPe3E3kjn4JpPsNHKkkQK7XrbWCkza2llD+cHlK8JVMxIkIWpBrXAoZl++SiUz5V1Qz6m3T58VkqtMIF8sqmXG9FHdpqxa/5qgLINAR1pf3WjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=g3KMW526; arc=fail smtp.client-ip=52.101.126.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATpp7elEyhnfxzbD0QmRzfeq7MU+rCwOydkE1u7sA44GPPqrwqOkjx0ffNRhqYgWURhE6toU4MCaP3FMp1x8BeZJJ3RxzidSDd3Ny4WRLB0rSa69RQSvsiZiNDxc7pyUyQWNP4b/CW0bV9zfw5JRvmqDIb3EyvZ0LiMk82K5PSVsDJaFFM6NiBQX0xwG3XsxHKeOadlRe/w1RIOeJlUKpPDjGSBcY+ijR2iS5FrIVzU78myg8MvYjJ2OCigNAiCUoPzLnKpnP1nNTgiKlt7JYaIFohsPcbB1bD65HSHAfeNMdRx1h3iU5Lj615ktRlXvGyRlIypE5ExmnEuVXUwLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1rUqFC4KZvqwrXuZSyuzEuTixJ3NBwaVmHClt0hbQw=;
 b=uo48Qg0TzB/AqOjXvhKaBk/TBeGeF1bdfs2mjIctpzVFX6xU2ejs/BVD8jbq8WWEGeOKkrKbwlar7Rdq7kNWic0INqgH38J8AI50cRtlAWbjoHglEjVn1ZZBP8tOpdQ01QTmjt5mGjrPevu2xzXbb7Nvsk7cbYvnlsJm6nlW+xvtTsGLe5KNaY22nN9sSKrIY8KQJvC7ossxicuPvfI5BA0Yts1nF1WsXxb7lKXGCMDEoWeVQvz4Q4eMqJfwUq+ZKcJ9euyDGAGVWYX1sLEp/F3RKT6sk8BbazbzUAru+WiROoKQEOyHHBucmdf2NnRrZlSSVBXT7SYSH7n01zClYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1rUqFC4KZvqwrXuZSyuzEuTixJ3NBwaVmHClt0hbQw=;
 b=g3KMW526ftULCsloqynuOx6SqKTSA6KcZI0U4F0+x3P79vBG3IkayUKqaZmhHMSlhTH5WG57Uw1590zI3rKinIclAqI92AwjDOxXuE4iR+zMyCLOqk5Sb9Ff45LXgKHFTD+VaQ8bfB4ttZXG/7PYLkYqutOy7PNhknou3Ne7TFjRaK25XSK2rP2+ETak4dne4EKV16AoviSoG5zRMg5HrxciWar6ZBQXaLu/6lJrf8RkE1+hFrHJpLFpAUZn9rrZiwmmn/1A8GDeHZ0qxhNhwFw5zpsnLdzpEKC3u3ypTMzpRrIADjUdgRnlhofRKhOUX4dOvzIX/WX4wTvzSU0Pgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SI2PR06MB5138.apcprd06.prod.outlook.com (2603:1096:4:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 14:02:15 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:02:15 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-kernel@vger.kernel.org (open list:EXTERNAL CONNECTOR SUBSYSTEM (EXTCON))
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] extcon: Remove redundant 0 value initialization
Date: Mon, 18 Aug 2025 22:02:04 +0800
Message-Id: <20250818140204.4762-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::10) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SI2PR06MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d76a1f-0705-4ce2-f432-08ddde5fd61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ze81ndYL9SYW3BC36WTEz/gjKMycBdmwLyy6860jcWmcwLOg5JogBVi2FMd?=
 =?us-ascii?Q?BaCt7kYG8d/4PwABK4EWxvJ3flkcqFP/d0s5m+eRkxAubcACrMSZxP630L/7?=
 =?us-ascii?Q?kfGPYcWVsHagLZhH8ZKv7v7JUtO6ascuZELq02WEOKTPtEDbpIGXtAf0JEqU?=
 =?us-ascii?Q?jL/G1Mm3xCLsf+L5DzaBp4eK0ahueU5+U3d/eM5+PbGWgcneWaqU1gdfWAnG?=
 =?us-ascii?Q?4iOfKlGCkyBm5OgP9jiKoWD4OYQAfb/3jxhmj6IWZ1qfWCrKoIknXP31oUiO?=
 =?us-ascii?Q?gEhwB9tejIolajQ+lOqs/wqhthVF7AlALFk5AqD7wclk/BOhIz9cfxZa1gyt?=
 =?us-ascii?Q?RkG0vXfeVAu2W5nck9vQtugDDu1bB0bPdtfRsugyewpdTP8GWGc68Yrx0Iiy?=
 =?us-ascii?Q?/ACkqsuUsBJ1NydV81JI7fGtzMPtQ2L/eMRUoEkuFu0foUXvDSIUqb6nCMHG?=
 =?us-ascii?Q?20rENu6/W5nGvl5LsFKPcP0swsTWwoKNKyhBLdpCikv1EKl1p8k+rEfoCjUe?=
 =?us-ascii?Q?dcItb2KYCe89dhBjTwq25qca1vIhefNksP89ElbLFg+yK1LEa26rFtBE4N3y?=
 =?us-ascii?Q?2FdY0QZwa/NxPzctNZUiQcv5KP5xffMHEN+YbczdAxOz45es0i8Ag6yGlzgA?=
 =?us-ascii?Q?XcyitcOH2dDNaSZ0732c77spwOA/4iCiXaUtRyNTNSoM1+A9NUggf1LQ4IBQ?=
 =?us-ascii?Q?5cIbQlxyCjcKHPJsbYIjarMHFHrr9BIJW9okP+/Olri2Qxiita2uLe1E0kzM?=
 =?us-ascii?Q?jjTh7Vy/bAYAZi00EDn0wsjWIfqCmBRPxhW+o5qc1cq1wTU1rLZIBa3Zi2u+?=
 =?us-ascii?Q?Nsi4R/BzDtL2214Y+fMpzRq2ini3OBXyDqCBHXdQhpwhEJQ0EGmwrzf3mefr?=
 =?us-ascii?Q?L1fLHYarw3tuAsrlafwU4xwp3vwMW0ZSv30TLbJrAFryz6qe/JvQpjC8fEpi?=
 =?us-ascii?Q?ZFkN/sGWXxBaZ9RzCVSio86a/ilXLMrLrZJeVRC66Mylvw26wn7NzGZjzbGI?=
 =?us-ascii?Q?XUoIfXgjFNDkR7Gcv0WoMtA101CMT8NJP3f+3Fjp5Dr73l+mpTmyEXKa+wsV?=
 =?us-ascii?Q?M6tRIpirA6Xx+MBNcj8o4JoqoVheU4//TMmzDDHT+hFjKbedSD6fzi2413gB?=
 =?us-ascii?Q?H/lj8suEN6omVNpd+mYGq1L7irNh1J2YUk0X16BsuSrifQoiQiWv7DDrL+Al?=
 =?us-ascii?Q?yJ+K280QHPIEWPRwaXPKOvCCa81g3XdXylkPoWr5gEA3HeIjX7U9EdMLUKnq?=
 =?us-ascii?Q?2Znhw3QbOH8bHLVeGwhcFFa+xgZwfPwQyVdXhVIAFs09yksKa1QkVV/4tbeC?=
 =?us-ascii?Q?dv/DZsBPHXsguFLFkl0NLk42q9cG7vZ+nKHVp63sDbIrSRu83GDhK5W6A8Ra?=
 =?us-ascii?Q?iRY3Sfhvce4MfDaPm09IHuZ8hm+rOGZbGdkODqFCdxE8eYCmqikOoRwEm+p6?=
 =?us-ascii?Q?Yj8Gzhf9ph7IkhqeTnFbhpeVHeIuIQdUyeyxAf/gGKPZjgUzo7vjoTs5ah8d?=
 =?us-ascii?Q?FJYXmDZCfac2Y90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTcHw5Z4oQsptsZwgTb7/d8OkunUZfej/oMdEKEBIDct2l0c+uPyybGM9P/1?=
 =?us-ascii?Q?pXLrSjR3auAYmrEAYzb5N6G+Sj+9HyjyaoN8Y7H1QB+8mQJEyG8VJ93OCRif?=
 =?us-ascii?Q?qBBlYkOZyXX3SuRnz/qZ5jIeaKknSyZP/3sITfLgCMaE86vn5s0VI9a2Az58?=
 =?us-ascii?Q?qBJCh4PwvbxCUqYKUk+NdGBhKdsLvL0nT7XKa3pAWludWetJnJN+1d/1vNyY?=
 =?us-ascii?Q?031ZLzf2LKyZIQz7/34lngLvJhbKl5OREEk2sODO8+YL20lBbtf34CCYJu7y?=
 =?us-ascii?Q?dUab0UvyJdS+huol0cJW/DRms2Lye6y+obDKgl36IsV3+bV3NKl9pYvF8/zC?=
 =?us-ascii?Q?agLtb29hMi5LqN+rHuknHPKMYTqVdm8dc9HGreFoYkIDjAXXyLPB1bZYKIQ1?=
 =?us-ascii?Q?Ybgpu5fjYTXLpRmvkc3YEnrOpurhlbR1fRQEaE2zemMmhYfhjqChjwf7+Yjs?=
 =?us-ascii?Q?bi7zeWwVwaA6A/wmevrOg9XFd9/Szp5G44RSFkQvyE2xjbStdEs2pbtwCfJW?=
 =?us-ascii?Q?5325Qixa8jtSAzSjYkX27AmR1V8RdH7ZS8XyBuzM4tsDq2l2nHeS/JkINYDZ?=
 =?us-ascii?Q?N7MbV+AiqpIFQidJMnsIiyx3cejb6dHvzoNrnd25gnDT5YpaqHTNMJZWFAAS?=
 =?us-ascii?Q?iueUQdpt4WM4Wr40OuhV09X2e+QiGkEunOMGu5EkvIPld3nPdRbee2PA4MmI?=
 =?us-ascii?Q?Zcgr8jZQdI8PoD+CcKIIssiK1Cf5fEuxYRnK7qxBVszy6EZSmi2AGCbpiMwm?=
 =?us-ascii?Q?VhAeI2MNmoPvSq7JOgAkRWpWZHWk1jcUGxGmnY22RI7g5brxwFacYE0Nzj0J?=
 =?us-ascii?Q?nR6HQJ0G0FuC2aZvJHTGNlT3WBn5z1yVA3WSonJwHRi82STZo27REQjTGV4s?=
 =?us-ascii?Q?+yHycOE36WWUWMbPs+ShXE9uBjWdlMG88RVUjUzSg+uKhlRsXLCQGzRcU+jE?=
 =?us-ascii?Q?7zbTxKDzmeT41a2ZW/Xfpa2W4bcu9giRhK3yzqRnu5TrXoLIkWzxNGKPQP/W?=
 =?us-ascii?Q?+bI78ev8lIwrWa3bCKuXdygibXnGLFgROpuYPMyDzgrDiiHnhsdpzqLiFZWo?=
 =?us-ascii?Q?KFUpAjLDlwOdLHLhskWM/RuzoUgG0evFAezvJw8po0y1maZkFeaIIo6QyxLS?=
 =?us-ascii?Q?41Gozi8z/zQ93CLdpYOeJXIE9zPOeAT0GzgK/V+2eUxf7b6zkxNgHtf12nbo?=
 =?us-ascii?Q?LORK89Sz2tsM334fx167pqUK1SHHyS0I94JZ9rQAsyrM3qP/gawYTvmuVs11?=
 =?us-ascii?Q?gQKfaadx2nbSrzvRPxOed3W2dnAzwMnzaJIgYWAm2QLBWwJi7Q7fSKqxgKsq?=
 =?us-ascii?Q?UwpiwPN4E2woixhIqL2lJurUD/OIR0B0hu9lYWFEsZQnOvDyERLM5SBnExgo?=
 =?us-ascii?Q?tu1/gE9+H//vW3lkfgLIja3ZO/dWk6dAOvyHjKvChxvqOAov0HeWbKfhV6pP?=
 =?us-ascii?Q?WS1FQYp6XDENyBc76PZmzSvbbq90tt3bHis4cdJMu79lDze9KknJSrmfZQLI?=
 =?us-ascii?Q?w93wmIQHaTkz5cZWGppmJgEKGrQo/6yy2ci5pV2XW5wM2EWUlA2K/mjjdWFE?=
 =?us-ascii?Q?JS0zCP2gQ/1NqyTtOtQ2abUaU1u6q7z6DEXBi0MA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d76a1f-0705-4ce2-f432-08ddde5fd61f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:02:15.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zkX3W99zsEVbMNsjJemUhVPOrKmNSkoDHFR1hrer4MMcV4KwRvggreNjR2j4GpJjgO3L/AIQ4+yjm49G3SB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5138

The extcon_dev struct is already zeroed by kzalloc(). It's redundant to
initialize edev->max_supported to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/extcon/extcon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7f55c021e56..e6b10dcdb3cb 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1064,7 +1064,6 @@ struct extcon_dev *extcon_dev_allocate(const unsigned int *supported_cable)
 	if (!edev)
 		return ERR_PTR(-ENOMEM);
 
-	edev->max_supported = 0;
 	edev->supported_cable = supported_cable;
 
 	return edev;
-- 
2.34.1



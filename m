Return-Path: <linux-kernel+bounces-768438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9DB26112
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F06725B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0552F83C2;
	Thu, 14 Aug 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6Lwy8Rh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76762F533F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163790; cv=fail; b=rYKkFlaj/FYC0ZB/glOLrxOyInmaNuE1ngiMXYsoxJFQuln079KlJ9RDhh+K5VGx6juxJU/5W7qGWRFwYvUzBAO5tE5t+dq+0BJLTmgjLtDhjIKmPL0IoU3rd+8cg3th6ngzYVrGuWhOmHbaIuYPNxLxMmTl+1g1oTGt7i3H0aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163790; c=relaxed/simple;
	bh=Ufe/vEvENpyjoTP71SuZkRO2SJVe9eUTybK5iKmkGRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8rIalHMXhcIsz23AwQP8VzuEVGBfGYBqWIklsRXa3uDjmX66JMmwSF+CsBAp+cxSJAMuqfoa8++yWltrwcS+0VGDQkkFFXW+zudt5TpIylkcA3G9tj4ZDWXEDRiS06BNvfYo+8rWZnPuFFOA/FxJpZQUQ5UqAqkIln2mRbkw8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6Lwy8Rh; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai6rfUMSW/yR2VZhm4vmwKu9R+As/CNhV1ODjBUpq8n0wi49ZLEZK53JO28K01d0WQLVQ8J2Ct+JrnNWA7p5/Zi7yXdTMLJwmQ2BR76bq7RSOMFWXm1l/YkO1Anlj90L/eQo8WEK3EFguMdDltpk89Ov37HTMHCq3gPuppgP0u/Nxc9zwxdGawqDFppQ6nwfCwMTYo5LE53J4gFPIPuDL0eJozcpotHe+Tmygc3c94DmQK+7lCOcE3f3Hn9KLqhWmbiOwi3b3tZkVXOw2PUmTIIM6Usb2y8QpWljcl6wlBfsQLsCP3LYeBf0rO6BrJVtCjNzOJKUenWXlaCkMkVySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIylgGvqCyRP4vCCksz5vW8xv+d2Og2A06pAFqu7Xn4=;
 b=aiQAZ0kMCKT4dKL9MHrt6aiWZkWt+6rsjkicWhHY3o/TV3mcBxuyA6eZXLI2s0kHuoUuVLwkjxn7tT5j9o2uRwS0l2QMYQCOZljmbjYe6QdtId/r6cDcBai/ZpFK4zaEtzEG4WKlSePq3dvD7RDpil1Z7iFedOtBd8ran9wE+vto8yj24yLUIB+2ES/VI1WCBTqT71L5DVYU2c7Eggx00S/+u+7IZTd5UkyLVxzVoXrMDcYNC2GH+Kouu6iiaa1sJTh6OHZPz8x9+ne9HIJbDLGy3nuNi4I6izu/l6ZF/TN2T428IyB+lZrM/UlMi6rYuBXhSnKRnpaP4be5uwuOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIylgGvqCyRP4vCCksz5vW8xv+d2Og2A06pAFqu7Xn4=;
 b=O6Lwy8RhWPfPUkpab6gKpcjETV8edK+j9vMQpL2ONu8BZuM3VONuMrmihSH1AdLpLfsmfbSbh3za9ZxdM6IhNfKAbsj04MzIxcMJ1/ujBSIFvbYFTHe9942xODgsgmlEsuzWT8cWAUfimRVew37ehq3ryxYI7B4TrjDCDp5ARZXNI4RFjxpF+RXpLfX5InFVR8rfJcKXXI6f9HRlUxOHUH/pVJwUnDo2qi7xpDfXtIPDRIBpehgDqEMdAF/UM8Qfj00YGZwoTFy/vEWvlFe69sB/WWysRZjMDhMXfN35/6qvKDzZIksaPF59ohcyJDF7cZ572Ymdkodak1VParLtIA==
Received: from CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::8)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 09:29:45 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7c) by CH5P222CA0004.outlook.office365.com
 (2603:10b6:610:1ee::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 09:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 09:29:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:29:31 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:29:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Andy Roulin <aroulin@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>
Subject: [PATCH v4] checkpatch: Tolerate upstream commit references
Date: Thu, 14 Aug 2025 11:27:52 +0200
Message-ID: <20250814092752.612266-1-petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: c97c02d4-e7ba-44e5-7cd2-08dddb151b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNcBe2XshIYOVS3klOD8JxYEP3yFHPzimyp+Lg2IRVdLRgfUgzvSaiZAjJ+V?=
 =?us-ascii?Q?yQL7wCWw2ATYXwJnOgEmdBBY9fUq2jnsMluunaKmQRKV7GAI2QrcmlcETqj0?=
 =?us-ascii?Q?4PF+c0gxQmVP8DQd20uwBjZrIXLHTlRHVdHLmzhMamGDf1Gly6hEicdNEzi5?=
 =?us-ascii?Q?HrN+VerH2F1L697i2fXZYSgFqOZW8sUOeBv1NvHobH001jsvIL/zY27V04VK?=
 =?us-ascii?Q?HL+Ep3ztZINCcPQzwig5umcFgsciZh5LjsDPKxx88IS+RWiEfnN1DpyoE/Fj?=
 =?us-ascii?Q?zlr4K8Z1VIhc8BsDYgLHwKNAu+Kf1MmjSKH1+ecF3TCqs9uMX58nH+B8K8jl?=
 =?us-ascii?Q?6rbLK7xNat1Kw1VdnsEQvqvge79gJ8yVSfDh+SqtL9M3Lj0d4UTYybjoGeTi?=
 =?us-ascii?Q?LPSu9E5x2ZNZph8OrbGUaLMTCpj66fUVvfD2+jpz7NYZdiTJBFx+mSNCPy4N?=
 =?us-ascii?Q?BGgRQvBJuS22efdoxh1/MaSX68fYa4G5zXRU+MkqkFPUu+3L3EWa8DbrLv9R?=
 =?us-ascii?Q?mqy/rqOZqCu2qqtisbu67iyen3SoP4pUl5XxsTaCLyCg4AOQReYfh8POKVlz?=
 =?us-ascii?Q?uGiAiAve+6x4MFogLuAOfaTmL8VPcMpf3YNl69S2cgbjPsKsHdiq6GyjIm9e?=
 =?us-ascii?Q?SXV8EzyquRB+ZHZb97PBuIiMIeVj0PSiU9OY+/zcx0rMWg/u1YKywqf5+mXu?=
 =?us-ascii?Q?B953ZL9hBu41Gr871u3lJtxIcUonKFCtV40tJ1APfEbYZVhmAtEF85cp9h4p?=
 =?us-ascii?Q?r/jY5pQZPc0RVYv5NDvl5U5AzTkqk5ick5RqgHKrbIdD/iYIUVA7/ydXuuya?=
 =?us-ascii?Q?AfKs0Scd8m1Oy6pxmhXixCIOrRVDkwJAExCBdyR2RYY1L6YSz1SYag0vBkfu?=
 =?us-ascii?Q?Hj70mMOnjkDk+QTxx257QOfZ2KavYshFK7NNUy8rki4mzrG/tWgAf6rMG7GK?=
 =?us-ascii?Q?uX9mZurSUo26SdeN4nQxDN+gW1KOVVXzizIkOMvGZUnbJ3khg+/CR/4duOYk?=
 =?us-ascii?Q?KNGbwd08w/Flky6uwKXL/juGbuY7XP3Iy2pomyC670rTMB4KZZ9SLMSxWvud?=
 =?us-ascii?Q?mEgAGTTlYFcers7vre+zMRxr0oJPQsibBbIWX8vDtdYRIwOEINfPujhVwTW3?=
 =?us-ascii?Q?u5GOFnlm2GVfsYw4XKU6LU8O9dNaqd6UDAwMnyIp8ToawtB4XUIc4Utd4zw7?=
 =?us-ascii?Q?3yV+Of3FCersXTEVqYl9hpP0MoZQQAtI2Hphxc0sVN5T3XpNca64ymF4O2zO?=
 =?us-ascii?Q?aW35rXoUZKMHJ2dx2LKOQA17vqceFLUUzPQrGy3Wv7EC8jBqD0XJ2PVgJjrg?=
 =?us-ascii?Q?5vbsSmQtSNbfzpO6FjsSoqLLvkKUlCFA5YxbPZc07j/+p0bXux/zryXBiGe7?=
 =?us-ascii?Q?iQGyAuAeZgx1vSd47ShzUGmDmNaCROtdtqUpggMxz1X5O+h/lUjA8rnGtBY5?=
 =?us-ascii?Q?YXt8Mmhs+JPQHskac+grG57vlnSdBhVWWnZ8EK4+ydSm7ux+hUEnJNRG4HD0?=
 =?us-ascii?Q?/yyuxzEQMFqcZ46/zmn8m6JSFyhiijpwATUB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:29:45.5608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97c02d4-e7ba-44e5-7cd2-08dddb151b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

Two forms of upstream commit references are used (and documented) for
stable kernels:

- [ Upstream commit <sha1> ]
- commit <sha1> upstream.

Extend checkpatch so that it doesn't cite these. This reduces noise that
downstream maintainers experience when checkpatching patches that may
contain commit references of this sort.

In order to future-proof the script, allow also permutations of the above
styles: with a period or without, bracketed or not, capitalized or not. The
hash is recognized as at least 7 digits long, similarly to the "This
reverts commit" exclude below.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v4:
    - No changes, just a ping.
    
    v3:
    - Tolerate a couple more upstream commit reference styles.
    
    v2:
    - No changes, just a ping.

 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..53b21b4a4760 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3352,6 +3352,8 @@ sub process {
 		if ($perl_version_ok &&
 		    $in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
+		    $line !~ /^(\[\s*)?[Uu]pstream commit [0-9a-f]{7,40}\.?(\s*])?/ &&
+		    $line !~ /^(\[\s*)?[Cc]ommit\s*[0-9a-f]{7,40}\s*upstream\.?(\s*])?/ &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    (($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		      ($line =~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $rawlines[$linenr] =~ /^\s*[0-9a-f]{5,}\b/i)) ||
-- 
2.49.0



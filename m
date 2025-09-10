Return-Path: <linux-kernel+bounces-810191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6CB51716
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87721C81FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0031B13F;
	Wed, 10 Sep 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bo2yVBN9"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F81314A77
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507778; cv=fail; b=GRv7jH1FrYcyezRJrZksWGBimZ0ZP8T3nTJp2rMMbfDmQLNWqdb38v20iM9A9tnaynxlgNWEtCLbD1S7qJRFEpFmorLX0NKIbZiEe2QaPtDugaWsNlwdo2sSIOue9XAFOC4ZQKSHBBXH/P/Y9afQqEu84OWbzGc2TE7LGlqLgv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507778; c=relaxed/simple;
	bh=ohTp5oMiP9DK8zk2Rg+nQ0LklYJ4QARG643U9uzt8GE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnwDfxiIK6Oi3K8060NsQVyY3dXWWLzi5v2Unm76VluyZmD3Qmzll4bgRmQ07Z9syz3hCIOvV9gtvHGxkErjPJAYtt4zsUBGU+gbxGHGWGfOeXK4HxTBjxfEN7eyfHsO+j1WRIlHu8ks5OC7jGyG2vz92zCUk1rvUsjvrpJkPGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bo2yVBN9; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMjboH/cmmErQPXe43X4O/i/Q/SL594Sofnvc3J5fLlXeAIo48EbyYCJR9geRixnoTGPZcDuTYDbjBZvEGlAj4F3BpNAMcyJebrtbVaj70xXv6Sb1sXzV0+dkvNZ7W+pwOSKzrfahzn8s0GjdOHahOKwEV6k7z65WIBhLJVWtzHeYnY/z11Z7Fow/IUG801hetb6nki/01fg8UvJ9D+RquDwNTTKcnXcjOt03EKl6HcXpWLJyh4xj0uhRFjNgMwYiqmQXXzCmazMsypT9th6i2jr5hfuXwJKg2jeUJcEDIo8UvjyP9sdXoM8eZ5uEIT6nSl7Oh/m5B2xgylHfHKUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlvyYP+ZbCcXXoJ2PymMoyIo5KLn3n7UnZzK4ZI2BX8=;
 b=RrAoseB+H3E6P1eIm5xqQcofyONQOA7t9PSjCdt9WiNSFl/B/XqYBRbmDthk3aIOGLjMGlvL6wOMSw/b5FE5h3118QPeB10Q/f1LA8jaKdg0f4jGIGG4IRIodEMSsGQmm3whqMTSdKlXvxcUEnhSFziljsQdY2Yv7nL1QF3H55KjZ5F9dGp7snp6Ckjxk6+z9hN/Mtp/XBf8b8YkcqAmW2vr+BBK/kybITOLnaTAVwvbmR3XZ4D1uAXcgE/gc1HsFTLZgG9h2wGOE8b407BH9GHPxyVx9tRWDbq++r7tMZr4ap77BiLIMO1uPe+E/ywNXV7EPA4P405wS5RZ2v/o4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlvyYP+ZbCcXXoJ2PymMoyIo5KLn3n7UnZzK4ZI2BX8=;
 b=bo2yVBN9cKZP0JAa107KeW3iUyglCvvi7rAgppXQ1VNpmLi4pwSNTCTcl+d+M+vTDQB7bMy5rQ4OTIT8T7os4UBsCEK1Cub8fKdGaDaFuzDM8yXMTw8pvMayd/ONRiSODUeyhiFBBdkbROjiEtykHXMlNXdtEZbL3os371cUhDUyyzCb6Toshz+9/RWPX3GpJnFEsjRJ9yputuFBlXevV2t14OAjuZerbs+RuIl+EMaF1AxprJX5PS7oX9/m+Sianwk8QsjYhoKVmCWxWMOpd7SJQQBOIv4a9lyvxxcS0BGxepMI8jaH9Kxs8fDRGoSqbOVBeip+6PzubrB9Z3kRXg==
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Wed, 10 Sep
 2025 12:36:14 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::1d) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Wed,
 10 Sep 2025 12:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 12:36:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 05:35:37 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 05:35:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH v5] checkpatch: Tolerate upstream commit references
Date: Wed, 10 Sep 2025 14:34:01 +0200
Message-ID: <20250910123401.175403-1-petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0560b1-e470-4bfb-663a-08ddf066a0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYh19qTx5g2MIRDo+kBxlMiVMxYn38U6yv0l4062C2jduhZA59JeJohRyFH5?=
 =?us-ascii?Q?lkE7rPXxg3F3nbO6TqGVmwU/wYOChMJ6HZqOu8Hns+70dmQGWNhsPnGmtjS0?=
 =?us-ascii?Q?pFngfmBgcD7OB/kP0EWZWVrztGkTkjLZ2i96vl9T8j4HuqwlbOGtZm8Unb26?=
 =?us-ascii?Q?/ElScFJRUxwlqrObBdAuDdKpW2xSuCXo6qfEe5WfaGRmr23P35J8kZfz0VBy?=
 =?us-ascii?Q?bT9Cpym5EVYhelb60XVMOUquczyFdmW2sOaoGd46dUlaasdD14+MkkMfPZV+?=
 =?us-ascii?Q?sBKng9ofHAConO0OBQaahoLBx/OzncJu0tFbuzcIa+SSYfZVAuZ8QKuRVqBQ?=
 =?us-ascii?Q?75rWKcZwLGBBfp/7llB1HCjzZ2mC1GTASroHipQ03XYbF03hf/kc6FWiz/bm?=
 =?us-ascii?Q?aLSS5qj2it6Xr1NEjQhykhadPNmTvLmCOPBPo9FljL5yJO00bvt83UyKxhqm?=
 =?us-ascii?Q?ffQZOXlmeSdsfWDAzRBk0dUN6oZBhXmhPch5JXqP1MDDPx4BXon+lccnBKVl?=
 =?us-ascii?Q?OLz4+IrCQ79xyueNsiuyhxgKgcBLAOhtmo+lUH2DdVefoyFqp/miuYTNmaXG?=
 =?us-ascii?Q?BqDzYNfKwotyeEARx8IAVbQQrwKsTSdgjycMQdwotMFb+XAcIwbCbxSjmVdg?=
 =?us-ascii?Q?7K2ToQ6EhvLlx6rNciiFiQExv0C47CVpZgY6LUW66OIDvo4ArUM36kMsa1jd?=
 =?us-ascii?Q?taFVNCQJL6wxX7xnvGd34haamK9hp4j+eMlGyxKL89htRLKBJNjoUeYbzOXx?=
 =?us-ascii?Q?eIgL8keWhcg7bJlQFDlkmBgrAP4xSrQHwhgB57qvb6u22IMKZz8SvGty1Fgz?=
 =?us-ascii?Q?OlmDAgcZu1ZQioZcmg2S0KgqcCzGzvBimNa2j3bYJC3Zc6r4Y1bHXmdAsLbB?=
 =?us-ascii?Q?IqW/CXZEcaTq4qGWFIEDbtpoKQ52uS0I1ySM2LVxf7rahrvEyT13OiVRcTs1?=
 =?us-ascii?Q?nwU1KnRGPxHOAThF7Xl3nMDP3HoRqCh0CvgRL6OX0OCOCKv8ZPYkmKcQzE3P?=
 =?us-ascii?Q?QmEbXwIkkdxEhqw6oAD1KkjeQRjNF+IrB2w74DXGRMNrLPZiYJds3WRi3ORO?=
 =?us-ascii?Q?rbP9I83zxzbH/AjHPreFZl3jviE//tOfTiLNuXhD+LjA0F0VPWiBlHbt4PXn?=
 =?us-ascii?Q?3CGinzIZrWV06+6XM+uvi3T2TQ1LJBYZcbqFM/HU6jkW9+1xVH97HItRCsE5?=
 =?us-ascii?Q?slI4UQjDjaF90avW9WG7y8QsLdu5/nEY4siZsHJX6wMqDLy9jzOleHxIN1EU?=
 =?us-ascii?Q?q3U53CA/jh+ZXPhAMebzpBXLGR7rTVqM83SEvcMQ0KrGrUGLQF/tRObIcgPQ?=
 =?us-ascii?Q?QwljSVNEMQTHn11u4tSMRBGCEhq7HZwSNgU9SNfdx0aHd3O1sSGYVqqxA9HB?=
 =?us-ascii?Q?5EHHgYAYt6yoyVitIjAYdx5/XLUnPAQjjrXL1bR3cOGVEdfrcaLMgGsWdqTB?=
 =?us-ascii?Q?UmtpcbEtJOl2rdeyzlA4z0ZfCChL2euaP7RzMIJWeR9yd7a5AAlVB/l87tGq?=
 =?us-ascii?Q?wV8U54jmSO4oRkWuoE6tkEhhDONx9zzFYW+Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 12:36:13.2142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0560b1-e470-4bfb-663a-08ddf066a0f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

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
    v5:
    - No changes, just a ping.
    
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



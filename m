Return-Path: <linux-kernel+bounces-778977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12581B2ED72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070B3585091
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1626FA5B;
	Thu, 21 Aug 2025 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVdG0+DU"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957691F3FEC;
	Thu, 21 Aug 2025 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753073; cv=fail; b=PvXQPzT3aWy5xBKi33zZFXM3HJVt2Kr3WQifdNiapzLzpRD6Q28e4330ccJR0vdHLRqAwJJehbzml6UUhEtck1qnyBYsxFF2MqzF5oye+x+CxLeu+E/ygWO2S9Jp4Iv1n3y4QJlN5mwPqcPTOWpk0tOy1WMK3crPI8icgMb2fTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753073; c=relaxed/simple;
	bh=5m5399uHPLxtQ1oybI2AC8tGlyOX9TgHpqZ0XOFVaJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfrhxAmoZjOk3hyleRdi3U6ep3PisVFh19+9wQDxOui/1uOoEImMqFES/UCqGSANhdfJC0W/mNaEiAV5wnJoyOVUcf/CjKF9yx8YuR7KYFnHyimPHlQgFsUwW/pd1/17bI7JJfbKiPRPWWcndn1ocSMvkcTeZkOEuO3uy9K0emA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVdG0+DU; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtrzZ9FLewkNgrQYQj5xKUyiy9cN7JxwBPjKyUpZOwOHAzsqVQXwjEUdEe7Gn++sar5v0mxsktpKWeFr2C+PRnmSONL7M86e6sqfTDdbnc6XmHNloNO8TvvLI4jsxCa2OuGiYs1665AMFJKdbEDlQOUZgiw3a75pIUJcscEodYn8o4x5jw+NtolR7+IQG6bXcehIefPJTrr91u5z6kGChg0ZfYdGEq7WY37WL3x2OcwupZb2f8wnZZW+ZLPDBVewTM/EshLnsWCkaMIr7V22KbKwcDPn9PcPBrLLCTdQhwa2+cY0QZJkWr1gIxnf8pvQR/Jvu0hGU10XqnTTmHFA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv86RM6kx5Id2OXDWyT1PnIS03iC0tmyd4rJ8QrfpjA=;
 b=Kdx5F1y9DrnOJAZBOTXwh+gcvuZQEf+givb/e4nDsfi4uPxygPua24PIgvhrk7NGI/YLD9//kWX92LyqSC8FK4XkKE3AHVfs8N2ZG1vvm92dBpkmJRC2QwV04aF+f3/wtbcfqYCVJHMvcPDgYb/VpHgMhvjxmUF6AcyTXN4YIIFgFqusenZbCN9JbCyGaHsWcQ50TYA7zAjH+9D2lnXVgKUChAn9afEDTSQ7RuVXfVLe50USgLb65+C42A8eDpiwrDJORcI3A3jRcrJFZDwp6b4VKftXKLe6lfXYD3AZFQahlYYK7HWZscHGGxK3BJ1jIS58IWfa3edDByYDLZrjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv86RM6kx5Id2OXDWyT1PnIS03iC0tmyd4rJ8QrfpjA=;
 b=RVdG0+DUzrzABooetrU2ZvPN6e95yvYXANdJdbNtVLObjq4Cq2hyDHBiUEK+H6LGglsZ6/fLqygOEkzlarVfd6+l9uctj8rKpOR+lAuyRvfx/qUXhzY0GsXZA5xyZ+ZG9FAMHbURpKuLGCLJOIGdS5JlRxFBr7Yh6M6uMkSgUry5qEwCT6v5T/Rd7PdQ/pdQiexfsuxW4H9cqGijWHYEJPu9NuVbanJBtlD3x6pcp3VbLO9CAd8iwc+DNiihQ2L6QmplZ3pP9a/vLerTSpzc7lY8q7v7gT5xXqQ8Hs0Ld8uTVa5T3YUrYPXjP+KwikLO09VGr/B0h9LLuGrOuUGXEg==
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 05:11:07 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::4d) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 05:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 05:11:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 22:10:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 22:10:49 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 20 Aug 2025 22:10:48 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<donalds@nvidia.com>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <etanous@nvidia.com>
Subject: [PATCH 0/2] Add NVIDIA VR144NVL board
Date: Wed, 20 Aug 2025 22:10:45 -0700
Message-ID: <20250821051047.3638978-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d6476a-14a5-4589-f656-08dde071223c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aiMihgr4OJg0l3SDZsxW8CjN2jeGNtfqAcopEcs7QkKeMxe13TjprOtFxeGz?=
 =?us-ascii?Q?03fCld/HUvGtfYo4GOcF8gOoLi3N1WMDhC25+0GcM4TYohZaru+895dp6JD0?=
 =?us-ascii?Q?1Yol4Ga39k1QzzZmfdvvNg1UxU62pV2krSBnew07MsrBthJVcxpNJj5pxW3W?=
 =?us-ascii?Q?NcrJm7nq2OUavvWbWYsrgAgI9sR0M98TYvAIfvW812gzw/79w6yMCy2fEZI6?=
 =?us-ascii?Q?pkBGdQEy8svotwNGNYjtI4QiXSYUSIckKIMA9vEV8E2go+AB1kvPFQwLCKT3?=
 =?us-ascii?Q?I0b7YnFai5v1Zr0Gl3L1O0f8Ael1wHgAnvKzJvNCItn0M6so05HO5lZ9G0Sd?=
 =?us-ascii?Q?Tgy2XTukiojrg+O/wjA3xnUcDc0NLB/CrG6+S1xg2gsROmWE5LvrhUyqobgv?=
 =?us-ascii?Q?xG1DSjqLqr0TB4xje9jyconT2UA5lkAQ1O2pQ54HaZ/fYYEUvY7nlk/CcX3Z?=
 =?us-ascii?Q?+OLvqDsZJJwdn/51rjsBnF5WSPiIK6HUolCoDX+WJFh2dlncB3Mrf0W2jdo2?=
 =?us-ascii?Q?nPAfuCrrD5FVdkTd2tSpu6s6Y7oQIMRoJn9V/R6YoGXYpRjGFbjctXKJcTcG?=
 =?us-ascii?Q?qTRqQySqSW6yhHujXh4rYGW4PaUmZD62Ug+xewb2dNwcBIEa19u+XMp5AQkq?=
 =?us-ascii?Q?LmfpdCV0w9djJq/Bk+SLgL3t8figgVTKWfbdD5zCVy0WJplbMC6/RWALcsQ3?=
 =?us-ascii?Q?3e301ElUFRJ5pSVcjSueI1EKFBHpYfh7dnR6KBUcau/EqU0ysCC77/BTyDT3?=
 =?us-ascii?Q?BJwoIBb6iSkVsHm0aMu7QLULGWB0BDyx4ol2zc6RBZpFowCwMs0otoBq6+aD?=
 =?us-ascii?Q?hQkcxsJNBUqMSTYBK1xvM0JqNktQLSy7AdL5mRIFLPSWODMpwHMUkTcyUhw0?=
 =?us-ascii?Q?liIMFUygN+ldaXrsfDiAlLdYBmLp+7ZcqOKM3iEpxsGavH8pp5XAzENZpymU?=
 =?us-ascii?Q?Rlt17RxnCgRVv9ELEaYFc/rsI3S3jqVBijPTXCs3WLvbbq9VTKmUhVW3N+56?=
 =?us-ascii?Q?RCWp8Xc9r1D0gqQDgCHsSE2fU2J280snvS3E3XNKC4yWhMAmRxHTbNDmRyVH?=
 =?us-ascii?Q?9CR5wH7RrzsWFd/NgXbiXWWZxQ51evUFQ1ZlNWg18DHFpWn5j+bI/JVZ/Ufz?=
 =?us-ascii?Q?U7or2ieEGiVPxn0MIPq29Ys7VF8/NUXY9XrM+om8BSnEb0/appmARJ9aE03x?=
 =?us-ascii?Q?Uo6SjApvYNoVHqkZ+99w6SXxs3495Z89W9E+Gw0N9DaQtvWYxj5ZAStXbHQv?=
 =?us-ascii?Q?mw+Ub4jnnIElwCbg8iS3DRwuGm7svc+GJP+Uubz1QJnj+ew5MjMy5LEJO8il?=
 =?us-ascii?Q?ZqBvpz3/E1VQEch8L2Fg5BVTcAaJzY5gN+mdNDgxwDsFWC55/3CWgs4jrM3y?=
 =?us-ascii?Q?qk+9LfCvXpOvN0JoRwVNQ1yFSdWePc/z0F3rubZ/EQRNBdTkAxW2W6Ggg9dB?=
 =?us-ascii?Q?L5NemGGNZXYWxnd43IU88nJne400AooI8iH0h5RbVB1/5f7Zly2mQUXs74vj?=
 =?us-ascii?Q?Fp2x9I4Cir5d4yHmsWKaRJVqu3/ip8whPn7j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:11:06.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d6476a-14a5-4589-f656-08dde071223c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

This is an Aspeed AST2600 based BMC board for the NVIDIA VR144NVL
platform.

Reference to Ast2600 SOC [1].
Reference to DC-SCM Spec [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://www.opencompute.org/w/index.php?title=Server/MHS/DC-SCM-Specs-and-Designs [2]

Donald Shannon (2):
  dt-bindings: arm: aspeed: Add NVIDIA VR144NVL board
  ARM: dts: aspeed: Add NVIDIA VR144NVL board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-nvidia-vr144nvl.dts | 879 ++++++++++++++++++
 3 files changed, 881 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr144nvl.dts

-- 
2.43.0



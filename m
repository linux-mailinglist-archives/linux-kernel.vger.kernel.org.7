Return-Path: <linux-kernel+bounces-743256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18CB0FCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC44B963165
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB4149C51;
	Wed, 23 Jul 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMXPUB+Y"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE04A2D;
	Wed, 23 Jul 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309453; cv=fail; b=iPZVENbhI5GHFeSoAWn415xPdWX4I/AnR2DLdQUc8dxCLimZoO7OvP7Xm6RlvMrdN7OwTAm+m0b/NKJhO9ANDiqusCgyc9NUW2ZF4MQmDpw1GSvveF0+kVdNYN7HRX88SFvpoA4kM6UlcqEO07lGZ2n9ZctlfmnCmIVDt0EjFtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309453; c=relaxed/simple;
	bh=CLCq+pBuuSJ3FQ78wEnR9G2ue3b3bIsDfqY9dLlleYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P07gAmnN/jrqLRaYCcLZA9JiCJ3nDdWEWukDW2iInfiAY8MWUyxOTgvUKVjHkwRfHFgDw8aJ/Af8Yi90t5moyzUbLcskTVIhFwgGK/kOyzaXXiGnmUHRMOWaojzDhZxBuQu4b9h+jKDaqRIxmwsCZ4KvmSpK6p4QSJa7xa6eJ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMXPUB+Y; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cALbSVPeJhiZ7U4AL3bSBcINrGxb1dDAVYKREkKi0wbImSg9epyXvQITRyfH94D2iT/gTiL/PzZJtn5FCCHacBYBgSh7Do351gxKMuHmeu3zPqy9AcmSQg/k23EpqWLh1CU8W3j0uwhFE5CFBhqMoau0diYirgnUVfU5NOj5GGfT5yvyT41xmQCyMWCeRy74K+9hnl24cmN5zwLZp9Jq2VaAYUE7oPkW89bunatU7h5hBcQ6RzbXppb8s7oopZhD9ub3eKLtYLBvJ+Iklfs4/nkh373/mzFrr7RiCRNyueihfKiwM406ALwcBu7HhsbKNslrSaDKbvxXC6WyaTFBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwj61VdGZbmkj1z8gtIXqp+9+EvND36erwsUAlu04no=;
 b=DbPODhLYPUKd7OuIvq0eiSOd6v3w6cuNo5FhPIDsf6cplTfNDMPC/hqJgltasm6gvXiO+757sskxarP5+5+j9a+Ch8tLXTvo0OXdcwhfXu5B0+0+ppihx64ZxA+PoZCXEBKx3ECFYeOVDPqWpltvyQDVb8i7n7/+3/Y1tMZpNcwalwl+Go1HSf2VCGznkqi2wNNUKnfJ+R7WM4BscQwEYDDAjXAyj5Z6qCgslnFJUEqm3E/VPc7V0W9Yymah+xa3jgcdj6yvK78DscJwEa1drTU02pP8kgEm4wTiBV0fa4IWFLuYmZ+K+yec4nAayRE2UihNGqON0Z3SNUpLih+Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwj61VdGZbmkj1z8gtIXqp+9+EvND36erwsUAlu04no=;
 b=fMXPUB+Y4So95+l4svkZCM6RRjBPR3wwhqC+eO/k2Nxw6+D8aOb6j1s7D/bz4WvwMF2uKWjcPxYNcO78ahLQT9Y93JiqRZTa80PGxJ8PcckE/x7QTGQ1o4PbBaCbGGy34sqJ0oPT00zmiBUuCa9kuaBPq+BbfId2V70Rzq2xTmRh/Tpb84PpkxQ8ZFJiotC4ChApmmqIcu9570fZTNCUL93Y0wmwXWD8gafXbiFCz9SoWHZyzFcuKsQciuqAcImtVY74RjCBSUdQ5d3H8liKTIePRAZ1X6yxWdvVbO4zABsr2r5RyiUNuXgFEAYwaYc4hUji8r25L75TBo0NfIWhmQ==
Received: from BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35) by
 DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 22:24:08 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::75) by BYAPR01CA0058.outlook.office365.com
 (2603:10b6:a03:94::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Wed,
 23 Jul 2025 22:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 22:24:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 15:23:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 15:23:53 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 15:23:53 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Donald Shannon <donalds@nvidia.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
Date: Wed, 23 Jul 2025 15:23:49 -0700
Message-ID: <20250723222350.200094-2-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723222350.200094-1-donalds@nvidia.com>
References: <20250723222350.200094-1-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bd7142-178f-45cc-537f-08ddca37a426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ygGTckY4NrN4szaudb5Jx7W/0bN1nR2h9Z8gRFOZXKDEHVTa6qMFMC4EhfPG?=
 =?us-ascii?Q?3/B0WRphZONMhVLD4BqZ2dIy4gSwlB0fumeFUMJAHRl6m4KrcGWIlCVbkWP+?=
 =?us-ascii?Q?DXQt1SepZEZWq8fglXY8IaRRSm7c8tBPaoqwls5Q0p7zrDC4SYsPDgaCbgOs?=
 =?us-ascii?Q?UmuKXKAxMPQOUUysewrxhZCHVWZm/ROYizvTwHZB0+mpdQlOjW3rusNhnXTo?=
 =?us-ascii?Q?Q36xXDXv2EJDmQFyDU4GTITw3vBteJhxHWHj4v2sHpeeG5nWHOhff6WtZjwk?=
 =?us-ascii?Q?aGrQXyB/MKgfEaK3xgLULrNW8MfpF07Njwvj2dWokZiJBESPLwLx4NLLoGm7?=
 =?us-ascii?Q?20oCsQu4A6x+x5OAq4+msq/ef5X2UQ9ewHvcFJDKSKTDdqzrnjMBJwGNngEr?=
 =?us-ascii?Q?fMCgWffNwHGz2WiSn81YmxQjOKQMEMzkujv30L78PKTsxPHE5UH0B/4buomH?=
 =?us-ascii?Q?/HolMvcF0ZFdm2ZA6nC9sT+Z/xJ93Y38PlqcbRK6raWwkk0Atm+R5E6uTR/l?=
 =?us-ascii?Q?Bjfpul/XhM9jS8rmUN52FnUlP5OQ7CNXLI4wUH5/U6e38l0quLmgdpJ5ONFs?=
 =?us-ascii?Q?oxL5EAqnno3rCh4AZO9rmRjMVG36bl6DAGfhIIiShF+/+HOyWmuAhIgCvWTa?=
 =?us-ascii?Q?p5Avot81rxT65vLp0kC7Zs2Iuo7py+xvsGLQYnWBa006En/rZs7AcVg4jn9t?=
 =?us-ascii?Q?KHWUZ7A7sd+qphrZhiY7+WU7tMwR/Np8gz+jwsf32dIRoayhee7Gn+2fHY1k?=
 =?us-ascii?Q?Hu4st8mbhyPBL8GJdWxS1bBccJvZJNTrHSwh1SlVBz5p/ugwleXHpQlXxlpP?=
 =?us-ascii?Q?5zj6hODu2P9saOY9i8LeGxRoXkGRBMHOgVpMtXELOquR+P7C5Khg+FJwDf6y?=
 =?us-ascii?Q?Z2YLOFtUR3aobMRitmW7fPhujJPkGKnVyNSNfW3aq4brU6FgF7c1vIHiXbYp?=
 =?us-ascii?Q?7Z0IPZ3lpwtAZ71yNtgFP9Xlx0ZkprZ8SaAogsvvW9iMjSNhjYtKZ8l1+r3a?=
 =?us-ascii?Q?Err1EPbwd0DWF2nDDB8mxFYevGBDn5D84Q3eabB742z/8cuHH6Z21LbMqQC0?=
 =?us-ascii?Q?RqIytn3nA5sMycUOKMVmAvwBtgA69VMBSrNg0bt1XLNTYL4QM3C6WTdsYcaW?=
 =?us-ascii?Q?CIWNRCyXuT/nZ2hRYiVzYXWu3FlxtffloqHifvBCIPrJ5UaznK3KmqV2G4IT?=
 =?us-ascii?Q?SkmdZbjX4rp3RYFNcNE8KOCKdILfwbVNuIkK0/KD0dkDeqH/Eh/ORtlZ9fBx?=
 =?us-ascii?Q?4RJ+011LSEFlL1NEgp+n09yeftgR6U7QS1KfjdFjvKgxAkcrZcaMqpIhMhyq?=
 =?us-ascii?Q?VyJxZq7ty2Ki2kDP4Gd4X2FyBox5NKNbDlQ3e7lp/gpGH7UaQ6zdj9bqYXtp?=
 =?us-ascii?Q?X8v5FmwX8kzevylyEIhVsFXzJQnidV+uS3iDeyVmVXDlNyKJytdLEa1n8n5X?=
 =?us-ascii?Q?uM82sGQ9Bhf9i8V6KvjDZVxBUra2YNHfdQkWUz95IUFVw3pEE31OLkjEp+ZE?=
 =?us-ascii?Q?SSTTzRvrnVRgC5NKexY/rtI6l9YG8j6+v5XO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 22:24:08.1430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bd7142-178f-45cc-537f-08ddca37a426
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087

This is an Aspeed AST2600 based unit testing platform for GB200.
UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
differences, additional gpio expanders, and voltage regulator gating
some devices.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..624581db2330 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -99,6 +99,7 @@ properties:
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
+              - nvidia,gb200-ut30b
               - nvidia,gb200nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
-- 
2.43.0



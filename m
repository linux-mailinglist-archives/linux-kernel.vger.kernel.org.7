Return-Path: <linux-kernel+bounces-736786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36320B0A1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25AF3B4643
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443E2D8375;
	Fri, 18 Jul 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iszpwQND"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A32C1597;
	Fri, 18 Jul 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837870; cv=fail; b=jKxruciGoCS45+3Vvd110bEFrViEZ67CZT68yJb+ypl4QRflS2OVYtgHpnmiFHKqnydC3bCPZb6po6OnU4AGFlKe2rIjx7X3FeHxLgIOrXGw0Y8XYuOhxd+tKjB5mwTBfXaIRsFz//1LjZmMNv9PYV4isuKv3qSR9hRRKdyoCPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837870; c=relaxed/simple;
	bh=2I2WHOUGSmTLqkZ4bh8QcpUtsz0asfRj2SXXqhFCbDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l7E2AvvlZyrwdQihk8rPna9Agp7jdJ0kZeUXTA8Ve2yTCC8/CYCRGV54WdvAi0ReZvtNFDONh5pf7P2A5wJTOvqa5xoOkRTbYbfkV7J0O2ZC11cWQU2cRUBBlD61mqGQSinlTBliqG5G0OBDpekrRAKpDCe2dTGVGAB0z0MqVg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iszpwQND; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj0SRN+4QyMOVD+A5MpBHeB7+7CAxp3fyq25j0PNVj/SMZ7ImAP+DzUQQCVEOhLQriUM2No86rN5jMaovbNKotncVFFZlv8hQVU0qTgvD/aBFYf0ln2Sti9LFHsmmHBxhvECErBn87nm7IcBohsjqZkchQLvr4vN8iEk5rubGGRyAdg+SUgfiWkhmSu/q/DllRiJOecQJxRLyXcXl9cqHYTdJk090JmUynowGTXuwHm550iDZjJaIG+K0DAW3NbZvYW3CVuxaEbHais8ffei515MtOEe8JxOQjFeuKls4WX7/dDLqvpkkDEI/eAgqcDsm4qzqF8ZigPYgt6jsHkUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNnJgIuMkX1y0V2BRId+ruz7414Hy7H4YyDiyLoPRlk=;
 b=ApD+8SeWVB7rNJqECxExVlnBksmRurFscfIiweWssemyEg/gWtEUH+KWdqhclkZM1p+Zq1JHrIaPJC4fNZKvUfLbceJPfhEq1PK8+S9ZfZb3z4chG4tVhmpbfmS0M0QLgfHngv+SYtbkvAu5FkxSDK5WP+USTw/7NkeZRmOtytU49qNv0NeM5ckRLJ9KU6wfqWX1866YZiVepfjH++8UmAw5tBumD7WrvcT1xfTENSoizVez+apk2HnkUa1UQgaEAkPnbJfjFIRU5j3TCrbgmyKXO6PjBYfodBkn9T2dh5ThgHvWAmg602nLsa7YN4Jz2qfT+o7kHUbLwZ8HaDPaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNnJgIuMkX1y0V2BRId+ruz7414Hy7H4YyDiyLoPRlk=;
 b=iszpwQND1dzJXD/4+l1t+x7+NsSQfM96HWWzbWvdAEOmA4l/j0Q7t/ui1YxPMnSTxR4Y/+ckJ4vPdYazh0djYITVrLicSNMt6dmq3y8kg1juLvPC06YCJu2JnHrHfgNdNigVUbIDfhui1VFB/ScD7Y9sQe41BF6VlqrBp+C0I4U=
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:24:24 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::1a) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 11:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:24:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:16 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 06:24:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] arm64: zynqmp: Add support for kr260 and kd240
Date: Fri, 18 Jul 2025 13:24:05 +0200
Message-ID: <cover.1752837842.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=michal.simek@amd.com; h=from:subject:message-id; bh=2I2WHOUGSmTLqkZ4bh8QcpUtsz0asfRj2SXXqhFCbDo=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRU6V3Tt9Styoqd2TRjhfFlBid5PUuzQ7+4DsYeXTD5d KH19KaKjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiIsizDX0ENSQP5fXdaJU0S J5wy3LDX3eiIqHGdZNVWpsOisas+BTIybDz26sc80f4AvpDv9xva5wrVxTnvdlaa3N8vYxr7puE cCwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c805cdc-ccac-4dd8-f73e-08ddc5eda61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3MLqm44CCsy4WKD0EuUbK0MyM5e4BaU+wD+Mne5X7JUwNfabvFKCXgKVqIy5?=
 =?us-ascii?Q?GT7IquGJ9wGBivCh64hLRXQzuUpoTrfApH1+UrZzlTgonogBmzuHDcIoD53P?=
 =?us-ascii?Q?KCRlD9Mx1drq38/YMoAuaLMKeKnpeMsmBFiTGAuxz7py3epLzk0TzdOn7Y/c?=
 =?us-ascii?Q?HRAHm+0P0j9UukCOPuVWd08kdfObdlEfB14H1fpEVIlJmQkg4g5dnnPZJpH4?=
 =?us-ascii?Q?YmSktZl9o5VuwBiDpJhNDJGCqfgxzBpvx3pmI56UkZ1S9MEDsiirCXWZ4tRv?=
 =?us-ascii?Q?maOJsXPeWyoPlkdQQ1salJWG6HvJmz5RAvAi5Uuge8iFcTzQ9tOBkdfArYbk?=
 =?us-ascii?Q?BCF3lqL/s55ooRChz+GrwM961S7MP23eZNRyG4sxg4PVnpBMtSWjsnSCfKiv?=
 =?us-ascii?Q?uy+i4fOvPFaLWTmDH+UzwtAypSmwzvci90KFcI/VlXJGtFnedGa8XhnqgmJO?=
 =?us-ascii?Q?wARG9iUFgkltpmlAZ2n7kTOdCR3WH10SXhGu8pnkKpcCwoeFEIQUpzMD06Hw?=
 =?us-ascii?Q?ero/tUVxjbOL78Hs9JDkjH7Rko5JgprqAXZB/PMgkWr3+Wha5/IeBgAFHpC5?=
 =?us-ascii?Q?fSkrXMCTHZ2qhlZ5qYoKZGfc1JMEbC+vmqT7UBpfjKxJbms06yMQftpoMfUH?=
 =?us-ascii?Q?KhrNyeD0Lp+MQCQKssvtHGOksVwjzXlh/u2o8PGIe+AOgWsHELcqB3NIEsMv?=
 =?us-ascii?Q?TElkegfAj2XB8t8WyIhCjYIPntmC4xHSjgpUN/ykM82Ut8gShdA6/bCL55uB?=
 =?us-ascii?Q?B9EnuevFtdvMt0eFwxlvZsCca0Vum6THUq3z0FCmd9Ua2SujG44NKoX69t0q?=
 =?us-ascii?Q?Pj6L6lmn1rTvJGDOAQg6/t3aop0XdilYIa61wPJ/K2nqiR+msC5iWPck55Vv?=
 =?us-ascii?Q?vzx+zb+Dptk369nknauki9Md9K1xqQ8Fhr65GcjsrJiAK6xlWfql9os2XDY1?=
 =?us-ascii?Q?YJNPbj9KcZ7prtud1dapUx2pNzEiGy8Cj0+aqC5t3W5K39jjM8oimFsM51BO?=
 =?us-ascii?Q?yYORGB2lbb3kFv1594aUQE7BOEd3D+Hgtx2NriQIx46DAUUD7k3wCmgJkSoy?=
 =?us-ascii?Q?+/TU8pUoFJz938NRvSWZhyKDXnn2BbuF+Cg9DGiTHsrPDrZMIjtuRwLTbaIo?=
 =?us-ascii?Q?4VtBJplZ6ZZ08AD/HNxCXGtPgUS8Xo+Cg1WT+9QVqqfwMQNShXmewGA/vB7k?=
 =?us-ascii?Q?RnMYiRTuTijJ0jdn/zYT02vYZ9ED9PdFwORzsQl3ShAuH72QfrEnEpVzEFi7?=
 =?us-ascii?Q?jU/wUhNyFp1XgG7jrC1Om/FQVWjnc69wDyq311X6X1Te5pf6gW3OMT/T/ckS?=
 =?us-ascii?Q?1M/8tIs+2YZDvYvqOfDwKRo96IXqR/HNoCR7nse5zw8qR5WkqgtV0fR8wvcb?=
 =?us-ascii?Q?yaYLL6vtNNUFKjIwteiKDIh5Hb4VNg1hsYllGYeecsqXsGlzSSSbwbtTEBUp?=
 =?us-ascii?Q?l7Mt/Y/K1wvkCvdHwqGovOimtjrEfwJa0SrBjT4Tjygh3dYNGa9GfF/iCutQ?=
 =?us-ascii?Q?eEEfET6pHy93QOAtCFxfWUcB9C2WPDIPiWsB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:24:24.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c805cdc-ccac-4dd8-f73e-08ddc5eda61a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

Hi,

add description for k24 and kr260 with kd240 boards.
Pretty much both k24 and k26 SOMs can be plugged to other carrier cards but
not all combinations are tested together.

Thanks,
Michal


Michal Simek (3):
  dt-bindings: soc: xilinx: Add support for K24, KR260 and KD240 CCs
  arm64: zynqmp: Add support for kr260 board
  arm64: zynqmp: Add support for kd240 board

 .../bindings/soc/xilinx/xilinx.yaml           |  81 ++++
 arch/arm64/boot/dts/xilinx/Makefile           |  24 +
 .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso | 390 +++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 438 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso | 451 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sm-k24-revA.dts    |  23 +
 .../boot/dts/xilinx/zynqmp-smk-k24-revA.dts   |  21 +
 7 files changed, 1428 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts

-- 
2.43.0

base-commit: bab2fdce8aafb5eb809d979d3de7cb9b05c28dd7


Return-Path: <linux-kernel+bounces-845896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3957BC66D6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2DF19E4D69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF72C15A9;
	Wed,  8 Oct 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5aN3T46"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648B2C0F62
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950609; cv=fail; b=XGsPFeWMeJu24m06W89BnJWc22rIiIFJDOqASFPff9rxAFFk5pX6Z2aVuYI7GuFoqyxTW/Y8QiPboygqbpgm/SKDCTEyGg9so1qCaPOB/sCnEWvZXrkPbxWorOuWbqaT7XZ6AeB+w6yKYa1LJDiLN3qpUUHZg1ZiKxqnRAEurfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950609; c=relaxed/simple;
	bh=ZRJAS3Jl7lHwnQvJmhoGA0KHem62I9CfNV93i70SzuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sr0KA5WFkP985vqH3NQBOJq+/iRrMNJ+d0TJJzHVqN1KrbnY2goQCT9t2bsD9LSDxxrvh31B7We0o2YpW2EEpFmaZickEQiZAUNKjfzOJNuWrrq+yMdQA65Ivg7miwtsB4TxsZH1H92cZJQmWUZNXwjmvZ6Bs/N45vyiDSaBcbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5aN3T46; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZweoZ6cdX13oWVYafjOQS8jESvv4vpfpz2JRpsnSsSeEJYcu1z8e2wfbr9gSw+7hN2l06SDO5sHjzeKWSA1H0mg85KWFZMgNpUzfAxpZM4JmQUM55gKnpIdNBMzdMh7efPPZFHys3Ux2at5pUc/6T0qynUWk1RiQ0F6xMj8lVHVMH9XmlKNzvRo88fiJFS5uVNPHs3da2q34UG5JCrbgxcwiZvxXHf2FOyfjKD5NEbKAchs4Jcoyofocf7Edm72ojpxi1o4xJBixuuwrSisisKbgEQYyiCZ3VBe0EgYNoUe1zox50xq7h1MY+H0K2H2LWkRudfgYI6coKiBSuu5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlWVeY+vESK8rnzUKwuZ7J2BW0PVD5K7pP0zBBJtrkg=;
 b=v18lkKLXeBPVC8g4z+qkx+ZjLHNgoojljpjUUD7GVhDkcKTI/O9FJUwicTj3V6AiGDzguo1W5LvowUht3OpaaOlSioDEaGD8uKIdMI9icWjRUM9KIERmMP9vLFdnTMjDLwuEGYGHGFKDQ+uhbCfaezJfraGqmR2IC2C6MJknZ1kmdHTm6/F8/Rp+6YlCBgxRC63Pq81ah0cnG6VoF7KSe9AAcOecNDFouGlR+DdgzL7Mt2GORXZ9TwFLn+qmQFlu6ZUlXxzq5CPWaMy75lpdAU+4SlJ1mWvVVS0PQgSKNh2hhjBODV7RCcohvzo5y3WG9oxTjbf70KD6AS/Oa9ijTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlWVeY+vESK8rnzUKwuZ7J2BW0PVD5K7pP0zBBJtrkg=;
 b=l5aN3T46pIBsnYnFjEMgY3q/3OIYnFbCxwIWeYxbYIza4Db57Qn8FIUEb19eoFfa4LH/nYnQ6UP164AeJRF0C9JyeizpR3xuGsGpMTZSOCKa+jo5ouFFWUe+4u8HOD1tILhMzVqUM2Uu30fM03Ndw/7diLQU33iiYfWpcTr4XsbKWktzyqLjON8uS+JwEvg/UjGUF1EcUza5T8Th2OkoM6yc8O5Yxy8rw2ipP/QOcVC02DQSGwEVWhMggP0kfZxs09tBVgNMRlKDL2jjZBhtPJUXIAwzHuJdl2L/R1dL4zQwGNhupiXrDb4hh6EOg+BIP0HZmo23t0takNkOT9cSng==
Received: from BN1PR14CA0014.namprd14.prod.outlook.com (2603:10b6:408:e3::19)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:09:56 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::1a) by BN1PR14CA0014.outlook.office365.com
 (2603:10b6:408:e3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 19:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 19:09:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 12:09:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Oct 2025 12:09:41 -0700
Received: from build-vvidwans-focal-20250627.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Wed, 8 Oct 2025 12:09:41 -0700
From: Vedashree Vidwans <vvidwans@nvidia.com>
To: <salman.nabi@arm.com>, <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
	<sudeep.holla@arm.com>, <andre.przywara@arm.com>
CC: <ardb@kernel.org>, <chao.gao@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sdonthineni@nvidia.com>,
	<vsethi@nvidia.com>, <vwadekar@nvidia.com>, Vedashree Vidwans
	<vvidwans@nvidia.com>
Subject: [RFC PATCH 0/3] Arm LFA: Improvements and interrupt support
Date: Wed, 8 Oct 2025 19:09:04 +0000
Message-ID: <20251008190907.181412-1-vvidwans@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd48c29-bd05-426d-7c73-08de069e44e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/yjC0kd8hSSY+dFm9XeR/D3isiweKIr9nPCGywqaakHa1VFh3bNj+50yE33?=
 =?us-ascii?Q?7MluFhFjvUm63H5phb9duc+U5x05Eg9k60nN89mEPB1szJWHIhokmJJdLrzV?=
 =?us-ascii?Q?QGDzXoNlEBXhsk6pQhCuC+A63FrEeoN0u5PIYuun+2WQIoOS6RxG2Ras6+rg?=
 =?us-ascii?Q?ywLMHGvqJXr81NqwEJAZ6jPBXZFJnPspVXisESEZ7zW3yWMsH/AsJ4COYh/0?=
 =?us-ascii?Q?hIVR/SHcTU1sJT4Df/BVJcUgTxUT93q5M0MkSNi5Yaz4fzkNEum0Wequ6v3r?=
 =?us-ascii?Q?3pwjxcn9eG6lU0Qd1vvsWQeVC0LYLaK6zOYJiT7VONLfVdf2S4l3QqBnK1Ax?=
 =?us-ascii?Q?/O+LfVBZI68CJ8mPr3GMd39ZUeKVDFOUoJB3DI4y4SzQkOHaNgpVhQfvToTQ?=
 =?us-ascii?Q?dP7Neu6ln3W7MvFwyFw1WXscVO7Ag7X65zVOIsi+2XyNDO9kFliJHG9uK+Wa?=
 =?us-ascii?Q?qfJXOtr4LgAkN9oofreKjNQT9ps3Tv1PzxxGx46DJy9/mUll5MfkO5jgFj7Q?=
 =?us-ascii?Q?kyu+kpOLuaYdr824hpp0TN2gpjcyJxIhuH8DWlxS9GGcaYQPFWTaeWIL56Wq?=
 =?us-ascii?Q?nNSV3MNSVnBVODewXWwA94jls2dNXRHtaVtf8j1Ms59ruyDh7HTKjbWfVW2P?=
 =?us-ascii?Q?4RpM+bRbfdyD9FBtcuhk/Um2D5PaHaERGKybJ7gkFZ+sODVANbWvXf8+esOW?=
 =?us-ascii?Q?wfs/2XGqN7/8Qf8zY4nP5e2Ut5GUxWIAgl645Q9runsu+S637hQxHf1m9iGP?=
 =?us-ascii?Q?Zxi3Z4oTlLr2hZFq1cGpRRy6wJBlB3pHwqYvX9+sIni3x0XQsJsuB9u1qcjx?=
 =?us-ascii?Q?Nf1L73KJioOaNAqaGCU2bkVZwk2jC8X2hz/KniPR0O2DWRZ0BkipNiio07On?=
 =?us-ascii?Q?sojPWJCgUjuNGfA8o594V5F60ziRR8AQaF0TWnbUrD7jUed3GOMMm6MOIH+e?=
 =?us-ascii?Q?p5LpnoWg/OWM8HuwLJ9pFNcxBQ/fvEQvcq5F3MNTHOoxls8xIX4mUU7aJ7+Z?=
 =?us-ascii?Q?z10151hVi7Jk4wKwOLIWamAxUHxTcpHPUrwFl35SkhayuHSadzMF7+PULdVA?=
 =?us-ascii?Q?OOY/1f+SMzahh9Zfxd4hfI2jBzPafqc9ihZjg6C4qZjZumN+TzeRXR2zMtcG?=
 =?us-ascii?Q?KwowhNhKUY1ZJolk83vbbfj+3/Naf8HP0HibQr/rSBRaKIXqof0YCoLKB00f?=
 =?us-ascii?Q?h0qrMV8CUdU8RbdCPtZkFbAnpkCCOeLCrCSZIuTHY4/W4f05nWLbHO0YP9Pv?=
 =?us-ascii?Q?5z+D7gh+XWR8xbAgX+/nfx5MWSCk+PSrhi/cC5/CSf3XkjyfRf+YpdENRwoP?=
 =?us-ascii?Q?WjbtiYt7Ht0hsEif/RJrIsrEajTV1A7ZdNprwj+LOJnKTR4Z7dtWJqx/zoUT?=
 =?us-ascii?Q?M8syG6SsTaXxSE3Yg1Wy1sjJUnwM4mtnRosFlGzNNGe9/pi3afdNWLPayUKo?=
 =?us-ascii?Q?vX5kVE4NDpVf/pWzeqbXH8JhNdqyUKDraz7KAtOY4FkvmvjH5ELADyp+NcHc?=
 =?us-ascii?Q?h5929ZoNmJ5ZHzwgEiIBpL2yYdC/C9YChYPOy7RDRTjSAQESPXRBAh+J8RgN?=
 =?us-ascii?Q?h1k2BAhRuvAaIyzuPRM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:09:56.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd48c29-bd05-426d-7c73-08de069e44e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

Hello,

These patches update the proposed Arm Live Firmware Activation (LFA)
kernel driver [2] introducing several enhancements and improvements as
outlined below:

SMCCC version 1.2 or later;
As per the specification [1], use SMC 1.2 to invoke ABI implemented
by the LFA Agent.

Interrupt-Based Enablement Support:
The patch extends the proposed LFA kernel driver to support
interrupt-based enablement, as described in the specification [1].
An interrupt thread function will query available firmware details
and trigger activation of qualified firmware components. This approach
allows the driver to respond more efficiently to hardware events and
improves overall firmware management.

Mutex Synchronization:
To prevent concurrent firmware updates by interrupt and sysfs
interfaces, mutex synchronization methods have been implemented.
This ensures that firmware operations are serialized, maintaining data
integrity and preventing race conditions during the update process.

Polling and Timeout Enhancements in PRIME / ACTIVATE Stages:
The patch introduces polling mechanisms and timeout controls during the
PRIME / ACTIVATE stages of firmware activation. The driver now
periodically polls with a delay to check the status. Additionally,
overall timeouts for PRIME / ACTIVATE have been implemented to guarantee
that the process completes within expected time limits. The initial
timeout values are deliberately set to be generous, and further tuning
will be performed after thorough testing.

PRIME / ACTIVATE FW components:
Interrupt-based LFA allows OS to trigger LFA for all activable FW
components. Initially, FW components are primed then activated
successively. The later patch modifies the PRIME / ACTIVATE stage
to prime all activable FW components followed by activation of each
FW component. This minimizes the time with combination of old and new
FW components co-exist.

Thank you,
Veda

[1] https://developer.arm.com/documentation/den0147/latest/
[2] https://lore.kernel.org/lkml/20250926123145.268728-1-salman.nabi@arm.com/

Vedashree Vidwans (3):
  firmware: smccc: LFA: use smcc 1.2
  firmware: smccc: LFA: refactor, add device node support
  firmware: smccc: LFA: modify activation approach

 drivers/firmware/smccc/lfa_fw.c | 429 +++++++++++++++++++++++++++-----
 1 file changed, 372 insertions(+), 57 deletions(-)

-- 
2.25.1



Return-Path: <linux-kernel+bounces-889737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92961C3E5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8D7D4ECC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491002FD7D2;
	Fri,  7 Nov 2025 03:38:36 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023132.outbound.protection.outlook.com [40.107.44.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1A2FCC10;
	Fri,  7 Nov 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486715; cv=fail; b=AnnUApZeMjOjCLAuygXj40IBFePQ9d3timOnLxiT82qasCc504//8JgEBsy4xlRwqrspJ2rF48INtkMc4pLhMVfXdksyW41m5kz2EX62Jay4SsVQHtR6XwNKs108iEJDDt8nPiEtPyMERDC9Y6k6WyXdtTneEk95l9a7ORJyzMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486715; c=relaxed/simple;
	bh=r4X1C0uz7YiCFYOHNCxwMrRI1gR6t6PSjVmPADQyj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZWUYplPpESEd3XwWhJpy4OPO+PjBfjDDBbIh90OZcLcDJDZc7lnll9HZ7B8FGtACXxZ26LDJ5q7bACZ4wPMCceQP6gM7kitTScM9TrEKUT1O3kpz9LBW6cBW9xY/7kaCErjpmJ7YDS+4uk1xCGx9/ZNtE0R38cYypmB8SR6tyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh5zjiu/u8+Og6EEEbAEp6sQOr3qqtwBJKxL9qqgUkNo9G8LTrU8jgEh6CzWPmlRMbqbGty7bDP8SnNUi+kQcBEOE5xBwKyj7t/FaN1cyukyas1S/kgSkvJnuuuJlDD/OlKNmj9fKbpOvhCRlCHt9PpGJSxAzyeOKjRpqYMH7W8YzdFVjvolbUcZHVi6GK0qGFun/Qi+Z0lGYi/2VdyGy5fVJHm2/W930SnfP4wnoV0e3W/71JtZEh+iRuGZ/dLViVE7wG16rC4AQLTWRCadrKpK2QEPKhMdqgJBinZ70pbdg8toaB8Xulk4oQv8pWKixlkHPEoNRmQjGWIR510hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNkfdbKFMQotV5Dy25aNC7BLQycr5rHxg7vBhNpM7gY=;
 b=jjR3Rx1dBkaPGieWBJJXVmF1Wnu0GoBO+vRHhKXB+utgf3UK2RPnI3lIhTh2vZ7Ypc1oB7p18BYVUMFJ4OSyiNiMWKHZfkBVoBUVDAHLJNXtCq0TCkK1SKAQQ7FsppwKsRowp3l4McrDg5TEJq4UKyEJ2v4MSZ4zyIUVwYpDUaIF1jM/rgh01VSKhOehNtQgg8OoXvxXMUB5UUzF2u3ZRPkhvkEyF4KETTfPU4p6ivbwqQbngCKyWPtSDg98VGoY5rdur233j32rUE+StsIPzBF2qLwqJjpGmj+fohEg7KtcmOKqthPFDCOOXrypytsiWCgSTUMHvLWrqRcpvhsJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR04CA0016.apcprd04.prod.outlook.com (2603:1096:4:197::7) by
 TYZPR06MB5276.apcprd06.prod.outlook.com (2603:1096:400:1f4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Fri, 7 Nov 2025 03:38:21 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:197:cafe::54) by SI2PR04CA0016.outlook.office365.com
 (2603:1096:4:197::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 03:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 03:38:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C9DCC41604E0;
	Fri,  7 Nov 2025 11:38:19 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH 0/3] Add support for Cix Sky1 resets
Date: Fri,  7 Nov 2025 11:38:16 +0800
Message-ID: <20251107033819.587712-1-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR06MB5276:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c1a80a8a-2628-467c-b84d-08de1daf18d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWWJC/M5kg7V3roji/hMM9ynhsXrBoKyvZYVkJjN/14B7ZKINO0wGhLLOq6D?=
 =?us-ascii?Q?3TuWEXge0xapIyK8zsaY4ghMDIXh83x2gZ7+oAmhl0HkaLIwmUOzrhStSX+3?=
 =?us-ascii?Q?wI2vr0F/WwkEuCSATYNBXfEHMlu5oywEKlf7t9hggOIUpJXCC3H1gam9fUqt?=
 =?us-ascii?Q?VmpM3ksPEv9yQLHSJa7PoIcUPbBCWHB5IRzJDRN7Cs9v3Knbuyir5c3GQQ+A?=
 =?us-ascii?Q?GfC2HXQDoTdHnkBg+ydJIFSXECE2IwubvJW7QTuuuu90zqEshiCULLWY6lkR?=
 =?us-ascii?Q?t0sjLtBAQYLF0QlKOciGImu8HQlEOJiaJOxGc35tR+m9NnOkietEKygGVAuN?=
 =?us-ascii?Q?vgjF+D3iVkuk7vvKYZCxo1ZVRpc2TWJjcSV+5Q15umvk6OCtFxSwHtytkhEc?=
 =?us-ascii?Q?7fk50jH5phbdsJGBj8APqGElbbCwxciYSUnbLS4O+W7/ZusRo2iq79VK9C9D?=
 =?us-ascii?Q?rtEM1fO+l2xNgsK2d/NjRpVN+szPRXgd3CnKt+02iUxpg/JONNaW4inT0Ola?=
 =?us-ascii?Q?OtYqr9WmKljysuOMuLXU8YPyrZODHkjQKQF4LJOjJTWs7P5g1ISCIiA//M8C?=
 =?us-ascii?Q?kBOgjpiECHIJeMPruI/ZmNMG1GfQjGUmR0ObA4zTAaCjXPKar0L6k7c3jj08?=
 =?us-ascii?Q?EmS1xFdKoZeglf6sGU3JHjIsf6BYeWu5ZkjwxJroSw75fvQ4SF4LRmSo3l7m?=
 =?us-ascii?Q?dVv84v/PtpT2AmyFZi9bp9E7ZdyDhK7g5HQ7uhUwECuoyHO5duJaLdZiLVIw?=
 =?us-ascii?Q?7aRDLJpVNUvygKfl83OOzjzTcffE+AoqJPEyAkJJ6QXkFSm6ZDBp3n3bBeyZ?=
 =?us-ascii?Q?saCUl0ZFova5eVKHKu8Pa/MgAtb46GHG2dsxf9NZsqJ8/YK+Uxp8xXNvY3b7?=
 =?us-ascii?Q?y9Igxk3Ec0gN5Jcbn7lxtbGQyzIGDMHTdf8pVByP52NYfD6CIzriGE90q/Qa?=
 =?us-ascii?Q?zUCMrYzU655QTOszHEndrlcL+go61qCXwVHCKJ5hx54QGu6Rd8X6onnrEWRI?=
 =?us-ascii?Q?RhXoG5PcGRRC2dqzAY3wnqXoYMUwclHB8S0q0K9CkfhoU6xiKUY0O0BZQFgZ?=
 =?us-ascii?Q?btVo+jkPAReUFLi2WTKwYpEd9Emw/7FvKilq+I3HkYTSyER1fmkoCY3N50QD?=
 =?us-ascii?Q?mRw1Dtnm/zuOg+Ebw69pbDrFZDUccXUdaA6Cb5i0Tl6nOeXJE55m/nG+qlPf?=
 =?us-ascii?Q?JH2Q2CSN0+7RjEF4d+gtvsmU5PW8zaLVJ22p0iF74yslGOA6LfCzJkUxCh3Q?=
 =?us-ascii?Q?bd7cN8MR/A9txjARkqG194C6MSDLRMEoGsvJaVeOLgs4Jx5M/FCdfaOyi4pv?=
 =?us-ascii?Q?LCyienO2Oj93aDXvi9QwqlXcnYhFdtMEv9Z5Qf0FJOAgGCvUA4qYUThnpyMe?=
 =?us-ascii?Q?iECfV1i4yKCwE/j0Fb5QBfeJXITou0YJNlKsSLX+gNM28EU8xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:38:20.4036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a80a8a-2628-467c-b84d-08de1daf18d0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5276

Patch 1: Add yaml file for Cix Sky1 resets
Patch 2: Add driver codes for Cix Sky1 resets
Patch 3: Add dts nodes for Cix Sky1 resets

Gary Yang (3):
  dt-bindings: reset: add sky1 reset controller
  Reset: cix: add support for cix sky1 resets
  dts: reset: add support for cix sky1 resets

 .../bindings/reset/cix,sky1-rst.yaml          |  48 +++
 arch/arm64/boot/dts/cix/sky1.dtsi             |  14 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-sky1.c                    | 403 ++++++++++++++++++
 include/dt-bindings/reset/cix,sky1-rst-fch.h  |  45 ++
 include/dt-bindings/reset/cix,sky1-rst.h      | 167 ++++++++
 7 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
 create mode 100644 drivers/reset/reset-sky1.c
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst-fch.h
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst.h

-- 
2.49.0



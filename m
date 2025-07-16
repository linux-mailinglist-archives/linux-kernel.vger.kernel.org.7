Return-Path: <linux-kernel+bounces-734077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB6B07CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D468A1894CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9552BF014;
	Wed, 16 Jul 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Px+WmiFh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CD29C344;
	Wed, 16 Jul 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690173; cv=fail; b=GuZX8JgoOnx4sk0uhZvp1Xx3I5mpZtmlNblPOpl3eZ2cEpyRTIYz/373C3vWp2I1X5X+4qbsmtgGJEz30M/aDSeWHPQSFtm3S7RMhS4azXc4mkcTv/K+oj7C1KkzlKuTKs4/wfAqITP/k1XQ9oMqzoqmM2fhp9vM7+NyEDwIi98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690173; c=relaxed/simple;
	bh=/NHbr8LdSTtIR/sT6E/6WcGZAcMEn1rWeXwmontsJ0M=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dpNjK7UFwVpWXZHBkRMBkHXpY2ERDYIkAiK5cZyAN8gDqZ5EztCWc+SrekCV8J/6DaXjSbuGxTBNxIKTWehUO/RHd3nvDdoRX/eW/gUsrIBKADMDQz+x40o/dhe+nKsuXC8baidfV5oo0YcEYhX0HaoswDAkM/zOf7y5wR5MFig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Px+WmiFh; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyRHidFwbVbHAcFhBP7nPuuEWQCYqHR5jvbY3q8Xbir5eoZRJQf8+3/IKDAC3CK7A4ly22hsXxy/LE28IFr7mxykU1p4IOLUE0fbJVZpC1GXx9E5HvP155CAFy1GDFbuiwhJoefVc4mfO29GZrpLkJJjzPWk9q9Y63x9wKEacNiqliEb5LV7CTzYTirfMsBmI3J0ghfmeNyZ4s0C0Lw1ntYZUPUZfDLFQOIur3diUFNwr3XZ3ITBAx5ehnG7/zcKUzSro401+7/b7wm0XNvRxo+3J8CQeKRiU8f8zWzHKI3B3pQjAJ1goKCWSjaSspVPbf3QBJ0nijGiVEk1b4rCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7oYOKcX5fBzt82SdFH90QNLUOxe4wmKdOUm6RefDgM=;
 b=Adobk5HV0VztmVSLzbPnDwD8sGAtqbDqq/rHjzLcY/137dzE7XpPw4OwF5q+mXaotkQyQwnnwTBTZaEL42xmaxO9z9kakjUMsLkFqjUqmvG3SgpIvCMFB8+qMUWI2+pAUAMqKHVSzIxZDS5jguMp3QnhluNWPI3f9tBptoWQf9aoqQZI661A4qrzyLDM5hvOHZ8QkfyV4rgfog80neyswsTug4WTRJmlNQ6vd8d6FFdFm+4Vukrw2x4LPy1hxL7WC02oDHgywA0aZFrI+udk9XP8HeeAaizgt2xzwWVvG7FcEjJaYwsenr4Ea1Rvz06sYsqxa5wcv2vXFVEHziTlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7oYOKcX5fBzt82SdFH90QNLUOxe4wmKdOUm6RefDgM=;
 b=Px+WmiFhqt0xlB0R2l0YAzDYWOF8wQncFqdvdjxaeGMJeHXV7P+RvDTuyTCD8zZUFAQwaMOgAgFWLdWQ9Mgyi0J7H1Zw98g7cnGy1sSMqUPvEepEGzC3pTfBDQaWfB2BqnXR0vpWW8C/ZbOHzQMICxwoVeSNvIKcJRzqOz1LQJnuhxSELmvHiARwqa04EyGx8p3Y7tJ0YruPVYZ2j9LE+k65jkRIkJUGVZsn4HE/XdmNmNjqM5Hx+Ke6XCjxUV+iSgCWLpy6duUgv1YtREtc+hej1dSjh4eHfU/FhU8KdnnhmVU7bhZJmq78NcKvuazxHYvngo1DvZXa/C/ybdIZ5A==
Received: from SJ0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:2c0::30)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:22:49 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c1) by SJ0PR13CA0025.outlook.office365.com
 (2603:10b6:a03:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 18:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 18:22:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:22:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 11:22:28 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:22:28 -0700
From: Willie Thai <wthai@nvidia.com>
Subject: [PATCH v2 0/4] ARM: dts: aspeed: nvidia: Update DTS to support
 GB200NVL hardware
Date: Wed, 16 Jul 2025 18:21:54 +0000
Message-ID: <20250716-update-gb200nvl-dts-for-new-hardware-v2-0-9a1a916f461d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLtd2gC/0XNQQ6DIBBA0asY1p0GIdjYVe/RdDHCoCQVzGCxi
 fHuJW66/Jv3d5GJA2Vxb3bBVEIOKdZQl0bYCeNIEFxtoaQy8tZ28FkcrgTjoKSM5Q1uzeATQ6Q
 NJmS3IRMMrZZO99L22opKLUw+fM/N81Xbc5phnZjwjxtlTqy0IKFH22l0evCtecQSXMCrTbM4j
 h+iIbeKsgAAAA==
X-Change-ID: 20250716-update-gb200nvl-dts-for-new-hardware-b130d390c93c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, <openbmc@lists.ozlabs.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>, Willie Thai <wthai@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752690148; l=976;
 i=wthai@nvidia.com; s=20250525; h=from:subject:message-id;
 bh=/NHbr8LdSTtIR/sT6E/6WcGZAcMEn1rWeXwmontsJ0M=;
 b=JINnfzlfOKD0/0YkzTO64AVjLQNMuD4C86XR4P3z4C94I9c5riHRv0QPstv45iUKZN4W2EmIH
 /royMtvuOrEAGkJcYPlxg7lB5ziruqBYZkyvjq+WixyxjxMLShG+TSl
X-Developer-Key: i=wthai@nvidia.com; a=ed25519;
 pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a9f23d-38a7-4e7c-e0f8-08ddc495c4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1dIV0xCTmYwVzE4L1VWRCs4dlU0Z2hubFFaOFlGaGVmMVRSQ1VBYi9mS1Js?=
 =?utf-8?B?NkxhOGNCeE1UNEJUTk4rNUl3MnlTTnV2L3NNNGZOTmFzYXJweXljZ296bGRH?=
 =?utf-8?B?Z3l6SDI2WVRsZXJlbWZydjJpRlZsOFh2V0h2cHprdHZOb0t5c0hDUmk0WVBO?=
 =?utf-8?B?RFdVWm1hRDhGRUdqcERyczdXcXo5ZmVEc2FWVS9NSkN3MnJUSk95ZVFNTW0v?=
 =?utf-8?B?dndZb21PUUduZ2JJMG9sc2xyTWx3S2QyNWdJQzJ4b3BhSXNlU0hEZ2phbWhE?=
 =?utf-8?B?ZnhVTDJTUEFUVTJnNWwrRkhOd3JYcmdINzdpcWk5SGVpajVrOEdDMWZPcThz?=
 =?utf-8?B?UmxKWmMwSmI2YlU0ZU1hUXp4NXJHYjlLTnNxU1Y4TnNiVVhPOUh6KzdqTmwr?=
 =?utf-8?B?bjRQOWU2UjBTcHVnd3BZNXV6c0JneVh3K0tXWVk0a1hnUmcrWjhEbGxiWjhi?=
 =?utf-8?B?bXZsci9wTzJ5ejFFT3NPVERwdm1JcjZ1clRsemxJMGRMNTRLbE9BYTFZdWZW?=
 =?utf-8?B?dWZZWWowZC9zZ3E0MlRtZWgvcXV6citEd0xUemNnVnoyQ21wWkR2OVEvNVZo?=
 =?utf-8?B?UExOTzBUWnp1ditqNzVDeUZQVVBOejhGd2xNa25saURrbm5TQmhyUjhwY3JH?=
 =?utf-8?B?a2dqclZIOFR0ZHBQNDYxQ0xLcjROWkZpNkxSU3p1Znl6aG52V3lIOEQ4bUQr?=
 =?utf-8?B?RlhnYWlxRFVOQndDbGgzdFFvMVJERDhpd1VxZkRVTllWVUNQbUF6RkQ1Uzdr?=
 =?utf-8?B?elFrY3F0YW8zelNoODlvQjFrUEFzRjVCekxqaUI1Rmwzdmwvd3ZwWm9pcEly?=
 =?utf-8?B?ZklhajBQcG8vYUdJdE4waGpYTkYrTmorbkRLL1R3UkJGZDhDanNMamxLdHN1?=
 =?utf-8?B?d0QvaFdndDJrMXMvVnIwZU1rUUtZOTdmSDZKMVZJRWNlNXJ5bjFHbG5iaVBu?=
 =?utf-8?B?L1VsaFkyZkVDYXdIcndhdVQxVWtNb0Ywdzd1OFV3TFF5aHBBd2d3MnhVdjdx?=
 =?utf-8?B?VzVUTWMyTlJiRVV5Uk1YemRLR0hEdHVPeFZ5QWZSejMwaWJIZC9TWE1WQkRI?=
 =?utf-8?B?YlhkOGdhS3c1UzYwRUhJYWFTNEdrbXBVWFZ0UFl3Y3VZVVI1YnBnN3o2NjRM?=
 =?utf-8?B?ZFA1RlZ2QlovU0xoK2dNem95Wk1ra1hTZThlSW8yNXdHQWgvbGZMa2tnSGQy?=
 =?utf-8?B?czR1TmRKR3E5NTNqTmwzcjVjK0VOVzFCWGlpY1c4UDNXUERpenk5VGJZSDNz?=
 =?utf-8?B?NHdsWldsL3lwN000YU9XcmVqcXVyeTJoRDY0UFZNOG5UdEVxRnlrOWxiRXVm?=
 =?utf-8?B?aHJ2VDkvRzFFTXAvbXBYU3RFWHB0ck5WeHVUWWxzR1AwMElBOVo3bXRkUUgz?=
 =?utf-8?B?ZzkvSEVVa2ZJYm5VOEg4dEJSYnUzTkVpd3Y3a0o4RjkxeUtNcytlOUxQV2lx?=
 =?utf-8?B?Sllkbmd2NEw1cm52aWU1L3JpbC9CZHNQdmI0NDVlUWVZY1MwL0VCS21KbmVJ?=
 =?utf-8?B?aTVOem5PYUZEMXorVlZMaXJXblR3L1BKT3dJNk1keUFtWUlvM3I0Yy83VjBS?=
 =?utf-8?B?bkZZeWY0WDFaT2Z2VFZJTHJLay9tcTM2SlRmM3I2a3lNd1AyWTZsNFlOKzVL?=
 =?utf-8?B?aTBmWkIwdnBNV3lZTE9YM1NJOTJ6Y1RzQnIyQnZvU2hsZ0lRMi9ZYzR6dlor?=
 =?utf-8?B?TFA3QzZFRjlXRnp0ODlFS0puMC9GY2d2b29MOXpzWkRNRldOekwxZEQzdGxG?=
 =?utf-8?B?c3F2R1QrQ2R6OGx3TnlSSVBzdFhtK0JYVWpRT0Uzd0FGQ3ZUMFQxZHR0YTZx?=
 =?utf-8?B?dm91SllycjJ1MS8vOHZtQXBoT05VSFk5ckd4K0JOQVc2bHZEY3lHNGtyeW1J?=
 =?utf-8?B?eG51R0VpSEhSVldxeEU5TFlEZjkxSkozR0Y0UDNGVnIycWU5b1NhRklsMUUv?=
 =?utf-8?B?cEpNSTgrNW1PclNCUHlyN1Fpb25QYzhMb25OOEdUUm9jZGlsZFhwSlBtbTZZ?=
 =?utf-8?B?bE9HV2dJQTVEYUhPQkdmY0w4WVFUbnFXTzVnQkVOdGlnYzBLYXE5SmlUVlhL?=
 =?utf-8?Q?rASyQP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:22:48.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a9f23d-38a7-4e7c-e0f8-08ddc495c4ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

Update the DTS file for the GB200NVL hardware change.

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Leo Huang <leohu@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
Changes v1 -> v2:
   - Fix unevaluated vcc-supply properties [Rob Herring]
   - Add MAC0 [Deepak Kodihalli]
---

---
Willie Thai (4):
      ARM: dts: aspeed: nvidia: gb200nvl: Add VCC Supply
      ARM: dts: aspeed: nvidia: gb200nvl: Enable i2c3 bus
      ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the HMC gpio pin
      ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0 for BMC network

 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 55 +++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)
---
base-commit: 13c9c6eabf033ed4f369ad4d29bdc58ed4a411e3
change-id: 20250716-update-gb200nvl-dts-for-new-hardware-b130d390c93c

Best regards,
-- 
Willie Thai <wthai@nvidia.com>



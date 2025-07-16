Return-Path: <linux-kernel+bounces-734080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E505B07CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA83B64D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027C2D5C74;
	Wed, 16 Jul 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvmqH0le"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD62BE033;
	Wed, 16 Jul 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690180; cv=fail; b=N2gmSrgBurVI4cjOiVPBS9KVcsk8djOSI+uO/BoOkpKoiev1hsusM45VXtYDrMBlgQoqE5MNjUkTJSKIvGOnQXB7NOvpDGYMfvzoBfoj3CUHuovAiEApIimHw/ztPWbVo+fMv7Iw/x5WsIwhW97vmntp/NcKU17gR/IhZQkRxH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690180; c=relaxed/simple;
	bh=/7WOo+BtJck4Q4y574hjut9eq1lt1iHGoSpns4D/l7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cew8BjnDoun4UYCRyMrvOt16MBk4F8oUQgRE5aY93OwRQAtBpGGry4+7LJMC+vgzhBoVvEcsZag3GFLRpeO52wTmd97IbaeZLlFfbNd5bSIznlbyR2AWQnLtesw7o37xkr1cfg0lIPaSlgfhcYIXs+kxL3Wk33wQ7G3XueL3zXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvmqH0le; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MesYoWK7I33ahnrPTMGAWaYiaeXBJK9f8k2llOK8TVL+MkW78bsOg038KbcWerUzt670k+a37e/dEff+hizNaDoRJoGWvF3sTVT2h22B8kT+nFQ6v0S5hvuObsElhXkQbFKOKPnGWsYbgnaMbvh0psUvGVzwGZYfowpr+/7DJx/C80QkHPPfZjCWujBmuV3uQMbVSOuBwdeEkL8JLXG9kA7Pny4pNW/T/j3Hvl9U4J/LfQBMRe3Bi6Gsc6m+UYU3M33P9fDznbfjD5kL/SzgEi9UVEHJ4m/2buUCGdC7EzLDht3UzfKNXVm01bJaM3jPWuKU5NRP99EAuRqAQkkWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucPit7tmu5ulF5bTmehYuLjm8MFVibaVK9xDS2DVKGw=;
 b=enZ050e8vpQN0AgVh+snPO/FLyWLjvbAnCSEc9hylzORRGVpB80RzYfKd0EYJrbgwQHI/I3YTdAnoy6FmZt0v46qJBXosmlCNFxc54xsaJoyQoaDx/QqCxB67vyvDfjOEwtnCz9zDcyDYYs9dRQzKqEpfQeH3WDzcev4+x1etgziezTryqd/XO9D1SHKbtgcbL1j1l98zle5T18enT3ePyiXgse1+iW6rEe4e2RvZNyvTaz8Bgm4eRXzOtlRENReysEppv1PGtyl5+Uu1gFMMVVqgX7G+5Qxz/qB7ARw8zbYnmExIXrFsrmdoLXxnKlNEZ+xfkFxEhiGDxIRY96pFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucPit7tmu5ulF5bTmehYuLjm8MFVibaVK9xDS2DVKGw=;
 b=IvmqH0le2D5Sphvp3F35SKYP5mhsZOnNNGXsjt3FW8ZFmrlAB1BhcAUznpsQe07L02TsCDQ7CY/RQ3hRlcvCjmFdzmd+UrLo13KKQKoryfKtNhCOzGKheQZmLo0S/eLNiGBQfJWtn1N7Oe4U4bHIHxnUlq59hRz7v2CazQbscMRoh56cdmaJ6hXeIsF4YiaTJSC22lBnMk3KuY93Ig05suuazQRaCZJay5F4IhHjQDeBw9mLHO352tIVFjtKpy3UVi5QPByTkTdtFpU7/fmxKRamEWzOh8i+atZEuMNJM6WpNZCdGFd8yHKHjuUR0DJrhy1L5NORs41OstEf+BYeCA==
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Wed, 16 Jul
 2025 18:22:52 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::98) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 18:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 18:22:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:22:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 11:22:31 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:22:31 -0700
From: Willie Thai <wthai@nvidia.com>
Date: Wed, 16 Jul 2025 18:21:58 +0000
Subject: [PATCH v2 4/4] ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0 for
 BMC network
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250716-update-gb200nvl-dts-for-new-hardware-v2-4-9a1a916f461d@nvidia.com>
References: <20250716-update-gb200nvl-dts-for-new-hardware-v2-0-9a1a916f461d@nvidia.com>
In-Reply-To: <20250716-update-gb200nvl-dts-for-new-hardware-v2-0-9a1a916f461d@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, <openbmc@lists.ozlabs.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>, Willie Thai <wthai@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752690148; l=1279;
 i=wthai@nvidia.com; s=20250525; h=from:subject:message-id;
 bh=/7WOo+BtJck4Q4y574hjut9eq1lt1iHGoSpns4D/l7U=;
 b=/YwoTnxHvM6hIMX86j7g+tO+/JNzdSQxLmZwG5wgbVuhStPoHWUmBiJuaMM4rYwfDU+btOs31
 RCF61PKayasDdyT3TPqNlUhHQl6j/YgVEgj8O5cVGyVWyUZ3SnMdMp+
X-Developer-Key: i=wthai@nvidia.com; a=ed25519;
 pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 872d3cae-d115-435c-69b1-08ddc495c5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENYWTBoSTFTalhJa2dnM0NTWElYZU1pb21Yci9zaHlWZVI4OGVjTG5TSkUz?=
 =?utf-8?B?S1IyNTgwd3JJNEdoTEUxek5LRHZDNzE3RG5uYWZBNUVBRjA5SnMrSEtKR240?=
 =?utf-8?B?YVdmdSsrOHNNV0ZJdWNmbld6MU42L20zQ2l5eFFGU3NzdFhvUjR5QWs5dnY1?=
 =?utf-8?B?VGNNVHBrRU1uQU9HMjZ3bDVMSlY2ZG56aFRBK3JpL2Z0VkV4Nk1yQm9WSFd4?=
 =?utf-8?B?UTJ2dDlQOElxTmhyalhFK1U1SlI0V1cxVHY0V1ZlOTJpVFhoYU41NmtvOUpk?=
 =?utf-8?B?ZjlxMmJ4RzBNczVQL3QwejlOQS83c2ZGK1ZaWU9YOENrZXdkbnRyZzhzUVhC?=
 =?utf-8?B?K3MzNERZbmhLQ2tiUG8wRUlvWjExS1lEMUFWT3AySC9QZHNmNTg2eDJIclNs?=
 =?utf-8?B?aGtPUU9MTStTb1lWbDdTdEozMFZ0aTUxOE8zbFZ3TkhHT21SMUdrMDQ5MUl1?=
 =?utf-8?B?OHlVZjdZOVI2VFNoVS9xMkxYSXhudEN1UHl2eHFUL3hhODJVUnpmczdUTVJV?=
 =?utf-8?B?a3crb1hUVDRXMTFhWVNtYndQTEhJMUEzSHEvZHg0Wml4dWthQmkxWFVsK1dk?=
 =?utf-8?B?R0NKbHo0RTF5eUh3K292NFlxNkV5QkFqTG1mSzQ1WGNrSVFTT012UWdPMkx4?=
 =?utf-8?B?TTVlUWFxQUI1czAxbmxNMmd1ak8vNDFSelFwZ3IrWU1uZ01Td1NuQ1cvOE1X?=
 =?utf-8?B?djdtemVtbUxBakVzYnc4Zm1iNWlETFEwOEdkQW5KdEd4b20wak5qQjh0WWtm?=
 =?utf-8?B?Y2NLb0xQV0x2RCtEVmw4M0ltYkk1SThYakpXNFRlek1lWkptSmZpcXlmSXRJ?=
 =?utf-8?B?MGFrWEpuT2lJRHQrWGhsSjBtM2ptb2lvdkFUTU9Ibkx3bWk1anh6MW1Ta1dr?=
 =?utf-8?B?L0dnSVJpcVdLbzVmdDdRRXpVb2ZZcUc3c1NTRlpmcVFsZ3hwcFhudnMvNGtl?=
 =?utf-8?B?ZUkydU8wYlozb0I0Qyt4eDQyaFk4cUNnWS9xSDFrU1Q1YlpUZzR5TzVGbDMz?=
 =?utf-8?B?YWIwK3ViSWY4R3hSVUQ4MjJNRnpNdWFFYTZaL01LS0k2QUFrS1VIdkdaampH?=
 =?utf-8?B?NnVBQ0xMRllvNkFNMHNQM29scHZ0VStzdjNhd2RmNXpkM1ZjTXV5Z2ZGZ0tr?=
 =?utf-8?B?SjhnQkd4bE9qVjJEREFRS2ZWUFQ5azg4NGtqR2pzYTVlbGhiTy94SkFGMVF5?=
 =?utf-8?B?bkVZaFBVVDl5WnNJNXl3cXhSUVVZQXpicUxxeFlETk44N3ROd1gxclB2MDVU?=
 =?utf-8?B?VFVQNE9Hc2VoaWgybTJZZ0xwTFVwTmNWSnNWemNEWUdocm9NamdjQ2xSOFpI?=
 =?utf-8?B?azFDcHpPNWQ4Wk15M0l2bC8wL3NLaUp0ek9ZYzI3RU1pQXR3bTJSUnppRXFl?=
 =?utf-8?B?VzNNUm5YdHVucTUxaTdQUlZwTUVWTE5IR05UTTdZeEJTYWtnQ0RVVkpPai9s?=
 =?utf-8?B?Z3hXSzltREdvSC85T3BheVA1bUFRekxBWlB4ZVJTVy9idGpZeUJRVjIrdVVv?=
 =?utf-8?B?dWhrd0pITmtXQytMUTZtaTRXdXRDaDFIRXd2eU1nTnF4OTBCUExQVVdxeVVz?=
 =?utf-8?B?WUhtN29BZkV1ekZObzZwQWtQWUFKZFplTlN0M3FtMDBEL0M5bFFMYlV6Ykgx?=
 =?utf-8?B?T1ZsZXdDZThJaEtNd1h4ODREOCtzTXB5RTVLNXdtT0NmbTFySHNvbCtCV1Ju?=
 =?utf-8?B?WVRXVW5TOU40NXlwSm12NzNqZXhjU1d3MmJzbHBSTnZrUE5rRy9kcFU5bmZt?=
 =?utf-8?B?WU94OXJWU2JWNTdBSXl6SnFSb21Ea2h2bWtobU05SnRJSCtLdE85K21zdjNw?=
 =?utf-8?B?VTNRZm1QYWxHS2tCV212b2NFQjFFSVlDQllnNG1BS3ZFdG42eDhkeHliSnFO?=
 =?utf-8?B?b00vZUw2YnNsUDcwdHZ0bDlHZSs0V0F2eFNkMEFMejRDWmd1WXVYYXJUWUdI?=
 =?utf-8?B?cFNqZ2JVRCt5YU5KZGZ0c1diekFKRzErb1RwM2lSSFBHUGVaME1qWlppZEFz?=
 =?utf-8?B?Nm5xTnZ5elhqVlV2ajJVTEl5R3ZvSS9jU3E3dVpCTkpnaHR4dEhneXM1N1JU?=
 =?utf-8?Q?CeCSTW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:22:50.5384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d3cae-d115-435c-69b1-08ddc495c5f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720

Upstream-Status: Inappropriate Bad devices

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index dd2a02a6d1d40cd3fe99af83123a7a3a67149a69..7ce4f5fedc6f45960d45108c62f2039f65811b76 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -227,6 +227,31 @@ &uart_routing {
 	status = "okay";
 };
 
+&mdio0 {
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio3 {
+	status = "okay";
+	ethphy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	max-speed = <1000>;
+	phy-handle = <&ethphy3>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
 &mac2 {
 	status = "okay";
 	phy-mode = "rmii";

-- 
2.25.1



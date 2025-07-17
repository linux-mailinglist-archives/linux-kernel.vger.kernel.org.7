Return-Path: <linux-kernel+bounces-735039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57AB089EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531C5160B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50080298267;
	Thu, 17 Jul 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJyJi0V9"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB92951C8;
	Thu, 17 Jul 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745960; cv=fail; b=DRl8y6hOoT6yxHwrpT6rmplU7a0kUZjQO5/sITvHFNE15RhRUqtG3Ng69Q1XGM486Q4uI15sz1/8lBDa3qYqhYonWYcqIpEkmXldFAONAshhBYA+6id8/QWEKgANWcUlQVctacpzewMmUqAkpA1cIZ0q7iYmBCgnwjLdQYTWrFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745960; c=relaxed/simple;
	bh=AIEh6W3Aw33duG3ZSwFBoH0Xgfz0ou4uW61ngi8tjjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cK2Y9k4ukAL2+9lOa+bdjNkNnHROI6SdfaBFkYkZdrSfcrJ0uV1b5Dz15gLG3OsGNTq5NPjZhSAsTAxRCD2Phn6rZj/wOkdIzuoWJIF4/Yb3j6ZaOYaAEJfJ4Rq/tLYe3uvZgkWVa1EJovRRbeHabGuTu3DvOWKB4V8wbZ1h+hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJyJi0V9; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVjByzK+kK0Eqy7ALPST1lQt20gCq4qXe5UuRRArRuPS1qNlZf9WeP7w6kZRXx+m03l6sB3+9u6JfDCB6joo8/fIS96bz2Q448yURqrbYInvacqWexAcs52eOvU3tvMP5bVsD4n0R2mf2URifvLMXTqv7N0K1FSyYJX6uoCd3zU80Cexh0nbHhBdSTtUWwe5mvCKNh58NiYPfsIGw0IqnQNQ10XOnSL28CzR2SwtHhrB1mih9TRgn9XXldN8D7mcNPaNyEAbZuZdnzPSx+/mzjFp2BmpecC5mKmIbwJeSnPw0LvTjmhXS4HK5UhebuACOAi/oa7AJHkq1lHodI6p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhMoPYt1F3OESRAnc0gVCl4lrAi7RWnI7/AgAT7EaxE=;
 b=wTIhMcggD6zOTwP9y+QEqd+1cFMgZKMBqHQvvO3chYrXJ+jS2vq1ulE3UDobmpRv3SW3v/7CZalNvJmdfFpbK0dQcwW62IGpsktYpB7y7OG0qkQMJXLZ6tgUNevIiJ3LQ7TKuZ2iJY1bK42jTrR44zD3lKQuT5uG2V+abc/ncB8CStt1UO3JIbMPZYb5YS6sJy9RvoW289V/1b4zj45Z3je87FVH4y+OV8XI0DlEpyfg4XDefa9Gsr5adeTk3jLE+UKl1ap2ApkOtxgmnCzAzplR3hnIiZ+MTHz2etRM4/9o0cZaKlqBIcP4EmveT0Ud1IQe4MhoQ042nBV0AqzqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhMoPYt1F3OESRAnc0gVCl4lrAi7RWnI7/AgAT7EaxE=;
 b=SJyJi0V9D+2l4VOECBpyqYIn9ovln1oqk6JPRpa73ESYmLXNiEI4G8vgpSqM89GmSlSqIji7Cj3K+4DmzuXLAOM3kmncX6p4FDJVD80K4EpIfHtI/Q3P6SFNMghPVAPvimzdUOiGuq1naRTsA5WWKugIr6TxdiAIoWtIYo4Yh1JhIFl79Paqp8wvECp0TFrrX5fqyWS4XuCAgizCj+x2oNGHKQRuZOrbJLfeiZBw17Dcregd1goax8BdqpDf0gHMrYDRYisEspPQ67GBcO6RBxytmp8zUmVDeQY3/9UnbFFJgypID4mS1Nlb7AQh5qZJiuTaYNzKubxMGbmK1h262g==
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:52:34 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::33) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Thu,
 17 Jul 2025 09:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 09:52:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 02:52:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 02:52:17 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 02:52:16 -0700
From: Willie Thai <wthai@nvidia.com>
Date: Thu, 17 Jul 2025 09:52:13 +0000
Subject: [PATCH v3 4/4] ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0 for
 BMC network
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250717-update-gb200nvl-dts-for-new-hardware-v3-4-f28145c55c98@nvidia.com>
References: <20250717-update-gb200nvl-dts-for-new-hardware-v3-0-f28145c55c98@nvidia.com>
In-Reply-To: <20250717-update-gb200nvl-dts-for-new-hardware-v3-0-f28145c55c98@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, <openbmc@lists.ozlabs.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>, Willie Thai <wthai@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752745932; l=1353;
 i=wthai@nvidia.com; s=20250525; h=from:subject:message-id;
 bh=AIEh6W3Aw33duG3ZSwFBoH0Xgfz0ou4uW61ngi8tjjc=;
 b=J56BoS7MacWDTOs3Y7pwm/K/9RdCFpnSLh7YdHxf6vEPLVy6Y8OzoQBX7olzwjBJHz6MUIIE6
 evySpWL0aEBAg4NBtDJn90wW5kNB8Nz4i3mYa4fttoTn8ICYYXOASS2
X-Developer-Key: i=wthai@nvidia.com; a=ed25519;
 pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8909de98-9f25-4d45-c5e9-08ddc517a755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJQMlBPSVNMcTE5dk1PTllNb3I1R0w1aHVlSnNlcytGcGZRdG9TZUU4MkZk?=
 =?utf-8?B?aU9iNEcrZnRadC9DZ3J5Z0VqMXNCTjJvN1lWZEFrUG15eGE3a0twbnV4bExF?=
 =?utf-8?B?aXQ2Q2xpcnVLSjhiVVZIckVmK1pXRGZYRkxqQUsyaklIWTNuN2QrcmVCNkI3?=
 =?utf-8?B?VlNFQlV4TG5WTnVncjJpcXpCYXFnaWFTWXBwREFTYW1ONlZtVVZNS0o0OUdF?=
 =?utf-8?B?WDNRMCtmU3N5N29PUkp6MVNZdEJRWGw4UFNTRFNqS3g2YU1tb2MzeXozbTdI?=
 =?utf-8?B?RXVrMStMOHVPZHVsbWUzdFc2UWdXZXZyd2RkeUh2aXRFbDg4L1ZXMkd1Y0Nw?=
 =?utf-8?B?dC9BN1ZJem1xR2cybGxxRVg3UXkwdFNKcHlLRmg5bUVSZXFFTFowWGZzQ3RP?=
 =?utf-8?B?UkgwTEd3c0RYdXJ0WHRDRi9PWE94UFNNRktEWFEyT2FxUzZWSkF0SFFCSjg2?=
 =?utf-8?B?RlpJdmd2aEp6eVM3RXU1SUJ5WWVPTnA0ei92aWhVZDNRZHV0aDR1UjIvL3Rm?=
 =?utf-8?B?Nk5icDNoeVdRQ0c1clROSkQxR1ZNdDU5dDFYSUVyOFl5ekhsd3dwUjJJQVc4?=
 =?utf-8?B?RHZOcjJTYkVvZTNOMzkyaS9lTUs5T3lYNUNLa2RCVEt2aGdXOGQ5M0xROUFD?=
 =?utf-8?B?dW10U3VBT21SNmVYdkZTSWlabVZrSTd1RjlZeVZTdHhEWTlrUDJ4cjcwcHJ2?=
 =?utf-8?B?WFpNdlRpUUhEakhtRWFvTDdNRkRId1pNbUNaeGtFcGZrMVQvam56V3lVdktW?=
 =?utf-8?B?WkpRNHo3aGp2Ti9FU0lzcVFqcTlDQmN3K3BqYVkwVU8vSmJrZURHWDNBUEhh?=
 =?utf-8?B?NUNOSmZwUHl3ZWdPQzJtaisxKzNTK3RTN3p1eUpCa3BLTU9sS3RBVm9iV21y?=
 =?utf-8?B?ZFFUbE1IWERudU1RUEltQVNjQm8wTG5rbjFtQi8vdHVzT1dpYmt4QWtyaGlI?=
 =?utf-8?B?VnNVblcyNS81b1VVR1V6ZmJlVUI1MXBBcGJGUGcxUVFkYlFZY2tURWQrK21B?=
 =?utf-8?B?YWNJd005NmJNcFdZTUxuaXZaTENRVHBHU3JSRmZxdUhXVElQVmc2OGdTaUNB?=
 =?utf-8?B?ZGxabHNvK3Jla3RoUUlEYmszNmlEamZxYTh6TWhvZ0g5VW5lL2szM0xCd0F2?=
 =?utf-8?B?ckdZOTJkdEh6M2YrN1NYUWFEUnJVa2l0VmZvWkZKa0pFdG9zN1NCTTJUenVG?=
 =?utf-8?B?dm1IajFxZGc5dmw2RGEwd1BOQ2cwT1AyQllYZVMvRXVEdHhnbTcyeWN5RDJs?=
 =?utf-8?B?S3ovVjI4ZzJnOHN2b2ZZaTBqaW4xTnhBcWtFblI1YU9pRmRVL2NUZkJIM1ZF?=
 =?utf-8?B?RS9KSWtNaHlRQS8xR1FpUXI1OVh4QTE4UlhaQkVkeTZrc1Uva1lzbTNvMzgv?=
 =?utf-8?B?SkV6cGF2QkJPd2dWWnVFWWFUVTZCcUlnQTl1OGo3V0ZReFdGaEpMbjJBVm9V?=
 =?utf-8?B?Nm1PdnJ4N2NLYk9aOW1LMGoyMFNvWmwzbzhtOUYwTDdzZi92MXdHOFhXK1dx?=
 =?utf-8?B?M2JDaTV6ZGhNTm9pS0tucWFNZi9CeG5aVC9tRzhGYjJUTHp4cXVpY3hMcHE3?=
 =?utf-8?B?bmFtaUNYVDVJSm5VWlJRUFV4VE5ZS1Rna0VyMGdpWXoyQXVIdTV0M2RHai8w?=
 =?utf-8?B?VmMyT3FUR1g5dkFyd2F2a2RodXBjQllMVXc2OU1jT2hqOU1iY3k1djB2TTdD?=
 =?utf-8?B?bytxRGlJVGlkZ0dXaXVFVGJua1NzYXFjUEVVczQ5d0duNGttK3pyaFpUWGt5?=
 =?utf-8?B?bXBKM2tSV21TOER2aDlVYmUxZ0ZNcktGV2lxbUZMSkF2YnFWKzJkci8rNFov?=
 =?utf-8?B?dDkyaHhEQm1SNlFNOTB3eXU5WnhpUXFuakVUdDc2S2RSMmVoWE1WdE5rZ3kx?=
 =?utf-8?B?a0tqbm1CczRnRXlzYktabjRxaEdFcmhhNTR6U0llZE5uTFBwRjFiUHg5bW1N?=
 =?utf-8?B?blpZQWJ4YkxwaTlTZmZaUTd0VXFmNEg0clpBb0xYZzRJSkl4ZTFvam5VMzdj?=
 =?utf-8?B?S0lHb1JtV0JOMHZkSGF3c2pyMEEvZGdjRDFwQm5oS01uOG42ckFzbXdCaTh3?=
 =?utf-8?Q?2nZFiv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:52:33.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8909de98-9f25-4d45-c5e9-08ddc517a755
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

Upstream-Status: Inappropriate Bad devices

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
Changes v2 -> v3:
   - Remove max-speed setting as it is not necessary [Andrew Lunn]
---
---
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index dd2a02a6d1d40cd3fe99af83123a7a3a67149a69..72dafebc080d5ab30a100450fb04c688cd805844 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -227,6 +227,30 @@ &uart_routing {
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
+	phy-handle = <&ethphy3>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
 &mac2 {
 	status = "okay";
 	phy-mode = "rmii";

-- 
2.25.1



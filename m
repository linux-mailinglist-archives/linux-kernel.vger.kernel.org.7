Return-Path: <linux-kernel+bounces-734078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CBB07CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97AD1AA567A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B642C1788;
	Wed, 16 Jul 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gr9CRyDz"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9A2BDC01;
	Wed, 16 Jul 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690174; cv=fail; b=lBcVhBazRdzGGj7fK/w5guzWbU0OY7MYyUjOvSDuWoMeMorDu0jHY9IajkfLfI9qntDGL3JIRwTlLRQQgWrNNbFDoma9bbLBM14CndxwD6AOVv+J936zgtTd0c6Tua+JfeExa+scSlSYYOR1OkyR5UZKFr15Qk4dppvhlGqiiFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690174; c=relaxed/simple;
	bh=U/hb94f62wDxLjqgv/eiUe31gOSf0eh/bOHZltRZM0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j3Tf/V36fzJJHX2YPI0m4wutFm4833dhM9JlXOiDAjKHYtzfzVUCjTn9h7Rb2KETEdunZos0u5+qdXqDLfgTbzJr2NrAGhybjx4o2OYW5El6HnMUb1YHgk8x60Dx/h1T6gKzK9tq43CwtSHQGbpJca5f7znXPWLkTBE8Idq6BFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gr9CRyDz; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDP0JMUTuooqONabtihGjWKD/JLRlNYeOe7fy12qnDF/zcVrpxyPEXTPNHS3bzkOWIqfUxZSGikHuxlz8fQpU/M0jQpDpdGvbxwyhC6Etow4tZa8mFO82fKkPHqnkzgn2AQ/Ue/Ij9YkkImkZ+be5IP8ohTdCanZqJ+gpyRhn15jy2C/ldAZrf6T29KVn3+k9L1ZbF2jJaH3LlA5hiSMgCJpwiKnTwNT1vbufmVVnp7NJ64vnxH6tqKa52Rf0PUJFhfasc2+SgIthxbkmV1PWQJgwpYszRHWFfcO5u57dGDEP3Fkh6gBAIZgnEKYo3MT5BKryUdF54FrKWJaNtasZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWkWfZutqQT+qFOmLnfDTsBntwOP+JAXAYtZirayczQ=;
 b=T0aQYBFdVJL1ANd8jbrD+nbhPXaUqGZ3jQ7JbqFSsZ+DR/m/izXmzY9h2RIzTcLEQ6KEOeKtcL/Meg2Iuuicp/lo06cmjAgliqwuo/elEHFqvHLMcFZh8ORV7ErGDRZm5KhccMZukMM0twYMg7SFOWgXbZLsdL5CIrpkIGZTzbS4izhROz803TZCoFHf+YteSIZocCc4tdks04qwHjIjrItXhh0ALCAekTL90948NZ1A9OE7HKw6LKVtjVpMhEnfEA8lcgOeu8dJrIWoNiCpThg+Kwxu+yhtcC+3TQ1b9QArzv0wXDnaUxvB8b+RrjkiuimAo+V95Tk62pJimE8YFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWkWfZutqQT+qFOmLnfDTsBntwOP+JAXAYtZirayczQ=;
 b=Gr9CRyDz8xAsxWx5d5Md2ULMJNJRk88S0YThIdlN/R7h8zi1LHIJgu90DZ5+NE77qnaspCxMrZ2u17qvVKx8WFnEWjsph+IBYZj95xsl+qhjnip5fpahO8pB3W4AUTyWm1wqmjhI9wLD0otRKQg3y4T1PVlpBBoPhHfO9ShiYDuEZCkMjEk6BmCxmuZBdD+bMfnadYEsLHPPzvPDtl1qY+j6W836yl7LQfu0A7+SteMIMrnI1fTLbdnCjwsIgwjX8m6j1lzrLfWm+r5RXMcxKPhWTvqc/j7lp9Xy/LPZNR6I0sEMQy0c65+hrXYOYetlq1LuIHaeauot+Zdj5m/VcQ==
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 18:22:48 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::bc) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.14 via Frontend Transport; Wed,
 16 Jul 2025 18:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 18:22:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:22:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 11:22:30 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:22:30 -0700
From: Willie Thai <wthai@nvidia.com>
Date: Wed, 16 Jul 2025 18:21:57 +0000
Subject: [PATCH v2 3/4] ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the
 HMC gpio pin
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250716-update-gb200nvl-dts-for-new-hardware-v2-3-9a1a916f461d@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752690148; l=1239;
 i=wthai@nvidia.com; s=20250525; h=from:subject:message-id;
 bh=U/hb94f62wDxLjqgv/eiUe31gOSf0eh/bOHZltRZM0M=;
 b=cq7KXjzfbD8N3bDaS+iutkJ2gIw9t+wrDSFGUrY7CNrC8hPQhh2rdEGboW1w+C9X2yhCJP9/w
 wmX9JHEEBJIB+4SXXeY+zisxTKFJItyokLTlLsU0KrhWUx9TfzrBcgs
X-Developer-Key: i=wthai@nvidia.com; a=ed25519;
 pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: a79e7af0-e818-4762-e620-08ddc495c447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHNUcTQ0dzdqbVJDaTAyMGtLaEdwNWw4UGVMTXNZNTZOWGZsUitYMlo4WWpU?=
 =?utf-8?B?b1o3cHpGUDhBMlZVdTNVSHdYSHlGbUVHdFFnQUYwQitUYVYwWit2NXdDcytM?=
 =?utf-8?B?RjJ4azN4cXVMQjhqWFcxQUdPMFpjS0I4WEwrQnVka1FFTHRTRjk3QWI4WFo1?=
 =?utf-8?B?SExpWDBRcDFKQ2pnZFM4b0dBR3pFOHpnNjZvQll4TmlSMHNFREpjVG9teWRR?=
 =?utf-8?B?RytVV2pEK1RXN3dkNEtzNHc1RmJIR2V6T05DSGNmTTdFZ1BmTGxRTENsMXJ4?=
 =?utf-8?B?b2FYYW1TWWk3MlB3QzdMNmZ6d0oxVHBTd0Ftcy9jN0c0aHI5ODA0cUFiTXVy?=
 =?utf-8?B?ZzZhTTR3czZ4UjhvUmtoL2MvNm00Y0dlZ2k2cndtYi9ndmZmZ0w4T1VTVkk1?=
 =?utf-8?B?K0tMTTNZUmlPVmNLM1QyeGJpN2FJdDZpYUhDRnRLN0l4TjR6K01HOUdPOWJB?=
 =?utf-8?B?dGEvdHVEbXB6dDB6R2ZjZjRjNG56TTRsRnd1S3c2WVlGa3loTkcxV0FtUzAy?=
 =?utf-8?B?NEFXWlRpdzZ4TTVsTzMzdnF6T3B4RGl0a0JZYjZMMkY2Tkd0ZUFBcDI1UGJR?=
 =?utf-8?B?OHd0emZaOXhPaW1YUnRHRURBOEVZbHo4Q3RsbDJyL1JVY1loeC9tRlI0SWs4?=
 =?utf-8?B?UU9nUGwxa0xqbmNTbHY2ZmYyZ1A1bzJGamkwSzFWcnVLd2l1ZGE4eW5XTXFp?=
 =?utf-8?B?Y0dzMjBmbFozSkpnNy84eHUrcHZ6bC9tbkRkWkRVdkZKeklPelFEQ1BQOUp1?=
 =?utf-8?B?WndaOUcwekZMbFhyU2ozV2x2Mmp6UGhPY1UxNEVYdGp1bVJtMHI1R2QxMVJU?=
 =?utf-8?B?L0FIUWxGV1h0NytzblJ0VVpwWjk2YmFBdFYzMzAycEFSeHNSOHRDbDB0bDlj?=
 =?utf-8?B?MVoyZmpvNFlzd0JERjBxcWlKbjN1dnh1aU9OU2ZndUhqTEprSFl2c1JRNWdN?=
 =?utf-8?B?alZKYmFzbkZMYk43Q2NHRDd2TTVjU3k0OVd5SWFkUFJNY0FIaTBqM0JQSVNL?=
 =?utf-8?B?VHpYd3ZFNzRrQUR6SmdkcEREMGQwSFo4RWI5RENuemVuUUVuaUFLdDFNamJv?=
 =?utf-8?B?cldwZ3MvV0FlVTM1bW9hbjdtZUF1NzF4MlJ1RDJVVjhwRklhSzNzMFlVMlI0?=
 =?utf-8?B?UUVjWjc1YnZEUEczR1RQWlFTbm91NzdvamYrZUU1WHYzYXl5NWJJa3ZTcU1M?=
 =?utf-8?B?UHd2d0NyTGp5L1ZvTmZ1VmRQOFNEcVpza2ZsNkdwSjJ5VHVIWmFaU3ZFNzd2?=
 =?utf-8?B?bm1yN2prQXhXSVM4cm96Mk43Wm13Y2hYM1dVQWVUOEFBOEpoRmk4bHdTTWJ1?=
 =?utf-8?B?K1lNY0NVYTJSWU9aUVBpRHdNSXN4QmRKUmFxRmorQ0VLa1lTeTVYTEFtY1Ir?=
 =?utf-8?B?WkZxWkpGa25EclpKQTdNdmNsWmRQbWlJazhPWDhjL2xCeWYyd2lBWldPQ2ZN?=
 =?utf-8?B?S3JBdXB1S0VzTVNBei8xemVMbUdWaE5sd1Fta3lIL3kvK1hPQlBiNmpDWG92?=
 =?utf-8?B?dkhPU09oM041VVZ1MmV4QXQzZzFYeUdkR0I5ZHdLN3dEK2RzSmozMGxJcVB5?=
 =?utf-8?B?b0p2R0hzZEF5VFVYNlBtVTYvVndRZXhRdE5rajBHNWdnMXUvb2RwbUorcDB2?=
 =?utf-8?B?TkdPdTdiN1BpZy9ZRVNMazJPTWs0R2JHTndPWm9sQzVSd3BLWHpERldITXQ1?=
 =?utf-8?B?cW8vRFBPNU9PcWdCeVp4c1ZsTk9jekpuMFpYdkZCUzY2cWlQSmRQYjFIaXpn?=
 =?utf-8?B?YlVBU2VtaTJPS3dhSEIrV1RIVDZicUpnY2V0bWlFS21JNk1ZVW5GZXVlUCs0?=
 =?utf-8?B?VUFhT0dYbDR1azZFdHlwSlJFZm92anVVaXl2c1R5OHZFUFc0R2FzRUppOFFS?=
 =?utf-8?B?TWhBdk14MmhKeTEybGZpdlAxaHppODA1MjBlRHkxendadlBOQ1BCeHY2d2dY?=
 =?utf-8?B?TWxPTGdaMWUvMlcyb1BpSDY3U3o2MmlPaGVFT2RPeHlRUEpkRjhLdFZIcDBG?=
 =?utf-8?B?Yld4VURSWlhvQ3ZaR1BvZXhETnlhSkRxL2FEeFA2bjRqV0pMTzlKQ3ZYeUpn?=
 =?utf-8?Q?0Zu7It?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:22:47.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79e7af0-e818-4762-e620-08ddc495c447
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198

Repurpose the HMC reset pin to FPGA reset pin.
This change is according to hardware change.

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index f0a18adc328759e290bc354ad8ef703f28c1ffe8..dd2a02a6d1d40cd3fe99af83123a7a3a67149a69 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -1126,7 +1126,7 @@ &gpio0 {
 		/*J0-J7*/ "", "", "", "", "", "", "", "",
 		/*K0-K7*/ "", "", "", "", "", "", "", "",
 		/*L0-L7*/ "", "", "", "", "", "", "", "",
-		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "HMC_RESET_L-O", "STBY_POWER_EN-O",
+		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "FPGA_RST_L-O", "STBY_POWER_EN-O",
 					"STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
 		/*N0-N7*/ "", "", "", "", "", "", "", "",
 		/*O0-O7*/ "", "", "", "", "", "", "", "",

-- 
2.25.1



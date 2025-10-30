Return-Path: <linux-kernel+bounces-877487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F033C1E34A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8EE634CFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4F2BD58C;
	Thu, 30 Oct 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IfRsbSOg"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69361F4CBE;
	Thu, 30 Oct 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795027; cv=fail; b=ZUoFArr1U8PutgJcHp0PBXR5UzoR3wAr7RuVEJ80dxT5TxesR0EeI3PbImEnnNEjGixA6QTBZJo8UCU8xthJYsoS3Hsk2LEQ0OBW4wGNCgfQbdMlNxQJQRR0UZP6kAGygX/wdiYTKX0Cq/uFq17Poe4oDhBV6/jR1NNishp3h6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795027; c=relaxed/simple;
	bh=DQEkuhR9qtLo17tiuh7yGhCJyMqxTKWAsX6buJP671k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wwyldfd3zyrAnH8Nysoc+05sODnvADvAkQki32lLLhxPvRCaGka+GPb0iGq6gr/BY0mZhKmYDzapwXWfy/JOT7re9MzT9GymiUh3ByM4sAKz1gdzsw3X3CkdBO7zHt3SJBbLllUns6l2uR7QzmozNKBYtNMEDUAftysXI93QiAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IfRsbSOg; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqX2csOHomPecYQHGxlZ5RRPyB7Zc3qLJARPb4xxHzQbldrp8epmMFJCXal9QO0rYb4dFgdFXglVlHHRTsQk5A1TvDvIQJ6ivqaIRp4A3vd5s0Tgh+vm5vCgj3CcSaH6Zez0fZjLyxzbtboqAhr2wWvg1vPREUryIiGHbykQAFqncbFxkuCK4e+VjKyu2qtTggul1X48yltu3gAPOCuu4T4M5WiI+O5oTymfU6pAAENUin6LHoBtDR55GJDjBo6dk0xIUiHJnuEkt/IqmoMXKvbgJ2PYPigozc6Lx3Mk+BGMwwlWE+NvTIQCu/kwtZSObcYBWxmrxJG4anrA6JP8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ky6yqtxRV9E8WB9bNOf7g691Eud4ozs7REbWVrxXQ4=;
 b=WCRSKl8QlMd+Ama6eoOtL18Ayay2LxApJo/CUmQxXqFWS+hNa+iv/Ns+UIq2izjiU17OV8eL+26rGMnnFM47T6z+pp3dOuu2FSyJ+FGGU3N6Q/UAM+GwBp0jhcR7z2Sc9xyI7zftPHuaP9SKQRBM0VOwlmRrC6i2h7dUfjX1RYmsaENHy+BArEBcbSZUxCVKWZz4CY3uq3m1FGGywa4aEWPVas22GaXa3O0jeuW7g0pD9zIjmQAxAIVk3ylvBz2nYkLoGdVGYythF9nqgvumKTwtcWX8Q2FDn28C2jR059tdFhXScq8b+MJyESv8af2Q6neRsufZm7tnaVLKoepIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ky6yqtxRV9E8WB9bNOf7g691Eud4ozs7REbWVrxXQ4=;
 b=IfRsbSOgfvcpotYeOWxkNUzHasWXdBYHjmAzIp20YPuMsNGTbUdBXdp4FuAaq40w8jLs+ZjYb59a3vyAD5vu2iG7j7qwGdGlIj7AQapEMxXCuZ0Sa/HffLsFSu4YFCew4BQoUmlVdYpRGDp/PQphopa4b5S/MUGvpNVz1S6mpJ/o7JYMFo2KJiDZn7dthgFxpdustHGUQe53g4gWjPIAawa+bB603rpMpfgHAQJXLyZjc03sBG3uVLJj4N8DKuc1+xjpzUn9mVMB1qhDUOkFK7ZtbEwEuUPoM4W9v8Gwnf3YjEtL0GknKByWM2fD8MR12Qz6o3R/tZU33cwM6zhOJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:30:23 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 03:30:23 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/3] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Thu, 30 Oct 2025 11:30:08 +0800
Message-ID: <2ab538d19d8287517f608d5169c80944bc1eaf3a.1761648711.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761648711.git.khairul.anuar.romli@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DS0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e16a07-e618-4e3d-5266-08de1764a8ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?On6kp6A/kWOIR0JGIGOLisbX09jLVxeq/i3uAzi+MTXq7t/PocWfVNCFHjFj?=
 =?us-ascii?Q?luoT4pZLdUy+VQ2qWTcN6BAblr/WsqN3J7BidFAqFswy1VGSOznjqz7a9d1A?=
 =?us-ascii?Q?yDzXzqCFiuU7JEIcs59GqFw3hBoNNKqXP/z6LkE7CvQwy6uQkZ0GNueL0cGR?=
 =?us-ascii?Q?fQ1IdX+D8O4mZrBEq+cOhVQJwtorcuYN2zcsomVFNyLCiMXLtI7zrClt9YGn?=
 =?us-ascii?Q?Dzrq2+u1qfgcqQ0zoV7lpZkrQOq+PyY66ZXCuap7zzyM0Asb0qpBxu2HVITo?=
 =?us-ascii?Q?gUkX5cQi8Qst3TINjiW8LwP1MSN7mHgREzBl42y99ceEuN7jCmZH+ovtgGgj?=
 =?us-ascii?Q?lsYUewbKozE4UXD3GBB556CPvCaMh/41hT8badgqCXi/06Dl+hO33ZkMcx7u?=
 =?us-ascii?Q?N9GKsidMIQP93BLlJ0r/qpscgOm/llT0IJ9DonywZw+v0BX30dcTBkggfndq?=
 =?us-ascii?Q?o8Eyzu/L9pHdChHfmhUZvRFyn/g6il16oCUMbaiuB20/t4m87Yll+gmefYRB?=
 =?us-ascii?Q?uvj8SYfRfr+52XlwewVUWV3l9NG5d5Xd2jZLsgHXfNPPJJaqvzPKR52p22Fc?=
 =?us-ascii?Q?Fd+xQTHMmnXyWW+KYrLwKMdX8Fk3B7k0ucq6UZx8eH+eNEcO19zLS7B9i2Yi?=
 =?us-ascii?Q?RCFRVQVL+qnGl0RNH7+Lrv2ClUWOaSCMvO7CM8juNIeO3CbIOAkVd07/kHOX?=
 =?us-ascii?Q?du2ds5h8Of/e1cbKipxmoIWIaA5NmytWJpOIOk3Ma4GPb0u7w5ywyN8S/8oO?=
 =?us-ascii?Q?84hcgHSohkVi8dnkbPov8KjBp1PRxSzi7rer/zAHUAbBH6FK2/roKQx6PP06?=
 =?us-ascii?Q?bxu8wPXP6UOvlIaYsS8zLsoCEJybFLJP9MFdkFIYw8z52d87kdgjggFOQ06J?=
 =?us-ascii?Q?fToJM8ftoCseaDwON5Ub1QMm1RZsAAJ2BOo2sehZtvG+n8lC9AdUzXCHfPP+?=
 =?us-ascii?Q?aDwRv6rQl2OULmJzU2SvbHgW4KV1Ufs71RUriXUNK/Ukg2WN/+l3HKu50Iqj?=
 =?us-ascii?Q?RcInBHj/nmaxPAiagMco7t5iy9wzaA+45oaFAQM7k6B7aG9kiNMDZX1ztMNw?=
 =?us-ascii?Q?iPTDkkZAy/ImeiKi9UNTP85gb+sJ4UklrFKOOAXTeUT3tu8wTOOW9WaDCYvO?=
 =?us-ascii?Q?ESP54KMTMQMtfbWxnMk6KlvsBS4uNOp+owrsO7gzegqzKwunVVt79zocQ4px?=
 =?us-ascii?Q?l+AnxB6xF4K9sB+rbcSv+BVdD1uRfbV0PsWUVgPvdPKo2mc23dzWeXM9+ZH+?=
 =?us-ascii?Q?BTq3RiyzFuiqJYQieV2r0ffGS1XFkmRy2RPPA3mKD3k9ZTtSHStwc95ZImJA?=
 =?us-ascii?Q?zO+WEOAGkBtgELTtwmxgZkOuwhcbw6U13DQT9FDSbXsLuylPdt2+nBa9kSgX?=
 =?us-ascii?Q?BUn8+QzXY5bbdETdzkoILNyuCexkNM9k2QpZYf1rOcrTxSdZNnk7KvfTKa8g?=
 =?us-ascii?Q?5EDr9BxLZ22bflGDmBJLtAPbHCriC1YR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EO0joFsj9ieWBkjgrWaBVGShcRlnrJi90JbwtEr2o8+KBOPT+9iBLuf4/Msm?=
 =?us-ascii?Q?erUDt2xYfPwY9ww5OqR/bah8V3u8BcT0Yl7BBDtdzPM0tj9yRtcb3nq2tGFY?=
 =?us-ascii?Q?vSNFdNf5+UWVoN89VC8PO4qC1BY51sg6t3IG3y6EUPQjt3k/gNfJNZ8oNhdP?=
 =?us-ascii?Q?zDOEUgNCVxhJGprADhSUMqlioMCf7/NNV25l8ZtIeaCZm3Zzw8QZ/1ENEcy0?=
 =?us-ascii?Q?mLSuMzH9iOEykZAJpSOT0TYI7PF2PJMPruSjplwc12eumvIILeb62kuqdysn?=
 =?us-ascii?Q?ao/PVxroPofWxYCv/UqyKL9LSTqYqOnyXY5kztT/VxCEAqL5ZDrjICwTOHk9?=
 =?us-ascii?Q?B1zqCF6O14InSUN0RL8IRoedKWajUBymMTX5FSAcy+9GDP4LSfwMevxuwzK/?=
 =?us-ascii?Q?SQHTVyZcIbBysZtTd5Py3KRwpdhorhI1/dQNmnTDsepxGh32nWV5Ar3WmPuM?=
 =?us-ascii?Q?EKHXxLzljZIVR7hmMypnaGAJ6EjzeynTXuWfhA2Oz10/VvztvmeNYfhhVHGu?=
 =?us-ascii?Q?ER9eGyrhI1lNI8ACBMGuBUvUyqnRiJDS+dCjfVaN1JJjLtxMOBjbLlSlG5Bu?=
 =?us-ascii?Q?KTjW6vRBeKrPrCgcNtkgEtVvrZva+qo8Btp6wvl6nW3x4dKm1rBH7LxQklCh?=
 =?us-ascii?Q?Jv5hlucLXcYYEDbAxGRba6DMKzEUMiyP6bv3PSLNMcgm6MqfUljZKCrSqsn9?=
 =?us-ascii?Q?lhsCscu34XpIl/gXB/9a2WKJJgZNJSrpKAjzSLAP1VYb/3sWIH35W4l9rt9n?=
 =?us-ascii?Q?kTa+e0HZBBSukQnVdyTArPzU4L1z9IiY7ZnsPZkgkXz3xBz/+dDS849sQhem?=
 =?us-ascii?Q?hb5BxbbVRkXat0dgwhhTx4dAIRSx3YI0EWkAyjI4z/wNmbB6vQHsHvCwHfwG?=
 =?us-ascii?Q?x1IPlVt4VR8y15oPrjEdZhXBcfBtWQqnguOTy/7xF0mwE7dgsnp+nKD+B4bc?=
 =?us-ascii?Q?iPY2KH458iqOUvLvTiMHnRYcfJqm5k5I0hxM54opssvP74iIDT5nyhYUjbn0?=
 =?us-ascii?Q?TeTbh+6SYkcA53+PgoCS/aqWkEP1aW0+TR5yXAUgAMareiEKCvF1faDJsk6l?=
 =?us-ascii?Q?yp6RllhnCgc3PESknMS35H0QDBTZx5T4BXs5EiMC/bPH+pxhQqS/ipXKU7OE?=
 =?us-ascii?Q?hyNiVvk+PcNKcZhN+KRUpr+t7GZNNFR0otVyyTBvJXb6q4VGK3NT+zcJsEMP?=
 =?us-ascii?Q?sVm+GiSE9Mmq+9pwzACybDH8x/JTKc69tAbufAckRkHvysQSfDlAx1fs0w0S?=
 =?us-ascii?Q?kpyqyi0KvLR9lUVYgQdrd/d61jyukS+FJwmFHDhHhprxxgiFCStlRkqs3Ru4?=
 =?us-ascii?Q?h0DbKWWcSVfCE28GlmYhR2pu/mAgPeJxf58AVP5eaSMdfE8IfdvAlgVih2jb?=
 =?us-ascii?Q?mztgst9PeiBF+phuVJZR02f5JgLF0xxviJRqDnFaiKc5vYEziB0vwszhVJ+j?=
 =?us-ascii?Q?6tCKBesbnnBPxInsHFJH3tbACsQZi37lVjZelPWjtsXtfG5Sbweh1uJfILjW?=
 =?us-ascii?Q?K0EneEJ7bcqoZCdtPi9qXFKPxZ8Jt+GB6Yu0KAFNhUBRnDpqeN5hpmpRf6xp?=
 =?us-ascii?Q?20D6/ksOr8oSZsptLKkTEXt4jeLQW3dhXPKfwhBxF3alABD3QlQmfbpUWKyT?=
 =?us-ascii?Q?McxnMfk7PL0Y8tBiFUUqj3U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e16a07-e618-4e3d-5266-08de1764a8ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:30:23.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wze8SwpvCelVzMdCVDWl9D3C9yUBm+FggBalQypaclybC/6oCac+N6Kx2+LhSlMpQdUyAUfVVtF6UXot7oGHnyQEgnH5add4njFy+7+nJUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655

Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
node includes the compatible string "intel,agilex5-svc" and references a
reserved memory region used for communication with the Secure Device
Manager (SDM).

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. This commit updates the device tree
structure to support Agilex5-specific handling of the SVC interface.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Rephrase commit message to exclude mentioning iommu
	- Remove iommu property from svc node
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a13ccee3c4c3..a003720b2995 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -841,5 +841,13 @@ queue7 {
 				};
 			};
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,agilex5-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
 	};
 };
-- 
2.43.7



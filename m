Return-Path: <linux-kernel+bounces-886981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA9C36F06
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC151A26712
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC8433E361;
	Wed,  5 Nov 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzZl1Qpr"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB433385BC;
	Wed,  5 Nov 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361754; cv=fail; b=nOb28CTBhw0Eliwmk0qgkCR+mjUG1YEDANv7vwDpCsFXPTCbYPunaEPo57zk2kJSpENGdPHfpQmpZZ++x7tvyuCxFg0c8xzttXZ/nBypZyhe/isIs4osUIEaW2Avi7PVDTb9mJgbAMUsxbi7lXw/07GuabTJqbx2F3kCqKxRLdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361754; c=relaxed/simple;
	bh=FTnuXSZBO/+9/Huj2MTdpznnwq5JJdGt1n8O5g31ZQw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j8OvDjyBlSFrwzmAmEI1SFWqbUGSu+VzNAV6UG9vD48f79/Ghjr5zl29PiYPIH+w8MMLsScPxUBuGUN3onYJqlv1GhTSND3IVS9LDnuULYmQEQ/7poOBlh7F86kIIScn/BPZxm/vKc3LC5Xu/wI0EYuaN+ZwpPo4ITPSkdGVANM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AzZl1Qpr; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXM+6eRBOQPcCvpXQEmZ/GwPFE/FklTyPBUKPyEywqsdO89Y3STM938Bcq8CkTO4+O9aOTceSUEBLZ6Zsz5MViHuI/MrxQd8KE/DAo2NeFI61bSqBuLnH7kR8xv0HwNk8YDvnQslHzcdF12raNg2xirZcRYDnc4R4PJoa1sCdlSDcupCTcm8L1gb2xftEFTj/1EJTeB2dsCcqNL+lT4v55qc7M33iFaN3RLLJbl1sMg1+ci4TkLK1B7jeK4cgcTvZ9oxD5PZyBJ7LpBtwi17mv0eUsgfBW3jx5lcFbEmXTY6Wf71pOxeHrCA+1CTNNJa8JfctMKqIbtrGjxY2KrxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqcKhaqoKBwN2gXWQsGN/lLNpFe9+0MeYBdFiyowwng=;
 b=Ny61lRYAznxLV/bHdPsscu/OFfiCGDWGxNAOZuLRHKyiQg+djwdAXvy4cMvWRVbn5eNNObD8oTlQqx8QMz8zhn5vycacu9A/M2p+c3Ob/oT1IjxPWY0S+mvyGw/HFbkCLvjdvCyAcawDS3QL/zBpD1xfbsUGKwnxnZ0fw9qhPcelpVF/B3yVqCtCcdD/O6Pb8w2i1VOLFc+VHA9gbzTDz6dXiQVmeRjICJJ9QJZpCswNR90PLeaqY//bYUKa9KnBtMY/K/EA4JoiyJO+xiOSiad5jP/7oepohzi3gLTXE7QVAzsUx5efVtT5QYekL+AGMKhOu3GQ0uAWoED4yve/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqcKhaqoKBwN2gXWQsGN/lLNpFe9+0MeYBdFiyowwng=;
 b=AzZl1QprswFso+U1ZaAgiJ7VIxupIhj2eZR3C2x9WEBqLfiJSsLWq7wbaqhRSZ6CuJHacgwwcXvQJGKdkTQTtfc5qgvqw8C8xx5h6Mho9ExIv2w+/DBEBazZYj7KiX+lc3T26PJspa1zNfVs4pk/Y2KUayk2IErT5I75XQa3917f6MUPhI2oCpD3+ELqVICi/CdlnB/2pPIBuk8xq2OkQh0j0VKpiGPN+nDli1W7IRxzjKc/CH41+zcw9teW+d5FgoNRb4rQo1HffP4QhQBL5Q+JUwWjBwvZOErlF63cJJxaF940Dkl0C8FGh2XyaRh/7Ib0etc9y5fIJ8Td75Ea2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11022.eurprd04.prod.outlook.com (2603:10a6:800:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 16:55:47 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:55:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] ARM: dts: imx6: cleanup imx6/7 CCM related CHECK_DTBS
 warnings
Date: Wed, 05 Nov 2025 11:55:27 -0500
Message-Id: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH+BC2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3eTk3PiUkmJdUwOT1ERTA0OgcJISUHVBUWpaZgXYpOjY2loAZU+
 3ZFkAAAA=
X-Change-ID: 20251104-ccm_dts-504ea501251b
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361743; l=1402;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FTnuXSZBO/+9/Huj2MTdpznnwq5JJdGt1n8O5g31ZQw=;
 b=KGi+lh+4p+jQC6YfCkZ3fdEYVPIdHIaNFj0bvgijIqJzy9u4JekyW6gAA6R6p9p1GYJVqmRRX
 w5jda7XvdIFDnRTWyfaqb4kcKvQo0aNlVzRW6loSK8YwIewWBYSM+6Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: e45de548-e174-421a-eed5-08de1c8c2ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFhvWnhtWk8vN2RudkdQS2hOc1ZqUTdFYmU0WitHanI2RFRCSVQ0Tjc2M0ND?=
 =?utf-8?B?ODVMeGFPWlNDcnpNa0k5UHh1cVpCWVlnNEVtN2JpNzVBclU1cW5QcmJ2ZjlD?=
 =?utf-8?B?M3BuejdDYlA4WVk1dDBCczdmR3Frc1FXMDA4WUcvOE1jVmVTdHBaVVNRd2hy?=
 =?utf-8?B?dk9DM2J2cjZBS09uSGNKcjNjdTIyNFgxd3ZjQWRNOE9GQ3hXeDA3TXBRUGFH?=
 =?utf-8?B?Q05ZUVc3cE1OOXdNM1JETDlad0pBVjNUUDN0OXhnWkVuZTk5ZGQrNWFyZVVG?=
 =?utf-8?B?RkJGM0JTNWRPQXBNRTZvTnZQRnRNWWg2RnJ4WmNVZmVxRk5tdmo4ck1ZY1FV?=
 =?utf-8?B?WkhtV2hGWVZNRm5MYmx2dDZLdmNRTytnc3F0Z2h0OFlNdTVLMWFqNzFoYkkw?=
 =?utf-8?B?YVU5YldrZzZqRTFlNUE3TGZobjRCVVQxOTZRdEZtTzlPRGU1cEExdkxOSXlU?=
 =?utf-8?B?WXBJM0hxNVZkN2ozOHlVY2hqWFVTWTlQYjU0ZVo5WE9BRFp3OVE0UUVWRVNp?=
 =?utf-8?B?Um5FbWQvSXZkYW81Y0JrQWk0Qk1mSkRwRW1MTW5ldzJuelpHK3hvT2hJSDBp?=
 =?utf-8?B?SXZTVHBWZHJMbjhoeFhsekREaEZwVmhKbWg0SVVKVElyTU9VaG51THN0bHdT?=
 =?utf-8?B?RHhpbTZjdDFiRXA0U2ZZWVM3K1E3R1RldkZmNUpHQitMdE1VVUZKQVkxV1E2?=
 =?utf-8?B?MllCREp0VzdhYjlvMEtVNXRDVy9pcHJhektGOHZDVy9MVDcwMGxTMUtYNmdo?=
 =?utf-8?B?ek1jSzhIaFk5VTFVMDU5TGJvM1BURlNPWXdXb0VULzY3K3RQV3E5NjRwdXBu?=
 =?utf-8?B?RCtpNTdjcWVOMTRNMHlRLzE2QTBmcXpkZFBwUER1ZGpwcVpacFBYdU40TEph?=
 =?utf-8?B?NzdPeVJkbnNSRVlXQi90NUErejlqQ1JRQ2VGOWZ4Uk5yVTUxZHhHdERXN056?=
 =?utf-8?B?SDhFTUI3aEJoSlpmT0praUZVR3RuU0NDNDZFekJzNzY2ZFByUmZBTlNiTUNJ?=
 =?utf-8?B?QTNiemMxdDVocXhaMFdpS3N4aDNCKzlsK2pGZGh4b01OYm44WFFuaFVyQnJw?=
 =?utf-8?B?WlVQZDlHcjFKSHJqZFZoZ3c5L0dzcGg5azU1T2N5eWhXSEdHVVN5aVR1WHhp?=
 =?utf-8?B?bTVVQmZZdVZlNkphNmwxTTArbUxXSVYxQ1V0UkdDeVJ0TlRUbGJWdlBVLzVQ?=
 =?utf-8?B?MUkvSzZRQm5DSnJpbUhYdEdhWG9OREloVXZ6ZmJSR2Z2elN4WXRDOFhSMTVu?=
 =?utf-8?B?SFpXd2ZQQk45T3I1SDI0eURiSllyYm55YmljemNkY0ltRkYrZFpJQXJQS0hS?=
 =?utf-8?B?RmNQOWpyNEpic0p4emEwcENEUEZGUGFRcVhoUWxMaUorUUViRDVXUGRrc3BU?=
 =?utf-8?B?WWo0UWdaaldSZnd4cXRSdHVYSjMvMUlKdU1XSk1QVlFyb3BjV2RHbFR3ZTMr?=
 =?utf-8?B?S1ZycEx1ZXZXclhycEVCVjBheHdSTnJ0OUdZa0ZjdTBwcDNYL1pFWkMxeGI1?=
 =?utf-8?B?dUltV0VQTy9hYmRkTkV0UFp0N1V6S0xlZmswTVFYOU5JOWNDZjR0endBWG5E?=
 =?utf-8?B?RG9ZUFFoTHRJQ1FZNnptV2tXUG9FK0tjRVQvU3BzNkhqV0hiZENrK1RDSlk1?=
 =?utf-8?B?bTljN1dZdnFtcTVmdCtSdWEvYWtNU0VRQzFLUk5VTktBTkw5NFJMVTdpdTBS?=
 =?utf-8?B?akFWcjNUWDN6b09DUkUrZkh6elRhcFg2dk0vTTZTNmwzZjdMWnltRXBhUkxn?=
 =?utf-8?B?Y2R5S1dDNjdnakJQRlRHUzhvM2NYeHRwd0dhTzNZcXdHbjc0SitWZk9ReUx6?=
 =?utf-8?B?LzVmS0ExazdaYW1uMTIzbVNOWXRJdzM2SFBoVXhRaytEdGRWTzVWSWJIUXRB?=
 =?utf-8?B?aUVPa2tEL3pCVVIrUU1ZSEgrOVpiMDJtcW1xb3l3YUgyODRoTFJ2SzN4QkZY?=
 =?utf-8?B?SlhsT3krTVZMZXJSYTFvQUc1L0dXWHFHVE1KS2t4dzlxYnNXaTZCaVh1enlQ?=
 =?utf-8?B?Zks5emp1NVhpMDlWN21iSzVQVlZEelJ0VHMrcXoxVmF2dEY0cG85SFkweCs0?=
 =?utf-8?B?KzFkTTdtcG5tK1Y0Tmx5Nk9WMXY2SlV6VzVQZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXNDdTFWa1hRNCtFWEtsTHk5KzNiU2dRN3JBN0NhSDcvbTNzNUNHWEFHc1Z3?=
 =?utf-8?B?dEpTNXdrWWk3MlhRSVpMZ2lCaVAwWGlaRlBtWGJTWC80a3ozdHJqQ1VTUURx?=
 =?utf-8?B?S3ZUd0JiNXlsVVhZT3dzWDZWL29VZmpwSEpudUZOdjRYVzN1dXlFWGk4akVG?=
 =?utf-8?B?RmpuU1crMzl5NFBsUTNUTlFNSDZsMjlTWm5vdUNkb1VRbE5Vb29sQ0szRVFa?=
 =?utf-8?B?U3FyVGlMTUVTYzk1bWxkMXhHeHJ5N1dRNWZXS3ROdTNzekMxSUR1MVVORUlz?=
 =?utf-8?B?RHpIeWZCRForc25KdWNmbXU2TURUZXlTSUFFUXRvK2pWOVRPUVZaaGRjb1NP?=
 =?utf-8?B?Q3Flb0h0eE9TeHFhb0dxdmRybWZaUUhoTGNLNXlUdi94d1loK09xVnFXRmlt?=
 =?utf-8?B?SktVYXZ5ZVd6SmpudkxFNXE5TG1vT212R3ZVaGo0RTJBM3FQYmxuc0ltODY0?=
 =?utf-8?B?bGtIL1ZqZWphUWwzZFZ1SkJoc3VMRit4RCt1UHJ5WHF3eFFhSlZUREZLT3hN?=
 =?utf-8?B?MS8rMys0MjJzY0k2dzRBUHREU2trcEduQkVDZFdGVXo0YUNFVU5sbVBjWTJv?=
 =?utf-8?B?M2lSMjNldHVycC9OL0xEQVhUbEZ2L0FvMm1FSGtweDBld2hMOHFSMDBCalY1?=
 =?utf-8?B?SVIxRDBBNkRoTEFOVzNnYUlqZEdzU2JTR3AxcU9vend6akQ1TnU5a3Fyczlq?=
 =?utf-8?B?cU00MStvVjRHOWN0OXp1R0VYQm9HVUphR1kzTFptRytNaVhIdnBQOEFITFVW?=
 =?utf-8?B?cVVQbHZ2elNLOTVHVFIzNzBJMGtiTmFzYVRSeHcyRFZ4dGdwQTdZQzVHOS92?=
 =?utf-8?B?S2k5L3lJa2tCVHJ2UnRIUExFOVhnZHExZ3hUaWtyUWhHRkRkVEVrQU1SdXlZ?=
 =?utf-8?B?Mkh4QkQySnpUWlBIOHV5b2R2TUl5NFljV2x5M3lLTDNXM25KVmJXWXdzMnlv?=
 =?utf-8?B?eFBqMjZVbm5POXJ5NkR4SktVUTk0SVRZRERNTDMyUTh5d0V2RXJqZll6WHF2?=
 =?utf-8?B?RU1iMjJzdHRhalhCdVB5TTl0ZTFXeFgrYjV5Q2c5NHJGSXhKR1FkZGRySnhT?=
 =?utf-8?B?WmdYR1FEemk0RjlsT0Z4QnBIV2VyVU90d1o3M0tCVnVQRVJmd3UwZTBYWUFD?=
 =?utf-8?B?L0Y0bmNPckppMTdzTEFGUzBqMGNHUkhHV0pyR0VpTWRVZUJNaXhNekNLUTBn?=
 =?utf-8?B?WU1TMHpCUGtnb3FlSEdPcnRjWmU5RzlvdFNJYk5qaks3dVFPRlpTZ3AxdFoz?=
 =?utf-8?B?YTBNNVZtRHNQcjltZ2ZGSTVGR3MrL1FhL1VWOVJkQlVBZUFXMTVwdTBjUE1q?=
 =?utf-8?B?SXlLaS85UXNNc1NRVEhoblpyemlCSEtIZTNKOUZSWWg0MTBHRDh5MFhNeVdj?=
 =?utf-8?B?THVqMjhCcmgxY2JkNlFsUFhlZ2VsS0JDNnlUMVRwUjNSdHpiWFBWV0hVNWlo?=
 =?utf-8?B?K2JwZUdvUUhkcVZPeGY5SzBNdkRBQTFERmY1M3VaMmZuYkE4VEdKQVVYM2sw?=
 =?utf-8?B?RkkwVlkvbEM1dkM5K3FJRi9XR3hjTS90MWVHVUo2RWV3L2lTdC9aRnlQclRK?=
 =?utf-8?B?b2FId3dTSzhpV2RQeTdSTkpaNkJGVnNOOTdVeGd1bjA1N25oV2w2TTJ3czY2?=
 =?utf-8?B?b2sxd0xlNmN5aGt5QllLU2RsZmdzU2pSSHFpdlFSYy9taDl2QTBPWXhaM2Rl?=
 =?utf-8?B?MGlESGFtWk5pVWoveFJiMUZkRnl6WGdyUzJ4OTNnNFB3M01IdUxhd1lIcHJ2?=
 =?utf-8?B?V0IyWXEzRitKdU1ZcURVTkMyNU1xd1hieHl3WklEekVicml2WlVkVUZWbEl3?=
 =?utf-8?B?VDJsQ1Q1dzhLQ2xxenZ1Q2hrejN0WWlsdnBIVVhia25XdXViL3R4YUo4Umpp?=
 =?utf-8?B?d0EzVWVYVlRaV2Z1K2RtMnRnbUVIMG9WM2ZWSGhpNEJQOGJjbFFjZ2M2K3Jv?=
 =?utf-8?B?NUhCMHFEcXRQbDM5ZlFXVHJTREJvVi9oL1p2KzhvKzZWSU1QWkRYSmZnUXFQ?=
 =?utf-8?B?Y2QvT0lLRTRTZHNxY3czUTFsVHVLd0s0SlpNYlZZa1VyTlk2eHdlNUZDS3VR?=
 =?utf-8?B?bm1PeXdLcWJCQVg2WFZ6dmZ5SDNaK05Vdlo0OXVOUG4zbzM0bGhseE1YVURG?=
 =?utf-8?Q?6VV6n+6Hbm27N3KlW7y5OGvyn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45de548-e174-421a-eed5-08de1c8c2ad2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:55:47.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH3PkS+TZb7VEBquDXcWIMAvq0b0kFVPvXaK/GmKqxEsHVaqn4xkAttbpffMGLRY8c783h5tOuAEHU8jY5Xwxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11022

cleanup imx6/7 CCM related CHECK_DTBS warnings

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      dt-bindings: clock: imx6ul-clock: add optional clock enet1_ref_pad
      ARM: dts: imx6qdl: add label for system clocks
      ARM: dts: imx: add required clocks and clock-names for ccm

 .../devicetree/bindings/clock/imx6q-clock.yaml         |  4 ++++
 .../devicetree/bindings/clock/imx6ul-clock.yaml        |  4 ++++
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts  |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi             |  5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts             |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                 | 18 +++++++++++++++---
 13 files changed, 44 insertions(+), 23 deletions(-)
---
base-commit: f8a6148698538647188a0f801f686ff90035a8ca
change-id: 20251104-ccm_dts-504ea501251b

Best regards,
--
Frank Li <Frank.Li@nxp.com>



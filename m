Return-Path: <linux-kernel+bounces-833237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F741BA17D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E481C80F86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FC322C95;
	Thu, 25 Sep 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lcAG+f4O"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B6322C73;
	Thu, 25 Sep 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834874; cv=fail; b=T94xf484QF23oLCMzCg+D0jQLBZu1YGCnvQ8LtpbwYk7vlRzRSaByI+GU93hTBof66aepM46Ge5lxHJ45N5hWUPt/tgfsRppsCDdPPUHN3qSNkfPTmx1/+YqIFfzx3FaSLivnHI5rbpuPVv0Ziosa78Y4fDEL4z2bBwr/SnUnTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834874; c=relaxed/simple;
	bh=UXTFwuzp+fbaPnexE334C+HKBPtRWAVcNRx/W2t5PW8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rIwEezxky3a9294oFbIsLWphwb35TGjd9tPh9rC7+MPfXXN0gxkFhey+Vc9uiNTjxvSHyUNWs9sobf60TVCmxFdaUsJoL5W22x0VM8cfHYajnJ/tdrKB2Am3kVhCoUj+dfIkhrind0AIpK7plZkfkx/SDgiVL6WyQxAAHv499zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lcAG+f4O; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1Q7q8px92+XZbXqnwWddl5Ti3gv18LVrCcIgcp89tLoZ4l3IcwbhDfuzDDuB7tlhtotq4XCUSGGMmJBhUMp51sflLpUgRarndWesD3G1q2OSjSShhKu/DtZEurrDxf0t/iqY1xqVHT8I5BeAOg7fuyrcu0/xMO+cVSmZXfudmbctTogzY7ZLJo1Kbi3TUOVnWkoygpUCDjS4M4QUwAtyNpgTF35eYw8j9lAZu1NKOnDwDUJG7BD5RIiQP/9rzgOjUu+qYg+nHWR67GRlYCWOC/NYnvYdg/wW1ukKlkBIz+jGbL0OU5ANZcDmn8gKLnKkdGhu8MWhO23dCpLNVXFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz1BEqwukzUZt+mLxR1cIOj0ulhAwP0g/vEdYMOZfH8=;
 b=d/8RGaKeNUyc4QZPmOwxaOzk/626Xx5DeLDxMx+5LkBi48M1gGR6jwnOuXJEEfCuiRtEpVSABobOV3Sg1bZm6MAsTqw2qQo35amNa83+TTvsrr34Dmc76+KCXsCj3uAR/WQEieR9YO2MIKMRCnlvuTjFVHeoB2oqrSHOML8mfyZOlbgcvm7WuFvI45Iv+rf7aQ9fUwCSw0PU5OHPHulJpDkmdAfiTkOLpvHucppi/I1xXIz+dquPr2Is1fmekK4viAQO/Kt5wmPp6ul18whJvc85Gk/aBxjBV3JFE+t/w8f72rocvwQkFaZcDe7obLsN6gL99pjqkblcMCupR4bsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz1BEqwukzUZt+mLxR1cIOj0ulhAwP0g/vEdYMOZfH8=;
 b=lcAG+f4OtRTpC+EW61U+JWOfSQv4Qls6Qa1grzT/adJWPiktgHI0DLBA0eqlOkMtVh2ASRhW/Gg5P+g6Amek8CUssouINZ7Dz3DbSbj3PNeyaDrSgTpZywDKOrssnBGlLGkBGcXnxIQJD5ekeQLI3QGWopDf7Rel4r+XsKtQ6h+OMHVoSPlgcut2TZtPnc06kHfrd11UslK9jswXuoGATtFqcqGFnxPGDtprQp7K4z8AOneP8Ebm7VTu1KUCS8lWZczsnPFjfNLUSt4XgOSqVft3/L0mYl4XY/J/atDOJbLGfKS8BVDseO3vkb/tv1PycIvQDGDb93iHbG4ZwA2NJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:30 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:52 -0400
Subject: [PATCH 08/11] ARM: dts: imx6-tbs2910: rename ir_recv to ir
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-8-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=936;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UXTFwuzp+fbaPnexE334C+HKBPtRWAVcNRx/W2t5PW8=;
 b=M0uKSydYs22CliDwAzCWz61v6uP2oHrtlaVCw+rLEP4ib1TYhtJ8qS4V9T+7H7PSpoRhsijJN
 ihY4hqrF5kHB0qyCpwQFK2ECw77NSJoTOerKwhAMleC8bxN1V0Opc27
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 06886873-593c-4fe7-1fb1-08ddfc788449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlJrdUI3WDlIM1M4SUNOQTRKQ2dNUFhlT3Z5SnR2YUlSVEJGem40RUx2SUor?=
 =?utf-8?B?MEhraFBKZVE2TzNUeVJUV0dNTkNVUVBCclljTXZHazFqUVhOWUhweFB1M3FL?=
 =?utf-8?B?djUzYkJOVjU3eDBndWZrdXhxeFNieEJUNWYwLzRTci9MelhDQk5BTjlVcW1t?=
 =?utf-8?B?S08xbER4UHRXTFdCYUI5SDNKaFBoNkVaZTVwN3d6MWZGbktRaDc3OEJTZENh?=
 =?utf-8?B?d0cyVlhoSDQ1S3dFUzJWYThaSDRuQ0pTcmZ2cnVpaUZNU2VXZDROY3FtTzlu?=
 =?utf-8?B?OXZiaFllZE9qOWY0VE1PMHdMSzg3UEZRejI3QUo1M3dBbmFyT1k2V3NISzZv?=
 =?utf-8?B?V1NJcWRRY2p4ZVFNMG5QdW05aktVV0ozcms5TXp0c2ZrNWY4VG5Kc0c1WXZq?=
 =?utf-8?B?alJjWFVFZElaaUlldWptNEpTRldSaXk3bDZWUEdadThsNDZFd1RQenpQNitx?=
 =?utf-8?B?Rkhnb3NwakM5TGVRS003UjFNNGR6K1R6cXBxWWFiT29xTXhZUzlzMEJxRzZH?=
 =?utf-8?B?L2hlL2YvdWt2L3V0QnpmN2FOQVFoYXgwNDJ5cHFtdDRqR1FqbUk3Q2FoeGpu?=
 =?utf-8?B?WmlCbU5mT2ZsVDN0bVd5Rk4zeVR5dzk2Q3d3a0xkVlZXNXBxMDFKS205bXdj?=
 =?utf-8?B?NmxZcllPZ2FiNEovaUVReHBZSXBCb0pVKzVkS29pTGh4R3IwQkVJNXZESDdX?=
 =?utf-8?B?SDBNTDhoOXFsdnc3SDkxUFN6dnl1SEpaTEJMK3ZwaE1oVVk2cVhmb0JBM2ha?=
 =?utf-8?B?eVZJTlVUNnVaSmVhWnNLV216UHNnUnVDV1dOQTJqSWYxRnF2cW90cVZxU2li?=
 =?utf-8?B?TXR0THk5Y3lKYThTeVZpT2JobEphaWxtSGVSbFZJR2lxVVRpUEwwTjZHSWlj?=
 =?utf-8?B?U2djOG9uR2RyYVNSUVNPTjBuS2J4Ykx3RkNnWmIzVEQ1anFXeXNoUk1BKzFW?=
 =?utf-8?B?M2dUVE5iTWtTQ1pHdHRQamJOMVdvK2ZuZnczL1ZWZkExaGtPM3pkMzJqRURJ?=
 =?utf-8?B?UWxKcjBzQ054ZlV2aHRlUnBwU08xY1pFVUJzclUwR25nSjZWbFd6KzVHL2l2?=
 =?utf-8?B?blNEVURPK2N5ZTVHZC9hTkhUWmNsaENxREFVZUQ5c3liUlc1UFF0Y2dUNlht?=
 =?utf-8?B?b3JoRkx4S3V6LzhFZ0NjWW9QclUzdnRucUUxczlNMTkrZFJDRy9WQmNTM0lt?=
 =?utf-8?B?SC9lR2c2U2N1MmpUNDByUTI2S0dJRjNoL1o2RFpVTVg2MVovTjkrcThPaE9r?=
 =?utf-8?B?QktrYWw0LytRYStxMmxzeVpiSDNjQkFiOTBTak5NTTIzWksrRDJqdVJMdWsx?=
 =?utf-8?B?RVU5NmpQdTR5elNXOUQzTkxSQm9nOWoyTGtwbTNvRFlLcjUxUzN4ZGQ2VFJk?=
 =?utf-8?B?STZjNEcxWTVRYkU4NkVnekc4N3g5Q2tMOEtwclBMaEwvaUo1SFh1YUJBaW1z?=
 =?utf-8?B?Y3lsM3l0SzF5MlRXNmRqc3A4bVZTQ3o3ZWlLbXBZcy9TTmpNVkIvY0k1U1Q1?=
 =?utf-8?B?T2M0SVJ0cGRUeFZyeDNaczVCeEpCV1hkU1U3NTdiamQ0NDBveFJwNWVRb1Z3?=
 =?utf-8?B?K3VReEg4QjErWkxCNFh1a0Vqdy9za3MrcmpMVGV1WDA5RW43TVBSOTl6eWo1?=
 =?utf-8?B?QVdvbkdQV2grb0RkQ3htVmRZT2VvMFh0NVBIT01ZTlZWU2FyNGRqQ2hCTTNB?=
 =?utf-8?B?S2xGSVlVUHpDWFI5V0VuRzJaeVRIRHZIUzJ4aXF1eitDWDcrWVBnRm5Cb1ZT?=
 =?utf-8?B?NVZycGl3NWpOODZ1Y1dRR0xvM3N0a01FaGh1aFlZZDJEUnpnWWFmWlBiNmRi?=
 =?utf-8?B?cWwrUW83c2FDa3pmZjFuK2NDNTl3Z0x0NEhLWUdwUVMxNU1KSG9nYk1SbENQ?=
 =?utf-8?B?Y3YvSVM4dVduWWxLRlkyVnVUazdRNE85eEJqQ2NncFRCZElhY0d1LzJBdCs3?=
 =?utf-8?Q?uQo3vsi2kI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDgyYnVFcW8yRWZoWTBoQlpONCt1YUhZTEpJcDFZcnBTTytPTmtlMW9Gb040?=
 =?utf-8?B?aHpJWjFLbUpLd0xIVndFTVlTYWF0N0xRUTgzL001NCsrMjNxZG9iLzlCQVJ6?=
 =?utf-8?B?V0pYWkNLdUFtQ1ZqV1dLOTNid1ErZ1MvVEVnaTZFcEpiWlRvc3cvbVBUaDFO?=
 =?utf-8?B?RDN3d2lZek5yWkd3NFpqN0NnVVJ3cDBWUUZHYVZBeVc0TXBOK0lpbGxoanRn?=
 =?utf-8?B?eitDUWc2MUxrYzBaWm5rZ3JNR2cwb25ZQnZWV3c5M2FheXRHalZtY1puRTZv?=
 =?utf-8?B?VHJiTGVTOHNORzRNTEJTNFFWbExVcUdZTWtwanZ0YnVzMVZPYldYMkQ2RlQ4?=
 =?utf-8?B?OEk1TlBzT1JCdW5UT2g2YWJydndVNUhZalNSdlRsRlRVN0d5M0JIOERRZk5E?=
 =?utf-8?B?RXR4eWhFS3JSYXpZTk5UTGRIZFRyMjZ3dGZMRFNvcmR6NjJxbTEwU0Vvbmls?=
 =?utf-8?B?RG96WTN3WjdOWkUxM0dGZzlUN3FEbjZsSlBGMmcwNXdxNFJLZmxKQ011RWc3?=
 =?utf-8?B?U2JNbUx0Rko1MWdFSThqRHBpRk9XTXJaZ0MwajlENjI3TVc1RFd4b3p2emRr?=
 =?utf-8?B?R01FQVYwT1lITEdvNkhWWkxLQkRyb1IrSnBxNmE4RFp6T2ZoR3E0a3hrWThW?=
 =?utf-8?B?RTNJMkxGc1FkM1NEWWtRRVA2cEFZc1p3OXA5b0lqbkx0WXgwTnhTc0hCWDhG?=
 =?utf-8?B?dkY4WE5DK05DdHU1a25ibjNWQ3Y3cDBhZWhzaisrY2hkZ2dBTXBnNkRNbWgy?=
 =?utf-8?B?SllGdjYxYVJRcysreGQzVUpoUlNoZ2ROQVBwWVRPM2phWk1BMzk4REpKZ052?=
 =?utf-8?B?VWxQSnZmV1lROSsyWGVDalFLcjNQakkrRW8wSzMwalZYWTVvaXFjREwzL2ph?=
 =?utf-8?B?bnI0SXRSRDdYNkgwaG1FekhBYUNYdExyWEY5dlp0UjNObXZtVktDYWdyRisx?=
 =?utf-8?B?bWdBeXJQZS9SeEZrS2k0cXV3Zkg5RnkvaEcyZzcvdWZvMHlVcDJwYURaNjRF?=
 =?utf-8?B?Uk52QjA4aTVNWGphcWdxN2oxWUVMckRVdVR1cW0yaWUxQnpZemVmQzU1TTZQ?=
 =?utf-8?B?WUxHdDVPWmlhWEp5alVkbzR2MjhiOEZCWVZFbVh5SG5rbUZSVUVpMkZLUnMx?=
 =?utf-8?B?cUlXeUx5N0tPcGN5ay9wMGVmeWFIUFE1ajEzZ2laTmFMM2hCYnVKNE9QZFM0?=
 =?utf-8?B?bVNBd1g5c0JUV2ZoUjFsak5lb0liN2FIYmxrR01MeGRHVmFPZVZIall0bEtz?=
 =?utf-8?B?anVDVFEvc3dFc3l0V2lGTzM5YTVhQ0RZWWVVYVNqdDBwYldmWFloU2k0L1R4?=
 =?utf-8?B?VGNCSTMvcWN2dDFvR3Mwa0o1Z293RHpTRzFSRWxoYlZsN0hGQzYxM096T3Iw?=
 =?utf-8?B?bE03Q0pvblVzL1F5bEpDcDBFdlhuR3J1Znd5T0I4ZVlwQWxtNnZzQUt4VHM0?=
 =?utf-8?B?OXVRNVFFdUU4aFdMdDdhNlExMXNXZFRUREc0L3A4MktqUkhweGQvMmxkVnN0?=
 =?utf-8?B?djEvTUg5dVRRZXdmcXhIN0s0dDJzdTBjSkthTk5HenFpQ2hnTG9EQUhYMTVJ?=
 =?utf-8?B?VjM5KzV6L05pRlVPNE5QaWg1V2lCRlNGT3dmK2dzRzNzMGRqeGJSUlZ1cWdQ?=
 =?utf-8?B?V09yd1AxcjFCME1OVUpWS0hOTWJYaDRTaEt4WnJ4MWV1WGZseXhvdVVGZmJS?=
 =?utf-8?B?ZDA4Z2p1eG9ac2Y1K0l5Y1ZocElTbVZEVTBMWHpqcDlUTVp4S21rTGU2ZXow?=
 =?utf-8?B?dTJBMUhOaTFPdCtLQW1USkIyNnRtS0lIbEoyREFwTWRpN1JqQjVDSTJtbVZu?=
 =?utf-8?B?TlZoYjJsOFJBc2JqNEVjU2pjWTVtWVgxaDV4Ly9DdE11VGZVQnlvQ2hVL1Zq?=
 =?utf-8?B?LzBRUmhVVzI1Tld0MVZNK2FRSGxqV21jVkwvVS9MQ09PRFk2a2hPUXhid1Fz?=
 =?utf-8?B?ZHRDQlY2WDFQQ1lmeHRNOS9NbHZqTXhpTC9UTHRTYkpuT2hFeCtoSlEwaG9Z?=
 =?utf-8?B?WkJlUXRaNlk5bmJURUZwaVVNQnh4SEtWU25TSXNJejdtbE5meXNRcC9tOXZ5?=
 =?utf-8?B?aHVGcVNIR3c5MjFwZWZ2NGcxSmNkN01TclQ2NmtpMkFwRkd6UisyVHhTc05s?=
 =?utf-8?Q?rgsvcANt8o0YILfGK0bmou654?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06886873-593c-4fe7-1fb1-08ddfc788449
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:30.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcRRtsVEyjAJh4PiXbAAMKYCYF2lINxtb4E3DS8loPVQ3ULgH3XkGsNx20wXeARL8dgmFUqLAqY53dvQqYyVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Rename ir_recv to ir to fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/imx/imx6q-tbs2910.dtb: ir_recv (gpio-ir-receiver): $nodename:0: 'ir_recv' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
        from schema $id: http://devicetree.org/schemas/media/gpio-ir-receiver.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
index 5353a0c24420504470b8b095eb7506e7713319c2..9834cd166688b4d2efa4724362a129479e2d3b0f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
@@ -37,7 +37,7 @@ fan {
 				      3000 1>;
 	};
 
-	ir_recv {
+	ir {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";

-- 
2.34.1



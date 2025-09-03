Return-Path: <linux-kernel+bounces-799379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C494EB42ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C1683FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F3371E89;
	Wed,  3 Sep 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXSDDLB8"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A78370595;
	Wed,  3 Sep 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930840; cv=fail; b=dzFp8FZsa+D35RZ3FyjcwYKU/XzJV7QW6OxMtNhRtVKe0j89Agpu3LPcjhBpFi3h2BhE9pvZBqf1DSjw0ocGPslDo3ifOUO1X96Yt/ZNXg2gxvYw2/aKBcabx4BRdzrAWhsOQcyeL9DPdexNDy4MM6wnrmPTZh5z4DIF0aNASeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930840; c=relaxed/simple;
	bh=pfJmo4z0EFBkngvaI+bV/3ONQSycCGBxEgiKtfTMnAc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DWjcde0SoAlVaKk9k8PfKidf1QMQcGn3AmSoNK5iPBgj3suYoXwC+iWC1BNHZjbNtLwrdk554y4DpPN0wXyGEW0v9fkq9h9jCDq8+4ajtodrIYJVvcF5027Kv8jQ50ayxWNwCPOyqsQULIw2z0Lu/Wo2WLpVMJOFs02TJqWrYhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXSDDLB8; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rORnc7fO6ia9SJUROKuUzkzzgUaxfN1ljGf5JOtG2/g6kjjRPMLdA8gOcc84gU59pX20cMt2js75jlooAVjhQFqjAPGuYBNwdaUmg17WQFMdLqMdZP4ehiKLxRIzLb7DTNViIJtYWvtZOhTQlBfp3H9SFrv2IF1KNhN+u+FyTf0Nz/K6K3EGIh/5VFBWCZJYThmT6uCMRQMbeMZ0AJNDMvljESOYw4uvCuazJWQNPDcsRd2RQNONy388zy420W9ps3vmq+entYWMCYbnMpto10xkVgNV95YEwuZMl6p7lYiSBTHO7iTGDd+CMKODEKngXjlaVtVqcXvDWqFf6Go2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrWdVyttspw9JlC9Nk5EhlrHebygMqqyJtBgi+ZPk/0=;
 b=e7fyeMnOOpY9WPI3xz4GsP84F868lALSYpB2uRMqij8uTXLjfqsepVVjQCFg2H9MsljoaXD/kPF4PsiJKhqLoJE6Tw4h2QVFD8OIPA66wsGJJoeDefr/YtxHhV3CaEMbqA8UbMhrIBWAD35Djlatrb9EXNB7ZFfTCMyRpBQEL/zE5WY6UjWFfUjyyehzcMMy5dNnqoLhyn+Bsq6OMNjoYbqzwP3pqGa61xzbodYNtgDHLjw60P3uDqw6TERujQCDgndiRxq5mLJ4VaCVdDm8GQ7ym/K8mFHceG1rG7znuy+gDOSguG8NRYkY05zSpNUvhGSHIehO+k/2SE+/i5SIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrWdVyttspw9JlC9Nk5EhlrHebygMqqyJtBgi+ZPk/0=;
 b=bXSDDLB8PdE68jihS9ZuBGomC4rr+z1+53BA0NiPhk1NopNmE26JDii9WuROFXZrEWMCF/kUcrYGBljesz0P/M5L7GR3km+SD0VYpEsXedMJpyJzSTJ86f0kyaJ4wNYk1Gfapk9QP/UOTPFUYxckuYf9q0WqsKSBoLjf+ZvXOYkRXy8InkKyN1Sa6G6Y907KpV3f+XCSn4ai/ULpUvl3qLQzHramb9/Wd7kKIYTiAiCG++7DdBbH4hiODjxWYVIGuqQTsRdhu9nKowviQSk+7U5IHSmyoYfGzz4rGSAMX48PFB2PGPDpUY0LZBXqKlecm5//wIL9fJmEQdJ21Yl4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:03 -0400
Subject: [PATCH 10/16] ARM: dts: imx6: rename i2c<n>mux i2c-mux-<n>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-10-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1891;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pfJmo4z0EFBkngvaI+bV/3ONQSycCGBxEgiKtfTMnAc=;
 b=YKYh9HKbdqWij1wWvw56BKPvmY1E2ik9Kd8gO5wyxCDwSsuQ98oMlYjr1AXOTHoqnG595emKx
 Bw7fycX53TBB8JiBul3t/opdSN418AvKdzqGKdW+ncZCl3FcnMeH2fm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 42aea54a-3398-4081-f2f4-08ddeb27562e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjdBMHptdjhTdzlneERQNGdvSmZrNHUySTYrSmdIMk44blNZWHhZZlE4QVkv?=
 =?utf-8?B?SWVoclQwS0doSGRzdURVTGJvSU16WWNJZVpySkhiTFd3WXVLdENHeDJSRGwx?=
 =?utf-8?B?S0EwWEZ3Y0phQzNEVjNLcERMMjVLNEVUdkg1TGNJWVpIbDgrVlcyM2ROQ2Fi?=
 =?utf-8?B?NUxVRWxjcHNUTmxMVnNVeXZ5WUp1Q3BSTzFEbmNnbXVGVkVPRnBWZ3h1RFkv?=
 =?utf-8?B?c2ZuR2p0V1NsRUJDNGJXb3BBbWI0cDN6UmlaQ2RXVlZEaTNVZFEybzR4RnZG?=
 =?utf-8?B?Nkp1Qm02VzdTSVR3VkplVU5YNFdPaEVmNk40djNaeXFuT1d6dkdtM1k3M2RL?=
 =?utf-8?B?Q3E3cnFjcVdzclQyU0wxWUhLbzlwR3NyMUtVQWFLU3U5VXU4d0t4UUpFMWRk?=
 =?utf-8?B?WTdaa1I2N0JjMXdURGorZUQ0S3RwY2I0UHZDb1ZtSVhuenVUV1J1MlFhMnd0?=
 =?utf-8?B?RUVGVXdsQkYvN1ZsRmtUK3gyeTZaTTJ3cE1TZzlJdFZteTZydU1ubk1teXVo?=
 =?utf-8?B?bzFZTkhRTzYyT2ZCaFRndVNib09ZWFR4YjNONTFUbVI4U0pkMFJkV1ZESW05?=
 =?utf-8?B?c28yK0xkaGdaSXRVcXYwMVJrU0RXcUM2aVhoNzFnc1N4ZmNZSW1jSXBsbVBZ?=
 =?utf-8?B?Ri9RaUU1R3hMVzl2UWdTdjRJM2hzbkpUN3VWWEJZU3JXdHZvcTJ2TlNMRTJz?=
 =?utf-8?B?aVltcThrRFRoUkRpTjVqTXRrOXVzbEtqZE5RMytJbE5MMlhjYXJISW5EOEpD?=
 =?utf-8?B?RURLNkdhcU1CTE0rNXNKc0xvZXREN3JqVEtMbHdYbFVSeEpIVjNyd3B6Sjc2?=
 =?utf-8?B?R1ZaY3lJcCtySVV0QlkzTlYxU1IyZzZkSnE0QkdhQVNKWklPb2FVRGM1WVpK?=
 =?utf-8?B?L3B3OVhKTklweFI5bGZiempHT2VZb3ZXTkJtV01aZ0ROdzNuV1cvVXNHdm1I?=
 =?utf-8?B?eE14ZmcwVkNTV2pqTzNnSXJzK2hIclN4ZW9JS0oxN3VxNDUybS93Z1FWOFAr?=
 =?utf-8?B?S29reHgrTkFBVkJXRHZoVU9mZW9oSHFWcVdMaHR3YktydWtla2ZPekxObHJy?=
 =?utf-8?B?T0FlV3UvQ3JiSlRqVVpPc3ZUUnlpVlRsazA4OUNVbmxSWnp3aUVRNjM5bzBy?=
 =?utf-8?B?STZia2l1NkpnRGtUVjJHRW9kNXg0SklqM0NwbEUzY0M5c0lLQWs0ak1mN2k5?=
 =?utf-8?B?U2hCenpYeUpyWHd0QzQyNjVWUnB5RE1pUTQwNENRWm1seWt6eU9xS0JPdVps?=
 =?utf-8?B?emJVendPRjBFZ2Rmc2ZNSWdjTVNtKzRoT3g5VFNFTmxSZ3hZSUY1UzJucktt?=
 =?utf-8?B?bng4ZTdEZjBPTGhZYit6ZmhqVkxzdzJVWUN1ZG52cU96dlV0b0pNdElMY2hj?=
 =?utf-8?B?TTQ4Wks4VDlOampuUE0zcXdudlFDVEVNT3MyYzIwWUFFZ1pkZi9vV0dMZDUv?=
 =?utf-8?B?SDN3NmwwaXdaQi9MY3ZTUEswU3Z1andzcU00VS9qSjRIQy8zSWU5OFZrcU5i?=
 =?utf-8?B?UVBuSDRPTFlUb3N6T3ZtVlVtNENxM000VFdmbmkzYjNsNEFVQlBwRWVzTXBk?=
 =?utf-8?B?Ti9naHQvY080TElJT3RTaGp1K21JcFJYenN4cWNWVGhTc0FENGhZNkEwSmcr?=
 =?utf-8?B?R0pqN2tXRWpkWTBYMm1SU1dNMjFDMFovYlJlVS9SdXRsenpIRi8zenJsVlZl?=
 =?utf-8?B?dUxyQS9SY3VDbmtpRWJ0Z1dlWXYxbmZCVGNUS21XMlpQNmlGdG5NTFBNVnZT?=
 =?utf-8?B?a2ROREJMRkJDVHVRNUVHYVlic3duUTRjRkgza0NhQ3FBZTk1Wng2U2ZGNnF1?=
 =?utf-8?B?QUhjc2NrektwZGF5cTlwRzhKdzVMVWZndUcxRXFsUzI5QUZ2S0hYcWEveW5o?=
 =?utf-8?B?R1BWcW5odFQ3UmlKenNzUjliSnZEVmUxYUNXczVHMS9VRnVHRFcrQzNtcUkz?=
 =?utf-8?Q?E4lJH0xgCQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmhiVElpNGRxQ3B5cjhCUW9id2ZCT1FqcmRtT3gyNjVlNU5NNHFLRVhSZEhn?=
 =?utf-8?B?QW14Q21VODFHS1Y3UkNIeXVJVmY1dVU4bTBYYmlEdkk3Z2hvZFk1dVIvTDd5?=
 =?utf-8?B?OENLU0F2TjZRUDJ2OHBOYTBISjBEUzJXeWVwUyt4ZUlvYll5Q1c0SUVNclgx?=
 =?utf-8?B?SklaUUovZTNWTGMxTmcrNHgvVHdaTC9UT3k4TEFpcHlvMkJTZGFpYmpaMm8z?=
 =?utf-8?B?K3d5TTNiM1NkdXk0Nlh6MFpqMDNVZnVENXJsSjMvTEpNM0FQQ01LeWNQTGRO?=
 =?utf-8?B?SnRYK0NwRUtza3VRM2p3QWhLdFZsRTV3aXpoY1cxNHNlZllkd0taRkQxbTdI?=
 =?utf-8?B?SGVjTk50ajVkSzdDNGtaZzBPaG1ndWk5SkdaYTdsZlZlb3NSZ3hJMkJ0YklU?=
 =?utf-8?B?UTVoendRc3kxN2k0VTdGQStWaW84R0FxdmpiQkx2N1JKdmpUSWI3WWVtOXFa?=
 =?utf-8?B?Tjg0Q3FYWlliQWQ3eVNOZFJrRjRnR21peGUxU1krLzJabHBac29JNFkvZHVq?=
 =?utf-8?B?V1JSWU55dHpmSCtmdFVnTHE1b21YcFcySmRSRlpLSUVOa0xPcm93QkdQenc5?=
 =?utf-8?B?azJiT3AzR2hiQk5UTW5ucWNkdVYwK0lST3RQRjVIRFYwVUhZajcvVjU3cmJP?=
 =?utf-8?B?YS9sWFNTeU1oUnZaZW9TV1hadHpwQndvVTZhNmszV002VHg1cU9CTzR6Q2tu?=
 =?utf-8?B?YWlWVjJCVUFrS0h0M0RSZEJPZzljem9ZdVV0LzJMcmZTenVoZlJ1MnJkTVFK?=
 =?utf-8?B?NE1rUTZaN3o2SWx6UElpN1BBbi9WU1dLT2xBY3BkZk45NXB4aDdZWjczZGNM?=
 =?utf-8?B?YjU4eUFzVCtWU3laaFZNQmVOZWFpZXQ0QnFrUEtmUEYwZWRQVlpiL2tFZi9r?=
 =?utf-8?B?NjhFTFQ0QXh0ZE40RndPYWp1dTAzeGNXbFBFK0E1YXBxWEdpek42SHcyWW1E?=
 =?utf-8?B?ZEdFMGVqbllvZnV6RWhmWUlzUDBMeVUvbkIwbkV3WHdQK0lMTkdNWTAxTngw?=
 =?utf-8?B?VjltTHc5Qnh6UW54U3YyYXl6UHd3VXh3U1d4aFlsQm14YlFtekNsZGt2SnU3?=
 =?utf-8?B?RGNaNmF4WmFiSUpBSkFrK3VrWWNGWEpkVzczNTU0MkxrZGc1WFg5WllZOWlB?=
 =?utf-8?B?V1JiMkRPRncyUHNUeEdLUWs5bkNCNDN1RHQwZzI1eWlBWjRtRTBpamk5YXVF?=
 =?utf-8?B?bVRPQjdXcTF2N2tuWENpeWlTRHZpd3dYNDM3NE14ZURXaTR6bi9ETi8zbUl6?=
 =?utf-8?B?cG91eWMwRzEzOVU4c0tkUytKaWFUQ1Z2enJleGZ1TGpWaTFOMHIzRXpCbFlB?=
 =?utf-8?B?M2dhZTR0TWZzYmIxUkEwZHk4QXJwV0R0T01tb05aMjd0SjI3elpWOXlMMHIy?=
 =?utf-8?B?R081c3dtbUVBYTAxMk55YzcrU3pEMDVDQ21vbU55RGppTC9pTkFWVEJPbFBG?=
 =?utf-8?B?emo4U3A5QjdvSXMyMnNEUmVsK3F0b2lLRkVkRmQxeDRtRlBVSDhacjNEaGN4?=
 =?utf-8?B?ZDY2UUFsZnJldmxHSlMwenJYeGZqTFFIQ0FpK0ZoZjBmYnZHbXNHdDhQYnBn?=
 =?utf-8?B?RTYyRklCZ1d1R2hIdU5Way9HcisxblJlUUhTOGFrakJnOGZNaFc4dHZ5ZENh?=
 =?utf-8?B?Nkx4K1NNWmM1REVQN1ZxN1BsNHliZ25ac3B1Qi9RQ0FYc0FEa245MWtMVGJw?=
 =?utf-8?B?Smg3aGV0VHlzUWJPNDQzQi9qblR2a050NXcxWDY1SXJCUXJPZTFHWnN5dE9S?=
 =?utf-8?B?ZXNrWWdDUzJoTUNXVlBDOGQrTEh3eFBpUFN5NEdnVDJKRENYS1NDREJKNFpo?=
 =?utf-8?B?UElUUWFtNGRGZmNTZnJDb1NDVTVITjZ2djB1bVJtemtNVnB2eXRybTZvekZ0?=
 =?utf-8?B?VUhocHgwSUdtTTZhRU1PaFJxOVVIUS9xZTVNcUpwbU9MTVBEWTdOWUpkOVVk?=
 =?utf-8?B?S3ViUy9jWFVjT284cDNsMHFiNVN3bGFyQWlOVG9vc2RCaitFSVYzUW1ia2dv?=
 =?utf-8?B?U1drREN2c3lwTkpNTWdzS0V0WTBtRERqM1RxUFlxZDJQZ0diK05ZQ0RCQU01?=
 =?utf-8?B?WWVGTDVabHZRYmNSZWpQUjVjeXlNSnR6V1NsNTgrVXNULzZUaEovT1Y3SVR5?=
 =?utf-8?Q?mOxyZmHisTvB76MIkls0JaD+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42aea54a-3398-4081-f2f4-08ddeb27562e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:33.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEm4CmER66UWjbWBE20fmjtWFpF829OZFL2a0KnL9OwC2E/KsvWbcrF23kpbTm4KwI+cS/G0htwjEaErc7TSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename i2c<n>mux i2c-mux-<n> to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: i2c2mux (i2c-mux-gpio): $nodename:0: 'i2c2mux' does not match '^(i2c-?)?mux'
        from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-gpio.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts          | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
index 4989e8d069a1c593539ce431685ff76f5bdc962e..9bb36db131c21956a33f0a5a013c5bb4cffe1890 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
@@ -25,7 +25,7 @@ clock_ksz8081: clock-ksz8081 {
 		clock-output-names = "enet_ref_pad";
 	};
 
-	i2c2-mux {
+	i2c-mux-2 {
 		compatible = "i2c-mux";
 		i2c-parent = <&i2c2>;
 		mux-controls = <&i2c_mux>;
@@ -45,7 +45,7 @@ i2c@2 {
 		};
 	};
 
-	i2c4-mux {
+	i2c-mux-4 {
 		compatible = "i2c-mux";
 		i2c-parent = <&i2c4>;
 		mux-controls = <&i2c_mux>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index a096f4d985e753e280cd3f8b2f9ee26588c19e0f..c727aac257f9c3a1f16dc357fce355ad46a3f699 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -124,7 +124,7 @@ key-volume-down {
 		};
 	};
 
-	i2c2mux {
+	i2c-mux-2 {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c2mux>;
@@ -148,7 +148,7 @@ i2c2mux@2 {
 		};
 	};
 
-	i2c3mux {
+	i2c-mux-3 {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c3mux>;

-- 
2.34.1



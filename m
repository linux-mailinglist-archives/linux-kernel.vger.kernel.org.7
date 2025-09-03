Return-Path: <linux-kernel+bounces-799376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70526B42ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CF47B67C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E036CE0F;
	Wed,  3 Sep 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/c6bbIn"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8436CC9F;
	Wed,  3 Sep 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930833; cv=fail; b=lFNzhpJfGhioaICv8rgw9eOSx6ckuVuglSlId/lCh3y0wNEdyyhnqu2NLQI8CHb2ZiX7j0Pz8b7K57FdgkpnK9c/TgPx4fGcRxOOkUxAoug7GYS99tAevTenFsXif5f3N3Vuz17Q9kxnedBu+jPk7mdGyVy7v9TtLYimbwQRA9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930833; c=relaxed/simple;
	bh=jITDv37aHoutTKOh2fRv2z9A22z8Ibcu2YqqrOGiA2c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Th7zUbmTt+XwZ8YdisDX619v2RTtFViHSs6OFL+oqj5lOFF5YMIppsSVHWuIdDlr+44nGhq0bFoOhdM/ZSM5D4+zhcjiLsv4RFLKQ30T+/R+Rgrnld7LNjA4NQyx4byVmjVeNJQTIgmIkQlAkhIdqlRQT9ssTP4BF/ZEzuG1ftE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/c6bbIn; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKK4oOVTbbWq4f/jeAjdPmJK6TIEokPbTLApcA5RggKJPQmsIU0dTpvNvxuqOK2fTxGdFWcdnaVJbtv8g9YeJwDRYCDG3Q3Z/jWg5YEaMcmqMiVYoYPCi2ErSf+Q1ODGC9xisv1Wxop4zysc1cVKMi/LapNRLxDv4sKLvFHsoGaYsMPPQ8uJKLR1z3x9B8dD+3N0qjrfTADFcplnf4mZGvkml+IENKC/AjRjIvOrJxWskW3W6ODjRqel4/rQ3OdZ7vhxhTy/95T7B6WXaTFsJ72bHuHDgeVukdW1tn9w/455CvXqRV63I3VS5ZJz1onkAUNfZ87hjl3xyVjJHL4Jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvwaVP9kD2iTo6X6VP6xIY4cM+hj5Tda6VWXTsaBo+8=;
 b=rBZOydIiP47MsTQp38tfY2bcL9E+4TE6duBHeZGsQRah0ogpDHa/rj0D5sqDQCcqVRQxLJsMWLnXLD4oONheLBNmjmLtztAPxxuFK3qFobzG75M9LJPHo2MKsOVKCQitoK2GypXDKHejHNOQ5FkTjUEnkHkht3b/YTm7mfod41ol38O05T+YWHWD9ONlKJNk2fE/o+MwnEP26lWNsWhpNRTfUg9VfJsKBh2pugtoenLsTh/L0VHoT/neJJpQ/VgkdfTBCOWY13B4JG1waQZ7v7QmhuuOScxSIxQCIriMfwHDQy8fLlsedFJFK41584AGsAnmyna6Msf8bbrPaef+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvwaVP9kD2iTo6X6VP6xIY4cM+hj5Tda6VWXTsaBo+8=;
 b=l/c6bbInmFNGupR3twDrrhUXYq5Xfo9QUb3cZ7Gdpfu591wnWdEpIsHqIvP9y1CXA5PtzYd3GzeUNWILA7EmUF56SHlGfnDsjh95sDq6ocp560JPmVObln90cyUSPCs6VSIyzSdlvOjacyqQPjM3Z2kEs3iGgBL1GuS37VaGKS3Tb8XIA4rEqOa+xteLRDiXRoToq/DQG4Cq5uVfDC3kK2Aa6TMY2fulO7U02VH4IJLhxvbs0iFDBIfk8b8HOQsqHbDXZmdrO6iqoJ5MLNZOeaaStC8Wf4u2YiJDQb4lvRtkDXnn/Tg2zhzc+uYrazTcd09vwLEPUUSbGC/6alUAUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:00 -0400
Subject: [PATCH 07/16] ARM: dts: imx6: rename touch screen's node name to
 touchscreen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-7-1e883d72e790@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=5075;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jITDv37aHoutTKOh2fRv2z9A22z8Ibcu2YqqrOGiA2c=;
 b=eDPqECXuEatSc8OGEEVoCtuCyNIGEK5inHEWtTKtzZSb6G8Os4Zn/OZAUpj+KCLWM3HBNlVKn
 /dKl5MmiSc2Dr2k1AnLs+h6Sn0FeddwgRcsQQ05z+wEhzsCcFIimWAl
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
X-MS-Office365-Filtering-Correlation-Id: 810c7d04-8919-4dcb-6b0a-08ddeb2751e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a29tVExTRDQ5YU1rSGFaaGxlSzJCRFdaam5iL0FsK2h4bjBHYXYvZHhDQzFC?=
 =?utf-8?B?QW93OTRJL1FvdXQzd3JWSHZGN3JyTTdScWtPU2dCcTM3dHBCZ1pVeTJmd2wv?=
 =?utf-8?B?ZVo1VG9XRjN1QmtadHRrUytTTmtmYUZTRkRaYTJ5S09sNzVmUnFrd1JlekVC?=
 =?utf-8?B?bTVya0VJMjNja25KWkwrTUh2bG82OSthdnRFNGs1Wk9qOENVcFY0TmRPcGlw?=
 =?utf-8?B?OElnU0NCM1UyR0YxeThZRDU4bFpWVzRCenJiUUk3MWlIQTltSWVERzZ1N2la?=
 =?utf-8?B?eGFiZUI2a2NWRDQ3RTZXd1UvRjVNYTRKZVZpSE43emVFS1BGV1hZZWRVMjNO?=
 =?utf-8?B?MEcvMTR5QkVtbmpxQWxzY1lmMEdGblU2aFlLQk1rZ1lFY0UxKzFTdU9NK01W?=
 =?utf-8?B?ZlVRVHpaQnBHZjFyV3VkZC92Y01RRmRuTHJLeXBPbVdab0pkVWZpRll6bmJ2?=
 =?utf-8?B?YkJqODhPU2V6aHdEa0wrdUpCUS9CREg1Vlgzd1FFTnZocytZNHlHV01CY1h2?=
 =?utf-8?B?Wnc3bW9uNW1HWmg5N1ZqOE5laitkNkIyUllwWUN2VURaTUp2K3hQbXVObnYx?=
 =?utf-8?B?Y1REL2pXekNWZ1hXVEt3ME9aMld5TFJvMzhSdVl1RnVGZGliOGgzRXF4N1gx?=
 =?utf-8?B?eHF2TU56V1lUN3BNUVlpLzVWTDBFY2FSbzhrdk9IdWY4VUthUGxtdWs3Rmhi?=
 =?utf-8?B?aGtnd2RFYW1vK0ZpZWpvcStWSWJtMjJXUVVFZ0pCSC9ucFhEZis5ZnlpeXdl?=
 =?utf-8?B?T2VNNFhySjVHMHVHdXdJRlNoeXE5Vm1sMUYrdmJHVDBNM2RId2orRHQxbWNV?=
 =?utf-8?B?M2g3OWdhcTdBbEVmWXNXcGVPSVlIb0w4dnpraHBEUm1yNEFDczNENUhRRFhH?=
 =?utf-8?B?eUFORXV1aUx0NVZMRVZHem1JYXRkbUR3N2ZhRmt1ZzF1a0hJeHE4aG16Z2ds?=
 =?utf-8?B?dlBsV01XRjZxRVpkcldoQVFiZXhmeVlETzRtMUdqcUJ4eHpGWmhJdHhEUlhL?=
 =?utf-8?B?SkprUHhKYkRvNUxmUUtidnUyNEhmbXFLdGpsQllsSmdHM3V4SVBXUTNaYUV6?=
 =?utf-8?B?RDZ3Zzd3OW9uNUNKY0NuenI4N0RoRHBIa0k4UlkzZlJPUWV2aUY4dzN3cWtz?=
 =?utf-8?B?dVZJMVUwNm5TaWZCZ0VmSkNqUHh1MitpT0REODNYZzc5RmZ6VEhVaGpqV3JB?=
 =?utf-8?B?QklRbk9QZEFjVktOSFAzeXdZOWZDakc5L0RKZTZZZXpzdDJFQkxwV2srdkUy?=
 =?utf-8?B?YTRIOG9JcjJCQmtrWEVRRkMwOTVvcmRZZi9VSktUNjV2VS9hSVNLQWc2NHBI?=
 =?utf-8?B?VHlDSk9OM21OcFR1Z2YwWWFoU1FVVUpsZmJMcmFPQ1FRUWJ2V1ZtZkZCTlVn?=
 =?utf-8?B?eWN1cXp5SWhRcEtIeHAwRXEyOUNFZk9pSnlDRk5BRFJZb09xb3I0b1N3UDI5?=
 =?utf-8?B?WE5uR2l0MGpqV2p5ZkwveWRoZUgyb2FzS0tsMEJWSG1XN214TjBUdHFtMVhz?=
 =?utf-8?B?WElhTEtySTZGeWptTUdldDFwUU5ON24vVTlKYnNIbldYUVl4akpsdU40Z0M3?=
 =?utf-8?B?L3FLbkFqcS9JWU11dnUyT2x3ZWJEUVplODMwSWFpbTVkWW4yVEYzYUJaNC9t?=
 =?utf-8?B?bUR2Y0lkSTNGOTFiWGZoOURPS21MbWlkWStyMEtYbW5WSHVSaDNXODZkNU9W?=
 =?utf-8?B?WWtleXFVdjVtUnYxamxsc2hmczNFN2VoR3BxUTU1YktPQlprUTVLa3AyczQ1?=
 =?utf-8?B?RDhMaExQK0hmZUFIenNGWG5RMG5za0JRQk0yQkIrM2s0TlhkbHN0cGQ2bXRk?=
 =?utf-8?B?clZWczZIaEVZUXpCb2pNNE5EYmkyZ2tydi9HVEZkdXBWTlpRM2d4OWdYR2NI?=
 =?utf-8?B?eTBNeU5td2FSRnFTK3RUaUg0TDRpemlIbmxZYWUrcjEyWWdpTGZqV0RBejlC?=
 =?utf-8?Q?GD6QHoExq7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXlta0NhTWFpSW5LV3AwdENWWnJkM1NVQ1J4MGFZS1ZVK2FXZWFwd1plQUY0?=
 =?utf-8?B?Zk10MWdRTjZWazExdk1naXJaU3l0blRBQWtJckJqbnA2NUxOaXUrNjhFV2lk?=
 =?utf-8?B?RjVBN2pObUlWTytheVBKemZIS1g5V2pQRGMvU1lsazc0dnZ4S3VtN3U2L1JR?=
 =?utf-8?B?T1QxMGlQTGlSbkJCZ2dieTBuc1QwMWg0MDNuODNFSnNhSW1YUWQyU01lb1dF?=
 =?utf-8?B?QlFXUVN0ZXN1RGpZTSs3U3RyekRXZ2R0a0oxY0N0Ylg2NVdxcENxblY4U0Fz?=
 =?utf-8?B?MGhwTEZyUmlMNVZYQi9RNDA2SGpidStwMUlTcXNhVDVvcWEwb1g3ZFdJT0Jj?=
 =?utf-8?B?dDJpTzBhTit2b0ExeGs5Vm9uWXNoN2VURXhEVDgyNVA0SFpsU2d5bGtOaXVS?=
 =?utf-8?B?TFlJTWlkRk5mdllBRTdFSFUwQkMvS0N2T2JlQW5xdytUWnN2SllNKzQxQ216?=
 =?utf-8?B?TE1ZZXpEbGFqU0NUcmpXdWIyNEpSOFlkbnVLQTRKRklpZ3JwQjg3dVhybmRp?=
 =?utf-8?B?T0c4TjlYaTY3enhpNnJBdmxtMGdhRjVtQjQ5c1FDTDRlOWJuRDB6REI2K0Fj?=
 =?utf-8?B?a1VEU2ZGSWxveTE4SDhMOGFWa2JjVFZQUnFoeGxQTFhIU2dIUEQvRW1YTU9F?=
 =?utf-8?B?OFdONE93SEtMeUxYNmNFS05VNFhmV09YUDZBSGZuUWVDMldtNFVkRExiQXdH?=
 =?utf-8?B?RWV3MnUzMkNZNmIvaHRKUUNRVG9QWFM3OFpwTW1CZTJMQml6NTltOHN3Um1N?=
 =?utf-8?B?Tm9RM1U4aXIxSTkwRUJUeDY4Yk4wVXJCNjJMekduYktUbmZpWFh5cjN4ZVdP?=
 =?utf-8?B?SHZzdXBXWHRQOXYxc0k2T3dIOTA3emoxVjd4V3ZpZTY0ZVBERVh2UVl5cTNp?=
 =?utf-8?B?NGowY3FBYU15cG5zaUdEbWlhajVodFRIRFBLTFVEWUNmMG9wbGxWY2owU1Qw?=
 =?utf-8?B?cnRwZmxiZ0ZlekpnOTd3MlNUNDN3dVN6NnJCWFM4TkNXTUd1QW42V092ZXVh?=
 =?utf-8?B?Z2l0RGVMWkhKY1ZMUlF6MkJnZ2xLd1F4VW5INGM4UU4zQ0ZKME5wZnBIWU9I?=
 =?utf-8?B?eHYySHlrTEFDbFVUalVZa1ZjQWVLUnNjblNvdG5VQXdBSWFRVm9NNWdIaFI3?=
 =?utf-8?B?MXdTb1loYVlvZ3loYXpqcmNrcEJXbTBvWVhMWXFnT2h5K05Ed3J2ejg1R3hH?=
 =?utf-8?B?M21IckdpM2dKVzJTcmQyeUhsWnlGSDdGQlFZZXpOYi9HQnA2WGRDcHdtRnUy?=
 =?utf-8?B?WUhoN2h3UnRPVzVraGlRSWFyZlZtempJS3htN3BzYytmekpsSUhyaUJOZEVD?=
 =?utf-8?B?VDdVdEtrbDVIZnlKcVBwWTNUMktQUHQ4Tjl6a1UwMlAxV29CZXpCb01nRE0x?=
 =?utf-8?B?K1Z1SWVjeUFRdDhTS0JXK1JqeUhtYzVjRHVCK1lROG0yWE1nSFdEOW5uRUJo?=
 =?utf-8?B?WVluR2xUQ0FldVVuMDRGcFhZWUdiSE0veEQxdWtyek5lNGFNbzdQeG5POFMv?=
 =?utf-8?B?OStValFvdmY3VTJ4dll0OWVhZ0lFYlpUK24yN0N4UG1vcjEwUWhqaGNqNWpC?=
 =?utf-8?B?Smx2LzY0QUFZU3NEbHQ4U2cycGI4WU9CcUt0eVJvRU1qUXdJU1JXRytkb2RH?=
 =?utf-8?B?SllRdk5xU2p1VUJDSnFEdEZrVGVjQU8zVDRkb3plaHlIVXFheHR5M2E0aGRP?=
 =?utf-8?B?OU9tdFF4YU1naysvcSs4d0hYaVBhMjdQQ04yYmRUM0lNVE1OcldHVTF6b3gr?=
 =?utf-8?B?L3RRbjBnM0Yxc2N3ZWg1QXlLN21WYXlha0dwZlpMRzNYckpOc3lTNUFkNzFj?=
 =?utf-8?B?NHYvdmFFUGlxZUJadjkxSU9GMWZWS2pqRjU4K0kyU0RLdHhxQi9nVG5mczk5?=
 =?utf-8?B?VVlBQWg0b256TjZwemZzc0wva201MjlnenRrcW1HVXR2bUlQUmVpK2ZTNS9L?=
 =?utf-8?B?UFdpODlYdHMyR2ZjUjNXc25XZnpLM1FIalpzVlB6Y0Y1UTFRckJlRlRYYU5Q?=
 =?utf-8?B?bVdHdUJ4YVgrQXphdWQ3UzE4QmJEWmhOZElXbEsrSG85aERjNE9oOVlxcEth?=
 =?utf-8?B?bnd4ckNYRktrT2tTYlNtVU93eUdxRmxnS1RDMFJlVnQ1aEJiV0RxY2xHS25n?=
 =?utf-8?Q?RTZ49SBcTey9VE3ITHKTQJeSA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c7d04-8919-4dcb-6b0a-08ddeb2751e0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:26.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByuBASfjF2PfGxVXKkiYqsVDCPAbpnhwyLZbtLzZiW0LGspQmKIUgCupQxRyex/XHiJD6isqwkf+yxypX1X7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename touch to touchscreen.
Rename stmpe_touchscreen to touchscreen.
Rename stmpe_adc to adc.

Fix below CHECK_DTBS warning:
arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dtb: touch@48 (ti,tsc2004): 'wakeup-gpios' does not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/input/touchscreen/ti,tsc2005.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi                     | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts                   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi                | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi               | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts                | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi
index df543b4751e0a66f22c42a0df9e2c51982648ca3..89b17509ad48729c2e4e985aac8f05d1f80a36e8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi
@@ -47,7 +47,7 @@ touchscreen@41 {
 		interrupt-parent = <&gpio7>;
 		irq-trigger = <0x1>;
 
-		stmpe_touchscreen {
+		touchscreen {
 			compatible = "st,stmpe-ts";
 			st,sample-time = <4>;
 			st,mod-12b = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
index 4d25090db55f956972c7535e7309fd4ca17ddb7b..24fc3ff1c70c2f3c9ac4309f9c7c723f003096d9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
@@ -288,7 +288,7 @@ touch: stmpe811@44 {
 		vio-supply = <&reg_3p3v>;
 		vcc-supply = <&reg_3p3v>;
 
-		stmpe_touchscreen {
+		touchscreen {
 			compatible = "st,stmpe-ts";
 			st,sample-time = <4>;
 			st,mod-12b = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index b13000a62a7bcd87c74f66d52bcb8f3cc4696b90..5fcd7cdb7001ff3ec9e31a68f31b6b813b4ba821 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -648,7 +648,7 @@ stmpe811@41 {
 		/* ADC conversion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_ts: stmpe_touchscreen {
+		stmpe_ts: touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -665,7 +665,7 @@ stmpe_ts: stmpe_touchscreen {
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe_adc {
+		stmpe_adc: adc {
 			compatible = "st,stmpe-adc";
 			#io-channel-cells = <1>;
 			/* forbid to use ADC channels 3-0 (touch) */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 3525cbcda57fdf800205792e9b64e5219c5b06e7..419d85b5a66061d4389df5d42de626183c27a9e6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -572,7 +572,7 @@ stmpe811@41 {
 		/* ADC converstion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_ts: stmpe_touchscreen {
+		stmpe_ts: touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
index 0b4c09b09c03dcc2a8628a8eb449143e32cbf8fe..a3c2811e9c6fa90c1722f9b3a29401637b8eee1a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
@@ -162,7 +162,7 @@ stmpe: touchctrl@44 {
 		interrupts = <12 IRQ_TYPE_NONE>;
 		status = "disabled";
 
-		stmpe_touchscreen {
+		touchscreen {
 			compatible = "st,stmpe-ts";
 			st,sample-time = <4>;
 			st,mod-12b = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi
index ec042648bd98f4b73a03e059e6452e63a328ab33..c6064f4c679b32e2215ac90646c3c2f2636be59f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi
@@ -61,7 +61,7 @@ stmpe: touchscreen@44 {
 		wakeup-source;
 		status = "disabled";
 
-		stmpe_touchscreen {
+		touchscreen {
 			compatible = "st,stmpe-ts";
 			st,sample-time = <4>;
 			st,mod-12b = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
index 7ee66be8bccbe67211dbee0094642f122805739b..7acd28658e6ffa3bc649c93c19d2f0b8e5a9f51e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
@@ -270,7 +270,7 @@ &i2c3 {
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	touch@48 {
+	touchscreen@48 {
 		compatible = "ti,tsc2004";
 		reg = <0x48>;
 		pinctrl-names = "default";

-- 
2.34.1



Return-Path: <linux-kernel+bounces-854913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74DBDFBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E593C2A97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A733A036;
	Wed, 15 Oct 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBAFC/mx"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7D33CE98;
	Wed, 15 Oct 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546723; cv=fail; b=DuddIo4dYx5lyb7ncVSFOOELYTLnGdW42Prx8HpImOijg/FRk9ElGeUEbft/shSWamJXT1Ua9fTNzdkcHrb6ClETu6C5MY0Xg+TQ7RZiZ18V/6ONu9iaxiUPPb/kh4iCweJmOoZhFLpcsB2Lw/QdRB97PcPWzuF7Vy/JNV0riO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546723; c=relaxed/simple;
	bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ThS2mzHaU+z3buE2BmoSYRldmc1h+y0DbO+dO5lttnZFCKicp9V/BV2MvjI3R0ZOwRKYYKIhOY6F9Ln9GnWgyI0mIeZYgjkLqYhs4Z7+5tTzwgn6r7glhfXPQHDKUA1Ang/BdhtzWi9f+F5WansnbSV0Genk5eIFcnAfHcFoh4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SBAFC/mx; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjlrDWwegAKo9dfmL6Nb41zYf92Hq+UO4BZATdgjASKwYKTCM25Ab2WlzvZLHvvOUypkmVIyzCrvCFI2rZcIMxYq9eEItx62Zt4LkIlC64BdqgFo5hyzFeJyljyW/b3SDm7yIPvw4FK9bYnTO2xTDZR/bgnNdPg/xXGoil0/h/ERJo6fVHiqOkUmXJO7baQCGXMUi8hmlT9/9pTBVzNHO/2G+mYWr2wfMEHA9IrsoNmVE/YynrSWZXsggI7wQcO74dDgEmqvPbLrNQer3pZgWehMBYe3rA045f1toGf8QCKtdy/2uRxOKmaqhRZ7c6eGC22GAgon6fPCqMlCAv2V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=eyafk5nEVlOtWgXR8pgkxyTFjjEPQcEdU3CqodiGk0KwLDTifPCj5CZVubXs56SczviF+fGAO6XuxJgkQTjh/BDH9onrfB/FDLKNKzh0KOv4yWg5rnR6EH9I9sZTuA8yaqThYJ/qqPeIvFutrvXtI5Px10zrk5sHT1SbbjvHVnjd4jdlZ+9eA98FE4om0CteQB3N+QK8wgMAQ5eob43F9kbRiywEHJkWQQ5bKR4H8lF84vmLeM0sj7v8lS4+8wfvnjTo4MfQJ+KS0MVByCXIwmBy0xNvqu3Plw1QnAx8yZLHFm0XkafiDzCJUy3kIS/g6WIX1HG02AlSBJ11RooAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=SBAFC/mxUKB2ilbw9o9+PoN7ffDuieY+aSMN5qK/eL17/Qwlm3OgMO69/zzZBdjZRaiLa9ff+wDrtPuB1DeYwxAc2yNh6RYzjo63L6Xz8Sbzvyn6yszkMXWWJ6djSYj9RUnFaXRx9TtWyTx6FXOMbHRySIxxsB+diZ6fYLjapSWi95D+QnFkfeR1+fR5ddf0ARkoYDbvUIy2ZvjL4mmA1kCmADdewgxUEcTOBvBHpP7LeN++y80Dwgw3By+IUzwUO2Md+lj2IsPgaur6jrGCX7mcIyM2lfPqwKhMPLio3gRi/8+ZXKqZ/+QUajcnsAqeR0zZnpUZWl9jEo4NdGRJoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:34 -0400
Subject: [PATCH v2 09/11] ARM: dts: imx6q-utilite-pro: add missing required
 property for pci
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-9-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=1718;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
 b=8BnBj/20dezF3O1040dGxHqB7bATEiOnSHKm8KZSDIf3ytdUb8NVgWYvJvqFW5u1J2DPZCtns
 ncYvpG25G4sDPwRTJ79lrN8L/17fejmzVJBmXpvNn2jDEPCZTD5h2s0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2364781e-3529-4d4a-db39-08de0c0a3781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFppZWpZK0J1Y1dMdGNsa01VdGF1TiswWVB3YzNsOVkvK2VhbGNiVlBJdzlP?=
 =?utf-8?B?bkFielhxRkxubEdlSCs5cG5QelJsNkJVQWlhUkxMcWIzQjRIY2NLWG03TDY5?=
 =?utf-8?B?MlNpK0MxcEo0c3JLcnozWmtZL1FaK1p0WW5ISGs2amx2b2t1QmJicE9IMjly?=
 =?utf-8?B?Ky9rSTVIU3AvZDFYcVNGSjRLT1RHU0Zxb1NLenU3TWtnV0d4THc1WENnYUs4?=
 =?utf-8?B?UWgxK0N1aGpPY3BoZUVGQUNtUFNrUzNRdFFaQWw1MUcxUjJQMkd4U29lY2Rl?=
 =?utf-8?B?Z3RyUnFBUnZUd3FNQzV0cHRjNmFGMEs4TGI3ZFVyNzNjZVlsTTBjWTFGdWxN?=
 =?utf-8?B?UnRzdkdTQVVPM3Nib2tIMTAvaXJabDVvWjZwTnFhV0JYakRiTXIvcWdWcVIw?=
 =?utf-8?B?VEovVmtFK1ovVGcxQWUvZTc0dVNUS1djdUpvSHhTZDEwb1R4N2o2enpCWFJM?=
 =?utf-8?B?V1BFTjNCZllhL1FETzBqUTNtbEZvU1QzSFVqVmtsWXllcmp3clBsSVFnTy9X?=
 =?utf-8?B?ZHc4MHU4WENLdkw4cHJQT2NNd3crSGhCSGpKbG9tYTJ4Zk8vMzdCZmwyWkd3?=
 =?utf-8?B?M3h0aXpnb0dsOW9NV0JBa0lOZ1F4LzltRmpCK0pZWVQ5aEVWNEt5VTdFYjkz?=
 =?utf-8?B?L1ZHN0FFTHVCMHhLU2RvQ012aWVDUmdQaDNkekVPNFpmaWkxNTFIeEJ2NUZ1?=
 =?utf-8?B?eVhFTS90aU02bjlnWVgxUFBoYVFBYzFLTm0rbkJLWGcxNGx0MTJ2b2xiWUht?=
 =?utf-8?B?MUtzQXlDZEdPdStDVFV4VmthZHB2QnlhdUQ4Uzh0aDhGUWsyQU9vVUlCMVRk?=
 =?utf-8?B?Sm0yYlFPWTA5anE3Q3VJMUNlQzVBQTV3U2FmcW1FZE5GSXNHdGowL0s1MVdz?=
 =?utf-8?B?b0JFYUR0NU0zbkhiOXJWREZqWUUwOGRRNFhOUXBVdGduME5kbUsxeFVjaldS?=
 =?utf-8?B?ZU96dG5QK2cvbzlMN0RUNU5SNHBVa1RWVzF2RUp4aFoxMXpCZXB1Z0tLMGFy?=
 =?utf-8?B?WjJHbWdBWEtrOThaN0UyazhPVUh0SUVsQWtDaS9lS05kU0hlYkVTZ1VoQkc5?=
 =?utf-8?B?eVpPR3J4ZlVuN0lCR00xdnBUTWpYRC8yQXF6Z0Nub3FXOTBGS2NLRU5BZ1VG?=
 =?utf-8?B?VlpmL3hFWFZPajAvaiszejF3Sm5QNUVJVnB1aGN1NjFnMVZSdjRiREg0K3Nn?=
 =?utf-8?B?MzNpNmV4ejczcTZ5WkM2VnZyaDBvY3ZkdE9ZUDljbnlNRzZWNFNUa2N5NmF3?=
 =?utf-8?B?ZjlZREhGZWtMOThaOGNkYUxlNklPc1hvNHdrLzhEeVBFdTBVRGRmcXhRazE4?=
 =?utf-8?B?bDcrRFpVR0R2T1dtMm1pR29uek5Kb1crWlZJZEozanFhUU1rcHVFeG04K1pw?=
 =?utf-8?B?cHFkUFpwOUY2THFVc0lDV2JaQm56NUdjbzRpc3cxcFE0dUI1SXd6SjgzT0Jj?=
 =?utf-8?B?N2U3WjFIY3QyL3Nmd0ovYTZBYmpjeGdocERMYktHZ1l4cjArdmRHQyt1Rllk?=
 =?utf-8?B?VDJRQUVVL2xNbm84OVpkVEpIekhwZkVoeFl1Y2p1VjJMMEJ2eDI3Nm5DelMv?=
 =?utf-8?B?MG9CK2gwUW9IWSs1TXVSWVZVZk9jVGs3ZUJDUk1qNmJGZU5lamUxMW91TThK?=
 =?utf-8?B?cmRTaEVhU0tuUUV3TGFmVFJEZktFeWgrWlhUYXJLcEF5Z1g5Wm9jWnRUcUxX?=
 =?utf-8?B?Y3BHY3BqVnRVelVCbkJ0OWZNWElzVUtsaitWT1JGZHVCRzZmQ3JOaC9DTGgy?=
 =?utf-8?B?Mjk1SjZHTVZVRFhTMGQrNCtyQ3g4Z283bEVJa0wrTXdEbnI5RVloakx1RTlG?=
 =?utf-8?B?QVBQMmt6RXh1SDUvdnJRYXpZUlBFN0xyWlJ1cU5tMVZPeC9BOVZyS2hIa25m?=
 =?utf-8?B?NVBKdWQ1NWNsWExkQW1PRllhMTJIRHFhbTFCdnpIT1BNNWlhMllLWTlrTFJv?=
 =?utf-8?B?QmRiK1BtUlpSNlRNeFk5TzlWcDZyN2I3OFBmUnpyS3lhUDFPcUJCUDlYV1cy?=
 =?utf-8?B?aVE1aGNhZ2lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVU5M3YwOTRscVZNcjRJUWRrWlVBUHpnREpFN3U0akt0WnZnM01nYzdFWnFt?=
 =?utf-8?B?ZDBIcndhN3lwRWw4dys2MWZPVVMwREVYeVVGeW8rdkpvZUgyeWtvNGc1c1pu?=
 =?utf-8?B?WlQ0VEU2YU5IN1k5UE0vb3BaQUtkVzJIT0ZqTnJYY2RxL09pUlh4czduOHZz?=
 =?utf-8?B?YjJMOXhwM1dMY2N2UCtwQnJqNUU4MjkrcHRid0kzaXg2YWdEUnExelJTRDFm?=
 =?utf-8?B?YkZubXFnOGRKVWFmN0d4bVlsYXNxWkd2SXN5MW9UR25ZVkMzbDBqM0JtVHIw?=
 =?utf-8?B?WXFwL1JiZXlwM0l3Z0hDTXpQMGdVZzhmeVV3NkVicmJDMXd6SmRhMFhDbmxu?=
 =?utf-8?B?bkVmeEtEM1hZczVEQWRwKzRRS3J3bXVUVG1EUGJ1YWwyRUJ6UVlLS2FPYXlq?=
 =?utf-8?B?ZkFMQ3RzVm9hMlNORFRoenJId2VBc1k4by9sZ0REY3RqdExWdGRCVGVPL0xr?=
 =?utf-8?B?ZVZQd0Z1NU52M0pweUpycUlIbXROWjNWOTBDTlpJVmtpZVdsbC8xN1VNM3dx?=
 =?utf-8?B?VG5qVDdxcUpiUWpzL0NIWUpkOG4zWk9BTkJCd3ZZamI4dDhpUHV6M1ZmYzQz?=
 =?utf-8?B?c0JlZHV2cGtoV2R5eFYwY3RDOFpsVGQwWW5XYnlXem9DRzQwd1VzdU5zczRY?=
 =?utf-8?B?ZVRwbEExRFM2UEwrU0piSW13Rm9kdWY1SjJuTHBqZlZQTFZYTmYyOWhSWm42?=
 =?utf-8?B?bHIzNXNjRmFwTkVseHlOMGwwbGJwaURBWlNHaVBmRTQ5ZjVLSDhnMXFlRWxJ?=
 =?utf-8?B?QUJOWWZXTUFQTFQwN1FCdjkyVGh4TkN3STBYOXpKdjZlWUYvZEpIOXU0Sjg1?=
 =?utf-8?B?eDR6RUMxYXJzQ0hWOWU2VytzYWF5eWcyMjV0VzVlRVlZREhFZ1NxY2dVaDJQ?=
 =?utf-8?B?UnNhdkU4SUFPNHNxZklRUzlUcE9MelpUT1k0TnhRaVR6aWpGUDBROHpCTS9T?=
 =?utf-8?B?V1NnT1c5VGo5RTh4KzZqc0VwRG9LdS9MS3NTK3AvdURiUFByYVdTQnFEejg4?=
 =?utf-8?B?TWh5RUdWQjFsTk1XenhrZENnWS9ucXFsVTBmRDc4eDE0TEtWUUd0bHQ4V2Vz?=
 =?utf-8?B?Z0xiSDZhRE9GUHNCS1c4TldLbmlRVUNiYis2LzJsL2ZkNCtMVWZoWTBFcDYx?=
 =?utf-8?B?d1Q3a2R6Q09JdXQ1SDFpdTQwaFFmU0xaVU9WZ1BvK2hQUzFDdzFGUXNET1V1?=
 =?utf-8?B?aTJ2TktkNVJuVUtaS29vdDR1RzFxWE91THZDVFdZdWwxR1J6bk1vdTIwbS9X?=
 =?utf-8?B?QzQ1djVOYjRkOWQwdzV1T3pDR0hTNjdyN0xtMGttUmt2UjNmSjRUZU9xMWVY?=
 =?utf-8?B?OWx4UWFkS2VPaWZTakNjd0lEMTE2VWpFR08rWVRTWGVnWjFQWW0yYnA4aytX?=
 =?utf-8?B?aDdFZ3JsdUNlaUdtdit4WUFpWnpCZUtqSlp0eUJzWUtTRjFuU09CemlCQ2Yw?=
 =?utf-8?B?Ti9kY0xIa0hyc1NHVTBhd2VQTzRHWTBaUXU3RVRPWjBQR0ZDY3l4TVBHU2FT?=
 =?utf-8?B?NzNIMjJDUGZyeDhIRTJGeFl2TGdLSUpxUzVGZHNTNkkvcFhKVG9xdS9KREVx?=
 =?utf-8?B?Y2ZtR2hwVjYza1NIVmJxY21RRFhnSDd6WHhNNmxPK01BTWlTNjVTbkJIRWcy?=
 =?utf-8?B?eXJubVZMVVF6WVMxUGsxa1VhM2RzWVJud3Y3SkJ1QVQ3cWkwcnFIdmM1dDVr?=
 =?utf-8?B?SmtpSUNJYTFsQUg4NXNIMGJHWXlFNFd2MEdFR20vMHoxSFFJVDNIeVE3bEpW?=
 =?utf-8?B?N3h1MGtDSVBka0RzdUdZVHBZTjVuY3QvZTdZdFNuMzNJRGhuTkwxK016Sksv?=
 =?utf-8?B?bnZ6OVdRUEFQb3pkU2dWNjdWVnNpZ2UxbytzelZ4U3dYQWpMNUNYSm0rOG81?=
 =?utf-8?B?T3RhbngvOUM0UWZ6NmxSa1Nad0hoZmI5ME1EbXNMeXhLZjBuNlpJZEMzak4w?=
 =?utf-8?B?aDA1cExIc1ZvY1ZlM3NuTG5xeHdFbXZsWnpXaTU4R1BJNnAvN0JhT1NsRkc4?=
 =?utf-8?B?NjRFNkxjbU9nZkhuWkZ3d0grQjBXb0JEcnluNUVOYWFnZDFjV1FvbEVOVy83?=
 =?utf-8?B?VkxsMnZWZWhsdHRiSnBBTlg2aXNtMUxVOUEvcWpiS3ZQcFFlMGphQmtvTklY?=
 =?utf-8?Q?cTRE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2364781e-3529-4d4a-db39-08de0c0a3781
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:15.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83eynYlCS31b/MhfcuR75Uot6UGo8BgQnvBL1mDfkeg3Fs68boLyff5fTKbcQyG4FIJ8+kTCXbVnIf0ACWdrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Add device_type, bus-range, ranges for pci nodes. Rename intel,i211 to
ethernet to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
  arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'intel,i211@pcie0,0' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9#,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index aae81feee00dba2761f140fc2a76a828f69a8308..c78f101c3cc122f418b708b1c274ca11b586b65c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
@@ -326,11 +326,14 @@ &ipu1_di0_disp0 {
 &pcie {
 	pcie@0,0 {
 		reg = <0x000000 0 0 0 0>;
+		device_type = "pci";
 		#address-cells = <3>;
 		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		ranges;
 
 		/* non-removable i211 ethernet card */
-		eth1: intel,i211@pcie0,0 {
+		eth1: ethernet@0,0 {
 			reg = <0x010000 0 0 0 0>;
 		};
 	};

-- 
2.34.1



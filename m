Return-Path: <linux-kernel+bounces-874650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE787C16C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6F401BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C234CFA3;
	Tue, 28 Oct 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWAYCxbZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0A2D3A75;
	Tue, 28 Oct 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683466; cv=fail; b=G9+w4TlhNlZxxB3k0i5dKvxMuwjo3YfBdIANObfeeCJ0gg/Fb3WDqV3PzbGWM4/yF7zAKW299ic56VqC3cG4gtudvQiAVcLpgR89bhUWyPfd9o0jsb3v0Vjb7d7DjKBFSXOJtjsLyZfIItbJIzU7Aqokr5/N92R5KZrGgRUA1Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683466; c=relaxed/simple;
	bh=sdlGwN29+XAJcr/y7mfw8WTYXZVtw3PUJ0pjZkbJMhM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A8EbLQ7K9dOC+qCAnCniqB+P3xsRATP0dwvfiJWRdkUnbL+z3J/n240/aHIrfc3v1ocKv1zjDOGKTnNXJyBIEG+dEZZX69WGBhd3uHav0ERYv5vUNM9yWMPzgaxO7pyrR1WHe82irDdtDIt8mKdIrpo4taodXuc0B81v/cmSMDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWAYCxbZ; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksNdfJP5LIPxZKJU3xD1lDkJkJP3GuHVnoBU1kE4ocTMie0dqiHa06J4CyUzlak0uw9qhTP7f6YAOxkj9Oh+sZVG3m6c/L6AtyF+aF595hMTPoaChIeI+yuJ7OoDCtNm/7FsZl/emQK4uVJtBO4BYhiCSyvZL5L7pxQKL9Ru2D+q6RLSU6zeeP2xUVn7SoauI5dLQ1X32YtzdepC1oCD1MUjCgOCoWOfSfz5g9isWx6RndV+HxKHJhDmg9wM0oXa0sPfY0mGrtKm166dtZFpTQBqvKjFBDgLHT0Z98opdNVUuUDVsHyYm/yHBqxtuTNDHunsb2vmAH0oUe+StzxW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cL8fbxty179vrlfB0WIx9hoEQbPRQxuI5qK87GfxNc=;
 b=L1jtpdBR70IISmUkoAVM3mmt63DGWTdUNGLtrx17GC5XKHOTPrKsTtre74PfCaJ+5PTMUqV/kgRdaCxUAwik4XrabHZgN3t4tXPCV8rzzhCzFxQ6+/hMlJIRMvqNmL3rwArXF6EmhUIgvWfTRpfL9PhoucXf0j+I2fvkfUeaBkWezXR6EaQdlnWHML71BgKndfMK7OMgLt2No44eCoC9BrHiMD5KS9+h+kScGtEVlK8NR8uSspsjNaBvw57ZKWRQ4tY9K+90RJQn6307ZvTVa9HvLzZeOf9IiurOB6crq/+sXUrbNdGgFn/TAnNksAHVj9xC/LIrRgH/6jz9pEcz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cL8fbxty179vrlfB0WIx9hoEQbPRQxuI5qK87GfxNc=;
 b=oWAYCxbZuRmjpDB6ywFSDSaGF8usGZ9VQlf7pMz3GHwTdq6bSwEtZPIqdllgvTS5mwb0MvtO1itXAKUXHOS6MCLAYVrBcVCje5T7JJ/qySrLRF4nxLUo2CSIjCVpkGdKuVdfxhnIEyjJ1gF5WlDwwzoJJEX/o8/L5Z3uD0TNxE6EpW3KgrFxLblS5oi8PUTc9polYfiKQ4XNgoPm5pguWb9FnoWd/WHtdGOZLpr2gKeInohzW6FJ6AYNel5gstiVNXcZVhtizrekqvjwXgKgj5TrIgnIc79kmzMaJz4fh/SKlOU1nuoBHWLF7PVPEAjdNVBtJEZn0A22HaT0E9Qk0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:43 -0400
Subject: [PATCH 2/8] arm64: dts: imx8qm-mek: assign double SD bus frequency
 for usdhc1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-2-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=849;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=sdlGwN29+XAJcr/y7mfw8WTYXZVtw3PUJ0pjZkbJMhM=;
 b=Xb8iEjoGPr7QGKFWt3qARf9yUErjt6P2g1aUYsHD+YND6oAu5xYjoLLcijgADIj/T17xURaD6
 qW3JF4WKqy1D+lfFkh91MnvY7CPMFeLo48mx+0xN2d5nKjNn+8iVEtL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 7022a175-f5d3-40ce-d437-08de1660e98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNPTm05R2JPU0tadmR5RU1YT1NZSEk4L3FJTGx6c2ZHWTk5dW9PNVZocnVl?=
 =?utf-8?B?NmFlVGE0YlhmcGw3QXRvZngwYkZNYzdqVzNiR2IxcW9Hb0RROEZUN01yQ1Rz?=
 =?utf-8?B?SEJpMUlHYWoxd2ZqUjl4Y3BwZWwxdlJaU3JERjVMaHUzRDNjaWlsdytzRURp?=
 =?utf-8?B?L2UwQXBwajJkVHRsZDFiSmhPZnpBRDBVNGN0ZHBScXNtek52YkxsNk44T0Nh?=
 =?utf-8?B?dURQeUZmMGhrcUFTa3BLc25EUXZ0YldHcTUvdTRuVDZMRGhJSGhBSnViNm1m?=
 =?utf-8?B?NFlTMEJQWGF0TVdnSDMxUmZYVys0aGI4bk1OcmhXeGJJYWdwZXFXWndnU2k0?=
 =?utf-8?B?WHNpaEZDdDU5eS9tREsxdnpXekk4WlNRN2dsK25uOEFYdnRQQ2diSWxteCtJ?=
 =?utf-8?B?TXNzSUFrVWVqdVlvMEhqcHJTdFo1Yk5xZ2JEQzcvWTMzTy9qcWdjTUdnV09v?=
 =?utf-8?B?empIWTkwY0xORHhDa0pTUXRoaFQ4R0J4QW1HeDVtZEdmekp5b3k4Q3ZEdFln?=
 =?utf-8?B?YkhsR2N1d3RqTmU4ZHk1TVJ1SDloSXlWYklrQUdsdlNKYlJ5TWJ6MVdJKzZ2?=
 =?utf-8?B?ZWFteGUxb2VrNUtBY08wcEVWckVTQkQ5OUpaU0plTjg1ZmZ2N1RIeDZhamNB?=
 =?utf-8?B?SktHekdlK01KRW1oVnM3RGJsZ2hPNkJVMzN0M1hManJJM3ZPSmFpQWdwc2l1?=
 =?utf-8?B?bkJEYzMrak5xSlhwN0lqYUxMOElESTZoUnB5ckxxWDI2NkpCajhvMENuWXRZ?=
 =?utf-8?B?RXF5M1hJT2VoZXJxVTYwTlhFRmtza0NEVjI0NDltRlp3cjhYR0U4VTF2ZTgz?=
 =?utf-8?B?dVFiOGJZS2dLa1B4Tjl3U3V5MEs1ME05SUcyRUxrVDJVTUdIby9EWGhnR1U5?=
 =?utf-8?B?U0VGbVZNRnNhZC9oM2hDeDduSkF2SkIwV2lhclR3eW1kUm5NNmllVVdsa3Vy?=
 =?utf-8?B?VllkdEp0cWVhTkhCNFpHRE81L09yQk01MWdKSnBoUWs3NFQ4bWpGUFJTOFlt?=
 =?utf-8?B?bzdKOVhuSkF4clRkdVdtQVdTWC8wQVQyV2llNDhaM2dHdHpGaVMrMU1HQ216?=
 =?utf-8?B?WitYNnNXSXQ3b0pHSUIyeUgxZmhFV3cvbkk2dEtjMzZISTUyM0srV085RTFu?=
 =?utf-8?B?VXczWEE1SDdyK0xKODZkRXRFMGZDOUFQd3BZbDVvcTFncXA1eDFUYUljOFI4?=
 =?utf-8?B?UmIwZ1VyUkxrd3NvbnNpUTQxanJIMkxCQm1VM3YxdCtlRTN4M3ZiR3FHWDNl?=
 =?utf-8?B?WUdZaWsxVnVvVjN3QlpQRllUTTZrcy9lT2lWTFRTdHlCRVZNOVd4L2g3dUI5?=
 =?utf-8?B?LzR6RVR4Slk0R0lQelcvNy9ua2VtdHpTQWJpQVNhdEVjYi9pQThURlVYNXpa?=
 =?utf-8?B?dDZ3dzkvTU5rWW80TWVkM3hWeFRpMlpxWWx2eTlrUld4QTFmdlhMd1JqL3Yv?=
 =?utf-8?B?eTM5UWlWSlI1WmN0SWtRVVRtY0JvWlFVZ3NZYVRhbEhnSVkzVklUckhEMEdG?=
 =?utf-8?B?NC9uNFV3Q3ZWUHJETEJuSFREKyt4bHVTcUVtUnJ5dkNJZUVVNjhTRTFPN1J1?=
 =?utf-8?B?MVJ3WkVzeWhTaEFBSE5GbVhXekRXeS9GSmFZT3laZDBPTFl2WFNzTEFid1Uv?=
 =?utf-8?B?cm9uUklBRGJSemhibkJZdHhCNFBxQXZvcEFoU2I5UjdqaFN5ZDNFMGlTSExm?=
 =?utf-8?B?UXErOGIrNWdRaUZTdEpxcmYzTndMMEhia0lNeE9wcWhLNVU1VWdwbDdCQmJv?=
 =?utf-8?B?cnVrMXBJeXhQYlB0ZWcycWI4N3JSSTZUZER6MWg4M2E2dTdKeEQ0Mlc3cDg0?=
 =?utf-8?B?Nzd2aDkyZE1oY1RqVmo4cndTT01ya2hUM2ZBQUpZWDhBelNXTlptK1Y5SzE0?=
 =?utf-8?B?OVRrZ3ZQVlNTdzlRZmZhbzIrMCt2djRLMjBzc01KVmhyUUJkdHcvVENJUmky?=
 =?utf-8?B?b0VRREpQalhlaFd3ajF4SGFobHlhcUloTE1pVERSUVI0dDZBL3hhWEN0UUpN?=
 =?utf-8?B?L29NZlVHQWFuQTJpY0svd005QWMyN0JpNHpkQ3pHTUpPcG95UmFKZ25wQjl1?=
 =?utf-8?Q?tsAIND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTdNN2FESFc1THBoVDBDT0h5L2g0UWVPbDI4amZCeWsrS2R3a1k1dStjUjMr?=
 =?utf-8?B?QWQvMDZYZ2Z5cklNNjFEenNWTTNjYUs0Qzlpc1BYWjVjaDhwRm9CUng3ckF2?=
 =?utf-8?B?cjhHcnNPaDk1dkViNHVSYlYwVjRRcXdJbThJbHdmQ1o2bXYrYlFveU1PN2Zj?=
 =?utf-8?B?cklURHl0ZWhmWEdGRlh3UGR0dkgzOVBFR0NGYUw1RjBxQ0Mvb29ZelFXSU9y?=
 =?utf-8?B?MGdjN1pleHZCYmdrTlFFZFdTZXRIdlIzM0RZTytoUkRBRHhsQ3g5SnVSZUhI?=
 =?utf-8?B?d0NmMCtaY1JsQnQybkQ4VGdGTjViVU1GT3FsMWNSQm5OdkJCOEhZVW9nUHBj?=
 =?utf-8?B?SkdEeDhna2s0QzVxdWREWTVkYnF5aWRaTXZuZ2hSRVBRSU4yaVZGem1SSVFW?=
 =?utf-8?B?WTBVRTZPRUtERGVLd3VtRmdFWHNPRk9mdWZaS1pydTBwME5BaEpPSDk4TWo2?=
 =?utf-8?B?dEtvZ2JYSmtTQmJIYWpJRlVCWTk5VENrSEN0dmE3WVR1a3VDcE5CcEN1RjNj?=
 =?utf-8?B?MkVyTy94UnYwUVFHQkFMeFdaTlpaYXJNOWwrZWhvYURQQ2pBUys5NTRBQ2hX?=
 =?utf-8?B?Znc3MDE5b2JOODQ0c1dGSHBtZEJIMllDQ2pUdmZMTmhCeXA4MmkwMWxnUXRW?=
 =?utf-8?B?MlpPeis1MHZUdWdBcTRnL3doRzhpTVpnOFI0L1VqUW8vNklPMXRlMzkyMVpL?=
 =?utf-8?B?dnZiVTd0aUVBRHpsRTZENTZlaVdDbkZqN3dpNnJVVGZya1hyT096RFBUd0JF?=
 =?utf-8?B?cEorWUU5Q05ZS1lWTzFmQVNnMVZWR1VYMEx1M0xVQWJRQUFoTzdaWU9sM0pm?=
 =?utf-8?B?d3dFUnlXbk9wUGljcXU4VVcwVExZU01GWnNhUVA3Sk9aTGtVMHlpZUhwN1VP?=
 =?utf-8?B?eXREeElkSWQzc0gzNFp2WXdpWmRhVHpFMDg2cWFlWTNKcTcwSmNjM095d0hW?=
 =?utf-8?B?NTVjdE5jbU1oSlAzanozZU9Ubks5OUVQSFhJcGNBdndyUWM4UDJXazFXL0xl?=
 =?utf-8?B?Z1Rtd3dGN3puUkNuSnN6RThrU1pNL01yZC9rT3pTdVpHb3N0bTRTZit2Zzha?=
 =?utf-8?B?UkZNSmxZVzJLdXhvQXVlbGthc092V3Vaang0K01lamhDNlJYU2dmOHp1akIv?=
 =?utf-8?B?Y0xtK1FZbkRGa2tlUnB5eWV1VzhrdS9FelhBUThhQjFKTzA2bnJBaUl1Nlo1?=
 =?utf-8?B?Y2RTOEdIRElodWsrNlN4RWxRY09wWitxRE4valdSYU91dy9qZHZnWGl2bWs4?=
 =?utf-8?B?SklhaHpId0dvdlFQWjdKTlJaWUNoeUJycjhpcTE4elcyWWlvdmg1S0V4UDdn?=
 =?utf-8?B?K0pZbDF0UnR3NkkzT2R0b1pwa0RYRklOOFE5MnJ5ZTJTVkg4eGhRQkp6bmdU?=
 =?utf-8?B?d3duUnJrRFAvNVJzNnUrVGNEV2o1dk82WjBYejJXVEFkWkJBYlFEZklkVW0w?=
 =?utf-8?B?cEl2dGRLejFqMmdrSXRLT05oM3BISW9PdXpFbkJYL1VNbktlK1A1bGVOcjFN?=
 =?utf-8?B?Q0x2ZjNwcUc2NUM5N3pvekVQTjJMOVQyWGFmR1ZnTkFvOWVRS0poTk9Ycjd1?=
 =?utf-8?B?SWs2UGZaVUZBMFdaZFk2ZmtkSVRWWkt1STUzM2x0dXF6YW50RUdJVEVqd2FJ?=
 =?utf-8?B?SW40emlLR0tycXV0VWh4TjVWZkVrZERWS2hPUmpqbTRxMHhDVU45dlA4WDBj?=
 =?utf-8?B?NDFvYXV3VC9lWkd3WDJSc2hPNk5VS3BuOVZLMlEwejRpRTNabjlpaEVNWE5m?=
 =?utf-8?B?VWNCWHE1VjFEaXBDakh3WDVYUSswM1ZEdE9hMk9ubk1LMjg0aUp1eit2allU?=
 =?utf-8?B?bzNKck5tV1gwUWEvc1BtVTgwbkxQQzU4b0FaYnNGVDFSbld5L3VyUFNNQzRW?=
 =?utf-8?B?c0JUOVcwWE1nSVBxMlA4RG83bEZGYWZCcG9UN0I4OUJsQ2FxVk15QUlIWlVR?=
 =?utf-8?B?cE1vdzVuVnVURldjb3JWSWdscVRTckJHbUFCdWdwenllVi9DNU1XYjhwWU5T?=
 =?utf-8?B?cVFXTkdWUS96V2ZIelJYT0VJQTVYUDFxbWVjUGpEZVlaU0dWM2NNdG1oU0Np?=
 =?utf-8?B?UVZVMFBUVzBxMkhxMUFiMUl3dHhHTEM0cmtxblpsckFzcjcvZlduTXdkZ0V2?=
 =?utf-8?Q?CfdM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7022a175-f5d3-40ce-d437-08de1660e98f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:02.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDZbOQEGYuKOkIDtuYOdKVqZeU8mBRQbMFlw3fKbsLmhhIAoE+kFVZUACAZRH16/K28DNSI4NFkO+oGiOTq9xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Assign double SD bus frequency to support SDR104 mode, where the operating
clock runs at 208 MHz.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 6f1c78fcf384a7691f7f8ea1b50ab21cd6e72ba1..44b8e9c75c59aa31cf9dd04c3d03be047ef82ff9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -800,6 +800,8 @@ &pwm_lvds1 {
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1>;

-- 
2.34.1



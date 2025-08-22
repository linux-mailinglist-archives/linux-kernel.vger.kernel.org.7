Return-Path: <linux-kernel+bounces-781286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F2B31086
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A251CE308C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953C2E92C3;
	Fri, 22 Aug 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="K03jObR0"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023078.outbound.protection.outlook.com [52.101.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8652E6136;
	Fri, 22 Aug 2025 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847999; cv=fail; b=g8W4viw8KXtRKe7QDA2RQ3rIDptfUxRdk1yT/TFWfvryEHkqjb/apydjIQVeC2qmwu2nhFPYZ1KbNYOBEYXBh3lXzC3mz64EeOsNSF3rud07Bta5KZi2M3N1FMQy8SnDS9QnXI8UTwWihYzd4WRxA5S77ObQ7Ac099g6J4dp21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847999; c=relaxed/simple;
	bh=/JJTQ3Rf2pbrv39MzGlq5znFn+svycWOvPbnVWxrE7I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=crVFmc9w/HRbPds0l4OKD0+fK4X3YkgatadaNiti4nLJ32gaN9rFDoBtO075LNCuKODMAgkfTIyQUr8lUA6BZJiON2jPEUX19k8IKuVq2XJzHHPGJJHm5HoEPVIzLGkf97hMpN233tCvvirpi1j34MITzssgbx8rEtuH6Er5FKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=K03jObR0; arc=fail smtp.client-ip=52.101.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qANiGAktd7ks/Z8+xWSyRHLgH6cD646X/UjbujkL5mxvwKDHNxwHP/opogEdUgwbMcy2HdfjprpbWdHUp2L0UqqvAvV5+0sDGecd1jHCDDgDDctKnwoAw1a5QHoi/zHJYf+c6eXYOKKZc7AvHE0b4XhhkXnUNCjYbVrG4btszI63Z+E0z6K+wfCj63NkEtNKErUNzGSqm30x8/3OUC1LohI2SZuzOKIDOr9T/j521k5MKOz+MQ52gsSAgJee/X3r0Y4CEUnuVzgyV7BlU5WOgjuC/OA20LRcSqdpa2UjiJkTJLv0lEKoPWkGbf9GPsPMSQddvnY0aUcZGvSUa2e1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3Fld+/TvLNcfXgjcaIgvPZFgu9szsUuRr3o5DkzRL8=;
 b=mSD+yhiOH4hNFDGN03IWpeR6Kij2KWvPH3/2yAWC+wkWgrjkMRqKUyOUfEy6KcgP3OPao8iODqQHWJ+YoXGMlw1Uptr0P0vZXAwwsJEyJORyTm1r/phqYPwlce5X2qCPoTXWLg+Ok61C6k60rJZ3MOLGVb+3QfaNWMoILulQgDrVQrhQTw/VJ0LW00CrMYGVdbf+FVX5cpSc3IuS1/f79ONnnQxv8lOVh6a/A/tblf3PcPHRFzmDVzG3E0xsu5qskSdnq2anH/kFovXmbLat5YFA2jNzc7GWdWrB/ZSxzYaRVAdDvEtnAge2AUof88GmsFiuBx7izpQUjnAgVRfjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3Fld+/TvLNcfXgjcaIgvPZFgu9szsUuRr3o5DkzRL8=;
 b=K03jObR0OgQuIKWXRgJ+97pNOtwDZ5CVsTgPVJL3/gXhBckBokvtEM1AtCgsX7LCoYbxwfPCcLSr/eryENhoQP/Kd+xJzvZtpWZ2HpHHqSZgSQUFdAtEZLHSBoahEALnufR+LtSaRDqLD8253/4lNjCKv1lbUKHEeeOO6hpotC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com (2603:1096:101:146::7)
 by JH0PR03MB7493.apcprd03.prod.outlook.com (2603:1096:990:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 07:33:13 +0000
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071]) by SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:33:12 +0000
From: Richard Hu <richard.hu@technexion.com>
Date: Fri, 22 Aug 2025 15:33:08 +0800
Subject: [PATCH v5 1/2] dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and
 WB-EDM-G carrier board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-1-bf745447345a@technexion.com>
References: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
In-Reply-To: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Richard Hu <richard.hu@technexion.com>, 
 Ray Chang <ray.chang@technexion.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755847989; l=1270;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=EnJ6L+3ymwkC5QMgOgOeEqM27jZ+6MuITwnew0dMxrY=;
 b=VQeIrE26xshxoNxg+mFcy6EEFZs0ag/bodTyHIkl841a/HKLtVsvnEq2ylL7l97AVYA53qFV+
 EkrdwuLo+UkDxdXEs+biPhRV2sys9WNU6DC+J1ZYBjf4AYmAREg3XiM
X-Developer-Key: i=richard.hu@technexion.com; a=ed25519;
 pk=MKoW0/U0r4MjJdRNaq37Tb25KE1fzJUdMN0pa8XBJSA=
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SEYPR03MB7464.apcprd03.prod.outlook.com
 (2603:1096:101:146::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB7464:EE_|JH0PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: e956daf9-3e25-4665-85d9-08dde14e2615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDBsS3k0SGVXdUNaMndrRjZQK3Vsd3RMRlpxcnZQRklLTmlKZGR4RTF4aE5h?=
 =?utf-8?B?VTk4Q05oWU5kVFByRWZIK0J4RlRkYURtTE1YZUU0Vm1JUFQyYWV6cWJoRk94?=
 =?utf-8?B?Z3VMMEMreG02MVgrczB1SXBvbWdkamxKZ3kyeXlWekVMd2NXZ3hWaEFlOGU1?=
 =?utf-8?B?VGpTaGhvQ3U2VEk0YjhQVzUvRHFTUjc4VXNLWGtHTUtiSHNpMk9yN1FuSlpm?=
 =?utf-8?B?VTNXaUU5RXNlLzh2RzZ3ZnIrc1FXbFNwYlBUR2sraXRzUXFicjRQajgvM0FF?=
 =?utf-8?B?Zk9kc3VEbDJzdVAvRnVjQWFyTUNGa3lMZHArRWhTVTVSNlc0WCs0SkMwTE5C?=
 =?utf-8?B?cTJpMkNyY1V1UDRXSS9WdlJ3cDRXSitjdjJiQk9nNm5MSzNMZHgvaXc1UE9y?=
 =?utf-8?B?Ny9kNk9tSUQzTm11djZUSU5pZUlmZjlUZXVhNWNnYy96bHNrWVlabUtldjdD?=
 =?utf-8?B?RkhpOFBnQURFUk52eDFOWk0xVHpwVVF2Kyt0dmxtOW1EbUlXMWVmQzhjcGR4?=
 =?utf-8?B?dW82MkRJYzhlamZCN0piczI4ZFVhRzMzd1RJdW5FWmZjcDlzZXg0U0JEak1G?=
 =?utf-8?B?MHE2SEtKSy9TTnEwbVY3a3MrU0ZqbGpPc0VRd3o4QXRwUmxJa2pvN3RYQWtt?=
 =?utf-8?B?bnE1OHRteEpoUHI5WllUWUxvOVBRc0dqb0F4cy9CeTFhVCsvR0tCYXlGVTNh?=
 =?utf-8?B?a0NRbnAxWXc0NndWRzBFKzhqTmM4OHFwWkwyYW5FRktxUndlQlpmRDJoVFJx?=
 =?utf-8?B?VGdFbnJoQTZseExWcXg2NlhSOHh1UHowWmFaeTJyT0FRZDJ6OXpReGsvUGlY?=
 =?utf-8?B?aENyQUc5OTN4MDVlSVFpbVRydlFSdTJwcUZMNHFHdGFkZGlHUDl0SithaGNj?=
 =?utf-8?B?QW5JZ1NxRVp2Zk5aMDZZZGk1SnlvQmlZbjhoVGwvSTNZS3lnU0RGaEE3aXVP?=
 =?utf-8?B?NHQraU9iZUJPcFNpdnJKOHFxd0RNZWVyMHg5ZTJiRlFicEU2bE02NnRZdDVV?=
 =?utf-8?B?M3pyNGgyVTNnSlgxWTZUcDdVQXJJTVBtTURuTWlibjhIaVdyYjN2VHF4RW56?=
 =?utf-8?B?dnhncjA4Q2lOaE9EMGNpV1lXRzFyd24rU3hQMFB2TUlaeEhFM2xrNHhXRGIr?=
 =?utf-8?B?QVpSSjJtS1A3d2xqeS9zN3ROaDhUWFhWQ2tqYnNUUUlJai8vZTlJRGlCZG0r?=
 =?utf-8?B?Y3AzT0tqTTZ6aDVnNndTSWhVMHpKZFM3dTFlWEljcDRBL21HRVZLVnZ3Z0ds?=
 =?utf-8?B?V3ptSXllME5qUW1Ib2Yza0pOUzNtSThibTMyY1I0UHlFa2N2T2pZamo2M2Vp?=
 =?utf-8?B?Zm5FWXJsejI2a3dDbzhSU3dORVhEWDhhUjVsM1RHS0l3b0NYelFwK1o5eVlr?=
 =?utf-8?B?UWJ2cURuOEg1SkYrNCttRzF4bWdwTWVUTWdodDlnS0lZYkovcU11ZFdjVFF4?=
 =?utf-8?B?bVRyQlFBUS9zbEZiMytRb2h1djZWWXJVWU5FemtxWUJ3SnQ5dGRDWkhNNDdV?=
 =?utf-8?B?KytXTi95cW1ERlhHWHZZUWFPUG1zYXViczhwN1d2SmYrMDYvUllueFF5bXBL?=
 =?utf-8?B?NTZZRUx2Z3llSko3UE5VOGNRZllXZmVMeklnQ1pHeXVqamU3YzZRLzZFK1Rh?=
 =?utf-8?B?TWlMQ056RmFZTnFzS0lia3dEZllzV3FENHpOQ0xpaFBNV24yaVpQb2ZteTdE?=
 =?utf-8?B?SDgzbzBSQlc2NStYUVNOeDBTUGxSMSttc25SYVh5ajB0YkFiVzkwZFNGUXRj?=
 =?utf-8?B?N2QwaXpVdHB4V0RNM3lVR00zZGp5N0ZJMUk1bGRyU2x4c3VUcU45TEpTWDZU?=
 =?utf-8?B?TjgwcUkwMnJFcDlhL0Q1Sm4zVjE0a0lIcFJNWkRGZ1FERVk0UFhFaUpWTHlR?=
 =?utf-8?B?K2N6MDk2VHdFSUhEQlNyeFNNTitveW0xY0hpb25NcHNIZStpbHl4L2NXNFRK?=
 =?utf-8?B?dk1oMm1wMkloc3lMVk9qbHFRUjREKzhCMnNPdWxyYmJ1V094RGJhczkzd2R4?=
 =?utf-8?B?RmlJbnR1dnZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7464.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlI5MVIzSzh3T05SaXREUGxtUFhWM1Z3OFJ5TmF0SHBEMXcvcElxSldVeU14?=
 =?utf-8?B?RUtxblphcVVUUDVpOXVDNFkzYmRVSDJRTlo1bVJ6VThNYmVVZDE2K0RyaWR1?=
 =?utf-8?B?VmNjQTRPNnFTU1RyV2MvNmVTbktBclpSYnYvcHg1a3dhV2pheG1MSDNML1VL?=
 =?utf-8?B?LzdWUXFqNTh6cmJCb3hDT255SmhmbVlndythOERzaEt4S0xybjVzRWV3RkFD?=
 =?utf-8?B?K2RnWGp4YmhQTmNRKzVRQnFzazRtd3A2OG5ULzVnTkIvUG9yVE8rM001RzB2?=
 =?utf-8?B?ZEhjb1FkV1hzc283Mm4rakh0eWowYVl0RUJvbzJTZUZlV28wUXB1VWVScWdk?=
 =?utf-8?B?ZHVIN2pFL2Q4NVFOSXlubWpSd2c4TXlPTE5aeFpIQ2Jxb0VXdnA4S2hiNlhi?=
 =?utf-8?B?ak10c0hKL2Nienc4enpCMWpKbGdydGk1NDMyU3k4bmtTaERrbFZCV2hLNXJF?=
 =?utf-8?B?NnZEUjdhNUtPTVhkS21qRklTZWlETFNNYm1Fc3U3STE3clNNL2RYNkcxU0xy?=
 =?utf-8?B?cTc3aG5TZ3lDZnNBTmdTZHdXVzYvc0dSdkt5VC9rUm9aaUdWdmttbnU4elJU?=
 =?utf-8?B?MXZxeGlKUVdDblQ5YmlLSXFXZTFlSVBRd2hIdVA2Y0sybE44RWxKNmF0eVow?=
 =?utf-8?B?ZEVlL3BDQnVYR3FLVVVmYjBYSm53U3RFUzhtN3J3aGUxa0RPZDRDMFV1c0l5?=
 =?utf-8?B?bVVwTlpYSGU0NnVHRDNFM3hwQW9kRExIODdhOHFFbWtrL04zQ253N21qaUda?=
 =?utf-8?B?MmdVVjBCN05lWmc4Z3pleHJSSERrR21YR0NKd1lURXJCWEpkN2ZvcXJoTUp0?=
 =?utf-8?B?aXZNaHp3emJYNWhBTnBnNi9ZU3o3MkMzODI4VUVyRmx5TGdaVHhKWXIrd1Bi?=
 =?utf-8?B?T3RwR0pGTC9qUEt3Wmw3Y0NYT1ZNZGZ2ZWtLUFBjeVorWm9kaDY2NUZWRE0w?=
 =?utf-8?B?WFZiK01oVUwrbHVXd3NBeVdFMUx5RWNQUXppZG1SNlhVekxBcmhnNkJIYlc3?=
 =?utf-8?B?NjFVaHJSQUlEWmhWODlObjV4UFlqNndsVVZ4eTl6dnlqWGsvK25KZEZRMDli?=
 =?utf-8?B?L0NMSHZBMkpPV1I0cHoyMjRpaHRYRVBTcmRxa0kyeUhVTTdQNWZiRG5zNUY1?=
 =?utf-8?B?NFBHUXlxQ0U3YngwOGs5c2lNNlB1S3BhSlh5TlFiVlZneExOcDZUbjRwQlZy?=
 =?utf-8?B?bkNTNVRnUlZrOE8vSzhUbElVVUxjVnFTNEh5VWJDZkhQaEx2eEJCazJHTmFY?=
 =?utf-8?B?L00vaEdFd1VMWUVJdURBdWxwVmhkT0JROHowN1Q4VTVrZDJIWWJaWVUrSmJs?=
 =?utf-8?B?NXlGbnBzZjVVWGxnSzhlckNVdkdoU0h3TDh1QXhEYXJZRGFTRDNDcDJPTWNw?=
 =?utf-8?B?SU1FTUtsVStOUXU3dm0ybFI4b0ttcVMzNDZhUW9HdXArcHlCZVk2OGI5cEd2?=
 =?utf-8?B?VS82OFI0S0JNcXVCYm84ZGE1TEhyUzV3WUJEQWg5K0Y5bU5JRFM2cGIxa1pD?=
 =?utf-8?B?aWJLSm1mZy81NkVhY2R0MFoydjRtTzIyM2R2ME9vbXZETWV6Wjdsa0VXbGpy?=
 =?utf-8?B?TEhlN3VpOXdFNnFIUVlmUXlDYlp1bURHSnRMQktXUHpPcDE4MDFRckFEcDk1?=
 =?utf-8?B?cEhXZkZ6Q3R3cWdyRGxlazNuZGNtOUpPcFQyRW5sUHBmaTN1SGo1Uk9KeUJI?=
 =?utf-8?B?Z1JZVnJSb0hQY25Lb2pzRTB1VTVERDdGaERKQ0k5bTM3Q0FacytIelRSL0FN?=
 =?utf-8?B?eXBFZ0tQWDNOaEVCbWlrRUthQXUvVHpudjgvdlFmYU9YWkdjVHFaOFZRSkw3?=
 =?utf-8?B?VC85QW5KeVgyM1B0NGZaWGo5WUVDMm9lOXJ0Tm96VmxDNEtvZCtnK3k4SXZt?=
 =?utf-8?B?VUwvaUpNckx6ck9IdDZPZFpPcnpaVURTSURlYzJ3bExjYWlMNUFFNUVPbDc4?=
 =?utf-8?B?UUp2MU9IT3lBNXBOQjVoRE9RaWk3cUNmM2lsN1FPem5Da1dOYmpsZ0xDRFJ2?=
 =?utf-8?B?VGR3R1FpNU5CTmh4MUJVbElYRElLN0xZN0hhRk9VcDQrTlMxQmszRW5KaGQx?=
 =?utf-8?B?NmprZ2tuYXRPZytLeUpHa3piTHN5TEo2T0lObVNoazBMQlRDNHdoREc4eTdm?=
 =?utf-8?B?RWlBd0Q2Zk40UG1xYWxwTGdMcUdzMDVZaCttRkRGdy81bmFJQnlwU092blcz?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e956daf9-3e25-4665-85d9-08dde14e2615
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7464.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:33:12.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD27f6als9MHyZ+cPJNeN5gII8kIO4KCejjHWjbskMKzNohXgaDUxB380vIyzlCtuKPq9Su98167oeif2A/aA4Wsdh/dqsVu4Mz5EJFegdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7493

From: Ray Chang <ray.chang@technexion.com>

Add support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board.

Signed-off-by: Ray Chang <ray.chang@technexion.com>
Signed-off-by: Richard Hu <richard.hu@technexion.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3e9f9e0735a..8733419b5a9c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1200,6 +1200,13 @@ properties:
           - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
           - const: fsl,imx8mp
 
+      - description: TechNexion EDM-G-IMX8M-PLUS SoM based boards
+        items:
+          - enum:
+              - technexion,edm-g-imx8mp-wb          # TechNexion EDM-G-IMX8MP SOM on WB-EDM-G
+          - const: technexion,edm-g-imx8mp          # TechNexion EDM-G-IMX8MP SOM
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with SMARC iMX8M Plus Modules
         items:
           - const: toradex,smarc-imx8mp-dev # Toradex SMARC iMX8M Plus on Toradex SMARC Development Board

-- 
2.43.0



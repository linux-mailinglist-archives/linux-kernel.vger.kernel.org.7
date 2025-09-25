Return-Path: <linux-kernel+bounces-833239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDFBA17F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568B11C8131E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65A323413;
	Thu, 25 Sep 2025 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OPjel6Tq"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366743218D1;
	Thu, 25 Sep 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834880; cv=fail; b=MSE98pKFndE2FEPSFaYHJOiJ/Xyv8koeqW/vz7gO8lkVA8WYwlwd8TbcT2vw8aR8f6jI8yH9bcXAJ/7xKMMTCtdu/FQgWKlSjEOJ7ne3aZ5sZlFt/fZg6Uk+Q0DiX0VOwJ1humWIjk+YlkL8Kle5viF8KorLTiRVS/7CEfXPiL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834880; c=relaxed/simple;
	bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VsFI5XMX1Ca+l/VQTBZRXc9rPt2FR3Q3Lj/O7/Ie4xhKwmLKmnrfaftOnnHNz3XHZmaSC3SA5vGA/bz29683UqahzNMbsZ0TsLhe6m4CKev9Euz9I+kCJCwASXRZ1lM7Bwhv0Il9toR/OZR74B8diAWNIKyM5AMRl5ugRAfR6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OPjel6Tq; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU/z763HvX7aNpiFBmWuR/FPP60hWBMmA3dGHjtT47hix8Ms2VcWcVfuxGF5++v3Hv68ervLfiaLXXBauM0WqeGi5Y1hSSjueuDETHi8u8aG1WyPnOu2dfIh8x+fCN3XQJokTyMImjCUPSvFzMLWDFzmeoqEWHkiN4G5Rsb3GKJyGf6u87RSL7BYAdfE2lSuyhAYs7bCXCEv4662hrcxNXjLwANz447iaD8YjuQf91g4RlC3wj0ZvuKw7swbexv7qSF8a9MfKz8X/69EcYVIJsxHvicvecO5maH6G+HSsf7Qk8fKxly+mzGCo6p1bHpxC259SfpI286zqg4eRxq85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=QRdeCtoElpfvOyHx2OQPdrTPVR8W/6DdurtE+Gwm/aSwwRGy485yev3KRxNfLLr8jNtUYWOnIVd4O+488Dc03U2corFIVpYmifAy9ztqPMnstitygmhrw3xPsqiBD+X/KQ1ZqCYOWeTJMHmzarPGklapb3QAL6u0op+O9zJEGUk1QGNtO29W2ZHrfIz6uodj4nVm0qeeCHz7EMEEtWJMbdeVmI5uXGP9Kx2zPQfY24yqsnvhDBk/sBZfhOUw+wVhFvazE7M/ar8VRj1C1YdSpZ7nUbgondKvHpVCNSkN9OXSIi6kjHAVOAjlcpYrP9cTZws5HScK1rF/pYjHB6g+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=OPjel6TqOPYMtcUK1OHtB12BtRV/bNh61wywQ+mLqaXhz6oCv6i5tjDSKJGcoVqk3arUFS/Nl8O4ybeoNmyL2swMmArKuT+lG7jyCelPxha2GE/ogxrtp3XeS1cbrDP4uG4VpOD+DBLTyYa4clTNKyKdbiZwDZOkPhANjB6NyW4mK+gO8gf6DelNSOWzib2IL3pXKt44TG8kYJ0PyJyeL/Nhs7SI82CFYD1017NdboKtY4BtkaroQtokH5ftyDyxt/IdXoPT0CtBtLd4JaUmRqRhDkvtJxmewQD8RjvXmv07K3ZMuHrlgIY0p7QBV1+k4Ldtw1OfYyhGB+GpwgfR7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:54 -0400
Subject: [PATCH 10/11] ARM: dts: imx6ull-phytec-tauri: remove extra space
 before jedec,spi-nor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-10-748380dd0d22@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=1012;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
 b=FA7CADxSINL+0uCMKwF3f1uw3NS8oQ9UIN7FQLXxBYEgGOEDCNEXIEIK7nOw51slA8HQf+/ef
 Efd5/N+bq/8DX5T2e7e9KTMOsC7YH5aBAAxUBdomKCQq6ZPjXRANiqt
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
X-MS-Office365-Filtering-Correlation-Id: 692041f1-c654-42e3-9ad6-08ddfc78887d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnNsaTJGWSsyZzNXeU5LTUtrbXlJSUljVURpTFFjWUM4Y2lsZEhtU2d2ek9q?=
 =?utf-8?B?WDZKeEtWSy9QNklxV1lvbUF5bHF0K0dxelo1aXllVWs0UjJRODhyaS9oWVVw?=
 =?utf-8?B?WDA1R3BNa09CMURPdTNNMm9DYjk0Ui82MEpRdVVZbHh1K2E5azRkVzZMQzVj?=
 =?utf-8?B?amt2VEZlSVE0TUlWQzBpby9QdE1kQTIvcktnZEJxT21qY0R3eDNlc2dMd3lB?=
 =?utf-8?B?TEZhWDVzQW82b0NySVVUcllPTm9ReDB2QUFSWVNYSC8xOEN6VUlCbjRQTmto?=
 =?utf-8?B?REpjdmF3RnJwb1dOVW1HOG9ObFNjUVFBWG5raHBIU1A3WWJnZk1qNDNvUTEw?=
 =?utf-8?B?ZVJpL2NEL1RyQ3pvaGVwSzdIRUxCMlBEUWlQSkN4UStPQnByVFZXdVlHa0Mv?=
 =?utf-8?B?Qkg1cU9ycHFDZEROVEJWbEJjVGJRK2xueWUxU3lSa0dUQzhHT2I3RkNmUVBB?=
 =?utf-8?B?dksyTU1lM2dMTXJRQmFZeTc5TFpVOTl1akVzUXZvQjB4L1JMT1RPVjlJTStu?=
 =?utf-8?B?LzJibkFqRVQxMU5UMHdlOFdTdzEvbFNYRTlwWHRIdlFoN3dZQzAwUTNNS0xV?=
 =?utf-8?B?U0tlSmlOV1RiY2FEbUF6TU1CY2t6dlRoQm9CamdNSWVJak93SkMyMDRRcFNL?=
 =?utf-8?B?cm0wRE9oVXFpSzQ0MFlQNnZndUFjZ1BJL2M4M3ZjRHZVb2RMRjl6VGZ1NVQ0?=
 =?utf-8?B?TWYwVmgwNGFCSXZZZWZIalZPUkRTc050Z09JTGR2RFhzdWQ4OEk4UWtNNUNQ?=
 =?utf-8?B?aGNnSVE3Z2c1c2pycDJCdGRDaC9TMmk5MjhyQnBJaTdsNjJ5NWdGa1FWTXB5?=
 =?utf-8?B?VzFkTnJhejI2ZlZ1TVdBc3hYU2RDb2czUUI5MnoraGt5NE1zRnl1UXpVSjVW?=
 =?utf-8?B?K0E4MGdlY3JlSkx5SXVVUVdhNmN4UFBiS2ozVG00WmxOazdrL1F2OEI0dVVj?=
 =?utf-8?B?dVNTSXZXOXp3ZlNWUDZuVVp4SEVwbzN0Q3ovMXJ4c2syVUFHT04zYWtockpz?=
 =?utf-8?B?Zm9wUGJ0VUd4b0JLNzFQT0RNM09DclIwcVJydEFVb3luK3V5NmZWOEhaOVZV?=
 =?utf-8?B?eTAwZE5IdjZQRWVBZ2VoaGEzaTNBMWRCNlUyempaSm90azh3a25YV1dMUGg2?=
 =?utf-8?B?bkxRYi9HVFp0REQyemtYR0o1MHdwTDBFamFNKzdTK3Bub3ZueTdOSjNMZXcy?=
 =?utf-8?B?Y2pYTGlseUFnaVB1R0RHVWdDOHZtbFZuWFhUVlU3T0JoM2cwSTRyNnc3WkU4?=
 =?utf-8?B?SlBCZ2tkSGdTRjJ2MGhKeHdjTE5yZDdqZUsvWURSRnBaRi9KWmVIRytndlps?=
 =?utf-8?B?Znc5TVVUQXdyVW4reDJEVW54cG93UHcwcThSYXpTM05aRnBjeWI0ejVhMGVM?=
 =?utf-8?B?L3pFdm1HNWtyZXg3Yjl6NWlWdHpiRlF5Rm1WaE9JR3daUGNscGgyVHVNWHkw?=
 =?utf-8?B?N1d6blc0SzF6YmFCMFVQVTdtNzRhZnhwNGJOcWpMd3F5WWVnNm0vcHgzTmZ5?=
 =?utf-8?B?clJRWmFUMW15SXVoQUxwd1hJRytZS3NXNTJrUm9RSWdMa3pzRlpsdWtEdTdS?=
 =?utf-8?B?NGxMQytMdTRFbmc5NkdvWHJtbCs1Nm9hTkdNYVJJLzdueWE1MU95blNXdCti?=
 =?utf-8?B?L3ZXOTlCT3N0bHNVU0hLcitIcFBNT09Ldk9vOWZ6Zjg4UVViTVlkRS9POWpO?=
 =?utf-8?B?VVJwMGpiR3VjTkQrdEY3TVNDUXQ4Q21UM3hrU01acWNVUEw5QUkvZG5kblpC?=
 =?utf-8?B?bjFzY2NkamVreFM0b3hSZTVpWklXMVBSUGhaVkJLOFExa2ZRaUNVd2xNaTdR?=
 =?utf-8?B?VnJmQVJESG1lNW05VDV4d05OUGF4VzRuaTBYNjE4MUNWSElUZnJFWEY1elpF?=
 =?utf-8?B?a3lnc2lNSXBWa09UQm0xa2lzK25MY2NVK29HL2hvTjRZK01rZ2JjRlBWai9h?=
 =?utf-8?B?c05iL1lXb3Y3QlRNZGZJeFM2Q2ZNNHRrS0Q0dmlVclFyM3NLT01LQURGanFD?=
 =?utf-8?B?S2ExWmJFNmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZ1TGVrN3JaTU1SVGdNNlZWUXZXa3BIN05aM3lmMEd2TTJOdjlRd1R6Yjli?=
 =?utf-8?B?QlZKZmJTTHBpcTdVSG9SblZhNnYvaGY4ZzZjS3lIT2M3bW5jazgvUHVvaXY5?=
 =?utf-8?B?dCtkcjIwYmZQK21MY0xhZWJpMTIwMXkrMmdKOG5maE4zUjlvVzdkSitHTytq?=
 =?utf-8?B?QmY1RDVmWlFBVXkraEtLc29MT2xMN3dWT2VZSlJaQ1lEWlRyQ25ueXF6b0Jt?=
 =?utf-8?B?RDhyM0NwcTE3NlpaMk1JLzJRN2E2RXdCWEZOcXdZaTlYTHpMeHk5cjhkMk5n?=
 =?utf-8?B?TG16N0ZaK0Evbm0veFQ5MWZNSSsyK1VXTG9GZ0hQOHE5Yy95Q0VnVFY3R3Bu?=
 =?utf-8?B?TG9vblF0OXgxM0VaR282R2FZbXFSQTM0SDBBWFRwdUZNNUkxMHk4aWRWemxY?=
 =?utf-8?B?c0hTV0dVay83b2JXdnlvaDIyNGw4d0lwS1RnZmg0VnU2bVpuQTRndlJmKzEv?=
 =?utf-8?B?Y1dwRlJYYmFBMCtUM2lXSGZrTWc0S2tPZnV2Mlg5YXF1Sm1NYWJtMjVPUHhi?=
 =?utf-8?B?VGNNa3FDa0tLYmJQd3hTYW82NFpURkVhSERKYWpPQ1MvcTN5clNBTEs3Mytq?=
 =?utf-8?B?SnZQTmw3QnUyQUdhekdqcXc4d0hLdW5sSlNNWFFodW5YV3ZMYlV1aTIzK05q?=
 =?utf-8?B?dzBZL3pyS2tUN3FFSHMzV09mZTgxUndNR3RuelV6MDhEUU5ZT0orN3JUYXk5?=
 =?utf-8?B?WXROZUJJbE1WWXR5QTl6UjgwVWpudDhaeUk2ZFVQeWt5M1NQT21YZG4yTm5Q?=
 =?utf-8?B?M0llSnVoM2ludWE0alRUZnFDUUNyU2ZNdlFBb05vcUZGcG1UajgzUktsSTlZ?=
 =?utf-8?B?QkZHZ3lPZ09oWGR2d1VmcmczMTZST0xSWEkyelZoWTJFU3RCRGFibUV1SFBP?=
 =?utf-8?B?ai9YQUlwTEpaS2JsTTQxcEdvaC9uNFRqWlpocXVOVTBCcWJFRTlObmExN0hk?=
 =?utf-8?B?MWc0NmdQNnpzTk9ib2FNYjdJaXNrbVd1RFN1cUY0d05xWGt6ZjlDd0F6cmZl?=
 =?utf-8?B?bUwzeEdyZ2FhWjk1Qm9raHE4MEZTVG5rWkN0Yk1DaHhwNHUyZmxVcmRwYVcw?=
 =?utf-8?B?SkwyYlphR0FkQWhtUGx5OTh2bVdGcnI2ajFETDYzMGtySnpPNFFiRXNWaUt5?=
 =?utf-8?B?M3JiTy93cDJqUkVJUGlYUFQyWndsOWJ5V21oa0VaNUpEU3VSL2I2SFZnc1Zl?=
 =?utf-8?B?SndHN1lvc3l5K084elI3MWpYOTFKN21vbGhyYUxvcVV1eFdBQjNqaFpsbkpU?=
 =?utf-8?B?RWg4MTF5KzZ3YjAycVhjQ2dwdGlEaWE2bVlOT2FkckVxdXNZdkc4Zkp2RERJ?=
 =?utf-8?B?T3R0SmZrV0tSUVdDa3ppWUpVWTdnQTBKdFJDd3FMTklSanlFZEpSb0RQRm50?=
 =?utf-8?B?Qm1INHllZHVVaVZRaTBGMWUzMlhrM0JCR2UyZGpHaEtNSllIVlg3ejRyNm9r?=
 =?utf-8?B?cEMzZGlXcVFSYUxSckNOV0hXT21kSzhFQzkyTjhUU3V1MmN0L3ozS2ZaVkJr?=
 =?utf-8?B?Z2xMWHlDS3oxTEU2TTEzaTVIa3JMV0tQcXNDRkJtbU1zb3ZJWlRnRGpMZDl1?=
 =?utf-8?B?ekx2ZEttN0FrYzJpSVhzRFJLdWs5ejNteEZsaGdPVWVEdktIbUxMOFhscVRa?=
 =?utf-8?B?d1ZxS3cxTi80U3dHRHVRQkRuQnhOOXFLNWdmYk93UkU2WGxxV2dmZTB1QllS?=
 =?utf-8?B?OHJ0d2l3R0hUOU1LeWhjeVBCczZTQWhaajRrMkgzdk95SFZ0SlFHSmdkR1pm?=
 =?utf-8?B?bCtZMlFNSW5INGlrS1B3bjBzcDdMUFhBZDhYVlEyN1BOL3AzZEp4Sm13MTVO?=
 =?utf-8?B?bTdPM1RpdXhIUUVZeGlsZ01vdmRlbWtmWUM5VXhPL2NJOC9hTDFVQStmS0M4?=
 =?utf-8?B?dnZKazJmVDQ4OEo2SkxzVlNrTTVsOXVBb0lmQlFvcTM5WmtTY3dmQ3JxbXdr?=
 =?utf-8?B?RjI3ZXQ3VlAvVjE4ZFJaMktleE12Qlord1F1Y2paOWJqVzhTSC9kMnEvbGZG?=
 =?utf-8?B?TEJ5bGptZ3o1dDY4NU9ZaG00L1ZBSWdvYW5mdHBYZkcyeUtiSmVtY05tbkxt?=
 =?utf-8?B?eTBSVm5rZEFRYWpDa0F0TDJYQXBSZHZkYmQ2OHRySDJhd0lJR0xFRWdpRVlw?=
 =?utf-8?Q?aWQtDaL5ELoV+X0UnHmjzlK1D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692041f1-c654-42e3-9ad6-08ddfc78887d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:37.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+cUOagK8pcEaOATz+rFZ4rIaFFMjpehSGtI4F85huF5NVzb/+ykHAB1xPHEaDq4q5Ca1zE4pbFyEqE6Ub3hQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Remove extra space in " jedec,spi-nor" to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-emmc.dtb: /soc/bus@2000000/spba-bus@2000000/spi@2008000/flash@2: failed to match any schema with compatible: [' jedec,spi-nor']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index 7ee25b14162760effd4a402470f814f021a607da..6fd68970c0b4568fe609f544e9b7f3fb2ed1cab3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -126,7 +126,7 @@ tpm_tis: tpm@1 {
 	s25fl064: flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = " jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <2>;
 		spi-max-frequency = <40000000>;
 		m25p,fast-read;

-- 
2.34.1



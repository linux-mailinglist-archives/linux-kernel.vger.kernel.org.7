Return-Path: <linux-kernel+bounces-854914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39BBDFBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 660F9506319
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0AF33CEA2;
	Wed, 15 Oct 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7hFf1gj"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197933CE90;
	Wed, 15 Oct 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546726; cv=fail; b=Fm1BjZ8l2k2NNrTrlgtQqx2TBN0TSWMBlQvTqZ++lWnOykP7Z0YWrq0HqNbFA10WT8lDL1TleicfXWBZsphl1FW38MZjDR8BpBxc2xL8i+kjD90h7w4DjPEPHZpF8eVQUCiu7BGspWSZlstz7uKCwJWbkjiuVo3e5Hvx7qoobG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546726; c=relaxed/simple;
	bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Qks2yMHHhwy6XTDg1IzRSlofzd2LSxIFlxGHMZi4WVRsD9Qk2WMC4NzdYTVCp/EGT/mED+v0UCSY4oU9KXdE3MfIVn9nZSXq3IKae5eQfU5235YYEmfubuFPpMOZTn9Tctpe0A4sXcONu1rLq74rt3n/b1jTOMH9glkpodSv2y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f7hFf1gj; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaFjYoUBa51qLwpnigvjWU+5TP6N1C1vovanCPoq1YrgE6qNQxP5rEQpEGHXjtcVgriaZgFsL8o/0Jij6iGW2pDs4A/ZCElK+8zi2nKQZYGtfVf3bp5prz2jYb9L3L1ezMoUXna1Nk77kB5gAk2U+mGRmjHp2k8lsb1fasSSj8alpjC9koFK0F6oHbSvBZj7XZ5uUKHtDni925zg+Y1pxGC50YPt751i5HonmD3V7hnz5bTr9oenI3KRvsLvgJefe8WVQEIaG+VS4OesCyFX+di/HwXedLs++5zmMxpd+v95LQFuIA4gyYeZeZYfxFJmHZ0+ke/bZqnZXxsC704iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=f46slIQvlfxsbh6v9juDTTCK8kAm8MwRrL4cbm8nlgnwnoRJE5+5GNaNftioY+Uh0BRELcJxOF9ncALcVCqnPxIT1aFZBiuwrlNoFw+Iu9W7KEz9BNU8FTrhKjRgmUPd27hBjZ8oaQdV9KWcfPtwSMpWZS4xZr1o2vjBqECPK+Zy4+jVQfuA2eo26uUuaq1ek6HaH/9Cvw6Ts239AtwaSvceqUyeGT2DGuf5weKZvOY5tVGIEyADuSU4vcTNiEK2P0lWJbb3b/jaDXGb827FoPuJam1DMeYu4Gwhsts4BLiYFim86XsgNq6mnylxKRuc5mTvNq5EyyBcRr8x1cajXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=f7hFf1gj3EBNVPbjYYcQPKCAy95rimSseWq3UwYk+lPkFYGV3iFRbP5nk/8075XTPPpHgqtXAvlb0iI0zpX/Mx9SKNBxfoXfFL7196UbE26l+celCrUxOu/iU4pDj+vhrcn9qT/qNaTXRGIPW2798zD0VfYG6oi2YoDcxOq63wbISRw/vpjCzYr6kw8sv8Y76yzWAo5/YS42CKdUHOhkstRV8VKPO7gInxEgBe+ow0b9a0S8AIYkq15ut6Bl3G2FBaD19RLWaBUp9wGfwvtONdwMDoLJHggmVQfCGEPX1xhisCSFFHGPaJMye+BP88BoepkoE59uZdONXH4P/oEAjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:35 -0400
Subject: [PATCH v2 10/11] ARM: dts: imx6ull-phytec-tauri: remove extra
 space before jedec,spi-nor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-10-41a7281b98c6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=1012;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
 b=xzeYlhAjjkQxyWh21CX5CESbRTIi6/DtzSrhTbBQEpMRArdWMt1KVib5Sy9u5Am+my+ULm95M
 KqK9cP1jBETB4sWGin0sCaOI6VI7sHVcBLWtlx5D5rA7ObJv8fy6J6s
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
X-MS-Office365-Filtering-Correlation-Id: 5576f1ec-9aa3-4b18-499a-08de0c0a3980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZJbnplNVNTUk9TLzdEVjVzWlZ5VUtqMGxaWVpVK3I3ei9ZaThlNFF6SHR4?=
 =?utf-8?B?MjhsYXJhOVdsZHhHbzBuKy9Td0thT2ltdTJRODY2bk1UdWpGMEtOLytnd1Ew?=
 =?utf-8?B?dzFNSWtyV09kUVVvcWxFc3pVNlhXNXkwRTVaSDBGU3I2QWJNcnd1QmhML0NS?=
 =?utf-8?B?Y2FJSThiYmR0R01zeHhhRDdURWVldTE4YnFwRlhSaG0zRDc0bnpZR2I4bUUw?=
 =?utf-8?B?NG5rK0oraGZkangwejYvNFRlcDczYXVLcUNVYjNOdVEzSlhaUW5xT2N6Mkhr?=
 =?utf-8?B?ZDUwQWlVaS9NTGVmTEIwTFVBaFc0alhEeDNkZlJ3WjNOajJGaGlDSzhJK212?=
 =?utf-8?B?WEpmNkRFSTdNZG0vS25pOEpkZmRoUnJna2VWUmhzQjNLb0Q2aVhBRy9pUk1M?=
 =?utf-8?B?Q0VBSDk0OXVoTlVFRDdLUDJQVDF6bUhURFlMbC9PRUlpOUdxdHY3Yld0NUFS?=
 =?utf-8?B?Wi9qTE01UGlkS0lxY3VxUkVzR2c4YzdVYm1VVGJjZzNBbVAwTmk0Q3YzSWNW?=
 =?utf-8?B?dHBUY3o2T2NkZlc2SWZwdkd4T0M3Y2VhSVJabExqallaRUY2R3V5eG5kOVRv?=
 =?utf-8?B?Q1lHcUhGamRMOUFFQlErNDZ5dHRHakZNSE8vbFJJY3VoWXRPVFozVm96MGlJ?=
 =?utf-8?B?Wkhvc1YzamZXL00xb1VRcnZlbWs1THhTdm9WZHZMM1RxVm9oTkVGeUwvR2RC?=
 =?utf-8?B?eWdaOTY2bmY2VTlxMmpXQmRqOEJ0MDU3bUlWUGJCNE1CZU1rQ2hLelZBbUhB?=
 =?utf-8?B?QVFEOWt1MlF1a1VoemdjYkYwamx3cmlMYXZaRDNCc1FCMzZIeW55T2Jvem1S?=
 =?utf-8?B?L3ZBZVlTalFPOW53VmVNYkhwWXhaSHBpR0pjeGIvR1Q3eVdhUjcycHFPWms3?=
 =?utf-8?B?RXlyRlN1UUo3OVRtWlR3ZjFBSVdtTXVkSG5VRUNZVWgrUUZNaVh0UUFkZEx4?=
 =?utf-8?B?cE9VOVI4VW12dWJIK0dwNEY4cjRTNzMrTTBsczNqc042UHIxY3ljczNGaUEy?=
 =?utf-8?B?WDBLWDhGa3RPaU5ab084RkVhSmlpNEYyZ1NZK05sU2xsUUVKYWM2YjRHQWs5?=
 =?utf-8?B?Y2hYRTEwcUZxODVOdkl0S25Ba2UyWTNwR0hzU3ArdGNvR29EbmxGSFhGOU1S?=
 =?utf-8?B?SElzcUVtODEzYUE2NXZIQ2NIY2xiaFRoZTJXTUtTQ24yaS90SGhiTlYzRmNJ?=
 =?utf-8?B?NDlIdDdMQlJXSkk3b2FwUDJZcWw2ckxvSmJmMERZbWhrYzQ3KzVHakxlUGZr?=
 =?utf-8?B?bWpTNm1GVGN1ZkRMdGNmSklyL1YzS3lhb2MzS2QzdDYvNlhTQVNYcVNMVHlz?=
 =?utf-8?B?eGErc3N4NUZWSjdwdEUvYmRQRG5XUm1tSmJvRTU4N3l5OGU0SXk0cndSdWlC?=
 =?utf-8?B?LzkrRmdEWC84cXM3ZkxObVFlZEtXdTBIcGhBb212N0Z3Q21qUUd1SWkxTENj?=
 =?utf-8?B?VHd3L1g1MzlLOGtvYnJqSTJ6Si83N3JWNjlsNE9oYlphaGJZRHZ5bHE4MFNm?=
 =?utf-8?B?MnBKZlFidStvaG1pNGNPQWgzaUlCamc1Vy84QXdWMjVMMG5hdWdEaktTclpG?=
 =?utf-8?B?b0cwTzUwd1lzR1MxQlQvVG5yZzdCYUNKTW44RWFpNFM3RjE5ZSthNVpVVjZx?=
 =?utf-8?B?MWN1OTMwV1h6OE0yVmdjSWhCUzE1RDZudDNzWU1ia3hrZWhobHRVUE5BZGJ5?=
 =?utf-8?B?UkVaNFZjMlp1RnBpRVFOUzlIT1F1UlloYXE5SitWWkVHNkh3bkFoOUk3bGxB?=
 =?utf-8?B?N0dRNW5Kbkk0UXU3djUwMVlvelNrMk9tRk9rT0lZUUdkaGs0Ry8xcjdzRUQ4?=
 =?utf-8?B?NW9NZ3hRY3oyeVRHM1VwNVN6T3oxK25ORHlQKzFWQzJjckNocjJ2NWFNbkcz?=
 =?utf-8?B?a3pNb05haW0yZHpiVE1zQ3Y2MVBDaHVialJ3L0h0ZVFyMHVlZDhLVzN5OHYz?=
 =?utf-8?B?Y2dRWmpMN1ZmeVRIenpyUW44elB6ZnRKcVZlYU9JMENaSXBYemVtd2dWOC9X?=
 =?utf-8?B?eGpQZ0VwbG0rOEZTUzdheGxIeVBoenN4c1A5MmN4L05sSzJmNHhXbEJBNXVD?=
 =?utf-8?Q?dM1Uha?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS9oU1daeWlCeVVDUGFuWlF5RFRnUWFVSlJqbXBVUml4RHgxbTJrT0twYUJo?=
 =?utf-8?B?WHlUUlpWYTVUclgvalJQaGhwUGxzbUlKU2lBSUxjTjV6UUw3dVYxK1dUZ1Np?=
 =?utf-8?B?aU9MWVpmNVhyZnZFTmNENlE4UzZNUXA3d0lRM0d6SEh6RU5rWUMxQ2VZQWNj?=
 =?utf-8?B?d2YwT3RNWXRVclk3L3dhVnJ6WDZXZHJWK1dINjRRbkRVY3B4dFByY2lZRlo3?=
 =?utf-8?B?Vmp4eWpKWE54eEh0S1paKzBzV052OHlkS3ZDTzRYVTRMU25kQmFJNktxOGN0?=
 =?utf-8?B?TVFqWEcxLzJHRi9GdnRTRnRNQi9BZDlDcEZYbksrdFhhRVgrL2ZiNS93aU8w?=
 =?utf-8?B?TmZWTGorcHFKczk3OEdPVWI5OEFLUVN0bjh1MnBWbmY2SXF4cHZZTWN2V2Vo?=
 =?utf-8?B?NCs2SmlQMzYxMGZVdWc5YWhRYkpPb1k3S1JaSno0b1JSaXBQRE1zRGNmMGtJ?=
 =?utf-8?B?MkxXeGluc21GUmtsOU5RRUxwczQ4ZDRITkszMmVqMUpNczV4MlFnRm9PUklE?=
 =?utf-8?B?MlZXRFExcGE5dTBsU0kwcEtoUmxsSDlJT3hjYlA2bDRuQlNYaEQyLzZwaXZ2?=
 =?utf-8?B?WFJNcnBMQkNIS1NOZDB3VXNrbVJBMEZ5OWU1UEV4dUpOTkpDVnZQd2lvWVFW?=
 =?utf-8?B?NFRrc0cwejV5dzhKLzB5emsrTVlLbGEyZWJnQitrNUxCb20yanV4Zlp4bFZm?=
 =?utf-8?B?cjd5dDBGQkdST21lLzRjNTZ2N2JYR3d4Q1FJeGFXVGlWREJvMU9nL3JULzla?=
 =?utf-8?B?dzFLZ2RLUnpUdXlZY3JGNGdLZ3p1MVV4R0RsaGR4czI0Vks1OXlsdFpvd0k2?=
 =?utf-8?B?aVBSbHVvV2xiYk1WL0ZRWnJDdS8rc3ordEF3ZGxWbGh0OWxteit6OUFtVUll?=
 =?utf-8?B?eDdVZE1MbzBuOStCSkJpNXlVN3REU1ZJT0luTlFUdVI4ajdGaDE1cFpFWVAz?=
 =?utf-8?B?V0tZM3BNalNYOVR2UXJUUm9HVGtjVU5CaGdvMTdVSzFPYWc2RGprdVRxVllJ?=
 =?utf-8?B?ckZ6NVk4V0NLL2plM0FwaU01cmZBTmZxL0Y4dHBoYXI0RllqUTlGd0NHa1l2?=
 =?utf-8?B?Z0xaREdvN1hPU21yd1hxeWYzN0I4TXFTVTJ6MERzVkR0S0dnTmcwQ3BYdG5K?=
 =?utf-8?B?azZyTUNmWlptQkM4a2Q0K1AwOUxyNU9DUnIzUHVsYzJjemJHYzFqV2t0TG9u?=
 =?utf-8?B?a1BTZ2kzU0xmdFFmOVdjVTJMU1h4aTlWNXNwc1ROZkZwS25vVHRhRS81Z3gw?=
 =?utf-8?B?dGdwcFM3ZncxUkZQR2hRUjlibFpZUjhKYTNhdFc0U1BXRGJzaS9LalByQWRT?=
 =?utf-8?B?dUJhRGp5T0RXWjZPbnI2WjJJYm9JZGp3SjRlSG12eUVxd1NJYlBhRDh3a2Rr?=
 =?utf-8?B?NUNRS05WcWJidkIzN1piclhTTWxvZURnRHJaRHN5cExMTSt4UXA1YXFGVTFX?=
 =?utf-8?B?aXU5Vjl3T1RvR0hFTGZadDNoWGZnb0llN09Oa015YmlIWmV5L1UyNzhkR2tt?=
 =?utf-8?B?OURaUzVLRUM2MkVDTzhEcm5BUE96TitRL3BHUkhLbWM0Y0J5bGhoL2ZmZFd3?=
 =?utf-8?B?OU1hcHV1VkIycG9XWDFaNXhpZ29XUjlvSWRWSmE3WGpXMjRQN1BwL1BtK3oz?=
 =?utf-8?B?V05NWnJYNDlCYS9mN2xGbGwxME5NVWRMTFBlcDJHaStPZXd6TFN4ckNCWjRo?=
 =?utf-8?B?bGdyWlcxU1NxSDI1Q0NkRitpNXo0SjNHK0ZySDlmWnZWbFNoS2pLYXY5Vnln?=
 =?utf-8?B?MGdOdzRacWlHejI1d1B3UStPNnh5MkVvTFAvNDJ6OXFuQUVXN3B1MTdURHdw?=
 =?utf-8?B?M0grMHpUUkVhVmtiK2ZMMUgvMElrdWZoVUpKWVl6YlFUbzdyUnQ4cWRGK1BE?=
 =?utf-8?B?QjJpU3lNYW54cWJtOFoxVFdaM3NoWnU3UzRqMHhUN1Vrc2h2WkFrUDRQdXB4?=
 =?utf-8?B?RkZ1NkY4UkRGdHFMbHpKUHA5eTlxc01vYWxiQ1pJNk5TcUViV0FHUjRxeHNs?=
 =?utf-8?B?K0tHNUd4Z25kTlNsS0hzbUR6MGc0VnQ3TzI5ZzZxOVRTa1ZkRldpNklwaTFU?=
 =?utf-8?B?eXBUM25QNmJZcE84ZzF5OWJyR0oyMExjV003b241dXdnQ1J1S3JkYkx3Sk9q?=
 =?utf-8?Q?D5voO8gyJHTA3+ZfK5kh8MYte?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5576f1ec-9aa3-4b18-499a-08de0c0a3980
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:19.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7lVoKikKb8Cr7hyyWf60JfkCXOtpx1ZY+vlJZaPQgfcZ8W2F8si0JjzIKHa1RNVREeLPgeVIehFvqYE+cLyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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



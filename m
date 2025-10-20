Return-Path: <linux-kernel+bounces-860679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F2BF0AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDA3401ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90516254876;
	Mon, 20 Oct 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hPw6C3h2"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92D25A659;
	Mon, 20 Oct 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957514; cv=fail; b=IiM/OKu1NxSs7fwWcAOHpj+L2UdJnF8XOZ9uGKbEeyg1c1Umz8tIfKSaTU+3U2TZNhV5jhWgksBqdiY2USCPScNG/y8tIaqINik33wsw6hKqg44BvM+0lG7r7aKRYudFHYPloUn67h8di6Xu9zZDci72Kg+mVs2DS7mKv2vpzEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957514; c=relaxed/simple;
	bh=euZtKZy46vO3JCBL8e0pKDaJnLOTurTJRnKsfnnHUKY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VkbIU08qUwu6KVKJreuEQSF3gcjpe+1uyzOJraqcfBnx1cOOGbty1wchOr3mLRO9yRveVBbJr8SB4tZQpHihtsRgmrD4Klk+J6aiKIdIcfNwFweVcosugKMhzOUI/PMlc97eIZk7j/1MKgwJjiTquleJLh4rZcjZuQ4wdzuy9hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hPw6C3h2; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZYfvuh/3DQ1JbhBcLdUK83XhYySlA9JBpevMCYq989dw6IgKGyaE24w7uYrNRMmKjio4/vt8E4qYCIUUOwqsYOAk21XYkvCvkvzX5f776hTG41SRsUYkVCHsuzuCx5ZeWtHLpFO4Q/VzWOILtCBjfmGteGy1XZ35Gck71vdBq3Gf6NRspb9lrTkho5r33SNboSFlCGSSxd/dFlCwE9GfkHVBJevXAwG/FaQfqmyEfAyM5CXEOvcEqchlCYdtFaeRvlla3Devp6GPIFpt2WUZ5fu/VpAu3Qd1RZ1g6Zw7us3br4kk+RQcGrhzsTEcAeK0jL+SMWD0qm6avz3WDc/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf7LAecHZsilHJJOWvKYrzCozfTHdJK4caOGZe5NliE=;
 b=oSXmQn7n631V/oz+1FML/ivHkj8749h6VnE3ww1S9XKFfeLglE19oO4Vi9+wFyXU6Lbti6V5jSrTg6sld7g+MVLo4NXp4MXWbUjBeGKjvL0pz3sf5+qKS8ZLNSGSqD6eNOTc/9++4og3BSJF28A2iY+UkCJyCKgAr6JQZogjaVyCveD6NT9uUO2f1KgMYJyTNtbneTkGXx2VSsrbIku395jGVRfaq1drjuBNT8RvGQ21hKZDg+C6jKC1a48PyTLka9fIip3THjaF3Km8toaZX8L+XXfVZOppT2kJoVMnsNtT7Vjh7x3a3XyuYK/66/ypQxFGYXZvW0jCoD0vIcbaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf7LAecHZsilHJJOWvKYrzCozfTHdJK4caOGZe5NliE=;
 b=hPw6C3h2gJ9NYP2ve8iRcPhFSIMWYHdC5dk60zSIjjLXlyS2QRky1pSMpF8pDCIWowg0jICTZL3QNE/04jl9MPW7tEQS0TM663cj/Puc5N2Z9IHH92OX4X3YWwebNoytjyQ7uW3V7Xi7JqoSsRg2bL21YUaKudvw5iXv1db/ZLqJW+f+NkaeYUjoGr3KPutGojGfYQGsWfve+7toFD/LCerLGbEKn5KGMY+6DjK2kOouXIlG3m3V/RoqJSde8Lqq1lacUSF47M9hmo7k0S9EMRQMKklY2NAgSTosc3bn07RPY/jJFmfdnbbAbnRanN2DfJNf90Atbh13LIVAblgjcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11683.eurprd04.prod.outlook.com (2603:10a6:150:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Mon, 20 Oct
 2025 10:51:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 10:51:48 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 20 Oct 2025 18:50:43 +0800
Subject: [PATCH v2 2/3] nvmem: imx-ocotp-ele: Add i.MX94 OCOTP support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx94-v1-2-0b4b58a57bf9@nxp.com>
References: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
In-Reply-To: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11683:EE_
X-MS-Office365-Filtering-Correlation-Id: de23ae47-acf8-4715-9599-08de0fc6ab16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0Z2dGVRM3JFOW5xQ1phaU1tTFdwZ2lIdFFkcW9DdWFCalRXVGJPbmFJUXhx?=
 =?utf-8?B?TmJWY3JwTXVkajVvNWN3RUQ1bm05QVFuSTI5RFVJa2ZaSWxsN1NrMGhPNEZ6?=
 =?utf-8?B?SHFaSEo4bE9uc0tSQmdwai8xVnR0eDA5bExXaHgwR25aSEVoRWhWcnVCTkcw?=
 =?utf-8?B?WW9WRjBSYWpORXFoK01wTWRSRFJYMmpJTjdhTlFrc0RvU0JSR05lYmovOWNR?=
 =?utf-8?B?OXUzU1ZxWGJ5TTNscUQ0STQzZmRvM2ptY1BXaUc2Q1B5WFJpNittODJXZW1U?=
 =?utf-8?B?ZjVVamtBbjRndko3WE9FaWs4akVucG96bWp1bDNBR0dnamlxNGFrQjF0em56?=
 =?utf-8?B?U09UOEw0ZHQxdnZsT0hJWjZhYWVDRDU4UGpFM2t3QkdJMjNqVityVGpGSDNs?=
 =?utf-8?B?UFZCNDVDQ0YzclJFUFh1SGZkYyttZzZjZ2loZEJxRG1VK01IUDArd1I0KzRO?=
 =?utf-8?B?K1NWUjd4d3grV25mamN4WDBobStzRGV2RUlPc0U2VnlJd1ZVeE44eFdQRDhk?=
 =?utf-8?B?eEZMdGFGZGJHbE03eG92V0lOVk1hdjJNclRzMGw0REZxWUZrTHI4ZDIwa05O?=
 =?utf-8?B?cFJDTlNlVGJJYndxUnhSUXJVdmo5Q0c2M2RZcGp1d0EwQzkwb0g0SkgvN1dQ?=
 =?utf-8?B?U2xiOHBndkt2YjY3QXJUQmFkWTNWODBuS2NRMUhlVDJhRmtCN05rT2s2VWpu?=
 =?utf-8?B?OHRpVnJGWDVCN0NQc01sZGdDVmFyQ01manM3T3B0S1p4dTNDWXR5UG9xaTZS?=
 =?utf-8?B?Q01VQ0Z1MEtWYTYwWVg4SDN5Y0NRVVpITEtWK2hYZXQyV3oyMklnUGlBVThF?=
 =?utf-8?B?aTAyTE5XZHhUc2RHSVh6S2N3Skp3b0U3dmJBMnZadi9KOWF5TzZEQjZ4ajUx?=
 =?utf-8?B?M004bWo2dVpzQ3d1NStyd3dQOUFsLzhpc0hKQUpFQ01BVnJmZHJaU3YxdVlN?=
 =?utf-8?B?OXlKTTE5S1N4d1dRQTdMMFFIRlZNbzlrc3BXaVkvNUNDdjVjQ20vTWtwNUdX?=
 =?utf-8?B?WWtuUURUeUptTCtXbjFQV3RYRDJxOGJkR28rbDlzVklVa2crSU9zRHF1MjVF?=
 =?utf-8?B?WXRMZ2NtbFN5WG1KWEo5SVVOTmppRWpDUnh4cENnYStxdjhoYkhPWlBiOEkv?=
 =?utf-8?B?T2xHWHJva1RCQ1F6eU8yc2g5VW9lUWZMaWVxbVB5WlJCdEpwUmdaZDlVUDBO?=
 =?utf-8?B?TXFmOXEraEwwcnFlY0lsek1mYm1FN3NkN3hidzFjVC9GTVNUSWZEK0V6S0FF?=
 =?utf-8?B?aHE2ZERaR1pzSXRkcXRwV3dEaHJPS2RoZ3E2eUV3MVRqQmdGZ2Q1SjJPYy96?=
 =?utf-8?B?dUZuS2tTYnBGa1Ntc0R2RWFUbXVJbWIvcVAwSnFYOU5XeUdEcHlKSlhJNFd2?=
 =?utf-8?B?MGEzZjg0TXlaNkR6dVFTZWZZVkRncThJN0VuZUYxaElTQnJKSW5XNmo4ZEtP?=
 =?utf-8?B?WWhIcWNBalJpMU5wWmhzNm9pVS9XcTRBMzBzMFdVWVJPVWUya29qeXVVN1hC?=
 =?utf-8?B?dkVVZlpuN3Q1UkRVaTFtbCs2UlR2ZzQ1MFowYi9oTTZSTUxGVzIwQlpEU1Rq?=
 =?utf-8?B?eDhqeXJRaHppSitEblppbDRpSy9pYUhEbi9PQk9hN0wvYzU3RDE4dHdnQzFs?=
 =?utf-8?B?NGJjR2w0b0hwOGZnZ0dFYWR2cVVpd3JjQ3JsS1JKcEhUUXlUOE1CYjlYU3VW?=
 =?utf-8?B?aWFiYzdkYzdYT0ZRdGlySHFSbGpYMjZDVXgra2x3c2swclVaSmRkKzJoVFB4?=
 =?utf-8?B?bUcvdGdjWGN0UW1DWEZWZzZTVHhmTExGUEd2ZEgxN1B0YlZpMW5EeHZzektx?=
 =?utf-8?B?bDNtMGVrbHA1d2x3WTdMZ2tHNlN1OGdhY0o1ZGJtV05ldHI2U1R1TDQ2ZUs2?=
 =?utf-8?B?RGRlQUVGN1ZSK2xzL3FJVUUvcWJ0d2xRdHF5NWVuc2hWOXd1bHJDM0U0WXRu?=
 =?utf-8?B?eWM0Vy9VWnEwajVwckQrTUFkT0dQT0x0b0JWdzJWc01kYjZORjQ0cXZFTnRa?=
 =?utf-8?B?b2ZQMFNvc2lkblFCM3RXVnZQOFdBSzZaZit0Z1ZxeGh0aFpHZmVLajhFclF4?=
 =?utf-8?Q?ogTaE4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEpzVkRZK0M0dzF5UFY1NnhnRlJ0d29xTVk1d3p2c1RWcE5SeWljUkpCeXRP?=
 =?utf-8?B?UlNzZGtjOUJYMTQzUGkweUs2bTRObXNmRkFhVEpPbEs4enc5Yi9mZzJOUjZs?=
 =?utf-8?B?cHh5WnJvcXR5clk4MXVHdlY5YlpwZGRsek5uK0J5cHB1NW41SFZKU2tDSlEr?=
 =?utf-8?B?WVBWb0ZEbUNkRlVBZ0FyZm9aRG9TbnJCQzJMYUFDSEVVa3FCc0xuc0M5eFNz?=
 =?utf-8?B?dnp5WllFYUFmY2pORUFTODUzSWc1M2pNTXJ3bmVhaXI5SzFUZHZsVmE3SUxq?=
 =?utf-8?B?NjdicEJRNmllMHowNnBaZ2ZRdlArM3JQeUtsZmxub1NDUFJIUGgzWW1PMnYy?=
 =?utf-8?B?QUQwU0lnVGw2U0YvM3d4ZTVYVTlpSG5kZlZYME0zQVpSRFgxL3pjSlgxVFdU?=
 =?utf-8?B?N0lmS2tGZ3J2SnRQdmpxSnBiUHQvUjhkVEhGMjRmNlA2Nzg4MUZReDd1RVQx?=
 =?utf-8?B?cUE1Tm01WE9udUdHNTVzdEJRaVp4UVk0ckwyRjJHSXcrM21CVjBZeE5zZW1x?=
 =?utf-8?B?R0pzMjlrMjlsK2xGN2JNd2Y1dGxJTjFDYVFPenZXZnEwTm92cFBjT0xBbkV6?=
 =?utf-8?B?Um9mRW1xUmZNd2VzNHI3b0JZRlkvc0hQcTFoTlhXZmZnbm5COVUxQ2FnYzZB?=
 =?utf-8?B?R05ib3RpdFZjVEpURVprWmpId05BeVdUOXVZOENDN0MvS055a1lPdGlDRzBC?=
 =?utf-8?B?Zm1YdzdhUTRzUFNmaUo3RFNlZUZZdmJHQXRUaDliUzIreFZicWk1cnQzc1V2?=
 =?utf-8?B?TllUaVhiNWpEb1NRZmVVUkhPNFlQWE1ueFFXRDhLKzJGVTMyYk5ZSU1aWjQ1?=
 =?utf-8?B?UkZjNWJNUjVRalNmK1Baak41RG5uUkQ1cTExTDBpTmt3dDVLc09PWStlUTVj?=
 =?utf-8?B?cWZxNktNNkxZbDUvajBic0IxTFg1bmFGSHVwNGducm1PS01WMi9qZnZnVmVl?=
 =?utf-8?B?TkQwUEw4ZzZVa0RXbk9kc3ZCZzhoSzZVUGNicUI2YzRDMzY5Wmh1QkJBV0Qr?=
 =?utf-8?B?dzBmd0RxRk11S2NOTnZRenptVkk2Z1A4Tzd0cmU3K0MvY3dMV250NUo0dEZx?=
 =?utf-8?B?NloyK29Tek5WSDMxcjNXY1VxK3FqQWZLKzFkSWkrTk5WcFVJY0d6ZDVOUUtB?=
 =?utf-8?B?NFFFNkhDMWhNTmFKYThWd0FzbkhQRWQwcDlDZkVqOG02T1EvTjIzWDNIZGhj?=
 =?utf-8?B?SlpDZVVxQWJKNThmTjNWUFp4MEtJRTZoUUhMd1M0VElTVDNCTUtkanJxNVpi?=
 =?utf-8?B?WW50ZytvU0xDUnQxTVJ5MHNCZzFRYjdDQ013TnkxK2JRVkhGTVI4K3A0YUM0?=
 =?utf-8?B?SS9qRTE5dzBwNzMya3dDYmJoQThBYTBxSkdYbm1yVlUxMjRsQ3BEU1BYN25L?=
 =?utf-8?B?d0VZM2o4cGZETTgya2pMNWdBcFZsMHJSeU5ZSFdEWkNyRU1xTzZDclhNL1pN?=
 =?utf-8?B?NkN1eXRRR1RGYnZud3ZzQStaL2NwNzNlK04vdmM0aFVCRVlvMkJPNVVISE5z?=
 =?utf-8?B?YnJQL3VVL1JsUWdqOGZTV1RiSE9KWW96cGNUU0Fuekoza2szbWwzSWN2MWpt?=
 =?utf-8?B?ekdkSU40S1JyMlAvWUovUmVEYUNkZTVUZ3Z0QjdEcDAxTGlycVgwRGo3REpm?=
 =?utf-8?B?TTI0cFZPWXlLSGJHbmtVRGNBMXFLU1Q0WFoydHZVU1djOERrK3p2bTdtaENX?=
 =?utf-8?B?RjFKeEtIOFlwT0prQlREVzcwVFRMaWF3TithMXAwVDhMNjJnbXJIZEhwNGdw?=
 =?utf-8?B?V2JqZlNHWFpGNVJpU0dCYWJtTXE1L2RTVEM2Sjdld1l0azZ4TlNuWVEva2Z4?=
 =?utf-8?B?V0JueEZLWEhKMmc1UUJtUDFiMXRTMjFHbW1mUHFRVVJFaXNSK3FMU210UStz?=
 =?utf-8?B?bnlDeVFGaFFEYTVTa3J2RmxidVF1YzBrLzd1NmVqcVB5UmhESXU1azdnSzY2?=
 =?utf-8?B?NEJ1eGIvd1hCcDJKazlpdENNYjZGTmZWWmg3M1YxakRlQzJ3VWVWeTUrak9a?=
 =?utf-8?B?bVJZQk03bVRESlh6dUkrUTJRR0pmTWNTRjB1RHB0bUlvNkRydS9HSm9DUDFo?=
 =?utf-8?B?V3FBd1N1TmZzWHp3b1Y1VlZvaTF5cEovbHJCKy9IVk5OdXVoc0d5cHF2RGM4?=
 =?utf-8?Q?ObdTru69BiPTbXggki4IYLFIQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de23ae47-acf8-4715-9599-08de0fc6ab16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:51:48.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9Oje3ehd5LE+qvX2AhPDFRv+LrSjnQ8eO7RW0O79tzHWp/1ArcvQ9VXmoiS/R46f9ZKq7ecxPlzT0XhdQEt0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11683

From: Alice Guo <alice.guo@nxp.com>

Add OCOTP device type for i.MX94, including register offset, total size,
and fuse layout. This enables NVMEM access to the eFuse of i.MX94.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 7807ec0e2d18..7cf7e809a8f5 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -186,6 +186,25 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
 	},
 };
 
+static const struct ocotp_devtype_data imx94_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 3296, /* 103 Banks */
+	.num_entry = 10,
+	.entry = {
+		{ 0, 1, FUSE_FSB | FUSE_ECC },
+		{ 7, 1, FUSE_FSB | FUSE_ECC },
+		{ 9, 3, FUSE_FSB | FUSE_ECC },
+		{ 12, 24, FUSE_FSB },
+		{ 36, 2, FUSE_FSB  | FUSE_ECC },
+		{ 38, 14, FUSE_FSB },
+		{ 59, 1, FUSE_ELE },
+		{ 525, 2, FUSE_FSB | FUSE_ECC },
+		{ 528, 7, FUSE_FSB },
+		{ 536, 280, FUSE_FSB },
+	},
+};
+
 static const struct ocotp_devtype_data imx95_ocotp_data = {
 	.reg_off = 0x8000,
 	.reg_read = imx_ocotp_reg_read,
@@ -209,6 +228,7 @@ static const struct ocotp_devtype_data imx95_ocotp_data = {
 
 static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{ .compatible = "fsl,imx94-ocotp", .data = &imx94_ocotp_data, },
 	{ .compatible = "fsl,imx95-ocotp", .data = &imx95_ocotp_data, },
 	{},
 };

-- 
2.43.0



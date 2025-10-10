Return-Path: <linux-kernel+bounces-848144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ECCBCCACA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0A1888C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA12EE262;
	Fri, 10 Oct 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCJtEwxN"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E72EFDA1;
	Fri, 10 Oct 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094076; cv=fail; b=Okv/+wM+LnD/JlLgXqp8wbDRSUOQ0sZHbAIkfykGinHhrQjK8+fngOumGi3fpITlPG7ahjREnOf0cHOb00P4ADl5kfKUZ0N1//p6+p3zMb+PKP4xejVVYycoDphz3UoVSkvXLGgGIRHHNJuHsw5cv0Khp4MTP/QR3fLry7mhDJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094076; c=relaxed/simple;
	bh=pkKSSxFGWTei+bLmiottuJYERlzSp00rNaEjiYLMi+o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KEwxauq53So0CFLLzXWcEfi4aEeovVQPwRJ60u80V1t1z1AIWOd6JNBt2zrhO5kC6MAbwGyuWIx1sdqMSXg44ukgk9eQLGwbxba30RS7QCMiuErDQjGu3xuLYVaKvBNkYiAkw79+vG6EOY2A9dvvGfZspLVV1hhqTORzqBpRC3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LCJtEwxN; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDIO9Zn2DZ+Xmx5/ssUOqHGqNo7EUqkeqwwwAfEVIwvWZeIe3cmwmBDVkoKj3gFxTt1Pwdl9So0upQyl41PlYxFvSjKRmesx+bjrchJkNYZx9Difb204xs8dWUsSH4nF3VD9IERqItUj9nSm+x0X9A7GZAbQz4cWtcvaAU38pjh/SiDjiXd3u35NGtOyZIWv3EEiA2Zs4VI6bZEBMF4Up69JfDqmFIJ03tC0pvixVtSpoguTVbVEkPuK8JnDom1jt61SBLRZmHLdsFASmzkPOeYzGkOyIV++GBckkccETFylIRTWZ6PDBJas9ley0Ulf1RB2o6ghtamTTGrIqlYf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efzoit/cX6vzWHCCKyuR/7QxlNHG0mr+AYzdFq71akQ=;
 b=SOBjD0PcSl0uA27RmGtLEqF7nB4Y1OJG0fqWNvUbsjOUybjR6OQ6G6JoPMNlI2L96sjjE9Ihg+uxtK3+5FrfvRIzx/bzu6KNSCA/ehfOVslzwqmAwy7tUYSMdryL0xgQq4Ql/JUI+iPeLQTyJJD+Tjj8PQEtSiByn6sx4EYinZGV6ZCJAMkWZnTamMCy0tNQA2wGBEnY5vX04kZj4cb3MKf9pJgp36JDidcZLNZzDCc5upJM7YMFnUHJbg+Sp2yIXfCu3cmZ2P9Yj7Fo9TL+k7IamwBEjS+PJ5LksKvRCIqcy3LJwssA3JtZLgrrnLGmIfp4oNfK5xQJjOrseCP0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efzoit/cX6vzWHCCKyuR/7QxlNHG0mr+AYzdFq71akQ=;
 b=LCJtEwxNbiVL711eA/A9XqXTkS3fSfz2DiZxvUqlTWvOSyry1uACuIW4dhm8j+OB2aYDqyddPKFExNMvMtZLtJlKXBEdIgrFXQv9CHsQf2E/7vWO+KPD3231GmsvoRk6wCI8VZ6KnZretGoq/UmreVkXjlF5VVy+jXn1sbOi7wbiD7PWfp7ZzBosHFX0KEnlbBFjA1m6eNWkUuzcM+zKtSLgsNFKNKYb7M65c6+hH9unPhJS+Uj5rFgCmiz9PSZtMqeeRBzVzRmmmJwbRMX2BcAUxBwbhM31EKs0hwEVIi6V6KTcLtWYkWEGU5Ne0Nof3hllOODeJWQn7hgwV4Kpwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:01:11 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:01:11 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 10 Oct 2025 19:01:12 +0800
Subject: [PATCH v2 3/4] phy: fsl-imx8mq-usb: support alternate reference
 clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-usb-phy-alt-clk-support-v2-3-af4b78bb4ae8@nxp.com>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760094078; l=2764;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=pkKSSxFGWTei+bLmiottuJYERlzSp00rNaEjiYLMi+o=;
 b=qO97BVEiE5BpSvLR716a+b/2VNAcG8e431dOBnKIxd9Wpj9fJqTupJGB0V6t1xWAomin/aMQC
 ONoJUC/YD6eBcK/EEe/peH7jfmRkgaWwJZTbWycP638pZiFjQSPMfWX
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 335f1031-01f3-4517-c8af-08de07ec5220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkovVHhyVG0zSGkza2RURm9KNEhMR0poa0ltcnVzY0hNNFkxUDA0b3ZSekZ1?=
 =?utf-8?B?MXVHeEFMVEJ0VmJVSEx5SW5ZSUpNVkN6SExST2RabWx1Y1g0Y29MdnJlNnJx?=
 =?utf-8?B?a0RxUHdPZGVZeFpRdjl2VFZ1Zk9LUWVVeEhWODBRcE85NG14MFpKZnV2R2pp?=
 =?utf-8?B?Q3VxNEJ1dkR2cnhWWkZ4RDJ0WjFOblE3MkJJbzY3NlYvZ3p3TkdtZGhDdjhr?=
 =?utf-8?B?NWdaaWt2YnJsSG9qdCtPZlZlbFZJQVJpc2pmNlBkWDRWemJrTHdhaDVLNm1W?=
 =?utf-8?B?UmhMaHdkVDcxbXdnK0hhRi9hcGVGSEErQ3kzcUdFKzJGY0Nuc050RXNLYy8z?=
 =?utf-8?B?bWtRNko3Vkx1Rm5CL25RYUljeG1TUEFYZ0pkYlNQV1VJQSsvaktiWVBGcmR4?=
 =?utf-8?B?TzZqTDRLY0NKRFRlSXhTL1YwY1RCNWNUdFNxU1dSMmJNVEJ6eHQzZTlTNG5m?=
 =?utf-8?B?S3AwZVFvUUxEMkZOM1dYODVqUzJDdTJjTDY2UzlrWjlwL2Z1M1F5a2pOdzRY?=
 =?utf-8?B?SFM5ZEdmWVdlaFVHWUZNdW1yY2srdlhUOFRaNFdkc3N0a3dreFoycDZ4dVhS?=
 =?utf-8?B?dEk3YlJQSHBnUmNLVkxmczUvZHZweU55Unk1NktnSUFjdjVxaUVNOHNJMWNI?=
 =?utf-8?B?VGEveWYycW8yemZGTWJBSnkzbldiSFQrbFFaTk84OHkwa08ybzFIam9aTmJZ?=
 =?utf-8?B?QWp6NUhTQkcrS2VKTWVENEQ4V2sxUG9hMEdoMXQ3UDJXcVBHQ05Sa2xLbktC?=
 =?utf-8?B?a3VyUUVBM1FGbERET0dFTSs1Qis3RHU4TmVRQThTdDZXdmlLVFpBc0MrZExm?=
 =?utf-8?B?cU9uQzFzU2l4QzBqUnFjYkhkVjE2aUZuRnZkVzVldi9nZmc1dHFmSWQ4Mmpp?=
 =?utf-8?B?RWIvMVZkNFgwWFk4YW92VEI5Wjk5STgzNEcwalVSZ0pRdmxuZzF1eHJaNVAw?=
 =?utf-8?B?TVoxTUhXMlZWZEt5RFNBbURaR2dLci81UURkbDhSNmhUOVd0V0dRektVYVdJ?=
 =?utf-8?B?KzRXMWhhUXBEN0x1K1FHbUVrS2ZLNCt5TlIzQmFQeGl5Ym0wd0N6S0ZFTnN1?=
 =?utf-8?B?N1U3czhlK3k0SWJwNDlJTlFGdnB1d2RMZEVQaHUrbUN1R2tnM3p5bW80QVAy?=
 =?utf-8?B?MTE1RnJNTjBySFdHdXFKdzdWQ255RE9BWEtpR0dQcGVidFFwamM0eWNrMzVu?=
 =?utf-8?B?VXlUb25mRlZzUlNLWGJiZFFVRzFOUityZCtQdWxkeDdoLzVRZ0RFKzRyVlRJ?=
 =?utf-8?B?UUlQZjNvSTZ3SHdPUTNIbkdhcFNwLzBzUGRzcGp3TFNiUjZobWRWbHBXSXNh?=
 =?utf-8?B?RmpaSGVhZFpLdUpVV1R1bTRydUZNODNieHQ5Mm1kVit3U2p5M0ZtYlc5ZjVj?=
 =?utf-8?B?eEJrWFVGY0N1ZWI4RjROWkJsZldndFFBa29IWG1EVEdxdmZEOGlES3VoQWlT?=
 =?utf-8?B?Nld2UDZGemhneHp3OWxSdUM0OURWQ1hxcHNEUTZpQ09rbC8wM2pwTk41V01T?=
 =?utf-8?B?UWZ5VFovOVVLeHdrbW5oYVZpTi94L3BBOG9yWEQzd3VwTEJ1dStHelRlUlg0?=
 =?utf-8?B?YndUSUNSVy94K3A3TmlhRGcyVFZmcCt4ZjUrQWhyOXdOKzM5YzkrQ0R6eWt6?=
 =?utf-8?B?bzQ2WVFqR0lFWDluak9qTXNvSmVIa2FrVFdTeUNwNmNhVzY4aXZYbWxaZkg4?=
 =?utf-8?B?UEcwQ1BaYUJxaFAyakJLZTBhS1hmR1pzUmcwNDYzV2IzS1R4YmRQdTZNQUZS?=
 =?utf-8?B?STlMN2xIVjhkOXFlZjR2bEErWnRibFZDeHRZV1FvQkJZZHBjd05oZFMvelBi?=
 =?utf-8?B?VjVRZVZ1UC90dXNPQjl6eGJ3TU5sdjR4NXZZS3ZONHBabGxneFp6OGVEdVl0?=
 =?utf-8?B?MmxrNXpqU2lyNkQrY2s3WFVaMVBzZFVQY0gvelg1VHVzYVB3QzBDckhESzlE?=
 =?utf-8?B?aUhJWmsvWHRySEtTTHh0Tkw0dzdYdWM3enFBNkJoTW9wUkVvSjRCa1lLNWpm?=
 =?utf-8?B?UjhrQk1zdFVMRWN6Y1YrQk11OTV1aStGRWhucWVkWnpYYzQ0L3dxWmh5ck1Z?=
 =?utf-8?B?b0U2K0dnN0pVMWc4V3ZoUXUySFEwK0lpakhPQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHpiUGRwY25jQjl5M2xKNTJGeXVXWnFPZ1hkZ21NSE90ZjRwUFlDdzRJOXk1?=
 =?utf-8?B?N3NkTjJsSVVzUmFXSFhpV2xvY0dSdmhGdmRidlF6SFE2b2M2dFlib216a2xZ?=
 =?utf-8?B?b3hJS0lFaDNxb1ZJWlBxNk5uQjl2ak9xb1Vtc1VwR01sMjR3cWJkU2RTdlgw?=
 =?utf-8?B?OWo1dmNaRy82bnZxNXZVa3d2OUNWS2Y0NWhLWTNZMVJVS3d0SDJYT0dFUmRD?=
 =?utf-8?B?aXJaaU9tVG44cjBIUGlwM0UrYkdITDZIWHkzVWtnVlkvWHlndy9DY2Z6TmhS?=
 =?utf-8?B?WWNLQ05PL2FEeUswSUtROWswT0NlaWw5NnBwcks2M2R1N3ErOVhYUXRKU21S?=
 =?utf-8?B?MjFTZHhUaG1vcWhpNXF2TmlsdmlXTlZyV3lWWXZXVzRiRWt6OFcvc21Ta1Fh?=
 =?utf-8?B?WTNMZmFkN01NUjBQVzhDd1JIaFljTkpNcjhablAxTVIrVnNSN2Y2aHVwWWNE?=
 =?utf-8?B?bS8vVjJVRUtnSjlHVzBxL2x1ZUpPRzZNajJieGNPS1lqT2JvM1FHVWhyYkNn?=
 =?utf-8?B?Y1BlaWM2YWlwdWp3Mjd4enVNY01qVkhZSGRUQmJOVlBONWhxVS9JTk1qVk4x?=
 =?utf-8?B?UXhBeGx1Q2RiRjhMeTRyNkZReGs0b2hnMTh1MmRFOXMvYlBlNWRyVGF6OWY4?=
 =?utf-8?B?b1FGNnh0Y0VvbDRrZzk5SFpPcUVrWWVEelh1d3hUN21vQi8xamNyMjQ5d3pS?=
 =?utf-8?B?M0FEVGJ4NUZzL0RuUDFtSEptaUQ2T0MxU2RYWDFaY2JNUXBRWm84dTNZTklL?=
 =?utf-8?B?MUZzemYwTUQrNFZCcmpOdzFETEs0U2QyS0FSWFhJWkFDS3o5RTlrOW1wMGJs?=
 =?utf-8?B?YVJsSTExUUVaUGpXaEpCVGdvUzhMRjRaOWFsRktpZWYzUVM3Vk1ZTlZwT0Zp?=
 =?utf-8?B?Z1dXTHZjNDJ4THUrdDMvZHVqbXprbXdEQWRSOXZBTmdRRnpSSmdQcDlwRDFW?=
 =?utf-8?B?TVk3UEhBS1lrY010czcrbHZObjAvbVd5SFpsUGM2TDNCQ0lTOHNwUVMxNFZ4?=
 =?utf-8?B?aEdWeWxqaWhpM0o5aWNqY2l4WndBenNWeEw1eWh1dzNoelBsbFdjTE5EVW02?=
 =?utf-8?B?RUtJSDh6b2l6QkIxYmt5MUxIcEtYVlNRN0RqTWFPSVNReUhOTTJnMHZkeU4z?=
 =?utf-8?B?UnJndE1XSDBwWGVMVzRDUnMyNU1uRUp3cHRVT0NiUGZybU1FNzBXTXEyTExh?=
 =?utf-8?B?SE5nUmk1K1NpZWZ2aFBTYnFFTHlKRFI1OHplNys2NFdmRWdnejlsVXBsT0tB?=
 =?utf-8?B?c3l2SGNCcW1hTURrK21FTDc0SVlaZzVDY28zM01mbnVpaXF4QlVpdDVHYzND?=
 =?utf-8?B?UHpYaENUaU9wSU1BRmNFVHdXdEQ5V1VKaVN6cFVIb1dYTW1JVWN0cmtBMk0r?=
 =?utf-8?B?bEhzdzl1NDdSMm5DQ2NRcVVUZytrMmJQWXEyeXFNemNWSjVXVXJmSXFrdmZK?=
 =?utf-8?B?QWVDMTFtb2o2NkZBNFk2K0R0S3BWQ2kzUHpBeWw2Yjk4WnhnSFRxMlE5eTJ0?=
 =?utf-8?B?K1NiUWc0Vm82N2VyMURpelN6SWVKUFJMMmRpYTMrTW5CS0xTYUgrcGRjMUtS?=
 =?utf-8?B?MDAreVV4NXNlMGh4OFdiVlBMZEhvMVVwZDNwMm16Qm5lYzcyeWFIYmkvV1Ra?=
 =?utf-8?B?eTgvTkp4TGdjME5sUmF2Mlo2Qy9rSUhCVXBFQmpQazRDZ1dOalF0VXNHYkVs?=
 =?utf-8?B?cFRRaW5jalZ4bXg2M05iWUFrMCtnMkhIcjNsS1FiWEZWZWdiUjBpeDJ3TUlt?=
 =?utf-8?B?ZFZ1RjlPOHhncCtBTHFsU3JXT2gxV1FHR1RjYjF6SEZiZ2VnaGltZUJLODdk?=
 =?utf-8?B?aUJJbWF6dy9tdHJnVmNaSkx6V3VHTEVhczdFc3NyZlA4UWczL09KRFBvelBY?=
 =?utf-8?B?dThDWTIxVUdCR0xCSi9aTEdZVmtDOHZOd2RMNGlzVXhqMWU2dDdOYzBzTW9x?=
 =?utf-8?B?c0x6N3IvMzh3ejN4MG5TOEZPYThJQkVOd3lyREZ4MnNKdVNrTnlYczNaTFZi?=
 =?utf-8?B?aERlY01NVElBdXVFb3RjOUx6NHYyZzNiK0RRS2w5ODV4ZVZnUzlIbElzS3py?=
 =?utf-8?B?SitrZEp3ZTJwNWI3SmxQQ0xJUUpma1BndnVkaDBGYm12VVEzckR0ZXhRRlVp?=
 =?utf-8?Q?XiHr1rCkcxiK15BpQsGI59qfd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335f1031-01f3-4517-c8af-08de07ec5220
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:01:11.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbFrYp/Q023VULAWBXguEV9K+wgvg3I10jPE9EGIzIxjGV21Fgz8cjXakv7PS/FBNHzxvgbfiAp8HR4TwTbLzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

This phy supports both 24MHz and 100MHz clock inputs. By default it's
using XTAL 24MHz and the 100MHz clock is a alternate reference clock.
Add supports to use alternate reference clock in case 24MHz clock
can't work well.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb tag
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b94f242420fc733cd75abef8ba1cd4f59ac18eb5..ad8a55012e42f2c15496955d00c6d5fd85c5beb2 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -16,6 +16,7 @@
 #define PHY_CTRL0_REF_SSP_EN		BIT(2)
 #define PHY_CTRL0_FSEL_MASK		GENMASK(10, 5)
 #define PHY_CTRL0_FSEL_24M		0x2a
+#define PHY_CTRL0_FSEL_100M		0x27
 
 #define PHY_CTRL1			0x4
 #define PHY_CTRL1_RESET			BIT(0)
@@ -108,6 +109,7 @@ struct tca_blk {
 struct imx8mq_usb_phy {
 	struct phy *phy;
 	struct clk *clk;
+	struct clk *alt_clk;
 	void __iomem *base;
 	struct regulator *vbus;
 	struct tca_blk *tca;
@@ -582,7 +584,8 @@ static int imx8mp_usb_phy_init(struct phy *phy)
 	/* USB3.0 PHY signal fsel for 24M ref */
 	value = readl(imx_phy->base + PHY_CTRL0);
 	value &= ~PHY_CTRL0_FSEL_MASK;
-	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, PHY_CTRL0_FSEL_24M);
+	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, imx_phy->alt_clk ?
+			    PHY_CTRL0_FSEL_100M : PHY_CTRL0_FSEL_24M);
 	writel(value, imx_phy->base + PHY_CTRL0);
 
 	/* Disable alt_clk_en and use internal MPLL clocks */
@@ -626,13 +629,24 @@ static int imx8mq_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	return clk_prepare_enable(imx_phy->clk);
+	ret = clk_prepare_enable(imx_phy->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(imx_phy->alt_clk);
+	if (ret) {
+		clk_disable_unprepare(imx_phy->clk);
+		return ret;
+	}
+
+	return ret;
 }
 
 static int imx8mq_phy_power_off(struct phy *phy)
 {
 	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
 
+	clk_disable_unprepare(imx_phy->alt_clk);
 	clk_disable_unprepare(imx_phy->clk);
 	regulator_disable(imx_phy->vbus);
 
@@ -681,6 +695,11 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx_phy->clk);
 	}
 
+	imx_phy->alt_clk = devm_clk_get_optional(dev, "alt");
+	if (IS_ERR(imx_phy->alt_clk))
+		return dev_err_probe(dev, PTR_ERR(imx_phy->alt_clk),
+				    "Failed to get alt clk\n");
+
 	imx_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx_phy->base))
 		return PTR_ERR(imx_phy->base);

-- 
2.34.1



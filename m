Return-Path: <linux-kernel+bounces-816368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF05B572EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C6517DCB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784042EF660;
	Mon, 15 Sep 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nGyShJsS"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0342EFD98;
	Mon, 15 Sep 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925032; cv=fail; b=H3G/rWHWD1m1ZbJNmcnIj/PEcpYL+ezY5tmI3/V4vAQmu3OI/pZy/lD0+Ng2cYUsmzQQnf9EZdm9TBH4KWB48YSnOPPNQG7hY961b63s+Eaby3WPUh7gtXP5dMA4xFbUU2k7lIrUenhHC3Ip+sRPT9qksQu77LXPVAqRCj7dCmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925032; c=relaxed/simple;
	bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hBhkG9WNbmLOPgxSQpL0Hm5MAzLzkdRW3r/L8cHVTYpd5TgzEHMd47sYEYUUspp420SsALMOlCId0FRntKAHmv++JKwoopYvQrJKtIMJ81DgY2QoO5uQgUb4clc/a0aTwILghGTAmF9Amy/+6PIvIKvJL7YT0YfM4LSuK4nPiTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nGyShJsS; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAb2ZD/1VTWh1qp/XvScHPWkEwxhkzIngejhrTw1rnVleFLgXAZT2vwJtIAwCeVwZTvSZfi8OdXraCBCZYwmFxTfKp2PeZeMOwqyW3RrQeZr4uYQGmAGGHenOfK6Mo9v1Amnwe9v5ctCYGYXmlhfQWYzK/aSb+w3uQf2GULmGPtWepxFW9VmAjmNuDGKuTLKTLJGa7NTFzoBDVKLVC/95BWfjrqN2MBbRIPrVexCuNKkpyZD5A91rmIusS/XmtjGzUD+L4/9vlyKMhSG/ZH1OQtC/yBQ/xDpAPE9UMcKvgAQaudbZ+5qPmGBb2mIOXnPSw+20yoqmqVlPTBMWW4skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=qhAnea4JcYrvufF77oqwZMEJGjUnAst7YOUdHWj/WUZhxafhoOta7VQAHithGrkQjf39hN6Om6ef6C28ENf/DLssIk8ySAt2J5bIFKlANBlBoB5E3ZrVCAPt7tcJayAquqKaJSmy/MAZtaSUyizWgRgba/vwRbWzWgzTsRnkhzuJD/mTvZma/DEZcI6oofAnUqtXEnrsTsqYEyFNjnwDt65KAiq03HjtzJe3hq/YHtgUwi+SJUvZhkW03ta7OTJDUcTmU7W7rUzYYLNvXAlNtSCgipBd1/DZoc5Lx7jK4/sn+WbY8EsDq3OyTe6Kyz7EKoTKzKVZem/Eg57FX+JNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=nGyShJsSr55lPxr7IQ68ZdsgbpCAkMSfy9Szi/DLw3KLeerGR0vydesjvSIZsJ9yxykPGHbAFMubIpDl6myW4eFLXRhK+Zh8FMnoJJI0Q37aAbleERSCw+r+WNaNLIEeSf4V3LnKfxhDAB9LsrM6GsrajhskQQTXmJn3BwqZc9hsiPoiNDOQyx08bCO9nxbi0nj3OZznfYAweGX81QyHCGd88oxw6Mz/ZaWfPwUNDD0eIeY5A5yKQrgz+wAVlm9Adwd5keXZyzEUGN5sXltXcyRsmWJIBkV1nePh5mGQy64vbJDbbyx62+TT7GmFz1Winb5LjjOAU2BN/bt7qJQleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9913.eurprd04.prod.outlook.com (2603:10a6:10:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:30:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:25 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 15 Sep 2025 16:29:37 +0800
Subject: [PATCH v4 3/5] clk: conf: Support assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-clk-ssc-version1-v4-3-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=2996;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
 b=fn/voTLSGoiV1eXFlWqvfbtIQkdy31mg1oF9IP7p2CX2N8IaK70+ShoqNIds25rQvKtfLrix9
 J5BC6gEBBc4BC2yKdYeurY25fdtD6vACm8KWd63e/wubQipOt1b7upa
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9913:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b951bbe-5807-48d5-8dfb-08ddf4321eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c05Jamw4YjBTUWRCN3UzdHgzWDhVRjExK2tsNjYyNzJRRXJieHE0MkFjb3gy?=
 =?utf-8?B?eVlGMWpUWko4ZEoxanFKRWRxRkhDdE5MbDV2NTJySVVWbzZjRWJYZjlPTDMz?=
 =?utf-8?B?OHBIU3pKNFM3amJZK25PUEo0eTcvcytUYmd1NkpvL0NkaXdzRVFHM3ZzbGN3?=
 =?utf-8?B?dVJNalpMRDdmbnhobEY2aTc4MHBoQjF1ZmVNSTlTUC9pRGU2a2VkYzJTWVJh?=
 =?utf-8?B?NktQVnRhWFd5S2tzbkxrbGdVZHhRM0VobEVBem9TNFMrQ2d5UlAzYzRjTjZT?=
 =?utf-8?B?N3Q3WDZRekY1dGlqSVVHSG1RTGpQeThmMll5bEVGQjZybUhTSkZmbXlINFpC?=
 =?utf-8?B?RTV6OTNEU1VmZWFyUGtTZGtCNjU2dzhrenAyVGZMbDBvSDZvVy9zdDRnR1Jj?=
 =?utf-8?B?S1orT0g3SGx4SXdIU1MvR3VtSzJTZlVNMlFtWFhPdzdSay9OejVGWWtRSkdU?=
 =?utf-8?B?TVB3TXJRVUpacUIyV21WN3FyR3VITDNTVnJKaTRVSEJUaWU2RTNHSTNZRzFQ?=
 =?utf-8?B?ZWs2VThkYm9RKzlKNzlkSVRqSFdpSlNMUFlUVnFFRThWLzdMRE9FU3U3dDZt?=
 =?utf-8?B?NUdLMGt1anFoeXpXbmh1U2pKWTdHR3RjaHhQWGFUZTYvSkR1REE0Tkl2cnNo?=
 =?utf-8?B?a3JCdnN6WVNzeCtBdUszZmI4Y09BMXZoSVpoc1hueE5qeW5Za04zQlozZ2ox?=
 =?utf-8?B?M2Zad1BXNWVka2twWTlhVUl0eFRMZmtscUluUEtLUnRyUEVIYmd6T1M0MDkv?=
 =?utf-8?B?YlFqT0NwQiswVFRNQVRXTzRpV2ZQbVhRVGo2OGtmdnF3bWtCU3c5SDVUcFJS?=
 =?utf-8?B?SFhYeDVqUytwNDhQMEtoZ2Z1TCtFdVMxQnFlTUJEQTQreTJQTS8xYUJHVFl5?=
 =?utf-8?B?ZEJOYmNDNGp4cTZoYXdreXNlVnE1cXQwRGJ4T0x2SXVRdVZDQWVQeGg5a25u?=
 =?utf-8?B?TWltMkpPR1NRRlhRMnNsd1IrbUpWSGtJSkl6SlIzNlVZVVVKKzBCbEYvcTFI?=
 =?utf-8?B?QWhZck11eHV2a0plbWZ6bWluTGNicldtb1BLVUhKUmUvbnQ4WTR2NXlQWmNU?=
 =?utf-8?B?SGpJelgrcEZBT1lCNmdZR3ZQWVZtVWdwL3E4UXJUZ1R2NlBrQ0pPdXlIMkll?=
 =?utf-8?B?RG9USDFJcnhnSVBoZHFBTmJMQzlDVTlSMHNubHNFbm5pRjdTcVpRbzVxZFJa?=
 =?utf-8?B?WGgxSk9lSUlEMVhkb01YWCtPM0FCemtGMnhsTGFVMWpYblBFU3M2ekN2dDds?=
 =?utf-8?B?MzJxSCttSDZ5NEt3bE9lczlGUTNhS2RJMXFlUDVEZ3pZNi9hQXhSdUFjRGs4?=
 =?utf-8?B?bGMzR05xczFrcG1kcVUwclp6UHR1UmZDVElVclliTXVFYXpsRk1pTFJDOHIv?=
 =?utf-8?B?VzNETFNrZlBvdlB3eEJWTzdYVm95QzRxbHZOWnRwMHNWd3pTbzcrenZMbkQz?=
 =?utf-8?B?Y3h6b1pKeG1oUFRiblp5OTdBK3c3Sy9JWWxTQlg2bkxjcU1DZ1FEMXE3NFRH?=
 =?utf-8?B?ay9aUklNWU54SFFNdjV0amNzUENmbHYxUjcydzYvMm52NGliai9NRWxTMGFh?=
 =?utf-8?B?TVFDcHN2cm5pTmMxV3VXUkc1L2xvMTJGOHhJZVJuNlhWaHpxSzF0ZCtLOHlU?=
 =?utf-8?B?WWRCM0VLcU05TlVudytFOG9wei9hSUxNaTdnaElnV3VqaWpaVTIxazBFTUNZ?=
 =?utf-8?B?RVA5cjhYcDhFTFVKY3dUcHJDRktKb3JPUjdxNzBhUHowNFJobDlqYXRLTzNI?=
 =?utf-8?B?K05mUHdGNWIrZWdEWU1ubnlxdExsZjJBSHNBZ1FleU5BblFaOTRTQmN0ZW05?=
 =?utf-8?B?QjRZNmNrb05FRDI2TE5RcUdlTkhKUXoxUk9MZm5MbDRwRFlxSHpYVGNudnA5?=
 =?utf-8?B?cUI4cEFpY3NhN1lJaStEd2lkbVQ0Nm0ycDljZVl1UHYwWDRlakt4Ynd1STYz?=
 =?utf-8?B?L0R1dUxqelNFM24rMUxQNi94NWVxanpJOWpzSHRjMmlSa1NLQjIweDFxNXJ2?=
 =?utf-8?B?dkZVMTcwdzRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFBnb1hyY1M3QnNHOXViWXB5SGNTTktkbnNvR01VVnd4dm9jU2pCZ2Eyc0tB?=
 =?utf-8?B?TDBDUDZGY2NubVJEMUo0WG90cEFBWFpzNDhJb2orcFNtdVZ3UzdhNmc3QWdH?=
 =?utf-8?B?MThXVzFqWEl0WG1sUkFBdjF1SU1VWUJjZlFESVZOZHNiTy9HaGhGNTZvQkFl?=
 =?utf-8?B?T083Yi9MbS9YNmtKeE1xMEZNMUx6dUtRbHQ3aitIWE5WK2g5Y0FVeTNJNmZu?=
 =?utf-8?B?RGRmdjk4TDFmSHNueVczTFJxT3pwdTg2Tk5RbU5RNFBWTXA5QjVPSkhKYTFK?=
 =?utf-8?B?OHBvNGZaVmlaMFJuTmlXWHp1Zzg0M1pUL2hUYThrZlNsZXZSMzRPU2hORHd2?=
 =?utf-8?B?SVJpMWZPV1R2ek1KdkZYaWRkbHdzZW9wUVVqNFkyOXN4aEQvZ0dycE9yaGFj?=
 =?utf-8?B?by8wUy9maUJsZWVzaStuY3VTVU4rL1JCcGFkQWpXczZQcHVKbUFDclQrZm1u?=
 =?utf-8?B?a0tmVmVQbG8rSEtOUFNGQUpzaEJhcnFHNyswWGwwKzF6YWt4eHowQS9uZ1lr?=
 =?utf-8?B?aGljdUoweEwwY094ZXFYOHBmMUlXVGZodTZtS0pNZWgyeUdGYUhXZkhBbXFI?=
 =?utf-8?B?ejExWDRXUGdWOVo4N3B4VmdzYlppQU8rWE1IRHJFTXN0WEpDVXM3MmxFbTZo?=
 =?utf-8?B?aHBBYzliUW1tbzcvcTI1akRjOENtVjcwTFZ6WjdXMjBwYU43ZS9uRUVUZHF2?=
 =?utf-8?B?N3F5cTBSUGVDR2VTZkxubWRpUW9SejdGRWVyYi9MWEJLeWxpcGx1SlNURncv?=
 =?utf-8?B?WjM2anhHL2R0TU81Y2JuWmJNNzlESUh4WkhiN0htS01DMzBwcEc2Qml3bE56?=
 =?utf-8?B?UVdvUXNncG5kR2lMRElWQ0hQanozZFRaZXE3UTd3ZU1RUXZVbWs4eWg0cGRX?=
 =?utf-8?B?TXErU0E3WXVmd3RNYzczYm0wQVdPZUJhZFdmUnNRNlNWZXgycW91dGtiTW5T?=
 =?utf-8?B?b1dGR2VRaUFrbFhkR1h3ZjhDN3BYYVpwaDdPck1pWDFMb3FGMTZRUGtSeHJM?=
 =?utf-8?B?blJPeUdrd2VGdmlNMHVVMlRTTWtJVCt2TlFQRGovOTE3RndRc1g2aEo0bHJa?=
 =?utf-8?B?MTlQalZGSXRiN0M4amN0WHpJR0xZRkQrb0FpclF6eGNFMWRleVBwcDd4Z3F1?=
 =?utf-8?B?UCsweWVjVFFFWlpKdkxlVEw3MXZJamRGeWFJaWFKc2Y4a2I5d1lxNGZpc2ox?=
 =?utf-8?B?OFNaVEJlNDdhcjd5SHJhVEc3YlZJSWs1aVMyTHNyTHZqekFzN0plcDJLS3I5?=
 =?utf-8?B?bzl3T1lhelVVUk9YN01HQmh0dThVeUdFeTVzY1NlNUcxdEVoQit6d0ZpNHB4?=
 =?utf-8?B?N1gyVVYxR0xJZGZUbjNkKy81RitVUnc0MjZ4d3dBbERXMmVFV1dTTS90WkVR?=
 =?utf-8?B?THhiUGZFcjFsY3hVWlFZL05nSitlemhaME1KcXE4NjJNekM2dmZUZGY1UlQ0?=
 =?utf-8?B?MEp5MzJKVmlWNk9ZR3o2aWFmaVZOQVRXVVA2RUEydUpLK1VNMlJEQW1WNnAz?=
 =?utf-8?B?ekthbUdtOUFuWmQyemtFWnBOczEydFZ4OFE2QkYwWDRPSTBJNUpzVG8yamhX?=
 =?utf-8?B?N0JvY1VLcmovcXhmQksxOCszdE9aY3l4RDBZb0RmbjBzaGVOVXIrT0p4cDhH?=
 =?utf-8?B?c3daUC84a2VpOXFrZFpsdGtaZ3g4bU85dDR6MEVoWDFndTlCWlp5ZFZNS1Jl?=
 =?utf-8?B?Ky9hdEREZzIvRHdOZjV4dnpxVCtKMkp6c3h5Q3Vtb2wrSWFWN3ZPQkE3OHBu?=
 =?utf-8?B?K3pydjU4bk5JSk5zM1QyTEYvazVtcWlIN2pmZ2E4a2NJbkNpNkkxRDIxNlZ1?=
 =?utf-8?B?MWRxeHQwNU5JYjVvb1V6OHNqUmdiWEo5azJCb0h4bUkrK1FRcWxLYVluaVpW?=
 =?utf-8?B?dG4xVm50a0FvbzdpS0YxMzhHK3RJR2dJdnFlbUFzQXlLTlFRMHp2clZJRDh3?=
 =?utf-8?B?OUorb1hKZDNNd2dsc3FsVlNjVUp5YkNpVWpyRWdkRHErdzV4SEgwVXdCclh6?=
 =?utf-8?B?SElRdUFYUXE5RmU4L1A3Q0IyamQrOFVsVkRlRHpDemQ1MXZZbnI2Y1NmOTA0?=
 =?utf-8?B?eXdhNnVqQ0RHZzVZVjR6a0MwRm1EMllHUHVjRUEzMnBURlVrM0h5Rnl2VUNQ?=
 =?utf-8?Q?/Wl6y8GDqzYOA/66xDfIFe+kD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b951bbe-5807-48d5-8dfb-08ddf4321eb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:25.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpUEx3uhR69mIssVELLgbdK6FFHLj+3Bfb9fEK0JE5IJ7n6c5BP2jW+W13HFhSaqHZkalljT80SYxQBJGHMMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9913

Parse the Spread Spectrum Configuration(SSC) from device tree and configure
them before using the clock.

Each SSC is three u32 elements which means '<modfreq spreaddepth
modmethod>', so assigned-clock-sscs is an array of multiple three u32
elements.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
+{
+	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
+	u32 elem_size = sizeof(struct clk_spread_spectrum);
+	struct of_phandle_args clkspec;
+	int rc, count, index;
+	struct clk *clk;
+
+	/* modfreq, spreadPercent, modmethod */
+	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
+	if (count <= 0)
+		return 0;
+
+	sscs = kcalloc(count, elem_size, GFP_KERNEL);
+	if (!sscs)
+		return -ENOMEM;
+
+	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
+					count * 3);
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		struct clk_spread_spectrum *conf = &sscs[index];
+		struct clk_hw *hw;
+
+		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
+			continue;
+
+		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
+						index, &clkspec);
+		if (rc < 0) {
+			/* skip empty (null) phandles */
+			if (rc == -ENOENT)
+				continue;
+			else
+				return rc;
+		}
+
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
+			return 0;
+		}
+
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				pr_warn("clk: couldn't get clock %d for %pOF\n",
+					index, node);
+			return PTR_ERR(clk);
+		}
+
+		hw = __clk_get_hw(clk);
+		rc = clk_hw_set_spread_spectrum(hw, conf);
+		if (rc < 0)
+			pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
+			       __clk_get_name(clk), conf->modfreq_hz, conf->spread_bp,
+			       conf->method, rc);
+		clk_put(clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -174,6 +239,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	rc = __set_clk_spread_spectrum(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;

-- 
2.37.1



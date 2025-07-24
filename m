Return-Path: <linux-kernel+bounces-743448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4BB0FECF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D471898110
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696A1A5B84;
	Thu, 24 Jul 2025 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="AdhPaWfc"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9413A41F;
	Thu, 24 Jul 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324508; cv=fail; b=as3dQeYhietXLKMOmv71fCH1uuCKG4k2TiAHMOXUW6nuGmM6Fudinln6MtVz1RlHfn0rf060v/l3qe+FmeP7gzI46UpqXCJqX4KqltZuD8H+UcrFWOknKAdEB+7JZh3UYFhOK1/0+yzRDpAdtlT2oGnf85zfY4P5ZD+iyQ/DCRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324508; c=relaxed/simple;
	bh=zExS8c+tuLRVxRZjAFU7I4D+ZKPXgTgyDCUyPn+QcGA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VSWxqvMw+ClPofx5qKLbIQpliK+w7/fMA5R+3I/lU9nHP3lH4ZVxNt5B+Dy2MbjnEcpq5DP9ExgM5ZkGwiVI0UwJBKqi6AQDRBq2yDvddNs3KcFJotGHQdjx+4WriXt2VMYYBhKqxzoOOJ+yhfXQjfqTeNZysU22p3AHZF4/n+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=AdhPaWfc; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/6FPnKM6wf/FxZGFx54UpWx1IyLUGjE72XOAowKm4pYVG7ioruZ+FvBNRD01Y00YEpkX5lcIZCEFQPAgcbkpgVrvBhGZ3mkrgBI+QfBAkBcVoIAWr5Ri94p/tdYG2KdGu0Q7Y29AzWfAvCQ1ON2MD604cozqqI/ryxz90ZuoDHApb0DVpRts8msYqnFSlgVVJSTzexQTXHFFKnoL8nAfxC8f3kJ8UeNK1007Ua65T7/iZd3WzTYhPQq+CTCGxVKVLBFRuc45VcYAuPShvV+h5s2Sxegj7RBUb2PZDXMvo/opn2q+UI3lIEXhp4W3wHru+hwT1kAXTF3kUPLmr0hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zhKceNjp/l9N0hLndB0M22NIDnQ2xzw2clZOxAh/uk=;
 b=HuA0xeowHsgbLfYi+WGsB8+R3PbMFx3aL8BYVRcQJ8b/kkv67+gxaQWUoJ9GWB9XzunlGHLWf5JTFGwmXtE6lfcWPPjjduJKBnsDOfqpuXYMAwxq2R6g9I9k/R4ouEJL1Y5+CTLwcWEPfOw0aPO+J7KF/XhTCjds98MZkpqIMsOAeb1bDwigoKYb27NZc/qcqjOjCdZo7srKcX2yhUe7dxOR7EMyhr7q4jiz8LhLnMtpZOwfC1BH2q2DvZdfGz4J5SNaKKZQzMidb4ZT8lVJouF3LwSbgu0pfRjllmx4Oldli0NzyKoKVI8wyrn79NL3S6I0XhEjneDu1fTU+0Kihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zhKceNjp/l9N0hLndB0M22NIDnQ2xzw2clZOxAh/uk=;
 b=AdhPaWfcEfV2NUxf2q/D9IH07G/ZeCSxY/R0JcFkgcbEYxPRbtGwGrfyHGlcELm4EugayOClZFXbJnRSCAZuXSNu3Dg7PqbB588aWeDzYas+q5ctmGx+HLJQLMwxiv4pwbwSeCzBoOlV3WLr+DEXNWESEe6HFZZ5MUwemRnVgzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
 by TYUPR03MB7032.apcprd03.prod.outlook.com (2603:1096:400:35e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 02:34:59 +0000
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94]) by KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 02:34:59 +0000
From: Richard Hu <richard.hu@technexion.com>
Subject: [PATCH v4 0/2] Add TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
 carrier board support
Date: Thu, 24 Jul 2025 10:34:04 +0800
Message-Id: <20250724-add-technexion-edm-g-imx8m-plus-som-v4-0-d1c88155d6f4@technexion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJybgWgC/43NTQ6CMBAF4KuYrh1TWrDUlfcwLvozQBMLhGKDI
 dzdQmJYuGH5JvO+N5OAg8NAbqeZDBhdcF2bQn4+EdOotkZwNmXCKCvoleagrIURTdPilF4BrYc
 anJ9KD/3rHSB0HoRUtqKaS4GaJKkfsHLTtvJ4pty4MHbDZxuNbL3+/OKQHxlQsLpQQmvkpszve
 +NiOk/Wkch3WFB5DOYJFiyzmSwNMqr/4GVZvuhyXuQ0AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753324497; l=2955;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=zExS8c+tuLRVxRZjAFU7I4D+ZKPXgTgyDCUyPn+QcGA=;
 b=tCHpHucngS5VDRgk9x/o0G8Cqz5X6434H29y57uE7g+JHDSr5Xy2/eoe57NOu+uqR+pw49l81
 uK4bSmM2NFdBIL0l1TU0ldJZ21NNEDtevpppEMFRxXhco8SrzSDwg5t
X-Developer-Key: i=richard.hu@technexion.com; a=ed25519;
 pk=MKoW0/U0r4MjJdRNaq37Tb25KE1fzJUdMN0pa8XBJSA=
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To KL1PR03MB7454.apcprd03.prod.outlook.com
 (2603:1096:820:ed::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7454:EE_|TYUPR03MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a21f54-6ac0-4754-29c5-08ddca5aaf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2Q0VW1jQlVtR2Y1OUE0Sko0YTJlMHRjU2VGRlhCZzVObXlmY0dnWVhZUitK?=
 =?utf-8?B?ZVdqSk04U1FwTExqWk1ncXlhVFZnR01NR0lmWC9Fa2xnZCtmMWcxTVVDYkhI?=
 =?utf-8?B?WVJDQU11RzJaWlNseHhBSjAzaUpQQno1aU5oVW1XaERNZHFSWm5PNndBVGll?=
 =?utf-8?B?dFhLZnNJWk9FcGtFREpEUWdwdzFyL1NHTWJDemMvUWs4N0l5bE1wTzhTQjJk?=
 =?utf-8?B?ck9VR0VpcmdyQjIySVc2UG9QZDR5TUR1cG5WU3RxdXJrUFViQ3M3UURNT1NW?=
 =?utf-8?B?SjIzdUZ6RXE3b3FQUnpXZkt6dmRFMWRkTnJyYXNodm5EQXEzNTl2ZkdlQ3Nj?=
 =?utf-8?B?OWtRS2pTRVB3K0dqMDJIQmV3QWx2TitYbml3SVY0Y3FVeFl5Rm01NGd0cjd4?=
 =?utf-8?B?QXFsRytqT3pwL3lCVUs4UHozYnd1cW9GS2krbnZNWjZBd0RndEllck41d08r?=
 =?utf-8?B?enY2WUNvejBpazNMVy9sNFo4R2J3VUpRNUl4M3UvY1A4emlFdlE4bWVZaElI?=
 =?utf-8?B?YTdwa2poQjdNZEpxTThleHY5YjdwdG93MUVhS1hPM2VOK25DbWtuY0lzaDJC?=
 =?utf-8?B?NnYwQmhZVzc5NWgzUnowRHZ5N08xd1loWHNMdit6aFVKSCsvZkxsRVIzSThX?=
 =?utf-8?B?TzJRd1JyYnNLQ3ZweWZYaytIV1F1b25aK05LYlVHVHR2S0w3V2NTZndQRFFj?=
 =?utf-8?B?K3lGTEQ3R29JV3EzdkZ0M3U0b1FwbFdEeWtwZ2UrWlBIQlhRanRxUmJna2Nk?=
 =?utf-8?B?NTJlZHU0c1pkVkQwdjNRWkJFSGlQSmMzOEgwdFpGMzJuaUtZc2hKWGFjVENi?=
 =?utf-8?B?MXIzclB1NXNValR3bW1NRHNZM2tVRWZBc3lGbkNCMVlmbkxhdVR3YVlYc2VC?=
 =?utf-8?B?Ym9ZOEF4MkdNcFN0UmhpM0tGTmhZZzJZM0RNT3NmS2Z1cytiaGdpa1FzRTJw?=
 =?utf-8?B?VUMzN0haU3crNTlPd24rMTUxRVF3dnZtbGJnelQ0QXIyVzBZNUozcExYZWJH?=
 =?utf-8?B?Wis3eVpNZzBLWWdsM3h5bWhnb1llcDRHM0JJa2FpSU5kMGRxdlp3L0NVWGN0?=
 =?utf-8?B?dUdGOStNSGowa0Q5aUwybzU5Zi9lWEFRR1l2VEZEMHBjMGJjNkw0NTRRSzhN?=
 =?utf-8?B?M0F0NUhPQUxndlE2azQ3aG5paHpkMEhRbFlCV0NLQUFrd1pjOElsaVJhanhW?=
 =?utf-8?B?ZWhvWVl2Z1pwdTJjWTAzcldpV2FwRUY3RWNEUGhKcEdWTzdlN2oyUFU1RWFa?=
 =?utf-8?B?bjhFaGFXNU4yZkVkdW5WaEVYYjNDZitqOUREdzN0ZjlZemhIVktuWnRodStI?=
 =?utf-8?B?amJ4bUZwQ2pDZ1F1LzdZamxWZFMzMUhqRHZROFFTRzlKQnZ5Wnh4VHVnUzc1?=
 =?utf-8?B?ZHNnOTBnUWJVbWpINkw4RWpzS2ZLMnU0VG9FTnh2cDI2MzlHeWwzTWtvNXF2?=
 =?utf-8?B?ZzNnZndqS3lTb1A0T2Qrc1BqbHRoS2l1WFJ6dDhINmxaNDdkQnBnbnlxSzVZ?=
 =?utf-8?B?VlcwNkwyZXBSQlZjb0dsci9UamhZYWU0djNBKzgrTXczcTV3TEZJTGFnVUpX?=
 =?utf-8?B?WTV1WWM2VElISkFCRGE0dklCcFAwOFlmelRBVjJEOVFVQnd1VFhzTGE0MG8v?=
 =?utf-8?B?YmlZcGpqdmphK0V2U1hFNHBoa1hraEVxN1I2ZTF5aGJPV0FnS1dQMlNzQ1o4?=
 =?utf-8?B?d0FDUnB3UmYwMWtVZk50OFEwYVEraGN6YmJWOXZCdFpnU0NvQ1hoaGZNMHNC?=
 =?utf-8?B?a2U3L2krenBlM3pTNWwzREN3WG5QeWhyU2s1MW0rTlJwb2puMEZITFNWaStx?=
 =?utf-8?B?QzllL2VLVE9VazRrYnp4d0hxdXI5YU5hTFRXV2Z4eHBTOXN3bXZ4VjZHV3JN?=
 =?utf-8?B?TzFueHNiNFhyRFBXc29WcW1aM3dqR3dWS2pYdkIzQlJNQmM1cTNGbThOM0U4?=
 =?utf-8?B?WjIvTmRRN09EUTduQTBkdTA1T1NITi84bzkwbEl4ZGpVYXVFdThDZEdWb1dV?=
 =?utf-8?B?dXNjMmJzZmtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7454.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnIzZFIzM2tha2QxY0pIVmRzeW40WENLeDhEQ0hDWGs1ekp2RkZzcW5KaWJ2?=
 =?utf-8?B?MUNScDRNQ2MvQ2RjM0NsUlRpSVg5T0Fra24wL1VkSHVOSlA0Zzg5ZllRcHFv?=
 =?utf-8?B?UXllVllHRFZqbzN5TnpoaHBJeXhXTU5CSmR3Um5WRjZoRVdqYnRqTmNTcFlX?=
 =?utf-8?B?U2pJY2ZXejRYLzNHYUhGZHFuQ2RVYnhMZ0hvb3NIc09zc3cwQ1ZOZG9XbExO?=
 =?utf-8?B?VVM0bHhpdEMvSE1WZE8yNThEbjVwM0VHK0hNRUNVb2RkdHZDK2NXYWFtWmpG?=
 =?utf-8?B?KzN0U29oeU9TZzVzYldFWS9DMUJhT3NnNTd2UkQyQjJPNmwyOWRrTnZKTmhp?=
 =?utf-8?B?bzdNWHoxMWJhcXhNdEZjbWYzUjBiUjVDQXRFSGdtK0QrK2toeExadVI2aU5j?=
 =?utf-8?B?Nk5UZDdIV1REaS9nK0RBZnoyaEc5QU9ITklvanc2RXFhY3pGazVkL0xNN3l5?=
 =?utf-8?B?ZDVuNGFCWklteGFDQUNhZ25Kd2luTWJ0Zjc2SVhzTjBGWkIwandGYlRpbi9t?=
 =?utf-8?B?WlI5UGEvSVRjOEVqNTlRamRjSEQzb2djWG00TGRPN2grWmdvQ2VPQ0k1cUda?=
 =?utf-8?B?ZFhSZnk4UFo0M3lmVFEycFFMT3dwN3VLRXhldzZFYVM3VHhjdEEvY0dKL2M3?=
 =?utf-8?B?T1JpejlOY1Q4T24zZGFvQWtvUmtCVmU0Vy9kZG9uUXhXYi8xVk5SMDJEUmRW?=
 =?utf-8?B?ZDZ0bVI0ZFYyWXZYMDUxTlZ1R1FuQVRuTm1RTGhFcm1BTEhROTQwaGVCbC8x?=
 =?utf-8?B?RGpKSUt4STVsZGdDSDZhSUgyUDdQS09zL2JjekxnSllMeUQ1TWd5ejRycnNs?=
 =?utf-8?B?cE5MM0lJbHZsTXU5R0VzRm02N1BVZ21uSFpkNnRIaHhWRzlFOWVTSkxIM1ps?=
 =?utf-8?B?NEl1b2RXeHdMeE9FRnI2N1djK1p4MWpaU25MRFBoalNqaSs5VGN3QUhMNmMw?=
 =?utf-8?B?ZXk1d2RLSEZUK2s5cWZuUzdJS0Q0Mlk2QnF0R1VRckZLTmwzMDloQVpybER5?=
 =?utf-8?B?bkNFTVU0Ly9WaFpNUmJNQkM2YTVQekdBYlVxd0hnblkvaUhLTnpUekxsdDNX?=
 =?utf-8?B?eXp5OXdiYSt1Rnp1YzZlYjNpM0pFdVd2cWU5dVpDbFdrbUV4SFpUQnR2R1Rr?=
 =?utf-8?B?RE1VK1QyRWNBU1d1WU9hcnQydnpldjkvd0luMURuL244eWRIZWRla3gwT3lW?=
 =?utf-8?B?NDFzQUgwdVlxVlR0Z3pqQW9EbEIxL0pRcGs5ZkkyQWZCemd4UnFtQlptMUZ2?=
 =?utf-8?B?dXFHWmhsaXNDYStSUzhOUk45c0NaYkRQYll1NFZjVzY0Nzd4bks2c2o5SXJ2?=
 =?utf-8?B?N2pTVlE1R2VrWm51KzV6bWJMRDRlS3dmYk1aUXU0bkF3Z092RzFCQ3YyWHhr?=
 =?utf-8?B?ekZxQXN2cmY1b1FpcXJUWTcwS3BhZmJBWUV6b3V3c0tlQzBKNkMzbTNSdzNx?=
 =?utf-8?B?QjBaVGZQb1FpeEluNmRiaVRPLys3WXlWMlZWYVkwdCtRZHJmMWxWRGNNdGpz?=
 =?utf-8?B?M3crUVFPL1JkOFN6Vy9VRjVlRXQ2UHhHR0lUZXZrNTB5OVVDdGh0UktjTTFr?=
 =?utf-8?B?eWxNeHlrUUdBYzFMUkVVdmlsUitOVk5IMTYzTHpJcnAyL1FxR0p0VlhHMjRT?=
 =?utf-8?B?dXRZQkRyZWNTSmlqWG5tYVlLdENBVzNSaU1xbkREaUdCTDl2MFlJeGp6cjRq?=
 =?utf-8?B?b2xKSHNOeCs1OWROMmhkeHhWcS9xUFpWTEhPb0lMZVc4NUw5L1NsK2NuTkdM?=
 =?utf-8?B?eUFXNUlRQ2xjcUQ4ZnlUMXZ4STNaY1FHQ1Rtc09GdjVtMDE2Nk9pUmczKzlS?=
 =?utf-8?B?OHVPSnNpUUpLM2k4M0lOR2l2M2ZoVDliSnVIdjJWS0Z4blhGM0RQRDM2aVRl?=
 =?utf-8?B?ZzNHREs1UHF5SDh4ZVB0azhUSGUrREVYTElxRnJTaExHV1NaamRuYnV1WEEr?=
 =?utf-8?B?SXB6NzlGTFNZSkE3dStvaHN3U0JOQlIwaVhPMVVLQTRyTHpNZUt2YU8rT2JE?=
 =?utf-8?B?SUNuWUJOK2RUVUt3Vlc1YkQ0ZFlYYTlTd1FyaXVRQ2VjaytabGUzVndwSUMz?=
 =?utf-8?B?MTg4VTJtb2w1bGRIUnUxYzdoWVFOQkVOREdGLzEzNWYvaGdjd2JVVTJFR2RW?=
 =?utf-8?B?M1l2SC9YdVZlK2E3K28wV1RGSmV3bG4wNGMvNTY3cTkvNmJiaDMvelgzY0Ru?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a21f54-6ac0-4754-29c5-08ddca5aaf79
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7454.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:34:59.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZKYenN8vzZ5nRXMm8SjCSRvz4gJ81N5Rcc8KyG99bn7yub7qbTB7GaWBV2sXzqF49v3jSIr1ZoeLEnz1fBJqKyVBSvqS3wh0nlo/NkBiok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7032

Add initial support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
carrier board.

Changes in v4:
- Incorporate review feedback from Shawn and apply further cleanups to DTS
  style and node naming.

in patch 2/2:
       - Addressed formatting issues by adding newlines and removing
         unnecessary backslashes.

       - Removed the lvds-backlight node for the optional display panel,
         which will be handled by a device tree overlay.

       - Aligned several node names with DT conventions. For example:
         - `codec@1a` -> `audio-codec@1a`
         - `gpio-leds` -> `leds`
         - `pcie0-refclk` -> `clock-pcie-ref`
         - `wlreg-on` -> `regulator-wl-reg-on`

Changes in v3:
- The changes address DT schema warnings, remove unused regulators, and
  improve the overall structure.

in patch 2/2:
       - Fixed DT Schema Warnings: Renamed the i2c-gpio node to i2c-0 to
         resolve a naming convention warning reported by Rob's checker.

       - Removed Unused Regulators: Removed several unused regulator-fixed
         nodes for LVDS, backlight, ethernet power, and the OTG VBUS, as
         pointed out by Peng Fan.

       - Added EEPROM Nodes: Added device tree nodes for the EEPROMs
         present on both the SOM and the baseboard.

       - Node Reorganization: Relocated the iomuxc node to the end of the
         device tree files for better readability.

Change in V2:
- Ensured accurate `To:` and `Cc:` addresses by utilizing
  `b4 prep --auto-to-cc`. (Thanks to Krzysztof Kozlowski for the
  tip on this command and helpful suggestion from Rob Herring).

in patch 1/2:
        - Add Acked-by tag.

in patch 2/2:
        - Generic Node Naming: Refactored device tree node names for I2C
          GPIO expanders, the USB Type-C controller, and the PMIC to adhere
          to generic naming conventions (e.g., `gpio@21`, `usb-typec@67`,
          `pmic@25`).

        - Removed Unused SPI Node: Eliminated the `spidev1` node due to an
          incorrect and non-existent compatible string (`rohm,dh2228fv`).

        - Minor formatting improvements (e.g., whitespace, indentation).

Signed-off-by: Richard Hu <richard.hu@technexion.com>
---
Ray Chang (1):
      dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board

Richard Hu (1):
      arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board

 Documentation/devicetree/bindings/arm/fsl.yaml    |   7 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 372 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 806 ++++++++++++++++++++++
 4 files changed, 1186 insertions(+)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250604-add-technexion-edm-g-imx8m-plus-som-79adf0b397eb

Best regards,
-- 
Richard Hu <richard.hu@technexion.com>



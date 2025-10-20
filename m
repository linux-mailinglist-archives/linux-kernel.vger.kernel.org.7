Return-Path: <linux-kernel+bounces-860921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01398BF1546
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD013B7C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C93128BC;
	Mon, 20 Oct 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="B6tUWRa4"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020119.outbound.protection.outlook.com [52.101.84.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F530149A;
	Mon, 20 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964577; cv=fail; b=EnmoPzuzDEov4IdpnlIGj3pJoHTN7HawF6ESpnIOR65a/xoQwJWiZJbYB8FxV3NU9O3eAdrKKeo/PfE4J2EZ0KrLrDfVs2WuVP+Rt2gmM14axq+EYdAGAaln8Xc3NXpP5NQPDt5lklJi4xtzdhfzFEQyEkp4KKZpiiXPLUBZL2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964577; c=relaxed/simple;
	bh=fdk1jnlz/znn7bUzcA6531Op93iTsZJf8jgXxbHwJMA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Q/uOniCUo7mvcjHzQ8cyDuA+dSRvFMQmNSAVFfep1pS7FaYk1oNYrKE5esmKrGx81opubQSumwpgIHH4DSISDsMxALBbs28kKTxXleKgvEZN7oVhCi9+l/+C5aIHIWXIV1xu+nSvsXvbxo0VXUrEQeCKJXOHJ+JnpOzluy/euNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=B6tUWRa4; arc=fail smtp.client-ip=52.101.84.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exhH8YDf1MT8QiLYyqrLHjRE3uYnKL/Ye0rjFo+JGrOwqi38zGkEWnuNvjtdoBRop1TeW5zqIaQQE6A7CkTtZvmk0EXWLHlMAj0pZGxhTup2Jvlr74tGqKE6OFISACPsnz/IdIUB/8iZpTjnQW4vWJHUW4mEutx8eoLXpv1FqFtJegiC+u5uYBlAA3rUMxC/4zgYKrR5iuMELRhTx67TXIuzmjfHAPnJ3yrNHyRk+LJ83F990Sr+WTQSn3OngQdxj0Vk9AbL8INXq+orBaSaJdG7zsqCKwTZyeOymMts1AkPzB0KkNCfY1ky2A9v/MAdZENU8qjb3SMPkYlnxQRfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csAIk7//sYR1p81gMbDbfczeDfWqjm4M/KL+rcjlaBs=;
 b=Y3svyYV3xzA5AyflcvVzTmDbVtenKXAMxFeLw6egLXOyi/n72YejpPhXf2UZV+nkQn+PHKNbS7bxvl4LBOnF23rWZfe3VByE4Png+tS4Z1sRubEzzERen5M0g/ikbk6xu4/9H8esk3r8YlddZOppiEkvVKaYnIYA/IRi/rLnEVCHs3f89apwE/THXN9zcjznfvHb5pm4dAPzz9etZqD/ycNSFk0/cdU5VWbMDYkR6MTcaAi/dPJC0VLGVFJK9ufrWJH1JJVeX1lRWvJG2z2Qdy36cR7EbnzM9L9QQq9m/wPMMsqi/5YkORnqOfvR4+uOv0QRtODq21+gVuD4to7KtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAIk7//sYR1p81gMbDbfczeDfWqjm4M/KL+rcjlaBs=;
 b=B6tUWRa4CBDPW9v18eiChFRfu5jTPPw755WtPhUHifEP8/fdx2g+9y6P6W8yW7+XeiHre1Ian/+4i6gavk/8cQF/SPUvS+NDb2iQkrW8AYqbnWx4WkatlmugWTy30MS/Lj/QXmLe3vD+5Y7znfsChgTZBgdPHZSpFVnlsrXTIvAK11YjXLmAOIfhuwWHDjGxpPN/bPkNh04xZ1nzc4w+B0ymTDsSHEBwnTBXQKJTSPaB/fth6cF+tPS+1spO0t/p8F5cIXlCQnanH01Qjfe81xUbbu/Cs7ntIRf3/1Wh62/BD18clxoomDZMFzPotStzqigcUoWDk3T2aLsbJaOJMA==
Received: from AM6P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::42)
 by AM4P195MB3037.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 12:49:29 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:209:81:cafe::4e) by AM6P195CA0029.outlook.office365.com
 (2603:10a6:209:81::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 12:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 12:49:29 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 14:49:28 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v6 0/4] Add display overlays for imx8mp-phyboard-pollux
Date: Mon, 20 Oct 2025 14:49:23 +0200
Message-ID: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMv9mgC/4XNQW7DIBCF4atErEs1YAZwVr1HlAUYqJGc2DIps
 hX57iVRVVnesBr9s/jekyQ/R5/I+fQks88xxfFeQn6cSNeb+7en0ZUmHDhCC5rG26JvE53GYfh
 ZqItpGsxKx+znchO1wlgtWik7KUlBptmHuLwHLtfSfUyPcV7fe5m9vn80wxqdGQWKLYJ2qHSA8
 DX168N3n86TF535juOiyvHCSYAA0iLTtj1yzT/HAFiVawqnVdCiCdJ6J4+c2HOqyonCKaU7yYw
 QLXZHDncca6ocFi5Y5gLTyqPBPbdt2y9jwOtMCAIAAA==
X-Change-ID: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Yannic Moog
	<y.moog@phytec.de>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AM4P195MB3037:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ab2838-db65-48f7-2de7-08de0fd71bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnhXTE9rN3VvcVZuMS9mNkVyaUl5MFM0WDZYTkJxeTBUcjNOc2RNa3RIWUVH?=
 =?utf-8?B?TmhIOW96YWpEU2wrMFcyWkdTTzhKMFFiWDBYaDRsemhZdGtOaUpXN0xZTGd4?=
 =?utf-8?B?V1RqTys2ZGwyT1JCbXNKMWNpNzJIS2JJYXN4U04vY1RDTm1sVUo2T1l3UFcr?=
 =?utf-8?B?akI0VXUzd3FVbUV3U2x1M1ExVnBRUDFTaVc0ekZPSEd4RFpZWXJkNUVoMHBD?=
 =?utf-8?B?THhYdWYzVVFKd0V2OWZlR0NQYVhtMU5pQ0ptMXZpcEFTNDlYazAyazVMVmxT?=
 =?utf-8?B?YkRKR2lzQTFIOC9TQVltMjh5dFJhNTRWdVdvUFpZbDFHNjN1MW1pM3BsMWFh?=
 =?utf-8?B?MndaZVJMZm1RS1ZmZHEvNlBML0NrNlRHVkI4Z2ZaSkNVVGNUNnArUEo1RTd3?=
 =?utf-8?B?YmIxQjM1cUEvajQ0eXlKUXoyWGp2YlJ4cjBvNEQwSlRIejJCRjdMTDc0RFYy?=
 =?utf-8?B?V1N6VHV1cFNXaHBiU0phSVI0QnFYU2xFSW1zcFhsbEJVeCtibWlZMDVrM3RB?=
 =?utf-8?B?NlpPTGNaWmJFZUJlSXZsbExMRnZWVnZFSWVkSHFJZWc5NjNqaE1RUkZMbTFm?=
 =?utf-8?B?b0h6SmZmYWlEQ2UxTU5sbE9vR1FRenIvUHpndlBFN0xXdUw2YXdGbW54SnM3?=
 =?utf-8?B?TmZVaHVMRThsK1RvTk9rTHRHOW9BQUhtUEhub1MyTXk4UG5DMjhDbUsrMWZS?=
 =?utf-8?B?VXpWQ0F0UFRoOWt4TW5OWTdsVjNXRUNUQzZudXY0cHpWa3dBSERJWldpQ24w?=
 =?utf-8?B?SWxRNW5zMXNyNWlCZUhxY2xTUENadjhlelJMcjBTa1MxbXpZNSsrN29YZllF?=
 =?utf-8?B?RFRtVjNnQ3ZOYVB5cm1Tck5uODJ5dnFvb0g1YlJwREdkOVZnRXVWUU8yVTNT?=
 =?utf-8?B?TERxYmgrenBPRHhRYnRjWEVpeXRoVnZ3dlRYdHJaMzhZaFF6OVJPK3hUMFc3?=
 =?utf-8?B?WGtVSUg1amhRblhTZVpjMDdMR0JENXJWNTllTFNCeGozWnpIdGlmK1dpMlhk?=
 =?utf-8?B?OEZlMTVOZEpwQjFCZ2tEUFo0bm9NODZIODJUVit2UVhMRitNdnlUVWtnUXZH?=
 =?utf-8?B?UjdHNXppZENTN0MzSXBqeUhjbmNvMjZOdzhUVlE3TStMT1VzNFBWT0cwY21r?=
 =?utf-8?B?TjF0SlN6M1VqeDNyVE1PYmNMdVNXclRLaDFFakxRRFkveTZVcHJIN1VRbkpC?=
 =?utf-8?B?OU5wcno5Sm9sYUc4c280ZVc2QlFrY01SNGVHaG54UDBFZTVhbUxPZmN1OFF6?=
 =?utf-8?B?QnNRQmwrMC9UanFmY2V5VnI4UkZzdUx2UVpTOGQxWHU0UDVPRDJGdWRJa0t6?=
 =?utf-8?B?L2dwVFpIUGhacnBLT0VnejVnU3Q4MnJmbjZvY1dqVUZXMlVib0o4eTEwdHJE?=
 =?utf-8?B?TENUOWZ0ME1vbTJDSzQxMzBjNXZycE83V0hTNjVVUUwxM0lkVGZObm9tUStz?=
 =?utf-8?B?ZWw3djJEaStsQ2xhaXpCaWVUSk0wMGV3WjAySGFjTXgrSVYyMllFOGkwOEdC?=
 =?utf-8?B?NXlsOEN2ZHZFRjB4ekY1MVRJYk5GZmRDeCt3R0R5UCs1ZXFqU1RpNXIvNjNl?=
 =?utf-8?B?WUd0QWt1NHMxTk5WVDhpam5WeGlYcTN4anptb0xxMnNPdlozTnRySWlHSUth?=
 =?utf-8?B?QmlJWk1rbmlybkRITXNLWjQ2dFJYN2QyYS9COHlSNHZXbnZ2UHhNdVNOK1Vs?=
 =?utf-8?B?UE9uMklWMnkzcGVVRHF0Q1FYY3NDdVdpQXdNczVUVmlGMDl0YnI1cU1QVWtN?=
 =?utf-8?B?OEx6dkxaT2xRU1FuM0FjQUZPRSszbFUxOEMreFl3bDluQzlPTTkwWjlrZ3Zw?=
 =?utf-8?B?YmsxeEJuL2pUMnBJL2tISU1qczhyV3FXUGY0WEhOUG1sZkxoZldLVTc2Qkcx?=
 =?utf-8?B?L3Q3bWFQMHhCd0RSZUtQUkRXRytSZ3hEUnI3cmJUTWVDd2p2aEdUdy8yRGV5?=
 =?utf-8?B?WjZzUnNCbmJzWThCWlhoQXdyVDBWWjdSd3RlckRyZnhES3JHdlQvNFF0K3E4?=
 =?utf-8?B?ZmJjQWszdUdkQnE4Q3JEVDYwNi9XNGY4NHFyRmNUQWNocDdhRTlLdnFQbUp1?=
 =?utf-8?B?dnNTNkhjZGhFa0QrdTlRd0UyR09zZ3dxZloydE9pZWVUQ3JyVXhBYmhNZnZ2?=
 =?utf-8?Q?RCr5s4JkCCIhspff2VkF985xc?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:49:29.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ab2838-db65-48f7-2de7-08de0fd71bba
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P195MB3037

The phyBOARD-Pollux has an LVDS + backlight connector where one LVDS
channel is routed through.
Also, an expansion board (PEB-AV-10) may be connected to the baseboard
where the other LVDS channel (of the imx8mp SoC LVDS display bridge) is
routed to and there, too, an LVDS display may be connected.
However, both LVDS channels must not be used simultaneously as this is
not supported.
Currently, 2 displays are supported. Both are 10" touch displays, where the
edt is deprecated and kept for backward compatibility reasons. The powertip
panel is the successor to the edt panel and the current panel of choice.
The expansion board (PEB-AV-10) also has a 3.5 mm audio jack and thus
the expansion board may also be used for audio purposes without
displays.

---
Changes in v6:
- re-add i2c4 properties as omission causes dtschema warnings
- Link to v5: https://lore.kernel.org/r/20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de

Changes in v5:
- revert to leave copyright dates unchanged (leave at inital puplication date)
- remove redundant properties from i2c4
- Link to v4: https://lore.kernel.org/r/20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de

Changes in v4:
- remove author from copyright, fix copyright date
- Link to v3: https://lore.kernel.org/r/20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de

Changes in v3:
- add patch which updates copyright and license
- update license identifier according to proper SPDX syntax
- explain in expansion board patch why a dtsi and dtso are introduced
- Link to v2: https://lore.kernel.org/r/20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de

Changes in v2:
- Change license identifier of pollux and peb-av overlays.
- Link to v1: https://lore.kernel.org/r/20250915-imx8mp-pollux-display-overlays-v1-0-59508d578f0f@phytec.de

---
Yannic Moog (4):
      arm64: dts: im8mp-phy{board,core}: update license
      arm64: dts: imx8mp pollux: add display overlays
      arm64: dts: imx8mp pollux: add expansion board overlay
      arm64: dts: imx8mp pollux: add displays for expansion board

 arch/arm64/boot/dts/freescale/Makefile             |  15 ++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      |  44 +++++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso |  45 +++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso |  45 +++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 198 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       |  45 +++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  52 ++----
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   3 +-
 9 files changed, 413 insertions(+), 43 deletions(-)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>



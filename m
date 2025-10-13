Return-Path: <linux-kernel+bounces-850028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFABD1AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C504EE0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F0C2E1F10;
	Mon, 13 Oct 2025 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="A5+JjogJ"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021114.outbound.protection.outlook.com [40.107.130.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7222E11D2;
	Mon, 13 Oct 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336727; cv=fail; b=bkFbsCHM2XvQwNKr8Gxs1aAFxSDNBzMCpOJX/crTSfjXapqzj2gXb8ofi1j4a4D+6vTReP8P3hOGUTUAMygP5id4+C1Sh49dAkwNWiO6ZsUbx53KAKf9tQxIvM+r64GBlBGUHgpWxhce65Xv69XaAqiq21K2y4XwpcuWhMoHOjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336727; c=relaxed/simple;
	bh=/e9NOZPxp/7p5mnr5WIVcoWX+5Mq+KE/7+Nay0xztk8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AK/FZUYVBRfZiClbriiLJHsa7kehv4r+8zw3kCJu2VplEFkON0gmJ+HMSkTk3ijHHvjIFX8hM+40b5B7z11MmJ21YKVOmgtbzrXQxU2d00yRgvY3P+0CldB7DrFqwP/u3f5td2Xc5DbTyoEdruCnHwY3OwPLzO1/5LaymXFd8EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=A5+JjogJ; arc=fail smtp.client-ip=40.107.130.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws31sZzq/GEEOjmAnZgKpuZ5W0mRtl+T9voP+4nziPM9YiMxDkqIXmvmdvcPtBeEmjIkw2Lz6zjcXtALAEjIJ5/dAVGWGxxHDa5eQHt/ZS71jbO4FOycHS2KgbSEXbeHSef902tDoaPN6LnmGrW728gYJ/o9Y5avmSxFBIuFi5U9xTlXq39zKOfeVKEfu4stjE8818/t+gBNX+sS2QeNFBH498RaYz0PrwdVvCAVlDuLj/CpkZQzfn+6rlxeeNyEv5NsWDIxClLBIUqdHOf3Yo5BvvariU1XG1PUCgPi7l3gbdS0w0Ub8WtQq4a2/V5k5rOKOL+c+H7UO17i3cTyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqvyyaCeqbKmFuVALm2cXWnhl83c80ZscID110FAfwQ=;
 b=E/im/hNV79UGG4eAkYonES7Yl/3C4znX8x/+RBdvcOttnQck3gg2ZCI2wmHmLkg8eTaa0LMuUgUkti0FB8bIwiZDjOGByJLHzx8Z4Ubwg76UxOxGFsxCy1zwwc7QSnC8on3q2FkRkDD4Jajy9EaUFE/3Sf4/R3TqhtGhEnQdeNMszz7ayurkmGPQa6cgOriSQ71wYVZ+Tq9dVAI4ASSrwlhAm8E1Ggm1b9eRSCczSQqbn8v403zrH4bVDbPD+37IlI+AKi3JxSWl+3wVs6l1lmMN3EYSp1RnZKSc7rKQiNRTzlSYk3c6gYmE7ythFAqNSY8i00JRnvv0gPYzr+y61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqvyyaCeqbKmFuVALm2cXWnhl83c80ZscID110FAfwQ=;
 b=A5+JjogJ8ii1Lhns+ogGKoOTJvMXAS/Y6HMheoLUqjoBrlYif6kENrJWFNw4GUUc8THcyLQaGYieWz0G8xtDbSTpKjuoKLz83MSCBpKr3iJPWYwNH6g+0JoGGDObqXi9m1TyafwxFcQsjwmrp0o3Ez8OZzGVzU8IFfQgoQvXIHueK/gI4/iWkyaTpDNFy8aOEqm8hCDKXKl1k0VhGf2vs4UrvMup5yR70qTxcB0OyKireibIQSBKzlaxPGGq/UaED8AU2FlFZYpfRyFRdwxehOuxAKcKmNm8Nbc+K52CN5RUATVKCe5DZVPdPJHRnp9x3yQ6FxCNzzBYZXUZFYvSUg==
Received: from DB9PR06CA0005.eurprd06.prod.outlook.com (2603:10a6:10:1db::10)
 by PR3P195MB0845.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:25:21 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::11) by DB9PR06CA0005.outlook.office365.com
 (2603:10a6:10:1db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 06:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 06:25:20 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 08:25:20 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v5 0/4] Add display overlays for imx8mp-phyboard-pollux
Date: Mon, 13 Oct 2025 08:25:05 +0200
Message-ID: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGb7GgC/4XNy2rDMBCF4VcJWkdlJOuaVd+jdGHdYoETC8kVN
 sHvXiWUYrLxavhn8Z0HKj5HX9Dl9EDZ11jidG/Bzydkh/5+9Ti61ogC5aBB4Xhb1C3hNI3jz4J
 dLGnsVzxVn9st2LDeKKaFsEKghqTsQ1xeA1/frYdY5imvr71Knt8/mvAjuhIMmGsOynGpAoTPN
 Kyztx/Ooydd6Y6j7JCjjRMAAYThRBn9znX/HAEgh1zXOCWDYl0QxjvxzrE9Jw851jgplRWkZ0x
 zu+e2bfsF/PsZMLkBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760336720; l=2787;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=/e9NOZPxp/7p5mnr5WIVcoWX+5Mq+KE/7+Nay0xztk8=;
 b=72WHorWLRCRhgFk2JTMpODJv/YiDkH20/ZJkNtVC7lI//bWCL+83VR4jwnlz0b2od4LSGl3d1
 aDywUGr1XFICSco5OuYrR2zBtLuqkQ5/LQp6gUnzXzfn9sO5nGJUhYI
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|PR3P195MB0845:EE_
X-MS-Office365-Filtering-Correlation-Id: 85afdaa0-b12d-4dab-eb04-08de0a214920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmIyOUU3ckRvbjNsaWRxczF0OGVucE5SWGtJazVSSzkvUG5jZUpEekxnRzc3?=
 =?utf-8?B?bVptR1NZdGJVWjY0Z2FnTFNzdFlodGs1T1ZJRTI0R2pEc0JKOTZnN1FORzZ4?=
 =?utf-8?B?alB2cmJmUVoxSEVvd3NQNVVaOGFyL2Ntc2puWEpaWWNIUHp2dm5MeWFDVytF?=
 =?utf-8?B?MnEwOUpjeDZNSUcrNUY4SG94UjRWQzAvYWRpWTdkRjZHU2JoYk0wUXhrUWxM?=
 =?utf-8?B?bE9TVHhLWDJEUEcxcUZUQ0JsK1drQVNTMzlxL2tIbjBzckhydG5Cb09zeUcy?=
 =?utf-8?B?WHUwaytzWjdYVXEwclVSOVVFWWtRMXJjWmpaYzVPTVdwa0k5STlSdzVUNzZM?=
 =?utf-8?B?NmV1emk1NVozeUt1VlhHc0RPR1RpenVJQkJIZGl6dUJhTDBoWFdJcS94aENm?=
 =?utf-8?B?ZTk4bDlUL3VxZUV1Z0FJU0laRDZEMlo5aDFHTXVNQ1VtQm9RYzFDODRrazhE?=
 =?utf-8?B?c3E3QjJ0QXJqQnU0WDk3Mk01UnQzMDh6QW9aWmRFZ3RxaGRRRGtQc0NwdHMy?=
 =?utf-8?B?bnZUZkgvVTRNMU13RlFxcXBwUmRzWTlMdVFlWXpPVGpvL1k0dFd6dlZwOEh3?=
 =?utf-8?B?SUEwNWQ3M2ZSYUtZdU4xTEsrM1RUYlBKMk0wVkIxOG1qUkh2bVpKejREQnFE?=
 =?utf-8?B?V25lWnRGK3hpem41WUVwWjZsb2dybmgrSFZySHBBcUZIbTV3a0hHYk9nQUZr?=
 =?utf-8?B?cmxnQmo1NDJGcFN6a2RIVFZmdlprdVh5V0dHMHI0c001SW1QbVVoczFhaVRj?=
 =?utf-8?B?OHpYSDY0NStsQjArTTRCR0ZzUkpmOVk3SkpWU2dSL044ZGxITDdNb3B4VDEy?=
 =?utf-8?B?Q25YWTNvaXZxUGdkWExab0dIeWh6ZEdTdWFRVUlVRlNhK05wSHRxbmwwNktk?=
 =?utf-8?B?NWNCSHpjNXFCM0RHUlR4QTB0QnQ4WE9iNk5VbVdSYlhnTFhFWjB2a0ttUkVQ?=
 =?utf-8?B?b21HL3hZL3EyV3Q3dHhYbjZ5aURwWnRkbXp5YlJtZ0JPUUxFb1lKQXErVEpU?=
 =?utf-8?B?Z0VlbDlmMmt5NXF1NlQzekNBR0ZJQ3ZIekRwa0owNGl2R0JZbWRVQyt6UUVS?=
 =?utf-8?B?ZGdUQzZBL0R4a0FVK1crSGlsL1lGVzVjYVkxNmVWUmtGWGlkZTBWY3luTWZO?=
 =?utf-8?B?azI3TmU3eVNBWVhNeGZ5SWVjZ3V1UDVOQnpRMVJsRWNER3JjcXgwY3dFclFi?=
 =?utf-8?B?VTJIa2w4R0ZBdzhORmpCdlcySFVYbnZnbThyYlEvUmlENTBZR3p3SGJpSTFz?=
 =?utf-8?B?SEpIWVdNaDNCS0c5VzVlaHc0b0RVdXpoMERDZTcwWkN6M0ZkVU11TU9JYm9m?=
 =?utf-8?B?TVJYcTBxVFNYZ0N3bWcwVXMydzlIZE8vNlhTQmpnRkE3U1VVYkwwNFpMaWg3?=
 =?utf-8?B?dUZBWU5Wam9qUXhHRDdXUmd6djNuMHh4MHdYTy9PZ2FvY0F4cWtaOWdFRTh4?=
 =?utf-8?B?RHhDT3FLWjNKN1YxK3JlKzMwRTh4RkhtQWxianNJakxmUjVqWmJpeURwamw3?=
 =?utf-8?B?d2lSWEtSOUpPc1AwdmlUQlZnNGM4NE1OR2Z4bXNkNmQwa2ZIbURaVllpcS94?=
 =?utf-8?B?UlM4S09GcmV0Sml0dVQ1RzVKZVQwQmt5Uit6blZrL3dRQUxIVmZkcnRuZHBv?=
 =?utf-8?B?NVlEWkFvOW12TlpKVUtrWnhPaER1cnNZN1ZNL2dpN2lvM2pLSFJkZjE2RzUw?=
 =?utf-8?B?WkVqdmUyeHlyUVUvVWVsR3lsdmhSUzM0Q1pSTzU4dzFtYkxuYlVBR2Y1M1Vq?=
 =?utf-8?B?VlZ2MGlVNTkyWUhNSGMvY3JWVDZ5bkRFL1MvaFhMamI5Q1RIU2hHdHRDbzBL?=
 =?utf-8?B?elRYZWphWmo0cFFtd2cveFN0TmFhM1QvR2lnVlJLVW8vTHBuTnlIa2VDaExp?=
 =?utf-8?B?K0g2TDBIZFJKVmQvWEFLL3B4WENKN2dDNGdnT21pcU51eHlBNUVHMzhWR29H?=
 =?utf-8?B?VWN1cU81dVlrTjZLTWtaVFpDT2d1OGNMMzZjd1FEdnBDeE9UNTRNTnlaRGtw?=
 =?utf-8?B?ZHRyZTAwYTdtUFdWRnEyRENCdHNoNmFwRmZDRm5ZNmhjNWtyWHliaWI0cTFS?=
 =?utf-8?B?VWZTSUVxdFpTYnd3ZTd1eFYwdnR2dEp0dFpDUi9STUFQOGRYTFlWbkdwNkcv?=
 =?utf-8?Q?U51iUkX+OT8DVkTqqp1Q/vZd0?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:25:20.9566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85afdaa0-b12d-4dab-eb04-08de0a214920
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0845

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
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 196 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       |  45 +++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  52 ++----
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   3 +-
 9 files changed, 411 insertions(+), 43 deletions(-)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>



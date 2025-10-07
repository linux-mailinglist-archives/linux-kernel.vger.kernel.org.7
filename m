Return-Path: <linux-kernel+bounces-843919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6ABC0949
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6364F36E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC52877EA;
	Tue,  7 Oct 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="NRjTZD3F"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020143.outbound.protection.outlook.com [52.101.84.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E94286D55;
	Tue,  7 Oct 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824831; cv=fail; b=slb+4+QJSU3tG25MMxXnacB1wBAmP+65iDdqz86Rp9X/NomIv1pYg0Efl/QjUUnzAVyB03HcJscuQtWhxE2gzx+zIvmltgUDHUrI8q0Nrf6JismLnMVkdfnYk6k6uCogztok4N+GbrBs9/3dSv2HawkaosiQow/PqMCEAHYFLPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824831; c=relaxed/simple;
	bh=dePRwGW+6LyTd1QCjHdtIMQoCPE1zyAcMoNqaHgrR24=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Z8JBqYRyyYvTsRjjuSM0Q4m5nBbIYtLpCghc5gWB3RFzlTo94DpsfK6jxXkLjSe+cGsejKiKuiIdaFMDYxo8ur4AG12toMgkSZty407gHleEeDlhRxx5WW23ziyAPYy5s3Y5zQWVI+MnfmXsR/ijPJH0BKBVCfeQ1wXmln5cFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=NRjTZD3F; arc=fail smtp.client-ip=52.101.84.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgPeRL/6pYh7NIFPZWupKy3/ygUjytYt95ruyc4EOWypZLqwE0cYHHmcFmPzkhsfprSdg+Xg88gHQ2pkG0rO2hrsB29/s0fp5LM/TATve0CjQTK9KFv90z5WWrWqoHp7VwMkk8A+brB4HOyFu5kNGMS+XdtafQ2kSWGXbSUBdkJAI13/Enj8MW8if+7sGUIcYU/71qi1c4AEGE9IvFVF9fYrL/nFFInNF6lQ8mETyxzOJHdCC6pMOXVLBhjaPPnlJ/InGLv99hF7wFaqiC09KlYEcd+YI07A0RzrKsDRYkUjuaTwl5NuZu0AyRtj5fXmsvbYL1l1fPNr2ENRS6rW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o55PSaBX+sh/+Azx+zjKs/S/Xd2nfs0ZCYIuWafQQ+0=;
 b=HEqPP1uDS7gqNAQKFoiASZkHSy7ALgNmPkyzAYjArvgtZL7muRPvbOLhwBtzjm9QNubxShuvrKGUHute8O64Q1HNflSzMSrpLtzJhEBOmPnOLLjE40IU2GXJk2+bhjwOuS+E3jceILth67kP5jOh6vIabkBjvP8bd+oOPt9g+9iTVtCge9XKI8qmLbKdw++txqEaC6AYcws7OZUDnlQwx84LDH4Lg4aLch2nTTiLpxO3dU9kNB0EpeEa9GDuCbZ8DaAEQZJzpe8YzbdyR9w3OrDZbGpYe+hHgCZKWsatL+8WJDCcPNzVFC5kzLGrC6gYYWLDTgTKepJv+M/+isX06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o55PSaBX+sh/+Azx+zjKs/S/Xd2nfs0ZCYIuWafQQ+0=;
 b=NRjTZD3FYTb1fecGGP72dQSlwlNSUX1qIdK7buFa7lVgcnVbi3WbG9nUYy4p1txHyX4Op7FLw9k3cvZw622hy+wOf/stxMdNwWlV67e4g/Ljgg/ECzC+47PnIx5sN/e/JpcuVCsfrT8QmQYpWBQFmVecvq+RNPVaJzDuNd3FBBiA4vQ7oDb/EMbcwhxGVPJoCUu1rFGIulyPI5Q1PdqbLRcf3ZLNjvOVv4LNx/FIYdGPEayMrCTDx7ejpy3zqoEWFxGcJqeLxgRw83/aWr8cXbFtAJ0Qni/KzGqkqW23z6BU/7gSTedO2PZKawRi4/qG0w50pwMFs+wMHIugkYvIpQ==
Received: from DUZP191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::16)
 by VI6PPFC695D3626.EURP195.PROD.OUTLOOK.COM (2603:10a6:808:1::120) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 7 Oct
 2025 08:13:42 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::bd) by DUZP191CA0006.outlook.office365.com
 (2603:10a6:10:4f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 08:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Tue, 7 Oct 2025 08:13:41 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Oct
 2025 10:13:41 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v4 0/4] Add display overlays for imx8mp-phyboard-pollux
Date: Tue, 7 Oct 2025 10:13:26 +0200
Message-ID: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbL5GgC/4XNQQ7CIBCF4asY1mIGCkhdeQ/jopTBklRLoJI2p
 ncXjTHGTVeTfxbfe5CE0WMih82DRMw++eFWQmw3pO2a2wWpt6UJBy6hBk39ddLXQMPQ9/eJWp9
 C38x0yBjLTdSIxmhRK9UqRQoSIjo/vQdO59KdT+MQ5/deZq/vh2Zyjc6MApW1BG3lXjtwx9DNI
 7Y7i+RFZ/7DcbHK8cIpAAfKSKZN/c9VX44BsFWuKpzeOy0qpwxa9csty/IEFK2MHmoBAAA=
X-Change-ID: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Teresa Remmet
	<t.remmet@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759824821; l=2553;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=dePRwGW+6LyTd1QCjHdtIMQoCPE1zyAcMoNqaHgrR24=;
 b=uSI4xWqHwjmEXb/38G4HrgFqYvhy039swVfci2vfy/FOZTHUjU7I6dWXdbdzlcevu6YJpCCxe
 nY/eejxMuS7AwsEwssE3SYAnGxn9ExOvhvcS4zKRv3Lstjvl+uNSgpu
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|VI6PPFC695D3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beae58d-ab03-48ce-e3ac-08de05796d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVVcWUyTGZkU2Z3MzJWeENRMDdqdm8zMUZmRTlIcG82eDZZaUtlSGJSUVc1?=
 =?utf-8?B?dHoxbFhQL09rci96aFUxWGZyRVU2eG5zOW00S1BsRVlZZDFtVHVRSHkrVzBU?=
 =?utf-8?B?VVNDL0JuOE5uTkcvazkzVlFZNUV5bjYxNlBCL3dxUnlRcm4zN1loR0hNWXNP?=
 =?utf-8?B?K0x6VnptekUvRjdmMWRPTHZPakcrRTgzbDhiZS9UZER1U2haeXpZWWxPQita?=
 =?utf-8?B?YXpoQnFaeGV3OGd4YnkvU3F0aGZESFh6Z1FPbnFHK1hDaThIb0pkampwaGdi?=
 =?utf-8?B?bGN6eVVKMmt2NDhySDNRTVo4MGlPSXFYV2FaL0JJVjgvbEVVMVRsM1RnYzV6?=
 =?utf-8?B?K0VxL3o3SDIycmVxR3VFdjFIcXlzWWdkMXh1UzhZaU5qZFZlWWQ4M0h1VC9p?=
 =?utf-8?B?QnFNNitxRjVseHJuUUo4amJ6TmNDUUcwYlY1TzJQTVpEQkZkQnAvbzJPRUt3?=
 =?utf-8?B?MzA3RlZHV1RHT21WUGpXajZSM3l1b1RaNnN1bzBJSnRmQStNczNRbHZmMDJ2?=
 =?utf-8?B?Tk5GTmRlRFlvYStUVUp3UFRWS1FleWg2YkwyUWFpZDdiTm1kbjNVUDJIMytS?=
 =?utf-8?B?N1NjaWNFa3pOTEZaSng5bDNTTGkyK205Nm5JUHFXdURraE8yU1BHbk5oUjA1?=
 =?utf-8?B?d2N3dDcwWWdxK3JjOEhhZ2crWUVrYzZNbGpLeVMwSTZIWC9mR1o4UVFWbkVY?=
 =?utf-8?B?azlRSFhickl4VXVkWmZGNkFzRTNrWjhwcjI3TEd0UFhGMEFBS3ZCY0JQMUxt?=
 =?utf-8?B?ZWVNK29WdnA2bjZNN3MxdVBzRTF6aUxkQmdrcWpESFo3Y1dPL1R6bm84OWtI?=
 =?utf-8?B?MWJORTFnQVcyZXViRkMxSU9xa08xSDd4UUhyN2s2eWdXbGM1SzYzOTRrYlhP?=
 =?utf-8?B?V01SckM0UmlyVWVERzFySUtOMVA5SG1CMzQvY2REVm03UGhKWmpXb3JzUm5Q?=
 =?utf-8?B?L25ac1dJMkNBTTkvUzB6d2NsZ000K0hSc1lSOWVHMXhNcmRIYlJRMjA2cXBJ?=
 =?utf-8?B?d0JQcGdKeWNQejZlYkRQSzdSdEd5OGJ1V0pWbVRPUWlRQkl4UkZwR3FDVjNW?=
 =?utf-8?B?TEdQYXFDNXVXQnZZSzFza2NQdmRsNHAwK2VDelBsemJmY3JRdi9WUEg1aTJ1?=
 =?utf-8?B?NDB0UzByaEN2MlZDRXh1b0o4ZjltQkNPTEovckRRdGFuVng5R3lNQWFDS3Q4?=
 =?utf-8?B?RE9Bd29wVno2WEp1dmEyaVhtRDNxWFVuaithcDNMeFhQVnRyZjYvV0twU1Fv?=
 =?utf-8?B?cG9OK0RsbzBSYWZaM2FBa1N5MzZvN2VPTzk3RlVrZHAvblFTRHVxTzJwM0RW?=
 =?utf-8?B?Z29oaFZpb1kvTzg3ejdVMUR2Q3NsUUhlODc2VldEeEkvNk40blN3bENqd1lX?=
 =?utf-8?B?ZjMwUG5EeDFOU3ZJS0lINFFvQ3Q1ZXE0dXVWeU9ueU5tcFJlbDVIeFo0bkZP?=
 =?utf-8?B?elNOSHpBa2E4emxrZ2IrcmVLY1RvSThBT0lwOXpZVnJtR0tGU1RXdjE0Mmpy?=
 =?utf-8?B?Z29nS2pZOWdWVHlkWWVtS0wvU2NYandtN201UXNiZTRDZHRBcEtWdEpjLzk2?=
 =?utf-8?B?QWMzaklTcnl2RUNhdUpQUnJQUVdEOUVaa0xXMWJvdnowWWR1T1E5NXFSUWZ2?=
 =?utf-8?B?VkxwNERhcmp4RmRDY21TR0hoSkJaUEJHUWFOekVYQ0RsL09haGw2THpTTmxq?=
 =?utf-8?B?bVZLbnlSSGx0S1JzY0lEbktVSHBQbnVReUtWNTVkek10MGJtNnFNSmFhcFlV?=
 =?utf-8?B?c1lyRnM5cWNkT3p1ajJjV2lMc2pPaDZrak9pZ1VrUkhmcncveHdyQ0xuQ0hr?=
 =?utf-8?B?UlZFM1RSdE9BWm9JeGdPSW5BaE81aG5ybkkvWHFQWnFScnhqa2RxemlwR3Fl?=
 =?utf-8?B?VGl6ZCt5U3hjU1N3eGdkMHM4bmk3bTU3Y3YvMGI0aWNTYzI0N05FeXFMOHpm?=
 =?utf-8?B?VXVQWlZ5YjBNVFlWMFdGMTZDMzFkOUxxd0lobWtpbnhwK280NFpyM3lIbkFu?=
 =?utf-8?B?UWZweXVPT2hqbkp5VTViTjZNZUw4Y2c4S3pQK0J0QUpxOUEzYmRkV3ltbzY2?=
 =?utf-8?B?UVk0RVNzY0pnamVPRlkzdzI1amNWVG4yOW5FanIxUHhBc2xHY0JGcERwWlAx?=
 =?utf-8?Q?LkAnr9bLXllNnh3zOLC9nzvzm?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:13:41.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beae58d-ab03-48ce-e3ac-08de05796d6c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFC695D3626

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
      arm64: dts: im8mp-phy{board,core}: update license and copyright
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
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  54 ++----
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   5 +-
 9 files changed, 415 insertions(+), 45 deletions(-)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>



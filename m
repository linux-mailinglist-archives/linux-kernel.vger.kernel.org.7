Return-Path: <linux-kernel+bounces-838886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F3BB05C0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10CE19252DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CD5263C9F;
	Wed,  1 Oct 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="SukUyuS3"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021138.outbound.protection.outlook.com [52.101.65.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB41C6FEC;
	Wed,  1 Oct 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322054; cv=fail; b=qsZizVPE84yqmLMDhsckXReTf5mVk7UIsNAMfsAz2cSn3iwdAQpI9Y+MWgRDBgW/gC1oHihjULHjQtm26IAhvxSpK1q4tgXsgE/+4pVT71EZqJz0kAr/zi+kGX9ozObmnmP+xMbBNaRaA+BN0NluT9drh9hu8cSPJ/EzGVDbbwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322054; c=relaxed/simple;
	bh=a/ILgDaQ5D7ZnkRC9BbBiC+sgJxCwmCt/8E1M/Gx/qc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nSU2hIXDapUWwC6WjukAWW5+Vp0y/Eq1z2wU10CY8phkAX929haelhbvV/k7JyrMPowv87mgrhiCS3ZPhn/Y0I30ZbVpGv0HLC8fxPQTRW6tDD1OV0olRLGbPx6mAXaUDowydow+GJFWDVOjGVCxCY9A7awsnVKZxjshD/hkib0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=SukUyuS3; arc=fail smtp.client-ip=52.101.65.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYLW9/KEvng2ogGszFavADA2oLIiQd+Ey2+yYVI/2ywEm/8Vf7gcYl6m7MBj6rT6BYHrivgpeb4Nfn2e1oUbNTqOk6zS2xgUitkfZydFNpT2FhNF/+zuhRF2ZAaXJNyN9gkNUqLLTfzmX+JMLSPPAeuAHzcSjP/dd2bCFy31EO2qWWhnMI8Zz0i0ig1UOVFxQ7fpI5HV4q3y3tSvQP8vsuszVSSXrVHwZ772gDALaPicUNUuHqH2hbWTUCkSIrUg1gGZzMIgFYuruBUaTAM81/U244vdx1FXRbnXZ5C7fpCVekvfWsFToUnrf07b3tzLQ8jtzpmfrj+Utbl2ls89lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIXKwBExBKx0r9ByNQ84CPOvxzk/LRb8MJOXvTNqJvk=;
 b=mDLi2NyIQYf4cu2lOExAPGydLkWB3ZjLRxVRe1ihA5vHgttJsI1Mv17myRjaKQydYkv74+aJzlRJR3nOvVTxSdxddg3UFo8eZi6hb92VDmRCTSkdUoMYeKaCc9cBFyuOGhZiPaXVa9/pKXktQkReCho8u+iCFJZHBpAgm8PH02VYR4fIWhyLI17uYa3howZxVUNKWhaDqx0OoQnhHKMDYydxdUaTwMDk0Zsmzfd5wqUpEzWRegjPhzBFdKuf15+xEb/0HsvL/EW9f6ZNwBMmOGlGI2uRsUuE4h8eys00gMooGRNLtOkEuYylPVI8i/RtsFSFacDfkxV/Rk1nAvZjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIXKwBExBKx0r9ByNQ84CPOvxzk/LRb8MJOXvTNqJvk=;
 b=SukUyuS3a7bDVZJXmAv+zFHQ8MAb6/Vks7yjz08Ai9xuzdeW5UNsL+QIdAjrY9pC5FH5PJKwGPq8duCqCi/5mLuulH9XYyZ9xu8uXtMrnLXpO2BeRDjVjEsPK13E7kvXVhdH7b5MTTLYrRQAUNVlbWnlcShF0tjUv1GbSrfWlHxZp77LUdBAP+0VyoVVJjisuyAyz7+oIFAcyPgS5sbxkv9F6fyIpShHzAQUJitUfxVg24G/C0kdu7eaN0C382yCYOQh8Y9Wq8xirL92xyMlasGn7IkADv91T2BCQcR5Q26i3EL8ZM9ck2WsIIU9HOlf2jrDHmHZxkzCN5T466QDJg==
Received: from AM0PR03CA0035.eurprd03.prod.outlook.com (2603:10a6:208:14::48)
 by AS8P195MB1978.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:548::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 12:34:07 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::9b) by AM0PR03CA0035.outlook.office365.com
 (2603:10a6:208:14::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 12:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 12:34:07 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:34:06 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 0/4] Add display overlays for imx8mp-phyboard-pollux
Date: Wed, 1 Oct 2025 14:33:50 +0200
Message-ID: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4f3WgC/4XNsQ6DIBSF4VcxzKW5UKHYqe/RdBCBSqJCwBKN8
 d2LpoOb081/h+8sKOpgdUSPYkFBJxutG3LcLgVq2nr4aGxVbkSBMqhAYNtPovfYu677TljZ6Lt
 6xi7pkG/EsqylKCvOG85RRnzQxk77wOudu7VxdGHe9xLZvn+asDM6EQyYVQyEYndhwDx9O4+6u
 SqNNjrRA0fLU45mjgMY4JIRIasjt67rD/1wRu4bAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759322046; l=2374;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=a/ILgDaQ5D7ZnkRC9BbBiC+sgJxCwmCt/8E1M/Gx/qc=;
 b=ZLwS7VsLa7xtB7gbp+Xm3s+V4ZfaTRvcrCbWqH+kkytoCLDOpKuv1lOynzYEE/PhiNgClRzn6
 V3Bolm5BVX7AKZTNRmLG2lOLhfmqRlyQ5+2pSVs6ZyO6Jdfts278eN8
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AS8P195MB1978:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e4e6ca-2d28-4d15-e50a-08de00e6d073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpXY2tXTG45SXhRdkNSckk4aTMrN3JRT1pyRTNKYUFNR0lVdmtDVHYrdHp1?=
 =?utf-8?B?TUdMOE90UlZOY1dlU0lHOFNxM29sVDJrUmd0aE05bnV5N3NRY3JTYWtDRFh0?=
 =?utf-8?B?ZWhFdHJlZjRrSDgwdzBFaDRkeCtoMUZPdWZhSkE0Z1dRZEwwK2VXdytxRXNm?=
 =?utf-8?B?by9DVjZOb0lBWmtSNEpML01RMW5taVJJUysySmJ6QUJTK3RxZ3ZsY3BkWklp?=
 =?utf-8?B?RFRhNmEyamthUWhHUi9UOVc3dXAxTmJ1RmlJS3RYdUJHYUtkQU53aDU4Mk5h?=
 =?utf-8?B?ZCtzODdVcWpEeFM0TkVzWTdhN3FVYTFJOHlHOE44Y094ZnNjZEVmOUtkeWFH?=
 =?utf-8?B?OU0rOEl3dWlmZEhCSndoN3lpNlJEL2kxbE9FRXRkaUNLSVlHd2Z6bjFxRWgx?=
 =?utf-8?B?Mi9abjVndCs0T0xiS0YxUDdBeHpjamI1RzViNkR4bUFUaS8yaW55NmdIWWRV?=
 =?utf-8?B?SXpidGxKT2FnTzZBYnlyYU5Eb3ZMdzc0UWc1NUc3dFFJWGlvR284bklkaWN1?=
 =?utf-8?B?NThYdGpMc2IyZXlLNGtqR0plOFlkU2hRODZwanVoVkFHRTNJSHlqVGMrazdp?=
 =?utf-8?B?RkkrS3Z0QitkU0VKUGdpbW05VXlUUXM3VG9ERlFHMm1aT3dyQmpldjhkMEI4?=
 =?utf-8?B?WU00eGVOWElKZ2x4VUtXZ1p5SVRBUjJ4Nzk1RXdQN1h1eWZUdGtQWFdtVTFu?=
 =?utf-8?B?Nk9McU5wb3c4S1YyOU5qdUJYSHJUdDdYLzcvV1ZMa0IwUHlXUWV4WW11dExa?=
 =?utf-8?B?RkYxV25ENzk4TkpoR0kxUHdLVGtCNEs1akJGb205QUZuWDVObEhueko0a1o4?=
 =?utf-8?B?VEJ1VnVDM2N4TVYvYVdmT2xJdzZhVjJIV250T3ZhbUNRVjlCUFVZcC9mYy9S?=
 =?utf-8?B?alBzQnN2RjR5b0Q0VVF6eHk0b0Z3OUlnd08vQ3lVYlZMcmsxbStYemIxMFh6?=
 =?utf-8?B?TFNtcXpLbkIza0J2b1VtNlRId3hyQkpabEJVajFVNVc3U1RpdUxkZm83aHEr?=
 =?utf-8?B?WjdDUE1hYWhYMEloM2NsbFpRTkVpQU1DSXhVbVJvYUZxbDB3NDhLLzdidlNO?=
 =?utf-8?B?eWQxaTZBOFU3RjdscGxKeTNnVEcxZ1hhTTRlMUhjS2cvQ1NMMEk3UmFrS0lh?=
 =?utf-8?B?b0t6YlVkS2NXWTVKSWtpVkVpTzFjOEk4VHVFcEZUN2NPd09pK1AxVzN2emdj?=
 =?utf-8?B?Sk5xbmwvT0VZSS9xTHpSZkRQVDhTTzUyTWFSM0ZKY1VlWUZmUWV6T1N6T3ln?=
 =?utf-8?B?VlhTeEdMQnVUZzdta3pxaTNsQ0p5ZWFxTERsd3ZiR1JvemJnUk1FZXZaTUhV?=
 =?utf-8?B?bFJ4ck5oUjk1SUliYVJMNHlHR0Uvd2pBWFk3ZHA0cmRaSndIQko3L3E4K1h3?=
 =?utf-8?B?ZmFrb0dTdGhLWVF5N2p2cHFGbGxqYTkwOG9oMmJXMEMzWTA4S1hTeStmLzJx?=
 =?utf-8?B?Yk8vTVU1b2VLM2l5OUVybTM1aVdZV2E3c2Yxalk5NUtIM2V3L1J2N3dEQVdS?=
 =?utf-8?B?cDRxVnlaUEQxTEgyZThRa2wza3orRGJLaEc5ZStVdTFSS2NiN2ZXdlNzbE0v?=
 =?utf-8?B?OXZEcGdkUnJKd3k4T2g4bDBvL3ZXUjVwM1M5eGF6UWFiY1lZWXpzUklqWWNh?=
 =?utf-8?B?R0VDOXBiTDdnOTA2YlBGQkRWdVRXbFdqcE9GK2ZXU2JFcDQ2aFNCR015UnFS?=
 =?utf-8?B?dG5oaWlFeWRIV1JrbGtKbEZ1cmtHaWFSQXMxbFptc1hGTjVUa01oQnJXVUVE?=
 =?utf-8?B?ZDgxWmRpWkhWVG5SZDU5RWo3TVk1OEprY2gxL0hOYkp5S25jY3FYVW1DeUFj?=
 =?utf-8?B?WFdFV3krNmVXY2lheEdtSnVXUU1DTGozSFMxUFZvNXFNNWRCZDF2V0FMbVU0?=
 =?utf-8?B?djN5WDJ1azRqUTRrQWYxN1IrQ2ROQlpyKzNrd28yN1hIRmI5NFRlVGw3cnZa?=
 =?utf-8?B?aktxV3puUFh5d3MyVWhkUWlNbmc1STlrM2dkT2JwTTJBektnblRHcHZTTjkr?=
 =?utf-8?B?YStFSEdkTFdZWUJOZXVLOVVGRHZPcUhDcS9oTEhQZUpRWkJrNWtDU3ZFLzJi?=
 =?utf-8?B?Uk5GRUVlNFpLQ0ZiQXdsMUpDTkErMi9jd29wL2VzWG1Eekl3SGFGSHFwOC9W?=
 =?utf-8?Q?PkCILxIsV637eLLFviCOZpsXe?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:34:07.2473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e4e6ca-2d28-4d15-e50a-08de00e6d073
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1978

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
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  53 ++----
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   4 +-
 9 files changed, 415 insertions(+), 43 deletions(-)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>



Return-Path: <linux-kernel+bounces-770717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD56B27E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880A4A2621A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2E2FF679;
	Fri, 15 Aug 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MxYpexMG"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA732FF163;
	Fri, 15 Aug 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253427; cv=fail; b=JbgSXZTI7ZUlAFhCRS8588XhANxFDHvM1Aedo2bCaB0FeHycmUq2vT62DBDsCzWU8Ti+Fa0LWs4IRN36rvz1Ui7BBK+KQCgoOZXn/y/bhV9r/d/lfIGofKDBrlbekkti71+/tJNpd2ZP5L9JcijSSpc4bZY3T/4EzJrdjqrJcIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253427; c=relaxed/simple;
	bh=1//U32ZAgOtfXH5rsfirjyuE98LVtrPEH2eBEe69neU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTERPREugOX3GuZembl2DlbP4zabXKUGz9+5M6BZFscIp36krFEm7TWB8YVwAg1KKie9gMlDg8wuR21t2hCCjYZTjesy9od0Y7wmstIbfr5TBkRcLoneqTuIq6slnPccNeZ03r15UKGQy/7FoqsQans5KUX14XFEWA1YsN7MhWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MxYpexMG; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoHC9+tEZscut2nVSdcwqcKmgQJJaHsHChrSXDbKWDHhh9ghcFJiJDAKyYGiwQiC7PPaLjV2ITgNQFqpCjPhno2fFDV6KHJXNwvdbe/HamS5AwRiSmDdoCgTXJKF7GB0xTvwkycuXRLAOGxQ0FQEcBd/t2a+jMoGeRAZzupG5h1DH0lIAEYmkIrt2F9GmbNKf1NAhFp5lcRu1i4bT8LrzwxXpLhcB3GJNxaH0fdNv36GSDYQFMsHxr9c2+tO5m5gVJ0gI0QHcE+h5l/MBK0lbasqnADnkg4iRVuc7U7izIADcZZBpJRwdtTwDc2MiKbk7e1mKA9wBHcGA3ACVOARIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIvSHWEmzJ9UJgFV2IOk4wBsjvO2QACmzav7oULHgfA=;
 b=eVtRToik7gh0crbPaWmsknS/jv3ivN8HvLvAhU+58tUztIpX9Qmdz+RxbQTdmhfAJeNsBs2mHk1cRsdtdhAtp+GPjDysJrCrQwQx3StvGNYfbUn2YujeJHcSzh5wBTgPcQvwcQW3a6nb59O6a20X/S/C5VTYGA7mjRXN8+YRqRuWioM7Sg+H6Xhh+KBvSabeHw3iCc+HZBOtnexUQRjE7wVjKbE8FW1IEC/DbYtuZWzgZ8n43Q1sXej/iZGmjcEolqkc1c1CkH/k8mjhZJKMffMAISfR+i8gTje63556315wUmlPvp4EQpSy3Cuf67fpLMUSCIZZ/Oh6MQs66GRM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIvSHWEmzJ9UJgFV2IOk4wBsjvO2QACmzav7oULHgfA=;
 b=MxYpexMGhrSK6Mzg6cvRQRjHlquDBypa5b2JujScVf1OWnLUqWL9dmSq02+iuxhxqq4YT/aGM9LyN9tKlESECiZsCnf57itrmNihy4We+7nx+1hL0orbB1Fv0vrEQr2Zsn/kUcgyepjjndjdIQprFPOCi42Yh1LTiHDfuoF1/7eqvR+7b2gaFuQRbvRKgll/H70V5TOAEHdqlsHVrXGsI9wkmiqx8C4ZF5iYVnyNjMvHC4d70w0KORuQWMHmyzfjHtUbeo3dWV8BABk5lkjgU4EpcAo1WsB8ATa615+F1A8iqHIlSqsvRtkZ3+vp+KuJZydhicxOZrPuLAYHB2hlcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 10:23:42 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%6]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 10:23:42 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 1/3] arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
Date: Fri, 15 Aug 2025 18:23:15 +0800
Message-Id: <20250815102317.910014-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250815102317.910014-1-shengjiu.wang@nxp.com>
References: <20250815102317.910014-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 11454636-0f88-41ee-3868-08dddbe5cf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPxkyDjGJb5IJxRemZE2x/3vUUsd0pPDDo5NuRPf60ftkXoXSzJ1FvY5ERzC?=
 =?us-ascii?Q?kIN5bL7YuQ5bhWtR+/vFTSJ3geTB2NfdF/Gu75o+yUlP03y63Vo8DREo44MS?=
 =?us-ascii?Q?kaD5fOiFU4sWw4HUh3hiJyHcppxzEok+PXaWPvhlSLlq8Xc18T4D8tRsn/yS?=
 =?us-ascii?Q?fQ4vJiOKGvzQPjuN9jPuj6LsYrLsrYKt+mqsJFmbrVVJ2Esv9DA0ujzqPyXP?=
 =?us-ascii?Q?vPfCHAn+dPPPVYVcuMOdYkZDfP1ACDBHrBoYa3CseqellVru1gsg8qzVhRyQ?=
 =?us-ascii?Q?1UKdiaiXjRCQinlWSdWntfyqDus9rrVFTlRx9sJGLtesHm/nQekMWclbad+T?=
 =?us-ascii?Q?T3pTD+dN+8DxlB1JeBGKO1GJdINF7PDMrYPv3cMmVUZePXChT45Uf2GE/Lg0?=
 =?us-ascii?Q?qJ3/eotdVXINWcyoowre9DQ+gVlNIp1qMxLjl7UgOEGePtOK2A0+JX3DMd1O?=
 =?us-ascii?Q?Y5ok3ocynBVTiRUAJEzQPzki1WprL1QcfmpsjZbxjhpIPXpe4BE0ztInqNA6?=
 =?us-ascii?Q?rRwnj4+bZZPN96pu1K8r4fr7Ry919sIqxAPo+HI2Fye1f9Mdqil937iQYwCU?=
 =?us-ascii?Q?WvMEGpzwbsfSFrgdy02X3viazra0dnvrdGj6Jh3SghE/PMnN7r2cRgJ2/wrb?=
 =?us-ascii?Q?OKl9+TejQjyTRdAT1Q+fkbPBEW1qwKJDmUFsgYzeCFgNHraQZQ639su9qyDd?=
 =?us-ascii?Q?nxeUAmQz3wa+2powjA4yyOFXrv2RAS+9grU0xhNDodN3fGAhuzlQ51q/Y1kJ?=
 =?us-ascii?Q?IWfRWM4Vni2TXyKcQxwS9iO4GVYorYNFZ3aGUQdTNtLgRkpyJcMaV/ILF+c9?=
 =?us-ascii?Q?oZKXRxSc/w6V9zO4PI9q1s7PWA22L782fYj8Jg29+PXq20eZ5O+Tebh4ksLz?=
 =?us-ascii?Q?fKkG9UJljajFP5kNmtgTPD3lZPZ/IjvpFTs3ATj9vKi/U8rOld68NllibYlD?=
 =?us-ascii?Q?3Fs86rc/skto+TzIfE2NeEzRgVqj7x2Dpry28DZdP3Wf4lxQqMMJe/H2VT8o?=
 =?us-ascii?Q?CdkNCljdkrQCb+bzOuQUsC+S/DzmIWSMMjt57PZi1JnbKIIjPoitEt0IW4Q9?=
 =?us-ascii?Q?CZlGKdi3VOaznwHoDq9S89NuyUasbdHJ9OM8lRVW/Tnqtu2frTiGc3shZ2U2?=
 =?us-ascii?Q?0xxvSuqfEgRlRO5Pjk5dczeW6YC7tI0BptNvXyBMI4mymBZdojIs8kn1BG8M?=
 =?us-ascii?Q?sJK2ZacQTPENhuLHBx1FBff0Pc4agmmpbOhjLp9bup/OkUE9tRQ/OBs4mwkw?=
 =?us-ascii?Q?iEaMek1MhjckSqk28heRvlINU7lDg7alpPUP3DHa59rsSxj7CXCadSWfYjwu?=
 =?us-ascii?Q?4bZcLqjdQmyxyR5d0SB7mewpxmVrRgdcij5HoCutwHywW4wZQRLEVwijGo6w?=
 =?us-ascii?Q?rjHHwZRtf8B4R5m6pFWmXelePg8PNogQDenybn9PlZsm8yYH1p5m3FwY/Sbw?=
 =?us-ascii?Q?0sz/qdZfXsp3Yb4KcgD66dAtVZVRO2PzJ6x5+o+C35RgclHAHEmZ2mCPgr8q?=
 =?us-ascii?Q?542cDMo4VZ9N8vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/oD8ZAiaSvwpmnP1BiwT1qTlFrLzBVpwEdyOsJkDOFsx409WHjuga9/EBzLl?=
 =?us-ascii?Q?7vRy/DJV7hpT+Ev/2gO83epeBatAknBFA3pNxm9ipNJWGVpQZ2nr2butrAT1?=
 =?us-ascii?Q?OW4ZtevPPq0C5eQ7rkhzq4IDVFzDw157yzLdk80ORZDvvDMbfKdbaIrPvQtW?=
 =?us-ascii?Q?2xN5d12B5dFIiQVWqC/Zgpxsx0x9lmscIc31BL6nEgLngGR84Cq65hZ400eZ?=
 =?us-ascii?Q?k9p8vdERk5ds9WX1JC9Fk3zFSLQpkOtURAtMNvMNkMNI4AuoI+l8WUJ1kax0?=
 =?us-ascii?Q?cLjcv2G4p3DKCoe6vhOvoS/gkqGLPnzTO48JpXPihjSK0Y6iQdv1II+5zvfl?=
 =?us-ascii?Q?TKmFKVx1FLigdg9LWuXJItOxmq0HI1cszX2mP80+6lq9TX5oWmk4sD1w8+s/?=
 =?us-ascii?Q?MP8B2x3rnJDjCIhislRIYyuHt4vrvK3cxcNqPpX/uiG7VqGWGvZq/uPc2YQI?=
 =?us-ascii?Q?Y1MDQalXOZPlp3DAn3j4NJ1umBCwryiswl66nNv052jVwyozYWFnns6RI4d/?=
 =?us-ascii?Q?6Qwaqnt/nYIaV0gl/EQ8tjUDSCJuApuIRFh4DO1ozwoCBUw+5liSsvigNTIk?=
 =?us-ascii?Q?RayprFKvGmpUW1vhv0eyUYsUMoM20VmS/Wwm2T5+ejw/7I8jCMZwejFrUyxk?=
 =?us-ascii?Q?XIJ30LJTjvH3Vc0uOzqnLj88u7Is/2NfysgAxBbSwxj8eTNIDyZ+k9+h5i7c?=
 =?us-ascii?Q?ndiqg+qPeWG2+uuRIvJ+/h/iXFyMAzeY9HZuKrvjCAoJlTp9a/jccFORji2g?=
 =?us-ascii?Q?+6D2CESLP+OousvQNPQ7E3pCx7KTV/svoa0qrmYlFjOaITevzVOrryLYAwP3?=
 =?us-ascii?Q?kVPSjiN4NPaFDaP++aPfF9dtAJikojUOaf7wK8qdrONBGPyfujIv634e+ibq?=
 =?us-ascii?Q?hYPBhIG9fadsT1wO93xKqOe7/mwpa3/6VY+h4LU5Z4dNsWLgfl1IQAjvT1b8?=
 =?us-ascii?Q?ShLzxIZjfWyk5lU2zyt6cvVh8ueH9uCNvJV5mXMDIO3Soqkn6UHgN90B/7VT?=
 =?us-ascii?Q?4z21zkC6E2mA4HR9/uAv/A66q+/QWcWBK1NW+KdUjiYZyDQjfSKQGjQxtL3z?=
 =?us-ascii?Q?gs4pBWDnDWOf7cztmQjVXTSGXQRG8S24QVJclYlIlaVuNRyZ8LftCk7KiqQY?=
 =?us-ascii?Q?eI6ZLO4s/4MbdKDuyEi45wKNoMqOWWldABIPhESaX4ar3nUIjLcC9dA8/QWr?=
 =?us-ascii?Q?ES5wRzXXdn6D7lQVRvHqxKt7xim/7OLuqWR8Jo4dCQFEtfXSg00GuSwd3Uqd?=
 =?us-ascii?Q?51Aox1FTExBDVDTcdrf8qjtaOzwrtD2Z+6kCRIPtaQVuRLW/a0pDbio/Q+ve?=
 =?us-ascii?Q?U2uQk6gLc2hIul1p7Rw7hE0pte2Xbh0WTSJQiO/b9HyCtyMkkwmBZ0Tk/8uw?=
 =?us-ascii?Q?uS8SjURyuodde5MGlH8x8A5Nr+qGI3b6vzjrHqDlxRWiOY4w/+854O7sZbLT?=
 =?us-ascii?Q?oCbDSZ1Hg0iFjn+pE3Y1axA4amR7Y5iITnwGylQR2Xf5BYbhfr8FslUWagdl?=
 =?us-ascii?Q?etQb51EfgKGoxPLFLRG1V7KJvtZSAgHhVOnAUEoAwKyLbwcSK6HuPI4S7ThQ?=
 =?us-ascii?Q?WvKytudwKJdIvEOnsNSYklrDm4ReCJD1SXBNKWEt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11454636-0f88-41ee-3868-08dddbe5cf01
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:23:42.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYNf+1IX4myp2RpWBYdTb5jKXPWAoypJ0uS36uazIyZSdWOqiqHNF2BwpbcGaSPZufN6NXmD4GzjphFTfA6CBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MM, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

As commit 17cc308b1833 ("ASoC: wm8524: enable constraints when sysclk is
configured.") make wm8524 release the constraint when codec's sysclk is
not configured, so configure the cpu dai's sysclk to support more rates
with the 'clocks' property removed.

Add mclk-fs property for the sysclk ratio, which is required by
calculating the sysclk, 256 is a common ratio for audio.

'system-clock-direction-out' is a required property after
commit 5725bce709db ("ASoC: simple-card-utils: Unify clock direction by
clk_direction") to specify the clock direction.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 622caaa78eaf..ff7ca2075230 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -147,6 +147,7 @@ sound-wm8524 {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,widgets =
 			"Line", "Left Line Out Jack",
 			"Line", "Right Line Out Jack";
@@ -158,11 +159,11 @@ cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai3>;
 			dai-tdm-slot-num = <2>;
 			dai-tdm-slot-width = <32>;
+			system-clock-direction-out;
 		};
 
 		simple-audio-card,codec {
 			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
 
@@ -570,9 +571,17 @@ &sai2 {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
+	assigned-clocks = <&clk IMX8MM_AUDIO_PLL1>,
+			  <&clk IMX8MM_AUDIO_PLL2>,
+			  <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <393216000>, <361267200>, <24576000>;
+	fsl,sai-mclk-direction-output;
+	clocks = <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
+		<&clk IMX8MM_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1



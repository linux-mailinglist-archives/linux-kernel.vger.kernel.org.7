Return-Path: <linux-kernel+bounces-736650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606AB0A00A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18B4E0AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2B29B226;
	Fri, 18 Jul 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4K0ZJh8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C491EE7D5;
	Fri, 18 Jul 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832068; cv=fail; b=dSRbexWITznPVG+e3cd3ISrJvAz/NiHM4rBlIhgEji0elMXR9lel7Efy6cAUa3X7OeZvOVtLDxqVIMBagMxTolKzP+H5M673248FcQlq2UEKMZhIf7x/7y0hFx/oVhhIhSMF6YZdf4Op9rIhmVUny6xnrqzwTQwSPR657fnFrco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832068; c=relaxed/simple;
	bh=yfWA9m0fWbFJeLzXT0asRO45wDNMBCqWXRPJAHAZpDA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qifMy+i49UrkqEfrltLEm9857oy2ShLlQv86inIJqwLRZMqt7Ba+wWRLX6yRAXnspPAE6KVI9OTh1w8GpEsAQmAPAtqgjgNP0RVZgE0dBkCkO6QkUWsIRh+6WAIcaC74k95LSdyO+vDFSc3Xm2ekDaPjuQag+R2l3w80K2FaLlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4K0ZJh8; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oggp9NOMzW25DzB1w4brxQpVsazQrvdj7ayWqhrIrjlJKlFZW2Z4zuNqCAR4VHOwDKXbmHaG1LRpghzatzYGrN1tyB7ZqpRDPTPTS6vZhRg2Br+9Fc+QugQ2roxtyadQFE8EecB3H1uE2xkJ5l+3TIhaKUFWc6WOX1qttYE5BWWZnLxfvmnoAsiekaxnCpttn8ydJLAL8blqzgj1oiiGrsQdnThXylKIB2yhnJXTjWwO8Db43fB3HSRncaLTgUOMyZI8iqOkTvQALYNhUthTMHljhuLscWHEYmr6VlM3HrOKIy9OXRd+kijVCTNI3eKmov18LswlBSrRuyWBIGNouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJf3bMQGotHKt1OZ6CbB843DHEDphWLqyaP6E8HCc7c=;
 b=f+97v3DwqhFUyT4SfuoVijaZQXBCAFVaWpvrmK/VTlzj9EVECEcR090yqs9UND3azpPDOUebf5gYArqv7YwWmjd0LpP8bEeAn5mz1aWDf5d11wRupoxqyAEm+hM0zUmQOa6+a4fEGB+UqaG1vjIUA672G9RuMHHJZRgoRd6Kw3XYxJeE0E0GXDJf4K0LsfJNLfKzApDym1elJ/Pv5wYuu82vZcVIOetEFTkY6F4BF+YLy1HNmOXrcca6NIwtjDMV8oI8z1FoVvyIVLlrBiLC6NgHUDaXI/pXA4pYxlniKpWh+zw2jeyHsWI4O1AviNyBkLewzuqTLFcWU8ymcJcS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJf3bMQGotHKt1OZ6CbB843DHEDphWLqyaP6E8HCc7c=;
 b=h4K0ZJh8qe51pxWLlmToaEDl0FpNXL+wqShrxTqVW6SLODeMp+Cm0KWJCoAtbh0ZB8o9L6Mf2xi13CimJ/s93pvX6qfQEKTkidqwq9A+pqwF4QK5UzbsqxIZOr9F34FF4lec9mXEh2M6j1cWABPPbVoeEwJNocQn66v4cxzt+UPE2oUsq7prPKsUmwvnNS940A/Qu22y1f9WKJASOn6KJZmJlin1OZpCzZm2kH9GDT8/g/vfwi+aQ94ZIL6FK/wDPYl+45cRm+5sMG0DZAqrKiGRpZVk80nW8KM5G+hFShCPPJe6HEn3MfV2ldC1aF1joaR9Qbjf0cHqSy2hMsAdPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 09:47:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 09:47:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: mathieu.poirier@linaro.org,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX...),
	imx@lists.linux.dev (open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX...),
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH V2 RESEND] dt-bindings: firmware: imx95-scmi: Allow linux,code for protocol@81
Date: Fri, 18 Jul 2025 17:47:22 +0800
Message-Id: <20250718094723.3680482-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec37612-fa85-4d1c-4cb5-08ddc5e023c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncJXBHfH4uIgzXz4S9QopCCDBS/8LeteMmYMq2CwGFt1lMtg4JMmL14qr9gC?=
 =?us-ascii?Q?U5/6RfjEu9hZEjKCfxuDimiFzfe2igoivR9ECA5vL4SGflszrA7valjEcpdY?=
 =?us-ascii?Q?EsbUz6sGAryHIiUl5NSSAVT98AqVx9pfVn342L8mjyDt0ApM4+SSQrxiJwBF?=
 =?us-ascii?Q?L5cgmozkWUFkwS4OcaRT7LjWrKHsN9nTZKo0I0xIPksaZR8AOvR/hE0FwwXP?=
 =?us-ascii?Q?QuwVJit0MtlrN1Xe+iNVxSavakxUUUIh7W5z4aOAk1weeq/MqcnyXfFZc4Ct?=
 =?us-ascii?Q?EIkHcPwM38sIyRXeU8thA+rmKosvw015L9wGjYq4WaRfTnaZ4N+rU5B7E1QJ?=
 =?us-ascii?Q?/bL9mpjcq4EGCYPSAvGgLPaLzyRMHxJXV8lwdYsQAF5JybnfS4pS0REMlrYU?=
 =?us-ascii?Q?4tC3fd5TvtRYfndtBeWW+QK1n76RIYs32p4KgvSknzwdFffv0K1QJEaNH3e5?=
 =?us-ascii?Q?3pFDdsAX6ZTevqT78ViI4IhNDAGkUduBpnkUJeHSoxKXxfoFrVyAbN1rFIo7?=
 =?us-ascii?Q?Y06y4FTcad83Xm4jsU+qcOWeCGRt+RaqeAt7Vji5T3a3eQrbta2mCWT6wPIo?=
 =?us-ascii?Q?521oXntjrgujAC9Q0d5ocxSH2HBUqavaIqHiEr5O08YYnFj4eUgc/o79/sWI?=
 =?us-ascii?Q?jYVIxONllyuy7QBcn2fe3omkzfSn7PBnCsOv9i/8unhNTc4Jpvpe+6z8yd9p?=
 =?us-ascii?Q?0fZgp8xQBn+RsBX9SoU/4fto/TB92BGPv/8B//v9xi+exGmP032ZA2p6AALF?=
 =?us-ascii?Q?ssZFmbyl7kwB0PedZPWyqQtR2V87vszhWIAeqPHiyVZCe6hiKLTWhC1y/99T?=
 =?us-ascii?Q?eMRg+F5SdlkRLwkTOXViIQPkYPqHZHRtw/IS3jPauzss8xQv7ujoq3FX8jY9?=
 =?us-ascii?Q?s/aKVe6dgOGV9FncEUZwo4T8s0fGAGIz8/Yjhl13EgoGijEWxqMvNUL5enbb?=
 =?us-ascii?Q?BIMOMjCe5AjIKVAnntUdJckAAb6e2reKHn6Iz2qGwzm+LTHnhtZiV2gjHDoE?=
 =?us-ascii?Q?oxSJarzMgzza9Rhy95o3H27xonk2iyUNsg0z4B3VpJNziHJEmyNRO9TFQEIL?=
 =?us-ascii?Q?4gCYcBr8I5gPEeQo7Ek48HYFX9/KOWI59WZUj/l2ZmFvEHNMFXL/6a7jhtRR?=
 =?us-ascii?Q?T5TVaBRo7MiDVKEQhouUq7Kbw74nnOQD0XRxB61Ho5A2TjQjtfJCNixqRbxM?=
 =?us-ascii?Q?fmf4TUFYJgb8esvWrXJtNCg390nRbZIBOSyjimEmOx+rkTZ8J2QVrWvF75V1?=
 =?us-ascii?Q?zPnkssT5juMl1VSimuZP0TzdFEiLz06e5wE9cC5sXONRfTU7ZLrSSh3u3cW/?=
 =?us-ascii?Q?Gf7Yo4Q67p3OA9eNeAj5UojOZmbrX3cWVv6//96NzOQtUeYZGH/bKAytrp2+?=
 =?us-ascii?Q?MP7bL5nYUj9x8YTZ6/pSqICq8QuKYqJtGBLOtrzSOOzcCMc4NKDxKcjLbuJI?=
 =?us-ascii?Q?672Hwg0/DuG0QB7yoDczdwk8xFqI2ZLO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kE8MZ4ToK3eWAWnrYg0rfdRpDiBY4K1R3CM+R+OkZeayit1errwqqu4YRqCx?=
 =?us-ascii?Q?dB45E7yyY5aGPELlhpRiYyPBP9eu7/3+1blUBFpKJsFYiGnXG5kCauIDPdl0?=
 =?us-ascii?Q?9nvDhjTXDy6MHzBoT//sRBW8c/ZrnL+mc3YMloSN5qXnR5WHBUSQry/LVWLp?=
 =?us-ascii?Q?cFXzKoL/UEfgTAbrcH1aDqvqQvuU7bCIATKP1PEHONf2v8T5/10Fxajbw/ML?=
 =?us-ascii?Q?wBi8t+ba1h+QmjR8hvkBL/RCDRkRC5KqjG/fkeYHGiwSQ5WrCt7HQrTfvIKf?=
 =?us-ascii?Q?QwpejqiT02fsmODPqemgfteJ9nHEV8+OeK93MEfulPTKBdbJpWX96nNKW26u?=
 =?us-ascii?Q?L8BYt2C5opgc8YnA30jn8xbZymmU/gua3mcdSDxrJ5HMfLLIqguKjndCWGhu?=
 =?us-ascii?Q?piG1FEhbWBkDRDh+YhP4sCpYEBaXKcoPzEbywisJJJSwJxLTvoLZJ7xpBLHa?=
 =?us-ascii?Q?nwKnXV1dp+sWpSZVWLPgz5j4gKz05VUToKlvUzV48llvoRBt/2xGtZ5+wo2t?=
 =?us-ascii?Q?Z8AJWLaclIFLK7pu1+AIkfgxnmHEtLJ/LnTPvz5w1F3xm7xes2RPRiYWEV0D?=
 =?us-ascii?Q?HgeFbyMKOuIcmeDRaqpJH0NbkLMXKOlxAJhNobnT0tTSekoKnXz1S/06Q13t?=
 =?us-ascii?Q?gmjLd3J0YM8onmc+KK9NwAxnT6diPA6fwR6H1ZvOeB08dny7/dPSelWQk0wb?=
 =?us-ascii?Q?gI0d2+GCYBdkYFQGFcPBf/1XgQVCzi+qLAxP0z3A2/QqSjo5DGJnsQl/IuP/?=
 =?us-ascii?Q?xzSKehs+RaqxHDcDd5ewhQYcw+TSVe9ucgKfOImBdVow3M5iPUYrryfVWPZh?=
 =?us-ascii?Q?arq7INJJqhfNKFbB/Mt4u1x9kuNqRpfwcJcpjIr/iI3gygUdOk8A5MhXpnzA?=
 =?us-ascii?Q?lW+K+X66DO2KJGrAk2Lv2p8XBNDMhr63cwrFYpLpr7kqFiOzExIGphE6tj68?=
 =?us-ascii?Q?dyssvVbCQo2HhER1EoTBH/+0rgDfG4+3bDldxeagbveInQmdwfu62b2G7Hfw?=
 =?us-ascii?Q?d7Xd4Qo0fB+wPshX2kYdFy7fr7WAcoqcmn6ZdinTLx2/x/F7wvgStiUAE5FR?=
 =?us-ascii?Q?Wpgvap7O0ALtsOySsqEVz1syb1jez9klWyNNLSY1hecGyuAls7gJIosBNoeY?=
 =?us-ascii?Q?dbWJgoldI8T6UIgWqv+1JVjSSa4DPLReiJ+Fon692xvx/OcCvygXNJh1k8yj?=
 =?us-ascii?Q?wph7qEv1xZ99XR+22bzxnFa6hhiqYRCVCAtzuj7dwm4ymPZyVDm6NOSTiGWo?=
 =?us-ascii?Q?64oZ4dV4COgbMRwbuLaucWMC7LfdJBkyyOJ+rRl1tO2BoBcqtRElp1S6EvXN?=
 =?us-ascii?Q?3yUbP1nir17cj9A5zEgkkMdD5VGFH/x195Rk+4wz7kAc861OlRp5XrQOJu2q?=
 =?us-ascii?Q?0lmAjNRNNeqYieFLXo6QAKW5LVKS8EW5z7s6EkGvHkMB2lxWjLG272Q/DdrN?=
 =?us-ascii?Q?KpaXdmCEZjpsGkaXR7ibOfctU/8itHO3jNw0BGMyFAi0BhZ5lUjyMeD2yVMa?=
 =?us-ascii?Q?21ve1jV5Bb4iWR/r14TFXUSbFF0zUVf1GB/I68j5SXClIl3CbH0u7kFw9Xe7?=
 =?us-ascii?Q?oxirpqL6ZwqzUu6r1DhwTT1tZKwFZiWGm44KqE10?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec37612-fa85-4d1c-4cb5-08ddc5e023c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:47:42.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ccdkINco5hUyNIU/NeGSl1j1BYsLe8jvsYqaOtWfCtvNjhexV06lUn5zHdGNzYXiuefie/qYkb60f6oRSm9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

From: Alexander Stein <alexander.stein@ew.tq-group.com>

BBM protocol supports a single power button, supported by driver
imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
using linux,code. Add a reference to this schema and add linux,code as a
supported property.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Resend [1].
I not see a reason that why this patch could block i.MX95 remoteproc support[2].
But to speed up the work, I took Alexander's work and resend it. Hope this
could catch 6.17

[1]https://lore.kernel.org/imx/20250513-whimsical-almond-quoll-e3ad5b@sudeepholla/
[2]https://lore.kernel.org/linux-remoteproc/PAXPR04MB8459A0F330554EB69E990E048850A@PAXPR04MB8459.eurprd04.prod.outlook.com/T/#t

 .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 2bda2e0e1369..7a5a02da2719 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -24,13 +24,19 @@ properties:
         const: 0x80
 
   protocol@81:
-    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
-    unevaluatedProperties: false
+    type: object
+    allOf:
+      - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+      - $ref: /schemas/input/input.yaml#
+    additionalProperties: false
 
     properties:
       reg:
         const: 0x81
 
+      linux,code:
+        default: 116  # KEY_POWER
+
   protocol@82:
     description:
       SCMI CPU Protocol which allows an agent to start or stop a CPU. It is
-- 
2.37.1



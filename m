Return-Path: <linux-kernel+bounces-812657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD1B53B05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84551AA332A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA2136299D;
	Thu, 11 Sep 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SOiFgN7w"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0A35337E;
	Thu, 11 Sep 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614026; cv=fail; b=aHlNUsF19+283Ljb0N89Rleb+puHKK/uIHu+ZRbCeJBhFCKsIsDRwoZWSb3p9PCHgxpoBPZdAawN//An+h8OFob2t+ajKn6qeRlE//x7MiSG51nxpNDXS6Neobqm8V+L2qcHPWoC30sFQEg5PTzz+Yer19BMFZ3fQBkNRUPGi1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614026; c=relaxed/simple;
	bh=euDh0uipkJxbkuCmH/tPIhS5D9G6q7UVK2OXuvdkoBI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C4D5Q3zx+1m0RkNGx0zHBxGnFX7sta2C+o989QgNVcxr/bf1w8w/vrneFRbjtuqSd7KDn/DYJeteqgH0HCwtqu4kt7JDu47KypXageHuOFxjpv5GaMWGeLXMcY9FqL/L4zMGSj9CA7PwgZ4J3eDE4JRubsj6DxeGJqZ8MZ6nPic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SOiFgN7w; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp8OmXMuSxUzAg0pT/T9p2W2DbjRsAerNMTlErsLmx5B7Bvjyqk03FFcubJ5fEm2E90p0hjru/39pCqvYULsfSl29L2dPFfdFXJvQlSfONw2SDCudGUX3lCHVeyBsCClNYuArjDNvGCcwsNsFgd7g10KE25gmDMZ6WtoYcKA4wzEeaWmhA5haFBMfpIB1Uc+kTbV6KdT0co2Cg1VQGb4f9uJpSOYdcQqP2+jYtzRX7ku8mCBaXfb6H5rxpPl1Bv3IJlmSwyjqLTVXCIBQd5aMp/jMlH+NoaAYvLrJB6tub6qkp5SKWt+OeXmxXdvrsVRVO/g8H/5swpxqn09mDL4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3nF0Qm6W30bWSyPciiZ0ew94eZSaRnd966EmIWEoto=;
 b=PAJNipEGr296GaWum4yVAIWhqWXhgv8J/5gEl26Cj0cDxr+XIogZLV4waT8IKEJOua7UEm8vXNROMkn9rVpvlfSSzKQbXBNq5jojCOJH6xxeA8/tN12sD3B2ay2MZBBRjXDq6qkaD00IDY4LiHIoHAyNzVLTLPu6GC+VHz3FV6sB/1rwAASg8407se2AVoAkPWghTyORkEjncHEppryfDf7oKuSMybD8agtG6SrLbhEreRzmbUVtlVZtM3gY4leqA/BtCoecbbgUzVC5Np7BJChYWtY6GMHigzv5JWqgrp/jamSq+o0UdyjS7K6VdVEVpOODEAK7yBUUyVN7//kUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3nF0Qm6W30bWSyPciiZ0ew94eZSaRnd966EmIWEoto=;
 b=SOiFgN7wlelc3tCtsM1cHKJpSwI+D+LTjvQc7KLP7MijlbDKmAH/NkMOYGBodJbnygX0X9RYf5RlDvgw6nFiNVkdYuG3nY2q6SPFzGD6yAkhSF+dNYypzV3mtKXK7FI6Bba9U920XdzrzP8Q5fJ3mISEiD3YwGcQnZ2UTWHn/S2HbbqIbk2SpXybQN9LaN2peM66pj5PjMf0NOqkBe3wNxRDrD2+DQ3b2rype0R4R9X55ruZZWoAeBHElvk8eqUO9CDK3Gp7qJN+W1ldxxEVzQV3GGeji3ZkvqQ0lg3p9ZsSlOQKsBMZDKpkcbySaujR2+6MOzqvUE6fU+YeAE5W0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM0PR04MB7076.eurprd04.prod.outlook.com (2603:10a6:208:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:06:56 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:06:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: auxdisplay: change to unevaluatedProperties
Date: Thu, 11 Sep 2025 14:06:41 -0400
Message-Id: <20250911180641.1031346-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM0PR04MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6c4a2e-d1dc-4c21-7ab8-08ddf15dfe1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4eJRxABz0CDBBCE/JdyX7GS8+XmHu3QQ4S0osrLTj8bEAvrmi0n3wB0BQvZ?=
 =?us-ascii?Q?aAV3SFGd8qFrM42BP/WU4Qg3v8Cyz2oQNI6AcfY4VzZ9BeIr9sFxGjTORQsr?=
 =?us-ascii?Q?1oJcm4hlXAcdxU7k3/t49RtvDZVhg90d3u19/yjybetMdawiJ2hDdR1QqYmE?=
 =?us-ascii?Q?hmB05wIKTIyRUjD4DlCcZH5NPPHmrw1QOJg3WnnmdjWpDyVA7NNUGfdL1hb9?=
 =?us-ascii?Q?MxND58QGIzBTegoI9fBvUgZ1jnjti65fxYQLSjZlC/90kHKzx15jUC56QEFt?=
 =?us-ascii?Q?JvAHHt/JL8D+tc/PLAwfpEpzh+6qJ3yFmbrP7lB1dgonYl6nId2lR2RUuQrn?=
 =?us-ascii?Q?UC6RV3fjd0lEtX57fIqjAP2+fYfRdBkvPuJTmwPNOV1Tj9JxTdIGHkMScoi2?=
 =?us-ascii?Q?eyCyz2TMvqqnnQ5kLhiHdePbHa381DrX6decAfnlLK26I4JNx1shWgUs8/5I?=
 =?us-ascii?Q?pEYdJB9SNa9Lc2C1u8n/ig4TKGt6YtG83zZ4JlwdP9w8mR5KKAI5oPXm7v1I?=
 =?us-ascii?Q?zfiFF2TFsC0gnxPSx0SQbGvGkq3XKEcOf/3ZMuNE9p0UbtT4TV1VL3WI6d5r?=
 =?us-ascii?Q?r1UnzV+phY5ESTwmzAsoIH0VYhz5QoeBhks74tIj5N/y336hDVGrDnqyAThA?=
 =?us-ascii?Q?4uRZMPIxHNcDAzRGNBw2IRgGfF1DxjtrCIEjXvh1ZroDNLkRIc0UY2v82zXa?=
 =?us-ascii?Q?spDMbIWs9uirBJ8w7MC3UAkN5lErSe9ydTvZ05hkDtSfkn4uKMpT3q1sjnHR?=
 =?us-ascii?Q?mpgq21BCBoT3VNiPb9/6U39GO92f7w18CZsvH15/jFzGsORb0z/r/l5me5Wr?=
 =?us-ascii?Q?TdGMHaS54YVTF9fD6rUb+sLwwPH2siiYUy3M2ChFR9jS8tTqxCv66ydj7smF?=
 =?us-ascii?Q?2tZR/siKTcg6EAjjAXte2FEDMEqdqe8QWLpc3/cIKJmzjYRdMudcy5okBaBK?=
 =?us-ascii?Q?WwCfOPShSmFaCVE3VFrhBx8ZQ2sMFHipkEOeo+SK8SXRyvstmHrf2vJA7lRQ?=
 =?us-ascii?Q?6FFvArIdC0tFFG9jddK7qF9cff6Mb4H3yrN29qM//9bQMcQNzAgSkqxLle0y?=
 =?us-ascii?Q?2qXlFg5VrZDc/L2bVams7yCwwDaHUOqdqSpKsWtTXSWGjwHHtVwH0BvdelKb?=
 =?us-ascii?Q?BrE07XWKLBy5vy+4pvoVTDHi0V+4s+yXLx9+UtdPebmomKRTr9Cy6Rs+xD77?=
 =?us-ascii?Q?nGLi+YL75ILg6FOa+4MCv4ko8j5DZB9QU9Z8L29xCVGE9cEC/qI8rHGnJUYg?=
 =?us-ascii?Q?OGSUtc0JeClcgYMCwz4QMVi7EX15hAsZsfjHYbVVR8+1TzLF5pkD+Q3NPMx2?=
 =?us-ascii?Q?Oyg6FShzaVHRvP9j3yunPQ11dfhSmh214ESYz/op7EW2pHNwM6u9ldcyO/ks?=
 =?us-ascii?Q?fzRnZ4VRJfRDvtGRjEhqrWULdfqpKRRaZZULY9f06GN9z0O49Oaqi3C88hR5?=
 =?us-ascii?Q?yfAmldR7qq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2nDd19I9NIbtBoX3jMKTwXRDBAKc6H6mvEhZdZtla4Af0DUFSOyGgrI2ZwV?=
 =?us-ascii?Q?ziwJlM7KV9jDFXxWdx/j8o+uu8o7CCzsOZrFi2SslUmaKgmPTiDl+H5Y6lop?=
 =?us-ascii?Q?pblycOWk8zzTNp1Kp3Kixn2jTTTyIR2KK3GJbulmOcZmV8aGlphGCRQtRbo0?=
 =?us-ascii?Q?/XPOz0cOfMeXOLBhS/GtrlPanQA8tc4J0sthRdN1YQRQVJacHe558lFennoY?=
 =?us-ascii?Q?e3NcZQtDM7o+KZ0v1FnjcSFpIO8GgphpxlNyIH91GzsQYYUGuqcIzaCsGPWD?=
 =?us-ascii?Q?Kp3lmQN6SgVom6Lk+SrK4sF77AdODJAzJ1TY87WgJ+LtVLN4AzyZDU1O8mx/?=
 =?us-ascii?Q?SsNw/MIP2c8MP0LRD9/KN1nsZ9KQk6CzCjFZ/O7poeWbMai/hCPj26LZ/RfC?=
 =?us-ascii?Q?wFfJDfyZLDMUSBZjl2xwedaC3Xet4WNqJZPIpCzNXX5ZYdabVKA3JvEqNDG1?=
 =?us-ascii?Q?HVh4JJuMjGQsvBTJyknowh17SxatNQw4YJlLar3xJQcSW2S2HJTUpf+cTEZc?=
 =?us-ascii?Q?5XDxIqaaGpWJrDbJck5v4wTwt110kWonP3SzqjEc6TMy6h4PNQNJcU+N1JVA?=
 =?us-ascii?Q?qlyinPBp7kvMUJCm7bdPjp8/cLQ19tfYPKGl+EH3mwwZQe4Llaycy0WEYfmV?=
 =?us-ascii?Q?BFArKkDYI3E9Atg+rukqEuUnUt4hHrvglbw1BT6CVwq6UpuETNYz3vdy+/QP?=
 =?us-ascii?Q?MmUfHwgZqnDUgKw1bkqcrYxPjkjtNqVt3PfuJtrCiM6Mjp4gw5GSL9mnMU6v?=
 =?us-ascii?Q?dZJikzoeS9aiyZq/QnsY2699bOHjh7mUvH1wCm1ZuBExn1cjWjqzDoco5bv7?=
 =?us-ascii?Q?R6cMM7q5+WsuStt6G14bEm6OjXIRE2gqGLg6JELsoy3z6JvaI/kJw44PYhar?=
 =?us-ascii?Q?b5YTRTjbYZhSmcShnMhudRvIaH2whR7TOFO2FxP+nab1PWZcb8jaVCi86d6l?=
 =?us-ascii?Q?O9aewFIqZPF3ASTs0z1rbpu+imSByIe/waMjxfxTtUl70UN6F3K/PyTraF/K?=
 =?us-ascii?Q?thWjjV3klZwqDkXxIp0hASwCgm+mc97aM7AK4z4/+BW34D28NKwZFlfaG/66?=
 =?us-ascii?Q?pOASSFOGTOnipwpyMHO36+arlcOOsKADaeFVn2LelKaRRC9Ci/NV8MftsZkc?=
 =?us-ascii?Q?AVBtXKauXioRRXacrKASGufGOsw+/snFXTvUbyQFt5NjlDMbmkaurGTrBNMm?=
 =?us-ascii?Q?M4v5tf2vJeHGbDTGNiP59dGM4Yk2k3YVp0WNtDisXoFr25EvuHBx59bl6DtQ?=
 =?us-ascii?Q?hItaZ5ssg4tuY62wAWcn1WbQEa5ECP3y/RpE7cwT99Osauyevdhp40Xem7IZ?=
 =?us-ascii?Q?0hHVL0CSpUp3mSnUe8j0gUQDmnEDqnTBYv9o/7M9/9G/dHYO2K7A1ebxHhta?=
 =?us-ascii?Q?I0zmBbWX93X5oA+W6UVXaCS6XRaQr7UIm/d14VrH7eBkvFGhR250/CN4yBj1?=
 =?us-ascii?Q?GrY+IAcDBEy0OSbQMy2inclFI20UomfGAT42X6p6KZFap3RoLDHoDrXGMqYo?=
 =?us-ascii?Q?dP2qJusZD0vwCdfZF8XY3DnCahmO64wO5Mv4Dx8iXCDWf6ttixhOZ/xmeA8/?=
 =?us-ascii?Q?wvQ1/OrgyXrw6MUGZBo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6c4a2e-d1dc-4c21-7ab8-08ddf15dfe1c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:06:56.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hes9ViocbYo7hEGeUL/nKI7X6BlXgNCOt0Nv0ABe8G2KoR7e8JhErYlZYpxLwPmH6RkPtawAEYD8rIIbRzqp7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076

Change additionalProperties to unevaluatedProperties because it refs to
/schemas/input/matrix-keymap.yaml.

Fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dtb: keypad@70 (holtek,ht16k33): 'keypad,num-columns', 'keypad,num-rows' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/auxdisplay/holtek,ht16k33.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index b90eec2077b4b..fe1272e86467e 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -66,7 +66,7 @@ then:
   required:
     - refresh-rate-hz
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1



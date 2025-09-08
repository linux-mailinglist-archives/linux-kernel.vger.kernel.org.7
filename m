Return-Path: <linux-kernel+bounces-805063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62771B4839D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB103B93EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B822D780;
	Mon,  8 Sep 2025 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gm2b7T7J"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C022576E;
	Mon,  8 Sep 2025 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309633; cv=fail; b=f6pPvXGWFy0i/LSHkcd8nCcNVoRYnaI7apHjDIAApbTkx0fW98MrXiOsU1PiYWvYOfkVBAQBT1rVGiwD3n1+7UEjKIs47pYnbktMx29u3BFtOkiBlq56GJ1+u5PaBC0MFKC6oTw1224tHFON/FCD2lmvahJBRr6XprJT1DpyO2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309633; c=relaxed/simple;
	bh=liLlv1f6/aTzP3V5Gq9Kn1ZELxT32FiIsQmud+bldLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cd9+Rk0c4n0mlCw96p7Vltp5xOdGFtfhjbszTizI3MfjNo+SceCqwE8ooUEgebJ5YfZij+pc1W3/xPBk/Lcntn3kVP39R6VsWQVz05InQst8fTTmGyJlnWp053N5hBN7W6a1TRfYGm228Qmc56xEGXRihxhPmw3JUni/ut7K+58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gm2b7T7J; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpCg7ceqIjL9jRZI1q0WBizS1XkKVmPtr/UUOZ1d8bfuk1tIVu072G1vZC/HSB4pZsSbx6s6suChygHqv9kml7WmzgVRShYzfpz726sYqYAQHCiU40GeLSt8nxmxWFNjus+XDz7Z9mgME/7W3UnKc4AS9MlNabKVA3TPrpINDjHhHBftqSCMhEJasy7oObuUSRkw9q0/fNF4nNPYwkwmGyc55fPsXXUpYQE7EqF4rFePM0ewfpIurGwkYxt37VdpbRJyZ71rPV5mpbNcRxSXbnSijRockWHobJdoXcGM1ntvASiaouYfXcYwxVXO/Og5+xNtiT4A3aX0vth9f5oiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSArVWgAA9RjH2UNONUaTwmUkq1gpiqclcOEtDKFB5E=;
 b=eTDsaOnXoxno0sYZkKPQCmKpybKpxtMCmPC8MdRucTm44HX9m4CcpfOISo/anZrR0Z0tD70d6L3TGbXRQfBIJ+WpXDHeCpOO/QlqGe5wvpeqmDoyixVksSRizZ0Ron7Nl7Tdgjp1ZobXTWWLIwNEeyyRK4eh8MTitdVIHgyd3BS3mpTXYAmCnj5lZEKeTAzKS8OoIjLysL5cnfyN36Bff585QSNPBa1ja3fHk5hGkjS+i4tu/AGzUnP+VT5ixoOBdCHE/73ivulG6WhDOg+Xe+QhVcdDcVMvnFkhgU94pY+AcrNCfH8ymMM49a5PSSsA07CM5WWaz2VQb6eKHEATVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSArVWgAA9RjH2UNONUaTwmUkq1gpiqclcOEtDKFB5E=;
 b=gm2b7T7JprKFQyTnf5p/Fp6EC40SH8zNT5lOdEGBdReLKAf0mH/mJlIAqVxU+oaEeNth3AFArdpXcQK8bmmB+CJfX40vwzAMP4oXEBtG8dVPMqhajy9662GhPIzZZ1Ulpm2s6C0hl9vKMoqZ3Dj93GP8CSmqVrf0tUWBuSQi3/t8nYSp/tHKA64yJODH+r4xyR3evX2rgbC8LvY/VLbz9DAQ7IplotN5JS9IorMTiXBuAOMX+k8zxk88qPnkbLD2cB9+57K5cYabG/fSuoluK5yzTw6N3AdZU3EF9s2C67UFEfItgE5sHRmgu8xSSLjrWQBNbENEb8BPPVKzP6jlkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 05:33:49 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 05:33:49 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org
Cc: swboyd@chromium.org,
	heikki.krogerus@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [RESEND v4 2/4] dt-bindings: extcon: ptn5150: Allow "connector" node to present
Date: Mon,  8 Sep 2025 13:33:33 +0800
Message-Id: <20250908053335.36685-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053335.36685-1-xu.yang_2@nxp.com>
References: <20250908053335.36685-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f63a672-45d4-4aaa-2230-08ddee99497c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVdqWc4rkmBtGT5iM5wBoeHFDfYr+WEYE7vYQjACGMX/Dm4oswX4hKiOZALS?=
 =?us-ascii?Q?29Ifz+eoFySSCTkK9jBEyrJ9oVjL6SGjEwHcd3zjboWSnHVmTefBBp9yH2pv?=
 =?us-ascii?Q?9LnbhnRo9t5ryim205VgwkrqvqIULqWbzniiydsL92wgPT8DPVdliQ6l8qYK?=
 =?us-ascii?Q?mtl5va68GguTGH2fPhBbUgZUQjg69YnTRrWUVieIKrMVQNlE9bEfzdo4krYo?=
 =?us-ascii?Q?NL5yATil4WrJsg6MgJqp6eeZu7iuwR0yl7tiqtYDhl81eoZ0MUDqRAS2E3DJ?=
 =?us-ascii?Q?r4jH04FuJJt3P2IfuFBkSYvlJp867yTkNJzmoUkUyNILpOwouAUsRGFnhgCL?=
 =?us-ascii?Q?SF+GCIMnma/YWPqSdV2wY1vx0ncAaa8Y36r5Pfp0o96QIj0GP9C2DRvtrWWx?=
 =?us-ascii?Q?ofNic3xTpbe//22fzB2vSZQ5Xc3FB9jxxyg0vD/kqLxReHJUEvtkoqiePcZQ?=
 =?us-ascii?Q?ghaLOzm9EqzWGUN836rYcYIKWZkLqLXswpahP6Lx+pXCoMfSxWnBcIDdSb81?=
 =?us-ascii?Q?cVwbqwj5CIaePPmeNmbDauYuetYWyvpaeskEAll0Z2fTXI3xCioij/mGKPna?=
 =?us-ascii?Q?HMKwICG9VeFWuqezYUc5VYkzQuninRCA/U7RbyTnJzVR3wkAm8kV0JQuWkJd?=
 =?us-ascii?Q?U+2KToMLJcpWMODX4F6WsMYLjuznPCnawzlS/1o1WB+dOUzCk7QgPmR/9gqQ?=
 =?us-ascii?Q?XEZmjYGTaoEUBPfb6NX5KTVYuoVmb9sIq4l1si6zG8ZIr7P1B/IjcB4O4MLi?=
 =?us-ascii?Q?PvdN9XcUeE6lijKr8wkpzY5YWrkxM1lQvqjKqA+W1MS480vYnnj6GeirRdUE?=
 =?us-ascii?Q?SWwVC59Wlb2gIabHF2Zi4Qk9GmodKUwG79iHLAIZW1s6GvEYVHWhjkYaAOER?=
 =?us-ascii?Q?mHT28Ltu+9C9f5ssuusXyT9iCOQgkySDETwsQqbCYHeJmrScZtz7NAFRs9GF?=
 =?us-ascii?Q?xs/8elRU/yx4pbRuWOXHMRwFlvsOCfYZ/HwJubvAOpWJhHZd23syRmSPX7Ge?=
 =?us-ascii?Q?J6M28iH6xNWMT9GCpSJzgHlwwmHpF1RO2ZbrbXBaY88Tu1T7F0+sHfFwD5ao?=
 =?us-ascii?Q?n7rJp7xrBfMa+k1x8a7LZPgGQGq3UzLsigHOxGvN6X8LvDp4g2kBZurscoXz?=
 =?us-ascii?Q?Op+TEG2drB0as+YxYfkh0JB8344x9Gy7nCBDIHbhO5t8d3r2svEId42uLtye?=
 =?us-ascii?Q?M9oGajapZY6B/O4VkdFXJO2kqkDc8j+KFWSJ9yutJpkZA9I5JSGeh/uoD2zx?=
 =?us-ascii?Q?xkQkHrG72pn+srL4zn+hhkpE/+TF6AbTZxH6ZqFTHwgmi+iVywFuBUOHz3sQ?=
 =?us-ascii?Q?cT/nHyWlUeq7xbPyU6OOE/mmHI4hPjSOUOeJZX+cEQwuHbgyZnbMEeB1DqGr?=
 =?us-ascii?Q?UVT3oeenCFj9cCxdkELoAFk+7Cl10ViR5ZjLAiTkJXExnXGCMWb2AfEf+A6X?=
 =?us-ascii?Q?jZd45U81I6OaG4t1F5XFzE9khrsfPvX1D9/OGi6sYjkO0Wba8YlpPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efljMjgmf4lm0ir4Kolvp7zmetOoFZEdFXSxBKFAFjHLvLNK98iFp9qQ7cnF?=
 =?us-ascii?Q?j5d1wBtXcZFTLaVqGIKLW2RnTnWp5ENDxUOTaniKMF5h0eM/hC6GsDDVFj3Z?=
 =?us-ascii?Q?ny9Qo0UGG+JXmDvqPF85lySVXbRWrPa2qDNs8A1GB3pkxu1nu3iOPoOkO14g?=
 =?us-ascii?Q?RCh+Dpd6gxVZSlwlUJu+B0zrevA1OA9PUtt9BNU8nPIR3hfSFgZYcx6d84/X?=
 =?us-ascii?Q?l0yp0y0X+VJXYmQ+Uf9dW99+EHk83NjNvzLXvSOP7ZOiQJkH53tx42nNY0uO?=
 =?us-ascii?Q?yaZqL8fc4fkGxFcx3izAMhax7IuGis2NVF61tqGsIkzc5tZ/NeFV1s5nNUFR?=
 =?us-ascii?Q?6Ko5AvAqV6qmW+ixrkogNEM1JhpKsuCqHbzvL3i4H06rwL6QTdJpUaZl/xW1?=
 =?us-ascii?Q?Dv145g90TokJfNpdb4mAAL5RjE5XaJd922ZCcM0DQENneUIpdLk4PnPcsrAf?=
 =?us-ascii?Q?ur76/SuDLZHkOIeANxJzsN5Yq36K60XFs7jqpL9lMSDUiIzthz33uuNaduiA?=
 =?us-ascii?Q?tYWwIIweYekN3/aM/qEMleIMzBWD0p6y51YBc0tXgfjRO/fU+CBZm4PETIxg?=
 =?us-ascii?Q?InPoMV7s+KuFOV1nEtiy5+jDBkNrW1YjcBmAE6elUTJQaiGhyQKo6+9N1HJp?=
 =?us-ascii?Q?oIMHX+UMOfpTBtxr2uEKjsobra6iLKHPSe2awJtYO4uMTSXu8kBaZITliQ/0?=
 =?us-ascii?Q?GsiYWfFwfXt1fvpnreTpd68AoSkPBQSCBmUsikP6UZ3E6Ki4cY4wzLwikddf?=
 =?us-ascii?Q?nAjhuBModvCSYFPECYDX9nSXYngNhjTltX8F0zRv+3xk/218T2JQcUZeG0W1?=
 =?us-ascii?Q?qZARqEtCQhp8LvgXxuHzdCsleJy1ocasrwHlIGV9nVaGh1tJItfMcbtvsdt3?=
 =?us-ascii?Q?2exSnly62XTC+OeaQlbo7IymUoEpbAFMx5O7k2MoEXF5SAVf6WhnYi8bUPnK?=
 =?us-ascii?Q?fj7BXhhkae6ethNdDPpxlggmFsALXjGjl6WJnWMdvk6SU4I5UBkNfHxEGnNJ?=
 =?us-ascii?Q?s0HC1xQ1QZr1NuVJf67OWnIFFpQr9nMPm11Jc9XCZ5sbqahH5GoDl1z7cMFL?=
 =?us-ascii?Q?xQwPnPCk0qptiE1OTkhNz0+c5SiKnpG+3a15Phs5JA/y+ZG5dyIj+NAfks+e?=
 =?us-ascii?Q?bTWptVUSxxExVkcGE8dFLMftYWFuAfqo+qF8g0GOoDCe1qL2J6zGoUa7i6bs?=
 =?us-ascii?Q?86NpP3NntHa0EhBWFIkArWr39MO2wl2zB8K4Szr+7XOQSUXqfFMfqW4Zf3Aq?=
 =?us-ascii?Q?DFw/h0HH1dRsMGNMu9fxCLDTllPbpaIYtz9+Z70OOcqQMUSiKpOK32lw5FZj?=
 =?us-ascii?Q?3fc66dL4Kmyi5job2hv7PZuIBUdAm4junXC1iZiiv3RRUo/Y+NMw5MPRA+6g?=
 =?us-ascii?Q?K9LlcUSjydkGOI1b1sx/+LPdlSkyjA4qI2/PTKA+vUcHlsqB5H8rzSLKaxZE?=
 =?us-ascii?Q?VgIycj6kIaNjmMdHvUaeffdXm19NDHSlTSmDbRTVWHZzCz7xJ9O7ZfFDBKYF?=
 =?us-ascii?Q?59Cjn4TONfJRE4mhJad1bC2rKSKToFXSeLFEae1MjUryQbLF9elKWogQJ4gd?=
 =?us-ascii?Q?Pxf9LRr9yQNm70O20iw4cMc/Fy5+/uNMtauurv1J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f63a672-45d4-4aaa-2230-08ddee99497c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:33:49.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqiAH8pTJx5bYY40/CztE/xZ59augzU6MFxNahWg4C/JTfQgmuLKmpNDXhNL/pi+FWokysuBwqMgDXPALpEvHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

PTN5150 is usually used with a Type-C connector, so allow a "connector"
node to be defined under it.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - no changes
Changes in v3:
 - add Acked-by tag
Changes in v2:
 - improve commit message
---
 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index 072b3c0c5fd0..79f88b5f4e5c 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -42,6 +42,9 @@ properties:
     description:
       A port node to link the usb controller for the dual role switch.
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
 required:
   - compatible
   - interrupts
-- 
2.34.1



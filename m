Return-Path: <linux-kernel+bounces-848507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DAEBCDEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A85427B23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B442FBDFA;
	Fri, 10 Oct 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JRkJFS74"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7184266595;
	Fri, 10 Oct 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112223; cv=fail; b=uODXYN38of1idxZizF3XySy0EAC9OytOQXUxiUnoGoHBzcFLgULvoAhqhXeLOAZ+3YaBevlNe/q/v0vXTvSlziqFVS2NrdSyxfPk7PKCqblIbKGraXdniPBPDCjhNEc1w3xKgfBLpF037quwnXGFfetn0WHBCXpi77+TJew1Isk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112223; c=relaxed/simple;
	bh=Zm88Ty5CbHpzb2JM7Ib0ENYCtclitV2B4HlCaNBQQmg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uuJYlyW4bljACJ1AVkZCcNLgZXiGVXM5zhmb+DTBh9SIIfr6tO1m96iAKBdaaaf/IUeigjZLYQKtKyubZrlM8fBVN461ocyOV4cEAkL/06+46a5YvRPRtFA6s4wR8UUzYarwQqIwoSCwtoB0JEaRCpveBDNwbc4Y63kBsxzYQLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JRkJFS74; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm3fkwl3/np1K/1JSxBER4A+lxp0Wqc58sqa10ob9w2KuOjjRvaFZeyRVc/4zZZ/Cx7bjSGVGlm2xJI8DXhLud6XMLH6R7H7cilX+7m9SSFDFRQfa7Hk/77wOZKQiVYbnmO/furxLK+f8IMgZq2dj22FoL2O9oLTvzbtF0anwxLa6hl4K17RBTo9w4e8SC0fiyWzRUs7sdQery+9qIbSyajVJZo/v1ChBvjQZIvaRMmUq/qZprWPap0vJbP2SENCAhJ3dQRkj70L8q0y0sqH4m+FLPeu7oHston9X5eA6haRZYE37K/dtR8CfJRIEAtghweQj73CIN8YC5RNKtBMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCxS5GH35S/qW9aHcYI2I42Z75qI0kMHaiyWyiUt6mk=;
 b=eNPaEMHld4ZIummShAeAfzvc4ai1uBRNcjxIRjNtWATUbXq5oQwo9649MNa1yEeXuVhsnLgRIL0HjC4WINmsYPmRs4YTqRGBDa0JCJFiwdH77Qyvtzhf935m1x49q9eMcYeGjxTHm4ZZLS+8ufTvIuUq0paLRsFkZTJxEeRgevmnYxJ3zolhcM+Nj3EirAvMNWDebSrSywDqz6GNAeRlmGfpbUM9fyI6jpDHqC7E8cPQe0ZIx7bqPOy4PlL28pXv/UXD3N8bdI/88AlBQIdTSbkndy9Yi5w2VvRRnn+Ypsmk+38c58Frx7TI5YC5JGCUg7QGKGLoBKdpoc3XMj0vmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCxS5GH35S/qW9aHcYI2I42Z75qI0kMHaiyWyiUt6mk=;
 b=JRkJFS74syEdKckIRY3hiXXvkMdYpouy3HP/k2jcTKL2Kar3bdIN9jCzYXub3zNUlP2yCaKxjsRkcug5eqXYabgC1uyJq5mtTAqzRJUS7C5UdYjNNXrbcAOZC6AVrVfkIEldU1ziUQ+vBPTWTYWdPjUMYc1Py4mEQXUopeihnnHGf1FpzM7FDswSCugdETzkE3rD1V6oEhmUae/fASkQV9SPkEois6lU/yZO5hE0dRbPSuStePSquEibeSg7N6eDob5GgyRiM92nXVnajEwB9M3DUeUt3WAAjm0E7028PTJxvyE9VUhcLgO8y3LPxJRZd5uG4qqLDXuGPbSMLJw7PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB9990.eurprd04.prod.outlook.com (2603:10a6:10:4ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:03:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 16:03:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] ASoC: dt-bindings: Add compatible string fsl,imx-audio-tlv320
Date: Fri, 10 Oct 2025 12:03:20 -0400
Message-Id: <20251010160321.2130093-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e686f19-343d-4ef6-5964-08de08169310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CMpXyxY8/CmmNtGa719kNvcNbvKz7n+sTIZ3ayjyKqI89kYbKTXFJsfPQD+7?=
 =?us-ascii?Q?IKpWZqnZ2NGknFBpyu8BFCbRbSpvVFJsBUSfAq76PrmjhlTdBkEAx5AP36nv?=
 =?us-ascii?Q?Z6y+jGvBGTs3jLHVfY/d/pXeE/9q29qg0juG1lYMybeP6C2mtM7zsEGUWYC4?=
 =?us-ascii?Q?Z+IQMeKP7/ILQTZeCNL+9Y88VYEmkk8KYqSPHOy+HlGAQOa/BTjRabPPYen8?=
 =?us-ascii?Q?uR68JKUCJvIbWEjo5ogEEXWMYy/t2tXEyf8zEkCAr/8EudOIGqbfyBGDQXmb?=
 =?us-ascii?Q?YFjRqqF6JxLTODJAcuSVDF/AItOx5WDu5hYdzctVIHnTfEx9cv/Sq1P0z7fX?=
 =?us-ascii?Q?6YHFULqcTnobI6jqUFtAEJfcmzyOWnRWETONq7yppgC53hX97CbrjhYq9+iW?=
 =?us-ascii?Q?cibbK6nOFS7F2Mxzm0AqlqHTMVoV5hq0PKtnVzpX/njz8VSPbWjDIO4hLTdE?=
 =?us-ascii?Q?IO6Gv5ER/0n6MO3fnKyRyOzjuXV/8tYFiMiMuPHNMbRJX/JT9pRr6GxLMG/t?=
 =?us-ascii?Q?gUULJrL1N9DGKspD8eFgZ72gDupYEQJ1Uroj/If/dm2m3cDQeJFJVPTCv/O9?=
 =?us-ascii?Q?Tf5OoCf5uNCHuncyHezm5yREVduP2vcRcbDPjT/VbKhRsfu8JDqrWyEzWUtR?=
 =?us-ascii?Q?8RXo3HKN+IPDIsOouP1fhI9bbMCEmVyC3YvvVzwIkCDDVA6OMpZn7LpTKia3?=
 =?us-ascii?Q?SkejzrZ43cxLGynCDXGkdLkBDNGjwr5BNkTCONG2oXCKSrRHbI2uOg3gThpy?=
 =?us-ascii?Q?dhLilU/KraEGcYmVO9CPSZ+k1MvB+2dVXQrazPxW8laOxmWw1iOULKBbGS04?=
 =?us-ascii?Q?+daXItoXVNg6LZt0abRtp6LXAD9e/QzZdxQB2nJZhhtHDvmVqROzCjOwITwH?=
 =?us-ascii?Q?Kx6dmXkbkyM7PK7Oi+DBFLEUSWAq2SYG/MeRY4OpFkrgHStZI5hw7pXkgmSy?=
 =?us-ascii?Q?0/2hg+B9PwkPF6357mhVYY1czS0qrq/ZIbwLSoElgxqj2yDlJBrobxI0CYQa?=
 =?us-ascii?Q?6PkLZa06+de8JGumV4DFJ2Bpf3Nwvu3/w5AW4dz5HtWe6BQ10xPDQnNc7Aku?=
 =?us-ascii?Q?f49I9KAoZ85UmAwYCn+M9jYfJZfNNIPmrIIE7U0g61afdJwxxfjcXGyXiT6O?=
 =?us-ascii?Q?Y1sHcUYE26MCfcczg8JpkVj8QAFijj8Q4VvNp2/kY79m5CKkJ1O0kn+vv7WX?=
 =?us-ascii?Q?+3rKQgRMsjHyt2i1qLjOfxiUdDextToNTEyIlJqIVtbAnTIO9qXZb4eDb0K1?=
 =?us-ascii?Q?I5GH9IMWA+vMwp1DtnhhIRV/3ueGOYrhVTE83hrnK4vYoLsPETYJ6/N9J3s0?=
 =?us-ascii?Q?xXlFieiGvUBv31I+QdfgMfyi0eLiFLGNdDqomlEqaNWqaxf/10PrrMyuJvKt?=
 =?us-ascii?Q?tjzDZh3atNaeFP6+9MxioZ/kj0Wfyf080nHFTOENwEc645bVCqQgUOB25NVD?=
 =?us-ascii?Q?DbVAotQDIi5Uzl+owLtIlM8BuFnTDx4bSoO9KupZ0Ri7n4OW+RMdsnE8nkbL?=
 =?us-ascii?Q?a8aYy09QaeqmbZTJjtWCSJNa6ewifCx2P2Ok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WMsP6pxle7TDw+LYF4juLjz2WXalx8CVN5kFRL+3OYyCML8t6yQ6MXsGieAf?=
 =?us-ascii?Q?icz2GYwjBgtWP3Dn2TAfUOTr66qCa9F/Iv6xFk7MzakMqKh++hknRByDlszy?=
 =?us-ascii?Q?ED9NTvsMPvUv/22402VaszvRG13OllcdUv8P5kccyRU6fpokYyeOM9/2GZSv?=
 =?us-ascii?Q?MlerV3c4Kk7zB23HsQu7Z4pZe8C2uP/DljGxNu+nzZ1UzeogqROXCiyMOt8+?=
 =?us-ascii?Q?wrH919byYMiX8UGri9LufFkqVjFxk7kkk7NQCWRtkjddauxSXBNPTkXRkiIj?=
 =?us-ascii?Q?9s7nZwZYXHGRUPtbsxJ2HfNpJVm2CQf4P62Iu9O/WaltQqmq0k23n8M1DVFI?=
 =?us-ascii?Q?JqMZWQfH+CHRoT1Pnr19xXcyppFpY8UxqGqlrpQY0blUO9N/Mbf/TAFSO61J?=
 =?us-ascii?Q?TuHVyD4jaoL03dfxTxPc6QJZI/6Ky4hJ2pHSepnNaCtI7WLlxkQbocGlmYSc?=
 =?us-ascii?Q?AExM9QgA2DswEU/5n2IKb100dIPC5VEyY86Nvcv9WXWs0iVvWfv3/IYVf04U?=
 =?us-ascii?Q?EC8FGOkvoGNxzADoChYGYqrQfipBtX35gPR5/jImWGc/gyqMz88zq3z1/q1p?=
 =?us-ascii?Q?yz667mWvRTX9JK95CLhhqtQR5tn3Ge3DDt2KUnkVNMXwSW3PdF7jzRaTWJWt?=
 =?us-ascii?Q?O0jJBVS/MNfcsGh7HE+pWdYREjUmcIpcYFl6pEP5Zn5KFj8Zt8LQVKr+sUe1?=
 =?us-ascii?Q?4YvuMO5D0FMpCajnH4SHUwFI1zEV9TB2gok1qbaQ5OXF3Hd5+U6gGQTstW7d?=
 =?us-ascii?Q?/qBReFxogqF4l/FvtYNIjaby7kgwJ0blyoJpRCtSTjAf3TMjx0eLgtPZ/yrB?=
 =?us-ascii?Q?gtTnTJ65jSIcsALwT/bDN1lTYEt6YzIs5Z4V1sETOeDWcHeLSP9PBxCUkxZI?=
 =?us-ascii?Q?62ehqwO4lwkYT2L7LQSXDPLxqM3NH8lE1bkwjB4AuvLhOcaZxteh9pF47VmN?=
 =?us-ascii?Q?esHLD2Tilj+Ue1g88Oj3CesBX3DVPDq/j1xHSGJBQ6A3EjueprskIeKOT4t4?=
 =?us-ascii?Q?C+IQ3aUiciFPbELd5Z7gmmpd8iQXVEmbXMWV84db9lVzd2pTKuOtKBBwRYr+?=
 =?us-ascii?Q?A6+ufsncvoV1nP2EAHXz26RwdJ5f2cX0R9MDjYQoaU4WEpKvYxPltpUr2xDT?=
 =?us-ascii?Q?7Sfm3X1NbnszMlbUfnFlrcLQie2MZ8syfbPAY55WThmy1ZCsR+1bCDl+drWv?=
 =?us-ascii?Q?w0QGG4PGLvGzl/FJ+P/pa6R4utSkEQi+3LbZ5iG2yWHO27Wyukts9eyohv6q?=
 =?us-ascii?Q?70UbxexSdIKhq3Xo+9x4CC2ljJimPHNQ9ayydyuvF7EwDBkpmsE9JNxNUsxI?=
 =?us-ascii?Q?Vw7T672bNt/Wh29lY4khYcq4/5LB9DRxE2AKoCZrML2ZMUszRnsr6lqL/96b?=
 =?us-ascii?Q?DEEzsCPWz9V540i/PRVLxaN38DcDe10Vj4O33IPysoxAY0ejw+qcQOIGdZrs?=
 =?us-ascii?Q?Pv6INqwnbQ3TiYGEhf4IWD4Jjweyz2b4xRmRf6DikbLAFlUtSiLEegueABm4?=
 =?us-ascii?Q?lbS8sncTPvBy8rRTo9/DeRYzQJtQ1Rfuu9nd4XMehcYCu9NK+mqGJaHrpQW+?=
 =?us-ascii?Q?rfORUwCyDMYLJ1zyL//50CnB5aSJ1sxNT9feto+M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e686f19-343d-4ef6-5964-08de08169310
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:03:38.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XCFPjeUSzJN7CDajJncn/B9no13XDlas5JN9bXzlXpm6Du66mGH/IyPolpFFnltTKTGrjDvGxeZQAk4xYayyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9990

Add compatible string fsl,imx-audio-tlv320 to fix below CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dtb: /sound: failed to match any schema with compatible: ['fsl,imx-audio-tlv320']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
index 92aa47ec72c7b..88eb20bb008fa 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
@@ -79,6 +79,7 @@ properties:
               - fsl,imx-audio-nau8822
               - fsl,imx-audio-sgtl5000
               - fsl,imx-audio-si476x
+              - fsl,imx-audio-tlv320
               - fsl,imx-audio-tlv320aic31xx
               - fsl,imx-audio-tlv320aic32x4
               - fsl,imx-audio-wm8524
-- 
2.34.1



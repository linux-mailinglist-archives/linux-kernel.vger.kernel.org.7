Return-Path: <linux-kernel+bounces-833536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7ABA2413
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F14A1C226BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA91FDE19;
	Fri, 26 Sep 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F3/pn71P"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7A1C3C08;
	Fri, 26 Sep 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855197; cv=fail; b=oiduTVY4U2g3kjisYDxhmvdoZyKRF5+k+It7Hc4Jnr2ESvmHwvCAsf5rSY/hLPZbiaIy5wXLHhfG4QGjh1QancjCEy4vhZjj8izlrww66FSx5jIQHUcIy/axzTXfYpcY/FXWejg8Po8pcqq26+YjLhjjYJ9iEW3t7AbMz/DD+Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855197; c=relaxed/simple;
	bh=Ev5EqzHyVW/88f7rOSdC3vfgqGCmxMuTFngP5gEMxkE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EVCto/g5CgvqVpwfIrxmLbKd3RKVvpYK7Jv/YFSSyR0eOhbnDHrcrFRmjF0ESnXE9tuFdtrWJGYIF5LTpb9GmiuXECPC6ATlG7V5Y2m15zldBqrQqkinODs5ztK7i7C9YR1VxbDUgoU4+3m3sbo52JfjB0qUEEk9vrh+TZYzAKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F3/pn71P; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VonB2qqKdZCRW3bdY8czepZvxQGI1/PO3ZAQzdbF/Fql2Fe9amdq4e7DUkwu4kgj2HPw4fVt8hnjavVviSToJeBkTuQtKfAJjANL+fG6ceI5pwWegrf43F9m8CdXiNmgDEIMiKWTKzEwEu5TamLhXOKT+poB+s4nRiPHK/mMGgPZsPcBOEszjbQpopra77D6qLLb/tA+bxMUnCwr1VxAH/3TSYidnoNwocWW8y3/9XhnTCtRhMIXajG8eqH9VNYieCTv6Kc9M4BjTdQbp01yWqdTfbLseKdQi1es6/0mPqMjJwHAMNxbmumuBFnV6cTnNpLu/Ov3mdRa9pM2cXkblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5eb2R9vz7YbJUtb8F5LBAbJe7KlpbN6zgs7Fc8udT0=;
 b=TM90UvgRb3d1FZNSmvlAqt8QWULjwhhVUQd7Rjulp1PmRbAq21mU6/5GWr3wrvS7Q6Tf3IVJRLmtELR4wnj9HXZHsg+IucFhfU7peAugWW/GGFPCN+QcpvIZhjPXUYo0QSLIaHuixgrLlsEPc8aCWO0uQMbsMduCqz/fksJMj1efosk9CPhEheEA4Vtwzyc1qCdXC5G3MOxuX1FZ7u9Tp/Ip7F+rZhyy0/G8wB/AMCOCKw6w+eZleZcbIqS49bKSnw+4ezNblpbhwwIHBpULSXeNoV+uoWaCf5yxYffkg84aiD1T9VT0ruZfEBknUuaAJuM7Eo0kxt1/yetxusufYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5eb2R9vz7YbJUtb8F5LBAbJe7KlpbN6zgs7Fc8udT0=;
 b=F3/pn71P3SDrNo9LOdRnT9uOz1DNpPz+lbhQh06T2TUpFdotby17qj70IKasEQ1isJ4uqYB6/NDaWKDqED+RbkJBDIxyZdpE1lnP8NoCQzQ3pHTKSoBosDAv9gF8tOh9Mc/3bLB+aDJdabrlMOqR2rqaidtVdZ/3ulX32ximD5BSd9xHVz6zbzLY/qTqPSotRl81j9s7UL9LndCi+ulmj7RB7UhttDRZefUiYmg9Ij+f6PqbKL5jhw3yhofdzf/dvvgI6qBQb5t8fXQiKOPRSN008YnFJab5I3nGeGLNsakUp9YIYuZdEYVwB1F61BXXb32bHfcueYYCqSSd+hnr4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:53:12 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 02:53:12 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: extcon: ptn5150: Allow "connector" node to present
Date: Fri, 26 Sep 2025 10:53:07 +0800
Message-Id: <20250926025309.24267-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2589daa5-4102-4ad3-4a06-08ddfca7d531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XImn53vrK8v0YMQ1pl9qLWzCmAG3WZ9TmF1i1xBQgEOQdtcAInIjvur4AM6?=
 =?us-ascii?Q?kDDgdgoXTI5qaraxXOqB6P2L+f/LrAcCtOOouZ0a5vEx9Cr5h40nE/bmatdi?=
 =?us-ascii?Q?hg1wu+oDAlMtC4bytsB0t67Yrj/Oml7H+5j5XpfbDAp96x7VUTG4tncVdKoi?=
 =?us-ascii?Q?Kh3XbGUPsY934xff56WqGzyGp3fFk0DiPg6BT5UuRE2ntBnxra4jXeIjY7BH?=
 =?us-ascii?Q?Y+PWhtrvS8SCi9KYlBfhrYPdpdq27xk8H1uLOacWAoBWr2Rb29TqNoNcdmQk?=
 =?us-ascii?Q?tZYaMfkUL6AeLNz8fX+MBzJuQwSEzziAI+inMMN06RXws5KChL2Y7KNc8+ch?=
 =?us-ascii?Q?dLSizq4VM4CZ3fT7X+nKi2oiRu8RNrBvlIiGPrhTApXzl+PIFRrvcD6lMNbQ?=
 =?us-ascii?Q?+3HKGhSdgr3JuX/hUxTh1XowEhI3z4PqJReWNRR+65Ra0rxHBp3e0tJqogym?=
 =?us-ascii?Q?LSfG/yaReJmZwdXwipap6z6xMD02PoqSfbDlV7pbXWuJPeSe1P75wB1VNRN1?=
 =?us-ascii?Q?8MELNn5T1cqbBiNkoJeZzgtzacXHPmh834nT9s2OjQSpHptuekYc72Xm+O6W?=
 =?us-ascii?Q?zZIeDa6OQhBaR0vbBxGtp/zCTR+g1NjMUdsSl7GbWMVksQUnO+2JdtJfgJeq?=
 =?us-ascii?Q?j/C+7O4DW1TJaj1zxtcE7q5pnK77N4mCxZt8pci7Z0H+nUXaZln+/xwPvd/f?=
 =?us-ascii?Q?hUFsZNA0SgI2UUsAWau1F5HCUkQbSZLbZ0UWFMrI4jl/oe7hnuqM7xA7ELL1?=
 =?us-ascii?Q?XC20Y6qUqcUXSQxZTJkZCv0wcMCV9ojq6VfjuLqFad8CoxXTtuD2ePSH6WWz?=
 =?us-ascii?Q?OAGjfMVpJNJCSb5fA9x1FInZ/20AocS1F5/vQuFQjjbV36o+puwSDAfNrmo7?=
 =?us-ascii?Q?+3gm2fpmXqiwSRVpPKoSmOiaNlBsNXwqc7Aon4UZAj0uNwG1qTrML4KQr8yK?=
 =?us-ascii?Q?Q4muu80sAL/R3gF2EQYdF0qBudr7a0aNl7e+TVkwLiKuPGeEVEn4L3QoAGHS?=
 =?us-ascii?Q?MSM5/7G6V4s6QnZ9k9qojTOFP+ctKrts0Dxh63xVTLIxyYPMhDlp1GJRT9ye?=
 =?us-ascii?Q?TPzZjDrARQT0oIrG7hVR5R/kBmoJ9n26N1CWtrlU55UnZPU+xwY8pvsJNFll?=
 =?us-ascii?Q?hYZnmOsL/iXVId5g8hHNIxCSfFYWhu92+oCYta2Ue6SH+l4eV5c1SbZdJO9n?=
 =?us-ascii?Q?+SlQpxrO5yIrmB3GdAI3sUNIN/SP3O8jNlNl6yjyNYYyvN9l5dQIuflG5oKQ?=
 =?us-ascii?Q?Xoqugk5pwcP5Lg5HBqoyrojOD3inpkTYMK7dzGRpFNFn74hQ5LSvtu5U7gxJ?=
 =?us-ascii?Q?SgJjr0Xh/0wJt+tWq+VhNq1xRAP6TgzDSODLJr9cwvpdpTCAzFl+57HECeUX?=
 =?us-ascii?Q?SqUbaMwZOVk+19OtQmk5pa4ZrZZAGc2gd4T7H0mAIg8IJ6m49ey2jw8qvurt?=
 =?us-ascii?Q?zhWLvkiFzzyNvMYFHQVfXVsiT+P9dvQSxRA2/8nSoOhscChsctCZklWcCqLe?=
 =?us-ascii?Q?7GDxbXFYuvKKo4cCwIxzdSqozIqDVo4GofNL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWitWhqk3wdqrAqqwHNO0GmW7AzVsYfcDAdsToYo91WE1esGc7/e1pcY0THz?=
 =?us-ascii?Q?k6h3MHaZgz1OkirRWcluCxG9Hrw31JrYampvOxhXGEdX8Ny327KGiejhPklb?=
 =?us-ascii?Q?5zVCGOGMbuMKKse+7e9Sk6uHcAZErV8fFLqBrG1cI/8L9xzeskCrxqcTnJIL?=
 =?us-ascii?Q?yNOq8jgLvK5UCzpgTmagAMfbw7xzz+h7CN/6RqRMSi4nBnaU2BeDVDEpMp3F?=
 =?us-ascii?Q?6NzLV8nJphl/niDHqwv6X0TO8kAits3yilymbF6LGxNpaYvgLf2zB30JDAD4?=
 =?us-ascii?Q?LieRA/yuM2oMln2KoftmWT4rd+dg72490VrJGq17zyamdKNKfZVBKj1Jp14w?=
 =?us-ascii?Q?aH316bNUszgaY4opNHlHHeYH/Yu99tC+vrqe7OgbVaqjxEUuCDFMUEQNEzNg?=
 =?us-ascii?Q?TRTeDRF+iojwVxmfBwo0IWiGKbwM139lbO89ccjoieiOa/I4uWOZobrTnaYs?=
 =?us-ascii?Q?0GTQhN0EsAOrsSHXhNGv00sAOuCiwzcqfTye6R5daOPCbLNy8ZK623KtxvX5?=
 =?us-ascii?Q?He7imrWSv71vV4+FjL8/HYGtlij4C7mJkMSRAhPK9AuPCh28i4D6CGd4/16Z?=
 =?us-ascii?Q?QrGBEHl7yjPxAVDwr148Wl3A3RFh1KdktjUHT5r+sf85VIwQoYJnefJe9NJQ?=
 =?us-ascii?Q?hecoRU03g+SBk8A3qSD/WXaiyz8JcazYxey1sIe8wk/YDHvrEsMCcwG1r/Vn?=
 =?us-ascii?Q?cK+HGstxeLF3gFzuH9iSTZzdxPOMHpdf6dR9kaXrat/EIbgxXN+A9H0tZ8wc?=
 =?us-ascii?Q?1mwK+Uupu8aUL7JhB9gOKsJWYeyu23JHyJAyAIA3PeygmxKDZvtOW1qqTns6?=
 =?us-ascii?Q?0P/Sy+9am/UdR/yQsjc1wl+7eZTWZZroK2hVw6FRdu+TDeq8ypprWh2V7HdP?=
 =?us-ascii?Q?P/jO/8eU7SCb+xOFEYq5cZEwfELxg/D3W1Eiv25tLuIcaybBg2frh2II7h7W?=
 =?us-ascii?Q?2u2iOyiR7aaGON5/4JoDoRyxLHWHwDRbbfYy9uHPQvd8MB8jlyHtCylOOREC?=
 =?us-ascii?Q?UuGVx8/4gAoYPOwVJHOe87I3MTpg+6dObAd8vQk1Eox9d4PFcFG7kcmSVBIm?=
 =?us-ascii?Q?Oj2KWrYBBRRT9dKu76Gq0RaHHfksGw46/fV+igOX6At+LIzdCmVKU7WKOxWv?=
 =?us-ascii?Q?YdfaLgHOHOfZdQJrVSedJYqjRuiSEXUSqGLnlVboGnnPrjSsRknQmrUFWXpX?=
 =?us-ascii?Q?C3hj1K3Lnom2396/AhCgEOurT5PZOFOoZtV//bIJK4WgqL9OlODvvhXNGVpK?=
 =?us-ascii?Q?WYnhkQgCB5VVlI5JDDmhPMIN4gB5QQKtCkITkqq3Oq/hvjjc0HhlqttEMQZ3?=
 =?us-ascii?Q?9vEIeKNBa5jKFc7UPvKYVRKezLyZisjK6cfhkauRtBdf4Mr9AxqLQTIRJ1VJ?=
 =?us-ascii?Q?eSNYOXyYXeijoQnTKzEa3l1A277awNPTqu/AQjp9ARyRVAa9fY3XOQYKpsMa?=
 =?us-ascii?Q?Z81iouTqinj2bDSVXNpeufM/y1UrFz3ZJiUO2GKu/byMmPBagTWLtzkoHZ8d?=
 =?us-ascii?Q?V2PCg+BOHMVcsf/bnYR2DdMiY8wrw9EGUgyCRCWMAUeQsLhDoOzkU55G5EjI?=
 =?us-ascii?Q?B5wN3v6LwPXhehGiIgtWrJkrrtNRxKox0tns+iEs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2589daa5-4102-4ad3-4a06-08ddfca7d531
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:53:12.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr7Y0WSIBgMh9TC3gSQ/DNFWtuSv0yqzKMqDHKv0drCkX4GASYBNbegc2IyiACh+p8sLHMMxMyDuQ/xKGBqfig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

PTN5150 is usually used with a Type-C connector, so allow a "connector"
node to be defined under it.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - add Acked-by tag
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



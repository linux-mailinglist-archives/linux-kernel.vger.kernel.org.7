Return-Path: <linux-kernel+bounces-798516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96606B41F19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EDE5651C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C882FE586;
	Wed,  3 Sep 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D4Uumf9/"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3292FE56B;
	Wed,  3 Sep 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902860; cv=fail; b=TR9hJogZnEKrfjI+2gkXPXUC7sc860MfSN70vlAkqWR3PIQ1riWpLE6xg9mbmYf5ReWotJlfMNphsOnMGGZzN+L0mZAKlbwFKRfiFsVAR/IL1LzMx2R+weai5A6zqiIOw4T97OjVXm3WwRe2LzGmWR0ZNmobe9KJ7+kipNdAQ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902860; c=relaxed/simple;
	bh=KfGqWxTUnDuWaWzZIZdXqL3ttOsnHfQh4DY3apDYQyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyGmONPCI3uJb6TuWZn8BEF3dR1JZKt8rQXGQhK7/5nYU7uPUKVN7VqJiZCYivRDLRNpXeuHki439YLnU5Son/2i6WuWuwZiDjy/VFN0Gfi5yR92F1Y1hiQ1IAI4VLVU3YTdUf1dHl1Sg/CVu2Kp4ZS2QEXs3jIeR7pMOlu4f34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=D4Uumf9/; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ0/Mw8zcRhgVUmIokYXx9Jb93s7lpqinQKcSgCJOdHcgSRg/p6wFxFqrCmORVlrbCH+c27J1Wldp0H0V83tN8/4GiXnrofiWRr1qEyWEXMo2Ez3eZ1pcgfQK0dVbByvhlB30Hzm42v9c2nqXHjxsMFfKHbh0B6uEGI2Nm/zg4eVMYNmpF9AiXWz/6FSvISWQVe2MVcy9jRMd/UEAdUpG2KsDVFYmnpc+lppZ/fJ8sGofvQLwU9Au5YNgTLpz5wukvzaUc20Wb8Dqet6QGk9KEboWDkiEMWtg8QsOox0yRNkNRr/tggPS8jN08lAUYhto9v76UbykRScyZEjlhgYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA9zkKdHgTb6Ev8Gys77iOI3pUNdkdBVMd8BP3h6hK4=;
 b=qBq3FjjpvrtzWMS3nt0pvf+0SoOGdbUpycKGU49/HFFcBX2IAZgKBnJqmztYA2wFHuKaqZXwGH3ntXwTf3CZE7unwuKy9PFSEvD3dyL8u0U2u6F0Qy/+RL74znjsnRmCwhi/6YAnW8ZyKcn0L/w+hNVM8m+tE2wuxWgSMPoGtdcQ/3LOzhHvVXrVQrg0p7QQzFKdQGZqSpDHdnyaJxBtm4kHQP9gH6i7ACz3s3jHgPzlOpJg/OpKxz++pgOC8x8EY1sTC7inf9P6uQByUlaxGIa91VHcv06AI9r7zr0O8CwVivLwn2C5bDggiUKibGZQSBa4i1u+wpo0/qPIbslPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA9zkKdHgTb6Ev8Gys77iOI3pUNdkdBVMd8BP3h6hK4=;
 b=D4Uumf9/4/ZWfZK9F6QgEGmE1TdL4YiUAFtIFQJEBnH7XrEzV08K/HyMTVVrr0p3fW8uVuEI/DJzLlTvo1Zi3NyBrWyiw/S7Vi2nv2EPHip3fzdxPqEPyaLdxE65zBtIvIKBPyuxSjgEp/C5em/VW/OhOhHNDC39wO6sMiWT3DnD2zH8VMee2rdoE4jf7G2Rrg8RQioLR5r4a7QzENBbEHybeS8fd1ACVvQct1VCwygfIVBsR3G5Y8iLTHzCI5p2V0cpfv9W2VlHzQUMFU0V7sPf+eAMESdGUDEUu8SZk3hYfagHmB+wssVvV1y1TFPMjkeeFi8G77o8Kj259w8obg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:13 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 12:34:13 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb child node
Date: Wed,  3 Sep 2025 15:33:24 +0300
Message-Id: <20250903123332.2569241-7-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::8) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 114f07f6-d52a-4749-7b48-08ddeae62fc6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yMSISmCktJVs3C4UoHjh3A30UiRv0KSuDj9hjlIjpa8iIMSnfrpP55GEQ+V1?=
 =?us-ascii?Q?BkdXl0sgu/0pL7VW0C78wTnEksTW/8JY2x9SQ5d/bZTXEsRqmABmetWpRikz?=
 =?us-ascii?Q?VmF8Vm9h5mKRrlvnaGPdNjFKnzrh1NtiuH1UInNLXCH3SkQnThfku9GTPjIk?=
 =?us-ascii?Q?5ltl3NemLx6EIplJ2UQO4cY157gB/HVrQoxsdoJsDkeiyS5UhYxMQEFtrcpU?=
 =?us-ascii?Q?syN0yIJpQRtADaR/OJTF0AdI1XuIEp8T+eWO3jvgvSt5cqWUfKlrF401Xe0O?=
 =?us-ascii?Q?5VbmcT6oB9JFwrfqIxGct8btLZzbsTdxeoJOoSd6P8FV45zJCA2Ug2+MduDn?=
 =?us-ascii?Q?1jdoTXRp1y5Mpd8q/XguM1/T8RP1V7tNNf5/BnZprnJGb+TRFQ5xH0WyyywZ?=
 =?us-ascii?Q?UV1GaHTDcetruYRllZkcu5KzdDfzp/tze2lyEK7+0yD9gSkkK1HP2Sklmm1q?=
 =?us-ascii?Q?uyueG4tcb5xXBzLgFDb2KqsbFRUByNWwgzLsqPzi4UaLLYWNh0Khu8vxvoL1?=
 =?us-ascii?Q?0HIZYgZNYJwbKibauFOSAt1tgOnB5DmzD+iebufdL3WML2kV+5zgj+Hv0Q5l?=
 =?us-ascii?Q?lyspk+bOO+1ph0NLoozkSR541uUQO+CXzs3oWGqRso5OQ4AdhW+zuQk8wKi7?=
 =?us-ascii?Q?W626gk9yprIlUXdLv3LFkbdYcx8NDp+EVVOxcM2T5s7juP5jRc7Gsw+0jiNR?=
 =?us-ascii?Q?AptW7Q3bIA5GuP7cpMJ9ufLbWStpEJpmTKDUTXsqcWZVAWcaP0fl1PfdrkvM?=
 =?us-ascii?Q?WoD1veGhNJS/7WmBwoay7NvxkiBQ/6YuLQj9bulyqzXdC2bBd3pf72uvkynX?=
 =?us-ascii?Q?GH7j5xeR5kUle/K/eaeMY09k161u77zKOOUbhqrFjWIMMZDbwkwc1wz997ee?=
 =?us-ascii?Q?9lclS+gCkRFmPyMnPTyM+xvQjYTP6CHkfCh0iNeTZZeKnikctbSm/9r7c5ah?=
 =?us-ascii?Q?lkLifWok8ZqGFWfjP4PPepa8OjrgNmOBKDjmJc59jIPC+yBN7J2EFg98TrcB?=
 =?us-ascii?Q?QFrNxSjp4IsIc2tLzMoep2GzT8V9W9C2sOXcTJGBgsRU3SZit4fJs2P6azvp?=
 =?us-ascii?Q?MWKpnJazBL+BcALmn5nEI2GE55ij7Nq5rwaF8fjk3xGUNz+uZLLZtExfB3YM?=
 =?us-ascii?Q?sJuAnetDTJDYZaqZQYWA/bkFNhVN3uZ2P0FVSyBDJUbCvjbHuvF7GI/fxrzr?=
 =?us-ascii?Q?1QQU46qANwLpKZONGH9FpPAZltkUHICK3gxC+6dfz1XFnFw1GtzXXVpWyzTr?=
 =?us-ascii?Q?KX5T7Q1UrLL2+PzpH6wKgePy0S/SxX2ugfiyzPgIkkmxUZ2Kh2r0eqAdIEdN?=
 =?us-ascii?Q?7bvmQHy7iB9wWNFXXPvjXDR4L47kQTvLw7sIvc3/6ktTg5La9hq4DzRNoD84?=
 =?us-ascii?Q?AtNqRezvG3o7zSCPfBvXSFb4eakRtLENstk8zQoMiJKn+kE+dSWMFTwc738Q?=
 =?us-ascii?Q?qk8ksFTssoPia0C5XkK+4YgTDg2mxoIBo67yapVYBqpyim9CKVfKoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrqfmd2OHCFR/isEEaDgWyiM+h0l4e0nnLx6fsXoZsXDQg1WEbktQMWDWBs5?=
 =?us-ascii?Q?Z/XciW7JaXtU1U7mUIyfwACXwbhu2M6+LlnJBSkZIBzFYNLBxuKio6bvMU/Z?=
 =?us-ascii?Q?lPUIfHi8Bkn0FuffuKs+q22uYI1QJXBC+2KRBVk9Z623CMMsIpeevLmY9yl0?=
 =?us-ascii?Q?ADM1iYZ3Q+4+VwcqaRAoYN8Fo9OSIHod1JqvqJ/hyHs3/SIhnPeDvHX0baRs?=
 =?us-ascii?Q?xBjA1u1j6vv/+chuahZi/bmEvjIFb1nDJ+UfuXkr0SpyABrW0ndgAaftvdmm?=
 =?us-ascii?Q?doKhrXGJPe+vY+HF10RYiVUy+MaJgUk4zOeBm9qJJgXgzpImewgvivNj8Uoy?=
 =?us-ascii?Q?tamsTsjXRX7QqW+5i3nMrPBHa5SIA8U8Rm33AVbMwerVn6HnHg6ua0fuE2Iz?=
 =?us-ascii?Q?Ijs0upgECRur2yzrocDglNQlPMvXLHOnvpQPEweARF9M4RJR2Ag9saR/0VUs?=
 =?us-ascii?Q?4ew+del3gmOQVCGrDdo6TIW7qSGrzGX18zivCK+WGv7DmLLq+kE7+ddAboYN?=
 =?us-ascii?Q?U7cQPdXA7W62ICD5Z+Cl5kCPG07/b1CkAgpz/ID5yE3r/7b2TiuRko1qwP2z?=
 =?us-ascii?Q?jkEMid14I/8qtLNw2nfFafcG7v1yyZDzWCKuL3iRgps0o9rMAqKWBKifnEN+?=
 =?us-ascii?Q?tKbD9LU2D1/eZbQ+vPUidP5CLx4racq0neFKvZxFOZ8rdD2yWatJKlwDQoS0?=
 =?us-ascii?Q?yGpYmdjgeWuTFEN6AhKllBik41NwIi7gUMKZ/ADJDTJ8ujTxb/MiDnqYYaQc?=
 =?us-ascii?Q?K1mrOivo3jqJO3UrNFlMWdn7yVDwJdwWFPg4JDEEApfMF3tlgpVc84uh5Okp?=
 =?us-ascii?Q?w4Xoz0THAohz1w9poLlUv4Mk/+I1mgErknTpJn9K5jEvoR9+a6wkuZ722uKi?=
 =?us-ascii?Q?g/XM2EFHJkoccNhHem54SwYKvSPWCcnSlw8wmeULvHsYLCxboX6UwOH0m+MA?=
 =?us-ascii?Q?Yp3DxOjEpCMH6xAqLmVCUEIuqsvL1esQOfEUmtylPMO+OFKvYRiJvchBMIGH?=
 =?us-ascii?Q?zMX+ojnbsfIe04F7v7xwGoz1y0FlNM80QnplBe3AlfdfJlNDvhkrL4+eXg1Q?=
 =?us-ascii?Q?LNQOE4bDzso/4nRNPD9H11ZQvMNpifflxhR1PEehGtdTQQpgPMjnAnpElhAG?=
 =?us-ascii?Q?QnsaJbRtaWBL2soJtR7VD4qbFXQX86SMg33+QWcAUaFtO1qVLDH5uNzLH5Sb?=
 =?us-ascii?Q?15IUGcZEj17QlkoaGovx0buIY1QPbCUekbbQ9IWM6zIq8txgwqyn94kzEwRj?=
 =?us-ascii?Q?BtsbHdKT5hxU4HKygiFCHwd5PzYgPIY12DpsKVUfsZ9SAz2DOcYY7lEcrbPZ?=
 =?us-ascii?Q?HZvw/w4rnIGaXk29wERiobVhe5aehuGdSu57xN+h7LDCEOJHzB90qrEn+jxo?=
 =?us-ascii?Q?Z8+hE/OWbYUn+ksJkhbO+Khsd0vB/0MFe9fPfDsoJAOP1YQ2V9IdYtP9YWok?=
 =?us-ascii?Q?m0Z7Qdao41F/h4qj3Pt+Lr3nnZt5baHdIwPar+jrDeotfxsCHIyLhHHe0OqL?=
 =?us-ascii?Q?bsZ0Q2q5OKuXCRj6tUToqOGgIPWCRrTzSzlkJHWNKUPNCLrrznaljb85S+dx?=
 =?us-ascii?Q?5yXZAy5S9l+1FmnydWwYv0V1IA4Q8ZOeoNITX3Z9cUw4XOUxMqXMFG2S0/8d?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114f07f6-d52a-4749-7b48-08ddeae62fc6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:12.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjPnaqRlw4A3JnB646f5t00TJrix0z191+57JMa14+ntCUvEti4q2jtKIUWeZnMoCqoI8jRoeESHNeK8GkVmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add 'ldb' child node to handle
these use cases.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml     | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d62..f83d96701bb04 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -39,6 +39,28 @@ properties:
       ID in its "clocks" phandle cell. See
       include/dt-bindings/clock/nxp,imx95-clock.h
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: nxp,imx94-lvds-csr
+then:
+  properties:
+    "#address-cells":
+      const: 1
+
+    "#size-cells":
+      const: 1
+
+  patternProperties:
+    "^ldb@[0-9a-f]+$":
+      type: object
+      $ref: /schemas/display/bridge/fsl,ldb.yaml#
+
+  required:
+    - '#address-cells'
+    - '#size-cells'
+
 required:
   - compatible
   - reg
@@ -46,7 +68,7 @@ required:
   - power-domains
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.49.0



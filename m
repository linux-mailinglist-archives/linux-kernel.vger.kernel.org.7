Return-Path: <linux-kernel+bounces-824099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F062CB881EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5161C868A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DB2C326F;
	Fri, 19 Sep 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RtuP/hvx"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799192C234F;
	Fri, 19 Sep 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265880; cv=fail; b=hiToytpAVvH/0utkQpQbZ26nTyeFAmckGavKatfhZPOR6zCcpFOCFu3tJJtCRczyPLX3EveLXczxWTceQ/fe+BbhSmOoId3p3jJrLIlAf2hGO1eIW6cogmQuW8CXy1EIiZnXvLnPz3ysLwpDszNa4dSzB+nB0VSIJScnX8rMMqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265880; c=relaxed/simple;
	bh=MyFhVPSU8Dg3F9+fzaS5XmFYXq2VcDpKn3KOMvaL0Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kI2QriYDH4psRd83baNb7C+yP+XUyUH4Drl8s5QCZQoPOSoLRA0Nda/FFen4bVm3fX5MaDnZxbGflQllC06bTwIriWX5A6TxKgATFCTzSEd86Ll1f8HrOB9CZNuG1TnRjZmTDquItDeLZ7tN6vaLxNaeiwYX2ngu9elNxSaFCa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RtuP/hvx; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ4uHOIHhNcrrkX5HB0FtESkFSBuj+/mKBj6kekyCBaVNRRbJ31I+CedUTh/Tk20MyRUb7YukeDahcTrHLb0HLlNCbce0yoNkz43IAHXA4LENHNbGpQW8yF+Wy/V6mWpUlzh2MAg5UTdFomuuvBjFrbTMcX43RWVF1BsjluaPXm6U1iLzg8Baq4MQIjjBF+s4pdFMH59NRBxIIU4dtsW1B8ZdWTrztArYeMaZf+0rx8uR5DB83AWsxkLslmi2suv3XK7ucnOVQ2gP9Jq9NMiwWXQx9zfwXpW69+eF7f6AfMIgWmIGiFMshNHc5OJQrOc6+eZ7iM73isLbOGWuc/TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLckjpzen4RwM/Isz6rEhdF/9a2WwxXfsNWLI0vy9Y0=;
 b=vadHWX+KKg6DZyr7I50i5Cn181aZp23lHwDhO5envCOT5OKXnbbFDpFTHI0xYB740tFnITF0S6PkGrLIEg2a3m1mb3PsklZ8FkdvQs58yNvNftXUUS4U4qK0ODV7FGKHzezfvRd1gdurp8bTzOEMTlwxiLIoahMD+kTCwU9bZ871yVRMdQ0TtT4fGMRA+OFbB8/PX3xGlzscsEUGNxVeQV/L/bbXytffZCjVzjs5RxEiypCkb7/yt1Iqhx2wIPHXOIAwkh9E2nB5QtLxH7HfEGQJg5+VLZK7fLFD8vu1fgfOcGTafucdJ7KMIAJjOby+vvBYF2CGkaornCH1vATlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLckjpzen4RwM/Isz6rEhdF/9a2WwxXfsNWLI0vy9Y0=;
 b=RtuP/hvxpHLC36lagyDGNpA25lPETW0/uUNTMAT9pKHMlFkToMXNXqtSAOOzANepudEFDVgjU4NIcHKB/nV79lekJSrnKqKPRNJVVgRDPBKVgyex+mSgJhHcqdHwm8qx7zwLqdG6sSo19AAcCunUr98/uS19DmI2G+qotffY5yqT7ObjMHIdmY2t1M/ZcqeuArAB/uLuujvOnoaS45umwFzu6pBe0YuTXwchBJxgoIlHRcdbkBI3ex2tvIv8lZwZlu1rZnOLFU/zPtiPR1hsQUUIX02KlboDrQmHwIs5rNWNYze2lEf1xXIUOJ8O1O67eJVHzZBT7InjhdDqpimteA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:11:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:11:14 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] usb: chipidea: imx: add USB support for i.MX94
Date: Fri, 19 Sep 2025 15:11:11 +0800
Message-Id: <20250919071111.2558628-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919071111.2558628-1-xu.yang_2@nxp.com>
References: <20250919071111.2558628-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 11232d2e-c3c0-4e1a-e38e-08ddf74bb865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T1uKrd7SqP4W2HbI9eNW6f1LMXQ0yUsR2/Z47+HNkbz5U1/utQLCgkZslLKZ?=
 =?us-ascii?Q?xFnXLd+B3GRUybR4d2QY4AWSrmq/AOvsLd+dXgU4gkJnXE0+NPLeX3fzW3Ll?=
 =?us-ascii?Q?PFYzMJBM6A1ztzCa6ThY+weJXXyJXv4Nv/XjBvJ/sg/toZM2NuDqWTh363kT?=
 =?us-ascii?Q?5vWYtHTIZElWyufe1u/VihkQzQwkIlUWL2k42Xk5L3yoa/otJ2wxctApCZJB?=
 =?us-ascii?Q?OM53NcxTobRMEg6Mfonp4LqpMZU6VH6Lk1bADxdWZ+xmq/1/3EiA/10OrZFD?=
 =?us-ascii?Q?PIS8XINENhE2xywDR5i4wdvpCGqDtk6z3CNAHTyxSxqEnWdS/fQkkalsRqc9?=
 =?us-ascii?Q?517xnF1nHsvQHNoyBVmBLyXq1KZUbOR9JUi/q2gGaMdPas0AtnghfPFVvZjE?=
 =?us-ascii?Q?UdlkT7KX70NPQ3AwzCyEvVZLYMvlpos241647lYnnxD67A5iu5ir3Y6G5TOT?=
 =?us-ascii?Q?Lyi33yFoyy8CA3sAaUJTjstPfVjU0MVF5IYuqT+yf3Ut1oX1OLp4Zdd58BKS?=
 =?us-ascii?Q?IpC8kUPpqbkIo6GzHhHXnvIM3NUSno9S0DaSQmIuUaVUoiCCA2cdvTXps38g?=
 =?us-ascii?Q?T5YB+leUt+L7+MJUlxh0T8vknmurOnNer8D81NKa3gaRixGkNwsnzLj6c3Ah?=
 =?us-ascii?Q?Sdr975moz7u0MTKRTTooTL+DrYT1VVzJj1BtCNsoIWsqKz5G+yNdjgmVJQYd?=
 =?us-ascii?Q?c+K0FAI+AnMphyqGBgIWhOcE0z4eGlbKqp0HZhA30vzc9eLkjVdtpFpFaZWU?=
 =?us-ascii?Q?ksOucvfq8upQuOUwK5depprrj/wVLT2X0GxoZBYSH7Nx8yVKRNTL9lQLzS0k?=
 =?us-ascii?Q?7LZX+1q49bUT26z6VA9Z9VyJ7XWqRy1zqNaQI0fOeSgk3xhhDOexZSMbXfm7?=
 =?us-ascii?Q?FTG+s9wpJMNV7s/sxHHNgtUxUYBfcxBSOhgi8oSPXkISwdstWVPBPtwFL5gB?=
 =?us-ascii?Q?yOgXW6IGnReWU3a+Lm52FrXRrbff8JGsjzw/cAQ5caPUsFMc6kCSMv3j95Z0?=
 =?us-ascii?Q?uhajxP/dM5wnh2BfzCR73wFOeYqGKBn7QN51+AwTe+LZX5uNcUfXIpoTxgW6?=
 =?us-ascii?Q?dEyp/ckVudMiIPuxjNPlMHHCxV9g0hjTfGfid0maqvGq/Nd1505AcUhRHN2v?=
 =?us-ascii?Q?pateCkiAtqKncWcIpweit8++o+jiNM0JjiDZMuNZCmFD6w027rnJD/At1Rnn?=
 =?us-ascii?Q?K8QnCyg7ljLp0NlZts69C1+GM+GmtDChEyhtJ/jmnrQaJjzTeI+xlz8LwnAG?=
 =?us-ascii?Q?bqra/PSgjGR3cDnUrzswLYktnhjdRS/3zIy1Mz2sQ3UWdV8PwfPKSuVayEbm?=
 =?us-ascii?Q?owUps7LJIKo1YQ3F1tRwatxjgJf4zSMD6QzqPBP58+HG/hwpyqVodj8kt1QK?=
 =?us-ascii?Q?hUiNh48igpP7pd9GxV7m8O5nKJu3YllbDcsdkOPPPTK97rL9BigEP8nLWk0r?=
 =?us-ascii?Q?zBRX6ks4Tiz89+78V26bZN8G6JegTg4UgQ1f1pcvlneQ7mS64uO5vn1ODwJG?=
 =?us-ascii?Q?Hdg6UJRaIJjaZ94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LrESvO18fQ8FDJ5Eov/J266UXT9CyTzV4Hw7mkLKC99/ryaj+QeahH2w8UUt?=
 =?us-ascii?Q?etnnbFFUhjp3SdTiTU7wxe2LqCpdTOU1Qp7w3drd+F3GSuFbq2xVPBnJ71zB?=
 =?us-ascii?Q?H4qTbcVRYpSR0SmYwiL+m1NJmMwntBbK1qdpkWyPLKzFh7QqWiUZlQqCIx3s?=
 =?us-ascii?Q?fjfzsZrVQJfa06xJz5omELS2EQzowv9wMdhf+sszsO+5Ud+KlbXvXeIPintB?=
 =?us-ascii?Q?93FsAwoUGWQFSGCMnamyfH6i3Rd63LgoVdW8aoaZLhYZa3cwW1B/c8YP4EPo?=
 =?us-ascii?Q?RtC49CvCEQGimtac6qER9Mz/uMXcJicj3oW+R/vlUuWphZYcR/x9T9YW1heF?=
 =?us-ascii?Q?srqOIOL3Bu25yrIBmkx2YWnYIuFpeR9MG7uIWGejt1wt4J2j21VqyTYKPT1K?=
 =?us-ascii?Q?a1fWCiHM0L+MYCyconKcstpE1GBEh/iAGd2m2Zeta4tf23hE9nTOTu/ZNi/6?=
 =?us-ascii?Q?/NLmSKEsdUJ0B6Zi2a+ESN8RM30rMEa8NNpad52hk8C9LHsRKEC6+3Jygpsp?=
 =?us-ascii?Q?t95DgnetTIeQLGyDjElykRpctNNaW2RkkqRJB+glD8OHZwp1mkiQPwxiBwoH?=
 =?us-ascii?Q?c9LCH+zesWHIFOvhO3v357QGF2r/q5YcmSTxr7cz/c7aPBskp1az3c+d+JJL?=
 =?us-ascii?Q?Rj3eU1LDdNCZGyuPqFl0bXnpq9S1QplZNZ8l1zmsLYoazbt0OlAGfv14NtCu?=
 =?us-ascii?Q?4psrsPEPCLo7qNGcR9jaHvqboyKK9hlsLstGF70hZPhmO0ntGMJ9saVmge23?=
 =?us-ascii?Q?ADCwLoKjjMrdGXWUXgqs2t+2iugEEpojczrLoYzMpgGzNrqNVJtExfPArDdE?=
 =?us-ascii?Q?bfwxxRxPgTmplB+bya6NmJNw8Xk6wCpOV43iE4QNpsnQo0gm61LeF07UT1JZ?=
 =?us-ascii?Q?Un12zeQhbVy8bUiwLHSb6/tvGJBJ3Hbu8qHgbx8g9/2zceKICZZhRCU4t2y8?=
 =?us-ascii?Q?ncqQT94HS5TaIHTBzgt/CyoxXjW8AB1iU3aQR3+Q0j+SV8MBeWPdKoEcFO67?=
 =?us-ascii?Q?lINGABBF59UsDEgQsUdfk7zSB2geANCd4AwoMzV5XF+9FTh+1Xh7KQWvjVnl?=
 =?us-ascii?Q?vNeLz0lQCifh6tHgmzNsTEFzn94s81kQWMSgzP0y9j/GrGMwGEpcbFxX1/vy?=
 =?us-ascii?Q?Kj5bpxglEuMK1wcVjVn/A8LAMCusJLR3hA8NPoRPMibVUVPuI0I8UjCwrr0w?=
 =?us-ascii?Q?hCm/5jHUquEmSiNZ1gzTxxE0CntEJcYaBe1yYYK3WG1Dgu+5KziGSkgt++jX?=
 =?us-ascii?Q?1a9GrNARC+6QXIEhKz1Q+/gZHmg9g4mZK4KtvttAUts0YInmYFzeg/VAIZjh?=
 =?us-ascii?Q?IMP13956C3CoduapredufXo1aEN1qtBORBdaoCVkXh+1pEY2316hcN8CEibi?=
 =?us-ascii?Q?M3WRDoUg95nBy5c8Unhe5+WgHr6PbyB5N0LB7XiYnFn3crXhAu3BE43RgxOQ?=
 =?us-ascii?Q?lyZcncZmu+EigchqZyVfR00zxgtZVHn1ej41CLRrVk0Y3y2UtSy/wo4WwQuQ?=
 =?us-ascii?Q?ydB+kvoDXtueIVpkSmrtps7r558IR+QOmclf1fVICgaz8MOs5SAH7hdAhMiq?=
 =?us-ascii?Q?lBRRl1Hdde27P/oGTNU0i5OLLb0LfHGD7swyngSc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11232d2e-c3c0-4e1a-e38e-08ddf74bb865
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:11:14.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2b3E0kSWxjjPgw6+7fEeUALrQehZMNoG8viBmtH2BxInhGU3m5eZYeWMTQuaQHQsqgQNxuxmkTue0jYVWmsvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998

Add new imx94_usbmisc_ops for i.MX94 due to it has same wakeup logic
as i.MX95, but it doesn't need workaround for ERR051725, so pullup
is not needed.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/chipidea/usbmisc_imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index b1418885707c..bb027d2bd700 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -1224,6 +1224,14 @@ static const struct usbmisc_ops imx7ulp_usbmisc_ops = {
 	.power_lost_check = usbmisc_imx7d_power_lost_check,
 };
 
+static const struct usbmisc_ops imx94_usbmisc_ops = {
+	.init = usbmisc_imx7d_init,
+	.set_wakeup = usbmisc_imx95_set_wakeup,
+	.charger_detection = imx7d_charger_detection,
+	.power_lost_check = usbmisc_imx7d_power_lost_check,
+	.vbus_comparator_on = usbmisc_imx7d_vbus_comparator_on,
+};
+
 static const struct usbmisc_ops imx95_usbmisc_ops = {
 	.init = usbmisc_imx7d_init,
 	.set_wakeup = usbmisc_imx95_set_wakeup,
@@ -1481,6 +1489,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
 		.compatible = "fsl,imx8ulp-usbmisc",
 		.data = &imx7ulp_usbmisc_ops,
 	},
+	{
+		.compatible = "fsl,imx94-usbmisc",
+		.data = &imx94_usbmisc_ops,
+	},
 	{
 		.compatible = "fsl,imx95-usbmisc",
 		.data = &imx95_usbmisc_ops,
-- 
2.34.1



Return-Path: <linux-kernel+bounces-892693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE77C459E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CFB3ABB84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE28303CB4;
	Mon, 10 Nov 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRMGS2uq"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A1302772
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766599; cv=fail; b=LVAMEitSTWD8cFr/XRqRcsdfpp3spa3qX/Y7uKX11q4CFMUrb7hdnfGy59CKmSVYQwnZfn7GDmBbkppVjrf3lDQnaAx2LHSBQbCT3R0Fa9IoRn+bve5p7kdP4N6/bO9WI2x2dVtZNnOUlC/l/EcElGBYPUrnq6gWY1IL1arofeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766599; c=relaxed/simple;
	bh=bokxF1IeoNVuN/+ETzgCo8pHWUJbUx5o+DMO3vetIoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zwb1lbVlK1YcfsKNmlam+AvZr1P5/pPx7+726RuVusdp0ymQgW79vUoTyJ1yyk3qkRMdsLJhjJg2qnGOD/W9WEjj9wKp+9PlKtCUaqordKF+2R0sJy2iA7kVITvFrn01WQLpEXiJIrSenW3mzlKL39dBAAr+JIGnfkdCYPpdQuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dRMGS2uq; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlXerX+xuj98rNB06UqfWvffXbjVidjQDoADjbZK4dKKT1DYYSF/F086a60H8tsIqJ+XddKlMT1A9oJKUu4p1cK9gUB7XSvtLIKjjKvBr0AjAlAfrrKbzJ+V/PZHzphvRDFEJ6QI6cfsZVxD6AC4N6GVdoocJwkXKX+P/L432pC24gm6E7SVJcPyqVr6hozEhiQbhSXRLpGCC71lwlUlsx+J5SR75lFsrnW/r5uFzmRGh5Vl6zYJOjWqZEEF1t+ONHV6quWpV/EogPIz9pX49tj86rvDQs9S4BHZGhhPFhkIPSzIqQ+UEDjwmyWj09+CLA/CsMeyTqCW2FZT+m4Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRPNrOKgACToQcPmhW/UJvdU8htO1CzZUn450EmH4kU=;
 b=X7Ws0BUeLfgsdYDAUSfUoDnczPaWpT9oY+PeXsfMvuaDkwNns2ZGdQvCGjGLcU5MBxcFsbvm7yZfbmH73YDL5Eh6pZu0mJLBEaOdtAfcV/IV93fpi1FYuNYXkXlDKTpgqm67RfwcBWIl+TPkRVQRPVYbhvx1SX1M/EIiKeFoLDqp/d+x3L/QS14k7J+tfeTXWhKsQuDWc153PHwLRAhJ1dWIhIV0VkPYcTDRKGdOZXPBAtH5frmdZxEOAFgnPNo0IMO9e7DCSlnlQneFTd2h88orm2EA7Jx7le7piBUdKerBgVO4wQfLH4oZivf63XaukuCjSbok8Nn8z6cD56Vvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRPNrOKgACToQcPmhW/UJvdU8htO1CzZUn450EmH4kU=;
 b=dRMGS2uqihGJGb1sUX6D1BKHXDkgX7uVz8btfXl9kPVGbxF327D7WcToc+arjNHhpqpo4cwAvrPtE06DUlH3eg3HAFr7r4HbksGSLjJ7as0CB620nVxv6pspQEwCVpBMtUFvPrh6E6zs+mPHE81no1B3wgUWG4t4agivMJPmphPRpwf9rrZBovYL40XrGeXyHbpsu8+0I39LlgAvVq9D+ACZo1B6NNkOmhiZuu+KWHQOl2ck8f7NxpG5R/iNAR6d2y44gl+k8gPJOigks/jy2eJmR7L9yr1KqkcQLXP7Btv9l9ONcZ6lWxEvgPemuEsVCY8KSOOfGk/bFAtJV16SgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 14/16] phy: lynx-28g: improve lynx_28g_probe() sequence
Date: Mon, 10 Nov 2025 11:22:39 +0200
Message-Id: <20251110092241.1306838-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10574:EE_
X-MS-Office365-Filtering-Correlation-Id: 93384925-31f6-4d99-c13c-08de203ac559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsH0qyewh45P3ZpmZj5wEymfPOPPSnh+kLKZE1IqNcRFKOU13QnQhQ2s/RLO?=
 =?us-ascii?Q?/QLll/1hezwBWgrvgokKwGjs6wwvvJf8XYQ/Dm3a9fpxRKJH9pXckhcd+24m?=
 =?us-ascii?Q?5EoTp0LXEyhHVhfGDl0WFl/le2KpZPP9xF/pRAkadQGzS8E/VQHemuZm7NNy?=
 =?us-ascii?Q?GDRHt8G1PC/5QFBooA0No+zKoxcgGGSk7QBLeyJQoYKRBP6RrUbWo2/Upl3m?=
 =?us-ascii?Q?E9exhJVl8HnPrttqqqJmQgud+oTY/Oagi4vSvODYbh/986jwMByHEsHJWBKH?=
 =?us-ascii?Q?y3PxBEzYrL16KPw7mICQbKV0i83q6ru9GDX5h7glgrbeO+M1AZMz2PV6JE8G?=
 =?us-ascii?Q?aZYzzKiUKvPYwmsfHGs0kwlxm+hAQdPgxWAVluf4M/cppMugD51ITu+ZHh3L?=
 =?us-ascii?Q?2FJ128CnGQQnAspNynNcQXzEoK3P7bitb5UcW43FPqE2b9NzVLnEcYC8Qf26?=
 =?us-ascii?Q?g044aS3A8jE8F21ns260crh3HzvmzH8xO7W8WoWzqigTPztsw8ktj/wO/qCh?=
 =?us-ascii?Q?IvdnAjFi7mEtlER8Jt9syScmf1DNsEIDfZKQ6+agpi0KUp9Vh4ylmVYPOR0N?=
 =?us-ascii?Q?1kJYJbkRdZi7sxZ9E+sb/55PPyimPjerbiT/FYWg0F2Sb3OfURcnyze+v3PH?=
 =?us-ascii?Q?hoeVYGt2hUxu8s6TmbAhWQQEupsc5tFpt4fkpbhcmc/hy2A1RLz7Hs1igkDF?=
 =?us-ascii?Q?bGSr3H/o2rgaeljvrwsc9fIoq1IsyWqUgCjwsR6ijY+ppXQKjnY6e4zlh4gG?=
 =?us-ascii?Q?l8YP4eDKzAb56bMI0ZHG5rfd8EuLwQLOvQKCW2cpCg0NNuOUXLx/1xfOFLIX?=
 =?us-ascii?Q?byq19cs+Rk4XgnUu4ELEF8BLCxwqCKBqOBVsPBVqN4SzCof7g+99oa3Sr1Um?=
 =?us-ascii?Q?pDDGBGxUmWRnKBcFzpLjtMduO1cGOzDnqf5brRVUMK+zUPIypnW4T8SVjo5r?=
 =?us-ascii?Q?xKcVzERfGczRs1I+h1T/3cIxZ6plWz7kKAqKdDg8zBgnZ6CUy0nBKkFY38Ve?=
 =?us-ascii?Q?RoBpZ2am9A9e4OhVK6NYTvycqxpGGKnTEstGAboOG5GKfGhZJ/Z2v/hzov0J?=
 =?us-ascii?Q?nG3ygtX7MGZ2IHZhz2UoLrvDUa0H42WtSvfVAmzEmZsGpYJZ7et4LEth+KAi?=
 =?us-ascii?Q?vdsybBwnfWdftn+A4oIMN3lMO528tNFYRnvClH0JrSrhdOF7rqjyBveFv80i?=
 =?us-ascii?Q?XoWoMB6ObRHa+fEFY5BAh3RQlYyVyhP7O+KPx8IFQ5mmPXjhoXpGbDtu94Co?=
 =?us-ascii?Q?jj7xqaP3gns1O8vVvZWjp6BkBKxJoMeiETZFOxnubZCN4RROfrDy8b5uuBgs?=
 =?us-ascii?Q?2Jnmv5JnzHbd7h9gGDXS1TC82hEipom3Aqcmr9zJPs53q0wDFi+JaRrxdCBF?=
 =?us-ascii?Q?2DY03WPQ0oUiHaE54q6x7/ZU6QcgbiZCsRk0NMcjYRBJOgZHmejA2aT2elVc?=
 =?us-ascii?Q?3Tjy4itbRhVYqCZ7quGSQ15UGCpSTM3Sn+9JCfUSwCU06BpcT2dZSb/yzB1v?=
 =?us-ascii?Q?h/i0jAIzoifY0d3dbubHazEo+o0X+0+C7Vu7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWS61bosMnS0tKq8ZTrbVUQTFiKOnY46YG0TnxoN/9vtWi3z1LKu2gSqG9+u?=
 =?us-ascii?Q?M47tY6mFhv8obsGWC8CkFJU3AjyktcWYs3CGo1QGaIfk2vVcUCScpemSxvi+?=
 =?us-ascii?Q?z3d64h+6tpwcWmEH8XVLgdGRCBiw5b4f1UVrrXx/enCt/xy04UpJa8/BnBuk?=
 =?us-ascii?Q?r9jfk4637FRPlkDJnb1UjwtvS3pWgO/SUbCEhk1BY7xlDxDlZTDMIgciJhpc?=
 =?us-ascii?Q?beY1vVo9D7HmIQtw1CLVD4eavWnPo4HwVcrUO6oO0TgIVKo0KnBCxXxrgue6?=
 =?us-ascii?Q?/0T6pgUgbTPWNkCTytKqxo9MYN8MipkavSz2LiczZMQKjNfAmMICpDOLWjXz?=
 =?us-ascii?Q?E6EWN1CIbIcXv06Ouyk2z1LHWfbNluRTuB3HMpE717ph+DUKIko8hYSparFU?=
 =?us-ascii?Q?+IbLLlUaO4oA632E4hANQPnzvKCw6nGZ+tqwrylRL+ztoJeesYpb+TbH/uux?=
 =?us-ascii?Q?jLT1Xi6v6QfDkXahA/iLRL+Sg3nVkDqJRlO8C0qaCHp5L1MKLktYNTVez8Qz?=
 =?us-ascii?Q?MPbxGN/lOB7aWsx1FHe/Zi5gofJndKaB01kqAkaOMxIcBcSDd0nBWNR9r1Vy?=
 =?us-ascii?Q?wIBtx+/QitLp8t/8tQvVpuULtk56Wh5VREYoeRMP8eIWDQm9o6Zz7H+jjlj5?=
 =?us-ascii?Q?z9g08IX6FMyMEmMcotUWHIk6Ir1utoacm4fsW1z7dE84CdlLkosu4ghZBnTZ?=
 =?us-ascii?Q?Xem2GtWfnHm7If19/Md516Rx/7hw8HLPYUMookccxb6MNv5ch14g8+5WJ/Lq?=
 =?us-ascii?Q?vE4gJA+5TGP5iQTw9v4bM+fOWgJWbvFfb29fLaxdKyuIJX/+2kRd7sPaIrcA?=
 =?us-ascii?Q?+5iFBQROo+9PO6H4onQcuMt2CQwTvLwWj3iMLZy41JWWiWLM0qY/FYx8vnJr?=
 =?us-ascii?Q?ZyUKsiAnBe3s+HHFeqUQpEtUh3O5uFGDlpyB14XtWoUkLJ2tHKSr/afGDshj?=
 =?us-ascii?Q?wE82gm3M63i2DjOvGgjkuPAY1Uy2kXKbDEkVT7xXGaEEPly91rkVD1quq/V9?=
 =?us-ascii?Q?Up6pSDPuSxZrrbUFBao/g/pH5fQucAzqKUS9K5Y8XOOKdsa22pbp7NBGq5V+?=
 =?us-ascii?Q?IWeOhYP5FoGXovzIgeskGkqCSttS4vsikPU6sXk5pyb6ltwCo9ws4955XXUg?=
 =?us-ascii?Q?GNCK7kmh5pcKODG/yjnyMGxecTLhC1pWQnok1cBbB60/9R/VOdp6dwz/8tNv?=
 =?us-ascii?Q?fM0206LmasMoNJ1cmQu5ckBa5asUbxy30xK3rBy9mf/Pmx82m7lDNhYvh8JF?=
 =?us-ascii?Q?4eKPzd15+M2qLmWev6KmgKU0dWWbA6vNlnvWqPbPpYHO8/c+6dYtgS3yKcCG?=
 =?us-ascii?Q?+goSHhklYHcTUIgrF8z5p+b+npclsWmYVXh9m9hSqTcC2LJqTU2kxyVRMQxv?=
 =?us-ascii?Q?Bt14s47FaJELK382J6cGezH/45OSNToPXqPYsGK1MjwOVJ9bDwqCDdPlGEtG?=
 =?us-ascii?Q?qkL54nV+kZ3L1z4R+4vFol/LLhNKs14sxLOnnZSgLGMJor3ROH8topuKaMhm?=
 =?us-ascii?Q?+2itG/BqjOE3gYvfOFmLJZ3vkRYsLcso1TkPZa+lCp/4se7Rtsaq7u25yjpm?=
 =?us-ascii?Q?89p+7Rt4Ap/PjLsnpim1DefIXVtazqQGxA3fO38VWJ1CRTEI+F0RqYeTtzib?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93384925-31f6-4d99-c13c-08de203ac559
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:12.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CovwLpl8UoC59+46C6mTINltQk/IuQC0hXuYWxxS935O4dg0TPdaDcviJB9DZjpUR+ek5ootPMtebF3XOKkREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

dev_set_drvdata() is called twice, it is sufficient to do it only once.

devm_of_phy_provider_register() can fail, and if it does, the
&priv->cdr_check work item is queued, but not cancelled, and the device
probing failed, so it will trigger use after free. This is a minor risk
though.

Resource initialization should be done a little earlier, in case we need
to dereference dev_get_drvdata() in lynx_28g_pll_read_configuration() or
in lynx_28g_lane_read_configuration().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: slight context change due to the introduction of
        lynx_28g_probe_lane()
v2->v3: none
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 5d5c94295726..649c5c2fa4ad 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1165,7 +1165,11 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+
 	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+	spin_lock_init(&priv->pcc_lock);
+	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1210,18 +1214,14 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_set_drvdata(dev, priv);
-
-	spin_lock_init(&priv->pcc_lock);
-	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
+	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
+	if (IS_ERR(provider))
+		return PTR_ERR(provider);
 
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
 
-	dev_set_drvdata(dev, priv);
-	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
-
-	return PTR_ERR_OR_ZERO(provider);
+	return 0;
 }
 
 static void lynx_28g_remove(struct platform_device *pdev)
-- 
2.34.1



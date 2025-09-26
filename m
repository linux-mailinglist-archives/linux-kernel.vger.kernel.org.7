Return-Path: <linux-kernel+bounces-834509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E6BA4D61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9316B7BA908
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F5311961;
	Fri, 26 Sep 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C88dEybL"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285E30E0DD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909945; cv=fail; b=Mr3HDuNqoUrTiX7uqqzBvu4pjdbCw6tpWvJuKETPuGez8cp72EhcKf1pLs/4MeSpszeGYCq90XSKwNDo8VLriujnmy6XYzkhIloHrfDYCPjvfHHN/1HwfdrjBBtKkA2IpvgBUo2vMgsk4h7WF+pDm2Tp42GZVAaJvyBk3Bs6HeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909945; c=relaxed/simple;
	bh=xgk986R7qL+Og4I6EOaC9PAyYzpqgSh8kxGNRc0+tks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgcHG9wlX0xiNNJWpdOO6+4vz6klZBtscwNbSQEjkvbEi6nNl2SseINyQl7Pcj/9R4hP+vH8hVYsqhTDw+IJouJGLRLHEP9wy30E4lrGpoS2fYvHlbsw9yKQJ3UDngRYsvTPXNNlFIP6QUneAEQuqlByCstwVwslzWVYvRI9RfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C88dEybL; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKreju6AUlqpd3IVgoXFgbzCDFKvs2C1p1U5xlvjsr8k+TUtg1zQOguz9jM31p5mplHzvjE1rY67yV1DQxYtOuqOlSjFIiQObMY4wi7HSB7rj4CZvBNhVLtUnJRHVXBqvGcdeYJAJ5wwIoRQ+kmcwaF6fdsqqhzE1KWghNGdtTHccg/P3wvQflV9Y/qrPE7sXaWzz1bcP/8k5aEjKTVWhoms2a93U566Yfbp+KEwe2aXYK7hPRryPiySn9JewgIl8+/TrQe4DZrfl+sJthj4T8jOr1IPQtdtv0vbZfDW5VLoPRgoFpfF63+lRe2xWHXW9OeLkYiDDitKfLJRR6ZYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo77O7dZ2l1AkADr/gcZjZBAbBvU4GMGlhfoJNZmgGE=;
 b=SNZlIOgw8IqS3Ff9Rvz3b/R7/SN9STN7toiqrg2mz048jTeKjmXruXst9fB2nker3ukcLtQCOM5cMbbYASowcnh8zIdtYwKSZJGWjpSUUV1zu/ZecKXfNP3NI3wtwN9sho8ShziB08t+cufFk2LpTGPns4AbKPD9LP0U/WMtfqTbTpYV0bB+Pe3wk6s+f1HKFtwspY8NKrGTGNxd/KDdK1kR0TGPpSDG45HB7+K08OgRXQiK6rdAR0VgqL6oW5PiyfLGdPW9FGUyLZWpHpNnVAZuLNQJz9ECDr/I9rVxe+j4eYDdvUEyPORs3LhyUItUWiNwSw1+mP3/zu/8BEdsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo77O7dZ2l1AkADr/gcZjZBAbBvU4GMGlhfoJNZmgGE=;
 b=C88dEybLc0KgkdOs3OheaSqfvlUCjnOh+sTg+YVUPd0FzkBTjIizLQXRBR5G8+EIG8csYu0td8p3lg0xDK7J6Ng5C6WoxeS191Vq9s4GWdobxtC1Sdsio/GCBK5KSQagFWyVDSd21WiPu/nLYks9v+KGEfJNJNXNX+V7U56tAUTJ5LiBm+JZHG9Ve60x4oEcL2utppPco/Fyic/DZBfxXAjikU4EBFRNeCNX0HBiuDEpuBMk4DN6Z/2Gr7Wak9SbZpbsyfs3KmA83WYRdxRj6UgZDkOF+pH20FHmR6+c4jPc8rTVUzyqkk1sRTadDInbsqv2G0dwHVIHPNyHW3QUeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 11/17] phy: lynx-28g: improve lynx_28g_probe() sequence
Date: Fri, 26 Sep 2025 21:04:59 +0300
Message-Id: <20250926180505.760089-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ade4ef-ebf7-46c2-a0c9-08ddfd2747ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dA9ZE6IvpWiU0oRP6RT+TOkEstHcXy1qmuzJbRxq9atrMdkHdYqKZEz9m43C?=
 =?us-ascii?Q?msyFnU1ycWy3nHph4NA/twN8IvqgIgu8PFfAm1F7kuXyZPaBjl6FTmfhZp3f?=
 =?us-ascii?Q?awsH0oU4KrO5ub+X0+6e7SjQJA7ATcnxMI7hSKpMHwXR8jn0k0P2F/rkE1s5?=
 =?us-ascii?Q?85UuoihjZpxtqP5a3hV9oYgaEPy5rEL29Jpw3MVDtKql9MbkyzH22El4quBO?=
 =?us-ascii?Q?K3FgGAOcsOx98SnZszODA1j6or7WAWblxwTKRe0LHPNm7UxKkbTMsm9tyYRA?=
 =?us-ascii?Q?wlIDEA5wBG7PBHQRNlkVTxdlsvJjMIlQv4Wj0aY+h92D76/1AKA0CnpFuxGe?=
 =?us-ascii?Q?n4NO5hLjntR9+sIOhWrmHVTVIOx5xCCAVEbu9wVDiR+J4qv8hIxKqmt/+Ohi?=
 =?us-ascii?Q?DTTAAMOSLg069WFdLiK492eKaOiz9R3omh9QotTE9jgij8nB6kWVQ5LIvh/c?=
 =?us-ascii?Q?UNPl29YRFmWn3flxcIhjjeL1Fuv8SwET6raG2YhnuTMqqGV5XdAlYkRxtLWS?=
 =?us-ascii?Q?zkiBLVL+jlqtqPWmpoAZs/AhrmaX2NV+zHPZbP9a1jUQXlsxxwTedKG+pl7m?=
 =?us-ascii?Q?Q1j7P1nprhTqEel8DV4mmz6Z/RVguUu1fZFqkgGK16rbEO5tvX2kDcRdz7l3?=
 =?us-ascii?Q?GrZBDrV/2AJxUZAijLOHbWUasY1TafSHlXPsWiGuTBhMobbCLiGf4YjEZcu6?=
 =?us-ascii?Q?TsF48ZomqMm8t5cWTSoOL7lFph+iBzsWVsH7hDTtO0SDd2EctVR2QJTVb/hq?=
 =?us-ascii?Q?BdCsCPPjDVXE1zkM1TnxengpaaCbMjszd4/ixZUwABd/W8jzoZyCq7nxgnWk?=
 =?us-ascii?Q?BQxK4umpflhIRbb5GH4RixVUg+Zyp578KwRPW2okUAjWbDiZyRkcry/hyRRS?=
 =?us-ascii?Q?n/LjX5kW07GuEJJM4HSaNc8XRICG8I6lmD8M5FFLpfFUKiST+wgePeOmQE60?=
 =?us-ascii?Q?YSX01ic5NxbnmY4ZicJeSd5a5F3EyyjJuBxX9sNIuPNPXSlDs9qWKPM661Xr?=
 =?us-ascii?Q?eFQbDrotB0b/ZJo/FrIDvUIpYN2khf9fj9xjjA9EDEuRYod04b2KHAJcLVdO?=
 =?us-ascii?Q?ndEjmqJ3KQLbeY4knuY2HKLpqfUuMqFKDvZawj+jVZXk7KOU33bSu/zl3VMd?=
 =?us-ascii?Q?2dmUR3EQVpMX96kOx/4xP2otAb8diKB1zMBEKO7HMHY2SQ6izUTOIT8nwwgv?=
 =?us-ascii?Q?2VOOkO+E/BQ5croEH3wwTCuhJXC/BoQ+M0OSWnWMb0OsmSntKoFPP6ApCeuD?=
 =?us-ascii?Q?jdqj+G0xRjh8pIV9xIbjyiS/2GFlvbbcbEMYifTxrROOXHtNtN/lZinAm45G?=
 =?us-ascii?Q?+5Q+Ks4GVUpNt7ugii877BjwNadon1G1wgJpJ5GIa4FPAz8IXupRuIi6hwQx?=
 =?us-ascii?Q?RTEY/fB8s8SQedVgy5CGs6Kg+ikADq9awe29NsVP4SJLOkJlN1WDsbteWKPJ?=
 =?us-ascii?Q?LhAY2ols6XznPfDaw3XPxHwxpB+IfFa7ScQzyGxHmr8+ipQP+sexFu7f/MrM?=
 =?us-ascii?Q?/bKmQil2kFqpJP/vuPXB5Vo2IwFuksdKNLVs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hf1wok+2bCIoF7W9E2dvskKkmjS66/k0DWccr7BI/DQKFSk0cc6Fo8PsJppj?=
 =?us-ascii?Q?PClnglSljFqAEt4bXBdaAFGn4wuN5XTlrptd61yj0luwFjbhYivYOKKg3zCo?=
 =?us-ascii?Q?zmiF+KfAbnX6ZncjIYcB4Ls1PXp4MBfJYhQQ4HK90bV4/43Mf2IjCBvr14ds?=
 =?us-ascii?Q?lT5QqPqhZcuUao/EGZ2FeJ0q9K/sZDSWDniru7YL8DbKLRDwT7FJAvUUZBh3?=
 =?us-ascii?Q?NTgjGD8VpcerYkpxOACAIHPyqheZlkK2aMih6Ff4/avXiBjBBwQIW1fCwVAC?=
 =?us-ascii?Q?uawlxZEsOK7zlOcScTubm2dJNB93rV8bwM0cy98OpLQ02NPn6zEm6tA2DNnh?=
 =?us-ascii?Q?HY3sITjEe4pS7e//b1IN7vnPiMUX18t9gZs6F27lwGRrDE9SM7z50Mo5wR0p?=
 =?us-ascii?Q?wIV0Bp/yiW0ILhjEdeDw58PRc+lh2HKnFV6+bwmvc9y9rupOEhIIyicwBn37?=
 =?us-ascii?Q?qROSiEW7MRL8uEudtedimczdw1gXoV1xEugR9yRZ1WV2GDFA7EFngzlWFase?=
 =?us-ascii?Q?Sr2vCyZar6mnpeO/J26wBlcNH3ah44PhwIEfhAn+o08OQ8wv8zTcH+goMis8?=
 =?us-ascii?Q?3yaoSyZaCvI2MaWwQgjFoqqdK3WzrXq9YtlOyg+w/0Q49KdgQw7RLdiYvvUK?=
 =?us-ascii?Q?rWYRMlMNMHYISKyIzbgu+0sM3qabygG5JwAVc2BegHiSTqGf9y5Hc6iqLv/h?=
 =?us-ascii?Q?e4LjlYlnMaLmyJgYA81VPorweUC5VFXIzC0Y6SI7XVmc+8jrTIEU31XaVZAU?=
 =?us-ascii?Q?ea1MqQ4YCm89gT0zc7tOpWG/5ZrCwPXP7tbqFqQtAxwS+SuASD8siiT/8iI9?=
 =?us-ascii?Q?VH64b7vgHxTl5Hchl3P4sxlleQkNNsL2p2vNVtPaq/5LxavlN2mTMIPqRsXB?=
 =?us-ascii?Q?XByLCxjCyoarZai79gYgiSaZnjbT9NZq1V1uWVgvPLf3P79tLWbVDBdVUTQ7?=
 =?us-ascii?Q?GKoBDWqmn1nTANAgxUJuHBC34XXXv25hO5KQQ+KcHNhoRgwYOqvI/grN/XUp?=
 =?us-ascii?Q?Ic/Cy8gjAErQdZvZofaeKZ2jUhk+TxaXcCWuAS0o6w5xz8XYDIpMan+ZLoLZ?=
 =?us-ascii?Q?TAuI+HojxwAuOxt64Nkq8ZdOYGg+4FNYTTwsg8v4Vwj7TVhErvSeyL0A5cOe?=
 =?us-ascii?Q?3a0exMx0tAQ5V977kSnikLH1v2LQIUo8fj7aBDExvyrNYyg4duf7f4extoNt?=
 =?us-ascii?Q?/S4CPSnC4mJg+gcdbfH17gV0MSW2FoIoOaTBJsdeeoRzC8k+M5a7CDp5mRB1?=
 =?us-ascii?Q?ex1CaZNjjN9WDlvgJM3vriPy9rXwKzjj42ahjxkKuXLiWghQsO8QtNkgNeZB?=
 =?us-ascii?Q?fstqcSKTqrh+mTFE35v/aEuYTYKIMU0A27OZW2Z2htBAK7RX76IPj14fHQfO?=
 =?us-ascii?Q?G3Cp/GfjG3VwlN8/SV1E+N6yqkoosOwvjmmQO0gF9Qbzy0oYVDIvtsdgW8IB?=
 =?us-ascii?Q?qaFUg5kG01wlLA5Rn9+usDf9oDP4HW3fqelbgC2EB4RiTzEBy5q7OXT/iAQW?=
 =?us-ascii?Q?59Pf4rN5esEDktw9B6EPfl6AB4xBKl+hc+OAvPPG5p6JxPFLaVcgztaFjPOu?=
 =?us-ascii?Q?HkrZSVspm3qNpEFTcBVuvBPYrqVuoCr/K+1w8iHis1KXBXVtiHgpkD+QyJuq?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ade4ef-ebf7-46c2-a0c9-08ddfd2747ce
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:30.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSWoM+Ivp55/Lb2+d3Ulj+jQYS2Uesb+z6JVsN9YgLyOZKnmKwSW/jf0as4LDRD+F79+5gCsXBrnVrsKyUqixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

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
v2->v3: none
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 7800f57413ee..453e76e0a6b7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1136,7 +1136,11 @@ static int lynx_28g_probe(struct platform_device *pdev)
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
@@ -1161,18 +1165,14 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		lynx_28g_lane_read_configuration(lane);
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



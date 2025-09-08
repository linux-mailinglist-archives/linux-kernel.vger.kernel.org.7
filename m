Return-Path: <linux-kernel+bounces-805065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDBAB483A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F7A1693B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758722A4CC;
	Mon,  8 Sep 2025 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDGLAyCT"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778F235044;
	Mon,  8 Sep 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309640; cv=fail; b=MjnrU6/+ORFDY4CF6cUAYuWPdwnqydJdkSM+1LrIMMOgWihjTFuBoZr5GraTbSvsCITpnBrZccpwvAhc0FwaOsIFCnwD6UoEIve2FMQBvD9F2E5AcFNOP3W8a6iUl2eItacUDZhKgQaNlWm2wAb0dgmI0VT+4M3e42gD98G+tRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309640; c=relaxed/simple;
	bh=D+kbuaGZ0TeJS2Y4TVbf15/qAInKgr1ElaLBIHzUuOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmT8VLRZzIMcDw2JqXVPYPyQkGotNSy4xeYttcklCbFnShGqaBxeU89+Fp3fesQskML6RtqvQ8TFHvF2lcms2YnytyzUyBuxEZXw7bxQTueLMwMj1+GoL11KEgw7vQnUoiOQA00aq1XH5p171s6Zok3bENqDkkb4YNBalZgVkpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDGLAyCT; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeDa1u8hKfiB7oCLev97kQPF8XWN1e8IlkZZiHOxUXTgsOPrQSCdiIwDJGY6raqGvVQjes36mc+pS+FrphgwohhYA72ju9O30YNqpodiBIBT/5o7Hr9Ni4Ef+7J5AQ6knPnnhrMRp2nx3GuDaIkduXiLT/Zast548VtIIrdbcWfwSHCF7gSFCKry0ozHxc3IHM02QZZsEqmS8qKrfYLOUVIidpyU4hpjkOLQSS14dnW2K+O7QmPrUiZA5dhVlNPgEFbVodYh6sJegvqSzvcefFpEWf8Mct224D/hd3lCYBry96jJVE3LsRx+5ILQQBSWlKSCX41c+fWXRhWRUxbmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+cygregaWaKnABHRZj5lPlmw3YevbG5WiH7sqIp2T8=;
 b=o9WjJhFLkRpUriSFrVGlHLl1Ad0RNJ6pv3wBXZbdBfuFUxlZWTNF2j9tulf6KpUI1qkse0MEk1qAf3qngOxBVSsrymk3nFEKGDrcx/RRu/mAvSO7OXdz16nKVIDDIMybgb8/ILPIR0waW2IoDylyvLTuMxyMwkWDiVfOPHbp1JsWqLE2tVENrl+KWNC480vNU3UiANkIF2RYw8mh29BremCSCJKsajGW3jnrldWfrZM2eKq/hdqwM34JVYjH2LdoBJwdHnlVLZpN3rCFv1lPzEfBO3MXJ22Exl42OXlr9IfClNfSrwc1BW5WGuKoURxuH6Um97jsPijEO4lK2+gjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+cygregaWaKnABHRZj5lPlmw3YevbG5WiH7sqIp2T8=;
 b=RDGLAyCTH0it5C35JLdMrdIdP6YZNBhcloFmoKHNMYDKlHyqcotcLCIk5fXsmnl/cwDbzMqtubUM8Qm6l0lUQ60MUnYgKkBn4MiFGnfq1qa1LbSwmzD+QmrXbqOLWSME1+z8lHUKkDSXCjQkbapC1aMWmi/2bVU3ExxoesvvkXGWOWOThAtRnsAT/6P8Z0Na5ud+YHvHpW4tzFhVuGo5ULO1AMYBkXB3nenO+giWo1hpU0QZVSxFbhMb2V1veQNAzmXz29BpGwNC773hGZ8djC5KVZNVJ3gT6owvdyqFaH3pz1tIwEYc3Ejcp00uwfySz32SZs+D3Alh0YowGCRIxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 05:33:57 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 05:33:57 +0000
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
Subject: [RESEND v4 4/4] extcon: ptn5150: Support USB role switch via connector fwnode
Date: Mon,  8 Sep 2025 13:33:35 +0800
Message-Id: <20250908053335.36685-4-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb4fc197-7fe2-4399-4d9c-08ddee994e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZ7M4vRQjvIj2g+pMa6131JrED1nbeiCfhNTgj6lllWVw6fgkiitW4sGugmy?=
 =?us-ascii?Q?dk6VHHTAZ7fdonBKrRFZTlt+eLFYYwsWAe8rrPZnZl5t3Pl9keTLa38SKcRV?=
 =?us-ascii?Q?LcwAemZq11AzGh4VWu2SwYA20O8/UQ2v13t9OLtY2R7fDjD6dq/jm48HvSp6?=
 =?us-ascii?Q?UqSuLYAfV2aeGRYBuioo207FQTnQGaaHDo+dkgQzKY/0zFDlkPiPL9gPIrR0?=
 =?us-ascii?Q?wTGcXZea/UJyhLwLhR0M9DMDdcGIi4d9gMjqPCxAVJ49Y+VDrzan5hMBy9y8?=
 =?us-ascii?Q?TbHZZHMUGsP87bmQz6gfDHEEHMcJS2/WFpHqdCDJiINTwFqs2TiKdqcxs5Ac?=
 =?us-ascii?Q?vkGbf0jcH7j5UaTmgwc0ReGWJBDTVQnOxIHXKmRQGRbXbAeCTt/cOCzL404p?=
 =?us-ascii?Q?QCCrxvbIUJtZYthOj2/R4zTtl4T6/NZoHS32XTS4iEm1J2SGzOFQZRERFwQf?=
 =?us-ascii?Q?mj4W/7U5y5rRL6WeThNPhV5AARiZHLhMe3bfLF9XthVDWmtVSjaZclShqGnE?=
 =?us-ascii?Q?kIpe13W1uuJLrT25Bls2cD00o35TWlGJ3Rpf9BBaUARVnxIFPhCmof6juBHr?=
 =?us-ascii?Q?xgOboeOy/sNR5x6QNI8uDWgFwuSeOG+PDnZv26gK8M/VrWi8J3PtmxVK40oV?=
 =?us-ascii?Q?Yj+zGuQqoamFypR96/gTOd7vonUCeEpX6pUSbef8U+aONCH+fApodn8mjSS7?=
 =?us-ascii?Q?GQqzhJNHUa/DnEVmkYmTQdbJ5z5dIkaAbfuRqCqXXvtC6BDmYT8tQV93u/rS?=
 =?us-ascii?Q?Fnbe4XymjN+9ieAb2Jc7LRepu/xvnaxihTFL9CS4sj3la7rqqW01mXP4izPP?=
 =?us-ascii?Q?1Y30faWDEKdmsPs2MsGSDvv+ZSRgC6RMFKOl6j++vD7OXsNf21S5K6VxI1iN?=
 =?us-ascii?Q?JPGEvSdUFOGQqb9e22BrwmPANsSYOMbcSrbpXmLFVp9HaboJEOB7cvb1vmSm?=
 =?us-ascii?Q?2JllFAwkEXySHNT6cC5frskwp6RAuXo2nFZKyawBpOJyXawBcg1mhOn98oEl?=
 =?us-ascii?Q?2ppu8XPGiIW6GNjtX5OxfmmkPgO0ZT6+asvwwBx5NupG4lrdtm+HBUTmZcC/?=
 =?us-ascii?Q?OlmnyBmjiWw7k8Whfs762bBNkk+HGSGzrePSQpOVHIL+kH7pelScbKSnOofW?=
 =?us-ascii?Q?LPe5hwhe1TFp85wbh7X4jRM6jw89NGzl7ZGhfTlmpn1gfcy08iHWys8FWJKo?=
 =?us-ascii?Q?cVmcXMTazZegI1bfcz9RnlwoiYBphY/ARDCgzJnVYKj48aY6tF9VC1uykvbq?=
 =?us-ascii?Q?8EMXZGlcd+/6yc4yjVZfbV9IQ4DtGR6OOgixo+toHrdgy1p8UTDSywcdxMym?=
 =?us-ascii?Q?4xMfz1ikmxK6MaL1TsLcdpzRILizdD7xXaTX9r38iVfGqPEj5KYpmNKxWKyg?=
 =?us-ascii?Q?aeNqHdTJauO9vomcQAKUiJ3IWtmRq+GU5QcxY6jLRH6wlZtcBDqszFjSgJzz?=
 =?us-ascii?Q?+LIZpvs3QO30zQXjeN9k8/VlqLXP6V5dE9mJtbQ1L49NmqOY2UA/iA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVU7vUZjXBfwxH2hRm7zg+dbadgIx8KSUa+vKwGou+ejwT8wjBM4JqRDan9M?=
 =?us-ascii?Q?BjHYkwBlABAMXoPeFVlcc0zoEbdMqEIsx5qCjKuOwO2a9Bm2+4Hao6+yTaYi?=
 =?us-ascii?Q?w6PxKYcwH7hNVn4m1UFesitOcEopP/Y16po9WfwiXjnVYMeb7xOx/4mZkBeJ?=
 =?us-ascii?Q?7ed54rCpGfmpskcYPdSL1Nj/pj4BIi2E3WvQXJdEfMYRnTcPvq++sqd5GlEl?=
 =?us-ascii?Q?M5MdTaUFaRTem1DBCYCLbdaJ880IiqEQag+gVxA5wtxjOGSNc8GVkIasHVkT?=
 =?us-ascii?Q?zjRXIMti6RMRH0PJDXSedKCufIZ8KiyJWv6sKIQr55R30lpDPm9Iv/NJplG+?=
 =?us-ascii?Q?HT+U4cYqcftLyLPKPjbAAtvUESB3BAAsKkE8ceFa7/6Ibw69Ix6i5gBSqtHN?=
 =?us-ascii?Q?mA23jB7lvcmu7AXYvhS+sw7FUtN7ZGIG9Gj+rUAomA3M9anHoXLBiCmirqis?=
 =?us-ascii?Q?B7+oYPnMyR1DX47v8baj/QhwteOWnP8G5+gOpvZdbWm+oDUwESyW4z4C5V8J?=
 =?us-ascii?Q?F2gt+ngLOihm2uYlWOZXgbTMuoVk+JYWC3H+2DgOMUmwTz7u7Svp5PfYNYja?=
 =?us-ascii?Q?lZJQxhdERLyK7DyxwND1wK+XUqwQH90vr1N4BUui5Z7Tio79mOqsQiALkBaL?=
 =?us-ascii?Q?xMLqY5wzd/DiDK/JOBGL1Qoqhytd8GIA670M9PLa4WWF/bLIriAjLRRdhnVw?=
 =?us-ascii?Q?1YtBKcG5f4KMv0IRkiv9tXtXMkYlBUUihS5k9L6P5Nh6fh/PktTZzYVUNGDA?=
 =?us-ascii?Q?vZRWAznU88mMY1rYa6ahinZpernHJx+Or1xHOsLvw9Z+D6frMIBSTGooE/dh?=
 =?us-ascii?Q?crsuyIafRFc6FMdbpIpIIK/gE6Ux57RCzRA+DeU2a+AZ9mBv7JckB7fFEDuI?=
 =?us-ascii?Q?CEyF08Kw7VThlaoC/xJ4ZjInCMEIktBEPaxSXg9hAL1DwYskugWBGlSxB7lI?=
 =?us-ascii?Q?CBtyqVbbW5ShzlQH205cqyn4cjaqznq/xkVC6qdSi9R3Wx5uLbxOtw+zRFm2?=
 =?us-ascii?Q?6+h1MdXQdkF3E7ZeHIiNBxfiV0Kbz/CRD7mtg4q+HxLR8pIEV6OSKRotXFH9?=
 =?us-ascii?Q?QBUm/9hRmh2K/3XtvlyeWCXrP16gR+8GKPLVGC16mZpso+IJRJ/mvkeMTWkV?=
 =?us-ascii?Q?84nGAaYbGZztQaqKCTahRM2O9c+vyLEUz7PJLkaZr7ZPY8KoHGXxaHVZp4rL?=
 =?us-ascii?Q?bP5BMBf5VG7U+u1l1hXB7Q7ySBCqybhc4C8O8tpCSih0NDtp/9h4wDLKw0BP?=
 =?us-ascii?Q?MYKLgb3gBWAqSLCjT4lQ+MTUk/Qao6g+nAgx3CZtH9Zj6PdkWyfd/BoAbJ51?=
 =?us-ascii?Q?w4c/1EhfQ48jLixv0k9xdYL0EOF0Lv+Jk2Xk8xCdaKeAVVZ8DHv4ZVbAwM9b?=
 =?us-ascii?Q?/qJPYUSmo+VIKKP8wDB+9EBh8ysL/looOfMfZrSK4TghNXCdnpulykSL4pEl?=
 =?us-ascii?Q?4rPHFjW+GMf7SHeMAKcZfNZefUxuk7titSWewqdibMAF37vWL/JpWV0T3uGO?=
 =?us-ascii?Q?Wldg/eqG0a6dZzgpWSliIN8VfUxfgiww6Gz7EX4UQTiEW2RUQiaDoeyH/Ekv?=
 =?us-ascii?Q?P7GfHv0vnp+X3/tRtCI/SDi6OG4TWLGRZ1iHIQCn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4fc197-7fe2-4399-4d9c-08ddee994e3f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:33:57.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FGQGMhwOb38di2pb/gZoJFf89mmZ/Rm/g4Txwx4cYe1orQuycEIUs0S3s8itcHbeTWQ1BXnIb3GECQjQx97Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

Since the PTN5150 is a Type-C chip, it's common to describe related
properties under the connector node. To align with this, the port
node will be located under the connector node in the future.

To support this layout, retrieve the USB role switch using the
connector's fwnode. For compatibility with existing device trees,
keep the usb_role_switch_get() function.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - add Rb tag
Changes in v3:
 - no changes
Changes in v2:
 - improve commit message
---
 drivers/extcon/extcon-ptn5150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 768428d306ce..f33f80e103c2 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -352,6 +352,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	}
 
 	info->role_sw = usb_role_switch_get(info->dev);
+	if (!info->role_sw && connector)
+		info->role_sw = fwnode_usb_role_switch_get(connector);
 	if (IS_ERR(info->role_sw))
 		return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
 				     "failed to get role switch\n");
-- 
2.34.1



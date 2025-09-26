Return-Path: <linux-kernel+bounces-833537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB25BA2419
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD941C2269E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE6263889;
	Fri, 26 Sep 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jtcb6IR5"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB4257831;
	Fri, 26 Sep 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855199; cv=fail; b=c4tO5gdm46FnsLrvKtDrEQeoz0dRZXndypJ+sG1E/1cd48eqDG3DrwDrV2tBeTodFH3Pj/B0p9LvWfWIjfT6lpYMA3RjPJNjTbrXLDUqLaeqDupl/3idLXMikmkKPKaP/7P12JxQZRiLREOgPrKbz6Y1CnjWwfw/SYJO+xBmiyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855199; c=relaxed/simple;
	bh=g1mozhtQWBvAUN4TbRVaFSvVSK4HuwHyoZKxwD1NC8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eg9swmAyuMAz1yj78TmOIKWXrpMF+bF94OXRY5UwVBU/CgvtI9L7z0mo8zR8dAaPRZaS4Z+RltyxuuXrDKVZITBNRB8UfACsCCSAdcogz0wh0Xr/ns6ytKrDxdJSak7H49rU6g5eeiCBsw6EhtmlS8co9e2XlEZpPOfnJJ+Zryg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jtcb6IR5; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYB9xgP/lI/Gr5AFA+7Ku1SFZGriUNU+GtCSwgzw4PKH9wyHiihwhq8JFB3B1xwr5iDP+Gp332jJWA5kSFC0HM+5MSZ0mOeT3Foqp8exaeNwPl+RBbMi2LSK60RH6WyvY7uQOPWOXqx/Ofp+WvdSSrFJhaXV0fnD7K1vSyO7i8vdDGC3iETIoEKqpZPmZVUpfot5rG7xAwV2gCblsXpj4YQh5crx7w/5yVoM2vuH5VLuFaJdn7CMFRIMl8YZW9Z6t5efTXS6Zpcfah/GyeyrIiDUilT+eOPJ2BvF0xFHXpyR2tsy4uTHkahqGvr1LI0dU2YZTV+jjBYAF3FwXb9qGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVdTxSctB+waLr7sxn1YWvYWrbbWgOayIFpmzmwbMsI=;
 b=e8aQzdSH/EKMwWLYrlzPttbPYavujS6HT1xLaUyshOdRkGkW98+nfRgdmaxj8BddnX2+Ybl/00H+E797GdXxcPOKS350XJgbuNq+EuoOPMt/U8Lzw9U5aw0uhthQhruJJEZcsamHw20dm1nock94BmJKMuGG4d3hTBabiU2hnrm+mT4UeE2Zw/LybymVH9StG9UhzbrlLYxD0l11a/XAbibsRJcwvrr/DhbM97sqpzqnpjP15JusJpa2U7+GoJr7jsJe+yAbfIMzvisfQhVE++F++Pzy1bsIh9+CHbU6UUGUq4CzxDxPlHD7hNAwrfTg5ElVhBIvGiDYf9yJ+mji7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVdTxSctB+waLr7sxn1YWvYWrbbWgOayIFpmzmwbMsI=;
 b=Jtcb6IR5CUbj/YfDs7GM06AY1254cIKBA0CRKR/SmIhScHcrtGHPyal+54Yi08EI9Z1pwqNCE95q+Lsj8kI927yfnDSELDEAVyM9W7jljEx5JYBY7jWH17JpurANFSNYgHl3Ss6Pm1fu53bdT4yVpLoGeYjcL9p2wKrjqaFrKc8Sn1N41senaVD/6f6FEf7iA+lDvTZ54ln4Qi+Be19Pg6xpdOVcm0ZVvX8oDf9UeBeqnhV5J6vxhlLQmJALu/eW69Nj6OTvVZX+95RizC0jXY8EeHTDxms/lCtfOleIkWc5RD2enInA7KZaN0GU7AWNP7m5TYUgAipD7cUbvGftMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:53:16 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 02:53:16 +0000
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
Subject: [PATCH v5 2/3] extcon: ptn5150: Add Type-C orientation switch support
Date: Fri, 26 Sep 2025 10:53:08 +0800
Message-Id: <20250926025309.24267-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926025309.24267-1-xu.yang_2@nxp.com>
References: <20250926025309.24267-1-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98e7f700-6243-4497-02d9-08ddfca7d758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPV+bekB7U+oNRuVFLfnPDHRz76kXJPsIgNCQKfMTKkxoE32jfswtfOzFI1d?=
 =?us-ascii?Q?2w8f1ca4AQVtbU+KefsLs6S+XtjGpA+8XqnT7wbBkHwIJVhLTcl+0JWSUB3M?=
 =?us-ascii?Q?PWnHSXowA1KVdg+iEifObJv3I71rQl+jrWqmL3nDxpaqS6exAHhA/1H4e09w?=
 =?us-ascii?Q?LkJoBFGG3OmIejoqZh7iLL2rgY+2x31BynDTXLedBroyhrdcSDZ5fOWLhAYB?=
 =?us-ascii?Q?pziyRkIXhnXvuQ3qm/zWi3urNz5h0lvJk9RGkkIXKtUdPhmoTrDlaj3aeJZf?=
 =?us-ascii?Q?czNhTv14cW8IebYx5PCqJgqKKC3H+Ynbam6I6oHpUeZD+GEugagmdmu07uLI?=
 =?us-ascii?Q?mt7NIVhwDLXGsd/MG/+ER14SeRp1UpfS8DJbA9L+s9Bi8QVNKaQ4NojmD0wv?=
 =?us-ascii?Q?Bn/dtg/VEpad1jK4KU/BwPjlhsLasdEbbXnpkR8GNt5gqFeI9FpVTSBbhwaV?=
 =?us-ascii?Q?AChTcPz4Tyje6dcdAIlZxBjXPS3Syyaf6ZdprS0jqSeMvgQEyoMbkzjwZ1MA?=
 =?us-ascii?Q?EDtG3vew62uK5fd27edHBmsjHdgALOLiOrDRN15wwEBf60N8ASNk6jTo3DFm?=
 =?us-ascii?Q?9K1WPHJjtmUJiFtJr0livWtmHOfkT+nJX4bEUNFPCz8qP0hMe+Qc+qS0Y7Xh?=
 =?us-ascii?Q?mSivlg6xN0j36SJMh/Mi3ki763etuS+1LfEC+Z6/UsUiMHFB/qmWnD6WIj4K?=
 =?us-ascii?Q?uwE/3uaQr1bQBIRuPkHoDhumxfNkiW01yilBmjIhWLTx7orz0izL4jqqsHlM?=
 =?us-ascii?Q?z+Is/CndttQWqk8OWy3+vrEXfWtnw1/d/wJWIdl4js/MzdX/CQd+q41Djl9F?=
 =?us-ascii?Q?hW+YgGUw0p1VE5ggKCNfc90c7vJuLvld2BiM1rqvdZ9obZnshYmQR5X7GQwp?=
 =?us-ascii?Q?o3XiUJRN1IHfWG4TVsXnOPuwSdJ7bBNMtfliBbbZxeyl+wfNlqHClLs9DgIR?=
 =?us-ascii?Q?O/+0UmHQnHPEE5kP/65ABVkZqbF7Iv8g5BtsYrkT7eKRXKMhqCLTURSRmz/J?=
 =?us-ascii?Q?q3apz+I9umE5o6+/YZD3vwtGv6qUceFUWkbXVUH1TS8Jl0VxGIdHzgbpGUfD?=
 =?us-ascii?Q?u8Hc/aZfLq4AKuluiA8yvk2lICM6Bj63SFJYZaEdJHIDrGAMkq9EeSsaas85?=
 =?us-ascii?Q?t5mY9byLdn9kpZAqn7mGHrJMW4k1ksnAsypuorvEGxlIcrqemErc7mBKKfSJ?=
 =?us-ascii?Q?08OfSyv1vZ0dMX4Dy5l18W7EdsYlM/UZQwj/sIqa7p2JNpOaYuC7HNzIcWX4?=
 =?us-ascii?Q?2p+WGVqs55Kgyqf94MGLSCRad8tHd67qpXToymaGEBzOyM+rzk88CUc5S/8z?=
 =?us-ascii?Q?QUvOVDrzRy6MRsdV8EKKay28N4uCLZ/CICGb/IIqOLWEYSSHmWeyqVdxJN1J?=
 =?us-ascii?Q?xVtg4RK05LyW0ptEhR8JhXpa4mqKy4+umpKK7iL9oMBlLfiYDf+rNc/8k0Kj?=
 =?us-ascii?Q?peqfZpVSQeQPuI5gmIHXIqTzx+CBcETaPaSj98ISlPS/TztuQVeGvSCGVeZk?=
 =?us-ascii?Q?bz+2FiAtiAqluEhebg5bDfp+/zDBKU2YovtV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNr3T2s4QKZ2wM4QGX8zn2kTQBrngVxFysZpXs4XuqhaFukNWntt+emd0j8C?=
 =?us-ascii?Q?fIl7GHVBIyZxT905dgFc1gAoJ4U4WgLLxBij/udNLkSzq5HxS03w945PJGLi?=
 =?us-ascii?Q?/WHTYXlxGSrXoZHAbwzptsvfStaz+PIfdv2/zX/fLgHyVBqx0ROU7VgiL0jN?=
 =?us-ascii?Q?nPkn0pwOuO5L4R7J3YBpLUl6mX7r2uZSkuRyoLdLgjnnD4u6DqXVj6UZS1tX?=
 =?us-ascii?Q?gmsdXW8ewvtiV9m1PPht0fPViMS5ZPj4BAHtxrKqyfpaEfBDOYBuPEnz6nkI?=
 =?us-ascii?Q?lxM3/3P4m+4xKGj3iSoE4ZUMD9gXXx26wpNjzVjoon363nwnYL+Y4qWYXVFh?=
 =?us-ascii?Q?oIonRGIpyoArtu7eM4/n7QfiJbKnyWMltXk0+5bj8m/FOaHyoPe78VtQRugl?=
 =?us-ascii?Q?h8xDFQotJWdMk0eqqulKMgRBaMFUVJOOvfeW1nwsEm4SvPlzeuaA4Aify9p+?=
 =?us-ascii?Q?d/BRq4dZbiZbsdwIJ/v0WyGp3mcdh57ubzfI8rbrgS4hP/f635fF8eyRMW39?=
 =?us-ascii?Q?A9ezEorV42NP02+qD9GkvCLjhLBiXXYNgREsNxobIktPh/Ti2s4sQJeJIUHv?=
 =?us-ascii?Q?gXPrJMkUgmmLgIg5bzlcE2hXQ0sxyVUxslE/nHJPlk4SI4ntWUgTjc4folvU?=
 =?us-ascii?Q?Cd9CZ6jVdnVYpDJrUhJF4xorYBzh61Ji4ZRlVeVFoVr0ukZxdGLCqNocS08S?=
 =?us-ascii?Q?qS+4UN0plvuy0XNZiOa0euq8lg6qSuH9Dxy1xM2iPBp8pJG6h0sYbcUgPLfN?=
 =?us-ascii?Q?uX2at6mzGIdAgXW00BprCb2t4d8zFNDWH6OAS15Od/HofUtDMaO8QRa9ChFH?=
 =?us-ascii?Q?cdNrspU42BhV0ewOyr8svsR+z0QcNr8wz00ybo+ek/O5pfDeful5IysokaWp?=
 =?us-ascii?Q?BZ3OGO8Hhd1J7bv+mftUal3zeIJK1To6r794xDEmyrXZXoklrZFT3ZDX9JDR?=
 =?us-ascii?Q?/9CEiKUA1TfLhROfYYf2a7O6sssbyeZ6VeV7FU0nC3CmSwgt2URC0xyZ5wxX?=
 =?us-ascii?Q?7kJRjaU8Zuae/mUEzNQ9LV5DRXWG6lMQGxxzOF6A20FE1CoSF792jjAb9fHp?=
 =?us-ascii?Q?SU487/61xlquSmmr+7ni5povB83AM5ox4IpF0/C7IDgRLR0sCPzJ3hy1edN5?=
 =?us-ascii?Q?yiMKYYEzT3r/jCldiahXcdvaTvFDZfYjQJB2HZhJV1IUOoQ5bsNSeCpGE4Av?=
 =?us-ascii?Q?KS50NNz1jf8FNdxhTVmeheyscqFf8fuoxb6Wunx85UsSSW99IJjCd1lDObqx?=
 =?us-ascii?Q?ekWx8CM4c+9L8YGUH/nBE1egcvnLOx/eDMoWQchRh/eZRtHmtvLSN+NoMtan?=
 =?us-ascii?Q?b5nb8xtmFeVDc2Fj9pYYrKLOvaAjw2pianrqUX7Qc3RTJXD/wj2OhKkMv2pV?=
 =?us-ascii?Q?Me+zoIYJ0nGQhEhDvz90lJhgrmYQfeRB3P8NgyPTYyB3npJwmejjXMYbfQQ8?=
 =?us-ascii?Q?EOh5ph3FkWZk7RXXRKsNXlejgw61IBPdrb/S4894bTSgrRXOkaoIUPVFUzN2?=
 =?us-ascii?Q?MavsRxLUIYp+UwZEG82M1AevpCnggVK4jp7ZyIRpiC7Byk9r1itgZgLE73Tk?=
 =?us-ascii?Q?4brh1+TA6X0giiW3DyYTa+BYulZnf3XGXX6cuFaM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e7f700-6243-4497-02d9-08ddfca7d758
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:53:16.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWsRA5VO4JnVnahJ5ioVmdcOoTSyhWYTIYlhYceGhrtGlrwlYZjj+P/EysEfE1+XiB5ixY/tufrfPwpQuTWfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

PTN5150 is able to detect CC polarity. The field[1:0] of CC status
register (04H) will keep the result.

  00: Cable Not Attached
  01: CC1 is connected (normal orientation)
  10: CC2 is connected (reversed orientation)
  11: Reserved

Add orientation switch support to correctly set orientation of
multiplexer according to CC status.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - add Acked-by tag
Changes in v4:
 - add Rb tag
Changes in v3:
 - no changes
Changes in v2:
 - move "enum typec_orientation orient" ahead
 - improve commit message
---
 drivers/extcon/Kconfig          |  1 +
 drivers/extcon/extcon-ptn5150.c | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index a6f6d467aacf..fd4ec5dda0b7 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -145,6 +145,7 @@ config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
 	depends on I2C && (GPIOLIB || COMPILE_TEST)
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	depends on TYPEC || !TYPEC
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 78ad86c4a3be..768428d306ce 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -18,6 +18,7 @@
 #include <linux/extcon-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/usb/role.h>
+#include <linux/usb/typec_mux.h>
 
 /* PTN5150 registers */
 #define PTN5150_REG_DEVICE_ID			0x01
@@ -38,7 +39,11 @@
 #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
 #define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
 
+#define PTN5150_POLARITY_CC1			0x1
+#define PTN5150_POLARITY_CC2			0x2
+
 #define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
+#define PTN5150_REG_CC_POLARITY			GENMASK(1, 0)
 #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 #define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
 #define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
@@ -53,6 +58,7 @@ struct ptn5150_info {
 	int irq;
 	struct work_struct irq_work;
 	struct mutex mutex;
+	struct typec_switch *orient_sw;
 	struct usb_role_switch *role_sw;
 };
 
@@ -71,6 +77,7 @@ static const struct regmap_config ptn5150_regmap_config = {
 
 static void ptn5150_check_state(struct ptn5150_info *info)
 {
+	enum typec_orientation orient = TYPEC_ORIENTATION_NONE;
 	unsigned int port_status, reg_data, vbus;
 	enum usb_role usb_role = USB_ROLE_NONE;
 	int ret;
@@ -81,6 +88,23 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		return;
 	}
 
+	orient = FIELD_GET(PTN5150_REG_CC_POLARITY, reg_data);
+	switch (orient) {
+	case PTN5150_POLARITY_CC1:
+		orient = TYPEC_ORIENTATION_NORMAL;
+		break;
+	case PTN5150_POLARITY_CC2:
+		orient = TYPEC_ORIENTATION_REVERSE;
+		break;
+	default:
+		orient = TYPEC_ORIENTATION_NONE;
+		break;
+	}
+
+	ret = typec_switch_set(info->orient_sw, orient);
+	if (ret)
+		dev_err(info->dev, "failed to set orientation: %d\n", ret);
+
 	port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT, reg_data);
 
 	switch (port_status) {
@@ -152,6 +176,12 @@ static void ptn5150_irq_work(struct work_struct *work)
 				dev_err(info->dev,
 					"failed to set none role: %d\n",
 					ret);
+
+			ret = typec_switch_set(info->orient_sw,
+					       TYPEC_ORIENTATION_NONE);
+			if (ret)
+				dev_err(info->dev,
+					"failed to set orientation: %d\n", ret);
 		}
 	}
 
@@ -219,12 +249,14 @@ static void ptn5150_work_sync_and_put(void *data)
 
 	cancel_work_sync(&info->irq_work);
 	usb_role_switch_put(info->role_sw);
+	typec_switch_put(info->orient_sw);
 }
 
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = i2c->dev.of_node;
+	struct fwnode_handle *connector;
 	struct ptn5150_info *info;
 	int ret;
 
@@ -311,6 +343,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	connector = device_get_named_child_node(dev, "connector");
+	if (connector) {
+		info->orient_sw = fwnode_typec_switch_get(connector);
+		if (IS_ERR(info->orient_sw))
+			return dev_err_probe(info->dev, PTR_ERR(info->orient_sw),
+					"failed to get orientation switch\n");
+	}
+
 	info->role_sw = usb_role_switch_get(info->dev);
 	if (IS_ERR(info->role_sw))
 		return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
-- 
2.34.1



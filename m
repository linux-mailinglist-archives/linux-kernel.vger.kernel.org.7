Return-Path: <linux-kernel+bounces-868600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B017C0591C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E4DB4E5EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657730F94C;
	Fri, 24 Oct 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dcFZwcyr"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9330F7F1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301713; cv=fail; b=nD5b8XB6Z7k2meTvW73KzGT9vg+3AtfezhMxLo+CareakXFqp7KCqOvXYbdskPyOqjAhMDs15Z8VDVgFU9wfs4Pz26XozLZle2vYc20wEasgs3oDLkhrKRSS8K3qIfbzevU2Kwinvu8l6QC3Y17UlZFZf+kGWWgMjcSgbAQsIb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301713; c=relaxed/simple;
	bh=bTymKUBMoFm5z1FzROW0NnoLg+XoMQ7Ibe7SqX+NWNk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E74sbURW7ZL+C0aXpaLhQQ9U2cSQexyM0J6Yd738hjqLc6A2A53GA3n9EQaJOelNlZBLEXfHeuJkkLeUzcWsa07FFsww1J22Ov4WDBW0tWldwCNwejDm8clPhud6KfBtJLwPfxWEmD1ju/glFos3gc57HalP17lR/YIenG7KvQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dcFZwcyr; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEnMWmaH9g4dGwYjvY+EOeIlIPlLT/WGPTCXhlSyZaW/YhKa0UHat0+4Sg/puBVmPQ0uOPFq2DTaeFAkiOIrVKvSRzXOiOug23DRtuzw0q/4Ear9qri6tePJ3qffqtQ8Gx8MjEQoHlAwMpXkbgBuJRtq6McrtNkUeetxz76m+RLyWI4cbmeCSVjy9gkvPYPa+xUoAE5GeeeGirio7V/kr6Wb//4z5okMu9bmDJU4BzUdBaJVLgrigABoSgF7XS8Dfhj851gNyIl2DRJrmto5nbvLNf+6b9EhGl9b25MgmCjTuzlGqZyPMzJ1J44gd8Ny9UAIb4/2a+WCXdYJNjib9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeWd64gVSPsYzjRFIyorvscgbBqoyJqxcfp6e2FG2nk=;
 b=s9bZv4qECvcE2k5TkIjvQhF36IEqVTzWNgrmQD4S7w9AL85BEeTdPDEn0F7iMQU9eO0LmXfPih/zX5HnSgSlax1IHIXvlgJrvRQ+SKtwbgF7XM/cd+hi5OvQl1hSwZUP5oBhxqBD6azrIGBZIe8j2dC+mNDAFnNIRwy+Yg/PlHFoZBXiGy2U7+E1h8YL5UkYIgcIGQwo/v6rXHfwj3KoYyU2/qQK2D+OHZzyt41onjYscDsEsMIcUSRPu1rGdORBpNZP9EoQgpKiaElv8+lxfeVsLNubh2cYRXrE/jRTDqE7Bjytsur+DZTcCq5OKh1Awn1SUX/9oV7mDjL+z1KzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeWd64gVSPsYzjRFIyorvscgbBqoyJqxcfp6e2FG2nk=;
 b=dcFZwcyrIiRROCHEG+mIOISZQRaQ9/RBwZP7Fs2+NhzXLLa+8z/S1REspO2aS/0eHbRVjrk/zRlPTmJcphwcEuw4hCaGgjNp/K/Bj4IpEwp8RVtiVKi7hbpxZzZUkQUgxRfW2+pk0lXD3j7XAIDgGa4Zzx2jMKTfDVXHbUFgSDiiJ7P328w8nsRJqYfkDbS8cyV0I1P8wtYRUYnAtIWlLBHlJY8rFIxNrCM/Afpan0O/dWdYm6A/wNmDyqQon+SlvtAYnE57sMhbSQxgqNtMsp6p/4JRGo3PQImWzRlfy3yMH/4CLPFgF1jGoXF47IX1gMpwXtEuz/F6J7wcHbgD9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by BLAPR03MB5571.namprd03.prod.outlook.com (2603:10b6:208:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:28:28 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:28:27 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2] mtd: rawnand: cadence: Add support for NV-DDR interface mode
Date: Fri, 24 Oct 2025 18:26:11 +0800
Message-Id: <20251024102611.310568-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|BLAPR03MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c65b14d-e92c-40be-5ad3-08de12e81174
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xKsJ/pZoHl1Ry0f8TzVlQDiu0d6rk52K2+dMbpgwnwygCdG27HstXFo69TvW?=
 =?us-ascii?Q?fn4MYqFjj79vP5hemDJaIKAlOFQ1ywumLyM2Ao/6/Wt11up8dJoWppwqSx/J?=
 =?us-ascii?Q?P0w39kgxj+n9odjVKIXG3VXLpGkJKuyLMhkX5MBaXXxHqifilKku/ntO6Iv+?=
 =?us-ascii?Q?jespEiy08jX5nOxLGHCRn17oKiatWhg8AiQmhKP5QLg4fT6Duq62EIQx9IQE?=
 =?us-ascii?Q?gva5CDMNX/RQ0VoJNDMJAbGTTSGx0Mz2OI3S/wfOiPskYXF/sDF4KMsV2z0j?=
 =?us-ascii?Q?wiHPGW6Z414PJSkNzLacy3UBhttY5HEaqnupqWMoEgXVLeoJCQ42UVW041So?=
 =?us-ascii?Q?3IcGILFUVC6DuweexSSPqvfpaTMzZ0lCeGsmW56FhUhCFe3hoI4OMJFnAZsP?=
 =?us-ascii?Q?4iU30I/O222nmcw3rE7g/c8TMKtVzI8jcEiBNdOdtm47CY+C5QIcuZWk5Vr4?=
 =?us-ascii?Q?TzKkNUNmB1J4VhmoKdU3KA/hJlw1Uoy4XQY9Otg9QDLEO475YxGA5bkhy2hv?=
 =?us-ascii?Q?xE6vTvoQPrWM8S2MI0KdRUva5u5UUg+YwRACSghVtW6yE7MrPux3zQbN16dC?=
 =?us-ascii?Q?7v//dvRT/iFTdEMEkyPn9pYykeJ/dC658WbiXVJFJgj/Es3JmHIsJ70VBImv?=
 =?us-ascii?Q?W9PKWf6f48/FM0ZMC3C+t88aMJX6yuvcI9vbKSRevBC2DN2w2VfhdYpoB8zh?=
 =?us-ascii?Q?JHZY+3vcRAP3aHSc2QDFNRJk/hUmDHla4ObgW1KEZPxQud+VdpUYX3c9Cytk?=
 =?us-ascii?Q?z8dpDymui77fUy7eM4YmLgZLDx33rugk5TD5AVKu2bQBUgmEW1nBBZcpi8WF?=
 =?us-ascii?Q?DEMiVzc/q8IgJ+lbY9Ig8tJDyDmWFqBxeJLK982igjN1os2YW627zSvoTbia?=
 =?us-ascii?Q?ypiIMnJ0iNSms8rgzszJ/cvaVov9MSdI+VkbpLDZxvpPKuf1YkDXRhQRHoIb?=
 =?us-ascii?Q?EWSN622cJ4UtdqeAQ3ylwKzQAz5EAtDewdepU3tlB/UM0GUflEVmHB2CHGWL?=
 =?us-ascii?Q?vZtA7YLk1Go8SemAssU40ekFP0HiFd4mtBzT3Rk3ez9ojOk7aoJhfNPjteEJ?=
 =?us-ascii?Q?qFJm5XvHt0NB3z5Me6AwKsOkIflAllvR/ccywSV5GputMM8Ms87F22nYBlyG?=
 =?us-ascii?Q?fUrKzPeurhj/ajj+zEbjZNLuy+PS9eV3Up1GwUoX/78uemfgPfXAJH0k6h6N?=
 =?us-ascii?Q?fC7hK7t+iFM3rJTewtgkG1CBkUhzRQatHtDTgxPmTEYV5cYWX2+NCuOwqidf?=
 =?us-ascii?Q?Nbjv1szjRy1nuegjWXVZylr+VoCA7ktbpfkRL9VZWUwveDgma3CSl39yPNVF?=
 =?us-ascii?Q?Kv/EXTZkf+je3hulkQFohitGPL8LXz6zVuVsciaAoAnVW216eWqf6YIBBYHM?=
 =?us-ascii?Q?SsBKez7GhGUyM4JeD7USbUPBD7zf4Zl4wG3DlXA8lyGSYQhaww2YsZ/NXdln?=
 =?us-ascii?Q?UcOzISZpXS78Bn1+Zd70d0zU4+clWLLC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPAP5/D/nlh1augnQzZNoA0kXNkXFm/CsetzH+VohE6Prk8hOCHxuW9lmbhK?=
 =?us-ascii?Q?75rws+H1J1oP1G205Uw4o2wewJmuvyCKq3zHhDeBNMWWmGai/ZVQjJocXczc?=
 =?us-ascii?Q?4Vzt8OINwSY/ePYRUmBHC8YnDgdRLs5St0x4W1mDaAd9wWeCloV/7naKc3y/?=
 =?us-ascii?Q?7QJBYILyKN3Y15N4p82bSt81k9D0ZghgL0o89vB7gSODDNYIYGY9UbJkdJwe?=
 =?us-ascii?Q?hjmZraXC16PQZhU4+p9z+uKI72VKCagljid/Trfz1IugIWI7gah2EYv6lh6E?=
 =?us-ascii?Q?xV25sgFvH2DNV4195ZGW7gATFvNK0E4o2dmbKbPo5elHQI2g4HFHWrLW/X7a?=
 =?us-ascii?Q?TClOGZtvGWqiJaiYTi8Afw0BCjmcDDYaGfVBGLJdSiDYocUVDwQmmw8MRzdW?=
 =?us-ascii?Q?MIUZcMAkNbE7hGC7Zm+JjKzhmyjoqgdbwE2mKG6HvVPqg0i2uopr5oN4C65y?=
 =?us-ascii?Q?9N8rUohsb2Xwyby/fl2GiRkrhdBpGWJ8eAuE8ZaYBpB8qcanQJa+KM3+emif?=
 =?us-ascii?Q?hrGO1DaVXG43IGWDW0tJ9qP1/84M7PeQpL6nhqrnlJw2zNvB98u+M8/0G05w?=
 =?us-ascii?Q?oFbayNuQHKbCeGFqxe+vGbPqUbjpLzMsVRsS2yvcQ3XGZYUp6VjKrzKS1GfH?=
 =?us-ascii?Q?1RyIe6pAXaYeAiiSctzrgm5zO2MLJwhLPAaJbKa7drMeVDTgizF8ucso/9pY?=
 =?us-ascii?Q?ELpfkYQDJvgi5kyAnhB5w49VwXYsBNGxJoXSLSzpZqJBCkrdn00ihMLbM/GQ?=
 =?us-ascii?Q?OOOqFIyx7wbTQ7Y5k2euTsmgTdLSbJzyRoANCzKTqTMDsHIBnd2wVs4UVKXD?=
 =?us-ascii?Q?WnuiiUT4dr4DJcALJBbzrscVBkoB+gRhQlX7lbtgy0IqhdoeKq/9U/QQHm4L?=
 =?us-ascii?Q?RJuHBRdJoY1ots5UDRGR+h6NPB0FIAvg6PvqqEljOI0CO5OG6AgYallAw/K1?=
 =?us-ascii?Q?dTphXB3CYDR9E0ToNdnThj+hoHO+FCrw4+177m7VesBlxkYITV5vpTZA6PVm?=
 =?us-ascii?Q?/F+jTd9GKJqo/6wk6jNclRAHJpuCC/SDj+sizlsqhJP/0StMIScKYIZnlX0X?=
 =?us-ascii?Q?l0dwUkmL7MZKhyshfQyTzL+FoYdrwQ/sF+9NVelWftDh5Eov/hoQKDG5kTkT?=
 =?us-ascii?Q?oAe3jup0FhO4Tn90cBK1FyP4UTwgv+IusteRp8D4LcJVpWLStEBJerWVtJRC?=
 =?us-ascii?Q?2JchdL3wUyoRE4wzmeifk3yxJh1S3G8OFRQsCQCWnjRuwOC+Ti8F9W2zP2JS?=
 =?us-ascii?Q?X9dDFQ5J/reBhsdggd91Uoy+J83C12iFjsuet9b2TCYZYW5JXBUg55LheLCP?=
 =?us-ascii?Q?QEDrhrcltSTXWWlOjtG1a3Orxioi7BMS4YDmnnWcaOr8WcYm5WuPby8S2YxX?=
 =?us-ascii?Q?7kjW5b9tAINOQC82UOg9BEvRCq6iNEFMfqWjOFOYXEreskph1uO2hWxOAzJh?=
 =?us-ascii?Q?c7xXnHUyPBNj+Qwcq/xgRvbQHoMMw5gkCal0FAieG9oKkjaYSEpt/HQ62omQ?=
 =?us-ascii?Q?8855Zgzh+0rvaeVbw952Kl9KR9zUR0hVLTeL6dJHvUxNuIvashGgNxZ4Lc37?=
 =?us-ascii?Q?oXmhw3eywqwt2gP+KgWhlT1+6QxWUwE8e5ZIqtmSjyfkfPoLvaeE36jXyntO?=
 =?us-ascii?Q?8fGw+IazrJlXn2JIok3hbXrbD/GWOHVLTz9R5wrSn7aW?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c65b14d-e92c-40be-5ad3-08de12e81174
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:28:27.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TbHPk4X0JMOqFFG+U0IoHq14FU9cpXtBbnmGy/A+avflJhA8sJHdSTD0mHtYsTaN/pSiO6NQRPZMq7rZtRW9upDwjXisbhUsbDXCN0szk3hWoq0Vqqh5cfYMsPaquPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5571

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add support for NV-DDR mode in the Cadence NAND controller driver.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

Changes in v2:
* Rename NVDDR_GATE_CFG_MIN to NVDDR_GATE_CFG_STD to avoid confusion.
* Add a separate condition check for 'chipnr' to avoid mixing up with SDR
  vs NVDDR choice.
* link to v1:
  https://lore.kernel.org/all/20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com/

 .../mtd/nand/raw/cadence-nand-controller.c    | 273 +++++++++++++++++-
 1 file changed, 264 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 32ed38b89394..137e61e92117 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -199,6 +199,7 @@
 
 /* Common settings. */
 #define COMMON_SET				0x1008
+#define OPR_MODE_NVDDR				BIT(0)
 /* 16 bit device connected to the NAND Flash interface. */
 #define		COMMON_SET_DEVICE_16BIT		BIT(8)
 
@@ -211,12 +212,20 @@
 #define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
 
 /* Timings configuration. */
+#define TOGGLE_TIMINGS_0			0x1014
+#define TOGGLE_TIMINGS_1			0x1018
+
 #define ASYNC_TOGGLE_TIMINGS			0x101c
 #define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
 #define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
 #define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
 #define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
 
+#define	SYNC_TIMINGS				0x1020
+#define		SYNC_TCKWR			GENMASK(21, 16)
+#define		SYNC_TWRCK			GENMASK(13, 8)
+#define		SYNC_TCAD			GENMASK(5, 0)
+
 #define	TIMINGS0				0x1024
 #define		TIMINGS0_TADL			GENMASK(31, 24)
 #define		TIMINGS0_TCCS			GENMASK(23, 16)
@@ -226,6 +235,7 @@
 #define	TIMINGS1				0x1028
 #define		TIMINGS1_TRHZ			GENMASK(31, 24)
 #define		TIMINGS1_TWB			GENMASK(23, 16)
+#define		TIMINGS1_TCWAW			GENMASK(15, 8)
 #define		TIMINGS1_TVDLY			GENMASK(7, 0)
 
 #define	TIMINGS2				0x102c
@@ -243,14 +253,23 @@
 
 /* Register controlling DQ related timing. */
 #define PHY_DQ_TIMING				0x2000
+#define		PHY_DQ_TIMING_OE_END	GENMASK(2, 0)
+#define		PHY_DQ_TIMING_OE_START	GENMASK(6, 4)
+#define		PHY_DQ_TIMING_TSEL_END	GENMASK(11, 8)
+#define		PHY_DQ_TIMING_TSEL_START	GENMASK(15, 12)
+
 /* Register controlling DSQ related timing.  */
 #define PHY_DQS_TIMING				0x2004
 #define		PHY_DQS_TIMING_DQS_SEL_OE_END	GENMASK(3, 0)
+#define		PHY_DQS_TIMING_DQS_SEL_OE_START	GENMASK(7, 4)
+#define		PHY_DQS_TIMING_DQS_SEL_TSEL_END	GENMASK(11, 8)
 #define		PHY_DQS_TIMING_PHONY_DQS_SEL	BIT(16)
 #define		PHY_DQS_TIMING_USE_PHONY_DQS	BIT(20)
 
 /* Register controlling the gate and loopback control related timing. */
 #define PHY_GATE_LPBK_CTRL			0x2008
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG		GENMASK(3, 0)
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE	GENMASK(5, 4)
 #define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
 
 /* Register holds the control for the master DLL logic. */
@@ -260,6 +279,12 @@
 /* Register holds the control for the slave DLL logic. */
 #define PHY_DLL_SLAVE_CTRL			0x2010
 
+/* Register controls the DQS related timing. */
+#define PHY_IE_TIMING				0x2014
+#define		PHY_IE_TIMING_DQS_IE_START		GENMASK(10, 8)
+#define		PHY_IE_TIMING_DQ_IE_START		GENMASK(18, 16)
+#define		PHY_IE_TIMING_IE_ALWAYS_ON		BIT(20)
+
 /* This register handles the global control settings for the PHY. */
 #define PHY_CTRL				0x2080
 #define		PHY_CTRL_SDR_DQS		BIT(14)
@@ -375,15 +400,41 @@
 #define BCH_MAX_NUM_CORR_CAPS		8
 #define BCH_MAX_NUM_SECTOR_SIZES	2
 
+/* NVDDR mode specific parameters and register values based on cadence specs */
+#define NVDDR_PHY_RD_DELAY		29
+#define NVDDR_PHY_RD_DELAY_MAX		31
+#define NVDDR_GATE_CFG_OPT		14
+#define NVDDR_GATE_CFG_STD		7
+#define NVDDR_GATE_CFG_MAX		15
+#define NVDDR_DATA_SEL_OE_START		1
+#define NVDDR_DATA_SEL_OE_START_MAX	7
+#define NVDDR_DATA_SEL_OE_END		6
+#define NVDDR_DATA_SEL_OE_END_MIN	4
+#define NVDDR_DATA_SEL_OE_END_MAX	15
+#define NVDDR_RS_HIGH_WAIT_CNT		7
+#define NVDDR_RS_IDLE_CNT		7
+#define NVDDR_TCWAW_DELAY		250000
+#define NVDDR_TVDLY_DELAY		500000
+#define NVDDR_TOGGLE_TIMINGS_0		0x00000301
+#define NVDDR_TOGGLE_TIMINGS_1		0x0a060102
+#define NVDDR_ASYNC_TOGGLE_TIMINGS	0
+#define NVDDR_PHY_CTRL			0x00004000
+#define NVDDR_PHY_TSEL			0
+#define NVDDR_PHY_DLL_MASTER_CTRL	0x00140004
+#define NVDDR_PHY_DLL_SLAVE_CTRL	0x00003c3c
+
 struct cadence_nand_timings {
 	u32 async_toggle_timings;
+	u32 sync_timings;
 	u32 timings0;
 	u32 timings1;
 	u32 timings2;
 	u32 dll_phy_ctrl;
 	u32 phy_ctrl;
+	u32 phy_dq_timing;
 	u32 phy_dqs_timing;
 	u32 phy_gate_lpbk_ctrl;
+	u32 phy_ie_timing;
 };
 
 /* Command DMA descriptor. */
@@ -2345,11 +2396,9 @@ static inline u32 calc_tdvw(u32 trp_cnt, u32 clk_period, u32 trhoh_min,
 	return (trp_cnt + 1) * clk_period + trhoh_min - trea_max;
 }
 
-static int
-cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
-			     const struct nand_interface_config *conf)
+static int cadence_nand_setup_sdr_interface(struct nand_chip *chip,
+					    const struct nand_sdr_timings *sdr)
 {
-	const struct nand_sdr_timings *sdr;
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
 	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
 	struct cadence_nand_timings *t = &cdns_chip->timings;
@@ -2370,13 +2419,8 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
 	u32 sampling_point;
 
-	sdr = nand_get_sdr_timings(conf);
-	if (IS_ERR(sdr))
-		return PTR_ERR(sdr);
-
 	memset(t, 0, sizeof(*t));
 	/* Sampling point calculation. */
-
 	if (cdns_ctrl->caps2.is_phy_type_dll)
 		phony_dqs_mod = 2;
 	else
@@ -2633,10 +2677,221 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
 		dev_dbg(cdns_ctrl->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
 	}
+	return 0;
+}
+
+static int
+cadence_nand_setup_nvddr_interface(struct nand_chip *chip,
+				   const struct nand_nvddr_timings *nvddr)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct cadence_nand_timings *t = &cdns_chip->timings;
+	u32 board_delay = cdns_ctrl->board_delay;
+	u32 clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+					    cdns_ctrl->nf_clk_rate);
+	u32 ddr_clk_ctrl_period = clk_period * 2;
+	u32 if_skew = cdns_ctrl->caps1->if_skew;
+	u32 tceh_cnt, tcs_cnt, tadl_cnt, tccs_cnt;
+	u32 twrck_cnt, tcad_cnt, tckwr_cnt = 0;
+	u32 tfeat_cnt, trhz_cnt, tvdly_cnt, tcwaw_cnt;
+	u32 trhw_cnt, twb_cnt, twhr_cnt;
+	u32 oe_start, oe_end, oe_end_dqsd;
+	u32 rd_del_sel = 0;
+	u32 dqs_driven_by_device, dqs_toogle_by_device, gate_open_delay;
+	u32 dll_phy_gate_open_delay, gate_close_delay, ie_start;
+	u32 dll_phy_rd_delay;
+	u32 reg;
+
+	memset(t, 0, sizeof(*t));
+	twrck_cnt = calc_cycl(nvddr->tWRCK_min, ddr_clk_ctrl_period);
+	tcad_cnt = calc_cycl(nvddr->tCAD_min, ddr_clk_ctrl_period);
+
+	reg = FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+	reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+	t->sync_timings = reg;
+	dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+
+	tadl_cnt = calc_cycl((nvddr->tADL_min + if_skew), ddr_clk_ctrl_period);
+	tccs_cnt = calc_cycl((nvddr->tCCS_min + if_skew), ddr_clk_ctrl_period);
+	twhr_cnt = calc_cycl((nvddr->tWHR_min + if_skew), ddr_clk_ctrl_period);
+	trhw_cnt = calc_cycl((nvddr->tRHW_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
+	t->timings0 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS0_NVDDR\t%08x\n", reg);
+
+	twb_cnt = calc_cycl((nvddr->tWB_max + board_delay),
+			    ddr_clk_ctrl_period);
+	/*
+	 * Because of the two stage syncflop the value must be increased by 3
+	 * first value is related with sync, second value is related
+	 * with output if delay.
+	 */
+	twb_cnt = twb_cnt + 3 + 5;
+	tvdly_cnt = calc_cycl(NVDDR_TVDLY_DELAY + if_skew, ddr_clk_ctrl_period);
+	tcwaw_cnt = calc_cycl(NVDDR_TCWAW_DELAY, ddr_clk_ctrl_period);
+	trhz_cnt = 1;
+	reg = FIELD_PREP(TIMINGS1_TWB, twb_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
+	t->timings1 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS1_NVDDR\t%08x\n", reg);
+
+	tfeat_cnt = calc_cycl(nvddr->tFEAT_max, ddr_clk_ctrl_period);
+	if (tfeat_cnt < twb_cnt)
+		tfeat_cnt = twb_cnt;
+
+	tceh_cnt = calc_cycl(nvddr->tCEH_min, ddr_clk_ctrl_period);
+	tcs_cnt = calc_cycl((nvddr->tCS_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
+	t->timings2 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS2_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, NVDDR_RS_HIGH_WAIT_CNT);
+	reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, NVDDR_RS_IDLE_CNT);
+	t->dll_phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "DLL_PHY_CTRL_NVDDR\t%08x\n", reg);
+
+	reg  = PHY_CTRL_SDR_DQS;
+	t->phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	dqs_driven_by_device = (nvddr->tDQSD_max + board_delay) / 1000 +
+				if_skew;
+	dqs_toogle_by_device = (nvddr->tDQSCK_max + board_delay) / 1000 -
+				if_skew;
+	gate_open_delay = dqs_toogle_by_device / (clk_period / 1000);
+	if (dqs_toogle_by_device > clk_period / 1000) {
+		if (gate_open_delay > NVDDR_GATE_CFG_OPT)
+			dll_phy_gate_open_delay = NVDDR_GATE_CFG_MAX;
+		else
+			dll_phy_gate_open_delay = gate_open_delay + 1;
+		gate_close_delay = 0;
+	} else {
+		twrck_cnt = calc_cycl(dqs_driven_by_device * 1000, clk_period);
+		dll_phy_gate_open_delay = 1;
+		gate_close_delay = 0;
+
+		reg = FIELD_PREP(SYNC_TCKWR, tckwr_cnt);
+		reg |= FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+		reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+		t->sync_timings = reg;
+		dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+	}
 
+	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_STD)
+		ie_start = NVDDR_GATE_CFG_STD;
+	else
+		ie_start = dll_phy_gate_open_delay;
+
+	dll_phy_rd_delay = ((nvddr->tDQSCK_max + board_delay) +
+				(clk_period / 2)) / clk_period;
+	if (dll_phy_rd_delay <= NVDDR_PHY_RD_DELAY)
+		rd_del_sel = dll_phy_rd_delay + 2;
+	else
+		rd_del_sel = NVDDR_PHY_RD_DELAY_MAX;
+
+	reg = FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG, dll_phy_gate_open_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE, gate_close_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
+	t->phy_gate_lpbk_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_GATE_LPBK_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	oe_end_dqsd = ((nvddr->tDQSD_max / 1000) / ((clk_period / 2) / 1000))
+				+ NVDDR_DATA_SEL_OE_END_MIN;
+	oe_end = (NVDDR_DATA_SEL_OE_END_MIN + oe_end_dqsd) / 2;
+	if (oe_end > NVDDR_DATA_SEL_OE_END_MAX)
+		oe_end = NVDDR_DATA_SEL_OE_END_MAX;
+
+	oe_start = ((nvddr->tDQSHZ_max / 1000) / ((clk_period / 2) / 1000)) + 1;
+	if (oe_start > NVDDR_DATA_SEL_OE_START_MAX)
+		oe_start = NVDDR_DATA_SEL_OE_START_MAX;
+
+	reg = FIELD_PREP(PHY_DQ_TIMING_OE_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_OE_START, NVDDR_DATA_SEL_OE_START);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_START, NVDDR_DATA_SEL_OE_START);
+	t->phy_dq_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQ_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_END, oe_end);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_START, oe_start);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_TSEL_END, oe_end);
+	t->phy_dqs_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQS_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_IE_TIMING_DQS_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_DQ_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_IE_ALWAYS_ON, 0);
+	t->phy_ie_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_IE_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = readl_relaxed(cdns_ctrl->reg + DLL_PHY_CTRL);
+	reg &= ~(DLL_PHY_CTRL_DLL_RST_N |
+		 DLL_PHY_CTRL_EXTENDED_RD_MODE |
+		 DLL_PHY_CTRL_EXTENDED_WR_MODE);
+	writel_relaxed(reg, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(OPR_MODE_NVDDR, cdns_ctrl->reg + COMMON_SET);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_0,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_0);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_1,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_1);
+	writel_relaxed(NVDDR_ASYNC_TOGGLE_TIMINGS,
+		       cdns_ctrl->reg + ASYNC_TOGGLE_TIMINGS);
+	writel_relaxed(t->sync_timings, cdns_ctrl->reg + SYNC_TIMINGS);
+	writel_relaxed(t->timings0, cdns_ctrl->reg + TIMINGS0);
+	writel_relaxed(t->timings1, cdns_ctrl->reg + TIMINGS1);
+	writel_relaxed(t->timings2, cdns_ctrl->reg + TIMINGS2);
+	writel_relaxed(t->dll_phy_ctrl, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(t->phy_ctrl, cdns_ctrl->reg + PHY_CTRL);
+	writel_relaxed(NVDDR_PHY_TSEL, cdns_ctrl->reg + PHY_TSEL);
+	writel_relaxed(t->phy_dq_timing, cdns_ctrl->reg + PHY_DQ_TIMING);
+	writel_relaxed(t->phy_dqs_timing, cdns_ctrl->reg + PHY_DQS_TIMING);
+	writel_relaxed(t->phy_gate_lpbk_ctrl,
+		       cdns_ctrl->reg + PHY_GATE_LPBK_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_MASTER_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_MASTER_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_SLAVE_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_SLAVE_CTRL);
+	writel_relaxed(t->phy_ie_timing, cdns_ctrl->reg + PHY_IE_TIMING);
+	writel_relaxed((reg | DLL_PHY_CTRL_DLL_RST_N),
+		       cdns_ctrl->reg + DLL_PHY_CTRL);
 	return 0;
 }
 
+static int
+cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
+			     const struct nand_interface_config *conf)
+{
+	int ret = 0;
+
+	if (nand_interface_is_sdr(conf)) {
+		const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
+
+		if (IS_ERR(sdr))
+			return PTR_ERR(sdr);
+
+		ret = cadence_nand_setup_sdr_interface(chip, sdr);
+	} else {
+		if (chipnr < 0)
+			return ret;
+
+		const struct nand_nvddr_timings *nvddr = nand_get_nvddr_timings(conf);
+
+		if (IS_ERR(nvddr))
+			return PTR_ERR(nvddr);
+
+		ret = cadence_nand_setup_nvddr_interface(chip, nvddr);
+	}
+	return ret;
+}
+
 static int cadence_nand_attach_chip(struct nand_chip *chip)
 {
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
-- 
2.25.1



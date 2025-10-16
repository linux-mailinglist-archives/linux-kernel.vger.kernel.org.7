Return-Path: <linux-kernel+bounces-856352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA2BE3F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A961A65813
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C0334164D;
	Thu, 16 Oct 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AA7WDiPk"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70D340D95
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625520; cv=fail; b=jIDzZhT30y/lEJMolAx9lSutLKeLm7y1iElkvjCl+s9jvwbQxfYYbMh2lkvLjY4vqvyA2/GckLCdqvlzsGpfmnlCcQmLt7DAz6lXZ/AUA2QgFzIsuz/Djf/dUrNSImA8xBY5B6lJkDc1XKQh07cG+3wmGvXefu0txRMOr3mQi/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625520; c=relaxed/simple;
	bh=PdgZQPwm5IJWUTBNO8U6EeaxJAQy3kE/psTQx+GFpdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pkXXIetln7fSlA5NSSBwATr9QU86+YO1xGyLWuWKpOumIXyK38ttnTfq/6VEpKOXbVA0ybRlp+B7oxkGmwB5/dcSs+Glr4QKP4BS0eRZQtNR8+3wxlNjpQkF6BmZv4unIozJXDJbURsfBz1l2PIGhI6FaVV7+XB0NgWp73gd2QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AA7WDiPk; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5bk730QhgFguzkWiuAaob6xWpHedwNtV7opuSoLQ9Ck1tVcxJCDQvK5sWaPFZfva2k9LV+IthhuzrhWvSfhlbeTdxixhpv5+nmn6QjU9w+zZZSY44SEJWj/EyRTmWlq159f8ljfou3/A/0W6iTVKnHjqltPUKPaO1XMMPvzJ9nEXHTOMUETDNG6sXJf4fVg7mR12cttzbC4AfBWp1ZzSVEz5ttd+RpDI73wf+w7/LxotN8OitopXvPiBWEEHeKIuc0ahifVOMwYw/ImJR/fNO1AhtiAvknOofvilWBPttxGmjZvYHH3zGGZ6m4qEpn80VxvjGjxtdelP+lPqRFZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ghXB2tMb7CmNLLhZjOMyxhDLehzwRKIVMOf4GHVTbQ=;
 b=CYfCkml5+J3K7a38FADkKymeXnJh2zJo/0oumlK6m5viHUj/pqhGVNOyZ21fyuvs7MUqaQET+pX3AipZXqSmEzvbkuMBycVAfrh3l9/yzgwrXh2y+ci59IGxxqnmQvDSofuZrRzg/31gCjGNgph9BShXFzpCfOWfltvD64nlWHAw/4q2lYobwgI26haczFu0ZzbUJSL8bdk9ilRn5Y4mZdTXNGLs0G7Vyxq48SdwBKzweWEEgP2DsXh3kBwL6uqTH6rwdsqQ9cwiSfX8jTrgcPAxhvmADPk1vyJ7zRrtq/qVqpCumjCYydSuy0p+5S3iRrbwfxWI4WxuOUOOyeo3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ghXB2tMb7CmNLLhZjOMyxhDLehzwRKIVMOf4GHVTbQ=;
 b=AA7WDiPki9S6sV7BqBb9qyOPCbLJ1CTY8Whf/cLhia+l6ljfZ9ppf/ACFFcGtBk1pT75TsF2+kNouS6h/VOHchrGpXOvs7cTiC1HbM+s3DF8yTT3nsz8LH7J1HIrkdibuROLqLCuhCkw7G1q56yUD/0nAS72L2xuacYWXX/nIgtpWoWbC4yQHG758LWE3fzLbIBUkRddy3tRomhaEFVhvmXpF2FYuTZuGlFIkxT3wj1n/xWqdADPFQNH0PHgpArTf8YF+LU9xmORoBmBCBshAtt+ESKvkiSoXXkxNDKA22EVAS+kNpIqXQilFYdu7wcTypDG40jzy3G1D4B9t231Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10271.eurprd04.prod.outlook.com (2603:10a6:150:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 14:38:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 14:38:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: markus.elfring@web.de,
	imx@lists.linux.dev
Subject: [PATCH v3 1/1] i3c: fix refcount inconsistency in i3c_master_register
Date: Thu, 16 Oct 2025 10:38:13 -0400
Message-Id: <20251016143814.2551256-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10271:EE_
X-MS-Office365-Filtering-Correlation-Id: e922c0a6-e4eb-4e03-ebca-08de0cc1adcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/H5uSzmNW0GBPLmTx4JTYh1wyhFI0avVvo59bbuAVI76OypVGN8iJ8Ca6DTT?=
 =?us-ascii?Q?XzhbBSNA/rzr17BGwbTIMsMq7SQLZAmkHdkBRK2+XN+me4T49mkv65YYNZzH?=
 =?us-ascii?Q?MmOPIBWA0GeNNS3+8B7GAIC/lnYAbGjU+0mabrFzL1HVW/diIAfQ4o4uWRHe?=
 =?us-ascii?Q?qEgOZLNJPsM46HjkAuc3OsQx1paaamBBUPPlIgGdUqPkbhC5d2oVxIjxhR7x?=
 =?us-ascii?Q?MrramoQCcgknDSUZWKhb3DHT2OdPgfn51Y/FPtJRp45Jw1ghYIZtKLfEBT21?=
 =?us-ascii?Q?umEUZMqchhwKDqkF55iI2g3cjERfqxyy4ms/oK9n37IXYSVzXR+gBpxCQlMd?=
 =?us-ascii?Q?rJqHSfLwTuHw24u0HsNdRXCU/wR5IHygHv1osKpsy5SIrF/dTgtvMs6A8xYy?=
 =?us-ascii?Q?hPkMenUhOdHUJlCTEzpz2VL2sRvDbKUniN2D+/3FD95F6SzzgoADVCszAb3M?=
 =?us-ascii?Q?mRjwrkYIEcsoiqti4yge2mlT3ZmOfwh9Ajnelfyo2vncAu6iBvLS05q3rQvn?=
 =?us-ascii?Q?eARuwxFFcvE14so7M6tc8dMrwMAFrKNWMMPIWoU2iHv1ZwMJZh3WDGBRX+VL?=
 =?us-ascii?Q?wS2qQxWB4+cA9P4KYHDZvVonD0FijRyZs48clD5qhdzwdVZ2jCv5izJAs6ZL?=
 =?us-ascii?Q?3ptRMmulnz0gQWuzKoiqIh3ii4mjkhAAlVXplFSHjJOAGzDYq3iJJ7xL0N3s?=
 =?us-ascii?Q?jsdqp+1N0n1/0Fa7DGDfrn8zIs5hY43nrjNwgOl2WPgV3Blf8ntoGMC9qSaw?=
 =?us-ascii?Q?54jn9pYOJj6shTvR/feP0ge7f5I+T4caSWHzNEIaCfRlRU73mcgYr6NLeabh?=
 =?us-ascii?Q?dXABtUA9CMbPWVOsDdQC7cQVzxUvcS5x2as/E+XBSMIIa/TD8+77fjreMoxS?=
 =?us-ascii?Q?XJ2q3zDIdjwPqbT76GlrdyQqMxWHkeodbhiPekR2vax0fLdgXbRwrdZgO1lG?=
 =?us-ascii?Q?ellffoDd6fksDH6M/M3CB5XsRY5S9Qi8zMS3Fv/4XR502xOIq06m41bvBsH4?=
 =?us-ascii?Q?mEaEqnGRq20jUMEh7mIJ4+c2rVkaQ1xqdevXXwwr73UvSfoiZ5I1O5CofzgP?=
 =?us-ascii?Q?jId6qwVRFDPF+nF1vcoZ2zxWZIMOnyLIxMXWojLlcvZ6BcqmupdSRxhsna7u?=
 =?us-ascii?Q?t3D6kHWdE+jY2Z1ylxFyarQ1PySq4ZPqTsotyQFslz5L+1JonbxDZs8tCscr?=
 =?us-ascii?Q?AeHjiT2I3g3vIyB9+HJEbZQ9CCCdgYsT3jG+IOxZrWpB9RIZYvP1ASQQwVeo?=
 =?us-ascii?Q?MjB7899vs6LnOlpQKUS2oL4MfyBk8EvdRCjd7sbNi94DV6NV5Evvqay56yS2?=
 =?us-ascii?Q?l4EkB0WA9D1bhtgy6R3yUrMsU5I71TDNLM2hfsF0mZA2lF1TnDdMcdhrGD0D?=
 =?us-ascii?Q?jcbkMHdgrXLxPcqkJbSACRHUfs8fi/S4qZMBsMHVQ4ztac7DmMYY19UkEyy4?=
 =?us-ascii?Q?U4yp24nkoe3TXOeUrmHyMYaXqK6UVrjfY5uFXM5oX0JwAEsfeDZ5hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1i/HApiTfmar/gaZf0IjiRKlDhXiMyjCA1hSY7SFcNOj+hLEDbuOmKUkOHqk?=
 =?us-ascii?Q?hGkk7M+23FrhPR9z2mfKJFM2p4w6meEkX1FK/Vk4Js5N9g9XZkjmA1nPyIOS?=
 =?us-ascii?Q?Cvqn/zuhrWz+7Y22GrJMFzTKEkdA0gIEHAltyNwQ3QFKxHRc8uCFD3KwwoXZ?=
 =?us-ascii?Q?T3u7iSXKIcqrWl8TrF9f86ifk8MGln/9IgP/y12PhmRQbH0pn0rDVFBrKeX5?=
 =?us-ascii?Q?FvS/1Go9P9uu8HlIFdBR6KeLDlRgRGC7xKZtU6M9lXRMqUBbxvT1ABQf3dT+?=
 =?us-ascii?Q?w4/V6QFUV/OPW+oXXxzqiIIeJXoNIp/z82i9bqgKpBzhLy6o6mFvsHJQUIfm?=
 =?us-ascii?Q?aupJup7tlnBLM2BcfWvjE4HTp+cjQFR8m4G2g1s/bEXmRDFCEVNxDSJaQypm?=
 =?us-ascii?Q?JzL1bxP969fQTJ9q82xtHMIzIFx5vUDgbHwZYFZTQ4jrxDPQN9/8Bul8DDke?=
 =?us-ascii?Q?mI0vQi45D8s61VDiV7Ffbkr1uVGvt2xHKt9AzD1LWVPXX3t1cu3s7YHKXHcE?=
 =?us-ascii?Q?3ii987tRMeOaOJ9K7k9EUOruufFOn11FeaBCuGmmbXYr7XHuhGXtNfk4cP94?=
 =?us-ascii?Q?2JadT1nej7i8aVaCR6SeRp+DPeEjecFGO9q6cQ8hce3o/rcuU56PKa1frAn1?=
 =?us-ascii?Q?/MMxCrd1mLbDTPR24I+1a1jQt8RqPD7dfBn/zNimNm045/zKAzpXeKvF/f5o?=
 =?us-ascii?Q?pzDrnwcJf6hugkImf5Fu7R5TjZFGAmeFSmyrSucM9fsBgjeWMbZFNcKbPNA/?=
 =?us-ascii?Q?ALSsGkpgJUqOxCMlxlp8CQaydqjEDPAqPil75XcvQ7GPSApBmIhEjh00uOHh?=
 =?us-ascii?Q?oCgmtv9zQ0UQTcRRhuGMAeCd7Rr4IrgUPcyYDSM7dhtdmYX9Dgdwur+wBKuw?=
 =?us-ascii?Q?/Qqw0UIR5zJEQStoQ1IiotV68f2pke7UpmsKzM6BcYFDaAv+AQLdkfNwb99y?=
 =?us-ascii?Q?hVb6JaXBsMvBW2dGgS4os4yZ16wH4EOYe5e0UQY2VogHpTa3PqSUJtaLgavM?=
 =?us-ascii?Q?XokjBJsZDjbu/q8aLURdfDbkbBVZMepFnXcjmTTPbz/QSlP3U1fgkKwoQNXK?=
 =?us-ascii?Q?aIGZ/VUBBVtIFuJKpSYgjFqebXi+FW9J6mW49yAEE2dVfMRTnZ/SE3w8s3nH?=
 =?us-ascii?Q?4LvB3R82t0uNIrQdImNGhtzZKdgV1IZ4HIskHOOa/6O78p45v2sV7OwCCyjM?=
 =?us-ascii?Q?A+2QjAT1TwYYNeR/ZVO7X1Ohfb8g8s9+D5HuExGSzpf/RmpesgPKlQn5wEX4?=
 =?us-ascii?Q?t+N1voLiezPZYLVOgzv1OQ1uUswBEp0sp70FU3WvIdqgAgOl5dk90sNi9Yte?=
 =?us-ascii?Q?nfrxCboE8TGA0Pd8OvOGpuM2YTXw+jv1oBLmAqj4x5pT9et+JlRJLeZ+oZ73?=
 =?us-ascii?Q?vjOJU18jNK2CxHIe6Qaae+EAQJkcSKRiNojjn3SMSmIU6+RxQu9dkprL60NS?=
 =?us-ascii?Q?Pz2ottAPkWUMyg4Z9+a3UkKpuISaq9OI1iEMByRe6qsCTU1sliaHGdszPhos?=
 =?us-ascii?Q?U85GBuC5tEG8RL1Ww7Djh4AIT02nRbqLnksCR44VaZ4O1swepc7GBKLS+Njk?=
 =?us-ascii?Q?1sIIb811F2MC0reXY+Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e922c0a6-e4eb-4e03-ebca-08de0cc1adcd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:38:31.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jdatFfO6dFlf0lkLkeW6y3828TVgJh5HKrRXQfwpDCxT5ZpBctUF/nS1qI4rNeNKRZ2onAeifxaxHz4dVkqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10271

In `i3c_master_register`, a possible refcount inconsistency has been
identified, causing possible resource leak.

Function `of_node_get` increases the refcount of `parent->of_node`. If
function `i3c_bus_init` fails, the function returns immediately without
a corresponding decrease, resulting in an inconsistent refcounter.

Move call i3c_bus_init() after device_initialize() to let callback
i3c_masterdev_release() release of_node.

Reported-by: Shuhao Fu <sfual@cse.ust.hk>
Closes: https://lore.kernel.org/linux-i3c/aO2tjp_FsV_WohPG@osx.local/T/#m2c05a982beeb14e7bf039c1d8db856734bf234c7
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v3:
- add fixes tags

Change in v2:
- use i3c_masterdev_release() to put of_node to align other error path

v1 by Shuhao Fu <sfual@cse.ust.hk>

https://lore.kernel.org/linux-i3c/aO2tjp_FsV_WohPG@osx.local/T/#m2c05a982beeb14e7bf039c1d8db856734bf234c7
---
 drivers/i3c/master.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2ef898a8fd806..8efec085d396c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2811,10 +2811,6 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
-	ret = i3c_bus_init(i3cbus, master->dev.of_node);
-	if (ret)
-		return ret;
-
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
@@ -2822,6 +2818,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.coherent_dma_mask = parent->coherent_dma_mask;
 	master->dev.dma_parms = parent->dma_parms;
 
+	ret = i3c_bus_init(i3cbus, master->dev.of_node);
+	if (ret)
+		goto err_put_dev;
+
 	ret = of_populate_i3c_bus(master);
 	if (ret)
 		goto err_put_dev;
-- 
2.34.1



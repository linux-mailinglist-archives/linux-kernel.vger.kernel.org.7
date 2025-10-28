Return-Path: <linux-kernel+bounces-873080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F9C1304D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209493AADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417229D280;
	Tue, 28 Oct 2025 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vHL4VDtR"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE119213E89
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630415; cv=fail; b=RkDJeai5oaR63B22EvdcjvMZMRqFkixrUEJjtNmKg/Qh22zZ+cwUrLxqmmN8Cil7+BClFPqRHXEWzAYxywjht+a5VbQMdJYbcxOttFTLKTnRsW3FsfPuTv66GTocZtRJ085LdYVnuROEBex8OJswwbL+IMphSg60/B+fZpEhJWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630415; c=relaxed/simple;
	bh=Lt22kY7uASwXrNcNr58Q8T9X2f59dZECJkc0ktilLdc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZHe9Z49a89eXWHa8aYhRxko2oeUIM9kXkc+sZPOJPf3UD767tP8sny8KHsDnr9TYPq4ac6aLaAzbSzL0oPCEziMmpTQv7MDHAhZ+yoL1xfT1tIsOktp4SLcwHpn+Lb7SAHEirLb54/xdmz+GYm2BvKnMUQEG2aq/uXmf34Ocv1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vHL4VDtR; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHYWfwO5y06Lbkq4lj+GVrxZcwMf1QJkd/cNvK3sISiGtPQOpyYZD92E5dhMccS/wFTuYhR4aExuBP8sDEK5yzK7Ak1j3KPB4OBf65QEFTA2HdU2FZEoOXvxeTL5+FuMlTxmM41Misxm1OUoM8Pbr4ufWN8tl65rJOaPX3fmgE2y8+u3pQoiYeE4FDI750hhJCVtye+5fHkaMFflEffHaCR5S22GWAiBSV58fWQkh0zL4MRrfiDId6M5lf/bC4Vz5UFi2ifmc1kIo+E6tQtSPOOPBySQJRkjrGj8EL4/yWbX1/9RwhEQRM6yqIOG7FMGQOh5hwPsU0/WEDmU+weHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoxoqsMeuEpMOjJMwOkH6jvQAsUTfIapfi5ZEN5XL3I=;
 b=FE7eNIGiLBGhoWk/Jt//3Bltaktpi3VGciYFQMWVqwimlqhXkZzq9YgNH9PzcuUc0dKBuZJWuxuyrEifXWn713ldhNahlLNrqX0aQDGnQqRwBRV47bPYmzX+6JaQSpgWA0JYoA5pNrkcIzD6b+lOVykCW2teRpKiNUC0EN7FBrC64ZyTyz0MYm7iP59xxJLqL1JwJ2rC7w8jVmcU3O/93RCgBRO6jaWrIiNQ5mypHm4S3QD0Th773rjKgxGJ5RDBKoo246xt4xYWp3oSi0+A2iiHGcGwYrARa1TlXWrhzAhugZY4opkl/Ev4E24Nnj2V//JajOXRK9LKKvU9tad/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoxoqsMeuEpMOjJMwOkH6jvQAsUTfIapfi5ZEN5XL3I=;
 b=vHL4VDtRbM2IjPPro5/AtYsWsJF5hAIhWcBiJqNLXdeIlO31jpl4eAVRErfcOyewM35KN2047dTM3Ic2hfpZTFDrlBjGSFjLZLaQBn4sr4iv4PuByjwTFWrUJgTda7pEkZR0CBga5wswIqA4A2HV66yfk+AQnKBLR8iRGjGZXwFvIrz2j+zKj/ncSZZifxbB++eQZtwEh+6AvdOWxHOVDDoCos8KyZXGMQjpktR6KSbPKJETnEZDwM5h/AgKW689N3F9F53S5wk85+TlE4Bc8BA5iVO1npCDmS7wciP8sdoaeX5pr+wIHeFf7tvdT2IkbtHlhmyl6/u+TqQsHXmfLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA2PR03MB5865.namprd03.prod.outlook.com (2603:10b6:806:115::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 05:46:51 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 05:46:45 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mtd: rawnand: cadence: avoid NULL dereference of DMA device pointer
Date: Tue, 28 Oct 2025 13:44:37 +0800
Message-Id: <20251028054437.759728-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0100.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::7) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA2PR03MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db814e7-d391-4a3a-5a0e-08de15e56123
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbA9DL3iVDv79QYFydIMNUY1pNIaE6onv6PcyBl5c8XGP/a1XPiHQM4pS28n?=
 =?us-ascii?Q?ZY3fZQmGA+Qu89UQSFuhdpOrC58OsFZIp910HUy+9d//r6bMbzKGAWm24PZ7?=
 =?us-ascii?Q?EVav3wQFzKyuVOIVDC3NtGvGfMJ7zubaMIaQTluumEu+oSyFC0XtEDH0rdHc?=
 =?us-ascii?Q?SSDSoyCNzaNHT0qhEwCjnSYODiq2D7xY+dCCRdDRH4BNyuHmYtYCvePbmiNe?=
 =?us-ascii?Q?sR8chGMpeAPUJoRhDjec0jb4cQ3/qRlbBECQj9DRcPqR50L9N1Cvw8607gfW?=
 =?us-ascii?Q?yqLvN3vzdomvLLtm6IRi8Sw6ALY1ZTmkQ9Uk5rSDDuQSXh/khVtyFKRlFkrD?=
 =?us-ascii?Q?iol9gNbR4X6o+hIlkapYyy9Nnw2qhz8GKMQVL5IYwJ8IpeWHgvWpkz/Q1jxu?=
 =?us-ascii?Q?8LDtO6bugTEwpBVRrhhO9mPuKMI4Go+wOxJnXApyqtcDOekBHWmkXurAaXci?=
 =?us-ascii?Q?gtEGaeI97pxJ+3WXj3YFC03Y6P2nzGqiV+mOj7BM32WO7mwby+g2nsBFq6ED?=
 =?us-ascii?Q?I81TVbsUe7ilJzhmIDt1OtFxN0fasd5Wgufjbaj6MouPaKPar9dPeFZ2TLwV?=
 =?us-ascii?Q?KO0Ge7ANgysta3MOWpwTcms/3wZt57yiIIzVxt9t2jmbdwtDvUKzD/mrNAo7?=
 =?us-ascii?Q?yGZhFgSDV8T0nhLVU10BKKz4fOIVylp7Kdz7A4f0yHkmka/caoQuegtQ8bRn?=
 =?us-ascii?Q?bo9o9utz4ewOLYm7JgromA7AEw4T0VAlnVDsdTaVL70nQXyDrzBr4oEcbsa7?=
 =?us-ascii?Q?cyJOAVQxZs3y0Dyfz+ZHkQJmd9DAzR6eR/ZA5yVkXtr9Xildavcce27CCMTz?=
 =?us-ascii?Q?XppHMMaLfKg8NCTeOdAbUrL/qtaLCV9Yy1ZYzIM20nZ4MkU5by5biweh+C+8?=
 =?us-ascii?Q?pm8t/mlXZzIn31IkU+8dxNTeVf4aI7CMpIZjhtm6I4gGcIUFsP0SpD7Bz+HZ?=
 =?us-ascii?Q?y8esqrR8dM49P/B3SdRJTYd380OXzOFdSMTxJzT8i1HFW5T848yGUwBGjCi7?=
 =?us-ascii?Q?w0MFtyfUkrgJXTCFpoT2kt4WcXQN9mDJhCEAhSxEn6a3yyqXcSxoA2smeWtM?=
 =?us-ascii?Q?lBc8HdFgeMVa3mV6Jpi/aLmK+jcM0RGI/mZeEwbcSZeK46NCXTNsSUDYYxE9?=
 =?us-ascii?Q?ZrGuBMFGJ1f6GXD/oQdonrQzY80y55sE9M4F0z4fGkwPCgfusb93rYkmhToK?=
 =?us-ascii?Q?aunn4Q+ESQEi4urfN8C9SPFl/mQ5yxMUE+wFx/t9Z11eu+leoZ42UR7rhog+?=
 =?us-ascii?Q?zmhJmRZMpzH4Kf39KC5DFv3ixuLC2zOg9o+h9rcFPN0aCsvxUwnBTLcOg/0s?=
 =?us-ascii?Q?lFT/fWe2f1WnD1qR/gU5b+PY2TWRRq46owox93Gd2Fh2k0lQt/vJHgqY2VIj?=
 =?us-ascii?Q?HV8911hzh0wj5HTFW5yH0+PVGhAYmZyXmX+5HrRBApFaXZdzQpMr4etKvMn9?=
 =?us-ascii?Q?fetqqG+rVESRYKZOEG2yLR3BqYbLWGDJzh9d8bkjnl3tWidT3Kz7qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9SKboJCYn/mNqCPiUW6drTovDwgIiULCl7VwcwOXHXkqqg43MG6Gd4BDew+c?=
 =?us-ascii?Q?Cnm0v5EwhzHK0w4kH2T9DI4YGql3Oo7WCcf2yjZJW3kGR81YjAwCrI+0PfNI?=
 =?us-ascii?Q?VKaUqqmWHe2JB/uuA5WpLwTsIzn+jzCk/6dQ8SGRpCpzd72yLpt+7c45mIFv?=
 =?us-ascii?Q?hVTRrEexGCIDVCbAypTG22iLd0Gs2pGSdViaP+FLq4fSAfAtyJoZulwz+6Cq?=
 =?us-ascii?Q?jqWZZLeovvzwP8YVNUgVekGiLgD4VHp/8VAIbz4HXU+lz0WZ7pz8iJvy8QpD?=
 =?us-ascii?Q?aApKNCpGc7fFRIhyUxVsk+4Gj0u8jUKM8egZAVLsCzZwFw06vePSHQwNToQd?=
 =?us-ascii?Q?6sa9iEGkOhaqU/3NbhawpAouJHl2wekd4HN3htuW4O9GmcVH2o3cBx3IHuEU?=
 =?us-ascii?Q?I1HLqrsPLtOrcqPmu2K6S0gEnZGkl7mQliTwqdlpnAFB7HUaCQ3LFqIjsjvd?=
 =?us-ascii?Q?5bO8hXZ0KowUl2ILUvCpD57p0Fwr2uHC57lEhdkRIko2zclWfdeWdOcceTQa?=
 =?us-ascii?Q?jTeqmQMCQQ+iLRyWdMTthpjDoKij3nkc5nPFJSYlfJiQ7eEJabdgGW9ZR6gw?=
 =?us-ascii?Q?1tPM+PvvldnRw9uPaKcHPCbiP8cj7fbI7yO8G0Yd4Nj2aJ9X8pw4vViK7h0u?=
 =?us-ascii?Q?ZjrLTzXUQf8V4I8Byh7Gyjs9ChOEeppMvBwYfvrhGlP4IF/9C1e7geDPi5b5?=
 =?us-ascii?Q?o28hj25Kso/OMNF3tcO4kC3XnLHBJeREqpCAnrQ4LscDtTxC0uityEWbeTyS?=
 =?us-ascii?Q?cIe6izmgeo0admt3hXy5tPdd9LDqz+Gj3DRS59aGKg9UH79JhQ17JBP51aoR?=
 =?us-ascii?Q?yEIY1b4s0h49Aad+GlhJe1nlM7Iz89qDizLjrbN7+4ybEVqCDPMWDYUzXtTo?=
 =?us-ascii?Q?CVU+1tJUUnNckm2nRCckWlZbrWiGir07ChcnVpOIb/Yb8bjXAalPf3Hqk9yi?=
 =?us-ascii?Q?UOTACiWA+/fi4g/W+0qaWQnIV2gQe/r9DWPvB9J8uLVjfT/cv3Q1BfYaLcTv?=
 =?us-ascii?Q?3tmEhDX6/O61pQ1iOdLm63gKHq1KFbp4XR6jik7nII2i+F8S1F9kLU0g8zTK?=
 =?us-ascii?Q?GV+GijZ/+erMmL1StLngmDC4zjwkwE+Y0wQO87edpFbaAAkaPEepOsHug9Ki?=
 =?us-ascii?Q?p1Skxkt10UQlob5c02MwkYNeByyY3rqUFjvOpvmkZizfYjNYHhG9IukVcQXi?=
 =?us-ascii?Q?okdLPLhRZoVsZ1D0194S7qI2zhXSmELGlBpugSMPYfEboQCtXDIyqyuciwLI?=
 =?us-ascii?Q?H+F4bHOoNG/u/ZD2lZmGUwGUcRkr0Jg3HnqNSfj+ak53nzbQDN3/w9R8S4Dd?=
 =?us-ascii?Q?VjI6tjacT2zBERNB5+lGfs7MIgVkcU2eqY9DBLRbCGXV2sVq/+LniDAcT3M1?=
 =?us-ascii?Q?egg9t9xaymKgLqZOLRAtzEcq630tIkw0cjrGJovHpffaDvwtS35+r+M50Z5H?=
 =?us-ascii?Q?mS0JfMiPrPNHpPZcAXSrpFJ4G+11/ka0XyYwF8UReBQ6oXQK4faGl6/YUcKw?=
 =?us-ascii?Q?hUtusHNH2ADnFLbRPFut9NSYy5/CrT5QUiGUl4ZQGH9KsBTAxNtvLY0ozZWQ?=
 =?us-ascii?Q?7M0X9Iir7cnTsYwaZpPLk/lbRxI30Cu7LThZSmxF3eDLFyhlavv050IflKAz?=
 =?us-ascii?Q?1YZoPfsgnJH7YWOumxbFVUHlPI/hstwt4iNYQp3n1XiO?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db814e7-d391-4a3a-5a0e-08de15e56123
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:46:45.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzCRFouOW0J1YERl230u5zF9vNUiJbQxb739o/OycQwYNGxmSfiWH2wl6Iy5iLf7vegu0yjZtryjquWz81WKPIthS67RjTUYAIWJaIvboPWey3WEJf13zdq9+9qtsMlg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5865

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The cdns_ctrl->dmac->device was accessed unconditionally, even when
'has_dma' is false and cdns_ctrl->dmac is not assigned. This could lead to
a NULL pointer dereference when DMA is not used.

Rework the logic so that DMA mapping and unmapping are performed only when
cdns_ctrl->dmac is valid. When DMA is not used, the I/O resource address
is used directly. Also a proper check is added before calling
dma_unmap_resource().

Fixes: 5c56bf214af8 ("mtd: rawnand: cadence: fix DMA device NULL pointer dereference")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aP8S9oEgMv6PXzax@stanley.mountain/
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

- The changes were verified using Smatch and tested on the Intel Agilex5
  SoCFPGA development kit. 
 
 .../mtd/nand/raw/cadence-nand-controller.c    | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 32ed38b89394..5a40e0560984 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2871,7 +2871,6 @@ cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	dma_cap_mask_t mask;
-	struct dma_device *dma_dev;
 	int ret;
 
 	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
@@ -2913,17 +2912,19 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 					    "%d: Failed to get a DMA channel\n", ret);
 			goto disable_irq;
 		}
-	}
 
-	dma_dev = cdns_ctrl->dmac->device;
-	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
-						  cdns_ctrl->io.size,
-						  DMA_BIDIRECTIONAL, 0);
+		cdns_ctrl->io.iova_dma = dma_map_resource(cdns_ctrl->dmac->device->dev,
+							  cdns_ctrl->io.dma, cdns_ctrl->io.size,
+							  DMA_BIDIRECTIONAL, 0);
 
-	ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
-	if (ret) {
-		dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
-		goto dma_release_chnl;
+		ret = dma_mapping_error(cdns_ctrl->dmac->device->dev,
+					cdns_ctrl->io.iova_dma);
+		if (ret) {
+			dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
+			goto dma_release_chnl;
+		}
+	} else {
+		cdns_ctrl->io.iova_dma = cdns_ctrl->io.dma;
 	}
 
 	nand_controller_init(&cdns_ctrl->controller);
@@ -2949,8 +2950,10 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	return 0;
 
 unmap_dma_resource:
-	dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
-			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+	if (cdns_ctrl->dmac && cdns_ctrl->dmac->device)
+		dma_unmap_resource(cdns_ctrl->dmac->device->dev,
+				   cdns_ctrl->io.iova_dma, cdns_ctrl->io.size,
+				   DMA_BIDIRECTIONAL, 0);
 
 dma_release_chnl:
 	if (cdns_ctrl->dmac)
-- 
2.25.1



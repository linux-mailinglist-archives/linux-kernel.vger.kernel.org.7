Return-Path: <linux-kernel+bounces-791826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45AB3BC61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7640D7B3D47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AE33F3;
	Fri, 29 Aug 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aOJlwpAA"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013023.outbound.protection.outlook.com [40.107.44.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46F2877FC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473641; cv=fail; b=F3101k2xNHyjoz9TIygjvEaAIjws0LAkkP2pPbI2zkSqumv4hJ/DpFcgty3wCoxTGgM+aZrp/zhw2rZUm2IqDxxnC07Z6N7xmeO/hTB44ZoK81GyX95MDHeFu6SsQwCL52B8AmXjuuZFCpOLnG1yft0sg8SZdGS00b4aZoZTuCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473641; c=relaxed/simple;
	bh=9h52mwQv8oy1oBUYDEmNKy9xCnUBBWOJY0uouWi/JL4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DWJKn9Mg/4lhFdUJuGdMFYMR7SFsgKwd25brFci2E2K9i1CV1I+nIFSBkwiIHrLqUG/nkC5C58Znoct/mwIVe24wWemGa8vrOhIgE7PzTiYZIDF6P6+eJ6WuuWuwV+Ia6J2EqqeLnBg4M2qYTb5c07//RNTQkCBwBROlJ1CAAFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aOJlwpAA; arc=fail smtp.client-ip=40.107.44.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usmhoDei5KEBN8WsuhLhuVaBcsBZwqPTKS+frMWsjOe0aS7yepCoOCSFYcJHfNJwKP2157k27e8d97TENU6zsiDPib9Lcc8ntC/HvveaWaDIoO8VNHpgh3PFyXcne6BTCPDw9hqH6/d9VOvdiePd2D/2bXXcsAN4gjxdfyMYrOjcNpBpUSSgCtioLpJUw4YzH0RLR47GgNR+aQ1lY8smEp4g1HGLCWGlIlXRhtTL4qRkagOOjv0y8m/+tslMyGK0tESgm3J8n2XhCkM/5LkA6vPsuN1ENi7lwYmz9JRIDuIBhLT0p/JnG8PcovDqgFCiszs4K1Su66YUR9MFLR4FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF88/ZSkY+HN8vOkfjYyO9sNh2pKhrhpaWYLtpmjX7s=;
 b=PcQ7pj8B+VOPk2Ix3lTGkDZ8ee1S9vjPHHTH0FCJYnLkfGjPvkAxXlPji5u6awVUh4J6QMnI5anxqf/4O0FQeudT/LoO2hvha4tUxaP8EDWHj0v/KRnQta1wGdgRuXygN3zcpAdrRbKqbRsVNDF81fCmfVPmMMrI4xCvfQxyJKuW695jpB8cfAOxYcFj7Yyo/YiVXbXhCjMyc8JTOYJGDWBd/29bp+KeLBoaD2gmbqFtoHrUgC8Ax+t7bRwKqEYeHS2z81mzCvBmrYUI/saLMpARZKobkqLhJTZZaoNXxidfaSwryVz3uDwBvMuGL7EFpla3CD9xfH55WPR9uJm3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF88/ZSkY+HN8vOkfjYyO9sNh2pKhrhpaWYLtpmjX7s=;
 b=aOJlwpAAAFthElJ72+UbAarS3RuBGUUodQ6+/ifPXyVox2WXTq2xmxGyLOjRSCzY62jmDBeHv0BsscbuC32Fe//KMw9nuJgatMg2Sgnk6XfhqpGj5hw8Ew2gVUUBlD+k+ibHytD9+JF9rebSta5iyGwft8/eEsZRoU+7qBUkNpjcpF1M8sxknwp+aRHhHA/Bv6Lz3sV/Bz/UxqMKO1IGLUl+bRjkvdyosXqgZ6MXa+gVdqHfkuXUoNcSYibW3i907DuzzDIwCA4f/t0hHeqRTKncPKGjCoPtjnmAjnTGYUbedyrv5jOEUca7UC14HH9r/57uhGyvCUI8OncDy5AR3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KU2PPF3ABD1D432.apcprd06.prod.outlook.com (2603:1096:d18::48d) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 29 Aug 2025 13:20:31 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 13:20:31 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] irqchip: Use int type to store negative error codes
Date: Fri, 29 Aug 2025 21:20:19 +0800
Message-Id: <20250829132020.82077-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KU2PPF3ABD1D432:EE_
X-MS-Office365-Filtering-Correlation-Id: e301405d-d7c8-4623-f2ff-08dde6fed43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9jysFBS49FtIWe2h8qeD88lz0x0eLqDbKSxbkpG0IGU2oMCd3cHT5P8Qmbg2?=
 =?us-ascii?Q?FblOtATDr33TDZKoC4CsM+U9FMyZ6Bksosj0anILYUJh+/YbZDDumt9zP89H?=
 =?us-ascii?Q?ebxL0LC1iNCcGyTg54c82j4x8trUK0c3EYz9dhkHD74jYMw/6NE3SP1mTj5/?=
 =?us-ascii?Q?mG6tYXUDIpaEPNaUQGUqDBqVh7QVGUf+Rp0R8hlRTYJWbwAUNZEOAWibM2PY?=
 =?us-ascii?Q?OYrPHomLBhpNgl7Dt/8DzJ29IzPxzi79M/GaCWqkJlWN/bvf2h41+CBBtLjT?=
 =?us-ascii?Q?Z45MiLC7FnVdFlP4S8NnPTjYB/MMK4CkVV+ySDJFR5qB3IRYVVV0BPtaOm2M?=
 =?us-ascii?Q?/1K3zV8SnnGtvHh79O8qdAUopiOQyvzHQlmYDua8qvPcGaPT8QkVBZvaOoDl?=
 =?us-ascii?Q?HUf5P/7c0Q5TU5/QfDtaOqjkxKoNwKvwE2+h3MmsPwUsOdLFVxg9127oztRN?=
 =?us-ascii?Q?qyZxWNW6DniA16WEEySyjpzNqMdb2rq+sCmjL3bDTSKwapKWe9BW3M+/l3LF?=
 =?us-ascii?Q?zPOMK7X3sAPlzSAZcomlVKCCMOORDCvxl0ckzCyjCmaOzkOpLegySgKYRw/h?=
 =?us-ascii?Q?2iSr3tpDYRJiAR+qiqzOZi+zpfimsp+HUKV8xwln0Oeria/a7TE6dclCezD2?=
 =?us-ascii?Q?DUjm36/LRp4tEYv0kWS4oH9gfqWRw869U2QXUDU9DGsmyJuuhKjK/1Kusx23?=
 =?us-ascii?Q?TYhiKrDcMPriHNnsDHLASFu5NKFiGyeWaXS2shGc/vdOqKZYDMkuyHBFC6h+?=
 =?us-ascii?Q?KNYajHVJWHLFP9MvVC3r3KOv2xXWV+JwYIssvXw/IKk3oFbs7n8m+srCDCex?=
 =?us-ascii?Q?Ub6DPnTAzto4ijvbmmp3ohdft8Ov3j+FSY0CzYypVfiPPY+K9YBhtTUmhwti?=
 =?us-ascii?Q?5Lo5nK2+hjBQAFwtGYgI/nwq1HpKOhDnUlKF1lV7Dsw/Fhqz1diZmSP8oUdF?=
 =?us-ascii?Q?N+rTipvr38Dwn8OxytHfKG6NOTd4xOUb/xBwBBoJqZrsiEJvIIquptt2nnm4?=
 =?us-ascii?Q?TKsMw/jTwPM3vTQfNAsUL7j70EC09ZtpDXcRSBxgl4iRR8G/VyWe3DZsyEXS?=
 =?us-ascii?Q?arZPq73VDDDVHC07M/hjXfjnUA+7ef2RYri+VqdDAJ0I7KXXlynDWjJ6KSH2?=
 =?us-ascii?Q?V18jAK5Kx0Ju9zSUntRMOrk9cvXl7xAll5lu/VmLr4h7cX72Kfx8Kqh32qj7?=
 =?us-ascii?Q?dZn/BI6uWbhWeMinjuA+vFvWYuee1Xp7Kev+UNXbJ32kkmKMXuGkzmXn2jL+?=
 =?us-ascii?Q?QkOuOi7LmMWLvp8noZQ2pRRctj+0g6bGVg97WVIEYpeKUB/gy6mNIZmmIgxH?=
 =?us-ascii?Q?T510Eei2wcP52+STbkVkPytMyIWcAffOsVBDuD08s7Z0O2bS9BrRkVR5rZVu?=
 =?us-ascii?Q?PQSWH3CEARXggzYKhKJYH+ppbEkjMicZliGdrPetJeSkAuH8ZQ5hRKsSwmi5?=
 =?us-ascii?Q?DH8LnR+kTeZ0QAgwlLjJPzshGAiABLR7q2HANU9roEm8TmN/VrK7HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LIonIxEp9FLIUKpVCGLRxhg1WpounhAuLdOInV1xYKdlaGiAY0eGeMEudbl+?=
 =?us-ascii?Q?WSvjNd5B5bqx3EPCBTdDtUT8uWeo9Gcy6Sw6F15AiZwZUN9lmIPYtFSnk07B?=
 =?us-ascii?Q?oaSwir015eM3L8G2nYgjHFPTuROwx8VbEEXgIE7tyfOIqqcS1QYo5oPfj7zW?=
 =?us-ascii?Q?ZRbjGs+5JM55W6wgPMDhzfIiH5C70ey4mlqWfRZDS+Q5OCK8TENXOX6BRZQB?=
 =?us-ascii?Q?AL5/lSXT0G/sGQAvmBV+0BvSTu8OdQzD7w8FTxBRLwhgeDx18A3BMLg8Vgqo?=
 =?us-ascii?Q?0+UaJMHtEAVC8SDEaGsGbTb/c7M6VfwX0JPWr0zAi+2ceuBpQ9WXqmo2jS8j?=
 =?us-ascii?Q?mcT+hRPmFpN6ss/MWPmzIlpcIyVjBNw03ER+o2Ci5wSXeK+D/H5SF1JrA2a4?=
 =?us-ascii?Q?/IBfYUTrHHdA7Bs16JDci3TdUfg5ZQ30m7PunHRFWmbmat/WzwcK7EPG2b6J?=
 =?us-ascii?Q?DJt7HRVJSWd3XRC2v8grZj5R17N2BLGfwZ8KKpAJzdyd3KDZPZTnRMrxBWkx?=
 =?us-ascii?Q?iTM2Bspr/9tbXkS51aKM4NqFennTnhJ7YLiDpgAaXnIJfPYo4RMLb9SDW+xo?=
 =?us-ascii?Q?rzHX3ij2RHZ66IL5+1lvpY0ciOwmKzNtVGYkK3g+Pmc+mZ9haq1CcKhQ4akI?=
 =?us-ascii?Q?nZ+Gso6c4SKzO1YGg0K5N2fS5xWbR3qCFMTjev1hb5QGIUfxWYBQJjyaUs0w?=
 =?us-ascii?Q?skggOHtJ5bwAdFUBtUeEBOgL10CaMcPuRVOvallRmMm2BFJkcA8XrtUCidBB?=
 =?us-ascii?Q?RNiBcp9hSLvApo88ibAi8JMxvTjCO77IOuEVgRxm43LbaOAFRRB+Bdyno403?=
 =?us-ascii?Q?YBXLJPEK0mWsTkWJtfVv1spKh1nh8I7E1WfD0cUmKcjx/rsr563DnZ/5Sz1/?=
 =?us-ascii?Q?FuaJxLwPag2ytkZco/1ngCr8IPrppdFXne29URza7LYU5AW6ENR/aGeKLF3C?=
 =?us-ascii?Q?G63B1jwwONb3dOLKMgVhpufeDv2ofyUF3TV64D/o8CRjTzh3T15p2qiQyh07?=
 =?us-ascii?Q?IhjJxHReClvmXWv9W0Io1GqDEztIUgtLPuZWlgW0Hg2PI4o661ZJkBzfzqia?=
 =?us-ascii?Q?3R6+T7UN9IhuROMUnW5+Qe5Zb4i04smsmNUazaXV1ePoH2JPzRw+eXNkuNct?=
 =?us-ascii?Q?2qMQl0Nbj0djOy/WHDuVIGEpbUz2+DjKedOXbgfP76pbyndS8HWyKSmyGJ9u?=
 =?us-ascii?Q?gSbFD/KD8Z/PgxDh2OP2O2vTCKIkikVsjQyt/+s/Am2xxNhyHD3fwAw8i0Mh?=
 =?us-ascii?Q?4xSseHLwMmUbMCzSv59NvC5CgRnUZLsxSB/ZD8f9Hgi7UHfjaGdG9F/foaWN?=
 =?us-ascii?Q?HpiHIAERwI49XAI19YkSBjStyMUaPwO7W+BXhEVYgKD1SlLxh3vciZd5rjqX?=
 =?us-ascii?Q?1fbGIS8a13Gzd1T1bnJESa3C7H4Tq76yp5b1JhhjtXL0EIFmL/J7nz1yp2IE?=
 =?us-ascii?Q?4aZwY+1fQK60KFtUWHpJSh3myIgss/cFspux/xkNRwxncVowz7mjxbLsEAVB?=
 =?us-ascii?Q?1vRoSCkLgq4qQJ0QgA5s07ieKDQQOugLF19r54EJ4T0Mg9yePKtctOvxTLDS?=
 =?us-ascii?Q?iZLBiEwHtstDuvK3ESMQuAS8GCgSi/Khwc/jGJQF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e301405d-d7c8-4623-f2ff-08dde6fed43d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:20:31.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR3H+n0rwbbqTKB11W9S19z47csE2sH09Up7dGiZNNywEMJyfvoH2daZuEdN/dkOYQn5FiwLz+nwSGoSgKVcUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF3ABD1D432

Change the 'ret' variable from unsigned int to int to store negative error
codes or zero returned by other functions.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly. Additionally, assigning negative error codes to
unsigned type may trigger a GCC warning when the -Wsign-conversion flag is
enabled.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/irqchip/irq-gic-v3.c       | 3 ++-
 drivers/irqchip/irq-nvic.c         | 3 ++-
 drivers/irqchip/irq-renesas-rza1.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb85677b08..3de351e66ee8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1766,8 +1766,9 @@ static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
-	unsigned int type, ret, ppi_idx;
+	unsigned int type, ppi_idx;
 	irq_hw_number_t hwirq;
+	int ret;
 
 	/* Not for us */
 	if (fwspec->fwnode != d->fwnode)
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 76e11cac9631..2191a2b79578 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -73,8 +73,9 @@ static int __init nvic_of_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	unsigned int irqs, i, ret, numbanks;
+	unsigned int irqs, i, numbanks;
 	void __iomem *nvic_base;
+	int ret;
 
 	numbanks = (readl_relaxed(V7M_SCS_ICTR) &
 		    V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index a697eb55ac90..6047a524ac77 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -142,11 +142,12 @@ static const struct irq_domain_ops rza1_irqc_domain_ops = {
 static int rza1_irqc_parse_map(struct rza1_irqc_priv *priv,
 			       struct device_node *gic_node)
 {
-	unsigned int imaplen, i, j, ret;
 	struct device *dev = priv->dev;
+	unsigned int imaplen, i, j;
 	struct device_node *ipar;
 	const __be32 *imap;
 	u32 intsize;
+	int ret;
 
 	imap = of_get_property(dev->of_node, "interrupt-map", &imaplen);
 	if (!imap)
-- 
2.34.1



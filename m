Return-Path: <linux-kernel+bounces-887220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73AC37993
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EAEC4E43CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F93446C6;
	Wed,  5 Nov 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOLwPeWq"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B123343D9C;
	Wed,  5 Nov 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372709; cv=fail; b=ApAwwuO7sERVTt82Dkf1UBJa6C9twi5E9XHFwCVrQpU8JumqiiVQQAJ1PFEzxjdbR0JP4fc6VuKGYqRruFGI2SSnriTy9zOL8a03MJyC2o5aCZIqnZ45+UHzIKPM+54gpWFNLpu4RaYChbcDzTv2iK2Ita5v4KH0YvDUHF2U+NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372709; c=relaxed/simple;
	bh=IruWxQh7uTsbwP/u346RcMzHLMexAYtDLBGbJ4pVc+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NWeNlBEpX9Wn78VmQhKgE41qt3GLM8/ZnQHtN0TYFDPySTcSuP52ENNKfjtnXpZLu1Wu7BxgG0dv2hA7D/5OVCrijZovupgoZYCZNUaBkAKJ+kzLT7W9/KYEGsfK4YP8MoB3EufcFoNDagk8nOt27gcw8c3iPxGG+UzPXwiHFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FOLwPeWq; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhMFWAtY72z48N8dJQPfwlVjoUDnk9cJkNVDWDO4y3l1Zk3MVVtcT3iCPCBYUHQkI7IYKnjsdYgLlcz9BP0U3u1D8rHVceKfqhd0qhObhcL4reRH2eLj9x8CdjCM/4RhVI1OgI9+XoINMs6dBDMJR58v5BW/rXg/U0eS17Ea6om22yCi08jKDBrRVRA6ljO5y6S4SXD/jf03H6xY4v78C+tfjYVk5v99a0XBxoTLqvLbsIe6tLz+GRzjJZhFkgw4s0ZSLON7r5lSkrcEYUmDzTVluks0CaSh7Y3gefpocEF2R/DUdNK+lhS1//bAKjZV2x/ePlpVoz3g6VXmj7QLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZNGA6PDa4OZocUARumwAiFfwIysvsbtp4eMr1+Uu+g=;
 b=rYY2XCxSFdQUB6ewvx5rnXFNItr36AwpqDNqS7ic4ZcYbiyyvwi0PXS2UbM1/rnbTf9SJUz7pTOmv6flq/aQHsteeNlIQNuCOO5j+Y/uW1h/y879vbEzdliwHRdPnAHgP0C0B27yTzdHLxkzaRQUCSF6zsfKVa00aJL5Rmt1Xfqsl6s2purNEh9uS32GiexRG7RUzKfqAbMPUl61cjSgDQ42MANRMPhIBiLrXk0JPf5tfQ8bXZc7opQlHznwgCtjRceixIgjg+20yHynmIv71GENxTBV0Hvdc8DtKQjkDhPtD1ZcuPimBq/5Xcq7rrpVAOkd3FWcIMGyIQI2Z2RyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZNGA6PDa4OZocUARumwAiFfwIysvsbtp4eMr1+Uu+g=;
 b=FOLwPeWqHgW8+PjQml8VmgU8fyH/VoMWc6rBop7kIm3wv/fiXGYcXyZoTzph60iMjfVl2kr7pCVM75NJastT9WgBfg1p1LFTbS9wVOywIOxcGXCFHuIcZOonTeVs0Aj6knq67Wj/EWfozO5qVbA3gf2RP9UENN4Ek3NesLprZ0UwJ+0R+THViC1dtinvXoHUPawbyC2xLC6rNr4/81s1ey0VwF7oRDuu2lmgGeDsLrTopu5773/EDJMYO2XGwjgG670TK1SLHxDY/xchbsGHIGDtGGObLGVv/YihHNFtCK0JmH1GUfr1TYpPRfJFtC9zwTz/5cpIUby5igI+0+gzNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 19:58:24 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 19:58:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] media: Add comment about MIPI CSI2 data type definition
Date: Wed,  5 Nov 2025 14:58:08 -0500
Message-Id: <20251105195808.297645-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: c38e4197-7bea-48f8-9731-08de1ca5acf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcPJ0XUHOGvWl4QPYcXP2cDHQahKs501fh84K+o9jfkQKN8yY6Cr7UJH7Wl7?=
 =?us-ascii?Q?zPOWTj0DeBBFCxh4gRmh5hMOSSgpP//SRemK6LDmcqAPptlO+/FG0dnV/DUz?=
 =?us-ascii?Q?b5h9tZA/xMbPCaEQHai+ptavqdFwsInNbBgg2/s4d/kwhHyXLm/WKigRcalx?=
 =?us-ascii?Q?YMP41FA44RQJTKWPzmKSkT/aujrhaQ0lQy1L6vHAYUyTSUnHbQbw9ad+qVfw?=
 =?us-ascii?Q?7/E/g1bCK+ZRqDNqlAW5hmXwoZ0cAxlImFEnNQseMumyTaVhsRbdCPm14Ytz?=
 =?us-ascii?Q?EdSaxNl6WBQU8nt+kcx6Pndxq69WNooDkgZRbH0i9Y2xhcBXIT3xdyNBU9JS?=
 =?us-ascii?Q?KGkFRI5OIM+4MbKs0zf2EYJ0JrvGry18fgNn2a13A79fgCoYFeQYPgwmC9XK?=
 =?us-ascii?Q?fhKOSyshG12M0xwqNY60P0DWVqFpHORwuAhFUCpiz/nX94iZQYGd/y5wuaoJ?=
 =?us-ascii?Q?5NXRhA2WGJw71GBpivpRpuZYBz7nigzLWu5DcRx/qlTmMlQ4JZYWNpyxtniX?=
 =?us-ascii?Q?nLC2rH7rCCEpeSxUAtffExkFwFIGvlLnLLlgfd8PFqCLDIYO8dQk7rR8Y9c6?=
 =?us-ascii?Q?2mwPmYN+ra64KRB/KC9Sv+potLA2tkADI4DecN32/RQwVtbw8ofh3PAKDDdi?=
 =?us-ascii?Q?B+lXA1CZlK+zkjpAraD9z0X191rdNLDmKSoni0MTJ+AsLPLz7jj00NwHB75h?=
 =?us-ascii?Q?tEhxxvrfLPNaChbO7dwCJ6jRkw3Qc9I1BsYUecPlIJTLi8VtKGNgn0NMtEU2?=
 =?us-ascii?Q?p+wpUcQZAzR7UoFeeaB7r3daMydTtAmKNWjNJBq5RPS26l2uhZEs+kC00qJq?=
 =?us-ascii?Q?CPlT7Q2eGPYgYdAki+uH2QfZEi7b8n5wLttb5r/6lYjzoQyyyubZ8hltgaQP?=
 =?us-ascii?Q?LzLYddVXkzu5nenTPYFn2P/1lWhHC0a6NbrTd03GYLWVUwdmrPVJxOeAwrPa?=
 =?us-ascii?Q?x1wkUelIVsIT8LmCJ7/kh384bVn/eRxwo+YOA4Nhv2kRC6BGFSRqgAVl5LK2?=
 =?us-ascii?Q?euacW21V/UKLXUWPmaPj1+zZXOGKQeyFYDpN8r4z3H2hoBbqGZjw6jqQOCf2?=
 =?us-ascii?Q?d5KDxzssjfHpT8IKwld7Mo8kcfgetOvqrrxi/UV0POw2iOx3EzSHzuVD7Hh7?=
 =?us-ascii?Q?0iLdfU0WuvBLlWneCdR+3jQwSuvbLJjiMh9y11wMnAV5ZBwnS8mUYR5mAld5?=
 =?us-ascii?Q?s9iY8wklfAronb6Ck6Bc6oCBdx7DGccFOfo7sfpB0/7/xd4DW3N4CHFeFKTs?=
 =?us-ascii?Q?czZy4p3GR5IsYWpO7ASejwnMFys8hgZO4yUnitMrK4gUUHAmat4xmkvBy+ZR?=
 =?us-ascii?Q?09rchYuadXoCFXepRkDlftryZwSv4Q7gVIpHomsW5kYcf4fFYO/+awt44UHA?=
 =?us-ascii?Q?3K/R8wW+rXBwXmagjwjIRPsv9rHagTp4NDbJup/Vi9EUQdRRzFzV4dzvTcWD?=
 =?us-ascii?Q?cmaiUcUCrC+Hohqr6s+Jclymwgpod//OOHxxE1avs66xvkmdAB3//FRJQgjE?=
 =?us-ascii?Q?K9De4Tgc6PUh0gD9L4PdJjSMbDB1ss2HgIS1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdx9nUZ52dIhPlrQwAYc2rE7APJ9yuvNkkyDkr0FAoQlsPLxem2D/htSCUuh?=
 =?us-ascii?Q?hEqo6FB29LY1GPgf568EsVJvqWDOppF5Edh4xrY7Q0oqgH+p6WJAtjZTUx5+?=
 =?us-ascii?Q?S+bwdBYhnOF5wV0IQRBxFv9gLtrrpnTWnH0kx8oKL9TqtANJixbMP144H3iv?=
 =?us-ascii?Q?4QvHGQkrufAFe02QDWJDXGyNtDq3w8QDhBNWa8cyi8AKjnWK9GdemTfrmiE8?=
 =?us-ascii?Q?YDAkoLzaoYRjSC7vo3goGhsHpD2VsFLG9a+D8Ht6zWs/5PKCJlA32hcQcTdo?=
 =?us-ascii?Q?IMmgQZ9nK+0Bvv2qIbu025rE49UjHEnMySj2HX/YCkc9pIJQoQAWJgndJBsl?=
 =?us-ascii?Q?i90MfjYZrou/RX+ZgT/i0tLGnF4wda4NvCGS4xJkvCAFALLpB46XtFO6+pfy?=
 =?us-ascii?Q?pBpKXXVnCqsZL+tNaEAX2uliJSz1xTVxcXGoXq+Zq7wioAGz2ogG/sdtQgp9?=
 =?us-ascii?Q?WlwmU+ulWl2Hm9z7DDvcZALxbfLiGv0gw5/NW55qD4J7RndV6qirf47i5uZ6?=
 =?us-ascii?Q?fGIJfUCZQjh28anHiL0TAtkfthiBN9D47UUnJMcDk8OKkZYPDwPAp4cxZ+2x?=
 =?us-ascii?Q?rUXCuCVGGYJOUd46Y/tH+F2GtUDMwyTzGy7yNE/Kh2gg0Fm46+q4o44sBB28?=
 =?us-ascii?Q?vI5BTghRi4FndNIbBBcA58E6YAzxC/VwDhzgSd5r86T2XkBqXeQ6BNksPQFz?=
 =?us-ascii?Q?zkf/EMjs7OLkzfgs7PAMqiCgwXkLtROoxR3HPXb8HtHkzi4NUTXDR4JeiLgg?=
 =?us-ascii?Q?2jEJU0EPGN/4vne0tMuUQT8N2fK9Lt2I1no98BCcK1vUz/FJjWYQW0DGToz2?=
 =?us-ascii?Q?LFXtHNcyVeDLKmV+8bsv5zQ92iSN+MsB486RV6n6V1TXCoNWHOlnWXtzBnuN?=
 =?us-ascii?Q?EDBJe4e4a10ccDjs55iyxgb3VWzz3EmzW+9SQraTSDvbN139NHGOkUecrjbF?=
 =?us-ascii?Q?vkRP+IaX4SzmX/QrG+aCVLk1NWVXlQNBqzmMKp0v5yinO3h6V0L7REohGMIs?=
 =?us-ascii?Q?RCSlsWiYTgOVgahL32MoxftpH+TdbmvajdUKmgwDPSOBpl+m6seszdDGHJ1U?=
 =?us-ascii?Q?q0gxUGd6bVy+fjrKxp6iIW14T/Hexu6sK39UslNmabYTUc/GoLQJmFOGWq9Q?=
 =?us-ascii?Q?jmTprDHWbWGAj6wTqNIWtbjkbr3447jqP5bnEbylcrhPXjPioTKKrQOfsukv?=
 =?us-ascii?Q?nM4YpZUMigeOKJfFlgrq9AWGycJBpAJVcV588sMz5AJWVcs48RYAajPSugxq?=
 =?us-ascii?Q?WJ1PcIybws5o+rs6GSIJ4snc1d53QAk/DxQrpSR1KvkBEoVYhCvPWQddagxO?=
 =?us-ascii?Q?iqEAbr4TiGPxVgVbVTfvywdo8eS6OBI8unL+UExIIjYFtPLSowa7gxyO6uV3?=
 =?us-ascii?Q?cvOU8ncLAJdns5JVg7bCUMMZq+RR/wNTe6t2Bam3aH9xZDbF17Hzh9aFDCnl?=
 =?us-ascii?Q?sROaaa8Hlv18Z1NQUeF/XU41SoWLG/8C3iDxYIF0bwvRBUxEmIkiHo0Et/xJ?=
 =?us-ascii?Q?8g7llHbLFqsvlIOY6Rt0IiE/JWzj2GADG3tf/YZFq7Qa51dIfzpV2woNKEUV?=
 =?us-ascii?Q?hqHYD0N4cb8yuSDSxpahu8iXHq1HMZru2+bWERYh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38e4197-7bea-48f8-9731-08de1ca5acf8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:58:24.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHJdlHrZUwkpDEgEXfEG3i/Q+Lu+LoFCPcOIMPfQoaoPBFdXBJZ8P4puRc20pdqtiYkoRenS+ZgdNpyuBJ2b4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Add comment about MIPI CSI2 data type, which defined by spec. So the value
is fixed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/media/mipi-csi2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/mipi-csi2.h b/include/media/mipi-csi2.h
index 40fc0264250d7..7b887fa4fc7e7 100644
--- a/include/media/mipi-csi2.h
+++ b/include/media/mipi-csi2.h
@@ -8,6 +8,8 @@
 #ifndef _MEDIA_MIPI_CSI2_H
 #define _MEDIA_MIPI_CSI2_H
 
+/* DT value ref to MIPI Camera Serial Interface 2 Spec Ver4.1 section 9.4 */
+
 /* Short packet data types */
 #define MIPI_CSI2_DT_FS			0x00
 #define MIPI_CSI2_DT_FE			0x01
-- 
2.34.1



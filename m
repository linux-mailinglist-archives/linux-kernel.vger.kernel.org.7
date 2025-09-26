Return-Path: <linux-kernel+bounces-834498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B312ABA4D40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF68F1BC4D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19830CB44;
	Fri, 26 Sep 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EB8vK0HX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014A30C606
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909935; cv=fail; b=RamUnL+MW5h6QDN5LmOWgJLj/KmQfjcN8lsNWARIngtOvypi+vE1znO1KkMfJmKhlxlua47XquuhghDFsl+/1K1+x5Q/Nr08kEXTQYbCDq4cVXSQFL0NG+1+7wOOoh10mSsmIOuHCW3F7V31utVtX9ACNQ/GCzB0zbjPxzkYYv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909935; c=relaxed/simple;
	bh=L9xpPK+XYbvYJAxhn67/se3//F1WRJ4DMnMu/IZvcaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0Zea5sRYu6Au+948EFBcCGZF1t60BfNDn/jb8yJ7RWxJlrcNCwsiqUITOONCazJ3AnbRWYDcoV8fAcVuOJTF/eVLS+0Rp8Z9aLwPECDc2NYLXqbndU12M2OyfrQb2HxqZm4TP55wCqCYmNqs2FY0VgmmBzfNylyTlIYtSc4u7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EB8vK0HX; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiNQC/4R6VAi457qXo9ne1iDLTaFCUp/4UAcLt1lR76lu7YOcGSMPkdv+9Lu2H90wxW3YmMJ2VXqQpqrwIa0uDVd3gA88SjPmUF+oo2eSjZxoKT8Hung06sjM70no4Fogn/lnPD0puQZ6O2lHqDQpO/cP2sd1buH1bH2PeQF3URpa/LwD7y19VJZ9hWjscueTMIgs0enMr/DiUgxa5QZ2RuF9ZJPTYPU0yQ3VwgGtC42KNOnyXODIl8vGwOWga8n/TyutqFHkVrj8nkSvD/n0n3XyAn8D2JyfIA7GYgMi/Wuo62Cd9aI47U32vURX86pxVJVSYSy2FK2Q7nEsS7uYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9sOpI8b8fot9zoX8SGHK1v10+JPq8wryj1PDb8RiXk=;
 b=t+4rFzkwZA7cuEQGzOAuwexdH7EspBQbDlqCcEtlbfOdfR4NA1YLVr7zf9Kqqk9wiGAiOnspdmu0YZ3MfceVVa7LUuqJVit+uVh3bGm3q0vPJJUXVlJRSXDOxL//LTBr848rFJJM22uECs/OmgRvbE8NNwn7ZL7NYdGQe1GZUnFE7xH2oEGe+YWTPq+Ao3ZgVxLFNW3e8BzfZd8kxyOj4moJfDFtR1iv814ph3SjPmiD1Ei2bJqHIeLDd6nxGR3foODznp1VSwxUOrEsEQDlvBIdSRBbrH4e2HsesOwVgXtrgrD0HnB9T+jdbQDrbRnxAvUe9SbCz1e2CSQpdQPYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9sOpI8b8fot9zoX8SGHK1v10+JPq8wryj1PDb8RiXk=;
 b=EB8vK0HXr1/LbRbUf2c8RYEJYhQ4ffnh63X992DRV1CNuKLEHH/qmoUbMMJJbeF/R6Z8L/XzZIPxUeGBzgKm8DCBpY+AloamiCu7ZHJ20uP9vA5WwtvJeHOGw+YfR+RxJdMxfTL2s4U+dewUDA8mm4dgACv1fzrZV1N3B6gydW0hiYGqnkZ1eNZ90ogryILmEZgyWduDCVbBx0aovnM9vVw6B7CSWrQMAxFH8JQ8/hI3SLmsJKA025/Yr8+W8DVXAzQ5vwhTm8OEbPArN4NP52/TVLcoSaawGn/GHkJ3+XVrgWd/Ow8kgnBs6EBOx0WWOSe7F2u71vvY+s9ezddN1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 04/17] phy: lynx-28g: convert iowrite32() calls with magic values to macros
Date: Fri, 26 Sep 2025 21:04:52 +0300
Message-Id: <20250926180505.760089-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a159f5f-d79f-4b36-6be9-08ddfd274463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSC7v69FznBO1PzZ1La5Zh5ZJ7obTyJOOE5PXG9X4lT3w0GYZ5B/7srnMexa?=
 =?us-ascii?Q?76qKppX1MfoohKSTVuP1QA1iTb5WyCPRUalusb6Gf5kJMUf9q13c5YXBE59W?=
 =?us-ascii?Q?llDb7BWJmDFvq9ZXP/K0cGfeqg0vy+9wj6rMKdROhpoxs+otw9qNw+T3PYVS?=
 =?us-ascii?Q?nz7+02SA/Uf7Yu7nKL8rmAXacDDxWE/E6wgVoCLV1gVVIRVhacPjrgFOw11v?=
 =?us-ascii?Q?znWYIrrLDbKQqdgjfx/RGowLrsoUQA618ZBApX9o7VUn4oXTg5djPiabHnHI?=
 =?us-ascii?Q?5nivCrcqfak+Pkzrmp9mSm/mxQouSDdzeSUb5t5oX8rkaRuxLlctMR2u46xo?=
 =?us-ascii?Q?AktiPucqdf24fEqkaSqAaeaZomYyas3wPznagOEqT9jGASePtnPo0wfzA88U?=
 =?us-ascii?Q?h2RyGQ43WhjUxURtny9ewWA1Zr+CdQkWMo2aPFSVzD+rFRuw8P4fgdOS3NJc?=
 =?us-ascii?Q?hMe5RG+2YGSasWROE6eYn92gz59IP+vEzjTtTvMJL5hGfSBPZ+hdxyysXg6Z?=
 =?us-ascii?Q?bVcN9HcgQQJGwzbCUqeRevsuDGyesq5PR0flXfGSKNvKmpyXCtNo8VONIkVG?=
 =?us-ascii?Q?BgVeDDAngPN6uY0sRn7tti816+MPy5s5vwrtGlvY+yvXwdT4xBM7gBz+Xey0?=
 =?us-ascii?Q?te+IMbpkJwDXZjFx34r2JWGFTDMDtl0kQZ0qR1HqtXaZ1N0Qiri/sJuQdV7C?=
 =?us-ascii?Q?OzTULzOvvOMNhL5zFvJxslCTy7JtODt3Fn4BXKHfx3HEy2Ggd+B44tw8Kfuf?=
 =?us-ascii?Q?aLxbaMSKU0mSs93MdvmQ2+AR93mhGg77fUUTLfCtNPWVjyuU9jT3YKMQac8X?=
 =?us-ascii?Q?Vp4EihUBX36pKbL84ugOw4GehEHQyN8kp0vMbwuZWNkk2cB0pKBC9oUbnngm?=
 =?us-ascii?Q?DIrK/HgA93Z/qzAhlsfFJnLISK80Z40ettY9yqzFF/4qG9fbtaLU3mxvSgK2?=
 =?us-ascii?Q?dE0YXxntk9cHP8hNgDqImmvhwLR2SoU3fEDNpETlmfLrHa97vsn88djz1BRi?=
 =?us-ascii?Q?RTxe/P2tOrzd42atcJUGzjhoijLR7bQ96uTAw+TXnYldnRvPbDefheVL64BW?=
 =?us-ascii?Q?MHl4kqNgAwYZZlxgYFpDnMk1kuydA/1wjGNyZhjCAchOxhl3Vj3RTKGhUgch?=
 =?us-ascii?Q?PsjEKiKlUq5m4LiEE5Vzry1h131rbF6dDsnD1v5wJbFWRC02YGEXDsnlWj/u?=
 =?us-ascii?Q?/tKj24P7xkzNdpQljU/KOMRGMMlTroVyHTpQOGtDm12VhhrGjb4kYCYClglh?=
 =?us-ascii?Q?70yIIKVCzSwjG6lUztONWYIwSOFQcFidwSC8K0O4iPhtps/D34zndhht9dEE?=
 =?us-ascii?Q?Ywo1jLs9PsPBQHaI9hKS1HVu6IKSV/4lLKLPGmXdelzAlzf3NbpACYpPzfHi?=
 =?us-ascii?Q?BQgKmGg+rxRNjXx/49e7gq6W8v1dWlzzUaEe/5wmAZtmKKUVbc08ASAf84zS?=
 =?us-ascii?Q?jl9zMBXz49W8GDL6sO13RoazcO3RVV6xkYFPr3nCmuilnz+bx0f5Lkd52eyo?=
 =?us-ascii?Q?mZiZYMWQS9dQSXoyGS4GmaMq/dlLq7+IDcOd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6D0VubOuEMjXqEpHMiYsBWQvxQv+29zyLl0eJLLY60+jVUW4stD6WU7du5sm?=
 =?us-ascii?Q?Q86LpM8gD3q0tc6Z3aWaeQFhX2YQx13AqgmdDrImdIfW2YJLtyK8iYe+Wugd?=
 =?us-ascii?Q?CKNE2zGMt6p/JkMC9/Y8B4VBLl4AkvwlL78C+CN4Gm3ZKvjR7FtFZR4EfIxT?=
 =?us-ascii?Q?W+yjNbUzheq8iX/LCrWPhuyJFGLITpshCUHqGFfUWzPObGZuxgE8le3Fg5B+?=
 =?us-ascii?Q?D6yx0SdOJIE4VMl7vY7ex50NxC83tZjoUpaSxzZNaHAwkNhP6M8Jh2+eKAZu?=
 =?us-ascii?Q?KXyZXyrLxl+YDMhvm9DzxPv7P5G1EuATHST8kCdRNhJbvG/K/zZmj3dgJIN2?=
 =?us-ascii?Q?LGdu88Gfg7sJcT4IdcCVavvcNzA96YEZg439MR/j6fdHsF/l1FOFtcMz0Z1p?=
 =?us-ascii?Q?V0VLRDYXtG8WvOFdXiSR2BPt+zxoM+zaLa/ch0tB9jmdfM026QZJK2yJXPtI?=
 =?us-ascii?Q?yUM3WkASipvOl5hgfBZeaOu1mkOC3T339TOcE3FqmBfEEQ1HtwuGxamC4v3t?=
 =?us-ascii?Q?qSwrqCkK843Txb7gR5M7L7fn6zYcNl9wL2wup2SwD6QqjQaYvkRSxOmJX+K8?=
 =?us-ascii?Q?SzAYyjDeomvJ7J6EXLNRqVvqmDflEwW05zO5elz5MnFucyVM4ymp4V6Rfr/X?=
 =?us-ascii?Q?bUUHYicoKDt2bF9MQ1KL62AQCUzVqAoBKlX2kSqh55MJjh21vl2nRASZsq0Q?=
 =?us-ascii?Q?AwtBl0U4Ms5pYyJOY8GxbbY2k2+MpFquq977jWJOH2YcyqDuf3OlA0qw97/1?=
 =?us-ascii?Q?MYr5O+5sUhc++4FpWsYdAfpgziwaIjZL/g5KFcXFpBw7PnG/mIQ1dnXXECeK?=
 =?us-ascii?Q?Y4+CHqPTlQlCWaPn3Fn2xe7X6AwNlrB6jlSf4PwXIpIqebLqtS70W2JjUIcc?=
 =?us-ascii?Q?KmzO0iSxPI97LKnNxHlVpJiuP6lGtYBEC9BtXSUNvjENipNMqYoic9vpsYu7?=
 =?us-ascii?Q?HQ+qJbKFvwmsPhgS2XFqIKcAUWBNKsx3FudInD8f7FukbbmargQNmvH8R/rV?=
 =?us-ascii?Q?CYKzBMf6A/F2k+zyhTZMo1+NDvJnFeocrBuli0adboqSFSuK4BSKIQNqMbDt?=
 =?us-ascii?Q?4FlvIlfo985lHUHSSaikZ0jerYc1Va0amlqGZ+2O+EOL8+JeBGu3QhvGrHiO?=
 =?us-ascii?Q?wV5bEt7KfZeuU/E8mZz6nGIM8WzqDdB9KvTIR1hPLxVs8oGDfkhkmTbpVlFn?=
 =?us-ascii?Q?HJKmzuiknub7UG3tftFk/9cnHxe4oqhm4W6nihdQDPOVQ6fLXWodBqe9CKCe?=
 =?us-ascii?Q?l4KPuWycbWu1Ru+dY0cr+OwlsAEJbfzN80RXXauYSagwwu/glGbesjaRRBx+?=
 =?us-ascii?Q?YifIb/zdDSqfKaflLdPyKM1RaZCKgejYXjwKBGnBlQaKELNA/LLlTZcOzqTh?=
 =?us-ascii?Q?GkbzIT/EPi8d/beStnF4nQsyMFjDPNlf90Y9l5s+qtdI/aFcgE/aplL6L9Rw?=
 =?us-ascii?Q?0wJTpWVK5m+Aja7ICOpEa14HvoYvK0CGeLGk5zGyfwNhIsPYobmQfKgiFyWA?=
 =?us-ascii?Q?BpcmCtdtwhk0zkii7DXTfIAk2r0GePOVvSVIABRM0hrovkcFSBMbWvh3yy1U?=
 =?us-ascii?Q?tQR0aTNBzKi+jLo3HZtbxh/+DOTJYPWlDxo5nDsPc5ADPuMEsrEysjjuc4jW?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a159f5f-d79f-4b36-6be9-08ddfd274463
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:25.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKGV4wnRLlQOZNLvgTrYtCN7n1qZGbfz5F54CHfQt0opb8Sa5D+MK5Pd94KTlbFp0upVxOxf+SX+V4sbiH85WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

The driver will need to become more careful with the values it writes to
the TX and RX equalization registers. As a preliminary step, convert the
magic numbers to macros defining the register field meanings.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: remove duplicate LNaRSCCR0_SMP_AUTOZ_D1F definition

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 102 ++++++++++++++++++++---
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 414d9a4bcbb7..684cafb3d3e1 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -70,6 +70,12 @@
 #define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
+#define LNaTECR0_EQ_SGN_PREQ			BIT(23)
+#define LNaTECR0_EQ_PREQ			GENMASK(19, 16)
+#define LNaTECR0_EQ_SGN_POST1Q			BIT(15)
+#define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
+#define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
@@ -89,12 +95,56 @@
 #define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+#define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
+#define LNaRGCR1_DATA_LOST_FLT			BIT(30)
+#define LNaRGCR1_DATA_LOST			BIT(29)
+#define LNaRGCR1_IDLE_CONFIG			BIT(28)
+#define LNaRGCR1_ENTER_IDLE_FLT_SEL		GENMASK(26, 24)
+#define LNaRGCR1_EXIT_IDLE_FLT_SEL		GENMASK(22, 20)
+#define LNaRGCR1_DATA_LOST_TH_SEL		GENMASK(18, 16)
+#define LNaRGCR1_EXT_REC_CLK_SEL		GENMASK(10, 8)
+#define LNaRGCR1_WAKE_TX_DIS			BIT(5)
+#define LNaRGCR1_PHY_RDY			BIT(4)
+#define LNaRGCR1_CHANGE_RX_CLK			BIT(3)
+#define LNaRGCR1_PWR_MGT			GENMASK(2, 0)
 
 #define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR0_EQ_GAINK2_HF_OV_EN		BIT(31)
+#define LNaRECR0_EQ_GAINK2_HF_OV		GENMASK(28, 24)
+#define LNaRECR0_EQ_GAINK3_MF_OV_EN		BIT(23)
+#define LNaRECR0_EQ_GAINK3_MF_OV		GENMASK(20, 16)
+#define LNaRECR0_EQ_GAINK4_LF_OV_EN		BIT(7)
+#define LNaRECR0_EQ_GAINK4_LF_DIS		BIT(6)
+#define LNaRECR0_EQ_GAINK4_LF_OV		GENMASK(4, 0)
+
 #define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR1_EQ_BLW_OV_EN			BIT(31)
+#define LNaRECR1_EQ_BLW_OV			GENMASK(28, 24)
+#define LNaRECR1_EQ_OFFSET_OV_EN		BIT(23)
+#define LNaRECR1_EQ_OFFSET_OV			GENMASK(21, 16)
+
 #define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+#define LNaRECR2_EQ_OFFSET_RNG_DBL		BIT(31)
+#define LNaRECR2_EQ_BOOST			GENMASK(29, 28)
+#define LNaRECR2_EQ_BLW_SEL			GENMASK(25, 24)
+#define LNaRECR2_EQ_ZERO			GENMASK(17, 16)
+#define LNaRECR2_EQ_IND				GENMASK(13, 12)
+#define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
+#define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+#define LNaRSCCR0_SMP_OFF_EN			BIT(31)
+#define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
+#define LNaRSCCR0_SMP_MAN_OFF_EN		BIT(29)
+#define LNaRSCCR0_SMP_OFF_RNG_OV_EN		BIT(27)
+#define LNaRSCCR0_SMP_OFF_RNG_4X_OV		BIT(25)
+#define LNaRSCCR0_SMP_OFF_RNG_2X_OV		BIT(24)
+#define LNaRSCCR0_SMP_AUTOZ_PD			BIT(23)
+#define LNaRSCCR0_SMP_AUTOZ_CTRL		GENMASK(19, 16)
+#define LNaRSCCR0_SMP_AUTOZ_D1R			GENMASK(13, 12)
+#define LNaRSCCR0_SMP_AUTOZ_D1F			GENMASK(9, 8)
+#define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
+#define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
@@ -104,6 +154,12 @@
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+enum lynx_28g_eq_type {
+	EQ_TYPE_NO_EQ = 0,
+	EQ_TYPE_2TAP = 1,
+	EQ_TYPE_3TAP = 2,
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -151,6 +207,8 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
 	ioread32((lane)->priv->base + reg((lane)->id))
+#define lynx_28g_lane_write(lane, reg, val)		\
+	iowrite32(val, (lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
@@ -311,12 +369,22 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
+	lynx_28g_lane_write(lane, LNaRGCR1,
+			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
+			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
+			    LNaRGCR1_DATA_LOST_FLT);
+	lynx_28g_lane_write(lane, LNaRECR0,
+			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
+			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
+	lynx_28g_lane_write(lane, LNaRECR1,
+			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2, 0);
+	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
@@ -353,12 +421,22 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
+			    LNaTECR0_EQ_SGN_PREQ |
+			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
+			    LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
+	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
+	lynx_28g_lane_write(lane, LNaRECR0, 0);
+	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2,
+			    LNaRECR2_EQ_OFFSET_RNG_DBL |
+			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
+			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
+	lynx_28g_lane_write(lane, LNaRSCCR0,
+			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
-- 
2.34.1



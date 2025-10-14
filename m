Return-Path: <linux-kernel+bounces-853088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F7BDA9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08AF23433D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2C03002BD;
	Tue, 14 Oct 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iAaFp6rI"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092A2989B5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459322; cv=fail; b=m+SScmOU6qBdMVzO9mB3iLJslgejmdgULjdBxBs3bK0mLBIEbaGceEY9MWlTx8Erev2qMryn2EPicMLEFMVsDFENiAUXWbaF7XpXmhEtm/KPMotWSn6J3XJWWZw04KWoJMnxES2WvE+vhMp/5YNJL3lPXaAXcNRLK0TtNkM3nx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459322; c=relaxed/simple;
	bh=N0GcK3n1Xoi3MnC5mN5EKoFqxQoVyokAR53aldiJv7k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Dsqsrt/4x9X8ixz6aCtayRAGo7CNgK8RHZkDGBpP+Vh62Bkg2yxVfbVTZYr59P5VNRhC3BmoaUgPINi+k3sewQHwSeGtWDydYkC8baZaXb9qM3LiWe4cm3459Dtwl1UejSDlLHbt85NLW7lSgEefkQbRe5UqWUyGXrMgx3VKjj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iAaFp6rI; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTXzXshjLTTj+A+uvoZvLKttIGXphEsmlQfKeZHc/mE0vRtzWtpaakNT2KRZUGUR0ANN7nR8DO0Ukgda9pf6MeSnzyp+KF6RY3LYFssk+rbjUciGeFzBLfNZV3NaIegOb+Z9VlLpTqRiUYVLda2d4mK6o8NFrUmeuHzdXGeE0jXOc9W5yyRNGT5Z6E4DC3tlM1VwQFmBDpDxFjZRX0HyIYqXYpnBYFNxXLFKdHG+OompxNebOmgGTyYt9M9LDmTErdYwFgNWAJksaDc9AI1vM0R8LcgsE6aC5zXCTDZQzwzvDorcdqt1FedAIXFnv7dkYfrBGKiR1Qn6j0IPeN9Crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blVAp5RKUtNA0jab27czo5gHDZ9I4YGZe3IAnxUpfjw=;
 b=Sky5cB1ipx71fBrnOR6zEfQInTTcHWTPY02VAzvI91+ew9kN0dv8cNgGJmrJTZRPWnOubAgo3tnJ6jSYUWqms9arOLSA4BPLFqFantMTuZEelI1C7TxhJAQ+DLh8u4l3RC8MiIMefDi7mEhQbcIdzNqP97qiSaoWgiCG7+MvojRDkhiGdtiHttLuudCtW0HR9GCR/UC8IBYmylQW8VCF8RVR8R84V7kovMmWOFziagbG/qrfcL0BSuzBS5D6H9WB04SA0pcez3a5V0RK19jySds2RQT1vdKNCKzMrL4nIYUKeuvK2D41A2UpSUCw4BDKckrbihg8aRH8W2LnArFBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blVAp5RKUtNA0jab27czo5gHDZ9I4YGZe3IAnxUpfjw=;
 b=iAaFp6rIXy5x7zR5q+olsTy3/8/RvEYOjAmdI73mC91QSPfgwjAQRUZfWMUaDcSQBA0tNqQHAGeQMKgYtApIdZoGUCX4V710Vxxy8yh1aUeo8Qv0pLdoVqW4M8UrPDlXHiPmHGb5N2Jtyj9CRL0JO/GvPes1lv/Q71jZLylbJm3qSBwHWHimK3EiQtS8VCUV/OKAuR7hSWcUme4k31BdVhLdtQ8gMPtwZ959MSEcajyWXvQ0okwTNfd+ZI0Y9Nk3I82mpB4UQJMUi3XeM97cd25LOU6yosLtrq32KbTo/Tz6od5tXOKEk3I5yR+JfufwIQCnZOy/JPt9gjuCZamHEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI2PR04MB10906.eurprd04.prod.outlook.com (2603:10a6:800:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:28:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:28:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] i3c: fix refcount inconsistency in i3c_master_register
Date: Tue, 14 Oct 2025 12:28:23 -0400
Message-Id: <20251014162824.2324333-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:610:b3::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI2PR04MB10906:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a9a370-87d6-4099-f06e-08de0b3eb9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bo4z1Dtq6yL5Qvy30gVau7d4uFT9TSEG3b8c9fqHg7szIw/awzn5SGRPqje/?=
 =?us-ascii?Q?3bAcYryiZp6XFHnShxfKlBPNrb7qpXbm4jYmwuTscUT0cL00lq5zDisUD7n0?=
 =?us-ascii?Q?LFVAngHiGtqAH9trqmHmvRk5V/Pl8FFORsjUrqcOG5j370PIiLmPvJ5TsoQj?=
 =?us-ascii?Q?znFJs0Bc7gIBmAuPZCPGYVwMAGLXj8CSGHFJ8vpkDqrR/psqINm5il65Sfzu?=
 =?us-ascii?Q?/7WILXLhdL2grkpsaOl6QlqU4Ds/YzN8PTjmUzonYSiO2oSdrUkrFxCNzMC7?=
 =?us-ascii?Q?QAUjrR3tjicpEMmyiwjlc31S22U6gjYyYXYkp6oShffHoZhszXAMkSpD4dLd?=
 =?us-ascii?Q?CUOjTliyYwUY/CEimEyqbgqOm90bdiSCD3fe84gixXfydt42FjuADMzM+AMG?=
 =?us-ascii?Q?GzdliOzjBfSNOyVzCYpgAYCtZFoSog1U0xClaw8aqQcVO+n87HJd2Fb5PAbC?=
 =?us-ascii?Q?IQbKq1FRD03POatyBGFbjT5QdmLxg8SCxLcXKbxegsrs4qSSf+Q+5PO5k/j/?=
 =?us-ascii?Q?hgP+Pah7ZUsXIn0Td5nkdArUAYjJio09ZVQz7n4JAILO9bgahrK5fSdtPIsQ?=
 =?us-ascii?Q?nlS/3f2J3h/7DwdYxCzI9x8APQUbluinPJkJd9ClrikozKRHzAjKx19zgpdm?=
 =?us-ascii?Q?sAjB3gRn3E6FT4IjIA7ZjXY7nc2d00YAfrY+QR2D/9CXhViM/WZKdwDfFofu?=
 =?us-ascii?Q?FMNoDyJLTL/nKdLlb1XPxM0D3NUdc8FfEOvYyReWjOONplKHePp1ATNHOLbX?=
 =?us-ascii?Q?vaTPKw+umUfWbZe0WkZPvCTgXgnJzX0wGcZIz/wDd3T/b6vTdk70nEZXgjbd?=
 =?us-ascii?Q?MyU/YzhU2WwmsEf06JGz+/wayYLwcvyOff4pj0vdMpHQ2+b/i1ee0vzpcAXR?=
 =?us-ascii?Q?UkdMaWzs4cVv/MCVT3xgDGEpSpesNku1otOOlAQUckmunGDZXrFz6c5MrHfd?=
 =?us-ascii?Q?KVGlMtzeRmoR+Vm+DKztcupSz0xBJbEEMGKXXDdTd1r8MYKwDaR/DN6n4weW?=
 =?us-ascii?Q?ygSkVdkLDRIOzu0DdvjRobggH3VBmmpnrM5GBa+53w/9fh0H63c20eQn0tWH?=
 =?us-ascii?Q?+2dJQBygSGs2kBi18mgNtERMez7FnOhZ0Ptx28XHuVSUHY/W9sd2rJPkGL9c?=
 =?us-ascii?Q?tlsRvMLmPWxcn3mOHXLumgS7gY1rryCTOd/fAmF/Rn8zT4VMJ4zDU7wOZgkF?=
 =?us-ascii?Q?+xbISatuzrxsSLqHDFmtZ0RDL1AeAV7z30VeQAsH8bJg57r1kXByQbB71bUU?=
 =?us-ascii?Q?vp2HG/ZacyAX7a0WmVRekv2bJa+H7EALdJgYIhjYyUnhH+9f/UkNvymMZI8Z?=
 =?us-ascii?Q?x2rHhIrk6PwyCLsdS32NAmfQz+o3IfODMQIDQGi/qaHHHk7xuN5x5+fZ3h8i?=
 =?us-ascii?Q?9iitsEnGhHisX9LdbzSqHgJ1+XUSqAhi/6rkM3iCCfp6OSDaYeCkcwa0mJz4?=
 =?us-ascii?Q?n/rzkqJnlcKxDua92hSxsEq7IuJZH5wjc2nNt1SDVEAlVKtmUeNmuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNMBSbxvqS/3k4BjaX1cFDWsX+S5X02HiIyFx5ZH7MlCdEFj0OjkE58tDtJN?=
 =?us-ascii?Q?nxjb5Q3WdwD8UU+pnlf6M+xW+v2J6VwuUT5UP3cFq+zURnwigPpevOqLJ5L/?=
 =?us-ascii?Q?mJZr59DiPCUtnqX9Tl1NyVjmPhVBdR/xXslUK6V4O8cSqTXX4mhTZMTZa0qc?=
 =?us-ascii?Q?J+uEZGhBTxVD2Kx9Fip1dyGxfF2XyoBpApuKMs32uwYFk4zTOxN52PjOApJk?=
 =?us-ascii?Q?8kAxCbVWDj+gNXaNkPgRSjX5i68GKaVzqGzoN9p3gfs+N1MyTjy0IPDTvQzQ?=
 =?us-ascii?Q?7ScaZvBNgtnju8uzgvcsgQB/T7xa7P3ozG2jhyux+jDuj8Mb0NQgLGR6sp4j?=
 =?us-ascii?Q?uwynXb//UkuW5ml0tqV0NLRvpOs8MFhNRVW4SLdSN1ElGBdmI1w29zsbvaLY?=
 =?us-ascii?Q?dVAqlP1/ZIzqpOjYbmIPxV/FeZ6meL35C2CUjJU7oek+oeqrmFkdCov5HfWh?=
 =?us-ascii?Q?zfFR0jnbN2U9LWNS3r5BmdhjYfHY1jycR3MrKBwbMzXXLdh3EKfPIdrBjq9B?=
 =?us-ascii?Q?81yP4b0kne8oJJHLAB8zBgeyP7eCqqN5m39AVMJp2XwqCpUruH4foIk9+AbT?=
 =?us-ascii?Q?qGUhVmeK817Db0MdiNuE3WKaFIzhi29dIkP8M5jDh+az0c+Oz/CO8ooqNRfw?=
 =?us-ascii?Q?3rLG/eDIl1/Dd20y9IWiG36z9jlQyaDcl907pn4CUdD3jK6ZVqc0C1MFBh5e?=
 =?us-ascii?Q?R47298l/OtNjwpgRLPAhZzDNb9w43Kjdt+0yLDRLzHjTruLLi0Ov1+pscxfg?=
 =?us-ascii?Q?oH9MufSeECvT9KnS1yWVEtgi0bdn3qCk8M883bGKoKh71ZVtMv5DQrJ9jZzW?=
 =?us-ascii?Q?Fza0ee6d0mY6me82Dwijd3h2xRw9SKkHgzS5zkuZdtlTvlaOmqYGd6cUbRty?=
 =?us-ascii?Q?qh2M1OAIWAkqRnC7eIBXfhvDi9vOLqLCv2uqyN/w4/lsGQEgdWQf+6p4/QHE?=
 =?us-ascii?Q?TCLAp1U0ALb+UnkEK/lTyrbGoWxPAPWXrSpoxTfbVhpdFfRz1XfmOuDi5JU1?=
 =?us-ascii?Q?YXtL4VhkGDW3ES/6RKW4kydrbeFFcgvPgCJjeFcNgQafxI0w94P1JUBSRPZb?=
 =?us-ascii?Q?T/+ke5V7b4oGPUu5XYfckRy8EELYp1Bul8+iFSuqsN9TD+oktEdCPThiR/+6?=
 =?us-ascii?Q?ABt1BwUnCqe7VRnMKJVSVY44fWeqoXv1YzOBpuqbBRZvpZxMmG9xhp2LFLoF?=
 =?us-ascii?Q?RUONyk0hxnRCls6AM5q5RARC9SvbBDJdxnhZ1kK79XRBYtkXfqMsDpL/su8K?=
 =?us-ascii?Q?BrfB2k3JclRvQ8CKbzHNxB/98o0AGknws5cNk8AODdLPc06ly1g00HtQ63Gl?=
 =?us-ascii?Q?JklmjATN8pfGfk7SyxwgeXgJYhax2+O3laW6SUPJT3Y2Rr33haVvf+WSHo1a?=
 =?us-ascii?Q?ieACxDqSXDFKB/cVWiTYZL4V/0nk0IUMkB6E60jMSpkuPzDav+ULSa9q83kd?=
 =?us-ascii?Q?deZDReVxyJyAbbUtjYepQBLl0mqhSoPjRMdmcFZ0Y+22XA6VxymcOEZNhI5V?=
 =?us-ascii?Q?ZqwTAUOKUTAtEOZQuE4p7OzOoer7bgW/c93ts7tLFlqNHVP9fKIkJ5riiCFs?=
 =?us-ascii?Q?kDXZzanqtnKt9xixetw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a9a370-87d6-4099-f06e-08de0b3eb9f9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:28:37.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwvse64MjXYwUrX/PsUXWWUkaTqEPOP937LmQ2DsagiejIBm2jXHZw9v4FCE/ew2zufCa7GvruBXWQJt2v7N3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10906

In `i3c_master_register`, a possible refcount inconsistency has been
identified, causing possible resource leak.

Function `of_node_get` increases the refcount of `parent->of_node`. If
function `i3c_bus_init` fails, the function returns immediately without
a corresponding decrease, resulting in an inconsistent refcounter.

Move call i3c_bus_init() after device_initialize() to let callback
i3c_masterdev_release() release of_node.

Reported-by: Shuhao Fu <sfual@cse.ust.hk>
Closes: https://lore.kernel.org/linux-i3c/aO2tjp_FsV_WohPG@osx.local/T/#m2c05a982beeb14e7bf039c1d8db856734bf234c7
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2:
use i3c_masterdev_release() to put of_node to align other error path

v1 by Shuhao Fu <sfual@cse.ust.hk>

https://lore.kernel.org/linux-i3c/aO2tjp_FsV_WohPG@osx.local/T/#m2c05a982beeb14e7bf039c1d8db856734bf234c7
---
 drivers/i3c/master.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f5f44bd4f4839..b36d4ffadeff2 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2814,10 +2814,6 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
-	ret = i3c_bus_init(i3cbus, master->dev.of_node);
-	if (ret)
-		return ret;
-
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
@@ -2825,6 +2821,10 @@ int i3c_master_register(struct i3c_master_controller *master,
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



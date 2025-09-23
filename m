Return-Path: <linux-kernel+bounces-829593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D16B97676
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2714F425E93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078D230506F;
	Tue, 23 Sep 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bFiW3S3u"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88C30C34B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656735; cv=fail; b=LUjmMlN3CFIZfhPRW22kZ4qRdNTkwj/UUIIWn/mKlCdS2xmzgcIMtD+TsjJEzOwPtgB6MlxL+3TWmisfEDNLicu8zl9vwGW2AkBCJfX8VG+nfZEpQuErI5yw/nVNqmIQrP/j366kBRteOgU0ksgwvbqomYWqJ5TrnfPeTJfpB3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656735; c=relaxed/simple;
	bh=nOkrdgCyyuW4qK/TSoEVZzFbKnqX6cJd+i0hfzzdvF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9o501N9G/FqMh8FRiR1bhdaYsYZHRgSi2Ob1E0gtrqiBz/zuYZ9r9wqMb1M42FULPRly5g6ZEZDalCNDXxY1PkQ1m7KEq2yLwzvYpNeZ+nGyE9BVOdcY8Jy0pfluFUGAgPwj+ZR3tZLVnsQZrgGyB/7LWlMluOwdgVUzkFiYtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bFiW3S3u; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8JwEV6cj7jcUEuQHyHjKR9EDHxlklLgZ3o4u2n6ycZN45kRgLSYU0N9Hde/qx3lo7sRZ0fUaC9RP/wkLKP9/+eBaaa383xZ4gnnoZrYzaWAFKkEfe0mBfLzTKrN80dKbV2LGvjtLBuTC0ZhhhD2WXPnWjH5CwVvNtpWxPyOXZLooTG1QA99o8JwANRWL+7lCe8usE1ZkEZduaB0LQ+ACdPDQTBvr8D1tOHU+sqAkilHDBhwQHsyQmkHZmFjjxC565FuGAe/tfEaqG3Boip5bdvjjA3l2ds8pL9Uo1HGKkhDrVawBTYi6nhk7mfr17fb837xurjxtMkHGbliPi2meA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm2plcELlft7tdGsvqHTqtRRAtYiFjtzOpFTuGnqs3Y=;
 b=WDB6sw0B41yXnl8S5XsAx6PqhaGQdtaNrTbb5CEhbtS55lYElQWxfM3msJpxeCyefPkonNBDEsY+Qd2lAcITKMzpE+A9Rvwppdpep7Xdjvuv8Up7zM+fcBNJx9+UqDKUhPrLtsU3x0isgRM3ZtHbUm6Mc1X+KBWiWEJht/FuaA+QumVbOUpv20MDw0DevNTvMVh70lUifB5YzSgAkxi1I4Myt9cT2LvK5ApvXbhWsWGDbMydcOKJ6JQA9cv+1EspmBhSp2KJ8MyYerOAg9GRnGNwBD+spEgpHbGmPTximwyGVw3oQ3p016C6f+o1v9Lat2LQf81yLKs18Jd6UcgCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm2plcELlft7tdGsvqHTqtRRAtYiFjtzOpFTuGnqs3Y=;
 b=bFiW3S3uFFhVCgv2XchkM5ndpV4lWUtItYXCPFOKKM3BPfroEks6SdArPcXGZ9xVPBUxZi8EpIiXY5484uIC3yCehRCY7R3fULUrUzOnn9U7KUtHu/wQf2ExiOWRaelCGQv9hKiwRNC231suaaJutJhrWO/AVhNFEHSrby/uwEoZkqKf58O3IWgWgZUZrnk+9D+0hSX0U6nBIqiHVwEtenTbQWDA2xrdtxHzuxbBzlfV/+W+lV9Ih6mVmpCkyNziRD0wb4+S4wDJplKtsAC4nPcQXRcc/TFblW8jioAJoh7M/LktuTGpPxSHhI+IWnqr7Mze1tqZERTWqHICXeBvYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 16/16] phy: lynx-28g: implement phy_exit() operation
Date: Tue, 23 Sep 2025 22:44:45 +0300
Message-Id: <20250923194445.454442-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: c42adb6f-c4b0-4039-0d85-08ddfad9ba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IU6sYOKmhHab42T0zNc7UtcfyJO3veUk6CElCJ3oWrzA5pdPutbHjzZoJ2cM?=
 =?us-ascii?Q?TGu7Dj7qchdQ0tDYlAbuyBAzA0YQHAD5UPjvWDRnOGQP95VSj9cgZKg/A+K+?=
 =?us-ascii?Q?WjyokHV8jTa0Cd8XVdiF0zJDsUjJKS1oxeVvQKBW8IoG9rdvudll8w2hMLcm?=
 =?us-ascii?Q?Zy14txlViwSHCFMsm/2UAkdly0+sDkjh89XG9t2olo+65TrDSPhu57y4kZGE?=
 =?us-ascii?Q?QOWcUuQw+EBsxRPUuqWKjTXXwNWr72nfQUJyJdfbKT34Ik47W5x0A04ygvNV?=
 =?us-ascii?Q?o0TpitTroRmEcxpMiEZeZFiHXG2rBi9UwVeYyjauUR8R9aXLGo+Nt52kaqgJ?=
 =?us-ascii?Q?vPrZlzdqBgW4AW7/7Q1KuhO5RnsTe3MmbwuJRKy7OmGPyBEdS6XajJAjRSCT?=
 =?us-ascii?Q?MeUODrykBtKhItfstyXgcav5Uws/rTDu1/RTsf/ojDtWWAzQ64gNAxan0PP+?=
 =?us-ascii?Q?iR7zSbWVC5MTgN8qVKJitmzIbSUNvuMZbb4rXU7XJjTQVnOtefBaP8pa3by/?=
 =?us-ascii?Q?T4K7QkZ3tQtQtkCAzuQJmgKlMi8+BAYbXp2yYkX41bhnat1N7fXXp7Tz/AeX?=
 =?us-ascii?Q?E0XnLMXweBKerOvNnQo90ivDwcEyYrvyZLdJiKUrPy9025aAlqPBjl1W/3MM?=
 =?us-ascii?Q?MKipIr/ZZNLsoHpOXdxiI/I8GRL1NpaEfYNNnQ7HT5mqmMMuSUVoHqpCzqj8?=
 =?us-ascii?Q?Gw2TKivZ4k22Cs/IlNL75baxRgb5u+HkIysuqHMzRWiz89CBONLbFzKF2fzy?=
 =?us-ascii?Q?pFmjR03PPj56X5i0RHxPrps6Gh1Jps+ONJ2itsZIG1nh5q+p+nVOdGlvMsEk?=
 =?us-ascii?Q?AhWSNr6KLEM18iC0mOKBVh2x56ym5UBgL0G1AYNDjjhbcu8U8pNqfsddDQRl?=
 =?us-ascii?Q?hzFFMFF2ExnYVb5zgiOVM3niLtCnGIDJvBAHn35L36Co9bU01SP1ruQuBlXJ?=
 =?us-ascii?Q?2s91kn+U1F93NsGsZpLbeMCn6t4Yk8MI6kibTP7alMkRpWKNXC6p4V0hi/rn?=
 =?us-ascii?Q?DIpLFERtf4Ff+xqOMskbjZhAx3/z3CUOBnp7BdQ4wTVPWFzUk8bLQu7uj1Gd?=
 =?us-ascii?Q?jgvYKIOol5exhMNAFnUWjw2EfbRRANR8AtszGL+zztQNJlF/ajFEz74m+vLK?=
 =?us-ascii?Q?OTKiyKvFhVrjazaGcM0tWdLarHqsc7ULEi6zd6lcioOKmP7ozeRhMLO6AMHE?=
 =?us-ascii?Q?J+AXdx4u/fNz10EWSGvSk03csZ3qycyAx7JG1JiW2UFLcUGvqEKy9mPSpHBY?=
 =?us-ascii?Q?XnezUWjW+aJgCZVXIZEcegt5MX0rs3mJUUj1Q2TRe3bh+qBLDPC+0dZo2/Ee?=
 =?us-ascii?Q?yV1pxbASctS6EgGdv78U+qhHXAJMeK+/fvABegeacsFXVreUV9yoiWvCfjYZ?=
 =?us-ascii?Q?Y9C1GB/yntdEYaAcygwO0YVdFC8IRWwxipybPOBUfQfQfpklZgkEi5YG6XbZ?=
 =?us-ascii?Q?gJQFIQTFpRRhjYGtYJIxPitwstj58FcAEh6MvBQxccGrbTll0Ksl9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sozz3o/PIVswRVAJhmZTkYFCiauy3FsoWOBqIhon9m5Yp0ee36ypl23aScNS?=
 =?us-ascii?Q?TfII6Acvsxil/R7y5CfsLC6MDT70LbeMTTMRtTev5qTdn7cm1XhK/L2URGH4?=
 =?us-ascii?Q?cCQrGPGW/xlt1+puGyencZZG4lG/kxjS4EN4N3+I0z+fXf9tJNoZz3i0joYJ?=
 =?us-ascii?Q?UHiDPlmHUyvwJOJyl9vIybT8WBAeQAjwCEzlFGRUjTBvT6RSgXSqF5axQJCx?=
 =?us-ascii?Q?G/WfKWGTSZabgqIN45iSt6chP75k8opYId+q0NLoCRIV53EiN0N3R+vWqZ9b?=
 =?us-ascii?Q?qFX6wDCnyyVIq8lSEZeh6Yu3zToPF91w6XDRUSZeLFAM1STPuUKnN1yRBW3G?=
 =?us-ascii?Q?nsoage/L0oz5ecALRu71h0xAWLdKfpd+lcz1PAkAU8Q14yrKFOK7V3pUUxjY?=
 =?us-ascii?Q?UjKI/Het73b4yWL8MqdNpBJr690TyfxYbMSFD4FowL8w9fg0meBfiioB46+c?=
 =?us-ascii?Q?csGq8umclhjl2CcNc1EPgBr5PKLbzxa7SJga5Jc13Dd6T7xmsih69oFGHwgh?=
 =?us-ascii?Q?a79NjqPovmbjbp1lQYjhh5b2+7wzVCgifrQVRd9YFZr7Xj3Fosw+KL7DLm/W?=
 =?us-ascii?Q?/L/yzVumPtYOEg45OySscUxnTgqRr7SA5u/Z1dIbQRWW2oUsaRooVITDh1iV?=
 =?us-ascii?Q?YxBNVtrmML/XgVoCNXRdc/8CYYVOolVzHoqueG2jtHCBWAMP+UHu5KiOlTC/?=
 =?us-ascii?Q?KnyUoLBX+kXW1MoGGxdK35G5ockqNBgqk17n+1aa54PTfEnCFZ90dxCFJhZI?=
 =?us-ascii?Q?i7q/ckk9BuDg8HolaPDlkZDjAZ5irZuBkBctspOx4IY7AeklY025GHVbrlo0?=
 =?us-ascii?Q?pHKO0ed3TzOV/B4s3XmdPJqCbUOZe/sQjb1jBNFHkl97l3LXsnNSIaKTpNR3?=
 =?us-ascii?Q?Z1TG2QCc4Hs+I/I/xy/0lkIrOHkKwTSZX1k559O3p6iVMer3ycpFtC1fDwGX?=
 =?us-ascii?Q?CrGy6oU+k5iXo7nbj+4IoPbvH42f4Uncdo2Viyx8Fv1TNtuFwUYl/tiphJ8i?=
 =?us-ascii?Q?ISuB/wFmaEk6yX9RSFFaGp58ixIZLIC8mHz0D1NT5ZTtyom632Z3cwfhNfSW?=
 =?us-ascii?Q?V7WHLd6W+ai6RICT5H++1xEMqzA6PjNrjF7UZA5yJlK88jTkJ90JYPVuMgfi?=
 =?us-ascii?Q?CicJILsBT7IgAK98cpnWawstcenv57MfK4GLHF9N70mbIv3J9GvfiQzyZcTj?=
 =?us-ascii?Q?wuZLCrSX3K7lX0B5MNIpea2GMUxUnOiptrkRR5i1hHGNwasNdIu7UzPX9tXx?=
 =?us-ascii?Q?5ZV1Zp280kUrQvGX7CBw0o4TjjZwD2bw6JvX3hQY6oEh70Z2Ztv5o0K8nzhr?=
 =?us-ascii?Q?qoVf27NKgprwxeh8R8KuoTJveRa8+be0c4w2eaiXUg7bY7+Huq9HF7P9jsBQ?=
 =?us-ascii?Q?3g0xwnIpdtN5GHIgcr1/bDQ2UImFuS16rraV6e+cI9PTBZBov3HF9ZATyEya?=
 =?us-ascii?Q?bzjCO/CTxAx/GeipkFBWJSbK/9SKIUZrSHBQHOY+EutdOO6McZeOvnaBNr8/?=
 =?us-ascii?Q?1/Q0BTZ0tixuDYhVXWx4LOHP2a/ww6YAzMGrXNa0hfpkp5Xt6YdLg7L/JXYF?=
 =?us-ascii?Q?ffSUpMg7zneMEkTt8fDMcycmg1gc4zWV/sdV3+aHeuqbc6JiFh/s3DjrmInu?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42adb6f-c4b0-4039-0d85-08ddfad9ba57
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:19.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW2YZNrWX7/OpYhZwQxWcSkp/Vl4StFuWdD7nIBcwmrCKYFA0iUI21tCM1DcdYbvZaW6qRj2iaqhB2bGdLEwdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

Managed lanes are supposed to have power management through
phy_power_on() and phy_power_off().

Unmanaged lanes are supposed to be always powered on, because they might
have a consumer which doesn't use this SerDes driver, and we don't want
to break it.

A lane is initially unmanaged, and becomes managed when phy_init() is
called on it.

It is normal for consumer drivers to call both phy_init() and
phy_exit(), in a balanced way. This ensures the phy->init_count from the
phy core is brought back to zero, for example during -EPROBE_DEFER in
the consumer, the lane temporarily becomes unmanaged and then managed
again.

Given the above requirement for consumers, it also imposes a requirement
for the SerDes driver to implement the exit() operation. Otherwise, a
balanced set of phy_init() and phy_exit() calls from the consumer will
effectively result in multiple lynx_28g_init() calls as seen by the
SerDes and nothing else. That actually doesn't work - the driver can't
power down a SerDes lane which is actually powered down, so such a call
sequence would hang the kernel.

No consumer driver currently uses phy_exit(), so the above problem does
not yet trigger, but in preparation for its introduction without any
regressions, it is necessary to add lynx_28g_exit() as the mirror of
lynx_28g_init().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 798343b55ec7..718caf67322b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1226,8 +1226,24 @@ static int lynx_28g_init(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_exit(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and always
+	 * powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+	lynx_28g_power_on(phy);
+
+	return 0;
+}
+
 static const struct phy_ops lynx_28g_ops = {
 	.init		= lynx_28g_init,
+	.exit		= lynx_28g_exit,
 	.power_on	= lynx_28g_power_on,
 	.power_off	= lynx_28g_power_off,
 	.set_mode	= lynx_28g_set_mode,
-- 
2.34.1



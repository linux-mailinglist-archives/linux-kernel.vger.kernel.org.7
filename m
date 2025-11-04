Return-Path: <linux-kernel+bounces-884414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8FC3020F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F5218C24A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4843164CA;
	Tue,  4 Nov 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Cxw6isrP"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F2316199;
	Tue,  4 Nov 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246428; cv=fail; b=KZnJaYqrUusbjPyZMR54arZdQTiz73a7dG98+GRrVoAZUW8I1VZ0woH664aNkCCam6KskwxnLIikQVxkj/HFcspZFxmV4NGZiyXwCuL/qfSQMZsWPFkaUgGt/Xaima2J7YUUxJ+oxX7a7jPekbqug77zOnlFm0zL9rJJ6zQyC88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246428; c=relaxed/simple;
	bh=7itB0DtR/0CwTuFCVGeW/w6K1vJA/LNAD1MjBA64TX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8IV3A6gtnx/iBhFSZIdTuIO864xtSgP6WVhegoyEXWVXukCoL6Xs7M0/2T7TtGlz7+Ck7C+3dYMZpi4R3qmjH4bxMK6cSH6Ib+Jqt4BnFX0j7wKJ+8eS/TDKyjfxYwugLy44aArknQyj0+Ac5OwjzCHIymvIbX2bPE8JISpL+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Cxw6isrP; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUpEzdXXUUkuc9bSBc8BMIQVHDmmTVqyPWf74QeIlIMSFvnwURRUUSHOlqRm6Cbjy0J2DiX+MSd4nTqFuRBj/Pl5zhkdbXjJG6nxNerIfYjszz0WStqG2MBlpRObyLcWAycEGdVMALnizSG4AdxTffKWbFwNKZ6bnwqdFAJg4OUgxgVuYZ4t0GkazMqLEI6UKVAsCMfBd64XsuGMdVAU6SEZjn1zLMny4ZdT2O3WVUNTANL19/VUYCB+AZh5vUb9bpy4zaBdetJhm0G9VRcbtS1vrHXNUUd0afKRoLsxOL8cSfWdguvCKl2QTDY9tRQmseyxTS8uqM99FzfJK+/JWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es1x9w82UiH3pPjPmTe2t6cV5XswLwV0YfJPLt8Se/g=;
 b=PeGNkopKTF13M3nJhh+mlhZJx24z65FGfSg72E3LJxtpiqID67NV0ZuycK4pdVztmXzcWxbk32sI0Y7TAyGe9eqYEtrNXmpYYqRk+F4wDgbV2k/F+RYgKppg+0k9nq3leEBZppTjjlc8E4jQp8Mr0qK8Gj4eNi6XVCjyaNMqTjXQktnOLZQ74BHRwUHHxgo9RAW4WTPGVKtTRNccnZR+im7PkZHskZclOK3EYeaXy1wl/tMiCWO2beMzNSIbZ/7Qpbm8+mxifyBHtwpcu9kofA7s6M8YSKjS/YlseZsdUTdCIZ99MLlYIGVOKxxgnfZh90pZQp63c6eDXVMFzY7MTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es1x9w82UiH3pPjPmTe2t6cV5XswLwV0YfJPLt8Se/g=;
 b=Cxw6isrPeU0ooJsfckt+p8pponFL7ghNS2QVRe8m5YZIo7FrUP9VeqruXLDUnxJd8ecV6NPUrc6Eln5seN3K5ys1jMBZbprbZCr7uYJvvBOJhJCpOKar6a0oUHmcy1ekY6Ec+M532xORb8a65yUkwEA4cm0ukhHYd7D+rXbC2Odwms3wAJEBf24UhfGa/CJcVIMX9N+pYU+JGFRkLyBStCBzIg26bkl101moeOTeXuiWXUfzR+LCDDkjC4eY056ySlZYkcS7LXhnlYIYUo64jUqxOmJjM43FbxIh7nCf+pYV7phqZoCesEOEW9K7IKMmIpRQaaSEsjHy1eNTm390IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5164.namprd03.prod.outlook.com (2603:10b6:5:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 08:53:45 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 08:53:45 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 4/4] i3c: dw: Preserve DAT entry bits when restoring addresses
Date: Tue,  4 Nov 2025 16:51:11 +0800
Message-ID: <92deba7e5a210fdb7d525aa898210c2a6b7b405c.1762245890.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762245890.git.adrianhoyin.ng@altera.com>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:d10:24::8) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc7ccf8-e2a5-404f-ab8e-08de1b7fa965
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yd0nHYbUDOhGsfRBwBwYJqnLg8tr+AqtGzmUyXwfqfhVppa4mlvOzvUu4HHh?=
 =?us-ascii?Q?FVltBBqUaTxH2I2fzseNUKLN0I+QgLT6P1DBSMnv3g4zPgPm+40L88sU2Fel?=
 =?us-ascii?Q?r1G1gyNNSVzaQ0uLmFDFBxKvVShFI8Xp2rcKg3FIZNKvdEzEshRPj58gRx7z?=
 =?us-ascii?Q?dWwYVLRGzYi6GrrJgtp3Xwos7Fh4yIsaKp5IBAFpcx5fbb0hJO3/Wd4CD1y2?=
 =?us-ascii?Q?UPRvIrbqBj0Xc9C07df/jeEIJBuJjTc6/szzRO2x2ZyjeuWQRNt9wtz86Yf1?=
 =?us-ascii?Q?BBnIyhU+2ZSoDIV5tckKQXIJXdj+3Yd40Pe6ozzUOm1fNxBuinYapkrjH3Iv?=
 =?us-ascii?Q?LMKEDNZTH4VNBgS2mxSFU6lPA26/gNQTa0eGWk7c1gPmALfxqh9AWSm0JEXU?=
 =?us-ascii?Q?4McFts2re714r36TN8nDQQqx96EOciDn11rSkUFW8BJNZkzXz22oUkyg5bAb?=
 =?us-ascii?Q?UWILxbTykvJISxj7/9dMMSCyvB/9FVsOw1sBkZQFjCW0jvaCln2be3IcYqqK?=
 =?us-ascii?Q?lmNHHRL3snz7SCpXy7p+masbr6P0Go4cuX4bL0tv/m/op+d+3twBwO0d4dmL?=
 =?us-ascii?Q?NRIqXyAkbhyh7821wzp9ThBt0iQlEFGKbfzidYHPTNjISmsM4Xk11dVOv4QZ?=
 =?us-ascii?Q?iTyyVnT1hljBjsRB9s97zTTI+d4CQKD+Y/i0/Qf6NjlwGeiuOZ/7We85wh2R?=
 =?us-ascii?Q?FO4xNkCVs5s3D0zE/71LedTgdN6qx+qkBxQPBOvyEZDslHRt1ZKJPqL52/Lh?=
 =?us-ascii?Q?HylYlEi8dFrPYAuux6F95IHayp/NZctldJlqbyvHu4koSQFYVt7ACPXaseTa?=
 =?us-ascii?Q?6tKpcKRwcKwNiDpbyby3KAx8ZyRW+IdlEvYWeIkE8Y3K5vnUwZGQ8415CjbL?=
 =?us-ascii?Q?UUuXBkloGabYsd61eygFZPDS0ECAsIRbbCDYLBCQw3HY32gkXQYS7MPnbQ3t?=
 =?us-ascii?Q?44v1rrkrKN/tY/3DQ2+g5JHfeunbAEbp+r9PkBGljvrMX+OSF7VAlPqeUVX9?=
 =?us-ascii?Q?f0mPxI9QYfv/QzapmJmuvbGPKfDyAHbsR5HceLpcCC9Y+ktxum82j7H77446?=
 =?us-ascii?Q?FEsen87AptvAw5hwn34FyHHflBGbiHk6GfFX6owlKtfjllPIxCV97CL3AJ3l?=
 =?us-ascii?Q?Q9Oy2yrc4U3IgNiYD11WdJ09e3A2JvBZYPDKY8lSaZl9ZW2H3a6dj75H/CJi?=
 =?us-ascii?Q?X/XZH5g8skAr566lhQPGL/3O2nQ07HPVENxi1pmiMT8U1pY38UItNcGk1yRd?=
 =?us-ascii?Q?fB7Rv9XxxdYmf5B4sdbP7Vb8iEm8Til2ZXAyv+yVouhRx2xEFf26MXmZGjBa?=
 =?us-ascii?Q?Yh2a4QUsqGn6DLChSlokAfi+hEnZSFjQKFTSGsYO6o93s+lr7VfTiBhxVzuo?=
 =?us-ascii?Q?JmBqDVNy/sGPCwIc366klY7tRE2B1lfOleXWwYudKqRDcjPEQs+4SKcaaoio?=
 =?us-ascii?Q?ZoeUf1yZ4q3UuFVmIqEaK8WMsJ027ILbmFgLG3WpPa0Mn5peNpR086B9x/8x?=
 =?us-ascii?Q?IVqqnqfFDPx/heM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+ro/BkZ1h9AegfaaawveGaZdG/LnQ3C5fht9zisCwIN/4ri+XvpCD5+5GXX?=
 =?us-ascii?Q?+xuQAPDMr2IlZGccAksHvcRzVLJ8MJFiNvqaa3pUb9EohFDi1aOnEEv/79dW?=
 =?us-ascii?Q?dXOrNUJHtUmEFpsGoNvOOuL0ngF0MhHZngntyXX8a5tiUxmxvB7klOKGtqIz?=
 =?us-ascii?Q?JIx1prEBtk7IWtpylSxEFOAjGe37jGWXY7jLn80JhDaUGbuuYZHfynplMWCi?=
 =?us-ascii?Q?yrJ5D+aXxWUCAGEjfWvyngOs9BF+wQIacnfhf83/0YzAcZuZr4O+foSmWqNL?=
 =?us-ascii?Q?C2jFW/57vLCw0lCUwvslKxqqkwI24wIO5wklwmr4O4t140km/1bTL1F9/Him?=
 =?us-ascii?Q?4FCXzF+dVlkGpRAvxN04J7ywe1M0dmKTE/8HsnwWhenls5jxoRSxZdH8qhmH?=
 =?us-ascii?Q?0J1TsikGw1InjtOSlF5X/6rQ8XZ1yCvM6yxByqvAs7Sz5Q6IaOl37h3nOCjx?=
 =?us-ascii?Q?2zFZfAvBvM9zuoBNjAbEVuHnTrAm4hKd2hQv/w79KJDIsnU3n0d35+t26CmJ?=
 =?us-ascii?Q?/wuhuN8SJmYJ8CLG9KKKhEKGpqerS8vQ4K+VolV314fOMUrxzjUVFdnJ5Y4S?=
 =?us-ascii?Q?CtGlhJLea4lJbvT6xbqj+KE4sHB83JwvfKFWYv+K8Nceb/SuE/cuQBHEx2FS?=
 =?us-ascii?Q?W1g75tBuT4brur9VaEKXXt1umJIHEc4IxBimoMcFVSgG/h5BCBPDnmfFFh35?=
 =?us-ascii?Q?15jj47nL4ot3ed12lFvlAP50bHoI1sA3YJ3dLQP/TvDc7Qsox6M1Yk9HIAcU?=
 =?us-ascii?Q?G7+qstEowAT3/L65cM5WTX5G0yRoPFkH4jlKkvWKCOrn26HC9PPVdJIt4oaB?=
 =?us-ascii?Q?FJ6g74HUOVokjSCqPAYpIIFAG9z7rGRerkVhKNDBiK3BHb/DOYjBvuZUa0Qz?=
 =?us-ascii?Q?FJm7RRlmt7hyIId0mvC/yfRzKyMrtPfCefZL4GMPHmrcF3En3aaZIyBbkL/u?=
 =?us-ascii?Q?GPn+mlPHseXi2JQU03ExPPKUgKI8vJeaL8u9r6PNGQ1EtUHPWMnYz9qY06BU?=
 =?us-ascii?Q?8bqNNt1IZR0DYbUivmzYWe0c4xE7d19CcC8rccNancR+g7l9MV6+rWu3yOLe?=
 =?us-ascii?Q?fH9szfowP1+bGex+EsMlcX4YU5L4noq8Z4KB01qo3/s6gUNIkcqHEqeD3Uvx?=
 =?us-ascii?Q?8gZo3FBzikvsvIBMJSnacMjL3abf0eKJ35ZtFtHB/pPm1Vf23UEegGeisOuD?=
 =?us-ascii?Q?byozz+ANhOBwIHhfcFUc739TTxO4DBIMGnRUOzr8SAqqdChQ3xZ714nhc357?=
 =?us-ascii?Q?vfqsmaf9tOqqd3zgHlQjSfJHOp68Ng7tqS/G1rDRvGvUcaQBqBN/Png92JqO?=
 =?us-ascii?Q?oaBMawpKy7CrwXP6rcvtPnNCyKw3r35qpixNemV3kTpZs8bfDQyCoYpkZy8T?=
 =?us-ascii?Q?quOzejWGLGw4Veu1eo/svpCMrLmI0pYCc7X86AUXuLQAx9ZYB9aY4jmlbhyY?=
 =?us-ascii?Q?Lwb9IeNAzLeD66LEm40dzzM+7Eirn3sG+D84Knb6Uyag/4H7ML3XWGOYNC4j?=
 =?us-ascii?Q?gusGHVRY9Fhgqk/PHPP7PIIDT7Bv2KidQ7p2nczNAlx6QNJa/vz2EB8z7CNR?=
 =?us-ascii?Q?VB8fEwyKpVFUHoDwblDnuqw5ZaasoqeE+2OCBjWilQNesYfjR+jG3iMXSVx3?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc7ccf8-e2a5-404f-ab8e-08de1b7fa965
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:53:45.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9CVM3b9o6mCb5btMOj0OcvAMouI4QyG0khqNVjCvDuAMdbVpuH5jogsSPsOW6obK65o3zKaI6+2hhSs+FyykQsvSorSBQItYyQCUYUUU0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5164

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Update dw_i3c_master_restore_addrs() to preserve existing bits in each
Device Address Table (DAT) entry when restoring addresses. This prevents
overwriting configuration bits during PM runtime resumes.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 12ee4c4afedf..0a9f10677360 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1688,11 +1688,13 @@ static void dw_i3c_master_restore_addrs(struct dw_i3c_master *master)
 		if (master->free_pos & BIT(pos))
 			continue;
 
+		reg_val = readl(master->regs + DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+
 		if (master->devs[pos].is_i2c_addr)
-			reg_val = DEV_ADDR_TABLE_LEGACY_I2C_DEV |
+			reg_val |= DEV_ADDR_TABLE_LEGACY_I2C_DEV |
 			       DEV_ADDR_TABLE_STATIC_ADDR(master->devs[pos].addr);
 		else
-			reg_val = DEV_ADDR_TABLE_DYNAMIC_ADDR(master->devs[pos].addr);
+			reg_val |= DEV_ADDR_TABLE_DYNAMIC_ADDR(master->devs[pos].addr);
 
 		writel(reg_val, master->regs + DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
 	}
-- 
2.49.GIT



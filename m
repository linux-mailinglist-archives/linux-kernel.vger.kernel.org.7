Return-Path: <linux-kernel+bounces-808315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DBB4FE0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AD5E45C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191333451B4;
	Tue,  9 Sep 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="a2mFiUb6"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012026.outbound.protection.outlook.com [52.101.126.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69C3431FF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425480; cv=fail; b=lPu1dWHwh9lqQ5srliMrO7QoTq4wGCfuSnQNL+z1f3U/+XXlxFBmJ7z1Ftz+Zi2SgOEBpRByN+3kL1ZsVdA4RFXaiuY9Hj/J2+gdlUSbyCV3u73tS5gB7znEeRVjqUjAzMpp++bbCVkBQZvfe8oR2ESI10Vg9DUEzcX3qgEqlcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425480; c=relaxed/simple;
	bh=dMVSi2qP0mUAlJOkSuc80eyzsdqTI2JOI/+bYPnTbxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uP5AzIPKTIJeu3CXMuvXaZFhz7rNuRRCwqvIc0KVl3Szfej6qBjmKdcQ7ILFv51OvLhopIqf+ojNaDLjOfRPiHuPRoTuOIkvH2IkQ9x8lRQj/WEJ4XYhARX56bXRaP11Zxb2FUtrLd+N+DuKvLpmEMzTHDXALGyf1+hsRRiHYLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=a2mFiUb6; arc=fail smtp.client-ip=52.101.126.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8zK2HNWULGgHTSqGay9B+qJ5Mj8V3+9f/Sieclm0IOq+8p2Ui8HjYHJl7+FWIbZXrL2fa40uOT9DqEO6MvnO9+OWTN4ljO8evGoDl5gUL60emOvm0+HIdQN5O+NyBrzeCUQlsFdaW7zrlKWSc7rnc3dzY+NDh46+YROOYwwJVpD2Zr8zOIjXHiYYy2mSxlHPn/URtpOrI2ObVMUZeUgHWc95WOemo0FUpEG+fFo9f66W5Jkgf35zWDDYTC07+iwwmW+HM40WB6WOaoI9xG741JuT6EoGzXdiY20TLVd3Jb64ivw7aFB432AakB0FZxek3gLk+X6SwPQJ4ZKTzWoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfchuBOx0RM+asffhPXYJ+yajgPPePstjU3abSabOjU=;
 b=Ay2HI5m6V2rOnxPA7+AomRTNhqsG+ARcnVaAC8uUMVnpe9tgU3EUcN9Utg4UpEZZXT24Y0RSG4PVZ2uy6PeeiqlSDD9QfmvT7+1rc2hjjRpY390XXW13OvD29dd1qYgt+nhxTj8Hz2OKEjeLVMt2/RbNsQ/d4HVyRI6dvgxdzqTLEmgyh0JmY9XF7gZe+T8rZhzjlJv2OvA1aZI/FC96h+CDT0qRcY/v40E4+YVZ+HyvxlTfas7PZvngN5/czv1x+j+CQ89bP4NDPTcFPSirRM5GjhCJyvN+aWhk04mhZdftcHoAd/9q5HmlZn50fTjbwoROB+/akrwn31CzKgvSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfchuBOx0RM+asffhPXYJ+yajgPPePstjU3abSabOjU=;
 b=a2mFiUb6PYnfWCKt1sGL69zECmL0zy+ozT5JlJUNuHwwffdobOc0Qm3V0U5biwCZXn29BGuVW8lGE08Ndknxk7VRvaq3q2Dh6FqvR8hngrYVR/RR5fGoswZMbRZ2/XBNcKWhFQJrYvm+DFG+TLBjPWZo+XFQSk1v+ay7FiHvhzm62WaEGfEPr0N7QOtDnJZ59AVqp56AvgCgRdvPeMRWYBaJsYIM3MvzOeFxfBTc7llOtw1YXqF2faXV3yOcs4uqTHb119t/2l7xm3l3fZ+UeR7zsg5jLrlpR83W4B7s4CSTU+Qznro8JZH3l8MP+LtxUdq2FQcWkHs/PTbyrSlDyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:44:34 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:44:34 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 2/2] f2fs: Enhance the subsequent logic of valid_thresh_ratio to prevent unnecessary background GC
Date: Tue,  9 Sep 2025 21:44:17 +0800
Message-Id: <20250909134418.502922-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909134418.502922-1-liaoyuanhong@vivo.com>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d792a988-962e-4979-2bb4-08ddefa702ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tenRBlIYIoBlHfAUNiLA+N4NX1mOTm/k3U++r6segUs/tT8q2zTkxl82407?=
 =?us-ascii?Q?JXL0/FsPpN2Wt+/GQ3Y6D9Q1zNYczmSlHnYDeCMMMhGujxY5+/UJGy90ltsi?=
 =?us-ascii?Q?gvPxEHALMY0DK9VXzGTzByoppQ+CPNXV7Q4SChNWmUsZsIqtheWLmx7bbe0V?=
 =?us-ascii?Q?ND5qMXScPvRG+AevCELgbBProd1VUks9BCTts6AM5cmOhM3qIs13Ab6aprnv?=
 =?us-ascii?Q?S9FJ2AD7H33W9SNM6aJHf1bRnif9UbJiB/lrz3XF5P8WBU9p+dy4H/HzYXY2?=
 =?us-ascii?Q?/+tjD0tQ/Y3s2399pGcRL6RaVFep4WHJxBPGzgioAIB3tbOW9MRfJbg5RHuC?=
 =?us-ascii?Q?PErK9URU3R6s9ze2cfuMHVyFMMH2PjVyNcuiaQuHduwCN8Fy/E+1EZercH+L?=
 =?us-ascii?Q?Ja9hd6AkuX2c3qYqaxmk51ZbUEBZdFQOCNtTXJHQ/IzR30/R/xe+gHwrDHwc?=
 =?us-ascii?Q?rs2y3tcxDLjB3lprVPjyj/t0P9Blyw5115SJYSPIQR/su+MJI/TgcZD4o62b?=
 =?us-ascii?Q?/9pVfxFej+4EI+U0wCmPO9E06TBrH3pwI+RwigxO17xpwccmijRBTl/DqNFn?=
 =?us-ascii?Q?X/pCTheqC4ZaCXaLemdB6Kj2xGjJj2wicE2b2523bNsyHNAqUOJ2Wr57k40b?=
 =?us-ascii?Q?2x4e9tzqk++Pm2luHrAM+lFVvxovQgIOSr7u7bgmxuz0vw0YteA+DJ8fVEp7?=
 =?us-ascii?Q?bfWGEzYlPaH2m8AAHU27NBKWIhaX/Bdz93EoASsRUQY+c5L5cqam2moksFEP?=
 =?us-ascii?Q?9l96a+UiMjCeYqEObQVsjmSjjjNYH+EnhUSGIPH7zhKJmN1RbsaXG84IVxxO?=
 =?us-ascii?Q?BHmNhyJGNn1UV0elsfUQjkiNo2VqtXAXeHSa2qB3lVh3XDbMaLlOnzCixjpz?=
 =?us-ascii?Q?owQqgZx73b+tUVmFzZdTVUcwO6sQt+Fzb7nd1BDh7XEIbx/kclSRwrG17ibv?=
 =?us-ascii?Q?ZNd/PnFI1Jo9aLegqieLZGHbycvC/8a/baukezxSP/quuWLcxjQyKZbOXLQr?=
 =?us-ascii?Q?oRiCJvENw3gnAI5fn5R5/LJ4T4nqi0rGGKFwElJgwQB/6TihStwSx69/9aFE?=
 =?us-ascii?Q?n0kV/eT0K1GBoTaVrpcmKf9BGq4iGsVAuubk6v3hwy3MMmHeHMydcoz/0UoE?=
 =?us-ascii?Q?Y8BIzphid4fKFLRgcwjFU/wcP2Ng3jOcyldfloojLlKA7tgx5rQZ3uOSvXeW?=
 =?us-ascii?Q?HaE6EwO+FAU5LLdTcNLmyJG9FA43EtVSMGGjC1gQst52QFpkf1cKV3iK1d8K?=
 =?us-ascii?Q?2F4k5gH/oPljQ6tC9UR+z5iyLfrhGsZckOFXPtRMGeBDstXRx953FtrPkhfx?=
 =?us-ascii?Q?ruzxgi2dt7NJ+lXHNEJOrUFVJBut6lTmxiAyc144eUVFlNhV/lyQ//byN329?=
 =?us-ascii?Q?eBPJqnEuOzOpjfCBKAY4D16QQxk5OiTPWhNyk8tWgbb58wXjEcr2foGfF8op?=
 =?us-ascii?Q?s1B93ZDF/WHknEUs+ylU0gYySzZNFLL0oIx9Y4Kl6fTN75UGreCgoNHHDq1D?=
 =?us-ascii?Q?y+UPaggpShqAj90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0whX5aUzAo85CNwRZTaZfjVj68xXuIZM5sTHy3InMT0ikTzK962aJ6vvVhq/?=
 =?us-ascii?Q?RHU4D1o63ToX/or7X0PO66jT1ktvKtxXep483myM/vt+0ZHQb1/6Q7kogp98?=
 =?us-ascii?Q?+8N88qT+rvtD9OsJZrsn1deRHuQVWtUcTFkTjE6N9hNn/O/LpLItpCQ9ja8M?=
 =?us-ascii?Q?pR/j/sFteMfINKa0ahvWyB7ufh1EykwhnSrsRYXAmm8+fALcO9BAYlM9fvly?=
 =?us-ascii?Q?60PtcQIJreTGKdGf5jIIktRilyroXiNqtIgkomJnBehdbne6maRyjlC/MT0k?=
 =?us-ascii?Q?yYKPzd8dzw/e2Ha5+DC2gbN9HIMShQv9+Pf57hU/TkRZAF35m0ZN8LL99oZM?=
 =?us-ascii?Q?qsFyAvat6NsRdOb+/J9/axo9tj/9tJ6rFgABoWrtxUsKpu3usot1SZ01KFfm?=
 =?us-ascii?Q?nrWrem60ZmXjCpB2O/yU2cE/3yJEmsRq/KCpeiO3Gx0Y1impSWt9rBY2yGFu?=
 =?us-ascii?Q?7fqgfnmN0Bcp+Bh7YQHhyqfVpGfI7+7CEy8KMLl8v8YU0NER7PHnOGX1GK3a?=
 =?us-ascii?Q?wLjzpY8rjz5HqyT5fB4NGEbaalJ4CuvBn7laPU9VaiMKwUU63q2wYsbZyVWk?=
 =?us-ascii?Q?lqZgauVLiTYqGtKTvlG1e4TNRZrRRGXz1rnJbEURnaTZ/CCZD871GhKyhSQa?=
 =?us-ascii?Q?bZ7BX+EGERO1wi1kTgNjV1EzYK1u8Ju2retLpu4xTX0FXh5bEHluljx4GTuA?=
 =?us-ascii?Q?c+JNhQsbT02fM6bmS7LIWh0knjqFlnuHDEtwzSPz0iV2ue/GL+BvZBjlLW0J?=
 =?us-ascii?Q?2rv+hfqCE2wp+n7gIy5R0uUZ6gTnx0caOxoUQflv9KC0tQsH3xdDDK55CKSw?=
 =?us-ascii?Q?m1vrVLHK9yrHSR1DjyXnGv5wdSqzNOaMoexhMpuUwry1bZFfCgk5m+3bjkbV?=
 =?us-ascii?Q?Dydxmw2fgsEW4gH8nIqNvy8lsTk7S1hhrk4nuuZKmbKXT+lGW2wk3PZsuFT0?=
 =?us-ascii?Q?8x4LkhfR5OVEey7QLTZs08dVs+9DDaFOURpFaRkZcQ4dzvPMrkj8sjMbdM0a?=
 =?us-ascii?Q?FshoQSIgzpKdGbQBYU/6IE6dQGG9Tq+DFR9XwBzxIDytr7q892to5h6kgOPd?=
 =?us-ascii?Q?6BaecsB7LD4UbtDrAlfNZKfnEIs5cLAbFfrMd7fe+DpP2Soe0RGZMaSGyYhS?=
 =?us-ascii?Q?pYXHWsbTmpsBfsNTJOochAQH3QgEdQEk+vL/uwBwEKi2LK0KkF3yvOUSKBTa?=
 =?us-ascii?Q?S4c3vfz6BRTJD7s/raTgHIrDls0DvcucSooNCnKaZUHIhw5TM3Wowe+7egw5?=
 =?us-ascii?Q?dueQXfHS4pN41POTzkl0jS2xENio/h0skSPnHc9sQ1unqq5IzJs/UtRzxJ4I?=
 =?us-ascii?Q?tIhhVp1ug4cdeRkDxPxkL3ouWByKIN6TCDzt9t2GZJJsDWEiPYbt1Al7/iKp?=
 =?us-ascii?Q?OlEZgKa5/aW3JzWLaWf+3naBgerjtOwU+KzRHI3/AIvJW7eISY73PAsB+gIZ?=
 =?us-ascii?Q?/c87VMFRDr5q2PVVlH/M6Y/fuKeIXv1atbIoEVGi89fI/wwVY+FGPoksJGI4?=
 =?us-ascii?Q?fMBdknlB8x2pn82JjtHmhv20Y/Ps1hVWULX79xhx/zxJ+eyjJPg8ALo6g+xH?=
 =?us-ascii?Q?DN0dT6gvqSLvy5dqA12MFjtYJZRNpWLBWzpkEinV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d792a988-962e-4979-2bb4-08ddefa702ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:44:34.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE98ocEAUS2PYxaKqx3NnipzOcQSASEVdPqsvwPy9mpcriOC6DrTJ3gmzJPhytjzfhrBgrrv0bEO5vd0hUnYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109

When the proportion of dirty segments within a section exceeds the
valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
indicating that these sections should not be released. However, if all
section costs within the scanning range of get_victim() are UINT_MAX,
background GC will still occur. Add a condition to prevent this situation.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/f2fs/gc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4a8c08f970e3..ffc3188416f4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 		}
 	}
 
+	if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
+		ret = -ENODATA;
+		goto out;
+	}
+
 	/* get victim for GC_AT/AT_SSR */
 	if (is_atgc) {
 		lookup_victim_by_age(sbi, &p);
-- 
2.34.1



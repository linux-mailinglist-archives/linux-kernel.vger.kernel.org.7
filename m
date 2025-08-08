Return-Path: <linux-kernel+bounces-760043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A65B1E5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEDB1662A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766726F45D;
	Fri,  8 Aug 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RuvbZwpu"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012044.outbound.protection.outlook.com [40.107.75.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BF20C010
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646498; cv=fail; b=pz9aD9zLgMHnf7PxIilxJklG13VlRTHCdxKlloce5ZoX9NeU+SdVKhII3StnF/REJXxQLgSO28KtORzhdwvmrxdK2LG4jOevZqPsZPB0RCC2vb6p60Ph8hxlO5DcLPE+CAibOYfoZtDv+lU3cyso3aBAWbGnr62hspezt7C8Cz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646498; c=relaxed/simple;
	bh=v6DA2FC4fwpUAbaV1HNlpw9DRj2HTkUCB9tp6GFXsN0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S7jwj0AV73paoP5l3Wv341R36vgP7tfg6Qa8NQ5+4+T0I3EoQN7AM5FZnRnfm3ogEzuqNgBka3rTPG0ZhfAn4wHZGnMCNC2jwgrLf60e2yxKVwYuTz19lZkhdzwUtsKG5yIxr2h1CiZZyoAZ7sZai1ZP7ek9Gz8ubJqggBUunC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RuvbZwpu; arc=fail smtp.client-ip=40.107.75.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5VylByMppJT+EICHT3mnb+8kKHA0IqrISRRr9MIm5zynEn+fxGwsdpEze3zn3SxgCgO7vPKwiXxM0I7ArliEja7fVujuH05mobfxvJ2H39G1SBhjy25FOx2630qxVovapUE22H4tjKIpklzb2t+aVxTwdQDHpvjJ6RCRRUe8FfUL1HD5bt/pP/TekppfzcqetLM5TOeV7sXCC+mUY5OF5XxVaWgqYs0MDX+KW62w8GJ43CbMZvw0pHC+pCCK02aYrhFIByJvZDWz8RYAtA8yv5ekGLDAOrUTWwATdK3CtDfVe3CbN+kjcDSYBJJ8uOc6CJ+YBri5VvN14314UmZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHBVXpHP/pZIpMJkcgDTCTGJRh3qwXvn2YNPJP2D/z0=;
 b=iHofVPUE5JvwuJtum3nvKe2Ib8XtfT9SzoRxQpj1bVwA4PKJbxYGKuPpM+zVPW2IUv9ha5bLp8FOxkGIU74nPGLHTVEjMVGOzQb28L7ynkwTnMaRDpdqbFJfyhY0Jcr65ch2JBN7lCXXp9n1dUdKQQLUg0Z6E/ISidzsD+gWFKp6EYCWF0A1v21Tdp/hUCjL+fBKJRtWHwAidR4EAiiMmKAf+K9Oam6aF9Z/LqrIBYxj5E2k2Z2pCt+rGPRhWuu3ftB0WitD/XJaMkSiadgD4jrVtYENxPOUJkXaUEuHdpLfHg2ruXxscNTOhZaX1T5l3Ht3lgNExsnlb+xnr002hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHBVXpHP/pZIpMJkcgDTCTGJRh3qwXvn2YNPJP2D/z0=;
 b=RuvbZwpuyA3tmUZthsp7iWQ20tutpSbCTnoQpsLXgQvEvjOeGdi3PBtEuLF/2/NvrQ3pQJn/6JhW8bSRi9EtS+eS1FOIZyr4f5JvC1pQCvBJzApPWw2nu9z5uH6FPDoNzthZYSl+njIJJU9iZEF2PdZIE6uf3JO1Ha9+ZumW7rhitCq6ieYBmHE4gB6W+/KkxK/m09btuAh3AINdJja2/VbUAgzknUoAobHN+tuka3xfpya8PaFB/u6B3XiPFiPFm5J8YunuTXXBONCTY+kHjDnEBBv25lSg7/wvfQ30vhOvgwQYxxH9DjIv1Aw7jTdPaI5dP0otdx7lcKx7gsjgbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com (2603:1096:400:32f::14)
 by TY0PR06MB5846.apcprd06.prod.outlook.com (2603:1096:400:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 09:48:12 +0000
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263]) by TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:48:12 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v5] f2fs: Add bggc_io_aware to adjust the priority of BG_GC when issuing IO
Date: Fri,  8 Aug 2025 17:48:01 +0800
Message-Id: <20250808094801.250480-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To TY0PR06MB5579.apcprd06.prod.outlook.com
 (2603:1096:400:32f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5579:EE_|TY0PR06MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb5cbc6-f503-42f3-f993-08ddd660b024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blnvSAKVhY/tLMwGdMbDE5QfdLaEPFR6ndDkmdaQ9FB7S+Dvpq/2BKdYvZvX?=
 =?us-ascii?Q?mdDF2zedZ3wRTl+MbdpQVNeFzd6Rg3pMbqrGseyH9CsMpdko62aF+o2dFuZs?=
 =?us-ascii?Q?ZIv7cLoQhyqB60QZO/M5VqU41ixkni1rCGSp7vUXAShpDmrZ+3JRlt0IGo2e?=
 =?us-ascii?Q?6MMhSqTYljrAWeVG0bAY497coIs53kGAEzgw0DdenfPQ/gLdro/956TwUoIb?=
 =?us-ascii?Q?rBdQhmj8B8G9Jr6swxMILU7MVZTVWypKCSFezw5yVienB299xu0spCQNF6Lz?=
 =?us-ascii?Q?I0WvGDZZNvi2Ha64tebymA6IiTODER/Of+TLgJq1kBlNiQt3dTlEQDj5FRiH?=
 =?us-ascii?Q?et6c2WvXLThuSrQI5LxGrnZ3AQHUZUUN9IQcaMWwbjy+TcWsqE/I5vWJ/reo?=
 =?us-ascii?Q?OXF8QZN7bXw121OBfxiaGfN++6UXkswpfhYgwExW/Yw2ZR9ipjI8Ssah18V4?=
 =?us-ascii?Q?c5LIXKpQcLeCkTSSnPzHv4cDVV/OPNGfZJPqhuujQLoVTzokMP74j43cde6Y?=
 =?us-ascii?Q?ziOSFkze2P/HwlH/CC2uA+AodbZVSx/7eKKv0h3Rp/BAHH6xCtX9jWqsFNj/?=
 =?us-ascii?Q?Jt8yfo/aU6lr4bkJNl/stV0bOeUglSf7rOiWEcba4ZOTwj8kMPbL+s3u8GID?=
 =?us-ascii?Q?eAYl/J/QgU8KsrdBxsLvxnJu11c11aw1RLGz3+Nao2rMQkWgKjnOS5NqiAtn?=
 =?us-ascii?Q?c4KYBQwZl8gnDNIV5XdDtEwCvBsRALoz8c1tOHFflLYXhCZzkldtxpSHuXrd?=
 =?us-ascii?Q?NHdnjdAgCgXOi8u/wNWdYvaPKC2Nd/bGdX54gCT9WW+F5aP+iGCWo+c34aly?=
 =?us-ascii?Q?ICLD9n9/4l8ff0s/tUvIsVrpQOfUNSgPDgTNRjeUKjNswSkDUcYp0+uInyQm?=
 =?us-ascii?Q?MsXfpVlZQARKR0iqvcZKnprgKemcm50ccrPc/CbD8dCea4WEYLteIqmEM8vo?=
 =?us-ascii?Q?D3cVnm4wKi1nwVssBL78wznMmPb9C1wOjoSPDL+2+bMoWo4SBdznGZBpilov?=
 =?us-ascii?Q?goAFx4zWJvRVnlGCl6OeS9FfDCRd2hvNq4dfA35gSp4mA3Jk9lIg+8JoOZcl?=
 =?us-ascii?Q?K8/Fok2DdaNSP4q6kNEpsOQchMtoSoskkb3nWSKFsO9k7dFz64wmSTP5T7g8?=
 =?us-ascii?Q?R5fKspNcUbGHEHtdVAj3wdW949k0uexESYHpnStvB6D5YJY7FT5Xksj5Pwbo?=
 =?us-ascii?Q?fiRttA47/YM/C8+5qCkRB5TGYbYkGI5hmgzyMcQNNFJNGTOOiyZaWT7T4rSF?=
 =?us-ascii?Q?hiSNhz/4deM93ils/EZjJo+MenOlCq/1e8uuPDmleyhZVNvfQFFbBylC2Qop?=
 =?us-ascii?Q?irsKW9qXyjd6R5EUPA5kiYMa/kAjvw0NdWwV5NSb7xxt10NGLjmePTzi/0zZ?=
 =?us-ascii?Q?stBSWT3S0llRe0YafUnhtzcjjXMMCLupDQUqnFX+JDtLoYbyrhMU/njfcvZv?=
 =?us-ascii?Q?lVgwAeCnsvV1OcKJT5GkPQZfFfrtyNj5EGR6wAySKSGltfb35Ef0ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5579.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3D9bmXmGkX33LIDIM4yGsjqHrwke3dBbNo0Pbctswt06MDVnM41dWcvyuXd?=
 =?us-ascii?Q?ZFsGENHrDmeh33iWSAD9UgxbvPOpicH6z5LzWuw3HpaaybiGYmXmIYf+vZsB?=
 =?us-ascii?Q?K1EpfLjH9L0P+7gmnMEpSGOCuStg7Rr07wk1JXi0opWPqqMj5VdWs1osdIh9?=
 =?us-ascii?Q?QdNzkycOkB3puLUMsp+rh7oDt8owKafd/4uYIutpB/kpz2QLsDkxYtUPMqgg?=
 =?us-ascii?Q?OzX3RGN08yFiviJyPLoMyDQmIb9zyxjzMXIARE7kb+Y0fcaI35fh/bIMnNZ3?=
 =?us-ascii?Q?PGRqfn+bJDgMVyMgK+CrEsa72BOMvprTDNTNFObLgmmu9XiHBsMP6smY+els?=
 =?us-ascii?Q?4Q8wjCOqUyTBMh63TGMyp7ubu/veTkHBWtV1RS578yc4UYvy1PG71QYeHBWZ?=
 =?us-ascii?Q?M+x0LjcNgBZ7+SEulLJzaz3iljTAnY5pwekXYBZ0QSki3eVHmOsgBhIS4H4L?=
 =?us-ascii?Q?hEelzlCXTP7lE5sBOS+SNF8gylUDivYBhwFbCP3R1oBHh1nk/b060ruMPk3d?=
 =?us-ascii?Q?tNGQK6egPbeeLQX7bdDMkFe1/leOpZkpLF9fNhyjBm7VfmPGQZnfblyHpcDu?=
 =?us-ascii?Q?Lg9z00ZbM7GD73pZaKtKcUpjZbg5igGlYgyfDjngUrFW9FayJAqGUON46u++?=
 =?us-ascii?Q?uBGr0bLqh3TVCz/FoQpQDs431bAG/SrOtu8TlqRPsIPx81E5YLWkAVZx8mD/?=
 =?us-ascii?Q?8vEibZtROQFBP3Vm/zRJ3JuEWYGPlEhHgKgbePEB5CpOLdWrbcO94JydFZ8g?=
 =?us-ascii?Q?kg9C6d7P9iPDSgwr1ISSz05/X578z8npyqu77PmeKrqzKBl6YzHCxAlMlO9U?=
 =?us-ascii?Q?a4ByKLQSC7AHwcNY4c2KhARKYejr8G16+6bD+iVp1Iek2y8Oz+WUaVaYgiiC?=
 =?us-ascii?Q?Hpp5UFwD24JDNriZt6ffZp/ET2EWnlk1Wb+YxDPvggf1RaWT+BYVKF+kstQu?=
 =?us-ascii?Q?ONHAN2ffLtKJaWB9XK8nH5x/YJNHs2mYjc6Mq6yNFUWosnXmHNZOUloGKZRB?=
 =?us-ascii?Q?08tUzwFDeOgy+mN8LQfbRyKMmBAl3xbf10UN1MF5bSTKQ1NgvqwJqC1mtNs1?=
 =?us-ascii?Q?c/lPDooOxrzyD54SOECq0J/k/JuAVaGX5bjwfKxk27a31r0j5kdjowQ/EPaw?=
 =?us-ascii?Q?J8GwVWVFI+ywz8x7SqCIw75ixKS/CYA3WmcaM+n1yzAOgP++Fq8VfSR5Z5fI?=
 =?us-ascii?Q?Cs5k/15O06r/bqhkYuWrfpDkp2T18HIM375BrRGp56XiExqdDNOzhzAYoyyZ?=
 =?us-ascii?Q?wW8lbmpMOO/cB5veCfU01KAE631UEjbgyo9wYDcNKHVFHusSYO/dfNjwUVVv?=
 =?us-ascii?Q?2bq7mBFMpcl4IeZt5YVP1QKikqcAptGBcZs4uwqsRY57qnQojEKrD/mpChEj?=
 =?us-ascii?Q?hCancG95VqTltAHSl+NPk4EJ1n6W9rJUX6QNi7FeM19vElEQ9/ktkmLU1twh?=
 =?us-ascii?Q?kxEncUCcbVo0zxvhCiDOOSaIyfRgFuS/TuBiyYNX3Dr7HJLn9Wn79g4HG9KY?=
 =?us-ascii?Q?g8FVkyE5SSlKJWOwrjM1FKpfG8DnemmfolxwDqj3Z0ioMg1tP9FNlg3uIBFo?=
 =?us-ascii?Q?xV2TPqpCgpEq1KCHtPgf/C9+m8su0iK/6X9GSJ5f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb5cbc6-f503-42f3-f993-08ddd660b024
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5579.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:48:11.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nEEuxovMHKxVOR6DxFnuGyDkQmeLNTtVPpsedgxiy7SHOzrv8aiWgWwxfq1yV+afHHun/kDJ+nZHbejE13d1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5846

Currently, we have encountered some issues while testing ZUFS. In
situations near the storage limit (e.g., 50GB remaining), and after
simulating fragmentation by repeatedly writing and deleting data, we found
that application installation and startup tests conducted after idling for
a few minutes take significantly longer several times that of traditional
UFS. Tracing the operations revealed that the majority of I/Os were issued
by background GC, which blocks normal I/O operations.

Under normal circumstances, ZUFS indeed requires more background GC and
employs a more aggressive GC strategy. However, I aim to find a way to
minimize the impact on regular I/O operations under these near-limit
conditions. To address this, I have introduced a bggc_io_aware feature,
which controls the prioritization of background GC in the presence of I/Os.
This switch can be adjusted at the framework level to implement different
strategies. If set to AWARE_ALL_IO, all background GC operations will be
skipped during active I/O issuance. The default option remains consistent
with the current strategy, ensuring no change in behavior.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
Changes in v5:
	Modify feature naming to match actual functionality.

Changes in v4:
	Adjust the default policy ALL_IO_PRIOR to 0 and modify the description to
	match this change.

Changes in v3:
	Modified the issue where it does not work after closing
	CONFIG_BLK_DEV_ZONED.

Changes in v2:
	Non ZUFS can also be adjusted through this option.
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
 fs/f2fs/f2fs.h                          | 18 +++++++++++-------
 fs/f2fs/super.c                         |  2 ++
 fs/f2fs/sysfs.c                         |  9 +++++++++
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bc0e7fefc39d..71309e75bf85 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -883,3 +883,16 @@ Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
 		Default: 1
+
+What:		/sys/fs/f2fs/<disk>/bggc_io_aware
+Date:		August 2025
+Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
+Description:	Used to adjust the BG_GC priority when pending IO, with a default value
+		of 0. Specifically, for ZUFS, the default value is 1.
+
+		==================  ======================================================
+		value				description
+		bggc_io_aware = 0   skip background GC if there is any kind of pending IO
+		bggc_io_aware = 1   skip background GC if there is pending read IO
+		bggc_io_aware = 2   don't aware IO for background GC
+		==================  ======================================================
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548c..075f12f92fd3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
 	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
 };
 
+enum bggc_io_aware_policy {
+	AWARE_ALL_IO,		/* skip background GC if there is any kind of pending IO */
+	AWARE_READ_IO,		/* skip background GC if there is pending read IO */
+	AWARE_NONE,			/* don't aware IO for background GC */
+};
+
 /*
  * An implementation of an rwsem that is explicitly unfair to readers. This
  * prevents priority inversion when a low-priority reader acquires the read lock
@@ -1804,6 +1810,7 @@ struct f2fs_sb_info {
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
 	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
+	unsigned int bggc_io_aware;		/* For adjust the BG_GC priority when pending IO */
 
 	/* For write statistics */
 	u64 sectors_written_start;
@@ -2998,13 +3005,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 
-	if (zoned_gc) {
-		if (is_inflight_read_io(sbi))
-			return false;
-	} else {
-		if (is_inflight_io(sbi, type))
-			return false;
-	}
+	if (sbi->bggc_io_aware == AWARE_READ_IO && is_inflight_read_io(sbi))
+		return false;
+	if (sbi->bggc_io_aware == AWARE_ALL_IO && is_inflight_io(sbi, type))
+		return false;
 
 	if (sbi->gc_mode == GC_URGENT_MID)
 		return true;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e16c4e2830c2..5dc293a1a918 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4629,9 +4629,11 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+	sbi->bggc_io_aware = AWARE_ALL_IO;
 #ifdef CONFIG_BLK_DEV_ZONED
 	sbi->max_open_zones = UINT_MAX;
 	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
+	sbi->bggc_io_aware = AWARE_READ_IO;
 #endif
 
 	for (i = 0; i < max_devices; i++) {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f736052dea50..99ba06ae23b2 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -866,6 +866,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "bggc_io_aware")) {
+		if (t < AWARE_ALL_IO || t > AWARE_NONE)
+			return -EINVAL;
+		sbi->bggc_io_aware = t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
 F2FS_SBI_GENERAL_RW_ATTR(carve_out);
 F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
+F2FS_SBI_GENERAL_RW_ATTR(bggc_io_aware);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
@@ -1303,6 +1311,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(discard_idle_interval),
 	ATTR_LIST(gc_idle_interval),
 	ATTR_LIST(umount_discard_timeout),
+	ATTR_LIST(bggc_io_aware),
 #ifdef CONFIG_F2FS_IOSTAT
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(iostat_period_ms),
-- 
2.34.1



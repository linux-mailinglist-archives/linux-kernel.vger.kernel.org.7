Return-Path: <linux-kernel+bounces-851569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03633BD6C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA713E3A48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B872D8DB7;
	Mon, 13 Oct 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XFUM4nO+"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022092.outbound.protection.outlook.com [40.107.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F3EADC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399499; cv=fail; b=SLRDDipffbt4/TNlkXAW29UgEIgM8JGL4aQdzba72H+u4yAV2kgQUlrfPHgiNPMU8JJAuICcwb9gssmuXi3kr0ZWhNQcoARICjieH+dejrYdZCYpg525XrKbkFeAtdaVoiCBH2C+jcO2+rsPba0JIpcU015h9pjHOEy5qW4rzCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399499; c=relaxed/simple;
	bh=EjHlwLEzV94Df1Te+nyNX8mXeuLTf4yTEfCb0Kn0pLU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Et6zCG0BAniZNJIrRyFRIvn+t4PK0b37QfB7eB6wTZvdloswA5I5rWa2AGiHU8QFF7N5eg7akcBE2fS41eIttxO5E0zI3FS1FvXQgCT2b0TL0UjF3ZIX8kAY103mLSBT8KMIP6bqqcTgj0qrXKzDUakbueE/4j05FbZOrSgQHMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XFUM4nO+; arc=fail smtp.client-ip=40.107.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SitAQEje/bdIPo5tkuX5waAqorGNkYLErit9yWffIHMneGKqxEvCfI7e+m6yE4OlA3p35/U66iZVeebWExq8FMXrDHAaCxGfEucuerwvAg/35kYftoPAFGUy0nVOatKiYIEgzFGoP6jbZzeKOotT5gPK+128t0wyODSgpdQPa6RvuA3lmsz4jmBa2XD3uqIOyTWyVwqYbUo2mLydvbzgxWaqUziso2OWGTh/jgnOJ4+nNudcDzziTAPcFw2YSlKkvg2G0+XPMZf3i/90invLUhv2M6VJMH5dSbe7aJDcsz1qDpISdfCK0cpHzyXIoz3yKXCJP9HAKJBHMHqdZFQgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdpIq+IGabnUwGPq28msqSF1RV1OBzoBEoX/IK4nPqc=;
 b=kzWZAjvzXHuulrXbh465TggE0TA7xDwoEEuiGN5etN9wa4YpFx0/xEfBTv5vTIRBGTro5UrOJvNcdOcXcnhreNaSIoLcfWY4hP4p8IZtYiX7u9hfH5cBU+NDW6NZdNvhpRE/WtWERWZ+8b2rRqxsxh7Et8/3Zl+QvMhJHEaWa7YL4wDTiR3cR66GLgM04wrAeStFerzofCuLccST1hm1NrR9/Bo0rc3WxNjaG2e8ZH/4N4K2u2R6cNZNOGRf8kdSmyvH7HhRUnyV8LTNDOgnAWq6BbX6s9YlFxq2zG4O0j8DN0ljP9dr2lODYXfKK3yOCIvBR0dyPqSW7nllIa/mIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdpIq+IGabnUwGPq28msqSF1RV1OBzoBEoX/IK4nPqc=;
 b=XFUM4nO+xFBYIVg0++t0IcI7Y6tktT5mCHz6qItINIOGTEl+DuIcndTdh7NQOBrzqILmj43SHWuF1P/arJ3R5PGZ8j1Hocj1hrGeVxtN9iI5U7RoOv72RmZD4pXy0Rmck7moHA+LPAKD/BnoIo/qwYXMA9fb8TzCFy1zj9gE12o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6166.prod.exchangelabs.com (2603:10b6:510:b::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 23:51:32 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:51:32 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Date: Mon, 13 Oct 2025 16:51:18 -0700
Message-ID: <20251013235118.3072941-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:930:2::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d43c2649-33d8-4519-bc6c-08de0ab36f8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTCP0+3RakbowPQmJhrHVQ1RyrgTeYfES7/bAypmql/kkdvz4KLydKlUT3uJ?=
 =?us-ascii?Q?Q9LIpAqDqE4+8l2H5dWfy0ZFkPrmQ1LM6iU6oXeacaskZzxeIS4JW962XNtt?=
 =?us-ascii?Q?yuwBMhf/xcGs8DOeyRLzatXFcheVybrAfBkTYkunY7xZLN96triE8NGeDkhN?=
 =?us-ascii?Q?0TMtkyQg7CbskngHLNrlzhB6qJgPIQn/sPcmP+rv0KxXaAocU+Wq8RG4gom0?=
 =?us-ascii?Q?JKH1MUnZhcTqV0ecJlrKd0Gm3E8IWC5CcJdtzOlMxUbhv7n0tA03ZNV0ODVI?=
 =?us-ascii?Q?6WzC3HpQfN27nF+APwu3doRBI+w+ha398cKyLBzqihRzlpjnk0l+5nL6sgH3?=
 =?us-ascii?Q?LSMmdtrfpnvZNvRSPriicad7HHs6bBcgs+wC1/6hEk9aKCDMEDbS9jfIgJsd?=
 =?us-ascii?Q?lnR12TmI8jfALzkxTAxgrlo1TtMfZlyNzVdnbgQWrqDZUIirqwdgIwd47DNi?=
 =?us-ascii?Q?KZ+i50a3ZwG4FG+dU+wOkX1/zzFoir45RtcZ1hoiHQGARnntc7c3oB3y2LN7?=
 =?us-ascii?Q?dGqtEG725QstwRCuYZpQnylPhBF2WtXhCS2/F2HPBHF2bghMMxNrwHarreuN?=
 =?us-ascii?Q?7StpSX7UMeFIzF1fS6n4hD7uWWpu0Xu56dHsNSh7U9Jv4OF5L/NJkJtzfCft?=
 =?us-ascii?Q?p0CaBa0iUeFE4EE9ucw6QWoXKquqcIvtcnXo9yr9XYppsnz3o4C/IH3ivjep?=
 =?us-ascii?Q?2dDWGuQj4HnEXCupyZIbknjt/YQJbPhU2SzzlhbVtyZqqAcW6/qmFW20zQoy?=
 =?us-ascii?Q?iZV8tiGFV6TR3BQg5SrHvNHcJH0KbQc2G3xEiyiy2MRn6v/6vyYi/Wz0DEVu?=
 =?us-ascii?Q?ZoImnrCkIoaZMdrg+tlLdowDqpoHBwiR+kZ4lETrR5DVSWuDdDOFBft8slA7?=
 =?us-ascii?Q?yl2dB8LaxIJ0cbNiq6NvdVqaciExWIK4PSmIOhGt6xKnsjAMRPPECkTdAQy8?=
 =?us-ascii?Q?Ra/1dTLd8DUYkB/+oLhGAQOQq3On2m6hv/PyiqazdwMaS/pkbBXWSLK+oA8d?=
 =?us-ascii?Q?mIiwla0wrLXn8IgertUEzsrjdWKczxd5EjZKuvftscVPk6uUASYnTuN2EY11?=
 =?us-ascii?Q?VUX0QnPzn4iarSZZJLqI8Zf5/PxNhlR7AwbOZzrzFoNIyItQfpnSGPU2pV1f?=
 =?us-ascii?Q?7Rlvf4EO9pJvpPBpV6sqIvHNeox/4a08QYtQE0mYqKKusxsvm6MgmVtHG/rv?=
 =?us-ascii?Q?S0JN5T+HFv9h8a9uNejNYIZ6o3iir0O9n1KHuGliD1HzdPVfdaCW9Dr1WxN7?=
 =?us-ascii?Q?heEZK7PwgmiEDzIAJx9o0wDPEvYzn8d2J/W3FYgJx/OlKkbCkCggnzbZ0Jyx?=
 =?us-ascii?Q?sMAS1Q1iAWLAvSrHA0ZLW08ey8UziISm19gFpcRRruaEb8mP9HDExa+RQVNc?=
 =?us-ascii?Q?QLkuWmwx1birXUmh+ssBOu8d9tMdZLVHjrirjL0F1p2YO6c5ifhGzZsRgRea?=
 =?us-ascii?Q?56LyON6Jl3DnwarqxRKCAk5XevFNKf8y2+qlZQZtKaORwku+UKL4Lwlt1id/?=
 =?us-ascii?Q?E6koyIdcVlCRVsR9VZnm6F3vfGpxIQKe50iv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rkh1xXKD/j0WgoUo9U6OSE8197NU4uHH1F4YmummLG9zSt3fZc9OT+XtZheV?=
 =?us-ascii?Q?qxFgk+njwFZAdhJjCyGRLdkN/2s8lta7CnEL7vc2rNWVS5dZGc0Ezrtcxjju?=
 =?us-ascii?Q?jy0HdETzL+8h1ZWYfy8WOAMjWauyVrqEyS1I+qytZU/5Nb1rxUcQ+WD/FIE7?=
 =?us-ascii?Q?sCHuIkpsjwxgf2c9kR3mia6kX/21BX01LvpEevcGDxMbYbGv+LswtF25z45n?=
 =?us-ascii?Q?SOX7gocxEogs/Gx3N6tHkhV2zlKOj7aV31WQh7/CTgHUH8JZMStW6KKg2VU9?=
 =?us-ascii?Q?1i5fKq8kzwCjSp9wx9wTZN5vUiFKpMlL2OM7U6QVgCMyE6dJrBJfNyK29EG1?=
 =?us-ascii?Q?808ItbAevlgz+tlcGWQ1nv1bmkrXbPGoTR0QIsc72KY9JJzDXzcWNhsMz1rZ?=
 =?us-ascii?Q?PXmW74XCXWHOOLmHLAU77KVfpvzFl9eM3Xptp4QuRQGl392Y+gYL6nZtxGAm?=
 =?us-ascii?Q?fxzU3WbK0MGuF/mwGjq0ygV1jumyMdoAIlWgsMY7d2LZ1KazK3vj6EF/fiPi?=
 =?us-ascii?Q?emhgX6cTJSqzYCmvWjU+WaIEpwaLETqUYZ0BYvbSYWqcrSMhUpPV5IRn3m6l?=
 =?us-ascii?Q?0s6LpefygXgSz0sH3YqZL3yS0ogPJYFAMEzXlWLhfMfUJgEewahsPMoi245A?=
 =?us-ascii?Q?3c13vTb8OhB9Yge/V7bg0wtvI1a4lIgAOW+B/WwiTK6F0qSFC2HTt6Sl2uA/?=
 =?us-ascii?Q?ryjXUcqezKU76pjTZFoVP1PhP80ywlDKkjDfST7ohYbxX2vHK5u0JAS2RWGv?=
 =?us-ascii?Q?p4vifZi0o8K1KImvN5sFkB5TkLwIYVZc+o4Uc4wGLtCDngyNjphB1ZFXJMdn?=
 =?us-ascii?Q?FKzNkmFEGizjtdalIggV7DUukrEOCYslxWpuiz65zXoSB4SYd77vl9W5Y+5Y?=
 =?us-ascii?Q?5XiyC8sQJr1EfxM7jAinWSKBtkkyW7toCx2KHHCIewjec0eWQ+rXYy3xLXLA?=
 =?us-ascii?Q?yO2a1G+q5X+gdtnpsgpS2pOxUhVnxnjKK7g4huRRWElTxxCa10T1h6OJt4r4?=
 =?us-ascii?Q?8ddhubGV05Fdo3x7Fkp+YCemMipI7RcQjuP1fhGZpkNmn+STNV61Cb5s9SqU?=
 =?us-ascii?Q?eUH/UU9pUqNk4FqRSZ3TzU9Us/rULRJihgvwcgzK6+DQMRj3F46rFYlToBdY?=
 =?us-ascii?Q?N9RZwYtssmbdk0K61OO+SzHxpDUFikoWSJQ2XJxMbPz4nKC2vqyapTYIWHGH?=
 =?us-ascii?Q?EjYZQE2mDubGObxlU8nymBrm6aHVZgW9H06aXTeh+SmlEeRUkJfyFteS+NTW?=
 =?us-ascii?Q?tNDEfLKBt85zzvG56hZixITIjDFiplqhkWI0z5N8KFeoNynS9s1ntWq326KJ?=
 =?us-ascii?Q?JmaDiQ/k3G6/LeaIlVOfUuBkfBA6uJZfc0d67IXZ+4Ny9L2eiU1aiPLQ2pkd?=
 =?us-ascii?Q?Xgh8YOCn2lwBJBMt33FdS2Ri/x6qD7JaaY04Qg/SK4K9vjXktdWSczRTZjOa?=
 =?us-ascii?Q?PeMJBVBjDedoEbr+1FC8EHstaxPu1JbE+n41Hr5N6FUtbLx4raZuTxIXfnkI?=
 =?us-ascii?Q?395D8Ufr28bU3TrvSl4Z7kv0rveyayoPk86xM12Ri29QKN1+Rs17OvTHr4TN?=
 =?us-ascii?Q?3Iro5m+jppOr614OXa/LYEMSFyvHtom8lXlmhSwOwsaLGLmdcKbW8mb8vAPx?=
 =?us-ascii?Q?lLOo1SfuAJK3JodyH0bG96Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43c2649-33d8-4519-bc6c-08de0ab36f8c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:51:32.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a7Sio4PylK/XUR65UDzpcsdhr81woOvyjAydHjDqQXvi07uVO2+7wCzeDJa66GDKXXLgIymzl5rjtePuuKKI6rgDRFX7jBwyS1cLXOwedM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6166

Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
rodata=full"), the direct mapping may be split on some machines instead
keeping static since boot. It makes more sense to show the direct mapping
use in /proc/meminfo than before.
This patch will make /proc/meminfo show the direct mapping use like the
below (4K base page size):
DirectMap4K:	   94792 kB
DirectMap64K:	  134208 kB
DirectMap2M:	 1173504 kB
DirectMap32M:	 5636096 kB
DirectMap1G:	529530880 kB

Although just the machines which support BBML2_NOABORT can split the
direct mapping, show it on all machines regardless of BBML2_NOABORT so
that the users have consistent view in order to avoid confusion.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/mmu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b8d37eb037fc..e5da0f521e58 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -29,6 +29,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pagewalk.h>
 #include <linux/stop_machine.h>
+#include <linux/proc_fs.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -51,6 +52,17 @@
 
 DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
 
+enum direct_map_type {
+	PTE,
+	CONT_PTE,
+	PMD,
+	CONT_PMD,
+	PUD,
+	NR_DIRECT_MAP_TYPE,
+};
+
+unsigned long direct_map_cnt[NR_DIRECT_MAP_TYPE];
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
@@ -171,6 +183,60 @@ static void init_clear_pgtable(void *table)
 	dsb(ishst);
 }
 
+void arch_report_meminfo(struct seq_file *m)
+{
+	char *size[NR_DIRECT_MAP_TYPE];
+	unsigned int shift[NR_DIRECT_MAP_TYPE];
+
+#if defined(CONFIG_ARM64_4K_PAGES)
+	size[PTE] = "4K";
+	size[CONT_PTE] = "64K";
+	size[PMD] = "2M";
+	size[CONT_PMD] = "32M";
+	size[PUD] = "1G";
+
+	shift[PTE] = 2;
+	shift[CONT_PTE] = 6;
+	shift[PMD] = 11;
+	shift[CONT_PMD] = 15;
+	shift[PUD] = 20;
+#elif defined(CONFIG_ARM64_16K_PAGES)
+	size[PTE] = "16K";
+	size[CONT_PTE] = "2M";
+	size[PMD] = "32M";
+	size[CONT_PMD] = "1G";
+
+	shift[PTE] = 4;
+	shift[CONT_PTE] = 11;
+	shift[PMD] = 15;
+	shift[CONT_PMD] = 20;
+#elif defined(CONFIG_ARM64_64K_PAGES)
+	size[PTE] = "64K";
+	size[CONT_PTE] = "2M";
+	size[PMD] = "512M";
+	size[CONT_PMD] = "16G";
+
+	shift[PTE] = 6;
+	shift[CONT_PTE] = 11;
+	shift[PMD] = 19;
+	shift[CONT_PMD] = 24;
+#endif
+
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PTE], direct_map_cnt[PTE] << shift[PTE]);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[CONT_PTE],
+			direct_map_cnt[CONT_PTE] << shift[CONT_PTE]);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PMD], direct_map_cnt[PMD] << shift[PMD]);
+	seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[CONT_PMD],
+			direct_map_cnt[CONT_PMD] << shift[CONT_PMD]);
+	if (pud_sect_supported())
+		seq_printf(m, "DirectMap%s:	%8lu kB\n",
+			size[PUD], direct_map_cnt[PUD] << shift[PUD]);
+}
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
@@ -183,6 +249,9 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		 */
 		__set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
+		if (!(pgprot_val(prot) & PTE_CONT))
+			direct_map_cnt[PTE]++;
+
 		/*
 		 * After the PTE entry has been populated once, we
 		 * only allow updates to the permission attributes.
@@ -229,8 +298,10 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0) {
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			direct_map_cnt[CONT_PTE]++;
+		}
 
 		init_pte(ptep, addr, next, phys, __prot);
 
@@ -262,6 +333,9 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
 			pmd_set_huge(pmdp, phys, prot);
 
+			if (!(pgprot_val(prot) & PTE_CONT))
+				direct_map_cnt[PMD]++;
+
 			/*
 			 * After the PMD entry has been populated once, we
 			 * only allow updates to the permission attributes.
@@ -317,8 +391,10 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0) {
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			direct_map_cnt[CONT_PMD]++;
+		}
 
 		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
 
@@ -368,6 +444,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
 			pud_set_huge(pudp, phys, prot);
 
+			direct_map_cnt[PUD]++;
 			/*
 			 * After the PUD entry has been populated once, we
 			 * only allow updates to the permission attributes.
@@ -532,9 +609,13 @@ static void split_contpte(pte_t *ptep)
 {
 	int i;
 
+	direct_map_cnt[CONT_PTE]--;
+
 	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 	for (i = 0; i < CONT_PTES; i++, ptep++)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
+
+	direct_map_cnt[PTE] += CONT_PTES;
 }
 
 static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
@@ -559,8 +640,10 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
+	direct_map_cnt[PMD]--;
 	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
 		__set_pte(ptep, pfn_pte(pfn, prot));
+	direct_map_cnt[CONT_PTE] += PTRS_PER_PTE / CONT_PTES;
 
 	/*
 	 * Ensure the pte entries are visible to the table walker by the time
@@ -576,9 +659,13 @@ static void split_contpmd(pmd_t *pmdp)
 {
 	int i;
 
+	direct_map_cnt[CONT_PMD]--;
+
 	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
 	for (i = 0; i < CONT_PMDS; i++, pmdp++)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
+
+	direct_map_cnt[PMD] += CONT_PMDS;
 }
 
 static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
@@ -604,8 +691,10 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
+	direct_map_cnt[PUD]--;
 	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
 		set_pmd(pmdp, pfn_pmd(pfn, prot));
+	direct_map_cnt[CONT_PMD] += PTRS_PER_PMD/CONT_PMDS;
 
 	/*
 	 * Ensure the pmd entries are visible to the table walker by the time
-- 
2.47.0



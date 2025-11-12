Return-Path: <linux-kernel+bounces-896515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E8C508EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D57B344549
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C622D6E5E;
	Wed, 12 Nov 2025 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nraC3aqv"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D127F01E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762922822; cv=fail; b=hvq9a3kwT0WGabbwWEIumWpAfS5M93cvMvT331CL++ZchoaVgiB2lQUnqvHPIcfvnXPU4h1uUEu3cA8iURlyJtEtUmTwpkXvVc+gMRDvvmxPDHpxbjCurFAwENGsxcxZwV2t34y5c2ROSaXffQHzH18BMh4J0/EdQgUke0YBYt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762922822; c=relaxed/simple;
	bh=iJ8+0V9hHc++72Z1qEak5Bz2ffgiVoNMwmo3g5Aqnvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnmJoBnswb2zKvmUSg2zEpf3Oa1Z20DmCh6y8M6akH1Do0mQG7xkLSLJRQ11I4AyHhuE+QlUFU7Heud5C8OfgJBM5m3oPodrzKDDHhReNwJ+9fECUGPRTFFR3yNiNcNoLBdBUiPr4k8JUPEffGXyFWIeGJ+RrguTJMUePjP7Eig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nraC3aqv; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2GD3PJIf4TpUWh46PcfQWPu0pD06DoyH4Q6DKF8sZOv0upY/2KYvxDBVxwNteY+orZICan0XERC6T9yQU/6d1QBp55WmtLZn9PyVcHd9iLe08H87EpWt44D8nVEeuNb6lkEcgaxB8CLkUUuCGNtgrt0PdTfJ8+46zoy2aXv0dXWCjb3ga4uSFsQFYt6IEmjjXbLmsHu1lB7I+IXGgdjOF05DxjmAj6clURRuWOwTO1K1xSiZo+29t/YaoraQL//zBQNEtgf9q1qGSCGradmTDL79UC/dL002QogQcLdh65/wACkeMrD5X6Tvke+LXHbZ3BQFdjHuCo6TEp35DCiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/kMngb5+B04Sq7AqVV075rWHA+VVKWe4vWLs9GWA10=;
 b=REO/e6N7lcZuVNUzzUQVRcJ2jE1adCqjYICLEfl34Lpnak+6qsfb6IGdpRN2H94KiHJ4X0dAMcyuIvmFAgQqiDJgtN5vejIVeWVs149r1iUCNn3xrQcLwJgNQZ+WaPerLj5y+qvPIKS76hAeH5X8okLkmuuq8TcdsB6fh1SjBer2XkoJrxPt6I6PtmYKZpVJML9EChiZ219/PSJA90tyWrKELHoJXLRJ8NSCCZ88AoSrJIuEFA0ahhEIFOp2q7+FcSGYTd66O9ANpprXRymLIyeecVvxv4G1rpLNPJTZMtdWuGjx73iYE9Kxx4UD3k2hVl09QW1oIFO8Hucd9lrWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/kMngb5+B04Sq7AqVV075rWHA+VVKWe4vWLs9GWA10=;
 b=nraC3aqvtJ4s5gsK15NF7HVHiESoyHtqWJMvnglgeThnlpllxTo9mxwFihy3aQAb43zFnqVTY96JMEEEll/ZUeC5iSBVf9zYZIFgJ7aHKwLClyPwu3SVVLpyoz9GzdSJHEodsLRHDADaQ4/7JVsslRME0H7Gb/LIViW0UFVkdgsnKbD0xaMCPvqngH+bNXRuo18ry804xSp6Oyzl/0e0e/ST5i/sh7IBelndcfxef2wxICSQ1klh6Z7I+PlksguAUl6xJqdcNdxlrqToCcGmIHdDFxsYSzNZUf3ILmNoczfgab7thoyEXTSJiy15FUIcRfXAJKX24XAEp+4gFtiyBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 04:46:55 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 04:46:54 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH] mm/huge_memory: softleaf device private fixes in remove_migration_pmd()
Date: Wed, 12 Nov 2025 15:46:34 +1100
Message-ID: <20251112044634.963360-2-balbirs@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112044634.963360-1-balbirs@nvidia.com>
References: <20251112044634.963360-1-balbirs@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:10:246::7) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e531c46-f55b-4fbc-050d-08de21a680cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?svHMGPrkwdfw7IkKr5jaIx5z7Vhf98soayq3Bmd21FCEypsnqfZyL4tSuV2e?=
 =?us-ascii?Q?7bed59T1Ujewa1P/vr0Biw88mfsru969jTTg5cow39wYva6J7IWDivQXRZ8Q?=
 =?us-ascii?Q?ogwq0aepXkmHwes890hW19rGaqlPmfB9AFiwB/d1qnvLKiA/2bUCY5WgMdyH?=
 =?us-ascii?Q?R6c0GWauBSOgNb0ZQBHEFtVM7iV2bLMQpgoJZnQxYspZqgQp6M3m9r+xqMZA?=
 =?us-ascii?Q?gN9A8f4vRfqfNylQnIhco5juX9TKM3E4zZuJ/nXMNQPcYRzFNTIhTm7p8BKT?=
 =?us-ascii?Q?mIZ0uDO7/F7D8rhTfqAnBh4klDz6uU/9apt7r09ktRYQpL9XBgMQxQuYtrir?=
 =?us-ascii?Q?BtxuqzLoSupXElZiqJcgD1x/ef+PmyIwuicDuJrPLA/1jv1F34yfETy6CwlY?=
 =?us-ascii?Q?tkKAdvhVFKnxBzliGAQs7qqqp698/yqiQyoN5uvlxZgP/8sn9V9H1AnVLzS1?=
 =?us-ascii?Q?eI4wYMwWRNVHtBSU1n/ZbGfaYRlch8hKsl9eghxmnNkxSCPZl8YVxzv1XALO?=
 =?us-ascii?Q?escwp8uZcYmtmQWJhqSYAXZbDF8Z1r4dJ8TEXR0MSzqkaN0Qrg5sB9Gsr4fd?=
 =?us-ascii?Q?BZu4Rke5uSDQ8o2I06SJkY6zhiZH0LZihhKHTgf85DEVCbIxSxMIKvVLUnvV?=
 =?us-ascii?Q?mwXwvHOtaRdqAiEBHObOhjdlxaar5+8CiiJQ29xI+X8apr8wsf4qBuvejIIv?=
 =?us-ascii?Q?FuijKzEd9vlABVXsvXTEe7Z6PYQD6ldJeoKh/ElNSpTmlk/GiTKElPCrjPfI?=
 =?us-ascii?Q?TRbhVKEMp3tOFcJgv3di4KJo7ioGb5I8JCqmVsDYEd9k2e/w8FrzYVtuyY1i?=
 =?us-ascii?Q?d5Diag41Tf6tfNC/3sKLazfUQzP9m4UgZ/VvKF89NwQplHadXH4CJwcFwKhG?=
 =?us-ascii?Q?WCaJhAFI7YHxUNmyT24Jv5iQoBbZTPBbPc1PB07O8dsP4NnxLtQDkEX/EyRe?=
 =?us-ascii?Q?MKvsfRQfbk354D9DvPQsQF/YynlTGXlPL6HRhqSDQyZ6c3KYAmS7xJ7izZUD?=
 =?us-ascii?Q?Fm3w8E6PJCg2EWhHd0RMWTqQHNatQUu9dI+ILLM0Pnzglr8WGtAJ2mJ1dKxS?=
 =?us-ascii?Q?t3oldCdqLusnsK1ZfwFVrwZm9zFLWZXGdoATvzNRzvici5MC/b7ANGrUJpm2?=
 =?us-ascii?Q?9wNKDIC++HdYYMT+xh6rM/+B0efiWv66DiGxqHjS+/aN6mV3ZUBOjWyrls9u?=
 =?us-ascii?Q?Bj652rvETTu4RVQqaj9d2PYV1S8lCdyS1MVk9YCxwE/Pik6+WfC2Wpbx3PZJ?=
 =?us-ascii?Q?V4kNYOgSIkKnIZp8s80XtAgFoh9UbM6c+dIXo4UoLAxVLKrh+Qm7P5b8R27y?=
 =?us-ascii?Q?O2gvfeX0PjPfKFdLO2hXCUraholxuSAWUBlehYIsDzWCeHAjI0Bl+Vk1eyQ3?=
 =?us-ascii?Q?i7hBUJ3X258RgMwNhf8GZ8QUbacTxQoPhuUJnkqVMBlpHGCe0k446iK1Z534?=
 =?us-ascii?Q?8KcrBgPaHFcGnJkEaEsy8gP5n1K6p8Yb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6uiRKQUGskPLyUOgn/UY07OpHcsccGJpBEjZJIv5bW6jjLub0y2Pj60S+Md?=
 =?us-ascii?Q?09qNSlPo9oWfZ45uezk4w77LUN4dGh+dEAuErsrx5jaeT1jjpxtYi6E/ZSmC?=
 =?us-ascii?Q?tX0+umG3x6drCnFm6MPjgFv3ka1dt5Sb/OhRcMvvL2TohYyPYo+s7hiqM+0W?=
 =?us-ascii?Q?Pna0vM45roe07S+9paXMbwtP0jcNtRdD24CR+3hM735qpz3x7EHGzoiDlnU9?=
 =?us-ascii?Q?wNMndPfP5OQWWKH1ylB3HUWJxKOYgN00dgMpBEqQdbIuIvLA0kSUoxCUznb4?=
 =?us-ascii?Q?c9PhUMq7IAVwIBolkXNZYxQBofCcO6VEdsrYLAXtENhwf2Q0GAP6bTpZTo5r?=
 =?us-ascii?Q?f1mgZNT/jMGS6ZsU9DzwOWwuLGVz82kDPeDChG2Tl1ki5Ivo+JehN0tsQ68x?=
 =?us-ascii?Q?41O0ZehL6iw+cAc0QXe47YZlI9VcK7FcYvkHZVxY3sKOa9jJpEYPDVVFrcda?=
 =?us-ascii?Q?2XK85pb5zkcX6ONNwinOOUcnpcQsQZzJqNXZBYbUUslGZUwN3LLO/Wh/PTID?=
 =?us-ascii?Q?BqbQSEDPRRAuiNwaymjh2eyyO22X/ypmBy72yo8W+5CtyAUKQGoNUF6kgPXi?=
 =?us-ascii?Q?HcTLcUbUnrDOQZAo81lqAVi7AOF0jEs0jR/A+W/8GkjQkJwpNek6YaR9xpz/?=
 =?us-ascii?Q?vDGyula/LXRRSv3+Mrd9gpWp/Q3nwJK8X3CTKNA9Wumxe/uyfwP/fkMw3wZ/?=
 =?us-ascii?Q?ab+hsUTLlMHfTZg1bd8OGXLSHSz5mxRZP0ro0WWz6Qxy18dJcr+UsQ2XEST3?=
 =?us-ascii?Q?eoDu/GloeiecVNuD6g3rBvg1GytOS/cvzCwb8+hrA/njrLmEVXpWYPNuiKsq?=
 =?us-ascii?Q?SnFtEW6ijyOOg1LrS9CaSvK+9i9T0oLgxH4Gx1nE5JOn6DjsU/1qBVlpyHxI?=
 =?us-ascii?Q?qw/IAJa+/vvltCRMDTG0WPgBm/dscBn0EVDMvszFwitLtjSZJpoUaKZhMWck?=
 =?us-ascii?Q?VeSfOxLtPzV2UtHzx4vAYU/kRNfFvpDVi5GNv2U3Gs5uD797lFcJjJkrfx1l?=
 =?us-ascii?Q?fMRLVbGoOQkx3L3LTWz4f92HV1WfgUQzmVKRAFJZSx1XOuWhak0Nn3b9hcPc?=
 =?us-ascii?Q?STzzwCiDNHDpcEj8xmq0tE0qMDILr+wnOhgaekNTocobIAtCPVrs2uN4Zl8F?=
 =?us-ascii?Q?RpSLwta4tfZcA5Nza0PDXVLSRSoEXiVWCWRd3BrXs20uQ8DPq8SQdKUe4d4O?=
 =?us-ascii?Q?1O+0E9ndGfgxOy9X2xD8/gmP7IdotvygyyBnYafDSmGUwXbBi2TSHgGhn1VA?=
 =?us-ascii?Q?nJh+tplvmphaqb9erZFn9mdap5ebrchvV7t3FgxpuBX/uVQg5kVOYSLbN7E0?=
 =?us-ascii?Q?hSLhHxjxf4efQ3rq+qAbLD0iklfRvYBm0CelwWulWePfbD5hhDipX9CYJH7o?=
 =?us-ascii?Q?0g2OEEF9wosL6W54kn1MgnYElpKF9bczu83ytv/bfFwX+AkJRd6aQ/VaH93U?=
 =?us-ascii?Q?RYpCZR3oICABI2vOkC9QAKPKN42NEiBl1EZjJpqCKU2MGQdH8CoVWIe4CRLG?=
 =?us-ascii?Q?olxkS5ZSCiHbTQLR5nQ2t1OHlPXR6hIAYr4lQhD8cNErTHCTLQFHBIciX4uW?=
 =?us-ascii?Q?qLXikSxmUuzVhu4En0wTxKnAnJO8welPX6tt4CWlTKLbHIqB+KAj5ARhfU0N?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e531c46-f55b-4fbc-050d-08de21a680cd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 04:46:54.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ye7QFyxHfYKxkWas7mKmvORW5FA3jdmdrlo/GO/yH0R/mA/doOzOGhQjYQKqk+9SxlK0lQpy6QCaZMsjlL6z0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

commit a6ca2ba46390 ("mm: replace pmd_to_swp_entry() with softleaf_from_pmd()")
does not work with device private THP entries. softleaf_is_migration_young()
asserts that the entry be a migration entry, but in the current code, the
entry might already be replaced by a device private entry by the time the
check is made. The issue exists with commit
7385dbdbf841 ("mm/rmap: extend rmap and migration support device-private entries")

Fix this by processing the migration entries prior to conversion to
device private if the folio is device private.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 mm/huge_memory.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 942bd8410c54..82b019205216 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4939,6 +4939,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	unsigned long haddr = address & HPAGE_PMD_MASK;
 	pmd_t pmde;
 	softleaf_t entry;
+	bool old = false, dirty = false, migration_read_entry = false;
 
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
@@ -4947,6 +4948,19 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	folio_get(folio);
 	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 
+	if (!softleaf_is_migration_young(entry))
+		old = true;
+
+	/* NOTE: this may contain setting soft-dirty on some archs */
+	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
+		dirty = true;
+
+	if (softleaf_is_migration_write(entry))
+		pmde = pmd_mkwrite(pmde, vma);
+
+	if (!softleaf_is_migration_read(entry))
+		migration_read_entry = true;
+
 	if (folio_is_device_private(folio)) {
 		if (pmd_write(pmde))
 			entry = make_writable_device_private_entry(
@@ -4959,20 +4973,17 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (softleaf_is_migration_write(entry))
-		pmde = pmd_mkwrite(pmde, vma);
+	if (old)
+		pmde = pmd_mkold(pmde);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
-	if (!softleaf_is_migration_young(entry))
-		pmde = pmd_mkold(pmde);
-	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
+	if (dirty)
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_NONE;
 
-		if (!softleaf_is_migration_read(entry))
+		if (migration_read_entry)
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
-- 
2.51.1



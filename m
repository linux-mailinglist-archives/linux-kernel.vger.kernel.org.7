Return-Path: <linux-kernel+bounces-730560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09BB0464D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D48617FAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE0264FA9;
	Mon, 14 Jul 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dqUxeLOE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367652641CA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513519; cv=fail; b=Q6nZCTyjvtsgaNN8M+atFY4FQUE+/R53LXW4qVhS+6fO/Y9VVGkdRIsy32Dvbi4HLEkeeZ0UpyQNI9Lh3zB2OgbjDHjO1dFXUzZlMD9skHybRtF9dW07wu5/V21ca5A4CKMdEVlC/qQpvEB1AWusKDU6QE8aPtPkupkBAHO1IF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513519; c=relaxed/simple;
	bh=MUaD5RMLkfPXL6sWeqGb6JJjkfLsE6BLlHGWBrv0g3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhqVze6yFHp+Jnx3XstxyH/M29uh3fkqp4H+yPEUCftDxIcK3Vz9/h6TzUHU+l9wYrbY99EZh2/K0mQZXFUOayvX6HjvFWAT4WatAIVjvkVkyNrj6b/jbx01Xbc8blBcb+F4z0m6c4PK9JUR7RUwXZWy0/7SV2m4hf+j3JXwD8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dqUxeLOE; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxNIlO2VYAY0LdNTVSN0jSl8PL6w2K7BRL+7wxTnr6G0DViBysNpzhBjYCWr+8bT4NQCw4pTzNXTRFqeffcM9u7KgkSY35RXIc+oimZF8bE6fNael1lRuieZoEnS0GTNUF6zKL0lx0HATKRNtqapSv/OZ0sNWoqPKFbJicVasE6mZ2f4Q1j+7Ureo7PMPK4Lw6enkpf+iV2oPnvKXbSPqij97Q6fW6A55qglNtjj1cwMDy47IK1u3b/g+GJvqZRb4e57T09i3lN8n7OdjITYEjIrSAbqX7CVGQODDpxm53qCKH3QQu21cSLFWQ4XZ8vk4ChICXNBMrwbTj4sHBSKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDtHRasiIlb+11jzJX5Z+XhE/dbZEcljfBEkTlXN8AQ=;
 b=Ib6O/AYCkAl2O59aoxF4muz3Un19JEkx3shE7HXG+2ta/hFYd0mCn4B4pHP/43y1bSLPV6DEc/5Tl06qr38D/TfN3b+Qg4Ys5ucyQflMFoYA33CMfIhQg/FsrzfpQBjutHv7WWG4zgtdTQLPtNeIwcewhjQuv1tiOubcRl/A9nIkh1ih1bZ00/Zwh5xpSnMkwk/SU8up9F/df99Zh23IaqB4WT4SMEirG1ttq2WgslC03E0z8cOVNMwwDLR9JK03csD6GI21NeuGz3f2x2kpn8Ld49HLUVtTcFG+VVilELHCFcGr1vkI6HLxxx8y3lkLEWm4XTnUj6yZ2TBMPaSvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDtHRasiIlb+11jzJX5Z+XhE/dbZEcljfBEkTlXN8AQ=;
 b=dqUxeLOEUiV0Ds+vx7zPLjKRQkKRCbMy5PYya3PNPdvAEd0Cptdukk8W5CyP6N8b+RTC3mGXSUhWz7wQ5dbpRGyjwmcC5rnDKIka1HTT8gEriV/tlxvd2BLM8NN35u3hBHmGz7Xn8rGuBvCIKvQI0rv/YL+YtMyB7Z8eUJ5R023KnbSUk5W2b7Yb1wd48OTTRO70Y2cBOaBJ/A4GmxNtlO+iaRFc4kR0sQ9Y6wmbY32I9Lts6VI4CD4VvLfvJCRySx926U5v7zPWBnCoFpMhty/iOmUYRDx3cMI5zHMtR4YAMQv8RGumqc82ggV9pjZGa0z78zULIQDi24+ubhPuOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 14 Jul
 2025 17:18:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 17:18:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of __split_unmapped_folio()
Date: Mon, 14 Jul 2025 13:18:22 -0400
Message-ID: <20250714171823.3626213-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714171823.3626213-1-ziy@nvidia.com>
References: <20250714171823.3626213-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 0952882f-118a-4d93-001c-08ddc2fa748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZeCAi6ZlU0EthNVibhx+9c36B9T74GuwDMl7+ss6euKNfJqqu+liAeOjKj+t?=
 =?us-ascii?Q?7s2BZUhzxlxRrhph7y1ZWRC4qFcpdxrda0q5gas5AGZAK8Q/P9cq15F4Hb3Z?=
 =?us-ascii?Q?XJnJKthrLlhqwt+GeWqmuOVpIkEnmspZhOVRUz5TBJc+LuXsUDK/zb/844fl?=
 =?us-ascii?Q?EVzvA/7ibnMBftsAZ/Q1rSTEdtVVA4nJUDwllja3+GJKbWHaNJHXyDwsPMny?=
 =?us-ascii?Q?miRgPqa6yCk5gAht5D2lhGz1PRttUi8tpmqJ3dbCEP6nlts4CdoKhrQUeWKQ?=
 =?us-ascii?Q?ZBOnjnmm/8KBiG23SQP2MOLeZ3DsyKY4FP8JAhQSJsPSaDHZ1l0OFeG2xcvY?=
 =?us-ascii?Q?r3lU1cK4m5VGyiZkEgqJN8Jy/Ogklq03FKCBTnxBy5l+IRFDlgtFJQ/tdv8L?=
 =?us-ascii?Q?yigdX30qZ3qo+odhIiMUt319Kzd1uX9zs5BDO0RDTEtOa4q19MFk2Jdb91Ql?=
 =?us-ascii?Q?a9SfM/g3bOqbQyP2wHliRw7RnXKXjcYrdyJoZBqE59K7rm6i6lHpdWNjlRAs?=
 =?us-ascii?Q?7w216tHaeG/XLuZl4NdlLfLf2TCQcDzD5TBhBnXPH5c1hf/+TFN9K77Lf6Ql?=
 =?us-ascii?Q?SHAYzyG+mubnUrDd774K4cVe6rrpuBqVsHMEu99VdCiqCxDGeOZEoRM/3V+w?=
 =?us-ascii?Q?zCs1TEZYHTkn/6oK44rs2+817L1mNH0pvDan7y6kontNizzc7vk2VptpvaKy?=
 =?us-ascii?Q?pNfZB0pV1pRgAxKxPV9Wir8ZZ1I4OmAbFuCxM0lbMv/09vjJcRC+pIfmPRul?=
 =?us-ascii?Q?+R7n8J5al/4aSXqR4hNJUc5vHSwEbXdQEoBFt4/EUa0acpEmuzK8d0AB1Zh3?=
 =?us-ascii?Q?BXVi2W92+hZnB3o+aWt1k6s0wCXwsdnpn4G4338CgrI6RI0yzGO4Ibr4n1BR?=
 =?us-ascii?Q?epDZcLox+tBp0n5zsqFC7hfCKshfbSIsl9YSSLkZwpvy7VdyXK+fcMGd3HoM?=
 =?us-ascii?Q?4SKHcsivy6BfsjUW/d1f0JQX3UXaIPFbTFz+ar1LKNcPs7oRU1LA6JL+t44T?=
 =?us-ascii?Q?voY62VKLiGKjOtPQxo3Jz4eo50tOmH1ZNP664A3cSa9vT+7s+rW0QMG9NAB6?=
 =?us-ascii?Q?/Nx0zb7RMJ79ZIYkravU/xdB/dg59F/iwC0fm4xSRdxA4yb3lOXId7p6Xmoe?=
 =?us-ascii?Q?oaYbsAOleQhyukyI5OCbovGov3g6OCx0XuSrV9WdXHeBanRoFzbFTA0nFm78?=
 =?us-ascii?Q?1i7YMT3tDz6QR8zWRGsbEJnqB9zANJks1orbqlFN1uRxU12w7zcaDl0EO/Qp?=
 =?us-ascii?Q?QXe940N/BNyxiZ358IbUHX4RoD5L2qnra02H72MpR522WbSEvLXrKW5rtO/m?=
 =?us-ascii?Q?InlVMfPu38IAxhgBaIdGnIWJGuKhZsg5Cd0S4oPpRytfptimWfoMlesHoqP9?=
 =?us-ascii?Q?p+kYhwfVG7hzYiQrJUtWSEvwBzLuspi1/qYDgNuYktI4CmovlMPCRuMFaOFb?=
 =?us-ascii?Q?0cU9poo9ZSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtyR/E/u3yMc+BymPL5Bz5EIt73K3ceAWCPtUpbIqQKz9btgSx9qOwOg1NGZ?=
 =?us-ascii?Q?A1+WfO+OEzX66NG7S54fiQTCTbe3WwlIbGxtdtfVdJXeM/PGifhjvj4AUNXf?=
 =?us-ascii?Q?kciL+rYbpAF3F9kWsquLmm48bQRUCRYf0zKKsnfMFIujUH+L6A5bRW71juB1?=
 =?us-ascii?Q?WFM379/7i1qgTLKjEP9TCbr8VKItiDrRQKxMCPljYTai0wgNcfDIeWtzEidQ?=
 =?us-ascii?Q?K+lqMRPs0IO5GB2Yw7zn0lgmMVhZjfHLK+IA6OCxSXVzNyBH6+Ya0vgKTmbB?=
 =?us-ascii?Q?elreL/f9ByTNID/5pRinSb7UTK02E0zuovaOhkjThTwrmavBMpt5njDOjiW0?=
 =?us-ascii?Q?5XlYKSt0x8p7sKkmvUwWmWh/W4UY4brsixNep5UHqvFDJjspiPOdkmAXkfZ0?=
 =?us-ascii?Q?Yd1eBBql7TXJFnLQcRqFuBahBs0pmVOAzANTGMSe/I/pou7yPn7FvFzq0RnG?=
 =?us-ascii?Q?LfPmho3c4cvybhT9SP0byx7+/Xw58/0Ci+5Ht/CqiQBr5IQtkt9G8Z6r7V1o?=
 =?us-ascii?Q?P2Xlc3PUtPJiuqtjJkB+Irle67ZsuSF9D2TWh/OKk3KpBn7vlmHxVtWwXjg9?=
 =?us-ascii?Q?f0qAA3SAEJiAz/h4+nRAsEA+kZ9zFsSQDnXOqjk1XEcBMkxMmlglkerhpezA?=
 =?us-ascii?Q?OHHtr2s3NtsfX4j/wkb79BYSOpGZbYzejdmVVc7746oPv5baNVbnzLwuyClj?=
 =?us-ascii?Q?1JnJ3m0tceBnKLAwE/2fHP9EfG625/C+CJE78CGg9d8feBA+k/K/W+6znVaa?=
 =?us-ascii?Q?GgToro0iDunWRTumv38JJLFzE25M4IRiHasc4lF2BYCNJxagdTzCkfSdcZlV?=
 =?us-ascii?Q?jz8LR9V4/9Hij3Lv6u/kNEM4L3MxnbK3NZcLL9N3qG7AgutQ4R1oLuIbIAOC?=
 =?us-ascii?Q?SFJ+fXB4kvFfZberEFh4QMvx4j59Fy6OxIdTB0xLXEqVumXNn65JVzG+j5LO?=
 =?us-ascii?Q?T8foUU/9D2+RCPUJ5rqh7pyjAUvdjRNIxW7KvjYTfYkbCnHN5ERb8eEyxAKc?=
 =?us-ascii?Q?Mzwv8BHc9jhtT/cFhKEALYIBk2YD1XROkMUlr4LFkE1zIATObp4MTBMmqwkx?=
 =?us-ascii?Q?kK9KgZzALbLbyKkCEgzSc854/E5DEwbjyirJmyFcarXJu+8Fv4hRohtj4hmn?=
 =?us-ascii?Q?VNfBz3fJdlqPjTKSop82eAtt8PFH9YodvbU/QOX1t4uZbg0UkT6vUX1NZUb6?=
 =?us-ascii?Q?JKBaR95WWtFDQ18uYhTzbsIHmYaqiSzMIXEPX4tJSLbkMu/pF1NryX+2TRYP?=
 =?us-ascii?Q?YfNQ2LPkc4X6WbIB2UkfVnDL35t/hemfjjLMe9iHjpNIvB5F5OMhR3zqXHUp?=
 =?us-ascii?Q?PxcO6OBvzT5iPDb4pnDn10V2XYSLOZSuoobEB8dZ4wObEvoMvKDLYHJQOnKV?=
 =?us-ascii?Q?6rWP1yKpaGlqpHeiIgnQC1DLhGK0DDn5y4NvUAOHUHfdP/3xeupBNSW5sKtG?=
 =?us-ascii?Q?hHxIF++DYpIanuzUGKOVUDFC7YmjRwRImaEpqqzbIit0VevLLh5KJfo8g3QG?=
 =?us-ascii?Q?KgiTqtsda0QBslF/m4brml2m0bf9a8F0iEvoQNn5APzIB2+VPIj97S9fexGQ?=
 =?us-ascii?Q?ijr21pd46pqZ2B8kV5KUb6CFA07lKKCy5827pAax?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0952882f-118a-4d93-001c-08ddc2fa748f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:18:31.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txo+6Jcg8+VyH5mxIuuhfLMAkkMj2oKdhecc4pJQJ/O+GCH42y/fGyUHWlWKbVjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
splitting unmapped folio operations. Move them out to the caller so that
__split_unmapped_folio() only handles unmapped folio splits. This makes
__split_unmapped_folio() reusable.

Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
---
 mm/huge_memory.c | 291 +++++++++++++++++++++++------------------------
 1 file changed, 144 insertions(+), 147 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3eb1c34be601..a7ee731f974f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  *             order - 1 to new_order).
  * @split_at: in buddy allocator like split, the folio containing @split_at
  *            will be split until its order becomes @new_order.
- * @lock_at: the folio containing @lock_at is left locked for caller.
- * @list: the after split folios will be added to @list if it is not NULL,
- *        otherwise to LRU lists.
- * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
  * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
  * @mapping: @folio->mapping
  * @uniform_split: if the split is uniform or not (buddy allocator like split)
@@ -3425,52 +3421,26 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  *    @page, which is split in next for loop.
  *
  * After splitting, the caller's folio reference will be transferred to the
- * folio containing @page. The other folios may be freed if they are not mapped.
- *
- * In terms of locking, after splitting,
- * 1. uniform split leaves @page (or the folio contains it) locked;
- * 2. buddy allocator like (non-uniform) split leaves @folio locked.
- *
+ * folio containing @page. The caller needs to unlock and/or free after-split
+ * folios if necessary.
  *
  * For !uniform_split, when -ENOMEM is returned, the original folio might be
  * split. The caller needs to check the input folio.
  */
 static int __split_unmapped_folio(struct folio *folio, int new_order,
-		struct page *split_at, struct page *lock_at,
-		struct list_head *list, pgoff_t end,
-		struct xa_state *xas, struct address_space *mapping,
-		bool uniform_split)
+		struct page *split_at, struct xa_state *xas,
+		struct address_space *mapping, bool uniform_split)
 {
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	struct folio *origin_folio = folio;
-	struct folio *next_folio = folio_next(folio);
-	struct folio *new_folio;
 	struct folio *next;
 	int order = folio_order(folio);
 	int split_order;
 	int start_order = uniform_split ? new_order : order - 1;
-	int nr_dropped = 0;
 	int ret = 0;
 	bool stop_split = false;
 
-	if (folio_test_swapcache(folio)) {
-		VM_BUG_ON(mapping);
-
-		/* a swapcache folio can only be uniformly split to order-0 */
-		if (!uniform_split || new_order != 0)
-			return -EINVAL;
-
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
 	if (folio_test_anon(folio))
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
 	folio_clear_has_hwpoisoned(folio);
 
 	/*
@@ -3480,9 +3450,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	for (split_order = start_order;
 	     split_order >= new_order && !stop_split;
 	     split_order--) {
-		int old_order = folio_order(folio);
-		struct folio *release;
 		struct folio *end_folio = folio_next(folio);
+		int old_order = folio_order(folio);
+		struct folio *new_folio;
 
 		/* order-1 anonymous folio is not supported */
 		if (folio_test_anon(folio) && split_order == 1)
@@ -3504,126 +3474,44 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 				if (xas_error(xas)) {
 					ret = xas_error(xas);
 					stop_split = true;
-					goto after_split;
 				}
 			}
 		}
 
-		folio_split_memcg_refs(folio, old_order, split_order);
-		split_page_owner(&folio->page, old_order, split_order);
-		pgalloc_tag_split(folio, old_order, split_order);
-
-		__split_folio_to_order(folio, old_order, split_order);
+		if (!stop_split) {
+			folio_split_memcg_refs(folio, old_order, split_order);
+			split_page_owner(&folio->page, old_order, split_order);
+			pgalloc_tag_split(folio, old_order, split_order);
 
-after_split:
+			__split_folio_to_order(folio, old_order, split_order);
+		}
 		/*
-		 * Iterate through after-split folios and perform related
-		 * operations. But in buddy allocator like split, the folio
+		 * Iterate through after-split folios and update folio stats.
+		 * But in buddy allocator like split, the folio
 		 * containing the specified page is skipped until its order
 		 * is new_order, since the folio will be worked on in next
 		 * iteration.
 		 */
-		for (release = folio; release != end_folio; release = next) {
-			next = folio_next(release);
+		for (new_folio = folio; new_folio != end_folio; new_folio = next) {
+			next = folio_next(new_folio);
 			/*
-			 * for buddy allocator like split, the folio containing
-			 * page will be split next and should not be released,
-			 * until the folio's order is new_order or stop_split
-			 * is set to true by the above xas_split() failure.
+			 * for buddy allocator like split, new_folio containing
+			 * page could be split again, thus do not change stats
+			 * yet. Wait until new_folio's order is new_order or
+			 * stop_split is set to true by the above xas_split()
+			 * failure.
 			 */
-			if (release == page_folio(split_at)) {
-				folio = release;
+			if (new_folio == page_folio(split_at)) {
+				folio = new_folio;
 				if (split_order != new_order && !stop_split)
 					continue;
 			}
-			if (folio_test_anon(release)) {
-				mod_mthp_stat(folio_order(release),
-						MTHP_STAT_NR_ANON, 1);
-			}
-
-			/*
-			 * origin_folio should be kept frozon until page cache
-			 * entries are updated with all the other after-split
-			 * folios to prevent others seeing stale page cache
-			 * entries.
-			 */
-			if (release == origin_folio)
-				continue;
-
-			folio_ref_unfreeze(release, 1 +
-					((mapping || swap_cache) ?
-						folio_nr_pages(release) : 0));
-
-			lru_add_split_folio(origin_folio, release, lruvec,
-					list);
-
-			/* Some pages can be beyond EOF: drop them from cache */
-			if (release->index >= end) {
-				if (shmem_mapping(mapping))
-					nr_dropped += folio_nr_pages(release);
-				else if (folio_test_clear_dirty(release))
-					folio_account_cleaned(release,
-						inode_to_wb(mapping->host));
-				__filemap_remove_folio(release, NULL);
-				folio_put_refs(release, folio_nr_pages(release));
-			} else if (mapping) {
-				__xa_store(&mapping->i_pages,
-						release->index, release, 0);
-			} else if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-						swap_cache_index(release->swap),
-						release, 0);
-			}
+			if (folio_test_anon(new_folio))
+				mod_mthp_stat(folio_order(new_folio),
+					      MTHP_STAT_NR_ANON, 1);
 		}
 	}
 
-	/*
-	 * Unfreeze origin_folio only after all page cache entries, which used
-	 * to point to it, have been updated with new folios. Otherwise,
-	 * a parallel folio_try_get() can grab origin_folio and its caller can
-	 * see stale page cache entries.
-	 */
-	folio_ref_unfreeze(origin_folio, 1 +
-		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
-
-	unlock_page_lruvec(lruvec);
-
-	if (swap_cache)
-		xa_unlock(&swap_cache->i_pages);
-	if (mapping)
-		xa_unlock(&mapping->i_pages);
-
-	/* Caller disabled irqs, so they are still disabled here */
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(mapping->host, nr_dropped);
-
-	remap_page(origin_folio, 1 << order,
-			folio_test_anon(origin_folio) ?
-				RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * At this point, folio should contain the specified page.
-	 * For uniform split, it is left for caller to unlock.
-	 * For buddy allocator like split, the first after-split folio is left
-	 * for caller to unlock.
-	 */
-	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
-		next = folio_next(new_folio);
-		if (new_folio == page_folio(lock_at))
-			continue;
-
-		folio_unlock(new_folio);
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_folio_and_swap_cache(new_folio);
-	}
 	return ret;
 }
 
@@ -3706,10 +3594,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct folio *next_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
+	struct folio *new_folio, *next;
+	int nr_shmem_dropped = 0;
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3833,13 +3724,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 */
 		xas_lock(&xas);
 		xas_reset(&xas);
-		if (xas_load(&xas) != folio)
+		if (xas_load(&xas) != folio) {
+			ret = -EAGAIN;
 			goto fail;
+		}
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+		struct address_space *swap_cache = NULL;
+		struct lruvec *lruvec;
+
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
@@ -3873,18 +3769,119 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		ret = __split_unmapped_folio(folio, new_order,
-				split_at, lock_at, list, end, &xas, mapping,
-				uniform_split);
+		if (folio_test_swapcache(folio)) {
+			if (mapping) {
+				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
+				ret = -EINVAL;
+				goto fail;
+			}
+
+			/*
+			 * a swapcache folio can only be uniformly split to
+			 * order-0
+			 */
+			if (!uniform_split || new_order != 0) {
+				ret = -EINVAL;
+				goto fail;
+			}
+
+			swap_cache = swap_address_space(folio->swap);
+			xa_lock(&swap_cache->i_pages);
+		}
+
+		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+		lruvec = folio_lruvec_lock(folio);
+
+		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
+					     mapping, uniform_split);
+
+		/*
+		 * Unfreeze after-split folios and put them back to the right
+		 * list. @folio should be kept frozon until page cache entries
+		 * are updated with all the other after-split folios to prevent
+		 * others seeing stale page cache entries.
+		 */
+		for (new_folio = folio_next(folio); new_folio != next_folio;
+		     new_folio = next) {
+			next = folio_next(new_folio);
+
+			folio_ref_unfreeze(
+				new_folio,
+				1 + ((mapping || swap_cache) ?
+					     folio_nr_pages(new_folio) :
+					     0));
+
+			lru_add_split_folio(folio, new_folio, lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from cache */
+			if (new_folio->index >= end) {
+				if (shmem_mapping(mapping))
+					nr_shmem_dropped += folio_nr_pages(new_folio);
+				else if (folio_test_clear_dirty(new_folio))
+					folio_account_cleaned(
+						new_folio,
+						inode_to_wb(mapping->host));
+				__filemap_remove_folio(new_folio, NULL);
+				folio_put_refs(new_folio,
+					       folio_nr_pages(new_folio));
+			} else if (mapping) {
+				__xa_store(&mapping->i_pages, new_folio->index,
+					   new_folio, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+					   swap_cache_index(new_folio->swap),
+					   new_folio, 0);
+			}
+		}
+		/*
+		 * Unfreeze @folio only after all page cache entries, which
+		 * used to point to it, have been updated with new folios.
+		 * Otherwise, a parallel folio_try_get() can grab origin_folio
+		 * and its caller can see stale page cache entries.
+		 */
+		folio_ref_unfreeze(folio, 1 +
+			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+
+		unlock_page_lruvec(lruvec);
+
+		if (swap_cache)
+			xa_unlock(&swap_cache->i_pages);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-fail:
-		if (mapping)
-			xas_unlock(&xas);
-		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio), 0);
 		ret = -EAGAIN;
 	}
+fail:
+	if (mapping)
+		xas_unlock(&xas);
+
+	local_irq_enable();
+
+	if (nr_shmem_dropped)
+		shmem_uncharge(mapping->host, nr_shmem_dropped);
+
+	remap_page(folio, 1 << order,
+		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
+						    0);
+
+	/*
+	 * Unlock all after-split folios except the one containing @lock_at
+	 * page. If @folio is not split, it will be kept locked.
+	 */
+	for (new_folio = folio; new_folio != next_folio; new_folio = next) {
+		next = folio_next(new_folio);
+		if (new_folio == page_folio(lock_at))
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_folio_and_swap_cache(new_folio);
+	}
 
 out_unlock:
 	if (anon_vma) {
-- 
2.47.2



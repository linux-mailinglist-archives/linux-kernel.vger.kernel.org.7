Return-Path: <linux-kernel+bounces-745282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5446B117D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C801CE2896
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A81DD0D4;
	Fri, 25 Jul 2025 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gff68kFJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E229A2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420575; cv=none; b=CEADMXp9Vtd+QfoCny8LM3i430OF+NHWhjAvdagbA4OOzaa01ICWPv7TL/xOoCej9UFp00Amh8cFdLT0MGCoiJc5EbqoK4hl457v2+lRaF0PcGQLLDQkiFsaIMrYmf9nEu6SaFD2cxrjLr0pX7jR0lspqXyfkyU2pihfJnqOlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420575; c=relaxed/simple;
	bh=u9Po8QJ0SoeHzsv7ehzf9BPDQrZxUb5H+lUg8jT0cwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRiu9QrMxDgXBfy5ildhOOPCwAQMpa5d44yWWNzQYZCMrG/pi7zG5elNLVhHFo1f5300lWTttKEY9IAi3fCdW+jh8wzEHY7ifx5eIavvmUHnNS/ss7pc3kyPJ3RR1xH59Iz0eSffRhk4/MQjGVHHFamr2sDxDqYPoafSAxsPZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Gff68kFJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 772e3086691611f0b33aeb1e7f16c2b6-20250725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=46G8DD90VVrhpEQm7Mku51SwaoXM/jFS2E0FifwksX4=;
	b=Gff68kFJapmJYc1HJaAaIb2H6p55MIXAlkoUokMjyuvf2WMs1ies4gkkUfrr86bbec0LBCpNpdlSqzBvJbE+kLxlRm0Uo0vUITNoXU/rbePsr9jPGCS9XN74GSYgxPp7nTc6w1YazN7s6sSy99n4ZWZtkyMMWnpvfbGvcnYmWiM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:d2e55737-b199-420a-b213-72b9c61e06f1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:e94a3c50-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 772e3086691611f0b33aeb1e7f16c2b6-20250725
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <akash.tyagi@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1036085591; Fri, 25 Jul 2025 13:16:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 25 Jul 2025 13:16:04 +0800
Received: from mtisdccf01.mediatek.inc (10.18.1.155) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 25 Jul 2025 13:16:02 +0800
From: akash.tyagi <akash.tyagi@mediatek.com>
To: <david@redhat.com>
CC: <akash.tyagi@mediatek.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <ziy@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
	<chinwen.chang@mediatek.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
Date: Fri, 25 Jul 2025 10:38:10 +0530
Message-ID: <20250725050810.1164957-1-akash.tyagi@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
References: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi David,

Thank you for your feedback.

We encountered this issue in the Android Common Kernel (version 6.12), which uses PCP lists for CMA pages.

page_owner trace-
Page allocated via order 9, mask 0x52dc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 1, tgid 1 (swapper/0), ts 1065952310 ns
PFN 0x23d200 type Unmovable Block 4585 type CMA Flags 0x4000000000000040(head|zone=1|kasantag=0x0)
 post_alloc_hook+0x228/0x230
 prep_new_page+0x28/0x148
 get_page_from_freelist+0x19d0/0x1a38
 __alloc_pages_noprof+0x1b0/0x440
 ___kmalloc_large_node+0xb4/0x1ec
 __kmalloc_large_node_noprof+0x2c/0xec
 __kmalloc_node_noprof+0x39c/0x548
 __kvmalloc_node_noprof+0xd8/0x18c
 nf_ct_alloc_hashtable+0x64/0x108
 nf_nat_init+0x3c/0xf8
 do_one_initcall+0x150/0x3c0
 do_initcall_level+0xa4/0x15c
 do_initcalls+0x70/0xc0
 do_basic_setup+0x1c/0x28
 kernel_init_freeable+0xcc/0x130
 kernel_init+0x20/0x1ac
 
This UNMOVABLE page was allocated from CMA, but it could not be migrated - so CMA alloc failed
At first, we fixed this by adding CMA THP pages to the movable THP PCP list.  
This fixed the issue of CMA pages being put in the wrong list, but now any movable allocation can use these CMA pages.

Later, we saw that a movable allocation used a CMA page and was pinned by __filemap_get_folio(). This page was pinned for too long, and eventually, CMA allocation failed

page_owner trace-
Page allocated via order 0, mask 0x140c48(GFP_NOFS|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 1198, tgid 1194 (ccci_mdinit), ts 17918751965 ns
PFN 0x207233 type Movable Block 4153 type CMA Flags 0x4020000000008224(referenced|lru|workingset|private|zone=1|kasantag=0x0)
 post_alloc_hook+0x23c/0x254
 prep_new_page+0x28/0x148
 get_page_from_freelist+0x19d8/0x1a40
 __alloc_pages_noprof+0x1a8/0x430
 __folio_alloc_noprof+0x14/0x5c
 __filemap_get_folio+0x1bc/0x430
 bdev_getblk+0xd4/0x294
 __read_extent_tree_block+0x6c/0x260
 ext4_find_extent+0x22c/0x3dc
 ext4_ext_map_blocks+0x88/0x173c
 ext4_map_query_blocks+0x54/0xe0
 ext4_map_blocks+0xf8/0x518
 _ext4_get_block+0x70/0x188
 ext4_get_block+0x18/0x24
 ext4_block_write_begin+0x154/0x62c
 ext4_write_begin+0x20c/0x630
Page has been migrated, last migrate reason: compaction
Charged to memcg /


Currently, free_unref_page treats CMA pages as movable. So, some MOVABLE allocations may use these CMA pages and pinned them. Later, when CMA needs these pages, these pages failed to migrate.
free_unref_page()/free_unref_folios
	migratetype = get_pfnblock_migratetype(page, pfn);
	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
		migratetype = MIGRATE_MOVABLE;
	}


Best Regards,
Akash Tyagi


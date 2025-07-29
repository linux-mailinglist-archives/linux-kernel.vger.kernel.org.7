Return-Path: <linux-kernel+bounces-749399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A71BB14DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955EF18A348B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01936291166;
	Tue, 29 Jul 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qbE5D2Xd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBF287244
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792726; cv=none; b=RevhHz9gT49groFvveNMsanCdRGOzHH7bL1nqzSzJ2EuAFdBwXRdtqNQLHg53wJyKOhLQ7W35SA3n9HARUGkGPadJfqdh3ZtQ0bUBZtL7xRjd4XxrRD0UCAik6Bww/gHcuVOXWeUXFbH7VcNiHMGh6AxwmRuNrJiarywifIiWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792726; c=relaxed/simple;
	bh=0ThzzOh00UFJ2kfs9E/oxoqM+4CsLOcBlOdxM3epAi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYHOi6fO0yMZFFlJc6Rlr1hkCQhYj0MYmEhHfgxgsvoXeZ4mg3Y4Ru+akODFpZ+bANFhlGqKjXjJ2wGWFZ8fP86+6l3S4U1jSt79L/tnYjUZ1jI5mzOP41yf52URSib59YYhS5sev+KPaTK9x7jHUepR5xW0sgjZJmMRi8ef4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qbE5D2Xd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f42f0d3e6c7811f08b7dc59d57013e23-20250729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4od4AUhUIJ9k4ABCwmJJPjKIu1r4CKovbv8tn3vh+5w=;
	b=qbE5D2XdyLNDczPmYh2YidkP5mp4jHowmclyhsVB8WN4oUW6g56KvPF0ZfDg3grfT5qAawGbVmRoSL4mVM/LthSHptTW3zzCfGmK63uKlna3/qE3QGkeTgYfo8/cvfrlTy0MK8ThVP2egqI+B2d9FO1uxxCb03QH8g3KuJ5QPDI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:a14aa475-5cf5-49cb-a04e-41d51d2fd920,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:bf6f5e50-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f42f0d3e6c7811f08b7dc59d57013e23-20250729
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <akash.tyagi@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 718521956; Tue, 29 Jul 2025 20:38:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 29 Jul 2025 20:38:37 +0800
Received: from mtisdccf01.mediatek.inc (10.18.1.155) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 29 Jul 2025 20:38:35 +0800
From: akash.tyagi <akash.tyagi@mediatek.com>
To: <ziy@nvidia.com>, <david@redhat.com>, <surenb@google.com>
CC: <akash.tyagi@mediatek.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<mhocko@suse.com>, <jackmanb@google.com>, <hannes@cmpxchg.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, <chinwen.chang@mediatek.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
Date: Tue, 29 Jul 2025 18:00:28 +0530
Message-ID: <20250729123028.1224786-1-akash.tyagi@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <E70C1648-DDAB-4027-AB07-1C19B10C6AEF@nvidia.com>
References: <E70C1648-DDAB-4027-AB07-1C19B10C6AEF@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 25 Jul 2025 at 10:27, Zi Yan <ziy@nvidia.com> wrote:
> But there is this known problem that CMA can fail temporarily due to
> short-term pinnings. See the "reliable CMA" work (don't remember the exact name).
> I think you mean Guaranteed CMA[1].
>
> [1] https://lore.kernel.org/linux-mm/CAJuCfpEWVEqsivd7oTvp4foEho_HaD1XNP8KTeKWzG_X2skfGQ@mail.gmail.com/
>
> Best Regards,
> Yan, Zi


Hi,

Yes, the issue I described is actually related to Guaranteed CMA[1].

I have rewritten our problem statement to address concerns more specifically related to the Android common kernels.

Problem statement:
Android Common kernels usually have an out-of-tree patch to prevent file-backed page allocated from CMA.
It allows some allocations which have lower chance of being pinned to use CMA to improve CMA utilization controlled by a flag __GFP_CMA.
https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.org/


Additionally, android kernels create cma pcp list for pages less than PAGE_ALLOC_COSTLY_ORDER, but not for THP pages.

This way we noticed some UNMOVABLE allocation also occured from CMA via pcplist as for THP there is pcp either for movable or UNMOVABLE/RECLAIMABLE but not for CMA.
so we moved CMA pages to movable for THP.

		movable = migratetype == MIGRATE_MOVABLE;
#ifdef CONFIG_CMA
		movable |= migratetype == MIGRATE_CMA;
#endif

		return NR_LOWORDER_PCP_LISTS + movable;
		
		

Now, this way we fixes the issue where CMA pages wrongly placed in UNMOVABLE PCP. 
But now if there is a GFP_MOVABLE allocation (even without __GFP_CMA) (which android kernel maintains out-of-tree patch as share above), might pull that CMA page from the PCP.
This breaks the intended use case of the above patch, which is to allow only allocations that use the __GFP_CMA flag.

To address this, we have proposed introducing a CMA PCP for THP pages as well.

I would appreciate your review and feedback on whether this is a feasible approach for adding a new PCP in Android common kernel perspective becuase Because having many MIGRATE_CMA pages 
in the THP lists could cause several performance issues.


Best Regards,
Akash Tyagi


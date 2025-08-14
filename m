Return-Path: <linux-kernel+bounces-769382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA3B26DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78481B61B07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639E82FF66A;
	Thu, 14 Aug 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bxxGfpy5"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208031DFE0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192201; cv=none; b=a59rPMGFlFGBTp6ZcHQLpmA+qpvtSSgwBvp4iekDtH7zBE6l9EgwmLda5aEQhbaZnbS+v4gBaloWucCPLTo4mfSrQM1Z/t6xWid5nynj51VXC5QVLou8Gy13r/eyM+ng1RTeCtosOxc5HvxvQsQ8VrJP6Vlw2jZZVEymCZybh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192201; c=relaxed/simple;
	bh=nWPPNahG8UUt2RpKVYAo8b/Jvnxh9TIdKSNwgP3fyoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOiggLEQwefqgKKLE072yRP07h4M4HLma0N5vod9YBavDDh83hDOtvDPjhLZNTXQO15uEgerisN60tphBEYk3Uodk49pRt0M1fRc4IFx15/xfW5gIK0vxGUZADiAySfJNOOoyrlXjZen1Bg2TQDHJQmZB69IbPkQHYyOqrAz6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bxxGfpy5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GTyMLaYR+1uOWFwYD45tbkK9cNmLVTJpFPWAovysPBI=; b=bxxGfpy5yUVHVOGHsBhdmDXF5M
	/68DnQJcyvDIVWMp+e5nqsmrvpjwGAI/EUV9iVSnmSm5FrJkzySp3A6PshoRn9UszLRaFhq1ApDbi
	jUHMMARVNVj2qTtG1N0W3uXYXp8nbJVqJtU1pLLQNrjwtMxh0olKZhB0HHEDbtbozrbb9QiFQiPA+
	PWd3w7Bj+p+3OBi5D4V0DiMVXUetu5kbSrZAyfwoPfFD/V6wLVjNf3j664fw6HbDiICeDxbuIbCU0
	cUzh8e7sY9SPltcgGco5m051KsbseA5m721ObLzx2UfRtIqBylXWI0Ukyx5fmhWKYRc45vc4NqOEB
	wZwel/kg==;
Received: from 179-125-71-254-dinamico.pombonet.net.br ([179.125.71.254] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbfU-00EE1W-3Q; Thu, 14 Aug 2025 19:23:12 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Helen Koike <koike@igalia.com>,
	Matthew Wilcox <willy@infradead.org>,
	NeilBrown <neilb@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH allocations
Date: Thu, 14 Aug 2025 14:22:45 -0300
Message-ID: <20250814172245.1259625-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
which implies ALLOC_MIN_RESERVE, is going to be used instead of
__GFP_ATOMIC for high atomic reserves.

Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
allocations of order higher than 0. It still used __GFP_ATOMIC, though.

Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
non-blocking allocations accesses reserves") just turned that check for
!__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
test for __GFP_HIGH.

This leads to high atomic reserves being added for high-order GFP_NOWAIT
allocations and others that clear __GFP_DIRECT_RECLAIM, which is
unexpected. Later, those reserves lead to 0-order allocations going to the
slow path and starting reclaim.

From /proc/pagetypeinfo, without the patch:

Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type   HighAtomic      1      8     10      9      7      3      0      0      0      0      0
Node    0, zone   Normal, type   HighAtomic     64     20     12      5      0      0      0      0      0      0      0

With the patch:

Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Tested-by: Helen Koike <koike@igalia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..bf52e3bef626 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4219,7 +4219,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			alloc_flags |= ALLOC_NON_BLOCK;
 
-			if (order > 0)
+			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
 				alloc_flags |= ALLOC_HIGHATOMIC;
 		}
 
-- 
2.47.2



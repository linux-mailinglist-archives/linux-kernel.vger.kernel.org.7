Return-Path: <linux-kernel+bounces-867999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6722C041CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4603A8525
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACB23F41A;
	Fri, 24 Oct 2025 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A022288CB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272837; cv=none; b=K3Qp5DxzOPTmAdurVpQ4OjFm/CUu5sACzTtblucdIb8Pza3c0w6b/5pSRDOQ/Mdc/zyFL6fzET9evInoQx6oh/hKd68nkqsOi6tNm/ctqwY/e+OuiNGshdA+qcPKhYLYpvNjqwvh6vd0l39NFBYm7DmovXmneYiWxVMGpQyu2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272837; c=relaxed/simple;
	bh=dWne0O+Vb+/VikyMXFKm7XNukhA/Xu0GWOetr/xFln0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5FIDgejFGa7Elaonc9V1QLFSEb6K9afcNRxvuoy0l0W831Q59Yr+ci5u2Y2mDG1t5LFBbUoMQEScBnijXTwDKvehdGSUXdfw0zC3y84tBlFJvFwtJor/Hqj6ur4DQCZbDUdReVX2/to80ZQf1DJa9G0S0EBKAQK0Kvve36qn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 0C7C28B2A13; Fri, 24 Oct 2025 10:27:14 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/vmscan: skip increasing kswapd_failures when reclaim was boosted
Date: Fri, 24 Oct 2025 10:27:11 +0800
Message-ID: <20251024022711.382238-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We encountered a scenario where direct memory reclaim was triggered,
leading to increased system latency:

1. The memory.low values set on host pods are actually quite large, some
   pods are set to 10GB, others to 20GB, etc.
2. Since most pods have memory protection configured, each time kswapd is
   woken up, if a pod's memory usage hasn't exceeded its own memory.low,
   its memory won't be reclaimed.
3. When applications start up, rapidly consume memory, or experience
   network traffic bursts, the kernel reaches steal_suitable_fallback(),
   which sets watermark_boost and subsequently wakes kswapd.
4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
   triggered by watermark_boost, the maximum priority is 10. Higher
   priority values mean less aggressive LRU scanning, which can result in
   no pages being reclaimed during a single scan cycle:

if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
    raise_priority = false;

5. This eventually causes pgdat->kswapd_failures to continuously
   accumulate, exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops
   working. At this point, the system's available memory is still
   significantly above the high watermark — it's inappropriate for kswapd
   to stop under these conditions.

The final observable issue is that a brief period of rapid memory
allocation causes kswapd to stop running, ultimately triggering direct
reclaim and making the applications unresponsive.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1 -> v2: Do not modify memory.low handling
https://lore.kernel.org/linux-mm/20251014081850.65379-1-jiayuan.chen@linux.dev/
---
 mm/vmscan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 92f4ca99b73c..fa8663781086 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7128,7 +7128,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		goto restart;
 	}
 
-	if (!sc.nr_reclaimed)
+	/*
+	 * If the reclaim was boosted, we might still be far from the
+	 * watermark_high at this point. We need to avoid increasing the
+	 * failure count to prevent the kswapd thread from stopping.
+	 */
+	if (!sc.nr_reclaimed && !boosted)
 		atomic_inc(&pgdat->kswapd_failures);
 
 out:
-- 
2.43.0



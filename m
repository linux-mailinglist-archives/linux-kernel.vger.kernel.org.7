Return-Path: <linux-kernel+bounces-850322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54ABD2828
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422A84F0378
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F262FF147;
	Mon, 13 Oct 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCjSYpW7"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE152FD1D7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350617; cv=none; b=L1NH9u1BVOk5nG6GCn9AE1Q3UwGcutRA4HfG6/JDphU+6MvCzAZq975wPR4nUv/1Y7DFA1n7ShybleWdYIvAFDSQuQifZuthTi9FAZglFe6uzpGzsq6jaab7BEXeFyuTfRmshtBq1cqGu95eROozhzUz6b6Y35Oms3dz5y5LNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350617; c=relaxed/simple;
	bh=X1xmWRAd0rz1ccDKF1SY5AyFTCBLt/j4A08mR+7/PJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nI7xtjldgWKSDU3AzWKrHkBacbAh0mEO+EnKX1IbPUBiYGFsVR0VGORLegmjUZGziiUm4UJIAqurhAqZi8C8UVd2/oTGgoh6Azxd4R007VBQZCAZBRSmbx0GDVhiPe4lHvtPACPiChmKLoC2XP3WfNObQkzT6DklHSyUp6tJOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCjSYpW7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso3699252a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760350614; x=1760955414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCAxtY3LQTIn8FngImj0LqZJY45nq8RXCAx12F/vMUM=;
        b=VCjSYpW76CJ+BgiHWVwb1u0/vI4vVxhTAvTpyezF6mcXVY3yYR6wqCn0WWwizzs5jK
         hgGH+AnoU36Tq1aFJwcSDWeh7Kqx19dcGVCXklTgU1jnGbH2uyQ9K//gTS9ccgqI8R55
         UUkdltxyarqAmMnQznQTWOdHgGa2oUy58AqVKd7kA5R8GWD1pNH/pnGdAupIpbMdYDKi
         55qHs/AuiiFDkGWrjN3m9ixrZqmWP1OKmt1W3Ib/huig5EPpI1ZKX7ewVwVZp5zMTjL4
         ka/8gTWrMrCtZRe8V9Sw7zef5xE9kKkdlrllMoErlvGsd/tRiuGBng7DZKGY9KYzraDl
         URCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350614; x=1760955414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCAxtY3LQTIn8FngImj0LqZJY45nq8RXCAx12F/vMUM=;
        b=AlqHp32zqOYWSLiatR242hrY1qn5UUk/3RrSHkYKBCZfKrK8tyfcLRTQCHw7zKitUm
         mbLqjEis1YFjUeVITuaZPH3jUfss3eUwfzuF8YXzuzfeH15WOUvgY7yStjBWYtWDKT4Q
         4Qa6bzYPCX0KD3g8jbf0pI8ZpbMn/eQOjamN5xvnFRvvmVzY/EKDgI/Y/Ft2r2Hp3JX+
         2WwG4Qnr3SJ4qriE5rSMrO6fXCyTIYm6ZJTiitreMr+Ae9P0cv5WPaw4j1vQGBRNIb5Y
         IKOkhMrXu2HRBBmqFdKEnMkEpVRHFh37p/ooAQmqjT2LAX+G4b+96gaSGwxbZLq8K23E
         4Gcw==
X-Gm-Message-State: AOJu0Yz/yyujGmnD/1g1EpomFub47Ww/xym73rQPUPAiS4PoNsqsivTB
	YTyTm9Lf2X2e+RSR4oAaYXd/OTumTGNhyXUXlw23pOVcQ3Jrkz47vARX
X-Gm-Gg: ASbGncsKQdSyMmd/DtSLn9LRjWmNAyuev73gkjtzWNepisNsgu8t1QWz3IKC5m6oHF2
	CD9mnj/dsRrbDNp15l+guk4Z7fGN/wGU40WV2d5ZQxtTOY6T1fEk08ATutetl2JED4uMORdaX7D
	Ct13eYUwbwC/TCuMq3+P6oD6TYiH96hMwGlu8zUM4j6aS6UuaGt/MlE3ZOLCfMEI6qdbyhPzEyB
	acL3D9Dn8lKdUDlfBKuadMz1vmv0oLjbG4XNFx/XXdhudX8hR7ss4R9lIpiNoUaMXYiIjmLnbH4
	x6dLqO9exhjkwMWFt79OTPxX7/UO8Jiquv44gkOIRUbDzeoNvWcbv1o9u5jZqq/CakLeIqOVBb0
	3w2w5deXNYp7wnyXSV/IaehFw/umPudKd/lKCMkIDB03FJcCbIuRVNj44dCjKCv8eUjB5lZG0H9
	8SA4hlr+Ojefmuog==
X-Google-Smtp-Source: AGHT+IFb3Ekfpe+r+fIcV18hbbrZ8FmIGYR048P5P8oY5j/nrUewcp8bX6QuZ1UX5R5SzFd5k4dKnQ==
X-Received: by 2002:a17:903:138a:b0:268:b8a:5a26 with SMTP id d9443c01a7336-2902741cd15mr272716115ad.54.1760350613434;
        Mon, 13 Oct 2025 03:16:53 -0700 (PDT)
Received: from Barrys-MBP.hub ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29040e02648sm95556355ad.116.2025.10.13.03.16.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 03:16:52 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>
Subject: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
Date: Mon, 13 Oct 2025 18:16:36 +0800
Message-Id: <20251013101636.69220-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

On phones, we have observed significant phone heating when running apps
with high network bandwidth. This is caused by the network stack frequently
waking kswapd for order-3 allocations. As a result, memory reclamation becomes
constantly active, even though plenty of memory is still available for network
allocations which can fall back to order-0.

Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key")
introduced high_order_alloc_disable for the transmit (TX) path
(skb_page_frag_refill()) to mitigate some memory reclamation issues,
allowing the TX path to fall back to order-0 immediately, while leaving the
receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
generally unaware of the sysctl and cannot easily adjust it for specific use
cases. Enabling high_order_alloc_disable also completely disables the
benefit of order-3 allocations. Additionally, the sysctl does not apply to the
RX path.

An alternative approach is to disable kswapd for these frequent
allocations and provide best-effort order-3 service for both TX and RX paths,
while removing the sysctl entirely.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Huacai Zhou <zhouhuacai@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/sysctl/net.rst | 12 ------------
 include/net/sock.h                       |  1 -
 mm/page_frag_cache.c                     |  2 +-
 net/core/sock.c                          |  8 ++------
 net/core/sysctl_net_core.c               |  7 -------
 5 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff1..b903bbae239c 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a per-NAPI list. This
 list is then passed to the stack when the number of segments reaches the
 gro_normal_batch limit.
 
-high_order_alloc_disable
-------------------------
-
-By default the allocator for page frags tries to use high order pages (order-3
-on x86). While the default behavior gives good results in most cases, some users
-might have hit a contention in page allocations/freeing. This was especially
-true on older kernels (< 5.14) when high-order pages were not stored on per-cpu
-lists. This allows to opt-in for order-0 allocation instead but is now mostly of
-historical importance.
-
-Default: 0
-
 2. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..62306c1095d5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3011,7 +3011,6 @@ extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
 
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
-DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
 
 static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
 {
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e..dd36114dd16f 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -54,7 +54,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+	gfp_mask = (gfp_mask & ~__GFP_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
 			     numa_mem_id(), NULL);
diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a..1fa1e9177d86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3085,8 +3085,6 @@ static void sk_leave_memory_pressure(struct sock *sk)
 	}
 }
 
-DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
-
 /**
  * skb_page_frag_refill - check that a page_frag contains enough room
  * @sz: minimum size of the fragment we want to get
@@ -3110,10 +3108,8 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	}
 
 	pfrag->offset = 0;
-	if (SKB_FRAG_PAGE_ORDER &&
-	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
-		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
+	if (SKB_FRAG_PAGE_ORDER) {
+		pfrag->page = alloc_pages((gfp & ~__GFP_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
 					  __GFP_NORETRY,
 					  SKB_FRAG_PAGE_ORDER);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8cf04b57ade1..181f6532beb8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -599,13 +599,6 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_THREE,
 	},
-	{
-		.procname	= "high_order_alloc_disable",
-		.data		= &net_high_order_alloc_disable_key.key,
-		.maxlen         = sizeof(net_high_order_alloc_disable_key),
-		.mode		= 0644,
-		.proc_handler	= proc_do_static_key,
-	},
 	{
 		.procname	= "gro_normal_batch",
 		.data		= &net_hotdata.gro_normal_batch,
-- 
2.39.3 (Apple Git-146)



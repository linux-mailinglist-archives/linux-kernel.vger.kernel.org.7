Return-Path: <linux-kernel+bounces-830759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62DB9A738
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB614E22D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E7F3101D5;
	Wed, 24 Sep 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Eiyk3Z"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22D3112A4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726026; cv=none; b=Ye8VcAPqccI3xrjtJncD5RqkltGz77Y7IITjm93MKFEA6Xvo1ndhegfbDC7hQ2jKE4lsnCweCWOegT1Lh18JKy75tCSFYJMGp9j8JeR8qnB0LSHTniD4xCfLa8lUXVxLAgtLLd8N+oJzhyi2Z18RLI7yMlASMxsanjpidi6rFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726026; c=relaxed/simple;
	bh=0dP5NvAwWbmZXGXCdGyVFXlOGRGhP7dtkT+spo1UHNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4ZSv02qzaDMXneEAaYZGbyEzKRm/vwCT9HI5bD6gw49dn7YD9RgJlerGNI6BK95BsyX+HX/O6xvpDLN1Vxh2WS/BWpzpl3Lsjsn7x9/4hv64lhAoTwdzSK1hDkTgQXS+y1dK2WTkTrWIRdbZe/SdD0Xx9u/gRU/ZF77fmruBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Eiyk3Z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so3319225f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726023; x=1759330823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzrycjTVpnWNKj7lM2bs2OjeckNX2GUUhGCkamMVlMg=;
        b=G+Eiyk3Z5m+Wq/3isv1APAn8/+Qe+OWs3s8twD6pa9aJ6/IB9EomsvApbpDx6kcbkL
         94+OyTNjLXXMZbXZPCwLIBPMVDCuTbiM0Xs8+Ho4jK8uJYrpj52ma6Ait+w9coWZFkER
         2+6pEVyGD3R8oBUxQN9lMtUoDaqutWDszgkVtNwoLX5Q8WxLXRIn5qDplPztEWeK634A
         P8xd2gjQZeS01KBVIf5xxcxwFh3qiVDOB1KvX00jcxU/fka0PNl2+iXq2gOsmTIQi2HV
         fYao7efqOTCoGMVdac7wt6NG6EkBk0V5+8PIVEJjUEpBRNO6Mm1kRTxtqtBS1a7L56eU
         m0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726023; x=1759330823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzrycjTVpnWNKj7lM2bs2OjeckNX2GUUhGCkamMVlMg=;
        b=n7u154kNdtU9AT3l6hk/3KdjWOHPORTVcihd/52FwtmVfUqG4262DK4rrfE1Wjwsf4
         GQVsYjTql/g50TBqoJX166YbeRLyNitZBiWqb5w+E3b1EPYJ18KguYdXSQ5xtwzJXnqF
         JlAl186+KLT8X7SI/qm1p55q+7rzL42b5qc95vr1xLcX6UHYO6WfUtKEWkqPPBeK9C5+
         CYKWmRAccF/VdTcFqOF3xnHW+mfqJ4dEh2fhawhBsqhLxS9Govs4FlG++BpS7DOLClAP
         kIjVdDdQi4/sChX7/KK7oNuFyBtYMSuXOgnYnEzWOp9TwGjrtpx/vh+OjZ0o98TZWRym
         UrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSS72IdWR4wEl8r9uAS/UkrgMW2GZWF4fhYKTKf9p8PK1psb3Cqxnu98vCntkscwjoBUMRkPWCcnKeSyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3/DKCjR15NEdJ3nzzrTYT7L2gLrxhwWd1KmdW8Nz3QlZYKSs
	jDDXkhvA7VjlxZrmvd4bZLsBIk1jg9RybenccD/KmY0P23fbgaKWM5qbIOLVAqYRxeVo122Wq1H
	f8zMlyLhQNh0Jcw==
X-Google-Smtp-Source: AGHT+IG4WxCVm2OtQGcna9zHZFJt3Y1WAwbtDQRLq8Re2vHQBN3oIS6DUJScN8kIjtixgF9x+8sRx5iaUapcaw==
X-Received: from wrxo18.prod.google.com ([2002:a05:6000:112:b0:3ea:af7:bb94])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:381:b0:3e0:34f4:3225 with SMTP id ffacd0b85a97d-40e4ce4baeamr250578f8f.45.1758726022897;
 Wed, 24 Sep 2025 08:00:22 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:50 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-15-2d861768041f@google.com>
Subject: [PATCH 15/21] mm/page_alloc: rename ALLOC_NON_BLOCK back to _HARDER
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
non-blocking allocations accesses reserves") renamed ALLOC_HARDER to
ALLOC_NON_BLOCK because the former is "a vague description".

However, vagueness is accurate here, this is a vague flag. It is not set
for __GFP_NOMEMALLOC. It doesn't really mean "allocate without blocking"
but rather "allow dipping into atomic reserves, _because_ of the need
not to block".

A later commit will need an alloc flag that really means "don't block
here", so go back to the flag's old name and update the commentary
to try and give it a slightly clearer meaning.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   | 9 +++++----
 mm/page_alloc.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6006cfb2b9c7e771a0c647c471901dc7fcdad242..513aba6c00bed813c9e38464aec5a15e65edaa58 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1297,9 +1297,10 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
-				       * to 25% of the min watermark or
-				       * 62.5% if __GFP_HIGH is set.
+#define ALLOC_HARDER		 0x10 /* Because the caller cannot block,
+				       * allow access * to 25% of the min
+				       * watermark or 62.5% if __GFP_HIGH is
+				       * set.
 				       */
 #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
 				       * of the min watermark.
@@ -1316,7 +1317,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b205aefd27e188c492c32754db08a4488317bd8..cd47cfaae820ce696d2e6e0c47436e00d3feef60 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3295,7 +3295,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * reserves as failing now is worse than failing a
 			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_HARDER)))
 				page = __rmqueue_smallest(zone, order, ft_high);
 
 			if (!page) {
@@ -3662,7 +3662,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 * or (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) do not get
 			 * access to the min reserve.
 			 */
-			if (alloc_flags & ALLOC_NON_BLOCK)
+			if (alloc_flags & ALLOC_HARDER)
 				min -= min / 4;
 		}
 
@@ -4546,7 +4546,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
+	 * set both ALLOC_HARDER and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
@@ -4557,7 +4557,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		 * if it can't schedule.
 		 */
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
-			alloc_flags |= ALLOC_NON_BLOCK;
+			alloc_flags |= ALLOC_HARDER;
 
 			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
 				alloc_flags |= ALLOC_HIGHATOMIC;

-- 
2.50.1



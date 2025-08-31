Return-Path: <linux-kernel+bounces-793284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE3B3D188
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A233B75A1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4C239E88;
	Sun, 31 Aug 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d01foLdL"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C329A1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631313; cv=none; b=UBpl/lC0SVWzEdy+5VJTTeyu8QtF+Hj8S9zXxVPrMM61u2OhAlXbGCBnKQ2JkqUto7EaNQgTin/WsjyaObN9AnX7WZ/bJEnaByPhVrsCPd7dkW57aCO3VQbH6ORDRqq6vM26akZnOFVSZOBpp9cKmPkXOTiR0sPXhQSjR1GPEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631313; c=relaxed/simple;
	bh=F9zzDfAQ89ufKt+J1vm3QtfSIESD8Dr5qFKQljoOTSU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M1JWEgYxHFK5h94fF4HPaxAYVLxfNYFqTKK6LNvhbA8NuMqGwH0j/Z9crjozzEDgpJD6nu1tZp4CvxTvWVnODZd0VMkOraGWWUm+8ZhSZjQeMOBlHLZlm+YAR65nWTPoOVINCq1K4MC3iZyjJhKvox7cU3aPCwol6codOsq2dyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d01foLdL; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e970b511046so2599112276.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631311; x=1757236111; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u88nEX4VhKEhfqfy6sgABj7KaLHVYd51Cg9xPrUQsPg=;
        b=d01foLdLQuFOZkk0hNyaXds5qnMmBqhWqqnrrQzfa7RQT/O8cctngogxVFVSWTBRF5
         mkWm5zOMA49uDCRCP6tObxTKdOh14wyGhrqJFxXilE8sFamz4NsGepltno7EyLSIFVUS
         L6xvSEmL9h6gzfZ0a9dd7bVCUZ8TMrNw9Ky7ZKc/0bhFBBYiaubF7bs5oYZp6uh5bHli
         fHDTvVoGmFRrleWMnyIhoMcps5caLPD7RnDIxN8S5ZMg81FHpH+ZXhKMjgLKeaQ7g0qd
         HXNJD4csfq7YJlxSjazyvqu8d+hg8l/DVlk8K+k6swlUdQhl51RGBIYRJ2ivQ0m0D9zG
         w0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631311; x=1757236111;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u88nEX4VhKEhfqfy6sgABj7KaLHVYd51Cg9xPrUQsPg=;
        b=cmloegVIqRVnq36XWskGEFWK0tmx8zsiCk0u+YDnM0lo6mNqSHgHeYUVGGRVzbh4w7
         DT8tb0ZTbepOJZEipYrZU8YDmwO3V3mTr2g0x7tdKHh6cH4+HgoUYuBJ/3jeBnTB7FC+
         fuemugMPdxoNqkENLqJUtJinzjPSwn5M8B+Koh6zRNW8GWraZ34+BlyP+mvn5gP4gYiF
         ymrHVvFnzmg5hPk0rkpOL7lrXalL7LDvZ/yEwW3txWygSjADsCvsmBi3B+4pWPpQbpBb
         KBVaVwXtr5+mEC/mqNzPN7m8uqrWYWj9N15gql491kwfQJXPTkj6fUnglR8oPuUd4mC8
         PIAg==
X-Forwarded-Encrypted: i=1; AJvYcCVSjfpAVVgBLWXeCK6rLzCEJpNq+KdZotwPuaHQDQK9BVg/nyXXf2HcryZjExph9lhOT/aFZXcInlL5hiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MsxUeBlLPhStK6s4kDhOuSX1vNS6rAQBnMcMjwwikLDW0suD
	/04EWpx4GQ4H151E6Pmvvl7Gwhj5QJMeISs694BRTXaVfA6W7C0Qu0NQf8d2QJd8Ow==
X-Gm-Gg: ASbGnct+ZZbR3/JfEHap5zIIkMlOvpZPUJ/fMtub9gDRmH5mSTnQIhn3s3UyEPMsYLB
	bbNBDfEOgEV8y/c9pyWyuknXoabXQoeP+JalRd0Z6T5F2vJJyljwhFdcr3woKL4LoZIaYGiIhIe
	Fx0Ajn022WJSccH+vjCOh5CvQN8IEHfmb7Rit4bJHMzQC7P3U4b6VqBqSiLdrzxfx1LOxO/ksj/
	atjVYmwTm6Gx5Mh8sl8jhBW9SGXtwFfNjwqIy7W5ZWyHEOqA4ObpMA2gPcUHQUG/JfLDQiT2oQf
	/CqFv7pQ9fJ3P0MKCPrQztTHHMALX8GEarlVlM3FtZzLHV4AhEf05gS+4JrURtmSJUeRGwGe0xa
	quBOXpmk5evq4D6BL49Ke3Ki6/PIAvvTHx1XuOnNKdVstBa0nsHAzYVjEtJcfeFLPfarXhNAbsB
	Z6J8Arpc0rymSYHQ==
X-Google-Smtp-Source: AGHT+IF4uqF7l2E0FZ9hMKOQYbXmnG/oF/j3dZTuq2FVbemX/WEQ1z/BcNuLmVYRYcxAG32KEwnQnA==
X-Received: by 2002:a05:690c:490b:b0:721:6adc:4364 with SMTP id 00721157ae682-722764cb124mr44113587b3.33.1756631310488;
        Sun, 31 Aug 2025 02:08:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d8ccb38sm7148137b3.35.2025.08.31.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:08:29 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:08:26 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH 3/7] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <165ccfdb-16b5-ac11-0d66-2984293590c8@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

In many cases, if collect_longterm_unpinnable_folios() does need to
drain the LRU cache to release a reference, the cache in question is
on this same CPU, and much more efficiently drained by a preliminary
local lru_add_drain(), than the later cross-CPU lru_add_drain_all().

Marked for stable, to counter the increase in lru_add_drain_all()s
from "mm/gup: check ref_count instead of lru before migration".
Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
optimize longterm pin_user_pages() for large folio") first.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 82aec6443c0a..9f7c87f504a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 	struct folio *folio;
 	long i = 0;
 
+	lru_add_drain();
+
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
 
-- 
2.51.0



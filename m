Return-Path: <linux-kernel+bounces-830761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6FB9A73E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C425D4E2BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F8312817;
	Wed, 24 Sep 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGfnh/pg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619F311950
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726028; cv=none; b=lu3cvy+JLMec2ClDxcVGmRFjnPgvEfJWuNkLP7kByDj3w4GO8e0FbbHGpc53V8OqCgyBeNBiLqcQaZ3LdkcaaejMNgNrIfQJhBErn3UYVEvPUZT4iplBx8duWGZ0vtAr9KUBhDuuKxm34e34lOM9I/lFjU/hhJeNlXjyZNBw4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726028; c=relaxed/simple;
	bh=nvFdwqm8o9QTQz3CNfWRVh+M1QsyCyS3UTW9abSr1Ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mzq+0R98ccqQCzWPWL5sWS6vdYAMz3GwQJalNujSXZ+RRwo+PcTIFIZTYfvRp5wES7rWFQtrFZyn5ZBrzgAfQV7z8XPVZWQcFo4s4HGwLIY+/FPQN1/ZcG6rHBSzAKQN4ReX2MlBYl8dPIlOaL4gf2rhdTTRXYKrvUOUUdJaud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGfnh/pg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e1b05b42fso19989635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726025; x=1759330825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymn7hQz/pKJzXD8tPM+aagOUbUEwxLcJswgCIwaE8Js=;
        b=NGfnh/pghilGeWk1Ok2KZeKlk29iGOwU6YR0gc7ZXgTJVHQRAN9jXQpfQu2C39aBi2
         4xQsWHr/W0pgHkfRcpfZkBvlrNc7WswsRuVbhEilXX5HulYvRptTE+/K7Q77shZZi/Zi
         uBmOUclVzTBTXXuY4nnYXSJfTPuwX012UXVDUoMnuPfhSvYgxqxzDdXvLYdLk/BuWnTO
         efN+FjnsJ/tDdSZHRTpTvBMXDcvjp3YHGHAfDOuIRnbFQNdXn+Qa9euWV0Q1VQRHKNmU
         RP974AeyPjbCqnXm5R9/762bUU24Tlbl3sdDvuQRTuqwiqwKOJwgwls6f8iG/QiFK78r
         5KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726025; x=1759330825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymn7hQz/pKJzXD8tPM+aagOUbUEwxLcJswgCIwaE8Js=;
        b=eNklOFgozNY2NA6edsRJc9sI88VEH9svtJX+xyv0eGw7gpCc1FA3v2C7NJnDiQksLk
         tl6CDRF+vtsgzDPAxbKN84+LMFsMJGwtmtXpSn8WyZsgDwe1h0wAV3dTLidRdXll3F1T
         1amThpJeN/RBJ8TYPhHXRQ5N6qVRYwUqeKbTAWzsfK2mh3JPwfTbXX+DxiXK0fkA6MFn
         ULzIpIFSRvdApaxGA4cCSPE4jGv0fIgwDCF6SSMYbsds+/iR7fOBqm5uyL/TwyenfoPy
         /ko2iBdn2ZPwVLBqWD9i0OXpUR3EQuFYV319fc2bnw9jhq5RVPaQXU3A6gksahNl2UWW
         3yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoSlSdxGBpLJtl2jebu4/OEYhWOgqeQSv7awUhJeuyclwuF396gUwkxzANGAt7JigDDiEaWW73U2HwT70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLgsZu8BgRr//QmhT74G9jrK1TgVToEFoImnGGIg4Yr2NhQYv
	QMYM2L80SmXQfylKggu6uo2h5vDiJzKlkvd7R93xh3pjseZK3ZC92elKUVrvc+SeZH9xrBJ3oGC
	CK/mw+DPIo+cJdA==
X-Google-Smtp-Source: AGHT+IEpWYX5czTdErtD0ucu84grAEj2tMZftfqJQYBrWaTJqn3fb8Jtio2hFIBWofbJn4+DEL2AmWmtTqntmQ==
X-Received: from wmbgw9.prod.google.com ([2002:a05:600c:8509:b0:46c:8b6c:6cc2])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cc:b0:45d:7d88:edcd with SMTP id 5b1f17b1804b1-46e32a030cbmr1610275e9.30.1758726025028;
 Wed, 24 Sep 2025 08:00:25 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:52 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-17-2d861768041f@google.com>
Subject: [PATCH 17/21] mm/slub: defer application of gfp_allowed_mask
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

The page allocator will take care of doing this so SLUB doesn't need to
do this before calling into it.

The page allocator will soon start using the GFP bits as a proxy to
infer if it can do blocking stuff (separately from whether it can do
actual reclaim), hence SLUB will benefit from leaving
__GFP_DIRECT_RECLAIM set even when it's forbidden by gfp_allowed_mask.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 867a07260acf9e3c0f92de66e2d25f081ae51dcb..0f8724af4ce63f6e2a32e889f6490be7a25823eb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3177,8 +3177,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	int idx;
 	bool shuffle;
 
-	flags &= gfp_allowed_mask;
-
 	flags |= s->allocflags;
 
 	/*
@@ -3212,7 +3210,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->frozen = 0;
 	init_slab_obj_exts(slab);
 
-	account_slab(slab, oo_order(oo), s, flags);
+	account_slab(slab, oo_order(oo), s, flags & gfp_allowed_mask);
 
 	slab->slab_cache = s;
 

-- 
2.50.1



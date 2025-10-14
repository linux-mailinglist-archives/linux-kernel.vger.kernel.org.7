Return-Path: <linux-kernel+bounces-851771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D106DBD7370
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38C854E91D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AE3074AC;
	Tue, 14 Oct 2025 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8saI6vW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E6272E61
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414341; cv=none; b=A+EPKKGuYL7+XFaI2lJ54GxFvHSZ6Nqn9Fc8naREj3lo07quyFTdsFn5t8X/3z+jca4G37iJWt92AQas478UYl+OXjFKg1AGwon8klhBe5m6HsQtGBaA0oJpV+ZVJ/Q3vpHohlfppVklpEgAdxwalts+gTK8vqa1HBXcWXfBdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414341; c=relaxed/simple;
	bh=0mrsJv0zMKIskTlEd49XtUdQ1utrmWpTHE7Oji0ElAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NclEGfMPfaThGi5WX7tZsGfEiE8cEHjr4bvGQpfidhw0b+ZQsVqHF9GQWYm6UK/w/EOei04cor62+ZowkjUaXkptAevtJ4EhDvGDYKqhJWN1dimM94jHFdAze+tAH3hAw0232knn2nESmoRGm5HTEHowOTkg60eSXyHV1n7B+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8saI6vW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26983b5411aso33234135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414339; x=1761019139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIZEfbziMhDeXPLAiUOw0zvjCU/6+aE66j2icymvwcI=;
        b=O8saI6vWtmlZ0vfF8A2yNlJUOXvVH04edwOVGmoJrQ+J6tm7APa+sfBZSqkB6LQbEn
         LXGstI4DbWwGrXhcFgTpiW0D7weLKG7eZPUpFozcG5APTs7Q35ZFtLSu02xpO4JWdhDu
         4XizJ1eMX9I3zWyNYkhHOGpcmP3ivZtxZwFKMGMxEYm6HaXiCyiyDM8QbiqNxS4LXjiQ
         4jRgm8kIpwpKMGa2DiHXZ/abxHTXlRgTiOLmiVi/LRFBp5UFjK0Ftx8DOeTjZV40tZZe
         AmF92vttBZDa8wLK1Bw27pbybtVdNbok4qDOGn3cgWhARSJANy51OiuwoE6GqPIjhTc+
         cuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414339; x=1761019139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIZEfbziMhDeXPLAiUOw0zvjCU/6+aE66j2icymvwcI=;
        b=E5gRAMyw10kyrvwaWgiqWazYE2RGomwhO3SJz90wSUmR8I2F5HWIMFVl8rIUSB5/mH
         9cqDD4fy/vPWFH/T29EgHnYWl97laecPz4wq7EWgnIY/zAO+9RLT6fScY4uZDF8wm9oE
         T0KSpzmNubG00yY2en3H3oOYV+UcO6DfcA4Uae3xIJO1rgRtfT/awox27RtlnWbSqjba
         9gdrTpFZ24uXT+OwhB5RcHce4pA+6LV4gi54gIrB8ALQhCCPHJChC4ipGGIELvtF8pIU
         sjnVA1OZdXQlgf/TfMhtUd4q+FCGA1sANGraBlcvUJXSOf8aTLiHUTZrQtqlJx2eStuw
         KDtg==
X-Forwarded-Encrypted: i=1; AJvYcCV2DTrkfqAGbvs7XY+lEXnapRmauhhY1MforV958OoLZmWg8iByvBSnRVcQ/tGKesnJdKgRiM+7qPrJNy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjg0hT2txkkncjo3ZzIaq1fDi9xfkYERZBUaNMYBF6n6V9K3u0
	qXr3n0URzA78ydszU5GyT7O1S6lu96fI+QPH9XnIDOQlqksrlm+buyU6
X-Gm-Gg: ASbGncuDeh6D81EOcD6V9q1syzHhp4eanN6GK+adKK5xe20vu191c+rJtYwLyvXF89g
	cBCwi9omMGvQ6P3pNG4xyYfALvkGLovXNk3Nt/5OMCjr65RRxXIyABlIDLbVXUdopiXdAHUSaJc
	quLdMsiSA8z1HELMde7YIA+gZbgzWDPha1c0dWjOJR1NDw4RQFkUqATa5TzQvGMoBNAVdipOoSX
	+z2nn2uXtCAvHyhJDjh0dSqzIH6rDUnXRGD/G8Pjm5IME4dqnI6P/A5slJD/lY+Y6G0lYO4pcaZ
	rpMuDd/8mIfbPttoSFnSDHXXYvhLmVimri8AXLRzWFMnhbZd+nZq6WwLWJdATLGJtJYca9/RGeD
	ooqVWHzg5b20oKMGpaiFtf7rKHcRQRMjQvSa//pMnEBBIr+cuwg+v8FepEFr9Zo6Gowpm8IeqJU
	Yzh+1Xc9rq
X-Google-Smtp-Source: AGHT+IGL3EC7uzisf8wnwsneVP9C7iO5pEmo4F4CA0O58hvdMK9aZKrTbYI/GrA5pn66KoRLAHTokA==
X-Received: by 2002:a17:902:f641:b0:27e:edd9:576e with SMTP id d9443c01a7336-290273ef199mr269866415ad.30.1760414338517;
        Mon, 13 Oct 2025 20:58:58 -0700 (PDT)
Received: from Barrys-MBP.hub ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95ecbsm144418965ad.130.2025.10.13.20.58.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:58:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: edumazet@google.com
Cc: 21cnbao@gmail.com,
	corbet@lwn.net,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jackmanb@google.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linyunsheng@huawei.com,
	mhocko@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	willemb@google.com,
	zhouhuacai@oppo.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
Date: Tue, 14 Oct 2025 11:58:46 +0800
Message-Id: <20251014035846.1519-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> >
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index 2ef50828aff1..b903bbae239c 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a per-NAPI list. This
> >  list is then passed to the stack when the number of segments reaches the
> >  gro_normal_batch limit.
> >
> > -high_order_alloc_disable
> > -------------------------
> > -
> > -By default the allocator for page frags tries to use high order pages (order-3
> > -on x86). While the default behavior gives good results in most cases, some users
> > -might have hit a contention in page allocations/freeing. This was especially
> > -true on older kernels (< 5.14) when high-order pages were not stored on per-cpu
> > -lists. This allows to opt-in for order-0 allocation instead but is now mostly of
> > -historical importance.
> > -
>
> The sysctl is quite useful for testing purposes, say on a freshly
> booted host, with plenty of free memory.
>
> Also, having order-3 pages if possible is quite important for IOMM use cases.
>
> Perhaps kswapd should have some kind of heuristic to not start if a
> recent run has already happened.

I don’t understand why it shouldn’t start when users continuously request
order-3 allocations and ask kswapd to prepare order-3 memory — it doesn’t
make sense logically to skip it just because earlier requests were already
satisfied.

>
> I am guessing phones do not need to send 1.6 Tbit per second on
> network devices (yet),
> an option  could be to disable it in your boot scripts.

A problem with the existing sysctl is that it only covers the TX path;
for the RX path, we also observe that kswapd consumes significant power.
I could add the patch below to make it support the RX path, but it feels
like a bit of a layer violation, since the RX path code resides in mm
and is intended to serve generic users rather than networking, even
though the current callers are primarily network-related.

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e..8ad18ec49f39 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/page_frag_cache.h>
+#include <net/sock.h>
 #include "internal.h"
 
 static unsigned long encoded_page_create(struct page *page, unsigned int order,
@@ -54,10 +55,12 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
        gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-       gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
-                  __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-       page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
-                            numa_mem_id(), NULL);
+       if (!static_branch_unlikely(&net_high_order_alloc_disable_key)) {
+               gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+                       __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
+               page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
+                               numa_mem_id(), NULL);
+       }
 #endif
        if (unlikely(!page)) {


Do you have a better idea on how to make the sysctl also cover the RX path?

Thanks
Barry



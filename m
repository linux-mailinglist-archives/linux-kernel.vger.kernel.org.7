Return-Path: <linux-kernel+bounces-876523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3EC1BAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE1A18971BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE93376A3;
	Wed, 29 Oct 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fe1qANSy"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42832ED51
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751841; cv=none; b=dePrB9kUpnhRfFGuIM31s6aJkRiFBdWTR8zydBhTlDvVpCksdLWi9dRy/SBEesIo1nXA7I3jaiIAgd/Pz9XWtf4+9yoEjulCItDBxyX9DLohu3pkvmAlhcRbpBmjzULykuUDQ5cEWXjc59RUughf4lJbkWLRgXpC/jyqsAJSqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751841; c=relaxed/simple;
	bh=guB4QovAHT8kMie0PLZYLo2KFTfB2kqXlrVCoekHzzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjvQWQ4/oJOTbEf4zk53EmEBjDKSE1t6xfIcIxdGLugkphqjUizcICdnPUntFGj1S1lsOip4t4HsG/zyCC8Hl7DO6/d7Dvt8ef7i11OYaxSybU2KiReYU+QmMC/fM3/oKvtHf8sP79xwKm0xIjWFRQ4T7b2iMnZbTiYDj4mH1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fe1qANSy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso5110676a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751839; x=1762356639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=Fe1qANSyoYZ+o5Xo5l0p0wAQl/dQ2l6wihovFdmQz0LNNb+yp5MG6qh1ZS/66QKA0v
         cqZTpf8lsEM15lxmPtcE0abzG3++W/TN0uTkbgf+SktGWC52Mx03E+euik+ozrA7A2PC
         YlLNE+uwkA34AijjBjEkspFrBC6kjm2OmHg9laesKo3oy3dcW7WF82scAaQ3MIJPK0S8
         zAkAKkKxCGtuE0l2DBfOzGNLHKuXYgMomGvO5lTzJZkt4AbIBfSRMOvS2Dfh0rFeJl4+
         cJMRBsrADjOm/+7Mf4ykj4Obpp0nXOz7eR6h6ILaZxaEw3Rsuy839Qx1UHhvZNWfP2Fd
         sRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751839; x=1762356639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=vBn/m2o9uHYTO9D9mj2UTFycrHVwh+BwEWl0qjnacgDZ3H0GIFSMrSruEZf5hi6jrd
         e76C5Den4otaoIHNb+pk8GIYhMn6kVdFJB40lqdNRAiEWmON9ZDKWvpvtsYfu0Q4H7Sf
         mmBLu1rFHGrbk16lrNiof/CANSvUJDg/dUqjes7Ud+eB2nw/6B24dasdd8EHRplFvPmr
         Lmhsk0bob3dzQy74sn8NdXEv7ekXoZQmd/4vZXNi1EOm65wUbLVsR9ILvxREoWiglWxJ
         etMrXp/9fu4/YWqZOml0JZaGhxcA1doKFFVbvAs9D6N7TUMmCE9JmCFYiRjPLPyUOeDV
         Gegg==
X-Forwarded-Encrypted: i=1; AJvYcCWEEbsnpD8aXcAIGvub8l+PcaWdW2y1JMUM7F1sz23DeLraS8G6EIJJqkM2HFkCyvrzLP/ETkcXwfRNe74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGR4f8b1iIj4N+4cIHQCV5Xs428SluaXE9kA88ZRd0t6CRpQJL
	pHlubBm6cIKx4H0T9xhlfKhn78mw1HtxIWVwbg8eR1Q7b4siHseT8Q65KveQiJH3z5A4UvFNb6J
	/pl9+7jl1y4kvOc30RiyJHfiuiJgoUhi0gSdcdhmD
X-Gm-Gg: ASbGncvTKTP5b5DKxy7srdioe70Ej9uodeReYEvb/k/crLKI1Gitaq1koWCxMwnUXKo
	lVhgf2XQJq6WKlk1KTISuMoTeIj8R1gpujMtW37NY9YB6l0eQ15fcylABA0cZlI1yB6juE+c9BA
	5T5o6itDnI43+JFZgIzDCdzlsxvABPTM1KJy02X2KMOMntqN+1CTXnEG7ixGTQeudCz1F9asodo
	tuW81iDy/gvnNy58gOZSJts1ecAy1tBIhglzDqYvxv/P6Eqm8iDgKkMhmpXyN5qHRotxSQ/8euV
	V+EbUGAeQOErCtzYAY1uqqU/IQ==
X-Google-Smtp-Source: AGHT+IH8xvowD+kYXQ7z5quxP2h2xDBqXwlebiin7tKEs9t726w7tT592s456fkeCdpk2YUZnOu4Up+XSy1ZFsm9bRU=
X-Received: by 2002:a17:902:d4ce:b0:28c:2db3:b9ab with SMTP id
 d9443c01a7336-294dee25ef7mr46936785ad.26.1761751838802; Wed, 29 Oct 2025
 08:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz> <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
 <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
In-Reply-To: <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
From: Marco Elver <elver@google.com>
Date: Wed, 29 Oct 2025 16:30:01 +0100
X-Gm-Features: AWmQ_bkcozjdjluUvttU4Roh8Mm8XDdSh0qCy1zW1YFReOaqG1YdYoXpHqK6R8Y
Message-ID: <CANpmjNOtocYUyX4HEB9GELeDVb1LbgESea98+UH5LCuYVoZbCw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 15:38, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/25 17:20, Marco Elver wrote:
> > On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> >> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> >> but it's conceptually the wrong layer, as KFENCE allocations should only
> >> happen when objects are actually handed out from slab to its users.
> >>
> >> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> >> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> >> was refilled with KFENCE objects. Continuing like this would also
> >> complicate the upcoming sheaf refill changes.
> >>
> >> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> >> to the places that return slab objects to users. slab_alloc_node() is
> >> already covered (see above). Add kfence_alloc() to
> >> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> >> prefilled sheafs, with a comment that the caller should not expect the
> >> sheaf size to decrease after every allocation because of this
> >> possibility.
> >>
> >> For kmem_cache_alloc_bulk() implement a different strategy to handle
> >> KFENCE upfront and rely on internal batched operations afterwards.
> >> Assume there will be at most once KFENCE allocation per bulk allocation
> >> and then assign its index in the array of objects randomly.
> >>
> >> Cc: Alexander Potapenko <glider@google.com>
> >> Cc: Marco Elver <elver@google.com>
> >> Cc: Dmitry Vyukov <dvyukov@google.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>         if (unlikely(!s))
> >>                 return 0;
> >>
> >> +       /*
> >> +        * to make things simpler, only assume at most once kfence allocated
> >> +        * object per bulk allocation and choose its index randomly
> >> +        */
>
> Here's a comment...
>
> >> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> >> +
> >> +       if (unlikely(kfence_obj)) {
> >> +               if (unlikely(size == 1)) {
> >> +                       p[0] = kfence_obj;
> >> +                       goto out;
> >> +               }
> >> +               size--;
> >> +       }
> >> +
> >>         if (s->cpu_sheaves)
> >>                 i = alloc_from_pcs_bulk(s, size, p);
> >>
> >> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
> >>                         if (i > 0)
> >>                                 __kmem_cache_free_bulk(s, i, p);
> >> +                       if (kfence_obj)
> >> +                               __kfence_free(kfence_obj);
> >>                         return 0;
> >>                 }
> >>         }
> >>
> >> +       if (unlikely(kfence_obj)) {
> >
> > Might be nice to briefly write a comment here in code as well instead
> > of having to dig through the commit logs.
>
> ... is the one above enough? The commit log doesn't have much more on this
> aspect. Or what would you add?

Good enough - thanks.

> > The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)
>
> They do.

Great.

Thanks,
-- Marco


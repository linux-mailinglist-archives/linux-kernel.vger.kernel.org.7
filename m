Return-Path: <linux-kernel+bounces-840690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53328BB4FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097A03C7F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9E283146;
	Thu,  2 Oct 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqLfrF6V"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A32765D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432799; cv=none; b=ufaYHUqlmMVrkcmIUgEu7TAIG2Hyof+Ux2whtql2H92XK7VMatGVwyo3q4ZoNomrRc4VskCtbp5Vsa3Qz2XCh46WhoMDYj+L13k5TYCzZgq0sYzxlk6O4WLDJBik8vT4PEKlM0pH6P/YYPeRNSZYNQaf449Lmd5tSmqoejX2/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432799; c=relaxed/simple;
	bh=RHvbbQ9Fiz9JD9KEPx6v6LKvaEo1oDm59KFC40yb4Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4SVxqLvQjFX58yRWRocOkTRSPneYXvzcxr5VxmFw2lv1NFpd6hBjo+zVKSvVfYefea3D4bt+tmuaSqdra4gwPzW6x+lAb28l6eCGXXkDdb8lelBz0E+To4w2PHrLaN/XUxr+T63oRQX0vz2GBOJxIL8awuFIFt0XSoylvdfiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqLfrF6V; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e5bcf38dfso17701415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759432795; x=1760037595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIPuw5PXf537cGjHuuOBAnE/qD8vkHzGaf9rib+Lq+I=;
        b=eqLfrF6VPAKKfcFXHnJx0sKunJ02+PNq09uaTyl+po8t5uHw3unKZ/IyVRUEB9Ee/r
         Jtge8AdK99u0mq4t46Wn2cg6Ni+LNl1JuFrOV/5bp4TyJjbK/OYmxAUvw2NjRjdmffIW
         WnxfubpOkjyQuQpc0YlXsuK4KMC958vEGjzK0jHp00bagjeJX5eJJ3FyU8gbxiiarbwV
         Wbc4bL0d3lV7pLsJrEyiK2l23ZppOYM+qHwS+rnSvYY5WPuXFxZLKhH3wVQFDspgjH1M
         b0KK05+02EGTMxqvqYcIHIvI/+3jK6L7+X818VP5/UMfTX3olqk/IuC6LGjWMZgwoTQq
         a5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432795; x=1760037595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIPuw5PXf537cGjHuuOBAnE/qD8vkHzGaf9rib+Lq+I=;
        b=nDrZgibPom1EsFhqwH1FZ8dvzEhKMmq026z4ZVZtkEedTMa3dqDd51MkYHMzraVa0p
         yF72HAEcMSQ2nlz+Wji7murnnv+ZV47xfCkp4j7UHMKlDSBRRH/3iSagf9ebANsaNxWr
         fU3UN2AuMDEGuVkZzp7Cw1r4Bap2uIEn/5VZYGSE9lzeRPKflYWdleD5s74j80oKmDZZ
         agFm9bLVZ3hte+AfUJeFD29M5c51BvfAgzlTsoAl94hvx7/QwvWjt3uE1ynjvZvICxcF
         ksLK1dQlUy/u52+0ts23ZvORDlCce+9X0OblVYaBA9bTpXZIgIl0TTCIuJ0JymHLZQ4c
         /Skw==
X-Forwarded-Encrypted: i=1; AJvYcCWnCyLCdk5I1/cTQfgt3uge537YCcD9JsHFU24id8EJPZ3rbzKcSACPgEAUnFlFpXgbhhQByGt8jglujZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMy9Xm7R1Vrz1ItwiRB44fmdBAarePM7IQUvfn1gNZOc3YODh
	cGyV1yfLrbRjui87rV1V80j76w+gdQVCB7IFt0OsbyNPTa9M2RayCWJuBoauiqB6Tar8mp9kCjR
	m+kPqvoy/vTZZkw==
X-Google-Smtp-Source: AGHT+IGA0hBUYWEjVHKMSca9g2yFQ2NDxY+JABJUK7tlQgJ95B/8XPbRxR1nSAIBjkYBvuTBmTOZLYFHa4lk8A==
X-Received: from wmz11.prod.google.com ([2002:a05:600c:6b6b:b0:46e:5611:ee71])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6092:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46e70c48dc8mr4571415e9.1.1759432795577;
 Thu, 02 Oct 2025 12:19:55 -0700 (PDT)
Date: Thu, 02 Oct 2025 19:19:54 +0000
In-Reply-To: <6a97031d-33d4-4710-ab5a-7d8947936038@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <00e7ff5e-fe6c-4edc-9bf8-2352321f74dc@intel.com> <DD7SQLDVNSRL.XJ8PUCH6GYR1@google.com>
 <6a97031d-33d4-4710-ab5a-7d8947936038@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD82VFJLMSVX.27GMXVWD0A7UX@google.com>
Subject: Re: [PATCH 00/21] mm: ASI direct map management
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 2, 2025 at 5:01 PM UTC, Dave Hansen wrote:
> On 10/2/25 04:23, Brendan Jackman wrote:
> ...
>> [Well, I'm assuming there that we include the actual security flushes in
>> series 2, maybe that would be more like "2b"...]
>> 
>> To get to the more interesting cases where it's faster than the current
>> default, I think is not that far away for KVM usecases. I think the
>> branch I posted in my [Discuss] thread[0] gets competitive with existing
>> KVM usecases well before it devolves into the really hacky prototype
>> stuff.
>> 
>> To get to the actual goal, where ASI can become the global default (i.e.
>> it's still fast when you sandbox native tasks as well as KVM guests), is
>> further since we need to figure out the details on something like what I
>> called the "ephmap" in [0].
>> 
>> There are competing tensions here - we would prefer not to merge code
>> that "doesn't do anything", but on the other hand I don't think anyone
>> wants to find themselves receiving [PATCH v34 19/40] next July... so
>> I've tried to strike a balance here. Something like:
>> 
>> 1. Develop a consensus that "we probably want ASI and it's worth trying"
>> 
>> 2. Start working towards it in-tree, by breaking it down into smaller
>>    chunks.
>
> Just to be clear: we don't merge code that doesn't do anything
> functional. The bar for inclusion is that it has to do something
> practical and useful for end users. It can't be purely infrastructure or
> preparatory.
>
> Protection keys is a good example. It was a big, gnarly series that
> could be roughly divided into two pieces: one that did all the page
> table gunk, and all the new ABI bits around exposing pkeys to apps. But
> we found a way to do all the page table gunk with no new ABI and that
> also gave security folks something they wanted: execute_only_pkey().
>
> So we merged all the page table and internal gunk first, and then the
> new ABI a release or two later.
>
> But the important part was that it had _some_ functionality from day one
> when it was merged. It wasn't purely infrastructure.

OK thanks, after our IRC chat I understand this now. So in the case of
pkeys I guess the internal gunk didn't "do anything" per se but it was a
clear improvement in the code in its own right. So I'll look for a way
to split out the preparatory stuff to be more like that. And then I'll
try to get a single patchset that goes from "no ASI" to "ASI that does
_something_ useful". I think it's inevitable that this will still be
rather on the large side but I'll do my best.

>> Do you think it would help if I started also maintaining an asi-next
>> branch with the next few things all queued up and benchmarked, so we can
>> get a look at the "goal state" while also keeping an eye on the here and
>> now? Or do you have other suggestions for the strategy here?
>
> Yes, I think that would be useful.
>
> For instance, imagine you'd had that series sitting around:
> 6.16-asi-next. Then, all of a sudden you see the vmscape series[1] show
> up. Ideally, you'd take your 6.16-asi-next branch and show us how much
> simpler and faster it is to mitigate vmscape with ASI instead of the
> IBPB silliness that we ended up with.
>
> Basically, use your asi-next branch to bludgeon us each time we _should_
> have been using it.
>
> It's also not too late. You could still go back and do that analysis for
> vmscape. It's fresh enough in our minds to matter.
>
> 1.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=223ba8ee0a3986718c874b66ed24e7f87f6b8124

And yep, I'll take a look at this too. Thanks very much for taking a
look and for all of the valuable pointers.


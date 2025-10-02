Return-Path: <linux-kernel+bounces-840169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC839BB3BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E63A17624D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2B2609FD;
	Thu,  2 Oct 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlvoqjo/"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669E2FE577
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404208; cv=none; b=p7C5Grl6QDUau+ciGKYUaTrzWBYjsdJkr3A9MV4RjNfXNGa7FokHiZrRn96JTcS+kMQXjND8CCWLsqU+T6EkUF7E9iKesqcp3/3PHihhi7bOzKNNxvNX9oi8QTwiKE9ZPb+acPxg9pF7j2hA+aIbyZHaNZhHsX8UyYJe1OF0Tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404208; c=relaxed/simple;
	bh=JZRh8rtz5ZcixnzvbW/Ri1qluW3WtKEts7xB2OFkdys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVJr10eAOOp+6E9M1APNd7fLICZV+QPkpClFl6G59+vFNzFopgIJQx6SV/mAQGv0AKsD0qVl8xb7hhU4SnOPrTPGP5tcmOpYQn6M/x6AgkZHbUAiBoI62VJe1Qk0W/AOhMpHj3QHl0g2aRwC0pVkEOvX92GQX+54CbcOi874r/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlvoqjo/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3efa77de998so711977f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404205; x=1760009005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=StwXEML9DUJ/mYJQmtqU+M+tGtJwCRVezsEJIIsHWHo=;
        b=rlvoqjo/RriQfPa3mCkaBu3cBEU02el9076pmFYZojxGj7qIg9Tp9465Lupepx6Sa9
         UJqLUXyYQqEGr9NzrZ/2EANbylBPNhWWoEueQRhhr7+Oc9sAsfBxGuUKq1sf/zwPd3O0
         U/OPF+E3vVG+i1hUAb8EMwrLv1DT0jFoLr7JgP392+YzpNHq7ejUqwCbIttHKXG4fhpo
         vkCMJNQOm79N3BuuBgdXN1FiuY/mBXZQZHhufGKYrOpBKG+1dwJaYeKL3TeyghcrpsLt
         7FbD8k0f2O4qtFALjol0czNVn3qwBDGyNwUqmjwb5rZFAG6hiByGvn0XOj4HhJ+u8YU5
         94ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404205; x=1760009005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StwXEML9DUJ/mYJQmtqU+M+tGtJwCRVezsEJIIsHWHo=;
        b=UmaYv//dmaPLpc6QESGqoLGzishvEifpYEgH552Bg3r1EURkEj17FyyXjJZtQQ6QbG
         oADJ+5e2za7bwFTG3XLGvnFgP/AuBVybrVwHTagWDtkwPTDYEmCWxEv6RX6Ha/egDo2C
         nvXEGZAQoMmOeh5IUoNZ0CVdBx9vqaIpZ3w3E3yUQImHKhC/u3bUuYdBGTTyJGwridv9
         EgLnsV9IBgrJ1A1yGlys82uS0H2J0EoKZUNOyi6d9XtCjWYclEslUcDgtUKEStI+x9h9
         PpNOclsKpVdPuGXrNHDcB2IViUX2gUMRqjLFMkITW+D5BwBEzgTRCZ0/ZWzp/UYLZ+zY
         x+zA==
X-Forwarded-Encrypted: i=1; AJvYcCVu9pSsaXx6Tw5oiwzL6jyuDOfyDl6x5cBRNj3I63HtLrnKXA2Xz3CrW9RNGrt0SQtn1KGYFKnhvJh3gt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxbEhTj6KU2dONB9B9KEpLQOrWGtONP0XiVmoLvdMicQDB9POX
	XuMYxrAjWCO0cPT1PMrsutxV3uMW7kj+HMP2MpPCe51G0tKweWaTGcc11ZlBsnbgAC+YBxHJT6s
	we66/OwPqAWr8Bg==
X-Google-Smtp-Source: AGHT+IGWDUkaG6p5pIygtGCDP/CQv3zB4el8v6qelCaY1TuvOduqSN++5HdFowlfxZPTYWDWDdFsU0TbBAaraA==
X-Received: from wrnk2.prod.google.com ([2002:adf:e8c2:0:b0:3ee:fb15:5340])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f55:0:b0:424:2275:63c2 with SMTP id ffacd0b85a97d-42557816e2fmr4729772f8f.33.1759404205042;
 Thu, 02 Oct 2025 04:23:25 -0700 (PDT)
Date: Thu, 02 Oct 2025 11:23:24 +0000
In-Reply-To: <00e7ff5e-fe6c-4edc-9bf8-2352321f74dc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com> <00e7ff5e-fe6c-4edc-9bf8-2352321f74dc@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7SQLDVNSRL.XJ8PUCH6GYR1@google.com>
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

On Wed Oct 1, 2025 at 8:59 PM UTC, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> Why is this the scope of the first series? The objective here is to
>> reach a MVP of ASI that people can actually run, as soon as possible.
>
> I had to ask ChatGPT what you meant by MVP. Minimum Viable Product?

Yeah exactly, sorry I am leaking corporate jargon.

> So this series just creates a new address space and then ensures that
> sensitive data is not mapped there? To me, that's a proof-of-concept,
> not a bit of valuable functionality that can be merged upstream.
>
> I'm curious how far the first bit of functionality that would be useful
> to end users is from the end of this series.

I think this series is about half way there. With 2 main series:

1. The bit to get the pagetables set up (this series)

2. The bit to switch in and out of the address space

We already have something that delivers security value. It would only
perform well for a certain set of usecases, but there are users for whom
its still a win - it's already strictly cheaper than IBPB-on-VMExit.

[Well, I'm assuming there that we include the actual security flushes in
series 2, maybe that would be more like "2b"...]

To get to the more interesting cases where it's faster than the current
default, I think is not that far away for KVM usecases. I think the
branch I posted in my [Discuss] thread[0] gets competitive with existing
KVM usecases well before it devolves into the really hacky prototype
stuff.

To get to the actual goal, where ASI can become the global default (i.e.
it's still fast when you sandbox native tasks as well as KVM guests), is
further since we need to figure out the details on something like what I
called the "ephmap" in [0].

There are competing tensions here - we would prefer not to merge code
that "doesn't do anything", but on the other hand I don't think anyone
wants to find themselves receiving [PATCH v34 19/40] next July... so
I've tried to strike a balance here. Something like:

1. Develop a consensus that "we probably want ASI and it's worth trying"

2. Start working towards it in-tree, by breaking it down into smaller
   chunks.

Do you think it would help if I started also maintaining an asi-next
branch with the next few things all queued up and benchmarked, so we can
get a look at the "goal state" while also keeping an eye on the here and
now? Or do you have other suggestions for the strategy here?

[0] https://lore.kernel.org/all/20250812173109.295750-1-jackmanb@google.com/


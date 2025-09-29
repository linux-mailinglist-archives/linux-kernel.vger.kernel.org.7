Return-Path: <linux-kernel+bounces-836579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4ACBAA108
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BBD3C7C67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B43093A6;
	Mon, 29 Sep 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/vLG15J"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6A3090EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164880; cv=none; b=o1tYuRLS2Zhc46iuCwFqOvNWIDM9LL3BlpzB5O4PEfHXW90qtCtuScvdnb5pGlcpVoAHyesai7zXDRWwiMGHIfWlvoZIzQIUdrq83FgpNAYpydp72hPP8CaeKZhhAiWPSKEWE4nU36qL5B6geXZ9kmOitwa0l8fdkl6rtzw4s3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164880; c=relaxed/simple;
	bh=C36iw42WNzHBob34Sc7O1uFATf6AUuCubPOgYq1tNx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFi9htt+OR7v8TqH/e7WFzCvOn9XB+hLQZXYumRwLOQLsvRjDZhboxqdA36H+sw0/uRLtJekHvqdcqkdqZQwtbBvqdmFIOVe8u1JpoBoGspK8pEXnPMFHV20KCDI5apugUmplXWl3DmMVHiEei7qVW7mAl2SJhquHQr++5d3/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/vLG15J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so4347633a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759164877; x=1759769677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpOhXKI0b7JOoE1riy2qpQ88ygLrxOz+JUVQPC6uV2A=;
        b=H/vLG15JAn2ScrJgYSaIzd/evMushkFmre2HR0APpiLJUe0zPKRDpf9HS0ZUAyyN+K
         8d/bEiKA70NZUO6ttpq3dM8nvEZ2m8zNBJZZ6oGBeP5bV75CSoPoij3ae0/D1iR34iHJ
         DrgVJdT6Q1D57RW7MO4S9oTH1nfmoa/6nHDYwag29/F0ONfFJ7x7Yop+qwKf16/TRday
         bxdh3bHMbpMB0A6MK3V0KfJZSRdxcF8HqAXemKFSArwKtcg9nlvBLOiD7ErLGtG9socX
         uWdbUN7hbNrO/0AzyakQjHJPYhWJLmxxShxjg5qQMAPpFcp7cJenZVFHcSUUvOC9hQz9
         qy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164877; x=1759769677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpOhXKI0b7JOoE1riy2qpQ88ygLrxOz+JUVQPC6uV2A=;
        b=TqkqybWwtQn3nb/r6hJdQ6yqy4IB6g+36LVg3GkosxFVYzOfOJrQdE0hogFECTRBXl
         R/DaQ6+M0NV7kY63GkTd5tlK/efK0R/DnnOtFhE5f3Bi1WoV7buIaQDbBWDX0BVgztSG
         Yxj1QQeQF2hzxyLOe3M4k19lazCIqYujklTT+/qktnFQO11zxxJ5RMKdWJ/lj772lUbk
         781HLx5kyru78gouTjH15JcHsg/zpNkSTntE9x9UGT7723DQTkeBtP/LR6gp2UL2EA0K
         A9CC4A8c0f9kAMsQIppxl561hpiCDSnS6kvPXxcyjIIduC2NLdVr+Rt1Dq9Qm/VvuY3p
         RinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/m7Js4VwX7Gb5d6w0pnEupmvYm7WV356+ww5hPyfa2z9bwsOV/J2GyfkVQNr8kIL748Fy3PUK88sFLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDcCiE9+GBvzcjmo82gv6CstmAu0fTy0gTEuj1IXb45/2s1dL
	2EX/FKOux0bY107tbpaEzgu3KIneV4O3w+t9VcUtWfKg76XcDxUwGsVir+DGk0HBH/jFMjJuVi8
	fEAfXgw==
X-Google-Smtp-Source: AGHT+IFKXQAGYWhcY9Nrbucmct+SZFNk35FaiXyhafONfT+/fbYaXvR+65vzkfSOY9ZmV2dPHjVs3zVyZ0U=
X-Received: from pjeq9.prod.google.com ([2002:a17:90a:649:b0:329:ec3d:72ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1644:b0:330:6d5e:f17e
 with SMTP id 98e67ed59e1d1-3342a2b94c2mr19140153a91.24.1759164876887; Mon, 29
 Sep 2025 09:54:36 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:54:35 -0700
In-Reply-To: <diqz7bxh386h.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com> <diqz7bxh386h.fsf@google.com>
Message-ID: <aNq5y1BSWsjculYM@google.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, roypat@amazon.co.uk, 
	Nikita Kalyazin <kalyazin@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 29, 2025, Ackerley Tng wrote:
> Fuad Tabba <tabba@google.com> writes:
> 
> > Hi Sean,
> >
> > On Fri, 26 Sept 2025 at 17:31, Sean Christopherson <seanjc@google.com> wrote:
> >>
> >> Add a guest_memfd flag to allow userspace to state that the underlying
> >> memory should be configured to be shared by default, and reject user page
> >> faults if the guest_memfd instance's memory isn't shared by default.
> >> Because KVM doesn't yet support in-place private<=>shared conversions, all
> >> guest_memfd memory effectively follows the default state.
> >>
> >> Alternatively, KVM could deduce the default state based on MMAP, which for
> >> all intents and purposes is what KVM currently does.  However, implicitly
> >> deriving the default state based on MMAP will result in a messy ABI when
> >> support for in-place conversions is added.
> >>
> >> For x86 CoCo VMs, which don't yet support MMAP, memory is currently private
> >> by default (otherwise the memory would be unusable).  If MMAP implies
> >> memory is shared by default, then the default state for CoCo VMs will vary
> >> based on MMAP, and from userspace's perspective, will change when in-place
> >> conversion support is added.  I.e. to maintain guest<=>host ABI, userspace
> >> would need to immediately convert all memory from shared=>private, which
> >> is both ugly and inefficient.  The inefficiency could be avoided by adding
> >> a flag to state that memory is _private_ by default, irrespective of MMAP,
> >> but that would lead to an equally messy and hard to document ABI.
> >>
> >> Bite the bullet and immediately add a flag to control the default state so
> >> that the effective behavior is explicit and straightforward.
> >>
> 
> I like having this flag, but didn't propose this because I thought folks
> depending on the default being shared (Patrick/Nikita) might have their
> usage broken.

mmap() support hasn't landed upstream, so as far as the upstream kernel is
concerned, there is no userspace to break.  Which is exactly why I want to land
this (or something like it) in 6.18, before GUEST_MEMFD_FLAG_MMAP is officially
released.

> >> Fixes: 3d3a04fad25a ("KVM: Allow and advertise support for host mmap() on guest_memfd files")
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Fuad Tabba <tabba@google.com>
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> ---
> >>  Documentation/virt/kvm/api.rst                 | 10 ++++++++--
> >>  include/uapi/linux/kvm.h                       |  3 ++-
> >>  tools/testing/selftests/kvm/guest_memfd_test.c |  5 +++--
> >>  virt/kvm/guest_memfd.c                         |  6 +++++-
> >>  4 files changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> >> index c17a87a0a5ac..4dfe156bbe3c 100644
> >> --- a/Documentation/virt/kvm/api.rst
> >> +++ b/Documentation/virt/kvm/api.rst
> >> @@ -6415,8 +6415,14 @@ guest_memfd range is not allowed (any number of memory regions can be bound to
> >>  a single guest_memfd file, but the bound ranges must not overlap).
> >>
> >>  When the capability KVM_CAP_GUEST_MEMFD_MMAP is supported, the 'flags' field
> >> -supports GUEST_MEMFD_FLAG_MMAP.  Setting this flag on guest_memfd creation
> >> -enables mmap() and faulting of guest_memfd memory to host userspace.
> >> +supports GUEST_MEMFD_FLAG_MMAP and  GUEST_MEMFD_FLAG_DEFAULT_SHARED.  Setting
> >
> > There's an extra space between `and` and `GUEST_MEMFD_FLAG_DEFAULT_SHARED`.
> >
> 
> +1 on this. Also, would you consider putting the concept of "at creation
> time" or "at initialization time" into the name of the flag?

Yah, GUEST_MEMFD_FLAG_INIT_SHARED?

> "Default" could be interpreted as "whenever a folio is allocated for
> this guest_memfd", the memory the folio represents is by default
> shared.
> 
> What we want to represent is that when the guest_memfd is created,
> memory at all indices are initialized as shared.
> 
> Looking a bit further, when conversion is supported, if this flag is not
> specified, then all the indices are initialized as private, right?

Correct, which is the current (pre-6.18) behavior.

> >> +the MMAP flag on guest_memfd creation enables mmap() and faulting of guest_memfd
> >> +memory to host userspace (so long as the memory is currently shared).  Setting
> >> +DEFAULT_SHARED makes all guest_memfd memory shared by default (versus private
> >> +by default).  Note!  Because KVM doesn't yet support in-place private<=>shared
> >> +conversions, DEFAULT_SHARED must be specified in order to fault memory into
> >> +userspace page tables.  This limitation will go away when in-place conversions
> >> +are supported.
> >
> > I think that a more accurate (and future proof) description of the
> > mmap flag could be something along the lines of:
> >
> 
> +1 on these suggestions, I agree that making the concepts of SHARED vs
> MMAP orthogonal from the start is more future proof.
> 
> > + Setting GUEST_MEMFD_FLAG_MMAP enables using mmap() on the file descriptor.
> >
> > + Setting GUEST_MEMFD_FLAG_DEFAULT_SHARED makes all memory in the file shared
> > + by default
> 
> See above, I'd prefer clarifying this as "at initialization time" or
> something similar.

Roger that.

> > At least for now, GUEST_MEMFD_FLAG_DEFAULT_SHARED and GUEST_MEMFD_FLAG_MMAP
> > don't make sense without each other. Is it worth checking for that, at
> > least until we have in-place conversion? Having only
> > GUEST_MEMFD_FLAG_DEFAULT_SHARED set, but GUEST_MEMFD_FLAG_MMAP, isn't a
> > useful combination.

Heh, that's exactly how I coded things up to start:

        /*
         * TODO: Drop the restriction that memory must be shared by default
         *       once in-place conversions are supported.
         */
        if (flags & GUEST_MEMFD_FLAG_MMAP &&
            !(flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED))
                return -EINVAL;

but if we go that route, then dropping the restriction would result in an ABI
change for non-CoCo VMs.  The odds of such an ABI changes breaking userspace are
basically zero, but I couldn't think of any reason to risk it; userspace would
need to specify MMAP+SHARED either way.

And on the flip side, not enforcing the flags at the time of creation allows us
to test that user page faults to private memory are rejected.  It's not a ton of
meaningful coverage, but it's not nothing either.  And from a code perspective,
the diffs when in-place conversions are added are quite nice, as the concepts
don't change (user faults to private memory are disallowed), only the mechanics
change, i.e. the diffs highlight what all needs to happen to support conversions
without the extra noise of a change in overall semantics.


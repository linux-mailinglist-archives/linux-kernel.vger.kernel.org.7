Return-Path: <linux-kernel+bounces-837340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD42BAC133
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D421B1888EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A724677D;
	Tue, 30 Sep 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upx0hhSy"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23024501B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221375; cv=none; b=nxJkDGIZL0ep+Dt8aZEwPMaR04J+BZ7FCNV4VIO2ONlrr9RlhCj85K4X5mtVQ38eMhP2GRIzEHmPjwb2OgEXuat/58XUCFOGfeapf3+IfjrNO84P/2ZSSyBMH7uOoAGwIIRp7J75mQfuJlJZ6pjKoA2ut/WOUXcYTlv8WjuVqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221375; c=relaxed/simple;
	bh=3ApQz3zWEqQtKCd46uqg3P7F105aAnSBnojZ09IUAOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jR6CCQXa5kybh+1hO7BR8NZMDeKvRzi4NtLNMwh2hQI0ROFg0H2PbXJ4a3YkHECbhSkDoqfOoN4LzRfHvROOEF5JdwHRGpaUi7rU14rnmwiBAiEdDa6pkgiYqQSl599Ce4xly0FjcTiniVXdpPXANTkFORdxIp6xBvydyUCqh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upx0hhSy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78102ba5966so5314587b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759221373; x=1759826173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGEcQ039PHX8Z6bbWR5CExl7OEuHya7NAHoYULkizA0=;
        b=upx0hhSytbsM4hmsVLNMYbCUtVVxPaMUsFc2vtHkQb/xQvfCfsGfud9XbGJ0Acq2VQ
         jOtekl+ikDeeAqJI+XcEVg4fI4DLSZ/od2uatDfR1ejQMcHTslRYJD9d2+UOTVIvDvu5
         gdQzNfiZgsxPdOTbsatTwB71fXongh0LA53HNBNclzqbhVnYzy7Fuy0E5wGKIzT8pvao
         K9lITB/d06WzhXWq3Xu24c5aS5gEehKOByiYcDy3QJHiKEEywxuJ7MV+NsLsAuRQcXgA
         UdwFNXGmaZ8QaQalu0qBLpt85+ZTqOmDcxsM9VYCOLtAD5bsVXc5nTjP0BO5RMGIZZ82
         Qjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221373; x=1759826173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGEcQ039PHX8Z6bbWR5CExl7OEuHya7NAHoYULkizA0=;
        b=YkSgi5HqKkYZ5ggUIfXiHKKFBWkeBkRrKjqBJSDqITUh5iij18c98f8zpp2fJEAEIl
         gXLuy0G8Ky09EobQ1i0xj/o+kbHoR528eF/XukqxL64rNODuT6cqtdzfLQyZ0mZvPDN9
         nM0g76sXzdqQvYzxlOoxl8gUa9uDwSsm726MqKtAmuRHagscXMOrSlvuUV7E0SRywStc
         zcQPpt/2RoWmzDVI8E72VimFY59MZ0CPqdBhyaB9B7fDarYg2ILzu/8lxoBvoNylOhSK
         3p7PDIKgeH1J24wApk84h1MXaOlxCCft1c2ZR7BzM2cgOA+JvPH+2ubCtkWmZJNK2zyp
         LTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrmF9Jq9H5IJp/QILdgj7vevuA1lf82+tBv28eEJIETE6lLkL8s6P5fm5mQXxOI15GLhaAIDlDJl2NbDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oNzW4rlam5mBu1RsR/665BoBmaC/lyZZB/y4/Gh7Agp7/qvi
	m8vkSoNYE0Yq58GvnQ73YKSPeA/y6sEmj+r9bfVGKvysyLN+fAjrIyyIyvaoOtHX1mXD5IgtzaR
	kGH9oEQfPV+sIIw5MTrpV9YgcAQ==
X-Google-Smtp-Source: AGHT+IEiNQr5CnkmLDEZS68hRK4QsiHIiyJxnvGvd2vfUrjjCIDnWPhr2xJhSzzVgM6uSvZRJyLQq6SFb4/fJ5Rq1Q==
X-Received: from pfbhc7.prod.google.com ([2002:a05:6a00:6507:b0:76b:3822:35ea])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1896:b0:77f:4b9b:8c34 with SMTP id d2e1a72fcca58-780fceeb3b7mr21693306b3a.31.1759221372983;
 Tue, 30 Sep 2025 01:36:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:36:11 +0000
In-Reply-To: <aNshILzpjAS-bUL5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
 <aNq6Hz8U0BtjlgQn@google.com> <aNshILzpjAS-bUL5@google.com>
Message-ID: <diqz4isk1gn8.fsf@google.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Patrick Roy <patrick.roy@linux.dev>, 
	Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikita Kalyazin <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Sep 29, 2025, Sean Christopherson wrote:
>> On Mon, Sep 29, 2025, Ackerley Tng wrote:
>> > David Hildenbrand <david@redhat.com> writes:
>> > 
>> > >                           GUEST_MEMFD_FLAG_DEFAULT_SHARED;
>> > >>>>
>> > >>>> At least for now, GUEST_MEMFD_FLAG_DEFAULT_SHARED and
>> > >>>> GUEST_MEMFD_FLAG_MMAP don't make sense without each other. Is it worth
>> > >>>> checking for that, at least until we have in-place conversion? Having
>> > >>>> only GUEST_MEMFD_FLAG_DEFAULT_SHARED set, but GUEST_MEMFD_FLAG_MMAP,
>> > >>>> isn't a useful combination.
>> > >>>>
>> > >>>
>> > >>> I think it's okay to have the two flags be orthogonal from the start.
>> > >> 
>> > >> I think I dimly remember someone at one of the guest_memfd syncs
>> > >> bringing up a usecase for having a VMA even if all memory is private,
>> > >> not for faulting anything in, but to do madvise or something? Maybe it
>> > >> was the NUMA stuff? (+Shivank)
>> > >
>> > > Yes, that should be it. But we're never faulting in these pages, we only 
>> > > need the VMA (for the time being, until there is the in-place conversion).
>> > >
>> > 
>> > Yup, Sean's patch disables faulting if GUEST_MEMFD_FLAG_DEFAULT_SHARED
>> > is not set, but mmap() is always enabled so madvise() still works.
>> 
>> Hah!  I totally intended that :-D
>> 
>> > Requiring GUEST_MEMFD_FLAG_DEFAULT_SHARED to be set together with
>> > GUEST_MEMFD_FLAG_MMAP would still allow madvise() to work since
>> > GUEST_MEMFD_FLAG_DEFAULT_SHARED only gates faulting.
>> > 
>> > To clarify, I'm still for making GUEST_MEMFD_FLAG_DEFAULT_SHARED
>> > orthogonal to GUEST_MEMFD_FLAG_MMAP with no additional checks on top of
>> > whatever's in this patch. :)
>
> Oh!  This got me looking at kvm_arch_supports_gmem_mmap() and thus
> KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
>
>  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS so
>     that we don't need to add a capability every time a new flag comes along,
>     and so that userspace can gather all flags in a single ioctl.  If gmem ever
>     supports more than 32 flags, we'll need KVM_CAP_GUEST_MEMFD_FLAGS2, but
>     that's a non-issue relatively speaking.
>

This is a good idea. In my internal WIP series I have 3 flags and 4
CAPs, lol. Some of those CAPs are not for new flags, though.

Would like to check your rationale for future reference: how about
generalizing beyong flags and having KVM_CAP_GUEST_MEMFD_CAPS which
returns 32 bits, one bit for every guest_memfd-related (not necessarily
flags-related) cap?

>  2. We should allow mmap() for x86 CoCo VMs right away.  As evidenced by this
>     series, mmap() on private memory is totally fine.  It's not useful until the
>     NUMA and/or in-place conversion support comes along, but's not dangerous in
>     any way.  The actual restriction is on initializing memory to be shared,

The actual restriction is that private memory must not be mapped to host
userspace, so it's not really about initializing, though before
conversion, initialization state is the only state.

With GUEST_MEMFD_FLAG_INIT_SHARED, the entire guest_memfd is shared and
mappable; without GUEST_MEMFD_FLAG_INIT_SHARED the entire guest_memfd is
private and not mappable (gated in kvm_gmem_fault_user_mapping()).

So yes, I agree that CoCo VMs should be allowed mmap() but not
GUEST_MEMFD_FLAG_INIT_SHARED, since GUEST_MEMFD_FLAG_INIT_SHARED makes
the entire guest_memfd take the shared state for the lifetime of
guest_memfd.

This is turning out to be a much nicer cleanup :)

>     because allowing memory to be shared from gmem's perspective while it's
>     private from the VM's perspective would be all kinds of broken.
>
>
> E.g. with a s/kvm_arch_supports_gmem_mmap/kvm_arch_supports_gmem_init_shared:
>
> 	case KVM_CAP_GUEST_MEMFD_FLAGS:
> 		if (!kvm || kvm_arch_supports_init_shared(kvm))
> 			return GUEST_MEMFD_FLAG_MMAP |
> 			       GUEST_MEMFD_FLAG_INIT_SHARED;
>
> 		return GUEST_MEMFD_FLAG_MMAP;
>

You might end up with this while actually coding v2 up, but how about

	case KVM_CAP_GUEST_MEMFD_FLAGS: {
        	int flag_caps = GUEST_MEMFD_FLAG_MMAP;
                
		if (!kvm || kvm_arch_supports_init_shared(kvm))
			flag_caps |= GUEST_MEMFD_FLAG_INIT_SHARED;

		return flag_caps;
	}

Then all the new non-optional CAPs can be or-ed onto flag_caps from the
start.
        
> #2 is also a good reason to add INIT_SHARED straightaway.  Without INIT_SHARED,
> we'd have to INIT_PRIVATE to make the NUMA support useful for x86 CoCo VMs, i.e.
> it's not just in-place conversion that's affected, IIUC.
>
> I'll add this in v2.


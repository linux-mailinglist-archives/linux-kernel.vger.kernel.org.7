Return-Path: <linux-kernel+bounces-890435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B9C400B8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596653A4E55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBF2D1319;
	Fri,  7 Nov 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9T6lKNK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn9o+0xe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1982C21E4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521003; cv=none; b=QRIQ5zoYNMZonCDW14i3XtevHHWivpcl+tfIqD8ofgQ3Q47hsMU1ELpMS8eoyM/1E5zCnvACubHz6CqXvcvgwqwK0jku86Vou5l0ni1uKpv4NMy0KPkgqzKuJqrAtShMml3fPTfDbkgyaKQFj4Uw+0Bpx4+IBkelIxmHj6kLw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521003; c=relaxed/simple;
	bh=B4ngeTm/7x3Vu9seNE749EttsB8vxcdtADXSML3VlRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/kn7oVXz2Fr5uu9rUeA/gQf/bjJL13XsRYPBk4y60sG2weiceZuB8QbhGqEo/7gCKMkL/rRWPHwxpYLFtbkFU/uMxqio7NYODVd0qjIVlmtd4GxKUJ2xJpZyvYjBQXKFW72cZyrGXZL7K+6rnGBMECj3ddouFxi41LwI3zGkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9T6lKNK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn9o+0xe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762520999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrgsqdcysUxzxTMpusKBNfb3r72+Eorc3mX1btB4ovM=;
	b=f9T6lKNKnDfm6ZhM+nHg13BvtJZU8W6BDuvmF9oifyuCyi1oxNJ4ynE5ebnocmUu7mq4bC
	iUCC+A78uaho5RebrKytkLSywCY4Lz5EslNzc5hyPW5K5uRQtG8KNyamYWgKTWqGwaUcg1
	PiaenXS+/ERBnE3eeQ8WVu5QW+L3r8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-CW7enYDXPAi_kO5xTo8OJA-1; Fri, 07 Nov 2025 08:09:58 -0500
X-MC-Unique: CW7enYDXPAi_kO5xTo8OJA-1
X-Mimecast-MFC-AGG-ID: CW7enYDXPAi_kO5xTo8OJA_1762520996
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477594aad41so4286945e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762520996; x=1763125796; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrgsqdcysUxzxTMpusKBNfb3r72+Eorc3mX1btB4ovM=;
        b=bn9o+0xe2g6epc8UPu20jtmuRa9DvD6Y3pm0LeY14AqNgMH0sGJdzEdjjYEB4viTzJ
         iimQyDg1+JFXv2jc0f3eALiFG7Y0IAQLceTtDdAY5whrqRQSmQAO6ISxqNJQxrEWSGZf
         utBWwJyFDNS7aADZC9beVe9G7/7Q99JJ2ZkptWMXujrCtgDsI8pLCVp7Q5C7LZcao3Yu
         4Nu8rUT4L49opsJOZaKhY+K2qkIlv32w6Z+grb+LQ/8iL+t2buQanXB5YCN//f8Zy8lI
         SWScfJRKiQ32lTUKz4WpyAbtqPLsZtpgQtw9uyGMfu/x9+m4r7DIfYqeIlcJHTw1fXps
         z6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520996; x=1763125796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrgsqdcysUxzxTMpusKBNfb3r72+Eorc3mX1btB4ovM=;
        b=gP6XuZlIW4wdTJ3w8/68gzDy6ubhBg0mdof6oDRH+XZEDEYNJE7cz8QD7absLSXbSv
         LImONRJJ9XFca36g3PWYWhIUR2SEUcP6Poud8YBRT/mmRKt+dTqwLteQgddKwmVd+lG9
         PdFAXrEFvYaLWZ66O2WlWNAUnk22FF/vPQeEepwAmBKp61858MkTQ+xBDv5xgbLgp9ai
         nr0r+EpdwjYsxpBEvTMqxSie2yG5+aLxNVSX3Bz0/nTPWaEm6aWX3S89AqhpU1tOe59e
         8O6mTiw4fptBE9pVGkAUGbaNB4Py8u7FJwtfKj38gii9BuUx95tBkeWWc1RexrvtSyt8
         Yqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUApBFOkOm8NdaP9aPsZtUvcf3lE0eRfhPEhcFaJ3q74nji2sOig2N6tVxdOkV0As4NCm6VVMUNRJqkBrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9G5I3cbyuW6qTRnHxMo2ZjTq8l/37Bd8ZLoBUtmC8kSb9fZvq
	daEG/y1GNHWvlDldqVZHxwY6wHUsxmrJ34lvwtJmGJ+Bpfp7ehJ5WtM94oehGV3QsmDjXRyD/kZ
	NLXStWiW7iMHYvOZ1IOmnwVNGOqLwAyyu9jb5AsLn5O3gIpUCwqL5OE+gyjfYezPECw==
X-Gm-Gg: ASbGncv57nN8Lj3tT5JPFoKTpPE8koQYQe4vrv0dqJW0hXjLV6EA32MJnVgKE1w7unA
	o/DrYpRQrojkzeDIMiRg/Gh0oqN4ptU/xyclfl+oxV/NYjHJ6EKE8leXJA3kqnhCrkvnJ4EVid8
	S42bbUWDDnA4gKlon+j57CzPg/J49fwZWBGPLJ7CTms0GiRCZT675JSUDlpN3JED8fIPzND9SnF
	R6WNg+CXjVzd31m31EYT2CbbGSJ/k3yOytR2FG9BuDMCLHf1KigCr7p0EK/ztvzUlUITglMzsUR
	pPl3PSHxs/A4onke1hHrk0yIm8RghjMGLZa7ay8Wy7QAB8pAng0kKsMj92ktA//igTe0Ayw=
X-Received: by 2002:a7b:c018:0:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-4776bcba012mr17488335e9.19.1762520996359;
        Fri, 07 Nov 2025 05:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV/Rr5lzgLB/oFrRRCumn/JEzRFlirlNZ45yaTBgHWRSyCOkDHeIleNB5xGBLpvhxqzMlF9g==
X-Received: by 2002:a7b:c018:0:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-4776bcba012mr17488215e9.19.1762520995881;
        Fri, 07 Nov 2025 05:09:55 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd087b1sm55972655e9.16.2025.11.07.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:09:55 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] KVM: x86: Use "checked" versions of get_user() and
 put_user()
In-Reply-To: <20251106210206.221558-1-seanjc@google.com>
References: <20251106210206.221558-1-seanjc@google.com>
Date: Fri, 07 Nov 2025 14:09:54 +0100
Message-ID: <87zf8yat0d.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Use the normal, checked versions for get_user() and put_user() instead of
> the double-underscore versions that omit range checks, as the checked
> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> 25%+ on AMD).
>
> The performance hit on the unchecked versions is almost entirely due to
> the added LFENCE on CPUs where LFENCE is serializing (which is effectively
> all modern CPUs), which was added by commit 304ec1b05031 ("x86/uaccess:
> Use __uaccess_begin_nospec() and uaccess_try_nospec").  The small
> optimizations done by commit b19b74bc99b1 ("x86/mm: Rework address range
> check in get_user() and put_user()") likely shave a few cycles off, but
> the bulk of the extra latency comes from the LFENCE.
>
> Don't bother trying to open-code an equivalent for performance reasons, as
> the loss of inlining (e.g. see commit ea6f043fc984 ("x86: Make __get_user()
> generate an out-of-line call") is largely a non-factor (ignoring setups
> where RET is something entirely different),
>
> As measured across tens of millions of calls of guest PTE reads in
> FNAME(walk_addr_generic):
>
>               __get_user()  get_user()  open-coded  open-coded, no LFENCE
> Intel (EMR)           75.1        67.6        75.3                   65.5
> AMD (Turin)           68.1        51.1        67.5                   49.3
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/all/CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c          | 2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 38595ecb990d..de92292eb1f5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1568,7 +1568,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>  		 * only, there can be valuable data in the rest which needs
>  		 * to be preserved e.g. on migration.
>  		 */
> -		if (__put_user(0, (u32 __user *)addr))

Did some history digging on this one, apparently it appeared with

commit 8b0cedff040b652f3d36b1368778667581b0c140
Author: Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
Date:   Sun May 15 23:22:04 2011 +0800

    KVM: use __copy_to_user/__clear_user to write guest page

and the justification was:

    Simply use __copy_to_user/__clear_user to write guest page since we have
    already verified the user address when the memslot is set

Unlike FNAME(walk_addr_generic), I don't belive kvm_hv_set_msr() is
actually performance critical, normally behaving guests/userspaces
should never be doing extensive writing to
HV_X64_MSR_VP_ASSIST_PAGE. I.e. we can probably ignore the performance
aspect of this change completely.

> +		if (put_user(0, (u32 __user *)addr))
>  			return 1;
>  		hv_vcpu->hv_vapic = data;
>  		kvm_vcpu_mark_page_dirty(vcpu, gfn);
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index ed762bb4b007..901cd2bd40b8 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -402,7 +402,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  			goto error;
>  
>  		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
> -		if (unlikely(__get_user(pte, ptep_user)))
> +		if (unlikely(get_user(pte, ptep_user)))
>  			goto error;
>  		walker->ptep_user[walker->level - 1] = ptep_user;
>  
>
> base-commit: a996dd2a5e1ec54dcf7d7b93915ea3f97e14e68a

-- 
Vitaly



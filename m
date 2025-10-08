Return-Path: <linux-kernel+bounces-846035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC9BC6D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 01:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF754188A6E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B102C3258;
	Wed,  8 Oct 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIavJCYH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BE2C21FF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964472; cv=none; b=KkK6ubjmqNgpzymGs5ITMgh9Tcknet7zT0jvfhq31O8oMac6vWYryODkCWKunYLPhS1TIo09vJ2zB7cadiZD2UjaM4Dqf/h8PnqOG5P+/hm3SZfLm/qsWqJcsGjC2F1AY8V65PC/NqS88UkNppeljf2TOnClvvDOvKMypkT2414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964472; c=relaxed/simple;
	bh=J6naoicX6YO52BOs1YYqGhDcIuPebi0tPRNmqLYfK/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezfn609ztlY72HSPOyk2bp0LjJL4YLJ+Iq32cCwT8Gf6smrkSlecNiC+VpILbozFYYrbTV9DMBz1zpyHN0nioDFSgF5uDan7a/xtJuaK3VAnxlHAvlDnai/bLU7N85RTy+Ox5yLe2REFIUWKYFPK5PSPL5idy7tc3on47OhVPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIavJCYH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b650a3e0efcso62030a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759964469; x=1760569269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3W05OR4qhoErzn2hSlT+lwHNht4XbUpenDxlwhWo4Q=;
        b=iIavJCYHKT43xsOVQVX/QAuHGPAww9gEBw9seu4JOxyZuPikTEf2rIZLJ2/3jmBkeU
         ffYbzofgyui6gnJ6QDAf3CiVmzvjBzfTFhCgg391ARwHdceiXaBA6c2xL9JWl/ab+qqA
         pKhWNhaQ9HG3iCMn3L0FYcSOD4a+O17SQuFYd7F8Lu2c3X/js48LeGa5vwxNWddHan99
         aN3SbzxgGZohBKkHoslth13eAkbCsiA1nB8qH5v/YkiXfy1uUah6K42W0jT3WT17aPaL
         WYO07htKxyp/6qfDjJxVKMVc9RAztPw9UrA7Jj2iU9k8Gw7EIOM9t9Cy65ve3Q+HeHiD
         4Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759964469; x=1760569269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3W05OR4qhoErzn2hSlT+lwHNht4XbUpenDxlwhWo4Q=;
        b=blImIgD7MwwEe5FBPqJwrpqSB7f2eggvNvuZV78Kcl3/c6dDlTSsbl0tQIUFJENAdZ
         P1PjRuxoxLpMl8a/2vsvffoViGTc2NoW1YGalWhJj4QEvYyfNwrE4YFa0fatxbh9ELrO
         onl4S+EQ7/vP4Y6NUfrSKvmKEymDzPafU2K5qrhQP1IArzUHekND8Cgtop4L1B7a4DaX
         gp+yXKe8iLioQTEFbayjDu5GUXHuruevkna13mz/fShPbDWqkAw/2w2iirGKmcoUtlo+
         jam0+qVvZgWYA/5+Ry024IXwdU/pHQFOi94AFRP1ui529yiV21Xg7RScW+UFHy4dQatF
         6epg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGyyXRAh6j2GobR7yxlJqsdPNsAK1JVIK+/s8G5aLagKLvlTHjCOV6wLOFFlWpWrWTuSr9l7W6U5sg9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9lDl2bskXIUNoN0mMmRoZT5s3FRW+UZXMUpUZK2KW9oaqhtf
	7KWn+sP8inzxE4Zl0Q3RXRd7CxkcX+nNJrZp4Wr+PkZMAaQxI64lHulvwzKkI2Z1jlxAHPjclmU
	2LI1Ytg==
X-Google-Smtp-Source: AGHT+IFm0oXfs8EI8t7khyLXG8PnbkOBg8NV7KElx8DOui3DOeBprgmwN/sDXkkpdWjTUzd9ZcDKdkRKatw=
X-Received: from pjbpv10.prod.google.com ([2002:a17:90b:3c8a:b0:32e:b34b:92eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f8c:b0:2f6:9592:9075
 with SMTP id adf61e73a8af0-32da81f3adbmr7025731637.25.1759964469003; Wed, 08
 Oct 2025 16:01:09 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:01:07 -0700
In-Reply-To: <Z_g-UQoZ8fQhVD_2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324140849.2099723-1-chao.gao@intel.com> <Z_g-UQoZ8fQhVD_2@google.com>
Message-ID: <aObtM-7S0UfIRreU@google.com>
Subject: Re: [PATCH] KVM: VMX: Flush shadow VMCS on emergency reboot
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Trimmed Cc: to lists, as this is basically off-topic, but I thought you might
be amused :-)

On Thu, Apr 10, 2025, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Chao Gao wrote:
> > Ensure the shadow VMCS cache is evicted during an emergency reboot to
> > prevent potential memory corruption if the cache is evicted after reboot.
> 
> I don't suppose Intel would want to go on record and state what CPUs would actually
> be affected by this bug.  My understanding is that Intel has never shipped a CPU
> that caches shadow VMCS state.
> 
> On a very related topic, doesn't SPR+ now flush the VMCS caches on VMXOFF?  If
> that's going to be the architectural behavior going forward, will that behavior
> be enumerated to software?  Regardless of whether there's software enumeration,
> I would like to have the emergency disable path depend on that behavior.  In part
> to gain confidence that SEAM VMCSes won't screw over kdump, but also in light of
> this bug.

Apparently I completely purged it from my memory, but while poking through an
internal branch related to moving VMXON out of KVM, I came across this:

--
Author:     Sean Christopherson <seanjc@google.com>
AuthorDate: Wed Jan 17 16:19:28 2024 -0800
Commit:     Sean Christopherson <seanjc@google.com>
CommitDate: Fri Jan 26 13:16:31 2024 -0800

    KVM: VMX: VMCLEAR loaded shadow VMCSes on kexec()
    
    Add a helper to VMCLEAR _all_ loaded VMCSes in a loaded_vmcs pair, and use
    it when doing VMCLEAR before kexec() after a crash to fix a (likely benign)
    bug where KVM neglects to VMCLEAR loaded shadow VMCSes.  The bug is likely
    benign as existing Intel CPUs don't insert shadow VMCSes into the VMCS
    cache, i.e. shadow VMCSes can't be evicted since they're never cached, and
    thus won't clobber memory in the new kernel.

--

At least my reaction was more or less the same both times?

> If all past CPUs never cache shadow VMCS state, and all future CPUs flush the
> caches on VMXOFF, then this is a glorified NOP, and thus probably shouldn't be
> tagged for stable.
> 
> > This issue was identified through code inspection, as __loaded_vmcs_clear()
> > flushes both the normal VMCS and the shadow VMCS.
> > 
> > Avoid checking the "launched" state during an emergency reboot, unlike the
> > behavior in __loaded_vmcs_clear(). This is important because reboot NMIs
> > can interfere with operations like copy_shadow_to_vmcs12(), where shadow
> > VMCSes are loaded directly using VMPTRLD. In such cases, if NMIs occur
> > right after the VMCS load, the shadow VMCSes will be active but the
> > "launched" state may not be set.
> > 
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index b70ed72c1783..dccd1c9939b8 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -769,8 +769,11 @@ void vmx_emergency_disable_virtualization_cpu(void)
> >  		return;
> >  
> >  	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
> > -			    loaded_vmcss_on_cpu_link)
> > +			    loaded_vmcss_on_cpu_link) {
> >  		vmcs_clear(v->vmcs);
> > +		if (v->shadow_vmcs)
> > +			vmcs_clear(v->shadow_vmcs);
> > +	}
> >  
> >  	kvm_cpu_vmxoff();
> >  }
> > -- 
> > 2.46.1
> > 


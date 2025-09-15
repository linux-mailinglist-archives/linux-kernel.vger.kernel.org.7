Return-Path: <linux-kernel+bounces-817790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D01B586A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527EF7B298D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE92C0F8C;
	Mon, 15 Sep 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uW9pHazX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175A2C0F61
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971363; cv=none; b=QFX0lUfN+HPsvlA5XMhwTeXZcgp4Jef6zdQsQiavQuwtTwjNwKNYk3klMBnLeLIkt7knPXGRdqvzweCZYDONIt06ADaVISlwfX9OjkirXM6XDA+5C3bNKn26hLaKSogvmmp06tyAgKLoU70G2I+NBtbUXO8Ota6/T/6+BhcTXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971363; c=relaxed/simple;
	bh=AwXWIVYTmwCTCxNRYrGLZ2NZ9skESSL209hF04EJgTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AaDrs97fHiT/Bne54IGs8vUEUDk/+8qTfFEXv+5WwPvM5DcqgBYUXNrlXYsIe+g57GR7wB8fnuCHayhIhxKls2mO/SgBh+RSxOAHZ4OehcUfvuGp75sDNb7H6BFzVrqXvI9n9zNuf2+PZ5NM976QQ+ZQyCSWIksWzIfj64VMDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uW9pHazX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso8354654a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757971361; x=1758576161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cRptf9XI7WjIgrIL48NtO2kHVbk8p0nvm2Xzei94+U=;
        b=uW9pHazXI6fHc+5jkXKiAIh+BOm9tSHZ3sNrDZT7F5XH2yzQPWrVAOcdYOcC21Y+8p
         +CdII2lJqjApHSF1S8f2+qZZl3vZytOJNgUBP4M2TTSFSfwdSIDgaQB9qJpkP4APek3I
         YrIyCt7XHM6DCBraCMB5sRHW8cncP6Ze1rp7OFFDd4zwptgbDQkhcHuxEfDE7/eCSE7z
         45hWI2DYCdthrfJNVFk9bKNE7sTMEc8V9Z3HighSP3GowxQGKQ3qFG7wIRNosulRUPIZ
         gH3CkOuK7bbSX7NCX+udCWSeACvlqB6sI9Bhau7YmdEXIRUPP9/VHO/2ZFBKv9TPsFVe
         djYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971361; x=1758576161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cRptf9XI7WjIgrIL48NtO2kHVbk8p0nvm2Xzei94+U=;
        b=by815TLfu4zSaMLaxUjhO2NL5hec/y+8nWWT5LwEm1PAW8NFo8Stfb2BJAOJWZbHiQ
         R5jDFzd3qEA5UeyFCd78QeQuJrZjLbO0akWPjJpqI6e/miKW3H/cEkHACAMAT+HE9XeA
         cN/dgTDc7rp/LymgZJCnfS2o0mH1T6zBZxRCouKLNKh10r1rsJbArrggHuO1G3Ovd93+
         rN2OOAWudnbi0GamQynXTMSViiYYfx0Z7lS6fQkeMe8icqzH4rJr0SGlqgw2lSe2kme+
         s8v+BdqeqiWspqpAKWBWh7YJSeH/Qb/nfmKZVHAwstzsQIot3w/FP1wDq+X0CT3CLJii
         Uvzg==
X-Forwarded-Encrypted: i=1; AJvYcCVhQz3MspJAaEkB7f7i8mih+CUKJ9mHbQisCY1TyeOTJ88/8jQiIdyUKcy0BEqvILC0QqZxu4CJnwU2uLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECE8zGk5DWo+Iiw7nzW5Ye8JWSGhwjYBB2gIqpq1XnY9xdtc+
	qSn76ptZTPCn8PduSH8KZ/cJN98HrzCD6SnSkhFib7BvAno+bQ6tDY3qGnjJ5YfyEoi3nXP8dKb
	xEEhs4g==
X-Google-Smtp-Source: AGHT+IF5IXJXgoS0LEPkWktj7QYgx0swiSjB1JkgUj/Lz8TL9RMvRAxNF3q7FOaLKRcYiK8xf+tz8BDx+wY=
X-Received: from pjbee15.prod.google.com ([2002:a17:90a:fc4f:b0:32e:749d:fcc6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f83:b0:32d:90c7:c63b
 with SMTP id 98e67ed59e1d1-32de4fa6dcamr16528116a91.30.1757971361342; Mon, 15
 Sep 2025 14:22:41 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:22:39 -0700
In-Reply-To: <c30dff3a-838d-93df-d106-25acb7cb0513@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-4-seanjc@google.com>
 <c30dff3a-838d-93df-d106-25acb7cb0513@amd.com>
Message-ID: <aMiDn1BJsOxtJwep@google.com>
Subject: Re: [PATCH v15 03/41] KVM: SEV: Validate XCR0 provided by guest in GHCB
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Tom Lendacky wrote:
> On 9/12/25 18:22, Sean Christopherson wrote:
> (successfully booted and ran some quick tests against the first 3
> patches without any issues on both an SEV-ES and SEV-SNP guest).

Nice, thanks!

> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 37abbda28685..0cd77a87dd84 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -3303,10 +3303,8 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
> >  
> >  	svm->vmcb->save.cpl = kvm_ghcb_get_cpl_if_valid(svm, ghcb);
> >  
> > -	if (kvm_ghcb_xcr0_is_valid(svm)) {
> > -		vcpu->arch.xcr0 = kvm_ghcb_get_xcr0(ghcb);
> > -		vcpu->arch.cpuid_dynamic_bits_dirty = true;
> > -	}
> > +	if (kvm_ghcb_xcr0_is_valid(svm))
> > +		__kvm_set_xcr(vcpu, 0, kvm_ghcb_get_xcr0(ghcb));
> 
> Would a vcpu_unimpl() be approprite here if __kvm_set_xcr() returns
> something other than 0? It might help with debugging if the guest is
> doing something it shouldn't.

I don't want to use vcpu_unimpl(), because this isn't likely to occur due to lack
of KVM support.  Hrm, but I see now that sev.c abuses vcpu_unimpl() for a whole
pile of things that aren't due to lack of KVM support.  I can certainly appreciate
how painful it can be to debug random -EINVAL failures, but printing via
vcpu_unimpl() isn't an approach that I want to encourage as it's inherently
flawed (requires access to kernel logs, is ratelimited, and can still cause
jitter even though it's ratelimited if multiple CPUs happen to contend the printk
locks at just the wrong time).

For now, I think it's best to do nothing.  Long term, I think we need to figure
out a solution for logging errors of this nature, because this is far from the
first time this sort of thing has popped up.  E.g. nested VMX consistency check
failures are another case where having precise logs would be super helpful, but
telling userspace to enable tracepoints and scrape the tracefs logs (or run BPF
programs) isn't exactly a great experience.


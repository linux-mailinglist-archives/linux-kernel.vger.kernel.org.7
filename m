Return-Path: <linux-kernel+bounces-885224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F364C32450
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFEE034AE43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33430299AB5;
	Tue,  4 Nov 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/TbMY2a"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2017332EDA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276583; cv=none; b=YiJfivVlXA3ycKQjWMrhAZHEvvy+gO2kXjW1Sjck7RK2qyLIvbqJR8P1B7cUGoHiHmA+IBoHh9UI/+riBebx4+8li+I5PR0rojA47Y9hSOOhBH7bdravk9l/9HLeOwQhQKfpFtcWWTehoeulZj2gMOchVmZjIdpNFSdxAngWSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276583; c=relaxed/simple;
	bh=74YBZDoQ83xKtptK80/takPjZbLTMjieIiqtSwmNNJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HseTSwVMHocAMM0zSc9jlGwCr0D8kJaAVBMcVxbVsEr4Cs94QMpWMI8AtlJR5GyzqZbz5ZLVEI9u8fh67iQGX8nE4aDt4KQeHiT+wRPJVdGNoJHPdWSJWntAKld16yRFuVDu+lSCKvWeIVfFqSrLNfkDzpboLeeqJtGb0GXkflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/TbMY2a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29523ed27e0so52879355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762276572; x=1762881372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS4bLkjfdqWxdiK6mwiFizJkIXMdxek1nIt3B9oDobs=;
        b=l/TbMY2a8xpeaTkpchRwNykNVkEdH/f5QackNGVwgOn3WPBPS5dEx11lFp8SNsSRVz
         3sKFOZOmixJCTL1WdfdjdTUuDnk0XXv8jqa0mtf3Py1g1ZjesEmnoPElZOnKsZE56pSc
         Amkfjkls0PHti3HX6fOxMMAExpOywoUj+TQyNfvR3WoIt/aIOlCMuJon+1Gkb4TtBzV3
         1IPRR1x3Ke38BycKUyw174ZmBiv4gdLwCnLtCuVw5kH47weXjRZx3q+A8dEKEQvmFiUK
         We+Vbh7qj+gecpJvGPae4coecubN0IXFAkYo2iUiI7ySF+BMDbhcwpDgbJMfd+MhEzlO
         Ebsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276572; x=1762881372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS4bLkjfdqWxdiK6mwiFizJkIXMdxek1nIt3B9oDobs=;
        b=dtFlEBu7HJgd/NDEU2+um7gvseJ6tu6kv1knt+0kLbvHNX4xVwJqAoTja2ggdrAzJ3
         jRWg7hq/I72UM3Kjkr33TDHuXrXsE7jTy0SMaBI0U2eLKWqnSE6mvrQHS4sEzgOlbB2N
         m3c74A7zuB+uQSoV1q8jwH2u6Qj9QqKtiKjtXdANRHYd9RZQK/gvh1iYArG0BWOC5oVy
         Ok+PrmiK0LOGgQSM+cnCYfIDSxI0dzqx5kaS2zxg+xC4gsssB1YYR2e9dfN6xKR4nSOo
         bKNGW5Y/njFL6Gdj+C0v7WfL8rqaFTYJQ27tLAULXdj8+1hAj+1bBE73ynEj348yQ1S+
         wp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh1KKUs/XPhN4qDke7JVBP6VY6pmnWZoEokoOt3zojXHLtMxjtisnQwI+5PThCwUCe2F7xP89EGpSBTOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkXjeIoLoS4bADB3rYJ7TCdKHcZnIVplYqCWSYvco8SpOxWBX
	rSk9O88CNuSvoqMFCTuIuVxstHvFef/pNxq+hPyOg962Qc0inZ27RomMTD87ke89XR5vWGXMfdl
	oZa5uOw==
X-Google-Smtp-Source: AGHT+IEb98zdibRUw3q8rz5s7dc2rz9KLXalBcAB3oaxD9YhpNQGD+LumJ8fuqIknfJVxR3bHJsxCZ35FjU=
X-Received: from plhy12.prod.google.com ([2002:a17:902:d64c:b0:295:525b:2186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cf:b0:295:3d5d:fe57
 with SMTP id d9443c01a7336-2962ad2add3mr4432015ad.21.1762276572264; Tue, 04
 Nov 2025 09:16:12 -0800 (PST)
Date: Tue, 4 Nov 2025 09:16:08 -0800
In-Reply-To: <ojg5bq2guzb6hk7q7n2przo2ygkra6boavhhq7u5kptygu6jij@5nvgdi3preqg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030185004.3372256-1-seanjc@google.com> <ojg5bq2guzb6hk7q7n2przo2ygkra6boavhhq7u5kptygu6jij@5nvgdi3preqg>
Message-ID: <aQo02LpJ5IfNzVD3@google.com>
Subject: Re: [PATCH] KVM: x86: Add a helper to dedup reporting of unhandled VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 03, 2025, Yosry Ahmed wrote:
> On Thu, Oct 30, 2025 at 11:50:03AM -0700, Sean Christopherson wrote:
> > Add and use a helper, kvm_prepare_unexpected_reason_exit(), to dedup the
> > code that fills the exit reason and CPU when KVM encounters a VM-Exit that
> > KVM doesn't know how to handle.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  1 +
> >  arch/x86/kvm/svm/svm.c          |  7 +------
> >  arch/x86/kvm/vmx/tdx.c          |  6 +-----
> >  arch/x86/kvm/vmx/vmx.c          |  9 +--------
> >  arch/x86/kvm/x86.c              | 12 ++++++++++++
> >  5 files changed, 16 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 48598d017d6f..4fbe4b7ce1da 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2167,6 +2167,7 @@ void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
> >  void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
> >  
> >  void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
> > +void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
> >  
> >  void kvm_enable_efer_bits(u64);
> >  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index f14709a511aa..83e0d4d5f4c5 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3451,13 +3451,8 @@ static bool svm_check_exit_valid(u64 exit_code)
> >  
> >  static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
> >  {
> > -	vcpu_unimpl(vcpu, "svm: unexpected exit reason 0x%llx\n", exit_code);
> >  	dump_vmcb(vcpu);
> > -	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> > -	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON;
> > -	vcpu->run->internal.ndata = 2;
> > -	vcpu->run->internal.data[0] = exit_code;
> > -	vcpu->run->internal.data[1] = vcpu->arch.last_vmentry_cpu;
> > +	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
> >  	return 0;
> >  }
> 
> We can probably drop svm_handle_invalid_exit() entirely now

Hmm, yeah.  I'll do so in a separate follow-up, as I want to do more than just
fold svm_handle_invalid_exit() into svm_invoke_exit_handler().


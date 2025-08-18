Return-Path: <linux-kernel+bounces-774213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79234B2AFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68387AFC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C232BF39;
	Mon, 18 Aug 2025 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pB033TwY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA432BF20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540522; cv=none; b=FEJSI42XSjRq2Du1FCQFQ+dq2/5ovD8SJ7yPNe7jB6W35y83NPq3j2h969U2G61E9+SxsZuXFUeVjGrk6X9Xgz3/q9rbAIqiffcUeO50dkWCa71G/3dTcbpvhPFcdBixpvKsNyoCFvk+XyKk2cqCbbkKYMsM5RqO5OjVSa+lXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540522; c=relaxed/simple;
	bh=v3wUxTe/oczfV17Ur6CgCV11cP8tQI+5ZOqEY7Q1eQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEIssadC3GLjXor7qzWqqx44VC+1T4qBG0Ij5XU/c5VnnDb5HC6gPilvRPxFoxfQhe4uvrxxpqZcHkczGqWH7YpHYXY1jaKKIOOZz6WSORYz07KcsvPMOqTHFRax5I4+VLW5tTbI7jEjrlNZhQxi9g3WVGVHS3g3FTmoMc6d+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pB033TwY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so4289426b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755540520; x=1756145320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhyFTTY2gxFziV/t1dr06cUEDVJ2jOT7w1mNz7Rq2RU=;
        b=pB033TwYyMYhWLwCwc2MWXbE7kL5qV9TgEyy2yEoDLBBz9xgVbqEfUAdXtwrYarEpk
         TR0fs7BaeyAPdUCWuOLZhqzk8V32rlniFo6RXyymh5PuNjU2JESHivChrsm3Hd7yqNIA
         +ivCdJl/lEWRiXpQaoYlKA3AyJB8LAdGtqDK3z3je/m4ZvulPW+DmhCci38GfoJVAsE2
         GrVNEgUGETsq1i4PndTCwkZuaHXPDmReqN4WECPmKAxeDPXsjIfuWCfofMKwz4t7VYlP
         F9mk+mzRxuWioTPzAr1T05toNbqJZpIBi+j7pzNvKV2iF0AeH+hOFIQbVpbeBSMgoSw8
         gt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540520; x=1756145320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhyFTTY2gxFziV/t1dr06cUEDVJ2jOT7w1mNz7Rq2RU=;
        b=twwDhQfFlk7tdanjlrq8jo5JpoW7D8xy1xQOTAodLRA/kHGi6jELiYNX7SfHuHAF/R
         lj5+Wp2z8Swba9p7IA8FxVNBctxdhAKGu1FbOv5XlUpCHmxUTNeXJuyL+nyr5P/ewY5s
         SQ/aMlaeNuLaLkR1qNJKFsq+b9dCDJTmGsXlStjceSEDwzvcDppKYY02xPS0gf3lTm9D
         c0T4IAmTvycMQb4P79+vRW6wNIGKyf/2VfNUkzWP5B7Kk5s3uE7YSdBPUUU64TcnK1L0
         ONjybC5yz3SiNsO+vAcn3cW6DUnjPAbta49I26DnYL3HNINc4d/UvIZHCdnwJ/Jy9OeM
         qzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSSprUnVNw5QOJrxsGOSIy3Vj+EmZ6uMnXKlhkbwqDYz2SN2JGJjmUevjwRWYzYY+jBDQWvu9blGG+u+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1730JfkD29sO5P3w3uQWwqV7/L63i9Ja8CSyolCB5MxNhSwB
	iORM2lzXuxeUhKaLY3+kXK7yEnnwiWJym4MZz5bA4fA5wpKykp4E/oaxAhwL0DRvOLK4/svTNBR
	8zlztrw==
X-Google-Smtp-Source: AGHT+IEuRj/ZPaUh1DyEWU8zUq0bCPdsuEfkK3N4jW/6sjoBpobHBvIOiu/oe68da2aXndSCQQ4o+XsXmJ8=
X-Received: from pgbdt13.prod.google.com ([2002:a05:6a02:438d:b0:b42:a176:cd09])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3290:b0:240:17d2:c004
 with SMTP id adf61e73a8af0-2430a87fd95mr354744637.43.1755540520150; Mon, 18
 Aug 2025 11:08:40 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:08:38 -0700
In-Reply-To: <20250813192313.132431-3-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813192313.132431-1-mlevitsk@redhat.com> <20250813192313.132431-3-mlevitsk@redhat.com>
Message-ID: <aKNsJoslekEMI-FT@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Fix a semi theoretical bug in kvm_arch_async_page_present_queued
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 13, 2025, Maxim Levitsky wrote:
> Fix a semi theoretical race condition in reading of page_ready_pending
> in kvm_arch_async_page_present_queued.

This needs to explain what can actually go wrong if the race is "hit".  After
staring at all of this for far, far too long, I'm 99.9% confident the race is
benign.

If the worker "incorrectly" sees pageready_pending as %false, then the result
is simply a spurious kick, and that spurious kick is all but guaranteed to be a
nop since if kvm_arch_async_page_present() is setting the flag, then (a) the
vCPU isn't blocking and (b) isn't IN_GUEST_MODE and thus won't be IPI'd.

If the worker incorrectly sees pageready_pending as %true, then the vCPU has
*just* written MSR_KVM_ASYNC_PF_ACK, and is guaranteed to observe and process
KVM_REQ_APF_READY before re-entering the guest, and the sole purpose of the kick
is to ensure the request is processed.

> Only trust the value of page_ready_pending if the guest is about to
> enter guest mode (vcpu->mode).

This is misleading, e.g. IN_GUEST_MODE can be true if the vCPU just *exited*.
All IN_GUEST_MODE says is that the vCPU task is somewhere in KVM's inner run loop.

> To achieve this, read the vcpu->mode using smp_load_acquire which is
> paired with smp_store_release in vcpu_enter_guest.
> 
> Then only if vcpu_mode is IN_GUEST_MODE, trust the value of the
> page_ready_pending because it was written before and therefore its correct
> value is visible.
> 
> Also if the above mentioned check is true, avoid raising the request
> on the target vCPU.

Why?  At worst, a dangling KVM_REQ_APF_READY will cause KVM to bail from the
fastpath when it's not strictly necessary to do so.  On the other hand, a missing
request could hang the guest.  So I don't see any reason to try and be super
precise when setting KVM_REQ_APF_READY.

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9018d56b4b0a..3d45a4cd08a4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13459,9 +13459,14 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  
>  void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
>  {
> -	kvm_make_request(KVM_REQ_APF_READY, vcpu);
> -	if (!vcpu->arch.apf.pageready_pending)
> +	/* Pairs with smp_store_release in vcpu_enter_guest. */
> +	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);

In terms of arch.apf.pageready_pending being modified, it's not IN_GUEST_MODE
that's special, it's OUTSIDE_GUEST_MODE that's special, because that's the only
time the task that hold vcpu->mutex can clear pageready_pending.

> +	bool page_ready_pending = READ_ONCE(vcpu->arch.apf.pageready_pending);

This should be paired with WRITE_ONCE() on the vCPU.

> +
> +	if (!in_guest_mode || !page_ready_pending) {
> +		kvm_make_request(KVM_REQ_APF_READY, vcpu);
>  		kvm_vcpu_kick(vcpu);
> +	}

Given that the race is guaranteed to be bening (assuming my analysis is correct),
I definitely think there should be a comment here explaining that pageready_pending
is "technically unstable".  Otherwise, it takes a lot of staring to understand
what this code is actually doing.

I also think it makes sense to do the bare minimum for OUTSIDE_GUEST_MODE, which
is to wake the vCPU.  Because calling kvm_vcpu_kick() when the vCPU is known to
not be IN_GUEST_MODE is weird.

For the code+comment, how about this?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6bdf7ef0b535..d721fab3418d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4000,7 +4000,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
                        return 1;
                if (data & 0x1) {
-                       vcpu->arch.apf.pageready_pending = false;
+                       WRITE_ONCE(vcpu->arch.apf.pageready_pending, false);
                        kvm_check_async_pf_completion(vcpu);
                }
                break;
@@ -13457,7 +13457,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
        if ((work->wakeup_all || work->notpresent_injected) &&
            kvm_pv_async_pf_enabled(vcpu) &&
            !apf_put_user_ready(vcpu, work->arch.token)) {
-               vcpu->arch.apf.pageready_pending = true;
+               WRITE_ONCE(vcpu->arch.apf.pageready_pending, true);
                kvm_apic_set_irq(vcpu, &irq, NULL);
        }
 
@@ -13468,7 +13468,20 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 {
        kvm_make_request(KVM_REQ_APF_READY, vcpu);
-       if (!vcpu->arch.apf.pageready_pending)
+
+       /*
+        * Don't kick the vCPU if it has an outstanding "page ready" event as
+        * KVM won't be able to deliver the next "page ready" token until the
+        * outstanding one is handled.  Ignore pageready_pending if the vCPU is
+        * outside "guest mode", i.e. if KVM might be sending "page ready" or
+        * servicing a MSR_KVM_ASYNC_PF_ACK write, as the flag is technically
+        * unstable.  However, in that case, there's obviously no need to kick
+        * the vCPU out of the guest, so just ensure the vCPU is awakened if
+        * it's blocking.
+        */
+       if (smp_load_acquire(vcpu->mode) == OUTSIDE_GUEST_MODE)
+               kvm_vcpu_wake_up(vcpu);
+       else if (!READ_ONCE(vcpu->arch.apf.pageready_pending))
                kvm_vcpu_kick(vcpu);
 }


Return-Path: <linux-kernel+bounces-630515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B74AA7B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76E61892372
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F120297C;
	Fri,  2 May 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3yjK5Tl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D51200BB2
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219535; cv=none; b=mo4d465YmUTQXF2f17ONfZA1fGPW4qqbtI+pq/w/6xOTaKzeUOrTCnYllDaKsKRB8i9sJMlvD1S3JEzVJ9BmHPixArajMruuCZkFooiQCgQz+EFINXRiYz2r8oIFYj2XkXKicuLWgkPprAIAueH+7hKKzMOpwxht7qEJ0TghQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219535; c=relaxed/simple;
	bh=FMuOYXuNARVPGbLdZKzdZACnsi/D3uRXcBJ+KxMLSJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anLfFWtO8hDzAxLvfNrLg2JCWqbeBFTVjkqzYkmjh/ZDPADKjgkeQMAh53RhdU05H2V9f9WtgQwHmI3RUqQJPruJ1JDX/enNB5CVfNxo4CRGAxEkdrn7Um3QkVU7cINHHoYY0BbH8zr2WO/3hOUjYzm9C48OnhSJ1h9oNxCdJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3yjK5Tl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff68033070so2399341a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746219533; x=1746824333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z141FLEwqm2f5UKeV3GY2SvtY7oSxEMFO78Y0lhO4Mo=;
        b=k3yjK5TlxSHwkE10pVk/twpfj1LsProTTzA3zL6CnCOXeuNym74tyx4CsubLtdywHv
         QDPpRfW2vGWLYWXPHvphIVLqXa3i/KtNYV5gplCEeCxYbU+tmOXfrvgF87seLPFVgtsq
         IXx8sWCKV/Nx5AWbsjLI/diPcFrOl22W51Zr8kQWxisLlPv4EOPbvAeiNFRRfrl6uuhY
         39n5+57jSZ2sqI30ILLDR3Kci+7FJ/TpJFq4RVjVcFNXtviVoLLt0r+7WdFyQybhaVDq
         JvD144MdrHGUz76E6sqK2t9lRUpQPSjyQzDcP714447z3Jozew8pz92aFzeIuiXVCWYw
         tzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746219533; x=1746824333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z141FLEwqm2f5UKeV3GY2SvtY7oSxEMFO78Y0lhO4Mo=;
        b=HnXNCsHZf60uuOJSNGxG94wA61N6MOgKVRcwsJaFG5VrPhUMBnmX5VP1TMdk6vQlkr
         fIUakvzHfjJN4eTPlSPTALQDOgsHZwJ8w14ksGeSiMq+aztZI8a+Er2FVzwES9yT/R3W
         BtIloJIwfxaFIgf0kRtgU4NEt33JR4EFIRICjrTniy4XQfuq+kRPiAqMP8jToV0NCt+V
         W0huJibSsRyQ4HLW1AqxuEGUtL3NGO3In8D0eQ8DIoyQoSq+ARFSWNemkOEYw5YXGeSi
         qKetT+gIC8wvXc3SZKhDn0mMAK5crMUFn/hTBVwBwKRAV29PrPT/AAuw0K8GQDqbtWFZ
         vQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2HvoWsd5qt/dT/t+tatUCz0X2lLlag2FZP5NDxD21H6U2HX8IOlD3CJJiswsxDh1g58fykpiiHb/Eay4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtGU0mMoaVkoikZbXRxjq6L0Ci9j2cbvpAZB3HElx25OrLwmT
	qDzHDnD4v+gUSgdoKvq+3QDJZ6vbGc6IlIVMz7WdP9mIeUKVY0pMnX7ic7r5MAzMsR+VbLM9PvJ
	vMg==
X-Google-Smtp-Source: AGHT+IGm3fjnbZdZ0P5dTXEIDYUNeozyMh591wQHnGgOaKhf2rgPLaUDWxwxyDC2IuE6wOX5aAwhTk5qwaY=
X-Received: from pjff8.prod.google.com ([2002:a17:90b:5628:b0:2ff:8471:8e53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8c:b0:305:5f32:d9f0
 with SMTP id 98e67ed59e1d1-30a4e5c5e9dmr6320303a91.19.1746219533227; Fri, 02
 May 2025 13:58:53 -0700 (PDT)
Date: Fri, 2 May 2025 13:58:51 -0700
In-Reply-To: <864iy4ivro.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430203013.366479-1-mlevitsk@redhat.com> <20250430203013.366479-3-mlevitsk@redhat.com>
 <864iy4ivro.wl-maz@kernel.org>
Message-ID: <aBUyC5kgTipXud-7@google.com>
Subject: Re: [PATCH v4 2/5] arm64: KVM: use mutex_trylock_nest_lock when
 locking all vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Kunkun Jiang <jiangkunkun@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Potapenko <glider@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Andre Przywara <andre.przywara@arm.com>, x86@kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm-riscv@lists.infradead.org, 
	Atish Patra <atishp@atishpatra.org>, Ingo Molnar <mingo@redhat.com>, 
	Jing Zhang <jingzhangos@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, kvmarm@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Keisuke Nishimura <keisuke.nishimura@inria.fr>, 
	Sebastian Ott <sebott@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shusen Li <lishusen2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 01, 2025, Marc Zyngier wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 69782df3617f..834f08dfa24c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1368,6 +1368,40 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Try to lock all of the VM's vCPUs.
> > + * Assumes that the kvm->lock is held.
> 
> Assuming is not enough. These assertions have caught a number of bugs,
> and I'm not prepared to drop them.
> 
> > + */
> > +int kvm_trylock_all_vcpus(struct kvm *kvm)
> > +{
> > +	struct kvm_vcpu *vcpu;
> > +	unsigned long i, j;
> > +
> > +	kvm_for_each_vcpu(i, vcpu, kvm)
> > +		if (!mutex_trylock_nest_lock(&vcpu->mutex, &kvm->lock))
> > +			goto out_unlock;
> > +	return 0;
> > +
> > +out_unlock:
> > +	kvm_for_each_vcpu(j, vcpu, kvm) {
> > +		if (i == j)
> > +			break;
> > +		mutex_unlock(&vcpu->mutex);
> > +	}
> > +	return -EINTR;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_trylock_all_vcpus);
> > +
> > +void kvm_unlock_all_vcpus(struct kvm *kvm)
> > +{
> > +	struct kvm_vcpu *vcpu;
> > +	unsigned long i;
> > +
> > +	kvm_for_each_vcpu(i, vcpu, kvm)
> > +		mutex_unlock(&vcpu->mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_unlock_all_vcpus);
> 
> I don't mind you not including the assertions in these helpers, 

I do :-)  I see no reason not to add assertions here, if locking all vCPUs is
a hot path, we've probably got bigger problems.


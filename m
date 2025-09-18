Return-Path: <linux-kernel+bounces-792438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE81B3C3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE956A642AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAE345756;
	Fri, 29 Aug 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToTXahfk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE64202F8B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500449; cv=none; b=i+jU0MONmve7sc7B3uunX1+KEMk5rwhLu49EP5yKiae+Q7so1EYilGTdXl/i+bod8k+ApuZM8SbzhvxwM0OBJK2rl5o1lm8zCYREtn7C5+HWAVkrrGRJqnUrFmvYzdN8IyhcvCWGmTzQ3jiepYkoM/7YrHSmVbfmXQVU1MS75vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500449; c=relaxed/simple;
	bh=9/wSQP4TwiwA28VHXselfVMpk5vyfA21xkhCwpAOusE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6ycT2lEMCkDsQ8ZbKKK8SL6g3K9YkcHszJDdfXbxFstV20jtehq40VYIpwHdKeX0TiKGoNKSv1TzvHdAmCAbnzFR/mnrko3hRYeTX6AS5L96DN64/ZEwAZNslGPsbsGqjTJRbccPgpfmdoS8q0w1nZ0UjXFAC4l7vv5i7b6t6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToTXahfk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327d1fea06eso1716355a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756500447; x=1757105247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVbLrwfcaMKrZbEzaIUXHMFK+4ezBC1s3sCq6svjQiA=;
        b=ToTXahfkCYPpuJQrCIJeiRR5rqJCIKh6WcDOebynZAu/Q0ehA7GR0Bznd2eRotavRe
         AbLqSnKkMd0N3juuERwUg2VP5bdIAuckkWMHjkxgoEfyJL2Hrnx9gcVfEmidVcF7upx6
         tFqJXbJ66veK7tk/GGy6w07rO6H0F8jlzpmKqG/Gl5slyefwPKAr4GN2HDndlrASvddd
         XN0HkOUmj8z0DWMuiKXzFwfmLBUkqrO7NraAqPEA/yuzAf5y4REJVs7Z3hn+1ho9ACFR
         NbbTb+dv2O5+xnF87FNxyvvHrYwn76gsV4OK2rH/QyloI2g4Yv+/abyzl6bbZwYj3syp
         X0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500447; x=1757105247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVbLrwfcaMKrZbEzaIUXHMFK+4ezBC1s3sCq6svjQiA=;
        b=oZ6U7RTWlr7om/UDy986oqhhx84qHYQfEO1ZVxGuxTk3yEj1vDq5Q1unqlPpfWX4s1
         XFM3ydW96DrOhfGMQbDxdabJQx2VjWtkB1R2HoGO1wqvETZHJDiqL0cx6JZ89cGf9Oz2
         gr/UNtMa0bGaEYw/BsiI+s8Et5EkOvfHRBQx6V8PLXMDUZEuuZrdMl6AKOsjpr6zILkL
         FilHE/xlgQxlMiq72R0kDd/VHKQtYUL8gjOIRHLZWENUEnwssxx/lWA3qEKpVpQBUSa5
         jVI3WnthWtqleVhEgEdbb1bKw3H3Q+VtrpU1V5AUYXJSOevqH+wE+FWCD9WyeLWlzqzb
         lmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7QI9lOm8/o1gPHUUmkH8Vd0Da2NVFJ9jkZyPbzQPRxJxNvXgcKp4Y/j1LEDXmODUBIwdXxwntj8/gqf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4qCK9zKUVhL4JtnN7LMpIXHmrzC/GsNPLAUF0oyTM0jmx4FD
	cVvxQrpBWVwMfEVOs8VkLGY6EE1bhZ3AHLD/IGk/ztnrC92RI8aixIyrCqWEAJsqmbc9AqbnbXS
	qCjy3nA==
X-Google-Smtp-Source: AGHT+IEEqHXHhC1dOfepFQ4McJBotwArzkUulxIcLhYJ/fKtpfgV5WqeosCA+M558p3CNkr7r/wGr0do/qg=
X-Received: from pjbli2.prod.google.com ([2002:a17:90b:48c2:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3889:b0:327:b30d:9b7f
 with SMTP id 98e67ed59e1d1-327b30d9cdbmr12852743a91.12.1756500446915; Fri, 29
 Aug 2025 13:47:26 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:47:25 -0700
In-Reply-To: <20250829-pmu_event_info-v5-6-9dca26139a33@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com> <20250829-pmu_event_info-v5-6-9dca26139a33@rivosinc.com>
Message-ID: <aLIR3deQPxVI2VrE@google.com>
Subject: Re: [PATCH v5 6/9] KVM: Add a helper function to check if a gpa is in
 writable memselot
From: Sean Christopherson <seanjc@google.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Atish Patra wrote:
> The arch specific code may need to know if a particular gpa is valid and
> writable for the shared memory between the host and the guest. Currently,
> there are few places where it is used in RISC-V implementation. Given the
> nature of the function it may be used for other architectures.
> Hence, a common helper function is added.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  include/linux/kvm_host.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 15656b7fba6c..eec5cbbcb4b3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1892,6 +1892,14 @@ static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
>  	return !kvm_is_error_hva(hva);
>  }
>  
> +static inline bool kvm_is_gpa_in_writable_memslot(struct kvm *kvm, gpa_t gpa)
> +{
> +	bool writable;
> +	unsigned long hva = gfn_to_hva_prot(kvm, gpa_to_gfn(gpa), &writable);
> +
> +	return !kvm_is_error_hva(hva) && writable;

I don't hate this API, but I don't love it either.  Because knowing that the
_memslot_ is writable doesn't mean all that much.  E.g. in this usage:

	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writable);
	if (kvm_is_error_hva(hva) || !writable)
		return SBI_ERR_INVALID_ADDRESS;

	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));
	if (ret)
		return SBI_ERR_FAILURE;

the error code returned to the guest will be different if the memslot is read-only
versus if the VMA is read-only (or not even mapped!).  Unless every read-only
memslot is explicitly communicated as such to the guest, I don't see how the guest
can *know* that a memslot is read-only, so returning INVALID_ADDRESS in that case
but not when the underlying VMA isn't writable seems odd.

It's also entirely possible the memslot could be replaced with a read-only memslot
after the check, or vice versa, i.e. become writable after being rejected.  Is it
*really* a problem to return FAILURE if the guest attempts to setup steal-time in
a read-only memslot?  I.e. why not do this and call it good?

	if (!kvm_is_gpa_in_memslot(vcpu->kvm, shmem >> PAGE_SHIFT))
		return SBI_ERR_INVALID_ADDRESS;

	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));
	if (ret)
		return SBI_ERR_FAILURE;


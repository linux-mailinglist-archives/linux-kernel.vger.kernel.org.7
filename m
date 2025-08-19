Return-Path: <linux-kernel+bounces-776633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F691B2CFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5008D1C44B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2727A133;
	Tue, 19 Aug 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rt+oUgFt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A4274B42
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645251; cv=none; b=EczN7eIxWqF42H0lig5Mfw6nZ/CACJFRPWYxVcQGMw80FMR3Cs5s+5kLhOh22TVJ0qZvDHZCraLX7H9E4tdB+oL7y6HU+3s2mNheWK3HVv5O6mGCHxDNiOxRluJPDFlCT9l/vjRoup9lhsTcWgXoAw68QQXJZZ25vsqKSH6iJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645251; c=relaxed/simple;
	bh=r1bT3KQpL5rlUPzGIefr+G7x3Fyb5KoPkPiPBLvdfDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5W4KV9d6IBlQLpQo512bnCnv7l1UqVZAG/l/UhQVnSlxBu0jAGF1LXgzRhoBTt/VOrhHrUk9j4k+D3MZy/2ELUoVBJ3BctzJHZWzmOXfbUNmjV5wPfFI+iBHBL5uUwaScnrLGCPaMdaJt3TTd0pwooEPhG57JLVXSolKbSv2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rt+oUgFt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471a0e5a33so10713713a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645249; x=1756250049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBfhOd1/j1SijzHioK0Kidj1qJEFw7epUtuJ7lG3GoU=;
        b=Rt+oUgFtPNj6lzY3U3cP9oOPE48SNsnihPfQPCiFsv2vKMLfPdO++q8/f6xWVRBWh+
         gERmFbCDd+BG9oyUMnV4IJX2LkbOoRqVCu09McrcIeK3vlrNMKL2v1pD07yjpgNXMmPY
         LZkNjRs1V7NeDK7IFxBmE0HRwHKCHYReR7roGltchjt/EaAYxd3flQabSA0xgDy6G8x8
         CeMnNRTIF/HrrDY7FOs4lqSZAExyuB9Tul0y5qmoLp1uKwU2asM9/b/FqxwFazChc5px
         jA6eqn21eEQR3gTAqHnu6mTHz0HLwUJf1DXuolQcjuBQfnk7fkc2idxNDkgFOdZsHMv7
         M2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645249; x=1756250049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBfhOd1/j1SijzHioK0Kidj1qJEFw7epUtuJ7lG3GoU=;
        b=TCl0zRhHafRkVQBMhcxwphXP4G38aCx+7EwRZXiaNB7GrM42ulgw6MnHaR9VEbOfIb
         9XmhSsUeFj4jQrRv/msQ7QsEGRZy+VUuVpz250GL5DcLUnRtczeHOfDfXifORcM0aKTe
         BXVXlAkQ5Km6tyehicflaiqx4AWfnpGf7Xo1si2JYTrH8fZlTQu69zV2YDkv5fEijwIP
         eMIPfHWfiF+m3MOb11RRTguApZPegDgk/z0joheKiMOdYPHqzcg0q2lNu56HURbtKl2p
         P7fAIwNkCH2ps0uvtmnMMZ07X3F2tqMsywel59HokJuWIjc/F6hbwC+v2i/xP+db5aLc
         Pr1g==
X-Forwarded-Encrypted: i=1; AJvYcCWF2C4OoZdAda3gSqhu2/Lwp8BcnM+EFnvQACwSQvkVmx9w9PQqORLGXOktq2XR9QEjv7s8AytnOoWYx60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAX5fVDYAHb7mZ8JPdaT0FAvbVPAj8zsIjlDn82qgZ2fWqAQ9
	7Kpm2Iv6zpn5/QlQq3q6G+K7P1L+1MEwWI5S/qXOzQHiRckGuVeoqGAoJkp8S5P4AmiE9GJQsqC
	HwW1zIA==
X-Google-Smtp-Source: AGHT+IEKCoRqAMc/f4iB5AJQOguXNLumRWLvD7jp4GBK6HZKhyz1B49plLp8M59RK1CG0fCbxXOCOG75XdQ=
X-Received: from pgbfq28.prod.google.com ([2002:a05:6a02:299c:b0:b47:3914:9769])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a0:b0:1f5:72eb:8b62
 with SMTP id adf61e73a8af0-2431b7bb318mr1490210637.20.1755645248846; Tue, 19
 Aug 2025 16:14:08 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:11:59 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564464232.3065542.6062884759434886265.b4-ty@google.com>
Subject: Re: [PATCH 00/18] KVM: x86: Fastpath cleanups and PMU prep work
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 05 Aug 2025 12:05:08 -0700, Sean Christopherson wrote:
> This is a prep series for the mediated PMU, and for Xin's series to add
> support for the immediate forms of RDMSR and WRMSRNS (I'll post a v3 of
> that series on top of this).
> 
> The first half cleans up a variety of warts and flaws in the VM-Exit fastpath
> handlers.  The second half cleans up the PMU code related to "triggering"
> instruction retired and branches retired events.  The end goal of the two
> halves (other than general cleanup) is to be able bail from the fastpath when
> using the mediated PMU and the guest is counting instructions retired, with
> minimal overhead, e.g. without having to acquire SRCU.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[01/18] KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isn't valid
        https://github.com/kvm-x86/linux/commit/0910dd7c9ad4
[02/18] KVM: x86: Add kvm_icr_to_lapic_irq() helper to allow for fastpath IPIs
        https://github.com/kvm-x86/linux/commit/15daa58e78ce
[03/18] KVM: x86: Only allow "fast" IPIs in fastpath WRMSR(X2APIC_ICR) handler
        https://github.com/kvm-x86/linux/commit/777414340085
[04/18] KVM: x86: Drop semi-arbitrary restrictions on IPI type in fastpath
        https://github.com/kvm-x86/linux/commit/aeeb4c7fff52
[05/18] KVM: x86: Unconditionally handle MSR_IA32_TSC_DEADLINE in fastpath exits
        https://github.com/kvm-x86/linux/commit/0a94b2042419
[06/18] KVM: x86: Acquire SRCU in WRMSR fastpath iff instruction needs to be skipped
        https://github.com/kvm-x86/linux/commit/aebcbb609773
[07/18] KVM: x86: Unconditionally grab data from EDX:EAX in WRMSR fastpath
        https://github.com/kvm-x86/linux/commit/aa2e4f029341
[08/18] KVM: x86: Fold WRMSR fastpath helpers into the main handler
        https://github.com/kvm-x86/linux/commit/d618fb4e43a0
[09/18] KVM: x86/pmu: Move kvm_init_pmu_capability() to pmu.c
        https://github.com/kvm-x86/linux/commit/a3e80bf73ee1
[10/18] KVM: x86/pmu: Add wrappers for counting emulated instructions/branches
        https://github.com/kvm-x86/linux/commit/43f5bea2639c
[11/18] KVM: x86/pmu: Calculate set of to-be-emulated PMCs at time of WRMSRs
        https://github.com/kvm-x86/linux/commit/5dfd498bad5f
[12/18] KVM: x86/pmu: Rename pmc_speculative_in_use() to pmc_is_locally_enabled()
        https://github.com/kvm-x86/linux/commit/6b6f1adc4332
[13/18] KVM: x86/pmu: Open code pmc_event_is_allowed() in its callers
        https://github.com/kvm-x86/linux/commit/e630bb52d27f
[14/18] KVM: x86/pmu: Drop redundant check on PMC being globally enabled for emulation
        https://github.com/kvm-x86/linux/commit/58baa649ea09
[15/18] KVM: x86/pmu: Drop redundant check on PMC being locally enabled for emulation
        https://github.com/kvm-x86/linux/commit/8709656514c1
[16/18] KVM: x86/pmu: Rename check_pmu_event_filter() to pmc_is_event_allowed()
        https://github.com/kvm-x86/linux/commit/3eced8b07bb9
[17/18] KVM: x86: Push acquisition of SRCU in fastpath into kvm_pmu_trigger_event()
        https://github.com/kvm-x86/linux/commit/8bb8b60c95c5
[18/18] KVM: x86: Add a fastpath handler for INVD
        https://github.com/kvm-x86/linux/commit/6c3d4b917995

--
https://github.com/kvm-x86/linux/tree/next


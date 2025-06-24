Return-Path: <linux-kernel+bounces-701045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF81AE6FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631B41895AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 19:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166F2EB5CC;
	Tue, 24 Jun 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbEZkEA7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CE2EAD02
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794115; cv=none; b=DLkFvFb+8JJ0mLuRyC7vDSFVp7R3cFr9zzhzcxoPU2wMWy+RIyK+Bw+ZKElDG1Mhd4g0bfG6tGLeuFdumtwItfqIqO+fVfJh3g4d21t9PqfI2dUslVxmy1h+YXWyU2yzdXFmUEGNK+519DuocoDqtknvuZj94fCCVm7afd8gEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794115; c=relaxed/simple;
	bh=xoGRkqcRrlg9bdP+o2VngYN+pkOoKbbgaNhr25ErBDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnDPfLxS8DiqJh87KPAyS1b9RBkZlkMz5L90DSLD5u9VtFhdHMm8Gv4NhbyrgP/7gBPJCk7wncB7nIYn63rs77ITlFgzm8u7QoKXulPaMYwYPf4mqNGyu0Di8e6yKjwsGAiOrXjhVz7JbXKcl93RuX2y9Cm3FfQTrXfPMFT8mJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbEZkEA7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235eefe6a8fso5937725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794113; x=1751398913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQN4PTAdpI8+s0KG51C2iHV95LXvSNOrUpiZU0NS2fU=;
        b=EbEZkEA7RoH/H00AuR4bS0Ltx3yLUBAngPEGf8kAWRIcFJ9mxpyahfDi8Kgfnw4x26
         PDKM35+9D/OI7fvSo4e0yYLkG0AKXeE84oR0nkNPhGL/ZhJVJOsbGtZc2/ETPjS1Ylyz
         khJbKfNNVAU+RwFCkCO0j/IcrQwImsf4/OffKzEwaUnJQjCKH0mXNj3PU9uN11tH7RGr
         GMOyz4NrCNBMVhkndu2czDy+tISxd0W+IBeJbRqzYLuwJ5O/e+xU/sOlUSFnqaxHnCFa
         6xM2HLjowvj05jDok8DCfL6koEQO2ahKXk5/uOwt1QdgtsAQAbbYpDDJyPnYjebflHTB
         cR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794113; x=1751398913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQN4PTAdpI8+s0KG51C2iHV95LXvSNOrUpiZU0NS2fU=;
        b=gLj6fDiCMRWUJHvb4XN3AqqwTQa1B4WwuvoeokguElpmERL+N2YCvdqN/Zf7D6XaIc
         wi+JmURMbglQoZzwRmw917JcfgSghZHrpJGryRVpuMRQmYdgvrDxq32VUYNgxJCY4ofS
         UPICesEm4bJIe/l6A8avK/nIaXA53og0TwZi32dAOeEPWVybjJpiJNEbe062QV0QZ4pP
         GA4frjdJKXgCjM/+PeMlLrwch/8a140o7qNoD+MzlgXAK75mfYOXHTpiZsSu1242In5G
         81fAzwi7uuO/faBBMqyzSQ8F7jAnfjHdogoCOzYG/P0LsXaA119/mofmCFimAlsuFKX7
         DSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZWz/wo8DkD87Vu3p2AJyvu12FUP58mI90ltXGCR3ICGImTfLom6IapKUkjCXhlJBzzMVQNIJhBWIz9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQe2/6sMD40gUJaw/1JdrGyH4BAo7mU+W5jDvSE2XAJYPoK2ft
	8rYtzD8q+eRkYCBdkxdf+pL4k7qf4riXxHbZ3vWf1Ov27OWa4smJmHxGt9ooPX1Wg5E5c13Y1Do
	5NLzzaA==
X-Google-Smtp-Source: AGHT+IFQ/VRmwuhSBCFfuC0KCukBSOBqLu5fhZXY9B/1U0E7x/EuKoeGno8nbF9wDzwFAOOOBIJHG43eZFo=
X-Received: from pgdk12.prod.google.com ([2002:a05:6a02:546c:b0:b2f:63e8:1c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac6:b0:235:91a:31
 with SMTP id d9443c01a7336-2382409e07cmr6302575ad.8.1750794113341; Tue, 24
 Jun 2025 12:41:53 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:34 -0700
In-Reply-To: <20250610232010.162191-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610232010.162191-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079325208.521395.6877256761520608759.b4-ty@google.com>
Subject: Re: [PATCH v6 0/8] KVM: VMX: Preserve host's DEBUGCTL.FREEZE_IN_SMM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Jun 2025 16:20:02 -0700, Sean Christopherson wrote:
> Preserve the host's FREEZE_IN_SMM setting by stuffing GUEST_DEBUGCTL, so that
> SMM activity doesn't bleed into PMU events while running the guest.
> 
> Along the way, enforce the supported set of DEBUGCTL bits when processing
> vmcs12.GUEST_DEBUGCTL, as KVM can't rely on hardware to reject an MSR value
> that is supported in hardware.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/8] KVM: TDX: Use kvm_arch_vcpu.host_debugctl to restore the host's DEBUGCTL
      https://github.com/kvm-x86/linux/commit/7d390a9da823
[2/8] KVM: x86: Convert vcpu_run()'s immediate exit param into a generic bitmap
      https://github.com/kvm-x86/linux/commit/2478b1b220c4
[3/8] KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
      https://github.com/kvm-x86/linux/commit/80c64c7afea1
[4/8] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
      https://github.com/kvm-x86/linux/commit/17ec2f965344
[5/8] KVM: VMX: Extract checking of guest's DEBUGCTL into helper
      https://github.com/kvm-x86/linux/commit/8a4351ac302c
[6/8] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
      https://github.com/kvm-x86/linux/commit/095686e6fcb4
[7/8] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
      https://github.com/kvm-x86/linux/commit/7d0cce6cbe71
[8/8] KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest
      https://github.com/kvm-x86/linux/commit/6b1dd26544d0

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next


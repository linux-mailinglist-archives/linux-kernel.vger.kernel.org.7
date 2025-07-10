Return-Path: <linux-kernel+bounces-726613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E8B00F43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94991542122
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0E2BE7A5;
	Thu, 10 Jul 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQ3gITjS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F929E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188956; cv=none; b=dFoM6l9xcc5MseVwm/1rK/Xu2Nf6KxSHLS+bX4hpq9xmUvKOCzlNLcLGTlGWDemf6+GH+apt/tWjWrwLA9jSgwDDvhThF2l0s8PQYa8ycd6LvQtiTfey4GHwh7BChuVdE7fGLMqoZacsrdZtBiym+aU2GS1mccoL5DWA5Aw0olE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188956; c=relaxed/simple;
	bh=1ul/6EX2TFu5Bwr8EacJ3SLgJKtIeEbO+DykWAaPkxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RihwWSMjzOl+kAYPsaXVuuPleKtROBs5Yj+ihbB0jMNeSYxKWH4d1kV5t/313yDHOpO85f9LGzadwCwG5NG3nIRPE47U8tYZz5xFy2tBh3nJ0w65JFE8+ytdAvDUDJ9xNzUtZCEhwCXC+yZw6IxRH3/SnlOv5gbIFXvUho4LqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQ3gITjS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2293570a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188954; x=1752793754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHqz9eCD/RFeYw/jO43za0KfPfvkXlqF2yHRxGQS1Xg=;
        b=tQ3gITjSFdtokI79FYPj9LuXIX/RBK/h2SMKPQYNGeM6QPGQSXCa7NPsrse7xs5Am2
         nZlvFYFaj1k4ZzdMFvTujZ6wMaEV5UvzUZpiNeQO/HGvkgrwSnMdUpIocW3bKotdPLBl
         uxqI8ENumHRf14FhKoAOp+tzBWDDunAFahpe8MqCR1PZrhvQoiqbeEmG0Ji0n0ocacHn
         HL8iHrhvSjh3X5sJGybKItUcDIv1T1YLqsaQggys/N/oXn26JiE2cVModis0Y8G6MwOl
         LJJwNIifemeeJa7Q/YGu0yqsLF7RLA4EhVFhPgamXMqhZOgNziVcT3ogGJVm0jZtM/jc
         mKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188954; x=1752793754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHqz9eCD/RFeYw/jO43za0KfPfvkXlqF2yHRxGQS1Xg=;
        b=PUM/LfumMe2S8CAojuA+G82/VuMi/2kpSEVTe0n/Q7VwaX2uG2SdIcDQHIHV4G8j0F
         PIqY+pjWOHs+sqy4JC7yLA+PDplKM25BX4hGhfaKHTkc9FBuxhBlVmQZY/T5Ffktn2cY
         H8A6oFbcUr+b8is2SVQ10d7hkWnNrv3pABfUwbHlWhHB40eQvAMQSYOO8qAtGFzJGExt
         MUftjVBXP9BfmwzSLNmfM8lPW9Coedb2ysOwut1dw1/yzkh9hEttBs+/WA8IWhY4Mx01
         PUIbWGy+IfrzG5y9nLmrNEDzde8ors+B9gipJ3JwvD5mg4DsI3JM+Hu9UfrNGEcnWTiC
         47WA==
X-Forwarded-Encrypted: i=1; AJvYcCXJvHVOJU9FRbsPzOzLomwEq4JJabBXFa3yVWtziIjIknclhgTeQBFNQYjZCIRTV3aGn0TM70CZZ91UtkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6p5OdaAJte5UyvoQpQiqPhe7DBdwXtM457ior8krDv2A2Im0
	p5eESgPCuVGy6w90//tsiqrK5FHrNkQBgIUeChgd9VQRd+7YwEGutxFM1iBx25Zpv/ZLuYOB0hJ
	a69jgOw==
X-Google-Smtp-Source: AGHT+IG9afa7XawKOsa1XA2EJ3Y4P5HUGkDBpephXVwv5/bMEtPxyOYDTOQbE9U2eIhAUKRE0QVMl0A8j/8=
X-Received: from pjyp6.prod.google.com ([2002:a17:90a:e706:b0:2fc:e37d:85dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:564c:b0:313:23ed:6ff
 with SMTP id 98e67ed59e1d1-31c4f4b548cmr477535a91.1.1752188954159; Thu, 10
 Jul 2025 16:09:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:44 -0700
In-Reply-To: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218120796.1488446.373704753489360546.b4-ty@google.com>
Subject: Re: [RFC PATCH v8 00/35] AMD: Add Secure AVIC Guest Support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, nikunj@amd.com, 
	Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, Suravee.Suthikulpanit@amd.com, 
	David.Kaplan@amd.com, x86@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kirill.shutemov@linux.intel.com, 
	huibo.wang@amd.com, naveen.rao@amd.com, kai.huang@intel.com
Content-Type: text/plain; charset="utf-8"

On Wed, 09 Jul 2025 09:02:07 +0530, Neeraj Upadhyay wrote:
> Introduction
> ------------
> 
> Secure AVIC is a new hardware feature in the AMD64 architecture to
> allow SEV-SNP guests to prevent the hypervisor from generating
> unexpected interrupts to a vCPU or otherwise violate architectural
> assumptions around APIC behavior.
> 
> [...]

Applied the KVM refactorings and code movement to kvm-x86 apic.

Tip tree folks, please holler if you object to any of these patches, i.e. if
you want to bikeshed some names. :-)  I've thrown these in a dedicated topic
branch, but I'll hold off on creating an "official" stable tag for a few days
to try to avoid having to carry fixups (hopefully none are needed).

[01/35] KVM: x86: Open code setting/clearing of bits in the ISR
        https://github.com/kvm-x86/linux/commit/ac48017020a5
[02/35] KVM: x86: Remove redundant parentheses around 'bitmap'
        https://github.com/kvm-x86/linux/commit/3fb7b83e2a72
[03/35] x86/apic: KVM: Deduplicate APIC vector => register+bit math
        https://github.com/kvm-x86/linux/commit/dc98e3bd494b
[04/35] KVM: x86: Rename VEC_POS/REG_POS macro usages
        https://github.com/kvm-x86/linux/commit/9cbb5fd156d7
[05/35] KVM: x86: Change lapic regs base address to void pointer
        https://github.com/kvm-x86/linux/commit/e2fa7905b293
[06/35] KVM: x86: Rename find_highest_vector()
        https://github.com/kvm-x86/linux/commit/bdaccfe4e517
[07/35] KVM: x86: Rename lapic get/set_reg() helpers
        https://github.com/kvm-x86/linux/commit/b9bd231913cf
[08/35] KVM: x86: Rename lapic get/set_reg64() helpers
        https://github.com/kvm-x86/linux/commit/9c23bc4fec2b
[09/35] KVM: x86: Rename lapic set/clear vector helpers
        https://github.com/kvm-x86/linux/commit/b5f8980f29ce
[10/35] x86/apic: KVM: Move apic_find_highest_vector() to a common header
        https://github.com/kvm-x86/linux/commit/39e81633f65e
[11/35] x86/apic: KVM: Move lapic get/set helpers to common code
        https://github.com/kvm-x86/linux/commit/3d3a9083da1e
[12/35] x86/apic: KVM: Move lapic set/clear_vector() helpers to common code
        https://github.com/kvm-x86/linux/commit/fe954bcd577e
[13/35] x86/apic: KVM: Move apic_test)vector() to common code
        https://github.com/kvm-x86/linux/commit/17776e6c203b
[14/35] x86/apic: Rename 'reg_off' to 'reg'
        https://github.com/kvm-x86/linux/commit/b95a9d313642

--
https://github.com/kvm-x86/linux/tree/next


Return-Path: <linux-kernel+bounces-853504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02450BDBD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0124E72C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207E2EBB86;
	Tue, 14 Oct 2025 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqwDYKuk"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1F2E5B11
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486385; cv=none; b=lyiWa0CXwa7j0vY2xvKSPVe936+6uCsXqZxEcWRIzzAiX6T5uAjSNvOcH7IfX30fOX5RGfqwu41WTQ/ZmEXvlUffQ8ez0TuQ4WlPoke+HbbuHBH05MWGP/aEjPR8+ZnGNlczoIN6WG65KxCjP5TyG0qi1qE/0yL34Nc9UmMs/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486385; c=relaxed/simple;
	bh=PZScohF8tudD9f+zO9rGSAWZ8mUMGG9nExolI4eclrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IErc+aUvXiVihQxn9LRKmlR0TdgWdJ2mzHa3+HMb4uzwy0/WUjmjh8Qax1yw+hrC78elm0XyGBW/1EyBQBQoI9+MPKeNI2i04uoX4Bx+35SSCMtL7jIsNxs3+Tcnb16+3BIGFj6okc0eCk28XbG9qVsNYWcmDccpNG/njWsIgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqwDYKuk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so26733320a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486383; x=1761091183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaDUFIHlyK8oYHhDqlcGNw1DLz8hjMou12ZxOFyoEoI=;
        b=ZqwDYKukY4t/uCkRtSBl2TalvZxH8e8xUH+N+0WRXH8h+7Ct6R4+zfYXoc42E/blUg
         kAjOceNXeeoquWrElJHKWGXLmwuZXuSSnuviIQuM3zW2nFPv8octqYVz9kAc0Y3eqJg2
         ptlz3CYeQpKdi1P2jIc2RsNwh7pGzyFpC15fiXq16J5MWXVtPtJZIa5pRDxpNs0IGEwP
         5BtL6nGPzfClPx+fmqqZFesGJohZJabrSizVDGgEAee5p/6FG5wh95FEv0INZrFCfTXv
         JYuopgZG4f9SuMSRV11gS/t9bspWPygAK+SHX65OdLIGYDmONHQ64NvmqkUt3FulmK8l
         6WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486383; x=1761091183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaDUFIHlyK8oYHhDqlcGNw1DLz8hjMou12ZxOFyoEoI=;
        b=dpna9HSF8lcpt1K5lR9USwlFXjC6QiAZW0UvylF3mT4d8dWXhY+q/2GkbRIGWbGE4Q
         iN1Qew+Ez0tcsK/HJkOTBlhoRQBGMwlQ+bXlUc/zUtIlO2sUW/QsGIRS3o6Z6V2HnwJT
         S0bSYNo8fqnWkuI/1/OuiM/kR95k9NwSMG9CfaSCP4QO1Bbq5Leobg7rzR6jglCHCAYk
         MSjD482vWJnIbo+PHaN1HceJT77aZCXZYp2hh+q+2p4rHqG97qUZe/UCBhmLDIBHWQ4T
         EapHfyMFtqgBuP33/4ZWZ6HZXDT0hzWMNE7CsNh5GqgtJi7V0JF9MCeoTa+fCet3KRVU
         1Wjg==
X-Forwarded-Encrypted: i=1; AJvYcCXduyfcBRhsBpe0965KdS24OE/xKnaUdcDmG3P5D3RDNYbvL1L0LvotwXSaBP5jlCat+8FIWYngu0R0r/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BacTWuQ5OPk3QDDYmLMpZ18/GrC8MpsTvogtnu6e96L4FZPs
	HJJZzoc9TM/Vh1I2rMhHWgG/1gCj2SItT+Lt41p3d7xo6G6SXpCTDZvQMQc8gAIx14Zof8TlPH8
	XspRQvg==
X-Google-Smtp-Source: AGHT+IHupnMvdgg7F4xvQA/ZOSwtyV+kZZn6LLBAFH6j1PMVTq9dC6yLTtq/O6EeIeGcLmGol6eOpAXKW6k=
X-Received: from pjbci17.prod.google.com ([2002:a17:90a:fc91:b0:33b:51fe:1a7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38ce:b0:32e:23fe:fa51
 with SMTP id 98e67ed59e1d1-33b511188e7mr35344102a91.9.1760486383558; Tue, 14
 Oct 2025 16:59:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:59:42 -0700
In-Reply-To: <20250819152027.1687487-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819152027.1687487-1-lei.chen@smartx.com>
Message-ID: <aO7j7lcqmL-n599m@google.com>
Subject: Re: [PATCH v1 0/3] kvm:x86: simplify kvmclock update logic
From: Sean Christopherson <seanjc@google.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Lei Chen wrote:
> This patch series simplifies kvmclock updating logic by reverting
> related commits.
> 
> Now we have three requests about time updating:
> 
> 1. KVM_REQ_CLOCK_UPDATE:
> The function kvm_guest_time_update gathers info from  master clock
> or host.rdtsc() and update vcpu->arch.hvclock, and then kvmclock or hyperv
> reference counter.
> 
> 2. KVM_REQ_MASTERCLOCK_UPDATE: 
> The function kvm_update_masterclock updates kvm->arch from
> pvclock_gtod_data(a global var updated by timekeeping subsystem), and
> then make KVM_REQ_CLOCK_UPDATE request for each vcpu.
> 
> 3. KVM_REQ_GLOBAL_CLOCK_UPDATE:
> The function kvm_gen_kvmclock_update makes KVM_REQ_CLOCK_UPDATE
> request for each vcpu.
> 
> In the early implementation, functions mentioned above were
> synchronous. But things got complicated since the following commits.
> 
> 1. Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
> intends to use kvmclock_update_work to sync ntp corretion
> across all vcpus kvmclock, which is based on commit 0061d53daf26f
> ("KVM: x86: limit difference between kvmclock updates")
> 
> 
> 2. Commit 332967a3eac0 ("x86: kvm: introduce periodic global clock
> updates") introduced a 300s-interval work to periodically sync
> ntp corrections across all vcpus.
> 
> I think those commits could be reverted because:
> 1. Since commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
> monotonic raw clock"), kvmclock switched to mono raw clock,
> Those two commits could be reverted.
> 
> 2. the periodic work introduced from commit 332967a3eac0 ("x86:
> kvm: introduce periodic global clock updates") always does 
> nothing for normal scenarios. If some exceptions happen,
> the corresponding logic makes right CLOCK_UPDATE request for right vcpus.
> The following shows what exceptions might happen and how they are
> handled.
> (1). cpu_tsc_khz changed
>    __kvmclock_cpufreq_notifier makes KVM_REQ_CLOCK_UPDATE request
> (2). use/unuse master clock 
>    kvm_track_tsc_matching makes KVM_REQ_MASTERCLOCK_UPDATE, which means
>    KVM_REQ_CLOCK_UPDATE for each vcpu.
> (3). guest writes MSR_IA32_TSC
>    kvm_synchronize_tsc will handle it and finally call
>    kvm_track_tsc_matching to make everything well.
> (4). enable/disable tsc_catchup
>    kvm_arch_vcpu_load and bottom half of vcpu_enter_guest makes
>    KVM_REQ_CLOCK_UPDATE request
> 
> Really happy for your comments, thanks.
> 
> Related links:
> https://lkml.indiana.edu/hypermail/linux/kernel/2310.0/04217.html
> https://patchew.org/linux/20240522001817.619072-1-dwmw2@infradead.org/20240522001817.619072-20-dwmw2@infradead.org/

I would love, love, *love* to kill of this code, and the justification looks sane
to me, but I am genuinely not knowledgeable enough in this area to judge whether
or not this is correct/desirable going forward.

Paolo?


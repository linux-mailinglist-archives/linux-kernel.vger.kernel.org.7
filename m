Return-Path: <linux-kernel+bounces-812252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC9B53513
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019CA7A541C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1931B126;
	Thu, 11 Sep 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/D3kTRV"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF46219301
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600404; cv=none; b=qKCYosIHePGPaUJpgqOMoDYtUaThVC/833ANaD/TgVM/PPjMCCKGJ1kK/inu5LXXeLQGQ/F5BNS6QaOY5ZVZzLNITc/I4vN4n+4SSS4BfxTTpx0QF/YQQ8ZpI+C6wxkLfe+HUStzpkquc8n2ly6mcfdXRoN9Fv+yiZfjSe//PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600404; c=relaxed/simple;
	bh=pwt3sKMZTwzi5oyWxEN+3RjXfWcYCwF9ayzyhmI5SI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cnpktNakiZUDjvfp3Texp8L/mqZjmtMU76LRKo+4sXG8aZbgUsQ0pVqwO+BJj3fIMD7DgtXR0YKuevusPUGgNLAI5F4KcufpRj6UDSZGWqDnL+WGyptcSDEk4hrVXPMg6xYb9eW6VBzz13IHd8gIgb8y1+qSO8CF5uh5i7YLXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/D3kTRV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329d88c126cso788731a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757600402; x=1758205202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrndfxQ6TSaH0WN9cPCMXVX2wBUepc9wx8k6s7n8/YI=;
        b=N/D3kTRVJ0Md3+4rJA2zr2UqhttOJGt4rNlPBF260FaGnE2MpP7SzBmDt8bla/gFYN
         NtRZ3gufW3x7wxyAApRnDVDLiKpcTraAL7Szr61YLZAtwqGrxFAAuu1nxGJ9E3BfBZOB
         jBPyyoDI4/jX2y0LKWt/h7ooOiMx5YUwcLKxgTVVdanl9WfYxCfG6BJW/jKtVRB/sRL7
         kh3bPiSFCr9r9nexa3Mrn1FLmwK1dPDJpD5I6WyqT9NdUKRxiv3ycvq5FIjcJimwTouI
         yctrR+QXhf2Kszu2aiZuk97CtmuC1HfINxEAcXwonFrxrGne630y0++tWxc39+3rLBwT
         B06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600402; x=1758205202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrndfxQ6TSaH0WN9cPCMXVX2wBUepc9wx8k6s7n8/YI=;
        b=hA4/pw4iR1uGVT88stYmvtj5WuMsnQ4k6vZFcYy5oCb6VpEsKOGmxp9NoIKf3NVLF1
         OG1xq6CDkTZztwHL6emIHyfMkWjhxgp/8n2xqj3/CZ9unWWtf11vyp0IId12yjk37Bvu
         jIh+8dLOR24mq+kOB7oRKkZcsLBRVNU31o3vHemLspvosPN054dIBiWgXw7m2tOu2hEk
         aILOk0RiSxTGPiPHp3XFx4Fx7EZLmTx2OBsq5pgGFM8/azNj60tXXyaJSI0xeyKZS2fp
         of4imKHVUeGypyumgUnk/tK/3jZBsY6wPjov2qNy2hc5lpSfFGfbag7GIn8zDdWIMW6Z
         SMjQ==
X-Gm-Message-State: AOJu0Yz2mqub/gqijNtNesGTpGseqUAl7iIzSYrDFBq7EmpDdN6BXzOB
	wXdgtpQwWb+R2N5WrHNv0lQpmbvuDq8j5Lci7xpwIvSgPkY1kgmoU375iKUfJSPCquVwSSjiuqn
	+/7Tvvg==
X-Google-Smtp-Source: AGHT+IGoY4XzeimX4Qx5PFV5aBnqr9j6/zervU1TviGGl7Q4s1fC/e4Znd1pw4jlyG8vHmJxWf0THQuaDkQ=
X-Received: from pjbso14.prod.google.com ([2002:a17:90b:1f8e:b0:327:4fa6:eaa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d448:b0:32b:5dbf:e48
 with SMTP id 98e67ed59e1d1-32d43f045bbmr22319570a91.1.1757600401669; Thu, 11
 Sep 2025 07:20:01 -0700 (PDT)
Date: Thu, 11 Sep 2025 07:20:00 -0700
In-Reply-To: <20250909182828.1542362-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com>
Message-ID: <aMLakCwFW1YEWFG4@google.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-pm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, pavel@kernel.org, brgerst@gmail.com, 
	david.kaplan@amd.com, peterz@infradead.org, andrew.cooper3@citrix.com, 
	kprateek.nayak@amd.com, arjan@linux.intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Xin Li (Intel) wrote:
> There is now broad consensus that TDX should be decoupled from KVM. To
> achieve this separation, it is necessary to move VMXON/VMXOFF handling
> out of KVM. Sean has also discussed this approach in several TDX patch
> series threads, e.g. [1], and has already done a round of refactoring
> in KVM [2].
> 
> The simplest thing we could think of is to execute VMXON during the CPU
> startup phase and VMXOFF during the CPU shutdown phase, even although
> this leaves VMX on when it doesn't strictly need to be on.
> 
> This RFC series demonstrates the idea and seeks feedback from the KVM
> community on its viability.

Sorry, but this is not at all aligned with where I want things to go.  I don't
want to simply move VMXON into the kernel, I want to extract *all* of the system-
wide management code from KVM and into a separate base module.  That is obviously
a much more invasive and difficult series to develop, but it's where we need to
go to truly decouple core virtualization functionality from KVM.

VPID and ASID allocation need to be managed system-wide, otherwise running KVM
alongside another hypervisor-like entity will result in data corruption due to
shared TLB state.

Ditto for user-return MSRs, AMD's MSR_AMD64_TSC_RATIO, and probably a few other
things I'm forgetting.

I also want to keep the code as a module, both to avoid doing VMXON unconditionally,
and for debug/testing purposes (being able to unload and reload is tremendously
valuable on that front).  This one isn't negotiable for me.

And most importantly, all of that needs to be done in a way that is fully
bisectable.  As proposed, this series will break horribly due to enabling VMXON
during early boot without any way to do VMXOFF.

In short, I don't want to half-ass this just so that I can get overwhelmed with
more TDX patches.


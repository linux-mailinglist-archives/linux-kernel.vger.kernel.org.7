Return-Path: <linux-kernel+bounces-861259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9356BF2336
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18BA734A7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7D274B50;
	Mon, 20 Oct 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK/fEzt/"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557D225A38
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975302; cv=none; b=ghbCZizdrRi7bMmrnLRrQWzrxyp5pPbqcZ9E9CuA/5k/grUBJEZpPq+uIhSBB+NsYQY/ZG3mj4HaSEhqjN3pGERko+Bp/WNJbx0A6dBz0mLHGGXZFJ8BsxIO55s7AzoLdoblW2Wgx3Na828AyY9LBGsgyaRwqBebtGlAdcM8eiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975302; c=relaxed/simple;
	bh=mY4lDRBu+hq4QHSprdmPqj71tWsfEl20Vy/4TMM5oGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7Z4m29wXnYhuMkQ5H3lG5IcNUhjxLm/D76ajvwkRrpVHkzzjMlhE+tQO1XZL48zoZ1sZt1BEQXBIg1SIhsP8xhDRaMAZO2cPDHVsEpOmzU59YczetXUdq7jR48R3gAHWS3Zw8bHjTmHtUymwQQMJsc7xbQ7oa5zgQ0Wr7o2Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pK/fEzt/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso56755675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760975300; x=1761580100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w48hujcBL5OMwKpsjz0a8i5lMom7fWaSgjQnj7gmD0k=;
        b=pK/fEzt/3RZsx+CxXxbDP8dXATaYy75RHExb2oKRcBo523tkspk0MNJ6PN6oRSi2vL
         u2nxEeRq8De2WnH4VrKGJ7gVWWEJ2AZSX/51KFHSw4JDJrJPjb3hn3qERxPmGK0j75iD
         ux8V6lmIERMOMWpVa5gvUPwXAoqahz9yXgtK64oLTYVO2bibkDFlZEHUmWkOO/Ic1vxY
         Jgo8TrXQSq76uTttNKIiST/ToxzYJmUPCK8aqak86UuyoaxGRrDzJ6i+3WH/NGrenrGo
         X5P2/AWs2cL/roVieYZJACfJpvkbkep9bj+/MMFaNFvdOldg/JgYA1rtqdInhn1PTbvM
         EAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975300; x=1761580100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w48hujcBL5OMwKpsjz0a8i5lMom7fWaSgjQnj7gmD0k=;
        b=Ckdw7hw8UIjhhVg5NGm+E7FNpM621XnbhElucY2sy6JBN2z5FN0skRdueMfmA42BbJ
         b255RD4lzXGZfS3PUCwskdOKeL7Hlrrr85UADRX+1ONrMv0G+4aVHAAWEh9Gpd/Bzl2Z
         ZBEiWxfsxYZZaUzEF2SNARj44Cj12Rdy6lU7g+rOqm8uK353C3IQGUQExbWTfkqWr3h5
         PdkedpLZ7lAX8wXxkbSEJXso+SholVfde7vJSTYbGKm1JBv1To/wN1TLF9hU9oOOBTZ1
         kcUzReoh6PPzjn1Xll1eTJMk9iMJin8AYGdEQL6p8mg0aRqDG+jIqmR31BstoQFPGTLW
         5LFg==
X-Forwarded-Encrypted: i=1; AJvYcCXTXHpgrL0tyt/X+WxEMXymuWeF0wEjnXwodMiz97DQhrUNiE7F8ZYXBGlu7pD2ztsKnEh9CLfGFWKC5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYh+5XZChacF+/DP+bk7gYi0Gk5QJBUWPCun4/60yhvFYQdQXk
	gKDWOzv13Rqh1P7p2oYr7Ntx4qt3zpbTrrMbbLgZs+ogiFHe45yeKPlP6TV+QvuG4NYfJ0AJaY7
	72HOL0g==
X-Google-Smtp-Source: AGHT+IHsykl8GJIbj53Vtm8KX55t6u0dzJKaIOjx9CEFDBi/P2I8JNoJoHyi1ga431I0fD/ZNSfHcjJI0oc=
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:339:dc19:ae60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:286:74e3:3889
 with SMTP id d9443c01a7336-290cba42e4fmr194123895ad.55.1760975300068; Mon, 20
 Oct 2025 08:48:20 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:48:18 -0700
In-Reply-To: <20251017011253.2937710-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017011253.2937710-1-jon@nutanix.com>
Message-ID: <aPZZwoqWV8cJG2HH@google.com>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Brendan Jackman <jackmanb@google.com>, 
	"Ahmed S. Darwish" <darwi@linutronix.de>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 16, 2025, Jon Kohler wrote:
> A VMM may not expose ITS_NO or BHI_CTL, so guests cannot rely on those
> bits to determine whether they might be migrated to ITS-affected
> hardware. Rather than depending on a control that may be absent, detect
> ITS-unaffected hosts via a CPU feature that is exclusive to Sapphire
> Rapids and newer processors.
> 
> Use X86_FEATURE_BUS_LOCK_DETECT as the canary: it is present on
> Sapphire Rapids+ parts and provides a reliable indicator that the guest
> won't be moved to ITS-affected hardware. This avoids false negatives
> caused by VMMs that omit ITS_NO or BHI_CTL. For example, QEMU added
> bhi-ctrl only in v9.2.0 [1], well after adding the Sapphire Rapids
> model in v8.0.0 [2].
> 
> [1] 10eaf9c0fb7 ("target/i386: Add more features enumerated by CPUID.7.2.EDX")
> [2] 7eb061b06e9 ("i386: Add new CPU model SapphireRapids")
> 
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Fixes: 159013a7ca1 ("x86/its: Enumerate Indirect Target Selection (ITS) bug")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  .../admin-guide/hw-vuln/indirect-target-selection.rst       | 5 +++--
>  arch/x86/kernel/cpu/common.c                                | 6 ++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
> index d9ca64108d23..3cfe4b9f9bd0 100644
> --- a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
> +++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
> @@ -98,8 +98,9 @@ Mitigation in guests
>  ^^^^^^^^^^^^^^^^^^^^
>  All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
>  and Family/Model of the guest. This is because eIBRS feature could be hidden
> -from a guest. One exception to this is when a guest enumerates BHI_DIS_S, which
> -indicates that the guest is running on an unaffected host.
> +from a guest. One exception to this is when a guest enumerates BHI_DIS_S or
> +BUS_LOCK_DETECT, either of which indicates that the guest is running on an
> +unaffected host and would not be migratable to an affected host.
>  
>  To prevent guests from unnecessarily deploying the mitigation on unaffected
>  platforms, Intel has defined ITS_NO bit(62) in MSR IA32_ARCH_CAPABILITIES. When
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c7d3512914ca..3de4b51d8681 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1361,9 +1361,11 @@ static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
>  	/*
>  	 * If a VMM did not expose ITS_NO, assume that a guest could
>  	 * be running on a vulnerable hardware or may migrate to such
> -	 * hardware.
> +	 * hardware, except in the situation where the guest is presented
> +	 * with a feature that only exists in non-vulnerable hardware.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
> +	    boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))

Uh, don't you want something like this?

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..8c4bc9b5d8ed 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1364,7 +1364,7 @@ static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
         * hardware.
         */
        if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-               return true;
+               return !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT);
 
        if (cpu_matches(cpu_vuln_blacklist, ITS))
                return true;

Functionality aside, this is quite heinous.  I don't see why the answer isn't
"Fix the VMM to specify ITS_NO".


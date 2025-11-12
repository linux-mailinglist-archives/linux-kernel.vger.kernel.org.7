Return-Path: <linux-kernel+bounces-897804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6184C539F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D78A7344902
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0F346A0D;
	Wed, 12 Nov 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggSu3pVJ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCA345757
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967703; cv=none; b=s47wdn6ehNR/1Hw+V0hKpEXi/LxngCthePfTUkcAF9/WjXu22uRRwPLQxUBHpRpsqX+B/+n8As8gINzKrwIUN5snFNtC0IwTBc8TNJ35TdP6SbKrPI9AAvWJ11B9GAHdDGxvopUhoVxS/uCvu2G8uVj0yL9HoI+t7QTN9IU8pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967703; c=relaxed/simple;
	bh=9Vl4M+L7saM4H5FI9WoIntBj62joT4QeAS05d655lsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lfkq3/jFrMEkbV8Q0JuAZ5MCpYR0Ye6cfUEMZggpJO/wwvpeXjNtjzUtGJwg83zqb5hOecR7D49B2lMDX+pG1/87S1+RLgCD1WaAxOsc4PCqCzNi4+Xtwj36OtC9tJNatW8kCFFK871fYMApzzn0s/yXdwpUri2N7v8WKK9iPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggSu3pVJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295592eb5dbso11865475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762967701; x=1763572501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=86qJtDww2XHXYjGdCBBHyykKWyscomPO9oojHmUWOnc=;
        b=ggSu3pVJqSFerjEAGe1wRjxRPxtPY+ZhrT5jiwuf1KgX25tWUjy+XT6BZBJttiBTM5
         /tJj4i31h2RPaycEqIE1hUvRuxmmg6BMe3Iw6QlHNz54DJQu0Z0kEB5pGmC7ENNB0yrb
         WA9dltwJTS0LygM2joX+c3wPXnCPKcFQcuqNvfnHIWudUhT0PtnYJZ5LD1pcEmCMyE2c
         Cc9DfdFFenBRKOeZzWGNcf0EmBGFQYcfzdZmH+RV71YOF48PO1InFUGhPkoPusNGQRCA
         v36KLheJQH2uSuNPkqbhF6w8vIYWNZDLqCk0BlNt95IgUP6zW6wSqD6RO4KKh4InX21E
         aW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967701; x=1763572501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86qJtDww2XHXYjGdCBBHyykKWyscomPO9oojHmUWOnc=;
        b=Gde+Ihm4LHOhBluUwC5W2LWwXNQl5UeWNjZVZamLkZqLTpJ7ONeLOc6iwZxjlsK12h
         bJMFgKYqDt8TL/XGsMgDBQcykyf15YdxwkLMJE4PMBcl1o1Z9GsBvXF/5BYYJrkJco45
         OxR7fSuoTw1EiQKUJSRzrnT9r6TdC0u/S8+yjWLlIls36HTJf5okHbmu/CwInHyJ2hN/
         7uG6Up1jWpg7Ue8ixVUp1vhi8dgzpZ73A/8dNMyjiCcXcPzIYKJPZtQAvyKBg0uphxzy
         NUyj7JCVx5GpFgNdTIcVRKkeFi1DdCmEH95Kj1YBuzVydFwOJTPWJOILMs/8nRZmTKuS
         kReQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcf966zONWN3ypa4GVJZH7lD1u4yy2V2AIt5lFsKHzVDQMfadD3upJ5ab8IAwSavXdHy2dfDecXLTDtt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDzcevh7VN0nHRJPgQ9pLzQFtwBZMve9212YH3h3ulDPFoREE
	sgQqDf/HahMZC/GaPMu0l9SdCNqVmU/IT5/T3fdeccg/L8LNWu66HQujUzPnpxVekm/IOz+8sn7
	2VG5q1g==
X-Google-Smtp-Source: AGHT+IGrMR5JgwNv/Me2MYMypHfVwaZ3yclITiMGko+pOjGEm/IXIepqef+u9s5d279WEqGMcQz9Rix8Ljg=
X-Received: from plcr3.prod.google.com ([2002:a17:903:143:b0:273:67d3:6303])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:28c:b0:27e:f018:d2fb
 with SMTP id d9443c01a7336-2984ed2b896mr45483095ad.6.1762967701625; Wed, 12
 Nov 2025 09:15:01 -0800 (PST)
Date: Wed, 12 Nov 2025 09:15:00 -0800
In-Reply-To: <20251112164144.GAaRS4yKgF0gQrLSnR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-5-seanjc@google.com>
 <20251112164144.GAaRS4yKgF0gQrLSnR@fat_crate.local>
Message-ID: <aRTAlEaq-bI5AMFA@google.com>
Subject: Re: [PATCH v4 4/8] KVM: VMX: Handle MMIO Stale Data in VM-Enter
 assembly via ALTERNATIVES_2
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 12, 2025, Borislav Petkov wrote:
> On Thu, Oct 30, 2025 at 05:30:36PM -0700, Sean Christopherson wrote:
> > @@ -137,6 +138,12 @@ SYM_FUNC_START(__vmx_vcpu_run)
> >  	/* Load @regs to RAX. */
> >  	mov (%_ASM_SP), %_ASM_AX
> >  
> > +	/* Stash "clear for MMIO" in EFLAGS.ZF (used below). */
> 
> Oh wow. Alternatives interdependence. What can go wrong. :)

Nothing, it's perfect. :-D

> > +	ALTERNATIVE_2 "",								\
> > +		      __stringify(test $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, %ebx), 	\
> 
> So this VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO bit gets set here:
> 
>         if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_MMIO) &&
>             kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
>                 flags |= VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO;
> 
> So how static and/or dynamic is this?

kvm_vcpu_can_access_host_mmio() is very dynamic.  It can be different between
vCPUs in a VM, and can even change on back-to-back runs of the same vCPU.

> 
> IOW, can you stick this into a simple variable which is unconditionally
> updated and you can use it in X86_FEATURE_CLEAR_CPU_BUF_MMIO case and
> otherwise it simply remains unused?

Can you elaborate?  I don't think I follow what you're suggesting.

> 
> Because then you get rid of that yuckiness.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


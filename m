Return-Path: <linux-kernel+bounces-727230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBAB016D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118E8188C60C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BA219A7D;
	Fri, 11 Jul 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K4OQB0am"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61918DF6E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223873; cv=none; b=CTI5kmklyE/SYgr9pnK+1M6TVS+X30AzakBEkHD+zhcDNY3rewAcGa4dGL2oYpUIa0J5cGxE3LimY3xDWnKMqRN6z8zx4d/E3xuKJyh0VNsIBrHnEDuFkih48ZusYCmX5N0y/sCdDcDwPzUbHU3FRJCpwsDRnGAhTxrQZ4F/RNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223873; c=relaxed/simple;
	bh=z8h37/P+/Go2N/WRw7N3Bh2YW9ttrIhdTMNeQsayI1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1XtkfS7T95PqIFka+xwvY805UetJl1wi4wepdKZlmBJ+kdSLCMhClaSppZ7K9xCI5rG6rx0s82QG0MilYlzAsCLssTHfERP0jr+bNb/o8eQO3xLQecLMudvdCv4+wXMJ5qYrD0xhyK60ZAWJKhdpVHaMlgP1nGZQ2pJop/eZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=K4OQB0am; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1121616f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752223869; x=1752828669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLc+yAyLpgSsVL0DY27MbVKG7PMR2I1NMPg5UEUaSYE=;
        b=K4OQB0amdd4XDc0xIgjIUKIA7KOpnYL9ZnXtzWEcHVqy40zZ1qwYMH+78nAFS36fgP
         ZKN3ucEg2YGZAcesweH3KkV5sh4kDxbi7HcWjq5ZBVXTZOgPU8OULctVcQNksPgazee9
         AkahTFw+vforK/0KBuWkEC3gd2rycTIcQ2+lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752223869; x=1752828669;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLc+yAyLpgSsVL0DY27MbVKG7PMR2I1NMPg5UEUaSYE=;
        b=LdUDWHJkuudYR2fhv1URaoLvzBe9oZKYaubxFhKiim4jJOFn4XgFoKo6xxqmKOW9DZ
         Nfd0H+1KefgYCvVf56QTsdXf7oNeQiGSzbyH8lKETgsQ6mHN84FBpv5nSZRIPluEWTZs
         RBF73uXidGzHA8rhgArVTg1XOQ4zZkK8kTqcYbtruXrX6h9vzzfOK4QfwByaiLkWhQaF
         /g/6Hrq6t1Pokai5hAzdlHVF0cGp1y1FnUmBvgUUG0T0SonG0jPEaIwhxe96dXVhKWKc
         BwZT8E9U5vMF890jnWOStgiB+FBHYXJ5KaftrvfLeeZwL0A3YYP1tKH6MRW9DnXt217C
         0clQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRrawKwqySAMYhDSAqevMgaM+tck7J6xUDgqg0ZQIGHzyI46knfPoVW8SAlzUbDWJgaQ5AUXo/W1BZoa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9n4WYZ6fU/MiUoxv22odGPVD76yu1rTk90Qdd+OzlDYGX/ux
	X9fl72cIQB/j2cAKn8o9sjIWDQiBJm2qw05YTiLPT0BboGHY1D1PAul9DV67TdZZP8M=
X-Gm-Gg: ASbGnctfCtIJ8mDW0VOz8E9zPPOrWYZRI6+YKUjph+7a3HxE2r98HS1EZTaR/jGY9vV
	jSWyKXlthEBJaiTx5xIWTv8VnTrAfgsCKnGrWB4pAWI9DjpgPadIrM/JSfXickHDqFv+2w3q1cB
	ku8mD+vylUr887mcdKGgYM8bDEaWPusCysWN1P3xwpE5/kvPs0ZocH1nCd8FAgHbxO4Xf5Bgye0
	RFLiBpz/97QHiN9NA5nBWRaBK4PbpiCIXQQTafVP665ZGa/G6tpw5IerrJ02RSw0EmL9PsJGAta
	1MF6y/Q2Qb3BKtJQuEcuaRNQ9qMUabXl7ET15t+W5i8wxw6V6EFMk0jYYbona1oNwAv7+mA+LQC
	fUA91mXAUSpehc805dI/Zq26IkOLqqwr25Q==
X-Google-Smtp-Source: AGHT+IF/p5JseJYyVQuyUwqnGmfxYrQbso5K+hNI8FrIUfZsi1LkIHNT8yNbMfG/FKzdOjwH5E48Pg==
X-Received: by 2002:adf:9c84:0:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3b5f18d2e76mr2229476f8f.46.1752223868625;
        Fri, 11 Jul 2025 01:51:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2087sm3957272f8f.30.2025.07.11.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:51:08 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:51:06 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kai Huang <kai.huang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Mingwei Zhang <mizhang@google.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH v3 3/8] x86, lib: Add WBNOINVD helper functions
Message-ID: <aHDQersZPA9D8fJb@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kai Huang <kai.huang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Mingwei Zhang <mizhang@google.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>
References: <20250522233733.3176144-1-seanjc@google.com>
 <20250522233733.3176144-4-seanjc@google.com>
 <20250710112902.GCaG-j_l-K6LYRzZsb@fat_crate.local>
 <20250710143729.GL1613200@noisy.programming.kicks-ass.net>
 <20250710154704.GJ1613633@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710154704.GJ1613633@noisy.programming.kicks-ass.net>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Thu, Jul 10, 2025 at 05:47:04PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 10, 2025 at 04:37:29PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 10, 2025 at 01:29:02PM +0200, Borislav Petkov wrote:
> > > On Thu, May 22, 2025 at 04:37:27PM -0700, Sean Christopherson wrote:
> > > > diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
> > > > index 079c3f3cd32c..1789db5d8825 100644
> > > > --- a/arch/x86/lib/cache-smp.c
> > > > +++ b/arch/x86/lib/cache-smp.c
> > > > @@ -19,3 +19,14 @@ void wbinvd_on_all_cpus(void)
> > > >  	on_each_cpu(__wbinvd, NULL, 1);
> > > >  }
> > > >  EXPORT_SYMBOL(wbinvd_on_all_cpus);
> > > > +
> > > > +static void __wbnoinvd(void *dummy)
> > > > +{
> > > > +	wbnoinvd();
> > > > +}
> > > > +
> > > > +void wbnoinvd_on_all_cpus(void)
> > > > +{
> > > > +	on_each_cpu(__wbnoinvd, NULL, 1);
> > > > +}
> > > > +EXPORT_SYMBOL(wbnoinvd_on_all_cpus);
> > > 
> > > If there's no particular reason for the non-GPL export besides being
> > > consistent with the rest - yes, I did the change for wbinvd_on_all_cpus() but
> > > that was loooong time ago - I'd simply make this export _GPL.
> > 
> > Uhhhh, how about we use this fancy export to known modules only thing
> > for this?
> > 
> > These are typical things we do *NOT* want people to actually use.
> 
> So kvm-amd is the SEV stuff, AGPGART is the ancient crap nobody cares
> about, CCP is more SEV stuff, DRM actually does CLFLUSH loops, but has a
> WBINVD fallback. i915 is rude and actually does WBINVD. Could they
> pretty please also do CLFLUSH loops?

There's some ancient pentium M where clflush is a no-op (or at least not
getting stuff flushed enough for the gpu to see it), but we still need to
ensure cache coherency with the non-coherent gpu, and wbinvd does the job.
I figured this out with sheer desperation over a decade ago myself,
it's pain.

There shouldn't be any other reason for i915 to wbinvd.
-Sima

> 
> Anyway, the below seems to survive an allmodconfig.
> 
> ---
> diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
> index c5c60d07308c..ac3cc32a4054 100644
> --- a/arch/x86/lib/cache-smp.c
> +++ b/arch/x86/lib/cache-smp.c
> @@ -12,19 +12,19 @@ void wbinvd_on_cpu(int cpu)
>  {
>  	smp_call_function_single(cpu, __wbinvd, NULL, 1);
>  }
> -EXPORT_SYMBOL(wbinvd_on_cpu);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(wbinvd_on_cpu, "kvm-amd,agpgart,ccp,drm,i915");
>  
>  void wbinvd_on_all_cpus(void)
>  {
>  	on_each_cpu(__wbinvd, NULL, 1);
>  }
> -EXPORT_SYMBOL(wbinvd_on_all_cpus);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(wbinvd_on_all_cpus, "kvm-amd,agpgart,ccp,drm,i915,intel-gtt");
>  
>  void wbinvd_on_cpus_mask(struct cpumask *cpus)
>  {
>  	on_each_cpu_mask(cpus, __wbinvd, NULL, 1);
>  }
> -EXPORT_SYMBOL_GPL(wbinvd_on_cpus_mask);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(wbinvd_on_cpus_mask, "kvm,kvm-amd,agpgart,ccp,drm,i915");
>  
>  static void __wbnoinvd(void *dummy)
>  {
> @@ -35,10 +35,10 @@ void wbnoinvd_on_all_cpus(void)
>  {
>  	on_each_cpu(__wbnoinvd, NULL, 1);
>  }
> -EXPORT_SYMBOL_GPL(wbnoinvd_on_all_cpus);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(wbnoinvd_on_all_cpus, "kvm-amd,agpgart,ccp,drm,i915");
>  
>  void wbnoinvd_on_cpus_mask(struct cpumask *cpus)
>  {
>  	on_each_cpu_mask(cpus, __wbnoinvd, NULL, 1);
>  }
> -EXPORT_SYMBOL_GPL(wbnoinvd_on_cpus_mask);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(wbnoinvd_on_cpus_mask, "kvm-amd,agpgart,ccp,drm,i915");

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


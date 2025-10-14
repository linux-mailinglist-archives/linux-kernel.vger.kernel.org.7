Return-Path: <linux-kernel+bounces-852600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D657EBD96D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964C31927DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70333148B4;
	Tue, 14 Oct 2025 12:43:50 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368C313E27
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445830; cv=none; b=pvm48v7aG7bosDoZDVNa3hA6A6G1icw5Ev+PAd+IKm12TBB5g2XU6jJ3bRH1Rw+L5GqNbta6Lb6Iwo1fhlTwSAtq5oxBNfTGn80vz/qqgkpdR3jg5y4WpTQIfCnOO4ww/0Jvf91oyolO7uFcZ9YmN3cDv2ykTE1eJsxfRRBSrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445830; c=relaxed/simple;
	bh=RIfWvbV5qR2Jc9YKaUmr9BCFgP/FhvLoQholBe4TpL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQJcCh/+7W9plQ2dyeD28ZZTAcSX5MwFlYw4geCk0QI/qWC3ZUspH5vmgrMSCue8VoaykY0CLzYpvSjmSZUgNuvuwg8b+r+8Q/Z1hfwPA7XAi8apwuHF8HpTBDQBwgxRBvG3s+NvVB/81PmR8WVB5Z6780L56coq+DdKvXa3eiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-554f1c13bcaso1892981e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445825; x=1761050625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNxEU7KyfBYhfmf3Lx2LLvPMpGLQ7HkB7d0pkrjoK9E=;
        b=oTbbCTBY1lxK6D0YMotN9Id2jXRcdk4exdhIhjRbJRVT3T8Ats2WkD1SzrZejtUyrv
         a5jcMQhmaSMsBxGO4qGwsuUcLzT0piWQEgwdtqwsEmKDclUSxmm3dr/jCZjzWIc00XMR
         SND2fo8NcaI0QaxHH/RFWhyyo9oKHeKzqgluTyPYuNgq/lZLtZBZYPSNNx4o7SYjp6Lw
         zhOEbO/1/hOYZfSnNFkS919l9Z0xGEMs2HPo5tD9fmWjpd5BwaxJ3CuR2oZj1/S7FoNN
         pXFiKMTHU01r+eiWOTVJyb/nedmPUWAbtQFPRL98c5qzcpDNu/Fo4gV85kxF/QCYPBpm
         T7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmVuDnUalhGsMPfLh8GUx4E6Dw7U45gsnmM0otqTXRNOoQkFU0c6KTzccxUXGQTdf+47ttajZub9zHt28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKVO4lzGI1h5dNYh2fi2Ge4get/A0P7HTN2mAw+zLCyNpyToF
	1dZnAeY4e+KmyKm9s4LYH0eQxFNqLSXSpocxMEmWtZCoyYI9w+TcP7mN3ahM2NnJ
X-Gm-Gg: ASbGncuN4583v8DmwYVv51QaNSkipmvlrRegNavVMN2Vf7/3o97222jeazzw4+AiiL6
	5qlAeI0KjkAGdjZw7lfw8JVBSMzBQ3Ly3tvj9cOZKe/gfW54gpvxlKJ0ZVJ5Use80gjf5gdiwCt
	4+iYARLq+w+olUKd0fQIw3J31FNEbv8QgiSXKwxgspO+kl0AwlEqmPXnbzlXpVCYI9rMWb4LzP1
	3ap2Hc9BeyJm6BFc+t7Wak690f543XnVgXMt9A0QqYw79djTmSRLdi4c+7LzbAiaxScVtyQc+Jn
	kdU/rrNoLcnCcbnZR58oy8wOSyDU9+bxUQAlefxRSY3j/GfjnYe4h/kXoAx4GRikbDOEVVDMlIS
	i/K6dM+OGLQPleAiKuW3iBMehB6Patrt71QWQvh6hAF+HQoPXLSVT/e2cWEak3bOEhS4oWOZVY8
	aFGbEYP8s=
X-Google-Smtp-Source: AGHT+IEXX+dVcXisbURR7uedMO/VKMFKGHAKDTVIk0ljD7vL8t2WOaHsZCapuoW+Rnnii6/mWsD+eg==
X-Received: by 2002:a05:6122:2225:b0:544:7d55:78d6 with SMTP id 71dfb90a1353d-554b8a7f802mr9186085e0c.2.1760445825234;
        Tue, 14 Oct 2025 05:43:45 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f02499sm3946505e0c.6.2025.10.14.05.43.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:43:44 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso5888491137.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:43:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgrehNhUnHgufnnBvRf/bLZSUHr+g/OOJ2Kb+Vy8r41tpNvz/4X2x5VeC0PWQWZwjM7DlQ2wgZ5maU2Ko=@vger.kernel.org
X-Received: by 2002:a05:6102:a51:b0:5d6:3554:2dbb with SMTP id
 ada2fe7eead31-5d635542e5dmr527665137.16.1760445443647; Tue, 14 Oct 2025
 05:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com> <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 14:37:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>
X-Gm-Features: AS18NWC3_aMtxy2dnl_M3on8VhWCTedTTMBJW4khUhDoS9xyzcvkRTZ1BETpTHo
Message-ID: <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard MC
 scheduling bits
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, thomas.weissschuh@linutronix.de, 
	Li Chen <chenl311@chinatelecom.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Mete Durlu <meted@linux.ibm.com>, Tobias Huschle <huschle@linux.ibm.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andrea Righi <arighi@nvidia.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hoi Peter,

On Tue, 14 Oct 2025 at 11:42, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 14, 2025 at 11:25:53AM +0200, Geert Uytterhoeven wrote:
> > On Thu, 28 Aug 2025 at 14:57, Peter Zijlstra <peterz@infradead.org> wrote:
> > > Now, when I look at unifying those config options (there's a metric ton
> > > of crap that's duplicated in the arch/*/Kconfig), I end up with something
> > > like the below.
> > >
> > > And while that isn't exact, it is the closest I could make it without
> > > making a giant mess of things.
> > >
> > > WDYT?
> >
> > Thanks for your patch, which is now commit 7bd291abe2da09f5 ("sched:
> > Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") in v6.18-rc1.
> >
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -41,6 +41,44 @@ config HOTPLUG_SMT
> > >  config SMT_NUM_THREADS_DYNAMIC
> > >         bool
> > >
> > > +config ARCH_SUPPORTS_SCHED_SMT
> > > +       bool
> > > +
> > > +config ARCH_SUPPORTS_SCHED_CLUSTER
> > > +       bool
> > > +
> > > +config ARCH_SUPPORTS_SCHED_MC
> > > +       bool
> > > +
> > > +config SCHED_SMT
> > > +       bool "SMT (Hyperthreading) scheduler support"
> > > +       depends on ARCH_SUPPORTS_SCHED_SMT
> > > +       default y
> >
> > This is now enabled by default everywhere, while it was disabled by
> > default on most architectures before...
>
> I'm not sure ARCH_SUPPORTS_SCHED_SMT counts as everywhere, but yes.
> A fair deal of the architectures had all this default yes, and I had to
> pick something. Can't make an omelette without breaking an egg and all
> that :/

OK.

> > > +       help
> > > +         Improves the CPU scheduler's decision making when dealing with
> > > +         MultiThreading at a cost of slightly increased overhead in some
> > > +         places. If unsure say N here.
> >
> > So it should default to n?
>
> That's just help text that got carried around. Many of the architectures
> that had default y still had this text on. I suppose we can change it if
> someone cares.

Please do so.

> > If it is really needed on some architectures or platforms, I guess
> > they can still select it explicitly?
>
> There were 4 cases:
>
>  - arch doesn't support SMT
>  - arch supports SMT and lets user pick, default Y
>  - arch supports SMT and lets user pick, default N
>  - arch mandates SMT
>
> Of those 3 are still possible, the one we lost is the default N case.
>
> Old configs that have =N will continue to have N. New configs might end
> up with Y.
>
> Why is this a problem?

While old .config files will see no changes, old defconfig files do
need updates.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


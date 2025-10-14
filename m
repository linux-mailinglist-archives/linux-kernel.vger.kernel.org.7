Return-Path: <linux-kernel+bounces-852210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5270BD870C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19472351DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2DF2E7BB5;
	Tue, 14 Oct 2025 09:32:02 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F852DE1E5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434322; cv=none; b=mcESoNvDVrKRmmLAGHzjRzGcjqIm0KqIPrMNxJJb3YjgZ0zz0pSO/f6fcfcsMwOYyvPZm58NCjIR5B6HEKLpY/Fo9Dg3ScAW3dmrmTI4U6Wbo0dcZmYsBC0cUmZIIX0BOmNWnkAERPMzPQ0XKlvDLL70TIjozqZjzK1x77FkYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434322; c=relaxed/simple;
	bh=pkxa8puQtgGel9mbOE5DfNSU9jrsaW0tXQm2k4FGibE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh6KabR3H+E/B9FDBnklI1oOlw3Zftf9egtsjPE6Ce1fw7cNnnWSb3gKQTK5Pj11DP+OzuG5tamLLQABCWK20O38XVZms1H6JcbhJKrTDXtUtRMGdWTQNNhLfeQO525WNEScgBBBAKeh6QOKiAnsdToJS/VHsWP8LWJt8u8lYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42f7b17f9f7so40968045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434319; x=1761039119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpBgoDCD1NZyU8yXWBy8hXEWr5MI7i37aL5+z3xg+Dc=;
        b=b3eBHnSkFjJ+ddwURlTSjBaPfvLi4su8zZapsCGbjo5M2yoL4KvknH4hpcvzOi5Wnx
         S1T2yydFaN4DKC7pnGfrOL44IXGL5gxSugfXlBI5/pTACNJUtitzwLaw29Ix7IkV3dAj
         7Sy34CMWg9wYqUpOOTPCZQebMHqugoxSIgN/MOSX/RFfy6h/XxJgtSlbB+rKfgw5b5qd
         gMCu4mICfmmaM2bAIciEzo6kZyqYRU/bOWLXTWgmWDU2BDRnv5rCJljFUmyh6Gdg/DjE
         kL50n8M1Rr9blamT83RovgVy5I7LJzKRXZL0wcZ50VDQgcC4lxLByvfTquiMa2kS/MGw
         EI3g==
X-Forwarded-Encrypted: i=1; AJvYcCWCPbVLPdB3qvqmRJxeQWlR9s+wT6IEMdI+67X8syCPU+7yUg0z4xVojis9RSVF6Iq4c/5kxZVzplIfxJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkYHrEXLsDlrMVH7Yl8jHHZgVdCz/Z85PN0qlm1lY1+lyzh63
	qTi2VuNI3VAm4ZibEY/HwRc85G9cwlRfBSQrUAhmZ/0BbMxmQvlMX3DmAgmlTnpG
X-Gm-Gg: ASbGnctmG6HUA63G8029wbOR/Ao9rc0okYFynm3mz50/8YI+v8Fd482tkXiWRUZBBjs
	gJgGwdI5yGSo9nYn38DgwfLercEECL36TfX2pkVcWTJTOaKb69pEVwhQ6ik01qX+S4QXyzh9tW7
	N29HwGNsslfQVOqhSyMIGJBosFzUzoQSz7brZ+0XJloPbAfxwbUHYJAdFlrJCop5UIgD3xzKkNJ
	jXsdgiVbujELqi+1jAimYsKSIIQiO8wISqVb7g/Xn1Hkg4m+kOYSN7L9FfJqSuvYU4ePak10UMA
	cAbprhYS1QnuQxCr21TWXOFXEFvfl0/YL1/TE/2+BwaBvNIEw9OCJ2+zI9cnN9nWI8PJOf6/bW+
	QM8coSgrEET6POtvVuLzfe5y8hXIXXx2xM96k1YaIr7EMJPEuqNPSLvA4AcqwL9EOKYibxAIntk
	JZJpUA2Ro=
X-Google-Smtp-Source: AGHT+IF+ySr4SWETIPAn4yEdtgQO84PO6XTGe3x/4W9DoPxcVPhvvB6HnvKjdFF0IgCenc2fDyWJOQ==
X-Received: by 2002:a05:6e02:19ca:b0:425:8c47:13fb with SMTP id e9e14a558f8ab-42f873d1c2dmr263642985ab.17.1760434319483;
        Tue, 14 Oct 2025 02:31:59 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9034235fsm60808725ab.24.2025.10.14.02.31.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:31:59 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-428551be643so43059895ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:31:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCY8EIqr8AL2d1WDuzdM6P+XY/UjFvmP6/LzBgrYq/hiTnVNSd0MWSBH5odW1IyQP+zyhvEqPLwUJ7H7k=@vger.kernel.org
X-Received: by 2002:a05:6102:161e:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-5d5e2278aaamr7047842137.12.1760433964277; Tue, 14 Oct 2025
 02:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 11:25:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
X-Gm-Features: AS18NWBTuiqEZg-SFYGrxqYZDbYb0o6XrCJ3YERltbZU5Ho7kkUOk_8aIEnP1Zk
Message-ID: <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
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

On Thu, 28 Aug 2025 at 14:57, Peter Zijlstra <peterz@infradead.org> wrote:
> Now, when I look at unifying those config options (there's a metric ton
> of crap that's duplicated in the arch/*/Kconfig), I end up with something
> like the below.
>
> And while that isn't exact, it is the closest I could make it without
> making a giant mess of things.
>
> WDYT?

Thanks for your patch, which is now commit 7bd291abe2da09f5 ("sched:
Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") in v6.18-rc1.

> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -41,6 +41,44 @@ config HOTPLUG_SMT
>  config SMT_NUM_THREADS_DYNAMIC
>         bool
>
> +config ARCH_SUPPORTS_SCHED_SMT
> +       bool
> +
> +config ARCH_SUPPORTS_SCHED_CLUSTER
> +       bool
> +
> +config ARCH_SUPPORTS_SCHED_MC
> +       bool
> +
> +config SCHED_SMT
> +       bool "SMT (Hyperthreading) scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_SMT
> +       default y

This is now enabled by default everywhere, while it was disabled by
default on most architectures before...

> +       help
> +         Improves the CPU scheduler's decision making when dealing with
> +         MultiThreading at a cost of slightly increased overhead in some
> +         places. If unsure say N here.

So it should default to n?
If it is really needed on some architectures or platforms, I guess
they can still select it explicitly?

> +
> +config SCHED_CLUSTER
> +       bool "Cluster scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_CLUSTER
> +       default y

Likewise.

> +       help
> +         Cluster scheduler support improves the CPU scheduler's decision
> +         making when dealing with machines that have clusters of CPUs.
> +         Cluster usually means a couple of CPUs which are placed closely
> +         by sharing mid-level caches, last-level cache tags or internal
> +         busses.
> +
> +config SCHED_MC
> +       bool "Multi-Core Cache (MC) scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_MC
> +       default y

Likewise.

> +       help
> +         Multi-core scheduler support improves the CPU scheduler's decision
> +         making when dealing with multi-core CPU chips at a cost of slightly
> +         increased overhead in some places. If unsure say N here.

Likewise.

> +
>  # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
>  config HOTPLUG_CORE_SYNC
>         bool

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


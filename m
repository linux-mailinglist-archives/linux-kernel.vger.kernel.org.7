Return-Path: <linux-kernel+bounces-852943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5CBDA4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA558627A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0429A9C8;
	Tue, 14 Oct 2025 15:12:24 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9773002B4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454744; cv=none; b=HOCLzEYIfc++Dyg6Iye3vzPlq0pNKv8M5Vm6rPFKSl2wzE9mLRBTR8VXtA3Zl+K55cYjUD0pWR2mdX/KDFp0L19F3VIuq3M3wm9B2TRvfqeOeQumP8/vrJCByoyANa+cr2EBC66sXrB+hMwrxUWzldTKPQBI4/wP9BjzWqLVPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454744; c=relaxed/simple;
	bh=ldtXdhDcD5noXeIiZQgZJBdMoBquMUFmAjt6sfVA5AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWGdZfW+S890vaTz6bqnubpfUh/gPVq1abwjGmmEQrm1RfUuxHHDEm2KDCb4TMEl8q1feDu1lFcehsyeM8jdP3Wpep2wya1cRox1Ur87mTz+eGeCc4cDqVFXup9gTMjBb/Nl4ut9jZwxhh5v5U/xojZJ8r79INXlJrs+smOBk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8572d7b2457so839841185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454741; x=1761059541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ckaUVvDg5E1Kv0tRjD3tkk4SrmpuBncmnCZzWhCIjg=;
        b=xFl64bfy34aHOd3FTZ2VDOpMjdKjdmux7auqrI2/0RxDcE50NlRaRWP3txMASihvg7
         0dgrxU1+x8ss+LT32st/RsRqG67BT4bXhEVE1MDhBmsyb0i/zyYl/Vzcp67u1L9BOlXE
         XRrGn96IKvtZLbesMD0LNpaAIXsTJuMf9lZaB2yTxhRfqAzBRaVWFHjfh8VU8wOVhToM
         Y2L/WAeRn/86tCeKQMA9IVSb5EXxCPaRpl7UCK3JTpU1b456bX4gmgN4mGF58Z5UxGKV
         RZti8DBtthAQ+DPB5CkzDafr2lgj6bpYBWlUNrfncCtOc/giFCSaVP17mPq18PZFl8sK
         ksjw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdIAJg2O5YZqhJI+3XRhnteblC7tVlRQ2k1OEaaUVZpOTvcw18CeKv7d1uz1AGPmJNX57WXOGE+xclMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKSakjgsmqvcvlKGg44tNbpJEmf7CbxniqKOOuYjWv9EgG5fD
	zIhNTkYu9fLvJalRHnEpdrNpFlqJMkaTMZtx9IVej7Yv68bgv4c7DqlcmkR8WUxh
X-Gm-Gg: ASbGncv+mcvWE20bhRHqI4E3v4zO7ReD3bleVCsFu5Xzcjsu+aXmErxH7Ib2Eil5QWI
	JscT9fjeFkPeAyOkF9Snbwb9D+Iwmu/KaSWNwfW/X/0CL3w9QTf4aKKcEIfHnP+TvpgiX9PO98b
	XALVzIYijWT7Yvg0Irse7Wm+B0Ooy27Y2sIMJFRC/LByULbcHX3iSQSSkJ5FincFrl0TiPaz1sJ
	hDQUa3+kMlZ50/DEaI50Oi5y3k03R/TC03bQyivowwU9FQQTLjBVNFT7uO67+v3L89C2wKVjzxx
	LFLsrKRsGPiB+bK2xHgsS/LJWdVeO586A7IiS9uIjzYcSQ0HU/1xAdOVCzptBu9eAeXGssHAt07
	LGpiIoaVJeS05egeMcKbSfcxIKpjeNcpBnINzvIo3DEX+/aCLPmSfaiKuuxK6ryxRe02AgvADXe
	1sJp5TxZs0+sC8KVJ60w==
X-Google-Smtp-Source: AGHT+IFNyDOjKiBEjzPUcM4yiPqUgt8E2Z2fR6GO6fAbwcduD2fOCqgIrWnigHNRE/c2iEk/oldhSg==
X-Received: by 2002:a05:620a:2b8f:b0:878:215e:e3b3 with SMTP id af79cd13be357-8836d7432aamr3153500785a.8.1760454741427;
        Tue, 14 Oct 2025 08:12:21 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d8a70sm1219871985a.7.2025.10.14.08.12.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:12:21 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87a092251eeso84403436d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8zzh/8v01v5G4UXpXZTGvU16/MbAgECriPPoEEUpOUv1tMJJuCmvaHYIAkT28Zc//aGaKPK56M/M3jsI=@vger.kernel.org
X-Received: by 2002:a05:690c:6a04:b0:781:556:b7ee with SMTP id
 00721157ae682-7810556c4f0mr161656307b3.7.1760454307894; Tue, 14 Oct 2025
 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
 <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com> <20251014141730.GZ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251014141730.GZ3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 17:04:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpFdjDJrMbK8+6aO=O8c8p68RUGe0o1Mo4PMmFLufc9w@mail.gmail.com>
X-Gm-Features: AS18NWCARfLQt44MvWjqR1ybmDP5uvpIwul8XKi8euGj-rQtyjldCOHWrbLZbQg
Message-ID: <CAMuHMdXpFdjDJrMbK8+6aO=O8c8p68RUGe0o1Mo4PMmFLufc9w@mail.gmail.com>
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

Hi Peter,

On Tue, 14 Oct 2025 at 16:18, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 14, 2025 at 02:37:11PM +0200, Geert Uytterhoeven wrote:
> > > > > +       help
> > > > > +         Improves the CPU scheduler's decision making when dealing with
> > > > > +         MultiThreading at a cost of slightly increased overhead in some
> > > > > +         places. If unsure say N here.
> > > >
> > > > So it should default to n?
> > >
> > > That's just help text that got carried around. Many of the architectures
> > > that had default y still had this text on. I suppose we can change it if
> > > someone cares.
> >
> > Please do so.
>
> How about we remove the recommendation like so? There are many help
> things that do not have a recommendation. Mostly these options add a
> little code and the most expensive bits tend to be gated by
> static_branch() so it really shouldn't be that bit of a burden.
>
> CONFIG_SMP was the big one for the scheduler, and Ingo recently removed
> that (he did an effective unifdef CONFIG_SMP=y on the scheduler code).
>
> ---
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ebe08b9186ad..3d8e2025a4ac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -57,7 +57,7 @@ config SCHED_SMT
>         help
>           Improves the CPU scheduler's decision making when dealing with
>           MultiThreading at a cost of slightly increased overhead in some
> -         places. If unsure say N here.
> +         places.
>
>  config SCHED_CLUSTER
>         bool "Cluster scheduler support"
> @@ -77,7 +77,7 @@ config SCHED_MC
>         help
>           Multi-core scheduler support improves the CPU scheduler's decision
>           making when dealing with multi-core CPU chips at a cost of slightly
> -         increased overhead in some places. If unsure say N here.
> +         increased overhead in some places.
>
>  # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
>  config HOTPLUG_CORE_SYNC

Thanks, LGTM!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


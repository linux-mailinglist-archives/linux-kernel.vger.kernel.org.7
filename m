Return-Path: <linux-kernel+bounces-835156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E207EBA6667
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B41D189A1E4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A52472B6;
	Sun, 28 Sep 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="asix7SXw"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918672614
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027105; cv=none; b=K4Lwxa81WM/u4Y/q6TnyzOBhlrzfGML0QI4b8DCk4NDv1d1T7ir54fj9+kduWSP5yCbXGr4KzMrQtkWFJlw6SZfq2EN304kBK54XRsEu2Rd9GXBTx5k4yfKJTZn/pUmhAme8OxcjBYWXg+ILogQcdk5QiN+DIV5MU8ye5SeCPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027105; c=relaxed/simple;
	bh=y1o0NktTiBEjBpOsSj/+9mjkA32Qt5ndvIyNBx4gntc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBkbOY9JUZP91oVxec4XXy0Fw1pEqoNz0YLUMNu4EFPccCyINWztdUov96ooHm1ctdOd0SjcCpdYRp+6c6qgGhnGgYY8Ar8pJdkJG9xCho5DLzpVc40GlBdnou4A0iSaSSQ+/sH1Ij4icsmAnYQ20ZZEe41lRQn/F7RFZdfA/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=asix7SXw; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-643cd58c678so340191eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759027102; x=1759631902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDDVDZIdgHY10IxWeSmThIWnM3Kfl8SB2Uc8qwV0eGM=;
        b=asix7SXwsSIdHyHeR0zGuCLJBz+BNzd6M+VkUCC/c5AjPAWzRHxWmvFWChtHPKlPwc
         4yb0Fy6t9jxb5ndZ/56x64mTcWlos83ImV4zoEnf983IG4D7RuN/0R8OQMu7Ztg5s12Z
         s39O8eqf4//VNdp0Jjhv3jhv7LSMMNfm7NZ3T+VdR69d6TMqRbmUfZDzDXXKJ9qG8Nj3
         AF+uEGegnQF9mi3gkXIB0wjr/VIz3QtAA+xQUVInv5kbcku+o6G/aaDHOCwxKZ7M6AWg
         4TqQjMPW9JPPnW/sj9MJ1WxyziLy+mxJHOfQkNVu9Vd5glLyaZMmtevrIvjMZ+J/SGJu
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027102; x=1759631902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDDVDZIdgHY10IxWeSmThIWnM3Kfl8SB2Uc8qwV0eGM=;
        b=pkIkw/33HKUWHQJQV0/ciBhmfNX6K3nQWt0ztYDShwGxR1p3/8sO7QWOFSXKPxFoMG
         TeOJhmwQY2EdVrtxGNBYDSamshMeBMMdiLbI46cYl/HdTK+WYm8DQj8YqDSh4uoyJTg/
         xmOtxA6nZgFWN4PlI3MJz4+HXZtrlS0Z3AzOktuFwLiPpUqUC98sqpiLlk+pfMbA275T
         A/DS/UStbCXEJjTxpk6K55p3QYmo93QsVGcimRNbmJB5lW/ffQRWmbrX9EE0RcNGmZJv
         Qt4vb4cByQ/9mkYwVAkQYT2VLRlDe/hGy2FzCRPqNq7mK3OQv9b+bAKoY36/ue/vMK07
         xJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+nSu2wEjTEGFlDlUN3a36bOWE+q1sJhWsl/mD0xEzK6T0qV6jC7F5kzs2gCHJ3TvqyylqgM4YQshXVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0khDv2Adfe9OSuKwKOyMqZt4Osf0lDU3vv6h4j1dBVJWTPtrp
	Ak2LKr7ifN4Njle4FZWOR4PvMocboup4xSjiMFo1OpCE9o8NyfELdwSoUhLAbgpS8jb4U11vJVv
	X1v6HIWr8G0V3f4HS8A9gVGUCsLHCKBcjSRHJlS68cQ==
X-Gm-Gg: ASbGncv0IfzOEpkn0NlY83vPB93pkCPRkS3G6FhnOLUWCaImHkQqXT0KJQqxkmYakKU
	MAD+p6WNCOaeT68N2RG2JcdGeuK8CB9YzkPh6cryFJWI/iJGjY3cVKGxU57VatvMfZro1SwLVx2
	wA5gE7wX/uwIxAHGLBilr1VmsSOMvPnHKNa1HFXnU6Qr1hhajPefqRigtIhaDkn13QS3FJzhjH4
	iqV52Wr4cKLXDuargRggNGsTVw71pI=
X-Google-Smtp-Source: AGHT+IHN9SZKPMfskn9LtN56hlvjdE/PVxPJY1sD2/2M2FEMKbIx55CZ1Hog94gS2psvQYARXktJ5bJrXOdSq0er7i4=
X-Received: by 2002:a05:6808:3022:b0:43f:7287:a5d0 with SMTP id
 5614622812f47-43f7287b062mr1202461b6e.34.1759027101799; Sat, 27 Sep 2025
 19:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com> <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
In-Reply-To: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 28 Sep 2025 10:38:10 +0800
X-Gm-Features: AS18NWAN-ZpVjYdN0iAwRHsiQoYm1lDRDU85PF8Qq2B5t-2l3rsp0TxumU2MhVA
Message-ID: <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Doug Anderson <dianders@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ziqianlu@bytedance.com
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Doug,
> >
> > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/cpu_pm.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/nmi.h>
> > > >  #include <linux/perf/arm_pmu.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/sched/clock.h>
> > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu =
*pmu, int cpu)
> > > >         return per_cpu(hw_events->irq, cpu);
> > > >  }
> > > >
> > > > -bool arm_pmu_irq_is_nmi(void)
> > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > +bool arch_perf_nmi_is_available(void)
> > > >  {
> > > >         return has_nmi;
> > > >  }
> > > > +#endif
> > >
> > > Should the previous comment move here, AKA:
> > >
> > > /*
> > >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI tu=
rns off,
> >
> > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=
=E2=80=9D
> >
> > >  * however, the pmu interrupts will act like a normal interrupt inste=
ad of
> > >  * NMI and the hardlockup detector would be broken.
> > > */
> > >
> > >
> > > > +static int __init init_watchdog_freq_notifier(void)
> > > > +{
> > > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > > +                                        CPUFREQ_POLICY_NOTIFIER);
> > >
> > > I think you need to do something to prevent this from happening on an=
y
> > > platforms that override hw_nmi_get_sample_period(), right? These
> > > cpufreq notifiers will be useless in that case...
> >
> > I understand this is not a problem. watchdog_perf uses
> > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> > CPU's main frequency. After we make such a change, a larger value may
> > be used as the period, so the NMI period will become longer, but this
> > value will not change after the system starts.
>
> I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
>
> u64 hw_nmi_get_sample_period(int watchdog_thresh)
> {
>   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> }

I have added the maintainers for arch/x86.

1. cpu_khz can be understood as returning the base operating frequency
of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
downclock to 800MHz under low load and overclock to 4.4GHz under high
load.

2. Because the event provided to the PMU has the
PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
fixed; it varies with the CPU's core frequency. When the CPU runs at a
frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
it will lengthen.

3. After our modification, if the architecture is not integrated with
cpufreq, it returns 0 and will not update the cycle. If integrated
with cpufreq, it returns the maximum frequency supported by the CPU,
so the NMI cycle is only slightly lengthened, with no impact on the
actual hardlockup detection function.

4. I have also conducted tests:
stress-ng --cpu 1 --taskset 1 --cpu-load 80
echo 800000 > scaling_max_freq
turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectively.
And the NMI cycle became approximately 30 seconds:
[ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1
[ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1



>
> On PowerPC it's:
>
> u64 hw_nmi_get_sample_period(int watchdog_thresh)
> {
>   return ppc_proc_freq * watchdog_thresh;
> }
>
> Neither of those are necessarily based on the results the cpufreq
> reports. ...so therefore I don't think you should be taking the
> cpufreq reported numbers and assuming they're OK on x86 and powerpc.
>
> -Doug
>

Thanks,
Yunhui


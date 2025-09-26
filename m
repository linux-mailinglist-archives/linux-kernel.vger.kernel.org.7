Return-Path: <linux-kernel+bounces-833841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19986BA330E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66103BAD37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11462BE024;
	Fri, 26 Sep 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G0n7Nqss"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11B2BDC35
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879477; cv=none; b=UK8w4AcR3u0R7lYE0oTPSalnSKG1XpzGaoCMl3y582D8uyqzV6YDEct5+TBkLv0DnXJTICdBvw0Qg33j0CnPnS3ISsGIrrHEEGrTJsL7ktX5+ks+0R6bMOQtnMKGLTxoEnNpwQrqEZKt04AN7D5b+Ng3g6epVxPBrxhdqTQM4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879477; c=relaxed/simple;
	bh=B/7QQgyqHSm4AZXbTcSg97A8gq1X1CH39AjApJhmXr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVZPCRrUx9tYkGWsR1LgALEoF44HDaY7gHGA0qjeGk9zoySLcBcdcnt05jglaRu4gOE6Ya9pjXzyyWUkXOBSb3PMsYzf/VBXWqyQgYHjANwVmJ+iCibzX4pMGstDjYtb1dhbf6m0Kt2pDeVgA94JsnXgjyx6aOaSr3klkbPhI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G0n7Nqss; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7a9c15464f7so192333a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758879475; x=1759484275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5FmCZ7m0CyShB1Ycdtz4U9JEqoB4MdA/m7HVOlr6mo=;
        b=G0n7NqssAzj0IG6CY+5Qi/lsv6pyp4tX8yLowhiSP4mEo1a5zTTGdKPh+Vcz32SSv7
         VrGACAxwyfhxcCAXEx5Il62yjT9yLvO1IQc1E2hIxPNbI9d09gWxht9RfS+rAy8osM5L
         qsbnHj1eoBUDsSMV8Y4b8weoNajm03mzhYNXqDT4heEzUw+V4JMH1h0d6AnWssO/u+Ow
         g4fwuVCzauhfsyJhp7KH/mGdi46kP0/X0te2b61fmg6V7xfz5qIlvtnCldaqEpvhpVI2
         Bb1sLFRQOUkCIfaSh8B1VRJ2+jHQWHug6VSUqtVoJ1uwEtRTjb9E5nlO8js9t+DFrZgO
         vtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879475; x=1759484275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5FmCZ7m0CyShB1Ycdtz4U9JEqoB4MdA/m7HVOlr6mo=;
        b=IWTC4Pai7bONaN1yhHtsAuNkTPLzE5NtLZrJeJL6o89Ty1FqICl6C3pPzRqOcVM9rV
         TcMw3LAup2daVOmVsKt4H2hFpx7WpPRYLKieIDxVhMsCqz7qe+4xvTiIXIWawv6p2jwG
         JBVyYu1PDoonh6W0oEp0v79apZe8MZoL5QwMglgXNXbq1PnpKDrVYBwzkNcZfJWFUk9h
         AJXzplGWRRR6S+vu8wyX9RRh7C9AVKCPCPclCM6HVxVxCTZN3iz3QYKtRR/OZOkVObNB
         jru/NCY7SU//MnejMezrKlD8i/kxzIl/D9aUddyXV0JBPCP3QMGdS5GBGTNCe3EczQkB
         cEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk20HWa/nygguuYP0NTkB3Ub75To4wu/h7MQLRfxRo8yfBLqGmE33SemPyWMZmn0NOmPNIGdb0+evTfYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2nBPfJf3BiiVwUz+2FonEiF2OmiZoBt8nWcxlZMfk6qP4ZRE
	/VNm4XOmcSPJT/JX+5NZTzShSwg32gvBNP8oYVBEW9wOHCujInPxTmCY3dHDNrAZXMl1IOJ98H4
	vFo4t3v5N/MNw9C+XYsqnQGc1/d67yu7UHF+pASQwDg==
X-Gm-Gg: ASbGncuM+QUa9j9eOUHFo8LOwt8JN5N/+S2VvjOZzifbR6ymLktAlFBgMGEXSbYJPL0
	wyS32D2vK2fzMdML8n7qqVbJGipMvCv0mi6wJQ8WALL2/pFbLOoAmEhAFD0UlzbbroGoFEPGn/H
	sFK0zWZQ/WAFbO6sf9I21p7khZr1A3UTZbxPc9JHcfcnEAqUUrRP7LXhohxXvAUGEDBsq/rt0je
	wfaFB/xP3Cov7vS8JnkZbKdvDg0jmQkXtJ18w==
X-Google-Smtp-Source: AGHT+IEc3BE14yCdZtCENJr4UXyf6Y8XkhqfpWh+WHahYzWW5GLDg7SSMeNNAS+2Kw/XzX0+d+blEeRda/r+amoNwkc=
X-Received: by 2002:a05:6808:8843:10b0:43f:5218:878a with SMTP id
 5614622812f47-43f52188986mr2126658b6e.22.1758879475127; Fri, 26 Sep 2025
 02:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
In-Reply-To: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 26 Sep 2025 17:37:44 +0800
X-Gm-Features: AS18NWBUD0z6jg0TusFj1nphukSzt5aTNsZRJ0rH-JxFSgQYIIkepAcYdgJLzRk
Message-ID: <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Doug Anderson <dianders@chromium.org>
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

On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > @@ -17,6 +17,7 @@
> >  #include <linux/cpu_pm.h>
> >  #include <linux/export.h>
> >  #include <linux/kernel.h>
> > +#include <linux/nmi.h>
> >  #include <linux/perf/arm_pmu.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched/clock.h>
> > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu=
, int cpu)
> >         return per_cpu(hw_events->irq, cpu);
> >  }
> >
> > -bool arm_pmu_irq_is_nmi(void)
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > +bool arch_perf_nmi_is_available(void)
> >  {
> >         return has_nmi;
> >  }
> > +#endif
>
> Should the previous comment move here, AKA:
>
> /*
>  * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns =
off,

Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=E2=
=80=9D

>  * however, the pmu interrupts will act like a normal interrupt instead o=
f
>  * NMI and the hardlockup detector would be broken.
> */
>
>
> > +static int __init init_watchdog_freq_notifier(void)
> > +{
> > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > +                                        CPUFREQ_POLICY_NOTIFIER);
>
> I think you need to do something to prevent this from happening on any
> platforms that override hw_nmi_get_sample_period(), right? These
> cpufreq notifiers will be useless in that case...

I understand this is not a problem. watchdog_perf uses
PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
CPU's main frequency. After we make such a change, a larger value may
be used as the period, so the NMI period will become longer, but this
value will not change after the system starts.

>
>
> -Doug
>

Thanks,
Yunhui


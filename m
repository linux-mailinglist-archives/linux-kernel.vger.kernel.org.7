Return-Path: <linux-kernel+bounces-889700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DCC3E460
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9B0C348BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E82F12C6;
	Fri,  7 Nov 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LSQktzlJ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D62EF655
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483360; cv=none; b=P+xO3Od3bkKI/KJwxjv7xAFYCMQ8GpJQi5nT3OUtE1BnaG76+kgjlhlxvzqvUce03T3WrQQ8E8Y+1vJY75BZbnTHFbWvmF7aXo5b0D65ubk5dXOAk+8StvwxBJK6qxUTnILXwIHWolICso1rKoEzm800XbgBLru8SkH5Ok4X56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483360; c=relaxed/simple;
	bh=uYfqsgI+4yKP34dOe9Nf3RalYvhP+CX4KYMz72LP0Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufwdT0Z5HcifLKo4rFCb7srIvezitPQLRzozO9uy4NEf8yfESMiiyHU3MJNAFiDyrelxdPp2WO/oTMMZPha6ZbED8CloIeZ9++l1GA5/TYkdQMEtN8vR+UBxX+6qAHGvCYvVcP5G2eUIIebUyrbf5/i5rSicvCc/93q3qUX5qvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LSQktzlJ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-44fe903c1d6so67440b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762483357; x=1763088157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta4pHybjsRd5oAb5H49GhrRgg2InYaGc8HOWjDuWw8Q=;
        b=LSQktzlJNDOWNxrCj20o34ZHK0ILbhIKUhX1ve58RrWkfT1iCPIP1yBhfvpqOclJRL
         /t8Sf4ZOVzCi4n93EKb2y1H27UKAjXWBt7jrPB1RLGy/Tji2iduu/HCOSMC546s12onR
         paFkysj4nMTJWo3W9bQgnd+bq8w9jnUaFTc9P1PDZaKlvr9+qKsWKGiGXbL4/fzlx+ql
         SG/Ku2QVjnQK2BxWzk+Oeh5n8pIQ/D73vUrZ8LXX5+ucm+nInikhsWTHlLXmWO+bbHW+
         LNj6KssNQV1oFqgeDAqkP3CWx3XYWaEPTN0IKrwr01b1rf+Gx/nyI63KDxpoCECXf6oK
         oUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483357; x=1763088157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ta4pHybjsRd5oAb5H49GhrRgg2InYaGc8HOWjDuWw8Q=;
        b=Lz8+EyVbpc96FK8n0N3jD4sD5advzzsZTC/moKWzQhEQ9A6dj9UH2a0SnjmXJ7X1by
         RWyu91olt1u+hx/aaRi79Pq7Bj8aZcB1AoSyDUiCFyLDzTq0cbrJiIdnjumh3pYPdbQO
         6b6hRMm51nx0/ufAgz+MV2P9ENMF68KAnQ9TI7PAlpYJtY3/e83X63/o4KqPAX0YwVZg
         77vd3Ll0Gm9bsW5/CqWaZfs6nJKS9zC0O5EcPv/hVN2kQVdotcar2MaIAqIqyQHd9ngL
         INAppBi6OP0ZRxRUJ2iZXvCa4jSKESzA75IaiGWVXYxdvSC8sd7+HG+Yp1DhQS1+U/x+
         tABA==
X-Forwarded-Encrypted: i=1; AJvYcCWMM/W/k+UesPBqMEGanpv5mTBHhK/eqUMLlrs5291TQK0dAjxAOEi6LMD5I3v53+Ugjkj+bBcV9NQh86I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSP6ueVNOgVTAxAVaisrduorDH0eM2fZ/c2nFP+3gThk83Dr5E
	scDmcE4sGabvSQigwyDomWtnNy5G0Xj4qFicTCT/3zfwGUp0vjDXgRxZbhWax5AyjGW0gacSEc/
	qqD5WYZIbX1AwlkItB2KCghEdiAuzVOz1SYhvSbtd+A==
X-Gm-Gg: ASbGnctWyqX2HgMsJmvWh33L+Q5gHRNABaeKesq46Izqsz/Xn4ci7JV3yVtZ83YbZqI
	ohxwMXLdD2/98D3IKhOhaKlkcYWAfY7CP7AnAruHebTDYtpWiVE1saOeTV5YY/IGThy0kd1hMkV
	oXOTq3Hf1+fwHGsyw0uGO3UEz8NNP0hmzIfrhXsVcY/trQzRO0k6HP8Kg0FsV+GY0Vypp0huu1O
	EpJfqWjWNcqdZnqmNYSJfcJBwsXxVGrrluOT0kcIiiBqko4ajEpjetX4mDfcYyIzLCKchaZ5WG0
	ChoZw7WA
X-Google-Smtp-Source: AGHT+IGb0n2soPVhA9HW3Yi/ug81lmtTpcvsCQ9ShMeI3zEImc6F3+dHOysOTdbZsRZbSPkSfqhccOrjI+KKkLT4UmA=
X-Received: by 2002:a05:6808:f8d:b0:44f:e3d2:59db with SMTP id
 5614622812f47-45015d583cemr1045696b6e.16.1762483357292; Thu, 06 Nov 2025
 18:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
 <20251014031425.93284-2-cuiyunhui@bytedance.com> <aQixsIQXTjYyhRVj@willie-the-truck>
In-Reply-To: <aQixsIQXTjYyhRVj@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 7 Nov 2025 10:42:25 +0800
X-Gm-Features: AWmQ_bkNdWjndV3isxnVf7u1V6RwPPlMP2i7v5fPfn_48ruw1DHahvSQ2HKDsok
Message-ID: <CAEEQ3wk5Ru4-=4Ecnc6kQAAbR57806xxYTz0o1z4KfgZE6Cg6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	dianders@chromium.org, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Mon, Nov 3, 2025 at 9:44=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Oct 14, 2025 at 11:14:24AM +0800, Yunhui Cui wrote:
> > @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const cha=
r *str)
> >       wd_hw_attr.type =3D PERF_TYPE_RAW;
> >       wd_hw_attr.config =3D config;
> >  }
> > +
> > +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> > +/*
> > + * Safe maximum CPU frequency in case a particular platform doesn't im=
plement
> > + * cpufreq driver. Although, architecture doesn't put any restrictions=
 on
> > + * maximum frequency but 5 GHz seems to be safe maximum given the avai=
lable
> > + * CPUs in the market which are clocked much less than 5 GHz. On the o=
ther
> > + * hand, we can't make it much higher as it would lead to a large hard=
-lockup
> > + * detection timeout on parts which are running slower (eg. 1GHz on
> > + * Developerbox) and doesn't possess a cpufreq driver.
> > + */
> > +#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > +__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > +{
> > +     unsigned int cpu =3D smp_processor_id();
> > +     unsigned long max_cpu_freq;
> > +
> > +     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > +     if (!max_cpu_freq)
> > +             max_cpu_freq =3D SAFE_MAX_CPU_FREQ;
> > +
> > +     return (u64)max_cpu_freq * watchdog_thresh;
> > +}
>
> Why does this function become __weak? Neither arm64 nor riscv override
> it afaict.

Would you say there=E2=80=99s any particular issue here? If some architectu=
res
might need to override the hw_nmi_get_sample_period() function later
on, wouldn=E2=80=99t __weak be a more reasonable choice?

>
> Will

Thanks,
Yunhui


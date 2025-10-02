Return-Path: <linux-kernel+bounces-840787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3CBB5708
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C183A45BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26226D4C7;
	Thu,  2 Oct 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNFY4mN1"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F417C77
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438741; cv=none; b=IUZYigTZPMVzqkcbASRszkXDCyOZt07zU0j/J9ugExwxKrjKhWLUiZ15aSz9RxYI+Qf2dew15G0I835aahGQlVpy9v6cX+0UILzHNpS6B56UnRvuPSj1xvJYLMT29Dkkdn6kOECkvKtgo/hi6bx/iSrWlNMIpB8yEUjQie9MJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438741; c=relaxed/simple;
	bh=ypXYPlYFCvozZqIuyC9dj4joh++U/ltIN4PHfwfhO5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUVMQ2ti27GJK2DA4xGjMtCJ7daUuhc5iaw2So/PcaBhU7+XdUon1j0ENp57htuqPTYnn3n5dD3MkLah1aPZg6f7Durd1/ArZA7/ZaQ+jYZ2+a8CLcyt5xCvcHhUk04qFb4uWKtosABwNSHfkSo6hQKC5TTL51JLkP3Gf/QPkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cNFY4mN1; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bbb587d6dso882225e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759438738; x=1760043538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzfulOt3RuNjCZqZotlbZaUDHr7ww1cs1ieFRe/EaTg=;
        b=cNFY4mN1lIeYKmQiPXQHF0tZF6kbC8IYXFKTdk9RhlAaVi3zJomtAGPsR3rmee/HYZ
         PjclCZWyaMEDqHDz47J3NerY8xDwWyuIKN7JTel6RFOi4Ls/NiRSHOiuAN+I5UDklvx5
         C+SQ25AfDyzgwsv/gyP9Ku6sOIAoDK1S4urdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438738; x=1760043538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzfulOt3RuNjCZqZotlbZaUDHr7ww1cs1ieFRe/EaTg=;
        b=ek6AosYIMwKqIw1+3JZQ8hTIqXKhfrL6NmVyUXWU4/wQMEKBBTsK4DjvFSETrFHQoJ
         pyy2W1o7Q0+CvIYbTwxgb9Oj6qctc/hJI3iWv6J8atzBG/nmGPt1Ra6BoiMc4N4rDP+6
         Rq71syb46v3WjUHUCj3peAEvCjxyXKs565m0I9mtC8MquUCgX8j8+AbH+Us85+13q1+/
         4p9KvpRtjSWq25w9Mp/x2SakVnBNf99gP1YvHBeSPwFXS+8eu2G5GXZ7NoK/arnTaMpE
         bqaZeHORw2qXUFQ1M9uvXVVpruZWUZb8jc4rQx4xz1L30LllxJbkUTdgzrObaoySzVnL
         Ns3g==
X-Forwarded-Encrypted: i=1; AJvYcCW+gsGOmT91PE2P1RV2TEgNEIeEDvxo0TEIcc+Dh61dJRH9r4211gtnfqr9cyMAmMnLZvlUqfKsKOEXQ6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WFHx2XEDbhCF8+lceYfP/sMFvkz3syQoqC2BWGGmW+RNccoW
	jmBkRT6yueuG730OGOFnmK7RKHuO98CCZbRqn75tnUrBp4db/l44SbuctziyLYkwthgXllrOKti
	aEzo=
X-Gm-Gg: ASbGncsmMnh+aQyQ5Cac7Z9qedTe8c38yzE5N09A3n6p7+n4FLrAZ6FdvBNTvUYHFKX
	zgYBpRlHrUqqDA6/x5J3qOq6O+3roMQtoWtpooPmJy34am64uy5muxBfIHwk2f3md+KCfKBNjhd
	8Zw7dlQBrEa3Kz/lYVMOcaoU6bXlkrynmsh9668Nzn/nPEJ/hmbjfmlig408Hj/UmX3syl42NTJ
	WqNqdLCe2vuApErw0ZTRyuIHO+NTvoNk7FWB/Ng4x/ZPt36DCJZXakTSr8EF+eHOPsZlkBRrY9N
	fDnUGeAfxgzT/dorFvxbUcYhpLNxFMEPa7jX0ExxT8rm9C16UQeiMdIxewccLewddIJm2hjCSCl
	HXltBGQZHB5UFx5ZKNbaqshleXfT4OjTHCaTPh2Gj7H7VVC/Eg7fX6XKtvjQtr0sT6R35qGXJx9
	/o+rQI2vSkdJ/Z9A==
X-Google-Smtp-Source: AGHT+IFMCMjgfVyPH+qKoxUm39fI0ctRyu0DqUAf5N5YEfjtIKsP8aP5bEJBbjS4319qAB7C+dqGKw==
X-Received: by 2002:a05:6122:3bc1:b0:551:e854:8153 with SMTP id 71dfb90a1353d-5524eabddebmr280068e0c.15.1759438738367;
        Thu, 02 Oct 2025 13:58:58 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce648f4sm811343e0c.9.2025.10.02.13.58.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 13:58:57 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54a786ed57cso1120555e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:58:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWANOTmvt/oa4DRw3i6hhMGNGgdAQ+Ls5oUBTxMTEW/0V4eXNBkf1u0hCyQVWo9QOSIVeunSxcuEsO6UKk=@vger.kernel.org
X-Received: by 2002:a17:902:f609:b0:25f:fe5f:c927 with SMTP id
 d9443c01a7336-28e9a61a7a1mr6113515ad.31.1759438293518; Thu, 02 Oct 2025
 13:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
 <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
 <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
 <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com> <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
In-Reply-To: <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 Oct 2025 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw=TLx1KPKCdBcJ4BP8+hOcCA+7QLrmfGHCb9uw9u3Pg@mail.gmail.com>
X-Gm-Features: AS18NWAzBOpu8L_1YZexH_YKnsyYsn8PoONF8LzYzDqMVfF7ir8YT7oKetO1D5Y
Message-ID: <CAD=FV=Uw=TLx1KPKCdBcJ4BP8+hOcCA+7QLrmfGHCb9uw9u3Pg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ziqianlu@bytedance.com, akpm@linux-foundation.org, alex@ghiti.fr, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	catalin.marinas@arm.com, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2025 at 12:11=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> > > > > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > > > > +{
> > > > > > > > +       return cpufreq_register_notifier(&watchdog_freq_not=
ifier,
> > > > > > > > +                                        CPUFREQ_POLICY_NOT=
IFIER);
> > > > > > >
> > > > > > > I think you need to do something to prevent this from happeni=
ng on any
> > > > > > > platforms that override hw_nmi_get_sample_period(), right? Th=
ese
> > > > > > > cpufreq notifiers will be useless in that case...
> > > > > >
> > > > > > I understand this is not a problem. watchdog_perf uses
> > > > > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited =
by the
> > > > > > CPU's main frequency. After we make such a change, a larger val=
ue may
> > > > > > be used as the period, so the NMI period will become longer, bu=
t this
> > > > > > value will not change after the system starts.
> > > > >
> > > > > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> > > > >
> > > > > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > > {
> > > > >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > > > > }
> > > >
> > > > I have added the maintainers for arch/x86.
> > > >
> > > > 1. cpu_khz can be understood as returning the base operating freque=
ncy
> > > > of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> > > > downclock to 800MHz under low load and overclock to 4.4GHz under hi=
gh
> > > > load.
> > > >
> > > > 2. Because the event provided to the PMU has the
> > > > PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is base=
d
> > > > on 2.3GHz, the execution cycle of watchdog_overflow_callback() is n=
ot
> > > > fixed; it varies with the CPU's core frequency. When the CPU runs a=
t a
> > > > frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise=
,
> > > > it will lengthen.
> > > >
> > > > 3. After our modification, if the architecture is not integrated wi=
th
> > > > cpufreq, it returns 0 and will not update the cycle. If integrated
> > > > with cpufreq, it returns the maximum frequency supported by the CPU=
,
> > > > so the NMI cycle is only slightly lengthened, with no impact on the
> > > > actual hardlockup detection function.
> > > >
> > > > 4. I have also conducted tests:
> > > > stress-ng --cpu 1 --taskset 1 --cpu-load 80
> > > > echo 800000 > scaling_max_freq
> > > > turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectiv=
ely.
> > > > And the NMI cycle became approximately 30 seconds:
> > > > [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu=
 =3D 1
> > > > [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu=
 =3D 1
> > >
> > > Whether or not having x86 and powerpc start looking at cpufreq is an
> > > improvement, certainly it is a change in behavior, right? If we're
> > > really changing the behavior here then the commit subject and commit
> > > message need to mention this. Right now this is billed as a simple
> > > rename...
> > >
> > > I don't personally have lots of experience with x86 cpufreq but I do
> > > know it doesn't work quite the same as how it does on arm. It would
> > > definitely be good to get someone on x86 / powerpc to make sure that
> > > they are happy with this. ...or you just keep making it work the way
> > > it did before and then you don't have to worry about getting any
> > > buy-in from x86 / powerpc folks. Up to you, I guess.
> >
> > Well, I fully agree with your suggestion. What I can think of for now
> > is wrapping the newly added content with #if defined(CONFIG_ARM64) ||
> > defined(CONFIG_RISCV).
>
> I=E2=80=99ve also thought of an alternative approach: add a generic
> WATCHDOG_PERF_ADJUST_PERIOD to /lib/Kconfig.debug, then have the
> Kconfig files for arch/arm64 and riscv select
> WATCHDOG_PERF_ADJUST_PERIOD. What=E2=80=99s your take on this?
>
> Do you have a more elegant approach to

Yes, this feels right to me. I was going to suggest this in response
to your other message and then I saw this followup. :-)

-Doug


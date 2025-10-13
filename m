Return-Path: <linux-kernel+bounces-850059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C0BD1BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBC4E7A63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE82E7BCE;
	Mon, 13 Oct 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LsfCrh4q"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D191C5F27
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339461; cv=none; b=HvlgK9lH+3dMzDodb3aXzYtM7piZb4krGfZBb+BsrOUKI8MNQP8JRqH8FUvJUPpHrWV8XXY7D/hp5PCD7yyY+ajeWJSQlU8RCxav54+czHy6st8/XxzTjSvgfJAdaPfsCxIrIxYLyI4j9lOEWevR+88r97U2szysZqlsXFApdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339461; c=relaxed/simple;
	bh=i4krzQYydSCoBoNjUWqqYPeGUwtT0S2rlsHqymoV22Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXkkYxW5nzE7eI8jBPBsL+u14DjQL8Q1AvdDrlSCrnDoZrs5mQMNolA2PNVVmdieukRpIJLmVubzRcZwSFMdsrT0ppXvIxdQ7XprLF/L+3MFYM4evdi/rpjOYhFa1gDxz/UHUYOxmeWYzl7FzPP0+XpShbE6XeF1p29l9Ggjwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LsfCrh4q; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81efcad9c90so55604746d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760339458; x=1760944258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJf7xLipisHImEFHEU39LT6SyCTlQl1jbbC0qWu2PoE=;
        b=LsfCrh4qFuXWX6pbEstlplUJtgYApBh5frjn8gvUfwNluizPPha2vAov0Dc8MImgwz
         SEEcyWrcUvwghRjax+QG8Yq5G4BjhlTv/AObpnalXw9vfOf4rTQjHab0TpnEWPXl6JEG
         Q99HS0l7FajvwAGpNrExdiwuyBdmEdluS2mm02wmJbB5jvirSWgFToSmX3nfrbHOeP4e
         X15PHPsRmb6Rw5akmS/PloMM8owTj2KK/cudXcIsp1YXjF6sqMjV073V3JrSWsFZ8Wke
         bo38rgvGkFDhXvi5UGyQCVRA+hq4lfQM2a9XDIOg0SYHYWH2D3RvbAVMCvjfJ0vjHCTt
         AbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760339458; x=1760944258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJf7xLipisHImEFHEU39LT6SyCTlQl1jbbC0qWu2PoE=;
        b=pG8ZmRQBxsaeAjByMBXILErI3XNsLqxKo4kg7+wBRj10fGezM6hgiFJw7vgDeHBCTQ
         /Hjmv6XR1CHloKGDslpAQkY8e5u5s8t96bz7FdDI8yd/59orAZMuXeQqXu8H15uUUusk
         7n2gklLOYKuO8V9NCs1ZvxmCSxveUgr//rB87opkKFX7o5JSFne0EIfZyR4MldDWHcU3
         oHA3ObCaUa27yFfh0fhmunmdngCVILF4WVYJyuUIu3YCQWCNlq62DoY4udZ+rnxJ3+5H
         dDTdSLvieBndrgp3Abbkfwt78r1qitojkOOnevDi6wpkqalrgxNOUCDJEIH2feQ0M2qu
         vrtA==
X-Forwarded-Encrypted: i=1; AJvYcCXNmugFfuYNcerAE1GDExxMvD5/uIj3gja9CTlOWpAIqAf2iu07+7p2Q2RNMTZtivgpqPLf3jZLVtRIiHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2sZ74vOcxb5stSuI9v3G7PtdDONtUG4lRucL5FlDVz00Nblc
	9bDlJDuLCYnznU052wH7IUwzTdMOQInByQINgDPllW9tzquIiifpd1PrVVOflMOgr4qr/TUcJWJ
	GYEY5Ifdfq7v8GGhaLwPRNc9peLRXl4/TXo4UqsDIYQ==
X-Gm-Gg: ASbGncsWCek5CAWGBqM0/hRS2kbvwHwwnW/o81STfNsqsfRb8XXpnl3VeBak2DXaykD
	X5PSoMnyTUaY4E5VCYH0Lr5CfWPzZ09FZdnG9Ervxm8+0J34zUmP9kRwlkhD4sZ+fCw2CF4nubY
	8t7pZXn4IohB8NMytWWgqfGpLeLE6DvcHe1lxaPt4i+UzVOd+uzwgwJ5ud9BjSFr0wRB77U7fNp
	TtP4hZptcT4+htlvnwhnfpDyolfwgIYFO3BJmGVtOP8F7mMtFywd2hNOSZdM/A2xLiFEg==
X-Google-Smtp-Source: AGHT+IHlYmvSPHRRe5m0EkFR5aoK4WfWi+0MJgO2GyIhsHuhKt7Wi0a0UcJqCLk0ZaLHRfD+MX/KxQLvwg+1sKXpILI=
X-Received: by 2002:a05:6214:410:b0:7f2:5aa8:6655 with SMTP id
 6a1803df08f44-87b2ef33b40mr312076176d6.31.1760339457993; Mon, 13 Oct 2025
 00:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181717.1997461-1-cleger@rivosinc.com> <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
 <628d357c-f462-4dc8-92f2-99006b73e0c7@rivosinc.com>
In-Reply-To: <628d357c-f462-4dc8-92f2-99006b73e0c7@rivosinc.com>
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
Date: Mon, 13 Oct 2025 12:40:46 +0530
X-Gm-Features: AS18NWCt2iy9V0_v7KjFmtjkYMcjvPsZs4IHA_HWv-2SfKnKV8vVHkmqZQbY-so
Message-ID: <CAPd4Wez7eLunDbCmKs19S=q-DM3-kUs0=wwjxRi+pq1waq1RqA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software Events
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
	Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:23=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Hi Paul,
>
> Thanks for caring about this series ;)
>
> On 10/10/2025 03:32, Paul Walmsley wrote:
> > Hi Cl=C3=A9ment,
> >
> > On Mon, 8 Sep 2025, Cl=C3=A9ment L=C3=A9ger wrote:
> >
> >> The SBI Supervisor Software Events (SSE) extensions provides a mechani=
sm
> >> to inject software events from an SBI implementation to supervisor
> >> software such that it preempts all other supervisor level traps and
> >> interrupts. This extension is introduced by the SBI v3.0 specification=
[1].
> >>
> >> Various events are defined and can be send asynchronously to superviso=
r
> >> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
> >> as platform specific events. Events can be either local (per-hart) or
> >> global. Events can be nested on top of each other based on priority an=
d
> >> can interrupt the kernel at any time.
> >>
> >> First patch adds the SSE definitions. Second one adds support for SSE
> >> at arch level (entry code and stack allocations) and third one at driv=
er
> >> level. Finally, the last patch add support for SSE events in the SBI P=
MU
> >> driver. Additional testing for that part is highly welcomed since ther=
e
> >> are a lot of possible path that needs to be exercised.
> >>
> >> Amongst the specific points that needs to be handle is the interruptio=
n
> >> at any point of the kernel execution and more specifically at the
> >> beginning of exception handling. Due to the fact that the exception en=
try
> >> implementation uses the SCRATCH CSR as both the current task struct an=
d
> >> as the temporary register to switch the stack and save register, it is
> >> difficult to reliably get the current task struct if we get interrupte=
d
> >> at this specific moment (ie, it might contain 0, the task pointer or t=
p).
> >> A fixup-like mechanism is not possible due to the nested nature of SSE
> >> which makes it really hard to obtain the original interruption site. I=
n
> >> order to retrieve the task in a reliable manner, add an additional
> >> __sse_entry_task per_cpu array which stores the current task. Ideally,
> >> we would need to modify the way we retrieve/store the current task in
> >> exception handling so that it does not depend on the place where it's
> >> interrupted.
> >>
> >> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts a=
re
> >> handled and does not adds any overhead to existing code. Moreover, it
> >> provides "true" NMI-like interrupts which can interrupt the kernel at
> >> any time (even in exception handling). This is particularly crucial fo=
r
> >> RAS errors which needs to be handled as fast as possible to avoid any
> >> fault propagation.
> >>
> >> A test suite is available as a separate kselftest module. In order to
> >> build it, you can use the following command:
> >>
> >> $ KDIR=3D<build_dir> make O=3Dbuild TARGETS=3D"riscv/sse"-j $(($(nproc=
)-1)) -C tools/testing/selftests
> >>
> >> Then load the module using:
> >>
> >> $ sh run_sse_test.sh
> >>
> >> A KVM SBI SSE extension implementation is available at [2].
> >>
> >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download=
/v3.0-rc7/riscv-sbi.pdf [1]
> >> Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]
> >
> > I updated these to apply on Linus' current master, commit 5472d60c129f,
> > cleaned up the checkpatch.pl --strict issues, applied Anup's pr_info()
> > suggestion, and pushed them up here to make it convenient for folks to
> > integrate and test:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pjw/riscv.git/?h=3Dri=
scv-experimental-for-v6.18
> >
> > Am assuming you didn't have other changes that you wanted to make; let =
me
> > know if that's not the case.
>
> Indeed, I do not have pending modification for this series. The KVM SBI
> SSE support will be submitted later that year.

I am testing this series with my RAS patch set. Will update on this.

Thanks
Regards
Himanshu

>
> >
> > I noticed that you asked for folks to do additional testing, particular=
ly
> > of the SBI PMU driver integration, but didn't notice any additional
> > Tested-by:s.  It would be great if other folks on the list could do som=
e
> > focused testing now, particularly since we're on v7 of this series, and
> > I'm sure others care about this.
>
>  I would have prefer a bit more reviews and testing before going through
> since SSE can be quite intrusive at execution time (even though the
> classic IRQ path should not be impacted, I expect mostly feedback/bugs
> from the SSE handling path itself). We'll see in a few days if people
> find such problems.
>
> Thanks,
>
> Cl=C3=A9ment
>
>
> >
> >
> > thanks,
> >
> > - Paul
> >
>


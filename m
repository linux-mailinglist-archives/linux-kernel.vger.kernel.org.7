Return-Path: <linux-kernel+bounces-761060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5381B1F3D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E6924E05D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E902724167B;
	Sat,  9 Aug 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA9QfvrU"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0281F1311
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733013; cv=none; b=OQ+hYTx835rHr6gI4ls0Z3pd7QaUnmWdK5AAwxQ3Mte0JNSVHPrlvqfM8fUFT7lSwRJpOcQUtaI+kfghDTH1eFHtjJ/Y1d/QE7Fyqeb50JIfYoiJ8ooL9MwSJRusVxKqRe8yj1Hy4Lgl7fnU13BHu6g6DjsOiFHEJCQcx//zVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733013; c=relaxed/simple;
	bh=ZYbf8EsIYZFO81yTHUMtKbiC2T75uk75+9T+AJpt1Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb6BI5eOY6IkwdYz0JmGjyHAhP0wDCK4lmlBLNpwUXg9TIG2KS2arDH7cwi6418/7vJs9i2jVQgcOsoxj9mZfliH0r+u7/nqsRN4h+zjvRvBA6kx99NNDqLm9jDLTEADmAFO34iJgyWS65fuy4U8K+9u/mqvEKxmua2qZEZJqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gA9QfvrU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so3421729a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754733011; x=1755337811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mApNl9OyMaD4VGZ6r0mx3memK22VlVhEsGoa9kJ9Y84=;
        b=gA9QfvrUKe0rW26w3NGkg/B3G1ekTuIkXkGSxlS8mW/7KyUvuBbi5u9FuOzgmgMJpj
         MHCJh5uu3cVL9MMnSDAMhamdQWlI8H4dGps5BG0HBsWidVUob9+vm92avGoLa4CfaEEh
         4blIFkDzxkSL1+E4k1xZLLS4KzbjZgzqBy8BQBWfqMmJVXcaXkq1zLY+lWzcZemmdbpm
         qxpMNpo5LOh5UuaCz7gIBlj0eoxROgjKczY3UhJ+QbvcRSC6o5cpG/F7ip6RP8yZa9kF
         uoWoTLWeVsDydF4z8W7GMzDL5XlNrbRBpHM1s2X+6FBaYfWJZI3ivdnMQm8ocLODQBjA
         goSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733011; x=1755337811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mApNl9OyMaD4VGZ6r0mx3memK22VlVhEsGoa9kJ9Y84=;
        b=K/YuKs+1EKaP9fLFPO4bOJPvNGRJnPnjFlCr95Bp+Pe0T3Wng666ckKDoFpPdrFaED
         4fhPRQmO8eNnvGe7KtvonyVqvQ35oNO5sgAcXQSXqzRJyhjxO9RqDcWmv0QjS7khYw3+
         XQHPsQOwSW8MVGkbKRhPmwGC+GQznOGfD/aS98iwNNrN7n30W2jhzoTkDipcjzxCcpVZ
         euIKQM3B/lcMcsN79TVgqavf7/vn3UYOOKp9OKZ+54GDTNBj9P3a/Uaty0x+6BfkKzck
         1WuFNpIFUpH2K4R3SwD5elqHI+yRrtLxSTTr9OREBgRSE4A8ZaIjGbbIumx+ZLo3+mar
         Cm1w==
X-Forwarded-Encrypted: i=1; AJvYcCXfkwPVw014Pu9OB/8OVSZ4Ziln2IVY4kYIXNu3+W66BwF0rOweLswE34CdSM2nadMlQYZf/9XedwJylQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mRvC0R5C99BUCifcgAkuHwMgmiOJYPLS+fHEnRcTJtU3RdLg
	D4ZirYNI/aKpHpbGbEzQBhEASRreDG1N7AaKjrWHBJt4FhN0727dvLRac4Yg6cKkJszwhOr5UI9
	SoOjQby9Pa5EpSb/ZGrPpN6rYjxnbJyYq6k1WLXd/
X-Gm-Gg: ASbGncvJG4JFWkcxy13z25WAsyZRFO3SwJUbOGoxlb1aZxKS8uq88tsP9RMew92P4Bd
	HYgEBhIWLXtW4A1UbPJaBSiepKn6+2TiBb5BWDMadybjn8gLLwI5E7AmGPgGCko8m6F6Ho06bNw
	08XxOreNnMYKbjr4zhIGA0kgGIk8TZnVo7FoH3RAN3cKJGn9pKk5kpNTCXD2b9Mw3jonICtRCd3
	CBO7nizFyPM504QP3KsKYACch8RHoRMgXI=
X-Google-Smtp-Source: AGHT+IESzd9zfaC2deh5/pTXOEXeXfK/44plwlVMAXnQlm2v63zn18NvHxQVXO92KZ4+0x7GC3psv5PGn+zts+fYpgo=
X-Received: by 2002:a17:90b:544c:b0:31e:c630:ec93 with SMTP id
 98e67ed59e1d1-32183b45722mr9956895a91.16.1754733010777; Sat, 09 Aug 2025
 02:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805162153.952693-1-wakel@google.com> <87ikj0esnv.ffs@tglx>
In-Reply-To: <87ikj0esnv.ffs@tglx>
From: Wake Liu <wakel@google.com>
Date: Sat, 9 Aug 2025 17:49:32 +0800
X-Gm-Features: Ac12FXwAyr8kLaNxcUw79dYiwgd27yldMNM5geindbHi_tJ59IaBKROkiaTcO-k
Message-ID: <CAOcRiAFzN61FE=By1ANB3aK4PKVTBQAzrCcfoHfHwMX7Qn8wYA@mail.gmail.com>
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Here's the command I used in android.

```
/data/nativetest/vts_linux_kselftest_arm_32/set-timer-lat
```
And the strace message.
```
Setting timers for every 1 seconds
CLOCK_REALTIME         ABSTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_REALTIME         ABSTIME PERIODIC max latency:     747886 ns : [OK]
CLOCK_REALTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME PERIODIC max latency: 4296109428 ns : [FAILE=
D]
CLOCK_REALTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT max latency:     715292 ns : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT max latency:     628703 ns : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        ABSTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_MONOTONIC        ABSTIME PERIODIC max latency:     738160 ns : [OK]
CLOCK_MONOTONIC        RELTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_MONOTONIC        RELTIME PERIODIC max latency:     708172 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT max latency:     586385 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT max latency:     818237 ns : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         ABSTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_BOOTTIME         ABSTIME PERIODIC max latency:     795249 ns : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC max latency: 4295613660 ns : [FAILE=
D]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT max latency:     978516 ns : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT max latency:     628948 ns : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC max latency:    1511436 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC timer fired early:       1 : [FAILE=
D]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC max latency:     758913 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT max latency:     610881 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT max latency:     633708 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC max latency: 4295683321 ns : [FAILE=
D]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC max latency:     839520 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT max latency:     601401 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT max latency:     628175 ns : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME PERIODIC max latency: 4295577120 ns : [FAILE=
D]
CLOCK_TAI              RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME PERIODIC max latency:     921184 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT max latency:     590048 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT max latency:    1007202 ns : [OK]
CLOCK_TAI              RELTIME ONE-SHOT count:                   1 : [OK]
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
```

So there is some odd stuff going on in how the time comparisons are
done of 32 bit builds.

Looks like there is some integer overflow on 32 bit builds in the
timespec_sub function:

long long timespec_sub(struct timespec a, struct timespec b)
{
long long ret =3D NSEC_PER_SEC * b.tv_sec + b.tv_nsec;

ret -=3D NSEC_PER_SEC * a.tv_sec + a.tv_nsec;
return ret;
}

on 32 bit builds NSEC_PER_SEC and b.tv_sec are only 32 bit values
which I'm guessing is causing the overflow.

NSEC_PER_SEC is defined as 1000000000L but if we change this to
1000000000LL then the test starts passing.



Thomas Gleixner <tglx@linutronix.de> =E6=96=BC 2025=E5=B9=B48=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Aug 06 2025 at 00:21, Wake Liu wrote:
> > The constant NSEC_PER_SEC (1,000,000,000) is defined as a long literal.
> > On 32-bit systems like arm32, where long is 32 bits, this value can
> > overflow when used in 64-bit calculations.
>
> How so? Where is the overflow exactly?
>
> The only usage of NSEC_PER_SEC in the VDSO is:
>
> # git grep NSEC_PER_SEC lib/vdso/
> lib/vdso/gettimeofday.c:        ts->tv_sec =3D sec + __iter_div_u64_rem(n=
s, NSEC_PER_SEC, &ns);
>
> and __iter_div_u64_rem() is an inline:
>
> static __always_inline u32
> __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
>
> So how exactly is this causing an overflow?
>
> Also by your description this would be a problem throughout the kernel.
>
> Thanks,
>
>         tglx
>
>


--=20
Best Regards,
Wake Liu


Return-Path: <linux-kernel+bounces-728489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5882B028EF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 04:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745F6A46206
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083D16F841;
	Sat, 12 Jul 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsELPdBf"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D935948
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752286768; cv=none; b=Evo7z5INgol0drA+qyVcAVkOGoquBK6d5un+xu0PvbXfBQKI/3dg3mrSgSxKylEta4KiSo6KlK7FMVsB8MNfilxaWAWMSQ6nIBSSzvRs5HRkKQppsa5q4J5E4l2SaETV9qY3vQvIDkKB+0eV8bY2zTiVgJI6IdAOAjDY4Umw/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752286768; c=relaxed/simple;
	bh=MvNLqhKnm9tWE58Gy7d2l/AjmUMR9CdzU5l3kGcW4VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgsKRs4ZzpI18nE2qRVjbcWYoSjVxPod7ZrPPmZVv+wxMNFQA/gTBaAT0ydc3+32+2VVM+yruzOYRKI6ZRHSNtWBqYHejbGEGdS0YNVoN25+X4u2pSZEp4T+tKQ8q6toXiLO7+DgG26K6g6K6tK6j4yqTjNI6+GLKhl3VGOERhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsELPdBf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55502821bd2so2854270e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752286765; x=1752891565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGsy4dRD4YlqKx46rnboov0LsZI/I/Oxbnuh0sVluT0=;
        b=vsELPdBfL+r+fyIogiUbUwiQZ9t6ts2mFpvob02wqj7mUZ+Xij4axBtPSbAi1dpAUx
         0Otb0cHlgTqRgeAYt6IV6HmKIdUB5nXEgXEsxlCksExOqpBAw/HNxHFGv0b1mzroixbW
         Rl5KwvM5pAIxG8Q6Fls3BAJ1KeJddCvEIE76J/mLvge2wuqcZZpG/P1jCZJ0I+EzbujW
         RT7vvzsnqzPZ4nlyE/mUiK61jxLR9jfnMxbvX8UflHCp9MKeO2BYqAjBuybU5nHlhsRA
         IdIFeXcQK2WTWzF7+gy+035UWy95EiNlPsIlGm0ZeYmnXyi5VkOfLo8Lak5d6VZI+Y0w
         CXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752286765; x=1752891565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGsy4dRD4YlqKx46rnboov0LsZI/I/Oxbnuh0sVluT0=;
        b=Upi3s4oImZH6C9Mw5sVpC2syGxdmQqrXTfR4yYHtYcPzv/NOehTDNGpAzbteTZ8oLB
         SCrZ7iQMBf4l4cbWdiItbXnt2HJ+1/p+fz/zCcBt2NFicqM4VAAoV4XD9FovXAnzUGFS
         hlBaEatXyQNExkconJguQFUR5doS3l8IlBO+TVbBO3urdFjpiCRu4FhNcgtkWqVKCy2A
         NhW3+lj9DTErd73/MyUnTfw9pHz+dz0r1+f+UDaSJ3uTHZy75wqGwgA2gd7qnvSJY6HG
         xT2Bgk+XCH44Ln4W2rvEyrj9iv16UUE5SFwKMyHXtXhSfOIH1Iig9UrjarsBF0oxG/1w
         hbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZgURAhFfDn/7lbIAda+1FMKchOl0lVgQJkjd5ph2yRkPFU0jneVXUBm/znLBCbWzEbvX55PtHsNdLjGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrakZ9u8voNHVeaSw2+uITgHUo7C5dTcPKEFEiaK94yLEdd/6g
	6IwWdhxuEJwazClYrDz8/YcNAdrepYBhtE5/1HkpR+QbFsCtLrcHNbBmalyucwzCjppnJWoOcn3
	WupBs8h8GvOsXkQrZl3Z7y+wqGm+uiYNmftsii8w=
X-Gm-Gg: ASbGncsHAzYW97R/xX632/u93cCZvLVJNZVCAkfImzvBV6N0MkazZBfcEmXwUbQ9/Ot
	+De9g0RU4doK0fT7BRuRkN0Mzx0XDU9T6Bm4aYaLd5fjoozbBEjgf7QThGbCfzRqKpcFfY5rvih
	6fRFkhsq/tBmivwCN7dr/iHws/UOUzuIM9bPfBtdQxeR0mWrNXLK71Uy88ckMiCLYzlCNS90RtW
	zb5QERHmBM5oLKiAWDUD20ibe0swtuiUkby
X-Google-Smtp-Source: AGHT+IERGSMZprnmjmswl+nIzfWcSM0tYb29xmZk/NuCanGaERTLD7955zRy3xM1RQTP+jgABlNVrDjD85FH1QjzX90=
X-Received: by 2002:ac2:4e01:0:b0:553:358e:72a8 with SMTP id
 2adb3069b0e04-55a046001d9mr1640746e87.38.1752286764221; Fri, 11 Jul 2025
 19:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
 <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
 <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com> <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Jul 2025 19:19:12 -0700
X-Gm-Features: Ac12FXyI8kBc43hsn-fbzDpUZgjJ_pZte22xX3JWMIyKf8tOb-mAeqxBRTRIy8c
Message-ID: <CANDhNCr+7=1W9Oiq3AupXRVasU8FgLorzOnf3_RhYp-WK4qbyg@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, 1107785@bugs.debian.org, 
	Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:55=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Fri, Jul 11, 2025 at 12:34=E2=80=AFAM John Stultz <jstultz@google.com>=
 wrote:
> > On Thu, Jul 10, 2025 at 2:59=E2=80=AFPM John Stultz <jstultz@google.com=
> wrote:
> > > On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.=
org.uk> wrote:
> > > > There seems to be a longstanding issue with the combination of user=
-
> > > > space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle. =
 This
> > > > was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D2005=
95> and
> > > > more recently at <https://bugs.debian.org/1107785>.
> > > >
> > > > During suspend-to-idle the system may be woken by interrupts and th=
e
> > > > CLOCK_MONOTONIC clock may tick while that happens, but no user-spac=
e
> > > > tasks are allowed to run.  So when the system finally exits suspend=
, a
> > > > watchdog timer based on CLOCK_MONOTONIC may expire immediately with=
out
> > > > the task being supervised ever having an opportunity to pet the
> > > > watchdog.
> > >
> > > So I don't know much about suspend-to-idle, but I'm surprised it's no=
t
> > > suspending timekeeping! That definitely seems problematic.
> >
> > Hrm. The docs here seem to call out that timekeeping is supposed to be
> > suspended in s2idle:
> >   https://docs.kernel.org/admin-guide/pm/sleep-states.html#suspend-to-i=
dle
> >
> > Looking at enter_s2idle_proper():
> > https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/cpuidle/cpuid=
le.c#L154
> >
> > We call tick_freeze():
> > https://elixir.bootlin.com/linux/v6.16-rc5/source/kernel/time/tick-comm=
on.c#L524
> >
> > Which calls timekeeping_suspend() when the last cpu's tick has been fro=
zen.
> >
> > So it seems like the problem might be somehow all the cpus maybe
> > aren't entering s2idle, causing time to keep running?
>
> Well, there is a suspend-to-idle path in which timekeeping is not suspend=
ed.
>
> It is the one in which cpuidle_enter_s2idle() returns 0 (or less)
> causing cpuidle_idle_call() to fall back to call_cpuidle() after
> selecting the deepest available idle state.
>
> This happens when the cpuidle driver in use doesn't implement
> ->enter_s2idle() callbacks for any of its states and the most
> straightforward remedy is to implement those callbacks in the given
> cpuidle driver (they must guarantee that interrupts will not be
> enabled, however).

It seems like in this case maybe would it be better to abort the
suspend if the hardware doesn't really support it?

> There are also cases in which suspending timekeeping is delayed for
> various reasons.  For instance, on some systems, if the temperature is
> too high, the platform will refuse to enter its deepest power state
> (ask platform designers which they thought that this would be a good
> idea), so the kernel waits for the temperature to drop before it
> attempts to go for proper suspend-to-idle.

Hrm. Practically how long would this thermal delay for s2idle be?

> Moreover, if there are wakeup events while suspended that do not cause
> the system to resume (you may regard them as "spurious"), timekeeping
> is resumed and suspended again every time this happens.

Ok,  I'd expect it to be resumed and suspended (though I'm wondering
if that should be rethought)

> So in general time may keep running at least somewhat in the
> suspend-to-idle flow, but this also happens during any system
> suspend-resume flow (timekeeping is only suspended after all devices
> have been suspended and it takes time to suspend them all and
> analogously for resume).

Yeah, for small amounts of time, I do expect that the suspend time
will be slightly shorter than the time that applications are frozen -
obviously to your point about the suprious irq case, that delta might
grow with suspend time, but I'm hoping we're still dealing with
relatively small amounts that won't confuse applications.

But from the bug report it sounds like timekeeping is just never
getting suspended at all, which is unexpected.

thanks
-john


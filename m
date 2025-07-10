Return-Path: <linux-kernel+bounces-726537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1EB00E55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773A9542A29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFB274FD0;
	Thu, 10 Jul 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHCc6UMh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE520296A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184812; cv=none; b=DzUHMJjZMze8ZTWZg/XuylD04lsFjsDuZrnSKC1S+zP0iF7TcGBXT/nNNcbHzXzLet22whVE5n3bPP/Qf31YlbC7RyG7Uri3Wo4L+pUvDUTtBt1QROV2hF1BfPjDTat+JChw0DEUPwwzJVgsrQutPJRKnrg1OqjmKBmKW1uSYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184812; c=relaxed/simple;
	bh=6v9lXiTjYqyqXWDAP41VGCNxsCXH1turXzPssZQNhV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltV7gdtBistRJoUfFZeXzgbEcaEeWrNCcfcSPWIMwyvQ/8Als+KxjensJL6wQF5C0sHYbcpiCkPOvPXDjXtLjsXao4TSaFNRj6DS6E+BWkEPrk2eNxZyHR7d9Za7tzzAvencGXim4qL2jEe79YayOFsC+0UsepTCU4nVJ9ZuFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHCc6UMh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55502821bd2so1518064e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752184809; x=1752789609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uct7aOErRM1CCmDJ1gJe+QQrgk7Mmc9j1Oknv+rQqv8=;
        b=bHCc6UMhebxneFHFQYKLUBTC18R9YofIBkkKW2Wx9FI43lTtAbuFiBPraT4/3LEBu+
         w9SP7KIIXFQ6Ckz7OAwvqGxR0C9K0J02RiUb8uLqwdTRR7t1fEd5bsv6nWYT9HqMKxJI
         B/MtSvEpZkYrA1Arj7YgOkFXw7a2hqNTHB1WObnJ+L9rBI+MuApxxSqSt5KXieciRIh5
         LaLI4Xi+8GxMxapsid/sV9JefAp+H0A6IE9byAQ+LEaceqMnYTfLTv41gqkCfj5A/D+/
         3a4SIyAEFEk2EyY7iOkaQG9hOXuS+8oEj/8UMxhRKgeQXI4/90oDGELPKfWgQprgEfoB
         r85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184809; x=1752789609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uct7aOErRM1CCmDJ1gJe+QQrgk7Mmc9j1Oknv+rQqv8=;
        b=AywKONmqbKllMMaxn7XY8vUJbmpcCHnB2Oet/nZUIKF6iM2QEGKie4NrqZKkzaauLc
         Ce62i09y8lUl7uCbSPPYav9PphYtzw3z8QGOVIuggCDEqZZFObEfsHScV+8YXAZ5ahJZ
         AbkMVpo+770rfxsep7w+jd+nejs66ABogg5Vtz9ZsoAUz7KY17AaXMhr8ZFP1FvE+gwr
         8FDdXNleSh2x+NlynD7xHfjc5hIw8G/krjy8ukvB6jMvCPDd8zTBqcZ7uzGA6hBVGKGX
         nvCWhqqyp1YrCpgRWoC1GK6HHiwdz+x3YbXQ0X60yxqlkzpBC/OTDJe7WDCd3AjYgfZI
         LKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJo6eFkrY5MPgPyeXE+oPOi8cpcE6qD/+CGFMPWsphODFK8hUTO4r0VniFYFLxtnh8EZts/8jmUKZOyU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT08IahahBIEd/F+YznpTbZ4v/Z9PuRw0PEHc8kAp+qogNFnP
	7/jP+H0rBBVAc3zdGoQ0EIe/awOpGGoK9t7/fw8F4vBkBfUTSQ07Ls4htU+iuMsipEbAiBSUwzO
	AVqC0BgmG53JTxsG3zIhBzJA2f5kAlcSnymKqY9F+3pnxkscPqHZf4Rs=
X-Gm-Gg: ASbGncuUCxvCZGsfqG1YXAVBjcz6RvdPyUcKxAuBCrJShfUZY63pE3jOUSyX68upptb
	GKPVY1XDFOOz4coBnF2z8/gukuz/CJGu1jrk1ZReFBlh5312GP3L6Zjq7539UoWGwXZGdSL5WmQ
	91vGwwWYL74Hx/uKGo0KEJCPe9qPx9DQ/uOPDa/jpNXedY8ilz4B5ah4rAfscM+HzmPcTjYvCkT
	liOHbOhSbeW+7Ubrw5T8xONLTAYulzudiRNy3wyQstBerE=
X-Google-Smtp-Source: AGHT+IHAjon2Hbm1rrI9IYhjGF3rvGdl480y52h3Ov1ouiJQVcbaeaXPgibtRUczZh3fYpr6xxHla4+6l3JaHEYeI24=
X-Received: by 2002:a05:6512:4026:b0:550:e527:886f with SMTP id
 2adb3069b0e04-55a046264ebmr140054e87.51.1752184809053; Thu, 10 Jul 2025
 15:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
In-Reply-To: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Jul 2025 14:59:56 -0700
X-Gm-Features: Ac12FXyg7QYRF9eh_3GGUnrIobhIJbVBnaJ63BO1sJW_Jj4Kp_BPR9TAQFD1dlw
Message-ID: <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, 1107785@bugs.debian.org, 
	Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.org.uk=
> wrote:
>
> There seems to be a longstanding issue with the combination of user-
> space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle.  This
> was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D200595> an=
d
> more recently at <https://bugs.debian.org/1107785>.
>
> During suspend-to-idle the system may be woken by interrupts and the
> CLOCK_MONOTONIC clock may tick while that happens, but no user-space
> tasks are allowed to run.  So when the system finally exits suspend, a
> watchdog timer based on CLOCK_MONOTONIC may expire immediately without
> the task being supervised ever having an opportunity to pet the
> watchdog.
>
> This seems like a hard problem to solve!

So I don't know much about suspend-to-idle, but I'm surprised it's not
suspending timekeeping! That definitely seems problematic.

> By definition we cannot allow CLOCK_MONOTONIC to run backward, and I
> assume we do not want it to stop while interrupts are being handled.

How much work do we expect to be done in irq context when we are in
suspend-to-idle?
Will any IRQ that fires (I assume many are masked in suspend-to-idle)
resume the system? Or are there some irqs that fire and do work, but
return without the system resuming?

> But could CLOCK_MONOTONIC be split into a CLOCK_MONOTONIC_KERNEL (may
> tick during suspend-to-idle) and CLOCK_MONOTONIC_USER (only ticks while
> user tasks can run), with user-space CLOCK_MONOTONIC being the latter?
> (I'm aware that adding yet another clock type would be a rather large
> job even if this is possible.)

Yeah, I'm not eager for another functionally very similar clockid to
be added, though something like this approach could be used.

But I'd probably prefer to find a way to suspend/resume timekeeping
instead (likely reading the clock, calculating the delta from suspend
and calling timekeeping_inject_sleeptime64() from the irq handler).

> Until and unless that happens, is it possible to detect that
> CLOCK_MONOTONIC advanced during suspend-to-idle by reading e.g.
> /proc/schedtat?  If not, could the necessary information be exposed
> through one of the pseudo-filesystems?

This is very similar to a problem Tiffany (CC'ed) is working on:
  https://lore.kernel.org/lkml/20250603224304.3198729-3-ynaffit@google.com/

Where different tasks are frozen via the cgroup-v2 freezer, and we
want to avoid watchdog timers from firing immediately when the task is
pulled out of the freezer. In that case the proposal is to account for
the per-task or per-cgroup freezer time, and export that so the
watchdog logic understand if the application had a chance to run, or
if a new watchdog timer should just be set instead.

In that case there's a little more control over things, so adding the
freezer time into the watchdog logic is doable, but I'm not sure if a
similar approach would be viable for existing general linux
applications around CLOCK_MONOTONIC.

thanks
-john


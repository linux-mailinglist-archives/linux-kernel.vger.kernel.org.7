Return-Path: <linux-kernel+bounces-846192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D3BC73F8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B52C34B39C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFD1C84AE;
	Thu,  9 Oct 2025 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0OSD9fP"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B422083
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978544; cv=none; b=Fzcd2YvvoMYbWvW2ajpc/FOHoom9PD8U9+jkdAWIEzDyRShA/k38MBLnyVJnl1k2WPiIDjES2EVso+RYjCX25+LP8UAYSrOK4cJAOkIQnuHZjn+36/ZhBT1JJrE55ZMoZu/97PEPNJRl4oNfX6tiE0vhJcklKYZnySHvE77Ii9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978544; c=relaxed/simple;
	bh=43d1swtA21THz/DFNgemG8MtUgGMNjgpcRq2cvhkWew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO2fKx93OpxsF/k7FjAxYRTaRy19nuBdP3fESWV/YCQcE4cjhWYe862ICq6Tbpcof2laquE0BxWNDrbT/aCJflWD8glD//MvLRq03VRTEUrTbQiywkCFPxejGEuQ0DlO198miLbHD4b45VhiC7MJdkQVURsHGS0TmJTeEDDB6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0OSD9fP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-28832ad6f64so5280325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759978542; x=1760583342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/UauPjcF920ZwmkVvy9lacpRF1qSR7HJO5zYZnXoHk=;
        b=D0OSD9fPuz7Ew31xJbNh34Sgb1dd12YBR4REnXSpALEF+X44XLSq3Lg81GifFeo5yZ
         6HXrWL1InK7jJP9FN2qZrW6WnTNjQKVisipzIjU7y3CEcsEb4KtmJnb4iZV72znC+6sB
         SwYHEHOTIqdps8NM0GidIMxr6sdIUUeaVf4FOfNdsT/7tgMYEB81EAT7d5nEk5HHjL+o
         40bcL79GwHu0+9xD+inxOQGqDI8PzYwHZfzFwwhyOPe0IYmkTniJEpugtXdEeTo2nWqv
         XsXhOZiz6Cru6r5NIvb511Ub1rpYg5wpaDXTpjpGURI4TCTGFug3Z853RBbhp+f3PYNJ
         O7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759978542; x=1760583342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/UauPjcF920ZwmkVvy9lacpRF1qSR7HJO5zYZnXoHk=;
        b=cNBToq367XXCWiM3dyH41tRn6fe1Pg0O2u2/ruqUzfawNAg3fIrY/GM49aIC22vcZI
         sn/+SzJUN9t9S0TJkvRZ70sE5zdyU1MTq2C8c1GmPUqpmDjSxLYKjytAhv5kIFZfmvuT
         DIZLHOZUXpfPhOPyKmJwTH6JJGgx/ubTRuds8kCIZqgGb2J+PliCuzjMDA3TAw+hUX8S
         uV42NR8Nr5fDivqhnPBZxxhIo93/ziFS4mTXdmI+uH6bRrZ4VZUDDZ06PA6S9EQ6TOww
         yg2S5tvqqgtQrMHmS/7G8aNfdoe5k9ufx/58LGm+8x1LiQ2ckEQ+i7hHUSQVm+GjVOFb
         OsiQ==
X-Gm-Message-State: AOJu0Yx+NDYuG4ROisabsx6asYbH44mJZS5oAvYuIWUN/Z6MEoKwJmMc
	FwHIkihYZ2Xyfz4vbDHbX0+Se2F5Eh0320qOQf9gaxSvyrWPx4k0PSNWqxMCa3oaEjoa7hCMgnz
	0IVnEV77V0Q+HuJquoRoITjBh1cK6vrxZNZrCzWo=
X-Gm-Gg: ASbGncsNUeeZ2azZ501sRTNn3RGVjuaUw/1rT88QLPXHCu4ptAfjy1h8o4EBZ+PWZ+I
	x0qYXNY7YhZQtXwvDTe3Kz/Lf5I6GKXVF8s0z3htvxCV0hsFCGT7a3QG+IxEzCcqHEEDpkyUJX8
	SSHSXkYvUjQhIDn/hwUwJwNqdNNkA/i/QrG56uOUClB/c2/RvAP6iFNi/AQJrS91E3E/xItV9Bz
	ioi6x4oWws3XxC2BYvkx+ltElQNmE8=
X-Google-Smtp-Source: AGHT+IFYG+fCkwBp/B20rsG1TRQwnu1lifBaN6bEUA8ywHrKt8IJi+whpFlvBT5R6dok9Yw1qXYlOyG2YkZLKjLwmT0=
X-Received: by 2002:a17:902:b210:b0:28e:caee:40d4 with SMTP id
 d9443c01a7336-2902723faaemr50646965ad.15.1759978542101; Wed, 08 Oct 2025
 19:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093411.1509275-1-jianyungao89@gmail.com>
In-Reply-To: <20250927093411.1509275-1-jianyungao89@gmail.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Thu, 9 Oct 2025 10:55:30 +0800
X-Gm-Features: AS18NWAcQ5n33NYZ9cyitlSqjTitfTcqKivsQyhwVIRtlXFA4Smg4u1t8WkwL6s
Message-ID: <CAHP3+4AHs-Uo=9eOgCv_hNb6HmZ3n4zvces6Yz5AC5YciH55Xg@mail.gmail.com>
Subject: Re: [PATCH] timer: Fix some typos in timer module
To: linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could someone please review this patch for me? Thank you very much.

On Sat, Sep 27, 2025 at 5:34=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.com=
> wrote:
>
> There are some typos in timer module, as below:
>
>   presicion =3D=3D> precision
>   gobal =3D=3D> global
>   exectued =3D=3D> executed
>   refere =3D=3D> refer
>   avarage =3D=3D> average
>
> Just fix it.
>
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
>  include/linux/delay.h         | 8 ++++----
>  kernel/time/posix-timers.c    | 2 +-
>  kernel/time/timer_migration.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index 89866bab100d..46412c00033a 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -68,7 +68,7 @@ void usleep_range_state(unsigned long min, unsigned lon=
g max,
>   * @min:       Minimum time in microseconds to sleep
>   * @max:       Maximum time in microseconds to sleep
>   *
> - * For basic information please refere to usleep_range_state().
> + * For basic information please refer to usleep_range_state().
>   *
>   * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
>   */
> @@ -82,10 +82,10 @@ static inline void usleep_range(unsigned long min, un=
signed long max)
>   * @min:       Minimum time in microseconds to sleep
>   * @max:       Maximum time in microseconds to sleep
>   *
> - * For basic information please refere to usleep_range_state().
> + * For basic information please refer to usleep_range_state().
>   *
>   * The sleeping task has the state TASK_IDLE during the sleep to prevent
> - * contribution to the load avarage.
> + * contribution to the load average.
>   */
>  static inline void usleep_range_idle(unsigned long min, unsigned long ma=
x)
>  {
> @@ -96,7 +96,7 @@ static inline void usleep_range_idle(unsigned long min,=
 unsigned long max)
>   * ssleep - wrapper for seconds around msleep
>   * @seconds:   Requested sleep duration in seconds
>   *
> - * Please refere to msleep() for detailed information.
> + * Please refer to msleep() for detailed information.
>   */
>  static inline void ssleep(unsigned int seconds)
>  {
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index aa3120104a51..36dbb8146517 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1242,7 +1242,7 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, whi=
ch_clock,
>   *    sys_clock_settime(). The kernel internal timekeeping is always usi=
ng
>   *    nanoseconds precision independent of the clocksource device which =
is
>   *    used to read the time from. The resolution of that device only
> - *    affects the presicion of the time returned by sys_clock_gettime().
> + *    affects the precision of the time returned by sys_clock_gettime().
>   *
>   * Returns:
>   *     0               Success. @tp contains the resolution
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.=
c
> index c0c54dc5314c..d4f4398dec50 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -708,7 +708,7 @@ void tmigr_cpu_activate(void)
>  /*
>   * Returns true, if there is nothing to be propagated to the next level
>   *
> - * @data->firstexp is set to expiry of first gobal event of the (top lev=
el of
> + * @data->firstexp is set to expiry of first global event of the (top le=
vel of
>   * the) hierarchy, but only when hierarchy is completely idle.
>   *
>   * The child and group states need to be read under the lock, to prevent=
 a race
> @@ -1621,7 +1621,7 @@ static void tmigr_connect_child_parent(struct tmigr=
_group *child,
>          *   created group (parent).
>          *
>          * * It is ensured that the child is active, as this setup path i=
s
> -        *   executed in hotplug prepare callback. This is exectued by an
> +        *   executed in hotplug prepare callback. This is executed by an
>          *   already connected and !idle CPU. Even if all other CPUs go i=
dle,
>          *   the CPU executing the setup will be responsible up to curren=
t top
>          *   level group. And the next time it goes inactive, it will rel=
ease
> --
> 2.34.1
>


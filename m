Return-Path: <linux-kernel+bounces-785481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE5B34B76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210537B6962
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE68284B4E;
	Mon, 25 Aug 2025 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STYP7gjk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361D241139
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152259; cv=none; b=TtHed/EPxjkui4PSJv03vZq3X3YHEspkIrlDAbwtII1tDx3+MkeqyU6m1SmTkBN5GiYJ8umYo53xFYxOnddWuxhlIXfbZO9zBmlvNq+CBRidb/EC6Uubm36evv4DwKV0R7shgWHAvGjybVwy5F3xZihjMN4wrhTzX13EFcMdHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152259; c=relaxed/simple;
	bh=pyWx7ry8nEacECBvmsh/YLjQdGyXYlLQ42MxR3XUzoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv+Ly/YWd76nIPz52iI0Dc4o1z41o8jBq6QPQX54/+X5o/MIQEdvofP5ypfA0M+LUlq4K/H3vF1jvM/7Sq8w8gZAwZgCQt3vSfxKB9bYM+yau+QXKeyGzvNcmfWae+0Od43tzItU3DiBVghmaZvRhBXTL67JYysOGm9heYZCYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STYP7gjk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756152256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJH9EhR8F3NMH6Mg9oHMpa9As8D7ScamjFnUd9vCRrg=;
	b=STYP7gjk+adLbx6ag1fnPOBaUVm61no1RfomGDXI4Q5//Y98jcwLTBZFgZ2HQbu7Ff+a9X
	oeYtxi9qzNv1sWECFWUnAXI9FTwUP/tWQH8TbDyBhYJhxTgAqAprWvDMPy6APBcAsbUub5
	v8tBEJ2F6i/2zzq74Ff1L2/wzo1I5W4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Po4t6vkoOvmRdxuWwqqFMQ-1; Mon, 25 Aug 2025 16:04:15 -0400
X-MC-Unique: Po4t6vkoOvmRdxuWwqqFMQ-1
X-Mimecast-MFC-AGG-ID: Po4t6vkoOvmRdxuWwqqFMQ_1756152253
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-33669a1511dso4572271fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152253; x=1756757053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJH9EhR8F3NMH6Mg9oHMpa9As8D7ScamjFnUd9vCRrg=;
        b=gx2FQYutEqpLF4NtRVf9PFlTypCT9fCa/XF4Npvbu4jismIc5pIfe5x0p+RulHfEMS
         bNY43LSP/PCKqaNUZZQKfvWNB0vdNFUl2avXH2lc/LI0PEe4anYrY01RhcdAqFRgsYU3
         TA1HJPVM4rE6Qs1hpZV76q5ycSCFU1YJiyJWRCO9yKsOYbNux78jpBrnm3KCuzCs4FRS
         HbLmTFgwGmorx0pHF8BuB9Qm9BFdDofYAYJ4fFfdfk9cc/WBxMyTagF2VUA0LCPcsm5Q
         YkAyZcJgJ/2e0ciLea10VU9ljguPnTSr5cAuHYRWWt6Zk7MBkzn21lVmvVfI/HZzQgSw
         zyTQ==
X-Gm-Message-State: AOJu0YykFZBpH+OpjfcdDU5brxxgY/aNGenGle8FgZM4f3AV3Jxynydh
	q9T04JWdn6WLS0+2dkOkUK61vReEQqS8kF9k72TSr++ui/uBgNyPeHhC+Clb2qQo2oz+XpbfSid
	SD5li4RtqQLB0qqieAW6VqjKlbodHznx3TZmA8r+0DLYneinsvs9pq7D2FBUPQFmSN4V7NMUpMe
	6V7EMPAntFt/FCZrnO2UZB/JEuVOiiW9yONOUnlesC
X-Gm-Gg: ASbGncsgT/FR1XLMyxkp7GG9lzLvE2SVVdLSGvpKs0PlO/b/7r/mmd4BC/RC5VwU4ao
	MgZYjU5Qvy/gvaPzxMFx/SGeDpifCOftyhxqFBbln5ua8cx5/oJ5+9WcC0Tja6XPoFXlLpV4BIe
	Ju52NVS4J5tfLkxM+zaA0=
X-Received: by 2002:a05:651c:4087:b0:332:747d:cca1 with SMTP id 38308e7fff4ca-33650f27bedmr22787741fa.21.1756152253307;
        Mon, 25 Aug 2025 13:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPFIrDim2hxceHvWasfE8u6dhciCqCYJ1oYcvo2fmdLzx5/3JXGvbWAHdI4Itg8M8009/Mz4VB17m4BvryUMQ=
X-Received: by 2002:a05:651c:4087:b0:332:747d:cca1 with SMTP id
 38308e7fff4ca-33650f27bedmr22787651fa.21.1756152252839; Mon, 25 Aug 2025
 13:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sehh2gw8.ffs@tglx> <87cy8j3ma5.ffs@tglx> <CAE4VaGC1wbN54Dpd0THKBhdSM9hoVqAc=jrGoc7+5vZNwGpKpQ@mail.gmail.com>
In-Reply-To: <CAE4VaGC1wbN54Dpd0THKBhdSM9hoVqAc=jrGoc7+5vZNwGpKpQ@mail.gmail.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 25 Aug 2025 22:04:00 +0200
X-Gm-Features: Ac12FXz5Z2HnZVPMbvAzshutNb2nfUF-xCSfdhNy2E2Q0Z8geLLovkH5a4Q8zMo
Message-ID: <CAE4VaGCr0L9bJ8ZUQwjhqc3DWT_z-AabMKOVZmvJm4PRR8v0qw@mail.gmail.com>
Subject: Re: [REGRESSION] 76% performance loss in timer workloads caused by
 513793bc6ab3 "posix-timers: Make signal delivery consistent"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, john.stultz@linaro.org, 
	anna-maria@linutronix.de, Philip Auld <pauld@redhat.com>, 
	Prarit Bhargava <prarit@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Luke Yang <luyang@redhat.com>, Jan Jurca <jjurca@redhat.com>, 
	Joe Mario <jmario@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me close a loop on this one.

Colin Ian King has updated the timer test in Stress_ng accordingly:
https://github.com/ColinIanKing/stress-ng/commit/048b4cb1bbc83cee377330b20e=
1bd366b651e4ad

Thank you, everybody!
Jirka

On Mon, Aug 25, 2025 at 1:35=E2=80=AFPM Jirka Hladky <jhladky@redhat.com> w=
rote:
>
>  Hallo Thomas,
>
> Vielen Dank for the detailed analysis, explanations, and insights. You
> are right, I fully agree with your conclusions.
>
> I apologize for reporting this as a regression. I've filed an issue
> with stress-ng: https://github.com/ColinIanKing/stress-ng/issues/560
> to request improving or documenting the stress-ng timer test
> accordingly.
>
> Liebe Gr=C3=BC=C3=9Fe,
> Jirka
>
>
> On Mon, Aug 25, 2025 at 9:15=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Sun, Aug 24 2025 at 11:44, Thomas Gleixner wrote:
> > > On Sat, Aug 16 2025 at 18:38, Jirka Hladky wrote:
> > > And this has nothing to do with timer migration or whatever, that's j=
ust
> > > a matter of correctness.
> >
> > Just to come back to timer migration. That's completely irrelevant here
> > because /proc/sys/kernel/timer_migration only affects the timer wheel
> > and _not_ hrtimers, which are used here.
> >
> > And just a few more comments about your findings:
> >
> > > grep -c hrtimer_start hrtimer*txt
> > > 6.12: 10898132
> > > 6.13: 17105314
> > >
> > > grep -c hrtimer_expire_entry hrtimer-6.12.0-33.el10.x86_64.txt
> > > hrtimer-6.13.0-0.rc2.22.eln144.x86_64.txt
> > > 6.12: 8358469
> > > 6.13: 3476757
> > >
> > > The number of timers started increased significantly in 6.13, but mos=
t
> > > timers do not expire. Completion rate went down from 76% to 20%
> >
> > Did you actually look _which_ timers were started and which ones did
> > expire and which ones not?
> >
> > Data for a 2 seconds run (couldn't be bothered to wait 23 seconds)
> >
> > On 6.10:
> >
> > All start/expire:
> >
> > # grep -c 'hrtimer_start' t.txt
> > 248039
> > # grep -c 'hrtimer_expire' t.txt
> > 247530
> >
> > stress-ng Posix timer related:
> >
> > # grep -c 'hrtimer_start.*function=3Dposix_timer_fn' t.txt
> > 246739
> > # grep -c 'hrtimer_expire.*function=3Dposix_timer_fn' t.txt
> > 246739
> >
> > stress-ng nanosleep related:
> >
> > # grep -c 'hrtimer_start.*function=3Dhrtimer_wakeup' t.txt
> > 2
> > # grep -c 'hrtimer_expire.*function=3Dhrtimer_wakeup' t.txt
> > 2
> >
> > On 6.17-rc1:
> >
> > All start/expire:
> >
> > # grep -c 'hrtimer_start' t.txt
> > 457456
> > # grep -c 'hrtimer_expire' t.txt
> > 304959
> >
> > stress-ng Posix timer related:
> >
> > # grep -c 'hrtimer_start.*function=3Dposix_timer_fn' t.txt
> > 304673
> > # grep -c 'hrtimer_expire.*function=3Dposix_timer_fn' t.txt
> > 304674
> >
> > stress-ng nanosleep related:
> >
> > # grep -c 'hrtimer_start.*function=3Dhrtimer_wakeup' t.txt
> > 152241
> > # grep -c 'hrtimer_expire.*function=3Dhrtimer_wakeup' t.txt
> > 1
> >
> > The 150k timers which do not expire are related to the restarted
> > nanosleep(), because the nanosleep is canceled due to the signal and ha=
s
> > to be re-started.
> >
> > On 6.10 that does not even reach the nanosleep in the test thread
> > because the thing is too busy with bogus signal handling.
> >
> > Trace for 6.10
> >
> >  stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime(ti=
mer_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
> >  stress-ng-timer-2229    [110] d..2.   187.938505: hrtimer_start: hrtim=
er=3D0000000023e2c3e0 function=3Dposix_timer_fn expires=3D186716941003 soft=
expires=3D186716941003 mode=3DABS
> >
> > Signal handler re-arms the timer
> >
> >  stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime ->=
 0x0
> >  stress-ng-timer-2229    [110] .....   187.938506: sys_rt_sigreturn()
> >
> > Returns from signal handler
> >
> >  stress-ng-timer-2229    [110] d..1.   187.938506: posixtimer_rearm <-d=
equeue_signal
> >
> > Dequeues the signal which was related to the arming _before_ the signal
> > handler re-arms it. So it's incorrectly delivered.
> >
> >  stress-ng-timer-2229    [110] d.h..   187.938507: hrtimer_expire_entry=
: hrtimer=3D0000000023e2c3e0 function=3Dposix_timer_fn now=3D186716941468
> >
> > Now the timer which was armed in the signal handler above expires
> >
> >  stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun=
(timer_id: 0)
> >  stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun=
 -> 0x0
> >
> > While the signal handler handles the bogus left over signal
> >
> > Lather, rinse and repeat.
> >
> >  stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime(ti=
mer_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
> >  stress-ng-timer-2229    [110] d..2.   187.938508: hrtimer_start: hrtim=
er=3D0000000023e2c3e0 function=3Dposix_timer_fn expires=3D186716943483 soft=
expires=3D186716943483 mode=3DABS
> >  stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime ->=
 0x0
> >  stress-ng-timer-2229    [110] .....   187.938508: sys_rt_sigreturn()
> >  stress-ng-timer-2229    [110] d..1.   187.938508: posixtimer_rearm <-d=
equeue_signal
> >  stress-ng-timer-2229    [110] d.h..   187.938509: hrtimer_expire_entry=
: hrtimer=3D0000000023e2c3e0 function=3Dposix_timer_fn now=3D186716943952
> >
> > vs. 6.17
> >
> >  stress-ng-timer-1828    [029] .....    84.089978: sys_rt_sigreturn()
> >  stress-ng-timer-1828    [029] d..1.    84.089979: posixtimer_deliver_s=
ignal <-dequeue_signal
> >
> > Signal, which was generated by the original armed timer is correctly ig=
nored
> >
> >  stress-ng-timer-1828    [029] d..1.    84.089979: hrtimer_start: hrtim=
er=3D0000000081582a37 function=3Dhrtimer_wakeup expires=3D83144889279 softe=
xpires=3D83144839279 mode=3DREL
> >
> > Nanosleep is restarted
> >
> >           <idle>-0       [029] d.h1.    84.089980: hrtimer_expire_entry=
: hrtimer=3D000000009e0c5084 function=3Dposix_timer_fn now=3D83134840265
> >
> > Timer which was armed in the signal handler expires
> >
> >  stress-ng-timer-1828    [029] d..1.    84.089981: posixtimer_deliver_s=
ignal <-dequeue_signal
> >
> > Signal is delivered and timer is re-armed:
> >
> >  stress-ng-timer-1828    [029] d..2.    84.089981: hrtimer_start: hrtim=
er=3D000000009e0c5084 function=3Dposix_timer_fn expires=3D83134842396 softe=
xpires=3D83134842396 mode=3DABS
> >
> > Signal is handled
> >
> >  stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun=
(timer_id: 0)
> >  stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun=
 -> 0x2
> >  stress-ng-timer-1828    [029] d.h..    84.089983: hrtimer_expire_entry=
: hrtimer=3D000000009e0c5084 function=3Dposix_timer_fn now=3D83134842856
> >
> > Re-armed timer expires and queues a signal
> >
> >  stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime(ti=
mer_id: 0, flags: 0, new_setting: 7f7cccf7dec0, old_setting: 0)
> >
> > Timer is re-armed
> >
> >  stress-ng-timer-1828    [029] d..2.    84.089983: hrtimer_start: hrtim=
er=3D000000009e0c5084 function=3Dposix_timer_fn expires=3D83134844444 softe=
xpires=3D83134844444 mode=3DABS
> >  stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime ->=
 0x0
> >  stress-ng-timer-1828    [029] .....    84.089983: sys_rt_sigreturn()
> >
> > Signal, which was generated by the timer armed on signal dequeue is
> > correctly ignored
> >
> >  stress-ng-timer-1828    [029] d..1.    84.089984: posixtimer_deliver_s=
ignal <-dequeue_signal
> >
> >
> > Thanks,
> >
> >         tglx
> >
>
>
> --
> -Jirka



--=20
-Jirka



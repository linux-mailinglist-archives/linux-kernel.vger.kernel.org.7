Return-Path: <linux-kernel+bounces-784594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603C1B33E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFEB16ACCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D72DA776;
	Mon, 25 Aug 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGrMLGhX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73453231856
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121775; cv=none; b=mo1xkOMSGb9Ba6QcfFbFaUN2xbVU//Dh615qvpALfBdh5PzYxMqKpyqEclOQ0ySpWiDgJoE3V41cMtx0BU3O3KhVggDznsN4sM/0esddkMgMT9+9f3FpkGwjVAWfrFUXFuCno6WElsdgPkkokZXO+B2DoPwqY4sK1gQdP+XK9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121775; c=relaxed/simple;
	bh=Plbaeuyixc4Eic4GNIvx2FhMazjc99VDFVbbKDr4ynk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/ULTCYqFpi2nHC80mHxozPPdIxAnOgM2ebPLnWTCt8OzCLFcBoR/FolKsxL20GQZrbiqvylc2z0oVIiZMjKoJgxWbLeupA1V6pru0z5pZW5xK85KN4WRa6/3NqYWDbStc0vUZKd3JeocAOGSOQyGYIDApFs3iZcRwtfNpXVai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGrMLGhX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756121772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNB2iKNxGHCeZmMCS8hRQ6pg/Xs3E84mjm7y4hWo920=;
	b=IGrMLGhXgdxTCu0D4PSq874FOaZdBZzOdZxsuuDNRm4MuhgNUJJqurZw7TtXfY/7Qj+twV
	PLbkVNrhAGZagE8d9Wmrc/aNOV21Pt6vh9fEJXbL0crjA+3YlSaLNlK3mpLskYSzffbq68
	am3kwjujcK4gCAztgNUSabx4vh7oOqY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-L2bnQAG8OxK1NaI99TL9FQ-1; Mon, 25 Aug 2025 07:36:10 -0400
X-MC-Unique: L2bnQAG8OxK1NaI99TL9FQ-1
X-Mimecast-MFC-AGG-ID: L2bnQAG8OxK1NaI99TL9FQ_1756121769
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-335360f9d14so12913001fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756121769; x=1756726569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNB2iKNxGHCeZmMCS8hRQ6pg/Xs3E84mjm7y4hWo920=;
        b=HOBr0E1sMxBNV6raDGeDzB5pbQenBbiDqhxc3bUbq4CMVPZvprxuK5mJOwi0VGyxPU
         KtZDzdASLfY1PHliFpAI0vcW9jWv81aRjw3hOffpu/qD6dVMVh6v3TIJtI/+tyLkvUxV
         XpjZedb9WueYJjQPKHD/MIm01OT7QGy+1Ki2HUNdVRcmsIJyM/BEQKNfvnnjHqNOLHKm
         Vk9EPECu67e5PY5PYBk0d0W6NBrddOxBqOmAohIBkNi125ADr12jQisn9VjFAF5jGZqe
         C+B905dCrqJZ00iJ6ElxPxWiiQVt1imWXfpCaiArqexMuUPFnaKpqpvEEywJN55HcVFf
         4kog==
X-Gm-Message-State: AOJu0YwOv7OUpZ6+PY246yDAcREUPTAiImM5WPbyUfnHwiL/4Dmskmmh
	zcv52A82Q6kMic76rFowvx/Qt/XpRToQewEOCnajkc44nboQhaanIZUUtoWi2LdiKAASRWDMUo/
	X+uQKRSI9xIQHYQ2mIPLYqeWMdtibMLMIn8pJoPGmF7WVKiyAE/TCR7FRIOD7mM+pn+qTjGEDrH
	iiYonMSODbRLtTjisnDCEjPVIu6dHofuBc9LvnuBe0
X-Gm-Gg: ASbGncuUueuF2Dux/Fotk7FweDgqvXQP0QLDma/CQa8pjMXnsH22IlthCOWgTiduXo6
	4Cu6XxHvrqH+wcBkfGoU1bh4UansMY8NSRuWnpeMifms130UzMUjC/3WLFlcbDvMSBnjYWS9kyq
	wCZ9BTUxFIxK2bG3pNMXk=
X-Received: by 2002:a05:651c:2344:20b0:333:c7c4:6bdd with SMTP id 38308e7fff4ca-3354a18bcf6mr30408131fa.2.1756121769233;
        Mon, 25 Aug 2025 04:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG81fEQJjg4EYjz4TfA9BVN+GmpNWeg9D/FsNkp6vfDW/IzjzY3jelkrvIr967+PP16r6bTXRxGOuczhvLMNP8=
X-Received: by 2002:a05:651c:2344:20b0:333:c7c4:6bdd with SMTP id
 38308e7fff4ca-3354a18bcf6mr30408011fa.2.1756121768785; Mon, 25 Aug 2025
 04:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sehh2gw8.ffs@tglx> <87cy8j3ma5.ffs@tglx>
In-Reply-To: <87cy8j3ma5.ffs@tglx>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 25 Aug 2025 13:35:56 +0200
X-Gm-Features: Ac12FXzFE-GAFMAyhNFvWir6FceZfjzHcu2vPHPJXrJTp_a1yN4Cu7F_2h1bCeE
Message-ID: <CAE4VaGC1wbN54Dpd0THKBhdSM9hoVqAc=jrGoc7+5vZNwGpKpQ@mail.gmail.com>
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

 Hallo Thomas,

Vielen Dank for the detailed analysis, explanations, and insights. You
are right, I fully agree with your conclusions.

I apologize for reporting this as a regression. I've filed an issue
with stress-ng: https://github.com/ColinIanKing/stress-ng/issues/560
to request improving or documenting the stress-ng timer test
accordingly.

Liebe Gr=C3=BC=C3=9Fe,
Jirka


On Mon, Aug 25, 2025 at 9:15=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Aug 24 2025 at 11:44, Thomas Gleixner wrote:
> > On Sat, Aug 16 2025 at 18:38, Jirka Hladky wrote:
> > And this has nothing to do with timer migration or whatever, that's jus=
t
> > a matter of correctness.
>
> Just to come back to timer migration. That's completely irrelevant here
> because /proc/sys/kernel/timer_migration only affects the timer wheel
> and _not_ hrtimers, which are used here.
>
> And just a few more comments about your findings:
>
> > grep -c hrtimer_start hrtimer*txt
> > 6.12: 10898132
> > 6.13: 17105314
> >
> > grep -c hrtimer_expire_entry hrtimer-6.12.0-33.el10.x86_64.txt
> > hrtimer-6.13.0-0.rc2.22.eln144.x86_64.txt
> > 6.12: 8358469
> > 6.13: 3476757
> >
> > The number of timers started increased significantly in 6.13, but most
> > timers do not expire. Completion rate went down from 76% to 20%
>
> Did you actually look _which_ timers were started and which ones did
> expire and which ones not?
>
> Data for a 2 seconds run (couldn't be bothered to wait 23 seconds)
>
> On 6.10:
>
> All start/expire:
>
> # grep -c 'hrtimer_start' t.txt
> 248039
> # grep -c 'hrtimer_expire' t.txt
> 247530
>
> stress-ng Posix timer related:
>
> # grep -c 'hrtimer_start.*function=3Dposix_timer_fn' t.txt
> 246739
> # grep -c 'hrtimer_expire.*function=3Dposix_timer_fn' t.txt
> 246739
>
> stress-ng nanosleep related:
>
> # grep -c 'hrtimer_start.*function=3Dhrtimer_wakeup' t.txt
> 2
> # grep -c 'hrtimer_expire.*function=3Dhrtimer_wakeup' t.txt
> 2
>
> On 6.17-rc1:
>
> All start/expire:
>
> # grep -c 'hrtimer_start' t.txt
> 457456
> # grep -c 'hrtimer_expire' t.txt
> 304959
>
> stress-ng Posix timer related:
>
> # grep -c 'hrtimer_start.*function=3Dposix_timer_fn' t.txt
> 304673
> # grep -c 'hrtimer_expire.*function=3Dposix_timer_fn' t.txt
> 304674
>
> stress-ng nanosleep related:
>
> # grep -c 'hrtimer_start.*function=3Dhrtimer_wakeup' t.txt
> 152241
> # grep -c 'hrtimer_expire.*function=3Dhrtimer_wakeup' t.txt
> 1
>
> The 150k timers which do not expire are related to the restarted
> nanosleep(), because the nanosleep is canceled due to the signal and has
> to be re-started.
>
> On 6.10 that does not even reach the nanosleep in the test thread
> because the thing is too busy with bogus signal handling.
>
> Trace for 6.10
>
>  stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime(time=
r_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
>  stress-ng-timer-2229    [110] d..2.   187.938505: hrtimer_start: hrtimer=
=3D0000000023e2c3e0 function=3Dposix_timer_fn expires=3D186716941003 softex=
pires=3D186716941003 mode=3DABS
>
> Signal handler re-arms the timer
>
>  stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime -> 0=
x0
>  stress-ng-timer-2229    [110] .....   187.938506: sys_rt_sigreturn()
>
> Returns from signal handler
>
>  stress-ng-timer-2229    [110] d..1.   187.938506: posixtimer_rearm <-deq=
ueue_signal
>
> Dequeues the signal which was related to the arming _before_ the signal
> handler re-arms it. So it's incorrectly delivered.
>
>  stress-ng-timer-2229    [110] d.h..   187.938507: hrtimer_expire_entry: =
hrtimer=3D0000000023e2c3e0 function=3Dposix_timer_fn now=3D186716941468
>
> Now the timer which was armed in the signal handler above expires
>
>  stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun(t=
imer_id: 0)
>  stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun -=
> 0x0
>
> While the signal handler handles the bogus left over signal
>
> Lather, rinse and repeat.
>
>  stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime(time=
r_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
>  stress-ng-timer-2229    [110] d..2.   187.938508: hrtimer_start: hrtimer=
=3D0000000023e2c3e0 function=3Dposix_timer_fn expires=3D186716943483 softex=
pires=3D186716943483 mode=3DABS
>  stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime -> 0=
x0
>  stress-ng-timer-2229    [110] .....   187.938508: sys_rt_sigreturn()
>  stress-ng-timer-2229    [110] d..1.   187.938508: posixtimer_rearm <-deq=
ueue_signal
>  stress-ng-timer-2229    [110] d.h..   187.938509: hrtimer_expire_entry: =
hrtimer=3D0000000023e2c3e0 function=3Dposix_timer_fn now=3D186716943952
>
> vs. 6.17
>
>  stress-ng-timer-1828    [029] .....    84.089978: sys_rt_sigreturn()
>  stress-ng-timer-1828    [029] d..1.    84.089979: posixtimer_deliver_sig=
nal <-dequeue_signal
>
> Signal, which was generated by the original armed timer is correctly igno=
red
>
>  stress-ng-timer-1828    [029] d..1.    84.089979: hrtimer_start: hrtimer=
=3D0000000081582a37 function=3Dhrtimer_wakeup expires=3D83144889279 softexp=
ires=3D83144839279 mode=3DREL
>
> Nanosleep is restarted
>
>           <idle>-0       [029] d.h1.    84.089980: hrtimer_expire_entry: =
hrtimer=3D000000009e0c5084 function=3Dposix_timer_fn now=3D83134840265
>
> Timer which was armed in the signal handler expires
>
>  stress-ng-timer-1828    [029] d..1.    84.089981: posixtimer_deliver_sig=
nal <-dequeue_signal
>
> Signal is delivered and timer is re-armed:
>
>  stress-ng-timer-1828    [029] d..2.    84.089981: hrtimer_start: hrtimer=
=3D000000009e0c5084 function=3Dposix_timer_fn expires=3D83134842396 softexp=
ires=3D83134842396 mode=3DABS
>
> Signal is handled
>
>  stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun(t=
imer_id: 0)
>  stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun -=
> 0x2
>  stress-ng-timer-1828    [029] d.h..    84.089983: hrtimer_expire_entry: =
hrtimer=3D000000009e0c5084 function=3Dposix_timer_fn now=3D83134842856
>
> Re-armed timer expires and queues a signal
>
>  stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime(time=
r_id: 0, flags: 0, new_setting: 7f7cccf7dec0, old_setting: 0)
>
> Timer is re-armed
>
>  stress-ng-timer-1828    [029] d..2.    84.089983: hrtimer_start: hrtimer=
=3D000000009e0c5084 function=3Dposix_timer_fn expires=3D83134844444 softexp=
ires=3D83134844444 mode=3DABS
>  stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime -> 0=
x0
>  stress-ng-timer-1828    [029] .....    84.089983: sys_rt_sigreturn()
>
> Signal, which was generated by the timer armed on signal dequeue is
> correctly ignored
>
>  stress-ng-timer-1828    [029] d..1.    84.089984: posixtimer_deliver_sig=
nal <-dequeue_signal
>
>
> Thanks,
>
>         tglx
>


--=20
-Jirka



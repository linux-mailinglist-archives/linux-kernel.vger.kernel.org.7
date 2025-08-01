Return-Path: <linux-kernel+bounces-753588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A63B184F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5713A583F28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EDF272E70;
	Fri,  1 Aug 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b="kP8m97uQ"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52751272E63
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062174; cv=none; b=aneTJ6nkiqooP5S3q8Tb26kkfdtAQZVuDdBmj8X74uhQocQWKYt7zrcnBI8QZg5gtTxZIQyzZcID/QrdpM9HQyn8lMrFgDU0baXMPQ3pu6J3bN/+T0KJYYJWLlvMKIKTQD7hN6hhV0xg4u5R0o/4wcAvsBtD7zKC2EjIvcW5/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062174; c=relaxed/simple;
	bh=aDrp6QTE3vQlufqkuk57uRNs4GKDCnFor8g6lBNfRG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIh0OfK/Cs+fDnYluXD+K1SSMd6fw0jNImCZJWLg6vhmPqi6/yJhzs6r+bLZopim7ySyErPrhO2R7QhFS/2T25nVKrccGO0rrsxJ6oHapug5A4/BJo7LGf9+W1yX9G9CeX9Oj1pnKOWrY43RkEtnux+1ivpv69IjofUZlqaQjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com; spf=pass smtp.mailfrom=simplextrading.com; dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b=kP8m97uQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplextrading.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4fc18de8e1bso587671137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simplextrading.com; s=google; t=1754062171; x=1754666971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDrp6QTE3vQlufqkuk57uRNs4GKDCnFor8g6lBNfRG0=;
        b=kP8m97uQ+PhbHOhjPfUEnWD1rSq4BeEECHnB+0YsLBRYk8naosn02b0r6EmU3IIVGl
         WnrnxjgiGnbwtFhujQluu9+pcW+4Z2IEcoOO84LYgaLY26M8oxWN1REtZDIfrI2U9J6u
         2MhFewlyAm2l4vMOFXK2A3bDX241Wz0zcBIilm416zeWF0BBaYfj/Y2uWgPT7uc72inj
         Y0cwmL4/kcGvFzWHyNGkYpAg8OxhJqbX9GJgIN/dAgCvHAPrQ/XUSSripfeUk16BZq1y
         hgm9iGC5uITy+gAsYCJq3/1UtPkknmgTXmeZVsxTQVyDfyh3KUN/Q2BtQbz8Auqdq+29
         Vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062171; x=1754666971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDrp6QTE3vQlufqkuk57uRNs4GKDCnFor8g6lBNfRG0=;
        b=J26YJ/vXieanoHK87W2SlbY/6tOZ2tfL/21YtlnV4hBRBN58B1EjoUk5NgXevg4p6H
         4aIdMyQmzDYmX7RsIE5+t4PGmRsQu6xMtRADDnP0BdMxGuKxvgjAq2UP2qtF4ySl6nL7
         bu1y2xyF9PFWaTUw91uDq1+1ao3pnsZTb2ZSQxdfthd1Y6UD0++2WLRpbVIFcWmaFETX
         F22GDzQ0FN4lzMi3eOB+BL3vJ2heHUX9o9roxeHgUGFIQ46AUKT3zMUJ08CS18WTSFa7
         9V5o7ywHcwdOkz19+gDL5T2BIBVup7sg4jFh392I9p2nlLzky++OctV0WUhlGtHsVICo
         HHiQ==
X-Gm-Message-State: AOJu0YxZkNeFhpj93VKmCymZqtDkYZrbLLIkvQdjx1Ma1j4RcgKIF87u
	vzHbisj6fHn5TSil7cIAL2zyEsjmC7vJWp57eMZw67vxjQVIKEEIU6S60io6wWp7Zdu/4Us2d7W
	VkJklQZfcsOqg1MpUbIVvVw4rnNJ7d+fJg3xDYQPjmyd0TUWUOWzX0ZLgk9odVN/iHPv+srwSUP
	AcWSXbmyEjF6C2Zs7OydGo0Ono5L1CScA7rHFP9Ua4/C9RqGsCH1YMQ5rWH1JHHM6v++gqMIJZR
	Y15bwy1szvmIgkGnpz2FpT2QlRw6t1jqXEhgU3pspTglR4BkZmv5fr8SJHRAQblq+PIcRV1l1jk
	rLkLY7TzoQ6L8DF/1w==
X-Gm-Gg: ASbGncvkt+sdRqQPcm0ESMlBOdyotw9XJMuvPkvL0vic9IfdLVGbl3zd2IuDgLLhlmv
	O9yAjWq9QC8QEvVHJMBipAwx4Rl20wO2Is3H0ul5UshQcVBwpOcbX7P2FfRdUjn9uvHDF7/W3Is
	v8GDHNgM9bplivxo+phzFkBKu614v7zUgDNwzwMGEQ4bSN+dHKv1h6f6boob+sFG9WEQ94pNN4O
	Kp5XyGT
X-Google-Smtp-Source: AGHT+IHCpIenQ+d0leh+aRK8PISBKfjJR6c+GO8lCaKqDNLGzkMhofT6mcfhPUYkkFemYcsDvUb7lsv+yyNRG64PBpc=
X-Received: by 2002:a05:6102:5e96:b0:4fd:3b3:d4b0 with SMTP id
 ada2fe7eead31-4fd03b3dde9mr1395923137.20.1754062170753; Fri, 01 Aug 2025
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb> <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>
 <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb>
From: David Haufe <dhaufe@simplextrading.com>
Date: Fri, 1 Aug 2025 10:28:54 -0500
X-Gm-Features: Ac12FXy0nrGk73i_OuIEFAEnl3DCOCv52P2061hHkuhC8lV1aT3J1AQ9X26LJaY
Message-ID: <CAKJHwtOdiFTenF=zCL7_8c148Qs37r53k9uAKURLjq1JFJGeXg@mail.gmail.com>
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am sorry, but we cannot get this branch to boot on our hardware.
Looking through the code of the branch, it will not address the issue.
I believe the issue is more fundamental. In
fair.c->enqueue_task_fair(), dl_server_start() is called when the
single fair/SCHED_OTHER task is added to the isolcpu/nohz_full core.
The check here is simply checking if there is 1 or more process and
kicks off the dl_server_start() and the housekeeping timer in
start_dl_timer(). Once this timer is running, it will invoke
dl_server_timer() continuously. This timer calls __enqueue_dl_entity()
and then inc_dl_tasks(). inc_dl_tasks() increments
dl_rq->dl_nr_running++ and invokes add_nr_running(). This code will
eventually call the sched_can_stop_tick() function but
rq->dl.dl_nr_running now !=3D 0, so this function will always return
false. Something needs to be done to prevent this timer from running
in the first place, or maybe have some checks around single
"fair/SCHED_OTHER/etc" process running on an isolcpu/nohz_full core
which prevents the need for the deadline code to run for the core.

On Fri, Aug 1, 2025 at 4:06=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> w=
rote:
>
> Hi,
>
> On 31/07/25 12:48, David Haufe wrote:
> > Kernel 6.16 shows the issue. /kernel/sched/fair.c calls dl_server_start=
()
> > and there is no assessment prior to that point or later of the
> > isolcpu/nohz_full+single-process condition of the core. Same function_g=
raph
> > trace generated. Code is the same at tip+sched/core.
> >
> > On Thu, Jul 31, 2025 at 2:02=E2=80=AFAM Juri Lelli <juri.lelli@redhat.c=
om> wrote:
> >
> > > Hello,
> > >
> > > Thanks for the report.
> > >
> > > On 30/07/25 11:51, David Haufe wrote:
> > > > [1.] Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
> > > > Interrupts on isolcpu/nohz_full cores, performance regression
> > > > [2.] The code for dl_server_timer is causing new IPI/Function Call
> > > > Interrupts to fire on isolcpu/nohz_full cores which previously had =
no
> > > > interrupts. When there is a single, SCHED_OTHER process running on =
an
> > > > isolcpu/nohz_full core, dl_server_timer executes on a housekeeping
> > > > core. This ultimately invokes add_nr_running() and
> > > > sched_update_tick_dependency() and finally tick_nohz_dep_set_cpu().
> > > > Setting the single process running on an isolcpu/nohz_full core to
> > > > FIFO (rt priority) prevents this new interrupt, as it is not seen a=
s a
> > > > fair schedule process anymore. Having to use rt priority is
> > > > unnecessary and a regression to prior kernels. Kernel function_grap=
h
> > > > trace below showing core 0 (housekeeping) sending the IPI to core 1=
9
> > > > (nohz_full, isolcpu, rcu_nocb_poll) which is running a single
> > > > SCHED_OTHER process. I believe this has been observed by others.
> > > >
> > > https://community.clearlinux.org/t/sysjitter-worse-in-kernel-6-12-tha=
n-6-6/10206
> > >
> > > Would you be able to check if the following branch, containing multip=
le
> > > fixes for dl-server, is still affected by the regression?
>
> Apologies, I forgot to share the actual branch. :-/
>
> Could you please test with
>
> https://github.com/jlelli/linux/commits/upstream/fix-dlserver-1/
>
> Among various other fixes, 219a63335b67 ("sched/deadline: Don't count
> nr_running twice for dl_server proxy tasks") is making sure we don't
> count fair tasks twice, so I am wondering if it can have an effect on
> entering nohz_full.
>
> Thanks,
> Juri
>

--=20
DISCLAIMER: NOTICE REGARDING PRIVACY AND CONFIDENTIALITY=C2=A0

The information=20
contained in and/or accompanying this communication is intended only for=20
use by the addressee(s) named herein and may contain legally privileged=20
and/or confidential information. If you are not the intended recipient of=
=20
this e-mail, you are hereby notified that any dissemination, distribution=
=20
or copying of this information, and any attachments thereto, is strictly=20
prohibited. If you have received this e-mail in error, please immediately=
=20
notify the sender and permanently delete the original and any copy of any=
=20
e-mail and any printout thereof. Electronic transmissions cannot be=20
guaranteed to be secure or error-free. The sender therefore does not accept=
=20
liability for any errors or omissions in the contents of this message which=
=20
arise as a result of e-mail transmission. Simplex Trading, LLC and its=20
affiliates reserves the right to intercept, monitor, and retain electronic=
=20
communications to and from its system as permitted by law. Simplex Trading,=
=20
LLC is a registered Broker Dealer with CBOE and a Member of SIPC.


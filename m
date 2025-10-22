Return-Path: <linux-kernel+bounces-865750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44ABFDE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 521A05461F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B2734E74E;
	Wed, 22 Oct 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4ABvbj4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD134DCCF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158513; cv=none; b=WR1pFb2BHZ9qPm7pQWflsmqmASC55nav+josV3cJKuho69oEjwHp8TYXOiLX+cLjtqXvK5TVEOU5uagIXKimlm98ocI+yabVPnTWLO1msfNvArupNSZmsL+FRnKq/pcAmViAQrvWBU8svjKTqtOImB8F+zxKqBMDXl62vxWXlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158513; c=relaxed/simple;
	bh=4SsgFy3W8i6VYi5migZylUtx9+LlsgxxkwCdOCuq1ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKd7EQBhHh98hqdrb1z8nGBPcdqDIo4Enc39EW2kywRSc7SAA1AheriZ+dy1plb1uH+kj8bYe/5ljp268KXihENOSt2nclJTwSTUA7lrR4kYTrNJ0NZs/lHhtp9DIQgB6DaK1uixtZKZaVOaEi8PwZDwiLBmsuCCSjEE10EeWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4ABvbj4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so13086324a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761158509; x=1761763309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBSNtwt1hqivpMpQtmcSf95eEecb17MZgEpr3DvvZp8=;
        b=C4ABvbj4hEYyxN0hqadq04T0CTTUoZmxChgIpTw13E21PH2Mqw7qmXdxamV1Pm8HaE
         T/JkCy+a1EACehR0AwlaDvnOA1bs/DGiZRt68+TMKfe9nc3Q5oBCgqUh+ejDPQ8eWrgm
         XzV+lEwxAgLjWOKoBLXyaOpVN8wxLeiAvD8yOKaEpI3+VRUgEmBmK1kZq9/7n3FtSuSy
         dYcu+nhRt2OK3+gNbjJkTrcrUhFUwUqQIOdDTIf5vqPrVhW+Ib/nNGPqHtP9xdkmI9VB
         EQbRQ8LzUL/wI2TIa47+/WdMW1dTt0bm3KXcXyBMz6QSgbKIKkOA4sTyaidCpRG65C26
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158509; x=1761763309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBSNtwt1hqivpMpQtmcSf95eEecb17MZgEpr3DvvZp8=;
        b=wLRrFw2z3czLLRgOP324q6xUdSvHfxrU0zaUkXqrumHOSyIn9u+VvqoJKyC4Ep9JrN
         t5T6iH4dvTq41U32WUQh91NK6jjurjIXc7coHRlOZw6WM5X3AbmB7SWx9dpJ0IwWAACS
         RUnmGg6fRd42aTr/F+mJIbZy0bHOKtJiyqa8Exn71nl6IeJyxmw+Be3slApThzm4U1fT
         YKCuogqfj5muxTy8pL9USAlvogpZM+ZPx3EB9G9Zck2fapMGT7yZApj70UxfBIe0WcD3
         vCO3hcveWVH+xOB1ZaXA9YbbzZv2+t10CpRxsJsrFx6Js58zkhLofoHoaTRipiiLta4A
         mO8w==
X-Forwarded-Encrypted: i=1; AJvYcCWk+Qnt/nSgm097G9Xwcxv99mBR8r9dp1/gkO0OU8C+3eaOv+o7uDvAvfEZ1Sz31oW1ngPqN6wsa8OEn/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFaXLZflID+vTtClcpjiuS1v/JAtYjAzKIttDUQ+WBd2hkHAo
	gvMU1pwnmEhEjv0v0BK4YbfeANsSomLSaOplz5eQR/cllQwB0sD53pVR9gp/i1fukY4V9QoK1q7
	7WWPqH29H2IHCUdyua3g+Ot5X/MPxRJ+UjGB8lPZZ
X-Gm-Gg: ASbGncvbyWmSod5MthLrf1f17fwsuECxaPj8cnRrlz03OyLhhGp4iBKbQre8rKI51Xs
	IkN9TfhXw8DKzbjCx3pEBQxJRbmR+IvjGJpVgKf7JrLFoTw8rC2xtaXydZEUzS2K7RQCTk8HgbV
	SvhbhcOJRXvkgGYmAIfWYmPYC9NPoGdhLf7gV5h/xXegIJncxw2C+ds9DL7M8ck4NMvPA5rXBrs
	AfSWStqp+1Qmz2GE4q2IRuwKuREEP8IhKgpu6cEtdlKVeuMHuA5DxXjC3sl6rjrOtfMJqEo2Tc5
	ZXbGKg+lrpKlefp2YQhbid3y
X-Google-Smtp-Source: AGHT+IG9QOCvLGRlm2L1hQvr/syZxkOWJ3YGHVm/KAKKxfnnsFMCKtjyaFKcnKslc2naOE06t43sSnnXWGnsfmQWWbQ=
X-Received: by 2002:a17:907:bb49:b0:b4b:4f7:7a51 with SMTP id
 a640c23a62f3a-b6475706fc2mr2674087066b.62.1761158508815; Wed, 22 Oct 2025
 11:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctpHA+L=xh-VQ8SVDSRcqyL+ch=WMVrKS+pckLmC6uJwvw@mail.gmail.com>
 <20251022011547.8648-1-hdanton@sina.com>
In-Reply-To: <20251022011547.8648-1-hdanton@sina.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 22 Oct 2025 11:41:37 -0700
X-Gm-Features: AS18NWBw4EAoALtfgytkbkwkbw8Bd9QzC3V--BUqEq20Lf9R4DR6aXlMdo7JRKk
Message-ID: <CAG2KctoJ+1x61KNmDj_52J1_Y3vyox7UNceFw6_WtbRMA_1vYA@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Hillf Danton <hdanton@sina.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:16=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, 21 Oct 2025 13:13:39 -0700 Samuel Wu wrote:
> > On Fri, Oct 17, 2025 at 5:17=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > > > +/**
> > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > + *
> > > > + * Return 0 on successful file system sync, otherwise returns -EBU=
SY if file
> > > > + * system sync was aborted.
> > > > + */
> > > > +int pm_sleep_fs_sync(void)
> > > > +{
> > > > +     bool need_pm_sleep_fs_sync_requeue;
> > > > +     unsigned long flags;
> > > > +
> > > > +     do {
> > > > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > +             reinit_completion(&pm_sleep_fs_sync_complete);
> > >
> > > Given difficulty following up here, can you specify why reinit is nee=
ded?
> >
> > There are two possibilities that make reinit_completion() necessary:
> > 1. Suspend abort triggers completion, but is canceled before
> > pm_wakeup_pending(), so need reinit to restart the
> > wait_for_completion() process.
> > 2. Handling back-to-back suspend attempts: after a subsequent suspend
> > attempt finishes waiting for a previous suspend's fs_sync to finish,
> > we need the reinit to start the wait_for_completion() process of the
> > subsequent suspend's fs_sync.
> >
> If 1. and 2. matches the comment for wait_for_completion() below,
>
>         static DECLARE_COMPLETION(foo);
>
>         waiter          waker1          waker2
>         ---             ---             ---
>         for (;;) {
>           reinit_completion(&foo)
>           do anything
>           wait_for_completion(&foo)
>                         do bar1         do bar2
>                         complete(&foo)  complete(&foo)
>           if (end)
>                 break;
>         }
>
> the chance for reinit to drop one wakeup is not zero.
> If drop makes sense, for what do you wait after receiving two wakeups?
>

If I understand correctly, you are referring to the case where
multiple wakers trigger wait_for_complete() simultaneously, hence
having at least one waker's complete() being ignored?

If so, I see two possibilities with multiple wakers:
1. fs_sync finishing + suspend abort1 + ... + suspend abortN
2. suspend abort1 + ... + suspend abortN

Simplifying, if two wakers come in simultaneously, while one of the
wakers may have its complete() ignored, the state of that waker is
still checked after wait_for_completion(), with
if(pm_wakeup_pending()) and while(need_pm_sleep_fs_sync_requeue) for
suspend aborts and fs_sync finishing respectively.

> > > > +             /*
> > > > +              * Handle the case where a sleep immediately follows =
a previous
> > > > +              * sleep that was aborted during fs_sync. In this cas=
e, wait for
> > > > +              * the previous filesystem sync to finish. Then do an=
other
> > > > +              * filesystem sync so any subsequent filesystem chang=
es are
> > > > +              * synced before sleeping.
> > > > +              */
> > > > +             if (pm_sleep_fs_sync_queued) {
> > > > +                     need_pm_sleep_fs_sync_requeue =3D true;
> > > > +             } else {
> > > > +                     need_pm_sleep_fs_sync_requeue =3D false;
> > > > +                     pm_sleep_fs_sync_queued =3D true;
> > > > +                     schedule_work(&sync_filesystems);
> > > > +             }
> > > > +             spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags)=
;
> > > > +
> > > > +             /*
> > > > +              * Completion is triggered by fs_sync finishing or an=
 abort sleep
> > > > +              * signal, whichever comes first
> > > > +              */
> > > > +             wait_for_completion(&pm_sleep_fs_sync_complete);
> > > > +             if (pm_wakeup_pending())
> > > > +                     return -EBUSY;
> > > > +     } while (need_pm_sleep_fs_sync_requeue);
> > > > +
> > > > +     return 0;
> > > > +}
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>


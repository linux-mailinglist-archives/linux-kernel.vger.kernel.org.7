Return-Path: <linux-kernel+bounces-894829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB0C4C2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A74A94F4E39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FE299950;
	Tue, 11 Nov 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBWfWD3g"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33663271462
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847457; cv=none; b=PklihsPiz6fQybUch+gt4bswOkidcKl3QYTxmGpy25I1m+xjsjJ38WYVZInfZEAzdgi344hVwGSv9FCEBQ/3vBg+O2PyGRbAEz+l4oCM2VTxJy5yYbXTFVfctqQfO/r8O2VYEwIuKhVARZNdSalBIhZTj/CBLJpLAcd4w5RqoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847457; c=relaxed/simple;
	bh=wgbBjKCXPt44908Da8imHeITevGlc2N0snoDZHBarJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPE+RCTZmZQE7feUHWZympFvt5WQMzDta/NccLjIS5rye9o/BvMz7kQfV/JFyxJ5Cv6pC9DES6wFTlC/lAQndV+zaupZBgDQ3Dxis5X0zJbBv0iO3iacpqJbDwzjzbsCg7M69L6B4Fllb3JzT8aJDYBzQEyl3l9JWN4gxxsFg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBWfWD3g; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7260435287so583093566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762847453; x=1763452253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPb3RU6wwcBtxeOtftIdEiiFPQNHy2zbBJnXdVFccXw=;
        b=KBWfWD3gqQ/8i3tz5nbhvHRxWwe5jwjZVNUzmWvlF8ulvUs7lJm1Lz1A42Yu5Nd3xD
         xzdNMt/HIfruVJnYYeeZh4XR49qkZ5BST0ynOMpcxk1NGHkLMYJdpyPH662ak7TcPlts
         jRC59+0zH1QStCQzGMtx8miGfoyemXltZzCEUJBjGvPMQ7BN78Spu/3Nm/vRVu/F6X+j
         6QPPLTUbDXzqs1tOoDWZ+lA0/nniWOcwmJVQdT2+i0PhBm2UB+orIq4D/mHyULRWGtRH
         9ufOCqNC3STa2GcyvNxC6xWHgRtSVhPohTK5I2j9mxP96hm8IDhnUhWTsFrvMYGxlEFw
         6JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847453; x=1763452253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPb3RU6wwcBtxeOtftIdEiiFPQNHy2zbBJnXdVFccXw=;
        b=BkLN3T2jW3HbzdUz3nmlR+7gigCThjXunn1cQSGG9WrclGdpIzxmhqgxuw6UH8f3UE
         kysKfxB3hBgT4oIbt42KY+1mwpIYlJLwpEVMT1c2fsyNgl2Xyu5cYDiSaDZywUtOl175
         VvVbtv6c0RRC5Jb9UiiBt9bDQ631XLW6mhtjjvl2Z2j8g72t/x0SpTrYMc1EKy9cQ215
         punfbXw82A+8tqw15FIwD2dVlOIeESYf9Y93+Ne4+ZYGBncznYpO0mub+Fd2MFEesBlP
         IEKNZPQbD4rfcSjplNUFOMHsgMuSF6/fnUFA+hXOqvH/MC0rvm3CYQBJ9P5+GB+Aumvi
         dyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6jaSyljVZm//3cSiyLDhvgAa8r5hCnFYV+TWFd2a/cEf/aG9yBWXlMWNeJcxTsJhx7sjgIE6UAAaUzFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtMHx1+5OEQDPhGoZ0Tr4/oeL2zkY4UvcyyCXzo2KAGTsR2Nh
	Ghwwg5F3N1T2Vtdr6BPstHNtE/HZgx854FIJGq2/kEQvvZzlD/cw9QT2ol6jLCY0Sve+/OdCZp1
	ebETsjsBYLxx6u8oOc32qQq3sSFibNXbnD3sPsHw=
X-Gm-Gg: ASbGncs4QVSWUQmnEehZQtIEGDQDzARRWNlMZh849cztekd3x1vbIqwMnAUfe30v+Ua
	ZAK7bUmJygXCs4ZqAb2yIultZq/4WQTD+f4W+F7q3ASVzlaut4jWbMxDHMb5TMz+boqSbWF4Nhb
	ENI9yypMbDZj98JdCEhD+Aw2Jgu2+yxiO1ahBGFlwWHK+zuwg1agDpXB1H1E9MzXGXYnyx6Kfrj
	wmJnEHWQYedZzEeZUH+yuzhbmRSITlO0KQCh8jgI46OcWRk5jQt2YKbvZjGbNb7+Lz0kTJYF9au
	OIUE8HO44m3Q0rStO8TYjZdL62dzzDQxAw==
X-Google-Smtp-Source: AGHT+IGUExnaVr6M9xvfzXovOqhuvZapgeGIImxDTwkzsYq3skke52Dt66s1HawJ5Sj22ETKPhwaG9CQIrUxADSW9FY=
X-Received: by 2002:a17:907:3f9b:b0:b72:62b2:26a1 with SMTP id
 a640c23a62f3a-b72e0337345mr920803666b.19.1762847453142; Mon, 10 Nov 2025
 23:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-9-jstultz@google.com>
 <f9b42bf8-e4c8-4028-a977-f324ba2f2275@amd.com>
In-Reply-To: <f9b42bf8-e4c8-4028-a977-f324ba2f2275@amd.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 10 Nov 2025 23:50:40 -0800
X-Gm-Features: AWmQ_bm8qGh50p49pV_NgYsgWmZWd5A0cVU0KIOWVMlxdIXcGv4iyMlcL-l4ET4
Message-ID: <CANDhNCp=zbjcy-eCwKHcbgLSJjgzqz8ZLTMyZzNMkuXtLXseMg@mail.gmail.com>
Subject: Re: [PATCH v23 8/9] sched: Add blocked_donor link to task for smarter
 mutex handoffs
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <valentin.schneider@arm.com>, 
	"Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:03=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
> On 10/30/2025 5:48 AM, John Stultz wrote:
> > @@ -958,7 +964,34 @@ static noinline void __sched __mutex_unlock_slowpa=
th(struct mutex *lock, unsigne
> >
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> >       debug_mutex_unlock(lock);
> > -     if (!list_empty(&lock->wait_list)) {
> > +
> > +     if (sched_proxy_exec()) {
> > +             raw_spin_lock(&current->blocked_lock);
> > +             /*
> > +              * If we have a task boosting current, and that task was =
boosting
> > +              * current through this lock, hand the lock to that task,=
 as that
> > +              * is the highest waiter, as selected by the scheduling f=
unction.
> > +              */
> > +             donor =3D current->blocked_donor;
> > +             if (donor) {
>
> Any concerns on new waiters always appearing as donors and in-turn
> starving the long time waiters on the list?
>
Hey!
  So I'm not sure I'm quite following the concern. The scheduler picks
"the most important task in that moment" to run and we just want to
try to to pass the lock off to the donor that was boosting the lock
owner.

Are you concerned that new waiters would somehow always be further
left on the rq and would be selected as donors before other waiters on
the rq? I can sort of see the argument that "new waiters" would be
running until they try to get the lock, so they may have timeslice
still available to make them attractive to the scheduler as a donor,
so maybe they would be re-selected as a donor right away. But I'm
assuming at some point the fairness is going to cycle any waiting
donors up to the front of the rq to act as a donor and then have the
lock handed off.

That said, I don't see how this would be very much different from
new/running optimistic spinners having a better chance at grabbing a
lock then waiting tasks that aren't running.

But let me know more about what you're thinking of, as I'd like to
better understand it and see if I could contrive a test to produce
this sort of concerning behavior.

thanks
-john


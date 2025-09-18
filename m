Return-Path: <linux-kernel+bounces-823723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323EDB87525
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336847E3AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680E287242;
	Thu, 18 Sep 2025 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he+EI4wa"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF482F2E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236881; cv=none; b=JzpKayIOi3oe/UA9QFdzK5mtvJy/CHD8r3fhaq2+bicBMayEw5duy7HyjsccHHpTNq3HbUZ+x1669yqQ7EyBMMqbPRPXeX+gn4W1gfla2uqo0EE3mVepwqHmPzp948jBM/0CQmnIXLW6Y1X4J86lRt7g323LrggRki8BKoEY3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236881; c=relaxed/simple;
	bh=nxNZ1jszvpwyKEJO/gMw9sqK8SGTDAxwNv9VlpMrWA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+26/N54D5BfrI6/9TZqH/R+FpzmJpYCzzoTDEYI76s5XPqeiaccMB+qIPUO7U3KifHlAyGjTsaz8keYqR9IXm/z+KvFO8Fhb8T/f8F2dEkN+SHBGYgUR9TncEh0khqwlZb3DT3owuAdglMDv8BuDWAz7y/giVwQQdddmK55+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he+EI4wa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33ca74c62acso12556691fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758236878; x=1758841678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msjXtBYzUMS0IY0PtTudbUDMEzPS2Wtn39rOSMPfvZg=;
        b=he+EI4waL5LZRq6aHDFYvVnwosZ36PlX978iepDSdfFP4itE4ZUHzCf2jyVGUImUY8
         52ztcRtGyun9rOAy0O2XtkXY88Zwny5QEGujjmYI+5bzcCniiCtdyRN+5yn3pGVJ9mVv
         /QKELcJYYda/OiNsieYc6fjkrWLQR3dlwqm4t0azyvp3Jvoy88gN8bpS9AXQJo2YbCiK
         rrt6oZY6ybJAS2GCG7kbcEoj5+oq2wCZhVG+36Rg+S8RUu2Ln4AjCpxCdNui39CvxtOe
         VQ8KkHVzfLAGh18kUXG5Vfxc208F3FWihdNkIeQ5isXUjZ55PyL1qwNxrArtKWtp/OoJ
         Rl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758236878; x=1758841678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msjXtBYzUMS0IY0PtTudbUDMEzPS2Wtn39rOSMPfvZg=;
        b=t9yu9FXuxVbQVTr+esHJNyDZ65Q3TvZWO0neUxE0/qqiWQzfFI+Bht++dCYaJnkiPi
         Fri4vfv3MbNpsmHlJQFNGpHToFrRQCgejkeEVQDKXDB80ihPoqaxk5Xh8Vf9/I0psgRV
         3GTxUvKIniCjBvylpdMxYFJ3TqKMN79m3gPFvD+MD3gmjWimsvyu1I9Cv/cfv8gwmgg8
         sD2cSm6DamkwcsHICZXbdjDIu510ivkQiFBwymS/89EPwYfK2ya2QAwBkSpholMMNnXJ
         GkXjFAj2iEDpvBdJPkJzskBllAQ74n/9JP6aLk0wapjrpFvfmPWUxA2JkydC5aq4lBaF
         yZBg==
X-Gm-Message-State: AOJu0YzSUKfVf0i7GZfhyimak4YDL6dPvXINfBO4E63DIKdaNaBfSD+N
	tW+cd6BCzBa+oCgndwM5Mv1zRlBhukleewnmyCKp7u782kD/VBRROPga2/hncsTXHA+W2AB6aEf
	GWM4lGcHuGV6SQFEdQtL1bajUbW+k+zQQcXa8HoQ=
X-Gm-Gg: ASbGncu3SLezKjRznzWDiZsk00tC3q9zGMIvyGY58K7p+l/cJIcdYeLcsoE+iyQQU8m
	gqLrIkLPDbW5o+OEpxJXJ3Cy7g/t9i3EL4iwt3yvb/WCq2YxIXR4Dd47OqJ1y67j7mAm3Wigroj
	um+/1ZxsVDKRV6TJ6R0/nNwKo0mIa+6VNuJnGy2By611MtswmgAaJtwFXvDhaOPDlXdEiEwZN4x
	qv11LLKapBNnMWRT0EKCFJ4P7gA5qmFLVfYXXsGaGKs36YQyEFhV4vObuvvICGMEz1WQhLU
X-Google-Smtp-Source: AGHT+IGr0YWkNMzv8ekfAMfh1qAyzT6eWjOVB6UcIbfEr4lqXcwdyY6mvAlt09ARaLGmNoApOnMLxuvekk+GfEJyqyg=
X-Received: by 2002:a05:651c:23db:10b0:356:25da:89df with SMTP id
 38308e7fff4ca-3641afb9598mr3524091fa.20.1758236877391; Thu, 18 Sep 2025
 16:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-3-jstultz@google.com>
 <7bead244-f366-48dd-aae4-380d32de173b@amd.com>
In-Reply-To: <7bead244-f366-48dd-aae4-380d32de173b@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 18 Sep 2025 16:07:45 -0700
X-Gm-Features: AS18NWA8gMpFxyBTIgUlDeUL39iskoGeGewmsNTyZnR3aaTVboCfLkz8HrUKDyY
Message-ID: <CANDhNCo87Xq1-5vhVCyZ3780J+_tGVAjT4d=Z13WsfyQh3oaYw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
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

On Mon, Sep 15, 2025 at 2:05=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 9/4/2025 5:51 AM, John Stultz wrote:
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -815,6 +815,12 @@ struct kmap_ctrl {
> >  #endif
> >  };
> >
> > +enum blocked_on_state {
> > +     BO_RUNNABLE,
> > +     BO_BLOCKED,
> > +     BO_WAKING,
> > +};
> > +
> >  struct task_struct {
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >       /*
> > @@ -1234,6 +1240,7 @@ struct task_struct {
> >       struct rt_mutex_waiter          *pi_blocked_on;
> >  #endif
> >
> > +     enum blocked_on_state           blocked_on_state;
>
> Is there any use of the "blocked_on_state" outside of CONFIG_PROXY_EXEC?
> If not, should we start thinking about putting the proxy exec specific
> members behind CONFIG_PROXY_EXEC to avoid bloating the task_struct?

So yeah, your suggestion is a decent one, though it gets a little
messy in a few spots. I'm working on integrating this and propagating
it through the full series, and hopefully I can clean it up further.
There are a few spots where this and other proxy related values do get
checked, so wrapping those up so they can be ifdef'ed out will require
some extra logic.

Thanks for the review and suggestion!
-john


Return-Path: <linux-kernel+bounces-730921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769AB04C76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960934A3901
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6E277C9D;
	Mon, 14 Jul 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIHAEsEF"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AD1DED40
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536366; cv=none; b=qBUJkchcjYjiSkzcp9m9VidN1X7LQF7kJ3/pUXk43uDUOWMbG/UvJVVojIXSOK8frgkWmugflZpnaLV8UpxqEzohbR88Xlhndiq8UHTAcDKkEuCW8KsHW+45cej5/GOOumC1a2RQX8pFE1EhER9WopAYdg9KOFwYfLj1mEvy2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536366; c=relaxed/simple;
	bh=F6e3ahfTWXZVCPweSHf9iYB+IaN5NqDqlagsj58lcqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVs0QpwhcgDefFTwnDVOrnPJwxXq9Fjb4IqNnuH7fQ6Yfh+C78ezGzkt4RqOa8KOzrGlmYE/1mxz02nR2hBT6uKWv2bI79R3loOmATI8sYyvd4niXl1rt86uKXkikwT8WcEZZDLu2ibw93wnzpWumaNV/q/tAWnQpbg64ACGAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIHAEsEF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5551a770828so4876792e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752536362; x=1753141162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZrYFQX5m74tzX1S2Wsm+hw+h7DumvDepFQQOMivh90=;
        b=lIHAEsEFiQKba4HR2A1WjktzDVvqv4BQulwPxNQ5qx8vCAWTjXEf+pT+fvTqMVEBPu
         6g4tt3lxPthaJS+6jr6S7068wlTGuEZPlMNVb8jLiGNMZiuPE7Q9sq5Qdfwn6pyMc+Qz
         jFrQSrwTJgRV6+OJ4oGLyyPIvUTOyLWJSEve2HFq87fR3bKp7zrEVgl8hTlLb0EZz1sM
         g5cO76/ncQVLUQRivEz1hmPy4DLvhkQHAYBz4uvPi/6IcL/tIOREcGF7HRAbfEZYLX5E
         ZRMG0LcUGTmwTvhg3QBMxGjiaCr6dCa9FbH2ZtwfT7vsy/07oLQZVhxrl1NKWq0FfjNK
         HaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536362; x=1753141162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZrYFQX5m74tzX1S2Wsm+hw+h7DumvDepFQQOMivh90=;
        b=oqlM6ElNqb8M8zZScCEnrekmZgXd1ifoMoZZ+IAZO9+DlGw2fBs3VsQt5zSlLqA5Jb
         jX6/ERqprSo4WIWT2XqmEn6KGda3PD8+DYvvVjwp0HingwqRjeVB0lZrkgjhDbOX8FUF
         9cng8xJb2AfjisrvAIoETPT7XhlFJRzauIzgiYeOMOhmGDwfOCzEzN6wCG70IFUGzxap
         GcMyOfUsXH+lpbmO6oz9UPV7VPDihR+WtVkdJEoJ398ZDdsqDYOdMV3devm1Gp5fyGvs
         yrQ9W2LhQLkKjVzDy/TqJhNteFhZJlmDyrAUqVn0oiRO9UWSjYqj/pnZYqrhsTR8JzYe
         0UcA==
X-Gm-Message-State: AOJu0Yy5MpyYw22ijF/Y1YhhCXQ9TMX+U+tGG2IQYKxUKIlYNIuaS+CC
	iwvUjd8LqnisXSERuAhLG5Qa45Ug3fdbMsN9LM7rHucme+r82KxHnnWfHwpivSTPzEQs4m3z7yH
	zsroimNLj8sFNtM3aDk9Is2cICaLEmshJ8BfVNjs=
X-Gm-Gg: ASbGncsdyTgiBJOxvTxEytB0Gz/RWojR9K9wsQfgBXGC8UuofmbLNaqvzvqp8TTZm4x
	JAv9SoG3ofqxnr9V6UrY/jEkJKE6UD3muTVbkXavobMywxISbfFS5rV1RXRQEIRXB0oQa8a9IDq
	WMkcXlDWI+0U659IyP4azcVC9jEtchARowmkfweG+DLsBooHyeE9Z9ytb33/gg08qQwfndR9LAh
	QHABR7QCZbNLp86vNKmzrX8I5UYySW6ApDEkQ7ADwzE/oM=
X-Google-Smtp-Source: AGHT+IEeuf79w2ISqUUyqdadZfL6Bz4R/aaLw1MzFYM0DVOw8eOg9BzgMDRLQnW9fACH8d8jRmlIWMmVKAPly6MIneQ=
X-Received: by 2002:a05:6512:224a:b0:553:ceed:c859 with SMTP id
 2adb3069b0e04-55a1dd90b6bmr128998e87.21.1752536362218; Mon, 14 Jul 2025
 16:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712033407.2383110-1-jstultz@google.com> <20250714115217.GT905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250714115217.GT905792@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 14 Jul 2025 16:39:09 -0700
X-Gm-Features: Ac12FXxUerq1_WVDSEeY6pR7paOv_AGW8iMsmMdkBHKM_zKYWKBlOlfz6NXzhmI
Message-ID: <CANDhNCpKD7Ttygy9wGM429JYK86r70E6XGToPBVE2YrObKRHdg@mail.gmail.com>
Subject: Re: [PATCH v19 0/8] Single RunQueue Proxy Execution (v19)
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:52=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Jul 12, 2025 at 03:33:41AM +0000, John Stultz wrote:
> > Hey All,
> >
> > This is just a quick update to the v18 series, to address some
> > smaller nits Peter had as well as a few build issues uncovered
> > with !SMP and PREEMPT_RT that K Prateek Nayak highlighted.
> >
> > So here is v19 of the Proxy Execution series, a generalized form
> > of priority inheritance.
>
> I've queued this up in queue.git/sched/core; I had to stomp on it a littl=
e
> because recent other patches made conflicts. I think I did it right, but
> please double check! :-)

Awesome!  Looks ok so far(and seeing CONFIG_SMP removal from -tip is
exciting, as that will simplify logic and reduce build testing, as
issues there have often bitten me).

I'm running stress tests w/ your branch now and will leave it going
for a few days, just to be sure.

Thanks so much again for all the review and feedback! Really happy to
have this progress made, and I'll get the proxy-migration portion of
the full series ready to send out next.
-john


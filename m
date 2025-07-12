Return-Path: <linux-kernel+bounces-728516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B702FB02932
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995D41BC5718
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E211F09B6;
	Sat, 12 Jul 2025 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5R2ttkF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB41E8338
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752292734; cv=none; b=A1Zgye3iJxgHTUmyJqrrIYQdLmivJiZC37fDN22EmUto1GX01XXhDnftQWnFvYsE20K7HAx8FrD35t6OJ8msUJzgQj5fOqwk1vnkMTPaZ9fCRgXY4kcwQPXIJ7e7DmFhSar5+DaoXMD22TI4YvP5LQYaxJ4pMUHoox7FDfE2s2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752292734; c=relaxed/simple;
	bh=ktqPoh9vbiylyKtqbng9114CO3RkQhKV7giUxHpTzhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2uB/+70n8wDQmqF+zj+JXUx0rMq/Znzi+JhjzaBnUdudBhu9HvsEMe07g2K7vHhIME4A+omOt2Fiu6yajZFpF3lu1b+JT9N9l2TWl5EREL1dTYxOg2UNqpbLpw0ScKs//gSdOa321EqBDdsVbSxTkzqFhvuc6iunMyiWu6zWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5R2ttkF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so24898361fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752292731; x=1752897531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktqPoh9vbiylyKtqbng9114CO3RkQhKV7giUxHpTzhc=;
        b=G5R2ttkFMEuzMqYWRInfeUbh0DPKxcaLm/C13yKWub4zGNLj5CxZN7966lFZLlLnxp
         qmN6uC7NsYqnFC6YdRkez0pV7qEnnzg2z+4CKq8401l5qaWoOlMtd/IKrqsHz1h9531N
         7MFoKh5FVY9ELVAJjX4HH3OHaXVRVo7dL7nFLnOqMwbAlQrgM27jhH1Q0N3b2XQrFQk4
         suHwpuA1STTGC0G3KkMH8rjoP0FaNy89M3Ch2Tz0hnWhgRgBtN8qTxczqs9/9jDe6ck9
         En/1cDsg4F/Yqj8C9odWScrLx75zgQ4BIso3Fk/oaK6ZLWmS9riHWBVx/8nTrhrFnusO
         f2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752292731; x=1752897531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktqPoh9vbiylyKtqbng9114CO3RkQhKV7giUxHpTzhc=;
        b=XLlejGhoZjREWcTNUw1wxcIxn47t8runj3lVcFK3vbp0ElqgBppRnumm30pB8MZ1+K
         tvnVbByTq1wBzrZWxJa1Sja0SkJ2IEBYWe+mVWLyMsm1jP3U0Oj0BIjM2xwoFMGGdIgi
         o6p4U1VDRLyOAT9lAudbHyaz5CtfU4kUK093VPblUdwCsW447BiC5VeBJCvgME8j53Rj
         xrmYoXU6V1weSWzm6ZnTYRO3TbJuUvzVVTTS56wZom8ON226pwZHip8aWnMJBQEiQg/x
         CbGl7Mw+9NYr88eDuw5O3NM+fUrFAjPKKPEBp4/vRYkFg1mg49qLIMH9ic4kAJoGGih3
         h04w==
X-Gm-Message-State: AOJu0YxOoNjA8Wirrw0UfFA7XUabHSdAx7qF/3nSoCcmROXyk2vdJmeK
	oynqNj7Qv11l4aSygG1rqF+5IqrfHulM2DmfwLY3KxTBOd37CbSDDAnE2iisF9MnEK893ede8Jm
	UyF0rd+dEtwF2DtsL+kEQcVCOljeLMX3bmYKx6RU=
X-Gm-Gg: ASbGnctPX5/DPhDp1CTK69u+d6TPXJTRZWb9UhvfYsqhEBLWxx9wpAZCsfcq91h6BsX
	QKpcn6lWezk6ltGxWmHoEkYlrF4hdaaAmjRU0FTlsOOqhCSDv0kKEx+A0RynXV9QLK1hFxBdw6f
	zIJX6jWT2HToyIw0bsihkBM1FAnrG218BoucZCvfLystQe3d+nneb56YMM0VNtUzxcwx87BpGzl
	Np5+UX11A/6phPOwOsLVXgJsRSbeYq+5iYH
X-Google-Smtp-Source: AGHT+IHlC/QRznIB4bHVAXsr4H4qwGFX7qdOXx041Tlx8icBtyDfcTwDPiDDqp7+lB0HZ9Dp2ew/xZrE9fB1uA47pCs=
X-Received: by 2002:a2e:9219:0:b0:32a:7e4c:e915 with SMTP id
 38308e7fff4ca-3305344f522mr17906851fa.29.1752292730615; Fri, 11 Jul 2025
 20:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com> <20250707204409.1028494-7-jstultz@google.com>
 <20250710100206.GI1613376@noisy.programming.kicks-ass.net> <CANDhNCoMvY0s0AyePNouWqxdRpXCYJE=28E_b8RdmJ_2px_OBA@mail.gmail.com>
In-Reply-To: <CANDhNCoMvY0s0AyePNouWqxdRpXCYJE=28E_b8RdmJ_2px_OBA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Jul 2025 20:58:38 -0700
X-Gm-Features: Ac12FXxR8WAx0jNLrQZu4NtB2UHBRxYxxQ6o9FokCoU6-hsFZ4TYbRub1uwNQWM
Message-ID: <CANDhNCpxU=eLSwv2ViDm7-cGjXryRDXizWm=7rDYWE28c+BjjA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v18 6/8] sched: Add an initial sketch of the
 find_proxy_task() function
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
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

On Thu, Jul 10, 2025 at 5:43=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> On Thu, Jul 10, 2025 at 3:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> > So far what it seems to do is when true, don't block. It still does the
> > signal thing -- but I can't tell if that is actually required or not.
...
> That said, I appreciate you raising the question, as looking at and
> thinking about it some more, I do see that we should be clearing the
> blocked_on state when we do set ourselves as runnable in that case,
> otherwise if we are blocked_on we might get stuck waiting for a wakeup
> (likely from the lock release).
>
> I'll fix that up here.

So just FYI, I actually talked myself out of that position last night
before finishing up and sending out v19. If we are blocked_on, we're
not going to get back to userland to handle the signal, we're just
going to wake up, spin through the mutex lock code and head back into
__schedule(), so clearing the blocked_on state isn't the right answer
there. Leaving the blocked_on task on the runqueue (even if we set it
TASK_RUNNABLE) until the blocked_on state is cleared should be fine.

I did some stress testing, and never actually saw a case where we had
signals pending and were blocked on, so it seems like a rare corner
case, and I feel leaving the existing longer-tested behavior is right.

thanks
-john


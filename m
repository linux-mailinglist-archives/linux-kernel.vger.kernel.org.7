Return-Path: <linux-kernel+bounces-857021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3EBE5AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7823620184
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C12DE1FA;
	Thu, 16 Oct 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFU2Czy+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECB2DCC08
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653396; cv=none; b=W7wu8BU0Tx80gY2b60mKSr4k3/Ha7aJJeXsYArayl00S66jDL39B0aVk8mufASkB2DzOLDaIv2CX1nMxl9HfUvvefygcCiFGJbkT02MZJ+glPF60iGxIFaXQhF0g/xOsqYIvgWU2zWurlOQ9vzvvCAjC+c+IFyv6p3vHA22lC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653396; c=relaxed/simple;
	bh=3Of9KQDNlxnFxcbbIcQndxNfMGpGHDt7p33lwAbo/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyZ1m62q3zJD/TYNHUudF91WahyUj2BinsT8+v3XpX19TCslDwAGOOZOi9F0+z3fFmtD3XwnV8OX/63AXHCQwIU2epMmQNL+GYGPYi/zLF5BwZE3KxLnoWEdGxT+Fhji8KkIsI7mYewjkAHF1p8YIx+0RmNsD7uvDo6F0AOh86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFU2Czy+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so2780237a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653393; x=1761258193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbP4t9WZG2Kuz1VfYZ6CoRLFNg6XhQf//zeVogyIhOo=;
        b=BFU2Czy+P/qJ7jI9CpO+YONVrUDpjA3chmJqtvFbOSlMUnZCUlCJOCE3ETRAaUEVC7
         GB6tKSLiw2fCLmX93rnGCzQZ52hBQnAB+7INIOXB/rJZ8Dr3Zvbp5mJeTE8s2VxG918f
         HEvjZpQJftFE28ckA/DSydNCueeeBkqRk/NJkhwB1XJtaPW/bRI62OnkumcI2Co9OzO5
         gIAyoWmMcrtdRu/TN4aRWyeDEO/SgZyN2ewcYCkSl4kN4Q/y8jqvCchE0tAwkxa9sXYY
         7lomN5OS9lYHFNpHWTj6F0XNQg9YAJaXrEykudx6GqD+B3PIAosTYGIXGdW3WyhfBdKF
         Q7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653393; x=1761258193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbP4t9WZG2Kuz1VfYZ6CoRLFNg6XhQf//zeVogyIhOo=;
        b=jTc005jS1fxvt0pdfpmpXTkKfj6C+LIoAPX9+o1veEGOVYI6IP1wpWuIFrX+5kPAsY
         gvMxBxK43ZCmySlhAQi5IALx9rHd46ix6R0A+H/prB57avtZNUm58oyhWjBiZJCR9k/0
         o0zOnConCKqfuBYvIk74WSF41UCMRWMxeVVMxrh7HAiqmeFtmOBA0cNr34JqBz701TVc
         i37qYS+AMH6sbXSe8NNwGzP/cTmAAp1ZsFxlbauD6L2GsNhI+WxBw8O+z3klDnGlnI+n
         RUeJvTb9hkUZWLgAAT4aLhfIUB5wIu2Y5Lh+SNTjRCQl7RLPtunPW8Vc5zfkfG4DTy54
         msHA==
X-Gm-Message-State: AOJu0YwaLTaeNWACkRcthVpNS5QZFDD+LzYB1OXAyZc1uyt7hhEttY+X
	MWvPi19ICgeqHea/NiQy2I2RlOQjR0pU8E5dJ1m/cUAmPHZ8RTAwB+Sc1tuLmEG/Om7EUQMM6fT
	5ED0e3OooYaxjlKjblvTS67hFYiJHeH2v+H3kXO8=
X-Gm-Gg: ASbGncvI128SrIvISGn6xhuvJX+1d7+Ck3Jns+KB8Eb6NOCKKl0vIujwcR+6GKP8rVX
	uKAlnS80rHMcY7fcyY3tgK5G3nvnjL3Mf9YpztJsshPVJACEZIFj7M1eO3tNRUZwsAumpRk/hR2
	UtpJQF/RrjpLgVetr6r7Px/j9NrnjpAtcvqSE2xtZzTV3D5HZVvds4LezPmCcc75ksPtFmZkke9
	7UcB+xg4UTJRZMlVAJnpuiBNu3MjxFkJT6sUy0SLT0I/7tx8V1G8P+KSv4T8AVWtI93R5MPWYCz
	sfhf/WRb5zyqjNA=
X-Google-Smtp-Source: AGHT+IH1jyo8WiF+9onbqM3PWMbE33kht1xDlMoA6Nu+PSLmgon+9FHRgcFTIpcxihRF4rrkP/IWF/84kPNGE2TnQpE=
X-Received: by 2002:a17:907:7f17:b0:b3c:31c2:b57d with SMTP id
 a640c23a62f3a-b64742428b8mr191747666b.55.1760653392822; Thu, 16 Oct 2025
 15:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com> <20250926032931.27663-3-jstultz@google.com>
 <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
 <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com>
 <20251009114302.GI3245006@noisy.programming.kicks-ass.net> <CANDhNCp6TPcfzJLCU-o-xScfoeCqMzYjVhGyDa23YjAqiMnA0w@mail.gmail.com>
In-Reply-To: <CANDhNCp6TPcfzJLCU-o-xScfoeCqMzYjVhGyDa23YjAqiMnA0w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 16 Oct 2025 15:23:00 -0700
X-Gm-Features: AS18NWDJqXK2tpwEaqAd80ufKAkn9onPuMvbTv-G5jIj6eY-duD9kyAOhv1XIqg
Message-ID: <CANDhNCppAhmF5MX9wP06tPD=H4cpKqppHEPuMgxH+Z=cT9YB5Q@mail.gmail.com>
Subject: Re: [PATCH v22 2/6] sched/locking: Add blocked_on_state to provide
 necessary tri-state for proxy return-migration
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

On Mon, Oct 13, 2025 at 7:43=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> On Thu, Oct 9, 2025 at 4:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >  - I'm confliced on having TTWU fix up PROXY_STOP; strictly not require=
d
> >    I think, but might improve performance -- if so, include numbers in
> >    patch that adds it -- which should be a separate patch from the one
> >    that adds PROXY_STOP.
>
> Ok, I'll work to split that logic out. The nice thing in ttwu is we
> already end up taking the rq lock in ttwu_runnable() when we do the
> dequeue so yeah I expect it would help performance.

So, I thought this wouldn't be hard, but it ends up there's some
subtlety to trying to separate the ttwu changes.

First, I am using PROXY_WAKING instead of PROXY_STOP since it seemed
more clear and aligned to my previous mental model with BO_WAKING.

One of the issues is when we go through the:
  mutex_unlock_slowpath()/ww_mutex_die()/ww_mutex_wound()
  ->  tsk->blocked_on =3D PROXY_WAKING
      wake_q_add(tsk)
      ...
      wake_up_q()
      ->  wake_up_process()

The wake_up_process() call through try_to_wake_up() will hit the
ttwu_runnable() case and set the task state RUNNING.

Then on the cpu where that task is enqueued:
  __schedule()
  -> find_proxy_task()
     -> if (p->blocked_on =3D=3D PROXY_WAKING)
           proxy_force_return(rq, p);

In v22, proxy_force_return() logic would block_task(p),
clear_task_blocked_on(p) and then call wake_up_process(p).
https://github.com/johnstultz-work/linux-dev/blob/proxy-exec-v22-6.17-rc6/k=
ernel/sched/core.c#L7117

However, since the task state has already been set to TASK_RUNNING,
the second wakeup ends up short-circuiting at ttwu_state_match(), and
the now blocked task would end up left dequeued forever.

So, I've reworked the proxy_force_return() to be sort of an open coded
try_to_wakeup() to call select_task_rq() to pick the return cpu and
then basically deactivate/activate the task to migrate it over.  It
was nice to reuse block_task() and wake_up_process() previously, but
that wake/block/wake behavior tripping into the dequeued forever issue
worries me that it could be tripped in rare cases previously with my
series (despite having check after ttwu_state_mach() for this case).
So either I'll keep this approach or maybe we should add some extra
checking in ttwu_state_mach() for on_rq before bailing?  Let me know
if you have thoughts there.

Hopefully will have the patches cleaned up and out again soon.

thanks
-john


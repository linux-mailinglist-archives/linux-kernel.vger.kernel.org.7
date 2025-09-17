Return-Path: <linux-kernel+bounces-821562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5134B81A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A9A2A1527
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5727A91D;
	Wed, 17 Sep 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRirbJPy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F9284889
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137410; cv=none; b=H5K/XRxsObfKaIIlkvGet7jbEAWR7zaT2g5h0alqjkLcNjAVDAV0PoFLOc49qjlMqmK9uR17s2RkJ19ser9+Ske1XtVkIR7IZTkoM2ykYfRPsIGCkzMm020ChlqUxsmLcZhNiA3Jk+sN8IHHZ02CA0pGSs7Kv/RNYKPigVRkH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137410; c=relaxed/simple;
	bh=iLiNYq2F60Atjt8BEsSEpOLVxQyiWPgRzb2QOL6FfG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgEp0rnq6IdUu9m5G1GwwkDVya0OmsdJUrm6Fl0hYK7k96GMEhODGhZQs7uX8lzqZFqUFjQRtPRjgYakK15JNOsMTKHjaSqHSCU1f8xs9z5af5a2e5/FrAd09j9sl0KotUTKfFuYA/RErh0xrl6jKmVwblVrLuRxVezik1qsd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRirbJPy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f76454f69so223261e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758137407; x=1758742207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhhRg+kpMoTFNG/lVUFfqWfMhWxfsZiTxkMJwwJZ3Sg=;
        b=fRirbJPyBdy0njlLesLINDesqVfO1QX2T4rz+F6JmgIXEvWqelMzpn6RbCej1SbM09
         T0hrwfR2Xw68FSzXnhBnwMz12fYtzeylu7/OrlAXcRpn/IVZqIPV9MPNM7o2d2a3FIoe
         I3i9cIgqVgim36zk/p9K04Wi0k4+g560WzuIS9qlMY4NFkXU5JqU4YGdY9s5P1z81jXw
         AjD/Sok7UCXPpZEc4/To0B3xOXC4q0x9ioOu23EU5sTCWnp8g4iN+oEEEs8ima2UQH2h
         rRGTZuzXqORC0xJ6pyRZqmyy3ELQQnSAqd4b4o9Nhb/I/ZRs+ikufDAKOTSMU+Zh9qCM
         BdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137407; x=1758742207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhhRg+kpMoTFNG/lVUFfqWfMhWxfsZiTxkMJwwJZ3Sg=;
        b=F+DcX74MBITVXh7Dy5jJ1Bgt8pTxzAxklnv5BOArS3vyevF51HdVlnzcaqp528GLwV
         y6pBDb832/xUufK0JC6Cf6//++fIgeHcdiIQz9iVGhhVePGGose8RjhpD0oe3kswRrnI
         MwXEsRhgXUyAUT+gZvQXhJ/fD8tY6URoCs2BCYVGvq7pbFDaDZNyEbBHT1QfzbPtUFk+
         XmLYyI8howUwXKE5OtNjbMChBfptiADgy1fhACKDD6T4iwusv7/1K2HTGWTSDRrWTMcC
         cntefhyTIfoC9aSdd51rTRzC69a0E4WBiTWzt7QKsy3VxBgSexos9d7Ya35FrvqzfTZx
         kyZg==
X-Forwarded-Encrypted: i=1; AJvYcCVHIP544MWmLAL/Enqezun43whvm8SQ0YqzxJmARKyKupNdfI68d7CHVaK698hOUjo0qgPIDVdWTXbrdfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN5J0AX7lPya7fCAR/ywo7vrkp9HkI1+XEPMY55Ee8Oh6irBu
	dWT+ajEur1uH2lHB35mfNbKiF8wgdvvepG5f/Y0voJkTmyG4bMXjBi+1K7WDDMO9VdL68L4vdst
	qAYFT2gT614a71bk45YYC2/wGc9CKVacNaedNKb8=
X-Gm-Gg: ASbGncvbAloVYuoym7XalcdUEBWmFCxupmn23+DiT0/Ym5WNRTVrd8aXKj50UHBi1jr
	dxvh8tuHaHOPWA7p2FaGqmzSqmpsHynzA8gaQM7kA/8HMvyqWktyMXSwz/o/d7hku+4Rrz8LjP2
	Hfr3NIINjXurBjk6IWWB8Ha92tq+7M+ydLaJF0ZlzAPnjXw5IkTPjce7DfY3tk+TzToKBKujpX7
	QEB7fFJEBVg5KOScb+f8o56ND9bimpU7i1krn7LiVHXnDK1wgRvleelyO+tEg==
X-Google-Smtp-Source: AGHT+IEQqKaJMv2fy4QGAuI9SlIJ8ba9uyczcINA4VrjUHdkrqn+DY4Fawn4zBF6PVAeNLu8aJK2m5UZYD5ysWkvrjw=
X-Received: by 2002:a05:6512:3b27:b0:569:28e5:d42 with SMTP id
 2adb3069b0e04-57799115172mr907562e87.29.1758137406478; Wed, 17 Sep 2025
 12:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com> <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net> <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
In-Reply-To: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Wed, 17 Sep 2025 12:29:53 -0700
X-Gm-Features: AS18NWCh1W2MqeaOlyFwXmVzwwhfTkWdyYs3PWt4u6DeR1IxXs3cRtewuEJCdpY
Message-ID: <CANDhNCoV=8h56KKgWOVBZUup0p4p_n3nNUL6gp0pRuG48kLdfA@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suleiman Souhlal <suleiman@google.com>, Qais Yousef <qyousef@layalina.io>, 
	Joel Fernandes <joelagnelf@nvidia.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Wed, Sep 17, 2025 at 11:34:42AM +0200, Peter Zijlstra wrote:
>
> > Yes. This makes sense.
> >
> > The old code would disable the dl_server when fair tasks drops to 0
> > so even though we had that yield in __pick_task_dl(), we'd never hit it=
.
> > So the moment another fair task shows up (0->1) we re-enqueue the
> > dl_server (using update_dl_entity() / CBS wakeup rules) and continue
> > consuming bandwidth.
> >
> > However, since we're now not stopping the thing, we hit that yield,
> > getting this pretty terrible behaviour where we will only run fair task=
s
> > until there are none and then yield our entire period, forcing another
> > task to wait until the next cycle.
> >
> > Let me go have a play, surely we can do better.
>
> Can you please try:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/ur=
gent
>
> That's yesterdays patch and the below. Its compile tested only, but
> with a bit of luck it'll actually work ;-)

Yep. It works! See the same initial 1sec delay for dl_server to kick
in and boost kthreadd (that we always had), but then we see it bounce
between the RT Referee task and non-RT kthreadd to spawn off the other
threads right away.  Even on the large cpu systems, the dl_server
manages to alternate with the ref task and kicks off all 320 threads
over just two periods so there's only a 2-3sec delay, rather than the
5min+ we had without this change.

So for my issue:
Tested-by: John Stultz <jstultz@google.com>

I'll do some more testing with other things just to make sure nothing
else comes up.

Thanks so much for the quick fix!
-john


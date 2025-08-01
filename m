Return-Path: <linux-kernel+bounces-753127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9DB17EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0811EA821D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA70222566;
	Fri,  1 Aug 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/AOoO9g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E12253EC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039661; cv=none; b=Jqa5GHmFxplajU63XmQzwOIwwLWVMbt2AMl3PxVUjjb0EP0vmeae7wRcplIu6yZtMizwLtgIw5yOkoOwIGbxfq37khAW3jVRR50wbENvb3JMxY2DRTLgMkrQnKRCc8VyyC5jv+qVYL6gnzbhTzurzrHbTjz36XNpjWUqtJuoOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039661; c=relaxed/simple;
	bh=j8vEQ5NmD0UkzeTXlvieluXplT3t0ESYk9S6mP/+f/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaDe67tsDNt+LLM2AHV3EnMG0m3bT7N6/03GZg8yoqZJcBj7fGmCaDDBZi3vZchOFIhSA78kbCtxVqW22jhgxhZrcUBJIVMTpc9Wbwi9ib2P41AMDxh97+534Cwz/grG1f/cY6qCHaBxSWc7PUlhxq+U8RMmuIHIDirNqwDU25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/AOoO9g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754039659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/j0+WkfZMw1AoCAOC5CaMkbSzrbduahLpS9n566Aa3Q=;
	b=a/AOoO9g/1nkrjHe5l6gxvEm+4c5OZKxZ1nI8wvZ5ABn1pLbJbw+/ta3a9bgadIj8TO5vm
	1GfOyTNB6YIgAT3Mpbl/QOizqlno2gEdI/2ZDVTIbU3uV8AkS1lt25d6T0f7m8BkG7NBc4
	fWDAGGMcKHHwO2OSqr4ZwzboYrJ5kZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-GQUM25aYM9qoXjtGSiKusw-1; Fri, 01 Aug 2025 05:14:18 -0400
X-MC-Unique: GQUM25aYM9qoXjtGSiKusw-1
X-Mimecast-MFC-AGG-ID: GQUM25aYM9qoXjtGSiKusw_1754039657
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso4623515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039657; x=1754644457;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j0+WkfZMw1AoCAOC5CaMkbSzrbduahLpS9n566Aa3Q=;
        b=O1d2HTb86fzhZA4ZJl+E3HEPN6ia3nINMxESnQ5WcB+ez5tPD/lh7CBtAXVAPHiY+c
         QA1Dj0yAlSFQ/zwjpAqnkbSAT9Ze1effkCuX1bCW7ncnSShtbrItnOB3HvFgs7ZTVQ0P
         t6Ogs2y6N9qtq088VTExr4lxhIIBGe2xWSikYI+gpD4rvt5lj7hGIqZTxj+TJ2OwztGl
         enHSimZrDUFxnSPNDKSJmbZ04kVZxF/eyseFGoD2mMpPy5crtrbMEwJT5cMTom4b8mPZ
         51NEGOZOAxmKGLDBAgscgpQktbWVbCKZL8fkYU6gYspbIMcIslo32jlpxpbC9jrM8KGf
         WP1g==
X-Forwarded-Encrypted: i=1; AJvYcCV9n6P+Oacs6MUKaaElve8qHEvAJIZ/OjZ++askM9c8cOxzoXMEnMlYkJ2pA9M0j7CpNMkuORj9yL/b8aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHA4jukBboxzqDjzZIiFxJOaw6mMffnJp/KZbPTwf0Z+ZqZB/
	MWpe39its0JE/KCToVh08b7Uk0hRh+Sdsr27c1vRuil39qccllyZYIagcSOHHCTLnUay2RfSy/k
	X7UhXvKnRo9iCvxsI/Y/IOe7genc6RQfGdB3md0f8BLz38ArrlCNoZwerKEzVsHJFsg==
X-Gm-Gg: ASbGncu21R2nrrXue/0Y3Vw8T9weHFVqjkUrCwc6+6xu17+9oGocIR7gbDDmrxmrGfC
	49PDJzljRCQzKM9yqxjWXS+X2ddBdyEv6uwcJ38cl+GwrWu8mUkBQxhjKDcECug56wmJRsg36FO
	KtnuhvVeqj6l9FPBqgVqtvbkRiV4KrIg8iC+neCLjfneBicD3uGU62f/bwUpLODLAx0U9Njzt3x
	zg5lBsXhhl2pIIsy0CThN5g6hfZQizKerkmVjGZwIBHWNledbP5l01M74n9eBUgk0q1kqW9WK0W
	/M2wVUndwV4aZ5LTxxhu7NaMeHceQXv8xVT5gfwCg0PTAkJ3czvEM3htgqv2QmGkXA==
X-Received: by 2002:a05:600c:4ed3:b0:456:26c6:77f3 with SMTP id 5b1f17b1804b1-458aa31fcd7mr18902105e9.12.1754039656602;
        Fri, 01 Aug 2025 02:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9dHrdikJE8iU+AXDoaMgWrxyi9BhIyaYCF/grmEP0FdzFY/s5Yr9YWGryGg8P9I6xdtla/w==
X-Received: by 2002:a05:600c:4ed3:b0:456:26c6:77f3 with SMTP id 5b1f17b1804b1-458aa31fcd7mr18901775e9.12.1754039656143;
        Fri, 01 Aug 2025 02:14:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcc1sm101356375e9.17.2025.08.01.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:14:15 -0700 (PDT)
Message-ID: <c1635857f735aa91679c153f785e09beed9b5b2f.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,  Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>
Date: Fri, 01 Aug 2025 11:14:12 +0200
In-Reply-To: <20250801075810._Ng7G1QT@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
	 <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
	 <20250801075810._Ng7G1QT@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 09:58 +0200, Nam Cao wrote:
> On Thu, Jul 31, 2025 at 09:47:10AM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> > > Add "real-time scheduling" monitor, which validates that SCHED_RR
> > > and SCHED_FIFO tasks are scheduled before tasks with normal and
> > > extensible scheduling policies
> >=20
> > Looks a very interesting monitor!
> > A few questions:
> >=20
> > I assume this works with rt-throttle because it implies a dequeue,
> > right?
> > And you probably won't see that without explicit tracepoints..
>=20
> It does work properly with rt-throttling:
> 	root@yellow:~# ./rt-loop
> 	[=C2=A0=C2=A0 74.357730] sched: RT throttling activated
> 	[=C2=A0=C2=A0 74.357745] rv: rts: 0: violation detected
>=20
> Looking at rt-throlling code, it does not dequeue tasks, only does
> 	rt_rq->rt_throttled =3D 1;
> 	rt_rq->rt_queued =3D 0;
>=20
> so we are fine.

Wait, by /works properly/ you mean it reports a violation. I just
noticed you mention it in the description.

It's reasonable to request RT throttling disabled on sanely configured
RT systems. But throttling is a /valid/ kernel feature, I get you mark
it as /unwanted/ though.

I guess if that's the case, this monitor doesn't belong in the sched
collection because it's meant to validate the kernel behaviour, not its
configuration for a specific purpose (RT).
Isn't it better off with the rtapp ones (which validate the system
configuration to run in an RT scenario).

Does it make sense to you?

> >=20
> > As far as I understand here the monitor would just miss RT tasks
> > already running but would perfectly enforce the ones starting after
> > initialisation, right?
>=20
> Not exactly. What could happen is that:
>=20
> =C2=A0- RT task A already running
>=20
> =C2=A0- monitor enabled. The monitor isn't aware of task A, therefore it
> allows
> =C2=A0=C2=A0 sched_switch to switch to non-RT task.
>=20
> =C2=A0- RT task B is queued. The monitor now knows at least one RT task i=
s
> =C2=A0=C2=A0 enqueued, so it disallows sched_switch to switch to non-RT.
>=20
> =C2=A0- RT task A is dequeued. However, the monitor does not differentiat=
e
> task
> =C2=A0=C2=A0 A and task B, therefore I thinks the only enqueued RT task i=
s now
> gone.
>=20
> =C2=A0- So now we have task B started after the monitor, but the monitor
> does not check it.
>=20
> The monitor will become accurate once the CPU has no enqueued RT
> task, which should happen quite quickly on a sane setup where RT
> tasks do not monopoly the CPU.
>=20
> The monitor could be changed to be accurate from the get-go, by
> looking at how many enqueued RT tasks are present. I *think* rt_rq-
> >rt_nr_running works. But I think the current implementation is
> fine, so not worth thinking too much about it.

Yeah if it's something quickly reached it shouldn't be a problem, also
rt throttle would run in case there's an RT monopoly and you'd see a
violation already.

> >=20
> > Not sure you can do much about it though. (without falling into the
> > need resched rabbithole I was trying to untangle)
>=20
> I would need to look into scheduler code, maybe we could check that
> the next scheduler tick implies a sched_switch. Another day.

Agree, the monitor looks good for now.
I still want to give it a run when I have a bit more time, besides with
RT throttle, can the monitor really fail on a working system?

Thanks,
Gabriele



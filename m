Return-Path: <linux-kernel+bounces-751807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04CB16DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AEC1896904
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F129DB99;
	Thu, 31 Jul 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUTaOyK/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646462957AD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951174; cv=none; b=Gyy75/FNjavqiAbdkGGVfQBqw+oPb0TXQPE1u7KmIxg6L02oBymm+26nww8URxnVxjfIi6/0ujsobjZ8TAxdCSGKw7Zw5GQkozY2zLDi3DAhStbW5+fAMnx/UKGnHYeplTjm9nw5BHaB/eOtGTWW1k0XuqcPkO+jLMhGFAiMSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951174; c=relaxed/simple;
	bh=hxPsiLd1gVzDHcLACswmRB/4fo7ZC0IBGMWiKvUf56M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihEUpbfHm0ptFnE9sQ/6eNWSrYESm3PO0oxtV1ol3RD1aKbX2E/wrmr+TUKYJtANy1dCluywd25eJwIJWOO9A3N/nQKjK+YYiz4vmDaoS7JhtM/2+oHGU58GtDAx7Y10fYuk3NNh7oh6al6n4SuUv4gYGNOlHrGwk8ZVP2Ssni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUTaOyK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753951171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F7yP0szGzNbiy8cyqFmK1DSuaFl+Rz6XKugDUijkRpE=;
	b=fUTaOyK/ziW4zEYYdyT+GwIPZWGQJzYI+XI+8ZmgqWwibQGHUXved5UUrJ5snKYDFYQk87
	QbokhhFslyiQVr3zwNsuew9R+se1wiAaARMkjArbyCnkz/5zE16w2UdshLbxn33KJn1l8y
	am2p6zD/qJdQEwITw+NMueFFVI7ye0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-c0bjpffGM0649YvEBEGA0g-1; Thu, 31 Jul 2025 04:39:29 -0400
X-MC-Unique: c0bjpffGM0649YvEBEGA0g-1
X-Mimecast-MFC-AGG-ID: c0bjpffGM0649YvEBEGA0g_1753951168
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7961b3c82so325155f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951168; x=1754555968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7yP0szGzNbiy8cyqFmK1DSuaFl+Rz6XKugDUijkRpE=;
        b=IizrHRCPQVGc/cl9ffaBuPZg0/YeoO1/8zAui17wfEDtqkCncDkoJ028Dkv/7Ncbe/
         kKDG454JxsfQgkFt/yrWCfT2gMDXPS+AMteGoGTgXBmjY4oOAE+riHa8EMujjINu2cm7
         DI8cz6flgQWAdw6s15tHbbbGcOWX+ht7dPfsnpF7qaP0uD8DTbPcZKuiIpFdsVLun9pO
         q/x/9OmTgDypUSAQ3FhtfIJiK3VjDCmiMaYDAKd5ZKXKJCLTyMAVyhuNZcrZbVMc64s7
         2gbvhCSMEcATrakTNpu5Y9fvGHVMsyOK0cP0eqMgaeTIs/0eqBs58LeFfZ6mNOV+KEzW
         z/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVNXHFlmjr01Tt8oWGSc5CNKw7SXEK+euaC80svESIjJQnKPhhe47nic+M8y7T5Sx3b9lAcIyCxbBuFOf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJdLGd+9xo+9og0Hehiy5ojTlythxrr6nlnzyfoqnQ7O5wrSN
	R0rsfwtRgeqTbw3wm1uRrlp3GJdEu/quuiDdl4n9+LcZGJ2fW7pq+YGqFSQ/gPLXVS7flyYFo35
	8YdC85pv+/LTrb/l+j+oWOpeJZdZpi752fshgmYBkO47R6TsOKFdUak8DguSq+Pq7lg==
X-Gm-Gg: ASbGncs7WTd4j031BeCXpY6eRuIS3WQ3lvH0UqPDTU19Fq1H3qpFwJZ3LUUkZNwFejx
	Fhre8HiRasolfIJIBOMD0cKErurxtlKKlVEgAXOE+/LK3W5lgrOMg4mxJAAPMicp+h/jyVLkKe4
	oxqu5RTuokZvAGskNgPfuBoIWIzQs6em59zSiYUcH5zNAf1yPJ40TAUek18lMjMycuQVC2khedf
	MMLHoM8utrB/lv3pko4qkqVWleZqeg5ZZkccBwtPqrLc6DBHM+Hs5Nr5PeMMGLwpvIJ1BSd7KZY
	sJVlXwjqS+IzdvfRYOR3oAE13W8BIGNl1Vfv4bY09y+zckgr7UT2sPHjPoShD/dKiw==
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr3553014f8f.33.1753951168417;
        Thu, 31 Jul 2025 01:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlb7Q8yPGsqPrhTD0Y5orBknXFGcVgXJ65AHafvMuaqJXp4tRD1gmzSipBYjnC3cMeTlLrew==
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr3552988f8f.33.1753951167972;
        Thu, 31 Jul 2025 01:39:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9c7dsm1589327f8f.26.2025.07.31.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:39:27 -0700 (PDT)
Message-ID: <5a7c492bbad7d56f347ee629734fdbab275d6333.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
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
Date: Thu, 31 Jul 2025 10:39:25 +0200
In-Reply-To: <20250731073520.ktIOaGts@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
	 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
	 <20250730151818.7RemAREO@linutronix.de>
	 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
	 <20250731073520.ktIOaGts@linutronix.de>
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

On Thu, 2025-07-31 at 09:35 +0200, Nam Cao wrote:
> On Wed, Jul 30, 2025 at 06:18:45PM +0200, Gabriele Monaco wrote:
> > Well, thinking about it again, these tracepoints might simplify
> > things
> > considerably when tasks change policy..
> >=20
> > Syscalls may fail, for that you could register to sys_exit and
> > check
> > the return value, but at that point the policy changed already, so
> > you
> > cannot tell if it's a relevant event or not (e.g. same policy).
> > Also sched_setscheduler_nocheck would be out of the picture here,
> > not
> > sure how recurrent that is though (and might not matter if you only
> > focus on userspace tasks).
> >=20
> > If you go down the route of adding tracepoints, why not have other
> > classes benefit too? I believe calling them from the enqueue_task /
> > dequeue_task in sched/core.c would allow you to easily filter out
> > by
> > policy anyway (haven't tested).
>=20
> Something like the untested patch below?
>=20
> Will you have a use case for it too? Then I will try to accommodate
> your use case, otherwise I will do just enough for my case.

Well, I'm still defining the best set of tracepoints I need, if you see
it cleaner go ahead the way you're currently doing, then.
Unless anyone else complains let's keep it like this.

Thanks,
Gabriele

>=20
> Nam
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index c38f12f7f903..b50668052f99 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -906,6 +906,14 @@ DECLARE_TRACE(dequeue_task_rt,
> =C2=A0	TP_PROTO(int cpu, struct task_struct *task),
> =C2=A0	TP_ARGS(cpu, task));
> =C2=A0
> +DECLARE_TRACE(enqueue_task,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
> +DECLARE_TRACE(dequeue_task,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
> =C2=A0#endif /* _TRACE_SCHED_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b485e0639616..2af90532982a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +	trace_enqueue_task_tp(rq->cpu, p);
> +
> =C2=A0	if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0		update_rq_clock(rq);
> =C2=A0
> @@ -2103,6 +2105,8 @@ void enqueue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0 */
> =C2=A0inline bool dequeue_task(struct rq *rq, struct task_struct *p, int
> flags)
> =C2=A0{
> +	trace_dequeue_task_tp(rq->cpu, p);
> +
> =C2=A0	if (sched_core_enabled(rq))
> =C2=A0		sched_core_dequeue(rq, p, flags);
> =C2=A0



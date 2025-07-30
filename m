Return-Path: <linux-kernel+bounces-750856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2FB161E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93077AC533
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498A2D838E;
	Wed, 30 Jul 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NppxPi2v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA284B46
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883603; cv=none; b=W/eWs7MgnYvLYzs25Z+uNSGXVBD4eOkNTeyu1PhGo1OLRjfVQLDQIZecfLoFwFxbqoOzNjUW5b5Sg3sNCd3EqKoTupzntwTVUQsynOJ1oqh0QOhqmH1RdVB+UUMVEDf/5DLLt866v5p+WQLznKaNHFDcZWVkkDRIetgPaKEHBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883603; c=relaxed/simple;
	bh=IU3JMQiFV+FGQK9o7AYX0uWR9uKc/B7ZTHHw5MB8Myw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RK7kFul3tjHMJRYYSnEubk6guqsM/45UxMr9VoSYftaZbzmSi6w/7S7gpE+tV4/6r523dxzLgnaYB+qbaOJnrTlggw8SJdM3Tvs0wcIqBF/LO6WS+pMvLBiEGuC4D86SjqtOqoTp6MOigJEFpC7GVB5vHFTESb+9r/H4aQ4ugu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NppxPi2v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753883600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s5VhBNCPpXfQ0FMhPUPtPbpUbYNgD0vDQAOO3ufsUTQ=;
	b=NppxPi2vVhvJ7tpbKvcFHOSH/xPO6zQ6wNbbmIdw5Y/RpQLxzsrT7gu4s6XvZaQsE7q09f
	4qcMAEJ6YQ2xNKYZepAvwU/ygs0r4kUfU5mp4pg5x5iqOIxuzN/LiVvu3qixWUeUi/zgrJ
	zRb/zJoiFHhm5ZtxNA0JWbOYBeLPpHU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-s5KxQf0HOfapNgxya1R3AQ-1; Wed, 30 Jul 2025 09:53:18 -0400
X-MC-Unique: s5KxQf0HOfapNgxya1R3AQ-1
X-Mimecast-MFC-AGG-ID: s5KxQf0HOfapNgxya1R3AQ_1753883598
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so3650828f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883597; x=1754488397;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5VhBNCPpXfQ0FMhPUPtPbpUbYNgD0vDQAOO3ufsUTQ=;
        b=sSIzKhEz6MjHwfv5KZFlDSSyG/V5nEltKZHfHd4HX8ZZ5OHQFz3eKP7MyuKsOax3d+
         lRvV4JFBElNcmszHFCCUnMwrGNfEEZ+SU79vCPbbPwBTWDl73eZZUI6lfDX1G0KaFKyM
         xsxiblBkcBRYBuHzE8PWDStbHy/PPIqicMDIcAOpgBI5o4bWX5PSkNScy8rmo4QCjTyp
         dp/+sXLioM0j2JvAf62K10aH0g8CHAuQEwq7NJLGdFbycqBxhlftXxaxvXVkk8Cw+1GP
         YqEnVUtvPlHKvJY6aPssFGC0HgVDVp5HJmqgpL+xnTzJLvo/jebsHacJSJY37gvff0fX
         WCvA==
X-Forwarded-Encrypted: i=1; AJvYcCWaU4tZ+hj9ynTrRCApo+UBrYh5tQ8JRFQWrmDfk/PcHoOSM4QPt36gFP7rLj9IaJP1bbJNMb21QC3OfSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93I4BeVfg1CUG5O6sxw7vlify6tQF7TYjt2lH16ODbIt4PL52
	FMAjjJTImzvGsEd0l3EcyqKe0PNXSNAdXgH62pkvp7nvo72s+RarccCXYp5s/fc8VemSxkLnoVE
	2U1Y1A/IVi7ra7ESVqCk0aH/4A8F06a0iUmR69SBHg4LfuD/8i2Mk3w1eSKqayFSR+Q==
X-Gm-Gg: ASbGncsV1XSXFudNmMs97wNyG3AwCDdwZ5fEcMtUvUBGWuWsMxI/D/CjEtd1UB2sPGL
	BC+EhR7E/VCYL11yJpHfntKJGVXIVHpLR/X7ggQJaZqCZRcmdkjTc1BRpC+KIY5J8kFgrrGRm8h
	iJg++7j1d3zEZXJ1AjF9llbeZKBxxcHcQxD3aa09K7SMC18JYFwlvNPq0jjhZzX6fwKohdxaFU6
	1J7OD4dJH/54xA4hMVjdkn0iur6wjvF9yo1Aji9vQP3oGmkGq3Y+LaQFVmmYyhDEpWnKfyucNjv
	XPt3K1RxKKOJd7V3CBfWkQnGY3aVW6nPsN5LBC/UFqQjxHupobdDmbABiHtReKfdRg==
X-Received: by 2002:adf:a297:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b7970da81bmr1347982f8f.46.1753883597566;
        Wed, 30 Jul 2025 06:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFEhzWYMwwTRQo1bdOhOzFaDIgbxaeTPnywGw4nVO9bfEoPrUNrdganQQ/iWkVZcrnq5VNw==
X-Received: by 2002:adf:a297:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b7970da81bmr1347953f8f.46.1753883597005;
        Wed, 30 Jul 2025 06:53:17 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b794a9d6a1sm3589006f8f.16.2025.07.30.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:53:16 -0700 (PDT)
Message-ID: <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Date: Wed, 30 Jul 2025 15:53:14 +0200
In-Reply-To: <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
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

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add trace points into enqueue_task_rt() and dequeue_task_rt(). They
> are useful to implement RV monitor which validates RT scheduling.
>=20

I get it's much simpler this way, but is it that different to follow
the task's existing tracepoints?

* task going to sleep (switch:prev_state !=3D RUNNING) is dequeued
* task waking up is enqueued
* changing the tasks's policy (setpolicy and setattr syscalls) should
enqueue/dequeue as well

This is more thinking out loud, but I'm doing right now something
rather similar with the deadline tasks and this seems reasonable, at
least on paper.

What do you think?

Thanks,
Gabriele

> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
> =C2=A0include/trace/events/sched.h | 8 ++++++++
> =C2=A0kernel/sched/rt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A02 files changed, 12 insertions(+)
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index c08893bde255..c38f12f7f903 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -898,6 +898,14 @@ DECLARE_TRACE(sched_set_need_resched,
> =C2=A0	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> =C2=A0	TP_ARGS(tsk, cpu, tif));
> =C2=A0
> +DECLARE_TRACE(enqueue_task_rt,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
> +DECLARE_TRACE(dequeue_task_rt,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +
> =C2=A0#endif /* _TRACE_SCHED_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e40422c37033..f4d3f5e7fbec 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1480,6 +1480,8 @@ enqueue_task_rt(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0{
> =C2=A0	struct sched_rt_entity *rt_se =3D &p->rt;
> =C2=A0
> +	trace_enqueue_task_rt_tp(rq->cpu, p);
> +
> =C2=A0	if (flags & ENQUEUE_WAKEUP)
> =C2=A0		rt_se->timeout =3D 0;
> =C2=A0
> @@ -1501,6 +1503,8 @@ static bool dequeue_task_rt(struct rq *rq,
> struct task_struct *p, int flags)
> =C2=A0
> =C2=A0	dequeue_pushable_task(rq, p);
> =C2=A0
> +	trace_dequeue_task_rt_tp(rq->cpu, p);
> +
> =C2=A0	return true;
> =C2=A0}
> =C2=A0



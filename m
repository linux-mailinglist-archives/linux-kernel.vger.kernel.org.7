Return-Path: <linux-kernel+bounces-766071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EEB241ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB881B674FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACE149C51;
	Wed, 13 Aug 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv7rYsHx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F62D0617
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067848; cv=none; b=NocUceiyAI9WMVG/iI812E6vFOb0l1a3Mjuw/8g1f43g/P4WAVGUYHjeQ9U6Y+CyygzMdPMpr1CxRLTrnakMBMO1fWT6m2yvbeSNFmA/UQ2KwEm0kyznv6Uk6Ey/fsDYQ5KVEpMBtLBDBhfPRXck3nCIXSKY3UDEIx9wFXVuOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067848; c=relaxed/simple;
	bh=cBVmn9JnEoS3BZliqNzYhmwGcxntcYPH4dE6+tSC/b4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Os2WQP9ZGLPGFxfc93yIlGZVieOgVs/AWVQURhNVBTWQ1BFKiwC94PLIg7tmBCv1GAisgcPsKiYe0YDRA5mN3jEDuBf5EJo6wKEECGdpbmolegGC3T3sZItxsggFPtAYSz/PIngpTvFDNLku9cbUChDetwcVd27vLyK6FFnnyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv7rYsHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755067846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6w5eQUyqRO+CIDf7CkJT/ZVucOGIR0B1JUL4frXMV3k=;
	b=Tv7rYsHxxPA9cfTQM8K6Tb877IXbSIYKw9cr01aiyasdokgs1IE2pxuT9Lq6q5dDTtYHXS
	cxO9xwoHSFdt0pmDTbExkOJcm4qBg8flZRLa2tdMVtGWE+XfXUtXiBIKLJzkQu2egSO6DX
	EWJBdWWTaXv/0BVT9pbuT9AGMWMJ8jg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-xOutxQsXOM-j5t74rIrGXg-1; Wed, 13 Aug 2025 02:50:44 -0400
X-MC-Unique: xOutxQsXOM-j5t74rIrGXg-1
X-Mimecast-MFC-AGG-ID: xOutxQsXOM-j5t74rIrGXg_1755067844
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso227057241cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067844; x=1755672644;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w5eQUyqRO+CIDf7CkJT/ZVucOGIR0B1JUL4frXMV3k=;
        b=cmsc6p+3MjkXsevtH8cOfBub1Tre26hlgniOim//dhbD0NEdG9KGLIWdic6q3eM2xD
         9dstMGxu31V/CWdK4Bx6DIhgEwRP5Rf90deOqlHkrMyBwV2l6rcYla0GsSyuVvDphuTW
         HL7IgwHjhW/y0w8a7lFIhlfd6T9hCnnr89ItkU7y+UhUfUGR4BnRp7S0hia0m1gXi3yy
         nliNuEObhkTuYA4dJfsgn/AK8L3zLArUN1FvoAlV0gg82XY2auU820sixzb/o04er0yQ
         yCoGWyO3Is/ttQL+Z+xtidX0k3MGoyncrs/Ia75jc4x8RGIB2CGccrtwhCFKF8COD9Q1
         QmcA==
X-Forwarded-Encrypted: i=1; AJvYcCVNrlRtviWwfrojwSONT7Tu6igKZbLoEbZSPUpGZuQtbYNz2fYm34QrKko6oUUzglhSHYQA+CJGd/qpCfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpIEis4v7ybEkgfLHjGOzRccdOLbWHYdqV5X0AdWET8irEpvu
	3Rb5JeejlGsEtx7JloBDV9Mng9sadP3xTxPqEMslTMEMf2g70TN99EkiBjg4Cgz6UL+7liIY5mg
	pghUpdRCIgZFObydQPYZ7CgEwyqk/3dXicfkjfnZe97ZP7jyHYUCSNCsHjyjyO7YfZg==
X-Gm-Gg: ASbGncuy97nl40AxUtb4uYcLwqDI/Rgj02CLgm1IUX4CojJGBbPwdyNf+c5eSg4oMlm
	J3cPrDMJHqZ7zOag58I/iu1VKj0xwKyRggOHBJOU0Pshg0pkhr7whOB9P4a5egDxdESv6yiGI2i
	JrbAr3q6mZJN0NZTLMRE+fFAIXPK6bJ1Dbr2SjyyikOPJJoWvokAH1p5gXVCfK3SnxIot5vIf6e
	CDaYp9Xjk+Fg21A7xhlu+1RFpFKRq1EjcSMjzEbvnEJ1l7kpu5NCd3ujx3nWWPow8QoNY5h+poY
	cV8kpbSunnQtyp5iuMbUOvisJEyPBHfnrnKY9wtBGsZ3RHN+s12r6jhhuEu11IxJtg==
X-Received: by 2002:a05:622a:408d:b0:4b0:7f93:3cdb with SMTP id d75a77b69052e-4b0fc8c724bmr22315011cf.43.1755067844119;
        Tue, 12 Aug 2025 23:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuShnNGJ7nGbvS9Hkfc1PmPGBF5ZFOBaHg2Zh9sPeWe34ZfQ7UBXLn3E+cyFDkg+ZnNoAHvg==
X-Received: by 2002:a05:622a:408d:b0:4b0:7f93:3cdb with SMTP id d75a77b69052e-4b0fc8c724bmr22314821cf.43.1755067843757;
        Tue, 12 Aug 2025 23:50:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07611dc5asm126034001cf.42.2025.08.12.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:50:43 -0700 (PDT)
Message-ID: <61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall	 <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>
Date: Wed, 13 Aug 2025 08:50:39 +0200
In-Reply-To: <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
References: <cover.1754900299.git.namcao@linutronix.de>
	 <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
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

On Mon, 2025-08-11 at 10:40 +0200, Nam Cao wrote:
> Add trace points into enqueue_task() and dequeue_task(). They are
> useful to implement RV monitor which validates RT scheduling.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Peter, Ingo, this patch adds new tracepoints in the scheduler do agree
with the change, can we get an Ack?

Thanks,
Gabriele

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v3: fix up build issue on !SMP
> v2: Move the tracepoints to cover all task enqueue/dequeue, not just
> RT
> ---
> =C2=A0include/trace/events/sched.h | 13 +++++++++++++
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 8 +++++++-
> =C2=A02 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index 7b2645b50e78..696d22af5a98 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,19 @@ DECLARE_TRACE(sched_set_need_resched,
> =C2=A0	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> =C2=A0	TP_ARGS(tsk, cpu, tif));
> =C2=A0
> +/*
> + * The two trace points below may not work as expected for fair
> tasks due
> + * to delayed dequeue. See:
> + *
> https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com=
/
> + */
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
> index be00629f0ba4..6367799aa023 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +	trace_enqueue_task_tp(cpu_of(rq), p);
> +
> =C2=A0	if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0		update_rq_clock(rq);
> =C2=A0
> @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0	 * and mark the task ->sched_delayed.
> =C2=A0	 */
> =C2=A0	uclamp_rq_dec(rq, p);
> -	return p->sched_class->dequeue_task(rq, p, flags);
> +	if (p->sched_class->dequeue_task(rq, p, flags)) {
> +		trace_dequeue_task_tp(cpu_of(rq), p);
> +		return true;
> +	}
> +	return false;
> =C2=A0}
> =C2=A0
> =C2=A0void activate_task(struct rq *rq, struct task_struct *p, int flags)



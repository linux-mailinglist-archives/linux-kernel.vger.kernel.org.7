Return-Path: <linux-kernel+bounces-759139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943ABB1D90C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF87584F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795625C711;
	Thu,  7 Aug 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efhnP8Oj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623425B301
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573334; cv=none; b=DxV0cADiWXPlFiVZVXJH1A9TwJzi8qjnYsnNJJ4B9s9qcSqANmziM2Yfj40A/TWy7xIvLHG0oL72fqvb3wS8S/cBqbZvHa3ALpcrVOjEflcXyQxlTmv1oBERQH1HMx/mFGk7439B+Ah+ii+Tes80J6yk3TVam6il9Bydh/k5V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573334; c=relaxed/simple;
	bh=hS/XObiD36rjKaLxfMmDyuWsrOQ9/pIlMw01cTqSBkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJUDERrqBoXoPZ3ui5uEI1vDjc/3P+1NilHPdoUmllUXHGomQ9Ywqm0oaB0yu9QQjmZk8djCgMrN09Th8Ny+3ehp5C4mN8KRylPNBcElRAlR3sWVcdfLYTXG8UrDrvmuP3r3GW2fYWl9sYf7qSGw04CKgMpE87qiruNUDcVqEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efhnP8Oj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a5xwSvCoF6TIRBA5wgVSUg6aFNp3Rr7VfLIXicuNjQY=;
	b=efhnP8OjvjC7pKYfWdcn8i6483nWohzNh6z/vUvmVoQPs+F1O5JO2r38obyQWoKF4yKAAq
	eoeE/nUboFc3VBYEeyj6qHc/z9fGhPPbyLv4rdt10lx8l0eqFK0VWibu3ivqvr0jxZRb6m
	dWAT3jbUf61YLceGOQMiEqwxZkY4tmk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-7mtDawbNPjC66HoJr0uwDg-1; Thu, 07 Aug 2025 09:28:50 -0400
X-MC-Unique: 7mtDawbNPjC66HoJr0uwDg-1
X-Mimecast-MFC-AGG-ID: 7mtDawbNPjC66HoJr0uwDg_1754573330
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70744318bdfso28921966d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573330; x=1755178130;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5xwSvCoF6TIRBA5wgVSUg6aFNp3Rr7VfLIXicuNjQY=;
        b=MbTd0lMd4gZVQiLtH9UmIQrSuc/X26T9HNK6DCABKfj/tzHO1U7Jlnd+gxXhr+BMv0
         RZWQRd+pStue3pOrVxBPsQgWwcRQEVLIAbL6rRSFIYbm2xl6Q23qdvLiORQCdiR6GYV3
         QWdNFDoOUpBYkuGCKD4MRQUrgJdY/OJqvGnRkZKqr4IjngI2hUYSN359gFIsmbfIs9mZ
         4MSe7f/Tu+51TFnK5DL1tM37ZCLhNmtWsmDi5WTM7MqaSxCCNJBt6w/maEU2fYntn6jB
         eoieEOy7k5Li4aIlYQzMFXvHvg9ahrkdx3gUaat+VjEu+Usztvk3nQX9XEC3pp/lD8mt
         LC+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWjmajJZFna513WNvmXqwpBjBMMvHI1hqBtWDJkTKKsKZtjvUwcKCR+bYkDO1zzbQl87UiWFVE539X120=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbSNfsgXKXTNh5ljsbf2D1cAUuEkpJK3ON/UTs63+QLHHg+Rb
	bGVs0KoLTE6r4REqdVUH6T1QTbgEDSaRPwvzvPf2jkJRp36So3puPp1oxag2PNd2y1knlp3Wve9
	sIl7ywEngr0MPQFIqIi858STZd7uy+XVGnFax0xDyBBV2dPSY/O6+CBbjCywOcMO9fg==
X-Gm-Gg: ASbGncudvAYdkebF8/oDIbJrwjZNy5GuxwaKBoDu3tg7itcLJSsTq0Iw1GvrAtmrJ5u
	ze4aWH+G65b2qQ3CaiW5NaeKIRShUmQ71bqaqaRkePa0LDPQ2+e/7Eodg5LRJTqaAhN/vfkhfxE
	/dyFJfBdxnYAUwY2yY0gYplyEqXwRY6yvKP7UioKzVyTRTKtRappjO9iab0/H/xg/OtP/bt+VDz
	hqbLoisW9m4TFXFKcaYXVrpv696zn0w/W7IxREfRQNy7jXTLgoZ1hewURol9/EAb0WI2jeeNwiv
	Qu1d37FC1SNtvDvOT2sf3nUhY/cOGqTXtuPSVQbF5MellWYJMh9vYpzsYhk7P6vpPQ==
X-Received: by 2002:ad4:5dc6:0:b0:706:ea6d:e161 with SMTP id 6a1803df08f44-7097966daf2mr102842966d6.32.1754573329777;
        Thu, 07 Aug 2025 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9u4O9j1s3L/rokLiFtLf2hoWRa81S/BHfvNB2TK04cCsaj75pcgxG5grJPq4cYwLx59tJg==
X-Received: by 2002:ad4:5dc6:0:b0:706:ea6d:e161 with SMTP id 6a1803df08f44-7097966daf2mr102842666d6.32.1754573329199;
        Thu, 07 Aug 2025 06:28:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c716effsm98789026d6.0.2025.08.07.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:28:48 -0700 (PDT)
Message-ID: <918e887ec5f0832623b9fb7b8a23559aaa66e3db.camel@redhat.com>
Subject: Re: [PATCH v2 2/5] rv/ltl: Support per-cpu monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Aug 2025 15:28:46 +0200
In-Reply-To: <8e2b9d37f0543b1c0f78119d459d2294d99c8d4d.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <8e2b9d37f0543b1c0f78119d459d2294d99c8d4d.1754466623.git.namcao@linutronix.de>
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

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add support for per-cpu run-time verification linear temporal logic
> monitors. This is analogous to deterministic automaton per-cpu
> monitors.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: Rename "implicit" to "cpu"

Looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0 | 32 +++++++++++++++++++++++++=
+
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0kernel/trace/rv/rv_trace.h | 46
> ++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 82 insertions(+)
>=20
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 9dabc5b133a3..4ad08b5b9f2d 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -23,12 +23,21 @@
> =C2=A0
> =C2=A0typedef struct task_struct *monitor_target;
> =C2=A0
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +
> +#define TARGET_PRINT_FORMAT "%u"
> +#define TARGET_PRINT_ARGS(cpu) cpu
> +
> +typedef unsigned int monitor_target;
> +
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> =C2=A0static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0
> +static struct ltl_monitor *ltl_get_monitor(monitor_target target);
> +
> =C2=A0static void rv_cond_react(monitor_target target)
> =C2=A0{
> =C2=A0	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> @@ -54,6 +63,13 @@ static struct ltl_monitor
> *ltl_get_monitor(monitor_target target)
> =C2=A0{
> =C2=A0	return &target->rv[ltl_monitor_slot].ltl_mon;
> =C2=A0}
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +static struct ltl_monitor *ltl_get_monitor(unsigned int cpu)
> +{
> +	static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
> +
> +	return per_cpu_ptr(&ltl_monitor, cpu);
> +}
> =C2=A0#endif
> =C2=A0
> =C2=A0static void ltl_target_init(monitor_target target, bool
> target_creation)
> @@ -108,6 +124,22 @@ static void ltl_monitor_destroy(void)
> =C2=A0	rv_put_task_monitor_slot(ltl_monitor_slot);
> =C2=A0	ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
> =C2=A0}
> +
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +
> +static int ltl_monitor_init(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		ltl_target_init(cpu, false);
> +	return 0;
> +}
> +
> +static void ltl_monitor_destroy(void)
> +{
> +}
> +
> =C2=A0#endif
> =C2=A0
> =C2=A0static void ltl_illegal_state(monitor_target target, struct
> ltl_monitor *mon)
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 5b4be87ba59d..7ef89006ed50 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -16,6 +16,10 @@ config DA_MON_EVENTS_ID
> =C2=A0	select RV_MON_MAINTENANCE_EVENTS
> =C2=A0	bool
> =C2=A0
> +config LTL_MON_EVENTS_CPU
> +	select RV_MON_EVENTS
> +	bool
> +
> =C2=A0config LTL_MON_EVENTS_ID
> =C2=A0	select RV_MON_EVENTS
> =C2=A0	bool
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 4a6faddac614..bf7cca6579ec 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -177,8 +177,54 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
> =C2=A0#include <monitors/pagefault/pagefault_trace.h>
> =C2=A0#include <monitors/sleep/sleep_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> +
> =C2=A0#endif /* CONFIG_LTL_MON_EVENTS_ID */
> =C2=A0
> +#ifdef CONFIG_LTL_MON_EVENTS_CPU
> +DECLARE_EVENT_CLASS(event_ltl_monitor_cpu,
> +
> +	TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +
> +	TP_ARGS(cpu, states, atoms, next),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__string(states, states)
> +		__string(atoms, atoms)
> +		__string(next, next)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu =3D cpu;
> +		__assign_str(states);
> +		__assign_str(atoms);
> +		__assign_str(next);
> +	),
> +
> +	TP_printk("cpu%u: (%s) x (%s) -> (%s)", __entry->cpu,
> +		=C2=A0 __get_str(states), __get_str(atoms),
> __get_str(next))
> +);
> +
> +DECLARE_EVENT_CLASS(error_ltl_monitor_cpu,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu =3D cpu;
> +	),
> +
> +	TP_printk("cpu%u: violation detected", __entry->cpu)
> +);
> +// Add new monitors based on CONFIG_LTL_MON_EVENTS_CPU here
> +
> +#endif /* CONFIG_LTL_MON_EVENTS_CPU */
> +
> =C2=A0#ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
> =C2=A0/* Tracepoint useful for monitors development, currenly only used i=
n
> DA */
> =C2=A0TRACE_EVENT(rv_retries_error,



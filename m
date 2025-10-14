Return-Path: <linux-kernel+bounces-851963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0BBD7CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C77F4E1782
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F96305E38;
	Tue, 14 Oct 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb9liwpv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64D2AD0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425697; cv=none; b=jvo0wlGiPm0/ErsMC9BrLbIxZiKeG9ZgU1ULLFc3cDwBEJ5cVkXIP+ND7ACa9QuyPR+s7Hbb4D87gH/0yw6Ik7geR9hU2rAYmkMLJMelfwiqwav+lzS+fCC0mMoN1G8smNwyiRosiVNznYuS/AxFN9tdKIbT+yIV/+fpFmA17fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425697; c=relaxed/simple;
	bh=BzXYjfqYYdqzszJ8aQyRIfRYw5x81CUneoiMhiUb1lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6wUMNJQONYPJr8YL2CuXSPT6PJ79Ox6Ep9XaKdUSVaSKgp4UHBwNq2v5+ZByl/8Weq+zcPB3ko3yqzTBAlGDc1fZ20J7p/D1fSt9i8oFHWp7nav8gMTFupC6d45ZVwB9oXfjE7z1cBoORgpgGQcdY3gJpMr+ManTfjp0GoBa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zb9liwpv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760425694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kttvYHXy0dkls+A2ePr50EJQBuY3+2CK/H0WABCdXHI=;
	b=Zb9liwpvhxlB5bnahqbbrLUSySPY7fGIt85jxv1D9RPEa9TkEaM4kg7+/Pszodd6DRtnSJ
	Ka/CSIjkMGZ4ILsfp/PM2JxbdpfESFwG6ToM8z37tn7Laic8ICTHOLna2NkkQUQ7//nZlM
	LZVtfaJ+cdC6CZnuQWFtqAUtYqqVPqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-v9p5_aH5OCK2PID0wTmBbg-1; Tue, 14 Oct 2025 03:08:13 -0400
X-MC-Unique: v9p5_aH5OCK2PID0wTmBbg-1
X-Mimecast-MFC-AGG-ID: v9p5_aH5OCK2PID0wTmBbg_1760425692
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d314d0deso2026484f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760425692; x=1761030492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kttvYHXy0dkls+A2ePr50EJQBuY3+2CK/H0WABCdXHI=;
        b=W+X84Yq/MhrNhN6fXB0RkshU2kVCGOIHEbdG4s9fROxe07mBC2AMiufpefVXotEQTk
         /qWcNJtxprHREmUcPqOlEgSCC9EoBH1XAA1CneO7vYRtBwBBsiVQ08w6QmHhsGSODXDh
         pq5XrHbYLZynSWiG7NnAcTstOkflSMCl0qlMJPHjU2Fj7jYF50udFUEcVS2J8CVv3X/H
         9AK0515vbu1Nt7q7OxJnNDAWWElwyUlTv48LnyxaLEA6tsAbRtCbXMPimMoAMAjnsTt9
         YL2tFRw53r4+T9RK+anaGEjG0RYV/vlRv64hGS/Zxzl+o+nVJX1AFkr8xX43rJsdZrUQ
         HUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8NBvsd7RgV1bVtZJH99ftC15lfjUSyIntn6GWgZRx1iFQ4peeY4EyCtR/9CYsReMSotbpQ8Ivzv57FUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0A6n6TY/o7t98kiyYWq8d1EnlrhdzweqLgPAABR/bTkinZYP
	cMnRs3SIDV7v8OT8AHtiI4sW0yHI2/ogpuG2nIVHxf1sI7RHkz3bEl6nNQNLZ2ryhv/FRjdrqJp
	mwr/fwDzihhiNQ3XOzH96EY89Irvr75/HvahkE8D+OTW+0RkK3lfFGztvwnIAqO0izYgauUQ9uo
	G3
X-Gm-Gg: ASbGnct/fSpX5PaiJOYHhaap6VwEetWseUuDTk3qQt78VzWS48Zj+CaHEktww9FcmLT
	8Z77BS2KVfFLS27gM2Oey3g8RUq8DmCug207U7++YtttXc4lk5nmtYUlhupO+XdzLM941GB6ujB
	UrOC5ILoqBvqBhVDodco9wsffQ4Q0NxBb6cqaSfpvIrYPV9XBWr2Ns62xALpuLy0EONNvVslYJ4
	klVJE/DyZxFv0xeZ0dduXq7Od17NziVZwGt03joWcyQ6sp6SjC7OB54Vh6ZQHagVYRMt0gpLgP4
	0Y1w0/Vi7CPhadxLc4tea1DK/c12XhonfaJidPpHNryE9TJzdtFQICJOzxwXqJbKyw==
X-Received: by 2002:a05:600c:3b11:b0:46e:43ee:3809 with SMTP id 5b1f17b1804b1-46fa9a86364mr172019525e9.7.1760425691851;
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGRGjdiMCnQn5yNuX2bFCVFs8mYsMvlH0qZjdQzQmK4l4YIwFG7Zm0iMoZHgEddJ5BuP3LA==
X-Received: by 2002:a05:600c:3b11:b0:46e:43ee:3809 with SMTP id 5b1f17b1804b1-46fa9a86364mr172019215e9.7.1760425691431;
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm7331150f8f.38.2025.10.14.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
Message-ID: <704a58272bb9071d31488c1e12d508914dc391a5.camel@redhat.com>
Subject: Re: [PATCH 1/3] rv: Pass va_list to reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 09:08:10 +0200
In-Reply-To: <20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 07:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> The only thing the reactors can do with the passed in varargs is to
> convert it into a va_list. Do that in a central helper instead.
> It simplifies the reactors, removes some hairy macro-generated code
> and introduces a convenient hook point to modify reactor behavior.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,34 +16,19 @@
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static void cond_react_##name(type curr_state, type
> event)					\
> -
> {												\
> -	if (!rv_reacting_on() ||
> !rv_##name.react)						\
> -
> 		return;										\
> -	rv_##name.react("rv: monitor %s does not allow event %s on state
> %s\n",			\
> -
> 			#name,									\
> -
> 			model_get_event_name_##name(event),					\
> -
> 			model_get_state_name_##name(curr_state));				\
> -}
> -

The overall change looks good to me, just keep in mind there is an ongoing
refactor [1] for the da_monitor header to get rid of those macros, basicall=
y
making it more similar to the current ltl.
Depending on which gets merged first, you may need some (trivial) adaptatio=
n of
this.

Going to test it out more carefully in the next days.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20250919140954.104920-1-gmonaco@redhat.c=
om

> -#else /* CONFIG_RV_REACTOR */
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static void cond_react_##name(type curr_state, type
> event)					\
> -
> {												\
> -
> 	return;											\
> -}
> -#endif
> -
> =C2=A0/*
> =C2=A0 * Generic helpers for all types of deterministic automata monitors=
.
> =C2=A0 */
> =C2=A0#define DECLARE_DA_MON_GENERIC_HELPERS(name,
> type)						\
> =C2=A0								=09
> 			\
> -DECLARE_RV_REACTING_HELPERS(name,
> type)								\
> +static void react_##name(type curr_state, type
> event)						\
> +{								=09
> 			\
> +	rv_react(&rv_##name,					=09
> 			\
> +		 "rv: monitor %s does not allow event %s on state
> %s\n",			\
> +	=09
> #name,										\
> +	=09
> model_get_event_name_##name(event),						\
> +	=09
> model_get_state_name_##name(curr_state));					\
> +}								=09
> 			\
> =C2=A0								=09
> 			\
> =C2=A0/*								=09
> 			\
> =C2=A0 * da_monitor_reset_##name - reset a monitor and setting it to init
> state			\
> @@ -126,7 +111,7 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)				\
> =C2=A0	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> {					\
> =C2=A0		next_state =3D model_get_next_state_##name(curr_state,
> event);			\
> =C2=A0		if (next_state =3D=3D INVALID_STATE)
> {						\
> -			cond_react_##name(curr_state,
> event);					\
> +			react_##name(curr_state,
> event);					\
> =C2=A0			trace_error_##name(model_get_state_name_##name(curr_s
> tate),		\
> =C2=A0					=C2=A0=C2=A0
> model_get_event_name_##name(event));			\
> =C2=A0			return
> false;								\
> @@ -165,7 +150,7 @@ static inline bool da_event_##name(struct da_monitor
> *da_mon, struct task_struct
> =C2=A0	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> {					\
> =C2=A0		next_state =3D model_get_next_state_##name(curr_state,
> event);			\
> =C2=A0		if (next_state =3D=3D INVALID_STATE)
> {						\
> -			cond_react_##name(curr_state,
> event);					\
> +			react_##name(curr_state,
> event);					\
> =C2=A0			trace_error_##name(tsk-
> >pid,						\
> =C2=A0					=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),		\
> =C2=A0					=C2=A0=C2=A0
> model_get_event_name_##name(event));			\
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index
> 5368cf5fd623e74a5739d2e0b3fc2c27c4bad597..00c42b36f961a00ee473aa58f14b015=
30852
> 3eb0 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -16,21 +16,12 @@
> =C2=A0#error "Please include $(MODEL_NAME).h generated by rvgen"
> =C2=A0#endif
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> =C2=A0#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> -static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0
> -static void rv_cond_react(struct task_struct *task)
> -{
> -	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> -		return;
> -	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]:
> violation detected\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task->comm, task->pid);
> -}
> +#ifdef CONFIG_RV_REACTORS
> +static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0#else
> -static void rv_cond_react(struct task_struct *task)
> -{
> -}
> +extern struct rv_monitor RV_MONITOR_NAME;
> =C2=A0#endif
> =C2=A0
> =C2=A0static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
> @@ -98,7 +89,8 @@ static void ltl_monitor_destroy(void)
> =C2=A0static void ltl_illegal_state(struct task_struct *task, struct ltl_=
monitor
> *mon)
> =C2=A0{
> =C2=A0	CONCATENATE(trace_error_, MONITOR_NAME)(task);
> -	rv_cond_react(task);
> +	rv_react(&RV_MONITOR_NAME, "rv: "__stringify(MONITOR_NAME)": %s[%d]:
> violation detected\n",
> +		 task->comm, task->pid);
> =C2=A0}
> =C2=A0
> =C2=A0static void ltl_attempt_start(struct task_struct *task, struct ltl_=
monitor
> *mon)
> diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_pa=
nic.c
> index
> 74c6bcc2c7494408770881dda2b0de885c5eb88c..76537b8a4343cbd0d715f60db3cc886=
8e71c
> 1c0b 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -13,13 +13,9 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_panic_reaction(const char *msg, va_list ar=
gs)
> =C2=A0{
> -	va_list args;
> -
> -	va_start(args, msg);
> =C2=A0	vpanic(msg, args);
> -	va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_panic =3D {
> diff --git a/kernel/trace/rv/reactor_printk.c
> b/kernel/trace/rv/reactor_printk.c
> index
> 2dae2916c05fd17397195e37d9b42d24cea24b9c..48c934e315b31c14d3a5b4fa3ec334e=
f71f9
> e390 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -12,13 +12,9 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_printk_reaction(const char *msg, va_list a=
rgs)
> =C2=A0{
> -	va_list args;
> -
> -	va_start(args, msg);
> =C2=A0	vprintk_deferred(msg, args);
> -	va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_printk =3D {
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index
> d32859fec238371b5721e08cf6558f0805565f7b..cb1a5968055abb22439a066b4e25dad=
98f07
> 8389 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -438,7 +438,7 @@ int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */
> -__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_nop_reaction(const char *msg, va_list args=
)
> =C2=A0{
> =C2=A0}
> =C2=A0
> @@ -477,3 +477,17 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0out_err:
> =C2=A0	return -ENOMEM;
> =C2=A0}
> +
> +void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> +{
> +	va_list args;
> +
> +	if (!rv_reacting_on() || !monitor->react)
> +		return;
> +
> +	va_start(args, msg);
> +
> +	monitor->react(msg, args);
> +
> +	va_end(args);
> +}



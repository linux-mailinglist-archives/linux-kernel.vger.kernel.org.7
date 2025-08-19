Return-Path: <linux-kernel+bounces-775351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DCB2BE44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EC01681EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B20319844;
	Tue, 19 Aug 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZI3vuYC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5E220F2A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597428; cv=none; b=JRLyyrggLky/V86kF1JxmtXu2BqYILPP2usX6+bX3wpjY65fcxy1kcKpWSsbNj0l2vKqFsDpo2WG3aB87yr5GK8rQWaTT2JxmLrEwF/Simlx+FiS5TaYbW8d5qH+PerHteJSVWqjKn+ZZ8RpbDQhS410On1tzPdJ6lAxlp2YH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597428; c=relaxed/simple;
	bh=1ubucLddQMJmUq8vjtzNlVwWTiogh6llKgtEaT/i9oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Jy5Ti0IYVDf1/XrswzCyOXsVym2tfPBZaiwwYI/YUHb8psznkgfxPxO1TbBZPeQQPiocLnKFL5QIWroW7cqhEBcVJacqT5iw4Hc7n3/o5Z8H0xo1WSihD2RCxSnb/7MsG6HRSj3wlk5EnTMTW1+POHqYBAJaAh/0Oamg9a0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZI3vuYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755597425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovO3/gXHZDqtkD72WJKDDP7JTR3a7GhFon9JbVq5pdo=;
	b=GZI3vuYC3kDsf3PkLjyKefAtmldAqAtn3aKSXCKegUVX08A/JvG2DaTZXi7OwTptPWqxoD
	CH0LX2FpBWI6pEzq8eQ0kli4kih/5gixOuVQweBFa+UqdqWo+Q8ZGjS6Aw1pZrO8vCdHGi
	f0koweIInN7jHRh9Hpmzb0WsBq6ZA38=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-rwdqMG3gPpGRiJGklooE6g-1; Tue, 19 Aug 2025 05:57:03 -0400
X-MC-Unique: rwdqMG3gPpGRiJGklooE6g-1
X-Mimecast-MFC-AGG-ID: rwdqMG3gPpGRiJGklooE6g_1755597423
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10992cfedso117324431cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597423; x=1756202223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovO3/gXHZDqtkD72WJKDDP7JTR3a7GhFon9JbVq5pdo=;
        b=BVP3/RWs9P0qw+8QO+FfPDzygFrGSD8L91ut7ikzu1k0xb8QzEnK0G8AonGD239nlk
         iez7g/9tFn2aNmQA7nwSgf44Jr+yz+gRgTa5+KaHpBOGpEPVsrCSRtmpthSswsrQQnXb
         nRGBCQ+3gbmkfql7/cIZhx7m73TNZ8BDMD/qNkz5ZawtCwYFVzlOeiI13FmzoZFJuxDt
         y6OiFXU9r3tIfFqdPRnrSwNPCltUhx7qO0WhVg49b7IMzKJgmgMkNLoxVNmjGfHVgvG2
         8z9PPlklPCgVmJnQRDn7jqbKiVvufqgNZg8DX20fBtS/fu+AXC44zghNKg9FV1MyQJV9
         7UXg==
X-Gm-Message-State: AOJu0Yy25Rn4rqAGyyNnP+RPzb/9xdYEDKvTV7z9KQnXiIzsL6DkVdse
	ycUkdP1M+3giC6iEJemFdqF2B9SFVcQ8T5DIhVoQlCdp2XXqVYwn+SxLAmgGQuW/aOivzAAsAY2
	FipNyj7J5Tv1qYCAKWfL/GIaS0UXxzUjDV39fBgLI4pl7Q675sqJfALZngqWNWNwkTg==
X-Gm-Gg: ASbGncvzRJQohUUSic5OReekvEsNjO2X1kR7jZVw4z4+Q1W7M77l7m6pqh71Al/NkIr
	0anHmYJ+ICqN21fMa4boEVavEskGyoP4Sem+u4Cx7pAfp2ckUdgWx+zOLQ6Vv37tCBfnBp/rL6K
	pd0VveP8526iw0jqwB3Ke5N0OpPMYU26Gsz3KwpHtEu2juBALzXSBiGtctROgGXZrerHhXy6eui
	UMfTtlKFSbeN9vDhthwIWp9FQlo6qSIAW/218fGTxKg2YYTyvIKYhoQC2p7cn2s+bLK78nhXLsb
	dTQIJsaA72OvWT+ATMC2yo4cxxZtdcJSHqft7hK6RCAurYpvHMG8c59g/ODBKGPovI/c
X-Received: by 2002:ac8:5cc7:0:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b286ef3974mr18223081cf.56.1755597422850;
        Tue, 19 Aug 2025 02:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPOnJ8MWq8N3ISVkEuPgun5DwRV+bNUHYaZl50LdgymHYzejrD/IRP5r0A6M+wbxfPykgqiA==
X-Received: by 2002:ac8:5cc7:0:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b286ef3974mr18222921cf.56.1755597422408;
        Tue, 19 Aug 2025 02:57:02 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5d069sm65369421cf.21.2025.08.19.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:57:01 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:56:57 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-15-gmonaco@redhat.com>

Hi!

On 14/08/25 17:08, Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_server_start(dl):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl, hard):
>     Called when a deadline server is stopped (hard) or put to idle
>     waiting for the next period (!hard)
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/trace/events/sched.h | 55 ++++++++++++++++++++++++++++++++++++
>  kernel/sched/deadline.c      |  8 ++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..f34cc1dc4a13 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
>  			__entry->oldprio, __entry->newprio)
>  );
>  
> +/*
> +DECLARE_EVENT_CLASS(sched_dl_template,
> +
> +	TP_PROTO(struct sched_dl_entity *dl),
> +
> +	TP_ARGS(dl),
> +
> +	TP_STRUCT__entry(
> +		__field(  struct task_struct *,	tsk		)
> +		__string( comm,		dl->dl_server ? "server" : container_of(dl, struct task_struct, dl)->comm	)
> +		__field(  pid_t,	pid		)
> +		__field(  s64,		runtime		)
> +		__field(  u64,		deadline	)
> +		__field(  int,		dl_yielded	)

I wonder if, while we are at it, we want to print all the other fields
as well (they might turn out to be useful). That would be

 .:: static (easier to retrieve with just a trace)
 - dl_runtime
 - dl_deadline
 - dl_period

 .:: behaviour (RECLAIM)
 - flags

 .:: state
 - dl_ bool flags in addition to dl_yielded

> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(comm);
> +		__entry->pid		= dl->dl_server ? -1 : container_of(dl, struct task_struct, dl)->pid;
> +		__entry->runtime	= dl->runtime;
> +		__entry->deadline	= dl->deadline;
> +		__entry->dl_yielded	= dl->dl_yielded;
> +	),
> +
> +	TP_printk("comm=%s pid=%d runtime=%lld deadline=%lld yielded=%d",
                                                        ^^^
							llu ?

> +			__get_str(comm), __entry->pid,
> +			__entry->runtime, __entry->deadline,
> +			__entry->dl_yielded)
> +);

...

> @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  
>  throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> +		trace_sched_dl_throttle_tp(dl_se);
>  		dl_se->dl_throttled = 1;

I believe we also need to trace the dl_check_constrained_dl() throttle,
please take a look.

Also - we discussed this point a little already offline - but I still
wonder if we have to do anything special for dl-server defer. Those
entities are started as throttled until 0-lag, so maybe we should still
trace them explicitly as so?

In addition, since it's related, maybe we should do something about
sched_switch event, that is currently not aware of deadlines, runtimes,
etc.

Thanks,
Juri



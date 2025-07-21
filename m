Return-Path: <linux-kernel+bounces-739533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEFB0C776
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B959A1AA3D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BA2DF3FD;
	Mon, 21 Jul 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfiU1p9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE22DC33A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111401; cv=none; b=Chg1Klas/opJ1aaIwMrkjhD7h6LIwpe8+h5EFgJ08TcsbW2AVXYkIEGwGCTK+eGox7NzURCEv5Z92zzt5uGf4j71wB9rqM3vRCLrCv0dB8kznL8N7pH+4ZR1Wi90ZdXeNv7djZg3mZvmYbcVfogi0XVdhqYVY/aTnnilGGybHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111401; c=relaxed/simple;
	bh=ZnnGQBGaBJE5wN+cg8Ywlvgc6aIazcBRhgq0hpiQUtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sX8NO+ciFTPBi2WdHVFjR/m/q43Z5x7ThOSBoMv1JDm+b39nAHuvmEwNv+WtLmQMtQXEUV8C1b4x6xkciocRj8vl+8gZKe4JT2dp3DXtmpp7Y9Jo5xoyWjj4u8VlpN/vCkOyOhXoHGBjcE01CtRI9O6YTENcRRaNIeZNs6hKUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfiU1p9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1EVN+mQ5R/a5EGRZyA4TrH7zmCdcDhzPMCVO84jmEWE=;
	b=QfiU1p9M9jP9Y8qCuctGh1PlxFPI8S634rh2tcMrni+emc0ZwOZkEs7acmX9d/XJCxBmZa
	P55cwX4wWI0YJh236DkfdGkwrxQ2TyQnKXOh93X9ou+AFvn1lk0qZRzonTooIguPIt8+fz
	2di6ghxh0hUN7dWypAUNmeMkYEPDQQ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Wx5MTTpXMt-a2WzG1kxkig-1; Mon, 21 Jul 2025 11:23:16 -0400
X-MC-Unique: Wx5MTTpXMt-a2WzG1kxkig-1
X-Mimecast-MFC-AGG-ID: Wx5MTTpXMt-a2WzG1kxkig_1753111395
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a579058758so1760316f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111395; x=1753716195;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EVN+mQ5R/a5EGRZyA4TrH7zmCdcDhzPMCVO84jmEWE=;
        b=V1e4oOHXw7pjmnvdzEAsdoSV/j2SzPZq3MWhB0S6wGNFicA8iwHFZgc0GACPWRbAEY
         N/O6B7a24kwOudyZytRBdxZBrrVI6wSLMI+te6fLWa4yMiwCiE4OGnnHKk4zllyNHwTP
         XK6G17gN/sjEPloGJKV/PiLqPCREM9oev7z4IKkoFGeznBTU9km8i9Xa/vUp4UOqnbPj
         5ZTuLldDeeO1Cne8XuoyQGbJD36l+1DqVNE31Col1oJ33nVER1+GEMINLpKg7rjkiRmb
         actWE6ualS3ZDkIF1kwbJ/JSUWzsrYlINChSAUHF5JbkxBjtTxVAbQQf5ZpZPcy9rAVf
         kQ3A==
X-Gm-Message-State: AOJu0YzZb9OgsCpt1+noGIMjeCbE2RvV60r2fpePnU4jm/OfAVMfx622
	wHV14gPrUlCtgOlQ8uh9Ow0B+nTfkeczJoK2G6OJPx7+DQ8COOIJdvCS4IEgh6ADNGK2emwzXNq
	qqN5awcfJJVjwRkqDRNbdRjeazaZmk7Lih9dYugtNcKnc3FwS/cRaTfBSCbVikz+xHg==
X-Gm-Gg: ASbGncuO9jBBghFCFw6262I4uZfLGqqsP2WzCckmqR2my7FKRaZ80tNqJECB1xzYbHZ
	8y/VOaceBMKnMmvTjaTA3o9+QCiIyIdfdR60nEYIqCDVZaOngPUx/M3nh4wsPiuSZhG5i2qPnVC
	jKqdlY5M75SmLNPgJfArKGxUXVwmKL/zNIgnrVKTS6ARtoiJiiKiUJ12Z4yME6zL61KrNIok8nC
	nt/jn21ubTBXUtxp2hBvr3qJLbyKSyojs2i+e3UX0xxQAGszkO519F3Vq+xereUFMCYaZyqOlxT
	17eVX9+GJRQgsxMhw6CfX0i4zF27tTrRS/wcITNZY/KHnqeFldvGWkvMuRAmM97Npw==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr18160906f8f.9.1753111395084;
        Mon, 21 Jul 2025 08:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4jpDBvB8ticrivjLowJPy7FbEU+blN23cr0WoEPnxY8sSdfnn3cHYyANAFCoWuFvzaB4h7w==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr18160886f8f.9.1753111394637;
        Mon, 21 Jul 2025 08:23:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2548fsm10797741f8f.7.2025.07.21.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:23:14 -0700 (PDT)
Message-ID: <78c60d531c8ec862a0fe5e6ef4a40c1f65fe6544.camel@redhat.com>
Subject: Re: [PATCH v4 10/14] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 17:23:12 +0200
In-Reply-To: <20250721150143.sl2MIKSi@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-11-gmonaco@redhat.com>
	 <20250721150143.sl2MIKSi@linutronix.de>
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



On Mon, 2025-07-21 at 17:01 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:20AM +0200, Gabriele Monaco wrote:
> > DA monitor can be accessed from multiple cores simultaneously, this
> > is
> > likely, for instance when dealing with per-task monitors reacting
> > on
> > events that do not always occur on the CPU where the task is
> > running.
> > This can cause race conditions where two events change the next
> > state
> > and we see inconsistent values. E.g.:
> >=20
> > =C2=A0 [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
> > =C2=A0 [63] event_srs: 27: sleepable x sched_set_state_sleepable ->
> > sleepable
> > =C2=A0 [63] error_srs: 27: event sched_switch_suspend not expected in
> > the state running
> >=20
> > In this case the monitor fails because the event on CPU 62 wins
> > against
> > the one on CPU 63, although the correct state should have been
> > sleepable, since the task get suspended.
> >=20
> > Detect if the current state was modified by using try_cmpxchg while
> > storing the next value. If it was, try again reading the current
> > state.
> > After a maximum number of failed retries, react by calling a
> > special
> > tracepoint, print on the console and reset the monitor.
> >=20
> > Remove the functions da_monitor_curr_state() and
> > da_monitor_set_state()
> > as they only hide the underlying implementation in this case.
> >=20
> > Monitors where this type of condition can occur must be able to
> > account
> > for racing events in any possible order, as we cannot know the
> > winner.
> >=20
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> >=20
> > =C2=A0static inline
> > bool										\
> > =C2=A0da_event_##name(struct da_monitor *da_mon, enum events_##name
> > event)				\
> > =C2=A0{							=09
> > 				\
> > -	type curr_state =3D
> > da_monitor_curr_state_##name(da_mon);					\
> > -	type next_state =3D model_get_next_state_##name(curr_state,
> > event);			\
> > -
> > 												\
> > -	if (next_state !=3D INVALID_STATE)
> > {							\
> > -		da_monitor_set_state_##name(da_mon,
> > next_state);				\
> > -
> > 												\
> > -
> > 		trace_event_##name(model_get_state_name_##name(curr_state),			\
> > -				=C2=A0=C2=A0
> > model_get_event_name_##name(event),				\
> > -				=C2=A0=C2=A0
> > model_get_state_name_##name(next_state),			\
> > -				=C2=A0=C2=A0
> > model_is_final_state_##name(next_state));			\
> > -
> > 												\
> > -		return
> > true;									\
> > +	enum states_##name curr_state,
> > next_state;						\
> > +							=09
> > 				\
> > +	curr_state =3D READ_ONCE(da_mon-
> > >curr_state);						\
> > +	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> > {					\
> > +		next_state =3D
> > model_get_next_state_##name(curr_state, event);			\
> > +		if (next_state =3D=3D INVALID_STATE)
> > {						\
> > +			cond_react_##name(curr_state,
> > event);					\
> > +			trace_error_##name(model_get_state_name_##
> > name(curr_state),		\
> > +					=C2=A0=C2=A0
> > model_get_event_name_##name(event));			\
> > +			return
> > false;								\
> > +		}					=09
> > 				\
> > +		if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state))) {	\
> > +			trace_event_##name(model_get_state_name_##
> > name(curr_state),		\
> > +					=C2=A0=C2=A0
> > model_get_event_name_##name(event),			\
> > +					=C2=A0=C2=A0
> > model_get_state_name_##name(next_state),		\
> > +					=C2=A0=C2=A0
> > model_is_final_state_##name(next_state));		\
> > +			return
> > true;								\
> > +		}					=09
> > 				\
> > =C2=A0	}						=09
> > 				\
> > =C2=A0							=09
> > 				\
> > -	cond_react_##name(curr_state,
> > event);							\
> > -
> > 												\
> > -
> > 	trace_error_##name(model_get_state_name_##name(curr_state),				\
> > -			=C2=A0=C2=A0
> > model_get_event_name_##name(event));					\
> > -
> > 												\
> > +	trace_rv_retries_error(#name,
> > smp_processor_id());					\
> > +	pr_warn("rv: "
> > __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
> > +		" retries reached, resetting monitor %s",
> > #name);				\
>=20
> smp_processor_id() requires preemption to be disabled.
>=20
> At the moment, trace point handler is called with preemption
> disabled, so
> we are fine. But there is plan to change that:
> https://lore.kernel.org/lkml/20241206120709.736f943e@gandalf.local.home/T=
/#u
>=20
> Perhaps use get_cpu() and put_cpu() instead?

Mmh, then I'd need to execute them only if the tracepoint is enabled,
I'm not sure it's worth the effort..
I wanted to avoid creating two different tracepoints (implicit and id),
but I might have to. The CPU is rarely needed there since (for now)
per-cpu monitors assume event cpu and monitor cpu are the same.

I'll have a thought about it, thanks for pointing it out!

Gabriele



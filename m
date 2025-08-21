Return-Path: <linux-kernel+bounces-779341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311FB2F2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2705E64BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C612EB873;
	Thu, 21 Aug 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLgui+I5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F42EB5CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766154; cv=none; b=X9c09ncsNkbH/E7kNdm/KFkFB/1IXf1zL8yk5bk5m6+httq2YYGcGA63Vlmft+Labjk2xnujanPq4z6/wmiGHWfwnvJrjIIX3U7X22wIOEDEGiiifWU53tYWjSzJPaTyMcEIggwkJJ1fKdJV0bJ+8shFVaoL0BEK9sRHwkxLcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766154; c=relaxed/simple;
	bh=dY5H1u760ZHjTxgBCLEDTMjKy06liKt+QJAnkGh4Fo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DF051xRiur3S1wmjgiN6QNSAPTP2aPQoMJObTEDn1kTdlPVrOEzmEBG16r8PT8i7lSNGPdk+Ogj8kYvJ1QyumNblz5Cwn6EU9m4ivng21XJd/CWQACzc1fkKMmkatzq5Bva4OWhlf9ESHqV/DHV4Rpkz/eMpT7F+p8I3KvXjzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLgui+I5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JTKLkckZPZY51u66Qc8K7yv1S+qlB6sfl+ajIB2L21c=;
	b=XLgui+I5QpvixKgHRWLbG98C+DtUvSSccV0I77egAsmAiX7gMWp3jVKgESJ9rD502+/8Pr
	hF37Dv/F3/litwMJa9c0L+SNaavOKepFcAz1SPyRHfSXB4ZiEIIxzT3ijybcP7V96b0/br
	d6NjhVY/ThnRW8Ot04T2K1qYM+DQOHc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-B-8Us6HFNjyclhL6CgTDiA-1; Thu, 21 Aug 2025 04:49:10 -0400
X-MC-Unique: B-8Us6HFNjyclhL6CgTDiA-1
X-Mimecast-MFC-AGG-ID: B-8Us6HFNjyclhL6CgTDiA_1755766150
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f57ef93so16360276d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766150; x=1756370950;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTKLkckZPZY51u66Qc8K7yv1S+qlB6sfl+ajIB2L21c=;
        b=CcASznEo8EiilNfg0jEYrt0A510ZWTR16FJcFssJS5Qdr2mjyQNbUIZVmb4nQ8o8uo
         9a0nJ0JnUKKO2jDQon8E4DTdyosK8ll6+64Pl3h0nJ+XZrRuVZZb9mUGZtf5c/igS3bj
         g8bSGNHP4rR/LgpbQfbFkANurApCxJx9R3tnpzAAQE2njt3lqK9NvwpOSVue538D1hTQ
         WRQPZrT/aTlKsrY0APEnB8PU2rxYBTmIeYVbagvfVcZEjq2qlJMXhZptkMZGN16WWzRn
         /e6YGqShrZPjl/G1rhdvD/rHWxTpWzdn19AhnOf42n0QYdCa1jYP8uWCljrG6VL91/WQ
         qgVA==
X-Gm-Message-State: AOJu0Yxo026yIGjgIJyX3Tdxmw7LCBo1ACxi3WWftYn54XmlCM3o3/qQ
	AEeDrL2E3sqwXG7pc7CmQB1+7LxYSIrDuLzVFhNgqz9Ea3KrNYRcjAmbqIVAhwURcS2canVn0nx
	EEo4d7jwWJNlZ2WudbIKSKnvMsAvcTglh4L8oxBiTq/Uza4UtVugIkyqNOPD5b0fsCl/k7Z6Dz2
	ZQ
X-Gm-Gg: ASbGnctrTMYf/TuFcJgh3HIfovWRrVQFIl2B6SH7OhscZnfItInYsMnqZR6UzlajWRy
	NDJma0ZBDEOHNfMpBA/LUb4zRsGmqAvE46RatwdPoR/Usw9z5EdQCZI3DfpCvV2bUeJxRq/Rscn
	uXZuAEw1hh63x0WbCXzxJXJSsdB1YKHntyZj5vs2bUzPbGpKFOux8Uv9oV/02MrZz6giMAkf6rv
	axcKdm+Km+GqzAvGmzXgHO7EPxaoqBReNuwQpZJoFOdMPTBlQrESat58+UU6tXF/o+aN42xM4Au
	/QkFFoKYhO1/gn9THrgTL26YnqUJSNLkKCPtk9+WuTKa1DpUm8Yl/Sutm/i1EHgM9g==
X-Received: by 2002:a05:6214:262c:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d89015a8dmr13934046d6.46.1755766149730;
        Thu, 21 Aug 2025 01:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF55/vnQ1tNaDKPCQMGQodL9V8M4CDiEKuWbmEd0QOQ3dzp5Pd6zW34uVKscpzQ5WOnG93Cg==
X-Received: by 2002:a05:6214:262c:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d89015a8dmr13933856d6.46.1755766149083;
        Thu, 21 Aug 2025 01:49:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f4d7sm100681526d6.2.2025.08.21.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:49:08 -0700 (PDT)
Message-ID: <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 10:49:05 +0200
In-Reply-To: <20250821081405.RQhrWVKp@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-2-gmonaco@redhat.com>
	 <20250821081405.RQhrWVKp@linutronix.de>
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

On Thu, 2025-08-21 at 10:14 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:07:53PM +0200, Gabriele Monaco wrote:
> > The da_monitor helper functions are generated from macros of the
> > type:
> >
> > DECLARE_DA_FUNCTION(name, type) \
> > static void da_func_x_##name(type arg) {} \
> > static void da_func_y_##name(type arg) {} \
> >
> > This is good to minimise code duplication but the long macros made
> > of skipped end of lines is rather hard to parse. Since functions
> > are static, the advantage of naming them differently for each
> > monitor is minimal.
> >
> > Refactor the da_monitor.h file to minimise macros, instead of
> > declaring functions from macros, we simply declare them with the
> > same name for all monitors (e.g. da_func_x) and for any remaining
> > reference to the monitor name (e.g. tracepoints, enums, global
> > variables) we use the CONCATENATE macro.

...
> > +#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
> > +#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
> > +#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
> > +#define events CONCATENATE(events_, MONITOR_NAME)
> > +#define states CONCATENATE(states_, MONITOR_NAME)
>
> I think these macros make it harder to read the code. E.g. it is not
> obvious what is "events" in "enum events event".
>
> How about renaming these to be the same for all monitors, and get rid
> of these 4 macros?
>
> Something like
>
> 	enum states_wip -> enum da_states
> 	state_max_wip=C2=A0=C2=A0 -> da_state_max
> 	etc
>
> Just my preference, of course. You probably have your reasons for
> doing it this way?

I think the reason was mostly laziness / wish to change less things.
This would require to change a bit more in each monitor's header and
rvgen, but since I'm already changing those, it should be no problem.

I assume the compiler would be just fine with the change and I don't see
a use-case where one would grab multiple definitions of those enums to
get a clash.

Good point, I'll look into that.

> > +/*
> > + * model_get_state_name - return the (string) name of the given
> > state
> > + */
> > +static char *model_get_state_name(enum states state)
> > +{
> > +	if ((state < 0) || (state >=3D STATE_MAX))
> > +		return "INVALID";
>
> Just notice that this probably should be
> 	if (BUG_ON((state < 0) || (state >=3D STATE_MAX)))
>
> You shouldn't do it in this patch of course. I just want to note it
> down.

Mmh, I'm not quite sure about this one, sure it's not a good thing when
we try to get an invalid state/event, but isn't BUG a bit too much here?
We're handling things gracefully so the kernel is not broken (although
rv likely is).

If you really think we should note that, what about just WARN/WARN_ONCE ?

> > index 17fa4f6e5ea6..bc02334aa8be 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -13,97 +13,102 @@
> > =C2=A0
> > =C2=A0#include <rv/automata.h>
> > =C2=A0#include <linux/rv.h>
> > +#include <linux/stringify.h>
> > =C2=A0#include <linux/bug.h>
> > =C2=A0#include <linux/sched.h>
> > =C2=A0
> > +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> > +#define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
>
> These macros as well. Should we rename the monitors to be the same
> and get rid of the macros?
>
> I see you took this RV_MONITOR_NAME idea from LTL. But I'm starting
> to wonder if this is really a good idea.
>
> What do you think?

Same laziness, I'll look into that!
They are static so they won't ever be defined together, nor I see a
reason for them not to be static.

One thing to note is that by using the same names everywhere, the
symbols won't be as accessible from debug tools (gdb/BPF or whatever),
I'm not sure that's really an issue, but it's the only downside coming
to my mind.

> > +#if RV_MON_TYPE =3D=3D RV_MON_GLOBAL || RV_MON_TYPE =3D=3D RV_MON_PER_=
CPU
> > +
> > +static inline bool
> > +da_event(struct da_monitor *da_mon, enum events event)
> > +{
> > +	enum states curr_state, next_state;
> > +
> > +	curr_state =3D READ_ONCE(da_mon->curr_state);
> > +	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> > +		next_state =3D model_get_next_state(curr_state,
> > event);
> > +		if (next_state =3D=3D INVALID_STATE) {
> > +			cond_react(curr_state, event);
> > +			CONCATENATE(trace_error_,
> > MONITOR_NAME)(model_get_state_name(curr_state),
> > +					=C2=A0=C2=A0
> > model_get_event_name(event));
> > +			return false;
> > +		}
> > +		if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state))) {
> > +			CONCATENATE(trace_event_,
> > MONITOR_NAME)(model_get_state_name(curr_state),
> > +					=C2=A0=C2=A0
> > model_get_event_name(event),
> > +					=C2=A0=C2=A0
> > model_get_state_name(next_state),
> > +					=C2=A0=C2=A0
> > model_is_final_state(next_state));
> > +			return true;
> > +		}
> > +	}
> > +
> > +	trace_rv_retries_error(__stringify(MONITOR_NAME),
> > model_get_event_name(event));
> > +	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
> > +		" retries reached for event %s, resetting monitor
> > %s",
> > +		model_get_event_name(event),
> > __stringify(MONITOR_NAME));
> > +	return false;
> > +}
>
> You have two da_event(), which is mostly similar, except the
> function's signature and the trace event. Would it be sane to unify
> them, and only putting the differences in #ifdef?
>
> Perhaps something like:
>
> #if RV_MON_TYPE =3D=3D RV_MON_GLOBAL || RV_MON_TYPE =3D=3D RV_MON_PER_CPU
>
> typedef struct {} monitor_target;
>
> static void da_trace_event(struct da_monitor *da_mon, monitor_target
> target,
> 			=C2=A0=C2=A0 enum events event, enum states curr, enum
> states next)
> {
> 	CONCATENATE(trace_event_,
> MONITOR_NAME)(model_get_state_name(curr_state),
> 		=C2=A0=C2=A0=C2=A0 model_get_event_name(event),
> 		=C2=A0=C2=A0=C2=A0 model_get_state_name(next_state),
> 		=C2=A0=C2=A0=C2=A0 model_is_final_state(next_state));
> }
>
> #elif RV_MON_TYPE =3D=3D RV_MON_PER_TASK
>
> typedef struct task_struct *monitor_target;
>
> static void da_trace_event(struct da_monitor *da_mon, struct
> task_struct *task,
> 			=C2=A0=C2=A0 enum events event, enum states curr, enum
> states next)
> {
> 	CONCATENATE(trace_event_, MONITOR_NAME)(task->pid,
> 		=C2=A0=C2=A0 model_get_state_name(curr_state),
> 		=C2=A0=C2=A0 model_get_event_name(event),
> 		=C2=A0=C2=A0 model_get_state_name(next_state),
> 		=C2=A0=C2=A0 model_is_final_state(next_state));
> }
>
> #endif
>
> static inline bool
> da_event(struct da_monitor *da_mon, monitor_target target, enum
> events event)
> {
> 	enum states curr_state, next_state;
>
> 	curr_state =3D READ_ONCE(da_mon->curr_state);
> 	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> 		next_state =3D model_get_next_state(curr_state,
> event);
> 		if (next_state =3D=3D INVALID_STATE) {
> 			cond_react(curr_state, event);
> 			da_trace_event(da_mon, event, target,
> curr_state, next_state);
> 			return false;
> 		}
> 		if (likely(try_cmpxchg(&da_mon->curr_state,
> &curr_state, next_state))) {
> 			da_trace_error(...);
> 			return true;
> 		}
> 	}
>
> 	trace_rv_retries_error(__stringify(MONITOR_NAME),
> model_get_event_name(event));
> 	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
> 		" retries reached for event %s, resetting monitor
> %s",
> 		model_get_event_name(event),
> __stringify(MONITOR_NAME));
> 	return false;
> }
>
> Same for the other functions.

Mmh, that's been bugging me throughout every change, but I'm not sure
it's that simple, implicit monitors don't have a target at all, so all
function prototypes are different because that needs to propagate.
Now that I think about it, it may not be a big deal not to pass the
target at all and retrieve it from the da_mon (that's just pointer
arithmetic the compiler might even optimise out).

I'm not sure that would be as simple if per-cpu monitors stopped being
implicit (like they are in your patch: they do have a target), but that
may never happen.

I'll give it a shot, thanks for pointing that out!

Thanks again,
Gabriele



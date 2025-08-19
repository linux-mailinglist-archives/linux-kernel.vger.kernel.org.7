Return-Path: <linux-kernel+bounces-775423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80AB2BF03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11380565326
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2D322A2C;
	Tue, 19 Aug 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLlkRvPg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459E218EB1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599673; cv=none; b=X5P3WsKoKwdKXzdh53YgRiZxB2n1c4yPZVi1+6IMxKCGS8XxacclMgKmDSlZgXhT0Uj6ykll8P8Ygt/ychVe5rk+pYT7dwn9QaC4Z3ql3fAmyCrgqGIjMhJhuPMr2xVKZ9A8rDZMvI6pbjaWeGgxvwUJE6L1kw92WNL0bwewlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599673; c=relaxed/simple;
	bh=yb50+qHbFzMZRakkqa1vx69CPbp53EeOLA/6b4lNvAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAMZqrOwHJ2xVYA9HFdGNbpbJw6Bos8H2ZcEmx7oGUSFM45gKIM+/vyTqNpvvTCJaznbwh2putapMobVZ4GPqVwImbUOZjPBJMB3SmNTX4OPvk1IfyiDPZETxYGUU4YbRJ1Vc2Y4e3nCD0pKw3KS5cpuIDSHzUwhnnTCadjr09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLlkRvPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755599670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gnf9n/lvCgk4Dmu8/IiYGJ+sE0rdjFg2NpPd38mVnIg=;
	b=MLlkRvPgogAVlOhLi7i1glRkH/jyW1k/BgwrjMGVdH8Q9qnIFudVu6l1foeRSmw04GLmT2
	+cN7UG8o6B6k9IKXsPnGQiJU6xL3jvaZvWp/kupXPP3z+5ybscCHcZ7ecRx5T01CMFJi/u
	GhaBNaY/+Fk+ICvqNATLVovvOBiGyis=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Iq5fRdxrP962JPjFyQPoqA-1; Tue, 19 Aug 2025 06:34:28 -0400
X-MC-Unique: Iq5fRdxrP962JPjFyQPoqA-1
X-Mimecast-MFC-AGG-ID: Iq5fRdxrP962JPjFyQPoqA_1755599668
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86f8f27e1so1620821285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599668; x=1756204468;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnf9n/lvCgk4Dmu8/IiYGJ+sE0rdjFg2NpPd38mVnIg=;
        b=IUzbg/H48b8wrRXiyDmKR3yweYbWGeBVF3K+/lI1hAf8oABSwVSdjYlIvFPXwo+sRe
         OuN4gnAt5mqK6rZkJJAIQDklbI0Hj+W0uyti6C85i65GFqE+HtwNy3OMdmDRzqoWezOC
         u5bXW7PuLtzzJnZBjqzV2dm69r+pPfDEGFdnevmU6JMmCLD5nsR98MvUzRmTkd9OYleN
         bRWp9dwPqJZOUtf5J6icCzlTrAEAJmFs5K9l0U28DYsQP00XP1q26gjLv/oNYa2A02pC
         ITdnvqIi7DF9OUotWBr2cZHXnEKXquraaVDApnDvfOa+/HZ4/RMxUgh+sYGZSYJHT86g
         BOyA==
X-Gm-Message-State: AOJu0Yx29wxT7RLYtUT4LgSytatF4q35yzWz5Jc82vQKWcnW963LjuSt
	PSraO32ciCZ7BfQXquKkiT5blxQZKdOzxLDCfq47Fu6hy4LPpj4N+nOIriCVIDZOl1g0/dDgse5
	x3rgQc8ISdBecSMbsTGq6//hVckPEEXADLrPyaAv1jveD0jFzRTk7cG6q/l8GuAGQ1A==
X-Gm-Gg: ASbGncuCxKe/GXOgnxomtqgFpXD6Oj6slMAn6HRbRIDGdzue5mdn+xlTJQy8uRraztz
	3E5vzBzkxg2DPMU24KJnliuxyXKO+QdkgI+8Hl+XGpUrxKEyBO44jNq8wzHijmujmcpLBuUW5a7
	4GuOkHQIYf0acxUO48aZALRzxyJ0L9ILbc7ToeAcOLMH44kg4d7hDEMsaa3sGbUU1xKrzY2OkhQ
	IaIQgMLbOD6FxX9RCYLF+KssZJFSs963RvzslWlvn8P0iYCZVasKE1Y7bsPqIe2MJRCIboaoihW
	BivdWWSsCkiLclnP6zhVMWYayufB9YxXBC1/b05sIuhXZE6iFcKxpfIRX143/qxuCA==
X-Received: by 2002:a05:620a:1993:b0:7de:d9aa:8b47 with SMTP id af79cd13be357-7e9f4b31df5mr166978085a.18.1755599668221;
        Tue, 19 Aug 2025 03:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH6ombpOOxW7aZAm1rgMXKP1W9YllRE7QjE/iqNYwSVum6jldYZ6xUMyzVTW3X75hHoekc+A==
X-Received: by 2002:a05:620a:1993:b0:7de:d9aa:8b47 with SMTP id af79cd13be357-7e9f4b31df5mr166975985a.18.1755599667751;
        Tue, 19 Aug 2025 03:34:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9077520sm67530886d6.21.2025.08.19.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:34:27 -0700 (PDT)
Message-ID: <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-trace-kernel@vger.kernel.org, Nam Cao	 <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli	 <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur	 <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:34:23 +0200
In-Reply-To: <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-15-gmonaco@redhat.com>
	 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
	 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
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



On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > Hi!
> >=20
> > On 14/08/25 17:08, Gabriele Monaco wrote:
> > > Add the following tracepoints:
> > >=20
> > > * sched_dl_throttle(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline entity is throttled
> > > * sched_dl_replenish(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline entity's runtime is repleni=
shed
> > > * sched_dl_server_start(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline server is started
> > > * sched_dl_server_stop(dl, hard):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline server is stopped (hard) or=
 put to
> > > idle
> > > =C2=A0=C2=A0=C2=A0 waiting for the next period (!hard)
> > >=20
> > > Those tracepoints can be useful to validate the deadline
> > > scheduler with
> > > RV and are not exported to tracefs.
> > >=20
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > > ---
> > > =C2=A0include/trace/events/sched.h | 55
> > > ++++++++++++++++++++++++++++++++++++
> > > =C2=A0kernel/sched/deadline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8=
 ++++++
> > > =C2=A02 files changed, 63 insertions(+)
> > >=20
> > > diff --git a/include/trace/events/sched.h
> > > b/include/trace/events/sched.h
> > > index 7b2645b50e78..f34cc1dc4a13 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
> > > =C2=A0			__entry->oldprio, __entry->newprio)
> > > =C2=A0);
> > > =C2=A0
> > > +/*
> > > +DECLARE_EVENT_CLASS(sched_dl_template,
> > > +
> > > +	TP_PROTO(struct sched_dl_entity *dl),
> > > +
> > > +	TP_ARGS(dl),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field(=C2=A0 struct task_struct
> > > *,	tsk		)
> > > +		__string( comm,		dl->dl_server ?
> > > "server" : container_of(dl, struct task_struct, dl)-
> > > >comm	)
> > > +		__field(=C2=A0 pid_t,	pid		)
> > > +		__field(=C2=A0
> > > s64,		runtime		)
> > > +		__field(=C2=A0 u64,		deadline	)
> > > +		__field(=C2=A0 int,		dl_yielded	)
> >=20
> > I wonder if, while we are at it, we want to print all the other
> > fields
> > as well (they might turn out to be useful). That would be
> >=20
> > =C2=A0.:: static (easier to retrieve with just a trace)
> > =C2=A0- dl_runtime
> > =C2=A0- dl_deadline
> > =C2=A0- dl_period
> >=20
> > =C2=A0.:: behaviour (RECLAIM)
> > =C2=A0- flags
> >=20
> > =C2=A0.:: state
> > =C2=A0- dl_ bool flags in addition to dl_yielded
>=20
> All these things are used as _tp(). That means they don't have trace
> buffer entries ever, why fill out fields?
>=20

Right, that is a relic of the way I put it initially, this whole thing
is commented out (which is indeed confusing and barely noticeable in
the patch).
The tracepoints are in fact not exported to the tracefs and do not use
the print format.

I should have removed this, the real ones are at the bottom of the
file.

>=20
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__assign_str(comm);
> > > +		__entry->pid		=3D dl->dl_server ? -1 :
> > > container_of(dl, struct task_struct, dl)->pid;
> > > +		__entry->runtime	=3D dl->runtime;
> > > +		__entry->deadline	=3D dl->deadline;
> > > +		__entry->dl_yielded	=3D dl->dl_yielded;
> > > +	),
> > > +
> > > +	TP_printk("comm=3D%s pid=3D%d runtime=3D%lld deadline=3D%lld
> > > yielded=3D%d",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^
> > 							llu ?
> >=20

As above, this should all go away.

> > > +			__get_str(comm), __entry->pid,
> > > +			__entry->runtime, __entry->deadline,
> > > +			__entry->dl_yielded)
> > > +);
> >=20
> > ...
> >=20
> > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > *rq, struct sched_dl_entity *dl_se, s64
> > > =C2=A0
> > > =C2=A0throttle:
> > > =C2=A0	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > +		trace_sched_dl_throttle_tp(dl_se);
> > > =C2=A0		dl_se->dl_throttled =3D 1;
> >=20
> > I believe we also need to trace the dl_check_constrained_dl()
> > throttle, please take a look.

Probably yes, strangely I couldn't see failures without it, but it may
be down to my test setup. I'm going to have a look.

> > Also - we discussed this point a little already offline - but I
> > still wonder if we have to do anything special for dl-server defer.
> > Those entities are started as throttled until 0-lag, so maybe we
> > should still trace them explicitly as so?

The naming might need a bit of a consistency check here, but for the
monitor, the server is running, armed or preempted. Before the 0-lag,
it will never be running, so it will stay as armed (fair tasks running)
or preempted (rt tasks running).

armed and preempted have the _throttled version just to indicate an
explicit throttle event occurred.

We might want to start it in the armed_throttled if we are really
guaranteed not to see a throttle event, but I think that would
complicate the model considerably.

We could instead validate the 0-lag concept in a separate, server-
specific model.

Does this initial model feel particularly wrong for the server case?

> > In addition, since it's related, maybe we should do something about
> > sched_switch event, that is currently not aware of deadlines,
> > runtimes, etc.

I'm not sure I follow you here, what relation with switch and
runtime/deadline should we enforce?

We don't really force the switch to occur timely after throttling, is
that what you mean?
Or a switch must occur again timely after replenishing?

> As per the whole _tp() thing, you can attach to the actual
> sched_switch tracepoint with a module and read whatever you want.

Yeah I believe Juri referred to model constraints on the already
existing events rather than new tracepoints here.

Thanks both,
Gabriele



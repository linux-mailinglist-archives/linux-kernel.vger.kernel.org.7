Return-Path: <linux-kernel+bounces-775320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D5B2BDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA76E5E578A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16231AF2C;
	Tue, 19 Aug 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFAfhgW/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E731AF39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596890; cv=none; b=WteHDy3XRf0MO0IfH3nEbJS9VBQL+xnQKGqgD8SqwwUE0hNPo0tUmRJl2FSoOS4nVn7xPQNE70KKAyBTwTvUpuA3iJhVbj0ly3m63wS0yyC6fw6vg9GQ4+/YVeN5xpHL7V3D0TQFwa2+phFtTxaJCq7wWvDoIW9bIX4ZaNYMyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596890; c=relaxed/simple;
	bh=lzHWcPMtDmUlEEpKZJ2XIxqRj44dyvr6NgzpZfll9GA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOXr6Z+n/hlDVp0CsX5l0+vbZNKi8zRwT7rhrQ+r0s/LBjISERU0YLjB1G5b3U9mtwKy0Uug+wPT05A6nMivQYKeMoS8kJUT0wIgo9eic68IvFj8VrTr60eZyx/zgWmT8TRwRrwrB9EPnxxymK9IxMEwvuBZ8jBee8CUhGw0e54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFAfhgW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755596887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEVzF9oT/1hpvRKnmvG6fiGVxNfk5lnVaqv5Ao7G/uk=;
	b=TFAfhgW/KrFffi6X7iD8QVRbhEyEAx8JJlW4IvhmL33t5lYxVrBifQ3IMo5sa71rE/Y7jT
	CBqcapC4DvVRqRHU+kC66vpydJ8IhU8kC163y60w1ZDw9T+r1KNL8J+sQF5SJ45kq5dDdx
	me99BcCNukbkx75/iWacvF5tzVOkIAU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-6uf8-vTxM-KqrD-5gW-v1Q-1; Tue, 19 Aug 2025 05:48:05 -0400
X-MC-Unique: 6uf8-vTxM-KqrD-5gW-v1Q-1
X-Mimecast-MFC-AGG-ID: 6uf8-vTxM-KqrD-5gW-v1Q_1755596885
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-61a2d6c0585so2392167a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596884; x=1756201684;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEVzF9oT/1hpvRKnmvG6fiGVxNfk5lnVaqv5Ao7G/uk=;
        b=lrKCMhiPlW0QKt5SmFgneeDyFD7LGfG+ia47pqm/p3xSoOyzv/54zxZb5lIOqRZ9B7
         pCWZStG/773ZtYyDxeidw6hIZVj5ZhGuXK5pBYxxmD2SpNpscfxePev2BSVEAinFJ/c+
         9mHe7+VIyPZyq0prVPwsO/7FeZSDTzxG2CC61+G24A/eBKuM8oUd7sc3bSZmm+8qo05b
         syXqIsOBC+XfG4qjozE6gUONAvZ5+/aBhggZwE1dT/PrKmXXLzIQsqjYCmgiQSLRT8Ky
         5eaAPR2T/WTITrTjTCtWg8s3dPYfA58pZgn5dEBxwgM6+CNT/p95LIEtdXQ9t4CXzce/
         Nyog==
X-Gm-Message-State: AOJu0YycOPwnAoUEEjoGJzeTqb92fSQXtu3n9jfBSTBBknKlE1wdfrv6
	ilE6zxubHL6rQTN2OH1bMbTTju41XbC+NZCgiCRPk2wQVyPTQw++J2m6NpoqyMF5wnmHEqbMz5m
	QpWLPMezmlh106GPDgCo9fGdqPm6GdCsssf0+yLe3y+ObxgOC1SHxRusoCKh3sZR7ig==
X-Gm-Gg: ASbGncs/NbYa8nWH0eSMDZe7I/zKUiSekfVcg9HKnS4m78lRcQfggE+nUFTuzBVLQhI
	+Ohdq+I8xwCItEqrhepa9xniFk8H0zbThkfiLCpezfkN0cuc4T7iISYKuipYU2jzY/G3IS92nC2
	e7wceH+7J16zWmq26aGfPuZMA+fguM7G/i6mC+MCChCo9ZibYHAkINCya7HIpIPkVDPKFZBgtbp
	6ySY32OepJn+JbVph1Pf7bfyyq1srx2zTWqeCPVosSVQbld862c1PkHEGiQE+wEwtjrUeqFBnUN
	W1/HToFH681MbFuNLNrkQdNvmcS/cxXKKM82ggaRgQOEt81cmETekH0h/3ZJ7UdYVnAY
X-Received: by 2002:a05:6402:3507:b0:618:229d:7076 with SMTP id 4fb4d7f45d1cf-61a7e6d9d08mr1448289a12.6.1755596884457;
        Tue, 19 Aug 2025 02:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGianlZlTSJvsyDj4NNwcANeQwzhSMO1y9TEJ4ddHKW0W9g+a+n0D6BGlgBabUSWl9iNSdJYw==
X-Received: by 2002:a05:6402:3507:b0:618:229d:7076 with SMTP id 4fb4d7f45d1cf-61a7e6d9d08mr1448268a12.6.1755596884025;
        Tue, 19 Aug 2025 02:48:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778cb0sm1399367a12.27.2025.08.19.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:48:03 -0700 (PDT)
Message-ID: <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,  John
 Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 11:48:01 +0200
In-Reply-To: <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
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



On Tue, 2025-08-19 at 11:18 +0200, Juri Lelli wrote:
> Hi!
>=20
> On 14/08/25 17:08, Gabriele Monaco wrote:
>=20
> ...
>=20
> > +/*
> > + * ha_monitor_init_env - setup timer and reset all environment
> > + *
> > + * Called from a hook in the DA start functions, it supplies the
> > da_mon
> > + * corresponding to the current ha_mon.
> > + * Not all hybrid automata require the timer, still set it for
> > simplicity.
> > + */
> > +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> > +{
> > +	struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> > +
> > +	ha_monitor_reset_all_stored(ha_mon);
> > +	if (unlikely(!ha_mon->timer.base))
> > +		hrtimer_setup(&ha_mon->timer,
> > ha_monitor_timer_callback,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +}
>=20
> ...
>=20
> > +/*
> > + * Helper functions to handle the monitor timer.
> > + * Not all monitors require a timer, in such case the timer will
> > be set up but
> > + * never armed.
> > + * Timers start since the last reset of the supplied env or from
> > now if env is
> > + * not an environment variable. If env was not initialised no
> > timer starts.
> > + * Timers can expire on any CPU unless the monitor is per-cpu,
> > + * where we assume every event occurs on the local CPU.
> > + */
> > +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon,
> > enum envs env,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire)
> > +{
> > +	int mode =3D HRTIMER_MODE_REL;
> > +	u64 passed =3D 0;
> > +
> > +	if (env >=3D 0 && env < ENV_MAX_STORED) {
> > +		if (ha_monitor_env_invalid(ha_mon, env))
> > +			return;
> > +		passed =3D ha_get_env(ha_mon, env);
> > +	}
> > +	if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
> > +		mode |=3D HRTIMER_MODE_PINNED;
> > +	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire -
> > passed), mode);
> > +}
>=20
> Also, my only concern with the usage of per-task timers is that
> reprogramming add overhead, so I wonder if this gets noticeable when
> running some kind of performance sensitive workload in production (as
> it was reported for dl-server). Did you test such a case?

That's a good point, I need to check the actual overhead..

One thing to note is that this timer is used only on state constraints,
one could write roughly the same monitor like this:

  +------------------------------------------+
  |                 enqueued                 |
  +------------------------------------------+
    |
    | sched_switch_in;clk < threshold_jiffies
    v

or like this:

  +------------------------------------------+
  |                 enqueued                 |
  |         clk < threshold_jiffies          |
  +------------------------------------------+
    |
    | sched_switch_in
    v

the first won't fail as soon as the threshold passes, but will
eventually fail when the sched_switch_in event occurs. This won't use a
timer at all (well, mostly, some calls are still made to keep the code
general, I could improve that if it matters).

Depending on the monitor, the first option could be a lower overhead
yet valid alternative to the second, if it's guaranteed sched_switch_in
will eventually come and reaction latency isn't an issue.

> Does this also need to be _HARD on RT for the monitor to work?

That might be something we want configurable actually.. I assume the
more aggressive the timer is, the more overhead it will have on the
system.
Some monitors might be fine with a bit of latency.

For example in the deadline case, I believe, the monitor is not
supposed to fix anything, but merely report violations. So we don't
really care to react on time, but to react at all.

I'm going to assess the overhead and see how to offer some more
configurability.

Thanks,
Gabriele



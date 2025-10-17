Return-Path: <linux-kernel+bounces-857762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29195BE7E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44ACA4FFA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214132BE64F;
	Fri, 17 Oct 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9Ld3jin"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035F2DAFB1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694507; cv=none; b=JTLDdDoNte3xzgkal4kotKm3lHLRQ0U1WzBgzFv+CkeujH2j/WK8MPCBOO7i/FkyNdedcMixc2Wz06S+aqBCJiRE7Pe1wHEKI1dWty4yXIiHoaLTg6B/P/x8hE6MPACIJeWS1RuRn/h5LrtEP4uul8FtW3txPiN/kiGGbUL6zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694507; c=relaxed/simple;
	bh=c/QEwFR46hw7kFeEDDNiT8FB6OXzCNcq5coGdcFCKag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYt+OcePe8hFjnbF9T8aA1KA5GXnlVafLspifsF9vQCxdl632LpiC33yvSbrSjYVN3eP+yNtjS0IqsqRQdn6t5XtHO0OTUkqSAwjxvBVl0z6YBkFclyVrWMfxLyqsYDgVVJ8kYVg6NQy26tIxByEpSxipwCfFHBk53rNXOKTiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9Ld3jin; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760694504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPZVdwYVMXmvdgETlc0kkuddcTksc1mbBYNE4QMxEEo=;
	b=E9Ld3jinyzlnDykvvA9c4oILAuoXzVANlafHY2MqJ/JcpGaAug+5ZwuUST+7W6o8+1BKIT
	8gGs+ak182FaHeDVre8WvpLYlIUpHITZoe/albKoBYrY/67C+sPT6NuviFdZyFsFbi9/VR
	UjKXDwf0lf0vZH1RabwuYIeUWexl+4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-_A-yDUNlPqa0FgYZ4FvSVw-1; Fri, 17 Oct 2025 05:48:22 -0400
X-MC-Unique: _A-yDUNlPqa0FgYZ4FvSVw-1
X-Mimecast-MFC-AGG-ID: _A-yDUNlPqa0FgYZ4FvSVw_1760694501
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426ff8fa3a6so1274536f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694501; x=1761299301;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPZVdwYVMXmvdgETlc0kkuddcTksc1mbBYNE4QMxEEo=;
        b=RdP/+QABnlRvw9GZBpA04K/JaZTPACyS/4RuvCssWtHBNApb21FI5SS7x++/RR7O0L
         Hfa3fmMLvIFLy3h0aYuRth4zvdZxIqGBG2wtr8Q2srjIFh6bnmT+qAf8cmElAzfuJiNz
         ugmbWVKU6Ju6JGfD28hiQybG/Huew1RBSzewVkz9lcqKXUxmCP/H1dEs8lEUMIyao2Mg
         JYSWfGSxlMn5IHNclUng6KbdffKG7IhhNBROINc6x7d708kh5aBAZohWg/Ih8qc1O8Ik
         161YrTdX5ZlN+s4XbqVGwgA1Uvx6de3u6d0PgxUN8/oLTk8rIgjyGsvHG5yQ+iMJI4vY
         E9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsr8CoLj0vMGRvguJaG3cE6FlivsDdM6AqJdn54Avby3PvGID0aeExSb5dHPuvHz+MLxwM3LANyvKJwt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknvwuSmX9DMkG6pPRU/k1aEIJPAxGNdGzwd/W8K/dbM5/Crub
	qyg9K4gJi3ECdk6GQaaehMLVK05YKKIaFpI1/hal+C5Jxrqa9yJQDnWuPUlARDWHWRyoKLrlso/
	gcRjcLO1DmVKtwpnzD/KgIAPPNLHjep5Egh0WcC1kzZChsrAXSzIUQt/df5q6DoOctw==
X-Gm-Gg: ASbGncuL4GwNQ62hOUrv1exODDJ16Hsdv9H7PGaSU3Jr+sM4mTpJAnRjgiFFQk25h6y
	0DTLaYc8u31g5udtoLEYr6dhCZWBmE2qiIzW68Keru2Jqsg7pCk4aHDwKSc1Ww1dosWb5+nqZBo
	i+OdQgdQEM+bSzZCLrW7R/SpUCtMQBO+DIRnJTOhzePv+x9izTTuipcseCT3xFKcocrONWjQwJU
	Kg+B74/+F1RmWY1uCySeIa0rIE7CMFmaVpTL/Ma0K+Av14xoRFmfFJlBZjAJ4oG7WlRfw6gbChJ
	Ex4ekZDVwWq462WRzDoCKYblxB0VnyPyCUkiC6+vLTlY664Xb7v3mQRuIr4Q0SOTL0WymDy4tnN
	SpG7UwWULU+QR/vodDZEyIrGy
X-Received: by 2002:a5d:5f82:0:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-42704d6c875mr2405559f8f.22.1760694501357;
        Fri, 17 Oct 2025 02:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdsSMcOw5ZL2jR6hyjiSNg711Ev8q0s5gRKkVUUJlmfwROyY+h5E4fnL+7tlcL9fs9auY0lQ==
X-Received: by 2002:a5d:5f82:0:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-42704d6c875mr2405447f8f.22.1760694498640;
        Fri, 17 Oct 2025 02:48:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm40069307f8f.37.2025.10.17.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:48:18 -0700 (PDT)
Message-ID: <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 17 Oct 2025 11:48:17 +0200
In-Reply-To: <87ldl9x6h7.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-11-gmonaco@redhat.com> <87ldl9x6h7.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> > new file mode 100644
> > index 000000000000..fb885709b727
> > --- /dev/null
> > +++ b/include/rv/ha_monitor.h
> > @@ -0,0 +1,469 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2025-2028 Red Hat, Inc. Gabriele Monaco
> > <gmonaco@redhat.com>
> > + *
> > + * Hybrid automata (HA) monitor functions, to be used together
> > + * with automata models in C generated by the dot2k tool.
> > + *
> > + * This type of monitors extends the Deterministic automata (DA) class=
 by
> > + * adding a set of environment variables (e.g. clocks) that can be use=
d to
> > + * constraint the valid transitions.
> > + *
> > + * The dot2k tool is available at tools/verification/dot2k/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^=
^^^^^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 non-e=
xistent

Right, need to update also in DA.

> > +/*
> > + * ktime_get_ns is expensive, since we usually don't require precise
> > accounting
> > + * of changes within the same event, cache the current time at the
> > beginning of
> > + * the constraint handler and use the cache for subsequent calls.
> > + * Monitors without ns clocks automatically skip this.
> > + */
> > +#ifdef HA_CLK_NS
> > +#define ha_update_ns_cache() ktime_get_ns()
> > +#else
> > +#define ha_update_ns_cache() 0
> > +#endif /* HA_CLK_NS */
>=20
> ha_update_ns_cache() itself does not cache, its caller does. So I think
> it is misleading to name this "cache".
>=20
> Why is "update" in the name? Isn't something like ha_get_ns() betters
> describe this macro?
>=20

Good point.

> > +/*
> > + * The clock variables have 2 different representations in the env_sto=
re:
> > + * - The guard representation is the timestamp of the last reset
> > + * - The invariant representation is the timestamp when the invariant
> > expires
>=20
> Why does guard representation store the last reset?
>=20
> For example, what if I specifiy the guard as "clk > 500ns". Shouldn't
> the guard representation be "500ns"?

Alright, this is the simplest way I could think to represent clocks, still =
it
seems confusing.

Let's start from guards (invariants are not special but I'm trying to do
something to keep precision), the value of a clock is the time that passed =
since
the last reset, as that's when the value is set to 0. Storing that timestam=
p and
just comparing the difference whenever you need to know the valuation of sa=
id
clock seemed the most straightforward thing to me. The clock representation
doesn't include the guard constraint, that is validated during the event us=
ing
the current valuation (i.e. now - reset_time).

What is important to note is that, at time of reset, you don't know what gu=
ard
is going to fire, you may as well have a state with event A asking for clk<=
10
and event B requiring clk<20, also the guard may be in a later state and ma=
y
depend on the path.

Invariants are bound to the form clk < N, and get "armed" when we reach the
state, from there we know exactly when the invariant is going to expire, so=
 we
can save that (very important when using the timer wheel). Note here that t=
he
expiration isn't exactly N from now, but it's the valuation of the clock (r=
eset
might have occurred a few states earlier, see the nomiss case) subtracted b=
y N,
this is what the "passed" means later.

That said, I couldn't think of a simpler implementation but any suggestion =
is
welcome, of course.

> > +static inline u64 ha_get_passed_ns(struct ha_monitor *ha_mon, enum env=
s
> > env,
> > +				=C2=A0=C2=A0 u64 expire, u64 time_ns)
> > +{
> > +	u64 passed =3D 0;
> > +
> > +	if (env < 0 || env >=3D ENV_MAX_STORED)
> > +		return 0;
> > +	if (ha_monitor_env_invalid(ha_mon, env))
> > +		return 0;
> > +	passed =3D ha_get_env(ha_mon, env, time_ns);
> > +	ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
>=20
> The function is named *get*() which indicates that it only reads. But it
> also writes.

Right.

>=20
> > +/*
> > + * Retrieve the last reset time (guard representation) from the invari=
ant
> > + * representation (expiration).
> > + * It the caller's responsibility to make sure the storage was actuall=
y in
> > the
> > + * invariant representation (e.g. the current state has an invariant).
> > + * The provided value must be the same used when starting the invarian=
t.
> > + *
> > + * This function's access to the storage is NOT atomic, due to the rar=
ity
> > when
> > + * this is used. If a monitor allows writes concurrent to this, likely
> > + * other things are broken and need rethinking the model or additional
> > locking.
>=20
> Does atomic_sub() solves your "NOT atomic" problem?

Kinda, it would solve the problem for this specific subtraction, but racing
handlers could still lead to problems although the subtraction is "correct"=
.

Since this is the only time the env storage needs to be an atomic_t and it'=
s
fairly rare (only complicated models require calling this function at all,
others are happy with READ_ONCE/WRITE_ONCE) I didn't want to change the sto=
rage
implementation for some perceived safety.

I wrote that comment exactly to motivate why we aren't using atomic_t, but =
I
should probably reword that. Does this make sense to you?

>=20
> > +static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enu=
m
> > envs env,
> > +					u64 expire, u64 time_ns)
> > +{
> > +	u64 passed =3D ha_get_passed_jiffy(ha_mon, env, expire, time_ns);
> > +
> > +	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
> > +}
>=20
> I don't understand this "passed" thing. I see this function being called
> in ha_setup_invariants() of stall monitor. Stall monitor is validating
> that the task does not stay in "enqueued" state for more than
> "threshold_jiffies". If so, what is the purpose of "passed"? From my
> understanding, it should be just=20
>=20
> static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum e=
nvs
> env,
> 					u64 expire, u64 time_ns)
> {
> 	mod_timer(&ha_mon->timer, get_jiffies_64() + expire);
> }
>=20
> what do I miss?

As mentioned before, this is true for the stall case, where the reset occur=
red
when reaching the state with the invariant (passed is close to 0), if you l=
ook
at the nomiss case, reset happens before being ready (its invariant would h=
ave
passed close to 0), but the same invariant is enforced in running, here we =
will
see a passed far from 0 and need to take that into account when setting the
invariant.

This is by the way what made necessary caching the ns time, otherwise we'd =
end
up reading the ktime multiple times in the same handler for fairly no reaso=
n.

I've been stuck on this implementation for a while so I definitely need an
outsider perspective to see if things make sense!

Thanks,
Gabriele



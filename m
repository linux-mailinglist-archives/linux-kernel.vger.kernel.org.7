Return-Path: <linux-kernel+bounces-784208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2822B3381C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E86168B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80E29A30A;
	Mon, 25 Aug 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLZBt4M9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429C2737FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108114; cv=none; b=X9fBNbXthRryfX00tuhff1ydS0S33KJCVbZ7ndOGUMVL531gtF1WIKVsz40tt22ui2FJ15FtbSzpZT60XRUVXJaVjh7XPmgIvo2Jss0scY43wdvDi7jAUcHDnQeH+lC81hrvgTU5oh3jP16sh7bQv6CNq9nTA9YF4TU1hkcd0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108114; c=relaxed/simple;
	bh=NCund2P9r/7rKXmekNb86CC2tPapS78Ho/dPe4FXE1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBoMNXtFXnKdlf7EURX9oHY/JU2y2TJSHxUxV3Zk6LjY3tXUr6+x0GnQN2FdphjSvhHj+7/IGpbCBnzbNqVcjNuPKLV/FHjtURIlggzILyhCYhpRyIxoUUGUl59L4VM9x+8SGX8IrK7zYn5R58uslYQ/4rfN8k+kXoW4lBF8gO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLZBt4M9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756108111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ccIrOR6E/f8WoCPzjCXBcfOubdi+LJ39qCAR6Bxl8+k=;
	b=XLZBt4M9zkOmdoDwGyfcSiyFx0MW8806Mg3t3m3Rs8OdB9SovG++7F8qaJPXQ3eR6MJPip
	7jaha3ChMwso2FUCvoNcih4AxhzDcMiir9NkhrUcKFa/C8jS6ZAaoM1v1HmdB2WZuQsMc0
	tkxADA5Qr5b9nsIBCP7A5UIVWkuQTto=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-XMZd-wwWMFKWhz5nPzd2nw-1; Mon, 25 Aug 2025 03:48:28 -0400
X-MC-Unique: XMZd-wwWMFKWhz5nPzd2nw-1
X-Mimecast-MFC-AGG-ID: XMZd-wwWMFKWhz5nPzd2nw_1756108107
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d93f57930so105561996d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756108107; x=1756712907;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccIrOR6E/f8WoCPzjCXBcfOubdi+LJ39qCAR6Bxl8+k=;
        b=Lbug2Olsw0Puk22F/wZQ5GriHK0PykWcMkU8Mp9+nYbyQIzss31eeH1qJu6idURNIZ
         embFaro5sBMq7Y60/rQPnYIZdT0Q3a/AHP10wg0wlcw7PF/mdzrkbrFJ4XPh1TU3Waxa
         PITYtRFz8IALOneSCN/Xnlp5rIRgFcu5YmfPq/e8pF7hrsv+ho2ir1/Gy5BWsWEQPFZ0
         95u1HZ3quFXgJe/eEE4UEEr8fMKv5pfzxSy+/1T2lNTzRVZFUA9gWqSQL/N5uVwyUq68
         lBAjGKoC1sxeya0qA9NE7ITh+kOTrnYp9SPAVueDWR/szMBou4bQFSAXJM6Aone08jbV
         ipBw==
X-Gm-Message-State: AOJu0YyshgYIs5FdlI1FWnehE7hU7HVDbhNbm96GqdsiWhLYs+a1Zjj8
	zitGkEbJTRImgepn8NYQjND60IfFs/9DUKzeyHECbMjA1BET0+AJ0N+dwr9WjVUVo7T35m4THJz
	ZbM3YNSbBK2kmSK37zfLwFHJ5/dnpDCX3Jo2syi+QNi6QIspU/Y7O2sbteavfjaMZIfWl+YVIM/
	nM
X-Gm-Gg: ASbGncv+B92IUDUT8Z76nYz4X/P5MsodJLTOMkWPLc/xS5pOCIZKEqYqEjbrN7hvaYN
	KKEw574NrIT1loBwPj6FJ7Rt2vTfvXBLkD22Jdz4WEnMXFHUsfFMFqmYHFqmY7zLBU4R+9HPQRa
	dUF0FBce6Yia/sNbta8CytLU8TGitR207j58c10B9IgFGeQhZX9f+fPT/r35AOc1Di9DCFeyqZs
	rHy/VgPJC3WGkTf0MtdXbOxh/6Cf8sltvBqD3YyJ9PxqXUETwEhjp1KiAOcq6U5pSXW6sgCKZAs
	2j4++4Hh3CirU5N8Jwo41cm0GXxxZ+ga0UwaZtTpkpur5fw8XuMa0ECB6f6ozQCWUw==
X-Received: by 2002:a05:6214:f2f:b0:70d:6df4:1b0d with SMTP id 6a1803df08f44-70d973b835dmr113621326d6.59.1756108107508;
        Mon, 25 Aug 2025 00:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7/RF18IlBcepG6q/+MdO7zen7WXzh14KtBy+l+3laX790Cz+dSphgn5hg8T1eYbcBbIxgQA==
X-Received: by 2002:a05:6214:f2f:b0:70d:6df4:1b0d with SMTP id 6a1803df08f44-70d973b835dmr113621106d6.59.1756108106936;
        Mon, 25 Aug 2025 00:48:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da7173220sm42277656d6.27.2025.08.25.00.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:48:26 -0700 (PDT)
Message-ID: <fd9dc21acd4fac68a3948ded59cf9235f0e4bb7f.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 09:48:23 +0200
In-Reply-To: <20250821121846.N0S9tb6x@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <20250821121846.N0S9tb6x@linutronix.de>
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

On Thu, 2025-08-21 at 14:18 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:00PM +0200, Gabriele Monaco wrote:
> > Deterministic automata define which events are allowed in every
> > state,
> > but cannot define more sophisticated constraint taking into account
> > the
> > system's environment (e.g. time or other states not producing
> > events).
> >=20
> > Add the Hybrid Automata monitor type as an extension of
> > Deterministic
> > automata where each state transition is validating a constraint on
> > a finite number of environment variables.
> > Hybrid automata can be used to implement timed automata, where the
> > environment variables are clocks.
> >=20
> > Also implement the necessary functionality to handle clock
> > constraints (ns or jiffy granularity) on state and events.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> So you have figured out how to deal with the time problem. Cool!
>=20
> I'm curious, instead of a new monitor type, would the entire thing be
> simpler if these new features are added as extension to DA monitor
> instead?
>=20
> The existing "pure DA" monitors would just not use the constraint and
> timer stuffs and would behave same as before.
>=20
> Just an idea, I'm not sure how it would look like. But I think we
> might reduce some line count.

Mmh, that might save some lines, especially the *_hooks() macros.
The few functions that are now duplicated would end up together with a
condition, though.

I'm however not too fond of forcing any DA user to allocate space for a
timer. Imagine a custom kernel for an embedded device trying to squeeze
some RV monitors in tasks and ending up requiring 64 bytes per monitor
instead of 8.
If this doesn't look confusing to you, I'd prefer them separate at
least there.

> > +/*
> > + * ha_monitor_reset_all_stored - reset all environment variables
> > in the monitor
> > + */
> > +static inline void ha_monitor_reset_all_stored(struct ha_monitor
> > *ha_mon)
> > +{
> > +	for (int i =3D 0; i < ENV_MAX_STORED; i++)
> > +		smp_store_mb(ha_mon->env_store[i],
> > ENV_INVALID_VALUE);
>=20
> Why is memory barrier needed here?

Right, those are not needed, will remove.

> I think checkpatch.pl should complain about this? Please add a
> comment explaining the purpose of this memory barrier.
>=20
> The same applied for the other memory barriers.
>=20
> > +}
> > +
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
> > +
> > +/*
> > + * ha_monitor_reset_env - stop timer and reset all environment
> > + *
> > + * Called from a hook in the DA reset functions, it supplies the
> > da_mon
> > + * corresponding to the current ha_mon.
> > + * Not all hybrid automata require the timer, still clear it for
> > simplicity.
> > + */
> > +static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
> > +{
> > +	struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> > +
> > +	ha_monitor_reset_all_stored(ha_mon);
> > +	/* Initialisation resets the monitor before initialising
> > the timer */
> > +	if (likely(ha_mon->timer.base))
> > +		ha_cancel_timer(ha_mon);
> > +}
>=20
> Looking at hrtimer->timer.base seems quite hacky. It seems that this
> could be broken due to a future hrtimer's refactoring.
>=20
> Instead, how about moving hrtimer_setup() into monitor's enabling
> function?
> Then you can always hrtimer_cancel() here.

I didn't really like that either, it just seemed the easiest option at
the time. But yours is a good point..

Timers are per monitor and the enabling function is to register the
monitor functionality, so it won't run for all tasks (and some aren't
there yet).

The right spot for this is the start function (where it's currently
happening), the main issue is that resets are running at times when the
monitor is not started, so the timer may not be there when we attempt
to cancel it.

I'll check a bit more if we really need those resets, and in the worst
case use something like da_monitoring() as a condition there.
Then I'd remove the same condition in ha_monitor_init_env(), which
basically would setup the timer every time the monitor starts, that
doesn't seem an issue to me.

>=20
> > +/*
> > + * ha_cancel_timer - Cancel the timer and return whether it
> > expired
> > + *
> > + * Return true if the timer was cancelled after expiration but
> > before the
> > + * callback could run.
> > + */
> > +static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
> > +{
> > +	ktime_t remaining;
> > +
> > +	if (!hrtimer_active(&ha_mon->timer))
> > +		return false;
> > +	remaining =3D hrtimer_get_remaining(&ha_mon->timer);
> > +	if (hrtimer_try_to_cancel(&ha_mon->timer) =3D=3D 1 &&
> > remaining < 0)
> > +		return true;
> > +	return false;
> > +}
>=20
> This is still racy. The timer could expire after
> hrtimer_get_remaining(), but before hrtimer_try_to_cancel()

I believe in that case hrtimer_try_to_cancel would return -1 (callback
is executing) or 0 if the callback is done.
I guess that should be serialised by the hrtimers locks, but I'll
double check if there can indeed be a race.

> Is it really important that we need to care about the tiny window
> "after expiration but before the callback could run"? What if we just
> use hrtimer_cancel() here?

As Juri pointed out, on PREEMPT_RT kernels if the timer isn't marked as
_HARD, the window won't even be tiny.

That was a (blind) attempt to reduce the overhead of using timers, I'm
going to run more tests to understand if that really makes sense. Not
using _HARD and having the timer not serviced, would in fact end up
just like not using timers at all, which is what the monitor could do
in the first place.

Thanks,
Gabriele



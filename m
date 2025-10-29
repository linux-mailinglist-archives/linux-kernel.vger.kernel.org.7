Return-Path: <linux-kernel+bounces-875583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D819C195E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F02B502539
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D12D46B6;
	Wed, 29 Oct 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTc5cocQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FA15ECD7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729903; cv=none; b=Q8r5riNF0msk6sf69dE6f+UmQ7IlYphvwgCFx07IbqxDPfDnuCnPCVEy3irMx3J1z/h4SFNYZM99qtJ/Qn2i73rrT2+6z6G8YmZqsXj5xOvfScw3JZ6U8yN+lAKxAYUvK7Xkx4ICNZg//EPLbNfKdagEcybt8EHQV9i9LQikBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729903; c=relaxed/simple;
	bh=0WXsJu530ceNc7ilcUIwaAW370CuHlKgKqAImdKU30U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnA8aXjQ7X0iJAvqfk1g6PPeoBVpwOEunsUxRUW6JQe70pHPsCVyJjtOIMvmyWRLbfibtdkS97wYm/Beos83EIgNL+oUV32rvnuzoDyD5kMLWkyL0GaIS9UqKTkR3S66ZPU/Xv0lPoYLJwOdlDLf5RfVgzgwIruotlv4SnRDMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTc5cocQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761729900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0WXsJu530ceNc7ilcUIwaAW370CuHlKgKqAImdKU30U=;
	b=CTc5cocQdGacsERWhJEoOkHtzVgq0f598DLhqQ+jyKSUOgloi1F01QSGgnSa8Tn7QkHnOm
	M/dgahg5DYaPO9mkxTe1F3R0384vKzJNd+HEVVhTN8tnREaAE2Dd6I9dn2gIliTdg0e0Xj
	KwDhMC0WQYHj5wApEtAf7vg3HZC/Px4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-syxf0EQNN_y9E4Qr6WXZOg-1; Wed, 29 Oct 2025 05:24:58 -0400
X-MC-Unique: syxf0EQNN_y9E4Qr6WXZOg-1
X-Mimecast-MFC-AGG-ID: syxf0EQNN_y9E4Qr6WXZOg_1761729898
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427013eb71dso6242531f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729898; x=1762334698;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WXsJu530ceNc7ilcUIwaAW370CuHlKgKqAImdKU30U=;
        b=XkQWOyiYXHk26lnOPDs2zj0WcTYONAyzDEpPWq8nsWJauEGM67DfYJmRTgnggMTwVj
         HfkDxsgHAHwcakrY+yH2pQDpokG3NH2bGj+sn7f77fW3ibEPI1qt3OaFnkpDMVr/ni2t
         WlKlBXt5MwNCrXCgVt3OZlg4A2qBP2U46j37y3QyQDhaVwtHCLLSEDWp9VRuBT8iP4Xm
         DLYVHnOJG0fYT0vbypxN4VE/9eNO1vSTmGA/xcP0v0QOHVRH1Hk5UB9csezkQ3WYSnav
         s4bO++z54fMnY3yEfRXMJCBh/ZE38jHqshDRVrlPfqhEH/J4F/WVBWu8+QfeIscV4x0u
         0N8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYt0xhtM8ZEtFuI72nhJy4OtZC5caE3FjzoY8um+6IRvS2b9v5diiza0V9uC1zlNUNmTnQemrBA3INbfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwgo+5tTOBUad68d41qcexK8cjGjgwacwJzCWLW6v0V49EpHym
	wwYmIDdwoFh36XQ3Iwv3WO1z14NEliWBmoTtSaBTiM/T8hCm2cDBJu7UXdb4qbU6LjE0slhpmGu
	Vg6MFurksR8sk6T8Vg/gf8xUYlxJ3lQyAdZ+200HsWQqjfU0dB2yR7Ha8I1Eh5EauoA==
X-Gm-Gg: ASbGncsCazeBmZWx3buqRy2MAppwQlYxwCKX+4/1MyeAsX9OySE0d3ZrSVXQhxdZz+X
	2yQEqi77kfiui/hRqudZaIBme3C3ynDpKuxdhIiFAUK61E2VXvgEmdW3G1PrJIdj0Q8IoSnqD3u
	hia/2W+PNWy+slbn4FluI8ulEWBaiPuBiT3JuLFHfnVUH1AIJ0CgUplsuoaRHwxkNq/4TNITdQl
	6IpuJX78c2Bq1/OJJipJmiMeLuaMKX4mquFThrSGRgK7BgcNnY/C2rJj7DydYWHZaE16fgzui5o
	lmCeBoqC/NO1YipYXPVeZiW4Yrk7dt42pIFvYKgjxeJLqiYuuxAG6xn2uSIBwcladkzAcAzEdsW
	jli+xJfP1S57HvlDcUzUlNrZJn+5ATsOCuxSq1k65b8NIdAq8STk=
X-Received: by 2002:a05:6000:2485:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429aef78cedmr1474042f8f.1.1761729897663;
        Wed, 29 Oct 2025 02:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjTRxyGvokL2Th/q/DPYQQau0WxTo+NaKPw9LSbMtX3zlPsRrCVudzUFKVsEOalIXTrhFIdg==
X-Received: by 2002:a05:6000:2485:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429aef78cedmr1474021f8f.1.1761729897181;
        Wed, 29 Oct 2025 02:24:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902981esm38411385e9.9.2025.10.29.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:24:56 -0700 (PDT)
Message-ID: <6a85223ba6022ed2183a522fcf3e7c8d00675672.camel@redhat.com>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar	
 <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park	
 <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev,  LKML <linux-kernel@vger.kernel.org>
Date: Wed, 29 Oct 2025 10:24:53 +0100
In-Reply-To: <eed6ff19-a944-4e4c-96e4-0f44e888c71d@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
	 <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
	 <eed6ff19-a944-4e4c-96e4-0f44e888c71d@kzalloc.com>
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

On Wed, 2025-10-29 at 07:53 +0900, Yunseong Kim wrote:
> > What you need here is to validate kernel code, RV was actually designed=
 for
> > that, but there's currently no monitor that does what you want.
>=20
> It=E2=80=99s a valuable chance to make a contribution to RV!

And could be quite a useful model!

> If the goal is to detect this state before the output from __might_resche=
d()
> under CONFIG_DEBUG_ATOMIC_SLEEP (i.e., before an actual context switch
> occurs),
> I am considering whether Deterministic Automata (.dot/DA) or Linear Tempo=
ral
> Logic (.ltl/LTL) would be more appropriate for modeling this check. I'm a=
lso
> thinking about whether I need to create a comprehensive table of all slee=
pable
> functions for this purpose on the PREEMPT_RT kernel.
>=20
> If this check is necessary, I=E2=80=99m planning to try the following ver=
ification:
>=20
> RULE =3D always ((IN_ATOMIC or IRQS_DISABLED) imply not CALLS_RT_SLEEPER)

Yes, in this case DA or LTL is mostly down to preference, one thing to keep=
 in
mind is that this is going to be a per-cpu monitor (i.e. the rule stands fo=
r
each CPU, as the irq/preemption state is per-cpu).

LTL support for per-cpu is added in [1] (not merged), so you will need to p=
ull
that in if you want to play with LTL.

[1] -
https://lore.kernel.org/lkml/e7fb580ca898c707573fe1dcf6312f0c2d7682c5.17549=
00299.git.namcao@linutronix.de

> I=E2=80=99m also planning to add sleepable functions, including sleepable=
 spinlocks
> and memory allocations callable under PREEMPT_RT preempt/IRQ-disabled sta=
tes,
> to the RV monitor kernel module.
>=20
> I=E2=80=99m considering adding the following functions as a result:
>=20
> =C2=A0// Mutex & Semaphore (or Lockdep's 'lock_acquire' for lock cases)
> =C2=A0"mutex_lock",
> =C2=A0"mutex_lock_interruptible",
> =C2=A0"mutex_lock_killable",
> =C2=A0"down_interruptible",
> =C2=A0"down_killable",
> =C2=A0"rwsem_down_read_failed",
> =C2=A0"rwsem_down_write_failed",
> =C2=A0"ww_mutex_lock",
> =C2=A0"rt_spin_lock",
> =C2=A0"rt_read_lock",
> =C2=A0"rt_write_lock",
> =C2=A0// or just "lock_acquire" for LOCKDEP enabled kernel.
>=20
> =C2=A0// sleep & schedule
> =C2=A0"msleep",
> =C2=A0"ssleep",
> =C2=A0"usleep_range",
> =C2=A0"wait_for_completion",
> =C2=A0"schedule",
> =C2=A0"cond_resched",
>=20
> =C2=A0// User-space memory access
> =C2=A0"copy_from_user",
> =C2=A0"copy_to_user",
> =C2=A0"__get_user_asm",
> =C2=A0"__put_user_asm",
>=20
> =C2=A0// memory allocation
> =C2=A0"__vmalloc",
> =C2=A0"__kmalloc"
>=20

Here you're talking about direct kernel functions, currently RV relies on
tracepoints (that's why I mentioned those earlier). You have two routes:

1. use existing tracepoints and/or add new ones in strategical points
2. use kprobes and attach wherever you want

1. is very easy in RV and you may use tracepoints arguments to narrow down =
the
search (e.g. just transition state on certain locks, certain allocations), =
you
may need to discuss with various maintainers to add new ones, but that's us=
ually
alright, have a look at the V2 of the linked thread for an example [2].

2. is a bit more involved, you'd be able to access precisely the functions =
you
want (usually), but I'm not sure about the overhead of plugging 15 kprobes.
Also RV doesn't support kprobes, although extending it is rather trivial.

You can mix both, of course. But yes, you'd need to identify all the "event=
s"
you care about. I'd start simple with some of those (e.g. malloc and lock
contention tracepoints) and see if it satisfies your needs.

You may also be counting things twice (isn't malloc calling locks, which ma=
y end
up calling schedule?), just an idea, but you may find common paths in the a=
bove
list.

Gabriele

[2] -
https://lore.kernel.org/lkml/f87ce0cb979daa3e8221c496de16883ca53f3950.17544=
66623.git.namcao@linutronix.de

> > Now this specific case would require lockdep for the definition of
> > lock_acquire
> > tracepoints. So I'm not sure how useful this monitor would be since loc=
kdep
> > is
> > going to complain too. You could use contention tracepoints to catch ex=
actly
> > when sleep is going to occur and not /potential/ failures.
>=20
> I=E2=80=99ll look into this lockdep realated part further as well.
>=20
> > I only gave a quick thought on this, there may be better models/event
> > fitting
> > your usecase, but I hope you get the idea.
> >=20
> > [1] - https://docs.kernel.org/trace/rv/monitor_sched.html#monitor-scpd
>=20
> Thank you for providing a diagram and references that make it easier to
> understand!
>=20
> > > Here are my questions:
> > >=20
> > > 1. Does the rtapp:sleep monitor proactively detect scenarios that
> > > =C2=A0=C2=A0 could lead to sleeping in atomic context, perhaps before
> > > =C2=A0=C2=A0 CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the=
 actual point
> > > of
> > > =C2=A0=C2=A0 sleeping?
> >=20
> > I guess I answered this already, but TL;DR no, you'd need a dedicated
> > monitor.
> >=20
> > > 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
> > > =C2=A0=C2=A0 immediately as soon as the RV subsystem is loaded during=
 boot time?
> > > =C2=A0=C2=A0 (How to make this "default turn on"?)
> >=20
> > Currently not, but you could probably use any sort of startup script to=
 turn
> > it
> > on soon enough.
> >=20
> > > 3. When a "violation detected" message occurs at runtime, is it
> > > =C2=A0=C2=A0 possible to get a call stack of the location that trigge=
red the
> > > =C2=A0=C2=A0 violation? The panic reactor provides a full stack, but =
I'm
> > > =C2=A0=C2=A0 wondering if this is also possible with the printk react=
or.
> >=20
> > You can use ftrace and rely on error tracepoints instead of reactors. E=
ach
> > RV
> > violation triggers a tracepoint (e.g. error_sleep) and you can print a =
call
> > stack there. E.g.:
> >=20
> > =C2=A0 echo stacktrace > /sys/kernel/tracing/events/rv/error_sleep/trig=
ger
> >=20
> > Here I use sleep as an example, but all monitors have their own error e=
vents
> > (e.g. error_wwnr, error_snep, etc.).
> >=20
> > Does this all look useful in your scenario?
>=20
> Thank you once again for your thorough explanation. Many of the questions
> I initially had have now been resolved!
>=20
> > Gabriele
>=20
> Best regards,
> Yunseong Kim



Return-Path: <linux-kernel+bounces-858301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353CBE9CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D497F19A72D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449533290B;
	Fri, 17 Oct 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwtf6ZeL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD8289811
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714545; cv=none; b=CgHD9PVipkVn0Ictm3ZhGdFjv2Z01u/c80iYBkgkdRwXmMYENK71MyUN8VTWyp27lkPqLlH8/PinvwD1DmLQGREbDk6JqMthexntvKaV8kwKrs+KtwNampyddZeJbmeJtQoMynPc3W+u4KMVtc2eO6fgucXGLVMdMXXGMeT06bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714545; c=relaxed/simple;
	bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BG/kx0vaDFRAFYu906y6hvwURQhc1EVIgxziSsQ1ErRBRU6Z44NBozpziaXxnJODg/W837DJlfiua9KSOShh7O/CUz8UVBpoEjgz2eh2qkhXC40m51WHF669ZlUMYGgHCxz+kpU0T1CM/EmZcePw/feeimyreGZrDSOlWXx9P7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fwtf6ZeL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760714542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
	b=Fwtf6ZeLfPXJYddUl5fKYLAIDBggwvFCSty86kKk1n82AUIy9977AeKpkgkq2NS67nbT+n
	62LASEgppGj7ulqruAGIVdVAyzBzQdPhjO3WVHitM9gzRQ8dayVImwPCDz3qBJZKdZMRf8
	Pd8GCCg4ro1rCeHJsRzW2trT6ljhV+E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-vxnKZHKQOheImkRtA1X4iA-1; Fri, 17 Oct 2025 11:22:18 -0400
X-MC-Unique: vxnKZHKQOheImkRtA1X4iA-1
X-Mimecast-MFC-AGG-ID: vxnKZHKQOheImkRtA1X4iA_1760714537
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426ede1d66fso1273837f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714537; x=1761319337;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
        b=lHPcLR6NHNx+MmB9JXHGtPp+2nbwwzvFZfIZvfO28RXpxgzOHxffTQZcxrI5K4IYOE
         Qmgli2Awod2P5PQC+uT7nvppPEh6A6fT2eSboLWpwol6E/kC8Bn8Ijg+0sFaKgY75qPC
         5k8XCUrC7BAZqCGrC/Mhnz4OKP9mvgcKL9WCcWfMX+CXIf0XGGR/32+rkfvbHNCGYC3A
         v4LBwkTPv/+9PLm/lGQdGacborNpy4hEJTGw7DAB22NRybY2xoEAJiBIFeSJo4zhktF2
         TfY2lgTH2tRHOgqs+oaEFdCPk6XfyM3dQrU28WICHdZfwtlJ0WP4FWgDNoFHTF6Z6evO
         lhZA==
X-Forwarded-Encrypted: i=1; AJvYcCWTumvsO244Oz3KHX3vooYwKRdyJrW5cy8hCSB/vk1UuZRYCbzWtdieya2ICCPSwDjhvSDSzaUhq2O9yPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeb1KnlY7txW6FkG7AEj7RSd/a8hfMTBPHdnKmhH/DfGXME4ZX
	hus+sHK7XIHRW/A0gZwHRiR6Zz2Qn8EYNw8MHP+zx4wEwG+ofpSK8VRCf8ToBjckoDQ3128IQfm
	NTJM/Hr4qw8CFqYapWln9NO7evP332DmMiQCTLFxEA3W2uFAQP2bYJ52NjdFAu7OPCQ==
X-Gm-Gg: ASbGncsDVJ207jZRfU1sTqQI2+xka3jO3Ww3f5wQMd+bJ5d3Y0lSKehZSAGbwACP/rj
	8/5sf6y8zHFqAmno/gMrDhQM+vgwLIP3Iy4gqsUF0CuX1oca/WJQUk0L+H3ThC9760HTy6y/SEA
	7QX4RpRi338rwoOV48zYhLjgUa7KbHsOSzGhLBZ05NDkUY5laabpdmUWwfXfzkINNyx1sT9pi4R
	uZ0Eaw0v/X5qgjvggrWpt42oeqSSBKagdUj8S52o1BENpHxSi58OmLPhljY0XyApZXSgV26ZB4g
	bVxXPsorlz+bKWKMyZswP2nHlY7EhEg+rqLXJSuHZ2j7nQ9ITh2fw47frzGaewdC7h5a4WM6Y1A
	51gcQ30ftlGlkeOdEFevBn6Js
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr3075539f8f.36.1760714536915;
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoHGID/pkuiaJ4RfGLI4OcwnA8+eh8UgRZ4XAaH/jRsagXl9UHzOOtyF00rC63dnUFcejKnw==
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr3075515f8f.36.1760714536506;
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm42747615f8f.10.2025.10.17.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
Message-ID: <0c61c0bbbdc2002efb638dccda1f0a18c51d29df.camel@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 17 Oct 2025 17:22:14 +0200
In-Reply-To: <87frbhwudz.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-11-gmonaco@redhat.com> <87ldl9x6h7.fsf@yellow.woof>
	 <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
	 <87frbhwudz.fsf@yellow.woof>
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

On Fri, 2025-10-17 at 15:05 +0200, Nam Cao wrote:
>=20
> Ok, now things start to make sense. Thanks for the explanation.
>=20
> At least to me, using the same variable to store different time values
> is a bit confusing.
>=20
> Is it possible that we always store the timestamp of the last clock reset=
?
>=20
> The invariant bound value (N) is fixed for each state, so we can have
> the bound value in ha_verify_invariants() instead. For example, the
> Python script can generate something like
>=20
> static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum states curr_state, enum events
> event,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum states next_state, u64 time_ns)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (curr_state =3D=3D enqueued_stall=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ha_check_invariant_jiffy(ha_mon, threshold_jiffies,
> time_ns);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> }
>=20
> Is that possible?

Alright, that /should/ be possible, provided the value used to set invarian=
ts is
constant or at least doesn't change until we leave the state.
This seems a fair assumption to make but doesn't stand for the throttle mon=
itor,
in that case I read the remaining runtime from the dl entity, that one is
updated frequently, for instance when a task is throttled, it's negative, b=
ut
this doesn't mean the invariant should expect time to be negative.

Runtime is consumed only when a task is running, so here I use an invariant=
 set
up on the /remaining/ runtime when reaching the running state, that's why a=
lso
switch_in resets the clock (runtime is not replenished, but the runtime_lef=
t
value doesn't need to be subtracted anything).

An alternative would be to have some sort of pause/resume operations on clo=
cks,
and a task would just pause the clock when preempted, but those operations =
are
not backed up by theory and wouldn't really simplify the implementation (us=
e 2
variables per clock or a single one and some hack to mark it as paused).

Again, there may be better ways, but I found this one the "simplest".

Does it makes sense or am I just crystallising to this implementation?

Thanks,
Gabriele

>=20
> > Kinda, it would solve the problem for this specific subtraction, but ra=
cing
> > handlers could still lead to problems although the subtraction is "corr=
ect".
> >=20
> > Since this is the only time the env storage needs to be an atomic_t and=
 it's
> > fairly rare (only complicated models require calling this function at a=
ll,
> > others are happy with READ_ONCE/WRITE_ONCE) I didn't want to change the
> > storage
> > implementation for some perceived safety.
> >=20
> > I wrote that comment exactly to motivate why we aren't using atomic_t, =
but I
> > should probably reword that. Does this make sense to you?
>=20
> I think if we always store the timestamp since last reset, we can get
> rid of this function. Let's see how that discussion go..
> >=20



Return-Path: <linux-kernel+bounces-828538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D1B94D33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F782E19C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACB31159E;
	Tue, 23 Sep 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjRX9D7N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED532E9721
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613373; cv=none; b=Za2UiIkMtspZ8Px9rD8EdEexIscALIRIpfhNVcGA3bqlYpOvX5dVwKfctcVO/p7G8rzTjzoiU8xPd+nfsls3Yre8D/dZ1KEkCx/U1AzWuonODhWPDbJ7k2d5QQOhvw0QkSZgKVyk7qwyT9f+vMYuSJ1ce3IzALlvRkQtyC3Ty/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613373; c=relaxed/simple;
	bh=N0p4seiEQYgUMNiAldtlxRn72O3KMiTj8G6qDvnQ53o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJO7pyBTsO9LQcvRmeH8I5W3COriGh76k2UVV2z1Al4jSyGUaNJR+vQO/okCFqv4xkeDDKEi5PTx6m2Kcg3YKsV5CBiU6to4Cw70IA99CJZT0MxXp0VvJ83eVp2PZgVdWnqhjLIAeuinK9zwiMB9lMhuc3j37ZZm4D11sYN//2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjRX9D7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758613371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y3Qv0LLTCUmjMWNaQL1ZnMdluzFHkPix+U/IfYErqFw=;
	b=NjRX9D7Nil0EpFQ6jmdj6C9VB8NHcgZ9mRTIPlnoT5zjZbKeH2ME5s46e01DCmGhuzVtXl
	1I+JxQUXK7w9Z9pmXUT76nQGcHfYnxpLvzPMV9goieUBi9ysfBjSVlzEIdrkLx2L483Vog
	/9DcmpLZo5fitYDDWNf2BJOfhj/ZlI8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Ku4QpCfFMG63ttry7wU-Iw-1; Tue, 23 Sep 2025 03:42:49 -0400
X-MC-Unique: Ku4QpCfFMG63ttry7wU-Iw-1
X-Mimecast-MFC-AGG-ID: Ku4QpCfFMG63ttry7wU-Iw_1758613368
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de5fdda1aso26610025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613368; x=1759218168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3Qv0LLTCUmjMWNaQL1ZnMdluzFHkPix+U/IfYErqFw=;
        b=uzhiQodk4yype50dCkO4of1b4aC0pXodYIj/5E1ys7g3+GP8d3df3dXaVuKy9sFnRr
         ghJyF+iCmZk8QBoUHhX7VVM8ar8UVni5V6hgk+z0g+GlO6niBOGHuuU+EyVAKCjj44/S
         rHbpnnwAaaxTsOwvlw/YVVvqepFCi6gGKsMThINHGQWGKYFxXspgI7FYVez2EyvR3Mub
         MedhVbSTqc/72XIGqO0K5EaWn8HjHrR8VDD1k7R9kGDG4WZnqun6npKg1dEQnWXxQRy7
         EzzfXtjBMvvec+gMS46Ja5wyLfBqIRVEdAPNldTlkQ9JqRM7f/k7YB48LA1KbL12NoGS
         XD5g==
X-Gm-Message-State: AOJu0YzyRK80caNHj/RguNZ0xuxTip2kM1LtfdvIfRzi3bZXIlB57sWp
	nwl2Z0zzSMyzMNirPQKLDdTM1EycA6i3pZRuh152sFiHHsBV2KtRZ8jlp8kXRW1nttu/ZQv4Et5
	wdvqV+uBTywADB5bPqlWFTvXPw/WiCTQsOlBBgYOvjBJsZZqiUB9bnw0YLUOmipOT0PXmEy7dY9
	MM
X-Gm-Gg: ASbGncvR/DSYT0kzH4OvLvpOrUrKD22yy5nVPqnZ/nYhUT6PCz/Uu/k7/0zougdOJ36
	H2yOd3jtn4JAN8z2R4PGG31HJHmhUCU60sBwdjuhRIZfN4y8j5MCFwFMWNHKT246J+Bxe05gHut
	/XWn9iBrFQSVmjCNODLfIw53DTswWHYoh5h7PQp17ZS5709w7KdTdHKhAA/bb6xe9pW6A1yJw6U
	50kooUvR6gmVt5LPm+OMR1KCvla8UJLN/vnJtVotSjLJBKPcCnPnHyIgnFGQOjySne/BQ5vlHrc
	7ea+wDPS1MJM1PSjAzlQ8MB/ZMRu80Uoyuv961fPBsa95+MTjiL5gLlXYQAdF4hLEg==
X-Received: by 2002:a05:600c:4c15:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e1dacb263mr8066675e9.34.1758613368456;
        Tue, 23 Sep 2025 00:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8EXoCWEiqTmNsvoTITySrgXSbYUp7vJCyWTL7RnUVLQ1KyYva3lHV7061HfZx4QliTREupA==
X-Received: by 2002:a05:600c:4c15:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e1dacb263mr8066535e9.34.1758613368061;
        Tue, 23 Sep 2025 00:42:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d564sm307041065e9.14.2025.09.23.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:42:47 -0700 (PDT)
Message-ID: <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Tue, 23 Sep 2025 09:42:46 +0200
In-Reply-To: <20250922162900.eNwI7CS0@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
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

On Mon, 2025-09-22 at 18:29 +0200, Nam Cao wrote:
> On Fri, Sep 19, 2025 at 02:26:12PM +0200, Gabriele Monaco wrote:
> > On Fri, 2025-09-19 at 12:49 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > +static void rv_reaction_signal(int signal, const char *fmt, va_list =
args)
> > > +{
> > > +	struct rv_signal_work *work;
> > > +	char message[256];
> > > +
> > > +	work =3D mempool_alloc_preallocated(rv_signal_task_work_pool);
> > > +	if (!work) {
> > > +		pr_warn_ratelimited("Unable to signal through task_work,
> > > sending directly\n");
> > > +		vsnprintf(message, sizeof(message), fmt, args);
> > > +		rv_signal_force_sig(signal, message);
> > > +		return;
> > > +	}
> >=20
> > Why do you use the task_work at all instead of signalling directly?
> > If that's something not safe from a (any) tracepoint because it can sle=
ep
>=20
> If I remember correctly, sending signals requires a spinlock and therefor=
e
> may sleep on PREEMPT_RT.

Yeah that's what I quickly glanced at. Which seems to be the case also for
mempool_alloc_preallocated by the way, so I'm not sure that's safer than
signalling directly on PREEMPT_RT.

Thomas, did you test your reactor on PREEMPT_RT? I'd expect a few fat warni=
ngs
when this is called from sched tracepoints. Unless you're lucky and never g=
et
contention. Lockdep (CONFIG_PROVE_LOCKING) may help here.

Thanks,
Gabriele

>=20
> > you should definitely not call it if allocation fails.
>=20
> Yep.
>=20
> We probably can get away with not reacting at all if allocation fails, by
> crafting our tests such that only one reaction happens at a time, and
> allocation won't fail.
>=20
> Nam



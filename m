Return-Path: <linux-kernel+bounces-843134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C27BBE770
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A643B8405
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4792D6603;
	Mon,  6 Oct 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9e6Fq4l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8D196C7C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763972; cv=none; b=WVgsaSXtbEWdvBPTbA/+UNQPa1jMh28whc+8xNHK8e9DvME28TyLekLH3eN03zI2vovJOl96ZtzTBp5ZNSCw/WxpePEmpjI8BBfdtZIASZY21/Mt3YRM+0bWhqX8sO6WxN8FAFM6aK9ax0SiCDdoXXd2fLY+gBl/BNbA2Mt0Cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763972; c=relaxed/simple;
	bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3nrill+XvmWSPguIh6ZgzqpTwt0NeOTm/KxeXBdt799elCXl1lWi8Y8nY2lIs+ud1wH7lxosRatLIvyPSC3RcN7nShX3LfaWZ6xK6ramskrlrME48CdjuslW41j1t6VLzV/2aheLRBvYpitI1c9PQf+KkjOUIW2h7PL4W1ozNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9e6Fq4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759763969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
	b=A9e6Fq4lmIfLE/4fLZ1UTSSOld3iuYsE0/Q8rmrmNCBlBzzxsT5AFqjJz+gnmbRst/GP/p
	t84sgLlF9ZZ/nEQjwCiuEKtgJrmgn0OY+IMPWbSjsNQZs19CiX8r5ajEtyCJO+ESQCIQAo
	F2O600UPrjkelAZyVM2VmCF4LgqvUsY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-uQWEhmZqPq6afz-Kr3-0ZQ-1; Mon, 06 Oct 2025 11:19:27 -0400
X-MC-Unique: uQWEhmZqPq6afz-Kr3-0ZQ-1
X-Mimecast-MFC-AGG-ID: uQWEhmZqPq6afz-Kr3-0ZQ_1759763967
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42557bdbe50so2842459f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759763966; x=1760368766;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
        b=bTyTZNhu5ENOBY6ZvoX+e8AFlSBz5jcyo6X1VxS6O0QgVqBfrMlQnokJsbqw0cepjg
         YVhl7tPEHBrtIEUbFyPzA0i7nrV8LPmBwfGUjZAtBbr/NBDAepaVnVAftO00hEqFDx8O
         dc2byBorBZZq1Rj+AWjyBWyvO1zfzaH89VEbihU+LDB0ZusDydFSHZ23ezXHOlTStDHO
         F2eqauSJnILd82wNUgBTTgOu7XScW/ZufzHSKRxKU8qjVt3eH2Mjp1IorGFY4qEpYdi6
         ikx5LjYNf0JlubYmP0YH4QhX45ZtI2/8/xPGvVuoMtz8Kkr4zP/kcXt9kiLgssOUoL3C
         Fkmg==
X-Forwarded-Encrypted: i=1; AJvYcCVbrN6AqZFo8REkYZHZ1PNRjKqKTgL7KQtKaa4TpIKs46+UcLE5Vfa1a8cFHr/m93iOYjF3fT6uLdSxELk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/QIQ69x7EA1XthEyJDiJKzjo9EQgvFcZU4+GkLlwZdpV9dHj
	VbYdfrpDU+IaIGXNpD+EjbHp8Jmfbdb93aMD+YumfZSTkJaEPOdZoWbrLYFjMn1uTpgoRKXYVsr
	SvMalywla0/ez6a7ujPF/WRJd+HtVVB5IFCfEjzMl0GrxBN2jt9PvobauPpQ1D8gmqw==
X-Gm-Gg: ASbGncuuu4rxg80TBtNXwa25M8/cjZLixKWg45J70ehgz6ym+D2XpQhgDkanSyKzgAp
	i5LBe9BPlpgoDkGLY7zON9VRmP2N5PpaoNpStYyq0NGsOeg2gftrW+3gFZF3MGKGXCiopp7XyQU
	4JmxJTlMb2f8d3j6asDAOCDGKQM89aNXOnYdQE8y43Bj3+oCrv+qSmnK1gIUrYwHaxKoae+h0Co
	lfkHfV1Mg5dw5vKLvl9EOf20yppKwd/ks8bAOD6nXto9d4RU2Oj4cIpNllVkkrvlze8Q5Ahn3Qh
	IIalzr09BFLd1KCi3yQ7S9u2UQdTcQ3sK62jTxxmuxUwnG+wdiQajqW+9u2RKNX6SMetmeM=
X-Received: by 2002:a05:6000:3103:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4255d2ca77emr10468439f8f.21.1759763966637;
        Mon, 06 Oct 2025 08:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjOGZhBb1Hj6boNC5jaq+DsBlqku3D3S8G53bScw07rODCyR44HfCHuJGOAX5DYcdXXAMU1w==
X-Received: by 2002:a05:6000:3103:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4255d2ca77emr10468415f8f.21.1759763966126;
        Mon, 06 Oct 2025 08:19:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e58asm160675225e9.7.2025.10.06.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:19:25 -0700 (PDT)
Message-ID: <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Date: Mon, 06 Oct 2025 17:19:24 +0200
In-Reply-To: <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
	 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
	 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
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

On Mon, 2025-10-06 at 12:10 +0200, Thomas Wei=C3=9Fschuh wrote:
> Hi Gabriele,
>=20
> > Well, many use cases might be better off with tracepoints, but reactors=
 do
> > things tracepoints cannot really do.
> > Printk is much faster (and perhaps more reliable) than the trace buffer=
 for
> > printing, panic can be used to gather a kernel dump.
> > One may just attach to tracepoints via libtracefs/BPF and do most of th=
e
> > things you'd want to do with a new reactor, but I see reactors much eas=
ier
> > to use from scripts, for instance.
> >=20
> > LTLs don't benefit as much as they don't print any additional informati=
on
> > via reactors, but DA/HA give hints on what's wrong.
> >=20
> > I wouldn't get rid of reactors until they become a huge maintenance bur=
den,
> > but probably we could think about it twice before extending or making t=
hem
> > more complex.
>=20
> The existing reactors could be implemented on top of the tracepoints.
> This should make the RV core a bit simpler.
>=20
> Note: The current interface between the RV core and the reactors is
> inflexible.
> Passing only opaque varargs requires all reactors to format the string fr=
om
> within the tracepoint handler, as they can not know how long the objects
> referenced by the varargs are valid. Passing the actual objects would all=
ow
> for example the signal reactor to format its message as part of the task_=
work
> handler instead of the signal handler and avoid the allocation of a fixed=
 size
> message buffer.

Yeah that's right current reactors don't really make sense for things that =
are
not printing. But as mentioned before, fitting this for all the different
monitors types (per-cpu/per-task or something more exotic) and model types =
(DA
or LTL) has its challenges.

I personally never really used the panic reactor to get a crash dump, but I=
'd
probably miss the printk one, since it's much faster than waiting for the
tracepoint stuff (at least when matching with other things on the ringbuffe=
r).

As I get it, extending the reactors integration to support more things migh=
t not
be too useful, but I'm not too convinced on removing reactors for good.
I'm gonna give a little more thought on this one.

> > For instance, what's the exact use case of the signal reactor? Isn't it
> > simpler
> > to do everything in BPF? Is the signal needed at all or something else =
(e.g.
> > perf) would do the job?
>=20
> The signal reactor is convenient to write automated tests. It can be used=
 to
> validate the monitors by triggering known-bad systemcalls from a test
> executable and expect it to be killed with the reactor signal, see below =
for
> an example.
> On the other hand it can be used to validate that the kernel itself does =
not
> regress with respect to RV-validated properties. For example the test pro=
gram
> can enable the rtapp monitor and run an example RT application using all =
kinds
> of known-good IPC mechanisms without it being killed.
>=20

Yeah, what I meant is: having a signal isn't your goal. Easily understand i=
f
there was a reaction is.
You could even restructure your test using tracepoints without any signal.

So if I get it correctly, you are both "voting" for removing reactors in fa=
vour
of tracepoint-only error reporting.
Am I getting this right?

Thanks,
Gabriele



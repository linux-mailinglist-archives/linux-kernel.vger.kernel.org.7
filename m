Return-Path: <linux-kernel+bounces-824515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37EB89712
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D474E2336
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CFE3112D6;
	Fri, 19 Sep 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyQRinu5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2130C105
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284781; cv=none; b=hRKBQ4FCE0QupJYxqJWvNJVvSC0sz4wZ5GikolcPOshmm8YwFPrb7OueyfNsLPOo/bgxsVBGbcmyxY2/L8zsGicjlZxMsHXHhhh0KHDCfwtZBSVPtefCHy56M1Ll9KkNCgLiOGUTuSBQzsU1zEZKcCj2tXWaYSZNQUWZrdCw9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284781; c=relaxed/simple;
	bh=wYJ2jiE80KfiwrmgrVBkWI9v02bw+WVW2OnRMT/BNxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6twHOPsxXV+1akPaHWoQW92kjwPfqU5ZsEhzuE8qmiP7DU6tXHINIDEhmgL+1pLR1LWzuDf2loJT6x5zfaWt7dya0xjRYmXrzeQxoHTlEssnyepGchN9rN14JlvRUWR+Af4wpalOVVZztsdWhFXfWiHy6w5mLUUmhWU7h5jq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyQRinu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758284778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w2XSBYp5h1Vr225E++TG9Fqb3LLvB175rci2oqHmbHw=;
	b=YyQRinu5ptBaMnieXzc/oLZinb6eIsGTAnYvdblMPsidlWhsI0R8BTDUTZEjVwazxDSF4T
	2kmqZATS2f9GRB/RvjS96XwwbId4r2gCMLjjkI2IqxKwoNiu/GymSfylOFOGRV9xnqXBpx
	8a16qodn5HIJNtq0nvkRh9tgHzTd/84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-QFdVTTGNNaOm6M597ywPGQ-1; Fri, 19 Sep 2025 08:26:17 -0400
X-MC-Unique: QFdVTTGNNaOm6M597ywPGQ-1
X-Mimecast-MFC-AGG-ID: QFdVTTGNNaOm6M597ywPGQ_1758284776
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso16745275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284776; x=1758889576;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2XSBYp5h1Vr225E++TG9Fqb3LLvB175rci2oqHmbHw=;
        b=lKWZ1OkvJZ173LYabbOASqPmVK2zwii3va4GzRpNpxCBSeFX8h6ADxNnduJIR0iTmJ
         A/0eA90QICXXubqy6qiV/lqJVMLlNm2QM7X6S9VAMlg4NPErwoqsZDXV/JnqVjf3qOlu
         tU/igsnyCvdjhXK3hghQn0FVXDa9BeffNB2vYo9klnZCj/L0DoM6BABNIGGmodXiQkC6
         0Lr7kXhJJT67Y3v5i2sATPmRlcYy2Sjp49E7TIerIvpepf6WQro2j2WHztfW19r54ppf
         l/xcpFwd4KFbQjEmJGycXHvcoDzQ1D0d00C6jKg0hpKtLjoulh7tttjdM/+KQeAHz0GZ
         6FHA==
X-Gm-Message-State: AOJu0Yw1cEEB6a1M4a0trhMFa2FizUPDPZ4Q29uo/as+Nr338a65061c
	AIrlWjxLu+OO1esze1W552xL5AI/f4feX64T0nMnHe6H5yCjB4kVi8iBOWsA6jsT+xj/mfv7yRN
	3Lc2XxeLeX3/8d88khrkLnbVetsMfQCF2GQMGo/UXVI+94+6OUJ/KP3RSMSyPuyw6kA==
X-Gm-Gg: ASbGncumCN381wKuTZ+u+wNM0Ll03VJUYswJcZMl8CJ7Ggar33hlvjiagslMsY/oxK/
	85jt+AaLddU7HvDN/yY6z+Y0suDeAONwodyV9vMXcxpxO6sQVnm/8OOjd994uWlUKirG4v4lpq2
	memTiXT5GseH3BO5V95i2zt0iUCLfx4Vkrn04dvLiGEqzJUu7jV+q1ElmaNwLt/OzsplgRSX1Ez
	9CxZznvTUDI5SuG1GKhjFGcIY9IwRj+upXh1T7wZh8+DI1ls5hSzkFjl7HJOa4tqPEwQcDXS/MS
	7kizEF3YTJmrcakfBxAQ6yeLeQrm8y2tP0ibzPH0zMhtEtRssyZFCVA+9mFoM51FC3go
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr26612495e9.33.1758284775635;
        Fri, 19 Sep 2025 05:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExVo5Bm/Gvq4znkAjNfJnMZLgqKOOOnEVHm6N4TjEKj5ArkEr2zku7wSBIOGTxDiXnA/4U1w==
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr26612175e9.33.1758284775117;
        Fri, 19 Sep 2025 05:26:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm141809075e9.12.2025.09.19.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:26:14 -0700 (PDT)
Message-ID: <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Fri, 19 Sep 2025 14:26:12 +0200
In-Reply-To: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
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

On Fri, 2025-09-19 at 12:49 +0200, Thomas Wei=C3=9Fschuh wrote:
> Reactions of the existing reactors are not easily detectable from program=
s
> and also not easily attributable to the triggering task.
> This makes it hard to test the monitors themselves programmatically.
>=20
> The signal reactors allows applications to validate the correct operation=
s
> of monitors either by installing custom signal handlers or by forking a
> child and waiting for the expected exit code.

Thanks, this looks like a really nice addition!

> For now only SIGBUS is supported, but additional signals can be added.

Curious choice of a default signal, is this specific to your use-case?

We may want to add some kind of reactors options in the future to allow
configuring this, but I'd say it isn't needed for now.

> As the reactors are called from tracepoints they need to be able to run i=
n
> any context. To avoid taking any of the looks used during signal delivery

You probably meant "locks"

> from an invalid context, schedule it through task_work. The delivery will
> be delayed, for example when then sleep monitor detects an invalid sleep.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/reactor_signal.c | 114
> +++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 123 insertions(+)
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index
> 5b4be87ba59d3fa5123a64efa746320c9e8b73b1..dc7b546615a67c811ce94c43bb1db28=
26cd0
> 0c77 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -93,3 +93,11 @@ config RV_REACT_PANIC
> =C2=A0	help
> =C2=A0	=C2=A0 Enables the panic reactor. The panic reactor emits a printk=
()
> =C2=A0	=C2=A0 message if an exception is found and panic()s the system.
> +
> +config RV_REACT_SIGNAL
> +	bool "Signal reactor"
> +	depends on RV_REACTORS
> +	default y
> +	help
> +	=C2=A0 Enables the signal reactor. The signal reactors sends a signal t=
o
> the
> +	=C2=A0 task triggering an exception.

This assumption is not always correct, imagine a failure in the sleep monit=
or
caused by the wakeup event. The offending task is not current but the wakee=
.

This is a bit tricky because reactors don't have access to that task, just =
to
keep the same implementation between per-cpu and per-task monitors.

We may want to revise that, perhaps like Nam is doing with the monitor_targ=
et
thing [1].

Besides, I'm assuming this reactor is only meaningful for monitors written =
to
validate userspace tasks (signals and TWA_RESUME are probably
meaningless/dangerous for kernel threads).

I'm fine with that but you should probably mention it here and/or in the re=
actor
itself, since we have also monitors validating kernel behaviour (see the sc=
hed
collection).

[1] -
https://lore.kernel.org/lkml/9a1b5a8c449fcb4f1a671016389c1e4fca49a351.17549=
00299.git.namcao@linutronix.de

> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index
> 42ff5d5aa9dde3ed2964e0b8d4ab7b236f498319..adf56bbd03ffa0d48de1f0d86ca5fcc=
e1628
> bdba 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> +obj-$(CONFIG_RV_REACT_SIGNAL) +=3D reactor_signal.o
> diff --git a/kernel/trace/rv/reactor_signal.c
> b/kernel/trace/rv/reactor_signal.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..e123786d94371a240beb63b2d1b2f30=
44a46
> 6404
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_signal.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Thomas Wei=C3=9Fschuh, Linutronix GmbH
> + *
> + * Signal RV reactor:
> + *=C2=A0=C2=A0 Prints the exception msg to the kernel message log and se=
nds a signal to
> the offending task.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/mempool.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/rv.h>
> +#include <linux/sched/signal.h>
> +#include <linux/task_work.h>
> +
> +struct rv_signal_work {
> +	struct callback_head twork;
> +	int signal;
> +	char message[256];
> +};
> +
> +static mempool_t *rv_signal_task_work_pool;
> +
> +static void rv_signal_force_sig(int signal, const char *message)
> +{
> +	/* The message already contains a subsystem prefix, so use raw
> printk() */
> +	printk(KERN_WARNING "%s", message);
> +	pr_warn("Killing PID %d with signal %d", task_pid_nr(current),
> signal);
> +	force_sig(signal);
> +}
> +
> +static void rv_signal_task_work(struct callback_head *cbh)
> +{
> +	struct rv_signal_work *work =3D container_of_const(cbh, struct
> rv_signal_work, twork);
> +
> +	rv_signal_force_sig(work->signal, work->message);
> +
> +	mempool_free(work, rv_signal_task_work_pool);
> +}
> +
> +static void rv_reaction_signal(int signal, const char *fmt, va_list args=
)
> +{
> +	struct rv_signal_work *work;
> +	char message[256];
> +
> +	work =3D mempool_alloc_preallocated(rv_signal_task_work_pool);
> +	if (!work) {
> +		pr_warn_ratelimited("Unable to signal through task_work,
> sending directly\n");
> +		vsnprintf(message, sizeof(message), fmt, args);
> +		rv_signal_force_sig(signal, message);
> +		return;
> +	}

Why do you use the task_work at all instead of signalling directly?
If that's something not safe from a (any) tracepoint because it can sleep y=
ou
should definitely not call it if allocation fails.

> +
> +	init_task_work(&work->twork, rv_signal_task_work);
> +	work->signal =3D signal;
> +	vsnprintf(work->message, sizeof(work->message), fmt, args);
> +
> +	/*
> +	 * The reactor can be called from any context through tracepoints.
> +	 * To avoid any locking or other operations not usable from all
> contexts, use TWA_RESUME.
> +	 * The signal might be delayed, but that shouldn't be an issue.
> +	 */
> +	task_work_add(current, &work->twork, TWA_RESUME);
> +}
> +
> +__printf(1, 2)
> +static void rv_reaction_sigbus(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	rv_reaction_signal(SIGBUS, fmt, args);
> +	va_end(args);
> +}
> +
> +static struct rv_reactor rv_sigbus =3D {
> +	.name		=3D "sigbus",
> +	.description	=3D "Kill the current task with SIGBUS",
> +	.react		=3D rv_reaction_sigbus,
> +};

Let's be consistent and call this reactor "signal", you can use SIGBUS only=
 in
the description until/if we allow different signals.

What do you think?

Thanks,
Gabriele



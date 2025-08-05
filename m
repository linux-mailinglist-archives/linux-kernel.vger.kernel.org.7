Return-Path: <linux-kernel+bounces-756125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF7FB1B04E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4973B65F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA0253F11;
	Tue,  5 Aug 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO8NL2as"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DC2494C2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383241; cv=none; b=RUhbxuKYXn8s3bMoTJkS7IShaUNzBblkrmQT00cJHQrmlkSGcGfuN6qAs4g7Pzu4Ds61tkxH5ErqUbL9Wd89uHrszzOJtmnKLpTLejXtbPAX7q4xhx6xbrNn4jgmLfCP5twv7eqKMPoOY56V2YBWfSBXHiFFx8QUMvwCsFlIKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383241; c=relaxed/simple;
	bh=le/Wvan7fkAw3mn3n2k7HgTyhv1xG3nFfRlSKxDvMD0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l822PqffadMSNk71wZV2zqKZox0dI+1D3asyLYamPV+h/cUaC57SmyhcXn4teY3D1P94FCPKAFl3hyWB1ZWzGVcX/VPhzvOnmBsJmZnaq70+CM+Xn6WEcK/0McvyBSgx5YYnfbBTAC5NHOKjywGtSfN2MbsA0YkvAjFKxX+NPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO8NL2as; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754383237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+IC70/RTqTB2gnQ0vbDz5H3dkDco044aKQEBYM9Czs=;
	b=CO8NL2asJlrw6wopO858YxfIZFJ6W7ODOPhPoFS48LXAbv/993PpoFmX+ig2aLxLI0Hzwr
	6iLmo/nrsWT6XyJbA+4j6q3FXVIHh1zhaqBIXQJ9rzYkwNgo8oA71D5Y0sgn+C1efQMYQF
	v7VpqX+/aRqg8DiROzHuA8E+9DPtjU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-W8oSvCOyOBSdt2j15OsqgA-1; Tue, 05 Aug 2025 04:40:34 -0400
X-MC-Unique: W8oSvCOyOBSdt2j15OsqgA-1
X-Mimecast-MFC-AGG-ID: W8oSvCOyOBSdt2j15OsqgA_1754383233
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459d7da3647so12572035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383233; x=1754988033;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+IC70/RTqTB2gnQ0vbDz5H3dkDco044aKQEBYM9Czs=;
        b=n35CRpNyMMTp2m8aPQDBVbY5x+/V20jQDFoQ5idUdTOLbSF31QmzrlevPojyJYWJM6
         l1sMdJnXNRxKbb13lCPYGosV/Lcxjn+vs66lvQr0YgrWqlJ/O8VFWcd7EebIHyfciyYX
         OCEctCHUeW4sqdaZhgLJctGyyDM3NgO12Gqqh+q5laPDOMYVb5v2YqJ3IBMK2WsavwEE
         2clLD0R2jJuYovAXUd0ucBM1cE3iHq8AeP/jE5GSATCXNYOp7fSaVZ+cpm2ieT8lgg4s
         AB11p+nv7wGgH39FQoGnOJZbCneLDSzJaZGZzIY4bXcDlmf40SumaoA70iKrg2bzLFIs
         rK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVz7h6NDB9ci+xVtYymQxyE+AFgU6LCL275PRCJ2gZxMl3mLITG4ErppSEwmz73L0hp1aCveATzulSjR8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qyVW72KssAAdVjtMe0a/u4lPZeCVw/E1aNjglgXt7ZN0bkbn
	Z+hSHuYMCVvVfQmhwsurtgeC3SAbGu+Y05OibUvBXxMEHWbg62Buw18hW02j/C/rw9w2hnhLSTX
	tsPktbp5FHNxaAGRbtR5ERlRaGTJssGhCixtmpEFbpFmWnX0v2QQaMlr3Q/rhOWNSNA==
X-Gm-Gg: ASbGncvsDnFb4le21us0NX4qVfKBbz05czw/1fjm3GMXeMkB7+NhFwtzmvqZWPfSpP+
	38u9SO123+vEnV8lUqwGdgDn5FQ1d1kq1m9AHWkKXkNp911pEemv21j+8vZ6eyayqrdQcKdcety
	Octi9EnnfSF+qclYgzsw1ETF0H04iaTAURQAfJ1+dPBcFvF2w1lEamJf69nPzWxzPGqiu6D1ueT
	J8K0oTQMfoVDoaVmDQr690mGZpz7jQtdrZjxGsQOwSCTGg7TAnM3MWOXANwtfdZsxE3imUqDNLa
	qKdHdaSu0cEGIZvEuxuZdHr/mxP0H6qGXZwkDVGyfqbzW6XAzQj2Redo0/fRcXRlcg==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-458b69f2c1fmr112792365e9.2.1754383233228;
        Tue, 05 Aug 2025 01:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXkz7yJxMJRXO7x7Pqbkwu+fuUUUkCO0wHwuYcC2A1NgNZuooTmjERjvi3xOdnENJNnRES1w==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-458b69f2c1fmr112791985e9.2.1754383232756;
        Tue, 05 Aug 2025 01:40:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de85efb0sm51611085e9.7.2025.08.05.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:40:32 -0700 (PDT)
Message-ID: <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 05 Aug 2025 10:40:30 +0200
In-Reply-To: <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
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

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible
> scheduling policies
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Hello Nam,

I just built and booted up the monitor in a VM (virtme-ng), the
configuration has preemptirq tracepoints and all monitors so far (as we
have seen earlier, it doesn't build if rtapp monitors are not there
because of the circular dependency in the tracepoints).

All I did was to enable the monitor and printk reactor, but I get a
whole lot of errors (as in, I need to quit the VM for it to stop):

[ 1537.699834] rv: rts: 7: violation detected
[ 1537.699930] rv: rts: 3: violation detected
[ 1537.701827] rv: rts: 6: violation detected
[ 1537.704894] rv: rts: 0: violation detected
[ 1537.704925] rv: rts: 0: violation detected
[ 1537.704988] rv: rts: 3: violation detected
[ 1537.705019] rv: rts: 3: violation detected
[ 1537.705998] rv: rts: 0: violation detected
[ 1537.706024] rv: rts: 0: violation detected
[ 1537.709875] rv: rts: 6: violation detected
[ 1537.709921] rv: rts: 6: violation detected
[ 1537.711241] rv: rts: 6: violation detected

Curiously enough, I only see those CPUs (0, 3, 6 and 7).
Other runs have different CPUs but always a small subset (e.g. 10-15,
6-7=C2=A0only 2).
It doesn't always occur but enabling/disabling the monitor might help
triggering it.

Any idea what is happening?

Thanks,
Gabriele

> ---
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 ++++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rts/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 17 +++
> =C2=A0kernel/trace/rv/monitors/rts/rts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 131
> +++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 126
> ++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts_trace.h |=C2=A0 15 +++
> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A08 files changed, 315 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
> =C2=A0create mode 100644 tools/verification/models/sched/rts.ltl
>=20
> diff --git a/Documentation/trace/rv/monitor_sched.rst
> b/Documentation/trace/rv/monitor_sched.rst
> index 3f8381ad9ec7..2f9d62a1af1f 100644
> --- a/Documentation/trace/rv/monitor_sched.rst
> +++ b/Documentation/trace/rv/monitor_sched.rst
> @@ -396,6 +396,25 @@ preemption is always disabled. On non-
> ``PREEMPT_RT`` kernels, the interrupts
> =C2=A0might invoke a softirq to set ``need_resched`` and wake up a task.
> This is
> =C2=A0another special case that is currently not supported by the monitor=
.
> =C2=A0
> +Monitor rts
> +-----------
> +
> +The real-time scheduling monitor validates that tasks with real-time
> scheduling
> +policies (`SCHED_FIFO` and `SCHED_RR`) are always scheduled before
> tasks with
> +normal and extensible scheduling policies (`SCHED_OTHER`,
> `SCHED_BATCH`,
> +`SCHED_IDLE`, `SCHED_EXT`):
> +
> +.. literalinclude:: ../../../tools/verification/models/sched/rts.ltl
> +
> +Note that this monitor may report errors if real-time throttling or
> fair
> +deadline server is enabled. These mechanisms prevent real-time tasks
> from
> +monopolying the CPU by giving tasks with normal and extensible
> scheduling
> +policies a chance to run. They give system administrators a chance
> to kill a
> +misbehaved real-time task. However, they violate the scheduling
> priorities and
> +may cause latency to well-behaved real-time tasks. Thus, if you see
> errors from
> +this monitor, consider disabling real-time throttling and the fair
> deadline
> +server.
> +
> =C2=A0References
> =C2=A0----------
> =C2=A0
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 951c2e0cda25..3992ff6ac8b1 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -62,6 +62,7 @@ source "kernel/trace/rv/monitors/sts/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/nrp/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sssw/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/opid/Kconfig"
> +source "kernel/trace/rv/monitors/rts/Kconfig"
> =C2=A0# Add new sched monitors here
> =C2=A0
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 750e4ad6fa0f..d7bfc7ae6677 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_RV_MON_STS) +=3D monitors/sts/sts.o
> =C2=A0obj-$(CONFIG_RV_MON_NRP) +=3D monitors/nrp/nrp.o
> =C2=A0obj-$(CONFIG_RV_MON_SSSW) +=3D monitors/sssw/sssw.o
> =C2=A0obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> +obj-$(CONFIG_RV_MON_RTS) +=3D monitors/rts/rts.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/rts/Kconfig
> b/kernel/trace/rv/monitors/rts/Kconfig
> new file mode 100644
> index 000000000000..1b780bce6133
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_RTS
> +	depends on RV
> +	select RV_LTL_MONITOR
> +	depends on RV_MON_SCHED
> +	default y
> +	select LTL_MON_EVENTS_IMPLICIT
> +	bool "rts monitor"
> +	help
> +	=C2=A0 Add support for RTS (real-time scheduling) monitor which
> validates
> +	=C2=A0 that real-time-priority tasks are scheduled before
> SCHED_OTHER tasks.
> +
> +	=C2=A0 This monitor may report an error if RT throttling or
> deadline server
> +	=C2=A0 is enabled.
> +
> +	=C2=A0 Say Y if you are debugging or testing a real-time system.
> diff --git a/kernel/trace/rv/monitors/rts/rts.c
> b/kernel/trace/rv/monitors/rts/rts.c
> new file mode 100644
> index 000000000000..e23563c47eb1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <linux/sched/deadline.h>
> +#include <linux/sched/rt.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "rts"
> +
> +#include <trace/events/sched.h>
> +#include <rv_trace.h>
> +#include <monitors/sched/sched.h>
> +
> +#include "rts.h"
> +#include <rv/ltl_monitor.h>
> +
> +static DEFINE_PER_CPU(unsigned int, nr_queued);
> +
> +static void ltl_atoms_fetch(unsigned int cpu, struct ltl_monitor
> *mon)
> +{
> +}
> +
> +static void ltl_atoms_init(unsigned int cpu, struct ltl_monitor
> *mon,
> +			=C2=A0=C2=A0 bool target_creation)
> +{
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH, false);
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
> +
> +	/*
> +	 * This may not be accurate, there may be enqueued RT tasks.
> But that's
> +	 * okay, the worst we get is a false negative. It will be
> accurate as
> +	 * soon as the CPU no longer has any queued RT task.
> +	 */
> +	ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
> +}
> +
> +static void handle_enqueue_task_rt(void *data, int cpu, struct
> task_struct *task)
> +{
> +	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +	(*queued)++;
> +	ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, true);
> +}
> +
> +static void handle_dequeue_task_rt(void *data, int cpu, struct
> task_struct *task)
> +{
> +	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +	/*
> +	 * This may not be accurate for a short time after the
> monitor is
> +	 * enabled, because there may be enqueued RT tasks which are
> not counted
> +	 * torward nr_queued. But that's okay, the worst we get is a
> false
> +	 * negative. nr_queued will be accurate as soon as the CPU
> no longer has
> +	 * any queued RT task.
> +	 */
> +	if (*queued)
> +		(*queued)--;
> +	if (!*queued)
> +		ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, false);
> +}
> +
> +static void handle_sched_switch(void *data, bool preempt, struct
> task_struct *prev,
> +				struct task_struct *next, unsigned
> int prev_state)
> +{
> +	unsigned int cpu =3D smp_processor_id();
> +	struct ltl_monitor *mon =3D ltl_get_monitor(cpu);
> +
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, rt_task(next));
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, dl_task(next));
> +	ltl_atom_update(cpu, LTL_SCHED_SWITCH, true);
> +
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
> +	ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
> +	ltl_atom_update(cpu, LTL_SCHED_SWITCH, false);
> +}
> +
> +static int enable_rts(void)
> +{
> +	int retval;
> +
> +	retval =3D ltl_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> +	rv_attach_trace_probe("rts", dequeue_task_rt_tp,
> handle_dequeue_task_rt);
> +	rv_attach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +
> +	return 0;
> +}
> +
> +static void disable_rts(void)
> +{
> +	rv_detach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> +	rv_detach_trace_probe("rts", dequeue_task_rt_tp,
> handle_dequeue_task_rt);
> +	rv_detach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +
> +	ltl_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_rts =3D {
> +	.name =3D "rts",
> +	.description =3D "Validate that real-time tasks are scheduled
> before lower-priority tasks",
> +	.enable =3D enable_rts,
> +	.disable =3D disable_rts,
> +};
> +
> +static int __init register_rts(void)
> +{
> +	return rv_register_monitor(&rv_rts, &rv_sched);
> +}
> +
> +static void __exit unregister_rts(void)
> +{
> +	rv_unregister_monitor(&rv_rts);
> +}
> +
> +module_init(register_rts);
> +module_exit(unregister_rts);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("rts: Validate that real-time tasks are scheduled
> before lower-priority tasks");
> diff --git a/kernel/trace/rv/monitors/rts/rts.h
> b/kernel/trace/rv/monitors/rts/rts.h
> new file mode 100644
> index 000000000000..9fbf0d97c1a7
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * C implementation of Buchi automaton, automatically generated by
> + * tools/verification/rvgen from the linear temporal logic
> specification.
> + * For further information, see kernel documentation:
> + *=C2=A0=C2=A0 Documentation/trace/rv/linear_temporal_logic.rst
> + */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME rts
> +
> +#define LTL_MONITOR_TYPE LTL_CPU_MONITOR
> +
> +enum ltl_atom {
> +	LTL_RT_TASK_ENQUEUED,
> +	LTL_SCHED_SWITCH,
> +	LTL_SCHED_SWITCH_DL,
> +	LTL_SCHED_SWITCH_RT,
> +	LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +	static const char *const names[] =3D {
> +		"rt_ta_en",
> +		"sc_sw",
> +		"sc_sw_dl",
> +		"sc_sw_rt",
> +	};
> +
> +	return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +	S0,
> +	S1,
> +	S2,
> +	S3,
> +	S4,
> +	RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
> +
> +static void ltl_start(unsigned int cpu, struct ltl_monitor *mon)
> +{
> +	bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon-
> >atoms);
> +	bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon-
> >atoms);
> +	bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
> +	bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon-
> >atoms);
> +	bool val13 =3D !rt_task_enqueued;
> +	bool val8 =3D sched_switch_dl || val13;
> +	bool val9 =3D sched_switch_rt || val8;
> +	bool val6 =3D !sched_switch;
> +	bool val1 =3D !rt_task_enqueued;
> +
> +	if (val1)
> +		__set_bit(S0, mon->states);
> +	if (val6)
> +		__set_bit(S1, mon->states);
> +	if (val9)
> +		__set_bit(S4, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int
> state, unsigned long *next)
> +{
> +	bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon-
> >atoms);
> +	bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon-
> >atoms);
> +	bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
> +	bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon-
> >atoms);
> +	bool val13 =3D !rt_task_enqueued;
> +	bool val8 =3D sched_switch_dl || val13;
> +	bool val9 =3D sched_switch_rt || val8;
> +	bool val6 =3D !sched_switch;
> +	bool val1 =3D !rt_task_enqueued;
> +
> +	switch (state) {
> +	case S0:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (val6)
> +			__set_bit(S1, next);
> +		if (val9)
> +			__set_bit(S4, next);
> +		break;
> +	case S1:
> +		if (val6)
> +			__set_bit(S1, next);
> +		if (val1 && val6)
> +			__set_bit(S2, next);
> +		if (val1 && val9)
> +			__set_bit(S3, next);
> +		if (val9)
> +			__set_bit(S4, next);
> +		break;
> +	case S2:
> +		if (val6)
> +			__set_bit(S1, next);
> +		if (val1 && val6)
> +			__set_bit(S2, next);
> +		if (val1 && val9)
> +			__set_bit(S3, next);
> +		if (val9)
> +			__set_bit(S4, next);
> +		break;
> +	case S3:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (val6)
> +			__set_bit(S1, next);
> +		if (val9)
> +			__set_bit(S4, next);
> +		break;
> +	case S4:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (val6)
> +			__set_bit(S1, next);
> +		if (val9)
> +			__set_bit(S4, next);
> +		break;
> +	}
> +}
> diff --git a/kernel/trace/rv/monitors/rts/rts_trace.h
> b/kernel/trace/rv/monitors/rts/rts_trace.h
> new file mode 100644
> index 000000000000..0ac9e112a8b0
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts_trace.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_RTS
> +DEFINE_EVENT(event_ltl_monitor, event_rts,
> +	TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +	TP_ARGS(cpu, states, atoms, next));
> +
> +DEFINE_EVENT(error_ltl_monitor, error_rts,
> +	TP_PROTO(unsigned int cpu),
> +	TP_ARGS(cpu));
> +#endif /* CONFIG_RV_MON_RTS */
> diff --git a/tools/verification/models/sched/rts.ltl
> b/tools/verification/models/sched/rts.ltl
> new file mode 100644
> index 000000000000..90872bca46b1
> --- /dev/null
> +++ b/tools/verification/models/sched/rts.ltl
> @@ -0,0 +1,5 @@
> +RULE =3D always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
> +
> +SCHEDULE_RT_NEXT =3D (not SCHED_SWITCH) until (SCHED_SWITCH_RT or
> EXCEPTIONS)
> +
> +EXCEPTIONS =3D SCHED_SWITCH_DL or not RT_TASK_ENQUEUED



Return-Path: <linux-kernel+bounces-759194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F5B1D9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C432A5846CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193525DD07;
	Thu,  7 Aug 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4LqvezB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938911AC88A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577269; cv=none; b=B4e+5jOwr9KoU5KPl/DuwFSTULQXCJvQxLvAWYg8Yqd8RllT7UyBl4oCMvqRC6aRIyF6VhVy0p2PFcYR1qckQQRKpY7LZraiC9FPJObNmZulRqv73I7VuxFbzmnJN32sa/eQa1/Po7k0R6uGctDayh4OiPWeyLWlcFkY8y+eVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577269; c=relaxed/simple;
	bh=R4RqRdl7nr/8Yyh0O6TGufjFwZRcVMdHUnrdVDJwM5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJ0JypbKaDkM12iIka02NYXprs04gHaczQVONYnJJsdvhGm6XfnCez/50n1XGX9jppHMs5w6Lksz7vf2tKMUsoPV/c41IFO3Ic/jlRj0j2Z9vwnp9KqvxI0mWPnedvAJb11uWYLU1xAdSbe48pjg5xyA9DO/ewrU4j045LeSHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4LqvezB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T8JhdPbjaG7LJYzZIp+ylPJV8hHjzRxow/loSvjwY9k=;
	b=f4LqvezBrVj1y4iJosUOuGUew1xa7+MQx0rA3r49m3ANoxdNg4PIaa8nKfHaQU1HdwjPyH
	7OZ9vTgvMCAEb3jiIgEUcaEkZpbkmAREQRAUTQcnjsOiDqhuYIEXXOUDLx1EH6Ni4UPfNU
	7TuxEPi/ugZMj5eSL5hec4Y17FdvcHU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-VShzgg4mODuv3OU1jQUkvA-1; Thu, 07 Aug 2025 10:34:25 -0400
X-MC-Unique: VShzgg4mODuv3OU1jQUkvA-1
X-Mimecast-MFC-AGG-ID: VShzgg4mODuv3OU1jQUkvA_1754577265
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b096d8fc3bso24393211cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577265; x=1755182065;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8JhdPbjaG7LJYzZIp+ylPJV8hHjzRxow/loSvjwY9k=;
        b=gB9i5hf6f1fHoVCuWApNC/IgFei/pxt3odURNGoTm/AOrepxMIWCmua/+Cr9MXNizS
         NwHsM5rnG4XHlSRz0uWks8OmmEBdIEfhge0pxICZK550t8E3K1ZCVyLUM1YrL6+dmg5g
         PJCRD4cCy1pKYOk+O98/syfkDXxkcr72m68xf8ACd+E/wEaZG6UocSPyBVflvQYudl8y
         iX/4JVXjOF6/qARe49QwUUSE02VvhmpDcR0aTsqfmMyycCviOtt1vbpHTSCSE7Va7Ksx
         GvNUl32eAz2x4J2cYCdnAedlZmwxKivtYGs5hDVCeQ2Lm21nRjY8hfb+7QUTwE2R7pu/
         EwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSsnPeU+WX1jPX42QyfcZ6TXAt6JqrVGy5syJkyho2s49qHWY81d4rNxmA180MFTLEZ8QN6WukY5U0IwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CO+AwqUIZ2Ni+nsYy/KSBr3Ab+2f+pRzpzrWH/8Ntby4/8qC
	xYETd2eXLk9cu/g6SRpMCAo14mI6hcfGXXPGq+rzT/AqG5YpFMjN4bcMqbRSs6eATWdn9fzyPyA
	8HAQPQU1/bcJuTK+HyhjCGYlYUEUYGlyvzlByK0aomlEpS2ECuYm00FpnrE8yrwVUGA==
X-Gm-Gg: ASbGncud1omDup4/x6TuOEwTe4uH91IcTsfs91NAHSbGZr1PBxvnjz1yVUphZaqYgwT
	NawNHjV+PH2rr4UzrVaIsfVilCIe5EkDzbDGJXpxAwFYvS8AKBd3mXsBkF1Gsl8lZYLrwvI0J10
	PqJeP837nD0yWscautCco4suCoZabkmoJdznYo5SI8aVrnhMSMkXf24JC3+GbvIt8XJJgnbYXmU
	zqAN/e86EYHnfWQ1msIY9AXoEZmTkeiwdnZ3OPN4XnBOnuCVeNpicnA7TaHlPOEtJpehqTIFZ4Y
	7XqwShzTwUnFstNKCjodmwMYNcMXt69OJW/KZm0PR9eNfdJ+n6PgLbtO+M4hZH27zg==
X-Received: by 2002:a05:622a:2b49:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b091557f51mr103085511cf.35.1754577264717;
        Thu, 07 Aug 2025 07:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeQaz8gvnURliGGeO14IZFbkhaXotOsQNsr+/7ky7JlqogY8m9QAQ1+9NYNz4DpwDy16cgZg==
X-Received: by 2002:a05:622a:2b49:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b091557f51mr103084901cf.35.1754577264158;
        Thu, 07 Aug 2025 07:34:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81237b2e2sm319451385a.72.2025.08.07.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:34:23 -0700 (PDT)
Message-ID: <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak	 <kprateek.nayak@amd.com>
Date: Thu, 07 Aug 2025 16:34:19 +0200
In-Reply-To: <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
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

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible scheduling policies
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

The monitor shows a violation also in case of priority inversion
boosting, e.g.:

 stress-ng --prio-inv 2

It seems perfectly reasonable from the monitor description but it's
actually a behaviour meant to improve real time response.
Is the user seeing this type of violation supposed to make sure all
locks held by RT tasks are never shared by fair tasks? If that's the
case I'd mention it in the description.


Also very rarely I see failures while cleaning up the monitor, not sure
exactly what caused it but I could reproduce it with something like:

  for i in $(seq 100); do timeout -s INT 2 rv mon rts -r printk; done

Running the monitor without stopping for the same amount of time
doesn't seem to show violations (until I terminate it).

"rv" here is the tool under tools/verifications/rv, also the rv package
on fedora works, but debian/ubuntu may still be shipping an outdated
version, if they ship one at all.

Thanks,
Gabriele

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v2:
> =C2=A0 - use the new tracepoints
> =C2=A0 - move to be under the rtapp container monitor
> =C2=A0 - re-generate with the modified scripts
> =C2=A0 - fixup incorrect enqueued status
> ---
> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 +++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rts/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 17 +++
> =C2=A0kernel/trace/rv/monitors/rts/rts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 144
> +++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 126 ++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts_trace.h |=C2=A0 15 +++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A09 files changed, 329 insertions(+)
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
> index 7ef89006ed50..e9007ed32aea 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -67,6 +67,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/pagefault/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sleep/Kconfig"
> +source "kernel/trace/rv/monitors/rts/Kconfig"
> =C2=A0# Add new rtapp monitors here
> =C2=A0
> =C2=A0# Add new monitors here
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
> index 000000000000..5481b371bce1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_RTS
> +	depends on RV
> +	select RV_LTL_MONITOR
> +	depends on RV_MON_RTAPP
> +	default y
> +	select LTL_MON_EVENTS_CPU
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
> index 000000000000..b4c3d3a4671d
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.c
> @@ -0,0 +1,144 @@
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
> +#include <monitors/rtapp/rtapp.h>
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
> +static void handle_enqueue_task(void *data, int cpu, struct
> task_struct *task)
> +{
> +	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +	if (!rt_task(task))
> +		return;
> +
> +	(*queued)++;
> +	ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, true);
> +}
> +
> +static void handle_dequeue_task(void *data, int cpu, struct
> task_struct *task)
> +{
> +	unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +	if (!rt_task(task))
> +		return;
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
> +	unsigned int cpu;
> +	int retval;
> +
> +	retval =3D ltl_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +		*queued =3D 0;
> +	}
> +
> +	rv_attach_trace_probe("rts", dequeue_task_tp,
> handle_dequeue_task);
> +	rv_attach_trace_probe("rts", enqueue_task_tp,
> handle_enqueue_task);
> +	rv_attach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +
> +	return 0;
> +}
> +
> +static void disable_rts(void)
> +{
> +	rv_detach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +	rv_detach_trace_probe("rts", enqueue_task_tp,
> handle_enqueue_task);
> +	rv_detach_trace_probe("rts", dequeue_task_tp,
> handle_dequeue_task);
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
> +	return rv_register_monitor(&rv_rts, &rv_rtapp);
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
> index 000000000000..5881f30a38ce
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
> +#define LTL_MONITOR_TYPE RV_MON_PER_CPU
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
> index 000000000000..ac4ea84162f7
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
> +DEFINE_EVENT(event_ltl_monitor_cpu, event_rts,
> +	TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +	TP_ARGS(cpu, states, atoms, next));
> +
> +DEFINE_EVENT(error_ltl_monitor_cpu, error_rts,
> +	TP_PROTO(unsigned int cpu),
> +	TP_ARGS(cpu));
> +#endif /* CONFIG_RV_MON_RTS */
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index bf7cca6579ec..7b3a6fb8ca6f 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -221,6 +221,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_cpu,
> =C2=A0
> =C2=A0	TP_printk("cpu%u: violation detected", __entry->cpu)
> =C2=A0);
> +#include <monitors/rts/rts_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_CPU here
> =C2=A0
> =C2=A0#endif /* CONFIG_LTL_MON_EVENTS_CPU */
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



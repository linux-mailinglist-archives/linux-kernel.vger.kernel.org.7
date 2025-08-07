Return-Path: <linux-kernel+bounces-759146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86EB1D925
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7CA5851FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850322561D1;
	Thu,  7 Aug 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXmkcZqt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AA25DAF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573624; cv=none; b=rsMX7OwrHRITj3B/x6DvcrIS87p3DqE36kQoJVSsffFvONYg1cBtvrD0vceXcuq3ilAjx+yrPyCNvWZMwr+Nh5WXZoMrJ3CbZLQRj3L0MU73nFUBI0DVRYd8XH44s4WFRcZH5RUbBqkyDKb5awjpRovISOPgchP09l+auO+mSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573624; c=relaxed/simple;
	bh=VPaBlCqJSSY33j6aCoeEy8p9brVQKxc6LmHf7nxcjV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8QzAeO0ipX1wzq0jVB2FuWgonyfF42uPcLbwxoDHI6ir8WL83VjyHyPtceHhygqjhghLsFWpmi64IXt8Ss0lTTRUP1/UdUasahoZ0noB41nwyUF21FeW1ocC9bZS6CbaQvJH+S9TLw3RS4Ms3/QE4/flJslDuBTEKfBSgqpziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXmkcZqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JzvjZNuRe7YCX2KZM4OxlwHzZyDCzCQGFpr0/LzBYBo=;
	b=NXmkcZqt6YXQfXxWNmguI1vvUMp1EI+pGY2YyfsansnTtSgstaF+D3C/BfgcX72lG4Uxy3
	ItOmgHwZsE9bWayOgyJsWbaaH4t9doOmsC+quvH4aSeldYW0UldzyTQ8MDFYYWXbmuEyhD
	Fx+AT4MPe+nnmkLSSFNYh3LfkHhqbZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-uR95riayPYuYTtiL4YEf1g-1; Thu, 07 Aug 2025 09:33:40 -0400
X-MC-Unique: uR95riayPYuYTtiL4YEf1g-1
X-Mimecast-MFC-AGG-ID: uR95riayPYuYTtiL4YEf1g_1754573619
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073bfeef28so11348196d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573619; x=1755178419;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzvjZNuRe7YCX2KZM4OxlwHzZyDCzCQGFpr0/LzBYBo=;
        b=vMJ9m9vITxuTEclEl2Ywhha/oYgTMgx2OuNJ0LaM2ip1P0q+9Ybzz0W6awvOXGZ6W/
         mzbTYICGSdsAIGYFBUlFtbIo808CLrq+7pKTDN25gZyaFHjV9mMbvVnxyP9nCiBk7Egx
         +uY8ZHbivJnYPlvYrbdMoBTOIuoECMk0RdH33Ir4qJ4CFHFH9KX+IV5Mnmx5m/ZXTNyA
         o4JQbXE417snABw50MWJSwQ9liuRlJDSawpZZyH1N+nvHgF7NiKhQBp0F1+3izpGsmRa
         jXDPTkp0C6CjpICckZhu4ZaSDewD9iKBei09URXX9S95D/cAygIFZUQbcrqmDbndaCDp
         gTsA==
X-Forwarded-Encrypted: i=1; AJvYcCXO9eDbBSqqRwE8vtJQSXsi4fZj2T4mq8SST1aptjr9rKAv2UUl3Qw+9wnNL54JwjGcObg2/HZG9YDo1bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9jjX3889lHEBZlrP8/c9Y18HHNO15abcn/Edz8KKemarwUZP
	yUYDBi/qtdYPkq0OB0BUKU0nuMZx0R3g6tMH7OUSCUdIzo9xt2gy6Y6K0qJkVpflkWuXf1aAMmX
	t97un09+g2OLDvNvb3TCw0Wr4KlgyByhtWO9szv4M+NWZpqQtxzTNQC4997UFZPOmDQ==
X-Gm-Gg: ASbGncsoHclATRDc20mc0cAcSgVM/OQkbkecpVikc15yMaxJc2XwKHePCKg52ab/TeH
	Hd2CVijzhB6HHnE1BDCkyegiLif8LElu2SrR75FpRVjxadPS+Xosz4IoIuCG7z+vBownEitYWri
	wenoB4Ze9RmvBe5/Pq54hirzX8bfL2z/UJz/+sNSnjuP4mHm5sLQSEtZjCzl2vLYxL4X5AQfAci
	hL6v6zZwUkk5ymqGPY7gM069rJLJDtf+BlEdSzD4PXCdeQQ99RmEMEa0UqXOqYANpqQADcID320
	VXQ+7QHkvvF/y6vhuK6rTkAjn8P4xQzuw8N1HmpQ5xztcCGOfYgvaiDjW8PDi8Mkog==
X-Received: by 2002:a05:6214:1d05:b0:707:4aa0:2f4 with SMTP id 6a1803df08f44-7097ae5dbb2mr85915206d6.20.1754573619034;
        Thu, 07 Aug 2025 06:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX/+DVKAkIMUWAfViHhwH0ZWPtd2exQo2/Ctaqin01+KTwAF+GzoEvfJHNNow4U4RS0EmwKA==
X-Received: by 2002:a05:6214:1d05:b0:707:4aa0:2f4 with SMTP id 6a1803df08f44-7097ae5dbb2mr85914546d6.20.1754573618298;
        Thu, 07 Aug 2025 06:33:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9dff72sm97167506d6.15.2025.08.07.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:33:37 -0700 (PDT)
Message-ID: <957660bfb5c291b5bece9e557f30866728b9aed0.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Aug 2025 15:33:35 +0200
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
> v2:
> =C2=A0 - use the new tracepoints
> =C2=A0 - move to be under the rtapp container monitor
> =C2=A0 - re-generate with the modified scripts
> =C2=A0 - fixup incorrect enqueued status
> ---
> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 +++
> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +

You moved it under rtapp, you probably want to move the LTL model and
the descriptions there too.

Thanks,
Gabriele

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



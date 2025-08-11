Return-Path: <linux-kernel+bounces-763247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E2B21242
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5DC68372F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993F29BD83;
	Mon, 11 Aug 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyX1f6gk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EF311C25
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930135; cv=none; b=I2Apqid4FMWMZA1eC4NU3/1XXSxDeI1yVo8V08FVUW/X75wbwkYGF4g1R7EU4JTIJnPTEfL3c7ISZxOdZi6Pz9Otwyf5lD793fcPLYEQGkHQToIb210xyQI745lLQheQzdB3R8iDokBdhv8sDwhG++oqtPRrWqo2kgI+FKR9bSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930135; c=relaxed/simple;
	bh=z9v1AIbKTQe7fSyT3cnvCa2jZB8QliVNY9+fFmmW7eQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0HI03pUUGmfuzsCW/7iNcq7Pe59n8Zm9e79pT6bXFkL8YvZX7FLILPJ/qx+/NKQ0Vz4dlm4p2Tp4FHz2Dx/qi0vrSCbQrOUwMeTATNYyOHZUKSbAXFp9jrXnLX6DsYuidXHsO2boO5YVRdjmHqu7pSfjTgrL1LUcQYl+RvpavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyX1f6gk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754930132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0QKG6wBAV1bkVMISWx2XgFahcH/Eaz6cooDhL34CFg=;
	b=HyX1f6gkWMygHX02umHxJ93CvKVK7kJtgnKZprZyEluN2MM0IfwaqPxdaCjMsmDO5mk3TT
	8KkjkUmKeuQrmHHALnskYw2D3IeDRRHIGXG2u79eThaUeOEBr8zlVkZ2MQd8PfzK4ZW9mv
	0m6B5l6GuEMQlmRIBdlGgEP4hDyGx/w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Ya5MGdEPNbKA-1fR0iH-dA-1; Mon, 11 Aug 2025 12:35:30 -0400
X-MC-Unique: Ya5MGdEPNbKA-1fR0iH-dA-1
X-Mimecast-MFC-AGG-ID: Ya5MGdEPNbKA-1fR0iH-dA_1754930130
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b78aa2a113so2198094f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754930129; x=1755534929;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0QKG6wBAV1bkVMISWx2XgFahcH/Eaz6cooDhL34CFg=;
        b=imJgxUdQsfhGSck5mz41VNpZIkIVTqJs4apLM0i7qMO5u+OMXnpxIhCz13/wbReyv1
         FJJGyQ30unjUQ0ZofgQp9Tbsy9tQ7GLYOnsONPFFOY/btnjUX+k2G0baKlj2xOsvkYnh
         htXFbPM6nPncJsvavjz6VTiOjlHiWm5WUoeHJ2pCAByTMImw1B+xWoCspBflEiAHnVef
         VRmwcmNt4UKb9kxEHIwsjxNaqXq8O2EzCSdoGvkED3AIKIUsGu1s/PzyWi5o4inQHBSQ
         OX5U8bf8Y2iFBfnMS+LUizEpptl74SIu4KOj3gfh2WW+3ER2KBJ6EnHnJkjTiEqwa7WL
         8LPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfJ22Tlv6QOVqnQsYfAePh0B3/7/0591bMg+vsPil3P01WlWf9xb5/m0EOP4M+u5nOCgbiRFH6Ar9sG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkaYdkSnV3LIwhOQDJaqWOZNbf1c786YSCX6Uci8Cf3N9tabo
	S/Syv4/IWtVnwulWVtWS6MMY2yIMNVROgv4bWKudWn9uFwAOtD12QRyQobr8U5GtVTmB7xjbL2q
	Y4bs0V2ubqA8SLNo723HnyGvr025wy8S1bJhFryjyNWBy8OmFAKnGaZ0N0Xt0z/NxYg==
X-Gm-Gg: ASbGncvzZd+SIfF/NYMtPTeonGnZaLaAnAcWoxlQZudbbhlsCzGp7lI/P1kCXiGo4jL
	Qr6zw5WAdGa+PHIAUxMbS/VO4sM2sgX96mGQ1oc6U3NA4vRa1nQkyXwnfSp3emTFo1gDqAMYzNU
	SS+hGaiBxPO8KDpANaD5kuR1kvg6UInxz81aeUeYWk9qY2GMmAWfsoM33BNTXWBzvGlZlWNmfVM
	iiQVQhzf8iry4nzQ61LcdiGVN5a75aPj0Gec9DBlDhoKnBwlLrjU1rJblkdpbOPkhMrW5/4PuE8
	0zDFjKl+jrV1YROoeef/3l4d7RXJF6CL7+wjBoSmozWUxgT3yvzD9HI2i0p7YicFQGY8LZc5g/r
	xd9ye85Y5NIJSQgk5cVldGdyl
X-Received: by 2002:a05:6000:4305:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b910fd9fefmr319688f8f.17.1754930129478;
        Mon, 11 Aug 2025 09:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYcvsRE2HaDC7ziZhryNH9YA7n2OJOaJVhOuz86thiRjeyohANnUt1UvvZFEtz0r2qQXvOAQ==
X-Received: by 2002:a05:6000:4305:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b910fd9fefmr319661f8f.17.1754930128886;
        Mon, 11 Aug 2025 09:35:28 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm40068633f8f.30.2025.08.11.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:35:28 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>, Ingo
 Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Marcelo
 Tosatti <mtosatti@redhat.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Michal Hocko <mhocko@kernel.org>, "Paul E .
 McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Waiman
 Long <longman@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Add CPU Isolation documentation
In-Reply-To: <20250809094247.8384-1-frederic@kernel.org>
References: <20250809094247.8384-1-frederic@kernel.org>
Date: Mon, 11 Aug 2025 18:35:26 +0200
Message-ID: <xhsmhldnpizox.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/08/25 11:42, Frederic Weisbecker wrote:
> nohz_full was introduced in v3.10 in 2013, which means this
> documentation is overdue for 12 years.
>

12 years is not that bad, it's not old enough to drink (legally) yet!

> The shoemaker's children always go barefoot. And working on timers
> hasn't made me arriving on time either.
>
> Fortunately Paul wrote a part of the needed documentation a while ago,
> especially concerning nohz_full in Documentation/timers/no_hz.rst and
> also about per-CPU kthreads in
> Documentation/admin-guide/kernel-per-CPU-kthreads.rst
>
> Introduce a new page that gives an overview of CPU isolation in general.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  Documentation/admin-guide/cpu-isolation.rst | 338 ++++++++++++++++++++
>  Documentation/admin-guide/index.rst         |   1 +
>  2 files changed, 339 insertions(+)
>  create mode 100644 Documentation/admin-guide/cpu-isolation.rst
>
> diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
> new file mode 100644
> index 000000000000..250027acf7b2
> --- /dev/null
> +++ b/Documentation/admin-guide/cpu-isolation.rst
> @@ -0,0 +1,338 @@
> +=============
> +CPU Isolation
> +=============
> +
> +Introduction
> +============
> +
> +"CPU Isolation" means leaving a CPU exclusive to a given userspace
                                                            ^^^^^^^^^
Eh I'm being nitpicky, but this doesn't have to be userspace stuff right?
"someone" could e.g. affine some IRQ to an isolated CPU to have the
irqthread run undisturbed there, or somesuch.

> +
> +Scheduler domain isolation
> +--------------------------
> +
> +This feature isolates a CPU from the scheduler topology. As a result,
> +the target isn't part of the load balancing. Tasks won't migrate
> +neither from nor to it unless affine explicitly.
                                 ^^^^^^
s/affine/affined/

> +As a side effect the CPU is also isolated from unbound workqueues and
> +unbound kthreads.

> +Checklist
> +=========
> +
> +You have set up each of the above isolation features but you still
> +observe jitters that trash your workload? Make sure to check a few
> +elements before proceeding.
> +
> +Some of these checklist items are similar to those of real time
> +workloads:
> +
> +- Use mlock() to prevent your pages from being swapped away. Page
> +  faults are usually not compatible with jitter sensitive workloads.
> +
> +- Avoid SMT to prevent your hardware thread from being "preempted"
> +  by another one.
> +
> +- CPU frequency changes may induce subtle sorts of jitter in a
> +  workload. Cpufreq should be used and tuned with caution.
> +
> +- Deep C-states may result in latency issues upon wake-up. If this
> +  happens to be a problem, C-states can be limited via kernel boot
> +  parameters such as processor.max_cstate or intel_idle.max_cstate.
> +

Nitpickery again, I know it's not an exhaustive listing, but I'd rather
point to the sysfs cpuidle interface (or just mention it too), since that
means deep C-states can be left enabled for HK CPUs.


Should we also mention BIOS/firmware fuckery like SMIs?

"""
- Your system may be subject to firmware-originating interrupts - x86 has
  System Management Interrupts (SMIs) for example. Check your system BIOS
  to disable such interference, and with some luck your vendor will have
  a BIOS tuning guidance for low-latency operations.
"""

> +Debugging
> +=========
> +
> +Of course things are never so easy, especially on this matter.
> +Chances are that actual noise will be observed in the aforementioned
> +trace.7 file.
> +
> +The best way to investigate further is to enable finer grained
> +tracepoints such as those of subsystems producing asynchronous
> +events: workqueue, timer, irq_vector, etc... It also can be
> +interesting to enable the tick_stop event to diagnose why the tick is
> +retained when that happens.
> +

I'd also list the 'ipi_send*' family, although that's emitted from the HK
CPU, not the disturbed isolated CPU.

> +Some tools may also be useful for higher level analysis:
> +
> +- :ref:`Documentation/tools/rtla/rtla-osnoise.rst <rtla-osnoise>` runs a kernel
> +  tracer that analyzes and output a
> +  summary of the noises.
> +

I'd want to point to hwnoise and timerlat as well, so maybe point to
rtla.rst?

> +- dynticks-testing does something similar but in userspace. It is available
> +  at git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 259d79fbeb94..b5f1fc7d5290 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -94,6 +94,7 @@ likely to be of interest on almost any system.
>
>     cgroup-v2
>     cgroup-v1/index
> +   cpu-isolation
>     cpu-load
>     mm/index
>     module-signing
> --
> 2.50.1



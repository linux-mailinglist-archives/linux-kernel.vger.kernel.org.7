Return-Path: <linux-kernel+bounces-627076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F5AA4AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150F19A0570
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BC25B1F0;
	Wed, 30 Apr 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvOwTZc3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650025B1C0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015459; cv=none; b=E6aE+YDeVkydw//wyAs+8CRtDCs6MaCXFbwsEEybfTe3xM5Lemz9YYP+J7smlkCZnzHBI7uYYB358b75+MqlypFp8V/Sg1haaIN5ou/eGEo2WkCCVyrhUYdjvQT7i9ne3KrhfAC3XqeGhFGptUWDf9bBVqGhwzkxJrbPyIwEvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015459; c=relaxed/simple;
	bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIYcnvrE03qSJ4PgcOx2asXYNZyxM1ilPwHgXqx+qM2W7DCvBzvLjwWSNtlCiOEis6Pf244VEbUqmCvUBmjkzyH0/cGOamZjPJL+COjT5s1XCUmwIT4SqPtaFCwmePyLFD2/ABH5yOrv/mxScDYwPN7nrOwCJvQuZyagoYsRQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvOwTZc3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746015456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
	b=bvOwTZc3PM/7u67F1FJcrYdnVyxeome5PkxoGp4cj6XGeuMZ2240KfNpJOpaVAG95wpnbg
	Rq8m7uAWS4lHIpcJFSe3SAi2cpgEuLkUX9lL22y0sybfGwy+VZmn1Eem7nEzCjqAeOrbnX
	XjCo3KiVeWxaFkfGOyTMiCNRuktOIVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0JtIIWNwM1WJ7v24kSsqdA-1; Wed, 30 Apr 2025 08:17:35 -0400
X-MC-Unique: 0JtIIWNwM1WJ7v24kSsqdA-1
X-Mimecast-MFC-AGG-ID: 0JtIIWNwM1WJ7v24kSsqdA_1746015454
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43f251dc364so39189055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746015454; x=1746620254;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
        b=tXwz2jBb0wKYwrDbzorpwv0m0S1YH+JJtC57WZkmoqrGHmrAcobgDQoY1QHPCoFBxm
         YfHRkMH7X3QvaQTx9CLSX1TlND/mRSNoFxfrHgJzdeTfokJyAq2xpbsLnzNcvbWQpSdf
         Ara++dEeL9Y2ZZofMGlw7Sj5I74LcDJPeCGrTK4JABxnEGGx4U1GwEHjFYKWqKErqr78
         mu87P6Ojt/uW/y1Wbn1X9xnXVlfkzgoE+i4xQxOQtqoPidrR1DWIQgHw26aVXAN7U3fo
         hhuCmFWfWPNZfQ8ryu3i3rtOSlReSXitsdhNuxRHGtRxhkdb+DsQtWRtl8NY3O9PgOld
         X9IA==
X-Forwarded-Encrypted: i=1; AJvYcCUCwj9CR3hYOZXak5O9CKz4uiJV4c6lkbaf2jbk1qBZfkiJ2EBV3E5d5264490cslOSCqZN1lK3dqtqYsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszVwOsBwANlWm7iJ9hAQiiqevompa3rsvLY7I+yL51i6PJrNa
	8h4bVQthALN84UzWK3ZmdGS3odxzScUmEDe1Pw17ySoU1gT+OXUFjYGimIOdmPTiPq1Eerazjjy
	sc8axTrHqML5Uxts6DsOZ1YCfO2x7yzCePBi7jCw4vsbXitpRXsPjOcHvKIU3VA==
X-Gm-Gg: ASbGncsViUNhmgL9PgpFOFnmU/zVO+WwEi9aF02qLQ85QveX9BQMVywvXcErafdhkyw
	7fCoBq5bVTfaelZuwAr1uv9q/bMAV0gZQ8IBn9NQAZAEtFiU6HcvSSGrHm4gD2LANEam7azZGNW
	xFgOyMabnvB0/yXxBGtaCKMDlN+ujWIrLPpDosvTqYMo57CQSRZ/K3Wnfug3kNnxIwNBOouzJ6j
	8jNJ5yJPDQreRtbukXyKjX+tEw5Rfxh4ZrinrSw2WZjIojBxLvRp7wW96Qo9oEgjFfHKzfJ16vo
	jO3zHGi9EPRUwkjEcnouVUEOSwgNnwlvpiz0Nw==
X-Received: by 2002:a05:600c:3b08:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441b43a6849mr12659325e9.31.1746015454196;
        Wed, 30 Apr 2025 05:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeDRQpH85Tjf5lCeTC38YV5zFGOEEWEJ15Q43zpvFHsUBUREIV9t8rFVVspwP+av3krGaKQA==
X-Received: by 2002:a05:600c:3b08:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441b43a6849mr12658865e9.31.1746015453815;
        Wed, 30 Apr 2025 05:17:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a9dsm23611265e9.19.2025.04.30.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:17:33 -0700 (PDT)
Message-ID: <cbcefdb80d5e10b8fed80de17bb97bf61df81386.camel@redhat.com>
Subject: Re: [PATCH v6 00/22] RV: Linear temporal logic monitors for RT
 application
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, john.ogness@linutronix.de, Petr Mladek	
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo
 Molnar	 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin"	 <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, 	linux-arm-kernel@lists.infradead.org, Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2025 14:17:30 +0200
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-30 at 13:02 +0200, Nam Cao wrote:
> Real-time applications may have design flaws causing them to have
> unexpected latency. For example, the applications may raise page
> faults, or
> may be blocked trying to take a mutex without priority inheritance.
>=20
> However, while attempting to implement DA monitors for these real-
> time
> rules, deterministic automaton is found to be inappropriate as the
> specification language. The automaton is complicated, hard to
> understand,
> and error-prone.
>=20
> For these cases, linear temporal logic is found to be more suitable.
> The
> LTL is more concise and intuitive.
>=20
> This series adds support for LTL RV monitor, and use it to implement
> two
> monitors for reporting problems with real-time tasks.
>=20

Steve,

From my point of view this series is ready for inclusion, what do you
think?

We may still need Acks from the x86 and arm64 maintainers regarding the
tracepoints changes, though.

Thanks,
Gabriele

> Patch 1-12 cleanup and prepare the RV code for the integration of LTL
> monitors.
>=20
> Patch 13 adds support for LTL monitors.
>=20
> Patch 14 adds the container monitor "rtapp". This encapsulates the
> sub-monitors for real-time.
>=20
> Patch 15-18 prepares the pagefault tracepoints, so that patch 19 can
> add
> the monitor which watches real-time tasks doing page faults.
>=20
> Patch 20 adds the "sleep" monitor: it detects potential undesirable
> latency
> with real-time threads.
>=20
> Patch 21 adds documentation on the new monitors.
>=20
> Patch 22 allows the number of per-task monitors to be configurable,
> so that
> the two new monitors can be enabled simultaneously.
>=20
> v5->v6
> https://lore.kernel.org/lkml/cover.1745926331.git.namcao@linutronix.de
> =C2=A0 - sleep monitor: Drop the block_on_rt_mutex tracepoints. The
> contention
> =C2=A0=C2=A0=C2=A0 tracepoints are sufficient.
>=20
> v4->v5
> https://lore.kernel.org/lkml/cover.1745390829.git.namcao@linutronix.de
> =C2=A0 - sleep monitor: Fix a false positive due to a race with waking an=
d
> =C2=A0=C2=A0=C2=A0 scheduling.
> =C2=A0 - sleep monitor: Add block_on_rt_mutex tracepoints and use them fo=
r
> =C2=A0=C2=A0=C2=A0 BLOCK_ON_RT_MUTEX, instead of trace_sched_pi_setprio
> =C2=A0 - sleep monitor: tighten the rule on nanosleep: only
> clock_nanosleep()
> =C2=A0=C2=A0=C2=A0 with TIMER_ABSTIME and CLOCK_MONOTONIC is allowed
> =C2=A0 - add comments explaining why it is correct to treat PI-boosted
> tasks as
> =C2=A0=C2=A0=C2=A0 real-time tasks.
>=20
> =C2=A0=C2=A0=C2=A0 It should be noted that due to the changes in v5, 'per=
f' does not
> work
> =C2=A0=C2=A0=C2=A0 as well as before, because sometimes the errors happen=
 out of the
> =C2=A0=C2=A0=C2=A0 real-time tasks' contexts. Fixing this is left for fut=
ure work.
>=20
> =C2=A0=C2=A0=C2=A0 stress-ng is also far noisier in v5, because the rule =
on
> nanosleep is
> =C2=A0=C2=A0=C2=A0 tightened.
>=20
> v3->v4
> https://lore.kernel.org/lkml/cover.1744785335.git.namcao@linutronix.de
> =C2=A0 - support deadline tasks
> =C2=A0 - rtapp_sleep: use sched_pi_setprio tracepoint instead of
> contention
> =C2=A0=C2=A0=C2=A0 tracepoints for BLOCK_ON_RT_MUTEX, so that proxy lock =
is covered.
> =C2=A0 - fix the scripts generating an "slightly" incorrect verification
> automaton
> =C2=A0 - makes rtapp monitor depends on RV_PER_TASK_MONITORS >=3D 2
> =C2=A0 - make the event tracepoint output a bit more readable
> =C2=A0 - some documentation's format fixes
>=20
> v2->v3
> https://lore.kernel.org/lkml/cover.1744355018.git.namcao@linutronix.de/
> =C2=A0 - fix a problem with sleep monitor's specification (around
> =C2=A0=C2=A0=C2=A0 KTHREAD_SHOULD_STOP)
> =C2=A0 - merge the patches that move the dot2k/rvgen scripts around
> =C2=A0 - pull panic/printk changes into separate patches
> =C2=A0 - fixup some build errors
> =C2=A0 - fixup monitor's init function return code
> =C2=A0 - fix some flake8 warnings with the scripts
> =C2=A0 - add some references to LTL documentation
> =C2=A0 - fixup some mistakes with rtapp documentation
> =C2=A0 - fixup capitalization mistake with monitor_synthesis.rst
> =C2=A0 - remove the now-redundant macro RV_PER_TASK_MONITORS
>=20
> v1->v2
> https://lore.kernel.org/lkml/cover.1741708239.git.namcao@linutronix.de/
> =C2=A0 - Integrate the LTL scripts into the existing dot2k tool, taking
> =C2=A0=C2=A0=C2=A0 advantage of the existing monitor generation scripts.
> =C2=A0 - Switch the struct ltl_monitor to use bitmap instead of an array,
> to
> =C2=A0=C2=A0=C2=A0 optimize memory usage.
> =C2=A0 - Correct the generated code to be non-deterministic state machine=
,
> =C2=A0=C2=A0=C2=A0 instead of deterministic state machine
> =C2=A0 - Put common code for all LTL monitors into a single file
> =C2=A0=C2=A0=C2=A0 (include/rv/ltl_monitor.h), reducing code duplication
> =C2=A0 - Change the LTL monitors to make user of container. Add a bug fix
> to
> =C2=A0=C2=A0=C2=A0 container while at it.
> =C2=A0 - Make the number of per-task monitor configurable



Return-Path: <linux-kernel+bounces-897772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7BC539ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ADE5635FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A333B977;
	Wed, 12 Nov 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVAtPhmY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD033970D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965754; cv=none; b=OlNWnHSgmeixyoOu9h6GiSEGeG+sKqmsNqO8uoHuJR9Ipt7B9kb9/xcnM2sA/PPcaql5f2BAUoNASJfP0+XpjOzzt4uXgheV+i+eU7nMff9PILM90CvcTpXftoQHQgn+MyqgL4TzS4EO2w+gVBLWjZToVkANNckHIROf71AGnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965754; c=relaxed/simple;
	bh=/bSxAcGrhRp7L4ufXIbZzzWuihJrDC7nvf+26+tVFgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BATzKiFEP7KZsePv9kpC2WeucpxKMDvyvUQhOBOtQ+gIJYw9v098SoXFYovhrV5mlypRWoQwb8+KqpMdgJ/iGdeIHO0jXuXoT5ZPA5Y9xtwXA047JZd96rGXJHclF6Rnx9HD2D4nZIchZFT0GPm41pRHTpq7ynclvkZDCAvl/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVAtPhmY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so191555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762965753; x=1763570553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oylNPE4uVKQhn2NkMu29EXgAYx+J4vN9SweT4O8izLI=;
        b=cVAtPhmYDHzakEg5I05otGSgoMSQ+hFCpqXQ9Vw5waHd4Aj5E8PkH3m8w8P8WCH4jb
         cciBTzdDTLVKfOa8gy7lPWDAxc7Cwn+d+JWrf7u+NwO1Dg+vv0WcaCcy8WL/2f0mVMua
         JCfc2Omp5bEw7Wc4xlcmr071zl3cks1iZC5HJcttoOoznjChZfeNhtbH5OLBuKapZmFr
         GJI8DJqlVmicfyHMv7nBgLAkcS7hRJ3TM+tXYmd02KteJqrS7snG44d8FSYkXdNWgLWx
         scSrjRiByAIdaplGhXR5we/JZ0KWn/5HqTknpxwQlVDE6Xemo6lRVt+dY0oCr1IxWa3a
         I1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965753; x=1763570553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oylNPE4uVKQhn2NkMu29EXgAYx+J4vN9SweT4O8izLI=;
        b=Z2RNJSAy33E6D7EGte6JiZk6PP0cEl8eE0E9cteFBN9+k9mOvhwjZvbRm6IlEAcEQ/
         tGjeLlbTwwAxM5pxUu2ZYCOg84uu8WQqi4+pBrYA4oybivHBLvwIuqpAgf3EttYbJn0b
         iTkCMiF5GdNRzrEGNLslcxpgNqOrC6kMJjUmcBCTAi+ijb9VRceNuyaB90FjgOqe5cgz
         U3tz6BFyuoZ4gQFqjRSUIlvJx6pMt3Dk9otY9ZmS9SYw9NP6oihFDRtcaKDHjVXRGVs6
         UsVdthFQwApKWaYGLmowlTh1I/h8OGvNd/64ryT9CERynzS47z8ktvJmMzcvVQ+bR482
         rc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWG7CV3dZ9+CQfWEdHrb5td4KmQ8ifyaslgLaaCcdDPRPSbwIU5kUSBaBv0KgMUAwcPUxyi/73X+RJth/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGzgxb2tH4uqP+C8/yz83TpP6XfjMMIBatFU+0N5cljhk3jj0
	gbXebNZflNcrnU9Bl8Vej9yZ9nUUsGsMuUKOgxeSxCz0dXkFngJlC5IfJZtbBF2vNdUhQ8/h7GZ
	L0ZD52b407RSbuwDnmOpZJrNz7DvTBhIuGdPkyF5E
X-Gm-Gg: ASbGncuGykR5iSIanpgBqPvOp4R/a5oMb+XaIPY0fOuvWpklN00hiiwdpsiiuwunX37
	qlRyA80AZJlebNhbeLAIN1n1lfiA1y5YNN05hznkxUy30CihRDCQloWWFrZgLaZhPUTcP6P4r3l
	4PLes6QkJprNXwuxmq2od5a4GW3aEJkPt3ZiteEXil4K1j26qhoXE2fsnT6Iy2Zh1rZrzXCzIb2
	LvsgF6hGdNvZir0AeaVdypFLsb+xaog/JnkyKdMWkJiSb4SqmtlxwwPwnc6UuP/pmeVsYjO9iQv
	iCXx+2fsmaCf074cFh5hMpv2pSKVPRaqreZ8
X-Google-Smtp-Source: AGHT+IGcvt334Z1FGLlZNlTy5sWbRse8K04gLzU4vGzUmOzboVYYpE+qoTjqfj4wk2TEaL9VZwvq7RS13Bg49n/566w=
X-Received: by 2002:a17:903:1a68:b0:295:5138:10f2 with SMTP id
 d9443c01a7336-29850761942mr2777945ad.11.1762965752176; Wed, 12 Nov 2025
 08:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:42:21 -0800
X-Gm-Features: AWmQ_bnM7jWScBcxYA5ih0EnQ4GPvFcr1HhXobUst0RWyHfyQ_qayf9TvN2n1hc
Message-ID: <CAP-5=fUW2CdFnZ3sSOAnEHHqgDV3OB-p3FbfL+KKkvJJ6_smNg@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:07=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> Currently cpu-clock event always returns 0 count, e.g.,
>
> perf stat -e cpu-clock -- sleep 1
>
>  Performance counter stats for 'sleep 1':
>                  0      cpu-clock                        #    0.000 CPUs =
utilized
>        1.002308394 seconds time elapsed
>
> The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
>  error of some clock events")' adds PERF_EF_UPDATE flag check before
> calling cpu_clock_event_update() to update the count, however the
> PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
> counting mode (pmu->dev() -> cpu_clock_event_del() ->
> cpu_clock_event_stop()). This leads to the cpu-clock event count is
> never updated.
>
> To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
> just like what task-clock does. Besides, or flags with PERF_EF_UPDATE
> for task-clock although currently the flags argument would always be 0.
>
> Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks Dapeng! This is a fairly major regression and I'm surprised my
kernel picked it up so quickly. For those interested the relevant part
of the breaking change is requiring PERF_EF_UPDATE:

```
@@ -11829,7 +11834,8 @@ static void cpu_clock_event_start(struct
perf_event *event, int flags)
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
        perf_swevent_cancel_hrtimer(event);
-       cpu_clock_event_update(event);
+       if (flags & PERF_EF_UPDATE)
+               cpu_clock_event_update(event);
 }
 ```

Reviewed-by: Ian Rogers <irogers@google.com>

Hopefully a maintainer can pick this up quickly. Thanks,
Ian

> ---
>
> With this change, both cpu-clock and task-clock can do counting and
> samping correctly.
>
> 1. perf stat -e cpu-clock,task-clock -- true
>
>  Performance counter stats for 'true':
>            240,636      cpu-clock                        #    0.358 CPUs =
utilized
>            243,319      task-clock                       #    0.362 CPUs =
utilized
>
> 2. perf record -e cpu-clock -c 10000 -Iax,bx -- sleep 1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (36 samples) ]
>
> 3. perf record -e task-clock -c 10000 -Iax,bx -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.029 MB perf.data (41 samples) ]
>
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f6a08c73f783..77d3af5959c1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event =
*event, int flags)
>
>  static void cpu_clock_event_del(struct perf_event *event, int flags)
>  {
> -       cpu_clock_event_stop(event, flags);
> +       cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }
>
>  static void cpu_clock_event_read(struct perf_event *event)
> @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event=
 *event, int flags)
>
>  static void task_clock_event_del(struct perf_event *event, int flags)
>  {
> -       task_clock_event_stop(event, PERF_EF_UPDATE);
> +       task_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }
>
>  static void task_clock_event_read(struct perf_event *event)
>
> base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
> prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
> prerequisite-patch-id: 2a0eefce67b21d1f30c272fd8115b0dc1aca3897
> --
> 2.34.1
>


Return-Path: <linux-kernel+bounces-838122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A66BAE7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D311C3A95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805A28934D;
	Tue, 30 Sep 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/1KNLDf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18406233721
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262747; cv=none; b=KKwZyJvolC9POYlCAtmvh3+/vlgo+RvW7S/6G2XZIUS801Zhd2R4CYAP8Dzzrz067+/pPwjdz18kgfoey7JC34BwIFop/ENykENwlgDMWtQWw56yuQd7xBqimdd9xuU+0W+kRP7I2xC/FTMTk67jzJrGir+XCwEok44Hdm8vrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262747; c=relaxed/simple;
	bh=+O7E0xYbdBDkKmgcReNtSO/+rzQoEah3WlLA/TdGzRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s/HzZq8ogyXKTsSF/trazQJ3T+PP+q1MFTSaUNMMU8OpsV68+72SKK9X+Wr/vdra7kFSGseUEDh8iv5FlYibyXtjJ8xLKA+gtyZVvp4aguYCVF3NhOOKnVZ0MeObz7CL+ySAsd82150NqvslqGzs4O2feEtH5v4sLfh0fm0A8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/1KNLDf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2731ff54949so2435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262745; x=1759867545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFCc179Dp3pOElR5ms1mLbchLu5y9iNqzrQelohBmx4=;
        b=2/1KNLDf4jcNrymcFQvVarhWy7MKX/V4VmNEFQcH/ct3RONjr/Q7h3zeFKxuPUtGTS
         1ge7On1vOhxVbCyEywcj175JlNBnWQgT5eWl/Clr1BjFXghWnvn7x1XU2mjD+6yUZqT5
         OcepLL59dvMR1Zp5D3iKvqlhgCmtzR6F4vbz/3H53RjmZ6IF4liDLlvMRM0IBCo3k2CS
         xPN4K3OcpqF1WwQSHbUdzVzhgZxfL3BVZyBK/ozwqwa6wCY+RRXaYOnbQSGYtL9xlOWQ
         Fgzt3EulyLAAGGY9O2dYGcsnc9R51x09OB2w6rHLB0vGxtPUCdFu3sf+WwmVV9ptB26t
         7Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262745; x=1759867545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFCc179Dp3pOElR5ms1mLbchLu5y9iNqzrQelohBmx4=;
        b=C+xiJEctgwRn9ToqAe1o5GP9o47IlVRHnS7MZvyktmpQDvdVjsszTt+gO26VDechme
         rv8W8JqvHRwv79czypc+x0mRhekF6YRyKm52So6/GqPCgZE32k2PdYq1sJcKMZExBdpp
         P3tG2vTf+nVAbfsg/bDqeQmYAE55l79P3CfVDpySpzP7elNkZMmXlKRafbwrDocN0G5s
         3HReVTuccu8vHI2CUCar5i8A6XpzRjH9l4ZMSXE4Hedpgs/r8RwY+/Z29ULnYMkdpqxQ
         aoXCfQ/KXtwPn1pB71M41sNiD7n+DxBg2hGI8BGHFpaHrOx1LVcKYGmNxJaF4dMLSks0
         ne0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9PTS2VS2h2JNzaWOPGklXvueJMpML1q/Zr2yLY8SCZzLH9OVJ3jYZer0HCdFzapG0ursWDS98V2712qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IkUw+NkI8+XbJFlb1AC+jUNqAwrrcgPg5pinv1d6LMQnthx3
	mBlCkKSOsP3vNfnPM6yAObxl3AAKdPmMhfDf+ZpjREb4VUKsr4yHNTfbdFtESt4W9LVw2iNoQ9x
	MiSKvgK324TEAHsWUvQAWPZiSCX5L66nSIMA9GmEK
X-Gm-Gg: ASbGnctuuMal5VYpR3HFlpv56FlUtQckxHT9+bWCIwj2SIf8eRyqecIYVmqkBsHP0wy
	ba2mqQLUky7rYTIpuT5Zp93oqar6R9pFF0SVSKUQLHfISP4sdIO1GfRYcC3XkUkrMzL3pVNF0cu
	ifpTrZfYtQiHAV72k2QIp5qVCXKDr0IjXYHVAJWy9KQ0R/ql8yMC/LZO27cvtxtVbm5pC5nVvc6
	AgMnHm8UUY7QZKWtBvsE/UCFEpRhY7FWonjsdiRj+albEW5/xz7LDxI4VO6jAAGDIXr
X-Google-Smtp-Source: AGHT+IHHh9JevAZ7PaehVwgw6+jzVxzZ+2niK6DzklvkWwaIz9NijM5RmLov0xxykDGhNUTPGnG8FkD21SWdtww5YhY=
X-Received: by 2002:a17:903:2c9:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-28e8003e1a8mr986365ad.12.1759262745053; Tue, 30 Sep 2025
 13:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914183353.1962899-1-irogers@google.com>
In-Reply-To: <20250914183353.1962899-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:05:33 -0700
X-Gm-Features: AS18NWAWr0cMyC7kAVVOvYHKqJ8zIPeQHKH65rFC18TxONt4GIIpxrAGDbGzuOo
Message-ID: <CAP-5=fV59uES4ZkNHDUypeO0XSnjkUTDWLydvaymEsegyeSb-w@mail.gmail.com>
Subject: Re: [PATCH v1] perf sched: Avoid union type punning undefined behavior
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 11:33=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> A union is used to set the priv value in thread (a void*) to a boolean
> value through type punning. Undefined behavior sanitizer fails on this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index f166d6cbc083..eca3b1c58c4b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1532,35 +1532,24 @@ static int process_sched_wakeup_ignore(const stru=
ct perf_tool *tool __maybe_unus
>         return 0;
>  }
>
> -union map_priv {
> -       void    *ptr;
> -       bool     color;
> -};
> -
>  static bool thread__has_color(struct thread *thread)
>  {
> -       union map_priv priv =3D {
> -               .ptr =3D thread__priv(thread),
> -       };
> -
> -       return priv.color;
> +       return thread__priv(thread) !=3D NULL;
>  }
>
>  static struct thread*
>  map__findnew_thread(struct perf_sched *sched, struct machine *machine, p=
id_t pid, pid_t tid)
>  {
>         struct thread *thread =3D machine__findnew_thread(machine, pid, t=
id);
> -       union map_priv priv =3D {
> -               .color =3D false,
> -       };
> +       bool color =3D false;
>
>         if (!sched->map.color_pids || !thread || thread__priv(thread))
>                 return thread;
>
>         if (thread_map__has(sched->map.color_pids, tid))
> -               priv.color =3D true;
> +               color =3D true;
>
> -       thread__set_priv(thread, priv.ptr);
> +       thread__set_priv(thread, color ? ((void*)1) : NULL);
>         return thread;
>  }
>
> --
> 2.51.0.384.g4c02a37b29-goog
>


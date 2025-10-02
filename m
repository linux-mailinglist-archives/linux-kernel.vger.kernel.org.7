Return-Path: <linux-kernel+bounces-840453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B8BB475C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1618C3A8A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39074242D93;
	Thu,  2 Oct 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN9Ycp3M"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9D241CB6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421679; cv=none; b=uF9Fa3shgc/65saVAYyM6tiQTBNyzdIH2mcEtTBpvw57ABoNZUDoCqUHp8sQixY5UcAz/C8c8T7sQoMtM8kXQWOrTqSuk5yC/ppG8hu9LA0s+yqiKiuQc+DXO+Cz2klP8PE9xqu3ok8mhQRBuNe2FKnILfHAZG8n/1I5XV1W22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421679; c=relaxed/simple;
	bh=rhLVxpfQGbtVJNyFj+iCQzU2hwWz2cS2k+5lVPxuSX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzgPRRnW8MC82UBGjFBJNtO2JsiTfFfYoyrxoe5K+hutgIeVCNY0oWVUY3YBcrgP70HQ25AZOwEjeGmZqYbEAIyBQ6pexjTkSy/HCRRLXLNHkiZ5hkT1L4SHNebT2ZJgpHfLVTTjAiE252j6b67/vsem8Wfdltm1YWnXWK48sV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN9Ycp3M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698e4795ebso11264335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421677; x=1760026477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j76UJzpxIM0UDjCUI2ssii8dRu7vQdKTtMg3Bbeobi4=;
        b=iN9Ycp3MxnUOOVPuL3qFLkmCE29PL1/MA5V141qZKkKcDL/oy7Okg/xsihAswbvvOE
         7xYe6i6fMpK/kXl/6eg6I8fY/qZJJi5ohqeJs1cO1dHeEOEIwtzU3pHZ6WJMjRAc91DM
         lud+zNg9rdg6Ps/Rd+ja4zb7uRfmaHmCLk/l9gm6u5/xI1dnene92z4MigPWYweGygYt
         K2NJEmNX/EGqfY6gEj/Syk8bWdzeATohl4OcgQcjn5zXQjPYW2q1WeHgYVdSTyH16Ogw
         RWuPQ6jlO/hxT61dQmiLKZWuB0qIh3WpiIyl6xpSRa6sn9FQ99dyjQ3J3ILuacjGPkfJ
         /SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421677; x=1760026477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j76UJzpxIM0UDjCUI2ssii8dRu7vQdKTtMg3Bbeobi4=;
        b=snLy7WiyAf8Sq5Qo1CZUhn16dGyldKlqKuWoloaMKZ+8n/NUGwdpNxsLJLhCykypx/
         V8HH43ajJk6rQmdRC3kK4jyqSX9M3rX6uC4jT2a7mkH7hgLGQy9rLkuR0k+wITN8tJyw
         IJ1YwC+ORY1ELrV48APZiDbCurMHa/v6rP6qbb1mI4OFkgO66iSeMopJjykVu1IfSVG1
         MNGVxHTbvzQREJzJ79cZs30d8ZZ90ctJzyg7Epf2gXkBvNQjqv4JcM+JsjlVo5yknsOK
         VozJX8ces+MQtL9WS6XfJTbByIw6mmUWUBi6JmOjN8iLDMZkuOXWrDPvUHthmLcdT39V
         KjXA==
X-Forwarded-Encrypted: i=1; AJvYcCVqHVyPm5STLp91QxxrxXDFZFII6PYzWbKKKRG5ttAuDF3EjMy8j3SZlcYvEd79W00PV0uM1U7h/MElg+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyXG0vbxnspzzS7u5jodaqNzu3bMXE95LJEy4M12LngEq2uMc
	YANJLntbgu1fOu89mgKsDwn5JQ2Io+e3SnQFD6cg18Xm603RUSx7IQH1Bu66FRqM/ChKkXufHFW
	zJxSaWjahfwxxuaGerBRie69OkVcRNeE=
X-Gm-Gg: ASbGncuaZkR8VXB0cAV8ugrfNN0oaBLq7fp/95dhojKIvAujyddl8X7zGHOUAvXEdMm
	Y7W4aBh5JrUlQ2NT1YPs5853uosERcym9Usy6rwn3HCoEWfztWQb4cG3LvkuVafvhKNmi/+yx7J
	M6x28kt7foSkzZz/+cw7EL3zbqdYgyddNKfrah3W2dkRowVcOgX410PYsSw4OEZEik5cjNnKEor
	Cysp795wIKvJSkbJnKL3KpZ42WNGfw=
X-Google-Smtp-Source: AGHT+IHbtMDLzeR1sbGWDms0G96PvbvaODbPkv/i4BOWqccXBOtFVGuPCPTquIYVn+yewz88FEz/5ymwxelAnAlxT2E=
X-Received: by 2002:a17:902:e94e:b0:24c:e6fa:2a38 with SMTP id
 d9443c01a7336-28e7f298119mr103135045ad.25.1759421677200; Thu, 02 Oct 2025
 09:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com> <20250820023032.17128-6-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250820023032.17128-6-dapeng1.mi@linux.intel.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:19:33 -0400
X-Gm-Features: AS18NWBM0aYGmFkp1e6VQemGuXxJDoK5xJUF16ODwth6yiolqTW8NtM51H7eonk
Message-ID: <CALC8CXdkpNtk7gd+jPhixU2irxfLae+rQRzORWXmKtNMzdyohg@mail.gmail.com>
Subject: Re: [Patch v3 5/7] perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS
 to BIT_ULL(48)
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Tip bot"
Just the tip.
Wonder if this was sent to "menglongdong" (a kernel programmer)

On Tue, Aug 19, 2025 at 10:33=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> Macro GLOBAL_CTRL_EN_PERF_METRICS is defined to 48 instead of
> BIT_ULL(48), it's inconsistent with other similar macros. This leads to
> this macro is quite easily used wrongly since users thinks it's a
> bit-mask just like other similar macros.
>
> Thus change GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48) and eliminate
> this potential misuse.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  arch/x86/events/intel/core.c      | 8 ++++----
>  arch/x86/include/asm/perf_event.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 15da60cf69f2..f88a99d8d125 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5319,9 +5319,9 @@ static void intel_pmu_check_hybrid_pmus(struct x86_=
hybrid_pmu *pmu)
>                                                 0, x86_pmu_num_counters(&=
pmu->pmu), 0, 0);
>
>         if (pmu->intel_cap.perf_metrics)
> -               pmu->intel_ctrl |=3D 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
> +               pmu->intel_ctrl |=3D GLOBAL_CTRL_EN_PERF_METRICS;
>         else
> -               pmu->intel_ctrl &=3D ~(1ULL << GLOBAL_CTRL_EN_PERF_METRIC=
S);
> +               pmu->intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
>
>         intel_pmu_check_event_constraints(pmu->event_constraints,
>                                           pmu->cntr_mask64,
> @@ -5456,7 +5456,7 @@ static void intel_pmu_cpu_starting(int cpu)
>                 rdmsrq(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities)=
;
>                 if (!perf_cap.perf_metrics) {
>                         x86_pmu.intel_cap.perf_metrics =3D 0;
> -                       x86_pmu.intel_ctrl &=3D ~(1ULL << GLOBAL_CTRL_EN_=
PERF_METRICS);
> +                       x86_pmu.intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METR=
ICS;
>                 }
>         }
>
> @@ -7790,7 +7790,7 @@ __init int intel_pmu_init(void)
>         }
>
>         if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
> -               x86_pmu.intel_ctrl |=3D 1ULL << GLOBAL_CTRL_EN_PERF_METRI=
CS;
> +               x86_pmu.intel_ctrl |=3D GLOBAL_CTRL_EN_PERF_METRICS;
>
>         if (x86_pmu.intel_cap.pebs_timing_info)
>                 x86_pmu.flags |=3D PMU_FL_RETIRE_LATENCY;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 70d1d94aca7e..f8247ac276c4 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -430,7 +430,7 @@ static inline bool is_topdown_idx(int idx)
>  #define GLOBAL_STATUS_TRACE_TOPAPMI            BIT_ULL(GLOBAL_STATUS_TRA=
CE_TOPAPMI_BIT)
>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT     48
>
> -#define GLOBAL_CTRL_EN_PERF_METRICS            48
> +#define GLOBAL_CTRL_EN_PERF_METRICS            BIT_ULL(48)
>  /*
>   * We model guest LBR event tracing as another fixed-mode PMC like BTS.
>   *
> --
> 2.34.1
>
>


Return-Path: <linux-kernel+bounces-900054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DAC59870
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D62C4EF00C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85A3081BF;
	Thu, 13 Nov 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHF1VUN2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C330C606
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058773; cv=none; b=saXLKffQTzmTjP4ZM9+BIvePbQd44kuGEgB0rzqsi2o1YrN/02/W6fJ9W5Y3J+ojagjiKxo9pn5/Ux88nZof79J8ORvEz9C77qFAwfcJmixACbiM2lXjOwmpO8f6sJYsk5htbleqZJ2TUfgPJxwZ1nE8mA30nmRz6OWKPi8Rak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058773; c=relaxed/simple;
	bh=YmrKf+fHr63hik3Fn9MO4jfd3CHTuIoq9LFYAuzEtuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5Dvw3Rte9dO2kRoXak+3swJ5Sesqo5mR/y1Csidk7nehKU5MlJlwf1o4CIYdm3RrTle85/SoQYdPa8crzqzHvnY/A4PNPdABHGru7cB/kzyNX21y7EwsGkedp7fChodoZCbCPxx5sh548dCHF7awy1oKHhkG3oefDR0jJ4csQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHF1VUN2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295c64cb951so14085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763058771; x=1763663571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2at+nfnIrFBaGGjvDz/u+5B95saiDosUT0lSszTDcTE=;
        b=oHF1VUN2ZKAs6t0MBG4gIFSJab6XL5hIyI53ONtDM0drM0/zEmwpfXOOBm9YFHzgbI
         kupKoOMu0Y7wvZ324eXzfYKX7ATONEbianHF8ZQAozyPBKg7+Zv5MBbRODCkrgEmYmkl
         FcE1FnSbYhwEgzgibku3O6dTuQybiGGf0QeRow+yfH3rTPzM8GVTL8doPUiXScaRiQwW
         p82cbTnvI93bnhbGhG8yRJEZ8oF1yyBLMsAOGtEC+cLQCaA+jEu5cZOQncEmzo9Q/GLY
         dAi5eePeGjENkbMxsNCIw+RtgX3SxQyDbmr/3PBPzBIdf+gwggDJj754H9F8fhYS6wAq
         OzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058771; x=1763663571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2at+nfnIrFBaGGjvDz/u+5B95saiDosUT0lSszTDcTE=;
        b=JJK9SBR9a7jr69CTiB+VidnLU1fVB3iR+VI4ggZC/VWMvJRm6yq+UA9TY9V3xJfr36
         ICtYdklVNCPvxIiAIRCmcKQYLxcv1kZH7oinjlwPo5UiMe7k5/8c/IDiepvxOiyhmO2R
         FjGfD2ZgeauuKbetonCtBf/YZypCYf9q1gC+r6X9m113EDBywaNgKoNFTUK3OyEnYuN2
         RqrOgRfc54MpDmDmHgFIAXJf2bJnBiWEIvc9zhl8e3v9hOsFVYVAwO6ycO/qnfv3f1qh
         JlKXVdE3UO61/i5II3K1CJE+lork/Clmz96aMnMC0OSUmN3RqcsVo9+xqhuMzz5TN5by
         XWeg==
X-Gm-Message-State: AOJu0YxkbJbw7EMGTnGOsG04NGFCek1cy4qHOgJt43JiLgVaP3JpO62y
	TW1VYdZWyqcC1xcjaI8ZLLwdgjFAOsu+eDoAh/4rTpSklgVyD76EdpVumR8Qir7+O73g0QiLJDl
	RsXBusg46bw0RxzoKASp3wEeecWjO/CFN94fByl6P
X-Gm-Gg: ASbGncsGPM5lNB/yV6o95ELc39HXrfiNLuwXzEauJRKcoZ9fxQD0HDYY/xnPh9gjJFf
	oV12WyR4WhVV4bjh50z1pXIZr3KWVDzGD/mhG0GA6Q5rOfcVaIKXThloHPDiukqqm2Vh5jOgvWZ
	Nnuny0Z1uBiDmV8yfzkg8N8jAjoqrWCAeRFW+CQ4+TVpYS8wQEj7rhBcLaa31MoWWXSCuK/yLL6
	xSKKstZqUqMk2QkEoZm7g/Ydr2h1mCOmTaDVF9eIUBUQX4f63rwq6qurT6rolJIpDPS2JFHWt4E
	rOfPv/vIcH1E7S3Q8m6Q8XzKfER2mg==
X-Google-Smtp-Source: AGHT+IFskVn+1VHgqG0wsBY7NmWDaJkchDk1EChX8JK7q34LRAj9z24KAzeAwFZsXNEn7tckZKhgiC8T/an5OXZWzx8=
X-Received: by 2002:a05:7022:3883:b0:119:e56b:c1dd with SMTP id
 a92af1059eb24-11b47b9963dmr3756c88.8.1763058770164; Thu, 13 Nov 2025 10:32:50
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113082852.2902356-1-tmricht@linux.ibm.com>
In-Reply-To: <20251113082852.2902356-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 10:32:38 -0800
X-Gm-Features: AWmQ_bl_CF5Q64y_3HTsx4geNTxOXsCYssyD0TUV6zDIKddUsfOVBFDoJHZrOqg
Message-ID: <CAP-5=fUNQL_qr_MY7VaJVVfC4gsxu0Gg4pAGPNfFY7onJVgGRQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf stat: Regression perf stat -T cpi fails
 on s390 z/VM guest systems
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:29=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On s390 z/VM systems (linux guest on s390 LPAR) this happens:
>
>  # perf test 96 97
>  96: perf all metricgroups test        : FAILED!
>  97: perf all metrics test             : FAILED!
>
> This test works on the linux repo:
>  # perf test 95 96
>  95: perf all metricgroups test        : Ok
>  96: perf all metrics test             : Ok
>
> On both systems the command
>  # ./perf list --raw-dump metric
>  cpi est_cpi finite_cpi l1mp l2p l3p l4lp l4rp memp prbstate scpl1m \
>         tlb_miss tlb_percent transaction
> shows the same list of available metrics.
>
> On z/VM the CPU Measurement facilities do not exist:
>
>  # ll  /sys/devices/cpum_cf/events
>  ls: cannot access '/sys/devices/cpum_cf/events': No such file or directo=
ry
>  #
>
> The json files for s390 define the metric 'cpi' in
> arch/s390/cf_z16/transaction.json:
>
>   {
>     "BriefDescription": "Cycles per Instruction",
>     "MetricName": "cpi",
>     "MetricExpr": "CPU_CYCLES / INSTRUCTIONS \
>                                 if has_event(INSTRUCTIONS) else 0"
>   },
>
> The macro has_event(INSTRUCTIONS) now refers to a legacy event which
> always exists. It is always true even when the hardware does not
> support this event. Change the has_event(xxx) to check for a hardware
> event not available, for example CPU_CYCLES.
>
> Fixes: 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache =
json")
> Suggested by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

This fix is equivalent to:
https://lore.kernel.org/lkml/20251112162439.1553368-1-irogers@google.com/
I'm easy about which one is picked up, the commit message here has more det=
ail.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/s390/cf_z16/transaction.json | 8 ++++----
>  tools/perf/pmu-events/arch/s390/cf_z17/transaction.json | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index 3ab1d3a6638c..26c550621d6a 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -7,17 +7,17 @@
>    {
>      "BriefDescription": "Cycles per Instruction",
>      "MetricName": "cpi",
> -    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) =
else 0"
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) el=
se 0"
>    },
>    {
>      "BriefDescription": "Problem State Instruction Ratio",
>      "MetricName": "prbstate",
> -    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if =
has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if =
has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
> -    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100 if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 2 cache",
> @@ -52,7 +52,7 @@
>    {
>      "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
>      "MetricName": "est_cpi",
> -    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z17/transaction.json
> index 74df533c8b6f..4d296e0c8934 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
> @@ -7,17 +7,17 @@
>    {
>      "BriefDescription": "Cycles per Instruction",
>      "MetricName": "cpi",
> -    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) =
else 0"
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) el=
se 0"
>    },
>    {
>      "BriefDescription": "Problem State Instruction Ratio",
>      "MetricName": "prbstate",
> -    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if =
has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if =
has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
> -    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100 if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 2 cache",
> @@ -52,7 +52,7 @@
>    {
>      "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
>      "MetricName": "est_cpi",
> -    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> --
> 2.51.1
>


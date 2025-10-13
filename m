Return-Path: <linux-kernel+bounces-849933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61EBD15E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF83BDD66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7D223DFD;
	Mon, 13 Oct 2025 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oB9ApiTw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D2155CB3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329378; cv=none; b=tIg2avsjKh8RCM746PIAfeHUIoeYD/L3Q4+OmSNce3hX0F95fFO5Mr0Ff+rqpv7v4izD4x/M+la+om5bh2y1QqLjIx4MZFV25K/8iDMjL6KzPwhW6DHacTRqvua7PffVeBgzh6T7y2N1Fjj2oQkHkRBRUuekP8/ZVfQjkp1XGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329378; c=relaxed/simple;
	bh=dKKm/ucfnF0X/yhC/W/nimiSgwNp7VgI+M2mogqYvXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk798RW5JIbtoPq81DFtELL6ICk1VEfvVMpCVyoMGJFjxnVL4J+qX6VeU7HcbDlm8p27j/1m6uQytm5BHs2bAolG++Ko9I8TjQG7/njVhXicqzd91K87rTMhrqW30xj6bwn6ZuWc/33X8azNJ7C12lN1l+tjXdYMcF+aB6gfibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oB9ApiTw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso5895942e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760329375; x=1760934175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIm07Frt6UqA8OnEbW7sIR30RcCER/YlhbGsaYO7atM=;
        b=oB9ApiTwKFmATW9nnnCytP4DuhEZ2Tj0y3m1oBB6rs8piah4JQ32SUVRa06nZmXF9v
         yYoQIWIQ4xI8ZZZsuBTxWvLsBvi75rHwmT4D1TPfeUHLA0JbABzs1TCanyD0mRgQT7PR
         9/Ol23I+rmOGh2ksPkkHq9snqqCad/cvlPvsnCvFs8ftkZlMkXSZTLQW9U3lCIKpiHa9
         qnHuUKgkJ+AYtY7xq+BL/VsKGYmqGZxa+wOYRIhrVS+CGDQbKxaeS7IXvwFCRLk6Ti4Y
         ZnuBPvNJhOaZnDEhBwiDOCL5tahOzT5s6JAA0er3MdTq5fO/5oJXdDceJ0USDb690486
         7ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760329375; x=1760934175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIm07Frt6UqA8OnEbW7sIR30RcCER/YlhbGsaYO7atM=;
        b=nKFmYFl6ossuJoW2Fw9RPSphVYRalJK2BvZKF26VEhgHh/hZj2mdpxu+tJxhtF7JVq
         ajS9tDxILwpwYKJoory6L9asqPIW1t7AkdBwAxVTZ8fLiQJJbofXlE9vckGLHIgTAnZC
         4AYokHHClFQwQTTrzCBQjDzZccfObQUZVGKpcJcXke1o4inmb/6q/Dxmd5pwsSN/UxU7
         gn+ocZoocAzQJfbb53oYqOfM2J7bT+7BQhb+ONBK23km/d5r6nOGsFtO3IhY53E7FnHe
         Jv8eYK2TDZHFyJO9YIuMH44lSH9iOKGKweR/qeH76TIYEcPeTheRbSP0d6ztqWrz0J0k
         dVRA==
X-Forwarded-Encrypted: i=1; AJvYcCWB43uuvFyY3scWLlDjIMNNgeChDmwYaS/nvvooTDezIYvmSN2hIi/jJz6eRvQ4opbVdIrL2iCFFiy7F0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+xG/1oOV9iHbw/Q1H75pUydlSHq3AqLer0ymSMJ+adEl0oDN
	T6CQR9nYXHghtRrhcCJzc7OsSxH7yaDQCpXHZSuXbh95oWBRVEUybPSWsZCn0a0DqPNjZM2Diqe
	UewUzcaC0kgZnVl33NOvDzY5QV71JSHMvPReT1f3QHw==
X-Gm-Gg: ASbGnctz57vgJRcPQmcZ1ZlXxDTUc+d5BPM6fEjD6v6Eh3imYfpQN3N5yE0lQMVH/n8
	gSveblFONma1bJ2EKnsG47IIotOpRTYJXxQMQH/tKBSM0HSdJbOcJ3dSxQHU6YKGyvJeYmc9SR6
	pCsYKvnx2WpTv892wCUXLODjZv6PtY26YPgeqldE7vblaVOIxCV+FEgUt6aYapzxjoMHTi7AS73
	pFgVZS8j9RIiSwfyozKgS3QJOgCO4wyQUNTiA==
X-Google-Smtp-Source: AGHT+IF9GyRvwlY+za48jwaGLhv+GdYktcmtJpmyFrXoDuVmvzO8g9ax7WhUH0r6LKtiHHQUfIueiCU3VDqWez28w9s=
X-Received: by 2002:a05:6512:e85:b0:577:a108:93ca with SMTP id
 2adb3069b0e04-5905e3a0d18mr5694186e87.28.1760329374581; Sun, 12 Oct 2025
 21:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 13 Oct 2025 09:52:40 +0530
X-Gm-Features: AS18NWDCorXyTJB5-3mUpzhGpHftDP0QKH89ou3pgO4FOSJeW6Ud31hlZ5sBN1M
Message-ID: <CAK9=C2VEKAy-pS8gy02E2AFifxBOmNPpgTodC+pyuU53Ts_0VA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] riscv: tarce: Implement riscv trace pmu driver
 and perf support
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Thu, Sep 11, 2025 at 6:15=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> The RISC-V Trace Specification defines a standardized framework for
> capturing and analyzing the execution of RISC-V processors. Its main
> uses include: instruction and data tracing, real-time debugging, etc.
> Similar to Intel-PT and ARM-CoreSight.
>
> According to the RISC-V Trace Control Interface specification [1].
> There are two standard RISC-V trace protocols which will utilize
> this RISC-V Trace Control Interface:
> - RISC-V N-Trace (Nexus-based Trace) Specification
> - Efficient Trace for RISC-V Specification
> So, this is a complete guideline for any standard RISC-V trace
> implementation.
>
> This series of patches is mainly used to start related work and
> communication. It completes the following tasks:
> 1. dt-bindings completes the basic definition of riscv trace
>    component properties, but is still incomplete.
> 2. Implemented the basic RISC-V Trace PMU driver, including
>    support for the aux buffer.
> 3. Implemented basic support for AUXTRACE integration with perf
>    tools.
>
> There's still more work to be done, such as:
> 1. Complete RISC-V Trace PMU implementation.
> 2. The perf.data generation and parsing including AUXTRACE events.
> 3. Taking RISC-V N-Trace as an example, implement the parsing of
>    Nexus Trace data format, including support for perf report and
>    perf script commands.
> We are still sorting out.
>
> Any comments or suggestions are welcome.
>
> [1] https://github.com/riscv-non-isa/tg-nexus-trace.git
>
> Chen Pei (4):
>   dt-bindings: riscv: Add trace components description
>   riscv: event: Initial riscv trace driver support
>   tools: perf: Support perf record with aux buffer for riscv trace
>   riscv: trace: Support sink using dma buffer
>
>  .../riscv/trace/riscv,trace,encoder.yaml      |  41 +++
>  .../riscv/trace/riscv,trace,funnel.yaml       |  46 ++++
>  .../riscv/trace/riscv,trace,sink.yaml         |  37 +++
>  arch/riscv/Kbuild                             |   1 +
>  arch/riscv/Kconfig                            |   2 +
>  arch/riscv/events/Kconfig                     |  11 +
>  arch/riscv/events/Makefile                    |   3 +
>  arch/riscv/events/riscv_trace.c               | 253 ++++++++++++++++++
>  arch/riscv/events/riscv_trace.h               | 133 +++++++++
>  arch/riscv/events/riscv_trace_encoder.c       | 109 ++++++++
>  arch/riscv/events/riscv_trace_funnel.c        | 160 +++++++++++
>  arch/riscv/events/riscv_trace_sink.c          | 100 +++++++
>  tools/perf/arch/riscv/util/Build              |   3 +
>  tools/perf/arch/riscv/util/auxtrace.c         |  33 +++
>  tools/perf/arch/riscv/util/pmu.c              |  18 ++
>  tools/perf/arch/riscv/util/riscv-trace.c      | 183 +++++++++++++
>  tools/perf/arch/riscv/util/tsc.c              |  15 ++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/auxtrace.c                    |   4 +
>  tools/perf/util/auxtrace.h                    |   1 +
>  tools/perf/util/riscv-trace.c                 | 162 +++++++++++
>  tools/perf/util/riscv-trace.h                 |  18 ++
>  22 files changed, 1334 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,t=
race,encoder.yaml
>  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,t=
race,funnel.yaml
>  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,t=
race,sink.yaml
>  create mode 100644 arch/riscv/events/Kconfig
>  create mode 100644 arch/riscv/events/Makefile
>  create mode 100644 arch/riscv/events/riscv_trace.c
>  create mode 100644 arch/riscv/events/riscv_trace.h
>  create mode 100644 arch/riscv/events/riscv_trace_encoder.c
>  create mode 100644 arch/riscv/events/riscv_trace_funnel.c
>  create mode 100644 arch/riscv/events/riscv_trace_sink.c
>  create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
>  create mode 100644 tools/perf/arch/riscv/util/pmu.c
>  create mode 100644 tools/perf/arch/riscv/util/riscv-trace.c
>  create mode 100644 tools/perf/arch/riscv/util/tsc.c
>  create mode 100644 tools/perf/util/riscv-trace.c
>  create mode 100644 tools/perf/util/riscv-trace.h
>
> --

Few months back we (Ventana) had informed everyone
within RVI (particularly self-hosted trace TG) that we are
working on Linux trace framework and drivers for the RISC-V
community [1]. There are also publicly accessible RISE
project pages already available for the trace efforts [2].

This is yet another instance where ongoing efforts were
totally ignored.

--
Anup

[1] https://lists.riscv.org/g/sig-hypervisors/message/648
[2] https://lf-rise.atlassian.net/wiki/spaces/HOME/pages/8591251/2025+-+Ker=
nel+and+Virtualization+Priorities


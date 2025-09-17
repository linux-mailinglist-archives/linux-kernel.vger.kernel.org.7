Return-Path: <linux-kernel+bounces-820149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED8B7D711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2F97A6436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B4204583;
	Wed, 17 Sep 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g69OeIxE"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653042253E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094155; cv=none; b=qGDEXnRbiK/4ocMPxr49asfTGUsohr69uZEAYXFtTvX/LimdHL+vcLI2Fkumqiw34cLJvPIUIBw8otISpGBuDwk9C1zeHL3wKapY5Jc8z7RxFdz4VLjklifsW8wYk68HUVVSb6G++0aE5/SQB1MHPQ0Pemfx+st97liveaNxFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094155; c=relaxed/simple;
	bh=WunjDCY/mmceQf0OoZj3CKqUHoFgA6QT9izcm/iJq1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF1jVvdDM1ZbM/CIPoRwwyV/61bkJrYnnoVz8q/bVKULGjbws6dpaVr0GeX3hlPs0zIAJjIYvA1sYUwXUcEVvaxddwG/1RB4rtMJAkCLr8yJpmlUtmhTf9G/dpErwc63cHIuuUhzIgC4SfDkgdkUnsP6YnfKOgQR6VkMKhwz92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g69OeIxE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso2538109a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094153; x=1758698953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGMxyAVQkLmt2nM51SfjyMANS8EMy8Kdk2x4MsTxGUg=;
        b=g69OeIxERLzWtNsjisWNvSqWujJTjZL/nr1XhIkDkspfTkatecJFuRuW1posFaTe3p
         0gsNqqHIVSqP/bMLV1yLP5sFV4IOsN3BBTg22bPMP2Z1iJ66ELfi+bDLiGjleiWHcf6z
         N8DuW6ONINH1rPDDYGY8jh+lO0YzePqWz0Tu55xmkAMW6Qw6z/UwbsDn1Cae2mnMx/hq
         sTH4tPhdAj49Hd2ZY70q7jhI0nIALbWgPYh+6R/Um6hUOpT/6zaMEjOgfcXcN3r4UkCA
         8TmkSHF2P9RhKrUeZ2uEFn2BVcx2CGgMSZfUouHDhPzdjCztAiajEB7aw52nAJHQmJOR
         AamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094153; x=1758698953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGMxyAVQkLmt2nM51SfjyMANS8EMy8Kdk2x4MsTxGUg=;
        b=TQ/dsXBxRgazhx52o8kSAjRlkNNbLQ9PLEKKiXzHfttQ5By9o1kKwSjvGiNnRd4i/1
         HNjsR4qspDlBAQfu8Jv/rXL+0GgTQuEE6NdCMU4DfmgtU4zWYRuAQzOSPsKfQYIsPzGm
         marNQv4QSIOJLYgvDa04dCkRk9fVqFQQbhVwSvEEDr/E+3yYT2z4y/c/WLri4V9+3+H/
         Jn2tJ89k/dsMIkpD2MKoSfjVUrVZPOc6xxBq7nczdESY1DWp7Gtc44GO3cP0PhJV/wVO
         ZMh56+6gtAbSHdCnZbgEAT16fYnQyXxcQ6HNsgs2c7XZrBU/qTP4EuO5BdMBJjt7q7Au
         5h4A==
X-Forwarded-Encrypted: i=1; AJvYcCVFhoth+sKlwwSggKIRuCS0+IqUOMPH0jxx9qyCA+ijlu3XEW1OGZpoql7EUktuOquvWxTRCnUfOaHS91Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94fo/co823hFjI8t9JFa5bTpQjAkvLHDWr0uNk+KQKTGjnFiI
	Pl0u7V29fsMQt1MH5SLbE00Uyxxsb2bt1NeDHW85Go3+F4xeOEXgFOiQ
X-Gm-Gg: ASbGncvheWelDBGUILIDkB9elbg22er6VnA9ufvPsGPhHuaEjzlhohCCFK4A77/P3fr
	KSCnvVDy1suxyMm5DHLSfEflVYYIKRcvwMD9ohIavJVdOGN2CLoDmqEo+smQZuGrESQ5KEOOHSa
	NxNit+sip1WXZwC1gUgGFG5ofWzoJDo3BeTO/pQUJ+EktjhOSGmvH2ju/UHX1gVfjfehNg3wjAF
	7ZhXeiCCJqlb3PEmEt55bBbwDpg5sJCEQ2zGLKoZNq0F4RMmWzim87Qgz0+2sDKj6Yk4qSzC5pz
	wYtpTgUE1SiP+7ASjT7ssKv1bHixLzybTG8RxABAlBcqaxPXKSQbneQYOTGTpFPpkcOgzNIHx2h
	cBIzrpzsPU3xDBUfCs6fKEq21
X-Google-Smtp-Source: AGHT+IHUtcafhAyiAUgRuMgzIXX3ncYg9PIYU74U7gBGjUqm2CSWekMPflPgAWzrA95Bfx/ozkOv8Q==
X-Received: by 2002:a17:90b:3c05:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-32ee3f8df41mr1386261a91.30.1758094152532;
        Wed, 17 Sep 2025 00:29:12 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275e795sm1581943a91.19.2025.09.17.00.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:29:11 -0700 (PDT)
Message-ID: <58439862-945d-4b7d-bf6a-6d398e6dd744@gmail.com>
Date: Wed, 17 Sep 2025 00:27:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] riscv: tarce: Implement riscv trace pmu driver
 and perf support
To: cp0613@linux.alibaba.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 05:44, cp0613@linux.alibaba.com wrote:
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
>     component properties, but is still incomplete.
> 2. Implemented the basic RISC-V Trace PMU driver, including
>     support for the aux buffer.
> 3. Implemented basic support for AUXTRACE integration with perf
>     tools.
> 
> There's still more work to be done, such as:
> 1. Complete RISC-V Trace PMU implementation.
> 2. The perf.data generation and parsing including AUXTRACE events.
> 3. Taking RISC-V N-Trace as an example, implement the parsing of
>     Nexus Trace data format, including support for perf report and
>     perf script commands.
> We are still sorting out.
> 
> Any comments or suggestions are welcome.
> 
> [1] https://github.com/riscv-non-isa/tg-nexus-trace.git
> 

Hi Chen, thanks for starting this series. I have done a N-trace driver
in user space: https://github.com/ganboing/riscv-trace-umd, and I'd love
to see someone finally taking the effort to try a proper kernel driver.

My overall suggestions:

1. We need a way to expose proper topology to user-space like coresight.
    Thus, I'm thinking of using similar logic in coresight to export the
    topology through sysfs. Potentially we can abstract some logic out of
    coresight and make it a common core path that can be reused by riscv
    trace driver. Thus, we don't reinvent the wheel. This also helps
    debugging trace driver issues if anything goes wrong.

2. IMO, The driver should be moved to drivers/hwtracing/. It's not tightly
    coupled with arch, and there are many platform related logic where it
    doesn't belong to arch/riscv/. Having said that, I do believe we'll need
    something in arch/riscv/ eventually for trace once the self-hosted trace
    spec is finalized. Self-hosted trace behaves more like Intel PT, where
    the control will be done through some CSR(s), and it doesn't need those
    funnel/sink topology, and can emit trace stream to virtual memory directly.
    It's a per-hart thing with LAMBI and all that. I'd imagine that eventually
    riscv trace will be two parts. One is more coresight-alike, where you have
    encoders/funnel/sink/bridge that are described through DT and controlled by
    MMIO. The other part is more PT-alike, where the feature is described by
    ISA-string (I guess?), and it's much easier to program. For the time being,
    IMO, a coresight-alike driver, e.g., drivers/hwtracing/rvtrace, is more
    suited for existing platforms implementing N-trace or E-trace. Also, don't
    assume the memory sink is available. People using this "coresight-alike"
    driver can very-well be HW engineers who's collecting traces using external
    probes, so again I think we may want to abstract out part of coresight's
    logic and reuse then in riscv.

3. I've already implemented a N-trace decoder:
    https://github.com/ganboing/libnexus-rv
    It can decode N-trace on real HW (ESWIN EIC7700/Sifive P550). I'll try to
    see if I have the time to code up N-trace decoding in perf tool, once the
    driver and the perf trace collection part is stabilized. If not, I will be
    happy to review yours. Please include me in future series.

BTW, perhaps you want to also CC riscv Task Groups such as
   - Sig-Debug-Trace-Perf-Mon (DTPM)
   - Tech-Self-Hosted-Trace

to keep people like Beeman/Robert/Bruce/Iain/Greg posted. Robert mentioned
they tried to contact Sifive to see if they had similar driver upstreaming
effort just like yours, but there were no reply. Keep them posted anyway to
avoid duplicate work. We should also discuss this during riscv NA summit if
you or Guo's attending.

> Chen Pei (4):
>    dt-bindings: riscv: Add trace components description
>    riscv: event: Initial riscv trace driver support
>    tools: perf: Support perf record with aux buffer for riscv trace
>    riscv: trace: Support sink using dma buffer
> 
>   .../riscv/trace/riscv,trace,encoder.yaml      |  41 +++
>   .../riscv/trace/riscv,trace,funnel.yaml       |  46 ++++
>   .../riscv/trace/riscv,trace,sink.yaml         |  37 +++
>   arch/riscv/Kbuild                             |   1 +
>   arch/riscv/Kconfig                            |   2 +
>   arch/riscv/events/Kconfig                     |  11 +
>   arch/riscv/events/Makefile                    |   3 +
>   arch/riscv/events/riscv_trace.c               | 253 ++++++++++++++++++
>   arch/riscv/events/riscv_trace.h               | 133 +++++++++
>   arch/riscv/events/riscv_trace_encoder.c       | 109 ++++++++
>   arch/riscv/events/riscv_trace_funnel.c        | 160 +++++++++++
>   arch/riscv/events/riscv_trace_sink.c          | 100 +++++++
>   tools/perf/arch/riscv/util/Build              |   3 +
>   tools/perf/arch/riscv/util/auxtrace.c         |  33 +++
>   tools/perf/arch/riscv/util/pmu.c              |  18 ++
>   tools/perf/arch/riscv/util/riscv-trace.c      | 183 +++++++++++++
>   tools/perf/arch/riscv/util/tsc.c              |  15 ++
>   tools/perf/util/Build                         |   1 +
>   tools/perf/util/auxtrace.c                    |   4 +
>   tools/perf/util/auxtrace.h                    |   1 +
>   tools/perf/util/riscv-trace.c                 | 162 +++++++++++
>   tools/perf/util/riscv-trace.h                 |  18 ++
>   22 files changed, 1334 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml
>   create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml
>   create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml
>   create mode 100644 arch/riscv/events/Kconfig
>   create mode 100644 arch/riscv/events/Makefile
>   create mode 100644 arch/riscv/events/riscv_trace.c
>   create mode 100644 arch/riscv/events/riscv_trace.h
>   create mode 100644 arch/riscv/events/riscv_trace_encoder.c
>   create mode 100644 arch/riscv/events/riscv_trace_funnel.c
>   create mode 100644 arch/riscv/events/riscv_trace_sink.c
>   create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
>   create mode 100644 tools/perf/arch/riscv/util/pmu.c
>   create mode 100644 tools/perf/arch/riscv/util/riscv-trace.c
>   create mode 100644 tools/perf/arch/riscv/util/tsc.c
>   create mode 100644 tools/perf/util/riscv-trace.c
>   create mode 100644 tools/perf/util/riscv-trace.h
> 
Bo


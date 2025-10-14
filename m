Return-Path: <linux-kernel+bounces-851718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7BBBD720D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EB94E0EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA493054D1;
	Tue, 14 Oct 2025 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ5Vzk6p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFF4C6E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410477; cv=none; b=Y3stzWQ1BhJa9kqacxDvZxg03eQpXAu//jhrmgPyl4dC7FwBYhh7FDcypqcjzrikLF7sSKN/T0onvoXjhtRV79mKycT2UKukLrEhXMhu1HEGC3L5SseSWihgY4w7dtUwJjIKfSDU6/r3+XuoZXYXVUEJozXQd52wCPSbpJWUnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410477; c=relaxed/simple;
	bh=rN1/JT8Vi4aFfkerDExWo+sW0UZtHdXnofYs4/tmwlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/5KuT0hbPyUiKVaS8sXHi5IlOc58/z66X0JU9Kgm0BhH6iyBjmJvU2oNnGjTLn9MK5NPvq9PxV0FGNEZx4LtYbOYPoAEOTfpdeHD8NwJnacgPspZL2Q8XTWlOKxJWdVHSSeqyAGWCc9Kbj3Z9fimGdctB3wSv9FIGB4A2mAvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ5Vzk6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B15C116C6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760410477;
	bh=rN1/JT8Vi4aFfkerDExWo+sW0UZtHdXnofYs4/tmwlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QZ5Vzk6p2MTP8SCkciTYMggN/6CyeSrKIPBjuysJ1w5nkg3Ts+53V/Xdso9KjDrdS
	 TJ/TKe5YIK0H+E+BLBvlkj5aXEEIx3v7S6ZPTrAWIEhrYp12kJjZev016A/suGVDID
	 Mv2+MujU7AsxiRr0Dho8XEkCWmDD5XWzXFzJdQWqqmUCtAhqREzQoyGqqQHi0f7gPD
	 Mkl76+twKlUYOVkyQPDYspoCdvFxCu0oWOCoTbT8bDpvdP75jvYdixo9nNEROe8IIQ
	 9QBOI5HfCnxGQiAYSIx8hRSOSHlxH6HBwHeNsnGPX+5PsINUsyfhKDq2mmcIoVIx9K
	 6Aq7UCUeUXiPQ==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3408109f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:54:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcYukiJUA9b2GthZZU/YCgE8xZD0QGNiNVxme73kp1CW3882oD0pcE5UaxIKzX0QPlaTKmszFsWnfreKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdLxPLp/Sjr5ZRre0MBUfiIMvoGYbus6zIACG/diGyQjMZsoQ
	aJ4+qIh3QkBO8WsjmZoXaxloY/H+bPocm+I3mfykFuZ6msNPU+a+F6OKIaCt0T3Og+kAH52bq8+
	+A/5lIcPUG4RcwHWKUPicf2t0CZZE8ls=
X-Google-Smtp-Source: AGHT+IFeCe0m2jQpeupyU3ik9Z7IXPpZmM0qDJEXluDW3n2mFBlDM9cW5/QwsDQICNKkTsG8UM84eaA7ty8HCW1R4W4=
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id
 ffacd0b85a97d-4266e7befe4mr15259028f8f.17.1760410475815; Mon, 13 Oct 2025
 19:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911124448.1771-1-cp0613@linux.alibaba.com> <CAK9=C2VEKAy-pS8gy02E2AFifxBOmNPpgTodC+pyuU53Ts_0VA@mail.gmail.com>
In-Reply-To: <CAK9=C2VEKAy-pS8gy02E2AFifxBOmNPpgTodC+pyuU53Ts_0VA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 14 Oct 2025 10:54:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQNdRbB0JgAU8p1+13UEFKPF0BNfwzGavHz8DmzFJPF-A@mail.gmail.com>
X-Gm-Features: AS18NWAzR9RYh2nljzQvD39lmWOwh-HTD5q8TNwK0Yt5xzls94DHmtPOTGj-s18
Message-ID: <CAJF2gTQNdRbB0JgAU8p1+13UEFKPF0BNfwzGavHz8DmzFJPF-A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] riscv: tarce: Implement riscv trace pmu driver
 and perf support
To: Anup Patel <apatel@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:22=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> Hi Guo,
>
> On Thu, Sep 11, 2025 at 6:15=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
> >
> > From: Chen Pei <cp0613@linux.alibaba.com>
> >
> > The RISC-V Trace Specification defines a standardized framework for
> > capturing and analyzing the execution of RISC-V processors. Its main
> > uses include: instruction and data tracing, real-time debugging, etc.
> > Similar to Intel-PT and ARM-CoreSight.
> >
> > According to the RISC-V Trace Control Interface specification [1].
> > There are two standard RISC-V trace protocols which will utilize
> > this RISC-V Trace Control Interface:
> > - RISC-V N-Trace (Nexus-based Trace) Specification
> > - Efficient Trace for RISC-V Specification
> > So, this is a complete guideline for any standard RISC-V trace
> > implementation.
> >
> > This series of patches is mainly used to start related work and
> > communication. It completes the following tasks:
> > 1. dt-bindings completes the basic definition of riscv trace
> >    component properties, but is still incomplete.
> > 2. Implemented the basic RISC-V Trace PMU driver, including
> >    support for the aux buffer.
> > 3. Implemented basic support for AUXTRACE integration with perf
> >    tools.
> >
> > There's still more work to be done, such as:
> > 1. Complete RISC-V Trace PMU implementation.
> > 2. The perf.data generation and parsing including AUXTRACE events.
> > 3. Taking RISC-V N-Trace as an example, implement the parsing of
> >    Nexus Trace data format, including support for perf report and
> >    perf script commands.
> > We are still sorting out.
> >
> > Any comments or suggestions are welcome.
> >
> > [1] https://github.com/riscv-non-isa/tg-nexus-trace.git
> >
> > Chen Pei (4):
> >   dt-bindings: riscv: Add trace components description
> >   riscv: event: Initial riscv trace driver support
> >   tools: perf: Support perf record with aux buffer for riscv trace
> >   riscv: trace: Support sink using dma buffer
> >
> >  .../riscv/trace/riscv,trace,encoder.yaml      |  41 +++
> >  .../riscv/trace/riscv,trace,funnel.yaml       |  46 ++++
> >  .../riscv/trace/riscv,trace,sink.yaml         |  37 +++
> >  arch/riscv/Kbuild                             |   1 +
> >  arch/riscv/Kconfig                            |   2 +
> >  arch/riscv/events/Kconfig                     |  11 +
> >  arch/riscv/events/Makefile                    |   3 +
> >  arch/riscv/events/riscv_trace.c               | 253 ++++++++++++++++++
> >  arch/riscv/events/riscv_trace.h               | 133 +++++++++
> >  arch/riscv/events/riscv_trace_encoder.c       | 109 ++++++++
> >  arch/riscv/events/riscv_trace_funnel.c        | 160 +++++++++++
> >  arch/riscv/events/riscv_trace_sink.c          | 100 +++++++
> >  tools/perf/arch/riscv/util/Build              |   3 +
> >  tools/perf/arch/riscv/util/auxtrace.c         |  33 +++
> >  tools/perf/arch/riscv/util/pmu.c              |  18 ++
> >  tools/perf/arch/riscv/util/riscv-trace.c      | 183 +++++++++++++
> >  tools/perf/arch/riscv/util/tsc.c              |  15 ++
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/auxtrace.c                    |   4 +
> >  tools/perf/util/auxtrace.h                    |   1 +
> >  tools/perf/util/riscv-trace.c                 | 162 +++++++++++
> >  tools/perf/util/riscv-trace.h                 |  18 ++
> >  22 files changed, 1334 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv=
,trace,encoder.yaml
> >  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv=
,trace,funnel.yaml
> >  create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv=
,trace,sink.yaml
> >  create mode 100644 arch/riscv/events/Kconfig
> >  create mode 100644 arch/riscv/events/Makefile
> >  create mode 100644 arch/riscv/events/riscv_trace.c
> >  create mode 100644 arch/riscv/events/riscv_trace.h
> >  create mode 100644 arch/riscv/events/riscv_trace_encoder.c
> >  create mode 100644 arch/riscv/events/riscv_trace_funnel.c
> >  create mode 100644 arch/riscv/events/riscv_trace_sink.c
> >  create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
> >  create mode 100644 tools/perf/arch/riscv/util/pmu.c
> >  create mode 100644 tools/perf/arch/riscv/util/riscv-trace.c
> >  create mode 100644 tools/perf/arch/riscv/util/tsc.c
> >  create mode 100644 tools/perf/util/riscv-trace.c
> >  create mode 100644 tools/perf/util/riscv-trace.h
> >
> > --
>
> Few months back we (Ventana) had informed everyone
> within RVI (particularly self-hosted trace TG) that we are
> working on Linux trace framework and drivers for the RISC-V
> community [1]. There are also publicly accessible RISE
> project pages already available for the trace efforts [2].\
Thx for reminding, I would reply on [1].

>
> This is yet another instance where ongoing efforts were
> totally ignored.
>
> --
> Anup
>
> [1] https://lists.riscv.org/g/sig-hypervisors/message/648
> [2] https://lf-rise.atlassian.net/wiki/spaces/HOME/pages/8591251/2025+-+K=
ernel+and+Virtualization+Priorities



--=20
Best Regards
 Guo Ren


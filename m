Return-Path: <linux-kernel+bounces-812074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC0B532A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD64F5872A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401D322536;
	Thu, 11 Sep 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NvpeFXID"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64428322777
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594715; cv=none; b=gEn/op5szBVJDAzZGYIL2UV8fb2h0HPbHp69q5OHr0qESfE7FbSjx47eNDcnPRPYmpkapMAyhSJQLIjhhzxP7/ACwdAy3KfdaObyOQUP8wwyWyyzqoN2ZK/7xNmIKZA0siMTIp+v5uaxAfyo2CI93U9112zMds7mpPRin6EMYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594715; c=relaxed/simple;
	bh=lcpQ5gOlNW0uUr2Uoqt902A9z4/MJt9oOLrrux3tMbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qM6XTpn7V+Mh5TdVEegr2JOdG2mjQZi66hBi5RqASU/o7CNLFG0KI0oatuR0ECsI9HiUkeI5NnwMpnotxcS4gBMHciVWBGNUZDOPLKoqORcILCTRqa3nQdWfxRcBs+bqq2uLelZJFwo3RdtFICHxUAh58+Cv7unI6QiAmvW7RZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NvpeFXID; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757594708; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=A7y9SMNWfcdmMaWZPV3e4O3wkQ5XwZ5q195pdCXDlkM=;
	b=NvpeFXIDcnjnIDeK/FkOqnkb0ugjMxsdDl3U6n0oc5zOKRkjmiAKBBxr0FeZnl5EG38+krPlwX+M5dV4k6Jt5R+oW6afcses5BCbdDn+7fByEtNtS5w/kiW+kErTGzOvqUHhXZAjCfmtUXBa1e6Cbvps+JNcKSjUYqJ7bdJ/stc=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnmLJgJ_1757594704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:45:08 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [RFC PATCH 0/4] riscv: tarce: Implement riscv trace pmu driver and perf support
Date: Thu, 11 Sep 2025 20:44:44 +0800
Message-ID: <20250911124448.1771-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The RISC-V Trace Specification defines a standardized framework for
capturing and analyzing the execution of RISC-V processors. Its main
uses include: instruction and data tracing, real-time debugging, etc.
Similar to Intel-PT and ARM-CoreSight.

According to the RISC-V Trace Control Interface specification [1].
There are two standard RISC-V trace protocols which will utilize
this RISC-V Trace Control Interface:
- RISC-V N-Trace (Nexus-based Trace) Specification
- Efficient Trace for RISC-V Specification
So, this is a complete guideline for any standard RISC-V trace
implementation.

This series of patches is mainly used to start related work and
communication. It completes the following tasks:
1. dt-bindings completes the basic definition of riscv trace
   component properties, but is still incomplete.
2. Implemented the basic RISC-V Trace PMU driver, including
   support for the aux buffer.
3. Implemented basic support for AUXTRACE integration with perf
   tools.

There's still more work to be done, such as:
1. Complete RISC-V Trace PMU implementation.
2. The perf.data generation and parsing including AUXTRACE events.
3. Taking RISC-V N-Trace as an example, implement the parsing of
   Nexus Trace data format, including support for perf report and
   perf script commands.
We are still sorting out.

Any comments or suggestions are welcome.

[1] https://github.com/riscv-non-isa/tg-nexus-trace.git

Chen Pei (4):
  dt-bindings: riscv: Add trace components description
  riscv: event: Initial riscv trace driver support
  tools: perf: Support perf record with aux buffer for riscv trace
  riscv: trace: Support sink using dma buffer

 .../riscv/trace/riscv,trace,encoder.yaml      |  41 +++
 .../riscv/trace/riscv,trace,funnel.yaml       |  46 ++++
 .../riscv/trace/riscv,trace,sink.yaml         |  37 +++
 arch/riscv/Kbuild                             |   1 +
 arch/riscv/Kconfig                            |   2 +
 arch/riscv/events/Kconfig                     |  11 +
 arch/riscv/events/Makefile                    |   3 +
 arch/riscv/events/riscv_trace.c               | 253 ++++++++++++++++++
 arch/riscv/events/riscv_trace.h               | 133 +++++++++
 arch/riscv/events/riscv_trace_encoder.c       | 109 ++++++++
 arch/riscv/events/riscv_trace_funnel.c        | 160 +++++++++++
 arch/riscv/events/riscv_trace_sink.c          | 100 +++++++
 tools/perf/arch/riscv/util/Build              |   3 +
 tools/perf/arch/riscv/util/auxtrace.c         |  33 +++
 tools/perf/arch/riscv/util/pmu.c              |  18 ++
 tools/perf/arch/riscv/util/riscv-trace.c      | 183 +++++++++++++
 tools/perf/arch/riscv/util/tsc.c              |  15 ++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/auxtrace.c                    |   4 +
 tools/perf/util/auxtrace.h                    |   1 +
 tools/perf/util/riscv-trace.c                 | 162 +++++++++++
 tools/perf/util/riscv-trace.h                 |  18 ++
 22 files changed, 1334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml
 create mode 100644 arch/riscv/events/Kconfig
 create mode 100644 arch/riscv/events/Makefile
 create mode 100644 arch/riscv/events/riscv_trace.c
 create mode 100644 arch/riscv/events/riscv_trace.h
 create mode 100644 arch/riscv/events/riscv_trace_encoder.c
 create mode 100644 arch/riscv/events/riscv_trace_funnel.c
 create mode 100644 arch/riscv/events/riscv_trace_sink.c
 create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
 create mode 100644 tools/perf/arch/riscv/util/pmu.c
 create mode 100644 tools/perf/arch/riscv/util/riscv-trace.c
 create mode 100644 tools/perf/arch/riscv/util/tsc.c
 create mode 100644 tools/perf/util/riscv-trace.c
 create mode 100644 tools/perf/util/riscv-trace.h

-- 
2.49.0



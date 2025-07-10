Return-Path: <linux-kernel+bounces-724683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B0AFF5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CCE3B57C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2349620;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Sc3Oq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A175227
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107551; cv=none; b=Bjvpf8oYVyisqM3OGjFRUX0A4UBDXFfC802cmplW59TAXj2W3qkY4swbveTASF/8f9lZbExosOyp+a1YCTFWEyV9F8wPgh4Rgm15uDNwToJKz39icpkAIMotdi+sG9stJqXpu/wNLERFwOk0HIQg1iQYWT01lf0ggBIXlAnKNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107551; c=relaxed/simple;
	bh=hOmV5a/K9N/S7sOKcOV77PS2C7kidnWBoRpINVVJ+EY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=a2ovVEcFm/W33w5iDjiWS/qC9KVWOg0VD9Xix0F2ODw4GHi/I8vm724BBv4wIU+YlD29DVNSuzSvh1WeFlBlBkE8bLK8cUFr0mdKJlFV0daUfdxoqWAqBzRCwAh4Hsa1eOia2GAR7soMeFjaxh6y8ZDIgPK6jeP42vLf++eB/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Sc3Oq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCD8C4CEF1;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=hOmV5a/K9N/S7sOKcOV77PS2C7kidnWBoRpINVVJ+EY=;
	h=Date:From:To:Cc:Subject:From;
	b=V9Sc3Oq95lIMRu1haJYGtYkqMZxlBhLVNkbm9yCNaosKOthUI/Hdzr214C1D1TJqf
	 IlGZW70RMORqkiPBQa2gOtSnLGx5jyvdjBJMCh2QHxJrX3gzPkbTEIgb/F4Z/zQB46
	 LBXp4hkrJu9RZsXEhIXRkPfJ7PY3W4F2BLjPh2GkTEQoDeX8vehkOIEvbteafdep3d
	 WlVXpw63jK0JKN5ig2Wnfsv6RDSkLS/wFGqlsktkUulZiKc4bm/Wx/2iMRqVTRbfGJ
	 MH5Sco7BVf/opQVi4EPntxE3aBuwhmx6axuE0qzvmdx66qw5S1DiAzRyshOlZQ18+k
	 jDFIfY6WNolTw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDH-00000001WNI-277Z;
	Wed, 09 Jul 2025 20:32:35 -0400
Message-ID: <20250710003156.209859354@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:31:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: rv: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
latency/for-next

Head SHA1: fac5493251a680cb74343895d0e76843624a90d8


Nam Cao (12):
      rv: Add #undef TRACE_INCLUDE_FILE
      printk: Make vprintk_deferred() public
      panic: Add vpanic()
      rv: Let the reactors take care of buffers
      rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
      rv: Add support for LTL monitors
      rv: Add rtapp container monitor
      riscv: mm: Add page fault trace points
      rv: Add rtapp_pagefault monitor
      rv: Add rtapp_sleep monitor
      rv: Add documentation for rtapp monitor
      rv: Allow to configure the number of per-task monitor

----
 Documentation/trace/rv/index.rst                   |   1 +
 Documentation/trace/rv/monitor_rtapp.rst           | 133 +++++++++++
 arch/riscv/mm/fault.c                              |   8 +
 include/linux/panic.h                              |   3 +
 include/linux/printk.h                             |   7 +
 include/linux/rv.h                                 |  75 +++++-
 include/linux/sched.h                              |   8 +-
 include/rv/da_monitor.h                            |  45 +---
 include/rv/ltl_monitor.h                           | 184 +++++++++++++++
 kernel/fork.c                                      |   5 +-
 kernel/panic.c                                     |  16 +-
 kernel/printk/internal.h                           |   1 -
 kernel/trace/rv/Kconfig                            |  27 ++-
 kernel/trace/rv/Makefile                           |   3 +
 kernel/trace/rv/monitors/pagefault/Kconfig         |  20 ++
 kernel/trace/rv/monitors/pagefault/pagefault.c     |  88 +++++++
 kernel/trace/rv/monitors/pagefault/pagefault.h     |  64 +++++
 .../trace/rv/monitors/pagefault/pagefault_trace.h  |  14 ++
 kernel/trace/rv/monitors/rtapp/Kconfig             |  11 +
 kernel/trace/rv/monitors/rtapp/rtapp.c             |  33 +++
 kernel/trace/rv/monitors/rtapp/rtapp.h             |   3 +
 kernel/trace/rv/monitors/sleep/Kconfig             |  22 ++
 kernel/trace/rv/monitors/sleep/sleep.c             | 237 +++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep.h             | 257 +++++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h       |  14 ++
 kernel/trace/rv/reactor_panic.c                    |   8 +-
 kernel/trace/rv/reactor_printk.c                   |   8 +-
 kernel/trace/rv/rv.c                               |  10 +-
 kernel/trace/rv/rv_reactors.c                      |   2 +-
 kernel/trace/rv/rv_trace.h                         |  52 ++++-
 tools/verification/models/rtapp/pagefault.ltl      |   1 +
 tools/verification/models/rtapp/sleep.ltl          |  22 ++
 32 files changed, 1307 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
 create mode 100644 include/rv/ltl_monitor.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_trace.h
 create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h
 create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl
 create mode 100644 tools/verification/models/rtapp/sleep.ltl


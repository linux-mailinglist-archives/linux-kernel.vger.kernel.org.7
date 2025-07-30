Return-Path: <linux-kernel+bounces-750400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB318B15AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E347B17D9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90E290BD5;
	Wed, 30 Jul 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2izFAdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BB26B951
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865393; cv=none; b=matI8yC6gUoGIBYNLPKIn17Dm7fTUXcn1uX2BwOkChEzmtzCEDzOtwpg/QeW+Y0dG7NXyswoffup7j4xQT1gebeYEflPV6TO7AA+G7/vOqABRKIR+7XGIZrxD0w+Drdz+bJVlRrVx5/dvD4LeO5JaBytlgtd8LJq/xcxBHrt9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865393; c=relaxed/simple;
	bh=JTcjhFpWVqr+c4yj1tsGY4Wohuh56FR48RkzxRCIA5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=j7iwNldlq33wzdqFEm1+x7TomJ8MNoVDZvL8JZ36CZH5uGt4wIm9pDhHLlckhFPOHEh6n0ZwC/GybjrG6WrMag78BiIn0n2T40hLaI5AkH3F+Pgyg/NyDWykYjMr6OlDoFxycbMwRT+j3ERO6CqAIVU74yQxw7NiYY3W2xrr4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2izFAdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D652C4CEE7;
	Wed, 30 Jul 2025 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865392;
	bh=JTcjhFpWVqr+c4yj1tsGY4Wohuh56FR48RkzxRCIA5Q=;
	h=Date:From:To:Cc:Subject:From;
	b=S2izFAdJEzsVGGIsAgzYY7d70Cj/LybFRnWhkmXEMrTVSPUiUbXYCLs36ME0KultP
	 yfzMOK/GVtY9Oltt5Q6mE5qBFRdJShVxd6a0YQht8S8Vj/abJcGmbl1mvNVSiaVnhV
	 T2o6XFR5w8saOX98lu1C84frliBte5hAXzTNR9cdx3a5rswnEfWv4UtZuCy43ahk17
	 wPbFRz8N3zuvaZX9SM6E6EhkY+Wsd7vJrdrfUzlKhCT4gm0A8nb4WoJ2BrmKMAhu7e
	 qlffBD2uKK7rOK8lkrZKfdK13ot9lAuvJGPpovs+JI/4P0D28/d1MHdzdwlF4dvP1E
	 9dk1O6v388zOg==
Date: Wed, 30 Jul 2025 17:49:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Peng Jiang
 <jiang.peng9@zte.com.cn>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Updates for v6.17
Message-Id: <20250730174946.6c21cafc03bd295c58cc149f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Linus,

Probes updates for v6.17:

 - Stack usage reduction for probe events:
   - Allocate string buffers from the heap for uprobe, eprobe, kprobe,
     and fprobe events to avoid stack overflow.
   - Allocate traceprobe_parse_context from the heap to prevent
     potential stack overflow.
   - Fix a typo in the above commit.

 - New features for eprobe and tprobe events:
   - Add support for arrays in eprobes.
   - Support multiple tprobes on the same tracepoint.

 - Improve efficiency:
   - Register fprobe-events only when it is enabled to reduce overhead.
   - Register tracepoints for tprobe events only when enabled to
     resolve a lock dependency.

 - Code Cleanup:
   - Add kerneldoc for traceprobe_parse_event_name() and __get_insn_slot().
   - Sort #include alphabetically in the probes code.
   - Remove the unused 'mod' field from the tprobe-event.
   - Clean up the entry-arg storing code in probe-events.

 - Selftest update
   - Enable fprobe events before checking enable_functions in selftests.


Please pull the latest probes-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.17

Tag SHA1: 04ecc3e4ee6e6163c07baeec62ffbff04fd8ae09
Head SHA1: 133c302a0c60bca1f0a2f5f85ef11e7f5e8f1331


Masami Hiramatsu (Google) (14):
      tracing: probe-events: Cleanup entry-arg storing code
      tracing: tprobe-events: Remove mod field from tprobe-event
      tracing: tprobe-events: Support multiple tprobes on the same tracepoint
      tracing: fprobe-events: Register fprobe-events only when it is enabled
      selftests: tracing: Enable fprobe events before checking enable_functions
      tracing: tprobe-events: Register tracepoint when enable tprobe event
      tracing: probes: Sort #include alphabetically
      tracing: probe: Allocate traceprobe_parse_context from heap
      tracing: fprobe-event: Allocate string buffers from heap
      tracing: kprobe-event: Allocate string buffers from heap
      tracing: eprobe-event: Allocate string buffers from heap
      tracing: uprobe-event: Allocate string buffers from heap
      tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()
      tracing: trace_fprobe: Fix typo of the semicolon

Peng Jiang (1):
      kprobes: Add missing kerneldoc for __get_insn_slot

Steven Rostedt (1):
      tracing: Have eprobes handle arrays

----
 include/linux/fprobe.h                             |   5 +
 include/linux/module.h                             |   4 +
 kernel/kprobes.c                                   |   8 +-
 kernel/trace/fprobe.c                              |   5 +
 kernel/trace/trace_eprobe.c                        |  53 +-
 kernel/trace/trace_fprobe.c                        | 614 ++++++++++++++-------
 kernel/trace/trace_kprobe.c                        |  57 +-
 kernel/trace/trace_probe.c                         | 150 +++--
 kernel/trace/trace_probe.h                         |  26 +-
 kernel/trace/trace_uprobe.c                        |  53 +-
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |  30 +-
 11 files changed, 664 insertions(+), 341 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


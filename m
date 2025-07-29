Return-Path: <linux-kernel+bounces-749830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD52B15368
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299953BAFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFC239E81;
	Tue, 29 Jul 2025 19:25:11 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FA347DD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817111; cv=none; b=shlBEF5oM1ZZ8x/M5zxtebl/wFhTFXpVwBoWBofHzUFznN4Re+8Pl394R7UQvXRhY6qVx5sTb5Xey96yNATzGA5D6bCF6ohtCV2sE9KaMjjiTxnPlGgGgoz1GcW+Y2YdGfIeubPWOebceJPPp9UZGTqch6juW2Ajm7b1wiwhO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817111; c=relaxed/simple;
	bh=mHGvFrOMIR8tNF9riGxTGUqKgcN9t16ywT+wS9CkByA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O7slP6h7NUpxewpIK1NC+aWjc7+Vq2xlYYRaKQU7U5xX1ftCT9ACdjrHQQ2uqTU8NN58YR1d85lFvO9aL79GG0gtN+E4nJYADakpNuT2rnWLin1RSmiaaaSO56bHZFlmBpse4b1aliETj8XnPzmFu3R1QYx00aJIObF1Px54E4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D7F241401FF;
	Tue, 29 Jul 2025 19:25:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 3A67319;
	Tue, 29 Jul 2025 19:25:00 +0000 (UTC)
Date: Tue, 29 Jul 2025 15:24:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Colin Ian King <colin.i.king@gmail.com>
Subject: [GIT  PULL] ring-buffer: Updates for v6.17
Message-ID: <20250729152459.062d15b3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3A67319
X-Stat-Signature: uq3stgbxcn4fcxohma7rxh59451paoxy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19o/fkzjw7FHNR/Fw443+VcTumuVqnLVkA=
X-HE-Tag: 1753817100-666390
X-HE-Meta: U2FsdGVkX1/4p/yvabOecK7iWBlOb7whG67QeSekffb4isa+BWGL+S4VzweAx0E2tO9J2Ntk0vEgtp0qF44Bo6DHKzMiz8dlP40swnbcXg9uUjymNeZY5E5RB+oOG4I4MTdAJ9LW26gd3oxW6mEb6r50YacEguw6wAtB93t5xPXcbnDGCqc2Ge4EKtSCTg6y0NdxwibMPgHyVT8WEPH8k/o86wbHmsKUygZgMX4zUZazx+WTqktpn5QzdGl/Mx+SQmXEIDCJt1Qw37cRbDjl019ZnaPIVyQLQ3JtsTtal5S99TFL6/TjAvnclzwCZ4II1oUBQqslkLrFdh8B8x6B7MYvCeahMt7a


Linus,

ring-buffer changes for v6.17:

- Rewind persistent ring buffer on boot

  When the persistent ring buffer is being used for live kernel tracing and
  the system crashes, the tool that is reading the trace may not have recorded
  the data when the system crashed. Although the persistent ring buffer still
  has that data, when reading it after a reboot, it will start where it left
  off. That is, what was read will not be accessible.

  Instead, on reboot, have the persistent ring buffer restart where the data
  starts and this will allow the tooling to recover what was lost when the
  crash occurred.

- Remove the ring_buffer_read_prepare_sync() logic

  Reading the trace file required stopping writing to the ring buffer as the
  trace file is only an iterator and does not consume what it read. It was
  originally not safe to read the ring buffer in this mode and required
  disabling writing. The ring_buffer_read_prepare_sync() logic was used to
  stop each per_cpu ring buffer, call synchronize_rcu() and then start the
  iterator. This was used instead of calling synchronize_rcu() for each
  per_cpu buffer.

  Today, the iterator has been updated where it is safe to read the trace file
  while writing to the ring buffer is still occurring. There is no more need
  to do this synchronization and it is causing large delays on machines with
  many CPUs. Remove this unneeded synchronization.

- Make static string array a constant in show_irq_str()

  Making the string array into a constant has shown to decrease code text/data
  size.


Please pull the latest trace-ringbuffer-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ringbuffer-v6.17

Tag SHA1: 9969b67120a3c22ea35c93dc8f2f81dce5143a38
Head SHA1: 6443cdf567a900e03afe1d66fb8bcc7dad0835d0


Colin Ian King (1):
      ring-buffer: Make the const read-only 'type' static

Masami Hiramatsu (Google) (1):
      tracing: ring_buffer: Rewind persistent ring buffer on reboot

Steven Rostedt (1):
      ring-buffer: Remove ring_buffer_read_prepare_sync()

----
 include/linux/ring_buffer.h |   4 +-
 kernel/trace/ring_buffer.c  | 168 +++++++++++++++++++++++++++++---------------
 kernel/trace/trace.c        |  14 ++--
 kernel/trace/trace_kdb.c    |   8 +--
 4 files changed, 119 insertions(+), 75 deletions(-)
---------------------------


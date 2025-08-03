Return-Path: <linux-kernel+bounces-754422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24577B19420
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B1D1747A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F111EB195;
	Sun,  3 Aug 2025 13:54:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEC79F2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754229299; cv=none; b=E2Jc7r7CxU+5vBKR4TBhnJvbCqDVbSsGyQVS3LZulR1yqrQnFUpOdf53gsVU1eqA1A7C7yVHwsei7oM/100hXzpPtgzXs6lrnOWcxJix5kB8KD9ct36VXEusLwQQFouSQipIeqWDGnPxbtsrHvebCJogE6iH30+FEdETI8U1KJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754229299; c=relaxed/simple;
	bh=Tf4rvlIVPI8tSe+zIKYlcgGYPdFAFrCuUUjDTzoppoE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Sgo6Qtb1Zww6VgRnnvgIk1le9I2Xmlo+VQCBiqFxBQSetKtuAtQdX9w+xziPJCSAdKlWwgQKEULPz/RMgZrlLPYlElXQrhvxSobVKLGq2u3NAUAnmlT9bel2AMeFsT+pn0CFtGpoSrSK1F/bTfnZwdktLLfD+7S7nfNbfOKTVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8CAF41154D2;
	Sun,  3 Aug 2025 13:54:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id DEED420027;
	Sun,  3 Aug 2025 13:54:46 +0000 (UTC)
Date: Sun, 3 Aug 2025 09:55:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Cleanups for v6.17
Message-ID: <20250803095511.6b59d10b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: muhkabjw3sqode4c3kx6ahqdus8q7zzj
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DEED420027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/t+aNbi6fBFLVogyYST2vbGgfDvz0hwOc=
X-HE-Tag: 1754229286-592368
X-HE-Meta: U2FsdGVkX1/6q9nM7k5qqkNMLhSx6hQ/0kg8344yF/HqBwsE/hcoNt2qq0VokCYMZ8yNQwJd4qAVN0wt/BOsFNUtsA5YBHfJHrdrDlNDi9Hu2SvtYspTjaOmDo8gTfm5fofUrP+R4JxBjS7ZTXLPkI2K28rknIYPTGLaZbQGkQ+c4eXXANGMLg5oiYWB2q2HkwAjt9HtePFQjHeNdcgB2+gQ5K4al71fue//95s5yRpS075EwxRFDUc92YFjNS47L8DbtDnS3H1mK66DOgl72TBxy3LznPV+cApC41486LoHjVFc6LxPVs6rYaHoVqV/h2GkYx2Muel4Bb3xRbN7ePlMeSpzu2hd



Linus,

tracing cleanups for v6.17:

- Remove unneeded goto out statements

  Over time, the logic was restructured but left a "goto out" where the
  out label simply did a "return ret;". Instead of jumping to this out
  label, simply return immediately and remove the out label.

- Add guard(ring_buffer_nest)

  Some calls to the tracing ring buffer can happen when the ring buffer is
  already being written to at the same context (for example, a
  trace_printk() in between a ring_buffer_lock_reserve() and a
  ring_buffer_unlock_commit()).

  In order to not trigger the recursion detection, these functions use
  ring_buffer_nest_start() and ring_buffer_nest_end(). Create a guard() for
  these functions so that their use cases can be simplified and not need to
  use goto for the release.

- Clean up the tracing code with guard() and __free() logic

  There were several locations that were prime candidates for using guard()
  and __free() helpers. Switch them over to use them.

- Fix output of function argument traces for unsigned int values

  The function tracer with "func-args" option set will record up to 6 argument
  registers and then use BTF to format them for human consumption when the
  trace file is read. There's several arguments that are "unsigned long" and
  even "unsigned int" that are either and address or a mask. It is easier to
  understand if they were printed using hexadecimal instead of decimal.
  The old method just printed all non-pointer values as signed integers,
  which made it even worse for unsigned integers.

  For instance, instead of:

    __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs

  Show:

   __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs


Please pull the latest trace-v6.17-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.17-2

Tag SHA1: 9b49d74f0b5ded00a817117fcd389b253a94577f
Head SHA1: 3ca824369b71d4b441e1fdcdee8e66bcb05510a9


Steven Rostedt (6):
      tracing: Remove unneeded goto out logic
      tracing: Add guard(ring_buffer_nest)
      tracing: Add guard() around locks and mutexes in trace.c
      tracing: Use __free(kfree) in trace.c to remove gotos
      ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)
      tracing: Have unsigned int function args displayed as hexadecimal

----
 include/linux/ring_buffer.h       |   3 +
 kernel/trace/ring_buffer.c        |  16 +--
 kernel/trace/trace.c              | 287 ++++++++++++++------------------------
 kernel/trace/trace_events_synth.c |   6 +-
 kernel/trace/trace_output.c       |   8 +-
 5 files changed, 120 insertions(+), 200 deletions(-)
---------------------------


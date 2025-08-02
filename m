Return-Path: <linux-kernel+bounces-754177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7EB18F60
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71652189BB9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF7624BBEC;
	Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0VTQfkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97FA48
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152085; cv=none; b=m8XWPRIGav6r2dn2eGm2j2Y3Igfhq8sJb2KaMrvhWafkuE4+gKZvWxgKScUzFFay99XUjwrRQse/kkh6gQUlf12kdrHp0wGcyh00kCv3ccOIaCM5j5yGOAI7D+QJk44WVDJ42XEAid4pSOCRAUFtaDIerolm2sQjhTO4yBWYmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152085; c=relaxed/simple;
	bh=e/iWv+Zkrighj6UZ/h9GgpUxzTdc/gKY3p0sSNGO04M=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Ss/qcc7XsHRodbT7dgzzR/pRj0r5wh9du58bh6sg/SP0EWP96J9ra06aV+vwY2iU3Fq9FmqmT+SHMJ+f5KyU1xGlW1yjI5KUdY9TU7UXgorZq409RiDnV75y3ppMFVTDgZXJ6ZYz1qtm4I9BpRtdRDSV3iZIix4KTdtmsm+ZRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0VTQfkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4708C4CEEF;
	Sat,  2 Aug 2025 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754152085;
	bh=e/iWv+Zkrighj6UZ/h9GgpUxzTdc/gKY3p0sSNGO04M=;
	h=Date:From:To:Cc:Subject:From;
	b=T0VTQfkY9Z8MTT8hRh/usyD/XYt3ZH4wp9yD/cbUj1Di4aOmNt5Z9pZEUw1IAdmH2
	 0caSUkyN2TJH2fO6jDIQnzRXPQ5eQZITr2enFSApKeZ/E8xbjI1bQ9k7VGw/lFettP
	 xNTDucO0C6N+tIRL9ydFX9RuFwckxdgiyh2faTPvPltgAX08HI56PG5Q84jwz6rbxW
	 4+YY73K1j3V1cZJUw444uHBKiyyV636sSxtXXsxdLc1uaLJMrdbtiP9qXKgXXc3uvR
	 uRg9jgbDBKsjMjhV89fBcDUKZJQ/YUG9iILDIYRuCNCcf6Pm30K8QyGAt3aiqPiitQ
	 HcKepypi2vA7Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uiF5x-00000008SW5-00Bj;
	Sat, 02 Aug 2025 12:28:29 -0400
Message-ID: <20250802162734.529626660@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 02 Aug 2025 12:27:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/6] tracing: Final clean ups for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Last minute changes for v6.17

- Remove unneeded goto out statements

  Over time, the logic was restructured but left a "goto out" where the
  out label simply did a "return ret;". Instead of jumping to this out
  label, simply return immediately and remove the out label.

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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

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


Return-Path: <linux-kernel+bounces-835390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56EBA6F92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF5C17A6B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E62DCF6B;
	Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqURN7CZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C48299922
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057651; cv=none; b=tyyPcBLrMLcAlUy8FdCv+CZ5vtIDkCBmluHBk96ibBICjo5nw/zmp59P0wgicMaMgmsUcwVb7Ptfno+d4t3147daaIrntKXbbpcdUlOsnVvTf298Gs9aOL05B+Jg5lkv6AIi5K5Mx8SImdkFW+jkcz/n8k1QOL/yqi4Q1+/nDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057651; c=relaxed/simple;
	bh=j0gn6MJqKEly08fl24M8zJ4GOpJQztDVzq3cj3URuiM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ObgREOn2vaiX1XHF2WywNGLG3pEwfOqiv3O0Da+XtwLzSxYwxxEaaCCj2lEpZh8Qi+pwfjmf1YKC/CNtHRkxClW9oRflSb4VevDpqu/jTPIEjaN+1ngVb8oPNjL67cPev/fJNW+2mz+8zpw4p2w8GLRG2AxJWKPbn5s5OZiu5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqURN7CZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D686CC4CEF0;
	Sun, 28 Sep 2025 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057650;
	bh=j0gn6MJqKEly08fl24M8zJ4GOpJQztDVzq3cj3URuiM=;
	h=Date:From:To:Cc:Subject:From;
	b=QqURN7CZ1vq+aU+d9X3LzECzMmBYek0i5rM0DnFDooZr3nFM4JeypWzvYWvAGicE0
	 QtIYvxR4ktb+OJ5pc7EQGzrG9hMhkUyE6vI2m+/Lkzj1bTUkm+cnhOF0ahNicgdcsH
	 uVmBYCkYakNcLCTCIZ3auYbaMSNB/okHU3AwM58jyvMOZHkigylUZVIdPC/sZy/m+M
	 H86eFXi7tHJWuFtrj1Zlvy1Yfo8zZOwPvbOliuQ3EeDT8w9q4eKPnmPFstPtWnQ23b
	 Ers1wEdWyYo4KxGWMWdNHdw03Nl/IByw9tXuRLqU9kZaRkihuhiySGPqLn1n0OtUJc
	 aR/WYNa5NimTQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2pH3-0000000D8NO-2QU1;
	Sun, 28 Sep 2025 07:09:01 -0400
Message-ID: <20250928110832.098564441@kernel.org>
User-Agent: quilt/0.68
Date: Sun, 28 Sep 2025 07:08:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wang Liang <wangliang74@huawei.com>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.17

- Fix buffer overflow in osnoise_cpu_write()

  The allocated buffer to read user space did not add a nul terminating byte
  after copying from user the string. It then reads the string, and if user
  space did not add a nul byte, the read will continue beyond the string.
  Add a nul terminating byte after reading the string.

- Fix missing check for lockdown on tracing

  There's a path from kprobe events or uprobe events that can update the
  tracing system even if lockdown on tracing is activate. Add a check in the
  dynamic event path.

- Add a recursion check for the function graph return path

  Now that fprobes can hook to the function graph tracer and call different
  code between the entry and the exit, the exit code may now call functions
  that are not called in entry. This means that the exit handler can possibly
  trigger recursion that is not caught and cause the system to crash.
  Add the same recursion checks in the function exit handler as exists in the
  entry handler path.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: 0db0934e7f9bb624ed98a665890dbe249f65b8fd


Masami Hiramatsu (Google) (2):
      tracing: dynevent: Add a missing lockdown check on dynevent
      tracing: fgraph: Protect return handler from recursion loop

Wang Liang (1):
      tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()

----
 kernel/trace/fgraph.c         | 12 ++++++++++++
 kernel/trace/trace_dynevent.c |  4 ++++
 kernel/trace/trace_osnoise.c  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)


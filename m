Return-Path: <linux-kernel+bounces-778701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46493B2E91B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160691BC77C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3321E198E9B;
	Thu, 21 Aug 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHtZjqar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267F27280F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734411; cv=none; b=mA4T45WNZjfZJG5yIPT8jN2jUTa9j6cXH7xd4FTYchCFDnqlTmvLfkkT9jVQFSL6gU5ekelhyFo4/qRSZetlFrTK3QGlgFigyNU8gUF5PQVIfmVQAC24pj1JcyMDPJLEr57ipq8pd+3NBupzrQjBXJA0GRltZAOGXlBU7+w7Db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734411; c=relaxed/simple;
	bh=gf6AVBzhbm9azOLOWfei7spaFsD3lxXUzEc3qCjhKbs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=lojqGOUNuvQTJClv4CF4pxVsbfP5OXhROJ3mkXsrSP2CAKVT7dZrphf/6XJvr0S4tN7dCUlbIoI5ev/96uGlKRouw3W5ZRYpjrwSf3wVdPbtRiUeZB8aeaUD+I/uHf8dBiZRe52SirpVO2vZ+6oN0R9V4w4G3oHxDvqgOJTkIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHtZjqar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C2EC4CEEB;
	Thu, 21 Aug 2025 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=gf6AVBzhbm9azOLOWfei7spaFsD3lxXUzEc3qCjhKbs=;
	h=Date:From:To:Cc:Subject:From;
	b=QHtZjqarNJNfeqEcNWLNfkSFGK/lA6Z9mxfBq0djaSchdH6BHs4geUAE1BEQTkccP
	 ik5axa8ibO3ZWqpFVYJ2q0xXu0G0A1va5d+8we+Y3VNYi+sbPmxgfMbkhXv3PLMjqT
	 BA3jJlWqsibgjeuXSqZG6z3apAO91bRaO3LeykuclXUEq4JZ+4+RtaRwrgb7aZE4xZ
	 8QX1wR8usSjZplx24IWSHlWLwcYGkHw4+4fN5RBzrcLysFdJfoKki7czSeEgCsWwAk
	 C1BjR1s4JrYoNX/icga4Dk9jw1wd6R1A7VOoBH2b0P9LZV1T9iOVHd2U2cr/Rajxn+
	 g3bfpr+2eZkIw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj0-000000013cE-1BwE;
	Wed, 20 Aug 2025 20:00:14 -0400
Message-ID: <20250821000000.210778097@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Fixes for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.17-rc2:

- Fix rtla and latency tooling pkg-config errors

  If libtraceevent and libtracefs is installed, but their corresponding '.pc'
  files are not installed, it reports that the libraries are missing and
  confuses the developer. Instead, report that the pkg-config files are
  missing and should be installed.

- Fix overflow bug of the parser in trace_get_user()

  trace_get_user() uses the parsing functions to parse the user space strings.
  If the parser fails due to incorrect processing, it doesn't terminate the
  buffer with a nul byte. Add a "failed" flag to the parser that gets set when
  parsing fails and is used to know if the buffer is fine to use or not.

- Remove a semicolon that was at an end of a comment line

- Fix register_ftrace_graph() to unregister the pm notifier on error

  The register_ftrace_graph() registers a pm notifier but there's an error
  path that can exit the function without unregistering it. Since the function
  returns an error, it will never be unregistered.

- Allocate and copy ftrace hash for reader of ftrace filter files

  When the set_ftrace_filter or set_ftrace_notrace files are open for read,
  an iterator is created and sets its hash pointer to the associated hash that
  represents filtering or notrace filtering to it. The issue is that the hash
  it points to can change while the iteration is happening. All the locking
  used to access the tracer's hashes are released which means those hashes can
  change or even be freed. Using the hash pointed to by the iterator can cause
  UAF bugs or similar.

  Have the read of these files allocate and copy the corresponding hashes and
  use that as that will keep them the same while the iterator is open. This
  also simplifies the code as opening it for write already does an allocate
  and copy, and now that the read is doing the same, there's no need to check
  which why it was opened on the release of the file, and the iterator hash
  can always be freed.

Liao Yuanhong (1):
      ring-buffer: Remove redundant semicolons

Pu Lehui (1):
      tracing: Limit access to parser->buffer when trace_get_user failed

Steven Rostedt (1):
      ftrace: Also allocate and copy hash for reading of filter files

Tao Chen (2):
      tools/latency-collector: Check pkg-config install
      rtla: Check pkg-config install

Ye Weihua (1):
      trace/fgraph: Fix the warning caused by missing unregister notifier

----
 kernel/trace/fgraph.c                 |  1 +
 kernel/trace/ftrace.c                 | 16 +++++++---------
 kernel/trace/ring_buffer.c            |  2 +-
 kernel/trace/trace.c                  | 18 ++++++++++++------
 kernel/trace/trace.h                  |  8 +++++++-
 tools/tracing/latency/Makefile.config |  8 ++++++++
 tools/tracing/rtla/Makefile.config    |  8 ++++++++
 7 files changed, 44 insertions(+), 17 deletions(-)


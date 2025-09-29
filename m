Return-Path: <linux-kernel+bounces-836845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F56BAAB43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B27A1EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7A6226CF7;
	Mon, 29 Sep 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd+AufYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43211DF271;
	Mon, 29 Sep 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185287; cv=none; b=L/Szu6YRpLjEpm0GKofGEBkzmLnVF5CoaSmTZbn9XYF4fUkYY+4Zi/NfsZEpC7MouDkyzJ8ZFu7bjFzhXU6PmwL3Djnc4lViNZ99UBQWgXiEoTeJu6x8SNnPn7BeGInIc5b83taIa5NeMwiaMAplthY/pz29Q7r0R78SzLQIiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185287; c=relaxed/simple;
	bh=I6arWtUDDy5fEhbxtcn16Npmk2LXjNocui5zcRe+gQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=imCWex7oUSENk31YkYkLZdOcydFJ47LCGTAEtCR+sfT5edhQbL/JT1O0xcTLGDEaYmqKRfaGWakCKQHxmr8ae38lSm4ZcblVrN/EiEHdEUWKeCdUjRowSpQ6Wfn+mOf0Cv5zdztFbU9mzn3A6Na/KPsjghlmJXzx9KMLsRgZa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd+AufYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161CFC4CEF4;
	Mon, 29 Sep 2025 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185287;
	bh=I6arWtUDDy5fEhbxtcn16Npmk2LXjNocui5zcRe+gQY=;
	h=From:To:Cc:Subject:Date:From;
	b=hd+AufYsV8JR2zeyh2L1LbvwQhpAfp1smzezB9tLROTCT9fuuzLGdm+m2V7XkI6Gj
	 WmOz7r3iQt/tuqyPA8v58+tGI+1cCDK/m6vZFT8rmXRnwCx9icLLtTvyRw6e21UG9E
	 4Thnt5uxGu0caMF6UhNv35IS3V2//sVVd6RtBXlhLyzwnAVL6KpC+5ux1yuzaRSGaT
	 3aFrDSfbkXrdtU9CXGS4Q8buwbZZorSZKXCKGn6Fq2wewgnm1/FVGHdeq8ZT7KPvnv
	 gf7iNFHkHkUpk9sZw4dhlt4YKtplgjUhf5PIsI/cD6oxOZb3ahlZ5hMq07iFKyT41V
	 rM8yYGUNjnX8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Tue, 30 Sep 2025 07:34:43 +0900
Message-ID: <175918528341.65920.10238038992631012350.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This series implements an option to show symbols in _text+OFFSET
format instead of symbol name in the function profiler.
This is the 3rd version, the 2nd one is here;

https://lore.kernel.org/all/175854516202.353182.1216978967046454932.stgit@devnote2/

This version fixes to declare TRACE_ITER_* in trace.h and define it in
trace.c [1/2].

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler


 kernel/trace/ftrace.c             |   26 ++++++++++
 kernel/trace/trace.c              |   29 +++++++-----
 kernel/trace/trace.h              |   92 +++++++++++++++++++++----------------
 kernel/trace/trace_irqsoff.c      |    2 -
 kernel/trace/trace_sched_wakeup.c |    2 -
 5 files changed, 96 insertions(+), 55 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>


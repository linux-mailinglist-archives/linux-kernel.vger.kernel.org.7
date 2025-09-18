Return-Path: <linux-kernel+bounces-803163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E9B45B78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBF3AF91D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4037C0FE;
	Fri,  5 Sep 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY8Zv952"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DA306B2D;
	Fri,  5 Sep 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084352; cv=none; b=ECY2ZcQ/h0HkjQgBOoQv7nUeY5ZDu+JtRzNU5RYwyM05ygCDk1he3xQniE7aod4lzqGmhXOM2P7CGvrAU8x6Z/gws9UxNal+HiEUKYnptVvdkRmUc43+zvzyndz/IWuFp7bjZGtA5TCuyUEQiR5lYUM4C+E5Pf+P7O3fkQC3Bgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084352; c=relaxed/simple;
	bh=YmnJaLz0IT7+Cz6HPZlkjrX2bTrODXvTpLb48ZgINCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxUVC3gsd+1rc2uIzuhSnKainbI/6Br4YtNsHGejTgHaMSqkoKr9PYtuj32l5YpcFU3glrVay7wxuTDVgRg6Ss9394As5AT2nSaolBKI4UlpiQ6cD5be2I/snBNoPnmJ0Fk5becEK0Bmz+UosNALSYH6idA38te8IU6dSd9x5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY8Zv952; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DFEC4CEF1;
	Fri,  5 Sep 2025 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084351;
	bh=YmnJaLz0IT7+Cz6HPZlkjrX2bTrODXvTpLb48ZgINCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jY8Zv952wb/Q8W/J63HPd2ABUL5kpgAUMBceZRLhyiqphtw4Zln9Gu7tGjom1VB7y
	 p6tsuy1ismksy6XT+qjc3hela7bgo5nQZ8Kok0jpidpgy8f7CJ4F+cV/avT02QKL1C
	 zjjdLFjvtecJWI6PAJP7COsgPoCkfmxKOX+GzHNY1T7O6TdH/4RKPpMwxCOA1DbglD
	 alclBs1bYIYPLDro3nexcG33erHQqU+Q19eYx9t6b3RzgYtlcS/luO/6xyMIUbN35E
	 JO3FEgmQWJ+6MyamBz4mHzgz+KEIWmf/k7roe5hhQlG9VlSUHfHEGraPwoUu3WEBC9
	 ZSiPqId5Ed5iw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 6/6] selftests: tracing: Add syntax testcase for wprobe
Date: Fri,  5 Sep 2025 23:59:05 +0900
Message-ID: <175708434524.64001.3071330722993500865.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175708427997.64001.11661389635019507808.stgit@devnote2>
References: <175708427997.64001.11661389635019507808.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..82a273d9efb4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'event_probe' "$1" 'dynamic_events'
+}
+
+check_error 'w ^symbol'			# BAD_ACCESS_FMT
+check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
+check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
+check_error 'w w@^jiffies+offset'	# BAD_ACCESS_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0



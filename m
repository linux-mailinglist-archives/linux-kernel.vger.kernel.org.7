Return-Path: <linux-kernel+bounces-889392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C6C3D72B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A563B698D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78AE3043D1;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwoqkCWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF8303A32
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=KMGIHtZfKj1RF2+p0d+eC+aszff0Dn1OBqh8/8w44+p9JiZAtxZQMpBtQU2XrHJQ7rfvUNi8lu5DqOB2/0YFM+6nrSqMFhfTVtGhdF548kUI71dzn+4SKZvDPYUzLKo2JcxqZIitKLF8u8nIwZUuZWkUMPNtriNZPaPh8TeEfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=nxdKcSMKIeOHIPM+goweIhbi14dqb7tSaevc+KLnwBU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BuG6L+CoNQMCgMQT/oWLm7JBqUBUOKLTrPndJDdNuC7ZaFSYWzMK8G62rHLfkCiBKHuMwBgzgotsuI152HmTHnSkq54z2+vdloj3TDlWqcymrwmBilnAf7F1mWeJpc8lG3a2K9Ve5SPzjEv+tckxHeG2H50j13bAFTGqHWFRzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwoqkCWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17D6C113D0;
	Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463037;
	bh=nxdKcSMKIeOHIPM+goweIhbi14dqb7tSaevc+KLnwBU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kwoqkCWawTK16Jbyr6WIWvmwTGy0HMn8G8cGvf3vLIsXkdH1cO5+ZY/8tOzXauAvJ
	 oP/cuvRUVvg2cXa+jtJ53F6Ej2d7qDBCDzYyc+hirx/fnrB2EiPpfoE83TIs+bKhT6
	 H9d7ioPYSV0ZICBIo589Pklq8FQnzgms8Lkmp/GNrMm+qmrzMLesblrYheioRS45rX
	 1dQQR+NfoLk2bqMKTXdPr+obJph/Km7/dE1il8A6zvNSITii8kWJi5xMWiU1iPM/EX
	 83GvMULK47K2hvzkym2NYjLCUrsD7fvLudFm+3bYreeQ7QJBkX78pLXN5frRbVm3h/
	 zXe0sr1eiBnFg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79B-000000008CM-20Oa;
	Thu, 06 Nov 2025 16:03:57 -0500
Message-ID: <20251106210357.328874176@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:34 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 3/7] tracing: Hide __NR_utimensat and _NR_mq_timedsend when not defined
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some architectures (riscv-32) do not define __NR_utimensat and
_NR_mq_timedsend, and fails to build when they are used.

Hide them in "ifdef"s.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251104205310.00a1db9a@batman.local.home
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511031239.ZigDcWzY-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e07c5a3cc7ab..e96d0063cbcf 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1072,7 +1072,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	switch (nr) {
 	/* user arg 1 with size arg at 2 */
 	case __NR_write:
+#ifdef __NR_mq_timedsend
 	case __NR_mq_timedsend:
+#endif
 	case __NR_pwrite64:
 		sys_data->user_mask = BIT(1);
 		sys_data->user_arg_size = 2;
@@ -1186,7 +1188,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_syslog:
 	case __NR_statx:
 	case __NR_unlinkat:
+#ifdef __NR_utimensat
 	case __NR_utimensat:
+#endif
 		sys_data->user_mask = BIT(1);
 		break;
 	/* user arg at position 2 */
-- 
2.51.0




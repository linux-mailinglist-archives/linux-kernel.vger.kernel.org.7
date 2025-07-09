Return-Path: <linux-kernel+bounces-724513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39CAFF3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784A75A6BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DA23B615;
	Wed,  9 Jul 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OmtXyuVT"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C551714B7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096364; cv=none; b=MiF4pjCfxWLw37mNMyFQyP3soN3kOSr/gTvAKOhPacIg/NJtSHZ4RwpCqpc5DbXPq1pwlDkizp2qMcVuu13SP2lX5jDE7W5YtllMeUUbEZkh80aWSib+jSFva2GM+hsWrhzjHKdiq+tAfwWMgxxEUSZsrQmT2pdjmEZPqUB25s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096364; c=relaxed/simple;
	bh=l0aAEK1+w6NZL1qJtmfCltCX+cXhwjP5UlXI/9jMb7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9GlQZUtCWC8EkkH9bF1v0bikhQ//ddAN2T7OiZBhvLYEVIFky9CQW8I4GMqOMmNDOkBX11h0CvwYsVCv9Z3t6W4lkhc7vOyQMc6TydEoFLArxoydSTVTQMHXJ78Qa4j7ewsCUdnrzZLFu/6dcmjTsZ+oJCViSHgtdX+o6b409s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OmtXyuVT; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752096361;
	bh=l0aAEK1+w6NZL1qJtmfCltCX+cXhwjP5UlXI/9jMb7s=;
	h=From:To:Cc:Subject:Date:From;
	b=OmtXyuVTEG0xxEe2r5J/t0XIRsubjP0Wl32gkKDJT6HJvL03vpcoKaHAUykEreHEU
	 6b4aVxs1XOZuTPZc8UXLyS1GEN31LavJLUUmkmpoopfTpFGt7o/ysFZkv9QmUYNuf3
	 M5fupSJWTRrXE04PPNS/saNKqQmYhrc8UzIl/7hZvFsFhsTPxJ6BtUSPW4uK7WCY5q
	 Bb5wn7u4X8JGUjgn9YltnYFonYrBdmjgDIFkNUb97UkTng9YfSTSV8OOPnwNdjVPvi
	 IoCsZxtrYnj1OqU+O6oGN9sU+bLB/AISViTcdVGCz4mph3uCUq6ZCKPgY+5NRGIQpP
	 H/FbCuQ7AyvUg==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcrcn3WWkzPN4;
	Wed,  9 Jul 2025 17:26:01 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 0/5] Improvements to unwind user
Date: Wed,  9 Jul 2025 17:25:47 -0400
Message-ID: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a few improvements to unwind user for feedback.

Thanks,

Mathieu

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Mathieu Desnoyers (5):
  unwind_user: Fix userspace unwind iterator 32-bit compat handling
  unwind: Export unwind_user symbol to GPL modules
  unwind deferred: Introduce unwind_user_trace_cached
  unwind: Rename unwind_stacktrace to unwind_user_stacktrace
  unwind: Introduce unwind user entry type

 arch/Kconfig                             |   4 -
 arch/x86/Kconfig                         |   1 -
 arch/x86/include/asm/unwind_user.h       |   9 +-
 arch/x86/include/asm/unwind_user_types.h |   4 +-
 arch/x86/kernel/stacktrace.c             |   6 +-
 include/linux/unwind_deferred.h          |   8 +-
 include/linux/unwind_deferred_types.h    |   6 +-
 include/linux/unwind_user.h              |  11 +-
 include/linux/unwind_user_types.h        |  36 ++++--
 kernel/unwind/deferred.c                 |  35 +++++-
 kernel/unwind/user.c                     | 147 ++++++++++++++---------
 11 files changed, 167 insertions(+), 100 deletions(-)

-- 
2.43.0



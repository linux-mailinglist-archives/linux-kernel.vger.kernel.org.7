Return-Path: <linux-kernel+bounces-726178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC856B00915
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0861708A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104302EFDA3;
	Thu, 10 Jul 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OCldayib"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1047274FD0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165789; cv=none; b=ECVp56LabaLQJelv1rSeAEPodE2umSkcxV7oaRayvqgbqMm14G63kG34rDILT9+c1UPRuxr6r2JMsMN/AATmTIQQL4rbCKC8P2ydS7hGPYZqLrs9yQpvGM7HqapMO2WS1KTXeP6MM5kF2HJzYDSHgMz0cp85KMYbrCUyuuHu4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165789; c=relaxed/simple;
	bh=u7y7SDVfmxSF/pRXg/y1w8n3UBzv76AaGhTfMy1t0PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wuog5FSyeOVpQAEuLUD/UeeG3RRS/8z3FR8rD0nneWC7v0f4w6TtIzxAlG188JFNvhrt4j09i85WLWYAFqMZ8Qr12S/cns8YmqOZsPm0LnlzkdVyYZuHhbkmzrkqhAtte6KwTJ5dsssxMTwFaPI1uDZeOGCkZfG94wkgnISj350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OCldayib; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752165786;
	bh=u7y7SDVfmxSF/pRXg/y1w8n3UBzv76AaGhTfMy1t0PQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OCldayibHImcD9vs7uWJ/sVcjkux6rro4Lme4bX5wPQgEREPoaqwrShY6vqFTtbcf
	 3/rZOF7R+YmMr/HfCoc+MOb447wjcDQsCIyv7sudAHMM1ryvP2kKxjSmniKyPBLh5R
	 Q29pDmP6f33QpzkhEW1jx3rj8OUDtYd/5RiUzomTivyUdqC9E74i0eTk+PbTtwNLqv
	 KFkPqRnKYHLGqzCcrxgdMR2uXup9k0fHZWE+kFE8r6S4gVSUDdpPm4F4RyBJwxteTZ
	 Zgz5DVccMxEcFzCXb1K40++GfzocD4Y2MDf9v4E6ysSHp1FWg3ALSUozvV6DC7feF4
	 tsEmeZjSQheQQ==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bdLHt2DHRzpqn;
	Thu, 10 Jul 2025 12:43:06 -0400 (EDT)
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
Subject: [RFC PATCH v2 0/3] Improvements to unwind user
Date: Thu, 10 Jul 2025 12:42:55 -0400
Message-ID: <20250710164301.3094-1-mathieu.desnoyers@efficios.com>
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


Mathieu Desnoyers (3):
  unwind_user: Fix userspace unwind iterator 32-bit compat handling
  unwind: Export unwind_user symbol to GPL modules
  unwind deferred: Introduce unwind_user_trace_cached

 arch/x86/include/asm/unwind_user.h |   6 +-
 arch/x86/kernel/stacktrace.c       |   2 +-
 include/asm-generic/unwind_user.h  |   4 +
 include/linux/unwind_deferred.h    |   2 +
 include/linux/unwind_user.h        |   9 --
 include/linux/unwind_user_types.h  |  25 ++++--
 kernel/unwind/deferred.c           |  31 +++++++
 kernel/unwind/user.c               | 140 +++++++++++++++++------------
 8 files changed, 144 insertions(+), 75 deletions(-)

-- 
2.43.0



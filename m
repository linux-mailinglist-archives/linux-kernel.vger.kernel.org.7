Return-Path: <linux-kernel+bounces-726179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D9B00916
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121A917490D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CD2EFDB6;
	Thu, 10 Jul 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WIFrePVe"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF327817F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165789; cv=none; b=AjeyoQ0zy5iNpdeiriHHyuCwNfQ67CSl0HItxFWA/eedNljUU7Ee8RUR0s79jo2a+e9jcNuYIDEX+0VZbN3OLWZDr3fUeM9YKt/pK7eZyphj5KaplimE6LfBu0ax0c16nGnjiODr3WpRG6JZi8a6AU4j+B1GGVqS33JI/j3Z8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165789; c=relaxed/simple;
	bh=FsUOQ6i8OQS2NzfcLZRerrJnttdZzoVrOdkx6MT1NUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezZ04HQHFGOE4jteGoBX8xH0kiSU07COcURXMy8wNt7We2XLN50m66j7Dc43Q58x2aMAScVKTXFOx7wuBwODa17AXj5QKD5GdkH6v13R0WY9zKADfRB939LAjT+O5dnSbGh9QzD97peWaV/81zJAGiQCmqU6AqntdruOa4I9fRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WIFrePVe; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752165787;
	bh=FsUOQ6i8OQS2NzfcLZRerrJnttdZzoVrOdkx6MT1NUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIFrePVeBZa7/vcr23ZeyToWp1Vkut0oGDnKU4EF66JlqUEp/9lSKty2sBHlutOGG
	 fUU/vV4deSTzBdpNTRhwUejLz05fpJrVa4vV+mzVZRIh15YkQvHcf6zHofttdek3NC
	 lv2II8G9Zk32uZjQrkRSDmkSXk23r1yYuP+ZAhojfithvHl5dByEKNGLBK9g4u0Uhm
	 f01pvi8QraDWU9H2NWR5MWvAd8ECc07dJKzNUsK3xyjiOxWTFB391scoO66MhsHaWX
	 aN38DDc90DbpeHH4LIC19EOz37oCI0xUTaRJvwjNe0Srr1AgxozR9eSUstYxdYjn/B
	 etQhtQVWLBPdQ==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bdLHv13c9zq8r;
	Thu, 10 Jul 2025 12:43:07 -0400 (EDT)
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
Subject: [RFC PATCH v2 2/3] unwind: Export unwind_user symbol to GPL modules
Date: Thu, 10 Jul 2025 12:42:57 -0400
Message-ID: <20250710164301.3094-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710164301.3094-1-mathieu.desnoyers@efficios.com>
References: <20250710164301.3094-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the unwind_user symbol to be used by GPL modules, for instance
LTTng.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
---
 kernel/unwind/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 18d83efc876e..7d7dfb8178d0 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -189,3 +189,4 @@ int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(unwind_user);
-- 
2.43.0



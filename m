Return-Path: <linux-kernel+bounces-724514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A20AFF3E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5195A7A64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC5241C89;
	Wed,  9 Jul 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VFsJbXHf"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E7224AFE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096365; cv=none; b=MAV135Pewp59VFC8djEUb80OZWV70ZnUN+z59BlIxb1eCq0opnZ0ywpGt4ImCyvd8siuZK2vhmLBIbOv6xKWIjkzSAf63ddZtt5pqEOjeOj0JnhmDxcNu4W+40HE913Xlc5xlKGWP2K+NhbsAgfkkBnfhv6jFPwhCophcg1Vz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096365; c=relaxed/simple;
	bh=oFxa3EjcmepwUoJqmS6o0GfY5UgZGIQ3GJHwYb45pbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc8TIHJfBHRT4f3wHaO3rAfhebxJkTuaog105xthHkf5MHx5Yt0uZEWMTiKvBabmHaORv7IIsIo1c2DyTdizoA1To3jm2Yv1Q67vlF89UB95svSTo1jozl/YVuP9dmsuulN2p26iO1GDRJl9PTEW8it+dF0xO1OSBBZwZBnD//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VFsJbXHf; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752096362;
	bh=oFxa3EjcmepwUoJqmS6o0GfY5UgZGIQ3GJHwYb45pbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFsJbXHfmkX50tbppWYXx7Y6RL91yRsyRTc9WvtrCWmDIYEVRnGzZ9ZLOG7GW5y4U
	 uuM1IXu2y2h15Rw6vZERbbB6pulM+aFyNPRf2CmP3NAyZdK8j894PW7p151brtjhM/
	 mjOwm5l/A02u1dERcDr+pFzo3OXf1megs4KFaDfxBI43jYt9c4fIXcxXfuI5q3fvJ2
	 nYZAIX+4WqDfxEVrbPGxM5/T9Fmm3LoAhvAt8OWbX2EIYw502T7A7m/K4y8tflzg+P
	 8UqSXBQIIwgDomXZ1O4LqE7egBaj0knb/tj86f7VdMEnOHP/lsSQ0op7WizwB5/n/m
	 +Hi+RPDpmmHGA==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcrcp1lM6zQ0F;
	Wed,  9 Jul 2025 17:26:02 -0400 (EDT)
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
Subject: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Date: Wed,  9 Jul 2025 17:25:49 -0400
Message-ID: <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
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
index 349bdd72390b..9aefbfc8427a 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -187,3 +187,4 @@ int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(unwind_user);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-766489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7DB2472C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760AA1AA20AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C752F1FC2;
	Wed, 13 Aug 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcLdE8Ll"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8232F0C44
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080756; cv=none; b=b3ieocVph9GwfL+gNbkGbE7sNmm8z88msgZLg1enX3ws0CQxLZc7ED1DwNURms2X4Zz9fiVKRdO4qEB3FL8oUewtxG1YtkP0bFDYAKPTtra1DAXa1b3w5YyuUOUAXdi+5WBh95xdc+1nc92V3MAcHqwVVZDTzkYgft2drreLtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080756; c=relaxed/simple;
	bh=xFy7jtNDgrovmW36eLZW8d/ibTI3Iyw420gdDI4yDtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAn2ZGIUF8okYkf3WkI4e9Nx3ioUneQPnr7fxU4PAfK4vNPsLfh0zWN5bri8Nv765KdenWIFMiFQOn1E4CsaxNctMX6iVt16HBQvE8faaMsvKAIPbONF5M9DSOUX5m5yE3wySACRe7lettta3ZfrG6nxsMmynaouPfF/7PtS/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcLdE8Ll; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755080751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XJG0CzpAn6aGWj3q8ZI+ZTWk8RtelX9FCHaz6DPUnTI=;
	b=CcLdE8LlEVmTLvZ+dD0Cng4rN4i0Z+aWEAogLYjaVK2Tpa4didvXHQb6Iti4F3+LlmBPiM
	CY8XCH9yXC2O5JOpalJCVIU1XGoTD2HlY04Uq5xKz2UV2QufKGyQA3gdI2f69MWdajoCii
	yUIqmUy2702JWM8kVwEYXuBDSOtMCH0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/debug: Replace deprecated strcpy() with strscpy()
Date: Wed, 13 Aug 2025 12:25:26 +0200
Message-ID: <20250813102526.163511-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..bf76980e2334 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -719,7 +719,7 @@ static void task_group_path(struct task_group *tg, char *path, int plen)
 		char buf[128];						\
 		char *bufend = buf + sizeof(buf) - 3;			\
 		task_group_path(tg, buf, bufend - buf);			\
-		strcpy(bufend - 1, "...");				\
+		strscpy(bufend - 1, "...", 4);				\
 		SEQ_printf(m, fmt, buf);				\
 	}								\
 }
-- 
2.50.1



Return-Path: <linux-kernel+bounces-792232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA722B3C1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3B85A1A26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB63101CD;
	Fri, 29 Aug 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrZxGCzu"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FB337680
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488222; cv=none; b=qG4cYEa6sb9a1OD0xu3EQbcEBe9ERIetVbi9x47ybAcClu90iVdS6bGw+6oFTGXba2cAu+HlfcCWHyOdvL4bxPdk94TBbZUtsw5T90MUCSVAAe3zBxkRb5tWDTXpzoCALcuaamcESwYcTTcUv64pxB6W7iPWLOxIBxNxb6yDz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488222; c=relaxed/simple;
	bh=QRdPNgeyaIgdTw6jQJ4kM8OK3qz1U6FHkebbbsS7fMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abm3PCipOXEqdQMy45JUYHwiXK6NTcOdyll2nPIs+7MAjONveqkJP1FLbfCAsumh8gH5WnwEVwFqJZsbMpo5WJBbK+j/395k4RCrcaRZsl2kn0wvjR0gd1h6hw0/ZvRmfTuN+Odbp512WbPqVovaVDkV1LA7F/H+Kq9Ao8/74lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrZxGCzu; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756488207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KoQb4JXCjmXn2LaDQKdgBAQEw0MrpvzxxZIIngHNvYs=;
	b=BrZxGCzuADoIhVSo3ybx1XSD6u9O6gUDxvtxg75PmV3ZgEx7QeKCg9VzdYYmPv7Ij9O0FT
	MYWqfXzVsKaNzlGg8c4Hm1Zh6BfTx0zVNYL2ooSxDOU5ZSQM3A1YFCbUuT+Yk2SSVd/tez
	mzgLxm5yDA2/q4xJJul4ar/2XP6VC5I=
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
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched/debug: Replace deprecated strcpy() with strscpy()
Date: Fri, 29 Aug 2025 19:22:51 +0200
Message-ID: <20250829172250.55835-2-thorsten.blum@linux.dev>
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
2.51.0



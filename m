Return-Path: <linux-kernel+bounces-762182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1BB20310
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE01669B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3531E2834;
	Mon, 11 Aug 2025 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U2BGN5aV"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCC3C38
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903825; cv=none; b=KRTI1nzqmvVGprG9r2TFIyemyQiQrr57RvBY5G3/DnjW5nA9vYcJWt9uMAnMhHmwJ5dvo7bC7LDsYeKYB3TwFWIWAxTc8fYPGWGjsr72M92wvfoZqdKL4UiiGrDFbARPIy4fZdxlRCxuoZQhd5/XKupmBJwQr95AtCDi3gA5ZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903825; c=relaxed/simple;
	bh=bKwsoygsR7tMhkIbEETxfhvbjHfKfeVCH0s5cCKy17o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvEA4u9dSvcpnCsKNjKyUC+y9yZbWek1SHjygI/d0At0pShBmvSupQ5MlXGw1gPY5kRg8CJvYY/FLfNecCBSp3TAylV7J7hvE174zNYdaz8P5rWLPqYc/IOVkCcImOTCRNKoWq8u2n7hdOClBnFXSGvJyGYtLnCscYBm7XvR0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2BGN5aV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754903819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MNy7VvpanJVKEDboZ1rxz1ziHdpr9LUy0BLz2oY1q+U=;
	b=U2BGN5aVeWInjpQ0gkcC9om2fNYwxGBNi50sQ9z2X1blz2TLABSjljT0Am1riD6W4nquaV
	03Nps5q5t/Pf5zWzfGvlYxp/h52J6zov/nvB7h0s8WeVV4eEx+mvOUMSfv4P9lHFsbMJfO
	VXZfLpziPb6T65c9pxuOIx9GUfF3EDw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Replace memset(0) + strscpy() with strscpy_pad()
Date: Mon, 11 Aug 2025 11:16:38 +0200
Message-ID: <20250811091637.4492-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memset(0) followed by strscpy() with strscpy_pad() to improve
perf_event_comm_event(). This avoids zeroing the memory before copying
the string and ensures the destination buffer is only written to once,
simplifying the code and improving efficiency.

Use the return value of strscpy_pad() instead of calling strlen() again.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/events/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..69b4a32befec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8961,9 +8961,8 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	char comm[TASK_COMM_LEN];
 	unsigned int size;
 
-	memset(comm, 0, sizeof(comm));
-	strscpy(comm, comm_event->task->comm);
-	size = ALIGN(strlen(comm)+1, sizeof(u64));
+	size = strscpy_pad(comm, comm_event->task->comm);
+	size = ALIGN(size + 1, sizeof(u64));
 
 	comm_event->comm = comm;
 	comm_event->comm_size = size;
-- 
2.50.1



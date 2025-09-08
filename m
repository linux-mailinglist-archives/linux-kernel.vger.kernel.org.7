Return-Path: <linux-kernel+bounces-805177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C411DB484F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376B53C1C28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942C2E54D3;
	Mon,  8 Sep 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LAHEyySx"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EED13B2A4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315975; cv=none; b=oQFKi/PxJSvnBEJjDop4rwsHWIONU28vkJXtdUVbM+WjTy0vLaSPodgdnjOtPj8TnVQ+8i0w9VuS1bnjmUvc4jpdj8zUPJmUNTRUL86IwRxraTxVJPLAuW3Kx3FwJ7yrbLul5e5UcNDtoia9tjeD3LS+r+//0rlhgv6Gaj+vygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315975; c=relaxed/simple;
	bh=zH4JD/dlrSY6OxOvJhnXD/9oDuUN/j0yj5itLceofGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEhFeXV9hzN5jybWipEw42muLrD3f/MLt96NBRuqMKO3CA9qF9Nxi4KfYYHwpnAs2oExq5+EI6eiQysCOFzUdpmND63G0OHTN+7hsqKQcmVOwUYmBWTHLwNeHbXQuSuubtY2skcLI58WMYMf3WtZT7XHZDK20iGoVHLsCB2I1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LAHEyySx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757315970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IwgxsMq1tgAp2VqFUxjhXW3Xhestgip8zAuXd8bb+3Y=;
	b=LAHEyySxMm2ColIe8xcvSzTEEKu5SetMoSnM2MtL8t2YpBW3s8JKoMwmSDbH9y6U5WdrTk
	+cdcaSuL73nHXBydrN2Y1LTPEiwxyPVmkqqlXs/bJkmAluCWfHAaO6Sv+2sysohu9T1HQ8
	55qPXAM6bBYuHR4o4WcbKHmsUOOBF40=
From: Ye Liu <ye.liu@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: Refactor note_cmpxchg_failure for better readability
Date: Mon,  8 Sep 2025 15:19:21 +0800
Message-ID: <20250908071922.1062170-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Use IS_ENABLED() and standard if-else to make the code clearer.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/slub.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..34853c0441a6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3064,18 +3064,16 @@ static inline void note_cmpxchg_failure(const char *n,
 
 	pr_info("%s %s: cmpxchg redo ", n, s->name);
 
-#ifdef CONFIG_PREEMPTION
-	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
+	if (IS_ENABLED(CONFIG_PREEMPTION) && tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
 		pr_warn("due to cpu change %d -> %d\n",
 			tid_to_cpu(tid), tid_to_cpu(actual_tid));
-	else
-#endif
-	if (tid_to_event(tid) != tid_to_event(actual_tid))
+	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
 		pr_warn("due to cpu running other code. Event %ld->%ld\n",
 			tid_to_event(tid), tid_to_event(actual_tid));
-	else
+	} else {
 		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
 			actual_tid, tid, next_tid(tid));
+	}
 #endif
 	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
 }
-- 
2.43.0



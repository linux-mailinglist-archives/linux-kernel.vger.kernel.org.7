Return-Path: <linux-kernel+bounces-805464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78024B488DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7B4189320D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348B2ECD13;
	Mon,  8 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OXaAfLhA"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011382EA493
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324584; cv=none; b=ha6qLBR3iRi18/i9CmCkdUKKeKM1pQPnGRWM388ccrwtcV7lhyAUYzv5IAbV0WMaTWodtLeoDFQ+OZHOPvcRas7ZzHAURQ1EEtZ9+u0iEvnIzjxaw9hemQUSZCbonwOJconSbGHmiEQW52hv+gML2rLMEwu0esBMbdi6etQ/EmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324584; c=relaxed/simple;
	bh=xh2qh2wFQLmmoW9l+Bt+TOOehxaC85l2SPjkP4RRXno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE19xTzd6tRMHphk0vRgdqHGrz6ztjLnvGY2XsdJIc1aNekEWVqmvkghUxuJ396MVFSiukW1bwCbcRzxzcob40pomdgBb5laEmp+G2f+daCJJSOan412JglfDAI1/z0VmOzVTLLUGPrtkbipV2S2doE/bUDgJHZqUy04sFvnPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OXaAfLhA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757324578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g8brv8Bfza3R1KuSBek60li89MoffBE0eSq7KMm0i8w=;
	b=OXaAfLhAiiYm9lTf6d+u5S8yKXqSBlH3/3z0i/pqxpv9iH7ZjPDYKrdm7FtU3p6gIAptQU
	1X6oIBdxLjYh30HhIKwP8pO4pO7/JPCrfCHDCMlWtgZjOIWTE4nuG1FrIxO8dd/vWiQgcE
	8PlXmTnE4NUNXLqDIzFCEBaJcqyEayM=
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
Subject: [PATCH v2] mm/slub: Refactor note_cmpxchg_failure for better readability
Date: Mon,  8 Sep 2025 17:42:51 +0800
Message-ID: <20250908094251.1080646-1-ye.liu@linux.dev>
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

Changes in v2:
- Insert newline after && as it's more than 80 columns.
---
 mm/slub.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..5711d6d29a3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3064,18 +3064,17 @@ static inline void note_cmpxchg_failure(const char *n,
 
 	pr_info("%s %s: cmpxchg redo ", n, s->name);
 
-#ifdef CONFIG_PREEMPTION
-	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
+	if (IS_ENABLED(CONFIG_PREEMPTION) &&
+	    tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
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



Return-Path: <linux-kernel+bounces-857260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A964FBE658F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69206620F41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132830C378;
	Fri, 17 Oct 2025 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5YGIGLn"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD04204E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677133; cv=none; b=Y0lsm5lmXbJKpQkXlHHXQkKF1q4Gub9VZR8jlctXYDJW+wRgU3uzn3r7RqPgGU1e3zj2bkTRfWlfrNBJe3oyb2ah2zEn5cSBvevJsrZFe8RSR+8TK/5w9tiKHkSceMpJP9xdgaJrDT2d7Z3MQey4BKCCNTXuyOVDdZZHvjtoGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677133; c=relaxed/simple;
	bh=sipSVVBkCLtYZgoiZ6/FYGgfT3d7En5iLxYb7GJGX+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrLHSwqQFp1WfL6J9siOUEEMQTTLLq/NqEQ5McJrsUjF/7ftbTpyfxVDIGwxmdiGfmd9qHk2u3EcwmQaldqatl8ADXdAu9WHVwUm134fMzATKQ9t9u/UEIRnnjDzSocFCRPa9MTeqdV0B82kSMZwHmhMgi9RJ21vQvht4wa0cZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5YGIGLn; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760677126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FyaD/7QF3Mu8ROsvlXVHmV8rI/Un42dcuEf3hG7QO1Q=;
	b=I5YGIGLnI38dBetN2b64VAYoqXk/JdQNC02I/C5LK+TacJamLFE2wEoWc+b/bkD/DlZ+Mq
	gknKCNqSQhj8JtBR03lBVSuHpxBfons6KgJjXkbNYc7IN5bpw70NnHh+ikK/qjodSpc06/
	OULIHkqkEYjE2vMWsBBTvN0FX/746Tg=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Date: Fri, 17 Oct 2025 12:57:49 +0800
Message-Id: <20251017045749.3060696-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

In the alloc_slab_obj_exts function, there is a race condition
between the successful allocation of slab->obj_exts and its
setting to OBJEXTS_ALLOC_FAIL due to allocation failure.

When two threads are both allocating objects from the same slab,
they both end up entering the alloc_slab_obj_exts function because
the slab has no obj_exts (allocated yet).

And One call succeeds in allocation, but the racing one overwrites
our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
allocated will have prepare_slab_obj_exts_hook() return
slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
on the zero address.

And then it will call alloc_tag_add, where the member codetag_ref *ref
of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
leading to a panic.

In order to avoid that, for the case of allocation failure where
OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.

Thanks for Vlastimil and Suren's help with debugging.

Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2e4340c75be2..9e6361796e34 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 
 static inline void mark_failed_objexts_alloc(struct slab *slab)
 {
-	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
-- 
2.25.1



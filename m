Return-Path: <linux-kernel+bounces-871150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DCC0C878
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40781884083
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA77155A4E;
	Mon, 27 Oct 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJotxEZo"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8871553AA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555196; cv=none; b=sWRJh540EmvfHKaYogzCwosNjciTTmMVG/+Oq+bk+714ztQT7j/7DTZZV/IMZXTNvWbWRJfuxSrmyyhagVbJvkEtcXvGzaP8krk3hifC3kAAAMBqa0Cs8V+AqSs2hr6QbAH6XsSMo2e8SXi89K0P12OfY7S2Vp7MOrJFze8yCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555196; c=relaxed/simple;
	bh=Ns8YT7eYkP89feP7hJrIY9yUgqKgKKUgWZTsj+Rgitc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjoqFLADP228nnRaoSCXAqZiHjXuuTIemHFSkc0HlON7AGKKwDSaYVJJvPp0rNcvrYI3PMvuQSgECZKc+Dz655r0JnP3gSuf9Ozme7q2QI2ht1TDEvjSNKqF3JNmRzLEFW1HDpfJioya9ts+zGHIL5iMB2ZMb/c1aMLKn3kfzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJotxEZo; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761555190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1SFbXbwu/ePc1DQgC7lnHgCpffeuAr2Hs5LpPIUuFM4=;
	b=GJotxEZoFx8sIisRu4wQASX1sFEXgoyMGt0ian2JabetFdavHE3TA9GGZCAlNvEAwkxHIC
	LMKTU3goX7KSeJEFby+UIDWs+6EcdjwYhXSgFGG9i+tQLReZUSZRy02bwIiDWw2aQWJiJp
	uoztZZcEnbreSeWtRVW8HfZ/5bB5htc=
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
Subject: [PATCH] codetag: debug: Handle existing CODETAG_EMPTY in mark_objexts_empty for slabobj_ext
Date: Mon, 27 Oct 2025 16:52:14 +0800
Message-Id: <20251027085214.184672-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Even though obj_exts was created with the __GFP_NO_OBJ_EXT flag,
objects in the same slab may have their extensions allocated via
alloc_slab_obj_exts, and handle_failed_objexts_alloc may be called
within alloc_slab_obj_exts to set their codetag to CODETAG_EMPTY.

Therefore, both NULL and CODETAG_EMPTY are valid for the codetag of
slabobj_ext, as we do not need to re-set it to CODETAG_EMPTY if it
is already CODETAG_EMPTY. It also resolves the warning triggered when
the codetag is CODETAG_EMPTY during slab freeing.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/slub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..cda8f75b72e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2046,7 +2046,17 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
-		/* codetag should be NULL */
+
+		/*
+		 * codetag should be either NULL or CODETAG_EMPTY.
+		 * When the same slab calls handle_failed_objexts_alloc,
+		 * it will set us to CODETAG_EMPTY.
+		 *
+		 * If codetag is already CODETAG_EMPTY, no action is needed here.
+		 */
+		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+			return;
+
 		WARN_ON(slab_exts[offs].ref.ct);
 		set_codetag_empty(&slab_exts[offs].ref);
 	}
-- 
2.25.1



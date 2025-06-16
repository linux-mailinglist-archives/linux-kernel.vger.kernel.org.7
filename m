Return-Path: <linux-kernel+bounces-687545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37799ADA659
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBC716CDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5852951D4;
	Mon, 16 Jun 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovwn9yIL"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84373296153
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041028; cv=none; b=rCfk4xTaQBzy6stDQ3tCCDd4SaHhmHzsrRnlL9V/3hnBJv0U65iIFaxbkFD2p8UksOymN+pug2r2/94qMraCjw2h9qhJsQQppUfl7QmQ4kMuM65zeE30fWYZIznlxwuPPC2Q431+r0fiwZAQ1cViZgu5mUneTd179XSP6BZnaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041028; c=relaxed/simple;
	bh=K6Lvk3lCdv4M+F3hTNjTrtGNVvzF0n8odBOG6Q3Tp4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqYd0wmqvbb5Vgr8u2wpi1xhbKRjmIWrOG1idqpq0aqGEjma40piSL6SIH8I+cl1Bl+hSA1Z89A3lygfkvec5jrsZvaS5SE/slRtttcAB8s72m1Ysv+j8yKf+LvXTRE321L8vGqQXPBN4daSGzRdQMZga4JfOQk88SyMc8G9rBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovwn9yIL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750041024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hz18ocd/uSYiTes8KSvGTUaH79rqlEUDMw44khNO0b8=;
	b=ovwn9yILg7Ld/EV2cpX+yCktmX9NPFhFTkL7UBJuwOWxR6IpOsktL/W+xgQkSTJCcKQh9v
	JI01sD8DujrTD/KOB2P6oLNChagB8pDmUAfvKDzDcEuKcs4I/XzZozZid4bpFpU+e1NqTQ
	n2/IvX36dhEGHi81Fn9cIbXZtgGVh0o=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v3 2/2] mm/alloc_tag: add the CONFIG_ARCH_NEEDS_WEAK_PER_CPU macro when statically defining the percpu variable _shared_alloc_tag
Date: Mon, 16 Jun 2025 10:29:18 +0800
Message-Id: <ec632fc2b3770678dc1d078fe58386ace7c18bbe.1750040317.git.gehao@kylinos.cn>
In-Reply-To: <cover.1750040317.git.gehao@kylinos.cn>
References: <cover.1750040317.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Given the introduction of the CONFIG_ARCH_NEEDS_WEAK_PER_CPU macro,
we can now conditionally define the perpcu variable _shared_alloc_tag
based on its value. This allows architectures(such as s390/alpha) that
require weak definitions for percpu variables in modules to include
the definition,while others can omit it via compile-time exclusion.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 lib/alloc_tag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index c7f602fa7b23..14fd66f26e42 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -24,8 +24,10 @@ static bool mem_profiling_support;
 
 static struct codetag_type *alloc_tag_cttype;
 
+#ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 EXPORT_SYMBOL(_shared_alloc_tag);
+#endif
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
-- 
2.25.1



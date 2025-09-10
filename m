Return-Path: <linux-kernel+bounces-809209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF8B50A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2C3B6689
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557081AA8;
	Wed, 10 Sep 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUJIHie9"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A82D7BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466043; cv=none; b=fS1y3SnRs+9Cg0C/rtCQM3q2EDm5eILccW+9LgBd95pToQ9ZC0lukttBSgnTT6gWuqhzYeP6+rd8WN9HGtvTjBqcRQQAbuRXPHx4hFy86dc8uZfO3weKbtvBxItz4zy4o9RRvP/iAPBvI7tZfqWiLjQQL2ejvNuOYPl2LwROSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466043; c=relaxed/simple;
	bh=2buI1x8caBynVC7q9bxraifa+V2wfWGfBsIQAYHraS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1RAtmW/oKymRuddSeTT99xxSmkAQOtVwnSsz6QtpqphSod832VVZB8m1jMhzmtp5PzaSGjH53VANamW4m7d1eYaY2YZcgrhnwSeJ+JazZmTXezJiv2vB+9YuFg+xHIt7RJNwm7XxCEfFb3Y6SEhl9Ct4D3Uv+3bIZp+9ApqpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUJIHie9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25669596921so26571595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757466041; x=1758070841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYtIMNwewtfHP8BnvSKdl88/khkNxOHcpB9SEjCgTbM=;
        b=GUJIHie9HfZkDYqdSkgguKh+NXS4jCjhP51vb/EAtFzFXrXdWPFkXeKd4MqGv9eNrN
         EEmhrWZMFZltxeDiuxCG8P4+4BWok9af2ysg1OGxysrgoIu+5JpTo42EMotNoVgN9gK5
         VYZZnbBLfE3M4DLgyc13rvGtbnemAuSBtMXg8JvgeDHTIMMSqS+Hn9EnPBsz631sK6X8
         K+LiyAoZlYUpoXtHkAAKXaBz8kBS8zBDFDBtBS4e3sL7fhkhy/qtmk69bDSqK3678zKO
         60hGl7ZYx3hY2hNjYPoCNw+JWud1bwFBmu2p1KwDHXtxCFSQ4XbmoegNAjDgY8pEUnja
         s7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757466041; x=1758070841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYtIMNwewtfHP8BnvSKdl88/khkNxOHcpB9SEjCgTbM=;
        b=aIaWea0/WjVBGsrbecaaSVFtljX1j7d+251FOZyWI6OvGUep8p6S2MYe2O3j5Prhyq
         baaU5gqKGERrr9+myWty9l3peQDlBHGnahto6gNakORYUO0WhJjQ9BwaN2U2NGdyU0VT
         CRwR3Vaow10N7hsDDlN9n4fEvGYlxVzdbCb0qrFU9LFakfIGVDvoP+kxTWGrQ9qIYkxH
         I3szGuoGqTceeojFUf+YEfgR4dUk/JnCYbrVmJvSnEqmYGLl2AiDHc56ynwvulvq8vNr
         jl2rBnN7s7Kx2H6YtAY+U7Gye18q9i76T06RnacLrUwZbumqZtVr3NeN1eLW4QKLI/5T
         ZlMg==
X-Forwarded-Encrypted: i=1; AJvYcCWSrNBUjcayHjJsy9wJU5dLKQoSQiDrJYHU2zrOQlNt1BDsMoW1izlPOsQfbHA8K5mviF/Qgc2j6Gd9rHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsZnGiwIE2bgpFFZEXy3RIPA4d3I8EbgW3MJDtbUCrqQxZfuZ
	hPDf6zXis0bmfW6WORXDn7RcZibgnldjf2suFaxfZzvyIc5SoUCyCM/b
X-Gm-Gg: ASbGncuI1tLo3hNqzlrRNXt5/OH8gLFDS9BEDLRbVAcI6RZ17PirSIyL4LwK7vT/prC
	UvySDopdp6E81PBXJmHr5g/vfE0QWdH5JUYrzXr6RZWyrlb00Ds2qxE3UIaoVpr0x13QjKfeLBo
	m/Xsp2y0D71ZlBUMcQ1rwzYBJSaM4sDhubHc7vQrJ1IPlfUkLLX47AJeOjBXpzQ4f9I++13xJ7u
	sNlpaieYGdw0ZxEMfa45AvEYxwz0Pd9PIERz8TTyItZIWmdXJRv1JQPDkSJFNXzNtYRvy0m43NZ
	U7kdPjswfOoECAk51KGC7C3SJfqiTTg2ydpAlZUDXub7n1oMDSwK7kjs4Kxk4obyXI7iMJ/HeAW
	numLJtiHZDkbc2jWZ+vDCJ40kApZFyqntvH0=
X-Google-Smtp-Source: AGHT+IHsFSeEMBKM1x7ICE5JA1RNKFrxEW/Kh9/xTIxKubK9qJVAkBvLbRYdXVICltIthH9H1/yuBQ==
X-Received: by 2002:a17:902:f68a:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-251736df08emr188158855ad.47.1757466040977;
        Tue, 09 Sep 2025 18:00:40 -0700 (PDT)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32dbb62533fsm416564a91.25.2025.09.09.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:00:40 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@naver.com
Subject: [PATCH] mm/slub: Removing unnecessary variable accesses in the get_freelist()
Date: Wed, 10 Sep 2025 09:59:56 +0900
Message-ID: <20250910005957.54108-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It pass a NULL pointer to the freelist_new variable
in the __slab_update_freelist() function so that it don't have to re-fetch
the variable values inside the while loop.
Removing unnecessary variable accesses as shown below
will reduce the code size of the get_freelist() function and make it faster.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/slub.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d257141896c9..2e305a17a9d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3654,27 +3654,14 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
  */
 static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 {
-	struct slab new;
-	unsigned long counters;
-	void *freelist;
-
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
 
-	do {
-		freelist = slab->freelist;
-		counters = slab->counters;
-
-		new.counters = counters;
-
-		new.inuse = slab->objects;
-		new.frozen = freelist != NULL;
-
-	} while (!__slab_update_freelist(s, slab,
-		freelist, counters,
-		NULL, new.counters,
+	while (!__slab_update_freelist(s, slab,
+		slab->freelist, slab->counters,
+		NULL, slab->counters,
 		"get_freelist"));
 
-	return freelist;
+	return slab->freelist;
 }
 
 /*
-- 
2.43.0



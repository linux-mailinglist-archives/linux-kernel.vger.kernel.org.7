Return-Path: <linux-kernel+bounces-601080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FCAA868CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD47A17BED2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974452BE7DE;
	Fri, 11 Apr 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LZ6ak8wR"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4F202C50
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409500; cv=none; b=FPQO7JB5JFbTWi2yWW8DW430rmVyC9r44ZQYAB0b2yn37OX8m1cSqmAsCKFHr+NDPaga3v1WKFEveeuLocxt1cTMBYs9K1AUFYRvyX/PiBxsSB4eA+5Dbc0i8atVMZcQot4tp/zuqtbmiMNBwnLSFF90cJhdfv0i3l+Vyhwt53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409500; c=relaxed/simple;
	bh=iipUogHWKqbSnD4CjJCUz99hy1w9mLc5GhkbwJjFgE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRQDbgBRWnMCgs+6mlzORLYEK5OdIK3bFUpZNwo2k+NTYdH6lbS0OwzkDNwKVBtYIJ4tZ8f1W59IjvgsPQM1rlSA4b3qDM+aqTgr/2Kzu9LkS0teHa/UxOFXTxduVkGHsTbdEQWBzDKK0e0JVCIrF8E+1vgvGpGzmiQW8MVeMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LZ6ak8wR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be49f6b331so283319285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409498; x=1745014298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWwZ2vfL+KhsRUswnAKZ8QRNf9jCtW28RDZA6bxWNqI=;
        b=LZ6ak8wR1fshCx0fXAjvmT/MFyk5V3oySomvy27rN65222y2m+kiIAq7DC0VBJWW95
         9qXTGAq+4CFncw+tOmtqQRAmU4IlOkz/f6FJErAmD0HJo+mwY4OhqS5HNLBqqPlYGspl
         yda+kscupelujuOAG00hQPejteMZrfi5NXXKf9WXq9A1tRqgqaXYMkLXjY/bL64ni02S
         nYNNRo2QI2ILeXJMUcBrcx4TlAgzUJjNcqrbuHyyY1vXRWFzuYw+dXMmwAY4vCeD9ifl
         /X990Ptl41isNUeFi7rFioLVSgiFhwl7jHFtJLrbh/XW8XjGRfI7vvmrEzJnHFnTL2uO
         gqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409498; x=1745014298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWwZ2vfL+KhsRUswnAKZ8QRNf9jCtW28RDZA6bxWNqI=;
        b=U+ajiUMxgbPyEb+khB0NoPgrawWQeiNO5VGoVIOrcK3zF6MH4iZXjx3iEfpPAwAWt9
         7xnARUTjR45AEsF5Cug/Pl5ibg4HHqAapkK8IbTWz8/z/6XTW/xlwAlLRSQJTv/lL6Ij
         ytCJ3ztbZHkmrXHhh2kCaPrfoKefFpL/jdnJma4QGSb8FVvIg6lDGgMBEHgnCvQxNKXK
         4Sd6iW9FXSzaprY6vip66uE/CmKQ21ZoT1gBKGtR1yQ2H84jY8xsTT2Mtp0YfZpN0tCG
         D4nmO6d2fs2hlesStK9Vh2eGMrjqAB0YAJgsnDMsA1og0F/jbQ9RS8FmaCIubjdpCpnP
         EitQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZqwbCVTxksgMIjtegKNme/qHUlA9lOCZlpY8repasAB4XHtKw0afO75ELQsAF/0FFivpxQ4SwC+wSKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqwgBrbiwp7bXUh6VmJRuK2wY8rCAS3RY7TXSVCjIXdWXSG79
	eWxtwTZ5bsfXW0GTks1qp+bk0zzqnvou+Uo9jRy1TLTsiMA+l3vUzIllqYM85Ng=
X-Gm-Gg: ASbGncu9Sp9xqpdr696pX6DVIiYx+vh981Fnpy7Ga5g5JeQL1LVk2fpdiCbFtZt8StQ
	0tyTU/lDtKlsCwBbA2PgVRcd6Ab4lGkSyitBb7GfzKjHHW84N1GKIZSaKT6tIvD//4xCynnIKmQ
	/CPavhkCUTQocIKsJ0z7+dTkgZb+AhSyx9A+x8h/sOG4Ps8T33bavzVa65/tOzAN9pCMUgOjyC1
	dT+siqW82bn+cGJ3Eo96uNCmzbHi8pP5XnnAv0cL+CbdD1hufq8GLJbenmIMF/2aLNrU0PDpf/N
	KXGvpSJQv/u1nV6RNVseZMBVeqvIIOx+bmDfn/BVWuiSXoQ6ETPjQ4GN4IXmhtM4Iq2DqfQYq++
	ImCzbRDDB6ZAeojmSqUiSRglDN0UR
X-Google-Smtp-Source: AGHT+IGLtJZR0JJVKRILz/ZiqYmeVboSBH4PK1DJ0UoO9oX8aCb9uz98PkTHNKxCb1p4ZJETUczmng==
X-Received: by 2002:a05:620a:3913:b0:7c7:a602:66ee with SMTP id af79cd13be357-7c7af0bd2fbmr513370685a.10.1744409497970;
        Fri, 11 Apr 2025 15:11:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:37 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: [RFC PATCH v4 6/6] mm/swap.c: Enable promotion of unmapped MGLRU page cache pages
Date: Fri, 11 Apr 2025 18:11:11 -0400
Message-ID: <20250411221111.493193-7-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Donet Tom <donettom@linux.ibm.com>

Extend MGLRU to support promotion of page cache pages.

An MGLRU page cache page is eligible for promotion when:

1. Memory Tiering and pagecache_promotion_enabled are enabled
2. It resides in a lower memory tier.
3. It is referenced.
4. It is part of the working set.
5. folio reference count is maximun (LRU_REFS_MASK).

When a page is accessed through a file descriptor, folio_inc_refs()
is invoked. The first access will set the folio’s referenced flag,
and subsequent accesses will increment the reference count in the
folio flag (reference counter size in folio flags is 2 bits). Once
the referenced flag is set, and the folio’s reference count reaches
the maximum value (LRU_REFS_MASK), the working set flag will be set
as well.

If a folio has both the referenced and working set flags set, and its
reference count equals LRU_REFS_MASK, it becomes a good candidate for
promotion. These pages will be added to the promotion list. The
per-process task task_numa_promotion_work() takes the pages from the
promotion list and promotes them to a higher memory tier.

In the MGLRU, for folios accessed through a file descriptor, if the
folio’s referenced and working set flags are set, and the folio's
reference count is equal to LRU_REFS_MASK, the folio is lazily
promoted to the second oldest generation in the eviction path. When
folio_inc_gen() does this, it clears the LRU_REFS_FLAGS so that
lru_gen_inc_refs() can start over.

Test process:
We measured the read time in below scenarios for both LRU and MGLRU.
Scenario 1: Pages are on Lower tier + promotion off
Scenario 2: Pages are on Lower tier + promotion on
Scenario 3: Pages are on higher tier

Test Results MGLRU
----------------------------------------------------------------
Pages on higher   | Pages Lower tier |  Pages on Lower Tier    |
   Tier           |  promotion off   |   Promotion On          |
----------------------------------------------------------------
  0.48s           |    1.6s          |During Promotion - 3.3s  |
                  |                  |After Promotion  - 0.48s |
                  |                  |                         |
----------------------------------------------------------------

Test Results LRU
----------------------------------------------------------------
Pages on higher   | Pages Lower tier |  Pages on Lower Tier    |
   Tier           |  promotion off   |   Promotion On          |
----------------------------------------------------------------
   0.48s          |    1.6s          |During Promotion - 3.3s  |
                  |                  |After Promotion  - 0.48s |
                  |                  |                         |
----------------------------------------------------------------

MGLRU and LRU are showing similar performance benefit.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/swap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 382828fde505..3af2377515ad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -399,8 +399,13 @@ static void lru_gen_inc_refs(struct folio *folio)
 
 	do {
 		if ((old_flags & LRU_REFS_MASK) == LRU_REFS_MASK) {
-			if (!folio_test_workingset(folio))
+			if (!folio_test_workingset(folio)) {
 				folio_set_workingset(folio);
+			} else if (!folio_test_isolated(folio) &&
+				  (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+				   numa_pagecache_promotion_enabled) {
+				promotion_candidate(folio);
+			}
 			return;
 		}
 
-- 
2.49.0



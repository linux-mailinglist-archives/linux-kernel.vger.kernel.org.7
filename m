Return-Path: <linux-kernel+bounces-774304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DFB2B109
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BD0685D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84068311957;
	Mon, 18 Aug 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWXJCWeE"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187782D24BF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543488; cv=none; b=s1HHacXzHS1rkg4IZ9nhw+98cOtJfSjTekPr432SK5sXsoeU+VgF/M428EDx7y0N1dy+UdCym4SS4KMk5WvYtFRkCd5k/Tm1H8AUoB6Ay7ZffI+Qj/4L4uprB1anG7zKIBjPLi/DJ4xY/ITVSehmv4drlh1PeDuOpXSrgzOaYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543488; c=relaxed/simple;
	bh=V04jYNpOgWknV9HtlRdtrMU72SUxH8x4/ZBBgbujWh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nu1jH7EW2kEGmSyjGD7ZZnfvL1do/os39/ETmQHwIojPruIPHKEZrzxRrShEjBaVZ+t1kXeOnqWVVO6lx8MFev7725hM7iLTfVeTLy6nUpnF6ejwQlR14tk2sKCIFv7P9uGh1B4j4XMOza9kRq4ik3yysdzISEfFBcqnyDXqJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWXJCWeE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e933f00bc9bso2155141276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755543486; x=1756148286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvQtJJDThEoJCIOiCG6XcyoU/U45M25uQ1iDko4lnIQ=;
        b=CWXJCWeEzIRVXF2K5FHvqwfAdzP2gsDKII+a2jNwoZjn0EnCPDxsL9ALTyELtAe27y
         RRLwW/bppDYd2hqpab4k7v1D450xjxx/SCo4W5WoIfY4Yy6UTGZ+FKOXRCD2lLtqp4JF
         yvMWwls7KMm/xvyBTXHVMRHfj+EBOQYPs/vT0opYOyeozH6LE/zNZeS6qccp160FoL/p
         1X1knXEF2keKsi7fwxEFZt4C83JmqI99J9oOQt8OUa0B48ranJAo33fbdz2gdKK/t+w1
         55EWqDqn6lZyXiep5IiFSLF1SAQB6JqqmpCzgb0udz7XZA99oYYLJWPpc7oGpKSzvMSa
         Rrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543486; x=1756148286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvQtJJDThEoJCIOiCG6XcyoU/U45M25uQ1iDko4lnIQ=;
        b=uW54kj7lbCe2lfM6Dr8Oj1YjVxsJ+r8ldo8OJmvx+Q6JrMoGY8/GQMKE0ivgBknQjU
         67Hwj0FSwxyPhtaIJJ3spGL15sad4Lk+IIiceeu9aDgMd9wfHgDsL+serIWu82RGs9zH
         tXILgY9IFl/BfhJcpOmzLY+20LGBibJi37ToD7qlk2OkzwfsUiSiLKu7mteIn6mweKnT
         i31XOgoZXgFIq+ufQSqiGT5bNR4I8+VMQpNzA5EiCUttkKLr9jTnoYyEVM+HBCiYHNS2
         0vqXegB16lc6zUx+9fhuZQ6wg2vCdfAA22pn+3dFnBAs9nHwjgpxOMzexTFgVS82E10n
         Eqcw==
X-Forwarded-Encrypted: i=1; AJvYcCWapMQ4MsMjp13dUTNQzYNB+1DHsnHSqqx/rKLuBG4kJ8SBOwfj2zomak6HjQaSgVvQGKpWJcsShu8ngUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iQ6cVVItLamqmTCNG20uDHE0Ot4EcVDRWsy7iTN7fWfKaGhO
	euOcpCN7A36eBumVocPfFjiVNT0XQssBJBGM+XmQsgbAJEVjE2IMnOWM
X-Gm-Gg: ASbGncssXXHlv1Z9woEOfL81AJWD218DFA6Qo3yv4t91Q/DRQONTmRU3eFJlyLm5Px+
	nqNkZRdyYwLmnC/8rHvvg8ZOrIkSsJhFR6zd2GwzYB8vvvBv+PuYUz+H7XRJcLy5AzmUj8Ozyx6
	PgPNM8iRqNGY10pxR5vV2m1/XQrZ/DrHlJXtFpbcvVVXL9Nx+Hs1abef4iux8X5wTM5oLOWVJY1
	BUzEI22r+HgnxvEefhshlL8nzNtgdK0qchQWAw3Aqg1wsO3J5xk7EE+fAQXOtLijBNIChCKokAv
	v/5t1thU9tiBqXPJeOvpco6nuWKp5srPdfn6WnguQXR/J4V9WyPMaVy9/4AW5vskfL9y41WpENZ
	nxrikvPNLKxzrpNDjBa8rJw==
X-Google-Smtp-Source: AGHT+IGeElcrBG+Q22ismY7SZkhqWNI446WP+j5RDDU5N5dGnffzuAGQbvpuUEtBc87q6DwPwKECjQ==
X-Received: by 2002:a05:6902:6b05:b0:e93:4bbe:e0ab with SMTP id 3f1490d57ef6-e94e41f494amr607417276.30.1755543485596;
        Mon, 18 Aug 2025 11:58:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9348d570besm1922177276.29.2025.08.18.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:58:05 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@gogle.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Mon, 18 Aug 2025 11:58:03 -0700
Message-ID: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing workloads with high sustained memory pressure on large machines
(1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
Further investigation showed that the lock in free_pcppages_bulk was being held
for a long time, even being held while 2k+ pages were being freed.

Instead of holding the lock for the entirety of the freeing, check to see if
the zone lock is contended every pcp->batch pages. If there is contention,
relinquish the lock so that other processors have a change to grab the lock
and perform critical work.

In our fleet, we have seen that performing batched lock freeing has led to
significantly lower rates of softlockups, while incurring relatively small
regressions (relative to the workload and relative to the variation).

The following are a few synthetic benchmarks:

Test 1: Small machine (30G RAM, 36 CPUs)

stress-ng --vm 30 --vm-bytes 1G -M -t 100
+----------------------+---------------+-----------+
|        Metric        | Variation (%) | Delta (%) |
+----------------------+---------------+-----------+
| bogo ops             |        0.0076 |   -0.0183 |
| bogo ops/s (real)    |        0.0064 |   -0.0207 |
| bogo ops/s (usr+sys) |        0.3151 |   +0.4141 |
+----------------------+---------------+-----------+

stress-ng --vm 20 --vm-bytes 3G -M -t 100
+----------------------+---------------+-----------+
|        Metric        | Variation (%) | Delta (%) |
+----------------------+---------------+-----------+
| bogo ops             |        0.0295 |   -0.0078 |
| bogo ops/s (real)    |        0.0267 |   -0.0177 |
| bogo ops/s (usr+sys) |        1.7079 |   -0.0096 |
+----------------------+---------------+-----------+

Test 2: Big machine (250G RAM, 176 CPUs)

stress-ng --vm 50 --vm-bytes 5G -M -t 100
+----------------------+---------------+-----------+
|        Metric        | Variation (%) | Delta (%) |
+----------------------+---------------+-----------+
| bogo ops             |        0.0362 |   -0.0187 |
| bogo ops/s (real)    |        0.0391 |   -0.0220 |
| bogo ops/s (usr+sys) |        2.9603 |   +1.3758 |
+----------------------+---------------+-----------+

stress-ng --vm 10 --vm-bytes 30G -M -t 100
+----------------------+---------------+-----------+
|        Metric        | Variation (%) | Delta (%) |
+----------------------+---------------+-----------+
| bogo ops             |        2.3130 |   -0.0754 |
| bogo ops/s (real)    |        3.3069 |   -0.8579 |
| bogo ops/s (usr+sys) |        4.0369 |   -1.1985 |
+----------------------+---------------+-----------+

Suggested-by: Chris Mason <clm@fb.com>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 mm/page_alloc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8a84c3b5fe5..bd7a8da3e159 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1238,6 +1238,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * below while (list_empty(list)) loop.
 	 */
 	count = min(pcp->count, count);
+	if (!count)
+		return;
 
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
@@ -1247,6 +1249,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	while (count > 0) {
 		struct list_head *list;
 		int nr_pages;
+		int batch = min(count, pcp->batch);
 
 		/* Remove pages from lists in a round-robin fashion. */
 		do {
@@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
+			batch -= nr_pages;
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
 			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
-		} while (count > 0 && !list_empty(list));
+		} while (batch > 0 && !list_empty(list));
+
+		/*
+		 * Prevent starving the lock for other users; every pcp->batch
+		 * pages freed, relinquish the zone lock if it is contended.
+		 */
+		if (count && spin_is_contended(&zone->lock)) {
+			spin_unlock_irqrestore(&zone->lock, flags);
+			spin_lock_irqsave(&zone->lock, flags);
+		}
 	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);

base-commit: 137a6423b60fe0785aada403679d3b086bb83062
-- 
2.47.3


Return-Path: <linux-kernel+bounces-742007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CBB0EBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0B4E6DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F12737E6;
	Wed, 23 Jul 2025 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QdigMd9K"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4C273806
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255533; cv=none; b=Es/F7pFym57xd6U0eR1xym4/FRPY+Wpcl8tRI/e0h9FS7Z/alNrVBGvjwtpWWF/wZZFWf0UCCesxlEWkwIQDxIKmHPsY+Bjc3p0zQig4l3hfd9vmM9OG8GZJse6CofsyM1YU6l7n2ECnG3k4uEFU27UUZo4ls3NKa+z6sCMk8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255533; c=relaxed/simple;
	bh=XSbt/fko+eRy/SpzuCHHn3LXpeuJUuVRZQveFYbkPqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNJGBV2ojDbW7mmPEGrgt8s6ESFrgCxfxny3YwGc8Mh8IUGZHG8m6W2q4GymmTiCMuBaKaJAQpzEoWA/TK6hkXUnkfZ/OLTcP09/QvYcoWcDJ/3fPlRtmnFuVsyVrprZODQpS2Xh6bACUGzwSWXUVLLKW3Gkn4r6/GexxK+Tm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QdigMd9K; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=al
	AlhSGmTebtA+3jJl/XuXa6tRwN7fz4ebxMMcEAbo0=; b=QdigMd9KgZnjRkjc05
	6F5nGWWzm+u8YBMd/RB8iSmjZFZ9/fUzMwqydf9R6yRR7QjE9GQm+HF6i8RI0FTz
	l4bKRD9rPgVPZk7Vn3JWx7SNvRXHmiRxTIcn2Wr1iLDSZ1qVMyrtdscz3c5FUw9K
	r3QpqzLMSswaj+NqcFCLBh4y8=
Received: from ly-pc.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDH_5sKjoBoILM2Gw--.26993S4;
	Wed, 23 Jul 2025 15:24:03 +0800 (CST)
From: Xuanye Liu <liuqiye2025@163.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Xuanye Liu <liuqiye2025@163.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add stack trace when bad rss-counter state is detected
Date: Wed, 23 Jul 2025 15:23:49 +0800
Message-ID: <20250723072350.1742071-1-liuqiye2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH_5sKjoBoILM2Gw--.26993S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UGF4kZFy8GF1fCr47twb_yoWDtFc_Ja
	ykX3WDWr45t3Z8tasIyF13Xry0gwn8XFyFvw4IgFZ3ZF9rAr90krykJF1kAwn3XFZ2va4f
	AF95Xw12kw17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRi66wtUUUUU==
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbibg6TUGiAiYZxyAAAs9

The check_mm() function verifies the correctness of rss counters in
struct mm_struct. Currently, it only prints an alert when a bad
rss-counter state is detected, but lacks sufficient context for
debugging.

This patch adds a dump_stack() call to provide a stack trace when
the rss-counter state is invalid. This helps developers identify
where the corrupted mm_struct is being checked and trace the
underlying cause of the inconsistency.

Signed-off-by: Xuanye Liu <liuqiye2025@163.com>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cfe2f1df5f27..d38f1c5270ea 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -584,9 +584,11 @@ static void check_mm(struct mm_struct *mm)
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
 		long x = percpu_counter_sum(&mm->rss_stat[i]);
 
-		if (unlikely(x))
+		if (unlikely(x)) {
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
 				 mm, resident_page_types[i], x);
+			dump_stack();
+		}
 	}
 
 	if (mm_pgtables_bytes(mm))
-- 
2.43.0



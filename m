Return-Path: <linux-kernel+bounces-742284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59131B0EF82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878127B6A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12828D85F;
	Wed, 23 Jul 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hTHKWDgo"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669ED27EFFD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265432; cv=none; b=Q8xrFJl2gzJ1snebXN9JRm6iygOzYaZ2JA6aQ7OIl6R+ZUIy9JOiLieRfq1/TBJEt1rWT9ytuqadLlzmJ6EK8c065Ay42bP4B4B43/vBz421+Nzhnv7G25ehSYl8QH4lVcorYydz9M0dJ9a7OnwyWSNrVoTGZEF2a3mMdDwpVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265432; c=relaxed/simple;
	bh=s4HiKl+QEDkzijiropzXvy5iHdrqZS0GUwdnzOGUd7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rlhe2i3ctuB2FNFNlQr0xpMtAZjM6Y5K8B6mW5DDPHoq5YuDfKr2IdbsL+Wgzuqr0NnyylHSGnQ7FWry8xuB4yNlR0VvXiYhqVyjr2yvGyHX4UQM9xRPnBPqvitJ0qzmicmo8tcSyMhfqAIKMopQjD1fmT4RhjoRVDzLqdfJA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hTHKWDgo; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nh
	2o4zeAg7OMbohCVL8ICOdq71b512GbZ6YsdS2hIic=; b=hTHKWDgoW+BGrspZYE
	GXu4pdKkNEuYd437XW58tC0Ey0ajx5kKkzZa7mI7ORSJd5oTkudASXCSf6Ue8lDA
	Pvj90Rrljc7UqgFeIZwvgBoP20JIVVfQ7SSLS3SGImx91DqmaTGKS8gX32kgjbOU
	UOF+Tg2b6k3bdt9lD5ldvLzkE=
Received: from ly-pc.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXroe+tIBofN_UAA--.20396S4;
	Wed, 23 Jul 2025 18:09:12 +0800 (CST)
From: Xuanye Liu <liuqiye2025@163.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>
Cc: Xuanye Liu <liuqiye2025@163.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: Add process info to bad rss-counter warning
Date: Wed, 23 Jul 2025 18:09:00 +0800
Message-ID: <20250723100901.1909683-1-liuqiye2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXroe+tIBofN_UAA--.20396S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1fGr48Cw4UGr47Jr4fXwb_yoWDXrg_Gr
	Wvqwn8ua1jy3WDCa4ayay3Xr4Ig39YgFy093WIgFZ3ZF9rAr90gr9rGrykArn7XFsay3s3
	AF95Gw129r18AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1zpB3UUUUU==
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbiMAqTUGiAskRAAQAAsm

Enhance the debugging information in check_mm() by including the
process name and PID when reporting bad rss-counter states. This
helps identify which process is associated with the memory accounting
issue.

Signed-off-by: Xuanye Liu <liuqiye2025@163.com>
---
 kernel/fork.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cfe2f1df5f27..e02fa515b77c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -584,9 +584,12 @@ static void check_mm(struct mm_struct *mm)
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
 		long x = percpu_counter_sum(&mm->rss_stat[i]);
 
-		if (unlikely(x))
-			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
-				 mm, resident_page_types[i], x);
+		if (unlikely(x)) {
+			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
+				 mm, resident_page_types[i], x,
+				 current->comm,
+				 task_pid_nr(current));
+		}
 	}
 
 	if (mm_pgtables_bytes(mm))
-- 
2.43.0



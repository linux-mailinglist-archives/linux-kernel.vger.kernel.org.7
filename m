Return-Path: <linux-kernel+bounces-725069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9CAFFA76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C0116592C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BA2882A6;
	Thu, 10 Jul 2025 07:11:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B01FC1D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131495; cv=none; b=AcJmbB0cTYTBZaoq5b6pijdOcJm/QWuaXCsff7gjsyauFZWPq+t5OLGpifcpeCDcQLvOnzrAs7KI+/Bs247ADgOB5Dr9pN55TbvzCgkdtdHLIs/tZG2G7ni9GTFvzYBWS+n/olr2Up92AACZe9mVAb1R9VRDz7IKLrS5nx8c++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131495; c=relaxed/simple;
	bh=23RALKBWs4xi/fpqSsULx8OkRH5EOi8YXbwhvUqLkM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTCM2T8P6FfTgLlCS84N2NUcg6XBfzYUtxujdRzI/tbkGFGlgQyzVetLbYFZeQrXlImwZxYVYuMNPOanxPLHyU09dUeVEUXaKeRUdcfvgBmxEz7uK+jOGtHCLeLMVm4ty2NTRDR5AUbhxj5xvrgNpUvsgzHB7FXzD4i8fgjN58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089421C0A;
	Thu, 10 Jul 2025 00:11:21 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5429F3F66E;
	Thu, 10 Jul 2025 00:11:30 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3] psi: fix avg trigger being fired unexpectedly.
Date: Thu, 10 Jul 2025 08:11:28 +0100
Message-Id: <20250710071128.1637175-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at initial")
fixes unexpected event fired when group->total accumulated for PSI_POLL.
But, for PSI_AVGS, win->value should be initialized with group->total[PSI_AVGS].
Moreover, to get exact initial value for win->value, it should be set
under each trigger lock to avoid concurrent changes to group->total[].

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
Patch History
=============
from v2 to v3:
  - change author
  - rebase to v6.16-rc5
  - https://lore.kernel.org/all/20240226211237.48415-1-ppbuk5246@gmail.com/

from v1 to v2:
  - fix commit message
  - https://lore.kernel.org/all/20240226194642.47530-1-ppbuk5246@gmail.com/#t
---
 kernel/sched/psi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ad04a5c3162a..00cf7acb5eb3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1337,9 +1337,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	t->state = state;
 	t->threshold = threshold_us * NSEC_PER_USEC;
 	t->win.size = window_us * NSEC_PER_USEC;
-	window_reset(&t->win, sched_clock(),
-			group->total[PSI_POLL][t->state], 0);
-
 	t->event = 0;
 	t->last_event_time = 0;
 	t->of = of;
@@ -1350,6 +1347,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,

 	if (privileged) {
 		mutex_lock(&group->rtpoll_trigger_lock);
+		window_reset(&t->win, sched_clock(),
+				group->total[PSI_POLL][t->state], 0);

 		if (!rcu_access_pointer(group->rtpoll_task)) {
 			struct task_struct *task;
@@ -1375,6 +1374,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	} else {
 		mutex_lock(&group->avgs_lock);

+		window_reset(&t->win, sched_clock(),
+				group->total[PSI_AVGS][t->state], 0);
+
 		list_add(&t->node, &group->avg_triggers);
 		group->avg_nr_triggers[t->state]++;

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



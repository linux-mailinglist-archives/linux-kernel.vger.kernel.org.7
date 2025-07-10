Return-Path: <linux-kernel+bounces-725390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1617AFFE67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C36F7AA9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A302D3EE6;
	Thu, 10 Jul 2025 09:48:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F094A11
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140895; cv=none; b=eYl6ezAB/cHyLBrPTnwI2Xoy4h9AP0P70S7PRDJmVaJcpFDHPXBpwhOCuVrbBjxCP3zrIp+41shNbLZXBXi9NPfUA+nwYJ1NCgJpdAnkwBrL8uBiLKW2L95oFUYt4GBAWlddqc0c8Ts5IdFvBi7rbijWK4TzKzZcg5LjvxDtvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140895; c=relaxed/simple;
	bh=8phDT5YA/a738bEXBdlgsTC51YFW6lESbrOXS249ORo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qliUaJu1IUhFQp6Qq4lE3w2yQqcMJEfMb8frpRdAQ3udnB0BeLAuuSezHzo0OE+dJgch62obLsEwlUONQcHR4gqDK2Rx4+xl49euld9FsfbtX87Y5sfnNDiD+OVgItVdbjxIwQrtbyZEr6A3F+vI4awDM1/s3yJB3K0lxSdt0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f996335c5d7211f0b29709d653e92f7d-20250710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e7861746-8528-422b-82f7-0c3d84f5eabc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:4a2c22048aca1bf6e2d16bcdf8bfa9a8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f996335c5d7211f0b29709d653e92f7d-20250710
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 817012073; Thu, 10 Jul 2025 17:48:04 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1CD7FE008FA3;
	Thu, 10 Jul 2025 17:48:04 +0800 (CST)
X-ns-mid: postfix-686F8C53-892298845
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 19C17E008FA2;
	Thu, 10 Jul 2025 17:47:52 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] sched/debug: Only print util_est when UTIL_EST feature is enabled
Date: Thu, 10 Jul 2025 17:47:08 +0800
Message-Id: <20250710094708.15443-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The /proc/{PID}/sched interface currently prints the util_est field
regardless of whether the UTIL_EST scheduling feature is enabled or not.
This can lead to confusion, as the value may not be meaningful when
UTIL_EST is disabled.

This patch makes the util_est field only appear when the UTIL_EST feature
is enabled via sched_feat. This avoids printing misleading or unused data=
.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/sched/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9d71baf08075..a71ccb851e49 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -861,8 +861,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct=
 cfs_rq *cfs_rq)
 			cfs_rq->avg.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
-	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
-			cfs_rq->avg.util_est);
+	if (sched_feat(UTIL_EST))
+		SEQ_printf(m, "  .%-30s: %u\n", "util_est",
+			   cfs_rq->avg.util_est);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
@@ -1259,7 +1260,8 @@ void proc_sched_show_task(struct task_struct *p, st=
ruct pid_namespace *ns,
 	P(se.avg.runnable_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
-	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
+	if (sched_feat(UTIL_EST))
+		PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
--=20
2.25.1



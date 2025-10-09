Return-Path: <linux-kernel+bounces-847354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D3BCA99F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046F74FC4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D077248867;
	Thu,  9 Oct 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+k7hOHi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8D23AE93
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035690; cv=none; b=Rlf4AhtFWIK3/cYWtfW5Y1aa2QKFcNpz0LsXaAVProXxLGoir97suxY+ZIiew0ZD/2TV6wQHLIPCYz1rh5mST8rVBqTcvqgEFHdawOh2GtwUtSchm/Dv+2qbWl8y4wfd7gmN0lL0B9s2aCZigbaWJ9pbs+b2stMv//Ne3D5OzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035690; c=relaxed/simple;
	bh=ycn6NE2npvD7CdgXx6VDSx5WId2Gjp4aO6X45d/diN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBq2WtDKxsAlrOrjBfsZvMAwJlf2WvkCtOI2kzRNfccM2EOHFbBVa/FmlUGCoLobLN2uKmV4sfN6R4Obfnunxnb5bE+gGFEC+AXaYB+A+MYJy/mO2r7J6Fqkyp9Kly7Jq/HKFYFoh5LPna7KOcFFkQ5xJcNCRWQlj35Do81M6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+k7hOHi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EgPch012342;
	Thu, 9 Oct 2025 18:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ryV0YNyHKmdfxyc4hx/vdmLVpnWzl9OUf1o4Hh4z2
	bg=; b=W+k7hOHikTbWu58kQDYHtl5AZo0VCvgRSjrp6PCtF5mlfqSOaa2tGnrEf
	W39T59lvIqXHOyixfJYNcbwtps5R9frPWq9kIRP++o9oGMbeoCrHdgP7M4ikQUAg
	u6p3xNUwTduiLPexrAjAv1tvmgcsia+i5CggV7ntTiQLvN2YsWSL6eiwn5UmOPZZ
	RuLXmw5VDjGpWXUpj9dCVTJ87zuWPfOYxtQJrPk489oDHIZOLbTNSqTQDtWFGDZ7
	sbDl/wNXI52GhEo6qH9AtqeQpoucmDs62uACWiL1SPpjo21+pq603eFEGepdDCvw
	uh7ykniX0SVadkkCVOvnGKjblqotA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7yepbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 18:47:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 599Ij5G7029158;
	Thu, 9 Oct 2025 18:47:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7yepbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 18:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599Fbm33008377;
	Thu, 9 Oct 2025 18:47:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanx4ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 18:47:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599IlmQv20513224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 18:47:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8198B201C4;
	Thu,  9 Oct 2025 18:47:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42E40201C3;
	Thu,  9 Oct 2025 18:47:46 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.96])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 18:47:46 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: peterz@infradead.org, juri.lelli@redhat.com
Cc: sshegde@linux.ibm.com, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        m.szyprowski@samsung.com, venkat88@linux.ibm.com, jstultz@google.com
Subject: [PATCH] sched/deadline: stop dl_server before CPU goes offline
Date: Fri, 10 Oct 2025 00:17:27 +0530
Message-ID: <20251009184727.673081-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZCgYbSnZfMOJ_B8CeMnyzrrBpW4_o_XY
X-Proofpoint-ORIG-GUID: XEH02V8GAtsAq0G6-Se8zTLUcO6qtPt5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6icKuRQgLG4b
 skJl1I2QMtcvL8xX/ZpWFH+cr4alXU76kgPC8JSyWBDd3f/LAbljlD/YKDqElEyriDg+l4HDLi6
 R8mHp8RhNP2WwxESIshsuUgkHd16yaFhk0E/Jwk4xYhvn8s/DqSWAd3fWc9Y405hUbmG3wjU9a4
 Kx5mOfyEIHukloveFVZdZcje/i3KVeAbzGZFiPVU2q/mYQsDw3qUgUYbW37dAGqdMC67PQC3dr9
 WpxzgAUoba4YvZUxySQb8erbaOlsNGZ85Tr8oujH9Cz++sfQ5kTDba0azYM6h916l7PiDWO2b/E
 qdnlidBbncTOjRZ+Cy/ZfEkvZN4y7JQueyIsowE8mXExPuifzblm7BzBwe44KalzH2cX6NqX11B
 2VY41HWU5ME+SmmjusFK8R+bDYp5kg==
X-Authority-Analysis: v=2.4 cv=FtwIPmrq c=1 sm=1 tr=0 ts=68e8035a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=JfrnYn6hAAAA:8 a=hD80L64hAAAA:8 a=O2v9BJpJwca3pG5EUbEA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Peter Zijlstra (Intel) <peterz@infradead.org>

IBM CI tool reported kernel warning[1] when running a CPU removal
operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"

WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
Call Trace:
[c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
[c0000000002b7cb8] dl_server_timer+0x168/0x2a0
[c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
[c00000000034f624] hrtimer_interrupt+0x124/0x300
[c00000000002a230] timer_interrupt+0x140/0x320

Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")

This happens since: 
- dl_server hrtimer gets enqueued close to cpu offline, when 
  kthread_park enqueues a fair task.
- CPU goes offline and drmgr removes it from cpu_present_mask.
- hrtimer fires and warning is hit.

Fix it by stopping the dl_server before CPU is marked dead.

[1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
[2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr

[sshegde: wrote the changelog and tested it]
Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c     | 2 ++
 kernel/sched/deadline.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd45f59..f1ebf67b48e2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8571,10 +8571,12 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
 	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
 		WARN(true, "Dying CPU not properly vacated!");
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 615411a0a881..7b7671060bf9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
+	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
+		return;
+
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
-- 
2.47.3



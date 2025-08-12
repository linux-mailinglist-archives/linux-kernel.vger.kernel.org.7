Return-Path: <linux-kernel+bounces-764549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6DB2245C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514B13A4376
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93B2E3B17;
	Tue, 12 Aug 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="jH69zRxe"
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA612E401
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993782; cv=none; b=qODPzLp2sSPay+c6o45o1vJwVtFw/lMaSHwPj59lcDE0gJalAXzfWcefU8iaovHugaXY4UbFQ+Vyv4suEoOrNQbxehyhwHDEZfFOn3TwzWsr9ZjW/LUwoIKCUWXVcf7MItil4CNUhmEIzSIwKF+YOmT66/WG75c1ANL8DkNJLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993782; c=relaxed/simple;
	bh=c4RWPv8ififaKqYqXU2CPR+8HAaQjUtL3HLdGTmVQPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l5Y//vlXZExlFUtk2AQR5TbMmcgKzRtIQb6ZdFD30ef77guNshfHWweUYYmry9e5iQC9rgaBkqlPj90IV1fkjW/T3vDnpn+iQfxdEc0fW+2ai2Ly7U70CvUnQGi1sITGZfpYyy1TmQMAfNR7A+pJH64zuT8dr7sa6A0hgyT2Vxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=jH69zRxe; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 57C9YFv2048334
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:34:15 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 57C9XwwO046915;
	Tue, 12 Aug 2025 17:33:58 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4c1RCD5g57z2KqZt3;
	Tue, 12 Aug 2025 17:33:44 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 12 Aug 2025 17:33:56 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <dietmar.eggemann@arm.com>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <vdonnefort@google.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
Date: Tue, 12 Aug 2025 17:33:39 +0800
Message-ID: <20250812093339.8895-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 57C9XwwO046915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1754991246;
	bh=UWY2mKEvTa0wnX/pEG6AEYZML7JMB29Bm63BdbxkT9E=;
	h=From:To:CC:Subject:Date;
	b=jH69zRxe/Hv7o2TAXFIzXY3+oMctOVLoZeNh0B3ai4ga+LZEvEDvW9i2eqWI/tWXi
	 Vpvlr90QO1k233NpaDOqo/1DwWKXP1o8vZ+NnB9jQpztc2c0JWYPuxOPt4yYBM6pBG
	 Pvd34QDS8rzxyCTv0EdijGdnkGt22kmKFmUF0ulRPZ4Ud0UCooBoFkv3ZH1ic+iC6b
	 jgGQexOwYiXYZzIFvV1oVhj8IO/5T+CtwWPUb0Eu/XUGHnyCxKaSvbzwy43itwfZQj
	 9Wn5gkIvPOql5dWVMUK7d4uKugRNNCbCr94Z8gCsu5zh8rThUBuk0xE1TyKi97Xyf0
	 xO9eaGLNHncSg==

Now we use for_each_cpu() to traversal all pd's cpus,
it is in order to compute the pd_cap. This approach may
result in some unnecessary judgments.
We can simply calculate pd_cap as follows:

pd_cap = cpu_actual_cap * cpumask_weight(pd_cpus);

Then we can AND pd'scpus, sd's cpus and task's cpus_ptr
before traversing, which can save some unnecessary judgment.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..e47fe94d6889 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8330,18 +8330,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
 		eenv.cpu_cap = cpu_actual_cap;
-		eenv.pd_cap = 0;
+		eenv.pd_cap = cpu_actual_cap * cpumask_weight(cpus);
 
-		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
-			eenv.pd_cap += cpu_actual_cap;
-
-			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
-				continue;
+		cpumask_and(cpus, cpus, sched_domain_span(sd));
 
-			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-				continue;
+		for_each_cpu_and(cpu, cpus, p->cpus_ptr) {
+			struct rq *rq = cpu_rq(cpu);
 
 			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
-- 
2.25.1



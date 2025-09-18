Return-Path: <linux-kernel+bounces-807118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C411BB4A056
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7124E87F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BC301483;
	Tue,  9 Sep 2025 03:48:06 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421582F4A12;
	Tue,  9 Sep 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389686; cv=none; b=A4DQdDuw/qx3yA3p0uK8QcXcCfkjdXK7DG/6kSz9UnpyCGz9KzEMTUhTgu0X9f/fqmaYvkvxmX+8Sygtj/HxQR2evnAzktEg31aNF9zv33NREkhiLsvLp3uvQMxXHML1ikhwRvqhuS86cdOBM0ys+nxKJql/nIcsPZJWw27//uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389686; c=relaxed/simple;
	bh=goPLI+5ebq5vz03NwnjQXLKV5mEzLm0VKX3BjnStfxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4/vUO8+4HOaXEVwgVGEcbGkmv7PnrAhbTsq6hrYifsOIi/93LGfrswHNuLPweZgz1GlmHG4kNBHw/nBnw2bR8WFZRGrs+bE0wHgSxbSuRsBy9NfJfiYqhG5HLnPvHTDhCElK32MuZ2Yg/wsECTltc/PfWOCUYIWj2jxQumWJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLVCK3rlszYQv7J;
	Tue,  9 Sep 2025 11:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0B1461A1057;
	Tue,  9 Sep 2025 11:47:56 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgAnM3lOo79oBVdmBw--.63383S12;
	Tue, 09 Sep 2025 11:47:55 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC -v2 10/11] cpuset: use parse_cpulist for setting cpus.exclusive
Date: Tue,  9 Sep 2025 03:32:32 +0000
Message-Id: <20250909033233.2731579-11-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909033233.2731579-1-chenridong@huaweicloud.com>
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnM3lOo79oBVdmBw--.63383S12
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1fJF4rWFW8Gr4UJr4DCFg_yoW8WrykpF
	W3JF47J345Wr1Yk398KrsFgrn5Kw40qr9rtanrt34rCFy3AwsrK3WDGwsI9Fy8K3srWF1r
	JFZIyrWS9a43trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Previous patches made parse_cpulist handle empty cpu mask input.
Now use this helper for exclusive cpus setting. Also, compute_trialcs_xcpus
can be called with empty cpus and handles it correctly.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index de61520f1e44..785a2740b0ea 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2567,27 +2567,20 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
-	if (!*buf) {
-		cpumask_clear(trialcs->exclusive_cpus);
-		cpumask_clear(trialcs->effective_xcpus);
-	} else {
-		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
-		if (retval < 0)
-			return retval;
-	}
+	retval = parse_cpuset_cpulist(buf, trialcs->exclusive_cpus);
+	if (retval < 0)
+		return retval;
 
 	/* Nothing to do if the CPUs didn't change */
 	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
 		return 0;
 
-	if (*buf) {
-		/*
-		 * Reject the change if there is exclusive CPUs conflict with
-		 * the siblings.
-		 */
-		if (compute_trialcs_excpus(trialcs, cs))
-			return -EINVAL;
-	}
+	/*
+	 * Reject the change if there is exclusive CPUs conflict with
+	 * the siblings.
+	 */
+	if (compute_trialcs_excpus(trialcs, cs))
+		return -EINVAL;
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
-- 
2.34.1



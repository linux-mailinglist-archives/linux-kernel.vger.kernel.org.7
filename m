Return-Path: <linux-kernel+bounces-777639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4100B2DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEBB1C42B13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8131A58D;
	Wed, 20 Aug 2025 12:10:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB02EB87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691820; cv=none; b=XK5ZDJPhim7Wl2dORCIHjA2TULwqSgqKklJXrdks/G3RdcvxG3J6b7tnybkOxbldYfeUdrmTDfSA/TypBA2RR0l2CrynlKxtjn09DPICaBGtTjYYFqOtmmPwWeEBXAMowgbgIWqHE7iOzha8qg/As+S90a7UTc3rqb2MWkxUIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691820; c=relaxed/simple;
	bh=TjvwPoFJMB37Aujls8D4npdKO9JZVoEVa8kDxje2EOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5TgBG0D42ETJXPDSL6Rh0U5MkgE5iC04lDSnGpPnskgVDCJg2vx9HbzJixtrg5ilEgGL3JbFuKNed9yyOlm3wz3L/D2rSEqbE3GjkeTyqXnd+EGFpZvQDwyAED6kweNLWJ6aRWkrnAuWOBUQDvCxq2g4IpC6SXqr0QgxZcI5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c6QC25nL2zdcbF;
	Wed, 20 Aug 2025 20:05:50 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D800A18048F;
	Wed, 20 Aug 2025 20:10:13 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 20:10:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Remove unused declaration ia64_set_curr_task()
Date: Wed, 20 Aug 2025 20:32:38 +0800
Message-ID: <20250820123238.1778774-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

This is unused since commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..5217c8576a5f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1912,7 +1912,6 @@ static __always_inline bool is_idle_task(const struct task_struct *p)
 }
 
 extern struct task_struct *curr_task(int cpu);
-extern void ia64_set_curr_task(int cpu, struct task_struct *p);
 
 void yield(void);
 
-- 
2.34.1



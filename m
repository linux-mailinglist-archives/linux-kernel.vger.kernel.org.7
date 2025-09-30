Return-Path: <linux-kernel+bounces-837400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A4BAC3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7C169961
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E924167A;
	Tue, 30 Sep 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="x3vc469l"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E81D8A10
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223937; cv=none; b=Dk4fRV4aDxcxrJxxs2WF1MeEqvi/3beItbIRmSJBKRIgcPQqQLez+Xyc0Zwf3gfML/KU+YVgYwbmGGVoHAjG4rsGO4dE1aILMLAwvUIGwzoH6T6bzocYjO4ObnXvqmbp8JTLH+2QaBcDryDLQtkeHRaEeULbcqfnCxD78Ekftyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223937; c=relaxed/simple;
	bh=yT/9prb328Jk/p4E21Ik7/u6Vkncbf7laqiR4KkRVZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/+7Jqix3SAXxwziccGRY7ll/1v6SO1hWvqElh26TVWslua74dLK2f6sRIVSOGXE5mBfjOA7jJXtzN9fR3CYT+9Vsb9GzBirBxEU8ExPo2MobxNfLPDkF0UYLqUc7OYBnQrZByuK82NYFVQBq+lgPptWnB21HSEDxkF6HseYEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=x3vc469l; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Kj04+aRiMYK4efWR6lDLB1jm3vVtTjYdEIfnf+sLVqY=;
	b=x3vc469l7QAcAI3P0o6FnG3S+5Z/PMd1H3fiZsVlqETRz8I1S6yZRhgTKD0WXRFPxK9OGR/dj
	ysmqDhZpPWAUP3FH4wijPYqjOtCq7gXRVuCxoGikL0aT0RaaMkTqJ8nMJOE9RyX2MLO8HJo9NDh
	zQnDpvAO5RnD+9BBWDBmwm0=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cbXYD0qL7zLlSB;
	Tue, 30 Sep 2025 17:18:40 +0800 (CST)
Received: from dggpemf200005.china.huawei.com (unknown [7.185.36.191])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BC481400E8;
	Tue, 30 Sep 2025 17:18:51 +0800 (CST)
Received: from huawei.com (10.67.175.66) by dggpemf200005.china.huawei.com
 (7.185.36.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 17:18:50 +0800
From: Bowen You <youbowen2@huawei.com>
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <ldufour@linux.ibm.com>, <mpe@ellerman.id.au>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu/SMT: recover global num_threads after disable smt switch fail
Date: Tue, 30 Sep 2025 09:03:30 +0000
Message-ID: <20250930090330.3633926-1-youbowen2@huawei.com>
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
 dggpemf200005.china.huawei.com (7.185.36.191)

When attempting to disable SMT with the following command:
    `echo off > /sys/devices/system/cpu/smt/control`
if `cpuhp_smt_disable` fails due to a "resource busy" error, the global
variable `cpu_smt_num_threads` is incorrectly updated to the target value
despite the failure.

This state inconsistency leads to subsequent attempts to disable SMT being
 ineffective since `cpu_smt_num_threads` equals `orig_threads`, preventing
 `cpuhp_smt_disable` from being invoked. To recover functionality, users
must manually execute `echo on > /sys/devices/system/cpu/smt/control`,
 which is undesirable.

This commit removes the `orig_threads` variable and update the global
`cpu_smt_num_threads` only after successfully switching the SMT state.
This ensures proper state management and prevents the system from entering
 an inconsistent state.

Cc: stable@vger.kernel.org # v6.5+
Fixes: 7f48405c3c34 ("cpu/SMT: Allow enabling partial SMT states via sysfs")
Signed-off-by: Bowen You <youbowen2@huawei.com>
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28..a2420d8a6ae0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2902,7 +2902,7 @@ static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ctrlval, ret, num_threads, orig_threads;
+	int ctrlval, ret, num_threads;
 	bool force_off;
 
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
@@ -2935,16 +2935,16 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	orig_threads = cpu_smt_num_threads;
-	cpu_smt_num_threads = num_threads;
-
 	force_off = ctrlval != cpu_smt_control && ctrlval == CPU_SMT_FORCE_DISABLED;
 
-	if (num_threads > orig_threads)
+	if (num_threads > cpu_smt_num_threads)
 		ret = cpuhp_smt_enable();
-	else if (num_threads < orig_threads || force_off)
+	else if (num_threads < cpu_smt_num_threads || force_off)
 		ret = cpuhp_smt_disable(ctrlval);
 
+	if (!ret)
+		cpu_smt_num_threads = num_threads;
+
 	unlock_device_hotplug();
 	return ret ? ret : count;
 }
-- 
2.34.1



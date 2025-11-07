Return-Path: <linux-kernel+bounces-890295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D8C3FBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72B3A4F1FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4232142A;
	Fri,  7 Nov 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJCT3YMF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151D320CD5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514793; cv=none; b=DT3E7BzDoX16JnZGzE6Ra5VvKVpKvarHoSznMYIxOQC9eTesO41ry137eEXEos7hrmTsBQfkauwGC57+osEQ4g091h5YTOm88X4r88J7W03XbRvgUD/xRNzHNoaVXBZGfLS46du5aKAF8TsXcPx7EVIwjzHWLuyW6WEP++kCMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514793; c=relaxed/simple;
	bh=/OpycBwrnjTyiLJWX+i+miH2FcuBg3WefuVfu4hP+us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9HXDAeNNFQAL1lIrGlVRELC7X/j7jRslOwrrBIWuqgvQzYuqcQzds32L/emO3uOHP18jVdkBl0Y9W1C3joswNvbX4MlqMM5s/oWcyu4iwB1JZD5Vkr+JhnvfapxbB+rQ64qZh6UL6VAznkk3GlWJElqgNA8uBJgoI40oImUBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJCT3YMF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632d9326so4909445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762514789; x=1763119589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0p3O/pb//AizrafRTQJzp8sI+qoHtI4GgWcrf/805qw=;
        b=eJCT3YMF86Dbprn/Dg8du4WI41dgSYuR4g+AeNKHNpVRWSVYxytOiSxcEmqls5tkhF
         8rq7lefE1apBKHWqm2WwYAJPbqdFsI+QmBy+HynUDWvAeb5YO6Z8PFB7v+yo5xw2Ww4Y
         ZopbmEfHXiXNIEJgFg363AZq6owLWXWcfHMsdJ6XhLmmdegL67cY9atf39KH5e6yzC0e
         LMKZlb/D0tmhSkV4WxXQaQcW4QDqVYkt325pHRVm1LtQsS5+iORp7A5Q/VATRfQi26uV
         II3Dsr0IvtvYZbbPiyHSJOhpBgD+TmDvTLeRw/7d+n1QMpcjOsqI2btsu2u5jiRJ6YCg
         mzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514789; x=1763119589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p3O/pb//AizrafRTQJzp8sI+qoHtI4GgWcrf/805qw=;
        b=FpgRPRxHSwgX9yE3byiRqiI6HNTtgCD9kFTiIvsIGIam0iWOsQHLTN0RUFkq32goMI
         xjbxkzH/AK1j03jlnFpxtNxy0LcjCrMNIVpgX7AGJDx/FRknsgBiRZAKi1mQ6h0XMvaV
         ltJyrzaSE2rw2Zmf2N+xDRr4pez8yJqK/1EdFWrO+5/sFLWl4PGjRwZuKCVLvUTC4Ql5
         /iGVZTmGl37+7iLY2/leI9oCLiS7VNiPy85h5u12GwUJuhyPycqb/3spFNdBpVIIrtcM
         QW3migcU7w++Xf0+jYCF574Dkl0n7gMpA7QekieieapcxdDW/QsfxNCMTCFcGClb7bda
         yPUQ==
X-Gm-Message-State: AOJu0YzUrAHulsSX3akf81bwjaSxUZ+71+Gxz+4G53hVGx/uCZzsbdIG
	WD0RvTmtMYmAZvn7eg21LEuAoY/+E5dG2UgRa8qFNFKPqjjyAKH0R/AVhyJaWJF2HSz++VUsMIr
	G1vEf
X-Gm-Gg: ASbGncs446R1x2/3YFVNw8l2a8q77naYAJuAdQuJ81LhnqOok6Tc2GgQPjSiJFyx0sK
	3pP0G0fXQQmsK7neUfTnVt0EEbjkdudtrqUf2eSQumyjAIpfv/tfRfAYb5bJ8B14SgUZ3aR8Noe
	4j/SOLEQv0ZFSC61uWwZom1xD2appxP9Fg5owD6e6aUx8O90F8GQ13TibdS0xB+PdFgwQ3Rx4W6
	6NERspDN/Za+v0Vyn9Z2UrvYC4PzyAkXUibFSdDt9ObAPle+BYaU3lf8Fbpu75JKBKPvzrxKAzH
	/pF461v2Gwq6JP1tO7X/pMHm5DacIvQVnopRHWxAKwKmP7HQ7E85g5NqPvW+7ssn2hAOfyhPb0o
	NIZtgpmKimG3SbHvjFUbvnP5rPefQ4xtvf3NUQjQOevnIi4biTt6KniNP5LeqQdgdCSJHRaYH8C
	qduCrCcFuToxHtYHSRzoTohbZB
X-Google-Smtp-Source: AGHT+IEs6H1o4PIWCzP+J6CSQfhB0IMTx9LNmlS6M6nO+FXFt2zOgnGCd1yGQIa3PRWvCM0ki458xg==
X-Received: by 2002:a05:600c:524a:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4776bc89fc5mr24519725e9.6.1762514789555;
        Fri, 07 Nov 2025 03:26:29 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ee3sm157433875e9.9.2025.11.07.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:26:29 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] firewire: core: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 12:26:19 +0100
Message-ID: <20251107112620.146996-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/firewire/core-transaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index c65f491c54d0..c15dbe882cbe 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1437,7 +1437,8 @@ static int __init fw_core_init(void)
 {
 	int ret;
 
-	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM, 0);
+	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM | WQ_PERCPU,
+				       0);
 	if (!fw_workqueue)
 		return -ENOMEM;
 
-- 
2.51.1



Return-Path: <linux-kernel+bounces-800196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87DB43474
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF9485ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C0289E17;
	Thu,  4 Sep 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TsB5ZXm0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6513FF1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971938; cv=none; b=o6NeIrnDCKg4VRK0Q5nCAOiVMEQm5P6XbOwBjs7h6NhkDMrf6mZUgf/c4a56ZdWR/4WNr7wJedGcNB+Ws7VELMUCTT0L8+ONPL0xmCYOS1k7+OXAPYqj2woPM3s36Rii/f8JYPesMTpXDIRJBNJVd9opaNnRiIeOh5RAQQ6uY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971938; c=relaxed/simple;
	bh=2JG3jWqYLlfQhZBSRnGeuB9ys4zyrKZK3ClYzoG5V4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrUXCAKS4xVaf59iq0qRsgog4R6KUJJYuQGS6tgykmHO5jUDm1KIscNZVY7Gzm7sQQwotzMz9Q0iFAW+hRakutO/xJq2PDdhRizSZExvDtRTtY+GPLUdZw+nUlIyHlZZsLCglsnyfh7lehCYSt3nRtRWm1s6IIDqox/ptHjHghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TsB5ZXm0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24af8cd99ddso10306845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756971936; x=1757576736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOk9aM7uMLk4oCwBs0MeiGtoy+qSX8dOfHwcPVA0QKw=;
        b=TsB5ZXm0EEIuOPXETyaivVlPxeOeOJq5USM31wuXkIWQWJnlOgjuj1albaWxtKDLxE
         uglSQjcf/SKnjotqCN97k2vBK+Xb9P4kOksVAtEO2Sx6kWYk2KU4ce53nyM18ylxZsyt
         xv+uVxHVZG+APlY2MPsi7FvZSqrdNdThh7r6xmXRIHjPF8mMGLOCYaEpy8Wa7Uft8kcG
         TOaaYK2XL0S9hAlfL+aGflkcRCc9TjF/96eV3oE8nsxGrwbr4nuUMNA2QtXKEj2iniWq
         A3QSsqX2DvLnCpBCzdKryonOgxmdJPd1fHMZdxdYr1Egs6mwvceg9qyQSgW50YBw9P4e
         SUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971936; x=1757576736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOk9aM7uMLk4oCwBs0MeiGtoy+qSX8dOfHwcPVA0QKw=;
        b=O4nb+RXSYVSQoYlpJwJMnwWDnoQ4he1qhZcFa9NFlVsr//yRxkz1A7e+TD8wFCB9Yi
         SOYH7hb6tVd8py7FVIfVpLB0xc4P6PwCrQOu2kimRjRAwrlg3pT0zRazhE3lLC5w1Afb
         kGwRQMt6D1TGHXXi10DPqrhtt/npe0oaOzMgzYXY4j/R275OXZAkUJA0711xqVq7bfom
         pdzRy8PruGqTYXcJ0qdw5LqkxToNhwV0wfs9B9VbX0825tInnqMHsbpOVGRPgaSZyPtO
         gQuNkwnfX6pPAwEr/5CeqcT3NNYYhq5B7EVrGX+c/3CSANSKySMQ/XV026xQKTTalSOQ
         LITg==
X-Gm-Message-State: AOJu0YwMO3yA6Rha0ljeIbuhKjZ4L0F7RteySoMl25a6gQTgBBYz6bOW
	lg0sCCMVbb4/8oJnyWNNRpk3haNyGWYdvU5zhEaI6Z9juha+UNPEXnySaqGUe2wV61w=
X-Gm-Gg: ASbGncvv1bKJY6sttXwfGl9Wgi3FrOuvRXeRIZiIgwbwlDcPh+RrtaN6euiZSyh4dcI
	8+FVbn6AKOEQcwGCUNoMvMjojfovGm5tyvwQcKwqv+gKKOB1Vsy2Qh806qW6SlP+HBrZ2vZuicI
	u5hgAMnke+FQFomM/Tc0cpt9PT2i2f0nCglZPjFZZknk7677UteVc3poK1qiQEmcJHTqcQu6mvz
	u1Cm9uUOvMVE+7yABUj2165t9zMulax2U5dD19Sa2pSXTgIeSB64v+rMDCGrpEXC6Ld/u5As67X
	Owqex7/t1LAIXJRR9E6Hdw2biG/qcTErmOvS9UyRXjb2YNRiZlV9Nx0tEYr70DqP/TPjnO36ISh
	tw9AeiEdLevEfkYCL4/HcIhuajRWmX3GQ1xo/Ewax3c2+J7EEpw8Aj5RemPNBMWMIJQXG
X-Google-Smtp-Source: AGHT+IHgvNjNK+2nyS/2aHJDejBh5MtqlXwNPkbvUWoov9UdDxExDfOszCfmkHzSTWhXjS0OJ2oLRA==
X-Received: by 2002:a17:902:d544:b0:248:9669:a405 with SMTP id d9443c01a7336-24944a11968mr258033145ad.3.1756971935775;
        Thu, 04 Sep 2025 00:45:35 -0700 (PDT)
Received: from n37-019-243.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f7492d8sm63504395ad.129.2025.09.04.00.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:45:35 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 0/3] Defer flushing of the cpuset_migrate_mm_wq to task_work
Date: Thu,  4 Sep 2025 15:45:02 +0800
Message-Id: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now in cpuset_attach(), we need to synchronously wait for
flush_workqueue to complete. The execution time of flushing
cpuset_migrate_mm_wq depends on the amount of mm migration initiated by
cpusets at that time. When the cpuset.mems of a cgroup occupying a large
amount of memory is modified, it may trigger extensive mm migration,
causing cpuset_attach() to block on flush_workqueue for an extended period.

            cgroup attach operation  | someone change cpuset.mems
                                     |
      -------------------------------+-------------------------------
       __cgroup_procs_write()                 cpuset_write_resmask()
	cgroup_kn_lock_live()
	cpuset_attach()				cpuset_migrate_mm()


	cpuset_post_attach()
	  flush_workqueue(cpuset_migrate_mm_wq);

This could be dangerous because cpuset_attach() is within the critical
section of cgroup_mutex, which may ultimately cause all cgroup-related
operations in the system to be blocked. We encountered this issue in the
production environment, and it can be easily reproduced locally using the
script below.

[Thu Sep  4 14:51:39 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Sep  4 14:51:39 2025] task:tee             state:D stack:0     pid:13330 tgid:13330 ppid:13321  task_flags:0x400100 flags:0x00004000
[Thu Sep  4 14:51:39 2025] Call Trace:
[Thu Sep  4 14:51:39 2025]  <TASK>
[Thu Sep  4 14:51:39 2025]  __schedule+0xcc1/0x1c60
[Thu Sep  4 14:51:39 2025]  ? find_held_lock+0x2d/0xa0
[Thu Sep  4 14:51:39 2025]  schedule+0x3e/0xe0
[Thu Sep  4 14:51:39 2025]  schedule_preempt_disabled+0x15/0x30
[Thu Sep  4 14:51:39 2025]  __mutex_lock+0x928/0x1230
[Thu Sep  4 14:51:39 2025]  ? cgroup_kn_lock_live+0x4a/0x240
[Thu Sep  4 14:51:39 2025]  ? cgroup_kn_lock_live+0x4a/0x240
[Thu Sep  4 14:51:39 2025]  cgroup_kn_lock_live+0x4a/0x240
[Thu Sep  4 14:51:39 2025]  __cgroup_procs_write+0x38/0x210
[Thu Sep  4 14:51:39 2025]  cgroup_procs_write+0x17/0x30
[Thu Sep  4 14:51:39 2025]  cgroup_file_write+0xa5/0x260
[Thu Sep  4 14:51:39 2025]  kernfs_fop_write_iter+0x13d/0x1e0
[Thu Sep  4 14:51:39 2025]  vfs_write+0x310/0x530
[Thu Sep  4 14:51:39 2025]  ksys_write+0x6e/0xf0
[Thu Sep  4 14:51:39 2025]  do_syscall_64+0x77/0x390
[Thu Sep  4 14:51:39 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This patchset attempts to defer the flush_workqueue() operation until
returning to userspace using the task_work which is originally proposed by
tejun[1], so that flush happens after cgroup_mutex is dropped. That way we
maintain the operation synchronicity while avoiding bothering anyone else.

[1]: https://lore.kernel.org/cgroups/ZgMFPMjZRZCsq9Q-@slm.duckdns.org/T/#m117f606fa24f66f0823a60f211b36f24bd9e1883

#!/bin/bash

sudo mkdir -p /sys/fs/cgroup/test

sudo mkdir -p /sys/fs/cgroup/test1
sudo mkdir -p /sys/fs/cgroup/test2

echo 0 > /sys/fs/cgroup/test1/cpuset.mems

echo 1 > /sys/fs/cgroup/test2/cpuset.mems

for i in {1..10}; do
    (
        pid=$BASHPID

        while true; do
	    echo "Add $pid to test1"

	    echo "$pid" | sudo tee /sys/fs/cgroup/test1/cgroup.procs >/dev/null

            sleep 5

	    echo "Add $pid to test2"

            echo "$pid" | sudo tee /sys/fs/cgroup/test2/cgroup.procs >/dev/null

        done
    ) &
done


echo 0 > /sys/fs/cgroup/test/cpuset.mems

echo $$ > /sys/fs/cgroup/test/cgroup.procs

stress --vm 100 --vm-bytes 2048M --vm-keep &

sleep 30

echo "begin change cpuset.mems"

echo 1 > /sys/fs/cgroup/test/cpuset.mems

Chuyi Zhou (3):
  cpuset: Don't always flush cpuset_migrate_mm_wq in
    cpuset_write_resmask
  cpuset: Defer flushing of the cpuset_migrate_mm_wq to task_work
  cgroup: Remove unused cgroup_subsys::post_attach

 include/linux/cgroup-defs.h |  1 -
 kernel/cgroup/cgroup.c      |  4 ----
 kernel/cgroup/cpuset.c      | 30 +++++++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.20.1



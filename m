Return-Path: <linux-kernel+bounces-802435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B110B45261
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C4A16CEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC06284672;
	Fri,  5 Sep 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bNL/5nl2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43A2798FA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062950; cv=none; b=N3QO5v6Rn6h/RD9mPfeHVaXnqaI//xXt+w3vR/UghrYhtZ0KhYcfaNCUFrAmj51ODq0TJ9vKdozKJ2M37lpVZIz+0IDnHetegF8eJkOAfXJZYcOgQoQN9cxIovbMm4t1nVX7SQUBThM63pSjJm8HjrN+I447+HviVptpCvXsrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062950; c=relaxed/simple;
	bh=7cBRDPqhY0MXE+vamSMmFsAKHO6i5pYSg0prnBLULNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwY9t72gJyk+IpPSCiDhhrruZsg5imk7z91XIocOBrvvYmK3pyPyhrEkD5rdn6leweORgaLt+WmQ4BmXOOQjOfOJc4Qh6/X5AqoSAQT1aWAz0BbTK9sQMAz5+/AretXXb3DCiq97iPFLmTtqyIne4h89o7HMFjDosC9PHrW59yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bNL/5nl2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1279164f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062946; x=1757667746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBPhG1xpMg+yHePQXylxvQksQDMr/qwBidDK7DxfN6g=;
        b=bNL/5nl29Vax47BQMHCBCnM7zKqCuarI9nfUrjLpKFvpTcz0HkuYnotGMpdZgpxAPw
         88OwS4cyOnFFd6aeOURVDNx0DXm16DijLDz0IkS+lfr2Pl2q/2U/dj54tURrU0oVWZrG
         bOj6e3AvL/eGh+SnMX7ZEo51EXDYwV6wPu960HJ6cTyCh8+SikRzTeUad/+xkPYVdFH9
         JPKnwHS/RKnNeW6tZeq63Qp+swvC9caU8jJJSZw7GSv+5RqQ1HJ1gozJfGDbql7AwrNB
         O96HKwK0u/fPmcHcRo0ah0ms26KeryBpSUQoXptxFOPc74zO3qhP7riZO3AOfiZpDGCx
         VRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062946; x=1757667746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBPhG1xpMg+yHePQXylxvQksQDMr/qwBidDK7DxfN6g=;
        b=a3c3Rc5ntqG5C1njG/I8RRNnfZg3ARX4aejktx83jNteS6XOim0fKZ45FE6sdtnhWe
         OMiRESDjwfrnJ4EFOwcHmoynTe2zbg3DE9fPaKblDNzH9izM0tYpudSzFlmD/TRr5No5
         +jWm2XkVhHMDQr6LPsBCRd0zzu+ssA288S2we0T1GVxUj0yy3z+5JSSsN9Trs+g7TdYE
         fdkZ+EX5Lgb4/hZhohY7MKIHEUcSr6JM6wGNrgLy6w+egm7WMzjqduWAoX9GwZL8YmNA
         noyglXMl5ohKnQMl59myrKYh5ZkiZ/ui1cJfo3pS8uRiVLyNDQqn0U4HJsMFUf5Ll+Mp
         aSzQ==
X-Gm-Message-State: AOJu0Yz6RRdjwJR7rQewYucnJlS0zI69hGCfflAfuA9K3RhX5Hvtv1U4
	Rzw2/FPH0/RohGC2wNSfP9A8KYNw4pF2S8WAVVp8q+OX9YXy31xht5DcBs6wtY2OIfsZCEGKWfO
	jRVnh
X-Gm-Gg: ASbGncsp1UOTPMNYPHkE1hwAIomwDMJjGbPeWIIsRplzhFUegL8ZNrqxdt1QgNngyJC
	uhLj4Y/0ozWhAkjEv3VoGQqgTRIfX6MGCjgeK0FXccr1n7vMHHjSKTAvsmWsli0tGm1hcMQfTbt
	8SsGlJODHnUzO82L35Lwi/fGL0b7/25MDt6j2bXquu4Seq30y6bpIql5mADi0BYNk7v20LvFJWl
	Jvdv2sdFPo7LiE3KS3UL+Y7NxG3RlQBgIWKgS5d/LjNyQMST3T2LIF3Fvo6PQT5R3UDk6DUd1wg
	c/sYqY3g8e44vNRnsEDDvSMN4RVP4o7qnoVsH9LudTwzTN00AYVA704RsPaSIZaZKaIe0kLPOFI
	8WgTgwdA9rhC7KnT4jzaGJrarq1SjPc8t113O/6E+RhksoJDu0iTMmtT53idc2BneREP/
X-Google-Smtp-Source: AGHT+IFGuXRDgUoiDzBjUDFJCV6xcN5CnLwXClOlTisYvO2T06GJDYO0FSdAPF1LBUlhR/NsXdBvmg==
X-Received: by 2002:a05:6000:1448:b0:3dc:15d2:b92a with SMTP id ffacd0b85a97d-3dc15d2ba77mr7648328f8f.41.1757062946060;
        Fri, 05 Sep 2025 02:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35324565e9.5.2025.09.05.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:02:25 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] fs: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:02:11 +0200
Message-ID: <20250905090214.102375-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (3):
  fs: replace use of system_unbound_wq with system_dfl_wq
  fs: replace use of system_wq with system_percpu_wq
  fs: WQ_PERCPU added to alloc_workqueue users

 fs/afs/callback.c                |  4 ++--
 fs/afs/main.c                    |  4 ++--
 fs/afs/write.c                   |  2 +-
 fs/aio.c                         |  2 +-
 fs/bcachefs/btree_write_buffer.c |  2 +-
 fs/bcachefs/io_read.c            | 12 ++++++------
 fs/bcachefs/journal_io.c         |  2 +-
 fs/bcachefs/super.c              | 10 +++++-----
 fs/btrfs/async-thread.c          |  3 +--
 fs/btrfs/block-group.c           |  2 +-
 fs/btrfs/disk-io.c               |  2 +-
 fs/btrfs/extent_map.c            |  2 +-
 fs/btrfs/space-info.c            |  4 ++--
 fs/btrfs/zoned.c                 |  2 +-
 fs/ceph/super.c                  |  2 +-
 fs/dlm/lowcomms.c                |  2 +-
 fs/dlm/main.c                    |  2 +-
 fs/ext4/mballoc.c                |  2 +-
 fs/fs-writeback.c                |  4 ++--
 fs/fuse/dev.c                    |  2 +-
 fs/fuse/inode.c                  |  2 +-
 fs/gfs2/main.c                   |  5 +++--
 fs/gfs2/ops_fstype.c             |  6 ++++--
 fs/netfs/objects.c               |  2 +-
 fs/netfs/read_collect.c          |  2 +-
 fs/netfs/write_collect.c         |  2 +-
 fs/nfs/namespace.c               |  2 +-
 fs/nfs/nfs4renewd.c              |  2 +-
 fs/nfsd/filecache.c              |  2 +-
 fs/notify/mark.c                 |  4 ++--
 fs/ocfs2/dlm/dlmdomain.c         |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c           |  3 ++-
 fs/quota/dquot.c                 |  2 +-
 fs/smb/client/cifsfs.c           | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c       |  2 +-
 fs/smb/server/transport_rdma.c   |  3 ++-
 fs/super.c                       |  3 ++-
 fs/verity/verify.c               |  2 +-
 fs/xfs/xfs_log.c                 |  3 +--
 fs/xfs/xfs_mru_cache.c           |  3 ++-
 fs/xfs/xfs_super.c               | 15 ++++++++-------
 41 files changed, 82 insertions(+), 69 deletions(-)

-- 
2.51.0



Return-Path: <linux-kernel+bounces-770649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD8B27D74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224BA1714AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115381C6FFA;
	Fri, 15 Aug 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bX1tfScW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E21C1ADB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251249; cv=none; b=CPgoYYlBqIkCSFk7TgWTMlUbzXAgRU94hP17LI+zFflJHYbSEJxhwNnfCC/vuHJUUX/clOekOuV0H83+YuNRS5l2ObrUd3PxkWqIzeJ2gI5LkStrpzsfiDL9cvxmvz3yi+MKgigsf62FmQmyTKaY0UlS3yWdW17625KE1fsRoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251249; c=relaxed/simple;
	bh=WwKOiiKIiYnmIu+LlT3Q9wSfQA5kAmWGSW2Rrn2HYec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYnpb7213t50V9TWCygJbAfWQvuu1WR38JpQ79VpxMEllQJ1kdPcAgCs2tD4ti3w3vkqanzGD/YxixWrbphkP7XOOLtxPYJHSpuEwtVxeiQlFh4ZEfue65Fqsw79dbP3ZN/nH6Ewq7nGDoMynr+T/GsR4YZQ23vOmKqDof2v8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bX1tfScW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so9130715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251245; x=1755856045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMwFCHUMF+OJtcZoZN8E7Av8Dx87kERB9UUx8xTRQHw=;
        b=bX1tfScWPy6dTC7GPQ2sIWW3fXYN2MN58Yvy9m7/NUA47QT+VzV37Twhp2HM+uTBNC
         h5N/jQzov9dN/d5lIkJkbImPpL+beOyOO1xPY3YAgj7/2HL6wW1g9zBqHMtgg0Mtb7Gn
         LJWfaa0KPu2TAoU54AKrEPZExsEM6Y8PCuwR8RfdzF5FKudBFUKeP1x4ZHNBAlyTmSB0
         PkOhQ9clfjUu+IPk/1mHbXKmEq9RUSog/feOHtm5VQiVVen5mlFhSW0xKrCJ89YXNi+W
         GlHYhnCzEDNm6udAhcZDOKqDLRME0l9d96AThMt/1KC+TdEmfnODaZrWKR/9zJZEMemZ
         2Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251245; x=1755856045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMwFCHUMF+OJtcZoZN8E7Av8Dx87kERB9UUx8xTRQHw=;
        b=Xcui/x4l38xy4QzyGh4UYcp2TILuiRU9FyAYfhu70KKG4t1e/Xk0aCkkdfguOxURct
         mE72D1Ea6VVy/5rt8BrC9YNkKXklBPTmmXgifvXHOaLUnj0JPZjTZDV3e2vG30SRqSmZ
         5B+MlhTMMk9MsFPxDy+UPrHBY2+QDCiwXwDmE3DPBJ+nBDvUTMgAmHDkzqfFF0GPywjy
         wN2GyOTnDSKg9ibcZpmiUoBL6eydcHia+tyQN7jxzaQWu5183jLdCP4Le36zonxRoN4f
         Ec1ehVvuIRTg8P4z9yVDgLkn5cEglmsJGJJpwoqPjMrUHAJwTknNn7yxkuomzQ/jNVBs
         XNkw==
X-Gm-Message-State: AOJu0YyVHUuRv6RMCaKVbJ7zC6jWhaRXc/WoQzjfd0X6wXXIfHKDgKdb
	Wd5/hWBBOMqh6dTNzpHDKBfOS18buSO/MWJCnvxoZegFTdrXzo6JgR2igxgb2zmIgHIC0qsk7Iq
	OqgnP
X-Gm-Gg: ASbGnct4gvj6oEkP4+xb/q7j99Y92ljdpEMPd3lvZ2zGqN6LFoT/yZCpT+PTc2TXvnX
	WXRKDkFsHwVy4mJqjCEFnZ9t20wiShCfNl8qjq+4JDBeYCM52nwWQI3BwHc+uEQQXekok+3C4ZN
	0lvp8XkxKyfWknDlC+67aUxWehygrt9l3OeRg1fpiI/Y78LUIfRE7Dv+hC2NDIw8Pa9m5ilXhZ3
	Cb4mIuXV+qmQ7baP2xtKAopOkgDvgSfF+jBy/ZSKzoHH+26Z4Zxqnm7qEITmnqokwvrykWJACsl
	Ag+w9e2Db5iDKM1lgzcixE7mgCpD/cKAnp9vBaHnTJYxxIih7fs5OPEjMs9iOXgIyvKo8rytMlB
	oxJkLV7bwa75A72yc/XPxdiKsdbnhizAGZrNWj6JUYJfiZQ==
X-Google-Smtp-Source: AGHT+IErHn2TyulguFlSAg8WRREyBgk4z8RvseYRNyYTwI0rXzvCi/eT+b8WlK0IZTm0/MgvkRnz7g==
X-Received: by 2002:a05:600c:695:b0:458:bbed:a812 with SMTP id 5b1f17b1804b1-45a21ef1329mr9272145e9.17.1755251245311;
        Fri, 15 Aug 2025 02:47:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a209c25a1sm23241755e9.22.2025.08.15.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:47:24 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Workqueue: fs: replace use of system_wq and add WQ_PERCPU to alloc_workqueue users
Date: Fri, 15 Aug 2025 11:47:13 +0200
Message-ID: <20250815094715.54121-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

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
	-	Make more clear and uniform the system wq names, both per-cpu and
		unbound. This to avoid any possible confusion on what should be
		used.

	-	Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
		introduced in this patchset and used on all the callers that are not
		currently using WQ_UNBOUND.

		WQ_UNBOUND will be removed in a future release cycle.

		Most users don't need to be per-cpu, because they don't have
		locality requirements, because of that, a next future step will be
		make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
	-	Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
	-	There are users that don't require a local execution, like mentioned
		above; despite that, local execution yeld to performance gain.

		This new API will prefer the local execution, without requiring it.
		
=== Introduced Changes by this patchset ===

1) [P 1] replace use of system_wq with system_percpu_wq (under fs)

		system_wq is a per-CPU workqueue, but his name is not clear.
		system_unbound_wq is to be used when locality is not required.

		Because of that, system_wq has been renamed in system_percpu_wq in the
		fs subsystm (details in the next section).

2) [P 2] add WQ_PERCPU to alloc_workqueue() users (under fs)

		Every alloc_workqueue() caller should use one among WQ_PERCPU or
		WQ_UNBOUND. This is actually enforced warning if both or none of them
		are present at the same time.

		These patches introduce WQ_PERCPU in the fs subsystem 
		(details in the next section).

		WQ_UNBOUND will be removed in a next release cycle.

=== For fs Maintainers ===

If you agree with these changes, one option is pull the preparation changes from
Tejun's wq branch [1].

As an alternative, the patches can be routed through a wq branch.

The preparation changes are described in the present cover letter, under the
"main steps" section. The changes done in summary are:

- add system_percpu_wq and system_dfl_wq, for now without replace the older wq(s)
  (system_unbound_wq and system_wq).
- add WQ_PERCPU flag, currently without removing WQ_UNBOUND; it will be removed
  in a future release cycle.

You can find the aforementioned changes reading:

("Workqueue: add WQ_PERCPU, system_dfl_wq and system_percpu_wq")
https://lore.kernel.org/all/20250614133531.76742-1-marco.crivellari@suse.com/


- [1] git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git WQ_PERCPU

Thanks!
		
Marco Crivellari (2):
  Workqueue: fs: replace use of system_wq with system_percpu_wq
  Workqueue: fs: WQ_PERCPU added to alloc_workqueue users

 fs/afs/main.c                  |  4 ++--
 fs/aio.c                       |  2 +-
 fs/bcachefs/super.c            | 10 +++++-----
 fs/btrfs/async-thread.c        |  3 +--
 fs/btrfs/disk-io.c             |  2 +-
 fs/ceph/super.c                |  2 +-
 fs/dlm/lowcomms.c              |  2 +-
 fs/dlm/main.c                  |  2 +-
 fs/fs-writeback.c              |  4 ++--
 fs/fuse/dev.c                  |  2 +-
 fs/fuse/inode.c                |  2 +-
 fs/gfs2/main.c                 |  5 +++--
 fs/gfs2/ops_fstype.c           |  6 ++++--
 fs/nfs/namespace.c             |  2 +-
 fs/nfs/nfs4renewd.c            |  2 +-
 fs/ocfs2/dlm/dlmdomain.c       |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c         |  3 ++-
 fs/smb/client/cifsfs.c         | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c     |  2 +-
 fs/smb/server/transport_rdma.c |  3 ++-
 fs/super.c                     |  3 ++-
 fs/verity/verify.c             |  2 +-
 fs/xfs/xfs_log.c               |  3 +--
 fs/xfs/xfs_mru_cache.c         |  3 ++-
 fs/xfs/xfs_super.c             | 15 ++++++++-------
 25 files changed, 58 insertions(+), 45 deletions(-)

-- 
2.50.1



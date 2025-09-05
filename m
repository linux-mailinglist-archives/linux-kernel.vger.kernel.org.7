Return-Path: <linux-kernel+bounces-802403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EEBB4520F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A52584296
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6412FD7A4;
	Fri,  5 Sep 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Em3cUYph"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E65230D35
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062334; cv=none; b=fp9AG/d/N1lITKidnsf8Y8wtU0l/2JgBfdjHBdZXxzVBgDkLkH78+js1G6gWo+nk0ZFebpyamZxMlFWxXb36TfziHJqXQCkq2Q0m9ENdFG+xVrBVNndTSYCMSCTY5tlvPlXzrIR2lgHTJyGw15BC3dT/VJ4xxYH+sI2c1L1cRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062334; c=relaxed/simple;
	bh=uzmBSMwoXngYjlIholE5r2rVuQmZGx6pYXHocyWiQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KdaK3OLREdsg5O7wVsvMyp3aOfv0n37pWRi+LrNjx3aqxaiIdTi7MrS8fuRmZOj6MacEUH8ybD1sP2z16YNtL4Z4NHLgftorrMxW0vHtOb9m5XzVJdR+bofg5O23t1BrhYSkzUbyzkBgEmv4e+Pxkrmt38rxmQyf3d0zRRn75mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Em3cUYph; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so7983125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062329; x=1757667129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBWmDURFeu5TBKEHyo69+X2TtXzrJvvyBPGevz2jbwg=;
        b=Em3cUYph3Oyxjd3WySd0PecR0O+iE8q4A/d3UMOswYgb3a/J/JOcnY68Rj8zd54Yjb
         NTXeOIF0IHNJDosnu0hul5zg8mXQzlv0WD5pRWmwwTXe1joYIMHkJtb7Ea9g/dU0ssdp
         ZcxSKxABdzkdlByfonqPlzFVTksSMRIoMfDLDLs1U6uUT2E1ujrizkHrKLbkjfKw7w6/
         Z1NQVW6MR5YbxHMOJ034Filu8BAaOIpIP672o/2sSuA31In7nMefy+mtlj35lQuphsv4
         omI0+cZ7xZrq71MQAO+PPrYnR5OX3NF04tHnJ/IVudKLXaIqVxulOj685PNRX/HZsWd6
         eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062329; x=1757667129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBWmDURFeu5TBKEHyo69+X2TtXzrJvvyBPGevz2jbwg=;
        b=e9khrh0eByu33UGIqbRgTNg/3syBS+fwN51CkvoyvSUraf/S7bDuSYRnQVeIFy8sv/
         7J9uV+gMgt7KNo9LpZYkv1jJPLNn72+LHh5cym9mZzkaivVg3h+Z0gvDbBd48Zr8j+9J
         zbhv7HCsjEi4sQYVYpPEZK/KlgRYVE/jzKdwoZ5kFILLgEIbI8UsA9m033XK6m/fhcO1
         WzXHy4zIPxnb93NSfc2jj3j+awCaVT62k1VKU/E9h3wYzvke4rkdzboLsEu9VgPjQKZd
         PpI1qObRAG/qpYKW5es3msDbW0EZjanQlTHYeryR9/Hg4H38wMjeG9SYvpSdyBXO0nCH
         NpsQ==
X-Gm-Message-State: AOJu0YzXcb2LyrodLNLIvi5DmYjCXJcyLOe+Sbz6Rysp8YroMcT7bt5M
	Bkgmen4//sRaspwg2hOzbVjUdKd9gGXJluSsd/H6wtuoZ+UpEmffJE8J/JgaHt5HZoaooYvkttz
	Zt3XJ
X-Gm-Gg: ASbGnctlnTJI8P4KpBYrUs66z/+8wdHCoon1Pzt4tAy7Mvlxx4hKFI08BnzS4XUlt0/
	/chl7t7XiJejQ4dyZdYgBfIgtT4ijQ9V+kIrtFmfPvePVZwx1Hf26h/8bHFJVPOrw68ykWJtoOI
	sa2OL4rUhGDKP2+xU+n5Oc1645Yv5kU1ZrMLi2EzOrrmMQ1GzAMWB6PBpQni0c2ggQREHvoq8gh
	Q+M1uOCygkI+Bil2tt/wrgzGt6AsGs3kK2F+Pl88l8USOC/uCxyPyFMDqY7OlK2ULGK4VE5iUmw
	dSX9saQSRYges1QOueW631U1+g/CJASPoiOTRgCDIliRsO3ISHqfo2erKv+NgZkWbMVDmZrokpa
	mUjTtoMmkhFdDj25vukjsAwOY8Dx9NTE1zMjPrGB0Ko74jqc=
X-Google-Smtp-Source: AGHT+IF+/qwt/hDvrjvFcrV36f5UMAxxiiy+FQMCKBe/CySjhZZjN3LkyXnEFc/zkLX0zFf/cCDl5w==
X-Received: by 2002:a05:600c:1584:b0:45d:d609:117f with SMTP id 5b1f17b1804b1-45dd60912c7mr14760715e9.8.1757062329347;
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:51:38 +0200
Message-ID: <20250905085141.93357-1-marco.crivellari@suse.com>
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
  drivers/block: replace use of system_wq with system_percpu_wq
  drivers/block: replace use of system_unbound_wq with system_dfl_wq
  drivers/block: WQ_PERCPU added to alloc_workqueue users

 drivers/block/aoe/aoemain.c   | 2 +-
 drivers/block/nbd.c           | 2 +-
 drivers/block/rbd.c           | 2 +-
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 drivers/block/sunvdc.c        | 4 ++--
 drivers/block/virtio_blk.c    | 2 +-
 drivers/block/zram/zram_drv.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0



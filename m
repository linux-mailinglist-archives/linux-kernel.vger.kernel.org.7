Return-Path: <linux-kernel+bounces-802475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1AB452AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8431894718
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E630CD81;
	Fri,  5 Sep 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ScCTqce1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669C24C077
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063349; cv=none; b=aYS3LAUbCE2ArTJN7Bpbwnr6CPe0p25Fpz2h/YajWVcY1Jz4V7S44ygWwr7IAzT8LqUvkIEBhgztOucf0euQcjn74tb1u7TwKJZ7ahzQciMVnitU0+VPAEQkL92O0nLAvukM1gw8GN8s/JksHS8EPKVnGGV7ix/R75rTsWcC5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063349; c=relaxed/simple;
	bh=7Lq3qMXShfmBDk3ScmH45ToYpqdeDRbNuuuQpDGUbUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSCAP7aa0uIJ3ar2eN0TKJWQb3pOJvoQEQaD/3sOxyHDHV3cOkrhgvod/htMO90Siuv1Rsf/gseO3ykhy04A41QgIC2JjPrSwkJQcBBWE5qels6RBe354z4AZP5beJ/OOi0ffjJOekWgZJZZsiOB/kbYp4a9QFJomYselCpsZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ScCTqce1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so13645855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063346; x=1757668146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7GrTx5OAH0jMmNOM8g0SLGoBJRngIK/hcbD1dJzJHo=;
        b=ScCTqce14k01HmfYs3wHrMyvUIRgKddUp4NddEcMTycJ7ihrlrNSUlKV9pvRe7/3Ni
         aJQnJzB0gOjABjKfHArDtBcyQUJbFhWgDXjCp1nPiQSNYfNsV2lA1f+wWVKVCrqTy/vj
         wtHcAP4PFaUdl/sw5YVz2I3/o5/SoqbLYF4DRiF44+y4+LAQkVi90skb9nLh5jjCcK6j
         Ma515EWoTO/L0COOAteblpJIssVWIIae9NXnCu2PgTqcnErDlCV/2A7BGXrcM47UVDMM
         xu1bxbcBktKgNotn89dc122usb4VQ5fkQD+Jru4uniuWO6HDoJU0GyXYShuVfiuDsQZY
         f9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063346; x=1757668146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7GrTx5OAH0jMmNOM8g0SLGoBJRngIK/hcbD1dJzJHo=;
        b=AW33cgRD86Gm9hGA8GI+FpE5NgVHY0cEU2ww5guCYmzzWPdv3A1LXwb3Xu3KczIWca
         Fpm1SJQxPfwhNeY02W3OoNKiyOzLpsUY/u9xsaHjDONaa+NcUBBSIRg5p6FNJLvLam/C
         5/5ohpMwyrJ4D8o/5G/4BX6pqCw7XuMnPytmrd2BdYzsNWCQDApBiER1iwqY0ZvSScM3
         3mEz+OUPaNn1KI1IcPVkjlhHILCOvqtLS1i4sq9tchsmLFibJnH1WphYc14QsrgtpEKO
         pKDoNKY1UYLw8rkrL3fgIpDp/egrN/aSelKWyUmGha4sV8CtzhqNU9n8dVOoFHS2Sdf6
         EnrQ==
X-Gm-Message-State: AOJu0YzYWrd53cvL2va/otE6qbsqxuALdYjjanuSoSMC8W2sIVjSJYPx
	mRvYmnSh9DMVtU/0dJd3QaRTmh557i83QamLbiPJQoBMKRS4hjQy9LD/SVfKAUGgvNu+MQq5sUr
	b3fjknqk=
X-Gm-Gg: ASbGncsANCY/LWv2Chk8semVRScABFeTBAPaQ8dAORMurIaRRhJSSOBKpoNtWK9Mz2z
	zM5388jZoopjnptv8k2XMqzl+k94AH3Ju6KW4qkaVc81mA7cfvu7YQ/88kPdPPmNg3EZ29AhsCq
	Pd0c6dsLtzXLZRnXed8s+bvJ+fbCTTs0YdrUvpTVNQeEuA1ZTOTdeonCtopbiCMyhRCLXOEAchR
	F3DhI/5Usc9caBmcQIKriqkmgj6ZIWQ294Kna7tc4pOwBI9iWVzId07y/iKcmuX2M0EgBmq4Akh
	Nt/qg/2sZdoS/XXN7bIjxErnGMuQ/gKbLcOH3zgwUVQjv1uCGXKEN+OCKNAuolIastftSLd+2cf
	eH/WHf6Hvf0FyctxiFeIkVrFEnZfBrupvo5CbgU8S/OaAWA9ShlM7V5gQxw==
X-Google-Smtp-Source: AGHT+IGFAkAMNWLANszf5sfV5IIK/XFKx1LcXShCkOWPlYc7igvx9YUxhH0uGtBFRkNHjHYd+DFmuA==
X-Received: by 2002:a05:600c:4fcc:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dd59d2f76mr24210995e9.10.1757063345990;
        Fri, 05 Sep 2025 02:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:05 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/2] s390: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:08:55 +0200
Message-ID: <20250905090857.108240-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

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

Marco Crivellari (2):
  drivers/s390: WQ_PERCPU added to alloc_workqueue users
  s390: replace use of system_wq with system_percpu_wq

 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 drivers/s390/char/tape_3590.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0



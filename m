Return-Path: <linux-kernel+bounces-802446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CDB45279
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D55A18AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E42288527;
	Fri,  5 Sep 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LICtj+fr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1A27C150
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063016; cv=none; b=XtYCWcdixl28a44Mud3sJV065NZhjO0QlxdO4ElP+Fq1Wl/ZVUDSw3KE9O2zb5XCbQyvcji04k8xOhJRXBqE+o4V4ET903yQSdXSpwSkuDICwBLw2lXg/u11ML6ENHWtWNwq1rhx18Xmm0aWv5yrwVLOcYSctaVJi2oUFXlSgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063016; c=relaxed/simple;
	bh=KolEP05yqWLhazpEnmLeispUf+QK8waYV29HR+L5MYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gv2trHZkTVdybUdMtB/4TzKZJFwpnWYEydt58gS9dZGU/TWeWcRRdMQwHdfzuoiiFIQB7whkk/XN+l7vs4JFVBlFSJFRyWZ4fN7Doqh1tk8VUpr/6VwQgp4b3kVOrvqeeX27IISfjqt6QunQ5qwwzLYV4NyzbvHBtnRXtwIuW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LICtj+fr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so17988205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063012; x=1757667812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KL3x9RSWXKSLdTGhSdSpbWqX8OUbo1gEgXbGFUG72VA=;
        b=LICtj+frO+sPeHt57R5wCXIQZQ2D5HpxcIZzsK9CGUOsXYV6nO+nyHt3Uz86TmKpQ2
         vxO3fwhlsS/ULUcM2CdeiwQ7D2xfzCHzyj9aNP/vbFXAI2ALQgAF8Uzicr+hRbE4yVBl
         tMGc6ZP7tx7NZM1S/k4AmdFVQNc12x4es7sTOaS9L0RGQMWiidXbQZEIfYGY/scyegs+
         U6YK2SNpXY2Usx//nOz6VcnaLgd/H3pyg+tcYp5TTUMlF9uO9ZOlqhzqmg4KGXTzo4ft
         nZpiNdXUxyMwhOG1YfXnHkcvbWpA/ZgM+dJRj+lbLjLCNcHEmLrBzDgPHS2fqqDlqj6P
         5mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063012; x=1757667812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KL3x9RSWXKSLdTGhSdSpbWqX8OUbo1gEgXbGFUG72VA=;
        b=jYNNoXGVEjNu7U/VH4yb2ChPveDoLqbYI1WuHmDITJ3EWYJWHvmcRYAAucKEUXyS6d
         BWFMIDU+OUCPXW7OOHl2BWpTK15veFQSi2jGPdiRUAt3TnhfBqapRabZgvZEOU9m2C17
         zaK0HztH4+yjr/0YI9Mfw8ZlJ4TpjE3EeiJ8sG6k6ilG2lSMT/uWNuK/mnE5aU3cVVHF
         GkLXXwtuuFkxz/l4vfzFLhzEmWzmt2cDU1KJYCAG3b1dhvxy1t/v749LVlrTNgrSP/wO
         M5YiQH4DzwREWAaQrKUKpRs2GKEdHiqrB+mmfhw1z8LgVbXQ6DWPJRp7ftHyb9ZC9LKF
         TuGA==
X-Gm-Message-State: AOJu0Yzb3JKb5GwZVQcB1rbSpdyEnp/rXr2EOdqEak+diy9Ol8k7+9Tn
	gKmyPm3ap2txlnoj4OCweY3qPaRRd74j9ajs4Ig24Qeo0jD1kuWnwGNVAXwK4TtwwCP/sXn4nPf
	K3ILP
X-Gm-Gg: ASbGncu7ADvSwWEZnG7V1thH+eBYQeWmqAjepA0KI4z7GCOg/RhomyEsC7GJgZc5Joo
	4JM7PJuMz7ysPraVTIOxptPGncC3LGeDjgwIcWmIuU3BcfEObmbkUAwuZn4cMX75zzzkZete5n2
	rBpM+jQIS7Rg9XauIQb9zoCcjbvyAMg9wHwBD+9Qp5zhMpYT4Nqf7PN1zY/2zkdFZDsUeMRxC2K
	b0CUPnXEeKVE++OWAytKF3KuL+vRihlKi4j7wKDfGYgCnVV5br7qlSVo2DAal/xd77bAIWHjvH1
	oOzFr8qslWbCCz9AD3X7ny2CZ3CFp+6AIh234jAYlDr+bOxJofkNpfZdLDf8PIUsat1vs7hQsVh
	CbOh5xyHQwfZyuWW38O7Rd3qYtyXpUBwkP61kCK+P9wjduL0=
X-Google-Smtp-Source: AGHT+IH7Xf7he/bZvGPKn0Yiqk81LbFmFkKkY6ULudRp2kYJgJ9E+EpwCotTTIhB0vk5XsgDBSaUrQ==
X-Received: by 2002:a05:600c:a45:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b85598614mr207667235e9.24.1757063012191;
        Fri, 05 Sep 2025 02:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm3614543f8f.62.2025.09.05.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:31 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] mm: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:03:20 +0200
Message-ID: <20250905090323.103401-1-marco.crivellari@suse.com>
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
  mm: replace use of system_unbound_wq with system_dfl_wq
  mm: replace use of system_wq with system_percpu_wq
  mm: WQ_PERCPU added to alloc_workqueue users

 mm/backing-dev.c | 6 +++---
 mm/kfence/core.c | 6 +++---
 mm/memcontrol.c  | 4 ++--
 mm/slub.c        | 3 ++-
 mm/vmstat.c      | 3 ++-
 5 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.51.0



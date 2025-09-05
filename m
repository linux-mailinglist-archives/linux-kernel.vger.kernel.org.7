Return-Path: <linux-kernel+bounces-802480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580CB452B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732C61C87FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1E28851F;
	Fri,  5 Sep 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R+8Vum56"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D144D599
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063405; cv=none; b=mIlrKxUIARLqbs6oZlJ2PbWuQUiLtx/XY1s6eCBaRj5lwZpF2bm+CqrEnvJRpL5wVX/CJo75PT7tqGC5uaAKQ/CTvGJDE5YKq5PDJRervBM00fUpdpBoRQrkNrPDWXwWebgzrOdspOw/b+dNefNk0fWq2FskTv+L80DuJTXaV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063405; c=relaxed/simple;
	bh=jsSjJFExF5OCPhdEG7+S8t0Zb6n/ctvRoQg2EiRgZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOK2agcmbIbTjaFpdvhvtg6SnuoZz/SFJJX7XXqKYAGwPfLFv6+N9J8QWfAE8KS2XOTwfFyXdTp8NKbOcLiytV6V8r+r68jU4eJMOUWjtGkxnZ7gbc15YWmz0eBuL2zT8KzMFeelkpwRIni9nqZsEe8y+VovFGjuF60JGS1gsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R+8Vum56; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8025545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063401; x=1757668201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9XD7RuuUxgvLPOkhq+gsjkRL9z/bNF60lDSd/zyr7E=;
        b=R+8Vum56XpD/YH/9N/FTKv+LnrFRe/iuPTcwXcXoXh/qIpQ9yeBspRWnFYoFCNznsP
         ZV6denhWZt15QG7hutJwY7VSRItuCPyQGK9BfkKuvPoTQigfXnXHOeFMPTrnuO5N+kz6
         eCxv94tYE8drjIQ2klp+ZTeX2WvXj1AY1vfUs9DFUgLjg76RA10IHalBB+CwAIKcm7Dx
         LlhuSRvz7vTFml2Hq4mWCUUYw3+IKVlKK3rL3Occm+2CIG78kVR9vGM7ClGDu1U0h0w5
         //oG4kP2nWX+Tk/+bVPlYwr0P6bn3DOz78UP8nvuIeRnYDgwuvPox6XwCLTdv7qOSfXd
         METg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063401; x=1757668201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9XD7RuuUxgvLPOkhq+gsjkRL9z/bNF60lDSd/zyr7E=;
        b=WpRBWvyOFV2fGW9GXBJFq6a4VZd6onJYjFgRX/C2CHp32xv/G35Ydrrd+2DZUUyQix
         6m1mRvTu2pMFmTOMRN0X8lWw18ZhxF/SIkrDJcDQI7QVc8U7nxuhbK7KQGWN1SRZWpfR
         tluAeKcShxwpOIJYrUyYQrrjdAuQborh1IuNe0TzpOReRwVCcxuhBJ+W1qCGMrcHmCFu
         m6m4kZ4gsMP99WkCM2A2AWqiB/dEeqY+XGXOmYxbBK1Ffh45yYB7dkZZB5qA6RdcAEmO
         UDhEUyFAhI2pXKaL5StVCyz6i+ejPuqUkQ6ANfhkJqH5I5b9nWVz4w59FiMwRq2GSL1V
         4IGA==
X-Gm-Message-State: AOJu0Yx7SA704ZCLtZWP0s0j2BYwu1DUIiyWLa14GHIs/EwZSbmH6TOA
	NlXGitm5sZunWVyZkCbI5NyUwUPzJQ7ZSqV8ZC6Dpi4agtstMni2eKzpIA8quDoVme/FALM4KVU
	KnmYg3YI=
X-Gm-Gg: ASbGncsHpbE+1xq2bdXK7eLrY8OSWDkmfdS2sbUUeZlDY3EvsE4iHrG4v6H1y8JUvtJ
	ppeI0YbRT8NeB1KuLI0VaGbywl/w1ot0SS5fjO9ZCJCPKpk3OYmdKErvfnvyyvIszJiUiXpSAQ2
	392D5GCskq8pbwXAl1PtsWnbQB9IBeIgHqYLGIgCHE4QHR6HKCM9qXKPkr4K9uQC0hr73INvpnP
	5A5O5cBSY8YDTZ6qOU9s6gtpOBBchjERuRTsuNqXZKC65NslhrIlZQkhxBv2KOZxvlR2dFcLGmc
	99kDmOEPQOvs+ndk1BD2NfDlbOgBMSWsUupRuycJKAc9+j8t1QxMq7oZ6pe94/nEBBm7mLeYPnn
	UrSRYD6cf0IkTGAqMwdFFx9HULKHyxxUbyaRFoFQDfGPMaiHGNB85apiqFQ==
X-Google-Smtp-Source: AGHT+IFv2UO4jMjhjasT+BBJR4K11ienY90B1HAkWp/BD6lCy5ydCHLRWXvJgruDqaOZSU4mG0yWXQ==
X-Received: by 2002:a05:600c:35ca:b0:45c:b55f:466a with SMTP id 5b1f17b1804b1-45cb55f498dmr83821015e9.15.1757063401430;
        Fri, 05 Sep 2025 02:10:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm135607395e9.0.2025.09.05.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:01 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/1] smp: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:09:52 +0200
Message-ID: <20250905090953.109082-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  smp: replace use of system_wq with system_percpu_wq

 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0



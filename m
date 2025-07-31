Return-Path: <linux-kernel+bounces-751959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F454B16FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B567B1087
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC172BDC17;
	Thu, 31 Jul 2025 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvsLYI9o"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2192221FBE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959348; cv=none; b=kpbKi5FjfL/3n7li1ZjqUabsEEu4ajrRQkNHNu4YK8QcuxbfJaVY7A4F4OCb2EyEqU+P7MtyAfVm0QA2O91OgSP0DyGQTDBuId7sKrn3XKAHw7AROvXDkWSCH0fxq76hBZ9zMkZZl/abbdt3vnnJ4u1aWgRAUhnrz6zWXry3Z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959348; c=relaxed/simple;
	bh=ykxeOGOOFV3tXbuegunItF67JjjA831NL6qq+uvx1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uc3xr+0rYaa1C+1deA172Q0YVKD1OSpEvvfjtXYnPC2gYJCEx5alerIcHvn9nT7qdxwWMGqsUyDQvbi9PulH9yCH3Xs4B5+/dRmy+Z2AcdCYvRvMtcROgwFb8RnY3Cv72sFAJi5GhStbvKqMhCnv2L9N0XERFELqe8/++xN6SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvsLYI9o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b792b0b829so706096f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959345; x=1754564145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YD7mQhC1QLHiBJjxjORj55tdUZwnsFtTkkSbAA+7vnY=;
        b=SvsLYI9oRUQtwrPpKI4vcw6Nb+amc6hLx6h3KqaKAaDoF9pL8hgugakVoK9X1F4+eT
         UGyAmhaim2LIlG6ouBbgHWlM7kSIXwQ7UtZTA/One30am7JladT6JgWgMX7KohtL/gbc
         Lcp0bRII4WWco0sjYzfw+ykJiuoY7LEX08hSm2FknPomGrIHe+spMjb+Hw4x1P7x/EnD
         RJFQ8cglPSe/N6n9iyU+0LgPn+lOUHd+BT5KbOo1GU/+Ut9yfLVVb2ZJRy+P3hk25bi2
         IM8K26dEgXGxyjOpQnNnpqhqo1FKpqUpPRgtRyg/nRpm1IgiCUYNbs5k6dcJSKDa0hqj
         qXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959345; x=1754564145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YD7mQhC1QLHiBJjxjORj55tdUZwnsFtTkkSbAA+7vnY=;
        b=fNkw/JfA2HXhvi1Wbd/FXFKrCdbDI2NQmaWGfBxSUS/psXMYIDiZFhJ4jLLMCEostW
         7P5GX2fTG8Yc9JjXoIKSmwu4L27NnsLnCrZCQcW8YkdlCoTgBMmCYHa9Eq4dI5F5M3T3
         yvm0lVVQz58U38Hg4eN3u2xKICk6R+jiZXto/NIooMHFARHGF4kUmFRBh/jf2AFX0neW
         G2aQxtQ/JnMU6Oe34s5vQviVzOniqgQ6BN1iILzmHqVxLgYThRFe0zpXP4hKXQAEssds
         HUUPY+H/rcJhhSjeGKZGtkBMOsjE0tUBAIETAwtiK1LbxtRsev0VGZ6Phm9qnxtzUYUn
         k4hQ==
X-Gm-Message-State: AOJu0YxcjZ1PH2Ocs7Gu9lQNL7eQQuUYFmqbPj8uohRsFdyGeZ6eQlrx
	F64R43QU1lCVruC9uuunfYV3rmSoVRdDCMvx1c2x16z8OyD37/QqEeR+
X-Gm-Gg: ASbGncsuzHmC4rWiFEZU8eVrwOQFM2aGo+8Dfgc5qiW+a0CA8Rhkkp87LeL6xLOFimm
	gMEAUK1Fo4u2IaizqPsUO8U2s5y+bNklSC04sTVZI+7w+ErQtkWRPKQvsfvmSA4wHRdQTZL4PE1
	qsPdvtVDtUuK/exGS5e5qJ1cuQpcoc799o1ebZ51aBHdln0aiBNzZBY4Y+iVRqE0K5ZDBuxS2Jc
	r6dNzeP16JgMWu/iLdR4YMLcDN8h+RUfkgN8Lsxsi2LXpUvZOsN8vEa+pH+WdX0X6QqapElawlQ
	CW8lG83hS/lou6Wg3Wj5iLBeNdCOgQf0l1QZUTKbpVIU5R1prQyfB2rHmtPqoKpxsi5bnenpQgx
	XeGL6iwmrn7RTCav9sgI=
X-Google-Smtp-Source: AGHT+IG2WHJJ+QwAOGIYkVrUBw0Ma4Et7uEAsrJ2eSipH+dNT/hUhdcxfEQUD5IyoY7qeKpzVIm09A==
X-Received: by 2002:a5d:4ec6:0:b0:3b7:901c:92ee with SMTP id ffacd0b85a97d-3b795025bfbmr4346468f8f.58.1753959344648;
        Thu, 31 Jul 2025 03:55:44 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:44 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 00/25]  Hierarchical Constant Bandwidth Server
Date: Thu, 31 Jul 2025 12:55:18 +0200
Message-ID: <20250731105543.40832-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the v2 for Hierarchical Constant Bandwidth Server, aiming at replacing
the current RT_GROUP_SCHED mechanism with something more robust and
theoretically sound. The patchset has been presented at OSPM25
(https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
be found at https://lwn.net/Articles/1021332/ . You can find the v1 of this
patchset at the bottom of the page, which talks in more detail what this
patchset is all about and how it is implemented.

The big update for this v2 version is the addition of migration code, which
allows to migrate tasks between different CPUs (following of course affinity
settings).

As requested, we've split the big patches in smaller chunks in order to improve
in readability. Additionally, it has been rebased on the latest tip/master to
keep up with the latest scheduler updates and new features of dl_servers.

Last but not least, the first patch, which has been presented separately at
https://lore.kernel.org/all/20250725164412.35912-1-yurand2000@gmail.com/ , is
necessary to fully utilize the deadline bandwidth while keeping the fair-servers
active. You can refer to the aforementioned link for details. The issue
presented in this patch also reflects in HCBS: in the current version of the
kernel, by default, 5% of the realtime bandwidth is reserved for fair-servers,
5% is not usable, and only the remaining 90% could be used by deadline tasks, or
in our case, by HCBS dl_servers. The first patch addresses this issue and allows
to fully utilize the default 95% of bandwidth for rt-tasks/servers.

Summary of the patches:
     1) Account fair-servers bw separately from other dl tasks and servers bw.
   2-5) Preparation patches, so that the RT classes' code can be used both
        for normal and cgroup scheduling.
  6-15) Implementation of HCBS, no migration and only one level hierarchy.
        The old RT_GROUP_SCHED code is removed.
 16-18) Remove cgroups v1 in favour of v2.
    19) Add support for deeper hierarchies.
 20-25) Add support for tasks migration.

Updates from v1:
- Rebase to tip/master.
- Add migration code.
- Split big patches for more readability.
- Refactor code to use guarded locks where applicable.
- Remove unnecessary patches from v1 which have been addressed differently by
  mainline updates.
- Remove unnecessary checks and general code cleanup.

Notes:
Task migration support needs some extra work to reduce its invasiveness,
especially patches 22-23.

Testing v2:
The HCBS mechanism has been further evaluated on two fully-fledged distros,
instead of virtual machines, demonstrating stability in this latest version.
A small suite of regression tests shows that the newly added mechanism does not
break fair-servers and other scheduling mechanisms. Stress tests show that our
implementation is robust while time-based tests demonstrate that the theoretical
analysis of real-time tasksets matches with the implementation.

The tests can be found at https://github.com/Yurand2000/HCBS-rust-initrd . The
executables are essentially the same as the ones mentioned in the v1 version,
minor some updates. You can refer to that for additional details.

Future Work:

We want to further test this patchset, and provide a more commented description
of the test suite so that it can be fully automated for testing also by other
people. Additionally, we will finish the currently partial/untested,
implementation of HCBS with different runtimes per CPU, instead of having the
same runtime allocated on all CPUs, to include it in a future RCF.

Future patches:
 - HCBS with different runtimes per CPU.
 - capacity aware bandwidth reservation.
 - enable/disable dl_servers when a CPU goes online/offline.

Have a nice day,
Yuri

v1: https://lore.kernel.org/all/20250605071412.139240-1-yurand2000@gmail.com/

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Yuri Andriaccio (6):
  sched/deadline: Remove fair-servers from real-time task's bandwidth
    accounting
  sched/rt: Disable RT_GROUP_SCHED
  sched/deadline: Account rt-cgroups bandwidth in
    sched_dl_global_validate
  sched/rt: Remove support for cgroups-v1
  sched/rt: Zero rt-cgroups default bandwidth
  sched/core: Execute enqueued balance callbacks when migrating task
    betweeen cgroups

luca abeni (19):
  sched/deadline: Do not access dl_se->rq directly
  sched/deadline: Distinct between dl_rq and my_q
  sched/rt: Pass an rt_rq instead of an rq where needed
  sched/rt: Move some functions from rt.c to sched.h
  sched/rt: Introduce HCBS specific structs in task_group
  sched/deadline: Account rt-cgroups bandwidth in deadline tasks
    schedulability tests.
  sched/core: Initialize root_task_group
  sched/deadline: Add dl_init_tg
  sched/rt: Add {alloc/free}_rt_sched_group and dl_server specific
    functions
  sched/rt: Add HCBS related checks and operations for rt tasks
  sched/rt: Update rt-cgroup schedulability checks
  sched/rt: Remove old RT_GROUP_SCHED data structures
  sched/core: Cgroup v2 support
  sched/deadline: Allow deeper hierarchies of RT cgroups
  sched/rt: Add rt-cgroup migration
  sched/rt: add HCBS migration related checks and function calls
  sched/deadline: Make rt-cgroup's servers pull tasks on timer
    replenishment
  sched/deadline: Fix HCBS migrations on server stop
  sched/core: Execute enqueued balance callbacks when changing allowed
    CPUs

 include/linux/sched.h    |   10 +-
 kernel/sched/autogroup.c |    4 +-
 kernel/sched/core.c      |   68 +-
 kernel/sched/deadline.c  |  311 ++--
 kernel/sched/debug.c     |    6 -
 kernel/sched/fair.c      |    6 +-
 kernel/sched/rt.c        | 3024 ++++++++++++++++++--------------------
 kernel/sched/sched.h     |  140 +-
 kernel/sched/syscalls.c  |    6 +-
 kernel/sched/topology.c  |    8 -
 10 files changed, 1829 insertions(+), 1754 deletions(-)

-- 
2.50.1



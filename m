Return-Path: <linux-kernel+bounces-802465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABEAB452A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE79C7AC9B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B22857E0;
	Fri,  5 Sep 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoTpAeAe"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980E27F727
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063234; cv=none; b=mIL/1hlKXcEekYdbaCyr3pm9TIIkpKwmcxcawN7Ev1cj4J/DmG/dqLgdbgZBw6jiEYLnI3DlmOPbFlBX9IR41PdgczXNeYA1320YuzMdfUyxAc+7RDAhlLOGytNZdRBDuXOXVnXGK/SUKhV/pr5qNLFTYc8UhAojpDqzTcjw1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063234; c=relaxed/simple;
	bh=nGsURlCSPFwMHkpwpnRBNIFq9LbFcjE48KUt2cUhCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2p5uBT87JxXCSQdMjw0x8JI/MbYKbCJ+QNFa4ZuH6RAvVQDkOkgAc9N1KxzK049n89dU3G7amD+g/c9mDwjpxY5XjS/l4z1Ey1ziWmcIvzUuGtc0/g5P84QdhO248w5KNdIlho4rSagRnqBBPJAhcSm/2EusbJ7vjzQlnM+qAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoTpAeAe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so4157275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063229; x=1757668029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GcIUScVuiPlioGjKLRlRjgmAOi3epp++ZXELbLlRfY=;
        b=AoTpAeAeNfy+l1gufOnj8pjGi/zV2lhJoSesr0PVSkCUV4cN2w0C+U2uz0BNjkUs0R
         mgVxVfXddX28vB9SyA3ytSbUF7hm+S9ux7B1yNLmf5X5AxD0t8Eye+C8GiTMW49+uruG
         j5aBtkqWGLzVnDn4wSxhbX2kpN8dyccygdrScqzGjpLuZOd48BSsww9alcr87lBPiBO+
         CvpAovWi/1kEM51HHQtV+4h8uLsb0fHXFzk+8cPLhRXjNIu313k5ux3ELQZ7cpkeOfZk
         dwADhawCEv/1p3sivq48TTgN+hORxQPmsMOS+znYnxKRBlSRkS907FledjfqnuV/RuBx
         Cqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063229; x=1757668029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GcIUScVuiPlioGjKLRlRjgmAOi3epp++ZXELbLlRfY=;
        b=Mq6ZxLdQCVaThorYf/i7gt/Hsrcqn1OazOcXckdQduoDt2SWy8uXQGMfSjPvLOFAsS
         ucn0KnH9akHpL/IWIviRbDXX73Kn9SX1K39GyEIxhfGZfIiSc8DakQuiDYVHKWHFzwRl
         bP6fbSH4ESba8PMJAWXby7wL+hMmv82yVG/pcsaCZ/91VrFuZYCVqdXY+WEHdsQByKgk
         CUqeODS77AbrecMY6CVOA25pW6uOH2dBW+fXvNh/Y7l5DVXNu2eZr4QNCmflcRzEjYNd
         BIfFFNmJDosAyjUOnsrF5ZZtblY3WRYQN1ubFxik4kA2IjNDjwFXhqrjPCx7+4Ud7SOR
         9LzA==
X-Gm-Message-State: AOJu0Yyyg9mMg/nx5qNGC/Cbt6jIjTRnX8NrHIchoBuJ0g5IAVw8KTL/
	Yc09y6Y8FLr55IKAdNEGVpLwfcz3ZV1Z4xduOoDUzt3Aoz1b0eaneG28A8oWEhmUljHkogZqMHb
	pnyl9
X-Gm-Gg: ASbGncufcPq3UIZJTXjTD8Kb7ungpTREKzamGBiT+TQ3KxVHglj8rji5jMTKZXH8ad2
	/yHQ6sUCk8AeUFFxOLBpNX47VrGyhqs4ZZiQLYc/vblIAmNiqvyBBU6BDXwE+APdNL7rVPvzjxj
	VJ3J+5P1jyXrq/VjP82fIlYARY0pJeZQbOYN1Yrl5tmzjFigLc89XIqf7F0ph/BF6+ph5HpGXp0
	+/SlI5aAVlBn5G4LNh7gVHwzD6LCp8GNBzIYRKtYy3KnqZh5unbermuLNm1/RQovON4gjaHVxUs
	WL0FCZzzRDcqsCyZYG5NtCZUAKET5xMlRoTvNbzUXZXj7ZXPaVfX/hTzw7Or/mDkLHaW722TKYC
	Qk6eu/bn8EIRdt3U65+AoxFOUy/bT7D8eNUXpWM8kz7VyXjg=
X-Google-Smtp-Source: AGHT+IHK/rpFXhjPJeTma6YO95IHuyCp72obym5OqKOmlqjGWCVgqv0gSF2AQvVrvQpPFKJV4RqowA==
X-Received: by 2002:a05:600c:4695:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-45dd5b3c3bfmr22463695e9.8.1757063229313;
        Fri, 05 Sep 2025 02:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcf3de7sm35952735e9.4.2025.09.05.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:07:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] power: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:06:39 +0200
Message-ID: <20250905090641.106297-1-marco.crivellari@suse.com>
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

1) [P 1] Replace use of system_wq and system_unbound_wq

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
  power: supply: replace use of system_wq with system_percpu_wq
  power: supply: WQ_PERCPU added to alloc_workqueue users

 drivers/power/supply/ab8500_btemp.c       | 3 ++-
 drivers/power/supply/bq2415x_charger.c    | 2 +-
 drivers/power/supply/bq24190_charger.c    | 2 +-
 drivers/power/supply/bq27xxx_battery.c    | 6 +++---
 drivers/power/supply/ipaq_micro_battery.c | 3 ++-
 drivers/power/supply/rk817_charger.c      | 6 +++---
 drivers/power/supply/ucs1002_power.c      | 2 +-
 drivers/power/supply/ug3105_battery.c     | 6 +++---
 8 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.51.0



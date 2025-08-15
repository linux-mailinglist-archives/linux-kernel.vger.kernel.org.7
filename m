Return-Path: <linux-kernel+bounces-770653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC17B27D78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1491A5E5E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6082FCBE2;
	Fri, 15 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="al+7SRBh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB021FF47
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251297; cv=none; b=X9rbLkEq9Zc/+5X3BaeDMoDfhp2D+1vsEOstk0LEOizz+pnQqURKkbLYvV8Z7mxvXyrMHkgzGaBTxQmjtSlkR5tooxEfebnacL6Ro3W35kClkVwfcOddQJIOt2aJBtLl1Eqtt1AkrZLKnAuVumU9eO9iwvllk3arn8QZGmjVfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251297; c=relaxed/simple;
	bh=8nAIQLVuv+uNTs3JE/nSTRCFU+uEWvC7cQkhBBT3sX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TWis7ScoVPoVZIRBT/X5B/MOKqwA+3AW8QIVk2yvgMeT+mNy7J/rx1x1EN1AHCNaCOg1jDSzMmzWLA70Q86b9D/SnEIUxmnLpD/3voJYZJA1HA1b9afwt7JNvrTMLGNMApMUmbEUim1yu4In33/3HsCIDaYcS/4ldSgcLHVDFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=al+7SRBh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so11593775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251294; x=1755856094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ize45qr1K04edblcCekHUAetpbN9SWdG+qC7LbOB7og=;
        b=al+7SRBhtWrdp4DY0ZqCqVtJsd6eAwDqcpwL88clxELpMCD8sjqMSbWnlIfyPZZD/N
         bEhhGm3LEhK72wUaqrXttoLG/LVmr/0qcyvREOzejLYzJhARUM9Uyut5jRKvkTD6uc/Z
         Bn9kRHeVKwZe8zAhXyvOFpbyKZKALV41gSKz5sQXlYp7ZteY6cWHyvFCaZtHlmlRX3tv
         WHgCf559Oc46kYLEtgaaAFuLjxpG96Aob/UfFBJNQ5x2cGFGnwmjaJ6IcvvJ4t7i6hAy
         j198Y3MpbFAkCw84Hpas9xN8FUk+G8qq3vh3QXRGSUAhWySAwy/RO9n51UzJWC8qhoGY
         kr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251294; x=1755856094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ize45qr1K04edblcCekHUAetpbN9SWdG+qC7LbOB7og=;
        b=hNmwlm1Zx/q3s4fSKRGffd2K/lmjZ0VozpxGqacKe8ItHJqxdYqvVgCsu4hu7LtLG9
         q0JcRWQOJqbHhVYVm/4uykSPP2OGLLcg0AAy50aKj+iOtCy9DL8GR+J86+U3q13YPQFz
         iSQ+xudmsGRgRAET9KRT5R920pDXx6PPtHPojbCqmU9YLrtuffI/0dgzYC4Ay6oSxx4d
         w616YbR4iiMX2b+7I4H4XDZb11BqcJ/YNUeTVgR9FcM+ZRQldKbSmM6P7r3WpMw5K7h/
         YzCdt5OWfGGKzXTPxCNz1Xyg/F0V9ZC1NM3d5T16oRXjYRi9rAvdbdOM6Uley7Q2gELP
         yMAw==
X-Gm-Message-State: AOJu0YymqkI7dLVCkGthntgy1+I1EW+RkgG09ZcchX7vr+f4Fma0iH+5
	OzITJ8vBPLjt70wB1ycN9ylofhWqtb63FSh5Fi76d4mnSpIoG5Rx8oWZVBXYsLjB5q7xxZBc1+1
	EN6dc
X-Gm-Gg: ASbGncsHMi+F408WzBoxad+4B1DirZB3KRvzegsihm/BIjHafuW1piONxb3FaH2r4sA
	uN9ReIzOkzmnLu9IzOcbm8UZosZsWoASn0rUd9nqabwNvsWtTkl2FxIQgCOKxu6jOOZZaL03/P9
	9f/Gsr4u7Rq67LyF0EjESysnV7yI72cQbDlQF/2spHCi9FN33nO8AgTXkHbxpMA+TtIBRwPMnIS
	MmtNpffM1ItyFpOwlwe6kHyUS5LEgAMzBv7eH38BtrlLLWE1iUNMG4iUTADHu5imDj/BY1iEybc
	8jktO2yWDWD+bF/y70YSmB/FCYjJ/Rn4gmDudCU01HmMoAlmixDRV/MiCM9Wz3mUxhoymengfgB
	cmVWrbLJ2R3BuePeae8fP5G4LpcX2ZmA5AqV9OaujMY7yYA==
X-Google-Smtp-Source: AGHT+IEqIRYkk83qEzEPryjVf/MIHjDQNfhc+nb/NotQ5tTgS2nGZ9cNFl+Myz4yw+k1mmrOoM5lPg==
X-Received: by 2002:a05:600c:354a:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-45a21844ba8mr12680035e9.21.1755251293522;
        Fri, 15 Aug 2025 02:48:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223299ebsm12943805e9.23.2025.08.15.02.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:48:13 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/2] Workqueue: net: replace use of system_wq and add WQ_PERCPU to alloc_workqueue users
Date: Fri, 15 Aug 2025 11:48:06 +0200
Message-ID: <20250815094808.54888-1-marco.crivellari@suse.com>
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

1) [P 1] replace use of system_wq with system_percpu_wq (under net)

		system_wq is a per-CPU workqueue, but his name is not clear.
		system_unbound_wq is to be used when locality is not required.

		Because of that, system_wq has been renamed in system_percpu_wq in the
		net subsystm (details in the next section).

2) [P 2] add WQ_PERCPU to alloc_workqueue() users (under net)

		Every alloc_workqueue() caller should use one among WQ_PERCPU or
		WQ_UNBOUND. This is actually enforced warning if both or none of them
		are present at the same time.

		These patches introduce WQ_PERCPU in the net subsystem 
		(details in the next section).

		WQ_UNBOUND will be removed in a next release cycle.

=== For net Maintainers ===

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
  Workqueue: net: replace use of system_wq with system_percpu_wq
  Workqueue: net: WQ_PERCPU added to alloc_workqueue users

 net/bridge/br_cfm.c                 | 6 +++---
 net/bridge/br_mrp.c                 | 8 ++++----
 net/ceph/messenger.c                | 3 ++-
 net/ceph/mon_client.c               | 2 +-
 net/core/skmsg.c                    | 2 +-
 net/core/sock_diag.c                | 2 +-
 net/devlink/core.c                  | 2 +-
 net/ipv4/inet_fragment.c            | 2 +-
 net/netfilter/nf_conntrack_ecache.c | 2 +-
 net/openvswitch/dp_notify.c         | 2 +-
 net/rds/ib_rdma.c                   | 3 ++-
 net/rfkill/input.c                  | 2 +-
 net/rxrpc/rxperf.c                  | 2 +-
 net/smc/af_smc.c                    | 6 +++---
 net/smc/smc_core.c                  | 4 ++--
 net/tls/tls_device.c                | 2 +-
 net/vmw_vsock/af_vsock.c            | 2 +-
 net/vmw_vsock/virtio_transport.c    | 2 +-
 net/vmw_vsock/vsock_loopback.c      | 2 +-
 19 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.50.1



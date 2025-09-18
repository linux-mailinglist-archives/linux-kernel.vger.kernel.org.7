Return-Path: <linux-kernel+bounces-757547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1405B1C375
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E4818A57E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4E289353;
	Wed,  6 Aug 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/SD6BrS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588681FBE80
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473154; cv=none; b=aJkOoQakx8j+I6mNq4jIv4ijOGpAphdwea5BM6JeB7x5VHUgVjfyiBnljuQoVyokWZ6WrBvw+2Xr8l32KDHd/15sleowxpstKfCYQ6pCNyCFY0rHfk0BH9X4FLtepkE0PfG81OZJ7hHY/QVcsbWoY/GWb3Kxi0l5NZJ3dwcVIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473154; c=relaxed/simple;
	bh=lI1Emkccm+R6JQsa5DrYKXL5j0oVUDpQRIk89WBqsJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siDsM1Ry1TlKtbpTRn7HjfhNoIZ+3PjvOrrZ/ydzlRcEkiLguCOy4nsi2cccOQzC++8ARbqgOQWcVa5fvgFjUDKLf8++ofSA82SyytF38tIbsBbMmeFdmbCCqhuioIK01/ie/3CxraIuH+KVUg09jS+nRAv7apKnaEPFqpQ/k0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/SD6BrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754473151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4aY0odU//3/cTPWcGAYaqAi6X4ACSFonv2Rd8kh7Qq4=;
	b=T/SD6BrS01lMNig/24iKU6ePd6rwTIf6LHDmC8AL4Zjr9qs2YikLBOY2Ohp8JQaORbsAdX
	ssB7P9wbNyKw/pXwDrR4XrvicMHTZ+htnMVcfw5L8jgYsb4S0A5vCV/PqxKQLp98Dn/WHA
	1Emj9bYoudQbMFyqmhmRDorq3v7eYIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-7-BB_VedNQ6DGOkBmPyPDw-1; Wed,
 06 Aug 2025 05:39:07 -0400
X-MC-Unique: 7-BB_VedNQ6DGOkBmPyPDw-1
X-Mimecast-MFC-AGG-ID: 7-BB_VedNQ6DGOkBmPyPDw_1754473147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5D2B195608F;
	Wed,  6 Aug 2025 09:39:06 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBF621800446;
	Wed,  6 Aug 2025 09:39:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v10 0/8] timers: Exclude isolated cpus from timer migration
Date: Wed,  6 Aug 2025 11:38:47 +0200
Message-ID: <20250806093855.86469-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The timer migration mechanism allows active CPUs to pull timers from
idle ones to improve the overall idle time. This is however undesired
when CPU intensive workloads run on isolated cores, as the algorithm
would move the timers from housekeeping to isolated cores, negatively
affecting the isolation.

Exclude isolated cores from the timer migration algorithm, extend the
concept of unavailable cores, currently used for offline ones, to
isolated ones:
* A core is unavailable if isolated or offline;
* A core is available if non isolated and online;

A core is considered unavailable as isolated if it belongs to:
* the isolcpus (domain) list
* an isolated cpuset
Except if it is:
* in the nohz_full list (already idle for the hierarchy)
* the nohz timekeeper core (must be available to handle global timers)

CPUs are added to the hierarchy during late boot, excluding isolated
ones, the hierarchy is also adapted when the cpuset isolation changes.

Due to how the timer migration algorithm works, any CPU part of the
hierarchy can have their global timers pulled by remote CPUs and have to
pull remote timers, only skipping pulling remote timers would break the
logic.
For this reason, prevent isolated CPUs from pulling remote global
timers, but also the other way around: any global timer started on an
isolated CPU will run there. This does not break the concept of
isolation (global timers don't come from outside the CPU) and, if
considered inappropriate, can usually be mitigated with other isolation
techniques (e.g. IRQ pinning).

This effect was noticed on a 128 cores machine running oslat on the
isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
and the CPU with lowest count in a timer migration hierarchy (here 1
and 65) appears as always active and continuously pulls global timers,
from the housekeeping CPUs. This ends up moving driver work (e.g.
delayed work) to isolated CPUs and causes latency spikes:

before the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:     1203 10 3 4 ... 5 (us)

after the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:      10 4 3 4 3 ... 5 (us)

The first 5 patches are preparatory work to change the concept of
online/offline to available/unavailable, keep track of those in a
separate cpumask cleanup the setting/clearing functions and change a
function name in cpuset code.

Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
nohz_full from covering all CPUs not leaving any housekeeping one. This
can lead to problems with the changes introduced in this series because
no CPU would remain to handle global timers.

Patch 8 extends the unavailable status to domain isolated CPUs, which
is the main contribution of the series.

Changes since v9:
* Fix total housekeeping enforcement to focus only on nohz and domain
* Avoid out of bound access in the housekeeping array if no flag is set
* Consider isolated_cpus while checking for nohz conflicts in cpuset
* Improve comment about why nohz CPUs are not excluded by tmigr

Changes since v8 [1]:
* Postpone hotplug registration to late initcall (Frederic Weisbecker)
* Move main activation logic in _tmigr_set_cpu_available() and call it
  after checking for isolation on hotplug and cpusets changes
* Call _tmigr_set_cpu_available directly to force enable tick CPU if
  required (this saves checking for that on every hotplug change).

Changes since v7:
* Move tmigr_available_cpumask out of tmc lock and specify conditions.
* Initialise tmigr isolation despite the state of isolcpus.
* Move tick CPU check to condition to run SMP call.
* Fix descriptions.

Changes since v6 [2]:
* Prevent isolation checks from running during early boot
* Prevent double (de)activation while setting cpus (un)available
* Use synchronous smp calls from the isolation path
* General cleanup

Changes since v5:
* Remove fallback if no housekeeping is left by isolcpus and nohz_full
* Adjust condition not to activate CPUs in the migration hierarchy
* Always force the nohz tick CPU active in the hierarchy

Changes since v4 [3]:
* use on_each_cpu_mask() with changes on isolated CPUs to avoid races
* keep nohz_full CPUs included in the timer migration hierarchy
* prevent domain isolated and nohz_full to cover all CPUs

Changes since v3:
* add parameter to function documentation
* split into multiple straightforward patches

Changes since v2:
* improve comments about handling CPUs isolated at boot
* minor cleanup

Changes since v1 [4]:
* split into smaller patches
* use available mask instead of unavailable
* simplification and cleanup

[1] - https://lore.kernel.org/lkml/20250714133050.193108-9-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250530142031.215594-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20250506091534.42117-7-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20250410065446.57304-2-gmonaco@redhat.com

Frederic Weisbecker (1):
  timers/migration: Postpone online/offline callbacks registration to
    late initcall

Gabriele Monaco (7):
  timers: Rename tmigr 'online' bit to 'available'
  timers: Add the available mask in timer migration
  timers: Use scoped_guard when setting/clearing the tmigr available
    flag
  cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
    update_exclusion_cpumasks()
  sched/isolation: Force housekeeping if isolcpus and nohz_full don't
    leave any
  cgroup/cpuset: Fail if isolated and nohz_full don't leave any
    housekeeping
  timers: Exclude isolated cpus from timer migration

 include/linux/timer.h                  |   9 ++
 include/trace/events/timer_migration.h |   4 +-
 kernel/cgroup/cpuset.c                 |  72 +++++++++-
 kernel/sched/isolation.c               |  23 ++++
 kernel/time/timer_migration.c          | 182 ++++++++++++++++++++-----
 kernel/time/timer_migration.h          |   2 +-
 6 files changed, 248 insertions(+), 44 deletions(-)


base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.50.1



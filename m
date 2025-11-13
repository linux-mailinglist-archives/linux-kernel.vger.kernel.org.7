Return-Path: <linux-kernel+bounces-899213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8451C571BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC3A7C22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6CB335BC1;
	Thu, 13 Nov 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ygXxr0Qe"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B22D5C6C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032245; cv=none; b=V2Kby6DHGG074dqH+zLpApG8IIx0d2O8BgKK/gpD/+uI/kCnuEy4xjGaZC1tQ/EkdI48TiCUTQUo8qjs0WAnRRxUaxlUC9fdM82XYfe0lpZ7WofmIrS/K/8a7YO8/MIUUp+t0awPNlL0q0sOymEjGxY4SzK3szvoXYL3vEuivFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032245; c=relaxed/simple;
	bh=NU2DO26VBCObW+FNLheKiMpAQX6Qi+np61iGIH9kkpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EEsJNQnE1A/DWBSBmkHbKBeDVP0Vx3m3HUGVh19Lp6adF5w4V0CqU8G/VrRuKZHNPmI7oLkf6GQP1jIWZwaToZ9i0434HvhIwy2/Ta7Kj3DRi3I/JQxZEWu5A8yxca/zZ/9E7LGv7MIYPuHILxc32gdwpCUWED+WHVUGSwNYsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ygXxr0Qe; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763032240; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ac+kTbQ0ulaUQuHTs0/yklPkg3Ou7oKiQErKSgqxgUk=;
	b=ygXxr0QeXGmI8YKEB7LI78QVzN9fRvuRhUGSd4MQqQxJkjPng4NNMpvxNrDVbai4KxD8dIyK4leQOuzp2HvWzEg006cMfQT0Xab/gKUv5/oTmLn30UZUXS1RcaGgATlFWkrkscUzmfZvIh39qQUiz3+LVXpQvdBXFtIL4ejo3TY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsJMVrT_1763032239 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 19:10:40 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 0/4] Enable hung_task and lockup cases to dump system info on demand
Date: Thu, 13 Nov 2025 19:10:35 +0800
Message-Id: <20251113111039.22701-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on kernel stability issues: panic, task-hung and soft/hard
lockup are frequently met. And to debug them, user may need lots of
system information at that time, like task call stacks, lock info,
memory info, ftrace dump, etc.

panic case already uses sys_info()  for this purpose, and has a
'panic_sys_info' sysctl(also support cmdline setup) interface to take
human readable string like "tasks,mem,timers,locks,ftrace,..."  to
control what kinds of information is needed. Which is also helpful
to debug task-hung and lockup cases.

So this patchset introduces the similar sys_info sysctl interface for
task-hung and lockup cases.

Please be noted, this is mainly for debugging and the info dumping
could be intrusive, like dumping call stack for all tasks when system
has huge number of tasks, similarly for ftrace dump (we may add
tracing_stop() and tracing_start() around it)

Locally these have been used in our bug chasing for stability issues
and was helpful.

As Andrew suggested, add a configurable global 'kernel_sys_info' knob.
When error scenarios like panic/hung-task/lockup etc doesn't setup
their own sys_info knob and calls sys_info() with parameter "0", this
global knob will take effect. It could be used for other kernel cases
like OOM, which may not need one dedicated sys_info knob.

Codewise, these 4 patches are independent to each other and could be
applied separately.

Please help to review, thanks!

- Feng

Changelog:

  v2:
  * Add 0004 patch to add the default kernel sys_info knob (Andrew)
  * Simplify the code for hung_sys_info (Petr)
  * Use separate sys_info interface for hardlockup and softlockpu (Petr)
  * Consider the ALL_CPU_BT handling for hardlockup case (Petr)
  * Collect Reviewd-by tags.
  * Put soft/hard sys_info knob into correct kernel config domain.

Feng Tang (4):
  docs: panic: correct some sys_ifo names in sysctl doc
  hung_task: Add hung_task_sys_info sysctl to dump sys info on task-hung
  watchdog: add sys_info sysctls to dump sys info on system lockup
  sys_info: add a default kernel sys_info mask

 Documentation/admin-guide/sysctl/kernel.rst | 23 +++++++-
 kernel/hung_task.c                          | 62 +++++++++++++--------
 kernel/watchdog.c                           | 44 ++++++++++++++-
 lib/sys_info.c                              | 31 ++++++++++-
 4 files changed, 130 insertions(+), 30 deletions(-)

--
2.43.5



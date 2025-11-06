Return-Path: <linux-kernel+bounces-887685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4BC38DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F2189A5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1E248867;
	Thu,  6 Nov 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RR9+1MAW"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7E1D5CEA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396244; cv=none; b=JTS260daoVU85K0OmmMasn/MA0Fz5yYumJI2ExE6yJXQ8WMj/GK5PclrwEc8rYRN62W26rEdgwG2g2uOQOmELQ1m6Kj5ssvU7QrO2Mkkvc2DV1ESNSH+5R9NPWnyqdSnFQGJXBqHYAW36O9BY0S3ALN/VaeotlBTIKwnCrhT2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396244; c=relaxed/simple;
	bh=0Glg55zCL04NOSi6wuQx8R/AzjwcVknE7Xbo4YvNn0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9u2q4Qv2nGepwm85xR9Kwkv/A4QtwRMymuXDFdwTYyV3P6LvXHDcObPGMLxFfTBmB3qefP7wU1gTD5rFPcSvLkMsN8NJETuiHV8aszbJVmcx0UQljEo79Ot/PGY7aQyDNS1RWTmp1oO2KVE0DvV0Gkzk0L42CYAUYrw4ecscfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RR9+1MAW; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762396234; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qpFDpW9RXzUX0r2Rcpo/UZqbkY5cNU9mKGkbxvOLKpU=;
	b=RR9+1MAW/xB8B5eH/QtC6cYr5GYAERhwXILOZBdc6AqDfDnTfiTo73IwThH82LPcT6q3dh3aiRNUVq2OAAE6epTDWZRo0J53TGadDO5dB4iwSTLq92JvbxvMOibsJm7POQqXM/TAlID2tIOtK7oxld1d8YGiQAHTJGS5GQg7k+k=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wrne7ZP_1762396233 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 10:30:33 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 0/3] Enable hung_task and lockup cases to dump system info on demand  
Date: Thu,  6 Nov 2025 10:30:29 +0800
Message-Id: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
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

So this patchset introduce the similar sys_info sysctl interface for
task-hung and lockup cases.

Please be noted, this is mainly for debugging and the info dumping
could be intrusive, like dumping call stack for all tasks when system
has huge number of tasks, similarly for ftrace dump (we may add
tracing_stop() and tracing_start() around it)

Locally these have been used in our bug chasing for stablility issues
and was helpful.

Andrew suggested a global sys_info knob, and one thought for this is 
to have something in sys_info.c:

	unsigned long gloabl_si_mask;

	void sys_info(unsigned long si_mask)
	{
		if (!si_mask)
			__sys_info(gloabl_si_mask);
		else
			__sys_info(si_mask);
	}

to let caller decide whether to use its own option or the gloabl one.

Please help to review, thanks!

Feng Tang (3):
  docs: panic: correct some sys_ifo names in sysctl doc
  hung_task: Add hung_task_sys_info sysctl to dump sys info on task-hung
  watchdog: add lockup_sys_info sysctl to dump sys info on system lockup

 Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++--
 kernel/hung_task.c                          | 39 +++++++++++++++------
 kernel/watchdog.c                           | 21 ++++++++++-
 3 files changed, 60 insertions(+), 14 deletions(-)

-- 
2.43.5



Return-Path: <linux-kernel+bounces-752273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C7B17360
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA501C244A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F7155A30;
	Thu, 31 Jul 2025 14:45:31 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14613D539
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973130; cv=none; b=GKRtjHA4HNZVYvAxd99gut07bs5IAwZrKNNyLe09LIkzj6kwCLWfPFuIbs0UppYhLqtUqqFUF4lClGLZojATIkvuaaCMXPVIHn0Fkoqv6iN09g8AWl0dtt1C+LWQ6P4UE2mjKhXoGyIHMey3vL2YSdQtqPRKkIFfDG+o0WTp5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973130; c=relaxed/simple;
	bh=mQHQZzOgUyBuVTDMQnQPlIkaw0UO6teyO2+XDRZRLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tqd0BruW/TyYJD34+GjAnEL+bnngYhfH7jyHssCFtNVDuYdErB7wMg3PJuTnJ3wp5GhctrmlZVsBJFmo3HneHnRX8Se9o1tYoHH+ES6fDMRYHBTsMZctf1OpzYF2HnSktBSbv8innnfNKSzF/f9BMUMbEd2pDlvuVsaeJbQrcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 534CD1A0409;
	Thu, 31 Jul 2025 14:45:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 7A94B33;
	Thu, 31 Jul 2025 14:45:24 +0000 (UTC)
Date: Thu, 31 Jul 2025 10:45:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, Clark Williams <williams@redhat.com>
Subject: [GIT PULL] tracing tools: Updates for v6.17
Message-ID: <20250731104542.0878d70f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ftc6i1b4a7zmepy1747gihuija46qtia
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7A94B33
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tc/IfAGfWpsCi+Hjlw3FKh+dOdTY0/dg=
X-HE-Tag: 1753973124-647371
X-HE-Meta: U2FsdGVkX18uaogcUQ6OLRW2llR6y7TUcPVCBpls2oxpXTNnB3AHxsCJJ091ye4rt7ue4NUoPJaJT7GHySgNqlT+FW9C9JFKg6P83s9Xw1OqdeZZyZfIz1WzzjSwHWMBYZhZsQJhDQaWDY4agkU9KfenYJsIs7LVhDUSylmSYOkOAx7zqspwseZ0GhJn9iHQ3R/IW2U6hg/RvfbMM9cSUX5i3iT1aj+kCScPN05tiMWJ5oS7rjqcukAhVhhSeR4rlyqXmpNHwvns4wmpABkTH8yIiX99OgJHO02SGXV0G3dI39tgcgnE2unudQu6hkMiRcKusQ8/I2jf6KJONq88bqBHbQUyM3Jk


Linus,

tracing tools changes for 6.17:

- Introduce enum timerlat_tracing_mode

  Now that BPF based sampling has been added to timerlat, add an enum to
  represent which mode timerlat is running in.

- Add action on timelat threshold feature

  A new option, --on-threshold, is added, taking an argument
  that further specifies the action. Actions added in this patch are:

  - trace[,file=<filename>]: Saves tracefs buffer, optionally taking a
          filename.
  - signal,num=<sig>,pid=<pid>: Sends signal to process. "parent" might
          be specified instead of number to send signal to parent process.
  - shell,command=<command>: Execute shell command.

- Allow resuming tracing in timerlat bpf

  rtla-timerlat BPF program uses a global variable stored in a .bss section to
  store whether tracing has been stopped. Map it to allow it to resume tracing
  after it has been stopped.

- Add continue action to timerlat

  Introduce option to resume tracing after a latency threshold overflow.  The
  option is implemented as an action named "continue".

- Add action on end feature to timerlat

  Implement actions on end next to actions on threshold. A new option,
  --on-end is added, parallel to --on-threshold. Instead of being executed
  whenever a latency threshold is reached, it is executed at the end of the
  measurement.

- Have rtla tests check output with grep

  Add argument to the check command in the test suite that takes a regular
  expression that the output of rtla command is checked against. This allows
  testing for specific information in rtla output in addition to checking the
  return value.

- Add tests for timerlat actions

- Update the documentation for the new features


Please pull the latest trace-tools-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.17

Tag SHA1: 97181ac099ee9e7ef9f5edf99a0ad1c1b5fab8cd
Head SHA1: a80db1f85774ae571b94077f65c5cd57467641d3


Tomas Glozar (11):
      rtla/timerlat: Introduce enum timerlat_tracing_mode
      rtla/timerlat: Add action on threshold feature
      rtla/timerlat_bpf: Allow resuming tracing
      rtla/timerlat: Add continue action
      rtla/timerlat: Add action on end feature
      rtla/tests: Check rtla output with grep
      rtla/tests: Add tests for actions
      rtla/tests: Limit duration to maximum of 10s
      Documentation/rtla: Add actions feature
      rtla/tests: Add grep checks for base test cases
      rtla/tests: Test timerlat -P option using actions

----
 .../tools/rtla/common_timerlat_options.rst         |  64 +++++
 tools/tracing/rtla/src/Build                       |   1 +
 tools/tracing/rtla/src/actions.c                   | 260 +++++++++++++++++++++
 tools/tracing/rtla/src/actions.h                   |  52 +++++
 tools/tracing/rtla/src/timerlat.bpf.c              |  13 +-
 tools/tracing/rtla/src/timerlat.c                  |  24 +-
 tools/tracing/rtla/src/timerlat.h                  |  24 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  13 ++
 tools/tracing/rtla/src/timerlat_bpf.h              |   3 +
 tools/tracing/rtla/src/timerlat_hist.c             | 140 ++++++++---
 tools/tracing/rtla/src/timerlat_top.c              | 165 ++++++++-----
 tools/tracing/rtla/tests/engine.sh                 |  21 +-
 tools/tracing/rtla/tests/hwnoise.t                 |  13 +-
 tools/tracing/rtla/tests/osnoise.t                 |  10 +-
 tools/tracing/rtla/tests/scripts/check-priority.sh |   8 +
 tools/tracing/rtla/tests/timerlat.t                |  45 +++-
 16 files changed, 732 insertions(+), 124 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h
 create mode 100755 tools/tracing/rtla/tests/scripts/check-priority.sh
---------------------------


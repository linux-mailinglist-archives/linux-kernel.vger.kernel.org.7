Return-Path: <linux-kernel+bounces-748596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60603B1437A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD8E7A53A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65620225793;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOiQgbQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61D1C5D53
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735785; cv=none; b=D79q1GSJAR7BVgZSp0AIAoagNF2NMSb1/6GaxARlyxnAKijh4oGvLFEVhWxFC3N68Hw14YwintbBNveGzaA0WYDfc50bqDZyJqQ7aGHhfkMPKw41E+QLwSWu45ux6AtieYQqwugDKMF1c5QhZx0VzlBB6lfIjDGtDrVv37OAS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735785; c=relaxed/simple;
	bh=GL3gqrUHwJIdpjZoUxL4Ley0U3X51sHP+vg76SPtul4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JVefPXTR0zU5puOu5zuXnMrLdzKQ6rgH3aTbBbGDVq6Ytm+MtarOXS4jesE8XaTJIkIxZbD7kK6MnOlNcu6rmNddIbLHGCx1q8st/evCZeMGxYUmZ7xv3nAFRB/m+fbz21lctHH6N5BPrCZzbQ8uoVj+yl7lzSMaJmaLBEL5tJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOiQgbQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F90C4CEF6;
	Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735785;
	bh=GL3gqrUHwJIdpjZoUxL4Ley0U3X51sHP+vg76SPtul4=;
	h=Date:From:To:Cc:Subject:From;
	b=lOiQgbQXyVsH+JWpx/72FhOmuq+j2wZkuPuhiEyZMggY4F1dysQlliXXEpRmX42V6
	 WWsgp2l+HWwiEUCsZWYmjL78Um+KLLISUTH/lcPrBrvSkjWtUB0pBxHZUzEqUsauZH
	 sJnVSLXDOgSBg+kuTvwt5aRcDg0sw8djf1/BmgM2LRd9wkJIYvMeXkoYn0UdrBPIn4
	 GrGaJY8lfuUvJA/hnoKwRVgrjAsNeyh3yvbYZ251t3Ad6WQT8Tk53toR9BRkpcK5LM
	 Kl29RrkuPb4yV0nMLScMS2qPZ+pglEZHQqjGS3ZBziqRLHk34RC9Tf9fmom/2GVsPM
	 dieG7pvNg2pqA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnF-000000042tn-3mIN;
	Mon, 28 Jul 2025 16:49:57 -0400
Message-ID: <20250728204934.281385756@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 00/11] verification: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
rv/for-next

Head SHA1: 614384533dfe99293a7ff1bce3d4389adadbb759


Gabriele Monaco (9):
      rv: Add da_handle_start_run_event_ to per-task monitors
      rv: Remove trailing whitespace from tracepoint string
      rv: Use strings in da monitors tracepoints
      rv: Adjust monitor dependencies
      rv: Retry when da monitor detects race conditions
      sched: Adapt sched tracepoints for RV task model
      rv: Replace tss and sncid monitors with more complete sts
      rv: Add nrp and sssw per-task monitors
      rv: Add opid per-cpu monitor

Nam Cao (2):
      rv: Fix wrong type cast in monitors_show()
      rv: Fix wrong type cast in reactors_show() and monitor_reactor_show()

----
 Documentation/trace/rv/monitor_sched.rst           | 307 ++++++++++++++++++---
 include/linux/rv.h                                 |   3 +-
 include/linux/sched.h                              |   7 +-
 include/rv/da_monitor.h                            | 131 +++++----
 include/trace/events/sched.h                       |  12 +-
 kernel/sched/core.c                                |  13 +-
 kernel/trace/rv/Kconfig                            |  11 +-
 kernel/trace/rv/Makefile                           |   6 +-
 kernel/trace/rv/monitors/{tss => nrp}/Kconfig      |  12 +-
 kernel/trace/rv/monitors/nrp/nrp.c                 | 138 +++++++++
 kernel/trace/rv/monitors/nrp/nrp.h                 |  75 +++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h           |  15 +
 kernel/trace/rv/monitors/opid/Kconfig              |  19 ++
 kernel/trace/rv/monitors/opid/opid.c               | 168 +++++++++++
 kernel/trace/rv/monitors/opid/opid.h               | 104 +++++++
 .../{sncid/sncid_trace.h => opid/opid_trace.h}     |   8 +-
 kernel/trace/rv/monitors/sched/Kconfig             |   1 +
 kernel/trace/rv/monitors/sco/sco.c                 |   4 +-
 kernel/trace/rv/monitors/scpd/Kconfig              |   2 +-
 kernel/trace/rv/monitors/scpd/scpd.c               |   4 +-
 kernel/trace/rv/monitors/sncid/sncid.c             |  95 -------
 kernel/trace/rv/monitors/sncid/sncid.h             |  49 ----
 kernel/trace/rv/monitors/snep/Kconfig              |   2 +-
 kernel/trace/rv/monitors/snep/snep.c               |   4 +-
 kernel/trace/rv/monitors/{sncid => sssw}/Kconfig   |  10 +-
 kernel/trace/rv/monitors/sssw/sssw.c               | 116 ++++++++
 kernel/trace/rv/monitors/sssw/sssw.h               | 105 +++++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h         |  15 +
 kernel/trace/rv/monitors/sts/Kconfig               |  19 ++
 kernel/trace/rv/monitors/sts/sts.c                 | 156 +++++++++++
 kernel/trace/rv/monitors/sts/sts.h                 | 117 ++++++++
 .../monitors/{tss/tss_trace.h => sts/sts_trace.h}  |   8 +-
 kernel/trace/rv/monitors/tss/tss.c                 |  90 ------
 kernel/trace/rv/monitors/tss/tss.h                 |  47 ----
 kernel/trace/rv/monitors/wip/Kconfig               |   2 +-
 kernel/trace/rv/rv.c                               |   2 +-
 kernel/trace/rv/rv_reactors.c                      |   4 +-
 kernel/trace/rv/rv_trace.h                         | 114 +++++---
 tools/verification/models/sched/nrp.dot            |  29 ++
 tools/verification/models/sched/opid.dot           |  35 +++
 tools/verification/models/sched/sncid.dot          |  18 --
 tools/verification/models/sched/sssw.dot           |  30 ++
 tools/verification/models/sched/sts.dot            |  38 +++
 tools/verification/models/sched/tss.dot            |  18 --
 44 files changed, 1668 insertions(+), 495 deletions(-)
 rename kernel/trace/rv/monitors/{tss => nrp}/Kconfig (51%)
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.c
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.h
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp_trace.h
 create mode 100644 kernel/trace/rv/monitors/opid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/opid/opid.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid.h
 rename kernel/trace/rv/monitors/{sncid/sncid_trace.h => opid/opid_trace.h} (66%)
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 rename kernel/trace/rv/monitors/{sncid => sssw}/Kconfig (58%)
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_trace.h
 create mode 100644 kernel/trace/rv/monitors/sts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sts/sts.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts.h
 rename kernel/trace/rv/monitors/{tss/tss_trace.h => sts/sts_trace.h} (67%)
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.c
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 tools/verification/models/sched/nrp.dot
 create mode 100644 tools/verification/models/sched/opid.dot
 delete mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/sssw.dot
 create mode 100644 tools/verification/models/sched/sts.dot
 delete mode 100644 tools/verification/models/sched/tss.dot


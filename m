Return-Path: <linux-kernel+bounces-834144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772AFBA3FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD84189E44E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FC2FB08F;
	Fri, 26 Sep 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knFawx6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913E1632DD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894964; cv=none; b=BkYxTb7cEHvF+w/AjPplcH6cNUYkV+LEEY+ecsLmDsp1Id2flkeGcA+hgvZXekg+Q19khKPq50Q5ZZYj30nPyeoMtGecuPZpToY/5ATTTaCUes+qmOG7FnjrVfhBtNrvFCVN1ABjbvSF+pGtmFDp5e/sBT9hs7IrCvLuMesepW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894964; c=relaxed/simple;
	bh=ZJcOJe738J82333S+UWzutJXwsSL4xfYN0o3jB0o+No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rwe2GcgY+9KYU92Nh7LxatAKiyx0DiBwSsM5Pe6/4I57NeTPHEHJS9FmK8f6D4Wr0usb3fVKWTuiXVq13z5jFQX8C1y7QocZkYhBXd/+mxf5vQfhOPD0/Wo1mV5xkSyuIRdJhkDuKOLCwJJcduH8mtMND8pT4YXyTBfaSSv8tWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knFawx6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C5EC4CEF7;
	Fri, 26 Sep 2025 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894963;
	bh=ZJcOJe738J82333S+UWzutJXwsSL4xfYN0o3jB0o+No=;
	h=Date:From:To:Cc:Subject:From;
	b=knFawx6JlC6oKWFBQczvdB+7NTIR9wd2rPd4e77YiojIvr5AuH01tMiBJIHbgtkAS
	 or4F48suxfsl91+IojUPTa0JLpojmqhqb1Vf6G7+/U/oShhoxAqANhJENEe8StbUP0
	 HnGVnHswO4rMdfwWmfvPFc2uFzWyley7HUFda7M33KM8OSF3uiK7C7bwp2Bk7vb61s
	 QAolnbCLSAWxtXAzgLUhh3nyVuD2YGuKuQ2+sOpub6PYamZoLG7nhmq/kb9gCYsh4C
	 WsOO4wHnJ4YubWbpiFLIDGbNLSow/rgKJGAyTnbKmFb7XYtoniidUje08Vz4MBWuOG
	 9E+btCbrtmOmA==
Date: Fri, 26 Sep 2025 15:55:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <aNabbF7OMW396Ve_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-09-26

   # HEAD: a3a70caf7906708bf9bbc80018752a6b36543808 sched/deadline: Fix dl_server behaviour

Fix two dl_server regressions: a race that can end up
leaving the dl_server stuck, and a dl_server throttling
bug causing lag to fair tasks.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (2):
      sched/deadline: Fix dl_server getting stuck
      sched/deadline: Fix dl_server behaviour


 include/linux/sched.h   |  2 --
 kernel/sched/deadline.c | 35 +++--------------------------------
 kernel/sched/fair.c     |  7 +------
 kernel/sched/sched.h    | 37 +++++++++++++++++++++++++++++++------
 4 files changed, 35 insertions(+), 46 deletions(-)


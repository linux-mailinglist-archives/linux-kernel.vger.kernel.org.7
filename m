Return-Path: <linux-kernel+bounces-686586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C5AD9966
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912C61896E14
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB622EF5;
	Sat, 14 Jun 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBgcyh2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A162CA9;
	Sat, 14 Jun 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864228; cv=none; b=CsPprTRIsCXo/kwYE7a+XG4snKea7edoYwKsEI/WdIB19yWtzsNyZg1EtMWk5QlWnaTwjmJkWMN1Db9aBRYincOHsn/I0GcRUlKekanCI+hNJR6V14Crp7uG+48oUJb7ue9O6FGUhrn8ECE8DsVJ9lM7I+/d1X3f0XhHywcrC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864228; c=relaxed/simple;
	bh=VJqA88rDOceQM6yEHothInyxQRWfVg+uXlcQZBqQreE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs4xVkJpSHakP7RBscF+ZT9uK2HuTeFjS754fsxiNbnv2q8OnwxZ+U+TH0CCtRc1HWfEtbYfrfclNNXR0eVLWp6l+tTn1BkaCrHl8SojWO15TMjnH7mqiiQuzDl4cJoRTV5inw/TcroPLvzz6mKwa/nrEmAIXnKW9ydtYCMDHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBgcyh2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9BFC4CEE3;
	Sat, 14 Jun 2025 01:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864228;
	bh=VJqA88rDOceQM6yEHothInyxQRWfVg+uXlcQZBqQreE=;
	h=From:To:Cc:Subject:Date:From;
	b=BBgcyh2pULY3lrtRJLCgIFi9x6mMBVWoOLlljrRaz/P7uZ7UW3UQ40X9+X/shPiIo
	 4mEEj+fUJDvTQ52Nne4UcEtTzKG+TLV8bPXgotX2zcEoNGc8wxnbuvy4YUakvXkGMf
	 cvUc/eAaw4PToCr5CSfptAmWOMXw80X7pgPxhPKxGfwRcU8ukTlW6XkKhngeBhteiu
	 AvqMa5AU331YiYPbllIQfFi5S1rlY4MRxstqMS/k4eHdKc2fIgSygTiTDp0JYSB319
	 D0nGmWCKfQVGXBrQPnqTLdxpVVL7xUiit24pLtO8sW/m3kaHTuZVZS3ySdQ2EIN7Cd
	 UIqEDfjD8E+HA==
From: Tejun Heo <tj@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Subject: [PATCHSET tip/sched/core] sched/core: Reorganize bandwidth control interface handling
Date: Fri, 13 Jun 2025 15:23:26 -1000
Message-ID: <20250614012346.2358261-1-tj@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize cgroup bandwidth control interface handling in preparation of
sched_ext support.

- Implement tg_bandwidth() and tg_set_bandwidth() to centralize parameter
  reads and updates.

- Cleanly delineate time unit boundary - durations are in usecs from the
  interface files upto tg[_set]_bandwidth(). The fair functions that are
  called by tg[_set]_bandwidth() map them to nsecs.

This reorganization will allow sched_ext to plug into tg[_set]_bandwidth()
the same way it plugs into tg_weight(). No functional changes intended.

 0001-sched-fair-Move-max_cfs_quota_period-decl-and-defaul.patch
 0002-sched-core-Relocate-tg_get_cfs_-and-cpu_cfs_-_read_.patch
 0003-sched-core-Reorganize-cgroup-bandwidth-control-inter.patch
 0004-sched-core-Reorganize-cgroup-bandwidth-control-inter.patch

The patchset is on top of tip/sched/core (dabe1be4e84c ("sched/smp: Use the
SMP version of double_rq_clock_clear_update()")) and also available in the
following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git reorg-bandwidth-control

diffstat follows. Thanks.

 kernel/sched/core.c  |  311 ++++++++++++++++++++++++++++++++++++++++-------------------------------------
 kernel/sched/fair.c  |   15 ---
 kernel/sched/sched.h |   13 +++
 3 files changed, 178 insertions(+), 161 deletions(-)

--
tejun



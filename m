Return-Path: <linux-kernel+bounces-834589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F89BA5039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2872C320CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9123BD1F;
	Fri, 26 Sep 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7rSGjCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2183283142
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916629; cv=none; b=UObVTL8z0C/oBLSv+zl9zPldiCXffIjvgAh/LVTHnsrD651Mg8ieQbrlGIIpH7XcfAexfjKiscMcMlKGa7iYtaWPSIju4v8tmS/u30ZUlCNU5o9xCBDoKmI0S+cPtvRbtdc9YkLO3kZoa7QIKz8LC5sSsUkny1KUDqKvVzhbpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916629; c=relaxed/simple;
	bh=lHACcosUWPuIRG0D9BIsFVZk3ycIlyiMq2ZwwGgzksY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JxXJygyBY5NgEEf0nHcqcPNVg0yFt4RLrM+cc9xe0mzX3Q6DkYqH1Hyo911lIaYPctPhzG5xHarS5g4bJlBn4Q+E8vmSGeQqErZaimGGJkz1ri1lzysWpvUQzboRHr+pzwNd6ghWUaH+wi3VoP9nhxnXp01CYf5JtWJcWvVUEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7rSGjCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F715C4CEF7;
	Fri, 26 Sep 2025 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916628;
	bh=lHACcosUWPuIRG0D9BIsFVZk3ycIlyiMq2ZwwGgzksY=;
	h=Date:From:To:Cc:Subject:From;
	b=b7rSGjCiIru44Zmh3UBq0lUgKkygjhk7K4Te/dKimpuyO8p/od+aZaWYVrAV5lGk5
	 yVjDjwlvBLuy8131WF6q/PO5H5uUWcQLlA31jCTQAWQ6yMGopHMLRKxKRWB7UWjJp5
	 KgUkd2TMapwJod9kxSG0cwMf1C7BcRlrel7KPpCA+SwM74qWhM7mwplw8VUXVKN6/v
	 rjhVrc2rGZM6YBZb1klvUv47F6W+prcYbbRKwVMjLefM7R02000gsEBlGYJy6XNjSa
	 n5uXok2J1oetEwLWyox8uDEYOmB2qLGbVM9cTFbeGZetGoYUPAUrDRfQot2DjOx0wM
	 zBbSqmlMR1HDg==
Date: Fri, 26 Sep 2025 09:57:07 -1000
Message-ID: <50b697d50818b0c9d0abba3f1feaa2d2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b19a97d57c15643494ac8bfaaa35e3ee472d41da:

  Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-08-19 10:12:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-6.18

for you to fetch changes up to 0950c64ae38661bd97127e9aa0522f1624f82006:

  workqueue: fix texinfodocs warning for WQ_* flags reference (2025-09-22 05:37:20 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.18

- WQ_PERCPU was added to remaining alloc_workqueue() users and system_wq
  usage was replaced with system_percpu_wq and system_unbound_wq with
  system_dfl_wq. These are equivalent conversions with no functional changes,
  preparing for switching default to unbound workqueues from percpu.

- A handshake mechanism was added for canceling BH workers to avoid live
  lock scenarios under PREEMPT_RT.

- Unnecessary rcu_read_lock/unlock() calls were dropped in
  wq_watchdog_timer_fn() and workqueue_congested().

- Documentation was fixed to resolve texinfodocs warnings.

----------------------------------------------------------------
Kriish Sharma (1):
      workqueue: fix texinfodocs warning for WQ_* flags reference

Marco Crivellari (3):
      workqueue: replace use of system_unbound_wq with system_dfl_wq
      workqueue: replace use of system_wq with system_percpu_wq
      workqueue: WQ_PERCPU added to alloc_workqueue users

Sebastian Andrzej Siewior (1):
      workqueue: Provide a handshake for canceling BH workers

Zqiang (2):
      workqueue: Remove redundant rcu_read_lock/unlock() in workqueue_congested()
      workqueue: Remove rcu_read_lock/unlock() in wq_watchdog_timer_fn()

 include/linux/workqueue.h | 32 +++++++++----------
 kernel/workqueue.c        | 80 +++++++++++++++++++++++++++++++----------------
 2 files changed, 69 insertions(+), 43 deletions(-)


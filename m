Return-Path: <linux-kernel+bounces-751402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63EB1692A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C971AA41CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5F231852;
	Wed, 30 Jul 2025 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LScQz0Ig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EC1F8BA6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916198; cv=none; b=eBIBYXfB3V1pXaUNE8YoLgZ95ORzReXUxCP3fvNUiIsnuFT7uLxL6f1yFUhw3afiamdUsB2ONYUew/DEBqJhViGh2SLy5nWjeYXuNeAJ+j2Y+2RCepN1wqFqcf/jurKm9JAiusC1z5bFHqRcaXIfX0AIwVIUyEzLer79p+SpPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916198; c=relaxed/simple;
	bh=J5y2323sa7souGXfUB6aT0cJsEkW9go4MOfWRq0bSyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OZusnLQGPaZ4wiyFz0VkDGRm5rIm35YgMXKZEyijXYa9azk3LsUnJk1t6P7j8s8AQfru1hAZhjLc4TlyFRdFM+w3uNY+uaJfTR1X1E1f8+8Umr/vGWrcVcwHUiZ7GdB1adQHy4Kk5JB3QCjTqriMklhhoGLUYG16YIlqfNEJDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LScQz0Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F2FC4CEE3;
	Wed, 30 Jul 2025 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916198;
	bh=J5y2323sa7souGXfUB6aT0cJsEkW9go4MOfWRq0bSyg=;
	h=Date:From:To:Cc:Subject:From;
	b=LScQz0Ig9380Dya3jixG+u0x3U1twAWXXaBfg/LRhgqLJcw9OSv6mpEsmzXj11ybC
	 YHaRYoojj+w9Ysd9XiWCECbwIlzKQsfBYF7rYcs9e+vj8IfPWtOP89BuwYjplwOq77
	 iPsSNZN3UDZgb8UwJPLEwwPBqhCBC3ma4/dCpfCxo12QkzQCQupOK5QKzYXHOp5Kf7
	 yoyQp2YSFarbtJgWGCEtQnsdibSi1JBS2x8j75em3go0r9Mg0DfhB4/awHnAlRJSnF
	 gbrMk6nIis9tZ4j0Ca4PWNixGuAND7pkwrUfKc5VOIfXRBFOjiRzgqjF/ydsZbA/k1
	 CCvzmzbTHTGnQ==
Date: Wed, 30 Jul 2025 12:56:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue: Changes for v6.17
Message-ID: <aIqjJFLe9V4w2zLd@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.17

for you to fetch changes up to df316ab3d4440177e322a2847969d356c29b0eef:

  workqueue: Use atomic_try_cmpxchg_relaxed() in tryinc_node_nr_active() (2025-07-17 08:14:50 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.17

- Prepare for defaulting to unbound workqueue. A separate branch was created
  to ease pulling in from other trees but none of the conversions have
  landed yet.

- Memory allocation profiling support added.

- Misc changes.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      workqueue: Remove unused work_on_cpu_safe

Kent Overstreet (1):
      workqueue: Basic memory allocation profiling support

Marco Crivellari (2):
      workqueue: Add system_percpu_wq and system_dfl_wq
      workqueue: Add new WQ_PERCPU flag

Tejun Heo (1):
      Merge branch 'WQ_PERCPU' into for-6.17

Uros Bizjak (1):
      workqueue: Use atomic_try_cmpxchg_relaxed() in tryinc_node_nr_active()

Yury Norov [NVIDIA] (1):
      workqueue: fix opencoded cpumask_next_and_wrap() in wq_select_unbound_cpu()

 Documentation/core-api/workqueue.rst |  6 +++
 include/linux/workqueue.h            | 34 +++++++----------
 kernel/workqueue.c                   | 74 ++++++++++++------------------------
 3 files changed, 44 insertions(+), 70 deletions(-)

-- 
tejun


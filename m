Return-Path: <linux-kernel+bounces-838184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB1BAEA08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329BB7A27FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9AF29CB52;
	Tue, 30 Sep 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeK2b6Fm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBE81AA8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268718; cv=none; b=nRSJUKVJ+CdGe6Ez6VXOoRa71CUvVQXPSn1vbkh+7gMQI7x7cmW1YrYWW1rUpz+oPA7K+nhfkCxA4X3EgDpUXdihunGu6Rn4K7Fd3LmVbeC6TacEFYWoHEVBMNNJUfb45UJxqbtTbqnhOpGbLplqjY/Wrj3rUshzyQam4ZxYtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268718; c=relaxed/simple;
	bh=0CQ3wY+/BUb8p/7GjSwwBebiIJHWRwNNLJrGlsGtYHM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=PkBbzga5YlTIbx5R0Xk6tafag7WpR32VkQyf61KuwOmGLA/l/xJm9Isz9ElBL+/g+1fPKodQAE6cHi2ODkgdMTcKt2La12vc5iGNB23bPY3lvSFe5q7ouTCtVcIZerj1weEnYtY9VS/R1CP/1cuVyFYRCBMULhpxTB7mzIfmgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeK2b6Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16F7C113CF;
	Tue, 30 Sep 2025 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268717;
	bh=0CQ3wY+/BUb8p/7GjSwwBebiIJHWRwNNLJrGlsGtYHM=;
	h=Date:From:To:Cc:Subject:From;
	b=UeK2b6FmPKhC3f/hh8Z4me/jKvDN8zQQJEyiKnmMSG3CiuLTOcOX7kB2w8NjCUOFM
	 r2bfl+eiVVWs0gqIC4ZAAQROQjqlv+cu8Po0P3ZPL9Dx6ulJjpe27kebqyjX14CTF8
	 ZO+jz1QhyulwWHURHGchN7um7cLUxhr8vtqum3urvXZ1b9J46KwvdyocbwKfe0zN5N
	 VIMBa7pRqTlBxBg/km70sO8oR4RfD88XMNeXFnb4M6WxWhugEi4LfZc2zg7QGLI23X
	 YScHubxfzTZrqhR+NbCohe8R/MMC2BBJAMPPHqfNBGf08BY8Tx02wIbBlvBL0A9r/S
	 OW/MZ13I804wg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBS-0000000DUtb-0zjU;
	Tue, 30 Sep 2025 17:46:54 -0400
Message-ID: <20250930214630.332381812@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:30 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/7] tools/rtla: Updates for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 05b7e10687c69e0c28e62b9a74ce78b3e7463806


Costa Shulyupin (1):
      tools/rtla: Consolidate common parameters into shared structure

Crystal Wood (6):
      tools/rtla: Move top/hist params into common struct
      tools/rtla: Create common_apply_config()
      tools/rtla: Consolidate code between osnoise/timerlat and hist/top
      tools/rtla: Fix -A option name in test comment
      tools/rtla: Add test engine support for unexpected output
      tools/rtla: Add remaining support for osnoise actions

----
 Documentation/tools/rtla/common_options.rst        |  61 ++
 .../tools/rtla/common_osnoise_options.rst          |   8 +
 .../tools/rtla/common_timerlat_options.rst         |  74 +--
 Documentation/tools/rtla/rtla-hwnoise.rst          |   2 +
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |   2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst      |   2 +
 Documentation/tools/rtla/rtla-timerlat-hist.rst    |   2 +
 Documentation/tools/rtla/rtla-timerlat-top.rst     |   2 +
 tools/tracing/rtla/src/Build                       |   1 +
 tools/tracing/rtla/src/actions.c                   |   8 +-
 tools/tracing/rtla/src/actions.h                   |   2 +-
 tools/tracing/rtla/src/common.c                    | 344 +++++++++++
 tools/tracing/rtla/src/common.h                    | 154 +++++
 tools/tracing/rtla/src/osnoise.c                   | 101 ++--
 tools/tracing/rtla/src/osnoise.h                   | 114 +---
 tools/tracing/rtla/src/osnoise_hist.c              | 369 +++++-------
 tools/tracing/rtla/src/osnoise_top.c               | 303 +++-------
 tools/tracing/rtla/src/timerlat.c                  | 210 +++++--
 tools/tracing/rtla/src/timerlat.h                  |  55 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  22 +-
 tools/tracing/rtla/src/timerlat_hist.c             | 642 ++++++---------------
 tools/tracing/rtla/src/timerlat_top.c              | 568 ++++--------------
 tools/tracing/rtla/src/trace.h                     |   3 -
 tools/tracing/rtla/tests/engine.sh                 |  26 +-
 tools/tracing/rtla/tests/osnoise.t                 |  27 +-
 tools/tracing/rtla/tests/timerlat.t                |   4 +-
 26 files changed, 1395 insertions(+), 1711 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c
 create mode 100644 tools/tracing/rtla/src/common.h


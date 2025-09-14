Return-Path: <linux-kernel+bounces-815500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D30B56763
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD74189BA83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF621019C;
	Sun, 14 Sep 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuP6TF+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE71CD1E4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757842471; cv=none; b=FG3VxeBJ9uo9iNyUcXWb8ysi3BphWMKYcNW/+/TJgQZVF/oWwZFle01qWUSxIW5Fse9PRBwoYfwTxz6wqWcERdLUNZPPBrlnKfbrImK8YCFI7bIJoS35kY2fmxA9syh94Vj/iSLJXCGIvkpQ3Q/XXz4A5TsmR+tdgRNFmzQIVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757842471; c=relaxed/simple;
	bh=fJ2XgApONWYz4U6scba6WLscrcJ+qDJlpSqwobNE5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YwBIrJ+h9O/6kgk7vnBK77fB3mppiExgg0BRFlb/mCZRnGQUpiro3j+Er7yvn4SGzuOtJPeoPV00sDuzpeXk+Ql7aF6m5VhbNjonFVbzS+VRekx4GNavUFOBF979iEhjq5Cu7t6y3ntWwwG9l5/qnhO9CnRZhlrrHfaZHjBBIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuP6TF+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075D8C4CEF0;
	Sun, 14 Sep 2025 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757842471;
	bh=fJ2XgApONWYz4U6scba6WLscrcJ+qDJlpSqwobNE5TQ=;
	h=Date:From:To:Cc:Subject:From;
	b=XuP6TF+Lnm6UBbsnVlzD+I6RAXSHfmbs40lXrSsZvot1vwMsA5EHO911pu0nUiL+q
	 DgZzhMbDICiQBQgGlHTl4vYS+sd0jJBEmk2Dh9gy8WEQORES5o2OnB3wauxBDHpQ/u
	 +jh/GQ4nfyfqzjVLTeWEq4sEDuH9z0Kry77JpyWsWNUYHMGajfFN2ajBl3KRlEzkPB
	 zJWjYV+ZkJhjbZguAl/PGBdt8K0+pG+3jD3vbQY7T0tIS+FDLPo3kCWYKD7YYNuIhy
	 mOH2yCmug2mA4QPXj1g/brIW1KtEtaIblW0eVr1u7LPhjWy+Ex2LXsvAKq3ydllQJF
	 wMTPp7iCcQb1A==
Date: Sun, 14 Sep 2025 11:34:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timer subsystem fix
Message-ID: <aMaMIUc95ZNXEtbN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-14

   # HEAD: e895f8e29119c8c966ea794af9e9100b10becb88 hrtimers: Unconditionally update target CPU base after offline timer migration

Fix a lost-timeout CPU hotplug bug in the hrtimer code, which
can trigger with certain hardware configs and regular HZ.

 Thanks,

	Ingo

------------------>
Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline timer migration


 kernel/time/hrtimer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)


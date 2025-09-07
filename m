Return-Path: <linux-kernel+bounces-804719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A9B47C0A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052801784B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280127FD40;
	Sun,  7 Sep 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9w/FTZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1925A331
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259131; cv=none; b=KQCihLXSKRqnxqzIv+a+Jr2jsHiUK7JVPvYgyM5uHjN0EtVy8H3yol/3cOLbNoLw5A/5BdL3Oyp1fpIaJ9D2IG+7uzFUAVXUxz8w0nVPfTC3AQkNKqUXpxPmNRPW9fuzsQZYjeWyZlaBpQv3YW4+3VWy3lEqvSJuPA+E3tuBp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259131; c=relaxed/simple;
	bh=b2ag+q5FEP7AKxW51T+P+cgwmPygSZIDFfP88xqPCGY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dR05k3mKvnYbeZ4Sqtl6zmBcWHiGQHNiEqrWthVuOY0K5+Up+5pn88J39MBYhsCskTwBrjjXG1bJFxAnnq2aEdz/A6/k5OKdvW8YiU4GQNTyZpB0ENz/RUffZbdnp0Wd8LSo1A46S4lIpfTDzp/Rjx1sKYLUt04BQNWmQvPFJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9w/FTZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C0C4CEF0;
	Sun,  7 Sep 2025 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259131;
	bh=b2ag+q5FEP7AKxW51T+P+cgwmPygSZIDFfP88xqPCGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K9w/FTZo4TsKmONxOLJJ2tvJRA3bCCvQj0jvUf6uxGAiSROVkCtkg/VEAWP/GRgUj
	 aw81CqUELxXRTFspmv+WfSeZsF2EHQ8LcHvmD/c9oaED7+4W92E28C3ITNAAAbEY0+
	 TTevBOQeDKFj6N2mhYBl2ETnWCmXUj+jofDgmO5rm7EWxVS0/JSyVYRcwL76zKIgLt
	 F+BUmHGLWRFNbbZVgxPm8QUbPAey97/0SBiMoQPzN/Un5fKHAuLoLl6962z9DcbkTv
	 EITgXzeG3gUpcKZ39TUuXiPC9QAEWXEthivP0ZBtt0L+ddBVtUDHgeQIshkxeCMHEc
	 iGlMKeYLhQ0eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAD383BF69;
	Sun,  7 Sep 2025 15:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <053b276c-b22b-f3e7-6c11-abe61b8ee36b@kernel.org>
References: <053b276c-b22b-f3e7-6c11-abe61b8ee36b@kernel.org>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <053b276c-b22b-f3e7-6c11-abe61b8ee36b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.17-rc5
X-PR-Tracked-Commit-Id: a03ee11b8f850bd008226c6d392da24163dfb56e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00e69828220782cae5df67d1546d4969770c9753
Message-Id: <175725913509.3081192.6395265560508974365.pr-tracker-bot@kernel.org>
Date: Sun, 07 Sep 2025 15:32:15 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Sep 2025 16:16:30 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00e69828220782cae5df67d1546d4969770c9753

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-kernel+bounces-821817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA788B825CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9976A4609B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC828DF58;
	Thu, 18 Sep 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxyOFzYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397978F26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154702; cv=none; b=IiEbAzg1QG19t7zeW1RU4ww/s7c8M5gtW48AZC0M8jxB4RYIBzApGMUhPnrO2SfVFr57jrL3Por+oOOaEPkxvMYdpzhvL0coDphDcsdyLEOaFwq7qpxN6yQF34RiJInABzDcDPVCnJ5toJucyqIYOSWlDCWhif2xf3mp1XdpDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154702; c=relaxed/simple;
	bh=HJeHxvJ5os1bKgu/wmnW6eCYRB1USR4o2DaZhGqKWtU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AWFxjxwFAE5bd7/RvNVRDdNpn4lVs/bxrERihQNM4FTeK5PZGHZ8BoG6sHq6hu9R0VVdSqCqfFaiaq9BTm0jQPVN65a+uIyC8sR5UA7/1w13ZQ/slMlf7LWsuiC4EpTjU9GEgloyL363mQpHSSCo4Y+evapqGaBIuzA1vr7JA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxyOFzYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6975C4CEE7;
	Thu, 18 Sep 2025 00:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758154700;
	bh=HJeHxvJ5os1bKgu/wmnW6eCYRB1USR4o2DaZhGqKWtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WxyOFzYy1NVSSHhHkYJHC7SXkLCsG7Wgxl9+vL07j8aJLH92dvJiHQ6NX2B207T8F
	 fWJHb9NcHrNtKGTdTwu3a4iIAArJQq3hrOdwpSDGmLZJo/tfOSAVBMu42jLHhExRDC
	 pmALorSp2NVh1sGb/N1dIsqZo+ueVht3VgmID6uIC7ylTXXm48UVDrwT4V2iJSPAv5
	 sBGDaum44Ms1g32+vuoTAltMtgeckxQJT81Hcm1skJE2G6zz7zuoZ5p4CxQRL0096f
	 hHyd0e1KvK1U8W7SbhsgLoA0v4Jhcu2oXERdKIIadyguxYOoTE8B6mT8KNhL/BbFqM
	 sEXBwcQx9VmcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710EE39D0C28;
	Thu, 18 Sep 2025 00:18:22 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250918074652.b9d4842fb41b5bd810b1add7@kernel.org>
References: <20250918074652.b9d4842fb41b5bd810b1add7@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250918074652.b9d4842fb41b5bd810b1add7@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc6
X-PR-Tracked-Commit-Id: dc3382fffdec2c1d6df5836c88fa37b39cd8651e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 992d4e481e958c6898fe750afd429d1b585fff93
Message-Id: <175815470104.2197318.2065869104165887703.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 00:18:21 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wang Liang <wangliang74@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Sep 2025 07:46:52 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/992d4e481e958c6898fe750afd429d1b585fff93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


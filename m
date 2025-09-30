Return-Path: <linux-kernel+bounces-838003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55CBAE34D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5361945D59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F426A1AB;
	Tue, 30 Sep 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snda2Lap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8392116E0;
	Tue, 30 Sep 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253732; cv=none; b=T/GFSuER98Xj46c+SwqURVWeohaVANek/TExpSr7e2QOgsx2nsbSIKpaOKL6Dsyjm/8NsgmuUTUB6VEpHrjE2Y9RoE5yuwyJPyHOUHwAZH37Vol4IKEpUz5kM3G35Odq4Lxre2M/Wb9gYM5U7sth60Yr7mN2Vg4vJkytGNy4utE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253732; c=relaxed/simple;
	bh=shspb6feN4oL6+mL2LznfwgTvxUVbTY7ORlWh0UB+3I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mwTvPWWhb9Iy0++hm0A+yV56S1MoZG3ikJPi1KcZMWWwpHxiYx8Vc4De1d81sKMMMNTrKuWc/Bv0pwyDt3R61zwQpS/IlhI5qS9/BKTogSmsO0halWCf7Zg1qAEML1QoM1DhCn11UZWPJawjuzcNktlKXVuhaBRDf9GNozI8YFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snda2Lap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A417C4CEF0;
	Tue, 30 Sep 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253732;
	bh=shspb6feN4oL6+mL2LznfwgTvxUVbTY7ORlWh0UB+3I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=snda2Lap+qmPUBp5Pz1d81eCjPiRXJI19mxt0ENLlPcUdxYOmQbH1Ytj3JD/BX0o7
	 TsrNUSUS9tlKz3Jq7JMgF0tiytRmx1HvXmACkAXKULH5FEWWhnv3dB9Mt4augJMhs2
	 zU/saXcQQuACy6IP3GcBp7Zdvv/w8e+EhlHGwXi9nLR44RpVR7SfrNy8N3QPiT7/qy
	 PcRNMICp/xMDazmlLBAp+fYj8xBeL1g6OS58RpgMVhVU6Tl8I5zc6rSHllXxBrj27O
	 XCNe4SvWzP2inG9CqU4/iNu6oFnK1BshWmIBhx+PpxcYAxbhDJGJOMuC0NH8FHhEq7
	 lNUoWNeGCSsNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09039D0C1A;
	Tue, 30 Sep 2025 17:35:26 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <41d26de7756d571845b9feb04a4e8e9d@kernel.org>
References: <41d26de7756d571845b9feb04a4e8e9d@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <41d26de7756d571845b9feb04a4e8e9d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18
X-PR-Tracked-Commit-Id: df10932ad740ba1f871b6dd2ddafc7dc8cea944f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a23cd25baed2316e50597f8b67192bdc904f955b
Message-Id: <175925372532.2087146.10140585146071359446.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:25 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 09:40:26 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a23cd25baed2316e50597f8b67192bdc904f955b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


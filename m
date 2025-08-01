Return-Path: <linux-kernel+bounces-753846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84721B188DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F86586750
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65F28FFDE;
	Fri,  1 Aug 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxGtnXwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC228FFC2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084231; cv=none; b=tQHT5AZGir9Bg1bnZA4ABHqYfgzbw3rk9z8f7x67FCTuochnZ5YLADuhadEixcz8w1dZu782CCMCPHjSvxwC0yzdStlM0ZdkVEW0nsMZYjyZ6/xkaOgUDeKTi8rkf0mx5u+Z/QxY5sqideqYkUPPmTQ2+BYDbtTfL/zGPkKZLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084231; c=relaxed/simple;
	bh=zaSp9gfraYaWLzijMMeXi0kSAeTA1mQBsourcqNo4oo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JqyxJln/z3OLFMc1X9YXA3ulb3xhCeDsDXnyDTjo0q95seASCKNKqFVAW3TGrwFH7Bpt5s5if73AmwVzVRFf8c0VBwHwMuQyH6+7n05s8I8VXhYjglIhgnx4l9lou4H7JywD5nf80fsDAkOUKFva65yspvjOaXcN1dApkrdC7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxGtnXwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6394BC4CEF4;
	Fri,  1 Aug 2025 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084231;
	bh=zaSp9gfraYaWLzijMMeXi0kSAeTA1mQBsourcqNo4oo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uxGtnXwVZ2i0PblCmZVxxK1bNyDMUHTIaS7KVx9jyEy+rRlMc99XoAVbQMiwoR+lb
	 Becy5F52AI06nPULGHxYvhS9UtZGp2824cs9BgguSUhj4JdWMGg/tiRDQDziB6LQmU
	 a0tJel7Ob8itYjv4pDIRdvf+dwl34Edk/Ju5Amajnj9SluJjvj5E/mNG9EHqf86ABD
	 3DiDqVyI6OYufVqc04SnR63BvJWS+ERKz1WvyHzJTXWBj7f1/9WKOKQA4YluzJqoWI
	 toyC16ZofqJQ86JkYo0qgUdWuQ5EjmLSg+mbjxzsP3UCCu6zy7PCEr+H5FsnDh+xNT
	 Gm/3EKY9fIP0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE67383BF56;
	Fri,  1 Aug 2025 21:37:27 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine subsystem updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIy2AkFvYfbQ2WTD@vaman>
References: <aIy2AkFvYfbQ2WTD@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIy2AkFvYfbQ2WTD@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.17-rc1
X-PR-Tracked-Commit-Id: e3a9ccd21897a59d02cf2b7a95297086249306d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 196dacf4541afcbccbef9c3697231af354bbab13
Message-Id: <175408424640.4088284.5507252705288745964.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 21:37:26 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 18:11:38 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/196dacf4541afcbccbef9c3697231af354bbab13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


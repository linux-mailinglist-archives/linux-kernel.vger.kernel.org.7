Return-Path: <linux-kernel+bounces-753843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD6B188D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC3F16B124
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04C28CF6D;
	Fri,  1 Aug 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKjxtpt3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C420F076
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084225; cv=none; b=Ail8j1OEiF6EQTPwo58sbMWNgh5yxMnsYdc7DuWjkCVmtt797HhX7ZPMPU2AYrbUWhqgNUkj9Wl967MQdL/4wZZD2Wiuc2/tDPCNC+o1ypz8a5PuTF1U3v+Sajxijkgj419BoLhrvuXOEh9Jdu7KyANr3py6Dw7Mq8Kgj5l+MGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084225; c=relaxed/simple;
	bh=tvNR9WuzUsYgh3BrjbQivBMy5nrsSxmL+ZfibhZR7tk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MYZSjg27p/PJwEkpkXMjKE6AYXGCY0aGNU8cqAGDF/XdgiPhipKww6+HeM3MbkDsQ+8Kco9budm5qkNUQifuQ4tuKLJiux+FCBGA7L3LbhwQbKCZrxdNGFd638kX+n8Z02j4yGEBNOFDkH3uTs09VCDBV46oj60i2tnbcfo5iX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKjxtpt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E299CC4CEE7;
	Fri,  1 Aug 2025 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084224;
	bh=tvNR9WuzUsYgh3BrjbQivBMy5nrsSxmL+ZfibhZR7tk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GKjxtpt3rR33iwblzhb4HMZ35o4uj09XKDS3jtALeX/uH02s+LRdzXj0NlCJzitqh
	 q+qsPWFy+jjHU/Y/qzKqOJo2DTg/Fl/00GqieTozq/y4G+C/lxD+5mXpdpYf5Q2Q9R
	 bFO9lgbluQoGV74DCj4ZVSF3mDDl9HO9fnTxbxZC97IBeAzXDZ7K0bBpzfa+DfIU0m
	 nGIxYu9lDoBW+L2n4ixJsWEBoFqLZdyHUp28UOchhymJ8/Ya2ircMkXG1on3sgXPco
	 Myu/NPk51HVnrXK7myXqiaxpJ14nKoaygYi3RQDs3ORJhtGRK9qLbW7UJVKYmx3Wfx
	 be6/ZAekWSIVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715D3383BF56;
	Fri,  1 Aug 2025 21:37:21 +0000 (UTC)
Subject: Re: [GIT PULL]: SoundWire subsystem updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIy0LYXrdYiQCMWZ@vaman>
References: <aIy0LYXrdYiQCMWZ@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIy0LYXrdYiQCMWZ@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.17-rc1
X-PR-Tracked-Commit-Id: 34b1cb4ec286603127aa8c4191ea527eb8dd3567
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fac1139d99e283ba0c7ed2d1acad9ec2807ba3a
Message-Id: <175408424003.4088284.15513233071371253513.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 21:37:20 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 18:03:49 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fac1139d99e283ba0c7ed2d1acad9ec2807ba3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


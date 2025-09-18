Return-Path: <linux-kernel+bounces-823759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4BBB87634
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EFC7AC5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179F5CDF1;
	Thu, 18 Sep 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXjm89vv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFF34BA4E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238341; cv=none; b=GmA8/3XNbwgZcxh2J7JO8ZAhhvqb5UX3BQ4Tkd1MqQPzZBiQrj6TXGD3Qu+xdBEFG3lusDShIAFp8x0Tn04viablqsODfbtHT2jg3MyiARFK8rLZ9qq1kzTfN5WDzmE46aZJWtDPpznES/EzM7iBq3RvOrn2ZjE1H9bvk0uGVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238341; c=relaxed/simple;
	bh=OarGxGrcZxMdiLbEY6Ikye84NCK9MC9GByr/xcKP+GE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OqqMfQVeWI/DQXRXAoM9lOtOq2TK4WQAnqTNOVPnImOhcfZ5FSSB8hZcFYKqbzNHRGGbFBXYpKiji/jfqG1eFdewZ2kIwaV4iGp3psfumAMC6Bgvs+wK/iLEAT1OCTXh7XFOPVnO9Qeekz47jbwqHafAbjl3jko9eTfnSfgEQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXjm89vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B77C4CEEB;
	Thu, 18 Sep 2025 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758238340;
	bh=OarGxGrcZxMdiLbEY6Ikye84NCK9MC9GByr/xcKP+GE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lXjm89vvqXWOOXuu2M9a2xogshJCPAx+JxE/hxPNLtI7dCGswtxpKjKc+vjc4+Yye
	 vXMRS5Nd8DHcAsUfugpLhxJyBOiiPH9peZLhkLvcPkpazS/ngIMPM/Wmvf2I1N2Wkl
	 FpU79GIcaoYualwsg4kFrU6GN0TbMTEZRHCjc2F8I/ZDsJmMvG9/LJvTlYYJ1SGoa6
	 zwT6nyv2nrrRkvIM345/yscCnnxyngFa8nxozPhfalwyX87b7WCi8L/qovbWjmoA2h
	 9VZvsYm04CmziA0IcumtczIUVK3WBfKe+3Ie4ozrUGgpx4zwzymDAhYxqB9xCLdzIv
	 VtXVL9izUkccw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F9D39D0C20;
	Thu, 18 Sep 2025 23:32:21 +0000 (UTC)
Subject: Re: [GIT PULL] rv: Fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250918163551.3e4254ef@batman.local.home>
References: <20250918163551.3e4254ef@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250918163551.3e4254ef@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rv-v6.17-rc5
X-PR-Tracked-Commit-Id: ef442fc5c1a9a2a232de85a0e6967f388b6c0c8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 097a6c336d0080725c626fda118ecfec448acd0f
Message-Id: <175823833984.2988291.2863219765221200013.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 23:32:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Nam Cao <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Zhen Ni <zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Sep 2025 16:35:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rv-v6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/097a6c336d0080725c626fda118ecfec448acd0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


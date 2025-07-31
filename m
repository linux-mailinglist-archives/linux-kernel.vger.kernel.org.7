Return-Path: <linux-kernel+bounces-752461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C829B175D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E61C23AED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9323E329;
	Thu, 31 Jul 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf2kAZvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A48101EE;
	Thu, 31 Jul 2025 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984453; cv=none; b=VivKbFFlt1nu2dbIWzQtw/EFw5jQYvIF8jv7fiOwDNQ0Bh5hzw5MDUsk4s2Cl18hWtrj6BH1E6P+n9N5ahtqIFK5hvL/i0xvEVZuPGlg58EeLXSeMDrAhLFZO3OCs6WqHQOOTwUfJc5k5BU8Zo74gMSF71hT5gmOEEKlKqoISMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984453; c=relaxed/simple;
	bh=UZKcBAnLaeHD25NAhy96vn6yI+qVa5vhM4w9y//tGVE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PALUohsZQeBWWdZESooe0jrLlgsc4RDscbVqB2ZhtBn/+0ZxSN3EotbY686gFB8YTKnhjwqM9vY7MniBZbvS/jxjDmAq66IMK56cWfnPlpZytMXfm8GYUTPVl5WioA8jnQCu0QcTDCQjDEzg2d3pZfCmSdYAIc3mtZXOwNYW3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf2kAZvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C14C4CEEF;
	Thu, 31 Jul 2025 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984453;
	bh=UZKcBAnLaeHD25NAhy96vn6yI+qVa5vhM4w9y//tGVE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lf2kAZvlDpXEWNqz0O06DMPqQoqfp1b0G4gWuJiKZA0AwS5ehgGC8SAp3lXhn4H9u
	 gUfzqgyWEgpg3KWxQ82GDdKTj9Wkb9G6F+yvfJO5+OFCexRpKrKVKC9L+FNaCs7a/Y
	 HO0K3i4lpjgDsd+sclc8RMOg/Jv87t38JkLrGIjwzI9k/3HOwbagFIgCYE2eDO/rGY
	 ko/cmpEdJFOQVkgHdMzHRE2Lyu6cnwT0Jvm8H/55BZTn0ab0Ks3rSzxgn6iwc9d1XX
	 v6g3T6sFnnFcFJVrqFtw0WVUHEB0+oh1N7mkO47tLwgAnbh1oF7Jpbdu0bwfhEizUi
	 +18rb4NJXH8+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F10383BF51;
	Thu, 31 Jul 2025 17:54:30 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y0s81lqe.fsf@trenco.lwn.net>
References: <87y0s81lqe.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y0s81lqe.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.17
X-PR-Tracked-Commit-Id: 35293ebbb65e0295d3b9357f786004ae1026d00f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1cce98493a095925fb51be045ccf6e08edb4aa0
Message-Id: <175398446905.3232013.15385006637476439920.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:29 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 07:35:53 -0600:

> git://git.lwn.net/linux.git tags/docs-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1cce98493a095925fb51be045ccf6e08edb4aa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


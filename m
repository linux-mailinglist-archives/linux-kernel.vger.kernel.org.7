Return-Path: <linux-kernel+bounces-753845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D6B188DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E990B7B4FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A828FA9E;
	Fri,  1 Aug 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn0DFbXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093528F957
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084229; cv=none; b=Umd1sBrc14TYhN/4XRLi4R6Twecy5vyqdVUbGidUbRfRZ8+1hwuS9u+443GoF+O4LKczF7nu1ik8KHVZSg7/YdrVcwDV0n99HoqXkAtRVHz/0CH+8hNtjHMcz53T9uIgsszYuWCJiUzTUGJl7hsl5j1T8pjlk7DblUqUkF8gzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084229; c=relaxed/simple;
	bh=kNr8lA9NMdTm0qwHrraosiVfhpGuwn+rhDfsH4UITc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lG5w+hgOg2BVet6asj4SD90qnlNMrcVH/REmiVw3b1vUkJ0vYJuf9rSVWkKNjPiUU2J13F518chXmM6KbAB0BfYRUKdDW9R0R1ms1tb7wZynE/JyppiEhuLWvVgQ4M1evhTmIwxfe0XM0JlHQd/s7og8wRJi3ZizeVLcsD/C1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn0DFbXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302DCC4CEE7;
	Fri,  1 Aug 2025 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084229;
	bh=kNr8lA9NMdTm0qwHrraosiVfhpGuwn+rhDfsH4UITc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cn0DFbXNcnooT7d0NYtocZcj/CivVJMM0Ao61MvQodNVG/PMLXSFH0YT8+pZO2FWo
	 gIlbAiLrTJDBtcMLWqwI23TKrUNJCxUwMqscGyb58Z1tZkdjQPdidKbSL3oX0njs27
	 3l/8Ggr+aXfilw2Mkb+XPkWQDlre6IJaZ4PwnNXs9ZNWJSZaJxp5iCWwNbetXFrlsY
	 YmWKqj1ELOK5KKzotbJn1s1T1yFl278Ojm9AY4XjPlLMjUq3y10iXUjvy+Pz0oEwnt
	 wEhqbNcUnBfq28oSzWoJeWbf9mFhmN0hA7ClFASHaltRsfBDoWTVgq+jG76B3JB8bz
	 hsvdAiyaF7TcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4F383BF56;
	Fri,  1 Aug 2025 21:37:25 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIy03oxm1sfGZMDn@vaman>
References: <aIy03oxm1sfGZMDn@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIy03oxm1sfGZMDn@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.17
X-PR-Tracked-Commit-Id: 4a3556b81b99f0c8c0358f7cc6801a62b4538fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8582976acc8504cec53a7b6fed493435eba8437f
Message-Id: <175408424437.4088284.10685822949520530584.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 21:37:24 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 18:06:46 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8582976acc8504cec53a7b6fed493435eba8437f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


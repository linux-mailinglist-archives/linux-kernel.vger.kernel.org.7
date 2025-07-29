Return-Path: <linux-kernel+bounces-748998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEADB148B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8302544D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044D274B5E;
	Tue, 29 Jul 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JypNeqk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F72741B3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771811; cv=none; b=BahRIQglGj6pwc0+M4bOkd9BskXrk6WMVhS2JgxQFSDb6ctFN2ijjcJqybzda97uOZt6ks/CIh3Wp4IF0BAGlSC2Yf3/gNEfO1QZ/z1ltELncQ95qpNZFX8oQxAKgBAOXpxGO9JdCdvB8uhK9TnSNfLAYWKlNXluicBfXvbbhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771811; c=relaxed/simple;
	bh=PukLlaF7nU5pa2sC5xyWZPLJdxHHWUYKVi4YezAqKiY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kMcfDYkbrAgNBwg3J97vlYwmwRiE9AK0dKZAcz+Vp9kd5TlUt9w4fKvB2hQKzZRyAnek1xvBkglPNgx+wAI3KkaAnOqMpo3HmHDl01EvzWNShXHyRlZYyNnJgn3OaiO5ojELcy5LRAHh4L37YWb32uR1lziYa2H3z8VeF+dJzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JypNeqk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CACC4CEEF;
	Tue, 29 Jul 2025 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771811;
	bh=PukLlaF7nU5pa2sC5xyWZPLJdxHHWUYKVi4YezAqKiY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JypNeqk8tXBZmHZ7t3oTvfdgZke+EHVC6ZCIhKDLV88qsKTDtzQtfeTa1r3WXTobq
	 flSff/9MxRh/KZd+Jf2gfMu162xW4RRPKUmSsI87m6t9xMbWwtNb4n1IMYwESINR0V
	 NGsLQf2quej8t00USoaGsivYO46/tf8UPkKspSTpo3u0AmraD/uOJVJoC/zkZJTPmw
	 1XWu7qaH7QHhNp1/NUNQB/IVijth/Sox0Y7g0hSpkZhqKdorBxZm8cpyRzZqDophDy
	 dRBTsCJRwjWnFxSNn8RF2f5TcSwSXsUf+8+zLKSEVv2PLROR/xbEB9DS2a6lmfVCak
	 bRyPOxTThEvaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9A383BF5F;
	Tue, 29 Jul 2025 06:50:29 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <322b34fec942b961f17af6f02cb6b6a6.broonie@kernel.org>
References: <322b34fec942b961f17af6f02cb6b6a6.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <322b34fec942b961f17af6f02cb6b6a6.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.17
X-PR-Tracked-Commit-Id: ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5339a2aefc35c81526dc9a26419d34e8b041f0e6
Message-Id: <175377182800.1356386.9861403633067424938.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 13:24:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5339a2aefc35c81526dc9a26419d34e8b041f0e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-kernel+bounces-881470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5CC28452
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765743B5ACF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC91284671;
	Sat,  1 Nov 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY1jDOVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2627FD6D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019592; cv=none; b=Oe6HgMlJogeysRCugHkvdnxxlgMDuVJAYrWKKg5o/lRV9+M68iRBDVkppdZqG1rK/p8bsdspI72lYODGtPLQl/CKOPWZFLb+qMpqw0R/0VHTglD3jxHEsWMdGArI4DhinKe2fAUgOUlugmq5PQ3ukbBfxLM0yws0v4aeCcL5Pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019592; c=relaxed/simple;
	bh=6C8M7QSQfsYXDkzOPmrAoFtjq4idK264C20R3O+UfiM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PY/rxaShCu573UWtI4U5ifiLp4yWad1nsOei3EMWY7GoNwGZSd1gTXxbFuapR9+mzijBmzLJzStUvZ4LKWO7/Ks+D6SCR0sEfRnchKuryeMk6wanHJ1Pc37vUZ79nYbtDsT7BJeQs7RT4AJzilnRsYM/eoMMORItgCaKr/UvJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY1jDOVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44CBC4CEF1;
	Sat,  1 Nov 2025 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019591;
	bh=6C8M7QSQfsYXDkzOPmrAoFtjq4idK264C20R3O+UfiM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fY1jDOVnsgK5bdUhrYPfgY/OLSsJc05DXbPzGWJloWye1dDq8vZE7s62EqQgfeih3
	 M8qJh1w3v7TYILnMsaexOTZ7KRAyIlvhq3nCnpOpmIrWUy6yRSpKgkQumsmXYZiysj
	 wE4ncvbQBWvBl0D1g0UtIUTGY3+WjWNYGBcNKuomZEnmf+z0CSuVegA2JF6BjYOtdK
	 Oh1dx/FjQJ2Wk0LQ4dZoMw2ZvCTjLDsqL98nBylDtnS3X5H+JNitmtxULOIlzDZDVk
	 nceOwBBqAIgzhPtDQ//UgXUrb/XWXBNDJ3uhKG6eM6bSCnuM0ITr8U7TWFbI3PTAZj
	 wDr63ywDFO0Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2503809A1B;
	Sat,  1 Nov 2025 17:52:48 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <08892eea9f05f802e60bbda49e27bc59@kernel.org>
References: <08892eea9f05f802e60bbda49e27bc59@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <08892eea9f05f802e60bbda49e27bc59@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.18-rc3
X-PR-Tracked-Commit-Id: 48cbf50531d8eca15b8a811717afdebb8677de9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 963bf1619472d954d04ed8851be17df633c6afd6
Message-Id: <176201956725.853286.10148405001256834152.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:52:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 01 Nov 2025 12:29:42 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/963bf1619472d954d04ed8851be17df633c6afd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


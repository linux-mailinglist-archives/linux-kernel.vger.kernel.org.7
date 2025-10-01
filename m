Return-Path: <linux-kernel+bounces-839405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FCBB1901
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB8C7AE36E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73F2D7DF8;
	Wed,  1 Oct 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IarMGhy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C32D6E57
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345516; cv=none; b=bD24dhYrO/HuWH7S7Q3ynyhyvhFsIXL8rXP3I5SIqg/0YlwYpRj294DJ0MAxAtG00m5m+FQB4O+TFHo93qRRz1bypCl67t1OxOcKmqymThBRjy4BeLPtJFJL+cSzH/g6tTUW2CMWKTByICyb+jjpsRwwzYrz/WRzINNqZGMocUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345516; c=relaxed/simple;
	bh=vAPcJfEIZAzRcF+/UhpVuJ6I2yMzruyq82NedteNdLw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O3LRRNKQKlAeqirJvMlZGsu5suVrLdXCmu68VW1EPer8K6ZWWJwV+SjgMO7Y1dkh2+lfihH70GFAc4qyWZuP9jvGkXf+bOFGnSvo+0hI8nfYu5AM7ImhOK04ZoskN/70b2K0H7Z5gHsWdZiwqoBQ6kA6v8t+wSGeHMliBFbvEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IarMGhy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C365C4CEF1;
	Wed,  1 Oct 2025 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345516;
	bh=vAPcJfEIZAzRcF+/UhpVuJ6I2yMzruyq82NedteNdLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IarMGhy2fmuHyRkQxzXNVDAaLZKmZs8S+LFcPq81E5vs85cS9y18BeVikzRcd0z9d
	 hkacFloZgjVB2HSPCv/p5LG/uUu7hv6T2gJ8/+gzgwGlta5qL+BIB8dSMHephYTIj+
	 s5QrWUeoDE2cxUYMs512IpjQGOnk7nY4dq0gdGUtql4OEjDTPFmGPFnIxkqcIorSFw
	 DolM+wmAwrgYIAEI8niyxltzylV7I11c3We7syJyPpxwqAimVRSe9FQNMx6mXr1/kN
	 ZV+MQp5pZH9AznKMDHXZvBgBWXMuWfiEUvfGqNtcGwldCWVvynD4ZLkwWO9MLAhGMG
	 E4HYnh4MXbyKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6839D0C3F;
	Wed,  1 Oct 2025 19:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <0a19a5748ad44f494b94d78a3e35371d@kernel.org>
References: <0a19a5748ad44f494b94d78a3e35371d@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0a19a5748ad44f494b94d78a3e35371d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.18
X-PR-Tracked-Commit-Id: f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c252b8cf1228c70f044b5706613950dc283017b7
Message-Id: <175934550859.2583066.2570883262534097241.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:05:08 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:42:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c252b8cf1228c70f044b5706613950dc283017b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


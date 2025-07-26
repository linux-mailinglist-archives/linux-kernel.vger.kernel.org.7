Return-Path: <linux-kernel+bounces-746832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1930B12BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F62F4E5F54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FF28851E;
	Sat, 26 Jul 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVwA3de"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBB78F4C;
	Sat, 26 Jul 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552477; cv=none; b=TXxTVWirIQ+9T1OlMP0GgfyfX2Zetck2VDOBoO2lWKI/6yKp5HIC+PYqFZsiTwJq1FcrfAKz00BC8PNEvcc2VPqbj3cruU90rWTjMlbOTTFjq83jF3N/6MHeQdMFsPzB2V5WrHaLlt8KlvN3qQcmmgqgvaDe2+nssLzLYJX5CAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552477; c=relaxed/simple;
	bh=O8XDFXfBTuXvwGLH4OtMQytQ38kkabiKqv6gfOmh8Ho=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QfsY7mhARFwPPX2V4Q1MZqKIdFJjQds74l7v9soLkCTVag7hsO0s+xfg1Kv5mqxQD2QkcmQAQbOo+7W/MLyDy8VotbJip6BtwtnyF8qvjbpTEoSTtE1Xo4lid32NagtRd+CdDPJgbC2wqbJHNss2kFbPzYPGZnUcwumPxH3jiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeVwA3de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2661C4CEED;
	Sat, 26 Jul 2025 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753552476;
	bh=O8XDFXfBTuXvwGLH4OtMQytQ38kkabiKqv6gfOmh8Ho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AeVwA3der4qU1luIdSmKdWNi8DBP6jldHwxGX0f0t8Xn5q4lR8BYhCsjkSQLdudAM
	 QQFfIqDuHnPX3V7kXRYO1Jw/YTuLJr6VzRpW6jbHCeYytGlh38rj/DXPGhrrtE7Fjq
	 W83+ySkg8BAXz0Jo6pMhoa3BzIYlehPY7+/LrQKcH+Hdc3kI5C9v2TMX5N3crcgvyo
	 irqupxkIrUNz29ygon7VRaaNmouhCO4Jj49Icox5iOdVph3bdMjCoC9g90x5YBOKos
	 oWcoB8Au0/M+JHXPufqUN7JRCMCLf75LjJ1bG9s2ebyrYk87ZaQ0tkg+h74O5SfqbK
	 XCPYh6o2zHnvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3A383BF4E;
	Sat, 26 Jul 2025 17:54:55 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.16, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <94f09700-cebd-4270-840f-219ef14bf2ee@app.fastmail.com>
References: <94f09700-cebd-4270-840f-219ef14bf2ee@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <94f09700-cebd-4270-840f-219ef14bf2ee@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.16-3
X-PR-Tracked-Commit-Id: 912b1f2a796ec73530a709b11821cb0c249fb23e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6121f69c36337076fb0ffaa23acee3cf8cc5c931
Message-Id: <175355249373.3655743.9316066633007495504.pr-tracker-bot@kernel.org>
Date: Sat, 26 Jul 2025 17:54:53 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 12:36:06 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6121f69c36337076fb0ffaa23acee3cf8cc5c931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


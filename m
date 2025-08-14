Return-Path: <linux-kernel+bounces-769233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B7B26B94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33496AA6AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0A23BD1F;
	Thu, 14 Aug 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcmV2y0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42373233710;
	Thu, 14 Aug 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186579; cv=none; b=r0OUwZI6gNaFot1YWZzGsbcFdyN7HOCIdXo/mixZSE9Bv3zSS+vc2nE7ta9nLb413XPUd2PL0uXLgUtJfXbG+Pvwwi9hQbj9w6NlvyUavTVnkulYLIeGxaGjMkW9WOi8Iddn2BQ1pXhYsK5Ls4BfDsaNMVXjFGLKgGK2Dv/KJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186579; c=relaxed/simple;
	bh=LAOaboagujh2OPRaVCOoohhX/P7NWG2HXLah0MOtewQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=otOXgODThn5KHPeP1b20Je7c5fvuS6EnYC6uQIwb6FvuAfl899C7dMMBkOOCBzj3kHJwDKvPGkSYm+90qlpQBkDewb3YWGg6wdTWluCAtI2k1H0/9c6iJk8NhfjpwkzSJWm90XRkZGdHpmkoJ8ONKCWAT0glX1rKKUl61VJAndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcmV2y0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11BC4CEED;
	Thu, 14 Aug 2025 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186579;
	bh=LAOaboagujh2OPRaVCOoohhX/P7NWG2HXLah0MOtewQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JcmV2y0gUSk5FuKbZ1FSg+UO3ttxHrfYEYTyrIrTrnUSFV+H2587E/ciuXQpPH3ZH
	 IRESZjPZcHQ61QqDXpxzZ5/7xhINkIBl/fbuV+gxH79wCziCr77fw92GN6pELBz4w3
	 TjU5Mexo08J1M6Eh5Josktr+AZy3JdmkEFnVTyKlrNeynHigT07UWjMvu+nGwmphcS
	 jrC/H66zZmyg2dzmEeC6K5P0RrA3sVqWIDtnLfwkHvunZKnYPx/m+88LAAPdwsbz18
	 oMhPItHxLl0y+UgETg6yoQSMclh44B/YtsaIZRQeTbDubE+IPVA1oHiS4duroBEjQI
	 4h6xuLq5mVj3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8639D0C3B;
	Thu, 14 Aug 2025 15:49:51 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250814112101.35891-1-pabeni@redhat.com>
References: <20250814112101.35891-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250814112101.35891-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc2
X-PR-Tracked-Commit-Id: 4faff70959d51078f9ee8372f8cff0d7045e4114
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63467137ecc0ff6f804d53903ad87a2f0397a18b
Message-Id: <175518659027.350189.1346984299494340924.pr-tracker-bot@kernel.org>
Date: Thu, 14 Aug 2025 15:49:50 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Aug 2025 13:21:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63467137ecc0ff6f804d53903ad87a2f0397a18b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


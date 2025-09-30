Return-Path: <linux-kernel+bounces-838010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DFBAE36B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A5A38028A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C830F80D;
	Tue, 30 Sep 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzEPXFLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07C30C375
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253759; cv=none; b=HlI0ip6TA6QmP8Lu81uIEqdaVwVEWaL4eaqCK/36hShwtW6NEnEMMp36HBg1s6zGXgYPlhey+jNy/Pc2+w+HiOoFd3OGBuLbrYjtUTvmFZl34PanOPhaCadKFRTSnzwO060uAXCEVgCKCnVoKUFRBIMRDECPBZqJj3/4axJED2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253759; c=relaxed/simple;
	bh=sSaNX+WVVC84q5aZXD3EhUWtZau0TubRWS4P024pEbQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lAhaH4QKtS3jeRTWXwUPzPWVJ48bGHSnRPn6loxX5N3HN6FgrCXDHgXZ+OFHCdIddLeDoJAAYV3nlJO93XQ+V8HgXf14i8wcgan7mNQK5EAyPeWbTJl3uL9sdpElDzMfFq8mumenTCpA5zuSOzFrTEf0LF7UNTpAufCxoAmBvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzEPXFLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FB9C4CEF0;
	Tue, 30 Sep 2025 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253759;
	bh=sSaNX+WVVC84q5aZXD3EhUWtZau0TubRWS4P024pEbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jzEPXFLhpiTHGWLm01XT9H/oXmFWS6PXlfGb3CKfevsC3CyJI7Zs2QvZA58ufZyrX
	 TUprjQ3zoqu90gsr1eVx6b9QH2dExGBlhtwttnVJWv1h6bidsBqvNuXc/8+GE6eoK8
	 VAyRpIIqq9zIUNr3SeUn3ENTP5A6Pll27OBwiXPJlftSStXtSgdSvIry5/47IpBtOL
	 rIEZbP/kDbUHVf07p70b5qZeqotcfU9xxgVHy0O0Y+/tjNWkCqwRjB0+dz+m8lAYHJ
	 NubIfAMXk/YZVAEMv+7043wZorPvOHh/oh+Sev499Vj+JL8UKkbsa47a2BgEKOsa5E
	 n1hxTuqA4W03A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3B39D0C1A;
	Tue, 30 Sep 2025 17:35:53 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <50b697d50818b0c9d0abba3f1feaa2d2@kernel.org>
References: <50b697d50818b0c9d0abba3f1feaa2d2@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <50b697d50818b0c9d0abba3f1feaa2d2@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-6.18
X-PR-Tracked-Commit-Id: 0950c64ae38661bd97127e9aa0522f1624f82006
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77fc3f6696554a10cf7557c89bb3f1892ec29559
Message-Id: <175925375195.2087146.8097823507938171256.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:51 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 09:57:07 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77fc3f6696554a10cf7557c89bb3f1892ec29559

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


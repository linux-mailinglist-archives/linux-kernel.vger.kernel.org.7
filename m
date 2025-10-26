Return-Path: <linux-kernel+bounces-870490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC93C0AF29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEC87347478
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D325EFBF;
	Sun, 26 Oct 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IALnPnPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73B72605;
	Sun, 26 Oct 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500281; cv=none; b=NOJLXq5Nq+iaqqnrWbAHabT1DqL4uGIqhsOxkPEk5BZvjfF+4ZFls3qxkiYE3/ISGwwIEw1ToihdtIYRvWnVd8CsiAp3x9KC2px9hn6Fs2aKQTgqH/8eZHOSPUGsXCya0i46e96Hc39csA6f9LDR+IDoGDKQ1e85XWiRPpc3P/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500281; c=relaxed/simple;
	bh=4ae7mxLabP0oPbjtaOFBL7CYieSMl+YDOxtR5JHi5b0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KlaI6rfVToFB8wnzt3Ohj5dv09PbCNkW4uFTjjYSqs+EF6axGzFLI68wKWrpB3iNb5cUeXA2lGGTiICEqFjXuwscbh57sed6jMQx4gRqKOgzH0IfHdQi/Lbeq7a7+LW/vXP4Mi8mGR2Py3cpz3gXeoSYgkrNWkAF8VjrRNML5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IALnPnPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCBEC4CEE7;
	Sun, 26 Oct 2025 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761500279;
	bh=4ae7mxLabP0oPbjtaOFBL7CYieSMl+YDOxtR5JHi5b0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IALnPnPGRCo1qJjsW4/Pu4HVmVM7v4RkQu6Mp33Da7mCWJzagXHYB3B8rbUS5STpn
	 fQPYRUE78EhF1WzDoU9buFES0FOZrrWaBg7Px/igo4UYUg47ZfhsKO4j+i4n78StVS
	 XIt6zc4nFxXcrwb29NO8Zsfp0Eou92nOSfJNuEYZb6vwNK6jhm/GszZe9SF05aC+Ps
	 yGrb+yqFgpTGQzza+UGFI3QAbFz2ZG2mRVlE5Ua6UKuvEBoHFDeFGhkxK+YhTCzW8R
	 ptwTUIXb/DHLciG1FnPWRURsEj6RnoXRZXSFOMhcfu6yGKQzWIC+cR4yWdWMrXfqy1
	 JyT+bvxwuYqSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCD380AA7F;
	Sun, 26 Oct 2025 17:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aP4pX6-QYmlmM27h@kroah.com>
References: <aP4pX6-QYmlmM27h@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <aP4pX6-QYmlmM27h@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc3
X-PR-Tracked-Commit-Id: b1aabb8ef09b4cf0cc0c92ca9dfd19482f3192c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40282418e17e194fe70478025387cf89f8cfaf8e
Message-Id: <176150025823.300159.7769329660523366457.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:37:38 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 14:59:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40282418e17e194fe70478025387cf89f8cfaf8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


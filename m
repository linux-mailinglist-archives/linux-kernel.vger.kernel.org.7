Return-Path: <linux-kernel+bounces-870093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF9C09E37
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C888F343AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B472D7392;
	Sat, 25 Oct 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWnUQCCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A222C11FB
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761415990; cv=none; b=HWgDIYF+ysuvsxmk0jexof7oSKhZFNXADOuWzVU9AS3nkOqq4mTw1gPpxtAdp6Gq54WeTwG6mJe/ZbXx1uaS1j+cXteuZkG9HrsvSmlzAANrqen05rPm43acfHhgvuVNFGqjJ6yYiqyrNW3VMmkqrlAqgQaJ4HWRq2gSxCxy94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761415990; c=relaxed/simple;
	bh=B/i0bFGQzFFAcX2EZB1l4+QJote9cslbGzkanIXF5I8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iL/Ffi+bFuudxRsJHE6fKeBPvI7sm3xXbzPfOQuOM6BTbGy3+tHuOhVK0DEURYTh1+i0zeEqtOcd8QOG5oXND8M50VntVMJTTTCgXTzZNI+tYDmAE4vJsfz3TQEM2oQe0W0hQDVi4aAqDw8SAPNSmmTPuZoqt+Q+2C9z958+OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWnUQCCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B6EC4CEF5;
	Sat, 25 Oct 2025 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761415989;
	bh=B/i0bFGQzFFAcX2EZB1l4+QJote9cslbGzkanIXF5I8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eWnUQCCD+0/+XKbk6KMgHeK5r9ip8IchHHEk2fjhpWGUM6sDOG3SJPLKniDVz+I61
	 wVPFalQ2gZ+OBsbDlqNpQIbOFSu0Usik29wx7eQX6NxC28XVeal415szvbvQS8Nmyo
	 0j8Crt1o4vN03vX5jBJ0iXVn32yttltswpmMKpOSP9P9jv3Bi9mtpiXz1l9lGJfBFm
	 F1H4lcCci8E9hUHjYW9szr836IgzH7WJM2O+vNKZxfkJ9K6+5ZZJYrxSi7mIPStz1D
	 sgr9Rn5y2LWZU3haVPSh1v0kT4d8DoDKrbyQqX91LNTe7rL/kljO9L/JlecSqICYrK
	 fbGCEZPmB6KUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA6380AA63;
	Sat, 25 Oct 2025 18:12:50 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251025104152.GA501617@workstation.local>
References: <20251025104152.GA501617@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251025104152.GA501617@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.18-rc3
X-PR-Tracked-Commit-Id: 73ba88fb04081372a69f0395958ac6b65d53d134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 818444a61bd87d8b72c93448a62be2406b92ec33
Message-Id: <176141596878.93029.4061815109592402810.pr-tracker-bot@kernel.org>
Date: Sat, 25 Oct 2025 18:12:48 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Oct 2025 19:41:52 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/818444a61bd87d8b72c93448a62be2406b92ec33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


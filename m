Return-Path: <linux-kernel+bounces-650210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A9CAB8EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7844A6226
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3425C70D;
	Thu, 15 May 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/OGeYqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3125B1F9;
	Thu, 15 May 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332872; cv=none; b=ajQEZjfYnCa4J8arm0Pyqno8elD95BWb7NUv2MAYN14iOov0FA03Zl1onzjI2WDEDHrDxaEDHKh4w+3YUhs5bW0mpwJhyx35mRv3X3Wcjkz0bCTYrJ2DO2hMqrdL0jsgVr2FX8BmuwB9F03tltcasXUOsK88ZwXnmi/kauGgrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332872; c=relaxed/simple;
	bh=kOx3eKQIkxuyUxzLZTTPEvSZT+YYE3QV1XBsDXOpbvY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rmpr3DEH5LVDnMkYowGpSw1d7aylEPiJBdO9uWBSNvdInNdZQP1Vyn3Vq2GCw9iHcktSjgNHpSvkhIZF9UQ+ydDxxgWksN4Ugw7kLG/5S0+olRCw2Jxl8hRAM5oZFnx+NO90ImzSb9Q2sy4UBL3ZYo6FDvmi3Jvb67UcejjtkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/OGeYqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A33C4CEE7;
	Thu, 15 May 2025 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332872;
	bh=kOx3eKQIkxuyUxzLZTTPEvSZT+YYE3QV1XBsDXOpbvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h/OGeYqH+Q9kSSg1mKwhEJtrFJr4pAdMQnFGziyyofX+g9EuXW7oNqAoZ1Btp24zC
	 zb9OmlsBlvmoV3a0chz7wthM/2l6E76kMZuR61fdnlvCTY+62JqMLHhAajhpcVS/OS
	 +Tvk1F2GCl8aMXM2YXDB8cO0WWeEsdjzq7wvMnh36MsSErRJMfs4BqESPCAwZgkcdp
	 /SOZCGOZiSM33m2riICHbvByDGJ8Y/Fo2JqmVQjttlq0DjiU11wY9PwVbRSNCNCjki
	 nlh9a8EJ9r9aFHihs+fbNvFn+rMronziLBTqbJFSsIrDYgzPHS+Y39tu0x8Sst/yqw
	 OSTbajoZr3Imw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FEC3806659;
	Thu, 15 May 2025 18:15:10 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250515161024.2062444-1-kuba@kernel.org>
References: <20250515161024.2062444-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250515161024.2062444-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc7
X-PR-Tracked-Commit-Id: 0afc44d8cdf6029cce0a92873f0de5ac9416cec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef935650e044fc742b531bf85cc315ff7aa781ea
Message-Id: <174733290911.3202874.670144997755260232.pr-tracker-bot@kernel.org>
Date: Thu, 15 May 2025 18:15:09 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 May 2025 09:10:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef935650e044fc742b531bf85cc315ff7aa781ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


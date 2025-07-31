Return-Path: <linux-kernel+bounces-752468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C264B175E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FFBA848A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC701C6FFD;
	Thu, 31 Jul 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1gp5umN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331123D298
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984561; cv=none; b=ZmgwteovKm3oTowJNbSPruFsHPirjuIL0zj31Xg2kxH6pKuqUkw7DNvMudpwDQLqrlcUWS6njK4aAjq+fakydd0+yZrN1LpdT7/iqgP/F6nrW4m8GOqzFQwveOBKv4dTgNgsDjfQJMszk2EGC1g0AMwh2oUqVDV3MFyCDltZhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984561; c=relaxed/simple;
	bh=VKCwX0DHIRkcRvdK4nbNB2OWYDzjpsSnc8xa6opI+YE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tR+7geAYem+Bw3Lqk0NYKIisjB5hz2BVF0Fpqh86HAKT6Pr629Wb1OGarnY5KIlZ0uH/dda0j60SXH9dqFHYlpBxbFCIPILrwNJWTOT/m3U3DOKhWmD7XwHUjUGbGo2nxrTrwAtvKkp/6/h8KYpbF8oNetpVJ2pKnx+IW9CRIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1gp5umN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF35DC4CEEF;
	Thu, 31 Jul 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984560;
	bh=VKCwX0DHIRkcRvdK4nbNB2OWYDzjpsSnc8xa6opI+YE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A1gp5umN2ItxAdzkoxec6zoe4/Vh+Rv4SleH6jEx9mhU6czKFSO1bwEkaA5fngknn
	 il0kIedUd/ao4ceEQfIbdzeJVacpB3fVIkQb2LFvZq+Gdbfu0lizT4Q0Z/JNCqcwiK
	 LouWIbAFjE496FqjnowvRm709J9Ys+N0XxMQOyCmAIpFg/okLeURlSQ+tVl0OKearc
	 ydFIstxEhziweZCb/ISqfRCFDZjCoRgs2DNVbalc3X6LMAfng8QoENocO4P4YiZ8Cb
	 CoqzK8sNIVLqe/3G48BpCvXxRurg4qy8UOmeIJecxwOTFMUDJ/D/5VMpEboF0EIFdc
	 ++5CzCi43MJ4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC3D383BF51;
	Thu, 31 Jul 2025 17:56:17 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <1ab1a9e3-037d-473f-954d-248037f2ec03@oracle.com>
References: <1ab1a9e3-037d-473f-954d-248037f2ec03@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1ab1a9e3-037d-473f-954d-248037f2ec03@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.17
X-PR-Tracked-Commit-Id: 856db37592021e9155384094e331e2d4589f28b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 440e6d7e1435bb1e1948eeae34ca8bef6c7c5f82
Message-Id: <175398457616.3232013.14278904960309436241.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:56:16 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 09:06:11 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/440e6d7e1435bb1e1948eeae34ca8bef6c7c5f82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


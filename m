Return-Path: <linux-kernel+bounces-601121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7711A86972
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 01:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3753D9A8160
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D58298CD8;
	Fri, 11 Apr 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESebxlFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1622BF3C9;
	Fri, 11 Apr 2025 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415108; cv=none; b=OOPBnUyVHH3zc+x3Ao3+5ZKQ9zc/pT4Spf6yBm8OPAaqQqyspRWHq+pV3FhD1Zdd6ttNWzvKJ/U9CWM6/NbgzERnc5AOQ1hHXTacKQFcTIzxAYY5vuIPj8qmWd9+kMFxYdGYeStRXjGIQmN4XN5qeYqnK2ixByfT8mDxQDIO/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415108; c=relaxed/simple;
	bh=hXm6nBLpcy/OEy+oTm7ZOW1nl6FZJ9a4cI+WhskmLWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mE2Q7k1sR2s9+QENeh0sHxPcJc+25yBLRRynZlFVMo1jGqWWQHpvXsgK1UTcXS13RKFviQ0bNoJxcMMx5iJ7rhmr9CGUsZuzS6Sbah4ZMOvlDzHiHbpdNOhkUswejR045y7vpNBghb7W68Tfb84+7gZEbmEctdEv/doSBxV07T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESebxlFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D055C4CEE5;
	Fri, 11 Apr 2025 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744415107;
	bh=hXm6nBLpcy/OEy+oTm7ZOW1nl6FZJ9a4cI+WhskmLWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ESebxlFduxG22JBdcRy0q6ZMlOdN3cAZSAsodP2zwppeSOhF+fn0lgs2nwnfD8nSt
	 eTqyR8ywxaBysQQkF1I297Aj3kIvnI68ovhshk90pnXpYG9APY1zOP7S2Au+wK+7F1
	 J2hwwEpKlAheubaSbLjlLy+R4/QnKBh+tyrMDsvG1Lu7pbaF2W9AsLEs8bQtJYpopp
	 MSt6MmvvLQ6eOGVTsGChC6ksfwtUYDdcW2BTdeBfLFX6ONuRLqlcjDSgAATsjvkCJV
	 TN9WW3gTeZwefIqVAtOQwvo1JZfg7sGQ12I4F06A+NgY+xH4FKVwWBMVxHQI/aYZVJ
	 /XHEWxUamDVPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9438111E2;
	Fri, 11 Apr 2025 23:45:46 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt3CCXVEwdsrqPe1VE+xebPSh2k4Wg5Zqqp_OCm+m7cPQ@mail.gmail.com>
References: <CAH2r5mt3CCXVEwdsrqPe1VE+xebPSh2k4Wg5Zqqp_OCm+m7cPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt3CCXVEwdsrqPe1VE+xebPSh2k4Wg5Zqqp_OCm+m7cPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.15-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: 56c283b9e001098362c76547cfaae022d48549c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bde70a2c82712f05c7220b8b94fc2cbdf7fbfe0
Message-Id: <174441514468.520992.15416501184688847089.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 23:45:44 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 13:22:15 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.15-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bde70a2c82712f05c7220b8b94fc2cbdf7fbfe0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


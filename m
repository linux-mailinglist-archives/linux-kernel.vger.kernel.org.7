Return-Path: <linux-kernel+bounces-869627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF1C0859E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4793BDFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0988F30F7E3;
	Fri, 24 Oct 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCo3+r3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401F30F532;
	Fri, 24 Oct 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349769; cv=none; b=SFWns8k2AaRos4HpdidKQY67SlsaM9vr9c+Yh3uMGJTJudlEmEQ/ef8HgZiuCz4P/TJomtJVuHArha05gv88bbvSR+U/iT/coxfTHVCznWWuM4NwcB7CoKeROg0RvZT4AObkrU/KE25u+3RFo9AQdc94N36P755X+yWLeLzi7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349769; c=relaxed/simple;
	bh=QXYIduEbAZ2wTn5wBlNVCo0Nl2SclLtgrc69TrlARZA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SJtlzhzEptLIAVb9+Xo5Rhu0dTogP3QM9bnZf65gata8svAVtWnl1ZBFwLGdl08LBzE8ASE0NUtGwtz1E2YKkr78tjN4DcmQBcieSOay9vnyuxLLnK8fwJGuc82+oIh5WrCti4A5hs72uq9hvPSTcWvnjAFIpIPucNH2WbtFujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCo3+r3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F3AC4CEFB;
	Fri, 24 Oct 2025 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761349769;
	bh=QXYIduEbAZ2wTn5wBlNVCo0Nl2SclLtgrc69TrlARZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SCo3+r3/0Cfn424U7q90UAH+vmlNgtCDGiN2b4/xE2u0DkibWx4xkgXdTTyG2hIfj
	 DKOoZlJdqWCkic70IVziBRbJ4XMCTUGiYnDKSQxAY3pRd3/TdLQuWidVJjx3uLUB6i
	 2XihhZQ9LsMvuepCYyLtQJTFO9QIb4DijahPQ4nprst15egIiidGdMbSJEsXzQ6xgG
	 ZTpobct2Bnn98ylXg4mjLxDKFz9c+jEpWiAmWWC7uDj0KuWzIkROK8p0lIAofy02zb
	 IUpVBrg9Ej685A9uvQo9xJcWCdc8zjSVLFquOsgCq0UVmTgbCqL1uSoO08APghiRpb
	 Iw9kUVVON9EZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF1380AA54;
	Fri, 24 Oct 2025 23:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto library fix for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251024190924.GA2068@quark>
References: <20251024190924.GA2068@quark>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251024190924.GA2068@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus
X-PR-Tracked-Commit-Id: 1af424b15401d2be789c4dc2279889514e7c5c94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7083bb6060a99a4c7e60e710b70a2ea8fb2d524c
Message-Id: <176134974877.4096869.6589651191585383235.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 23:49:08 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Pei Xiao <xiaopei01@kylinos.cn>, syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 12:09:24 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7083bb6060a99a4c7e60e710b70a2ea8fb2d524c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-kernel+bounces-799465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFEB42C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEA0581A96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5E2ECEA3;
	Wed,  3 Sep 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNUuf2o/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60C2AE77;
	Wed,  3 Sep 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936372; cv=none; b=MRrI6Omx+CSoVumZPeYDyU9C7NyeX7aUJ/MCmX3uJbogL6k8Z+rLJi/+kZI0+sh6XErJLI1xu1g8hKYpcRSs3xttUiMsEKDS06UFpQlLEnCg4T3B7aBV/ncBBbOENSjyegHXP7/W+JAq9HMzxcSrxgYM+j/83C3EA4U99knqgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936372; c=relaxed/simple;
	bh=rOo20K73wsMPXw6ozpBRygvXugSlqznRaSINt2TqRhQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=POKVxeaPBLm4kM1cGA8ctfg0bdbrCqLDKqFOJmO4KBpWlQ/P9LeVV2LGvI/1tULl1VbZ1O9Pz9bUGyVuK7bOkMz17ZRKLYGBmVJ71Ka39WZg7oUF0MpK+WOT8vHb6vjboi/OU0EEskXi2QRmdCQImLrhSN60xfYB1uRp/XSlXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNUuf2o/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD26C4CEE7;
	Wed,  3 Sep 2025 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936372;
	bh=rOo20K73wsMPXw6ozpBRygvXugSlqznRaSINt2TqRhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cNUuf2o/403/LVG/8dFO4Xv6QNFGK4ienYZpv+kS79bUrukdQNdaOdogdzIX2zOdO
	 gnbqLrAE84uFCYxzw1bV1998vZ8SPZ8FsrjC3akJwyVvs2oBI5ZOIvCmOPliHQDz2H
	 n2r/SPWV/OTWdk5yooCLew/Oy5N1kIi/YKHlROEo9oqVqXZvwPpQ4nymyKn0l510mi
	 4cfxIQGZ+tKirqpEOBwqG//U4GFZhwy7QzvF5UrQ8vzaFJbQbS3sqHEHq4Hpf27Ne0
	 ViWrrT6EA11//oM9Hqrr3XfjtMk2UW7ZHK7ZEgLwqMX6LjGpk61IwAumQeYGllKtuy
	 c+FeOK4nGUfyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF92383C259;
	Wed,  3 Sep 2025 21:52:58 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.17, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <0baf22fa-281e-4f56-a807-917152f0bc79@app.fastmail.com>
References: <0baf22fa-281e-4f56-a807-917152f0bc79@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0baf22fa-281e-4f56-a807-917152f0bc79@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-2
X-PR-Tracked-Commit-Id: 875691ceb8bd619de7791243b1cf6184ab534865
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9a10f876409bf3768178f4aded199e193ddbe33
Message-Id: <175693637733.1212561.11065269005033782414.pr-tracker-bot@kernel.org>
Date: Wed, 03 Sep 2025 21:52:57 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 03 Sep 2025 23:21:19 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9a10f876409bf3768178f4aded199e193ddbe33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


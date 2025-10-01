Return-Path: <linux-kernel+bounces-839386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A9BB186C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B6019C0DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58282D6E59;
	Wed,  1 Oct 2025 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvi266jj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7272D6621;
	Wed,  1 Oct 2025 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344163; cv=none; b=JevLoq/3dy3x5Cz8+hVXZMFddnMZVRBhT2jQ19yBlNrTw6JKgmpHvX/uHorp8cEg1zxL21xB3ECfq4lb6qj53WoMaD7CMQCp55HkmEgKtwkiVJwLieSwjKi/lK8M8pU0CNsDetylAsvwT2tHe/6VxbAnqDi5o/3l7e0KQ51Kdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344163; c=relaxed/simple;
	bh=2cHu+4n9UY65ObeKIdblQpiuZzBfWCxejbH1z02Q7iY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D2aSR8KxWoFsZ2tO9RjZ2+RPl+w3qzaaU39KxIgE/cGrIxswUHYmd96n13gG6XzBwP7meeNNFHD4k+ePBSdns+VT7AGoBMWzKiAAeFb234ZqBuFEQOsyoR6C3133a+QrhU8mlBjsSqXiCm+9g1ZXbWUp8lDL7uTJHaU9uwN0qQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvi266jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CD0C4CEF7;
	Wed,  1 Oct 2025 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759344163;
	bh=2cHu+4n9UY65ObeKIdblQpiuZzBfWCxejbH1z02Q7iY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fvi266jjy0JqxUHnKcuJVr0BCr6HBNgq9kMtC5GF6e/YMpVKrO+gJuMx1dFHc1+OK
	 Q7XCuuY3DxvtFEkjSHAwngtHjA7u0dNADYqlLRsMPArjFKI1gUNhcEJGVkxzym/zhw
	 TtgzF4sxfGXDp7NJ3cNaXtvxN9toEBD+0W9B5L5MuN36IzWriaoGKu6/eg97cNjroM
	 ++uN41EDX+n8dMuTqVQWypA3KsLIV0N2l9mMJ7GvfvvJmOvr2S+AG6WVWVvkN7BT6Q
	 TKJdaAB7TP2Rnma+vj4ROFOkx1AYS0KYlDFBLrEBhY/HmaBdFGIcSzQB5ofJN0TJl5
	 +G+9vLUdw+WyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1E539D0C3F;
	Wed,  1 Oct 2025 18:42:36 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929005950.447268-1-linux@roeck-us.net>
References: <20250929005950.447268-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929005950.447268-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc1
X-PR-Tracked-Commit-Id: 76bb6969a8cfc5e00ca142fdad86ffd0a6ed9ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 989253cc46ff3f4973495b58e02c7fcb1ffb713e
Message-Id: <175934415540.2574344.1308587567840068638.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 18:42:35 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 17:59:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/989253cc46ff3f4973495b58e02c7fcb1ffb713e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


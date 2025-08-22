Return-Path: <linux-kernel+bounces-782118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6CB31B54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA5178225
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601F30BF6B;
	Fri, 22 Aug 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnpey8ah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F62306D2B;
	Fri, 22 Aug 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872307; cv=none; b=J0HNYUa8FaU0vQGMcptwQO1glOU1R3zjonEbS85UVj0YqNsyja9qy+22JLo2StU+h9hM2She7xXqBVvk0WqaLW9xo0t/1lrzRMP8fWVBS/pdIJUnZrGqOov/4ATzJSqNqRQRk6a4hOKrjn70HXGR4llv9+muDjBhJB5cSR1tq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872307; c=relaxed/simple;
	bh=AcnuYF9E0tz8mAsZYhReemdh2GANNFaNG7jxXhDuCAA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=No2GwDyHfLaGW1kpUwPCqHa4xaGOfmnFsamSqevu03kmKP0Qwud5qW61B9KA4z1XjSAysBEL8K4RVIrLx4qUU13m3ZxdXQwUwaKypmxVWQ6/XIlzhClqvXqpI4Ixn6a7zVC5ejfLOC0idbfKNNWTzIUordN68lMoSh+jX5YfGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnpey8ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC3CC4CEED;
	Fri, 22 Aug 2025 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872307;
	bh=AcnuYF9E0tz8mAsZYhReemdh2GANNFaNG7jxXhDuCAA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hnpey8ahfEgOdot9ipCvsUYPd3eFb18dgdqPQgevXt2u0gLTkuuXUwvsBD537UZpJ
	 +24IGza9CpCT4whI+ZqzEahnfiW1PgqLWlhiJovn7E5QZiVuwlhK2gOC6Jv19KFXia
	 dswvLIJZxa1Z1BSe3YQ+8KhyjzpMqDmjqp6xX4lxiVpG5mzgcStCxuG6POmyRA5Tng
	 hfVbHMQjZAsdKlwABa1XJd8K3PHkPeK6DLkS05z9FZGTfuv9U/ENjUojyaeo4KuohI
	 VUjv0+PTcefZrTO6oH9tLmjNaDYgfeymEWcLpbTGo1n8qK+GPWFduNi7/gU8n/yr2B
	 HSHwNKhMxW0XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA4383BF6A;
	Fri, 22 Aug 2025 14:18:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250822123608.142112A72-agordeev@linux.ibm.com>
References: <20250822123608.142112A72-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250822123608.142112A72-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-3
X-PR-Tracked-Commit-Id: 3868f910440c47cd5d158776be4ba4e2186beda7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf6fc5eefc5bbbbff92a085039ff74cdbd065c29
Message-Id: <175587231610.1847242.7503825458319222649.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 14:18:36 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 14:36:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf6fc5eefc5bbbbff92a085039ff74cdbd065c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


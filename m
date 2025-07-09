Return-Path: <linux-kernel+bounces-724257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2238AFF095
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD751C24BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C123D2BC;
	Wed,  9 Jul 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYmPdDBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038723C513
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084596; cv=none; b=AitK6Etsqo1CGi9vz035jYyKNggwBAidgZtdHVRjZUHM9PKhTnP1d3wiO1C4y+mRtbKOUgg7KMgLf73dvOA32i8cI/5TdgFktY1bCS04NZ9cBhC0wSqYxxeL7u3q8UkeM0pxIu21c3mmbkQBmSchFtsljvIioUiETAmQjC0xio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084596; c=relaxed/simple;
	bh=SB5eGlc2moEaIco7oamQmt2dqEBMeVD1RaTZ695Ux3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UjqYbLqlHN6tVEjGHLl/Vc/8r7VP95PcbbKpDCxKmNZWi5ptmXoyES9F4nIQ8T9RJNdqGGhdLtCiVOyZ4swBT3Haj0e3yO9zGA4EyvDVypgGKcPCcKP/Gc5Q4YPIuzDnj+abqoHLZccS0vIKYoYo699QytpOAA31heWYxmRxqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYmPdDBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4C1C4CEF6;
	Wed,  9 Jul 2025 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084595;
	bh=SB5eGlc2moEaIco7oamQmt2dqEBMeVD1RaTZ695Ux3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DYmPdDBoNmwt4l6OVHUtKSm5T1xZIxE4IwuRARnvBD3ePi/8j6tU8YU5Ap7BoA9nI
	 1W5Ykp0YnIqy+ILppNiwRPQzTurFnpfBE9fblqRrEHw8dzKSx//ZiBW/fTDiVSGRkG
	 CJ3GlphzdOWPSOJAo8px+1SuHUri0qv1qRLK2A0D97hCHUEwerBIYGQsw9OaSQuiJS
	 h7bjK9ImtSqXq1Qf4pBAIGs0RHrCD/grD9DYP7d9Mc6UZBbPaRNE7IsrQsNLbL6vP5
	 fiHWQqn0CJ2IZqxOdBme/F0TdiZ9Q1vAkkf9R+9Xh52b7+qAYmCGU9tcNtmI2n8Pai
	 rt3PBDoNhef+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E86380DBEE;
	Wed,  9 Jul 2025 18:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: fix KMSAN uninit-value in extent_info
 usage
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461775.806926.5771206803640875026.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:17 +0000
References: <20250625110537.22806-1-abinashsinghlalotra@gmail.com>
In-Reply-To: <20250625110537.22806-1-abinashsinghlalotra@gmail.com>
To: Abinash Singh <abinashlalotra@gmail.com>
Cc: chao@kernel.org, syzbot+b8c1d60e95df65e827d4@syzkaller.appspotmail.com,
 abinashsinghlalotra@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 25 Jun 2025 16:35:37 +0530 you wrote:
> KMSAN reported a use of uninitialized value in `__is_extent_mergeable()`
>  and `__is_back_mergeable()` via the read extent tree path.
> 
> The root cause is that `get_read_extent_info()` only initializes three
> fields (`fofs`, `blk`, `len`) of `struct extent_info`, leaving the
> remaining fields uninitialized. This leads to undefined behavior
> when those fields are accessed later, especially during
> extent merging.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: fix KMSAN uninit-value in extent_info usage
    https://git.kernel.org/jaegeuk/f2fs/c/154467f4ad03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




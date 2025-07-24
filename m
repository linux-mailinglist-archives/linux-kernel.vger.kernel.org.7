Return-Path: <linux-kernel+bounces-744907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA550B11258
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7701618960E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430328981C;
	Thu, 24 Jul 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH4563OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634327F160
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388991; cv=none; b=ai5rZ+jCt4iKmBH9DWHMPcWfG0keWQI9gFIHNAAelz6nqxG4tcccdZUrTj/BqXPO7CrO+lGjTV55zFEitj9vSEMFxluHyxHa57SdzWuzMu/nmOHckdDooxwd1c5VpAoqpDd5owFdNW0rcYCe8yAmQlANJ4HRGSvMXPP2AtEEvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388991; c=relaxed/simple;
	bh=8omJxnDmdLt4PCSaTRYHGUJhtLkmAWmpNQRwr/jaSUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tG0//u8slkN+hk1aRgM+MicuR0azb4QZrbBsAGkV5uO3ps6+H9dmPY3KuYz2QE6gAkWBHH9Tu4h1aUTQTOYBi2OixhkEhrQXTXZNzGz3EgJcr2HhzCzi8xlQXsNx5ncDSN5T8LWqRjAMqex6lIb7wKVDxBsV38F2nthabOGK1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH4563OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E76C4CEF6;
	Thu, 24 Jul 2025 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388991;
	bh=8omJxnDmdLt4PCSaTRYHGUJhtLkmAWmpNQRwr/jaSUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rH4563OUE1trZPVxlHrlpmqT0BnZY1P5WVADs/cjCaCSKUb9fjC1k2UXVTt0+ZPjn
	 5lA25Phj8YS6Vw1ka0zF4+dk0xn8+BAmzwMoE4ioZwLQgPtgEdp+PvJ+lBkNoZcZKP
	 y0qNYOGROWQB3hCzMhKsmlS4Kpe5m+llPiZDKI6YDe/Ym059fUFhMVhJzSe5diXXD+
	 bqs/Y9JGtNawPjB2LZubkW6KneyHbKfyXXKx6BvdD/P5AwEwb28bdQcQLgtbPLNBje
	 44/tbEP6jiy80wGLj015yAZ1JZcBmLR9G/jtfgFMIbxF620XIkjqSH0QrTCOQAkAuC
	 +oDZHpdvDcjrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD5383BF4E;
	Thu, 24 Jul 2025 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't break allocation when crossing
 contiguous sections
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338900874.2519964.9616561185237270230.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:08 +0000
References: <20250721020231.2482090-1-chao@kernel.org>
In-Reply-To: <20250721020231.2482090-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 21 Jul 2025 10:02:31 +0800 you wrote:
> Commit 0638a3197c19 ("f2fs: avoid unused block when dio write in LFS
> mode") has fixed unused block issue for dio write in lfs mode.
> 
> However, f2fs_map_blocks() may break and return smaller extent when
> last allocated block locates in the end of section, even allocator
> can allocate contiguous blocks across sections.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't break allocation when crossing contiguous sections
    https://git.kernel.org/jaegeuk/f2fs/c/f0a7adfedcc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-836835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2DBAAB01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DE77A4ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604723372C;
	Mon, 29 Sep 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/OA4gzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6E1FF61E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185028; cv=none; b=byhbmoZ/PJqkaDiIZKJWCdAH72QaufYRytb/pE+KPtgIZ10oxO7ZJAAMZ5VytLn4jEvaLhDiJHtxQyk4SXLJ4vOh3A+ucg5WvyONlfLBVCmqdOSm2bfzI6AvFdoOx83DD8iiqkkNAEzelN+QeL8usuvM6WrnLF1Sa/wnw8lGB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185028; c=relaxed/simple;
	bh=07u/WUF+ys2ZzKDNaEiodqR+31ShOCgxlIlySpsJCnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oV1R17CXodH7PhMFrmaKgMBrI5AReDR0/FOIGLQUibPfx4QgtvscgrMkVHzN4gafCtMdUMsT6i3bRsBe7Whp5JYi8Kzx9wtvSqcLsfVgqzLKaxAA7yspn27QfzO7qa+Qy+KXkFRVttNOtQpHL4mV5ZOdVy1aQT2YQ5x92LOUXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/OA4gzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A57C4CEF4;
	Mon, 29 Sep 2025 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185028;
	bh=07u/WUF+ys2ZzKDNaEiodqR+31ShOCgxlIlySpsJCnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/OA4gzNOhLtzSUYJUUfP9jTQMNhF4MsRiMycK8dHxNb7ZEDivGmb9nIeG2epK6+2
	 1mK+gRIZeXb4SzcdDxS4KVlqB4rf+9c+z6+R0EErW0QOyCJ892oKu8HYXWfx20fZk6
	 VRB8myVL1XnEIbty5hKJnEOj3NThqJ1yiHIXTNC4t0wxpafhtHmwNgcUH+KIsw4JVW
	 rRlZ+g9XmoY9zDs/nLBfzWtGn/lty7V9i1TCfsqtVPpudGO4iSWuPzaGwYK6tAthhF
	 R/qpdRBq9vYnX8bqU00NmOuL7XFI41RilmxFaZVhhOLFd+ctIjaONavt7XxrbDtpfD
	 m0Il255rJok3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACEA39D0C1A;
	Mon, 29 Sep 2025 22:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong layout information on 16KB
 page
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502149.1733438.11140938754376368014.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:21 +0000
References: <20250909002717.829981-1-jaegeuk@kernel.org>
In-Reply-To: <20250909002717.829981-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  9 Sep 2025 00:27:17 +0000 you wrote:
> This patch fixes to support different block size.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix wrong layout information on 16KB page
    https://git.kernel.org/jaegeuk/f2fs/c/a33be64b98d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-836838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF0BAAB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CDB189A328
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC6255E53;
	Mon, 29 Sep 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM2iwRwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6892505AA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185034; cv=none; b=CWq/VFbZpFr3d/msRjdFBxG8o/YUq/WPPr7IXr6BZ0Wbo/54Ih3+6t7kgvNVsZiJVnWKYXQzKzxHK9rqtyVQoO4/owvZ9Ixs6AJja5lJPjLxMCRdcFXE05lzaCWxI+RIFZfTD7wXWTg3t41FpkvpwEPF7fkxfXTW43Ar1fwmi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185034; c=relaxed/simple;
	bh=aR5kD0w1ADceK2J3Vt1M+GkVQaDpv+0TaN6cruVL9zI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ByUCobVIiNkHBO9RAYgn89SBaOkgiMe4M1xszdc/QEZVXb9MUrS2+Mm7eoqYpoU/l55v3y5IzT+Gffuyt3EErTQUZmL77UbxknUMx+sd6XcHBo3RcPsrLs0EH4DBeWNsyHtRQyaTvkSWD3neDGZv9MoCLbSaFP00k1H0/K8EElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM2iwRwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF04C4CEF4;
	Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185034;
	bh=aR5kD0w1ADceK2J3Vt1M+GkVQaDpv+0TaN6cruVL9zI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YM2iwRwmxKBBe3IvGmyG0pGF9+FZa7bAsGGtuJOugOoELb5wO02mFWY3xdf7HexOL
	 IbSwcGAZk7b1vzX/TMV8zk2dw8ayNBVy/8C6w3hPrJoIWX3Jax1CfXfBOnK2++bERO
	 rsA0nIyKNAOsotZ9LExVmgsALcaDVe9IQm3pqb9fecaP2wwUkkqGhgJrI0OEXEkxyH
	 AzTYU19M+ioiT23k1tUBXrBUP3XLm6t1ScWjojsTByMaMQgqM367t9b7Mhh4u1SVdk
	 W1kGDLEGPAxRaJBaLA2oSRjFPZ9qpxv3zLUwgUW5Fe9Se770aJmElNnQKm+VELfKY7
	 VPsoJf3/Hc3tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB31239D0C1A;
	Mon, 29 Sep 2025 22:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: readahead node blocks in
 F2FS_GET_BLOCK_PRECACHE mode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502773.1733438.7019947072233601645.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:27 +0000
References: <20250924074358.253759-1-yunji0.kang@samsung.com>
In-Reply-To: <20250924074358.253759-1-yunji0.kang@samsung.com>
To: Yunji Kang <yunji0.kang@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, sj1557.seo@samsung.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Sep 2025 16:43:58 +0900 you wrote:
> In f2fs_precache_extents(), For large files, It requires reading many
> node blocks. Instead of reading each node block with synchronous I/O,
> this patch applies readahead so that node blocks can be fetched in
> advance.
> 
> It reduces the overhead of repeated sync reads and improves efficiency
> when precaching extents of large files.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE mode
    https://git.kernel.org/jaegeuk/f2fs/c/72bdca6231a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




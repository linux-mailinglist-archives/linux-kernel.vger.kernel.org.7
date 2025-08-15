Return-Path: <linux-kernel+bounces-771193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB6B28401
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58B75A446C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF230EF89;
	Fri, 15 Aug 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI2tN7MG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2930EF79
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276003; cv=none; b=uO8MYdhmQnizMIZU3gyqQknsU7j8kwlMKMwDSlH3blZMA4JuReQ449uQKdWiJVginAMRhDPCSiLSnDK0XI7Vmqxo2VtHGE/kf1VHnWMWz0Z5tQrmOQO4bEdpE9Bfj6JDcE4KeEB7/w1jMj8T2Se2yBPdb2pjZje5jgY5hzsBqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276003; c=relaxed/simple;
	bh=TaOMQeXhqcnT5V3o4OlTOg8H7abGaZNTtOBC7Bmmpm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMQ8fN2yfN0xkjmZqQ6Tj16NJuvpTqHA+pxWvQ1Ixo5gfWeYjg/SY2coz975gdeOc4neXv21oqvPV5g+Gx+iis+Spiss7iK1e4Gam5DE1nc/ebcSCMPgFh0f1N/DCD9HkL+GpM4xD5X/VWS9dCRstj32H8DuO/BEX2xt/l8pX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI2tN7MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D461BC4CEF8;
	Fri, 15 Aug 2025 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276002;
	bh=TaOMQeXhqcnT5V3o4OlTOg8H7abGaZNTtOBC7Bmmpm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gI2tN7MG5p29R+xH9tK4CkKGqZxVNt9k3RtD/MDPc1c9WPe1EQ/xXO78J+EBiWLgr
	 E0yoWWbk9uaBmmJFrTpFvU2KA81Rry9kG+PZcE85bkJXqC2Po1Ka+bO+7EvsNgs9rt
	 MWOQjN1FFh1Zof5pX3aQxXR4p1O1kjBH7y1LCcn7rLhd4nxhb6mlI2fcBFVKgiMRvi
	 t0KW+xcI4oIqG1k6wgO0pqn3hpVH/MbnQ012zbxMv2zoOiOk6If8Rwild+/q1rUdSL
	 Np9HKaGI5OpacvhJgCKXYirBvgYPtvxs/CZ9YZWNsT9d2hXXPqquNRBe1+aoyrD63H
	 Oyio1IatdExuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AF139D0C3D;
	Fri, 15 Aug 2025 16:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601374.1161945.5893308622119407321.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:13 +0000
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
In-Reply-To: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
To: mason.zhang <masonzhang.linuxer@gmail.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  6 Aug 2025 20:32:36 +0800 you wrote:
> This fix combines the space check for data_blocks and dent_blocks when
> verifying HOT_DATA segment capacity, preventing potential insufficient
> space issues during checkpoint.
> 
> Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix CURSEG_HOT_DATA left space check
    https://git.kernel.org/jaegeuk/f2fs/c/066694aac462

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




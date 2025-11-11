Return-Path: <linux-kernel+bounces-896270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C18C5002C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E89C134DAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073242F3635;
	Tue, 11 Nov 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JilYNZfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FB2F2915
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901445; cv=none; b=osHkY1dmx47D/v6sQ7aQngx6W1VcbMTwAQjm1OeaTOySC6w4y5T2Zrqt4kGULhggL/tSSIhJsH4HS31L9L2Gt5lhkStci1dz8qCESkRf602TN08snvJ30YXd/lMAvg5a1/eJE9CS0y163bVbvQUQ4qOfezpMqyUiqjfehlAI5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901445; c=relaxed/simple;
	bh=XwfyhGg09HKqiv7zmaScf+pdUnoKEQvBL1rZ1pJG430=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VOghRW0xEpEF5lhElM1KhA+VxpGSx9/PS2A8s05BIhO7CGb91eve7DXRu8jxSpzVvnq8uqsBj1zUelUBG2sRv8zoOXiVyfLhnTkarSNP3vsVnvG9Of2QhbLbgI6op+U81CMeKeyOWMHWFRaOcdQPyO4Cmk+XEb2BRnpMCveWjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JilYNZfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD14CC116B1;
	Tue, 11 Nov 2025 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901444;
	bh=XwfyhGg09HKqiv7zmaScf+pdUnoKEQvBL1rZ1pJG430=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JilYNZfxLPmfHyaCTQJoVFJb3IeTwYf5amGNtREVrvu9EaRpy6VsL0dLlventvjK9
	 yOauQRBGWWXQ4+UweOPMHrABqf5oZdSGcLuLWgADsIMCVY6XxdBYqiVTF61RFoX36O
	 GjNy3499ULqolGFQRX1UhfcVnvD050TZvxWCJ7/SQtXj2OIpcpwTbhmTaQCw1ur1HV
	 GFX92QtmonljbCflEvGwXp9LcmOq4tUA1E0X0enULGbRN4WV+8CZyXwiiyRl8zcis+
	 GIx9HG5u/iEU6eYpwnc1xDL2jyuma6MPGwyQvnsZH+gyDsosaODx6PYLXus78Qc8Fj
	 oyCh64XDPOZRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C87380DBCD;
	Tue, 11 Nov 2025 22:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to propagate error from
 f2fs_enable_checkpoint()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141484.3596344.169057131556061047.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:14 +0000
References: <20251027063534.103963-1-chao@kernel.org>
In-Reply-To: <20251027063534.103963-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Oct 2025 14:35:33 +0800 you wrote:
> In order to let userspace detect such error rather than suffering
> silent failure.
> 
> Fixes: 4354994f097d ("f2fs: checkpoint disabling")
> Cc: stable@kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to propagate error from f2fs_enable_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/9e2d7d763a3c
  - [f2fs-dev,2/2] f2fs: block cache/dio write during f2fs_enable_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/ba4591f78dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




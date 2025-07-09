Return-Path: <linux-kernel+bounces-724265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C9AFF09F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A772416CE3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7224676A;
	Wed,  9 Jul 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0JK2x9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CED239E78
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084607; cv=none; b=aascX61JmPBgB9Do+lDFrI22iXI+tEbX0FprwO0h4Qu8ZQuLBZCdofQHkDEJGHGwa3Xm4uEgFruHnw54LZUSQ901SNd6kgiiPijAOJym2SMEA/sEW3DepqC+h9lWo4XMvcRLZ0xmlpSnn3Og8Dqa2h8kYTTgduCpFmEeoVL2n2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084607; c=relaxed/simple;
	bh=PspK8ujFcaUDrWOGcERuvoq46KpPQ2Uf1F/VNnPDiJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIFdK4zOXz6UAlbQ7aQUUOsL14c4F0gRmNwiAvgV7ZfmvyZOuvR1miiG8HJ9X3AAlOXYUgSM1VqAxj3BmZ4tzMuKP/iLwPXlOfy4yqImu5WgHOTIVR966/a3MMkx4H4/XfI3WARfXIO5+ydGGJSS4afif1VWfLn7Naa/0c3G+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0JK2x9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D07C4CEEF;
	Wed,  9 Jul 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084607;
	bh=PspK8ujFcaUDrWOGcERuvoq46KpPQ2Uf1F/VNnPDiJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0JK2x9rhYDWwEQs9c9Vf6PQt2HTPvooCcxVS+KfzoqIsqAjmB+RkuTXpmV3uN1tQ
	 YgeBCIdDIW0hfzJnAKg/eGWcjaTAO7mYTZDCwgjeZ0OP+f5RIgTAS4gTWxaNC6PC6b
	 vseppHCscEuUj6tS3SsGyT7Sa2s+VRIigbazEHlhI4U3CgesxTcauU4jsPW2x+x8Qk
	 vE0LV/EQyQyOGMY0ioye/R4nj5zGILFO0VnM4jb71MQZX073eK40OHZgHBtWYCBr/K
	 tq57c9n6XOoyEC+DlQyCxEvhDJ2ZNN9sJFe12JWQdz9++G7xkrtCAvRfEDrZe6bCIu
	 brgogaI+/Yiog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB004380DBEE;
	Wed,  9 Jul 2025 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: account and print more stats during
 recovery
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462949.806926.13437251978499582441.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:29 +0000
References: <20250627025944.152334-1-chao@kernel.org>
In-Reply-To: <20250627025944.152334-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 27 Jun 2025 10:59:43 +0800 you wrote:
> F2FS-fs (vdc): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
> F2FS-fs (vdc): do_recover_data: start to recover dnode
> F2FS-fs (vdc): recover_inode: ino = 5, name = testfile.t2, inline = 21
> F2FS-fs (vdc): recover_data: ino = 5, nid = 5 (i_size: recover), range (0, 864), recovered = 1, err = 0
> F2FS-fs (vdc): do_recover_data: dnode: (recoverable: 256, fsynced: 256, total: 256), recovered: (inode: 256, dentry: 1, dnode: 256), err: 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: account and print more stats during recovery
    https://git.kernel.org/jaegeuk/f2fs/c/55fc364b430e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




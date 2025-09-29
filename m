Return-Path: <linux-kernel+bounces-836839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B180BAAB31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C13189EB20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AFD223DC0;
	Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaXvzESq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8A2571C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185035; cv=none; b=NXYWzvCpPGCWuu86QP6keii8qnPOWfv6+YdE3xSy9L5XRcp1NIDz99rkNGwPGji5xzQqC6sxz96qz0sLHvpbPk634XIbm+KaefHF1P4T4Ed0bQUZnFY+az7T39DF/EB8XcL54SqQ13+2lbSpK2XH35HhMqHjRv/sIlI+9ZRN/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185035; c=relaxed/simple;
	bh=d9/rikFCFtg6s/2UoH48/W95qCDKZSprAcAWJzLDrIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HJvHIhEWBRQJ+0BDtzXMkr13XBnyatyZJ1JhbKLUSA3WtrLJ7SvNBhln81fb4/wE+Z1xl+ZK1gfDqN9JvXnQajSZ6/a3nDKZuHloPp9LSoQtLFvjclBa9mOVNnmEVxaRl8Rs8NXTQgY7zwmNDPe50KYfTbxBq1e2Y11qzpkb2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaXvzESq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7324FC113D0;
	Mon, 29 Sep 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185035;
	bh=d9/rikFCFtg6s/2UoH48/W95qCDKZSprAcAWJzLDrIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaXvzESqE0+QYJCyPTb1+okKXr0E3Hf43q1Sb7lFeutSQuf+8wykT9FgYH96lihaF
	 8etGBcKl9Ww4/9LD5nHdZZXPWexskRYTTCP6B6i494Kcbq+C4PtwmqdyRMwRbrFr+8
	 Np4rSeL7VQOC4TnjCspFCLVcwDidcWtTCspebS5iKWSqKvlpIl8dbVd6TXOpa8Q0pt
	 EiLUqVS35gZPprdJdPqf1geh5CPdFVmUz/C9eqMEQGi4gH38vKXgdUkX+OLv8EjpgZ
	 nizWK0xde/HMmQV+fobf9FRw/8PO+1M2DEEOvtRFFHQWnLzRI5mJ3xLKtAZkLYEOXq
	 rAMJ7MpK6L3EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4439D0C1A;
	Mon, 29 Sep 2025 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to mitigate overhead of
 f2fs_zero_post_eof_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502899.1733438.7787562060460882934.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:28 +0000
References: <20250916024709.4062265-1-chao@kernel.org>
In-Reply-To: <20250916024709.4062265-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Sep 2025 10:47:09 +0800 you wrote:
> f2fs_zero_post_eof_page() may cuase more overhead due to invalidate_lock
> and page lookup, change as below to mitigate its overhead:
> - check new_size before grabbing invalidate_lock
> - lookup and invalidate pages only in range of [old_size, new_size]
> 
> Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to mitigate overhead of f2fs_zero_post_eof_page()
    https://git.kernel.org/jaegeuk/f2fs/c/c2f7c32b2540

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




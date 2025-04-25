Return-Path: <linux-kernel+bounces-620893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BFA9D0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEC4A5949
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD21219A7E;
	Fri, 25 Apr 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4qDrxHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F561E32D9;
	Fri, 25 Apr 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607665; cv=none; b=rE5GfKHQQoIW0obl5it5euIFbGWx9mtbvwvHp/A3yRB1qtmZch5VrR4ix2w+9BBzHoZL2KzRvqmZsSpSQE7wQy0ohag7BzgtRH+UUNvsvMAxU4t5V/Wc+tLSHt4N1u4CceVm3IXl3OylwCMNeSB6BEjL17cRveKAGESkroYj7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607665; c=relaxed/simple;
	bh=+iGt+V5GHA1DlYPq1zz9QWmrWBPR93txyq3DdH2JeKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+BPRHCwRoqJlZJwKsW+yTo9x+zixGkfjhg5TIX0KMmb3FdnOQ4Rnh4PZzU5UJyG1dcZQTwkSKhsAsLBeQSDnmGanLZB2PRQXfDDBxldXzHkC+mRwg24KW1yC9heILEWSYpv+8jYaLPVljol/nQe+x7LLFSrhJtZih5sYj8n56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4qDrxHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B0C4CEE4;
	Fri, 25 Apr 2025 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607664;
	bh=+iGt+V5GHA1DlYPq1zz9QWmrWBPR93txyq3DdH2JeKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D4qDrxHwwT38UNKako63oG3V69TXGgDM0Qh6TgqyG5eR10bT9zL0Ho7lCSAy+0A7m
	 B73Ct/cIzDnRkpzfteFRna5iGTCwGGtctET6+ZrhYTJYYUBz0QIF0yswWTPvn3PCKi
	 seB4QgHAfgFrsUrbWbzawEdrTx6HXUS1BuukkTjB5A5drgnAo1SiiMxmPoILG49UVo
	 jHQr0PoWPzmXBxkNITM03Eg2X68B2ajNyDcIttq+bww733r7L5g3NRuBpa2lipd5No
	 AjqzM0IOuJpAcTkzodIFDFgXMJo0dzs3eIeDncYB90umf5iYT9utLHRIP5EPy+Tey0
	 G/KKN5HqHt1pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E68380CFD7;
	Fri, 25 Apr 2025 19:01:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: annotate RCU release in
 attach()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560770274.3803904.14574335432566097628.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:42 +0000
References: <20250423150811.456205-2-johannes@sipsolutions.net>
In-Reply-To: <20250423150811.456205-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 17:08:08 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are some sparse warnings in wifi, and it seems that
> it's actually possible to annotate a function pointer with
> __releases(), making the sparse warnings go away. In a way
> that also serves as documentation that rcu_read_unlock()
> must be called in the attach method, so add that annotation.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: annotate RCU release in attach()
    https://git.kernel.org/netdev/net-next/c/d57ee99831e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




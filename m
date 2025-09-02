Return-Path: <linux-kernel+bounces-797291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC095B40E81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5173A1B60FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F73570A7;
	Tue,  2 Sep 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmiWcB3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFA3570AE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844406; cv=none; b=W0EFUMepe2pb9NPD9XElysHG9fy9Hj5Sx5IaI1egK/CJfJd5EVwc5Ml4kbQ3m90zkDNK99j8SooI1TE1jVfjUM3W809twehPxt3aI5ZGLzL4Tslutn3hm0qixrK/Q5TiOiiLw2VYxn5LJAKFW2ozjFLS49ckmFdVGtUVrNGcn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844406; c=relaxed/simple;
	bh=a5xpJDyI0ZmkMroZh29UOG676SY5u7SLb7dCmmTu9+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DsVwktAjDwAYoMNLuSmES0HDKPw8JoSsACnm+XTAycdXhxj2NG6eGDwrUgU4KR10VzxlZ3Pskngh5gk+9ts0G3HR0OW4eeBs8kVnONrAIkHnEnTGK6AVTh7BzpXdl+agtJCHyUSnfyHip08eGefabrr1Y0eod0HFMa8x19V34LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmiWcB3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D333CC4CEF7;
	Tue,  2 Sep 2025 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756844405;
	bh=a5xpJDyI0ZmkMroZh29UOG676SY5u7SLb7dCmmTu9+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NmiWcB3IHJz772F5DpEGAcas6VNa8+Fkz0cWwJYTpPsFHcdGm9LSKNHOT3E6sljHG
	 9Zw3hiTzj1Sa7/U21AivFGIehnF5jo6I2tg7sAr45YzdSWJHKJ2mHivBuMk5bM523X
	 ne69b7UTaXNzWbop7uiYb+ia3Wk06CpVW9Tbgmss9bLhpVdnw7XSebvlVcWNKT2vGr
	 5AVcI7xZUBTQex40S6s2qga/6M4+cRW4bTjZveK9lRoCn2Xm4onDs46f7EqUIqoQXI
	 Xg9rdM8gt20ZNilLuhvmUCTSTBZ58wLAFi12s1CNuAHHIwqyXa5HShINl8+pKtmN8O
	 9AbSPRBAERtGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72A5A383BF64;
	Tue,  2 Sep 2025 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: Use allocate_section_policy to
 control
 write priority in multi-devices setups
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175684441099.425353.9345467792269228265.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:10 +0000
References: <20250828081130.392736-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250828081130.392736-1-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 28 Aug 2025 16:11:30 +0800 you wrote:
> Introduces two new sys nodes: allocate_section_hint and
> allocate_section_policy. The allocate_section_hint identifies the boundary
> between devices, measured in sections; it defaults to the end of the device
> for single storage setups, and the end of the first device for multiple
> storage setups. The allocate_section_policy determines the write strategy,
> with a default value of 0 for normal sequential write strategy. A value of
> 1 prioritizes writes before the allocate_section_hint, while a value of 2
> prioritizes writes after it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: Use allocate_section_policy to control write priority in multi-devices setups
    https://git.kernel.org/jaegeuk/f2fs/c/b639c20e748c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-817902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF930B58852
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FB93A4556
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EEA2DC32E;
	Mon, 15 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEZDq2ig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7A2D47F1;
	Mon, 15 Sep 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979004; cv=none; b=YukYfDeezZ1zYMxwJF5/IojSofUA+7BWY3sRTM+MQmklLBoPCxLP0Go6JeB2H+GKFSMAV/5Qk4tgDdWTVhYcUFGptvDhugn5e4g1owxDk2gWFCB+9aWEOo/R7DRnaeOenD4Gy7mt2yt9Rq6ZqI8IOi3/e2k1njeCap/+s3X3PdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979004; c=relaxed/simple;
	bh=yoQbZRc/nb2BJoeq+on6jDO88ZNiKxPAGxL/dcMOaNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PigDiK5Noo3d4c//015PxP61e4C9+WL58AH7ytHeLRwOuqZ85JvrOSega5Ykr06EwqlW7+b49c0yGhUFwifXjPVpegslBgASZ9uSXC32Vii0zcQiVh1XyHCkBle/6H1rJlcuhpRgLj7PF+TDjHrC1v7yKC6IXtYsI+0ggCjtXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEZDq2ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F05FC4CEF1;
	Mon, 15 Sep 2025 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757979004;
	bh=yoQbZRc/nb2BJoeq+on6jDO88ZNiKxPAGxL/dcMOaNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fEZDq2ig4Fb3lhzbXc/i6d4wvLFAcWkdx22QStHL/vhN6l0+Yv2kwGCDlgxSB/mr5
	 Q1XC7hItBMTeNDrYAoQPmMgVxDwkmnE37HKlymFWvprtKlc/X9Qi6K/AqVL5ZYuZ6O
	 74pVX4lzAMOvSzL2+QTD4pSvY5xYD4Hxji8uiTrFewb3fXPbUMdklF4UDJWC+aekyR
	 821ECkJ2A+GeoBK84hq8Mx5G1MYpnM97GzJTC+tSnrwEAf1Caqz8a4iyHiJd6amfhx
	 Y+GapMiCZ5fSnrz3ImBg2YCKvZkp70HsF8d9bL9NLERo7D9Y3wnyA990vNGwmG2NI0
	 QLXlMIx1QlYig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7739D0C18;
	Mon, 15 Sep 2025 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175797900575.527844.13813808525579188622.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 23:30:05 +0000
References: <20250912132000.1598234-1-o.rempel@pengutronix.de>
In-Reply-To: <20250912132000.1598234-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 15:20:00 +0200 you wrote:
> Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
> and the state machine drops the link. This avoids stale EEE state being
> reported via ethtool after the PHY is stopped or hits an error.
> 
> This change intentionally only clears software runtime flags and avoids
> MDIO accesses in HALTED/ERROR. A follow-up patch will address other
> link state variables.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: phy: clear EEE runtime state in PHY_HALTED/PHY_ERROR
    https://git.kernel.org/netdev/net-next/c/0915cb224527

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




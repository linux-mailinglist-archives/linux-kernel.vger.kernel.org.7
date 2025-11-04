Return-Path: <linux-kernel+bounces-883898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA4FC2EB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4537934B219
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126A21E097;
	Tue,  4 Nov 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsOGdhQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A71219319;
	Tue,  4 Nov 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218647; cv=none; b=cc6UCzp8MVRVc7mEq+ytt53F6QJ5qu2FhVbPRlUEM+Nq+Osv+hT8BsMcxmqqfWFklpp+fxdcpPjhXE9q3UsbOYg67rEhkXWLRnqCYuAwe3byXRrnVXbe7lnltavtF04+bwSU9ia/S0Oh4EurZEw0ouboaJh4DP4FC48anDQTMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218647; c=relaxed/simple;
	bh=sQjjqa/HmGiMh9TkeHExilCLSJ0OAck4vOmqSzT1X1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=COW1XAHCDpxyks2C1E1PGNdCMC8pdSm5ObMbtJNsNowiCZsd5CUwPRBQGlEgPiq7aIMe1//KbqTMC11WkS5LmRk/syC3dpM1F5BuoX9Y/CH4NoaOImDWeCp7ibMj64NC0SqDVrgd/Olr2eI15oXxE+aVD9v7pjLmnykTCUM5Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsOGdhQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BF4C4CEE7;
	Tue,  4 Nov 2025 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218647;
	bh=sQjjqa/HmGiMh9TkeHExilCLSJ0OAck4vOmqSzT1X1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VsOGdhQ7czrpcx4jQpk+S06sUomcI+WY9IU+dF45brGKjNWkNovxt9TCaU9HYF3og
	 I2b7m8pmAwgt5E81aWV8XIoDIrW5pTeAAND59QlqnvxcWVMolnkczGUwudW/NlJdMJ
	 nh7Zi8RAw4+YAeUIc8ANGrgLVVHJ2f+gZ4nDj4HwdUuLw+yelGCjpKyJ0YKhM8mFft
	 SVEOXixEW3CzWHCwF4qMXsJw+bT2+N3T5mj+BJnuMqcaj1UFzXj9clZwtRDZfUr94v
	 l4TOLB29GJa2QWJ+uTHa4mBmtmCa4u6kACOFuvBpt1RhL+WyHaFNd3F2VxVL8OKjUx
	 4U5XKag9LeNfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC23809A8A;
	Tue,  4 Nov 2025 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: dsa: b53: fix bcm63xx rgmii user ports with
 speed < 1g
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221862149.2276313.10187521899411726916.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:10:21 +0000
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
In-Reply-To: <20251101132807.50419-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Nov 2025 14:28:05 +0100 you wrote:
> It seems that the integrated switch in bcm63xx does not support polling
> external PHYs for link configuration. While the appropriate registers
> seem to exist with expected content, changing them does nothing.
> 
> This results in user ports with external PHYs only working in 1000/fd,
> and not in other modes, despite linking up.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: b53: fix resetting speed and pause on forced link
    https://git.kernel.org/netdev/net/c/b6a8a5477fe9
  - [net,2/2] net: dsa: b53: fix bcm63xx RGMII port link adjustment
    https://git.kernel.org/netdev/net/c/3e4ebdc1606a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




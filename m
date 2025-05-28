Return-Path: <linux-kernel+bounces-664644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E9AC5E86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 02:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B1318980C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1157F1C3BF7;
	Wed, 28 May 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoctNO1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDF1E8337;
	Wed, 28 May 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393402; cv=none; b=XiPj+bNI9mp+zGN0mAXjdPBiZiCJjceIRzvE4+3NbFl2r/WS6JzqkCBfqjr+NNbutFMWbvsLOrYS2afnWOP1FcffZjo+ITxga5SE+ATO8L/05EbNrRD+HbObBdCNEAzejroJjF42tOMoChW+toZzzoCXaG2APotcTMDmwNXyQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393402; c=relaxed/simple;
	bh=9De/m/VmFX2c33+DrVdD+ZWTZYXKbubLO87DFMkB6PY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bEtcy+Wn6KEYSvO0F900Cn4PjxSyCG89NBjub5ygDQZM6RFYcekcmHKxbCByYdEeeX5ywZZiPF9MdMzQgP3vLkqE1v+WMXKrMcqyezRXEO3r7tHciRG1EMnZatoxgGnE7N7XMOSSP8jeGxRMaDKPjFPWKYmniD2SbQEUA/raS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoctNO1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5946C4CEE9;
	Wed, 28 May 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393401;
	bh=9De/m/VmFX2c33+DrVdD+ZWTZYXKbubLO87DFMkB6PY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WoctNO1P2k5ldxYqJJzSFnNPL14vJPnIyzf0KyqV0j/SPGjY9DUNv9e7Yyp7jDanS
	 XDTRZqFezh13I0WYb9aabKy5mcOnTl9TXDyep3MElhv8Xk/5Pe2zL8iJXkUQHvo1fk
	 EHyiNXFp9pBdDRw1pz44TlS1rmkBhfTMVXWZJ03G7/IHJJuJ2hfNmiykgDhfxv/z87
	 Bkik9WdHXGm3MH3PrFskUMv+UPCX2aHG0zaannThbhbEtTZ1Is4rostk4OnAKdVQto
	 Q6VJsH5Ugw7aEf34aOGmIAeI7aCdrWaCPwULEup0P/z0bSmOXHLz1JDA7dPyX5FwnT
	 plQqsKziuA0eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0B380AAE2;
	Wed, 28 May 2025 00:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839343599.1843884.14163763070903616081.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 00:50:35 +0000
References: <20250523083759.3741168-1-wei.fang@nxp.com>
In-Reply-To: <20250523083759.3741168-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, xiaolei.wang@windriver.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 16:37:59 +0800 you wrote:
> There is a potential crash issue when disabling and re-enabling the
> network port. When disabling the network port, phy_detach() calls
> device_link_del() to remove the device link, but it does not clear
> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
> network port is re-enabled, but if phy_attach_direct() fails before
> calling device_link_add(), the code jumps to the "error" label and
> calls phy_detach(). Since phydev->devlink retains the old value from
> the previous attach/detach cycle, device_link_del() uses the old value,
> which accesses a NULL pointer and causes a crash. The simplified crash
> log is as follows.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: phy: clear phydev->devlink when the link is deleted
    https://git.kernel.org/netdev/net/c/0795b05a59b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




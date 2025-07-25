Return-Path: <linux-kernel+bounces-746447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21EB126C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC50169F63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727025DAFC;
	Fri, 25 Jul 2025 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnztQay8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2525B1C5;
	Fri, 25 Jul 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481828; cv=none; b=AwlNHLOOeWUAzSFed8t2cDLlwofuiObiI64w7KmORQFVOHSwuuyuuLEJ/qmNBuJj1Lpl6nt5zdwqgCgUNPnROCjmiO/i+ZLuWYKlvT0FThGC+9GKIqb9Ox8o2MiKddWFOhmZ5ynFFEcU2kYJSYrIW+NYtMwAzKZTUTi98ehBgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481828; c=relaxed/simple;
	bh=G+iwqFC5dV8xnfd0/OzbXvKTku7ogLqvVCr5bvOryK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=urHKl5sf6TJimz/ZLFiQ7wSY7L2rKabuUf4wh5GOGeKxXxbj3dMcIZMtO3hsTZXG+UYTHH9nHqRSOL0eTj4TU95vpwQulmUuoygxwvzmViSoKvqGAMB/pgFsY7kEuNBhxEwOmiHKFfJVY8yAPGqH9jCHDkeRKb8PjJg4YU3wDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnztQay8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F9DC4CEEF;
	Fri, 25 Jul 2025 22:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481828;
	bh=G+iwqFC5dV8xnfd0/OzbXvKTku7ogLqvVCr5bvOryK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HnztQay8hq/Sq/sC15dOqqnKLayttHPlyuhvjwdF+7O2g/ZVOUYK7bztIyesGd/U1
	 elTmoTwyb1buRdwzUBNncbhSkVJ2iahztXj5fmqq9AXdPn9jBYvTsrTnLW3rfdVrdy
	 dZlanQqKwHLxqUD6OduWGQ7gsWa/jB3IwFw7sz9MpXSewl2hKTBAT+I4yst5FJ9iKP
	 IjG392HVJejrQSNPQNMoqb0azoIlo8mRzYbZGy3N3AuGPM4dHwDuoOripOmJfDeYdp
	 wIZbDxw+oAdoPUVlVULWSbH6XDEbeZppZY9vvAE566F+TIHWXAdD3+tjx0IUv8l6um
	 I5JAdXwsKxcGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC7383BF5B;
	Fri, 25 Jul 2025 22:17:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: Fix wrong rx drop MIB counter
 for
 KSZ8863
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348184625.3265195.11254168994725323739.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:26 +0000
References: <20250723030403.56878-1-Tristram.Ha@microchip.com>
In-Reply-To: <20250723030403.56878-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: linux@rempel-privat.de, m.grzeschik@pengutronix.de,
 woojung.huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 maxime.chevallier@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 20:04:03 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> When KSZ8863 support was first added to KSZ driver the RX drop MIB
> counter was somehow defined as 0x105.  The TX drop MIB counter
> starts at 0x100 for port 1, 0x101 for port 2, and 0x102 for port 3, so
> the RX drop MIB counter should start at 0x103 for port 1, 0x104 for
> port 2, and 0x105 for port 3.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863
    https://git.kernel.org/netdev/net/c/165a7f5db919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




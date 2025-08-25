Return-Path: <linux-kernel+bounces-785700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77288B34FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419EB17C68F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF542C374B;
	Mon, 25 Aug 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQajfwi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7E281372;
	Mon, 25 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165201; cv=none; b=TAHFdfP+zCVD3oEKzDb38LsLrTMPmnu6jsdcghbDnOOj26678f+79OmpwnWlBOFUMUbe3DpEVgGMLTRc8ffW8taNg7lPYBQwdC+N634srAlRYVBpvV+mb224gnpkNH599G6DGtar/83dUEpNMdxvr1EpPg74QPB+PaQSylGzMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165201; c=relaxed/simple;
	bh=np5RXZXhqJHUQt9m3vQcrFk1yiIKrTCNgrCneks2M8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MVe7ppTQCyu9wYzyYe0brTFcqJ6/VyWvwE/cRTQHauH+8QYsODXhRrsbU+3bLOMfc0nobWMAPRLOrpiCEj5/5eVIpMrwMLPN+y1vNTfj1ST9Jch00wroYmnb9WY/I8Mk6R2hqdl/Mok+8HvS8oNp03yYXrHfIO5JzsHaRDhBTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQajfwi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E817C116C6;
	Mon, 25 Aug 2025 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756165200;
	bh=np5RXZXhqJHUQt9m3vQcrFk1yiIKrTCNgrCneks2M8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vQajfwi0iQO5CO9JsnQFMYZdFsTDm2saGDeAoxpLwMNyZfo47WaLxyFJxzBB633Um
	 jhPcPsK0A3JwCqrKkGZzrZwQSWqoxXdaq0fON6w5Axq7/+Vj1YH4pgovIf+6uFekyh
	 iaE1eLM60qnF/NyF4N175AkiRGQYnqCNGxL2ot30vAXz8eB5O5W4+sQr5v00pNN9tc
	 oTJ1h+rTJ3rVGQi2ltm6mI1LGCjoRnvXntlGrfDnfyAa2sUFjWKmSzgF/YqC6ujuBl
	 h1qdPRSnkLyMamsVI2LAZYduu6dlKZr6Vsu1ZGhBjwgjIwca0/FfupICKMRAcJivbW
	 2PP1GoqUCM93Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2F501383BF70;
	Mon, 25 Aug 2025 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: add support for
 generic
 net selftests via ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616520774.3596778.11014331482761333100.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:40:07 +0000
References: <20250822092555.2888870-1-o.rempel@pengutronix.de>
In-Reply-To: <20250822092555.2888870-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 11:25:55 +0200 you wrote:
> Integrate generic net_selftest framework by wiring up
> .get_strings, .get_sset_count, and .self_test ethtool ops.
> 
> This enables execution of standard self-tests using
> `ethtool -t <dev>` on LAN78xx devices.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: usb: lan78xx: add support for generic net selftests via ethtool
    https://git.kernel.org/netdev/net-next/c/411d7d70cdbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




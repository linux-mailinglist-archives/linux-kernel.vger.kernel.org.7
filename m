Return-Path: <linux-kernel+bounces-855422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B7BE12B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFDD54251A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8461F37D3;
	Thu, 16 Oct 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKLKWuRq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C9134BD;
	Thu, 16 Oct 2025 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578222; cv=none; b=HwhX55uankCzUbKHuoKLuXfIa5fIDPsLsPz7aGqZFG2wd8iRBTKcG60Eah/aPA3JN5D+ikjNyqr6OofHBfY0VrJO9WJvBY4uo2cAFuA4m8tbg12q+eLBuH6HBgt9l1Wk0yeiNTZk8vedVmT9MGaFUQ8ijavDA0vrmLTyBYogjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578222; c=relaxed/simple;
	bh=qPAF4tCa5lAk3X9LnjPJR3cSn3nx/PwYPEI7ZMhNI2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LD6H+axcm53Y0eL7YGICsRwGSiQK35ayyt9RqTTCnoQx1tRKGNE5jfhlQuzL1Bi+8w7uok/GOJlxQ2JxBP3adIOGLO7OekMTEbfp48WFboDHvoGy8Ie0dbEuHe8gOhj6QBLxEyrK+jXiN9XP6GgWPSnE2ORO6WYOAHvaVkWAgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKLKWuRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D456C4CEF8;
	Thu, 16 Oct 2025 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578221;
	bh=qPAF4tCa5lAk3X9LnjPJR3cSn3nx/PwYPEI7ZMhNI2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fKLKWuRqhj2j39QB7g253OTrriaQvD33qAZnw9Sk67p1648+deWaX7XyonwYPwo4g
	 WxyhgeT9X3sM48LeGfKp/sZYZ342AF73fPYFWBKfnhS0JsCJCq9zyarzHXq/AVWOFq
	 rvvpPORWU6D2xy29ZJBSsief7W8RYoO7ph+IIe8uPll0hYlOy4aiq3zACT9tYDqzc4
	 wxmA3/d7OlXBnAuvOTbqtRalM6lOkARsaqa1NoP05gaGd/8YIr/9LRPmQUW5AXscwI
	 yvgufp1dB3fGIZ+MzkAuO+qLp2kMbPs2b2cFQwDanRgrZH56jcExur/APrToHa0UTg
	 03YNFKy7J4RmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF8380DBE9;
	Thu, 16 Oct 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized
 dev->chipid in lan78xx_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057820601.1123450.11047692270273394800.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 01:30:06 +0000
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 khalid@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 23:46:48 +0530 you wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>     lan78xx_init_mac_address()
>         lan78xx_read_eeprom()
>             lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset
    https://git.kernel.org/netdev/net/c/8d93ff40d49d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




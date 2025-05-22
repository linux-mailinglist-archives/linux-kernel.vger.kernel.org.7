Return-Path: <linux-kernel+bounces-659221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B9AC0D00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036881BC1E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A028C017;
	Thu, 22 May 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyl08utP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5B3010C;
	Thu, 22 May 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921203; cv=none; b=ARfHWW3bAMPcfBYC9MeTj9Z9FVV4En9p2NvrArB8dWgfNg9bncCSzEZCfGJnEaWjz1vHkeKVAPLtjPzcNy28L2sQsQTUz95QNBCk1rtJL3/JnZmTZ+NY0yDoyfn6tJgiB75SMAIzE1ZCSNOj4jE0javd0dd7Wn1S/Hjrm3hnFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921203; c=relaxed/simple;
	bh=iUCQCYd6as19uTwSA890wnNEr95EHckro3Xf9ezf0qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDoTzZZTkktBDoIkqX4O0PS/YFwuj3k9klOfAjds54uhW1MuFgsNZfHDwHlm+q+DEDwIt/hQ8og8IDEpjllVHmAdBQc98pY4NkDLPeLDr3edoVh0HGDpsYfEg13WL851A0ErbYzUW9XDJjlt7uoo1bUrGWBLru+vfAzOmAkieR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyl08utP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D372C4CEE4;
	Thu, 22 May 2025 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921202;
	bh=iUCQCYd6as19uTwSA890wnNEr95EHckro3Xf9ezf0qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tyl08utPLLoNQvILkEKXzTTs6aYTUxRymGYHAjNE8Xr8Nm6covXegYejJHLyews0i
	 s7xaijzYwBPiZ2yDnKyvJaoDbNs7xeTDuvCjqFFhM2R+AEM7m2ITqXBFBE3IP/Ilm0
	 PIAJxLzaFUMgDX/jn8YdYA2jKJvgu2S4WGRb/UW7QhK70OmXiwW1D39uxZFOsEuy+e
	 NX1IMXTTrWYlmVH8jTPRMLWeE6fIUwitjAd91y2Ve8G2n+ZnyCaNYb4QN1oRgMCOj5
	 vB4I8pakBcRSy1tndkkWwMIP860XvRj4eXoYjBicnS1Z6jqmcBwxpNMTe3z2Pv3GCP
	 cWIdRWUUQrZIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD903805D89;
	Thu, 22 May 2025 13:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: Add support for providing the PTP
 hardware source in tsinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174792123749.2878676.12488958833707087703.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 13:40:37 +0000
References: <20250519-feature_ptp_source-v4-1-5d10e19a0265@bootlin.com>
In-Reply-To: <20250519-feature_ptp_source-v4-1-5d10e19a0265@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 richardcochran@gmail.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 May 2025 10:45:05 +0200 you wrote:
> Multi-PTP source support within a network topology has been merged,
> but the hardware timestamp source is not yet exposed to users.
> Currently, users only see the PTP index, which does not indicate
> whether the timestamp comes from a PHY or a MAC.
> 
> Add support for reporting the hwtstamp source using a
> hwtstamp-source field, alongside hwtstamp-phyindex, to describe
> the origin of the hardware timestamp.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: Add support for providing the PTP hardware source in tsinfo
    https://git.kernel.org/netdev/net-next/c/4ff4d86f6cce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




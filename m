Return-Path: <linux-kernel+bounces-757053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2CAB1BD05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051DE18A45ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930C92BE641;
	Tue,  5 Aug 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxbTJ4SU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD22BE620;
	Tue,  5 Aug 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436004; cv=none; b=p3+VX5fUEzBYWTPlzjK9y+g6+p0OLz98741+NblP8eeug9tBjqOTxz8lHxzoQfQAaAIurV6G7QYv6rsWf8WUXOsqOa0q4GvOWeGEzb/quFNvSSTHi7YcGPT33U5rZz8QzSCkh6n6bUc59CNlAFuNyb2P6FO7pa/A/EXo5b8iAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436004; c=relaxed/simple;
	bh=hpu0rDEYKsbZSgSJJ/g1je8ZHvOvgza6/VNOnD84krA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqBwMaHhPS1pueycUcOwITi3ZKhRwSyjWSBequItl4GZAq3MnJB2Sl/qDTaNAQhccAuhQOZuCRlK66p5stRRgVenYxcAXy24H5LwDSU1Se4IPaS/Au0ZnhOHUzkv4QNVl0y5PJcE/vJXK4P0dxXBX+NkkFQCTzQ8FCxzEsb7rc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxbTJ4SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F6C4CEFB;
	Tue,  5 Aug 2025 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436003;
	bh=hpu0rDEYKsbZSgSJJ/g1je8ZHvOvgza6/VNOnD84krA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZxbTJ4SUplLgl4whsHZTINcJmPZWNA04nVkuussQvqHu/jv1vYN+tE00v46kVQlb/
	 mXEMzJL2mtdJiGWL/mv3jeG38iGUGCgJMhCaNoKEkQE1lrjaEY8NXSGT7zTHo8497Y
	 xCD5M1Qky1d3XVs4JzQn3c5juxyCLAhnzdtnk2MfZsbD2rCMg8HGbS14Mr5TQ4nZlR
	 t0ynVBx2FdoR3y+s+CVtmYKMdreDefXu1DzFeQvWLOAvRzRSPBGx+L+JIHdwd0i2nU
	 maHypBtH4f6k54Tit7GotmjiJca+dP1C+mz4+cyEQ5t9UIhasXE7WTL+poTnUgHDEQ
	 fPSW9lj9WK4Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB9383BF63;
	Tue,  5 Aug 2025 23:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici
 emails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175443601725.2197607.8223334448564027919.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 23:20:17 +0000
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: michael.hennerich@analog.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt@analog.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 13:37:59 +0200 you wrote:
> Emails to alexandru.tachici@analog.com bounce permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace him with Marcelo Schmitt from Analog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: Replace bouncing Alexandru Tachici emails
    https://git.kernel.org/netdev/net/c/966c529aa177

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-799506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BDFB42CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B88546AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992022EE274;
	Wed,  3 Sep 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxIhqxa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3E4A2D;
	Wed,  3 Sep 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939205; cv=none; b=ubQs+lwiN9Et9F2pgNQgZ2Cl6bDuf/oQk06RE3LWqbOA5aJLTjzelxdiIKevq4J9IUGIE9dEYg58qtg0OJwGXL1yPm2T7MJXxZ2D3+tgBhIHpINT/NtG8HnEiPvoqcYvVUa1iH0/gEM4d36Cw67GcxxHe3em3KNxZAPj3jOWK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939205; c=relaxed/simple;
	bh=/E5Zj/BgMYUYauQyehlWEkdZYsK/ulBZEgIkhcsOnqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJLHV7QdyZDxH1nsrIvtsE2iciFo8Q9N2gG48JRPoBSN743l8Ux0V127h0eDPdfp+WzY3JkOoozZQlQ9dK7JlKKABraCT6ns0TyMmpG2Uyn+GRRYDHc4v4664mj2pVOTJEp1GNQWjSa7Bx+j9ROqBdaPweNBi+mazzTQsHD9pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxIhqxa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC2CC4CEE7;
	Wed,  3 Sep 2025 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756939203;
	bh=/E5Zj/BgMYUYauQyehlWEkdZYsK/ulBZEgIkhcsOnqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UxIhqxa1ctx5OutYvCteapR5w1Bx0s2acUWHdxFqNpQlEcAhd7Dpu5YRVXLuYxwJT
	 dJk0dQdx9b8eqFGnGCH8T0ORVBFU0N0Ng/oJXwgMs4bp98BLDm8490ncOQzuXrK/cW
	 47KJ1UG+z/alWfHvw871WxiWHvGZXtJs4hWBesDTNZlvrq/93T0qvEpcFKpByr2TxE
	 LWhQUOxnw4ScX3VQQR+1lv3R6Z1EhXobRSS+kFY/YWXpoLN2cVdnIV5QLOZ2MAClFF
	 JbV0wtYfpeud+EBpvT3wiSvu0+5Z1nVHVUgdPpSGoXTc0atdUD1d1IZ2mXulGjEwAS
	 gQzznvxmcKQcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6DC43383C259;
	Wed,  3 Sep 2025 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rust: phy: use to_result for error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693920825.1224224.13952038246418907969.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:40:08 +0000
References: <20250821091235.800-1-work@onurozkan.dev>
In-Reply-To: <20250821091235.800-1-work@onurozkan.dev>
To: =?utf-8?q?Onur_=C3=96zkan_=3Cwork=40onurozkan=2Edev=3E?=@codeaurora.org
Cc: rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 12:12:35 +0300 you wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/net/phy.rs | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> [...]

Here is the summary with links:
  - rust: phy: use to_result for error handling
    https://git.kernel.org/netdev/net-next/c/a7ddedc84c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




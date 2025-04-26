Return-Path: <linux-kernel+bounces-621284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B591A9D73A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 04:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5814A4E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB6200138;
	Sat, 26 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEdvUXPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345E1FF60A;
	Sat, 26 Apr 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633995; cv=none; b=etsgmPvnrnYBf/ehCR0m0jnznxaCDKTacucw7b23L3dV8yiT2Bxvy7LDy7H+/AbRwhDrJWjNQJnZe8tXsgDR38qTXGwzZ5wVTR5ntozkJh3K1EJ0W1WnykaUrUVWgh39R0jAm7MvsWjgL1wdyIQ7uNOJ7GeEJ4hZ6BvR0fkpNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633995; c=relaxed/simple;
	bh=Iss9/F8ysh7Nj74llcoIoLu0cjF85nogcjM3ps/8aOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LNnvKnjMdDqI8U7IsoyZBbEk587tvEftdyGQTxfd5Q4Ek6C3R87unZesfUZ3+R9LtloFx80KyI82N9pgyleH90tQ7icxRzvbZrOqxM2Pttmq0+ttoKcbUFWS/mKcCw9AM2AyTVNG96UbIB4WuS0RRINqQ/ek8H72yLKHT7U/AEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEdvUXPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4EFC4CEEA;
	Sat, 26 Apr 2025 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745633995;
	bh=Iss9/F8ysh7Nj74llcoIoLu0cjF85nogcjM3ps/8aOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tEdvUXPd4orT7qKMAcKERL2CpaBFmue7/2U7W2emfKePsiltdSGMGJ2zcfpIN6rdT
	 s5Zpa+zpVipKr3yhwYyQLZpLaMGQdmz8A5UJT1qGNLfPK+IFLewsLpKGsazvlDhp5q
	 97kBhQazYZgdtWYaUFGDtgEUQxMARPIE+cxW2+9F3AMeIUzBJpxQ/sdBcgmpY0A3rA
	 tRIHINc5+rZErhxvuXoySiFC1QeYhh7zUVIpfM1GDd+54N3ebugzEd1MRCvHkDIBI2
	 1ryKAT3Bfwb40g1cj757aJ0nTA+PjlWnjho0KHJXPSjlUQ/zkecbnQymIZe+k8SFct
	 8IHUbDWucWMYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAE380CFDC;
	Sat, 26 Apr 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtase: Modify the condition used to detect overflow in
 rtase_calc_time_mitigation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563403387.3902866.14183742832431815593.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:20:33 +0000
References: <20250424040444.5530-1-justinlai0215@realtek.com>
In-Reply-To: <20250424040444.5530-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 12:04:44 +0800 you wrote:
> Fix the following compile error reported by the kernel test
> robot by modifying the condition used to detect overflow in
> rtase_calc_time_mitigation.
> 
> In file included from include/linux/mdio.h:10:0,
>                   from drivers/net/ethernet/realtek/rtase/rtase_main.c:58:
>  In function 'u16_encode_bits',
>      inlined from 'rtase_calc_time_mitigation.constprop' at drivers/net/
>      ethernet/realtek/rtase/rtase_main.c:1915:13,
>      inlined from 'rtase_init_software_variable.isra.41' at drivers/net/
>      ethernet/realtek/rtase/rtase_main.c:1961:13,
>      inlined from 'rtase_init_one' at drivers/net/ethernet/realtek/
>      rtase/rtase_main.c:2111:2:
> >> include/linux/bitfield.h:178:3: error: call to '__field_overflow'
>       declared with attribute error: value doesn't fit into mask
>     __field_overflow();     \
>     ^~~~~~~~~~~~~~~~~~
>  include/linux/bitfield.h:198:2: note: in expansion of macro
>  '____MAKE_OP'
>    ____MAKE_OP(u##size,u##size,,)
>    ^~~~~~~~~~~
>  include/linux/bitfield.h:200:1: note: in expansion of macro
>  '__MAKE_OP'
>   __MAKE_OP(16)
>   ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net] rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation
    https://git.kernel.org/netdev/net/c/68f9d8974b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




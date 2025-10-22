Return-Path: <linux-kernel+bounces-863981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C07BF9A65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4664FF4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76585221F00;
	Wed, 22 Oct 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYyzoQ9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0F201113;
	Wed, 22 Oct 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097840; cv=none; b=ISqBHqPlZOQfgm4hFYLac3KHo0THySeEi8PiWZo1JHX5qqqA5M3+hHuPWFtGNdVXIRg29MR6/DYaXBEbPLhk9VTCQZnCTKNTUl5wJB2owucUv5YP4xnUwM1FvMa0MJXHAQd7/WRLmtdQLYnHTh8CVnAbOabXS69cepOcHGCrkS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097840; c=relaxed/simple;
	bh=g1H3vfd0ItlDEmCaC+S/5OdME7Lz4rA1NpEFbqw11NY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iab+DRrgAt2x7RSV3cpjvWw6RXsm+x0zUdv5xOgt7jCk5pI7c5NFKrprnQEdpWPpSELYGmbAmYF/9ZMq62jfwACfRpiyzQKPv6YgywldP+wU9jzj2WEd0cR6ZRHtZUjxG8pUegtxvguJf6jEUdzdhE44g5ZvntQe/fgmtyk4jDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYyzoQ9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A02DC4CEF1;
	Wed, 22 Oct 2025 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097840;
	bh=g1H3vfd0ItlDEmCaC+S/5OdME7Lz4rA1NpEFbqw11NY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYyzoQ9BTUZyrVc6SevPqOKu6lwPUc6A/k9Iyx2ynB5OatRN9ZZ/0heRUgM9Taxoy
	 Y9ja2TK+hNRTzLp3SI07F02cc4yFO9QKYhPH3sj5seL1omHz4rQtt1T6OiV++UqssG
	 KdJmrf/OPPX+qKF72QS8w71J1g4wjUfth5bsL5B+tX51VHFUXDxKm5UdAYM6aqRWIV
	 aacJTo191G8VHsjJp+zPt8f93PEXs+2ecQVp515HhSyKkor3571VQ5p6NocFY7agLp
	 57aKVjguJSdzJVukb5dq+OY1FHNR/fcDg9n7+h6fsRMsdKmhJUNHaDd6Pq9uFm4n6a
	 7kW8qKW1mkxgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7D3A55FAA;
	Wed, 22 Oct 2025 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: macb: Remove duplicate linux/inetdevice.h
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109782149.1305042.10173858234581566767.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:50:21 +0000
References: <20251020014441.2070356-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20251020014441.2070356-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 09:44:41 +0800 you wrote:
> ./drivers/net/ethernet/cadence/macb_main.c: linux/inetdevice.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26474
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [-next] net: macb: Remove duplicate linux/inetdevice.h header
    https://git.kernel.org/netdev/net-next/c/962ac5ca99a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




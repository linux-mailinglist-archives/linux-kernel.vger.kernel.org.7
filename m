Return-Path: <linux-kernel+bounces-874965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B2C17DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008A1189E7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDB2DF13F;
	Wed, 29 Oct 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqo+0IiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EF28467C;
	Wed, 29 Oct 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700849; cv=none; b=mJVj91YTRdwB37or25LWc0J2zeuY7YnH81BplQV7PVtGgB8ZaWLM8FAqFySq/4qvz2QtpenAH035eoP7IVkKUv6zYRKepQ5bT5KStglR8CVlVL6QqFBRYY51xP0EMhAm5Rn00tLNzC52EmQawIXwQL9Ydqnsllb8P8lcoRrahYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700849; c=relaxed/simple;
	bh=9ZqcnB1WevY+HG627LutBAc/aEokx5VVBtFlplNEhs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxQ30kVX1b+x7cxXXu1kSEWyCPCnCW+mSpVf8o4uEtaG2VpNDTJramTXym7sJLFj/A2DT/P6IxO6AW8NFYiFXg7Y3m7J4ReUp/Xf8USIXop1gGXynA4hVuZdg+lBrkFT5FxT8uMkH+Pb8pt9hYFmYwnHb+YFEnKBu3kZlSvf04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqo+0IiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F2C4CEE7;
	Wed, 29 Oct 2025 01:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700848;
	bh=9ZqcnB1WevY+HG627LutBAc/aEokx5VVBtFlplNEhs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xqo+0IiBUU7IjRPzGNI6BH3v8bNqA78jY4v/BFedgyZR8bgIjalo7ZvH3GOXyZTdk
	 y+YT1idiOMdcxKL2GPO3U8eCukv4hd+gAvFCSL2cZ47FpZNLcNe0fu+4ryOBCchl2x
	 0533y29arDaj4OQAA849YabkxowKMNGNkKUypatYX5lJgqkD/qx/0HJJGOradG83WS
	 J3CzWdrpwRT+V+s2Vc4EUMpJu9+mmYkhWNWItKi7AQm98OCf5HKIdWdKnDEjfKACnl
	 TpPcpd2ySPDiu0EesE0/faODDUPnW90WA2jxLvFjHo1b8mZ7v4QjsCdvAhU4c04VSq
	 cAOJlvvKrCPbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF439FEB6D;
	Wed, 29 Oct 2025 01:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: tcp_lp: fix kernel-doc warnings and update outdated
 reference links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170082599.2452213.4489623733769266836.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:20:25 +0000
References: <20251025-net_ipv4_tcp_lp_c-v1-1-058cc221499e@gmail.com>
In-Reply-To: <20251025-net_ipv4_tcp_lp_c-v1-1-058cc221499e@gmail.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hswong3i@gmail.com, hlhung3i@gmail.com, khalid@kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 17:35:18 +0530 you wrote:
> Fix kernel-doc warnings in tcp_lp.c by adding missing parameter
> descriptions for tcp_lp_cong_avoid() and tcp_lp_pkts_acked() when
> building with W=1.
> 
> Also replace invalid URLs in the file header comment with the currently
> valid links to the TCP-LP paper and implementation page.
> 
> [...]

Here is the summary with links:
  - net: tcp_lp: fix kernel-doc warnings and update outdated reference links
    https://git.kernel.org/netdev/net-next/c/5c00da851c31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




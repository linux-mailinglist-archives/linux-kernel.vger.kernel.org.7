Return-Path: <linux-kernel+bounces-869703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40FC088A8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF34E1DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7E2459C5;
	Sat, 25 Oct 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud4LwMt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEB23EABD;
	Sat, 25 Oct 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358259; cv=none; b=ohiqb3oCpTD8A0Xt94ZjPo3Id3TaWvLJ9ePuY4encw/ybiU7Xn+QRsUNtPL2rzWfFDSZzoSbpyfds9phbIp79+U8tZFtoFWOAwYBuQKBfIbrX70uiZBzTtEUq/AD98zxsIZhaAwbaNcv5mohuMwxa5Omb5vQmjquYgxpe2oGO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358259; c=relaxed/simple;
	bh=yT1Eud35w8rmJLNEacHmCbB6c+KUfv6JmDa4ROm5V08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDpFxERIcjFuJkTBGxZ1861YaEL7PL39RHtPzaZLRxz5Oya0evVQ0vf1NMB6/ihoIxr5MhW6BSzhVcfa0hJlKqTuJM8C70KJo8Qj/wr/Cg9wM6Cc51PXDGshSzZohc5jVBBswaxl6igmx5GqGIhikiSmq2mIUOau4MQSMXWrNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud4LwMt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B037C4CEF1;
	Sat, 25 Oct 2025 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358259;
	bh=yT1Eud35w8rmJLNEacHmCbB6c+KUfv6JmDa4ROm5V08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ud4LwMt72+zzyRHvCu4fYdh5ndh4mF6DrgMKOza+r7ukUyWfd2YFYhny2ee0DDjiP
	 UBfw0zeUTNPhzQeyCLmBIyl0drxSAWOA7L5tLVtIjOoBnFZ6AsyROyq1X3ovnqIUWg
	 ZOmGrXWXTcZDU/y9r5o7XErMMg58ygCQNGy9Am0PewNsAZR4HWsW//m4upYs3QaQih
	 xxOQSgAm3cX/nzfcXhF8fcsQ+kOS+gZwoaoSnYp0t3Bv/TttR1dEsQCaC8xCVw1fQb
	 2S1QQwJ9a1eMr9FrJQRqbHgCeFSG7LNOFBQxCnCUUfLOEcV8+9g1ZygYj/2JybpXh3
	 cEq/eKKbQuYEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CC8380AA59;
	Sat, 25 Oct 2025 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] strparser: fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135823901.4124588.12304678364483093377.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:39 +0000
References: <20251023013051.1728388-1-Julia.Lawall@inria.fr>
In-Reply-To: <20251023013051.1728388-1-Julia.Lawall@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: davem@davemloft.net, kernel-janitors@vger.kernel.org,
 kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg, yunbolyu@smu.edu.sg,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 03:30:51 +0200 you wrote:
> The name frags_list doesn't appear in the kernel.
> It should be frag_list as in the next sentence.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  net/strparser/strparser.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - strparser: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/d0d2203b9ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




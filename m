Return-Path: <linux-kernel+bounces-703515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4803EAE9153
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 00:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3710C1C27F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFFA2F4A04;
	Wed, 25 Jun 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSWHzHbh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353612F49E6;
	Wed, 25 Jun 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891828; cv=none; b=h7vKjlnPgdtrVsJ9BwIVNf71abAgU8TY8b4Il561KQwYoNvqWOhBfIuVj6IL30MLY+BkedfQnygxWbstt+UigekAjMnEebFmcvwHMXgjxpWt4JRiZpGua5MV04ww/GybrjXpsxlDTTV70LTgoIUEe3deNWxhGHVey3P1N14WX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891828; c=relaxed/simple;
	bh=EeIIx88KxbIwDqyUp9KTPG/NWGit+rGuf50o9X8FrSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvhxxnVoZ0ZtoDGLz88Qzufp3feJYEB83p6aP05O6nf8NU2aBScLOARSnwUEJcLbQDc6UIZVTSnFHRvP9ksOD96mqid7BXM/+A07mx4PEun8X/Yi/5KLPYROlJ4oSmSlDCPosvOSCzepzwpLaj31UYrUrgXSUQu9a8xc8vBLqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSWHzHbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82FAC4CEEA;
	Wed, 25 Jun 2025 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891827;
	bh=EeIIx88KxbIwDqyUp9KTPG/NWGit+rGuf50o9X8FrSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSWHzHbheDb1NQgBEOLbEnEnzA/6TPzCkzE3RptobQ3P3FPMUKbncbbxut8cdAKwS
	 8YxM10Xi13ZLwyjDS97VvP989oEGbC0eWoBvsMefns5/wgte1VNXcMjxUAes4OJ8gR
	 JezrdqJeTpyCpI9gqw6AIRwNtjKcAJa0UkWLU8AZU4r/BTsKZi5vDEI/B6US6zd9z1
	 P/5IIBZkPScVnbPytFxhXgTX/dn3YFwcxu76H6iSJY7P20N5Sge5mPMED/1VraQ65i
	 LmflcqV6aoXPSziGzpwQdwYyAyY/ugpBjbPD8ZZjvPufbk7DS1vnzR8s0PjCl6buSh
	 XvOawIiOmBS/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D983A40FCB;
	Wed, 25 Jun 2025 22:50:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089185399.646343.13396735096193328085.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:53 +0000
References: <20250623153147.3413631-1-sdf@fomichev.me>
In-Reply-To: <20250623153147.3413631-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
 syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
 syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 08:31:47 -0700 you wrote:
> syszbot reports various ordering issues for lower instance locks and
> team lock. Switch to using rtnl lock for protecting team device,
> similar to bonding. Based on the patch by Tetsuo Handa.
> 
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
> Reported-by: syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=71fd22ae4b81631e22fd
> Fixes: 6b1d3c5f675c ("team: grab team lock during team_change_rx_flags")
> Link: https://lkml.kernel.org/r/ZoZ2RH9BcahEB9Sb@nanopsycho.orion
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net] team: replace team lock with rtnl lock
    https://git.kernel.org/netdev/net-next/c/bfb4fb77f9a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




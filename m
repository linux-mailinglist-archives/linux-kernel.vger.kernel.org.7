Return-Path: <linux-kernel+bounces-615342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F3A97BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856963B36B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037A2571DB;
	Wed, 23 Apr 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYuvIlNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788E2580C9;
	Wed, 23 Apr 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369392; cv=none; b=lhzwto7f3B6qis0S30Vs4lDQfWTgy3p6HcUFG7+K6iO/Dzoa0iIpURiVGsz99AKM2+1+WZbhfyTJgmr0p3wIv0K4QgqDWkYobdEPA8sCZ0lDOK0ctdElPMdm4nzVgSlw91uU8V2OBo3rRnxT1hupE5XfPQuT+KYeIEZ1aXJ6rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369392; c=relaxed/simple;
	bh=+m3k+pIs6+1yrqNevLEQnX6PqG7mqrWx/snekHJOqdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GRXo6hxBF5V/nGVh1xeZV6hLhNr7Saz2UmlDkUH68zpCrXrbLrSt7KTPIuA1xbJViX1AS/hCOgJg4t6zjs98wsbZeke8cG9cn/6EwMONoSzh/WZvSWQ4AKoMwVS6eQ4LysoGSvfwQ95Rh5OiWUNg2F4au5XN6mbOUanfonTWHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYuvIlNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E08DC4CEED;
	Wed, 23 Apr 2025 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369392;
	bh=+m3k+pIs6+1yrqNevLEQnX6PqG7mqrWx/snekHJOqdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYuvIlNE402a+zo8LLprToWVp4rgzbAGFAHpadiyv8+Rp/vtFAV2i7O0MaOZHWW7g
	 e6Hd271Kbd4jlpHsVxvdoFsH4OTPyRB2WPXGBg95bDgMs4zA7zdLy7EjPKnEZS1juV
	 +5iuLq2Dtig2oxm8zQEUp/ry3ZRr/ReR0Yqk1NMy1w/qmTogp4MoqNP1X98Xb/WPwg
	 yCYOxkKiSg4MR01CD4sdMNAAD9jcs8pQiJSUyT4Q8qJIFNMOuF2cG16JoKlhl1FyCH
	 GS4PQfE3Tb0p8yOE20F7JVewEqa8oIYTjJtcSvyZ/RBovvZ4c72vm+NQ2YI0A5pOHX
	 FB3cuvsbLXTkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7C380CEF4;
	Wed, 23 Apr 2025 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Remove unused
 rvu_npc_enable_bcast_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536943049.2100670.14007960556015710081.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 00:50:30 +0000
References: <20250420225810.171852-1-linux@treblig.org>
In-Reply-To: <20250420225810.171852-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Apr 2025 23:58:10 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of rvu_npc_enable_bcast_entry() was removed in 2021 by
> commit 967db3529eca ("octeontx2-af: add support for multicast/promisc
> packet replication feature")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Remove unused rvu_npc_enable_bcast_entry
    https://git.kernel.org/netdev/net-next/c/67b083f14fb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




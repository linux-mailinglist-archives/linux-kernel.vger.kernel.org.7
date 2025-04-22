Return-Path: <linux-kernel+bounces-613915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F95A963BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ACB3AE5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB2238C2F;
	Tue, 22 Apr 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLVng98S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE31EEA47;
	Tue, 22 Apr 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313012; cv=none; b=s4J4zQQJKHmmCxSyE5FbpMqxPDrcavamoBr7IJTbNvSR8hDkIXVTke+91RXX5wATuCq31qK8LW4y5Ec3dIUv4iR9Q9XpOMlxDKB6iUEeJnVAM/DGdT8Jg0bKlNVR9FzthLfal9Hu/+P/odsTLNkOAPf+zRcb0/Q7wLmwZN3NwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313012; c=relaxed/simple;
	bh=3IwvABZJyhasjs2DLJ2I5DQtXsBPXFe8l+Bx1IpXSno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8cA0qHEJedtRQYvVPk9HXQzcdAGMuYCWlZQKtiPAdAGWH10wXt5OMk+l2SeBu+PRqKTKn0G91p3NpmCspF4UPec5CFHQxszpk9M2qYRA58O57ljpfrf3myGOJEQAMQ3J6mXW4N2cMi87tQyXgVNTc/KruzV1A/YQSIPwkF+Ez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLVng98S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E5C4CEE9;
	Tue, 22 Apr 2025 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313012;
	bh=3IwvABZJyhasjs2DLJ2I5DQtXsBPXFe8l+Bx1IpXSno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HLVng98SuIHAhxPpnaf3QeXL3HpoL69235/I+zllsQqRaM/Kc0TmDT6AqWcNyBRsW
	 x5XEeOEe/NHnTWnbsJzQxouMvUhx4kTSiMBvU1JfCK1kKr7aPmu0cM+J+8VSyF8Jvk
	 iYiPFrIpUKwgLM2sjxxfg24WEdqpSfVtQqo+Wj0Gbsz5vBWojJW7iqfnYZkvNhYL1J
	 kJW4LEQVV6aN6Kq4RCGXPjGgKpVI4u6HH3ob+FtPgh4oTyso78zmykAKLJMfwo5JC2
	 9AWTKHhmQaLhRZkISf0v7INqdzf8Kl2pGR6u2qxCsHa6Hvztae0LrzXhiHXWGLmXHB
	 OmExn3EKM8Ubw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8F39D6546;
	Tue, 22 Apr 2025 09:10:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: Adopting nlmsg_payload() (final series)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305073.1477965.10840520281239562472.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:50 +0000
References: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
In-Reply-To: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 06:03:06 -0700 you wrote:
> This patchset marks the final step in converting users to the new
> nlmsg_payload() function. It addresses the last two files that were not
> converted in previous series, specifically updating the following
> functions:
> 
> 	neigh_valid_dump_req
> 	rtnl_valid_dump_ifinfo_req
> 	rtnl_valid_getlink_req
> 	valid_fdb_get_strict
> 	valid_bridge_getlink_req
> 	rtnl_valid_stats_req
> 	rtnl_mdb_valid_dump_req
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: Use nlmsg_payload in neighbour file
    https://git.kernel.org/netdev/net-next/c/9929ba194299
  - [net-next,2/2] net: Use nlmsg_payload in rtnetlink file
    https://git.kernel.org/netdev/net-next/c/a45193018001

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




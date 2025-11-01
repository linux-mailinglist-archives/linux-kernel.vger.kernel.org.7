Return-Path: <linux-kernel+bounces-881039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FEDC27459
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B354A1B25AE5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A71EC018;
	Sat,  1 Nov 2025 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1OSPIN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E251E3DDE;
	Sat,  1 Nov 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957038; cv=none; b=Bmac+kVua2hPCs8PvHLkES8TqtNtmrUqg9iDEy9ewRHWJKQrVfJeUdT/4F+aQ0/cjWAGX3t/aCpFtL7pfjNHQTUgZXpfNwldzNLvU6+JpKi+0y2f798nWnLSLSovOTkJE3E5c4wwP9K6JadDjE/VI68TV65xeOB4KNrZUcQYw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957038; c=relaxed/simple;
	bh=7GxRr/6VX2s1e2bgaa3Z/Gs6604InPWmhx9Yd5I+Zzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujQ1sTa9f+o17eKliAVDiGmaNHvlWCKoC4WyOoJZLly9g2hf4742vbKEeRR64Uuz4uYNS5hSBSmqxigxQQu3W3fpMMQ3sNQlKH0QDfUCaq7gIoEI95R5UEQupNordXTcIBHYc8Lg7X48eeRYNMT8JcMhPKm1m01IZq6owqtlEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1OSPIN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD12BC4CEFD;
	Sat,  1 Nov 2025 00:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761957037;
	bh=7GxRr/6VX2s1e2bgaa3Z/Gs6604InPWmhx9Yd5I+Zzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k1OSPIN0kpJWhxzTjQzlxMGXVQv/6E/ixx8/3agXxB9qiwYRgfo2mo0+Mrtns0cWX
	 TmXJ+xLuuqelTAiHbey2cc5zSUGjOhJj1QdHVvD8KYb5NHuUVr4uQcaLOV2RycNKBn
	 5L2zKY02AH/kov8bZ9Y1BmKBIaMLvD4l/wUc467Dni+lkzs903hEIMfX8Kay6424Gv
	 XpRSN96GyO2VLiZvlekOZxFdPWHVzttValPcR3o3BK+X7rKaD2dCgoc4vxIqtdAbvo
	 tatDUcUFtPTAJ1GWf/eDdyP6462E3MmCR7p9pQYS3sawplYdawRnpLw9QeQpV2jYIT
	 h5/q9LfYPHa0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1E63809A00;
	Sat,  1 Nov 2025 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Documentation: netconsole: Separate literal
 code
 blocks for full and short netcat command name versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195701349.678724.16186608709028385228.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:30:13 +0000
References: <20251030075013.40418-1-bagasdotme@gmail.com>
In-Reply-To: <20251030075013.40418-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, leitao@debian.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 14:50:13 +0700 you wrote:
> Both full and short (abbreviated) command name versions of netcat
> example are combined in single literal code block due to 'or::'
> paragraph being indented one more space than the preceding paragraph
> (before the short version example).
> 
> Unindent it to separate the versions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Documentation: netconsole: Separate literal code blocks for full and short netcat command name versions
    https://git.kernel.org/netdev/net-next/c/a7aca10c0091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




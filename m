Return-Path: <linux-kernel+bounces-724262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4EAFF09D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51095603FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F5242D89;
	Wed,  9 Jul 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA7ya+4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2F242D7B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084602; cv=none; b=ANZIf4JlQWaMMZWKGkalTHQY8A0h535z8r3Qyyokq/CXdnyoKOevS5TmjGXX085d86l9AmYfEO6uDTkDc1pgqpkMr9EzmF1MO10ubuBp0llpxW9GbjFZMBNH0cVzuEX6RtFOuWBifEUo69BPkPvwtzrq027AiCmdMX4ptcVp5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084602; c=relaxed/simple;
	bh=cRd5nDEBswJD9NlbHfNeBwVC3wA153yJFbPNFqRPhRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WHbk69iTgG4tUsXaaBJr0ajBughAlckCL56O6LVZ2JhtcVrSnkQTh2hPI2gFL9KQnfdO/L5jLvTZOjre74MXlgRHT1ZGriKQKoF2KudUW/UEgdOaYecgCfl6MJ+XV+BxEC+pyfJUdq8X1LxFdPRSJikXUaXvtNoh33NVJJO3xNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA7ya+4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B1C4CEEF;
	Wed,  9 Jul 2025 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084602;
	bh=cRd5nDEBswJD9NlbHfNeBwVC3wA153yJFbPNFqRPhRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MA7ya+4d4pfK2Fi8Nb2pLvO9mIA2gA2618IYFXoapepeV1QN1QVBJvP3tsv/gDj5p
	 D8crhBu5PsCUpWTghsYhlUMn9g4bMqqUnMQajH73bFIXPtwPjbJX/g5UqPJ+G8wTqh
	 w7DOVUVhOxDutaE3HqmaZqT7QAQwL/E8bnNk47qUd8YUyn2/m1JDOpo7k9lcepS93x
	 Y6V5k+x2/7O1RSgeeSautuf2kZh3TwV6WQq3Fc4qyQt5kJ+n4q9SGLQNzITfJ+zZ1U
	 9U//y5Y+ElV9b+3iF8M+Pbr991IJvotZD9nk9qlZKOpl6CPdWUSuYBU+FnECiuBdNV
	 0ntRgp9l+zVVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714D2380DBEE;
	Wed,  9 Jul 2025 18:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid panic in
 f2fs_evict_inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462500.806926.7768132731103945108.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:25 +0000
References: <20250708095657.3081188-1-chao@kernel.org>
In-Reply-To: <20250708095657.3081188-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  8 Jul 2025 17:56:57 +0800 you wrote:
> As syzbot [1] reported as below:
> 
> R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffe17473450
> R13: 00007f28b1c10854 R14: 000000000000dae5 R15: 00007ffe17474520
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> ==================================================================
> BUG: KASAN: use-after-free in __list_del_entry_valid+0xa6/0x130 lib/list_debug.c:62
> Read of size 8 at addr ffff88812d962278 by task syz-executor/564
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid panic in f2fs_evict_inode
    https://git.kernel.org/jaegeuk/f2fs/c/a509a55f8eec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




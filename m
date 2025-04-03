Return-Path: <linux-kernel+bounces-585945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DBA7996D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 02:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D188316E6A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42D44C63;
	Thu,  3 Apr 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLAHl2ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A21CD3F;
	Thu,  3 Apr 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743640198; cv=none; b=AGFP6Ar6iJhbCoa12P4Z1XGLteCmZ9uWwHx03f3pDYTpx78F55Y4IDxgqJGZY+iuglGI7+CfBPDTbf7shuV1vQr6ueg7p7FzIYpa9OsJcNuccTUx6AiAG4bMIDEMoPM7GbI+mqPz/fP7wcUTBaux0k7jyIwsPL/tiHSKdO9HYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743640198; c=relaxed/simple;
	bh=xO9f4a/9WuPC3/ni2fkmii8ud0YKfXLKcQsP1T8GuzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oN/iBLHhvX3LWKNnVG9zPWht+sWtgOOJXHia9sfBefout/S/q7ci02BSkA04XepzCMhs+RlQ7slyzhRfhjUAbF/CxQ/kXPZy+0lv48jrgiJ1jQcV8+250OxEn8J7xSHkzcMBX+YuCvrbE04P7UCoDiThlJ7ZoM6d7or8yVVjLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLAHl2ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E163C4CEEB;
	Thu,  3 Apr 2025 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743640197;
	bh=xO9f4a/9WuPC3/ni2fkmii8ud0YKfXLKcQsP1T8GuzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WLAHl2lnRjMlYIAv4qOQ4+6LNMVfiA+1pgkerdgr/i+cHV9gX2Irx8zvvN2wPR1Kl
	 RJDId1DSsBOjeDJTK+4jBl/YupSPL/YLQwJamoRkvzyl+7x2AV7xQ4KlGwr6KGL9Ol
	 /gH3Dua9H67t6BWI7lydsCIvC0nt9ivZjhB1ALwh7I0fGfBqQGRLQAtxqeOVkHpV8/
	 RPZxMrp6EXTH1IHlZiMxEAkvJy7CX7qG2vcWEVoA1ITIZOcW/HHaXYHI/B4P8mnI8e
	 4HrvPOjX11LfqvATv2HF6GsMfoNI5Q06cm11EQOcD+nMH65oyNBnu5xNPkb5h+Sad5
	 WRNOdPrV0QfXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF77F380CEE3;
	Thu,  3 Apr 2025 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: avoid timeout during connect() if the socket is
 closing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174364023450.1731187.2572806115256964093.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 00:30:34 +0000
References: <20250328141528.420719-1-sgarzare@redhat.com>
In-Reply-To: <20250328141528.420719-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, mhal@rbox.co, pabeni@redhat.com,
 georgezhang@vmware.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, acking@vmware.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, dtor@vmware.com, horms@kernel.org,
 leonardi@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Mar 2025 15:15:28 +0100 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a peer attempts to establish a connection, vsock_connect() contains
> a loop that waits for the state to be TCP_ESTABLISHED. However, the
> other peer can be fast enough to accept the connection and close it
> immediately, thus moving the state to TCP_CLOSING.
> 
> [...]

Here is the summary with links:
  - [net] vsock: avoid timeout during connect() if the socket is closing
    https://git.kernel.org/netdev/net/c/fccd2b711d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




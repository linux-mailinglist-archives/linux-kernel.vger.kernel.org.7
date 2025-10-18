Return-Path: <linux-kernel+bounces-859281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE88BED353
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF474084AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219E25742F;
	Sat, 18 Oct 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhy7gmju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7E235C01
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803313; cv=none; b=t9YUOnphAuWIu/96KY2H1WKw8QKa0GpP9UuzIgU7GmvtlqZW9ij5JXfQr1krnsMP+frI1BK+ZydFkGlvr3ICXhmiD0uTITSU/P0Ow/T24RMxdG5jb+ZCBekRG300IHvpAjIDo1YendqfMMTyKOidB2beGS6oYGTS/VeAC5t0acU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803313; c=relaxed/simple;
	bh=lLadhCwqOLJRn4OyFyRaasmCVbJKXcR31WhZ+tQbsJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ggduwOKVAWVsq8qK/Zrenw4m/ouGtUXj9qLO0GAITzX9oKPUAL6qV1+lVh9DqxN2+hEvjY+rNQrjxY/FFsF6CEr0sBG2YvGuAJfTkVpMWyyczDwnVBuCbSurXpa0L2M6Q1dB7Ip0w3YLxuUWmD4yGOSKzbLjyv8/NHxkvjhLr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhy7gmju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B7DC113D0;
	Sat, 18 Oct 2025 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803312;
	bh=lLadhCwqOLJRn4OyFyRaasmCVbJKXcR31WhZ+tQbsJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bhy7gmjuYCl3k2qycHStnMR7Kz6A/tV6FoFM99CM5lnZsVkb62xdrYH+ikrSEfGgY
	 aHgAsJCMlGNVEUuxjnOnvZnOa6g+XTKxZME/YA489aDA0lRr2X7q6Iwcb6xWaMRjuW
	 hVBT6+AYPYyLNJK5eK+p08IGvdfCwJOsHeWfcd8kPb8nBMJ6ERqlV7YXIFUPYQ8flQ
	 dj5sPQpoUzOxEXm38QPojA6uur8/rNQQ3BmMc3RgO4gI5p1Xm5wru6cVBw3DctKkPL
	 yizQJ+QIck7YRkGHq8lLAb3WkBStuw5+0cyvHRv/DXSEFVNmpuS+Po6UG1hslpzVDo
	 R0jCws6Fo2lYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3439EFBB7;
	Sat, 18 Oct 2025 16:01:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: Don't print details of CPUs disabled in DT
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080329574.3028979.687307160089751894.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:35 +0000
References: <20251014163009.182381-1-apatel@ventanamicro.com>
In-Reply-To: <20251014163009.182381-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, alex@ghiti.fr, atish.patra@linux.dev,
 ajones@ventanamicro.com, anup@brainfault.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Tue, 14 Oct 2025 22:00:09 +0530 you wrote:
> Early boot stages may disable CPU DT nodes for unavailable
> CPUs based on SKU, pinstraps, eFuse, etc. Currently, the
> riscv_early_of_processor_hartid() prints details of a CPU
> if it is disabled in DT which has no value and gives a
> false impression to the users that there some issue with
> the CPU.
> 
> [...]

Here is the summary with links:
  - RISC-V: Don't print details of CPUs disabled in DT
    https://git.kernel.org/riscv/c/d2721bb165b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




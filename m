Return-Path: <linux-kernel+bounces-758060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1603B1CA73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9914216A94C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1C2BCF5D;
	Wed,  6 Aug 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua+YVdet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563D29E10A;
	Wed,  6 Aug 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500527; cv=none; b=Qb7Da/u17aWzvofreyMbQY78+jq+XyDI+VUOgp0MqVUd2T6VIrJ2MgiHuoC3d0pXgkp8LrWhjvr+oVff5hdBGWpe9SMN0d+On7Taz54yakLWYkhafFEVhigVbFC2oCApq9xsYYV4XGQEx+rC/N2fXhntWGdB8Ghh+IjPybiIkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500527; c=relaxed/simple;
	bh=4O0lpFS2A9Ol5YCPqBXxI2WeTeZTQ0FHJZhde9pVFxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGmpVGmpgNct0bqYKhxGvvIG+/tAw1YdMxbmWUYtcnJs1CTZAT9GJSdD1OOEm12k3qa20kqO8acEZdJaha2kbkfDZoRPPlAONhOX++Szg+lcmpeO8HSm0f/ViLTlYZikuaVRozjw9bNY5NKjpcleUhbH0WXIwsmtKwsNabYRoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua+YVdet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6EEC4CEF7;
	Wed,  6 Aug 2025 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500526;
	bh=4O0lpFS2A9Ol5YCPqBXxI2WeTeZTQ0FHJZhde9pVFxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ua+YVdetR6avGAde1rm4P69RtWpZrn3naIzqZLCt7YA4lFX3NtNGCM860Wb8Nuybh
	 O2zmBGVlXQjcfqy4Jr8bn7oK0FCRC4oUjLQHFaGY21TpdrBNZKE2eExTRIp4iOt4uW
	 ImA1sS5tqs/GByK9CyiXaaB1wwi0wMaXUrjIQ/et8yvJgdGcFSk2pzzfuy3g3pUQu0
	 iB16CLr60MtF1xWHRhGIJjNS8O0x/7un/8iEaZ850e4ZBuvOuyszhlcKppX6mnvjAR
	 6jUpi5NFr2QSVMAO44hI8sQR+yCyg5VJ2uYjNBRFw6OxmMjeFxmvws3WVX3+RoX9Wh
	 ONbYZvSauIbfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6E383BF63;
	Wed,  6 Aug 2025 17:15:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Few timer and AIA fixes for KVM RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054049.2863135.4614852920454002653.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:40 +0000
References: <20250707035345.17494-1-apatel@ventanamicro.com>
In-Reply-To: <20250707035345.17494-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev,
 palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
 ajones@ventanamicro.com, anup@brainfault.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Mon,  7 Jul 2025 09:23:42 +0530 you wrote:
> The RISC-V Privileged specificaiton says the following: "WFI is also
> required to resume execution for locally enabled interrupts pending
> at any privilege level, regardless of the global interrupt enable at
> each privilege level."
> 
> Based on the above, if there is pending VS-timer interrupt when the
> host (aka HS-mode) executes WFI then such a WFI will simply become NOP
> and not do anything. This result in QEMU RISC-V consuming a lot of CPU
> time on the x86 machine where it is running. The PATCH1 solves this
> issue by adding appropriate cleanup in KVM RISC-V timer virtualization.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] RISC-V: KVM: Disable vstimecmp before exiting to user-space
    https://git.kernel.org/riscv/c/57f576e860d3
  - [v2,2/2] RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-859279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06648BED34D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5B784E8227
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2D24DCE9;
	Sat, 18 Oct 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfn+9k8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A0248F4E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803310; cv=none; b=oNktREYYyu9whwYFT0An7+/not17spKESTzffXpGxeLDcmUR3JTcnwIJ4KqaC3blMvSOH0VuJ9Rvty0OIwm1JUTB67ACDPHIOYZqcDIWmk31c9UoW1fDsanoounS0L1OqF/cKE1qa59rQt+pPzmu270BkKutfK9Jhil17OrQufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803310; c=relaxed/simple;
	bh=W6ogpD1KM+CMWbUs+G23MEoyLhb/J95Jle+AQgCTx9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KryoZTLCQMNqQR8kzjglOaPEjqbTk8CaAmA10EX4gYZIKxVSOQCVQjokqw977Lb8u/9igmzHAMykrrwlG3DSSq1PZI7JTxIzLYsAsOyJSZWT9Su5Ac1DEmdTTdngSSdlxqh3Tuz0xivd8GnrWsbmIiie6162JSea/wtEFAQZos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfn+9k8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4182C4CEF8;
	Sat, 18 Oct 2025 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803309;
	bh=W6ogpD1KM+CMWbUs+G23MEoyLhb/J95Jle+AQgCTx9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfn+9k8/hxqjb8D2Yl+EGbqrb4rxtTIb404ltItB5hepMdx6jxesJ8mOx3YrxXuVY
	 Eib02ct1YKFuH+o+VhSv/fMUheC3xIVppe38jl9n0xpQdqRkmC6+ZVtjcMPigLjSe7
	 6SLOLd2Lhf5Lafwphi+I4Iq7c7IfCC940rz+z3SP4KLdnPxpLg1p0925PyTPYl0maw
	 wMp9sxQtzHg6rmeJ3AXTGJPPfPZkGeT8PHWmWNBRXoaYUzFEW9oMYrvCoHbUX3I24/
	 nLkWw/AUzSRiLhv0mMkik+n/7GJbtm6cozcunJh986oe20jxjOGQKx5gnQdQZJDUZQ
	 YwrkstN0ejpXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2B39EFBB7;
	Sat, 18 Oct 2025 16:01:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: Define pgprot_dmacoherent() for non-coherent
 devices
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080329274.3028979.8344603968685020251.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:32 +0000
References: <20250820152316.1012757-1-apatel@ventanamicro.com>
In-Reply-To: <20250820152316.1012757-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com,
 rafael@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 alex@ghiti.fr, atish.patra@linux.dev, ajones@ventanamicro.com,
 anup@brainfault.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 20 Aug 2025 20:53:16 +0530 you wrote:
> The pgprot_dmacoherent() is used when allocating memory for
> non-coherent devices and by default pgprot_dmacoherent() is
> same as pgprot_noncached() unless architecture overrides it.
> 
> Currently, there is no pgprot_dmacoherent() definition for
> RISC-V hence non-coherent device memory is being mapped as
> IO thereby making CPU access to such memory slow.
> 
> [...]

Here is the summary with links:
  - RISC-V: Define pgprot_dmacoherent() for non-coherent devices
    https://git.kernel.org/riscv/c/ca525d53f994

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-758063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E63B1CA7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F49722CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED02BE04E;
	Wed,  6 Aug 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVnFYxq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EE29B783;
	Wed,  6 Aug 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500531; cv=none; b=JSG5ofsYeyDcuWkU0uLmnDoImGv47LYH06MU2GcCdJIm3Gp7KgwWoQywNKAehJDaQatSQS5/qqBia5rBfuC4paZhLnRxMqvfLV4bLDR+RqbKiGZa/4Yfvmd4+g4VhScCSBzIBJ3EFQVNBSka40nCYbunScc3Mk5leZoQfJk07Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500531; c=relaxed/simple;
	bh=dP7LyJUuqyT/LSIjq7xZNcRuTUR3KNybdoTzyNUZlc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4fFgAfOX7msT8sVTDI6gvbB0FAbPSp/LqtuODzdM6LmXP7K8HK2R9VPCeyU8pXXRLjTgweeqLeX1VoWu5ejF/O3m0M/EOKL9+dLseTi0B7za92Kr6O0+1+qBorvSWHTIHLCr/Ur+stvVle1FieIO/XySIiGT80sbJXviuuaJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVnFYxq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2350AC4CEE7;
	Wed,  6 Aug 2025 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500531;
	bh=dP7LyJUuqyT/LSIjq7xZNcRuTUR3KNybdoTzyNUZlc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NVnFYxq4+64ZbTuTkRxzPZd+V9z/QGfybK++rPtLHonfQu4qIXoV4XNXJDM8BsJLw
	 Y25OUy64NbX3NbHfc7LsoGKJaC9kSP4/xazcIQ5CLBYqyW7Y/pPivZ9fhBP8pzzsj0
	 ANBzHfSPrasxaqPbgb3QbcXyX0pzsy6iBr9Pex8Qad9X/IGhME/4UVahmBfHlu4uB3
	 tSZZ11kygnjAiz1cae2EpqvOiLlO4Ue+eIBc1NrewxhclzTn3IFAlPuNb6y9BWq630
	 IFzSEP1yj5huksV/s5bpDdbo4nbXBIMvuZY9AL/kA+tCsUbqY9kO+sH/6Og1SoZkIG
	 XnYVJ4fPGtc9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D0E383BF63;
	Wed,  6 Aug 2025 17:15:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/7] riscv: Add support for xmipsexectl
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054474.2863135.5887102129908490866.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:44 +0000
References: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
In-Reply-To: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
To: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, corbet@lwn.net, palmer@sifive.com,
 conor@kernel.org, djordje.todorovic@htecgroup.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, conor.dooley@microchip.com,
 alexghiti@rivosinc.com, arikalo@gmail.com, rvishwanathan@mips.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Thu, 24 Jul 2025 17:23:24 +0200 you wrote:
> This patch series adds support for the xmipsexectl vendor extension.
> A new hardware probe key has also been added to allow userspace to probe for MIPS vendor extensions.
> 
> Additionally, since the standard Zihintpause PAUSE instruction encoding is not supported on some MIPS CPUs,
> an errata was implemented for replacing this instruction with the xmipsexectl MIPS.PAUSE alternative encoding.
> 
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> 
> [...]

Here is the summary with links:
  - [v5,1/7] dt-bindings: riscv: Add xmipsexectl ISA extension description
    https://git.kernel.org/riscv/c/06d48c2c4f83
  - [v5,2/7] riscv: Add xmipsexectl as a vendor extension
    https://git.kernel.org/riscv/c/02b01dfaf4fa
  - [v5,3/7] riscv: Add xmipsexectl instructions
    https://git.kernel.org/riscv/c/d85071f97570
  - [v5,4/7] riscv: hwprobe: Add MIPS vendor extension probing
    https://git.kernel.org/riscv/c/20b80c735c05
  - [v5,5/7] riscv: hwprobe: Document MIPS xmipsexectl vendor extension
    https://git.kernel.org/riscv/c/c714fbc023df
  - [v5,6/7] riscv: Add tools support for xmipsexectl
    https://git.kernel.org/riscv/c/378afb53aab2
  - [v5,7/7] riscv: errata: Fix the PAUSE Opcode for MIPS P8700
    https://git.kernel.org/riscv/c/838218910ea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




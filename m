Return-Path: <linux-kernel+bounces-758069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EB2B1CA85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391DC722D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D02BEFEE;
	Wed,  6 Aug 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQYaaw+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04062BEC31
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500541; cv=none; b=BFdjNZIHJ3yvjTQ1kgovFFHtYEarU67BzU6YEFC5seRzKR+DOdtiaJbR5bpvrD3tpFqJ2KSdUzKuPkJ6gGL1YMFyMTKxxZwMzi87XHdbihaYmrKZU65BgUI0KdU0s+r35+4tfqYpMFxoR2rfSOh0GYgX0KRcQ3SxDH5iiRlLFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500541; c=relaxed/simple;
	bh=5gTmnwipvuK0mCh6kDXIbQ1cXlp5XEVZRIIYS+AQmMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jn4rTINiM6HCbx2mDxktBpuG7OPf6QpnlvHMECw1CHrnEJc1S/NKj1Zuftx7DpcDnWePcLFVPGyfFCuNG0zypWn/3m2Vowl457Lgo+miamSH1cWxXnqfDZ74ko9LfxvdhycTx8WWgQIggsaaAswoSzOGW0qVm2eKb1nS9tmArIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQYaaw+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617BEC4CEE7;
	Wed,  6 Aug 2025 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500541;
	bh=5gTmnwipvuK0mCh6kDXIbQ1cXlp5XEVZRIIYS+AQmMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mQYaaw+jAz5cAeOhBO8a8FUFLCV9+yIzqsyAzWoqvsdoffIkqXEcKroIlbw/5QEbk
	 ngHrwY7j77qzA9Wa+drhLApd5kswPJ2JeUfQUUO+xVrUHO5A3Amb1qF1me+736R7Y0
	 dfY2Nc0tZnjgxHDDyro+jZJrzgBgPGBNdbdmrX2+8v4c/C++/PrA6OBkQB+2PM5qd8
	 n9hIhlgHNFJLmHe5pSoZl05hgvLWaSDl7TDbWZ2CVKmtB3HzyQVtBCECS36m6Wi3yd
	 1GTo4W7Rd5rx0NbNxUSQFaxOFSN4zsPyp2Qc0ffL3PaCeGe1g1jrQ61fZ/RDeS9KAT
	 3A6a/qpfRX7mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EEC383BF63;
	Wed,  6 Aug 2025 17:15:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header files
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055499.2863135.2738368758577957268.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:54 +0000
References: <20250606070952.498274-1-thuth@redhat.com>
In-Reply-To: <20250606070952.498274-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 atish.patra@linux.dev, anup@brainfault.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Fri,  6 Jun 2025 09:09:50 +0200 you wrote:
> The kernel Makefiles define the __ASSEMBLY__ macro to provide
> a way to use headers in both, assembly and C source code.
> However, all the supported versions of the GCC and Clang compilers
> also define the macro __ASSEMBLER__ automatically already when compiling
> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
> With regards to userspace code, this seems also to be constant source
> of confusion, see for example these links here:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
    https://git.kernel.org/riscv/c/c47963980ba6
  - [v2,2/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
    https://git.kernel.org/riscv/c/b5eb1f12a416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




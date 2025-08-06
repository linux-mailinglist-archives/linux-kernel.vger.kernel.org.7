Return-Path: <linux-kernel+bounces-758068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B04B1CA83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1424B164E59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031B29CB48;
	Wed,  6 Aug 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIzCJjq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693C2BEC39;
	Wed,  6 Aug 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500540; cv=none; b=o7tIOMmBMDCMP8PL+vT4HSzXZI1wSGCrZXbd121gqLFb08pm2IqxZhRJXwuLwJp4Faf/HK2nOXQ7G5hbfIYyP1+5q6qNB10LXBR7ecTeG6+VcJEgFDKlT89qHPDuXvpewbymyAASAAhx8X4ux+XwG6CgQPmqVoGPEYqFUJbD/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500540; c=relaxed/simple;
	bh=1pzAwtko3ANAmVm5KUzMtQcMCt+mGjENUOKMCtnNxi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FzO2EWv9GYxkrxm5bZ2kVz9W1D6tXJ/zgcPwRUyYwiyHBIdmy1enory4UmH7eKi6fh/ykFSkNe8ongkJbF6ahf0EXYYvTtX4KxQxv3D3kyJ4Ym8FRkY/yGKvnlfPSIeRtm3cVL+EzwBi/vzPFXWnNyYsHYAm7EUOEU+KZolsY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIzCJjq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B7C4CEE7;
	Wed,  6 Aug 2025 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500539;
	bh=1pzAwtko3ANAmVm5KUzMtQcMCt+mGjENUOKMCtnNxi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SIzCJjq906ULp9OXMPNow3K5PuZFIXcIgTMXdEaAfzYM81Vcq1T7xmQThk3Gtm+uc
	 qnIutpV3hA8J/tw65iThqeV2AaOW8mVltJZ5OSKrZ0ehzYwvuDyYCdMBKaHkd5MnrU
	 ZTLG1gR40HeX3CONton6HzdLzO8XPAlG8e4rFH4Ii4P4evtv3a6I+XmpaElVg5TWza
	 pOGCOkm4TwBvSdYEgVlFpKgW5yMtJmeFMat5GTyI6NcrorO1HupkRr9RMAV4KF+ydv
	 otPq9KO3VfnCgFlNIEOvlXhpaexNZuetdphgFNEdwB2ZF1xpK9FPb2PtrG++O47Ka6
	 HQSTWV+guhMZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE79383BF63;
	Wed,  6 Aug 2025 17:15:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] riscv: introduce asm/swab.h
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055349.2863135.5871727403840388182.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:53 +0000
References: <20250723-riscv-swab-v6-1-fc11e9a2efc9@iencinas.com>
In-Reply-To: <20250723-riscv-swab-v6-1-fc11e9a2efc9@iencinas.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, alex@ghiti.fr, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@rivosinc.com,
 alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Wed, 23 Jul 2025 20:47:29 +0100 you wrote:
> Implement endianness swap macros for RISC-V.
> 
> Use the rev8 instruction when Zbb is available. Otherwise, rely on the
> default mask-and-shift implementation.
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> 
> [...]

Here is the summary with links:
  - [v6] riscv: introduce asm/swab.h
    https://git.kernel.org/riscv/c/16b0622e2f6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




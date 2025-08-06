Return-Path: <linux-kernel+bounces-758072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C84B1CA87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E5E17DFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743562C08AD;
	Wed,  6 Aug 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmPurJYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59C2BFC73
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500545; cv=none; b=ZlNLZLyMq8kQFAdJtNJd3Rv77/VInXrmI/83Kv+w2ZMCTd7OO2nnv0n9ifEU2Jg7D0n43B/KGLlkYopYmQB8vg4S3BE/8JqVwoKFdFO/kJ9awb3HXmxyaVPy0byIuLVyl/jbZ6iCx+3EEXHyK0Mi6FmHuFPyGtKq8huQCSF1jEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500545; c=relaxed/simple;
	bh=1GNA7X5R51sdOSWNQYdwDRll9kG3ZCYqu+jXPiVoLSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZFqBT7SaX6zpzl0/buEsfaIQajHrjEmWO/FIm1tjhdPWcc30K5oLoiEP3t8l0P8cMzA+0JMYrPQBtyGqSvvZYTFnDVKqO+bNJ74IfHfBk0HHLjKy/iRbFf5+86FCBSTBY9lIVZwowMXbx4O6WZzOIw0tw3VtedN0Mu+AzNEFmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmPurJYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6AFC4CEE7;
	Wed,  6 Aug 2025 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500545;
	bh=1GNA7X5R51sdOSWNQYdwDRll9kG3ZCYqu+jXPiVoLSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CmPurJYdTk0V5U8cnRscexA8IsFBsd672nd+Olltt4YaJmn+vtcYCmE0w9X0sFEDQ
	 3rQ0eCpnqTrRfcpperyxWZQWuCFDUaFyjtcKOeSwDoEH0GaqrZ79wkKaM1v6O0ZDat
	 ZN8sqAKOzRcOWaeweI+TXdTr3V+48gyKJcWtKovIqKePUC0CHmAdBjAKPkx5ZeDo7l
	 oDMoyz1fEw/V/4byhzjO3ACNDTW84HSG+BnnQ1fVXKI29ztCA43qFWtSwBRIUpCG2P
	 zvGBtD/8EfisLduG/Pu8Z57A8aRIdVBvk5NGhI+eJoECYwc6kModtovTbYMKhV0anG
	 58ERYBMLv/PcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE227383BF63;
	Wed,  6 Aug 2025 17:16:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055949.2863135.12380729156820044095.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:59 +0000
References: <20250711090443.1688404-1-pulehui@huaweicloud.com>
In-Reply-To: <20250711090443.1688404-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Fri, 11 Jul 2025 09:04:43 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> The implement of cmpxchg() in riscv is based on atomic primitives and
> has NMI-safe features, so it can be used safely in the in_nmi context.
> ftrace's ringbuffer relies on NMI-safe cmpxchg() in the NMI context.
> Currently, in_nmi() is true when riscv kprobe is in trap-based mode, so
> this config needs to be selected, otherwise kprobetrace will not be
> available.
> 
> [...]

Here is the summary with links:
  - [-next] riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG
    https://git.kernel.org/riscv/c/9ad032ba418c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-733836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A98B079BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B401C21543
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D92F5C50;
	Wed, 16 Jul 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbb0Vlza"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7528A1C8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679286; cv=none; b=oCnJTm3Nj3B+T73TP/JjmW2y6Ju22I90bQLNWdFECoVqXkzTUQdMSqU0SVUuPNEOXmnGV/7gbHo4CdAndc0k61VOSmMv59UWIm7bPKDmNRAc0s9Spt6F0WOWkTqLAJeKQW0wl2xcyEszTxEZj1EKDZTbv9ojar5YBUPzsp+q0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679286; c=relaxed/simple;
	bh=hArCQNpeer8Btwx6Mc8fEsoOKg5ua9BNHWdaLPcW2+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rg/5LWZR4q2knYYJ0BLaJI25hbH5tgD8NX+Tm7TNj/ZbHsE9JST0qAI2wfhk4mmea185TgO7n6zL3MycdYKnu4DaQjUQols0h8glo9HcnsfM0EDjIcx200YbjDC25rQbQnK3QlNvF7gLEiq41rP2Rg9Z7jkCZX50GkW7E9mTDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbb0Vlza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0214C4CEFD;
	Wed, 16 Jul 2025 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679286;
	bh=hArCQNpeer8Btwx6Mc8fEsoOKg5ua9BNHWdaLPcW2+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbb0VlzaNqARHun1kOkS7sIFQnweTvmyDsC6ESZA0opz9qSKNQy5OOkazAlll8AfM
	 bEhmyZt1FCKz2RL1Y2UIiuf6+qaNv+3Q2TeyOM4OILXfJpY5+R+GCz3+EDVWKSsOiS
	 bYJN+sSX7k9ujxo+4CXROgDKLzvNns+9A8F+nOKfdMb/WrrX+2BHV5xY0aUEvTltJD
	 n2bjXKWWzBQUgxDesUGs2VZrlRzAwfxero0qliYHxe30OjtIq3B6seWxxrB7nMG5S+
	 UdxqOVg0jyLHVEJEPBAnv1UFMohovCkB4iMdca4c3doPyqF9m1KdYVhZW9zy3c45PI
	 IH2uAKY/kxihQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 80873383BA33;
	Wed, 16 Jul 2025 15:21:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175267930621.1224517.5170044226873875267.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 15:21:46 +0000
References: 
 <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
In-Reply-To: 
 <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Thu, 10 Jul 2025 08:34:31 +0000 you wrote:
> Even though those relocations should not be present in the final
> vmlinux, there are a lot of them. And since those relocations are
> considered "bad", they flood the compilation output which may hide some
> legitimate bad relocations.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - riscv: Stop considering R_RISCV_NONE as bad relocations
    https://git.kernel.org/riscv/c/82d369b48a6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




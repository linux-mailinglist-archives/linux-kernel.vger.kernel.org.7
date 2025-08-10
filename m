Return-Path: <linux-kernel+bounces-761579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C7B1FC20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B831173D37
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E022127A;
	Sun, 10 Aug 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeloW0E7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659021FF44;
	Sun, 10 Aug 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860324; cv=none; b=L/bcYSexv83nl74x1fOci18UO9WyAs3sFbzNozK4gA/N4VO7LmuQt6ayjJ79Cm+b/szzxltN35Btjr5nuKo4EScg9W/sW/n4onG5iThOtvI8ezcTQX6G/w5khmDDUYO5mLUCfoHgNTrHZVeTkUtZ/GISHKoG0IbYkSDDAXejLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860324; c=relaxed/simple;
	bh=BQP2wrXvpvE0OkhTHqKiJnJxJCBhEsJDRIlvbTbLikQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gUnhPIhdkX+k4aWxE8M+DysyZiLyCSUvo3CWv1zJ2qakgjp7xyeWdES3AAGbXnRg1Yw0vCit5/wnHtY9hboHO8eU5SnsMUFToeCw88A4zL5jX7D3s/wOc59tzbzuhhvS8A10YpUhN+A7fcGQZ44v+R6okTpTUxNY5+aGt4afJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeloW0E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1BC4CEEB;
	Sun, 10 Aug 2025 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860324;
	bh=BQP2wrXvpvE0OkhTHqKiJnJxJCBhEsJDRIlvbTbLikQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NeloW0E7hGjIA3yR9ZXXKj3hjEdgWXGZL4XVmFahhuMH0lydRU7ex9OqRoMjCiHbc
	 aJcrXN5NB5fmsrBCIWi0Z+KAaLfgEkClOzZmOB0QHPYfuVBPRomoVmCCy0NKhOEoYc
	 c5enY2K9iKuvCrzMZuXdriDKlA0aCjfUYWZhO3em1hSW/rwlVOeZS0cJ5XzCkpKG2W
	 ekmXLR6pjY4W0r8NA82tvLDW/sfFudo7L47lmiUD8Olk5cXPwhIrj0PtHoE12Bi9LU
	 DnlAgHP3yelTJ4e+R4kvJ8MO41fIA1C4oo0NPHgEx9TMl0fTetvPX7O6voVbgLWfTb
	 IoZ3UveYGt/4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC439D0C2B;
	Sun, 10 Aug 2025 21:12:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] irqchip/riscv-imsic: Add kernel parameter to disable
 IPIs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486033674.1221929.9986171280702761593.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:16 +0000
References: <20250716123745.557585-1-apatel@ventanamicro.com>
In-Reply-To: <20250716123745.557585-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, tglx@linutronix.de,
 anup@brainfault.org, atish.patra@linux.dev, palmer@dabbelt.com,
 paul.walmsley@sifive.com, alex@ghiti.fr, ajones@ventanamicro.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Wed, 16 Jul 2025 18:07:45 +0530 you wrote:
> When injecting IPIs to a set of harts, the IMSIC IPI support will do
> a separate MMIO write to the SETIPNUM_LE register of each target hart.
> This means on a platform where IMSIC is trap-n-emulated, there will be
> N MMIO traps when injecting IPI to N target harts hence IMSIC IPIs will
> be slow on such platform compared to the SBI IPI extension.
> 
> Unfortunately, there is no DT, ACPI, or any other way of discovering
> whether the underlying IMSIC is trap-n-emulated. Using MMIO write to
> the SETIPNUM_LE register for injecting IPI is purely a software choice
> in the IMSIC driver hence add a kernel parameter to allow users disable
> IMSIC IPIs on platforms with trap-n-emulated IMSIC.
> 
> [...]

Here is the summary with links:
  - [v4] irqchip/riscv-imsic: Add kernel parameter to disable IPIs
    https://git.kernel.org/riscv/c/ea92b6046d35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




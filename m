Return-Path: <linux-kernel+bounces-758059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89BFB1CA71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9DC1736BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3929E0F2;
	Wed,  6 Aug 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGo5p72z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241B29DB8B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500526; cv=none; b=h3Mc+8nHqLJ1f+TctEkBgmao39pWDF5GCcig7T23QQzxe+ZZIDTfSQBa07RVKFsDVrKFaATRxShj2F0ooAkLQvhL5vSqpDOWKAVTFamshdeBM/UX9pDq4v+K7LfB41On8/Z/8nScu4e0uejdvIcz7BUysUpeXHZqtNWV40Q9mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500526; c=relaxed/simple;
	bh=9gHLl9tgdN6m1xyHwJYn8Gcm+hsXzo1alXOLXcT0Rmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0ij9I/RT2tLyd5fTvHZ5EElBtzuFA9VpKMw2wLhS5ft0JlQFYDltmguD2zVRn5Q53yYUBD6t4qQkI4AsPi1UeS3lJUm/S857ig3xVfR2MtfSeEcZ64lvo+YagfX51o6IU/hLUavPS29Gb0bmBfY46iioQmugYR0yCheqfZiFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGo5p72z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EBBC4CEF7;
	Wed,  6 Aug 2025 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500525;
	bh=9gHLl9tgdN6m1xyHwJYn8Gcm+hsXzo1alXOLXcT0Rmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uGo5p72z/YSNwZ1I6UbTVcz27GhocJbrNBWOLq4Q/oXPYdFdGMaJPh9zdmagyrPcj
	 N6CmkPqP3I2MZA7GgMPF8S4OHbWMvuQYgpnIqZ517XA6nWpyacgW111JLoI00BaQxm
	 55j57tW4ccBXx9IiifkbRVf2/74FGgvvheKWQ0G6pWk49X4v+IXeNe7PWIdICv9JVZ
	 KBJyNkxFSz7xrKfV+0Q4NNf6fThrnnyTNeOPxClUtZbEcDAv+E0HzMnkguwGoheZXE
	 uuMMUGGf1UnQkry94v/jE2f1+4/i5qpJ+tSWJ3P9TGssXz8QNYIOejMyBcwbo0UIv8
	 R+8m1sljJFHtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F97383BF63;
	Wed,  6 Aug 2025 17:15:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: mm: Use mmu-type from FDT as SATP mode limit
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450053927.2863135.18156029900049802152.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:39 +0000
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
In-Reply-To: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 22 Jul 2025 00:53:09 +0800 you wrote:
> This patch series improves RISC-V kernel compatibility and robustness by
> refining how the SATP mode is determined during early boot. Some RISC-V
> implementations, such as the Anlogic DR1V90 FPSoC with a UX900 RISC-V
> core designed by Nuclei, which I am currently attempting to run the
> mainline kernel on [1], may hang when attempting to write an unsupported
> SATP mode.
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: mm: Return intended SATP mode for noXlvl options
    https://git.kernel.org/riscv/c/75ede0a8e07b
  - [2/2] riscv: mm: Use mmu-type from FDT to limit SATP mode
    https://git.kernel.org/riscv/c/a870d4f78f11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-761583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A50B1FC34
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED497A1119
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4132356C6;
	Sun, 10 Aug 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn1cEHXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A10233D64
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860331; cv=none; b=gH4lqBKfxT3YjsxxlZQ8RUQ1VCx287bmySV0g4DDlRoGka0tNuXF6lV/TOVPEjWwzOdy+73XitKKnER1Lv5Y6KRh1yIw4mdzTnlhsHks3NjuoVxo5TmwBeYEujEAUhyH9PTuDRNmnuuSaexqe8ZDuXKCwlC99SlsFEK7tgxNTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860331; c=relaxed/simple;
	bh=4I9I7RuWJ60qaM2pPz9O6+4tlk0mUd5Zz6Z6dLSxXgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gx6bWpFoiE8vEUuhJQ3czfBVbOIIfFekD70glggcosCFXwz/a5zxUbXG+unJQpgovshUXv9ZlvSOsEn4QICoLla0Xpt7hvDfXHsUMyRbeDQjewhBE2ZemOP7xL0AfqEdosa2fLd9CBbqkqPfabaDiFjVEf+QYbJO/WpatiYqdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn1cEHXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC3C4CEEB;
	Sun, 10 Aug 2025 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860331;
	bh=4I9I7RuWJ60qaM2pPz9O6+4tlk0mUd5Zz6Z6dLSxXgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mn1cEHXxgSXuqRhGUpKlOJIVubu5qDnDP2LXRFGtMut7PRd5GdakEucMEf2DqeYz7
	 RDqBvR+31AhfprLTEEka2QILFje+l3sZecwbxKK5zs3DH4M1n4tjB0WAkXeJGpa+SK
	 lhmnD+RLaJg8O53Gp4GVRqJrv7/gkCfUe1SD81TxH44DyfG1R6lJqvqznEpwwXRYan
	 e32YP63mu72RdBxv3Gl2OWkn//HUMWNX8M2J015KYr50kdqrIgAHjw+iOJ2auygygV
	 /jnjfpJAw1aCSOvKT5rLaJGcj1kUdTTgglpOTXFUEBEh0mO5qo4bGz8yegvUJqKjcJ
	 O+seXdQcM/rOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA139D0C2B;
	Sun, 10 Aug 2025 21:12:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Optimize GCD performance on RISC-V by selecting
 implementation at runtime
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034374.1221929.15171575812600532444.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:23 +0000
References: <20250606134758.1308400-1-visitorckw@gmail.com>
In-Reply-To: <20250606134758.1308400-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri,  6 Jun 2025 21:47:55 +0800 you wrote:
> The current implementation of gcd() selects between the binary GCD and
> the odd-even GCD algorithm at compile time, depending on whether
> CONFIG_CPU_NO_EFFICIENT_FFS is set. On platforms like RISC-V, however,
> this compile-time decision can be misleading: even when the compiler
> emits ctz instructions based on the assumption that they are efficient
> (as is the case when CONFIG_RISCV_ISA_ZBB is enabled), the actual
> hardware may lack support for the Zbb extension. In such cases, ffs()
> falls back to a software implementation at runtime, making the binary
> GCD algorithm significantly slower than the odd-even variant.
> 
> [...]

Here is the summary with links:
  - [v3,1/3] lib/math/gcd: Use static key to select implementation at runtime
    https://git.kernel.org/riscv/c/b3d5fd6f82dd
  - [v3,2/3] riscv: Optimize gcd() code size when CONFIG_RISCV_ISA_ZBB is disabled
    https://git.kernel.org/riscv/c/26b537edc533
  - [v3,3/3] riscv: Optimize gcd() performance on RISC-V without Zbb extension
    https://git.kernel.org/riscv/c/36e224168721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




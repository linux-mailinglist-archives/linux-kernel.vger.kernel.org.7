Return-Path: <linux-kernel+bounces-761581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F31B1FC27
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D215E1897AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CED2264CE;
	Sun, 10 Aug 2025 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIjaG7bH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4552253A7;
	Sun, 10 Aug 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860327; cv=none; b=eC7cWPDVeEETsLW8oR8JhV7QEBJsAR3PMbqUcL206nkUvAoRSIQqESv/j/SKuLFnbU0jRfg07R2Hgqh4ScwMI2MduZ/jmUbB4r15tsum4M1hCYQlNMETwc6ocVBb5WU34D69nE2YgxUtXK21bQLimRC6lqXQd+SZoSbxoqPGCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860327; c=relaxed/simple;
	bh=29Jkt6E+Z/r91Gjka8wTSIyCZDKG/PFRHm4REKs81+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HP/0bbGpVNtYBfm3CiiRY5Y6jZbKxpBWtGoAXDkJ86R/dKNnzQuJx9gtCFLRuQyLz+yOQb5YwY5arup8khLquXmPYOkJnLBqXaFtEzVqIcDjfz+bHgeq9rJtSFA+BWTGzK7g7sRoIUNEUjyA3FnUDt7rg6COD2edcjkX9S9a2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIjaG7bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A99C4CEEB;
	Sun, 10 Aug 2025 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860327;
	bh=29Jkt6E+Z/r91Gjka8wTSIyCZDKG/PFRHm4REKs81+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UIjaG7bH7wfZATr/m9gGkNg8qtUzFyU3q54CX3clwzy1T8HGH1Pyqm0RwMSf/Fajx
	 L82wKsg1dgZJr1ykakZYkN2r4mj1gEbExCXwtjPNCDn53twh/tEQcK0pKR3oc2S+Y7
	 Ibb6c2BY9oTzYZYgOAO/0REmx74l3VUpF+s9eSP+wleUw6ZlwRVMcnuF09OHlk2sBB
	 1naQUUjNg5chf2Vh5Sk0smFtSB31SjUe5Pe4odzKLzgt+4+DovMs61dNTAiShoF6zC
	 ZzJkmo2GAfV8VsMVKCYLygCYNkRWsQcpyVZwRu8Z8qv4jbQAaF7QXiGGeR0yqbr6nf
	 Oy8w+ysN6WXkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0C39D0C2B;
	Sun, 10 Aug 2025 21:12:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/9] add Voyager board support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486033949.1221929.12633096724273159685.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:19 +0000
References: <20250711133025.2192404-1-ben717@andestech.com>
In-Reply-To: <20250711133025.2192404-1-ben717@andestech.com>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, tglx@linutronix.de,
 daniel.lezcano@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 soc@lists.linux.dev, tim609@andestech.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Fri, 11 Jul 2025 21:30:16 +0800 you wrote:
> The Voyager is a 9.6” x 9.6” Micro ATX form factor development board
> including Andes QiLai SoC. This patch series adds minimal device tree
> files for the QiLai SoC and the Voyager board [1].
> 
> Now only support basic uart drivers to boot up into a basic console. Other
> features will be added later.
> 
> [...]

Here is the summary with links:
  - [v2,1/9] riscv: add Andes SoC family Kconfig support
    https://git.kernel.org/riscv/c/00dba19aa005
  - [v2,2/9] dt-bindings: riscv: add Andes QiLai SoC and the Voyager board bindings
    (no matching commit)
  - [v2,3/9] dt-bindings: interrupt-controller: add Andes QiLai PLIC
    (no matching commit)
  - [v2,4/9] dt-bindings: interrupt-controller: add Andes machine-level software interrupt controller
    (no matching commit)
  - [v2,5/9] dt-bindings: timer: add Andes machine timer
    (no matching commit)
  - [v2,6/9] riscv: dts: andes: add QiLai SoC device tree
    (no matching commit)
  - [v2,7/9] riscv: dts: andes: add Voyager board device tree
    (no matching commit)
  - [v2,8/9] riscv: defconfig: enable Andes SoC
    (no matching commit)
  - [v2,9/9] MAINTAINERS: Add entry for Andes SoC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




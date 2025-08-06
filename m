Return-Path: <linux-kernel+bounces-758061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECFB1CA74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BB7722C69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450072BD02A;
	Wed,  6 Aug 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6+RCle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38362BD011
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500528; cv=none; b=NcvsW28uautosoe/9qge+S7NgVsdfp5FYrQmU8FcNQV5ysJ45kttrSRdDI/bohywsBEA+Rcq7IvmwJFzYkwopE6QyOJYZFBcuqi3KqE+Vqy22OkYV4C4YXQjC/10m0yE+bhgXscqyC83q9CJcNYYDgGJfVdbSqBuTPYX+v8M6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500528; c=relaxed/simple;
	bh=Ff2V9hy6utcP0CCY2uNq0RzaFNn4ugm5oNFnC12dD1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxzCD7YWuqkI0djRr9mfl0ueoJ4EtWxYn89UGPm14zA6mHTH5yWnk6rA34hyEEsDJNmO5kXVDNTVtfngrCyES/vBGHop7BdEjZakCoVXziMsgc4AVTo89btJBOWMG3kBlOAU2Vr2UhHoYQue17CHdUyorPIOOdHqHGSYaHQDx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6+RCle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D8C4CEF1;
	Wed,  6 Aug 2025 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500528;
	bh=Ff2V9hy6utcP0CCY2uNq0RzaFNn4ugm5oNFnC12dD1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+6+RClezduuYHOrMuwc5cHo83I4YylhhQOHQFrZopB8tYgZvc0fuBHgjLTVg1o+J
	 qT9GcoseKGxuscYoE/KJmR0w1Cg0Cezb5JongGISFGRTKvrTs3Q+qq8FrONH/pOc7g
	 oX2HW5de53IC9aH5GuZafVVBGx4g/aB1xXklIv1exxKsmbNap4tE9gYRtBJXBgBJJK
	 5pG1HsYrxYSU4k1Udh6ZJM93gSHZFP71kTUt8j1p6298DtitU95taXPq43Gjjgdk50
	 9Fn6m5rTyzYNCOiw2/RHWP85y3UOUFOm5/Vz/kyShu2eIFB8llK9aLL9ub3rQ22fhu
	 e/RjVLy6SQOsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAB383BF63;
	Wed,  6 Aug 2025 17:15:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] riscv: minor thread_info.cpu improvements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054199.2863135.9619865736779982038.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:41 +0000
References: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
In-Reply-To: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
To: =?utf-8?b?UmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHZlbnRhbmFtaWNyby5jb20+?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, debug@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Fri, 25 Jul 2025 18:54:08 +0200 you wrote:
> Hello,
> 
> I noticed that we give thread_info.cpu two different names in the
> assembly, load it as a wider type, and store it suboptimally.
> 
> v2 is split for easy backporting.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] riscv: use lw when reading int cpu in new_vmalloc_check
    https://git.kernel.org/riscv/c/5fcea028d8b8
  - [v2,2/4] riscv: use lw when reading int cpu in asm_per_cpu
    https://git.kernel.org/riscv/c/47e006cf9789
  - [v2,3/4] riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
    https://git.kernel.org/riscv/c/a1984b2541b0
  - [v2,4/4] riscv: pack rv64 thread_info better
    https://git.kernel.org/riscv/c/9b3a86b7b14c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




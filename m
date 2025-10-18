Return-Path: <linux-kernel+bounces-859280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B857BED350
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85FB44EBACE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2BD252900;
	Sat, 18 Oct 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzn7gc9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD12512C8
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803311; cv=none; b=ukFwDF5Tb5h5yL3xNZdukBtSInqy2tmBI+agwso2WScomDm9Yj+MINPnL5VtzBtJBPn3sNPcJPUnqe5CAKqecjWqXERRssfug2Eui+DZLBsG/aolUGB4n+8MFEmLMyQ00JcmzOg43oAWAgi9YlgZQ/liHvHw5fW/1j6OVIDQf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803311; c=relaxed/simple;
	bh=wHoIEi9LyOjbIo348UgaazyL4vnBvYSVLFSEXBSMrXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ormlKjMOvBuuuRXgg5RlkYKWvUHRinf/K/Mj14SbKE4WQjOJKJi5Od+/JKuLkfaaQkFq/2PvJ3lplg7LtIiVwVo0m6Q4idjQsSV3Omh5siR6b9MM42eCmfg86hntX/aFkBgadvHrhUWFKmQkQzHwOAp0ACELmFSlkl6/72bneeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzn7gc9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3DC4CEF8;
	Sat, 18 Oct 2025 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803311;
	bh=wHoIEi9LyOjbIo348UgaazyL4vnBvYSVLFSEXBSMrXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzn7gc9EN+Id2A78wKRBgwd5M+d6kix7zKlEas6ZxQL4huwQCQy/5xfDxhE+nkcu5
	 bsFEAqkOEE5pBADqJjVaH62xeB18AzymrfIm+6caSXdXX/YUrUfYuLqb0EQj2cBOrq
	 BHDQDVx7UPdNq5JUypiKaRbpeNHJ8jv48Bd7BGXYZ/QFpHXM0GfWZr0I9SKwnd7o2U
	 lc4uOrTTIDT5zv2++toA4voNfLI69Slut6G29tmuOLonCTtEp3hzEbMfsa7hsFF9Nn
	 Dt82B6PjRIDWDUpLz+Q1uQHxmQpSuUlNrpGUrui/VoEpDHexxV3LKVy4j8+QiOrkKI
	 kVCqfFTAaC8kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7439EFBB7;
	Sat, 18 Oct 2025 16:01:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove the PER_CPU_OFFSET_SHIFT macro
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080329424.3028979.3497089590712775875.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:34 +0000
References: <20251015225604.3860409-1-samuel.holland@sifive.com>
In-Reply-To: <20251015225604.3860409-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr, charlie@rivosinc.com,
 rkrcmar@ventanamicro.com, thuth@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 15 Oct 2025 15:56:00 -0700 you wrote:
> __per_cpu_offset is an array of unsigned long, so we can reuse the
> existing RISCV_LGPTR macro.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/include/asm/asm.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Here is the summary with links:
  - riscv: Remove the PER_CPU_OFFSET_SHIFT macro
    https://git.kernel.org/riscv/c/768e054de01b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




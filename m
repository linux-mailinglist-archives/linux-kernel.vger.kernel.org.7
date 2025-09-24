Return-Path: <linux-kernel+bounces-830897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C611EB9AD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58CB19C32E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82AF313557;
	Wed, 24 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgH4HDO5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E78313535
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730208; cv=none; b=EESejJR5PfEksHsyMv8YtBZWCCKyafd62Qy39wzjkEyYPUKMZAR+AjzBZJefFZPd3H1feuIt2aXhGmfTprrBW4fGOVAs4uJ1bPB6oY1yKfPJw3BNl/mrH2xr0cMplgExhGfqac2QCftporpFEYyfN6BBBbCrhfZiYWYQICg0hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730208; c=relaxed/simple;
	bh=m73kcVysURDl6GXQPRTNE13OfbCK3ha4T2Z9R0aQT0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTYJ55QNtP4kgeD62oOkY7N2dlaeyk7ObNkDije4W2gkplXWU7z+UoL1BR1NPDUsR1GJa5LmlPGM1HP9935lT5PYANjiKDL4rkmjr4UCZ0UghDZkdaYf6PQGCfbpKGusR1oOr21rTn16DYmrelAhPXT9/VhUjY86Fg9+Meft1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgH4HDO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB13C4CEF4;
	Wed, 24 Sep 2025 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758730207;
	bh=m73kcVysURDl6GXQPRTNE13OfbCK3ha4T2Z9R0aQT0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgH4HDO5JWOt+xsLlEt99a/nF2CGleqbKiPNKAgj447l00w3BeLL7y+DhRVxyZHVz
	 VUSHt8he7/R9+ksWXMVa3RBwTLLc2vY7Xa7bc648y7WlCT7rKmMgRxHI15EzZuRZmx
	 4NY6LuJ8VTBpTBEy8yNCeIoB8KEkV9iL3EPFDtL4qqZrhFsJRBw12fRuIAitOHfbOk
	 87zYFVuoR3Dzb2RHaXkNdSVAZzlf0Q65BfECk4+CR3Ifo8aUvhL4WCMQ1jiCHUH4b8
	 8LM2RIkdXZdWUMeAC0yjV38+e9AICAlKRaqmCXkmBgwJtcOlO+cvGa+AIe5c/3uQ9+
	 fKImi/JcxUMDA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] arm64: cpufeature: Remove duplicate asm/mmu.h header
Date: Wed, 24 Sep 2025 17:09:57 +0100
Message-Id: <175872868780.2472667.3542607606720611909.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923035023.3166679-1-jiapeng.chong@linux.alibaba.com>
References: <20250923035023.3166679-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Sep 2025 11:50:23 +0800, Jiapeng Chong wrote:
> ./arch/arm64/kernel/cpufeature.c: asm/mmu.h is included more than once.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: cpufeature: Remove duplicate asm/mmu.h header
      https://git.kernel.org/arm64/c/ea0b39168d3a

Note that I dropped the Closes: tag because the bugzilla link was giving
me a 500 internal server error.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


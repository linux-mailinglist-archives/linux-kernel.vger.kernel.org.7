Return-Path: <linux-kernel+bounces-758064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD71B1CA7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829037B0B16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26BD2BE645;
	Wed,  6 Aug 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ+mFBaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6332BD580
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500533; cv=none; b=o1aqyGrfZsrNGvFXn92UN+TgutfEh4Ipv8+tD9zXzsfCf/IzA+F3Tn0db1bd1zeCSIJcdyYL7Ax1lYBbLC0Yfb5+IvCrhj0zMaaC2/6XF0F0N1AvW6ImnTMOG/K6SNeg6KPpmv8cE7tdMKzsOtdyumTRoUtraBWC8JIMKgnkGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500533; c=relaxed/simple;
	bh=OzPZZZJi1pVXgGVIG8cpBKsbVNQulHiuq38zkRzTI2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxUDof/dMIITYjmuskCFrXT5FV7atZHKE1QDw+j98EdQwCmuzX0hEs2M9bYrc12MFG9yK0+1BA0JesZ3uayQjNZAOJ+aTG+FK2F49pRlp+J42bhbwmVDkhNg8YPK3rrh5C70ZXtt1+I3iLmUc18TyoK+BUYarvAfilgZpqwXYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ+mFBaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A0EC4CEF1;
	Wed,  6 Aug 2025 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500532;
	bh=OzPZZZJi1pVXgGVIG8cpBKsbVNQulHiuq38zkRzTI2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZ+mFBaL/1w6jfQaSj8zmVTAh92n616XWk9KiJKFrNtnOOEr7Qw9WRQB3NpGxJv88
	 C4zz/Fb1D+AnlpNTwZTfq42WABoJKeIH5cIeERvwY3XlKfVQxN7nHxJUrKNYkcvvze
	 KFCb96HeMlH5sKf9IihiggA55VgnWDQsmBhiV1gzJ6nNBVpv2Yal163kWaRiwb8r8/
	 0wh5odLC/mr4S26UNNgvOsrWZXhNUDv8Ikn+SKtEJAjA95TRHKGrgi1aoKCvH3qLX3
	 ds+RgKd7g/ardfBsYU4Rc+bY2uQsXmcVvcv691RNpT5YQkoTYv2KnwiT8NgEVtYIP4
	 Q3E0SN44pJ4Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED5383BF63;
	Wed,  6 Aug 2025 17:15:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054624.2863135.16531031076393006761.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:46 +0000
References: <20250713155321.2064856-1-guoren@kernel.org>
In-Reply-To: <20250713155321.2064856-1-guoren@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, conor@kernel.org,
 alexghiti@rivosinc.com, paul.walmsley@sifive.com, bjorn@rivosinc.com,
 eobras@redhat.com, corbet@lwn.net, peterlin@andestech.com,
 rabenda.cn@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Sun, 13 Jul 2025 11:53:19 -0400 you wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> The early version of XuanTie C9xx cores has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> [...]

Here is the summary with links:
  - [V2,1/2] riscv: Move vendor errata definitions to new header
    https://git.kernel.org/riscv/c/736d67e4f0d0
  - [V2,2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
    https://git.kernel.org/riscv/c/b7f09bd30ca8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




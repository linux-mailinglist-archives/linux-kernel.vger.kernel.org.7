Return-Path: <linux-kernel+bounces-812486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB4FB538CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B0F165948
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46012352FC8;
	Thu, 11 Sep 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuBfToxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565A20FA9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607082; cv=none; b=lajUp48ksT3ThLrwcHbpW+Fri6at/dc4umuC+1oZaQLdJ3qlSdb1ugI0KkxU9fmaL6PlhqT5dAMeCc9LIEH+dFVvtLLggUXgO8APU59O1P89buPuRF7TYVAl6pnxgrqdCwIJ12esU9hROElWAVSmlQFMlkBWHmfB809o4MOReBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607082; c=relaxed/simple;
	bh=5vEajUiE8vOl+c0s0dvzPQu+3RLAa5VvYGmH9nj+aKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT3xlOCO7N8Ucpxa6/rR2lmP/me4l7o3xTsm8b2v4ZAAUKJLe8xeTrXcHSmZF03Gyq7KjKpvhiVTy9A9VCLroF6nppeoLxcEa8vtkLo87+tOSKyOJu+wRS5CRNSryIANo9o0P5x62SQfVqW84feM8XPIASmjGWOpIq90hrFav4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuBfToxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E70DC4CEF0;
	Thu, 11 Sep 2025 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757607082;
	bh=5vEajUiE8vOl+c0s0dvzPQu+3RLAa5VvYGmH9nj+aKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuBfToxkwuIfFk9nR7Y5ZKaZTpqeEbvLsL+qmycMw0U/DWbqdVZBI+xfRcTJIXSjv
	 +ideQ2F+dkvBGRcPw0TI7raAqdbPKd3p1xPevy0lLKkhe3cp/CDA5JYm3dlXveJgt5
	 c9HxB+j2wC/hdSdy+H2WS8xkBdq+0tfdl5VRfb2xPplBMrhcsWtsayftcmFSKBpAxv
	 3UcG5VZwZsZAC0o5XyqoBblq8tADG28vOkNDOCtXcSVNULNKRqppuJntr6AzgZZEa8
	 yBbpzDWD5bwn4ULjxesg/J8dOfFSpOyE2jdRpl3CnPuWPP1HdLCvrmMEnWke1BfDdP
	 hPOi2tnQfXZ7Q==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	oleg@redhat.com,
	sstabellini@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	mbenes@suse.cz,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	chenl311@chinatelecom.cn,
	liaochang1@huawei.com,
	kristina.martsenko@arm.com,
	leitao@debian.org,
	ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 0/8] arm64: entry: Convert to generic irq entry
Date: Thu, 11 Sep 2025 17:11:12 +0100
Message-Id: <175760255687.903003.14486495786906094929.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815030633.448613-1-ruanjinjie@huawei.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 11:06:25 +0800, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry which makes
> maintainers' work easier and codes more elegant. So also convert arm64
> to use the generic entry infrastructure from kernel/entry/* by
> switching it to generic IRQ entry first, which will make PREEMPT_DYNAMIC
> and PREEMPT_LAZY use the generic entry common code and remove a lot of
> duplicate code.
> 
> [...]

Applied to arm64 (for-next/entry), thanks!

[1/8] arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
      https://git.kernel.org/arm64/c/788b8f6af60b
[2/8] arm64: entry: Refactor the entry and exit for exceptions from EL1
      https://git.kernel.org/arm64/c/ee776d68ba47
[3/8] arm64: entry: Rework arm64_preempt_schedule_irq()
      https://git.kernel.org/arm64/c/77c195394639
[4/8] arm64: entry: Use preempt_count() and need_resched() helper
      https://git.kernel.org/arm64/c/c74c44c6ae20
[5/8] entry: Add arch_irqentry_exit_need_resched() for arm64
      https://git.kernel.org/arm64/c/3c973c51bfba
[6/8] arm64: entry: Refactor preempt_schedule_irq() check code
      https://git.kernel.org/arm64/c/64f4b8b15f1c
[7/8] arm64: entry: Move arm64_preempt_schedule_irq() into __exit_to_kernel_mode()
      https://git.kernel.org/arm64/c/99eb057ccd67
[8/8] arm64: entry: Switch to generic IRQ entry
      https://git.kernel.org/arm64/c/b3cf07851b6c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


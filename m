Return-Path: <linux-kernel+bounces-827284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5DB915AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884EE18A51C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314130F819;
	Mon, 22 Sep 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0m+pYkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEB30F55D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546912; cv=none; b=X9Kpv3SjaZ7ZwZ0+gwSBNqqh/2zi6vO52lW6ulE5FGja+4T2KpyU26XXR2/hB3XwnOwDQR1O0pge3Hs3tYsaA21BKkcuUFiZNMHsIz3/pJyOnSw//QGRTl8DVI0CMACqJzsXxYwOkT+5o0weO2LT5cNgfDQQaSrqHe+GNRzfkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546912; c=relaxed/simple;
	bh=aw8d7TQnMiVx3O3D0Yvpldr55/2d+Rct4+8tg2KDwhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQweUnFAcEHVB5LJAbKlTCLLVatCeGVGzeDlQwn8ylF052QJlFPJvJHhCVEOlqY9GmbSiY38HuhU7RROjdii3mmS2dCx14VQuQ1X9RWVMUeQQxuLn8CQr+jcGa7VH61bSmgw7culTupXsxpyI7Xb/oZXNFI5zWAImy4Rw3Zu4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0m+pYkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59DC113D0;
	Mon, 22 Sep 2025 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546912;
	bh=aw8d7TQnMiVx3O3D0Yvpldr55/2d+Rct4+8tg2KDwhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0m+pYkjM6o8XMa09ll5baluyQe+riaZZmoTwY/xyvo8fCoMwqsJlhQNcqbdUp5Pw
	 JvcyVos3WCjGmAnOVu38oX2C5WLJBba9OOHWuuceUHDVB0y1GRydYNLx6ml6Zmx6lj
	 Mjo3uak67QPzPpPWsAvimTU0Uo+ZYPeQgOIYuxSr1Og6H3ZMSNk1x6mAhp7bCKxhMF
	 JN8q8b4JPcEtD4G5StM6kTRx7JavEaKBwrXx1RoVL1S20SQrye44BrfII+6IgyhBaV
	 VPz/YBzzGGXNGSgEmRErePHbag6KaxMfbYAl9CY8/qn15cgD8WXfyyR3AgbxbY3Mfi
	 /t3zB4TvcPbcw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Workarounds and optimizations for Neoverse-V3AE
Date: Mon, 22 Sep 2025 14:14:50 +0100
Message-Id: <175853683592.1350681.8237584408369869851.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250919145832.4035534-1-ryan.roberts@arm.com>
References: <20250919145832.4035534-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 15:58:27 +0100, Ryan Roberts wrote:
> I know it's late in the cycle, but I thought I'd try my luck at sneaking this
> in.
> 
> Neoverse-V3AE has a different MIDR value to Neoverse-V3, but qualifies for the
> same workarounds and optimizations ("SSBS not fully self-synchronizing" and
> BBML2_NOABORT) so this just adds Neoverse-V3AE wherever Neoverse-V3 appears.
> Details in the commits.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/3] arm64: cputype: Add Neoverse-V3AE definitions
      https://git.kernel.org/arm64/c/3bbf004c4808
[2/3] arm64: errata: Apply workarounds for Neoverse-V3AE
      https://git.kernel.org/arm64/c/0c33aa1804d1
[3/3] arm64: cpufeature: add Neoverse-V3AE to BBML2 allow list
      https://git.kernel.org/arm64/c/8fca3852e33d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


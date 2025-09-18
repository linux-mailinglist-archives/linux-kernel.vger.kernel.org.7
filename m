Return-Path: <linux-kernel+bounces-823620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4643B8705C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C867BD0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C72F4A0A;
	Thu, 18 Sep 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovuu0LYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECC2F3C02
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229824; cv=none; b=dkimqHHuRkZKpX1VOs2rznKLWdm6VlyKjdsePt/+Umu5OiibdGWDuoxChHTxtzoIwhDdnOIw1k/k/+6Lf/E1L5AV1maY6/1qbd4IOOB9R4CSbRHYI6EjU9wxpid4Or0BJwDdySLXDBp/ONEfESqB1IbqEvfi//FlvXwi/VEcVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229824; c=relaxed/simple;
	bh=mmPjYKb+Qj8tpMJDfrTGOA3tvv71+iK7ZDNstQo1RZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRrGqrCj5MSotcnjqhERMvPW1m4P7j7afBy45QaPealAr1hYfb1IWx2g2T83ONGFTIY8Sg7pOM6tmcwmbOv407NoJ/YPAS9MetNnIqC9HUWcX2p7kF9bxui//cgmedAfFfti8Wixs1TG/PZWiknvopJ+m2jPxOFZq6WrLEbQBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovuu0LYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C50C4CEFA;
	Thu, 18 Sep 2025 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229821;
	bh=mmPjYKb+Qj8tpMJDfrTGOA3tvv71+iK7ZDNstQo1RZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ovuu0LYr+kXH1+5LJdzcfJJbmgK/ntmna5r9MNgxX/+UOvIOCWbLQvcI/ulU6khgi
	 oS1HkS0UMk+U42xCvZh6HDy2n3uwxsk5Y1Ilmiiq9jpAXTF4gQq+MiWSS7P929F2OL
	 IHyeE8z9+FDZxQ1nTwoixfcYrYbXaRGjxormbqj9wAAoFx4MUFKDhCGJr5H2KwiA9P
	 sdkm+y/6LgXwfELp7Cqoa//UrQ51u4NQ0fSzh2pCWq5Wb+GELw4bTIuEnvB+avbldQ
	 cckC3IpHaLMGifHsUNr0yVCfszGqsnZ/MdyeOn+2Yn54Jp4HtyfiDZg4mx41kZvCkT
	 T+8oZnDMWHnSg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH 0/2] Enable FEAT_BBM (Level 2) for Olympus core
Date: Thu, 18 Sep 2025 22:10:07 +0100
Message-Id: <175822329813.3545519.16720487758177130012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918132548.1141306-1-sdonthineni@nvidia.com>
References: <20250918132548.1141306-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 08:25:46 -0500, Shanker Donthineni wrote:
> The NVIDIA Olympus cpu supports BBML2 without conflict aborts.
> Enable ARM64_HAS_BBML2_NOABORT by adding its MIDR to the allow list.
> 
> Shanker Donthineni (2):
>   arm64: cputype: Add NVIDIA Olympus definitions
>   arm64: cpufeature: Add Olympus MIDR to BBML2 allow list
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

(note that I dropped the tools/ part from the first patch)

[1/2] arm64: cputype: Add NVIDIA Olympus definitions
      https://git.kernel.org/arm64/c/e185c8a0d842
[2/2] arm64: cpufeature: Add Olympus MIDR to BBML2 allow list
      https://git.kernel.org/arm64/c/cc80537caaa7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


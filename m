Return-Path: <linux-kernel+bounces-823619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A29B8704D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804D7626AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE12EA47E;
	Thu, 18 Sep 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frNq7MEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FA2D594D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229817; cv=none; b=UQX2to1WmyA3m3TlDQuHNZza80qkU4/6xuUoM+6yW4QhIUrdJOyb+Lr+ls4/Dp1xmTUlvJGQ7m+Yraq7ivxJGETbCmhml1YPKfkYWUozxyFgJo0BWm+0AyUhuDYzL9YtFEgd4nvG5vu7SkbKeK0/u++57og0yGI/yJAaIjnkpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229817; c=relaxed/simple;
	bh=j1CTtjGm+jrGFTPTDIMFfFXN9BLb03q1Mg0JiJ+5ylc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7JN2Ilgc5vsV2utRwd15zI3Tp9c+tnR5++E1z+pVeL8GLObhQL+Sv8Cwr+w0kZnjQcr7YVWVwwGvEJpUfMCQVpENQlOhSPzYVh3FHxBFOY5tpXZClYNSpFGZ2PBb852g7Y54h5fyFFZU9vCMFDy4M/AjQdNkYCUTmegkLjI2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frNq7MEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53681C4CEE7;
	Thu, 18 Sep 2025 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229816;
	bh=j1CTtjGm+jrGFTPTDIMFfFXN9BLb03q1Mg0JiJ+5ylc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frNq7MEs8uQvQ2H6fiYsY+ZDphflomx42JRFqskCtNqck+vRIZHnG0HeO5e3edclL
	 BbjLsGqD3TmXcp4xuL9pycdqzOrdVFx4Np0+M2273Gclce9P+b56R5M87FkMgeYAyZ
	 WcLAsHPQhGnmSUGpFsB7ekKcI5im9O1ylWtlqw0f1M/BVC9gwDYqKUG7ZIGGepCGsU
	 ycboPC6UDpEfTmLRtfco6Ow3IHqI00tXQru9V1Y40hzuDgfvZF4e4A7j6yzgusDfeX
	 /qW06qAbIZ0wEejIqPywsj8PEc6dlobSOn8sNnOFPbgoRO1KjTDnUx9NTCKYwOHJgd
	 OTMaqzDMlbHuw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Jeremy Linton <jeremy.linton@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	liaochang1@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: probes: Fix incorrect bl/blr address and register usage
Date: Thu, 18 Sep 2025 22:10:04 +0100
Message-Id: <175822602063.703125.494053900347788765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918175424.3483164-1-jeremy.linton@arm.com>
References: <20250918175424.3483164-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 12:54:24 -0500, Jeremy Linton wrote:
> The pt_regs registers are 64-bit on arm64, and should be u64 when
> manipulated. Correct this so that we aren't truncating the address
> during br/blr sequences.
> 
> 

Applied to arm64 (for-next/uprobes), thanks!

[1/1] arm64: probes: Fix incorrect bl/blr address and register usage
      https://git.kernel.org/arm64/c/ea87c5536aa8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


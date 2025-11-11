Return-Path: <linux-kernel+bounces-896117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0903C4FAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF04F41C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E333D6CD;
	Tue, 11 Nov 2025 20:17:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96F33D6C7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892257; cv=none; b=keMkX2mfeWIyHoY1j0ujBZW5v43pVWAVJ7+T8kBBN/qvOYpXphR8xpAhqjtZc2q3qjUHFVRaQ+vvhbgjrW7o9Fd9+iXQqEtQFwOuQWzb8aJ6j+3/G1CsEIXpFrnZp1eA899g0u3sxzKoFEFc71nbSAXz31v4BslHar2ikmQuJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892257; c=relaxed/simple;
	bh=Aif6rhd063oEAjJOx/btbQ3ZQoQUqppHYFKb7oS0Mk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enjHsynoBX2CxjPnhLPi8pri+YytvG2n8OwCmKQUnp8tav+DU84086MsPDbluex/gE/ygusJsQxUynJFQJebwldLlpNHkJAysm5NlHYlZAPHapL8qK5Z1Ei5du5urygQI/5vXLLMs+h302EOh5HDCCRNR1KVSvn3/03DerVsG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDDC4AF09;
	Tue, 11 Nov 2025 20:17:36 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add unlikely hint to MTE async fault check in el0_svc_common
Date: Tue, 11 Nov 2025 20:17:29 +0000
Message-ID: <176289222849.1642362.17670796678986309614.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919033327.1942730-1-liqiang01@kylinos.cn>
References: <20250919033327.1942730-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 11:33:27 +0800, Li Qiang wrote:
> Add unlikely() hint to the _TIF_MTE_ASYNC_FAULT flag check in
> el0_svc_common() since asynchronous MTE faults are expected to be
> rare occurrences during normal system call execution.
> 
> This optimization helps the compiler to improve instruction caching
> and branch prediction for the common case where no asynchronous
> MTE faults are pending, while maintaining correct behavior for
> the exceptional case where such faults need to be handled prior
> to system call execution.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: add unlikely hint to MTE async fault check in el0_svc_common
      https://git.kernel.org/arm64/c/df717b9564c8

-- 
Catalin



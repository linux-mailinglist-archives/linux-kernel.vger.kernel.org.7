Return-Path: <linux-kernel+bounces-742488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345AFB0F247
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F01C224AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945972E764C;
	Wed, 23 Jul 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3orR7SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE462E762A;
	Wed, 23 Jul 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273779; cv=none; b=HhGfanjsXTQMwSE1pfglnOUzB/UfIfufYkouQmZIVrLGNr7AKta6AXxugIAjT1350ZJr94JRYl/mF3jtgXcLCIzVgntd7E/WyI5VIMLFttJIl4LlbvxFI7YlY+17m9e5QngZHKgRONFaO0msyyXTv0A/eg5gyrgLng5XPPIdV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273779; c=relaxed/simple;
	bh=Eks1ShTcI5ZOfiYTakJ06LR1ihFE+efz+MdWoH3u8Jw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pfG2/2m5upLKEAIdI+BL/zPdiFUqO/I8Pqnf4R41ypSyNJXHc+0kPhTtV2/ZQmZSXi/S8UGla9DciFqDaVDCLpGLl+uSY6ydUF/FX3symvqW3fpBPJoGNZcDCwSfX0KanbwtqKBGPyxbaBaok+UT1KhfGxK83Ez5NM9A58kW7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3orR7SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58515C4CEF6;
	Wed, 23 Jul 2025 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273778;
	bh=Eks1ShTcI5ZOfiYTakJ06LR1ihFE+efz+MdWoH3u8Jw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a3orR7SPRH/sXm2lc1SXv676z7bsnBLflvYzr+FPBL0l9BaGPD+GjrvZt77brFiF6
	 0152WLJ0f4xHMdAPWUQghVnTBdPBQaSQM30s4EV7YFkhdoT48BGaZ+mlOeaTIvDNR7
	 y/SuyTtU5YUCHw7aqXEYzj33AxCkFfdoN8muNN9YM8UInRUBChgzQX/1tqyZQOgPpH
	 L/F8xrwaTylQY0SoGdhVqYBNoFpSZ/u82SZ2Q7EtrqHfHHH4YaAoelUi7uWjzekafC
	 J/in/56DXDPlnbvbyPEfw0ET9PzzrPO3W4gRPAgW9JQDufq2Pu7fvpaQ0yEx2HOk5L
	 ij4YpuF6HycKw==
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250707075752.28674-2-fourier.thomas@gmail.com>
References: <20250707075752.28674-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] dmaengine: nbpfaxi: Add missing check after DMA map
Message-Id: <175327377697.189941.4354617841916329738.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 07 Jul 2025 09:57:16 +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> If the mapping fails, unmap and return an error.
> 
> 

Applied, thanks!

[1/1] dmaengine: nbpfaxi: Add missing check after DMA map
      commit: c6ee78fc8f3e653bec427cfd06fec7877ee782bd

Best regards,
-- 
~Vinod




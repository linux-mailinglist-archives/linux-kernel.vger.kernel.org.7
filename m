Return-Path: <linux-kernel+bounces-783536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D26B32EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44CE3B188F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66371261B70;
	Sun, 24 Aug 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8YSmOeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1408214807;
	Sun, 24 Aug 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027511; cv=none; b=A3BdGw7FwiHeNB9A1+yK7v0Clhyi+4QKYeV7LGvjRepQHoT/0mN18VJRMw3lt63Pa5O9NEBt3Rsciq+kqb/KfCzgiIhlJHugqlOCsVRzzv8PLEPzeQLWn+Q6bfzZojNn1fkE5TqSP9u+WfhnqFpVT3s7A+L8p63hC+Gx8aKtJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027511; c=relaxed/simple;
	bh=S2Hs0y3UyUhNqz6ZmS2Je0osjxQ8a6YMieoxMFUDa7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clFjA3ppFCp3YCNxcDIwxvXj3zYcvFCNBlZ5LlOhAuKCknUgR+bo8LL6YGk8gr+6DdRi8gDeZzdAq5/oomXUcj24rsiWQDqcpxN5OuLp3xCxPxSgtb/SdiSLq9lJfsK7EAsJTKrjsD1aKaqyn99/BbSiDFTwjvLqc3tsjgDRbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8YSmOeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8392C4CEEB;
	Sun, 24 Aug 2025 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027511;
	bh=S2Hs0y3UyUhNqz6ZmS2Je0osjxQ8a6YMieoxMFUDa7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8YSmOeRjWNHNjjzRccSnLr2QjzZ3HqdwNcOJKD9CiTF8n/dkgsEAoTeqz4tjuLTJ
	 HCHO0VT8E8Tu0MGvmExgPQS+/8bFEO4XZgv0xotG6t+BFoeaRkC80YrffzE/1NhbSe
	 U80t1vQfew0fBdZ3wub3fEDp6Bi0zZqZRD3NryOQf4Tp+iObVLIKf/svVth9o6IILz
	 byWpJPN/SytHioQBEm8ktBICLo3t8eupBUN2CYBiuwfxpNF1/DIshnjVdHxOlXfcf9
	 8B4RmQMUZif6q0bFU7Fa9R0Dnk6ko/ccuzqk0wIrtqcqjvf3jM1urE1nmFT5iMQqWv
	 ns4Bov0LoIqjA==
Date: Sun, 24 Aug 2025 11:25:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: memory-controllers: add StarFive
 JH7110 SoC DMC
Message-ID: <20250824-new-messy-raccoon-1c26b7@kuoka>
References: <20250823100159.203925-1-e@freeshell.de>
 <20250823100159.203925-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823100159.203925-2-e@freeshell.de>

On Sat, Aug 23, 2025 at 03:01:41AM -0700, E Shattow wrote:
> Describe JH7110 SoC DDR external memory interface.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  .../starfive,jh7110-dmc.yaml                  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

There is no memory controllers driver change, so I am fine if this goes
via SoC/DTS tree.  If you want me to pick it up, please ping on IRC.

Best regards,
Krzysztof



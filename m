Return-Path: <linux-kernel+bounces-807292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E379FB4A2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55784E3FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8C2DCF6B;
	Tue,  9 Sep 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcoH4q0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF478F59;
	Tue,  9 Sep 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400788; cv=none; b=kVDW59H/G/ny4oj//I/X8ULEPDoFU/S5PIB5ioBy0pLMYahNtK0hhYbyD/JeYkM2kVeDPuXriMmnIGBjcGejGMvJiUNkqHosIFpI69gfKkOTYUtEjd8kGGqhzdDnXK9mDzy28NDqo/HA3bK5KRE0nOOekU7A8aKjy2sQZXS6s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400788; c=relaxed/simple;
	bh=Hco75eSdLR65M9UxB56opHwogsO7S9rVeVew59lMe44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCCmYJfi71zgK4sUq2WsGbcXUgQtyTLa7wGpl0zhE5A4FtAgBH5WcupxjaXNk8peBCgL+qICp3n5A5eUcF3Njm1qpffQUzD1H0hVD6/65QGR3m9luh+eKZjj5GJUk84WByFmCzLDsFrqztfotOdnxYuv8bt3R4iW7k3/klpY2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcoH4q0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D9C4CEFD;
	Tue,  9 Sep 2025 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757400788;
	bh=Hco75eSdLR65M9UxB56opHwogsO7S9rVeVew59lMe44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcoH4q0V9L6wYM5vZtTXEaG+WZLTyAAYEEgG4sP/iA9TiqX7Jlp3Al/6aP+h35naQ
	 ofLn+bPrHtTkDCZgQYOi+xVyVqmFVEtX+3ck0IJGGkgSGAWjIIibJIonmrj6IEnHq5
	 lkgqYJTJ8RTW3E1tnSdW1UpUmH/dVYEwzkg8ER2FojlHaQFibw76xU37RL66VSntym
	 S0O955c/VGkE8i1/4GcMNKwkJOoEFjvv+3SqUiciLppanY+y6fiE4+Itt3Y+xJwhyP
	 B/4o+3TG7bsmGrcRT/EnaIRihAeeUmZkycH5ZFuNj2zskFnl6XpwCXIyHMYDGLgR15
	 FFXlHnayB6BPQ==
Date: Tue, 9 Sep 2025 08:53:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, robh@kernel.org, krzk+dt@kernel.org, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: microchip: document icicle
 kit with production device
Message-ID: <20250909-accurate-wisteria-spider-222341@kuoka>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
 <20250908115732.31092-3-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908115732.31092-3-valentina.fernandezalanis@microchip.com>

On Mon, Sep 08, 2025 at 12:57:28PM +0100, Valentina Fernandez wrote:
> With the introduction of the Icicle Kit using the production MPFS250T
> device, it's necessary to distinguish it from the engineering sample
> (-es) variant. Engineering samples cannot write to flash from the MSS,
> as noted in the PolarFire SoC FPGA ES errata.
> 
> Add specific compatibles for the Icicle Kit with Production device
> (MPFS250T) and Icicle Kit with Engineering Sample (MPFS250T_ES).
> 
> The icicle kit reference designs in the v2025.07 release include the
> Mi-V IHC IP v2, used to send/receive data between clusters when
> using Asymmetric Multiprocessing (AMP) mode.
> 
> In reference design releases prior to v2025.07, the MI-V IHC subsystem
> was included as a proof of concept in the design prior to becoming an
> IP available in the Libero catalog.
> 
> Among other improvements, the new Mi-V IHC IP v2 includes some
> changes to the register map. For this reason, make use of a new
> reference design compatible to denote that v2025.07 reference design
> releases are not backwards compatible.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Why are you sending patches which are already applied? For two weeks?

Best regards,
Krzysztof



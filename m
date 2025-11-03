Return-Path: <linux-kernel+bounces-882469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B27C2A86C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D364E8537
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122182DC322;
	Mon,  3 Nov 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPgHPj60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF42DAFC2;
	Mon,  3 Nov 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157875; cv=none; b=d5CRNsnHAGZDA5Pvj9VitCVRXD7Ll0GlOAJsw42CBFPD+l9jb67PMo6pgiMaJLzIzhMlyqCpo8PKWm88szC/8xIQOwkwos0YzWN/hfuH+QyxkY9mpF8kTQKuxHCecpEWx4tgUJ9I6oG2iDqv3Dx3DMyUeEK5TRlzmSsbffGFt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157875; c=relaxed/simple;
	bh=e4eP8kIUbnxFkpE508lw7JjVKEVh23zzNZi3k04+VEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbSLAIorYuUhLUCLIJE14h3+JNnaAdybye/dywhOYzIoTNRwQaYWpELzwr4XyzrEV/16OXc+fZnySKD6HCIEiRZJw6zNYhodMKH4tIvissXg1Uarg8oqmVSaaHkxkFkyyCYrt3WvvaaRs64oFYF5s9O23X8gu1LA0U9c3AoiETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPgHPj60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDA0C4CEE7;
	Mon,  3 Nov 2025 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157874;
	bh=e4eP8kIUbnxFkpE508lw7JjVKEVh23zzNZi3k04+VEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPgHPj60n+mdv62mBOJGsVRWqHQ01Gjr7rTSTRIbj0hEjbXQsio7zNnampwXmqVfr
	 Sa91lh+8Xq11c2+0Eob2Mol7XBSQJj7zWPNQ5V/g6F1JDR4dqvCiIP9HT2K+AkNAcL
	 Getpo0YGj7SaTIBeEQrO9vLl8D1dpFVaLA9BHQJwYUBay5ujiO3DOp4ST9WOasWYrR
	 iEe9bbG/vX18ImVYbICTXGNw3rJ2W9y7N7ru3GyHbfFCGaO8tCGT+29JaOtPbGXYKS
	 2Tw6/LfHfQ+08W0UHnbz56r9V02UmWfUDrvk7LicyK7GpLoz5kyMept3/H2CWlbjR9
	 BFmCJrOBptHrg==
Date: Mon, 3 Nov 2025 09:17:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v6 1/1] dt-bindings: interrupt-controller:
 aspeed,ast2700: correct #interrupt-cells and interrupts count
Message-ID: <20251103-economic-lime-chupacabra-d7adec@kuoka>
References: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
 <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>

On Thu, Oct 30, 2025 at 02:01:55PM +0800, Ryan Chen wrote:
> Update the AST2700 interrupt controller binding to match the actual
> hardware and the irq-aspeed-intc driver behavior.
> 
> - Interrupts:
>   First-level INTC banks request multiple interrupt lines to the root
>   GIC, with a maximum of 10 per bank. Second-level INTC banks request
>   only one interrupt line to their parent INTC-IC. Therefore, set the
>   interrupts property to allow a minimum of 1 and a maximum of 10
>   entries.
> 
> - #interrupt-cells:
>   Set '#interrupt-cells' to <1> since the irq-aspeed-intc.c driver does
>   not support specifying a trigger type; only the interrupt index is used.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../interrupt-controller/aspeed,ast2700-intc.yaml   | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



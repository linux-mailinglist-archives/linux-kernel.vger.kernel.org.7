Return-Path: <linux-kernel+bounces-781357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A37B3119A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0218D1CC535F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB2A2EB5D1;
	Fri, 22 Aug 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz+DcCTv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C72E9EA9;
	Fri, 22 Aug 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850627; cv=none; b=NCgEWDhXYrfRRozxyzh6bPzxndil7JqRbaBouf1ukOINJ2kMj/i9KP81Lx9giQ3oYDbIc4l7FdRQcRyFDoGp1Qqke0U272ZV/73oAYP/kIb7BdlI9CO1trDe28Vy9ZGAxmlMWAkdr6B3tP8FztZ4KzzFTEGkc6nXgHtxv5/acgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850627; c=relaxed/simple;
	bh=EbORPN2iJKLpKFOR50XHkuBFz0WUjg9cW/T4/Cf7FdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRIGUJ6P6xkr6klvUEgyNOGQ5dUQ8CyFmjH8waCLXznb/c+wsiEbPjfhWiisyhTmMu1latB3po3wPJ8iJXJvzpEl7F3WcsXUhU78kdxGNiH0PYq7Yjy2OPumqCGzWyvNCgPFZA5SRh2/tf4mFnYBx1SKGFeksdWUbKiXXXU2e+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz+DcCTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3A9C4CEF4;
	Fri, 22 Aug 2025 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755850626;
	bh=EbORPN2iJKLpKFOR50XHkuBFz0WUjg9cW/T4/Cf7FdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xz+DcCTvWUtx6w5Bq9wvjapFgw9hAfiehSNZokoSK0bzMTGw0H/BwaV7bmFvvpSmu
	 4onb4j15cF+R6Y9LQbmukU81Imq4K/RYNCxmT/le5teKzMYrO3lJqRUkQaqxcPjfAS
	 xfQzlDP7EazTtNzzLrVOltBmx6zRmJH2kr8W74Plf8c1B8ADyrpTdPi7UxvoMYTgNH
	 B3HD51/GYr2O166+OvBgp2ROjLIv8mvWDyyn3o9wa16CwCtcarQq9qoH1TfDtmLtoW
	 USK1m9qxni4oubkgFzaINIY2dsnDPpRz3iI65VrKipudwfGK+AFX3x6MryRNrIZ/8K
	 AVK/EI4NzApZw==
Date: Fri, 22 Aug 2025 10:17:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Richard Leitner <richard.leitner@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: usb251xb: support usage case
 without I2C control
Message-ID: <20250822-quantum-hungry-orca-e6c6cb@kuoka>
References: <20250820161743.23458-1-jszhang@kernel.org>
 <20250820161743.23458-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820161743.23458-2-jszhang@kernel.org>

On Thu, Aug 21, 2025 at 12:17:41AM +0800, Jisheng Zhang wrote:
> Currently, the usb251xb assumes i2c control, and the corresponding
> dt node looks like the following:
> 
> i2c {
> 	usb-hub@2c {
> 		compatible = "microchip,usb2512b";
> 		reg = <0x2c>;
> 		reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
> 	};
> };

Above is redundant, obvious from stagtement that USB can be a device on
I2C bus. Just keep it simple.

> 
> But from HW point of view, the hub supports usage case without any i2c
> control, I.E we only want the gpio controls, for example the following
> dt node:
> 
> usb-hub {
> 	compatible = "microchip,usb2512b";
> 	reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
> };
> 
> Modify the dt-binding of usb2512b to support this usage case, and add
> usage example to the examples section.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/usb251xb.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



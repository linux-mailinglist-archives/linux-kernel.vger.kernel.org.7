Return-Path: <linux-kernel+bounces-884529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F22C30595
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BB189F5C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE7313524;
	Tue,  4 Nov 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Pc2wd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2962459DC;
	Tue,  4 Nov 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249920; cv=none; b=QQHbnBGtPhwE7+KCRkmAAzC6ZJE4E7bnxrIpWm9eZM3jU0VXIZSWLDJsErMOoeoY4owcXrgpFqeKHBus8URamJtu92Et9u5t73EmJ/Bn4BGJ5tw5vGD0UBt6jICt0C0IpUnklTlDaEgQvcam3DYdqnzLVBeem7al+tmBAIdJJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249920; c=relaxed/simple;
	bh=wNdYt90uqdaGUlBaeWYDe8FuBkRB5Vqr/izDKZMnQHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyZdwrogTqJRIRsN2Tf8G3oGtY4R5Tbl/g5isf+CmZ2dUBMNNtlHNnlGSqMlSVJI18IkZ42MgJQV9NY7ePQ6bBv8LkxiMz1h5WTtZbQdeMhtOwexlJSsUbL6aWppfAs2Wup6zvUqbwxsxJG6Nwn3iBYEIB7aE2vpr92Rq2t5Sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Pc2wd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B942C4CEF7;
	Tue,  4 Nov 2025 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762249920;
	bh=wNdYt90uqdaGUlBaeWYDe8FuBkRB5Vqr/izDKZMnQHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1Pc2wd2osFgzgrUS8qagrphCwyRBPipdUB2/51al+/n2+P6qyV3V9J1Cr8MlxSPI
	 7jjaRYCIo0PkIvr/LP+LjHs891ouOQQ9pBf1k0Zj3HPsF5AiuLucDMWBEx5B76ZMqp
	 phDQ2k64CgAgxZit79KJRN/mACjEfex9RKMN+WVbPqFpULrCW6PFo+mzMu0O3IoOqR
	 WmWiaCKvH3WoW6kdqsdnnKtgqVKYkAcs4xEWYfBtcnE1eMQWXLNLt/lMZsVfS2zPRe
	 3kFsmuYOF7ySZS51l3U1gKJffFDrp7UrlgVkmcikM9dy+AnhAVe/GkI4lK/SePYV0e
	 pzVa2QsShVhOQ==
Date: Tue, 4 Nov 2025 10:51:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: ST TSC1641 power monitor
Message-ID: <20251104-ruddy-tuna-of-efficiency-3321d3@kuoka>
References: <20251104003320.1120514-1-igor@reznichenko.net>
 <20251104003320.1120514-2-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104003320.1120514-2-igor@reznichenko.net>

On Mon, Nov 03, 2025 at 04:33:19PM -0800, Igor Reznichenko wrote:
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        power-sensor@40 {
> +            compatible = "st,tsc1641";
> +            reg = <0x40>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <1 IRQ_TYPE_LEVEL_LOW>; /* Polarity board dependent */
> +            shunt-resistor-micro-ohms = <1000>;
> +            st,alert-polarity-active-high;

That's wrong IMO. Either you use it as SMBus alert or as CPU interrupt.
If you use as CPU interrupt, then the flag in "interrupts" defines what
is the level of this interrupt. That flag is a combination of both
CPU/SoC side and any inverters on the device. And actually you wrote it
already - "Polarity board dependent" - so why do you:
1. Provide polarity twice
2. Provide inconsistent values - alert interrupt is level low, but
alert interrupt is also active (level) high. So level low or level high?

Best regards,
Krzysztof



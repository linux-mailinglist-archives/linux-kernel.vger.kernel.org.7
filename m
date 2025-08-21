Return-Path: <linux-kernel+bounces-779143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F5B2EFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662CFA2520B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23A2E92D1;
	Thu, 21 Aug 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ9I97GB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7842E8B92;
	Thu, 21 Aug 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761346; cv=none; b=kfoCTHwyBY+aK5oFdaH0YREWOSgWZPt3vRLjDXp3WVvMqUFxMg8F0o9TKx5KPr3riQPZ1MqHBTfDFc3kFpZNtPM4d48NjIYokiZTk7UP5Xk8CPagug8XabCErteKMVv8hAkrYr+jhLEo7LBnAIPXiyhxXui8Xc2hYSqOK7A0dIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761346; c=relaxed/simple;
	bh=r66I2kiPBFQQMFLmnRmcWaBbKixPZcG3Psuk+PUterw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeorZRmYMI0vmxgElD8KvcWcVvnkhbLF4XfkcyuyeczH7dM7nBaW4L/orO+oVWZp0Adlo+QJShBlDzMTdG4lKNv7X+020btRDqPzTajaDR1oBkBQcVgaGuKvkrcNTPZfplvS3qgk2TVJvOKIJJ3I2TKR5jGAxwMHRQ0uNN8cEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ9I97GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3852C4CEED;
	Thu, 21 Aug 2025 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761346;
	bh=r66I2kiPBFQQMFLmnRmcWaBbKixPZcG3Psuk+PUterw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZ9I97GBt2L7injbFo/Tb7RQuM7LfuqfJ6NhUOSDewCzPteHw8NMKOpsZ/i4CYz96
	 WLScCluQCdL2p2pe0+llm2dh3oeFkSL5iz+sN531ZyMY/jAIQa6VAJ8onSnX9svoBZ
	 12m8V1TT4y106QdvxxWUz84kaLrYyWQ+NQlvgw8ndTu0KcBJxu3/KC1LEOp5LMuvPf
	 CIysQuxhOXAB6QD4PfOc61RvHfcy7ygxAHvgi0nxs/OHoiBvmQskxqIaqiFp5jonvu
	 q1UBC8k2G9Em+jpM2YYiOEMaD3EHeZYYhjgYgK523ybzjrqeokRVRgkXRlgVemUCVI
	 PbWGLBlQA81zg==
Date: Thu, 21 Aug 2025 09:29:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Message-ID: <20250821-dexterous-faithful-mole-add8ca@kuoka>
References: <20250819215525.137080-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819215525.137080-1-jihed.chaibi.dev@gmail.com>

On Tue, Aug 19, 2025 at 11:55:25PM +0200, Jihed Chaibi wrote:
> +additionalProperties: false
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ti,twl6030-usb
> +then:
> +  required:
> +    - usb-supply
> +  properties:
> +    interrupts:
> +      minItems: 2
> +else:
> +  required:
> +    - usb1v5-supply
> +    - usb1v8-supply
> +    - usb3v1-supply
> +    - usb_mode

I think this should be just two bindings. Half of the properties are
different.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

You do not use this header.

> +
> +    usb-phy{

Missing space {

> +        compatible = "ti,twl4030-usb";
> +
> +        // 1 interrupt: OTG (ID & VBUS events)

Drop comments, schema defines what is here.

> +        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gic>;
> +
> +        usb1v5-supply = <&reg_vusb1v5>;
> +        usb1v8-supply = <&reg_vusb1v8>;
> +        usb3v1-supply  = <&reg_vusb3v1>;
> +        usb_mode = <1>;
> +
> +        #phy-cells = <0>;

Best regards,
Krzysztof



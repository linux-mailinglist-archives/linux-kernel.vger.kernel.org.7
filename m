Return-Path: <linux-kernel+bounces-792109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75387B3C03D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A491883ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA0322DCE;
	Fri, 29 Aug 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFX91NGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA821C9EA;
	Fri, 29 Aug 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483563; cv=none; b=lwoNfY3Rls1uY7Ju6M1xJn1An2F+zDRRMhW6o3hWGjvdwh5xgdp8Ny7h9LJX2YFmUex4Rl4+ws0HkOtvRnT4dCeldmnpIdQSKv0qxZLky9yPtqAAqo+Na40C0OkSo6s3aYInbKoSpAgtG1TA4FM+veB7qYZ8XXpkCDfFb5avfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483563; c=relaxed/simple;
	bh=OPMQ4rYf+/KiOsWsmQ2e492hplZ/+p3Od9JrRPKOmsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmh8V9zKrMx/ed1ugEB6nzEo0f5SqQmDzDKRPoZSrhbPSO/iz5W2MifmYRZZeizPmgbTQ3Oa4Le8frsQZN0yq+uSLCh7sopfYFuAvdfLHqhsO0/ufooIcukaL4Hdkkpg4G6HH9ZkiH4O+bhjbBg+SdpBebmGbz4siEJtpTD9d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFX91NGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40351C4CEF0;
	Fri, 29 Aug 2025 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756483562;
	bh=OPMQ4rYf+/KiOsWsmQ2e492hplZ/+p3Od9JrRPKOmsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFX91NGXOWHl2l6Lz/2jj0A+JnHgzGvHOq7P85HsCT/xqq7YTGJ+CzPaznqLnlD3t
	 QYHMmbihh2qwu3aoihrzo89ROJkAuyrfc6OOAzjXjB6/m/V4epaYUaJ3EWnY8HnIid
	 A3J1IzJljIcrLBkL0WjqzGB57qkwsnNUpJtm+g49/Nif++ksJoF7I50QVOVeOFWv+t
	 5Pgpj+dxTYzbqiY3b8YP1LyolMQZdhrJAZHk1htvnxwz0LpKG7yj2d1OSVCrbRZax8
	 UBuXdjkAjaW/ac4c2t8dB4rpFS0ilxxz4IfSjiFLs5uTlt7YDmcv5gC0Fop1+IHrN+
	 rNg2NL7DoIUxg==
Date: Fri, 29 Aug 2025 11:06:01 -0500
From: Rob Herring <robh@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add label property
Message-ID: <20250829160601.GA835423-robh@kernel.org>
References: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825180248.1943607-1-flaviu.nistor@gmail.com>

On Mon, Aug 25, 2025 at 09:02:43PM +0300, Flaviu Nistor wrote:
> Add support for an optional label property similar to other hwmon devices.
> This allows, in case of boards with multiple TMP102 sensors, to assign
> distinct names to each instance.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> index 4c89448eba0d..1d192100e8b5 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> @@ -20,6 +20,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  label:
> +    description: |

Don't need '|'.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +      A descriptive name for this channel, like "ambient" or "psu".
> +
>    "#thermal-sensor-cells":
>      const: 1
>  
> @@ -45,6 +49,7 @@ examples:
>              reg = <0x48>;
>              interrupt-parent = <&gpio7>;
>              interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +            label = "somelabel";
>              vcc-supply = <&supply>;
>              #thermal-sensor-cells = <1>;
>          };
> -- 
> 2.43.0
> 


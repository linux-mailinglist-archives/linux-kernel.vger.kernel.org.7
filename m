Return-Path: <linux-kernel+bounces-810100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06106B515D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02F51C25166
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5492820A4;
	Wed, 10 Sep 2025 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyt3iiv6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB823A9AE;
	Wed, 10 Sep 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504143; cv=none; b=Rdjq/Dk5V62whqRZuEftDHSeMA8WM4qEglkhWMFWQCFmE8/XkpSeW0JxqXqbembqAQKELAa/ebpLkermXjecB1y3uS4rQUhmUxcea8hPl4vqOeQ449PlU5v4xaKHb0w7CIKArrDRa+Uw2wQqI00kVOZpm0MNYDwQqH8ivruvQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504143; c=relaxed/simple;
	bh=i6Z2NDahm7CLx4TBaP4siTR23mUGVC+/9EIqEzuOL68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIb9OI8CNrYw3h51Nx45gWc1pa5s99G0xpNRvx92FfEEv+goprtJ+HxwBPVppAJQwXm7G8Wr0hwfLFweZ/dUxVVLxs1itDuuorCPd5+5Qp9Efe5d2haEFrA3nmCiCyDd5VsuvhClveAFkoWlGsXRV0bsSEGHr0MybYGVnhhGUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyt3iiv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5BAC4CEF0;
	Wed, 10 Sep 2025 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757504142;
	bh=i6Z2NDahm7CLx4TBaP4siTR23mUGVC+/9EIqEzuOL68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oyt3iiv6aPyQ25GkTyqU4y24qMajRCx/pzq+ugEir/izBj5M7pyRsA8OZStiNfH8y
	 UnR9dAoBcF5GV5vSuAXDUJr2EGPrBj5A8AcXCvsuQnRCMQtzH1NbxMGgX3hr1dr1QT
	 /RczUH9k53Mvt102cepRNnuIww15Os+glyKHgI+W2BsLtN1OxDVm47V5anfYpMdvSp
	 hX8UCpSvTMcDRrLtuB3xXerfO6IO8xFvIcjxKS/v8Ihv7d7Sy4Y0wsMAAW9Qd1RS9w
	 HEEXr4YbiFH0M7PEFAwIkTiFwEH4/D0rw/MyQsqHpfFZIaS5QJKVnqvyfV7j5xTptL
	 xL6VO/GfuLEAw==
Date: Wed, 10 Sep 2025 13:35:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: sitronix,st7920: Add DT
 schema
Message-ID: <20250910-ant-of-angelic-vastness-b5caa5@kuoka>
References: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
 <20250909-st7920-v2-2-409f4890fb5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909-st7920-v2-2-409f4890fb5f@gmail.com>

On Tue, Sep 09, 2025 at 06:52:44PM +0200, Iker Pedrosa wrote:
> Add binding for Sitronix ST7920 display.
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  .../bindings/display/sitronix,st7920.yaml          | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Please organize the patch documenting compatible (DT bindings) before their user.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

...

> +  reg:
> +    description: The chip-select number for the device on the SPI bus.

Drop description, obvious/redundant.

> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 600000
> +

I don't see how my comment about supply was addressed. You never
responded, nothing explained in the changelog, nothing explained in the
commit msg.

> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example: ST7920 connected to an SPI bus

Drop comment.

> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display@0 {
> +            compatible = "sitronix,st7920";
> +            reg = <0>;
> +            spi-max-frequency = <600000>;
> +            spi-cs-high;
> +        };
> +    };
> 
> -- 
> 2.51.0
> 


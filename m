Return-Path: <linux-kernel+bounces-674111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B8ACEA14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 08:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FDD18866E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 06:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8A1E32B9;
	Thu,  5 Jun 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpHB0y5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0552566;
	Thu,  5 Jun 2025 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104504; cv=none; b=G2qGlYkDHR/awpgSLgjKPS4x6i+Wn+e1amyPCDzvuATheWLzMUGv4qlhFEpaKAUxlNbdMADd+GVMfQGcgGkrp8Jlnz6JXbbxaryEoslG1hwzCQYAWiCb6Kpo4BKmK0EYSDE0KbRpBVw6eh3s0MoM7uRuQ5gYEm7nOA7aHeHCJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104504; c=relaxed/simple;
	bh=+Redz4ifkRkx64frRMoX7dOYX5AJN+Q/ArPYmvxEyPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtigZH51Ssl9Yy1MFNLbFCmqkV6soDW9+atHMKJZTh6AGVPWkS5F+1PN2ArKyF3tuGxJC1aoP5FwUhEfOM9lWAgCrcQGUj0IbiV7MvLagR6TjaP3vRORdUzez0tjw3CQ29taqrpnpj6B3GlhqPgPqJadK/m47xLgvXyixho1a8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpHB0y5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1271C4CEE7;
	Thu,  5 Jun 2025 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749104504;
	bh=+Redz4ifkRkx64frRMoX7dOYX5AJN+Q/ArPYmvxEyPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpHB0y5Ra2FIpz9VgGLS53mxOfVMAIYqacJek1YYOjiIK68AYA+laSiYRBvxmXbya
	 hnJy//xgXODlHJYv3jCjpYD3peZV8eJMilgHHNzMoM6HWjz3ZV75w6Y6B2cwrbo8wB
	 vBKfKwm47IhwMJ/my3pAsa55ftxFNeYGTAoShHQi8GNHfCkruvz/0Ek2z5DOgJSUz9
	 MetvBMahFWXn23VTcIJQBrY5d7N3Csdg2JEeZJyMP/u/ZeOmeHUHU2w4cuRm2wiufE
	 m+rEx0MdwqPAMDfmyWjwHuz/0Lt1kuETWGqydDGZJmm6KhptVX0EF4EBW7vCbGKT2h
	 nbtBBkx7RZRxA==
Date: Thu, 5 Jun 2025 08:21:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukas Timmermann <linux@timmermann.space>
Cc: lee@kernel.org, pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: leds: Add new as3668 support
Message-ID: <20250605-poised-furry-elephant-cadd08@kuoka>
References: <20250604225838.102910-1-linux@timmermann.space>
 <20250604225838.102910-3-linux@timmermann.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604225838.102910-3-linux@timmermann.space>

On Thu, Jun 05, 2025 at 12:58:38AM GMT, Lukas Timmermann wrote:
> Document Osram as3668 LED driver devicetree bindings.
> 
> Signed-off-by: Lukas Timmermann <linux@timmermann.space>

Please organize the patch documenting compatible (DT bindings) before their user.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

> ---
>  .../devicetree/bindings/leds/leds-as3668.yaml | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-as3668.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-as3668.yaml b/Documentation/devicetree/bindings/leds/leds-as3668.yaml
> new file mode 100644
> index 000000000000..a9d698eb87d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-as3668.yaml

Filename matching compatible. ams,as3668.yaml


> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-as3668.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Osram 4-channel i2c LED driver.

Drop full stop

> +
> +maintainers:
> +  - Lukas Timmermann <linux@timmermann.space>
> +
> +description: |

Drop |, Do not need '|' unless you need to preserve formatting.

> +  This IC can drive up to four separate LEDs.
> +  Having four channels suggests it could be used with a single RGBW LED.
> +
> +properties:
> +  compatible:
> +    const: ams,as3668
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C slave address

Drop description, obvious.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Missing gpio / pwm / audio input. I guess you omitted it because you do
not know how to implement the audio input part? Bindings should be
complete, so at least mention this in commit msg.

Best regards,
Krzysztof



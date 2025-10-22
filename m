Return-Path: <linux-kernel+bounces-864258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65727BFA4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A5842817E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A01B4F09;
	Wed, 22 Oct 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f52VkERP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A342E11AA;
	Wed, 22 Oct 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115728; cv=none; b=dQBybSfRokhmutCrNaxA7IR+KxoliRNaLJaSP7OhELqt2jW1hIi1jxtbi4KO8+f74XDfYcRgQG25+3WxCOMGXeDDsiVLrDzzVu9Dl2/KnNBYrhwNKu2NZBSSkcQBHmxHwUHkzca0xI1m9SmRUHZB24n1w9K48rA/tpI9V250ICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115728; c=relaxed/simple;
	bh=bux0MpiefE0E0udPEyLkyVKKTF7xnuFg2f9MRlWs8GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgBDZ7POUQMzKihnc7S4JOLP7uO1WXIo6IzC65NqHAvjCjrnTHFEPRxtQvawXBswqX/UK96mPFLjGb6Gr5j0KcHoGawYgt75FlyOhwHksQ6ODZsjFDazSkM5wws0L0EpQ37Psj4MB3PHZ1rWnL+bMMmP2OdbqdiLGyseCetEpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f52VkERP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B95C4CEE7;
	Wed, 22 Oct 2025 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761115728;
	bh=bux0MpiefE0E0udPEyLkyVKKTF7xnuFg2f9MRlWs8GY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f52VkERPw/+okQoOmeKa9eUCOQn1TM5lnDAiv3ekN3P/yEYgLJ+dz5+JO/7vnrI4L
	 W9cjAgJUKBW6yAVO94hSZ7UUEnyyQd8GlCzh/QBn2v8+t4SEpO3KeFFHNc92KgX4b1
	 lNxHihy+XKRm3oWUEARB8Cep5kv/ZBTFTflDvSrNXHyveYed0xCUoGThOR+WLZtd/V
	 L37/BHXGm/FzdeqEq+784VIwyfZLskBBhPTuOccVmr3iM9OEDauVMLaS6iPvVGzmWC
	 lyudEmwvrhS6ENFYjg7tLrtbZ8gCNOzgfypsAz8Yht0bStd5jInrsyckYzXnD4IubI
	 rPlNC5kvIsqVw==
Message-ID: <e396d81b-0f61-4a05-873e-354339b5e50e@kernel.org>
Date: Wed, 22 Oct 2025 08:48:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Documentation/devicetree/bindings/hwmon: Add TSC1641
 binding
To: Igor Reznichenko <igor@reznichenko.net>, linux@roeck-us.net,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251022044708.314287-6-igor@reznichenko.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251022044708.314287-6-igor@reznichenko.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 06:47, Igor Reznichenko wrote:
> Add a devicetree binding for the TSC1641 I2C power monitor.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Please organize the patch documenting compatible (DT bindings) before
their user.
See also:
https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46


> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>  .../devicetree/bindings/hwmon/st,tsc1641.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
> new file mode 100644
> index 000000000000..e79f6dab4a87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/st,tsc1641.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST Microelectronics TSC1641 I2C power monitor
> +
> +maintainers:
> +  - Igor Reznichenko <igor@reznichenko.net>
> +
> +description: |
> +  TSC1641 is a 60 V, 16-bit high-precision power monitor with I2C and MIPI I3C interface

Please wrap code according to the preferred limit expressed in Kernel
coding style, so at 80.

> +
> +  Datasheets:
> +    https://www.st.com/resource/en/datasheet/tsc1641.pdf
> +
> +properties:
> +  compatible:
> +    const: st,tsc1641
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor:

Use existing property, git grep shunt.

And then test it...

Best regards,
Krzysztof


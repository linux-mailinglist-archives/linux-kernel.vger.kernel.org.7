Return-Path: <linux-kernel+bounces-720944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD37AFC265
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BD21AA560C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351E21FF2D;
	Tue,  8 Jul 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQMDv0Xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BC5383;
	Tue,  8 Jul 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954707; cv=none; b=IFm2fFP5Pc/fUXlEuwZEZhf4OXMwO4jzwFVzRj3q7VERofNyRzn9eJ486b96fbvnw4AiS7YAB2oOXh+EjoiIkim5sG0ruEaENdHlq82hM+F4579Jun7EeNrH8MkHXCWl0umdwqZfTgvFJ+rdtjEzZfz7ZGljW3qJVuxAtWwPmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954707; c=relaxed/simple;
	bh=HZE3c5KNAGvsUgce2rbDwUdbZz9nxP9lOub05YWI/J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2UG2GTh+A9Rb42XVbm6UNxhksXZlYHYAkjnX7sjezqWvEjNbqXsAO4V0MTNfzafMVhVFsut6SfsSxVR2BFCqC7DO/BKyE+KIjGT69DaX+jXoaPgv1RZnZ1vmf2PWdxyLrtYC32JzSFKgSdP0PED2jIDMAYsJuE2IVdO1LiqtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQMDv0Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DDFC4CEED;
	Tue,  8 Jul 2025 06:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751954707;
	bh=HZE3c5KNAGvsUgce2rbDwUdbZz9nxP9lOub05YWI/J0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQMDv0XaLgCokD5yiKDnbqa1igsQmNut4fVpioFNBxMR1aOJh7KgTYSTleZaBQY/1
	 uHwt77Rey81KZibv6bZLghPSl/8XDF8MTtPyWnv3DpJYkulJ91rzm2QArb3oegwkPm
	 igPQd9fLIhktuLVmptXrrMcR+Zb5KWYHiv2uiypP7zGlFrifvGo8dydCzq2syH3+gQ
	 eIJuNuLrEg62U0Prv1BwsRfux4tP7L/gNXbjogvrDYL+tEbgOMqDm5gPlVl1cFtsMh
	 q7+w8jpyQBDSgE712KrSARMNmr/kAnx0GQaRbZJiI1KxmmvS2URpINaXJTwZh73PiS
	 41s4DShz7PfHA==
Message-ID: <cb03b137-c87c-446f-a6c6-45b6656af212@kernel.org>
Date: Tue, 8 Jul 2025 08:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
 Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
 Hao Qin <Hao.qin@mediatek.com>, Wallace Yu <Wallace.Yu@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 devicetree <devicetree@vger.kernel.org>
References: <20250708060150.27375-1-ot_zhangchao.zhang@mediatek.com>
 <20250708060150.27375-3-ot_zhangchao.zhang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250708060150.27375-3-ot_zhangchao.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2025 08:01, Zhangchao Zhang wrote:
> Reset BT via BT_KILL_1V2_L hardware pin.
> 
> On the M.2 standard hardware pin interface, the MTK chip
> has a pin called BT_KILL_1V2_L or W_DISABLE#2, it uses
> function-level device reset (FLDR) to reset Bluetooth.
> When it is pulled low, it can external shut down the BT
> function, it is defined as 5 on the MT7925 chip, and is
> defined as 248 on the device tree pio controller.
> 
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---
>  .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> new file mode 100644
> index 000000000000..636b8b3d6a14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bluetooth mediatek use BT_KILL_1V2_L hardware pin to reset BT
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description:
> +  MT7925 chip uses the USB bus to communicate with the host.
> +  Two methods are used to reset Bluetooth. It provide hardware
> +  pin, when an exception occurs, resetting Bluetooth by hardware
> +  pin is more stable than resetting Bluetooth by software. If the
> +  corresponding pin is not found in dts, bluetooth can also be
> +  reset successfully.

Don't describe DTS, but the hardware.

> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7925-bluetooth
> +
> +  "#gpio-cells":
> +    const: 2

You did not say this is a GPIO controller.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Default high level, this pin can external shut down the BT function

How defaults matter?

> +      when this pin is pull low, at the same time, USB interface will be also
> +      disabled. When this function is not required, external pull high is not

So active low?

> +      required. After 200ms, it is pulled high to 3.3v and the next probe is
> +      performed. On typical M.2 key E modules this is the W_DISABLE2# pin.

So that's part of PCI slot? Sorry, but this does not fit here at all.


Best regards,
Krzysztof


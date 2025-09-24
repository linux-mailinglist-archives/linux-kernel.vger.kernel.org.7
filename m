Return-Path: <linux-kernel+bounces-830137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD65B98E26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4883A4B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B270285CB6;
	Wed, 24 Sep 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C+eiHwu5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACD4502F;
	Wed, 24 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702430; cv=none; b=S42MUhdR6ZXEDuqOzJN7dcayCaIUAo0Hlxnx/Ujo6ELPWhHZ08Tgka2qpKbPD6RBscO1W6aBtcJP29ApdfSDpcRupEsjQYBiCxAM2c6vJ2edoCAZd2nPewO+FxINvkU5x6FnQyi86saLeF/StCEKVeOU3tVeb7cuwgLQ9KOMWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702430; c=relaxed/simple;
	bh=6Wtt45GCrcyLE7Y+MjZ0xRGSIEip4Qk9mzL+4G6Noh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlm072pmX7L5aBigTR9KDe63aeoayTGkbE8N4ZJc9umwGCMhAad0EZHx7hMa8rov4rztv/ioqOMLCHXaQWRLE3okiF5l/9x/UZEGwTknH+ZGn8iVuUiOyNQQSPNAam3uU7FoDnz5euRHxqGnufDlbThrSUHG6DufR+EDXTfxyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C+eiHwu5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758702427;
	bh=6Wtt45GCrcyLE7Y+MjZ0xRGSIEip4Qk9mzL+4G6Noh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C+eiHwu5PH2XvRjUDDPKl/cjs3WlZViR0RFmhNVG5mu2kN+qHXOyf1R9JGqEk0vKz
	 rBP+czHXptgenYuE6tUvFUROm644KdcAyJG1VoweCC0JoD+8EDLzbjHklWa5tSsJlx
	 5pc2ovu1A6qBaTlOcZuI9/ilMvO/sZVLJw7JsB43UXBJr36dnEUWML2QDfjUG/fna9
	 4n9fYhv+C+I58FqJKab3KsbpAgYGloWiT3p6RTple/pXyM9CM2VVHJDkWQxqKOk+MI
	 yM/gw1AMS3m6MhXn44AimDZNqOGp14I7FSC/rpOW0tl37fqrKagIG4z2r3HJmfx16p
	 F95p9XMb676EA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73B8017E068C;
	Wed, 24 Sep 2025 10:27:06 +0200 (CEST)
Message-ID: <9dd2fea8-f828-4298-97a2-10ef1c61799f@collabora.com>
Date: Wed, 24 Sep 2025 10:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: airoha: Add reset support to
 EN7523 clock binding
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924060509.1889131-2-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250924060509.1889131-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/25 08:05, Mikhail Kshevetskiy ha scritto:
> Introduce reset capability to EN7523 device-tree clock binding
> documentation. Also this patch makes mandatory '#reset-cells'
> property for EN7523 SoC dts.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   .../bindings/clock/airoha,en7523-scu.yaml     |  4 +-
>   .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
>   2 files changed, 63 insertions(+), 2 deletions(-)
>   create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> index fe2c5c1baf43..a0df16485300 100644
> --- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -53,6 +53,7 @@ required:
>     - compatible
>     - reg
>     - '#clock-cells'
> +  - '#reset-cells'

I can't find any reason why #reset-cells should be a required property: this is a
clock controller, it doesn't necessarily have to provide resets, and you don't
necessarily have to use resets, so this shall not be a required property.


>   
>   allOf:
>     - if:
> @@ -64,8 +65,6 @@ allOf:
>           reg:
>             minItems: 2
>   
> -        '#reset-cells': false
> -
>     - if:
>         properties:
>           compatible:
> @@ -85,6 +84,7 @@ examples:
>         reg = <0x1fa20000 0x400>,
>               <0x1fb00000 0x1000>;
>         #clock-cells = <1>;
> +      #reset-cells = <1>;
>       };
>   
>     - |

Regards,
Angelo


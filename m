Return-Path: <linux-kernel+bounces-796106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF0AB3FBFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085332C3BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797652F3629;
	Tue,  2 Sep 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HsTeJJPy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C72F068A;
	Tue,  2 Sep 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808106; cv=none; b=pyQjl7bBBWiFmUgyJNQrMhS0sdvEOJ2lgHuv4R75pRdLIby6vJHe8dSUOu52IIZQojCUUsRA3AA/UySspCoFSy6+Ggi7qxk5KgJ8TQ9+kg0DeeP/GtFOowqN7TL2euAoFSvSO0DQpZeRMou2KCifOp57w7RcrGXpxwSdbmWFCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808106; c=relaxed/simple;
	bh=7r0uYfWtBElvzR2QYMpdph3AQUnSm2BAWZWbcWhwkgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hneB2WyV9K3DsbvF7bExXVdvgm/FJ1BJXWZqA+kLApJA1/lII10/MNPj4ttuGPWjw6lecjH3YX24an5DISLuelJcldA8H2ttnMkEl64ULGgRx9HsBrE9c2AnPXbLGGewRDT3tjYsgnc/78yodMdKyY9Xdb1LDV31XhEhuy1xvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HsTeJJPy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756808101;
	bh=7r0uYfWtBElvzR2QYMpdph3AQUnSm2BAWZWbcWhwkgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HsTeJJPy8nskxOEnWjhWT23hBDAhRZZC8BBmLa9+pYVZHN/1ephldEEputMinatHc
	 8rhjPY/35EFw8KdZww8/CmeWOnDrqoELM4vGKhw0n2+fOwRZnteOQS9b86OEYVSKPh
	 M78G/SargYwFcz8nzA9RJ8OY9FN4DF2bRez1O5t4QsM9/lCXuiyQNUXgu5gGJA8PC0
	 7REujSKJS1o6pu7ugGg32yi3a6MqTYaNf8CnhVgAJYOwjeTA1hJjm9g1QcFYbw8c4Y
	 Hi4xdn2xFl1kfA2MWOPOacriYYoMb/TPJyDY2rOU3zFnGRvXVQFP0fgfGUibMhk5nD
	 gNO1gS409ySuA==
Received: from [IPV6:2a05:1141:1fb:db00:ba27:6983:e3a5:2a47] (unknown [IPv6:2a05:1141:1fb:db00:ba27:6983:e3a5:2a47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 251BD17E0456;
	Tue,  2 Sep 2025 12:15:00 +0200 (CEST)
Message-ID: <b0cad1e8-8b02-4039-b1d2-b9056fd51318@collabora.com>
Date: Tue, 2 Sep 2025 12:14:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Collabora Kernel Team <kernel@collabora.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
 <20250616-rk3588-csi-dphy-v3-3-a5ccd5f1f438@collabora.com>
 <20250902-piquant-secret-moose-06c4b6@kuoka>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20250902-piquant-secret-moose-06c4b6@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thanks for your comments.

On 9/2/25 09:55, Krzysztof Kozlowski wrote:
> On Mon, Sep 01, 2025 at 10:47:44PM +0200, Michael Riesch wrote:
>> The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
>> Add the variant and allow for the additional reset.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
>> ---
>>  .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 50 +++++++++++++++++++++-
>>  1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
>> index 9ad72518e6da..e37c9fd74788 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
>> @@ -21,6 +21,7 @@ properties:
>>        - rockchip,rk3326-csi-dphy
>>        - rockchip,rk3368-csi-dphy
>>        - rockchip,rk3568-csi-dphy
>> +      - rockchip,rk3588-csi-dphy
>>  
>>    reg:
>>      maxItems: 1
>> @@ -40,11 +41,15 @@ properties:
>>  
>>    resets:
>>      items:
>> -      - description: exclusive PHY reset line
>> +      - description: APB reset line
>> +      - description: PHY reset line
> 
> That's changing the order, before first was the phy....

See reset-names below...

> 
>> +    minItems: 1
>>  
>>    reset-names:
>>      items:
>>        - const: apb
>> +      - const: phy
> 
> Although here first was apb? Quite confusing.

Confusing indeed. IMHO the description "exclusive PHY reset line" is
misleading. In the existing device trees there are hints that this is an
APB related reset. These are only hints, of course, but they are the
best info we have.

I can add a remark that we are fixing the misleading description while
at it.

> 
> Anyway "phy" reset for "phy" is pretty non-informative, please give some
> useful name.

As far as the additional reset is concerned, I do not have any info at
all what it is related to. Therefore, it is hard to give a useful name.
Also, to be frank, I have no intention to haggle around with Rockchip
support to find out a more meaningful name (I tried to do that in the
past, only to find that the time spent on that is almost definitely wasted).

Similar PHY blocks are using "phy" or "pipe" or simply "reset" as names,
so I went for that.

Any suggestions are warmly welcome. "aux"? "reset2"? ...?

Best regards,
Michael

> 
>> +    minItems: 1
> 
> Best regards,
> Krzysztof
> 



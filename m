Return-Path: <linux-kernel+bounces-846758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA60BC8F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F12F44E4679
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4BF2DD5EB;
	Thu,  9 Oct 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XWR9WEkQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFF2C0279;
	Thu,  9 Oct 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011501; cv=none; b=OiE804pL8dEVO25g65hp6eEX1P4ggojEjCqglRAdOIX1zwo7pBnGaO09sDitpgwobgi7aDvo9tg1Q9HkJMr3OGFOhyQE2qySdK6hTpUKJsjLPc89MJmKQAl5YoVHRZUxKKO7x4E7Cj6NPo9Ysl3zn9SOiyo/NZm57UIOi1ZCfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011501; c=relaxed/simple;
	bh=1r1z0tu+/2i02NJ3LYyZb+KmF5RnrgujhZBz/NzLGNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0iUDXEP3TuLV0NzwPsTg5oWXSY8CzAQeOwMAHrfMDtub4PNfPjXeaKedlAamRJ9LCAoowF98X+uomJjiYJXujH21ppdWgsHEVpROo/KxX+vO62tvZiG25pK9NcfEXQONLQg7KOV61Zw5Gn1VinqjuLAn6DfFd/e1hXXMGR0RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XWR9WEkQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760011497;
	bh=1r1z0tu+/2i02NJ3LYyZb+KmF5RnrgujhZBz/NzLGNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWR9WEkQjABZZJ7IfU6ny9j8m1sVf9Ls3BE4r1Czi9tLN0i43vyK+cEYRt4IBuhfX
	 aqEKNcZuergrj4r39/UHaWIdh6ffZiOfUiuDr3qboMRJiTnXKFB7Sy3H9VMY3DQELg
	 aBQ+RkvPARo+WYUW15egQZu3uPBrJLT/J61DaM3CHfSjLPlO1A6xxiPT6Fz4m7Ywdn
	 4iob9aPpBY/xIx/WMcoXBrj09ll8EvcxDHhYDzenrjDsINzuhvIvSg5Z2H4oDOMsF6
	 Ho2/rBHdd6QjL62s2iegHtFz25Ga45hZulpxC1V7Jnvd5WC7EIpQfezq+HMyMSZ3ei
	 O4cILnK0s86uA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31C7917E0125;
	Thu,  9 Oct 2025 14:04:57 +0200 (CEST)
Message-ID: <217a6749-9631-4f9b-a33d-648c34bd09ad@collabora.com>
Date: Thu, 9 Oct 2025 14:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] arm64: dts: mediatek: mt7986-bpi-r3: Change fan
 PWM value for mid speed
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Frank Wunderlich <frank-w@public-files.de>
References: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
 <ce4bad93-2663-4c07-8cdb-fb6fdcbfc1ca@collabora.com>
 <15eb53dd-792d-4bab-84fd-2abd017c0a84@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <15eb53dd-792d-4bab-84fd-2abd017c0a84@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/10/25 10:55, Mikhail Kshevetskiy ha scritto:
> Is there any chances get it merged to linux-6.18?
> 

No, the window is closed - but I have added this patch to my notes, will be picked
as soon as RC1 is out, will be in linux-next soon after, and will land in 6.19.

Cheers,
Angelo

> Regards,
> Mikhail Kshevetskiy
> 
> 
> 
> On 30.09.2025 14:34, AngeloGioacchino Del Regno wrote:
>> Il 30/09/25 04:16, Mikhail Kshevetskiy ha scritto:
>>> Popular cheap PWM fans for this machine, like the ones coming in
>>> heatsink+fan combos will not work properly at the currently defined
>>> medium speed. Trying different pwm setting using a command
>>>
>>>     echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1
>>>
>>> I found:
>>>
>>>     pwm1 value     fan rotation speed   cpu temperature     notes
>>>     -----------------------------------------------------------------
>>>       0            maximal              31.5 Celsius        too noisy
>>>      40            optimal              35.2 Celsius        no noise
>>> hearable
>>>      95            minimal
>>>      above 95      does not rotate      55.5 Celsius
>>>     -----------------------------------------------------------------
>>>
>>> Thus only cpu-active-high and cpu-active-low modes are usable.
>>> I think this is wrong.
>>>
>>> This patch fixes cpu-active-medium settings for bpi-r3 board.
>>>
>>> I know, the patch is not ideal as it can break pwm fan for some users.
>>> Likely this is the only official mt7986-bpi-r3 heatsink+fan solution
>>> available on the market.
>>>
>>> This patch may not be enough. Users may wants to tweak their
>>> thermal_zone0
>>> trip points, thus tuning fan rotation speed depending on cpu
>>> temperature.
>>> That can be done on the base of the following example:
>>>
>>>     === example =========
>>>     # cpu temperature below 25 Celsius degrees, no rotation
>>>     echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
>>>     # cpu temperature in [25..32] Celsius degrees, normal rotation speed
>>>     echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
>>>     # cpu temperature above 50 Celsius degrees, max rotation speed
>>>     echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
>>>     =====================
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> Acked-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> Reviewed-by: AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com>
>>
>>




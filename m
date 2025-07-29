Return-Path: <linux-kernel+bounces-749253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F339B14BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93D818A0045
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6B288C10;
	Tue, 29 Jul 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QsA8zBkm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB173253925;
	Tue, 29 Jul 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784042; cv=none; b=iy28bpLl8cH9S/BlDFqIdSaKRHrKky4ocFZ8oHAYdy/1bF7YqqlosvCQOd0+UBRrc8eiIOcCk+XT79JbSp9R/NXeOfa82ho75d8NzGFF2suf3/JaBZil+WeXw26SPVJw3td8kddjuUT9MfhK3O/jEBObMTpAJAzbteApjPSPKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784042; c=relaxed/simple;
	bh=KCqBt2nHHSyKsCR7eaoD8lFqx1EfG6Nptsv2HTAspbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UktmQJGg/uAqsHAWQaDhvW1NZQ43XZkkloPcXR8+I9ZtjtO38xgSYoXTlBU3MXQDkvagtIi7a2yPozVz0r5ioNyEGUUNDNS8hm0hDzvSrr/xLuVolM/n3UyEM04HWSnT8pqL43V0/GxgmaIvXo3E+ONMtvWFRzpQiLx/sEvybks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QsA8zBkm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753784039;
	bh=KCqBt2nHHSyKsCR7eaoD8lFqx1EfG6Nptsv2HTAspbo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QsA8zBkmIBtA+Dt3J9nOwuC2s9aRQgBIqGyC5pNtGOTwUW1KeSY5kX+nrcLGjrh4d
	 UJ+3a/0fViXI7igUTedYX1gYRivwI/aaMx7xvs5i4xMBHMRmElf+nYyT3HCTgjMf0s
	 TGkNv0MhLxgfbTI+4QcpOQlhuIJy29zzxBiJenyGqynRwVuctK+scZiJ5YyY+Klve9
	 x+sLLv3jzTH5mguySM7ik6o4icAdIF3ghBF9mrKXzcF0NAclHbpeBMOp12J323gxn+
	 Iik5ya1qJvOaibOh5IKqUJk/oENeFdgId900NV+rEtNNemOcAmGm7rGqisQdMdr0mk
	 2RPys0on3yVgw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BBCA617E1284;
	Tue, 29 Jul 2025 12:13:58 +0200 (CEST)
Message-ID: <e6246af6-eadf-4bee-9e1c-c17adb86b496@collabora.com>
Date: Tue, 29 Jul 2025 12:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: mediatek: mt7986-bpi-r3: Change fan PWM
 value for mid speed
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>
References: <B06376CB-BE3F-4645-8A4D-A9C67CDCA3EC@public-files.de>
 <20250729075608.1651898-1-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250729075608.1651898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/25 09:56, Mikhail Kshevetskiy ha scritto:
> Popular cheap PWM fans for this machine, like the ones coming in
> heatsink+fan combos will not work properly at the currently defined
> medium speed. Trying different pwm setting using a command
> 
>    echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1
> 
> I found:
> 
>    pwm1 value     fan rotation speed   cpu temperature     notes
>    -----------------------------------------------------------------
>      0            maximal              31.5 Celsius        too noisy
>     40            optimal              35.2 Celsius        no noise hearable
>     95            minimal
>     above 95      does not rotate      55.5 Celsius
>    -----------------------------------------------------------------
> 
> Thus only cpu-active-high and cpu-active-low modes are usable.
> I think this is wrong.
> 
> This patch fixes cpu-active-medium settings for bpi-r3 board.
> 
> I know, the patch is not ideal as it can break pwm fan for some users.
> Likely this is the only official mt7986-bpi-r3 heatsink+fan solution
> available on the market.
> 
> This patch may not be enough. Users may wants to tweak their thermal_zone0
> trip points, thus tuning fan rotation speed depending on cpu temperature.
> That can be done on the base of the following example:
> 
>    === example =========
>    # cpu temperature below 25 Celsius degrees, no rotation
>    echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
>    # cpu temperature in [25..32] Celsius degrees, normal rotation speed
>    echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
>    # cpu temperature above 50 Celsius degrees, max rotation speed
>    echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
>    =====================
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Acked-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




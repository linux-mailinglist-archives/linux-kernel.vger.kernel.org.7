Return-Path: <linux-kernel+bounces-837596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3BBACB18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B89F164330
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734E25C81B;
	Tue, 30 Sep 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aLvaKjQc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EC34BA3B;
	Tue, 30 Sep 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232069; cv=none; b=hp9m7lCesB3hbuLLzRLPBbLLNTiMIR9dViWr0Abo9gB2GfaLTRwE9nc4xCISG/sc0qo2PfwdpZHJpmCJjCLYheDGlGPDh1Po/EQ+CE4SmgrEMyNfErYYYEOCzOU7/HW+W17FD5g+O5nvpFEwhUkrHlCogHLYS0RWiqg1GFN3Ri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232069; c=relaxed/simple;
	bh=tiHFk+xnP8SCA8zL96xKjLYHlIM3mrrw6V0YZnBkr44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phbFr9gCmrwLwHNpQMiXHfTu3CvY0fcYWKIu3/KOTguCKAYpgakp2mHviNANmAm44fx63+wwuPPH32OQs3YlCeluqWEEcW/hIHfOO15LYrVv1VbcJrwyPtzo7VhpoywNbFBha2mOUsZP5ZVRJ2mm6t3esk0DrGje+axViXu699Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aLvaKjQc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759232065;
	bh=tiHFk+xnP8SCA8zL96xKjLYHlIM3mrrw6V0YZnBkr44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aLvaKjQc2v07qJGvKM+cMa88Ljf8faYwGdWNauchDkYGAEKudftAh5IMVYrUCAhqq
	 jO4HlmEaYnGy/4KnIjIIhCvgfxMgA2dC7LyZ0qW0YIjf9l6qEFu0mmGGGsY+H0IEOD
	 9DMc8zSWZ6QNnJtXigFQ4xCLvoc5IQVgHA8baENNnkduqgE7Lb9YoAteesynpnlgNk
	 9Itol08/eiPordsqMClY066Q9jwfKBmi4jL69xenD35bSFqrrjz9DSB1QdSB87jtki
	 4uJYi3ZnVITDfz5AizU1FJZaU46kq8G+9qNb9twQP5IbcHArwWOf4LByn1GMdSTeJq
	 dqiKgTEAqZtOw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5961717E107D;
	Tue, 30 Sep 2025 13:34:25 +0200 (CEST)
Message-ID: <ce4bad93-2663-4c07-8cdb-fb6fdcbfc1ca@collabora.com>
Date: Tue, 30 Sep 2025 13:34:24 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:16, Mikhail Kshevetskiy ha scritto:
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




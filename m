Return-Path: <linux-kernel+bounces-732531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD206B0682B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019A7567AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1B1F0E24;
	Tue, 15 Jul 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="QZeoT1Q0"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028428727E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612958; cv=none; b=LdfYfWQiLZ0WpZvsbx2qTW9kegClQQjxGIYI6OY/OoB9aAV6rs70Q2P/z9uUdQVxFWc5n0y1tk9rPF1Sw0AmRM++E3WMzGFDuOcOkQUAwj6g0R73kWIULGHoJN7qVP8bLhGesat0K0KQ+etZzId3y33ipi1kJrtKyDmbNA9IpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612958; c=relaxed/simple;
	bh=s1aWX3Jy7JATwX4OLDhZyDCq1etv122jpd6xNWj4p3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGvbnsaoFlymh0PCF8Fb6KhEoV31GEDKCfjBTRAQU6nwJvrh0ZdIhdC7qy4L0k1T2kl2WXgsBGM768mJBYdTcTBRvXXXixpFWVX4qhwVTX2V77rOEAAdOGgI2hwtYCF7yEGZhs5M5t6Xpy9/ccjBSzts3WUryNikdijFYAyVIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=QZeoT1Q0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 95A8C2C028B;
	Wed, 16 Jul 2025 08:50:07 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1752612607;
	bh=hzmMFR6wcU7l1u5PHA1UjvLpv5HKxbamsPxwtTKjP3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QZeoT1Q0AFy5Nz2NSZVy6uSbYu4B97PRk9vgjnNmRGctaCI09W628cVd/8kVLyclB
	 eWmdkViMFYDFfXJpIfmG+JatfGtSXLNYvgc3itd9OTzryfFNBQudtNtQpa0gklxB+Z
	 6a/iuOlNcYUd1c3iewqEjvP/41L23ArkadWDvI6oSEQrVks5zlqhoXHevJQ055/Y2z
	 vFVYga9X56umWdg44GWJ6FF8Ex66AdFx3YRwAwDmJY0FX/nc6IIdfp7hfIv+O8Kk6c
	 XdBCv1K3F2f9cEskONWAtxh7N7u1M3moKLMQteN9EQGx29/U9ytvTZdA3tBO2h6Nw0
	 /hKHQ9+6s0fXQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6876beff0000>; Wed, 16 Jul 2025 08:50:07 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 7802413EDD7;
	Wed, 16 Jul 2025 08:50:07 +1200 (NZST)
Message-ID: <6ed8defc-0e3c-469e-be16-9d337d08f994@alliedtelesis.co.nz>
Date: Wed, 16 Jul 2025 08:50:07 +1200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as
 required
To: "Rob Herring (Arm)" <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250715202711.1882103-1-robh@kernel.org>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20250715202711.1882103-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=6876beff a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=vmEaEXbN32frhDhSycUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Rob,

On 16/07/2025 08:27, Rob Herring (Arm) wrote:
> There's little reason to require the SPI mux to define a maximum bus
> frequency as the muxing is just the chip select and devices still define
> their maximum freq. In fact, several users don't set "spi-max-frequency"
> which caused warnings.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

> ---
>   Documentation/devicetree/bindings/spi/spi-mux.yaml | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> index fb2a6039928c..b1e2a97be699 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -46,7 +46,6 @@ properties:
>   required:
>     - compatible
>     - reg
> -  - spi-max-frequency
>     - mux-controls
>   
>   unevaluatedProperties: false


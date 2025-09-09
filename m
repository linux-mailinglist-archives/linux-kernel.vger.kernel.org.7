Return-Path: <linux-kernel+bounces-808184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA3B4FB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C93AF203
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EEF337685;
	Tue,  9 Sep 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htGFE8AL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D152DFF04;
	Tue,  9 Sep 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421854; cv=none; b=XeHuMmvkrsDFZMJxPQKsH57hoenVDzLzC33B+lxixZQ0bFJi0HQZM1BrA9SHFmF20uRk1LaCvg2JzaexQTD78ULQnJI3gL+lTEQwQSaZHt3DFmIjjS/qJK6/gKexku+Kqr5qBZ7Uddo7BGrcX4XEXnOdH+rIPLmKvghfuXhOclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421854; c=relaxed/simple;
	bh=+GsoBonbh0+ieUxnpLBoixd8gmXwwPP4lkbSZqwha6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HODCwlDIv/vJanWim0JwuRZXdpqoQFg9m0R8KNsG6QcV4ugMk6ZeCIlB84andtdbyajxgLPBCweAOwVQbOudCeXPQ58ZylXGBDqd+185e0QI3FQbSYUUeeTTfWm55olm0mo0eyP0oFCa6j9lEPiQWMmWNwYjQjQg9vyBAZE/oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htGFE8AL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9853e630so51680025e9.0;
        Tue, 09 Sep 2025 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757421851; x=1758026651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9rFL+r1YKn0vpD5aAkD3QIB0bodgwk/WBTAvgFy59FM=;
        b=htGFE8ALi1j98o7p0/1NNXUu6QMlIbcA109l2PvjODzOtTHYSczopBbHnUEn4ciE1f
         lfjzJwuFQU1usr5ypOU8J5jbg4sYcuicN12WjpVqquaIfZbRBd0pi8LOUQhCnHbUlM26
         r+oloF3Suo2xCrge8sXcxHX2d80lIzD/EYq/ZrXhTxpQrsCQmD4BhZ/LWXhJcVaZgaSE
         6UJ6k+itFZGnkPxoWCYJ1ftymuR71zNSFMVOLgJIlM/ZqVnziB2cMqfqq/eBEPT9B/Z8
         Sv8PD4N7CKdJVmp9JIk/vqWUp5sU6/e5gpT7p6Gnl4DcOXdaXMclGzfgn4hjzSQfDKYW
         iWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421851; x=1758026651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rFL+r1YKn0vpD5aAkD3QIB0bodgwk/WBTAvgFy59FM=;
        b=fdsaC1zOoSdCviqOa9EytzTGKQ/6TnI5KxuSmBqO/7LxoeVOC1V6qxFbfq0eCpZPWu
         yUNoIOCsrzIotBJ8VJ4YgnhxTFrD+qk+TPPbv+CVt0yJvjYqDSANpCkb0aCKPfiPckkd
         HW1yUnwc8DcjgRihuwrYj89BEH2p4VeLF0YXttt6yrVqqEYuwpEGv7vVWuPr1EUeVgVe
         ko/Ze+ohITjauUpG//Et8rILutxvTUPKUIXUjxfrwl3xhitisNpeWKVD1oSWI5SRWc/J
         mXxjJtrTCcCYZHM+h/cN1u1mL0sSap8z3Havtul26wJVvMkLvB5JlNJ5W7eW1NWjQGAP
         /oWA==
X-Forwarded-Encrypted: i=1; AJvYcCVe+egPnqa/8hbzzYPmlmx6Te8w2sCf08/8BwqfkWGSNhd5D/TWAfOKfb0Zjzj2tQYXr7pLu6ITR67FAoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uFOYpuxf/s5qTXzZbDZRqTAPSvhiWoganVQXfZuaw22C8NwK
	CxEb1vtsx1iz8PzZXn0xi1I4hjI7qgmur5R5ILdXnggeq9ukLRfnzPUK
X-Gm-Gg: ASbGnctcvj60OAXgvhUshvpWk90J3UUUV1BpS7DZH6joHa4q53m2mT6SQAkRZV2/RtN
	7EEcCuNvwcryV1tt37yRC5K3KD7ePJ0h8XfpCRl4NYqu51W25TE4Epj5UfN8pMel1z1V29eZOu4
	8cPQiuEYlG/tq/lTonC102N5KPIKiw0o9tuaLTzOxIuywYkphgNloVAHLsProKGhSho6zJGWjKr
	4QkFJfpFwR6Dl6/mWKU31B9BlngEKdKLWMGYzXaMabjiFK4a65yEC2XgpiLRXNGzShp4GkQztJH
	fCFzRMp1CEvzyfAH15TBEYROIQwG2lNmG/xtTGVECYbPPskMdhN35AJ4ZUz2f8JV4fEdvBD+RPV
	0srlXcq0JuV50ZY18mod/MPfyqwioGaI=
X-Google-Smtp-Source: AGHT+IECKaIItMJhCB5fQPHsblBR/qDAMst2rQYDXJkJFXWQA4pISJ09+ACkbU0uH4JhyolNWy5pkg==
X-Received: by 2002:a5d:5d05:0:b0:3e1:da2f:af23 with SMTP id ffacd0b85a97d-3e636d8fb4fmr8567851f8f.9.1757421850822;
        Tue, 09 Sep 2025 05:44:10 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238820sm2534337f8f.35.2025.09.09.05.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:44:09 -0700 (PDT)
Message-ID: <4d6fcd11-a724-44ec-a183-cd1afe959bed@gmail.com>
Date: Tue, 9 Sep 2025 14:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-nio-12l: Enable UFS
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250905-radxa-nio-12l-ufs-v1-1-e2468bfd2c69@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250905-radxa-nio-12l-ufs-v1-1-e2468bfd2c69@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/09/2025 15:21, Julien Massot wrote:
> UFS is the primary storage for the Radxa NIO 12L. Enable it
> now that the ufshci and ufsphy nodes are available in the
> common mt8195 dtsi.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Queued, thanks.

Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> index 329c60cc6a6be0b4be8c0b8bb033b32d35302804..4cbd78c126f6b56f1833d220f7a7fbc7e4320cbb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> @@ -990,6 +990,16 @@ &uart1 {
>   	status = "okay";
>   };
>   
> +&ufshci {
> +	vcc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vccq2-supply = <&mt6359_vufs_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ufsphy {
> +	status = "okay";
> +};
> +
>   &ssusb0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&usb3_port0_pins>;
> 
> ---
> base-commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
> change-id: 20250905-radxa-nio-12l-ufs-c817a864fb42
> 
> Best regards,



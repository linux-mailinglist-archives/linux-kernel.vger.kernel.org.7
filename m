Return-Path: <linux-kernel+bounces-866935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6AC01182
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B03B3AC5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1F3128DC;
	Thu, 23 Oct 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+Nd95NV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7C3B1BF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222168; cv=none; b=s7JvifORKpysg9+oa0WRWDXt/z2serm42Qug6mP+UnRXycR03hAnyQye6cD4fXAn8Fk4eeiqcS/EnZj5zBqVY4Zvh49tjrqwT0ZnuL5L+wZkNXLsCFTwVQG/GKsDNu5C8lBXLW0xqgZU/E1n+hyT0xUonmMzixQ/y0OBrrslCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222168; c=relaxed/simple;
	bh=xiPiUZN+6HW8JFz8oh0e6yzQqMKGsrI5+W0KXzokEGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pumqqhyWEBr0isZw6zV7wboJMbj613NmCu0C6elVeD2/F08q1HfUGZJXAVZVDngWZY8Q+mz805RtwPAuz2GeewbFnupIz2UBo1sFYyR07qug1j84cSj5jV+epQATyCTM5JxEU+UwelMcgWhxD9oBZP9uoNHY0IqZSKkDA8ZYxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+Nd95NV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47107a9928cso400385e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761222163; x=1761826963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng0p3rzhbCe/bm8WuWNgEWBVBz/1DYFIUGKbuqDxdLg=;
        b=X+Nd95NVaYu6VjwgHmr+pyMdyK6bvBgfN29gnQvzUCSzZ1hLzs6cKZ13mhulBRb4z1
         RK7PDTN6P3xEcHFiv8h/yRh78OQ6no6DN67J5BjXezx8vtbQjBli+bC0bMkR53cY7fgN
         86hamQ6VAX1tiUZxEVPjl8rKzVSZTadCIBtlNlrSdr15DRsgnQdRYKvXgIN9tXqd6Ino
         2+SvPSP7Z4VE4fNneXqBxFvL1JKxCWrSUf9G3qj27pUxVyyy61UhTbvcpOUeXguWpg6r
         fRx4U9igxSbc4Sr0CVy6G8dM70rH7D+csyOnawaUIY47QfYuCBA1+ocVhMTxkcvnsm7A
         Bw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761222163; x=1761826963;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng0p3rzhbCe/bm8WuWNgEWBVBz/1DYFIUGKbuqDxdLg=;
        b=PmL40ils9tdK3ZMFrnWHzwdDZzRTFbU4LzTuY4q94JByS4rzQYbIe053n2F2rcNaUe
         H9dJGVldUCJko7TgeRR2up4LOwe9sbmJ7a40qL5xrkR8joC1i0V/s9Lca9PXUQCdCUIl
         x0887WlZAA/susrFCodAgc6sNdcB2jKomHItvQrfqgSphzgW9KivyYqmxe8bw1jo2UJn
         LNXjGTLSFxLNU5EbpqGaH4V9kY8KD8dwGLQktVCmnNSscBIkEUPEoMj2yvQRlnhgOyej
         r5NlyIiOMv1T0WPRe/a0arYBurVd00JMEtvhbiVECxyCb873jP73pTJngEmcEhq3Es++
         Xu3A==
X-Gm-Message-State: AOJu0YwiYi+XzqQOSKNNNOUxLtx2bEi/7hn7ZexQ6JY8zKh4PPIdqr9E
	YqVT9WHil6T+TClMfE0ZhRJnxL5fU+lVw6g/d1om3DJYkD8tEBt3uabm6s2FOBZCWuw=
X-Gm-Gg: ASbGncv77P3sWKCU5/J7yaetfUyUKHUsHOwETDGPxJdJPTRLdUGjuTPcKrFgLncysjv
	9JbG2VPuICQuZmfuH2+5A7UzaqD72iGIoUqgB2tq8I2k6gdPSYyy9oGrH/Aq5i6D6uGnFRu7HEB
	C/lwbZKSX4uNkE0CCpyuLn6fETGxFI+38fqeT7uxMFzIMdvY1/sEJ48kvw2TuYLvxq07mdHRd6E
	gYqMd13IdYZr7eqK72FGriMIgdyHWWttm6R0h0zffGJPNtW7xugUgyIO/Rz1+ZOoc5e0eRSYe/y
	BB+VUNyLWnBH6FbnGjLinPbrCdcyIlnqqU6GKEoaoolElTieJwGBufMfdD/az+noSviLR45GJkG
	iugIKmSxbsdNbEwQInPj5xwbomW4S0SV6ELGDxz/B59v4dO1XpDQP0RaY8uupI4YHdF+xxly/1c
	lCoOv0tyiUaBf3QjCZkmaqcHxC36FZB8zdlFiBy6TVgg==
X-Google-Smtp-Source: AGHT+IHn9Jc9tXr8TF9Sn6KIpzgp4yHxdt9b5RD5u8Yb6ZrVqAyZQpOL9VO2GV+WOPSTnrPzeUkpgA==
X-Received: by 2002:a05:600c:1d25:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-474942c4fa0mr55655555e9.2.1761222162514;
        Thu, 23 Oct 2025 05:22:42 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e7622sm3705393f8f.8.2025.10.23.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 05:22:41 -0700 (PDT)
Message-ID: <cacc9439-2cf0-42bd-b6c5-13d1e75642d8@linaro.org>
Date: Thu, 23 Oct 2025 14:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting
 and Ethernet
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2025 14:19, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> Enable the necessary missing configs for the i.MX95 to boot and also
> have Ethernet working:
> 
> * CONFIG_NXP_ENETC4 for the network controller driver
> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller


These do not carry any IMX95 compatibles, so I have doubts you described
the issue correctly. You claim that SoC needs them, not the board.

> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller


BTW standard comment applies - explain which upstream boards have all these.

Best regards,
Krzysztof


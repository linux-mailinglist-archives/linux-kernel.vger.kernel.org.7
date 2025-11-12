Return-Path: <linux-kernel+bounces-897817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3917C53C97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5428E5423D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326E3446D2;
	Wed, 12 Nov 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9TrqFbN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1D344046
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968070; cv=none; b=TUowZZCo16i4Zguv9JZKRLu6kp89XGPwz0DH2nrkkMn50w+Ku4a4vhi7y+az3Bhj8PxxpB5fPzMk+45D1f2gHt2KuD5sMvvR5k7AKUy1Vwl8CAfUSXjsYpt4CzfkuMc1m0Dh5j6u9jH8yDKCURe9l0JxqOP1S7ZH2ZwNC6RsArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968070; c=relaxed/simple;
	bh=zGm3bjPIXNlAXsn923/poaK7/h5DdSgopChHq1KIJug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NwGJbzePu5q5tlYeT/T+d6YzBwGtZqm2jWQRFhKhHlIT0XA/5S66a3zYnnPJlDKjbw6eg4SgWC1vfTikRjeEKb7liP6RDSjGnkfZoiSYx5AWtx7ZHfBFA1vfNyF77BqrH1eISDQRZ0N7asqbjBvKLqbyTLUqepS9Ja4As0kszwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9TrqFbN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b312a086eso816945f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762968064; x=1763572864; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D8BoUvcqK/7rHl2L0r4XdY6giRmTPN9ngtKeR3ez90=;
        b=S9TrqFbNcrP3YS5Uc7rdz6PzAL3g54MeF9cHf4b6VqPeDafcgVsOwmw3sVcAxW+SYf
         +kYZ8G5A1zVPRayt8sMogwJOaPtvzFRjp83uHjY4bmuhyPP/ULvORLZSyu5rRukDMrAv
         oe4Mtob5tFI/QAhL8K4A08M6tRgspAZr9rFNkqKY1CuEyuwiRzlmha0ipW1jef88mufh
         HtUdnYZGD29e3ULyHYB1AJmA5sxwYg3TX4ME9YuPK0B3SXLXHMIOCCKL0iDeU7NUoyZc
         6RXESpaWDJd3iV94l7X2grwZG3XtoyE+63VFil56xuS/4XFFO9EM+x/SF0Bk/4MevcWB
         Rh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968064; x=1763572864;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+D8BoUvcqK/7rHl2L0r4XdY6giRmTPN9ngtKeR3ez90=;
        b=uKEcvfTzQC3CC6Xm8a486z0xD/N7PmVM8R6Z2YN0G3Z6fzp0yr7EWMIWhZOvR9wo9+
         G0wn2YA5WxFKo05eJ59q9LRS1epnmOZ9PQRVg6PmceXZ5if/QpPwOBjtCUWyPvjbuRhm
         TpH4laLzIOAOzT+bV9fKZfl8O+eUiLCp9d64AEbuBucxcFh0op9EbsHrfub35e8n9vZB
         DV7FVz7cYYmPZ6Mq4ITcGoSB6YnfhsIFwiDI9anZMoW/m1JrnVwqYFhWPdSJrBUJbEqB
         WKcJVECSyBmPGZgqBtu3Hti3HQAoWChrQrV8RdzB4XaBeO8h4gM91izgSHUhiFCCz2/n
         IdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn+3lz1M1F82oSs7+WoF6CaZDb3dsshC7AnsbFVWdNZ5sQ+WSmXwhcn18ZuSW8cIIKQVq8MswQKaWCesw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxCaASE7SPeyIFtktlxsl9JnBLtkbyINottHOenIsvIUqmLrQ
	iJ25CElfzUHZ0nvwebFGnDtG8JotArSuFo/UFd8CLaW2efKiYnCFnWaU+yzG18KOS90=
X-Gm-Gg: ASbGncsLfeeEHWVX/OiGr942CEcKfhg6hJ6Ro/259JEU2G6xlwRJUc5xemjAfOVrbUd
	tMVXcndlp3tjgRHe5pGkeLn1nIGVHRNtLGVm8t7NhJhiWS5zJ3LYQc5INU4LqBqOEpIPFpU+H3r
	wlP2hghqfAsk7ej0s/zGrixcgcXCFMCaN4rAY1+1dYDNtxbW5lNOr7Ikj8iVldleSyMFgOBI2cc
	BTTKqvtjU/U9azf9eFldXtTbmRHqh1Z3Y6s1sgR3t5OmEBYK+ecOcCUKS4Pin0gWcZo5UdOIxDC
	C8WkhTM/KBGeIk9Dk0vAdPeIJ6kWu9l03YxL87uNP90CwJd7YIjUXqUYKArrmYRrDT20+t8Gib0
	hJ9dZd20NaYdcllyfar0eqMVDqCgYHqEBzzIwmSR1RhTZ/SUBdpJEMtAIJ0dJzgv6ka9Fvq/6G3
	FXh12tuHuUXboBZDw=
X-Google-Smtp-Source: AGHT+IFOnruwkehrKtiSlIIluNpW1jCcNK6zjknkUp1TXGQBb3IO3OG62+bnEz116c3kPlLyvXv7bg==
X-Received: by 2002:a5d:5f53:0:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-42b4bb90b60mr3558763f8f.12.1762968064363;
        Wed, 12 Nov 2025 09:21:04 -0800 (PST)
Received: from localhost ([2a02:c7c:7259:a00:4fbd:5c9b:d8a2:ee64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b4789896esm9558995f8f.38.2025.11.12.09.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:21:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 17:21:03 +0000
Message-Id: <DE6W0RIF2Y26.1MENYDV2RIAIP@linaro.org>
Subject: Re: [PATCH v3 05/12] ASoC: codecs: wsa881x: split into common and
 soundwire drivers
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>, "Srinivas
 Kandagatla" <srini@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, <linux-sound@vger.kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Dmitry Baryshkov"
 <lumag@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
 <20250522-rb2_audio_v3-v3-5-9eeb08cab9dc@linaro.org>
 <f1337654-ff69-4489-840a-a1b38efb7f74@oss.qualcomm.com>
In-Reply-To: <f1337654-ff69-4489-840a-a1b38efb7f74@oss.qualcomm.com>

On Thu May 29, 2025 at 11:05 AM BST, Srinivas Kandagatla wrote:
>
>
> On 5/22/25 6:40 PM, Alexey Klimov wrote:
>> This is required in order to introduce wsa881x driver that works
>> in analog mode and is configurable via i2c only.
>> Functional changes, if any, are kept to be minimal and common
>> parts or parts that can be shared are moved into wsa881x-common
>> helper driver.
>> The regmap config structure now contains 0x3000 offset as required
>> by soundwire spec.
>>=20
>> While at this, also fix the typo in WSA881X_ADC_EN_SEL_IBIAS
>> register name and rename wsa881x_set_sdw_stream() to
>> wsa881x_set_stream() and update registers description in the
>> header and use the new defines in wsa881x_init_common() and
>> in wsa881x_digital_mute().
>>=20
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  sound/soc/codecs/Kconfig          |   4 +
>>  sound/soc/codecs/Makefile         |   2 +
>>  sound/soc/codecs/wsa881x-common.c | 193 +++++++++++++++
>>  sound/soc/codecs/wsa881x-common.h | 458 +++++++++++++++++++++++++++++++=
++++
>>  sound/soc/codecs/wsa881x.c        | 493 +------------------------------=
-------
>
> How about we have something like wsa881x.c wsa881x-sdw.c wsa881x-i2c.c ?

I am totaly open to suggestions. Splitting to wsa881x-{sdw,i2c}.c sounds
good to me.
I kept the original name to keep the changes minimal.



[...] (the rest of the patch was quoted and sent but I didn't find any
comments there, please let me know if I missed something there)

Best regards,
Alexey



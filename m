Return-Path: <linux-kernel+bounces-886386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11194C356DD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5965A5616AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267A3126B6;
	Wed,  5 Nov 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJSB51PU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74753310655
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342792; cv=none; b=kr5pFVAZ+luBXmx3lgKrj536szDFTC8ZwvdtG/VWYW85FX0uQ72TpohDPcIoRGIgDbkKuhgav24hkLjwdEJ1B3M+cztUpcyEFBRTo4rU6eoimWwWNrmyVDn3d7HLw0fh6t6ILRbtmJkOCjvRV4i5k3DsIpPFYvCjdlwoP0xYYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342792; c=relaxed/simple;
	bh=XJnQ8QAutR/Qjzuilm6RbMyIh+omr6OWVKRLZO5Bnf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYFzbsK8BAmFuY9/59tCqwYH/C7j7DDcR3kEgmih+ka4iMmOeMoJcKCNSxHU1SECkO6kdU6qjUaKesKSj1QXfMfCrieb+WLtnMQiZczqmMJTBx6zwd8modn7NGw+U5j3ssmVCUkNMmyRDa5WOEhuYtTCIc6yi4L9Ha3uCjHzuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJSB51PU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5942e61f001so2715674e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762342788; x=1762947588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcDBz895P+pKkilzGMv1j9zQS86el4sifmVfoozzk=;
        b=CJSB51PUDDIAmXELEChvDo2y27eoe70faA3tbu/iPSRxcznGwDxA4bNg143HX2AY7h
         6OGa2qZJ2ps5r2LR1uY1uPFiEIH8H8zrwlbmo85b25eyoE02XpPno5Hq12P7LuhwCk1O
         AzhOd7dtEH/zdfXb7nbzaeQzyYAaewr51fx1+H5AjY8W3Kl0BOuLD5SXeR+Vmn2DTv18
         xNqJivuHGk0slJeCzmZ6txTYQKgfh9wlTNrQiIKp6MkBqkBELvDcax2vGsyZL/Yhiyyo
         0UwyKme0BrLCsAaEIC4WGuYf9doozejNTg8izdiv+LZvpkWMA7oSxGmH3YAIz9thlykp
         fWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342788; x=1762947588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcDBz895P+pKkilzGMv1j9zQS86el4sifmVfoozzk=;
        b=XTEeR3MX54P/bYCoghhNYMMu9UdZBpaVNz1pbS5aIWAQAY8hdckl6Q7cd6Q7SdTCGu
         8a4z6c4BNRjF7GnumFjf3XpzEuQdyfTKq+K1bIcjDlkzPMWMPIiAc9Oc3R5uIdOeuA3V
         DQKtUsvmrG4mixzwpl4s9yDyQLfQFhm9wPVzNLY2HTgrjZvXtMIPoo+MRPsnzaC46Dzr
         sM7DL0FIdGp4fnri9xb76dVJSzVga5kYUHU4N7esovoltwrLAzgPQsrQpl0V9uQJ797d
         /zJHQkpSLq+u5GNASsoYCC6bBxCx5P6cdqHmepVZLABc8PfJkiNUjP52IdsbKBJIQ1Q8
         4oLg==
X-Forwarded-Encrypted: i=1; AJvYcCVIt1v78YwEkIb4DqAOCBGcBr6jlvhqXKgTnPPPCJV+4H6RKjidB6nAuHjRqUV3aXDZYUh67/tfIZPU2lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgZqE7k4bdC64oui22BRC8EMZwCyoL8x7+2tEccSvj8DOoD4d
	7cv0OMR2qWXlxTBCgLhqkveCddkDEuDVk6Ot2oFZ3EaXncqHT8qnSdx9
X-Gm-Gg: ASbGncsoK3/vEXce3mwn21aJ/cb3gA9X5saG3VexH/1+SBpbJo+z+GO6rOolDGNut+2
	tWKVb9u5+G0bsdC5avN5QBVRJprf5FtK/+Gm5NvhMSDYS3GBDsrlR4v4I6NkrvIfR02byWRapyX
	630DtjyAK0q3aE2npfjwaZkKU/5RWnfrw79Lg8NLoQnWnWzQdDm3Bv8jrHVLaLipLk5lsx+1ePZ
	3KTtjdxePhOiuHR7fCj/tV61z7vWbhZny+YbwFIeY12H/ux/2wv6gyuXuMgYrsMPPk/pLomjclU
	9gvzTtW9L3/3qbUnVEHohNRkqrKjyuTX34urfU+WFYuGdMfehVCJm62K1iflnIi9L43/ufAn8yD
	SRg6q3LtWkvinnQQ/ViWR/FACVSmKQRchJSm4VIZNUfUI5oVvICvCWAr1pglgJaA0tr+JNbbVPf
	t+0vhDCW4LemT+JS9wJdGj1YxOmOxfv/01QNd9ch6LlKCi9P9u7QWNEGkUFQ==
X-Google-Smtp-Source: AGHT+IGG31UsLd4o1FDm3BbiPL0QtqwK8nPiQHx1dRUKJ4gb8AV+HvnhJfY8a3mxdgTF9YlyblMwPQ==
X-Received: by 2002:a05:6512:1395:b0:592:f8aa:c06 with SMTP id 2adb3069b0e04-5943d7f3f74mr1019404e87.57.1762342787278;
        Wed, 05 Nov 2025 03:39:47 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943443992fsm1652172e87.60.2025.11.05.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:39:46 -0800 (PST)
Message-ID: <aa55cba7-1f7a-4c44-a101-cb991387fa55@gmail.com>
Date: Wed, 5 Nov 2025 13:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] dt-bindings: mfd: ROHM BD72720
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-rtc@vger.kernel.org,
 linux-gpio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 devicetree@vger.kernel.org,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Mark Brown <broonie@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com>
 <176233321210.143104.455177775703669783.robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <176233321210.143104.455177775703669783.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 11:00, Rob Herring (Arm) wrote:
> 
> On Wed, 05 Nov 2025 09:37:05 +0200, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v2 => v3:
>>   - Styling
>>   - Document all pin functions
>>   - use pattern-properties
>>   - re-use existing Rsense binding
>>   - correct the example
>>
>>   RFCv1 => v2:
>>   - Typofixes
>> ---
>>   .../bindings/mfd/rohm,bd72720-pmic.yaml       | 273 ++++++++++++++++++
>>   1 file changed, 273 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml: Unresolvable reference: /schemas/regulator/rohm,bd77270-regulator.yaml

Not sure how this slipped through. I'll fix this in next version. Thanks.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


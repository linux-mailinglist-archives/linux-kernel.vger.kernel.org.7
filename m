Return-Path: <linux-kernel+bounces-890290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D8C3FB87
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6831882DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785D31CA54;
	Fri,  7 Nov 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znqkUCDQ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C531BC90
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514600; cv=none; b=mOLjdlRpeu1ZchOiIbN78KPlFaQhFsAgTFSNQn7+dV30wJUaAqJ00rl8qZFsfThvoIu8M9EcGpkhiDf3Kk+j2ZEAAAcjY/5VkRKGSsIU/jlKeYf516JhpRIiNbUZFT8giA1/OoTqACGHQJnVOmRh8/zz77cf+p12z/RVMuY/aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514600; c=relaxed/simple;
	bh=hIRq1hBV/Vkm950YcOMj5joE3yzYwWC3jRnL3QIu1co=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uB0kIpn+6UOgWoHSPLCKEdLqr/MOhbA5VLTjPZHkfWvxv/n/hPUPkcemHFf2mtIkTqJod0LiIi3loN0VXRjAnKFVXOlrpyMdUnJ4cmLIxaUjVxfiGd4bYD0/mIMTI2t/606CsFVjXdsyCI0RzHvWQdrCysOgjKM3JvAeivCt/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znqkUCDQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4298b49f103so249657f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762514596; x=1763119396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtAgMzQLUEkWjhbFNDOre6KPF58LB5AVVftjd0cwizQ=;
        b=znqkUCDQLSWxn/zRRI8tJAE6+ovbPzdcdiExcTCmBWZ7QMMKP8g/UnTooL50B7BGMJ
         lkDpP8i9xc8ftmkfK5Vf9A6g37rlUeaMFAJbu9SBgoy+zNnfrPMA/7Q3kkeyuL7d9a5w
         E2In1UX6Ii6uHo/TvyWgjdcXo2YXzwKNxcvjAkXa2Oz4o9xRMiIDTSKi27RIkiyBEBZT
         Pwqr2ZKVjGtTkpoYoETranZM/7z5bACrkF8vvPuEWRHISswJ2VkNZsUcJ/yIrtr8oLm/
         UXz31fQgI5Wpg3pT6IdwwJajKS/yiCbFa78PNzd+yDKw/PyHsDVm9ydjen3mXUKBKb0B
         eh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514596; x=1763119396;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtAgMzQLUEkWjhbFNDOre6KPF58LB5AVVftjd0cwizQ=;
        b=DZiQ90/UYz28rUyTsr558RI5o0Y5j1wTOgd28GaeBCZ/KEKhXSvLv1ucCHN1fPsAqL
         MaOR44f2NXI7+xRpVLTFHGLXMa180ZW5CfjvEKxuv1KSC1mlXUkLePrlclHcKrXebrwz
         9IkNt5UJntvI9fgTMLcf86XUZNgfD+CALEGZEjV6rkwgLAVGFtzeZXixtNYuIrtd2rca
         pIFnHscZHFK3TXTVgzt/Yi9Dd6p9/+iXv2fJQp9TIk9SldLRjahfGdr0CwVGPTvzXZl8
         kZsRU2MdkfMFyMg/wuWS9nEo3scabR/29pdoBPuxASXyYc6FTuxGIpEKCD2CnEInwBXN
         Udcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrPgB7/t+CND4dxhDGy6ovYHEAwHIts//M+qz/Brwa8ZM7oEzRJfEljznyLUKK0jWpeqoHZOvN3pU9cl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rgZarMiR5oiIiHtKkfolRqUmrT1bt2iF0TuMotJAJX8reWrR
	RW1450hX5z/+Pff7j9sQekbl+mvpOIa4ZzYAnHoEbZNfDZIjhbp+cYRP9t2w9fwA+3s=
X-Gm-Gg: ASbGnct6cBXB5aPxdisSQyLYOwDV08syjzgoqoU8EFX4xQgu1szyU+btwC8weaJU8bR
	tRxmVIgCRKdvHgTlZOX6529ciJQueYscikemDSUiEdoNEEYlCIY9zlbBYQ9ifllgEFrnth3WHVc
	mw22KJQST55MweKU/U1UsL+BRNR4jwvWLUA92Hl2KEF5tDz2BXruh2T81+phTYOI55HJk4WdKzv
	PMx9iaQwHwwsskwE2bUf8rgkQ8mdz/BIR6KpF92FvH81EJMf5u5crHpxskope75RbkCXjWpzHTM
	Ol3IuNQHagMYEOjKWjnh+kmix8/jRU0+kUnnQE8ZFX47FS89R/t3AQkkhcEk97+T0LT3FLv7QPv
	A1An1t6kxad+o01KVF4rBBb/l+U1vOUyhQuhK4WE7RZSk5THu8fAHSyBlONLapLjrEAB7SfJcdg
	F2/F0tpum6yBks31Ft8s+5w75wNbTM9cKiiDzFOM+wIJli
X-Google-Smtp-Source: AGHT+IFC6PS8CD4thOKnMt/0x6DHF4pMfb9zQG3hVlwbO9wPH+DcI/MNv2cBuknKQz9EdnzfI0iTFw==
X-Received: by 2002:a05:6000:458f:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42ae5ac408fmr1620035f8f.30.1762514596332;
        Fri, 07 Nov 2025 03:23:16 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm4745735f8f.40.2025.11.07.03.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 03:23:15 -0800 (PST)
Message-ID: <be1b6e34-40ab-4587-8dbe-84e08bf83dcb@linaro.org>
Date: Fri, 7 Nov 2025 12:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 01/12] dt-bindings: panel: Add Samsung SOFEF00 DDIC with
 panel
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20251104-sofef00-rebuild-v1-0-dfcfa17eb176@ixit.cz>
 <20251104-sofef00-rebuild-v1-1-dfcfa17eb176@ixit.cz>
 <20251106-enlightened-centipede-of-tempering-3cfa50@kuoka>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251106-enlightened-centipede-of-tempering-3cfa50@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 09:48, Krzysztof Kozlowski wrote:
> On Tue, Nov 04, 2025 at 11:16:09PM +0100, David Heidelberg wrote:
>> Basic description for S6E3FC2X01 DDIC with attached panels
>>
>>   - Samsung AMS601NT22 6.01 inch, 1080x2160 pixels, 18:9 ratio
>>   - Samsung AMS628NW01 6.28 inch, 1080x2280 pixels, 19:9 ratio
>>
>> This panel has three supplies, while panel-simple-dsi is limited to one.
>> There is no user of this compatible, nor the compatible make sense.
> 
> There are. git grep samsung,sofef00, gives me two users.

Hmm, on -next I only see a single one:

$ grep samsung,sofef00 arch/*/boot/dts/ -R
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts:  compatible = "samsung,sofef00";

> 
>> Remove it from simple DSI panel definitions.

Can't you mark is deprecated at first ?

>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ..
> 
>>   additionalProperties: false
>>   
>>   required:
>>     - compatible
>> +  - power-supply
>>     - reg
>>   
>>   examples:
>> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,sofef00.yaml b/Documentation/devicetree/bindings/display/panel/samsung,sofef00.yaml
>> new file mode 100644
>> index 0000000000000..527a10e3b798e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/samsung,sofef00.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/samsung,sofef00.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung SOFEF00 AMOLED DDIC
>> +
>> +description: The SOFEF00 is display driver IC with connected panel.
> 
> Description goes below maintainers, see example-schema.
> 
>> +
>> +maintainers:
>> +  - David Heidelberg <david@ixit.cz>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +            # Samsung 6.01 inch, 1080x2160 pixels, 18:9 ratio
>> +          - samsung,sofef00-ams601nt22
>> +            # Samsung 6.28 inch, 1080x2280 pixels, 19:9 ratio
>> +          - samsung,sofef00-ams628nw01
> 
> These were not in the old binding, so please explain in the commit msg
> reasons for adding new front compatibles.
> 
>> +      - const: samsung,sofef00
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios: true
> 
> Drop, not needed. It can stay required, though.
> 
>> +
>> +  port: true
> 
> Drop
> 
>> +
>> +  vddio-supply:
>> +    description: VDD regulator
>> +
>> +  vci-supply:
>> +    description: VCI regulator
>> +
>> +  poc-supply:
>> +    description: POC regulator
> 
> 1st poc, then vci then vddio to keep it more-or-less sorted. Same in
> required list.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +  - vddio-supply
>> +  - vci-supply
>> +  - poc-supply
>> +
>> +unevaluatedProperties: false
> 
> Best regards,
> Krzysztof
> 



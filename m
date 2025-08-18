Return-Path: <linux-kernel+bounces-773909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7675B2AC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF6619608D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337952494F8;
	Mon, 18 Aug 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b862hnKT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BA246BB9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529242; cv=none; b=EUf9lKQ/l3prCRajjE0dG5KBnLTMc05/xpPQwI1N0Z7LtNTGRoJdqfAMJMlimoxhEhUcwDNByGDqblT9SFncVUOD1Bp0WgXLiMpU8GgHKnMHc7qOjfiRM6Ye5Uebiw4Ni4HueSpORNjY1zj1E/RmfzqB8LxG1A3UFJrhgCS+K+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529242; c=relaxed/simple;
	bh=0JNZqbkaZPSHbtSv2NDjMryyfTS1TeGtEneKo4TuKFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aj92BClQy30Gl5P0ZZxb56bt6OHgnWG9QWQyOUvYsf9JjOhd6sSJgE0VAH6RG4KfZSY8pQPG0AjxZyAgh43PqWbO1RJc2g/mb30j4NdfYfU+4Iq3CCLHhpEFSAPCOUIG5ixSD1937sa5D/viINvUcIT2mCdHHcgM6tBYVXcyKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b862hnKT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso29367895e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755529239; x=1756134039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3C186B02aTHKwHlpf9PgYbUa4D0oYowUZVonNLOuWk=;
        b=b862hnKTM8Ul1ziS6hfbVhg6mPcXaBM3KBapbmewVrMBBdQZouX8K7sWWIuzGQ2P3I
         3QdyNzFNkil8SkZRIPDm+1T7xdcoKR6gSCOaGVYQ8zEe8dlSL1JtmjAorD6mWzRdQ4CP
         zImAcBiHTYQzDfcE7pTT/qZi/WUS9d2xDmvrifGK1t/T1Gejr40+24wONdWshbdjOTNk
         j3YByqVVzpI8BEb2LuJye8JPEyAFHvnMfolngPmg5DmV8q+b5p9r1rLapZz/C7bUk8V8
         s8Znl1mrBNkAyYKUN9Cz+Z3o8okVvRC7uZI6PMD5qH/CX1BIs/CpXV6biw7SN2tn1KfV
         Kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529239; x=1756134039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3C186B02aTHKwHlpf9PgYbUa4D0oYowUZVonNLOuWk=;
        b=L9pcxfwXrdkvxuDiyvzWppnBQ2rgPLEtxgb0OYouAMYyZKl9ivlFkaWgUTbGWUmPyn
         VLfevOB78NXNVBawN2CbTcxjJ9ip6tV5Z11wShEtweRaVj/tO9oEQenSukGnhQm+niTt
         A/0r0QkCIWW48VaJ0nYXicPjiOTOL72OnQhRtLlD6pIbXX6199/5UAfdovd9DWHWmQ7x
         e3idYmzJCiouFAxZ39ZXMLSU8yPxQn3dX1MVD8rEtBMjZAa+K+S1Cyvi6rw2cG6Zymdy
         wlWOByN8feo/fZaPT3FGX+tUJl0HlE6xwuAsUxsCNSHl/b0hoi6a+7Ut3hsLkA5ytedJ
         bMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcge80o1/HBBnjF5hEMcfLHUQnLkhDnGQ+myCKDGIYvGqdzoCzOaPgXOWV7T1UY+3TYnsnaZTe4eErgn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ItdYLb6cKzqIhxSDOi1elnqOJf/KNSEXowFsIOyIMMcJQBmy
	VppxQrmhZFBUt9eXN7j0S1ze2YJ9ANV5fSq/o/jLEmKPP616KpBcGP38hf7qdhpF8Vw=
X-Gm-Gg: ASbGncs9k6uev93HfXHahVzIJc6zX2sHzLRSx54gAjIGLHwqDD5YKV3Qt9YaEwAukcQ
	hUraX4JXnix6ZCAa5H7ugrMPgXugaYfO19ECCYW+tMwBGiGMWOYo8yXNBN3dvWpUQKmepFibFkO
	iEdCG04EBEKoCC9oqgWl2p/zVILD8n6pIOnVG7lAxCYJcRn/v9pKO73hfq/esuhfen9CpQj7VCn
	vA+vSO2Zh73a2Pm8BlZbn1MichuFAEJNPkm/jqcSYo26RvksVFhNJ8vX6jz+JVhNqO+lu+3zIaF
	Okux1yvaPSjAp0irZ8B88DWkvMXlaKIS7OtDRNWsQfI48ZNxXx+sRxN5+ghuKAR3SjJiUrRITcY
	4OiDQa8NGbU9qt4PQuWHXPFeRmSk=
X-Google-Smtp-Source: AGHT+IESaK84+Qbh2oexCcTZyKswpuURDPkkYWkvE7C1Z1VgwlbYMMcTEbeuIN+y6lVq8A9WR1nQXA==
X-Received: by 2002:a05:600c:a06:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-45a2186d9d2mr115197275e9.30.1755529238740;
        Mon, 18 Aug 2025 08:00:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a8f972sm3653855e9.20.2025.08.18.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:00:38 -0700 (PDT)
Message-ID: <c33c549d-71fb-4778-a1bf-454aab1dcd8e@linaro.org>
Date: Mon, 18 Aug 2025 16:00:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] dt-bindings: lpspi: Document support for S32G
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-13-9586d7815d14@linaro.org>
 <aJ4psW2Qul4x2bQ4@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4psW2Qul4x2bQ4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:23 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:53PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> S32G2 and S32G3 are currently treated the same way in the driver, so
>> require that S32G3 is always paired with the S32G2 compatible string
>> until there is divergence in the future.
> 
> Add compatible string 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
> and S32G3. Allow nxp,s32g3-lpspi fallback to nxp,s32g2-lpspi since back
> compatibity.

Ack

> 
> This is independent part with other patches, you can send seperately.
> 

Replied on other threads about this.

> Frank
>>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> index 3f8833911807..9fc98b0f3428 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - enum:
>>             - fsl,imx7ulp-spi
>>             - fsl,imx8qxp-spi
>> +          - nxp,s32g2-lpspi
>>         - items:
>>             - enum:
>>                 - fsl,imx8ulp-spi
>> @@ -27,6 +28,10 @@ properties:
>>                 - fsl,imx94-spi
>>                 - fsl,imx95-spi
>>             - const: fsl,imx7ulp-spi
>> +      - items:
>> +          - const: nxp,s32g3-lpspi
>> +          - const: nxp,s32g2-lpspi
>> +
>>     reg:
>>       maxItems: 1
>>
>>
>> --
>> 2.34.1
>>



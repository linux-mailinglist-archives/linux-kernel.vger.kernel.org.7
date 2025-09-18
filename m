Return-Path: <linux-kernel+bounces-764275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19722B220D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC753BA1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF12E2829;
	Tue, 12 Aug 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmphkC1x"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56722E2640
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987186; cv=none; b=tip0BcOTC6LBE/5NXFPHpmjFeCuXrcpgcaYZIZ35M/pjCzuHMMIAFo7b8gRoqQ/NUCfrz6gZVznYmgITGknEZjrJiFqLazJOGZrWbchsxO4MlPdLMLzpConumK5U/ygnu2DujEPsoNrlFuNCgYMmWruK4upnQu74TZZTYy6BeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987186; c=relaxed/simple;
	bh=uJXZgdWwqNsCml5GugnFmVpZMgaHLxLQxUPE4ka6n5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA6BYE9iad64mZPH9wvwzLwRFVDHUZQMrdp4yVXbSa/UfHlL2wUsn/NICl8PD0jfarzyI6VVsdUpEia9LXciQ3A6QbXfoLXNKBUz8+P4TdaJ+HTRV3TxlioYNEFsxY3EcJf4zhFU2FFEIscPgKwCkjtrPyZAvOQG9807JXNW9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmphkC1x; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af92f13d27eso63386366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754987183; x=1755591983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QbLB+9qfEdTxn65XyJ4OVhRT/fNBH2lNTneYC+BHgMg=;
        b=HmphkC1xiDg9kyMva5QrktudiPGMojG571WyMBhLYf/Oq0qXOvzC9amXnGzwEaIHH1
         +hv3lmIwyPdXLWPS8OiGmijh0tfuNYkHR3W6OHx+cYuNQtjWEIzgO9TWxHtkkfhIimDo
         s+ExZXEW8IFNjd8tm9R31ClVjCJfJFRsst22WRfiDYQ25QyQqRCDOYsnODEGkpaeZWUP
         6lfiFLHi6XyI62qFNzmDs/YL46d0QWLNFKdHiVv1D5CQJ//fqbxF0el+hC1jOADBRy1z
         lpMYsybWJwBdQbPGHgZGljyowvuu9zlK0Zlk+c8Q8ipfdvc0Guaqq44iqZiQ1NscXvvE
         gT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987183; x=1755591983;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbLB+9qfEdTxn65XyJ4OVhRT/fNBH2lNTneYC+BHgMg=;
        b=eFJgI5noAtTh5nvwUwhkM+/+8W4VT0FHONktr8e81vPTEUj8TH1pp2pFxOICbRricC
         bnEwMKgVACfBUL5JtxDqF8FhTliB/nNVCJ8Zwfr3nrXMyc+DLD1ch+sjRjb/F6JnKalF
         65NFwoPX6kqLxfVasTi2xu9OcK/ojT11AgcMjWIGUXgzESWbcig1TDmEo8TCP+GWRMhR
         aVOdMa1niJ7ieyH5I7Za+Xt0WmRvAdKPHqluGu296KaeWrFy1R09m4bSPdDVlVQ4RWoa
         /sLww0+4w/sj4xG26+4+DbLSBVjIDJfyAdBWET9y0hubk85Xkjik5tBTtjlWyH+idyU1
         f1NA==
X-Forwarded-Encrypted: i=1; AJvYcCU3kDsx6GJ09AAihAj39fQ1lNrNKBGg7tfJmtcF/qsXRF4/Fpp8x8B3vTMtJtpgwzo8oEuz4EfCY6sw+88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzgyl4BpvZqzSqdxz8hfu6HXCxRoWDBVwcCAJL0LgKvec7RGc
	QkLPOAJOgswKM4/eHxjm7AtesUcEji3tn4Q6oHm9Yw+0FVJ4WmbGvu1A7qX01yEwfWI=
X-Gm-Gg: ASbGnctAR/maxvcOJEt/Sf0cfCicZX6QStMmP9CQT1UvbH+Cxaj+ZrYr/asgkF40Oxu
	5n06acFBRdvAhMo/UQA8kVGYAQ0nhDjY21M0m/QaNDJG2oLX/aYeuGzM5OLPKVfb8JKN8W1SdYa
	FALhUCL487QhB0xkFbsrknXpYYkcQqx7d8Q5PO1wlEVPAxIlC2BakfTmIxsj/5aMJA3lRTpiqoc
	ZdXBGRaDW8f6n34fwFxTlHy8l7dcG76r2wt3DvfM338jWgiXjkyGysMxVvLiKlWlDewNvtQnF80
	ggS4Km7a0AfDAELelm2GaVzbFQ2jb+htDRMAeqMoMz1v2Rk4ZXoeS4tYSBAmqk3sLiWlF/Zwd5C
	Acwl2leCfa16CDk8nwGhi3gGpgPHHIv0NYpnMnTliDRo=
X-Google-Smtp-Source: AGHT+IGG8cHGIjKO75ABIG5UtKz1q0DmJJ3x+O/bjZqVJDeKgkzt6mbQSH+osZ+XM0xzd3+K67RjLw==
X-Received: by 2002:a17:907:97ca:b0:ae0:c276:d90e with SMTP id a640c23a62f3a-afb6ce4144fmr13496766b.4.1754987182930;
        Tue, 12 Aug 2025 01:26:22 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a14a0sm2179264066b.33.2025.08.12.01.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:26:21 -0700 (PDT)
Message-ID: <9c83e4d5-7192-4e02-baba-381bece513c2@linaro.org>
Date: Tue, 12 Aug 2025 10:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: MAINTAINERS: Document actual maintainership
 by Bryan O'Donoghue
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>
References: <20250714151609.354267-2-krzysztof.kozlowski@linaro.org>
 <8772c48f-348b-8a68-2099-562a29b9dd8d@quicinc.com>
 <b83cc20b-44d2-4635-a540-7a9c0d36cdb5@linaro.org>
 <a4dfc82b-79df-3e3c-0964-a99db222c6e6@quicinc.com>
 <4f79424f-0005-4978-8c6d-6b726ee7e4ab@linaro.org>
 <c70fd6c6-1a65-41ee-b0e1-f6c792867009@linaro.org>
 <2b5ececb-fbf7-4901-8efb-03744f740836@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <2b5ececb-fbf7-4901-8efb-03744f740836@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 13:03, Bryan O'Donoghue wrote:
>>>
>>> Reading too much? Bryan HANDLES THE PATCHES.
>>>
>>> That's it.
>>>
>>> There is nothing "too much here".
>>>
>>> Person handling the patches IS the maintainer. Full stop.
>>
>> Based on email you forwarded to me and some more feedback I got, I think
>> I understood what would be the solution to satisfy your point of not
>> changing existing entry and solve my problem of maintainer handling
>> patches not being listed anywhere as maintainer. I will solve it v2.
>>
>> Best regards,
>> Krzysztof
> 
> Doh, this is definitely my bad, I should have made a _new_ entry in 
> MAINTAIENRS similar to this.
> 
> AIROHA PCIE PHY DRIVER
> M:      Lorenzo Bianconi <lorenzo@kernel.org>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.yaml
> F:      drivers/phy/phy-airoha-pcie-regs.h
> F:      drivers/phy/phy-airoha-pcie.c
> 
> GENERIC PHY FRAMEWORK
> M:      Vinod Koul <vkoul@kernel.org>
> M:      Kishon Vijay Abraham I <kishon@kernel.org>
> L:      linux-phy@lists.infradead.org
> S:      Supported
> Q:      https://patchwork.kernel.org/project/linux-phy/list/
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
> F:      Documentation/devicetree/bindings/phy/
> F:      drivers/phy/
> F:      include/dt-bindings/phy/
> F:      include/linux/phy/
> 
> scripts/get_maintainer.pl drivers/phy/phy-airoha-pcie.c
> Lorenzo Bianconi <lorenzo@kernel.org> (maintainer:AIROHA PCIE PHY DRIVER)
> Vinod Koul <vkoul@kernel.org> (maintainer:GENERIC PHY FRAMEWORK)
> Kishon Vijay Abraham I <kishon@kernel.org> (maintainer:GENERIC PHY 
> FRAMEWORK)
> linux-arm-kernel@lists.infradead.org (moderated list:AIROHA PCIE PHY DRIVER)
> linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
> linux-kernel@vger.kernel.org (open list)
> GENERIC PHY FRAMEWORK status: Supported
> 
> Its 1:1 what we have for drivers/media/platform/qcom
> 
> I'll add that entry and leave the Iris/Venus entries as-is.

Any progress on this? We agreed you will be sending that, but I think it
did not happen, so maybe you want me to send it?

Best regards,
Krzysztof


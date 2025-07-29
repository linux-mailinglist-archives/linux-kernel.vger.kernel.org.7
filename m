Return-Path: <linux-kernel+bounces-748966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011BCB1481B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E17AC15E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474524A043;
	Tue, 29 Jul 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp63kre8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339951DE4CA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770065; cv=none; b=hciI4nhbwPR8ST/NiO6tOQq39JBSSAVKGJMttfF2zWrSxL62z4ASP2mQOmNkuOz38Ke9b+lKhqR3rlPe4E3xl/rgdHnsJKoLDroNAVanj5lmrk29a1jp69ZVNiETaTowdrDW0EGa7wHyYkXul7sc06WmkA6QBKGiHee9h3DKTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770065; c=relaxed/simple;
	bh=nP+28ID5Kj6o74p4+d/dlEul2MqwhF6WGYdpBvg2MYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ums+/pvZea73AwFi16XQIYY1IzK0yuGK11bVBIgfO0v8l/B8q+zjabGS9bnOi1bn3gMO1W0ljJ6/yvdv2PPiND6xcyE8hIiO8JTeuA+RiwwxBDr2xUUk8zLlETpKXj1CCLh20U6S0IOz8ZhKYYGUZwk/gm4E7r2NKQypexyYgWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gp63kre8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-455d297be1bso1971565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753770062; x=1754374862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ninIN9/GUpEjrJR47C5mY2otahpGMFvoZnUq9xsx+wE=;
        b=Gp63kre8jTTJJeCiAXngKCYLv00c5UPch/f8Pn1dY07FDtkTkxPVIWZLjy16j2etNB
         VB+48/FqzWV/BoYfEHznIrXnn2d8bUg72zV7PboaWkp/Vgx2WtylAttIBG5+eVxq+dzO
         eykcv6bjm3XRo0WwxqG4ezeEsSma4sPtnAtuyJedyhN5E2lPaHZhwHb5f+BfJbdYj7PQ
         ovlaAQsdjB97YL+xd9z/Fow8Du8Hom9EFbFtC9OvHTnEnro0sigwIXIDeiStB1dJ5D50
         nstbT+wHUaXNXG93hL3KZpgTpbjsbgm42M/GaOJ0Pg7HyJWfAzH9Hl1rD5hzPUrO2BGM
         5HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770062; x=1754374862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ninIN9/GUpEjrJR47C5mY2otahpGMFvoZnUq9xsx+wE=;
        b=PzAdRdjJA0jnaRHArNzP2LAmIs2ONVkSaIH41LGBWXCrrYq7YU3aiiii+SXrtcoe57
         6LD+yxTXml/b4NyY2FeYY3UuqqVCkX7JjZc+JSvAMvvAXmH3sejpuE3fPm1jZ8+qpSJu
         Q/BZFH723wNf11XEAQlAt+WO6yHfiF4ytJ7Z8MtfCI0ILFzDwP9qfL7EUM7+2wjlljNV
         8grJA/3/tEptiPEAP+6qLAxb6sc4EksEC/ky/bAz6CZWHqbYDIbIBOyN08hwkjdfxE4/
         p4kz0fxw16E1y1iro1W12lPCoIL7U3FWErP75ewP9TNvL/ugFWAYVlVXHVelpWYAKrEc
         XKow==
X-Forwarded-Encrypted: i=1; AJvYcCXFYAQuLMrNxlrTvHwsm8abbed3vCSapestevHJ/n80wVDVK7RZaxVIZ2mrFiZ3PGI1i7+tgEEXip5CRxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cScvI8C30IOeokSA+yrgP2mIngS5JEgl1tIwrn6eV1Jmxxd/
	H7QBEwG9kmXeNbgBCyDV0Th4FhB5jFg5nnUYpXYf5B9LkfJjQGCvQSLhyHQJhFVQGqs=
X-Gm-Gg: ASbGncvkg6l3L03js69eoHpusqLhXIoXgDZK7MW8Rxq10znNvxwjVw6DEzjhfnCIL0I
	mc2VpxuCiccXOAhMAvFPdkjJ3VXHh1V6fHWCG0ct47LUFkOs7VhoQhBDUKdLvHvramwd133xEkm
	8/eT5c0WdBFzvdO5wZ2BAtzcqKnveJwAxhrwmDXCaWhcfHQAkdH0tuY8QmsLOHgFwXohAfLSn9J
	tKC46S/ls/tCElAnqkvgJLXnnRiNxq1Tle4bRfAIAdJTqcQg7gKWgmggsKO9HP2TClfoIv6gC5Y
	avvLMnx9wVTX3dGzb6owwDHFn0EHO6K/EBEWPmwBe8STfUyCdeM20taQwUi/P2B/u8Q8jhepn6O
	Y39nmOYdyCu5QY8KPwxbuY2JpgDDCJvZefAx2pEJ2v7k=
X-Google-Smtp-Source: AGHT+IEmKgcMvWIj0DsMoQ5/CtMwQTTbMBLGZBD8mnAWI3sb3Z5QkzBevaGkajMpCZ6Wol0R62Yn8A==
X-Received: by 2002:a05:600c:45cc:b0:455:fa91:3f9b with SMTP id 5b1f17b1804b1-458766a2e3cmr48395025e9.6.1753770062566;
        Mon, 28 Jul 2025 23:21:02 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4fdasm188933305e9.28.2025.07.28.23.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 23:21:01 -0700 (PDT)
Message-ID: <c661130c-3d18-4e6c-9c63-ac4c10c415de@linaro.org>
Date: Tue, 29 Jul 2025 08:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: nuvoton: npcm845-evb: Add peripheral
 nodes
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
 joel@jms.id.au, venture@google.com, yuenn@google.com,
 benjaminfair@google.com, openbmc@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717135336.3974758-1-tmaimon77@gmail.com>
 <20250717135336.3974758-3-tmaimon77@gmail.com>
 <91119587-789e-485d-9cf1-da2c500f241c@linaro.org>
 <CAP6Zq1gN28y-6_OwnzMbJ+EiubtABVw+FUqbmAo5bvBW-5tDdw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAP6Zq1gN28y-6_OwnzMbJ+EiubtABVw+FUqbmAo5bvBW-5tDdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2025 14:12, Tomer Maimon wrote:
>>> +
>>> +     mdio0: mdio@0 {
>>
>> Huh... this should fail checks. It's not MMIO node, is it?
> No, it's MDIO node,
> https://elixir.bootlin.com/linux/v6.16-rc7/source/Documentation/devicetree/bindings/net/mdio-gpio.yaml#L48
> Should I modify the node name? If yes, which node name should I use?
>>
>>
>>> +             compatible = "virtual,mdio-gpio";
>>
>> where is the reg?
> It does not include reg in the mother node, but only in the child.

You put the unit address...

>>
>> Please confirm that you introduced no new dtbs_check W=1 warnings.

I need you to answer this.



Best regards,
Krzysztof


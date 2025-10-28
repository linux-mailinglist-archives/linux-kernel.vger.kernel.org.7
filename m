Return-Path: <linux-kernel+bounces-874405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A75C16424
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45090403B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F58834C81D;
	Tue, 28 Oct 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUzm1ReF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63E3491C7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673222; cv=none; b=MgrLjupYFHTjZbHJxOXZHY9fKlbd29jEXNCiSA6J+PRXZ8mOEppbN5+rMjR66EqCYhKG2r4dqAmz8C8lY2vGkqXSMweTuS1vvfQoj3RrwG59vSvUA63PmJ1LJMvq2vROaQUtiVENGxI+zq4jTMUnzeotXEozFCdrJFWPbK7Lams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673222; c=relaxed/simple;
	bh=33wyLUj2QslU96vkFuejtHTWTPXdr1QMfJdUov2O/90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqpJMAqeMYx+lbfNototj31x0/IrTzcRKPZQCqtjTP6drUs941TZznL5OHexH80pxpVoKy2yzCkluAdJtgQ2EYujeBCvx3zjTPJOJ5vVwjXOfLDLzDPBT9fes8J0WvuMbJ4xJ+yNMJBzWxzpidzTNngEMHdAgn8ckseb9vNiZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUzm1ReF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42844985499so723909f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761673219; x=1762278019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=odxA4vuWIg3DU9ItLUgKxGmWSsvINszlMmZ37wf20WU=;
        b=vUzm1ReFES4NbuNQPLP+b0yjTH0belyzbMszNqWp1zIrH7MjBoaCxOaugIqLqT7hOJ
         Itd6ihmT8yQlmfl0B1fUyQv1i7ADKSGFx+Yz5FJ7uYLzaxDP7cv2QaXNcf3JUNSDWMuu
         ALakqhV3nYWEAShyrfxLnxXJDbM5v+nQ1TjGdzvjU5D9Ag4m356OEB5wPh1OOMegHV/i
         0nm7v502htmcyUcIq6R/WB7DckZa+zIoxg3BX50fw4iGkFUvh+YWFYmqjljetsEQJM2H
         oK+JsFkpY+1ZnwqfCw2FmT0CCKnAF+E2vjnhsrlMqoEqBjM3R4nrCO2iIQu22kGJJwZZ
         I4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673219; x=1762278019;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odxA4vuWIg3DU9ItLUgKxGmWSsvINszlMmZ37wf20WU=;
        b=KZ81Gb7vH3acUH8lF6ilE1I6thr3xrzI57e+wcghpD3Knz+40Wuje9lZUP+7wMa4/j
         UB+2jQTQBwG9K76SxiDsoSD59VfL6v+nvdc0Ynd8NDingydTTDyqRVBKWExS5Qj/r3Kx
         Kr9PN8+QUlk+hDKM7v4AfjHFulrjdVVxsa7f0kBPSYVaSFKC0aG8Z1b8GhDxiUCiVATv
         CzUpVp6dHidwL1kf5zwpWUrwZ5nKxTxPteQjn3AxS94n+b4K+BbuOy4EAKB3/fRJezwe
         VArJqqi60O1Q6Z8cwXG3Bwl3sfYwvkMJRkXWIXSCtE4kdJwCIz5eymkTGniJsD5D11Vx
         a/Aw==
X-Gm-Message-State: AOJu0YxRrn4A2FFefOmYWAq7gFoV5jCw6JpdLsRQfMbVlgQBEpv0KRCZ
	vjufdY3Vvvs/iD6iUHKxCks+5ZLK/Sa9O/gfR6TfvS17Y9fDJId8XFs/3tkv76nO98A=
X-Gm-Gg: ASbGncsEL7VrGIj0iWhUhKv9yqGq81nl+u6lSNNhoN3L6auPEFyb9kVQ3pZdoczH7F3
	zsJy9dw0esid3kIqXo483Bp3uzffcH8iTsHSD0IJe8Empbmv0TYsMtZuzw9k9RR13QLjrachSfp
	SNTSBy/odZkyIaFi+Be+zTe9UrEYVoAaVt67lDZh+rD6g8zbymYcp9uGTTr675H4A4qx44gMFqJ
	oSRuQ/NDL34QwlfMgGALS7lnaQ9yN9VCk7uxBg7ImzD5cdr/jvW0Wj3VMt/d1t85qhkEQVaxeIU
	BDAA+zqG4PGUeUS4VPR17gOzwbJNAlCjnhpdCCjSeAuhKwPB9lzaRDUTPkwvseJV4YvsnOCevtH
	cRy9svg7JGDF7z6b/ib9aX1/4/I4/lnY4h9pU07I27f9MxwC2/c3HUyz/bJ9BzIqwhDy+w4u9K4
	ZIyi16pkXhOisaaHaCCzpk
X-Google-Smtp-Source: AGHT+IFy/1xBJegFAcxbIrPalGQnnNGCdCC9xAM0kIXP11B19VVM5aQ7fNW1Qn5qpgJClPtxqFFwIg==
X-Received: by 2002:a05:6000:1a8e:b0:429:8db2:a3eb with SMTP id ffacd0b85a97d-429a7e516c7mr2244140f8f.4.1761673218781;
        Tue, 28 Oct 2025 10:40:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da12dsm21892420f8f.29.2025.10.28.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:40:18 -0700 (PDT)
Message-ID: <3d16d9fd-f1ca-4477-bb92-dd6689a61f9d@linaro.org>
Date: Tue, 28 Oct 2025 18:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: bluetooth: qcom,qca2066-bt: Split to
 separate schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-bluetooth@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Rocky Liao <quic_rjliao@quicinc.com>
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
 <20251028-dt-bindings-qcom-bluetooth-v1-2-524a978e3cda@linaro.org>
 <176167254303.2794634.13957368391979283059.robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <176167254303.2794634.13957368391979283059.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2025 18:29, Rob Herring (Arm) wrote:
> 
> On Tue, 28 Oct 2025 16:31:51 +0100, Krzysztof Kozlowski wrote:
>> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
>> possible properties (19 supplies).  Split common part and
>> qcom,qca2066-bt to separate bindings, so each schema will be easier to
>> read/maintain and list only relevant properties.
>>
>> The existing bindings do not mention interrupts, but
>> am335x-sancloud-bbe-extended-wifi.dts already defines such.  This issue
>> is not being fixed here.
>>
>> Existing binding also did not mention any supplies (which do exist as
>> confirmed in datasheet) and Linux driver does not ask for any, thus keep
>> this state unchanged.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Expected warnings:
>> arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
>> ---
>>  .../net/bluetooth/qcom,bluetooth-common.yaml       | 25 +++++++++++
>>  .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    | 49 ++++++++++++++++++++++
>>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 24 -----------
>>  MAINTAINERS                                        |  1 +
>>  4 files changed, 75 insertions(+), 24 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Lexical error: Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.example.dts:53.42-58 Unexpected 'GPIO_ACTIVE_HIGH'
> Lexical error: Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.example.dts:54.42-58 Unexpected 'GPIO_ACTIVE_HIGH'
> FATAL ERROR: Syntax error parsing input tree
> make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1528: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 


I need to make patchset bisectable.

Best regards,
Krzysztof


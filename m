Return-Path: <linux-kernel+bounces-810229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB1B5177D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9001C84593
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369D31D73B;
	Wed, 10 Sep 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQ9SZMpE"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3431C57E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509151; cv=none; b=Tsnme7CU4hff52ksLqMRfJWwA4FaYDVWYkV7iPE75OJYkl0EUXfY3BkgG8Bb+7oQ9/3WVTMti+vWNT635aCJjbgZWMpO1t4zLSgTVzAT6jCYdhV6gAoF+eSBL/BSWjyUHfECojUCZutKKmfvzlr76XDBOCd4khNDo1pznX/5/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509151; c=relaxed/simple;
	bh=/IAl3c3EYOoYwYw+XjY3kagWIsE4eP8CBIYYAfbZtn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p92I+9KjzUhPbrWhJVTS/dmhglNiAFSIP1QoY4s//Q9WSWriEAVLd0ZRUHH621jvOzMkn3Ropi4SDam/SAWgkFcpucDUmioRQGFRjyeCuo69uYCuFpB6MAnKKjrzJJDRYqC6QWNTdxhZpMQ99gWPH0Pek5HIAV5rKwlxlhLsKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQ9SZMpE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042eb09948so1307864466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757509146; x=1758113946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MB4gaimWoDJk3NhrrABBopa5Fo6F6OnWDi3KrUcJvnA=;
        b=JQ9SZMpEsb/SUDDlJgz2IzBTIYmG1dwNFYDd3EPvv5OOpA9cW45y58zBakr0ZThuk0
         vCJ4mouOrs686mSRSpwv8gUj2o7j0Xy9ImyHl8WMlvDt8ouGdlZRHl2o5p46LeD3G/AY
         5S6jThsvX84LhYUXZdhpZhACT8csSqv6Rcr5qr6dkPgASzhGjWEZ+HB9SdXwlNcwMUIU
         ocb+AaPmkm3XujUARPBu0+7XskWf5sOYbTTpO4ZWwP95tHLHduLE5mJh9QZu8I+KVldH
         b9WnsIIbw2+Nli2bL19clAzenQxrMmtL4OFthZ+hnsdXt7mVdTV/lApdwLY5HHytSWms
         XssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509146; x=1758113946;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB4gaimWoDJk3NhrrABBopa5Fo6F6OnWDi3KrUcJvnA=;
        b=vWf2P5bBf/O1GcgQSpmmIIqfyg9opxeRiE567Ce4jAISpTiTRsw8xT3l9MQsWKcrau
         wPwBFErT9BCb9s2v7eNJLo3TMXEvIpbR5MZKq43VvBaA0r0x2NZvvH8da01RKYsa1cwt
         dJ0Sz3Ob++AYBp3NASQ6ocHHGUQcPCuD6vSj7NgGknrJM31WQY98rUJPTT3keFDz1+LE
         rJsC+K9XC9ZdZ7WQIfPsKgMFItw1qwJYpirSIYAqOiaxSna9L/Ka4TjHDCqaAPUgd6tw
         /VeaJ5dc/dG3o2sUwzZIxdUcnprbvOfx/XXR2EclFFnQ8U04MbOu9rITksBfVQDY47zS
         uazw==
X-Forwarded-Encrypted: i=1; AJvYcCVQfWHq5u5rxg+Cs0hvwZH7RPhrzAfSAIAxt7DboOKzEk0JvfX4iBsYuSBy83+58OLDwQHayLNlWo87JUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeYjjJEiwNCL07o1Wq2no4IshzbMiX8K/VPwbsdTakEDSTsDD
	VsuV624sH9D59Ca2yi+A8XpLRKBklEXWSLhRfsMY9tPHMh1k4f8Q62M0Tl0Seu/ttT0=
X-Gm-Gg: ASbGncsmlU3ur9QsPpxcPgrBs87QM3TSJzsvM/6BKmMetR0Q0Cq7CW/jzuGz/CemZwk
	OLmig1XBvWI/UoTYJRlolVEuvzDFrD/i8adqt38gGMl6miPMvNIM7HWDupPcqg4FkGK3kTW4MZG
	5qrRFN1M9St/Kgty18IbvhLFfwFiC1tDwOu+ReTf0KfpJTKVHNyzV2vzTRxphWMpJwsy9ZWIvDh
	LMg1ZVbXtXKuaIrDCTWd0kQC8YRILMm8/qbfTAW/BmB8zo88mrSwB56vSTkkER5IcAMpbXVzsjq
	LQnqCr4IkRDbdsBg9IjVSV476N9kTsNew9SRGV/sGHFSaLoanhYSob09RGj64jrCtzwauFAGM5D
	dr3C/Twwp7+wgbk+eNWJv/oNhBkmp4J+aomTQtuRx82Y3HuvBL9ULhZJOmQYy1DlZ6gagg18pcV
	77cE7mjB3ybnIpwHPj949in/0nYVdH4inBxso2L+oz
X-Google-Smtp-Source: AGHT+IHo42Ln/UQnJWBf+4snnXCY6UqBRGuJxVk3ykkRWA2Up2JqPWEeup1W5Piw4s3VUCTN4TNccw==
X-Received: by 2002:a17:907:3d90:b0:af9:eace:8a52 with SMTP id a640c23a62f3a-b04b1712177mr1353371566b.50.1757509146401;
        Wed, 10 Sep 2025 05:59:06 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830e613csm164708866b.46.2025.09.10.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:59:05 -0700 (PDT)
Message-ID: <8ea6406e-0312-4ecc-8527-3b3740c4c01c@linaro.org>
Date: Wed, 10 Sep 2025 13:59:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3.1] media: dt-bindings: Add qcom,qcs8300-camss
 compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
References: <20250813053724.232494-2-quic_vikramsa@quicinc.com>
 <20250910104915.1444669-1-quic_vikramsa@quicinc.com>
 <5a087d08-273e-4740-b47d-fc25be952ebd@kernel.org>
 <2a7bd0cd-a6c4-47c3-a6ca-f9d94c9b65ec@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <2a7bd0cd-a6c4-47c3-a6ca-f9d94c9b65ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 13:25, Konrad Dybcio wrote:
> On 9/10/25 1:38 PM, Krzysztof Kozlowski wrote:
>> On 10/09/2025 12:49, Vikram Sharma wrote:
>>> Add the compatible string "qcom,qcs8300-camss" to support the
>>> Camera Subsystem (CAMSS) on the Qualcomm QCS8300 platform.
>>>
>>> The QCS8300 platform provides:
>>> - 2 x VFE (version 690), each with 3 RDI
>>> - 5 x VFE Lite (version 690), each with 6 RDI
>>> - 2 x CSID (version 690)
>>> - 5 x CSID Lite (version 690)
>>> - 3 x CSIPHY (version 690)
>>> - 3 x TPG
>>>
>>> Co-developed-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
>>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets. See also:
>> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830
>>
>> Please version your patches correctly, e.g. use b4 or git format-patch
>> -vX, and add changelog in cover letter or under '---' of individual
>> patches describing changes from previous version.
>>
>> What is v3.1? How to compare it? Try yourself:
> 
> This is a weird invention that some media maintainers seem to promote..
> 
> As a b4 user, I would also like it to stop, as doing anything other than
> v(integer) will open the door for unlimited craziness
> 
> Konrad

This is from me, I asked Vikram for 3.1 instead of a whole new series.

Anyway the fix isn't this patch its 
20250909114241.840842-5-quic_vikramsa@quicinc.com

---
bod


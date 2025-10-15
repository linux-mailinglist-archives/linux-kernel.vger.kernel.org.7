Return-Path: <linux-kernel+bounces-855129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFCEBE0529
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F564279D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3766303A27;
	Wed, 15 Oct 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJG/aXgq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BD27A135
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555547; cv=none; b=BTqs4qsN0TzoUBjAwXFaLapEZvyu1bW+IpV2y4ihQNGYlzQynUtIcMkKonoMw0lW9w6a9Uk60Z/qJS9/UW63gmWSqAfhQzhAtJNxLpyp6aZ+iKTVcCmDZaeERAitBZPrNJzGwVBRDFkytMRRauvqq3IdGqgo8tuUc6Q+NEGBSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555547; c=relaxed/simple;
	bh=4QK2T6kGZyFylzPYSzPxH+9bXfmmQQta6fIUzxi82kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpS/+ccwCMswY9/SxsOUuaJ6NQ+62QpsBzmlOueR37tRtsPlJSsk/TddoRZms4xM4i9aMcWqwFr3KRIEoc5aLELAsG/o2wJdbK49ar4lgql0OgWNA7ahZp8EpVnfHslU20YsKt7QS6jdC9EABM6tU5CpZ1MP3f523/hmPxmLjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJG/aXgq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so65662835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760555544; x=1761160344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX0FQJMNOkesxTSiczvMscK9aHeUEgUhQXWADwrmqhs=;
        b=pJG/aXgqTPZ6GB70+XnOb3h9OZZnIcsS0otLdSaGUVnkmYKNx3qz8fuMEtTm+nec2i
         356bG56xys9klBWxh+4vX/HXlMhSQesz0UeFhRVLfCd86ms8XizN40N8lANcmaQ5cggX
         PWVdsrcL85RtAIW15UT+Xw+fE+JssJhyDjAMydB5o2wcIA8XIeVg8fEhCTYQTG/DmYoU
         RMWyfK43dGV5ApmMTKCg5zZg2q1RR1rjVZG2FMJ1DziiKwmRvEmr4BCFvCEeR1jJ56uq
         GrBOfA0e+EJg+3VQSbQYmQq74bOpbyYcSeh/3e6KTt/KyaEnkEHj5RjdpV4m4F0Pjcqt
         Euvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555544; x=1761160344;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX0FQJMNOkesxTSiczvMscK9aHeUEgUhQXWADwrmqhs=;
        b=Bya0b4W5NZaIDHye6r+WA+vTrYr/zXI6PcMfA4CgPq6QQAI89twh0P5pQmxINX8r+P
         vsk1kmm4qJ8H50VWTSnIa+i8bWafh/nDGY3jGRHVMCB1OBQSdZmfutTY3FA/5BmIAUTR
         UskH75u0hTWMQ7qU5JlSmoQuVLeEu4tEJes9I+S42mNMc4joOjxD7DKIM35alzw/970Y
         PWnKng4Nnu5BIXowVs4E0IzO0yoxGwp0fnMcaMV/l9CgcB/jL41A68wj0I8hdCoTIc2P
         y0SNvngD29z2WZiG5pWxMWgcvGuypA2ipTDfxVrcFGay/jzeC5BscIE/YOvpug5MJtsk
         d5hg==
X-Forwarded-Encrypted: i=1; AJvYcCWsTG3hVC72pZFY3iosDKEbATlOxUhIYNCovHDF+BgZV+c9ZA1+cFVq/V5x1cXMHkT3lupxRR/LyY6nLGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCzwCKYQt52Yj5Bz1AL2zvBIf0IjkVmeLmP3nPsBcSSes7vgd
	20Lh/okKb5cTbjMvn/PDKLGkEr0oj+KWgN3yo8Vpoo8IXEiRnQ6FzfUfAhuHAyNU8Wc=
X-Gm-Gg: ASbGncsmukCASzyX4KbVzJGWDaZw5IJ73uD8vv5z+XhtlutI/BPnmUKEqCUf6DYXLif
	AZIDODsNyxceynPbgmiWgWZF/LPWNopncjUPd+hPoVwddscUtyy8CnzXn0u9envsm1QHRLlckTg
	0Xm8Q/o2tovBXhh9HzA6ZDJSISvjpC/DJwtnJa6RwEecvTXFZFf95TCbwEFoXxYKjwxmBiINEHI
	IhJUo6joh80cR52zTFrKnfffJbojbSAiyeKv8zC/xNp5/SdSaD7AhSttqUs2QK74wBuuxoAp73c
	y+wduHD9faLCpqCVyHLf+23TyT1lpceKnRmXYPVPMUH7eRrIiFBDLchBPJnFE7iEjnYzBSqyAYf
	jzEuu/1LGiMFLZYEwGZeTV0OrthbX2elTXSeHOdHrr/mQvUnNN9AYEUuN2SD8/izTBogK4L121h
	8RXKsu0d6twAG/huCJy6xYhw==
X-Google-Smtp-Source: AGHT+IHbd0cW44W3/gflLhZW99H6UzVn2a320v+osYcGxzgftCt49JmvdlRHRiYyZeC4FCtJAzNpwA==
X-Received: by 2002:a05:600c:6383:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-46fa9a8b48dmr229438345e9.6.1760555543790;
        Wed, 15 Oct 2025 12:12:23 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm32016093f8f.10.2025.10.15.12.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:12:23 -0700 (PDT)
Message-ID: <15b35191-eaff-4971-bae5-2d5a8cb9f864@linaro.org>
Date: Wed, 15 Oct 2025 20:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: media: qcom,qcs8300-camss: Add
 missing power supplies
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
References: <20251015130130.2790829-1-quic_vikramsa@quicinc.com>
 <20251015130130.2790829-2-quic_vikramsa@quicinc.com>
 <bfa0d4f2-45c6-463e-8afc-d90edcf8cf2f@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <bfa0d4f2-45c6-463e-8afc-d90edcf8cf2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2025 19:41, Vladimir Zapolskiy wrote:
> On 10/15/25 16:01, Vikram Sharma wrote:
>> Add support for vdda-phy-supply and vdda-pll-supply in the QCS8300
>> CAMSS binding to reflect camera sensor hardware requirements.
> 
> What are "camera sensor hardware requirements"? You do add properties
> to the ISP.
> 
>>
>> Co-developed-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
>> ---
>>   .../bindings/media/qcom,qcs8300-camss.yaml          | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,qcs8300- 
>> camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcs8300- 
>> camss.yaml
>> index 80a4540a22dc..dce0a1fcb10c 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
>> @@ -120,6 +120,14 @@ properties:
>>       items:
>>         - const: top
>> +  vdda-phy-supply:
>> +    description:
>> +      Phandle to a regulator supply to PHY core block.
> 
> What is "PHY core block" here?

I mean come on, I think the meaning is clear.

>> +
>> +  vdda-pll-supply:
>> +    description:
>> +      Phandle to 1.8V regulator supply to PHY refclk pll block.
> 
> This is a copy-paste example of a known to be wrong pattern.

You're right about the name, please align with this commit

git show cba308979b012664c7fe7c5baa818fcb68e86363

Thanks for spotting.

---
bod


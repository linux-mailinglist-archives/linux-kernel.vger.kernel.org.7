Return-Path: <linux-kernel+bounces-855133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3057EBE058D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECC1C4EFA60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC436305948;
	Wed, 15 Oct 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqrIvfrK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868392FE05A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556022; cv=none; b=F4ZTfm8V3OoHlv4cNjYhFTXP3ggRJpIGmp+WNk3ugdqLTVhaVHQGo+VLjl17QpN97y+CbiGNieyZvOoE5kRraUtTGBUTImeCYcbrOsa1PF80ltC5TNG4PRekGVLyjfNm88YC+kX5D4Lt6TnmKipJsRUqeqGOGRx2NXa0bXTJ4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556022; c=relaxed/simple;
	bh=ep33UcssLfRjc51oBeoQ2Wt7olaU3sFvDFA0ufe3ojQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPgmuU8s+JeMBYUI1yZ9jOFDGNiddCtElR11fTR6z0ai4Ha/zRPX7+kjyLI0hB85BHAjEuTkCtNSEOE+H1ZlXcwG2Ed8pCDjukq/bMrWX6kGMN0kEm7pRNcPm23N5HwDjEcZ1ozfDo+8ffOylAyYNwhQ6WXRYH6V0Rz+dkWkBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqrIvfrK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3776999686dso2312261fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760556018; x=1761160818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mjpeIrj5Li1/mScwEA3BsQSOlfS1kTZ1a40z447tpk=;
        b=WqrIvfrKYrIOmkXaKVY1Tt9rTfwYgyOStVP4PIM/X9UmALCRHu/U38dv0tOB4i2rXC
         pmaQDw21i4k6a5k3ILX4AKFmwTjT439XCEJXVF92x22JvYK7bUx5OWuj3X0NqGtIUwWz
         MbJiDVdK0c2LZRBSctH7FAgXl0voYbTeTpwS34l0pvpbvWWMTVCe7DiGX/+JqRswWnkk
         ZPGGeA0/IICaknPO6sl6+7Ca0ELnQ8fU/eeCypBL4k30+USsnayuEicbd/QtPEke0m7c
         JP5rfDrwN3FyH111P2fJfEbDWuMO0SHhJG375lMzalMbDHUFC9Um2F8Mh2WW/xIEeuRV
         ITPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556018; x=1761160818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mjpeIrj5Li1/mScwEA3BsQSOlfS1kTZ1a40z447tpk=;
        b=X5bsb+ZgyyBrn8QeDckzBL+xRH+16aTdJ+uCLP2vFR3Hz95+IGzaHprpBtjuJKfvxw
         F5KEOJI0+1a0qxgN5N/ygcGoOGYJ8fJa+08H/BpaRHv0dSoD6A2IiZUoyecznBTWVw9G
         kqUwkzYVYOVWCr8ESX2xz2QicAkLOBoqxpLubM16ctASRnfCNuZ3VS0PNP+bjnza8Exc
         Uoc+hXc/m8CRcwxjVamvo5q2HZgpe+mFPJnuk1K/y0IsKI5A5nbN6G+LUX90++eyz4xL
         EkT04gpb2JPqyY3fW0YPbZ5y6B+qNrltzjI+TcT+pGlv1p8/k3v0aECcbXQ8eufVu+5y
         Y3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVDk00dUquuS11twMRp+o8MLTmFy3EMwAc3P6jNCrQNAbQaNG/KprEFc2WCEmnjBMxy3U32jgDF1CdTpF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj+WCuaDGVmK7+DKjpYW56wgrdqGsXMKCYUE/BuctClfZqpn/
	pf73xWl7r5Wr4RGsJJWqh82nxQ1qJl3l+1JzUMWWgrUqEU1K+uvHCxDf3xSeHpRhG9Q=
X-Gm-Gg: ASbGncuICZAB49RHBVd6LtFrSAly9YYY9cFGsYpN/WobS08TRLCSXCGExnqtnHHcMRT
	3YgBpJ0AiZcthXSobj10c7nI/3SyJ8j5zmiMZRHlRTP60sDIqvZtot4CQbVQKrF5KdiwYgpXpBi
	STyKyVUotcOMToBUYfHjtbKt3ZM4MoBp0j9VHjpqogA82HQhfn0dIdpnRFTUXsJf1P/i309e1KX
	BpyNDwXXLkPjsnu+cBuedz4IfhlljixH7FwXtKxopK7uiuDI8GmpMSI6hkxfV/tTJ3TO+kP3Srn
	HWqrg2wGhb7Q2QX6UceTjttc1rjTsuhQUBaDFMJgoAghW0Y/7kK9345fba+dsfh0f+xB095uq4z
	NWuv7kryr3tDhOlyKOSnCThgQ7OeWEtqR60gxl2oqua2t0IpBu9bvBdd6tAt2dXP2/EbOlT8v6E
	T+o+6DZ8VFrvsS5q9cK1pPT3keWyya47l6UQ9hDAa46kAOKhNMnAgHEXvdcBw=
X-Google-Smtp-Source: AGHT+IGIsRWmI5ge5lUIdUu2k73q0laJqSFh/LT9P2c/QCskl/jxZ4XreU8Hx9BrNbAPGj0+NboZdw==
X-Received: by 2002:a05:651c:41d6:b0:377:78cd:e917 with SMTP id 38308e7fff4ca-37778cdeb32mr7411751fa.0.1760556017299;
        Wed, 15 Oct 2025 12:20:17 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762eb6a963sm49042991fa.57.2025.10.15.12.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:20:16 -0700 (PDT)
Message-ID: <4eb4bb48-a8b1-4e58-a41b-b9277fbff6e9@linaro.org>
Date: Wed, 15 Oct 2025 22:20:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: media: qcom,qcs8300-camss: Add
 missing power supplies
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <15b35191-eaff-4971-bae5-2d5a8cb9f864@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <15b35191-eaff-4971-bae5-2d5a8cb9f864@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 22:12, Bryan O'Donoghue wrote:
> On 15/10/2025 19:41, Vladimir Zapolskiy wrote:
>> On 10/15/25 16:01, Vikram Sharma wrote:
>>> Add support for vdda-phy-supply and vdda-pll-supply in the QCS8300
>>> CAMSS binding to reflect camera sensor hardware requirements.
>>
>> What are "camera sensor hardware requirements"? You do add properties
>> to the ISP.
>>
>>>
>>> Co-developed-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
>>> ---
>>>    .../bindings/media/qcom,qcs8300-camss.yaml          | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/qcom,qcs8300-
>>> camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcs8300-
>>> camss.yaml
>>> index 80a4540a22dc..dce0a1fcb10c 100644
>>> --- a/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
>>> +++ b/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
>>> @@ -120,6 +120,14 @@ properties:
>>>        items:
>>>          - const: top
>>> +  vdda-phy-supply:
>>> +    description:
>>> +      Phandle to a regulator supply to PHY core block.
>>
>> What is "PHY core block" here?
> 
> I mean come on, I think the meaning is clear.
> 

The meaning is clear, the expressed concern that the given description
of the property is very unlikely match the meaning, as well as the
description of "PHY refclk pll block" below is the mismatch to the
meaning.

The misleading information shall be removed.

>>> +
>>> +  vdda-pll-supply:
>>> +    description:
>>> +      Phandle to 1.8V regulator supply to PHY refclk pll block.
>>
>> This is a copy-paste example of a known to be wrong pattern.
> 
> You're right about the name, please align with this commit
> 
> git show cba308979b012664c7fe7c5baa818fcb68e86363
> 
> Thanks for spotting.
> 

-- 
Best wishes,
Vladimir


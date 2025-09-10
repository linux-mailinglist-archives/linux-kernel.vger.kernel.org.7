Return-Path: <linux-kernel+bounces-810109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C959B51601
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4E33BF11F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048343164D2;
	Wed, 10 Sep 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxVDaAsh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C630F928
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504516; cv=none; b=bC6R+BrtCJT6ZARCiK1GGYKRGC6rQmyUKdtiKk5s48IwVATO+KmZkdpMHclUPYWV9nSpntbXt7S3+5wpm1bKpIw3c+qaXlGd6KUZoc6mY3RyUluNTB/EX+SrMNgL8SrRhZJWJmopueYkwUV/Si0nBP615nDL44f/gLxXdLZOqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504516; c=relaxed/simple;
	bh=R80lrQS1hQJF0roYzz0DTf0dlLu6IexIel/iumK3y4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCUnJ0eV0Tv+T5BKb/G77x3vCBEnrTMsv1HFTUq94fGUbNnFXVmLmQPLm3YN0gPGU9f6Ava3rKMlfA6+fQSunclnrPvWR1c9YFTyYxSqffvjgS8o7IOp62uTKUknHPX+/SA7Kl7y0daBFJeOvlklxqUs6gofs505Dej2DWFLiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxVDaAsh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so42135665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757504513; x=1758109313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shZJxLtW9iAiaEf/F/KUNA4WoMg1VvumYYY6r6PZJkc=;
        b=NxVDaAshFsgaAK4X7xC9jxYSWMowcAJt7SLKmBRMmhNAQEr1YYAECr02V3Iewd3s2h
         S6X4FWxwRYoTbwwBqfC7M7+nc4QtEHfoE1qDena3ps3yUqC5QMZeNSVakbzDUUxbdUmd
         AHW5VBPcc5wTkG75SFllmTawOnCnrcKf8sPQJwIKgE5w7z8jWurQ3ULvVjTcfubU7ysT
         4ARK2gNFwpwSJo4dOHrTJq4Ch8J5JmKLlVY71tZT23h+Uj69vC5mNavLWLSHxuYp4Bz5
         +LFDsuFnMyQi0Zz9bjJ0AK0T8kBqCYc1TsgYbNVmUYoDCIrNyfKKflltQcHH30G8MX5F
         q02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504513; x=1758109313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shZJxLtW9iAiaEf/F/KUNA4WoMg1VvumYYY6r6PZJkc=;
        b=K37cdcuRjrojAWtwx6idshCNRNoTFvtlm1A/lsQOdpK4G4KM48ZWioIZykjv++1Q9y
         hEZWCXkkRqu5PdpulkrIaNrnOpc/uyIOR6s0EtSGkFEToROqxM1VR7DSVPfVGGvXx4k0
         1FanbsuW/BXE7/jQMqkS03DbjunEZScXtLOuRfIvlyU5o9qhVEtiZt2C/3g2/lQUfHEz
         syOWB3HY7t94HFYspREsrhJxDUY7EQcQVACJNtsR5QVcYhMZmMnKuT+38+cW1r6i4IKp
         uRXJv82sjVXV0ioUNLLLYg0SfLrMuJa+uY67QfKyLXoW+8nPG+mI28gc8B2Dl7ExOqG5
         f/tA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zwoeWUwADL0PHcae5MahMMoTaUMuAEXes8+x44jAj/yfN5QN0tjrMFrEUzAQm5XB1RrzIaAkJD+szKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKw7Vt5bSb6YF7gLq5zSwnfFPfAgmjpyD0ohZJORtY5ekEHMBR
	MPdzq6a/b3BX7jFWlMVgF6bEcmiEFtkiSKFj11nWvadiX2zJCd8C/+z+Vb77WiH/79A=
X-Gm-Gg: ASbGncsNIRcRBuN0yfPWv6P1+4k6ysS2opFyHQuXKnuWqRPHofXBOrujvRAiYD2jSY1
	75b//VrpWXXAw4wsYxmTExtvZsntNauhPPO9b1pVp4GI5SI5mDt+J/bPZsfURhZTSdluzjd3/a/
	V9ewiH/2uAyv801ML28fks89ovyAEeQLVrcJ5FfSQrKz36lYI0uEKY2izAKZ3a/59coS2gigx9G
	ZkumC0reFANHX4rPdcceBa+OXQJKdtnN6fFKhAg446QxorburmVinwi0Xe6fSGDR2jxp2j/c84+
	RDcD9F3xyPbJ+tc1Z0zu3cs48eeMREjvGL2tI8EFpsx/5+/7sxAkNyFcp9dmj7VFclB0IIS7IDA
	I33qDG3vzetjq8M7KyzxtUV4kZ1nnTcE9M1VaAJWfj9r03VQUenSJn4Zfq5cP3h6DHf3VBYBAN6
	zXKt8DLZplk0m0vSDI+W0=
X-Google-Smtp-Source: AGHT+IGlxSt/xs7I3D7ZMakn9Gr+X1/Zuc0c5vvYIA/kLFFFxTaanjZmiqDr4kYOYkKHuiNeNUlj3A==
X-Received: by 2002:a05:600c:4453:b0:45b:9c37:6c92 with SMTP id 5b1f17b1804b1-45dddef02f7mr145102055e9.31.1757504512855;
        Wed, 10 Sep 2025 04:41:52 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8259524sm24547495e9.21.2025.09.10.04.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:41:52 -0700 (PDT)
Message-ID: <61b562ad-eb67-4917-a449-f5556c43ceef@linaro.org>
Date: Wed, 10 Sep 2025 12:41:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dt-bindings: media: camss: Add qcs8300 supplies
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909114241.840842-1-quic_vikramsa@quicinc.com>
 <20250909114241.840842-5-quic_vikramsa@quicinc.com>
 <e4d3c2a3-e395-4f60-8cff-fbb9a1611ec2@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <e4d3c2a3-e395-4f60-8cff-fbb9a1611ec2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 08:02, Krzysztof Kozlowski wrote:
> On 09/09/2025 13:42, Vikram Sharma wrote:
>> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>
>> Add vdda-phy-supply and vdda-pll-supply to the qcom,qcs8300-camss binding.
>>
>> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
>> ---
>>   .../bindings/media/qcom,qcs8300-camss.yaml          | 13 +++++++++++++
> 
> There is no such file. Why are you not fixing the patches on the list?
> 
> 
> Best regards,
> Krzysztof

The easiest thing for me to do here is to take this patch and send out 
another PR.

I can fix the commit log too.

---
bod


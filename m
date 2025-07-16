Return-Path: <linux-kernel+bounces-733449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03CB074CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3719C1C25E68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5222F3C22;
	Wed, 16 Jul 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKsyTiP9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0E1DDC0F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665441; cv=none; b=tSvEkv4wJ+NXKRfS9a7n1TtLl3X5YqjOrCNJUy/nVHoKt/KOozJWpHebs3tvh1H9Lw7wsfU5H7Dtwkv7PIZWvucAz+wOP/cM8xTMOo+0FKwfrt7I0KtD5awqMSVRdqLR7EbSDbsUWwiQlJ5m7onXlgOhRsVNBbPIadaYa77vhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665441; c=relaxed/simple;
	bh=+ECop3VKmF5vBzMl7LnvNjLQmkqlhgXLNF0rFI01PpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1W59AsPdOfxntMMo9m+x1VFXJ58GZKhcXGbZ3iGIRew5bN8JG2yMET4ZIZspTSa6wIhDVVwK2Ql/iC8LJfdtRHWG20uQKM2u7iM6nl6hSckfwrGSpLJ8iew7dksqt6dFwm/aS66tpVtrAGDjKNrg+MaIoZvDcDgGZ04JOOTtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKsyTiP9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so972117a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752665437; x=1753270237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wxt2TkBp//2+Tyvblq5rA5SGBeO4yjsxI6SfU9mxpsM=;
        b=QKsyTiP9c/VRdL886wRva3NvDLET7hBD5Y3snoJVp6htHWEvWMoVjdHZQubcRC5Ags
         CvH9+CRyPKgBckwm1iZR4iGlNAzUhrQuR83mbz/JA97cFji19r9JZ5Z0XpD1mwwAYJWC
         puODNmFZJTCNd6W8TBW6JoWIOdamimnm8Npdd7rqKG1Z0bFRCwXqp+j39XfSkuKXIt8q
         MfGJ0Fg/48C69vJ5IDtzOUWerka2XEPX7NY8ocpKcxbzwPSCYelWZqxArkP7eKENCD9B
         n95iA3/ae4axjdC7udb7NI/cWlaQRNzFy3Ojf35vVUny0LWhorwaLQ94q2uLTtw+selB
         EA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752665437; x=1753270237;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxt2TkBp//2+Tyvblq5rA5SGBeO4yjsxI6SfU9mxpsM=;
        b=RWbhYRqcPZMims1g4D0p/r3JEB9Q4LhXcnOMvU6pDQvEeAMphTHWkVtWuV1TdWtshE
         rqFv9Y5sFw77mhzbaYlL4QDCBGIJ47+zRonfc4TDCg4kgqAdL722zHu7Srq4Qj4fSXLW
         aBqO2DDt0gMMr7K0lgMuqnBORPrnzsSrz3KtXrXin52aVrquB5VRPfmGbXGhMAJyPbyh
         8qbbZZlvIHbqf9N6j6srX1zcVq+IKgyvX2tCu9XZOEsyeLWolx0yKbl3n4tAqklwNI1R
         GOOVFmi0RZ/52Bm0dvsuth2ZjT3bHnnmuB0NEvWX+s51pADDM7tT2/EJyCNDMOmSYDbR
         KAYg==
X-Forwarded-Encrypted: i=1; AJvYcCWEVho61KBPylqvtd8ZmEUyi8nzCx8SaZ2rh9XHWdkxOnLnJbaBjy/2Wvz6DanEejE4g3q1werbVzoxcuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUq6k/bmt0aPA0wcjgZA+nL6qTI9mZ7pgiJbqDO0jfGxeXREp
	2aaAUjDgCkR36bBYqTdjrGzbgc/YYHH0B5aVhwBid11lErE6qs1qWzia4tF3IhtDmj8=
X-Gm-Gg: ASbGnctgVCPnz7P9rYyUr4hXHPcrLxzhcv4sn3IWTRdsemf1J5BUysU4bimK/T7R+xm
	cN8HCPDQ1vnpRaTwlDQlhl6ABfnumNfFpXV0s46WnsRk9KuvoemxCObInvhlwMGEXrPfh116C5M
	JmVQ/UEywm532mJgEl/eKFY4iO28SKC5GWOD7VBO076U7YK8BZ5dA+q1D7JyIBkxuLXLdziUtj7
	FMz9zTf7aPWhpexmDikI7QW5OAC9XmRSzURee3iFex2lH85PJvOkI42NjIQXGvR889XWUXawjOX
	WGfLSjguwCTdTDyFV0pWraqm9Fpk8IAnOFDycL5ogvuZsOK6zvY/0czzlPRHlLdRtBbGc7nRcNg
	y2CuOZKSotoAkmm7lU5N00w2dmrdLe+EdLfyvAKK5BQ==
X-Google-Smtp-Source: AGHT+IGKb/yMmo+6HqAi38Y/JYq4pgPKYjhxTqfALfSBgriOhZiBnQk9t+lWqsa4UOBxEFVK4YE0eQ==
X-Received: by 2002:a17:907:971e:b0:add:fc26:bef7 with SMTP id a640c23a62f3a-ae9c9ae8531mr105371866b.10.1752665436954;
        Wed, 16 Jul 2025 04:30:36 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826469asm1161311966b.85.2025.07.16.04.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 04:30:36 -0700 (PDT)
Message-ID: <0debb9a2-2687-4622-ab05-0a3c276f2482@linaro.org>
Date: Wed, 16 Jul 2025 13:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
 <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
 <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
 <b5a68138-4eca-4bdd-8f72-d80236b02c0a@oss.qualcomm.com>
 <ec0f64c3-bd08-4944-817e-f5f67c317b94@linaro.org>
 <4be1ebb7-1dc7-49e0-aa5d-621f023b3853@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <4be1ebb7-1dc7-49e0-aa5d-621f023b3853@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 12:50, Konrad Dybcio wrote:
>>>>>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
>>>>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>>>
>>>>> This is incomplete, need second power domain and I did not check against
>>>>> qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
>>>>> (maybe some reviews pop up).
>>>>
>>>> Heh, no. The DTS here is correct. The videocc bindings are not correct
>>>> (and that's not my patch).
>>>
>>> Well, you want two power domains here in either case..
>> Are you sure? My point was one is correct and downstream confirms that
>> in their bindings (which is a poor argument, I know). Which one would be
>> the second? MM? We don't have such...
> 
> Historically clock controllers used a pair of CX/MX, with CX powering
> the "meat" and MX powering the PLLs (& retention logic, IIUC).
> Over time, CX was split into multiple usecase-specific domains (like
> GFX), and we now have MMCX (or MM_CX - multimedia CX) for multimedia
> hw specifically
> 
> In the downstream tree you're looking at, sun-regulators.dtsi aliases
> VDD_MMCX_LEVEL as VDD_MM_LEVEL for $reasons, which is admittedly a
> little confusing
> 
> MX has similarly been split into MXA (MX-Always [on]) and MXC
> (MX-Collapsible). For Venus, you want the latter, as the hardware is
> not crucial to the functioning of the SoC (the connection is of course


OK, so the binding is correct - the second entry is the MXC power
domain. I'll fix this in v2. Thanks.


Best regards,
Krzysztof


Return-Path: <linux-kernel+bounces-736689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA34B0A089
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C31AA6CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6A2BCF7C;
	Fri, 18 Jul 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/wWWskB"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82629CB5A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834073; cv=none; b=DYaqe0Ht9vlEI9IPlW3eeImcipSAb1B8Xb1hMrSHKXfm9dauphxnkpg0Zuilud/Al/BUQD95dygSaOtEuB1r801EIGbYjkqlPfr6dtg5mcQ1h0GZetEFqaVPmju0+FkNYuFpbluOW6Lf0eu6EJtraEzmXjaEVguOV0opP/YUdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834073; c=relaxed/simple;
	bh=g0MCGJ7YaYbAjDt3WhSX/LOOkU6F6Pxo7BkKvNMJkvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nl0N86wXKM391/9eHAoLQQtkQI7vi1ZfMSdKdry281bcMsGyu+DqtcryWE8txSqV1DFOP1bh2N/vux6Q/1NMlChjXhis8zkg+qkQX4R/8Iw1O6qIgfSk8TItTe/eRzvEl4GM+27IBzdUv3ianLPQyFHMBmI84rWKIIYMWIoey7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J/wWWskB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso1165968f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752834070; x=1753438870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OAIcBL70630f3jMfmSHdEwCAV/8PODlKAUzq5Lxgf4=;
        b=J/wWWskBzPKPx1yaR7a+bWgJi8A/MIVn7ItK7/YQCis1Xz+EY+YQKZAX0kgMHw/OKO
         jERX7ACjBL0auwz409G0hE/JClq/5/Y8kMUCPU9B5e2E54eXhyXGrXwBfvWoZpoYPfhy
         +YPW/szg4MpecksdbkFdvkKAmZ5GMYYMuVlA4FGplKVfPmg46y4NC2Vr0AlJGn5H9JqJ
         l9Da2T7Xv8UjiNlf9gGKhTausYqcspHyHCZWNnRKShJlg4MyaW+m07P6H/HZzwmOxCgc
         w7DMVzmRNhYzA7NGZMIdtFEsElqijKyHldkztsn1vLf+DIdvpi580AObPJRJt/0RY/4v
         ir0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834070; x=1753438870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OAIcBL70630f3jMfmSHdEwCAV/8PODlKAUzq5Lxgf4=;
        b=pGGlQ4hqAsc27r5BE9TuGNXoPvKuqjwqlmb1UQa8GZrmpFflyixmQTlxj++qF14OH6
         6vDHeK0BZDiCLZfOexF2Sq9pfHlW8/TQkee2G+H7I4snyyP9jry/ZRK1VWghGhHlriWD
         +aseviXrSoeS0G+9uh+C/xTQ+1SyRExy4xFt5LGU3UruGqMHiCfgFLJ7Fj+PvaG4Wq2N
         Kxc8YS/rUvy1f/fs0m7P6A20ui6Q6PGWe2EnFdTiq2eBY5j+Il7pZQr4n20aOlK+/5Ic
         UQpnf0m3VXH/3Iy4jn9DwrQ+1yJgoP/fPiGT8m0mu+RQGn2qPVAd0J7Jom+ACKIsHt+y
         LDWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4YP9d88OqoVuzfkR0zbI1neMEFrGDeq8EdGMwD9jrPpIT+bkx0ZNZpRr5kN6G0z6DTEzm+YxM0Sx51To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvnqo9Akhc187EXQjrEb6aRrwL+RmoiL8QufpA7inyhYd9JVnr
	RdG1oMavGTrGx4eIQybXupW2yLAKicS0umxzE8btgL4sLzNmtE8YP7Wokg/Pfhc4g14=
X-Gm-Gg: ASbGnct3gO3Kqjoi+oEhPgCsLvk5IUIgPTSD+Es3pjUaN21gyzXcdts31XVTtrvVOtQ
	oRH3v2kZZ+AwGbehRqZUYLtAtO3+vRJmHJYsFIM90HJUrn7noVwCA0FXvyGnfsBZWF9/uT/s6pk
	8lamOBzHdCxz0JrD82hzX/GWxx4+3vkYKy7ffAlcNd1xWATgp9DiQ5fht/Vh/gHfiRBogxByZCP
	1/REmnfOXeBg59XnM5fOF8AGpip4KlHHWQERr8VhB25UXx5stThQ5ERQsZxr66aQ7M+Fq45BXlS
	nhdHP6kjdwOHuIsPhkpB505IwisIWDFxw5PE8GsEEKUDSYEq74JVTm7ibcKDYus6MkJoM4WY1Ad
	0qBJ8RxR7RwzbF3GMbQm2oyJXTK4SuBeTI4ftmR8kPiSdYh2RyL+ficxthvvVbCW7I+Di/7RQNu
	A=
X-Google-Smtp-Source: AGHT+IFb4UrEaIgReWQNYtGNnuAGOrUAMETqNaFcLfwK/JPQUJ9ADxpbWpnghscMDuTHhPHpfNW4tw==
X-Received: by 2002:a05:6000:26c9:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b613e983bemr5609226f8f.28.1752834069708;
        Fri, 18 Jul 2025 03:21:09 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b945sm1427254f8f.22.2025.07.18.03.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:21:09 -0700 (PDT)
Message-ID: <1402a52f-639c-4872-a153-b549603c13a7@linaro.org>
Date: Fri, 18 Jul 2025 11:21:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] media: dt-bindings: venus: Add qcm2290 dt schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com, krzk+dt@kernel.org,
 konradybcio@kernel.org, mchehab@kernel.org, andersson@kernel.org,
 conor+dt@kernel.org, amit.kucheria@oss.qualcomm.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-2-jorge.ramirez@oss.qualcomm.com>
 <8a63f517-a443-48e4-9b9c-0c4b362f59f8@linaro.org> <aHiZpnFhhR5O0h97@trex>
 <0bb2867a-393b-46f9-ad6f-1aeee5a3a9d4@kernel.org> <aHjbjw8Z79Xcd/ZJ@trex>
 <aHksJum91s4ZmI56@trex> <5afbaf46-bbb1-47d8-84aa-29b18987564f@kernel.org>
 <18d013e5-352e-457b-ba96-3dd19f1cbaed@oss.qualcomm.com>
 <56d4e911-5bec-458e-acd1-3594a6d8b91d@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <56d4e911-5bec-458e-acd1-3594a6d8b91d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/07/2025 11:04, Krzysztof Kozlowski wrote:
> On 18/07/2025 12:02, Konrad Dybcio wrote:
>> On 7/18/25 8:27 AM, Krzysztof Kozlowski wrote:
>>> On 17/07/2025 19:00, Jorge Ramirez wrote:
>>>> On 17/07/25 13:16:31, Jorge Ramirez wrote:

>>>> Not sure if I’ve shared this before, but following an internal
>>>> discussion, I think it’s worth highlighting a functional dependency in
>>>> the current kernel:
>>>>
>>>>   - the driver only works if the first two IOMMUs in the list — the
>>>> non-secure ones — are placed at the beginning. Reordering them breaks
>>>> functionality, which introduces unexpected fragility.
>>>>
>>>> Regardless, this seems like a valid concern to me — a driver shouldn't
>>>> rely on the order of phandles — and I just wanted to make sure you're
>>>> aware of it before I post a v8 (likely sometime next week or the
>>>> following, as I’ll be taking a short break soon).
>>>
>>>
>>> Hm? Order of lists is strictly defined. That's actually an overlook that
>>> we never do it for iommus, but the core rule stays.
>>
>> (FWIW "items:" is an ordered list, "enum:" is unordered)
> 
> enum is not a list, but enumeration, meaning one item of multiple values.
> 
> Best regards,
> Krzysztof

As Krzysztof says the ordering is strict.

I think the right-thing-to-do is to document in the commit log the 
dependency.

The final three entries are secure entries and the ordering is important.

---
bod


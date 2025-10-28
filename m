Return-Path: <linux-kernel+bounces-873726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6EC1487B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6FB1A68434
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF47329C75;
	Tue, 28 Oct 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2i9Sqhv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC532A3C1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653296; cv=none; b=lw6NP2S4o03jVRIRuKjU4LPFm7FX54O5OYjZ4xVyMoQ9GhgHewuMUZDraphAmsyFhrSJ1uTuZo1n3/0cPCH00P8P4QXjNbouL7N2QAR60I/XtQmbACg61hz9yHlQ+vbHfvnIcNkqIAqDw0eRzMigJPkX4N+nBMIXliJ2gfKrfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653296; c=relaxed/simple;
	bh=FFZIhW7dPQduoS7KNYpmAufTpW86vs1zECIWDOcIxOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3lC//4VDySnxFKM1jdNc7tN8qf4H4TVYHsrFjolJmlk0q+K6H9gqG9uu8Gjviyt6nsl1P+dg+L+og/8lPAH7ExaqzaZoTpY7OPL6YA2J+RoyMEHgya9ysY8fx4sCObl2PRVdKmqm80X6yjzbrD2oW7Q/vVYt7hXmn6BwWXfGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2i9Sqhv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so40653315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761653291; x=1762258091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjjiZbIUuyLAf493CLwJMzPeawzS5Hi7KDfcQ8XqHPU=;
        b=K2i9SqhvhcTFN5t8WVdPFenAzKDJnwsKubl9rZC8x3Htax5UES0T2I6SAZjZy2k4yo
         O4G9ltAZ3OB/iV92UmlooAkR14Fj3hmqb87CAR05EO2Wb3SmOh38eHCy7rqE3YpIzany
         H+sGzx7SITrsa+PpzgXqFnSwb0g+7YYkQhtqDKvWrBdvRbl9FTt23CcdxOxpWuEZWrIl
         ySzV/OzpKWLiaEjkklTX0TIhV9U6CNVK81+yvhMxxSJCKKt3T3QlcgHuPjUjwPjiWM+B
         P0sLoRg39JShhSg0CcnljL4qtJOXUZnVpOV+Fu8vWKOUvTYfdnbGkK5lS3TuZI1aA0Jn
         7anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653291; x=1762258091;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjjiZbIUuyLAf493CLwJMzPeawzS5Hi7KDfcQ8XqHPU=;
        b=UkQzYVLPlvaVaSAQs4b0f3YUsQjn8i+zLYesqp+6OWmgcWtpNhv398tgtPS1aW+awJ
         PTM3M+1hh5ZPhlwT27d49q4INlvzak3IL3w0zWW4DQtMvccmFig0JrvKmOH80VHnZZDs
         cUMKTrV/TkT4m9l/0ceQeAuFFclOFCM1t9BA6ooeGKh11asjA2NxnP4pnxCY001tf2uJ
         G3OwDmfaGMZEgurRQE5ktcHa4qCYWgmdosnm+yWrbsBPcZtmSl811YXw2qiTZyrR7tWT
         rndILm2dJGfF2CZNnojggln1RuFeyR2pTOomEZs3b5NBskrwEr41hblTYdCtrNho8GLz
         lJHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9oQu5I3LBy/+TEWcNxb8OtmwkBtgjefwkRlvabjgzNxPcrxszTbFtRWOkov7a6E6OjOD3Sc420hBVaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYynWylVgA3BuJMAg7YZt92h75eAC5HKoYFVJy5T+uG6BneyLc
	B2n0jiJrFMOGdJ9tUMu4zhOGBgDXndCyxVbdT9PlQzLXlA/dLZIIMLOcOQpbkv4nUG8=
X-Gm-Gg: ASbGncuwbow8EqtYW/m7e6FXnQ49XOMRmV65CeOmc1uy60l2OWrxDmI5P5xalMbGBb4
	xd2iwdSuKcW2xAeuyTOyXr2jHNrVX+OG7SXZjMvgEObZyDEvrO9i38DNFJDJi3d9DyEsqjHHqBX
	HbbIVWbZ7fz4G9JYUHuwkOwx9nfDeE0tNRDyrOvYU7JbTo7yOqDZ9SEd1d7nHTzKEQ8lcyvqZFd
	kYORyjthBOC1I2/SaPqCW9o9zCDoxCdZkBsYH/iFwBKoCIWdByT11cCmBzgOAOBF4LUCFadzoNh
	hlE15Cauj+BBkg0ejDwhH46mTcVGVxjXUy5o6ERlehIkJXuLA7p3bP1sDtvQXmRad48jys8T6zG
	RodgZGX9IMUj48Z+zSgDYfYgTnb+YDE224obYLJ1RL0y38HthQrbmN336loXDY9Y5EQc5ZNG+2d
	epaYdv3wbjWcHfIhE5pGT8KE0ddOG06WeauFtReyqaXA==
X-Google-Smtp-Source: AGHT+IGFpjPN8Cn5YgLMJOAQI6Ro/JGJGzDgKuY2HvqITluVdL/i2A10CTxri2/CVAdNVkSLxXekrg==
X-Received: by 2002:a05:600c:a08b:b0:477:c68:b4da with SMTP id 5b1f17b1804b1-47718176e5amr27234325e9.20.1761653291379;
        Tue, 28 Oct 2025 05:08:11 -0700 (PDT)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a36easm193604505e9.10.2025.10.28.05.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:08:10 -0700 (PDT)
Message-ID: <aaa361f7-6ada-4347-8bc6-3820cfc9feb4@linaro.org>
Date: Tue, 28 Oct 2025 12:08:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: media: camss: Add qcom,sm6350-camss
To: Luca Weiss <luca.weiss@fairphone.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024-sm6350-camss-v1-0-63d626638add@fairphone.com>
 <20251024-sm6350-camss-v1-1-63d626638add@fairphone.com>
 <20251028-defiant-visionary-rottweiler-f97cda@kuoka>
 <DDTUHFIN3IEK.3FY5IS9S73ASO@fairphone.com>
 <0bf4ab2e-9846-4f8b-ad72-e9db6fb7d08e@kernel.org>
 <DDTVUXIIQQUS.2UUJ9BS4JCZ0V@fairphone.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <DDTVUXIIQQUS.2UUJ9BS4JCZ0V@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2025 10:28, Luca Weiss wrote:
>> So that's vdda-pll-supply
> Just noticed, this S5A regulator is the MX power-domain, so we cannot
> add it as vdda-pll-supply.
> 
>  From what I can see, so far no other camss bindings take in an rpmhpd
> power domain, and given it's not referenced in downstream kernel, it
> doesn't look like it's necessary to control it, from camss.
> 
> Maybe it should be added to camcc though? Still not quite sure how
> downstream vdd_class should translate to upstream...
> 
> Thanks for helping with the other points, those are clear.
> 
> Regards
> Luca

Standard practice here is for MX and MMXC in newer parts. MX certain 
pertains to the clock-controller in this case.

---
bod


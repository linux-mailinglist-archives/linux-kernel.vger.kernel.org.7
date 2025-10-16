Return-Path: <linux-kernel+bounces-855708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA4BE20A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887B83B5550
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB912FDC56;
	Thu, 16 Oct 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvuSWFrX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A522F83CC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601266; cv=none; b=OLynm2F7wZhpSt8ASagPoM58ZVzXBzGhlrCxhv90P2V5VjGrxiD5fHRnVF1eF3h+E8ivCIHxuKF83uI+elHhHvYBb0rdZRnJbOydvFzsZJrrBtVV58szscuzfr+vqCbjnrYIyAlffPtMLFI07eEWkWrDOQoHEZUbb3O59QLKJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601266; c=relaxed/simple;
	bh=CfvRVCErtGHXBxkKWgrElBI+QODUT4a0FK4sms8pPYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5K/uCqJPbBF5AUJNL5n06sWjJpXF93tkizT6Wo39I3Ea+QgO6kTXYYuw7qtRcgDTqInn5Ra2wPjw/FPmTxj4OIU+LNvMOQd5OUinWxvrshp3lZOhV5L0mpgQ2VNcSV4OLW+vm5ZYdLKEw3j6zy/FLAzdFoNycpyVEBUipLRS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvuSWFrX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd7f0e2daso71948e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760601263; x=1761206063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmVtWvRHyMhniNi0gQhG72brgXAlVXx/qF66DGWagrQ=;
        b=yvuSWFrXE6/c//r6iPe3nmYPuruGcDQEh/hVuSV76sMAWvB4s2p/+1XOHNnS08yCaT
         TRIgu5DeJ3SUuncJYc+cZaqdl9lhpZVd+A7V1yTSaBH9Mk0bN/LiLRIzu35s0rDqu3GU
         yyDDDutpEz4w0tnKWQNp4Z21ZJs05qbBSi50SJK0SdcEGLbwoxFPwy98qHEypjcjobkq
         qnQDuDmXbYtAXDRKNCe3SQ2ablYRg8Wt+/rL9RsUUP5vPJ8luLIGjOT0MYG+bvE0pt83
         wHzcV5df3zkCFy4N0PPXK0VZrq+1OB2ULg2WXWtsHHGivcoVKzFbF78xrzY51dKdbZYi
         qRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601263; x=1761206063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmVtWvRHyMhniNi0gQhG72brgXAlVXx/qF66DGWagrQ=;
        b=o5BAjcULSCIz+xFvMnCq6zoU5+CZwRO18+gOS7t92+8cd1/A6N2OWGCM7/au/ljM1x
         p4ez7ABFIgW7FdVk3oX2r51Mj8i4w5pjkOlojw78L7rcy3fd3JXf4HmplicS3oQWxUdL
         WpUSNAODF9CRfqhFuLfNipAY6uhq3fIEt0ReIgZjhrunKiiuCetzdsUbahILUOicG9xe
         Q8/2aO1L/v1OdV4DHRmFGb3piPnj7fFlPYP9bahS75Idkeqpwl4hSh2WyvDWDJbU6CiS
         GV0ZaY+GgC0IQN+PFPSMur2EqAho130kj+A9S5QP0Zte/6qxxa3eSiEvrSd7dltas13Q
         rLeA==
X-Forwarded-Encrypted: i=1; AJvYcCVs9sXcwOMN8waihae8SuGWIs9DKuwQQERkIt9VaXvvsEUOsnuRcOGmdttostZVDXzwwSiXM1OIQqfkJ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP35B4lFUypet3Gqqy9XD33oTo5DdzVWeK7tIFroIPySd98spx
	/uYOITPb9xlU0exB9an8Dc7Yv6cm76plNnru2bz2Qw0bh+OZnh5L4DZD8maclXgsX3k=
X-Gm-Gg: ASbGncsroo6MTGfh8G4VEc6EnbEWERk+eWImlygMWKepqLM1buaa/Ii6MU7ZPWJhRd5
	7dDu0QL8rMAU0CHKBA5Eoh8ENrXhP0T8vI6lcXMgshTN2yHzNmkgmIUMjK6wjECqvOX/a1UaH2k
	aK2eRz8OFLA1ZnzurswuiSeEYu0c96jBXhMRMHsZUo4B91GM9pTtyqCXEqd16F/2Wm89/4IGL0r
	WVwOeK2QzgCt7k1mx/w4W+lQ0JopAUDLH/mOMI3qexNek1aqZK9Uy86+AUc7NWn79ILc8TBLYi3
	kV0ICbeNjS8jICRaYYJNFPQBjspz1vxShbUlSBvDnbVGnSHMyaR8SYFoa7G8drFxxUjlk/tDgwX
	Iq49WhyyWmPzkoTrludVMthkH/nvSfg99lZMEQKqA3lff3ZNmjDykqSsCdzJEa4DgQD1pFgneG5
	oX7KSnJnIsABOcVyKylz19vFQziFkiLSdx0/nKqwx0n+5vHTFRIA8DqiNQ6MI=
X-Google-Smtp-Source: AGHT+IHsX/HilH4EoOWx6EsAJ+ylfUI4lAvcSrs8mZEm+Ft9+c6g8wGISR6HPEd0aILkxc47HsTiOQ==
X-Received: by 2002:a05:6512:3d11:b0:579:a9d2:6636 with SMTP id 2adb3069b0e04-5906d87bba2mr5552348e87.1.1760601262815;
        Thu, 16 Oct 2025 00:54:22 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe50csm6904428e87.33.2025.10.16.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:54:22 -0700 (PDT)
Message-ID: <46776a87-8038-42b3-8982-0cf83f8ba1c5@linaro.org>
Date: Thu, 16 Oct 2025 10:54:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
 <e2c43a8c-a9cc-46a1-9ddd-5d6dfc7e917b@linaro.org>
 <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 04:56, Hangxiang Ma wrote:
> On 10/16/2025 3:30 AM, Vladimir Zapolskiy wrote:
> 
>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
>>> of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
>>> aggregated into 'qcom,qcm2290-cci' node.
>>>
>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>> ---
>>>    Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> index 9bc99d736343..0140c423f6f4 100644
>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> @@ -25,6 +25,7 @@ properties:
>>>          - items:
>>>              - enum:
>>> +              - qcom,kaanapali-cci
>>>                  - qcom,qcm2290-cci
>>>                  - qcom,sa8775p-cci
>>>                  - qcom,sc7280-cci
>>> @@ -128,6 +129,7 @@ allOf:
>>>            compatible:
>>>              contains:
>>>                enum:
>>> +              - qcom,kaanapali-cci
>>>                  - qcom,qcm2290-cci
>>>        then:
>>>          properties:
>>> @@ -136,7 +138,9 @@ allOf:
>>>              maxItems: 2
>>>            clock-names:
>>>              items:
>>> -            - const: ahb
>>> +            - enum:
>>> +                - ahb
>>> +                - cam_top_ahb
>>
>> Why is not to give the clock "ahb" name like on QCM2290?
>>
>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>> and name "ahb" is good for both, I believe.
>>
>>>                - const: cci
>>>      - if:
>>>
>>
> 
> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. GCC
> clock domain doesn't manage the AHB clock but CAMCC does. I think it's
> better to create a new and more complete clock name to denote the
> differences between them.

Remember that you do not match the macro value here. Please provide an
explanation why the intorduced "cam_top_ahb" is anyhow better than the
already exisitng "ahb" name, or please stick to the existing name.

-- 
Best wishes,
Vladimir


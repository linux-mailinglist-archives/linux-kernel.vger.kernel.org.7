Return-Path: <linux-kernel+bounces-798536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B9B41F75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BEE682AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411F2FE05B;
	Wed,  3 Sep 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPvTAbyx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3E2F659F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903329; cv=none; b=axQYKldDaC+eCaH1+TFqivQMPrQGVqAU5vV4Edki46P+I1Ec4eo4bFqIcLOi9rFKk8EjiprZcKsiFGL8OYei/6t3v03rgmmzTCPcLsqAl8gYNJbJu6EbpRJDVfKfTz5sGPDafPWQqOHnqLO+SjxcfHLOSQatB/VPqQdpmPDwp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903329; c=relaxed/simple;
	bh=E1Cna2N6t9JI+222gYwxRIEMiszhSQiq7OVsmw0ymsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EagaTxhdZkDw+xR9XI63chENb/fjB2/yxQOwgzBS0KPvfoHERC5fRT5SqHiKWI5NpEFXJlKEYwuTirvYglaUBISsn/B9DzZteDy5ta0Vf/7trKZnG4LQ53HqSnwvGtl8F3vQJETLcSFbR4hTOmTkqbxkYR4Dg7Q3L28R3JqT3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPvTAbyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFIQr011335
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UyKqXw+ysFsFYLn6dUcHiY+1la1eKIWGJlMEPy3Xe1g=; b=KPvTAbyxdOAR12ei
	60xecrPb+TPyiRkSD0snqlxUlWPHcUjFg+H7+9e/NY+3CbtQGIYpB4SUyrivMvXD
	mbVDZrMl/Dyq9FQvNxH/MvuLhT3y7oefheUXcplUlgiNn6ak7+EVxa/2tOlOZRXO
	ieQTIBmI7YCIXXNP+DjYp9sEiLOjzWX1jRccygpo8I6Y4PoMLDIvfOYeaCej4V+L
	fhudvYGhNSJsbiaQ91ibNbCx9SwT/QlKkZhgFn6YBUOtCOty1dL5FmUo7T5NWVMr
	VOg5+1WzMxU0JhTwukeWO0CdxEM0LYz61pn0rqDY9NtNyA6oN9vdTXMlqYPnUGE1
	wdLVhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjkm9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:42:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso669221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903326; x=1757508126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyKqXw+ysFsFYLn6dUcHiY+1la1eKIWGJlMEPy3Xe1g=;
        b=EkuxkthP4wUwR7lj5px+uXc72p29Tq5BuIjx0GU7Wdl996Wfq+acukOEkBmPW1ipL/
         IliYmpkTy6UI0thFs5uRRXy12plow+yCun/nHVR1SYlpJLD6DGo2pI7PosqGqrsBNN3A
         Xm9VspdrjOhE/etgjm2TUVSmXiA80LDNKQl6Kgq00AuLR4iG70HCkct+3mhBBnVteEcT
         HYZM7u1uR1cEKdu1Ob2EF/K+U6JIkpqGt3UTAQY8VhD9EPvFHyeLd/Ivf/F7G4JaepjV
         h7/fWAdnetlZ4u00NxiHR/MlPfuhNqZxd1Gi93mvzI6wXX/0UQw+/Acr6fBMWKvvsCq1
         vlDw==
X-Forwarded-Encrypted: i=1; AJvYcCV0i2+Iq5Y4jdjgwqtP+9ELUpxiP61tocQGmeZA6TdQW5PzQWOD+dvQqxhA4WUlir4gKAUJU8dLjl1N9NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcVwHY2Vko2ZBxV7dfpuAIjGOTImn1x0vC5IqF9iXXsGChxEq
	S1sOljgUgyHfIX/POvlTNypx2s8GEkyE0xevht5AtSoWXDA1JbyDM6vhavxARCJ2xbRZ13uNXo4
	oMkoBWBdJFwIp2VD7+dF7caeubpePoCOPHJ0uh/36qNUtC9xplBONm9naBFJ4EkdXMFk=
X-Gm-Gg: ASbGncsTctuM3QUem3gcYnmgsSKU660aqy1k6dwWprK0ADtVONnVzMAllEN7KfVHL+d
	M8Tdv/zqjZhC+dUHkF5ERZ1nFecs6t9mR2T/DEWEVWwqmwk88gXViDqoY/mfvG8A/yREhEfVB0N
	QRoHBILdT9+IPNGnyigQEpBsqEXDb5hK4OXdf2BASxmjp7fcDH9458HB1py3L0qy8llhTXoNI/O
	en76GAfjILV1qf1fOM5cccqHW2lwWsyZAXCCQfcIx6FNSU5JNs0YNdSJHIDWioZNDJNfUw6PJGs
	giBRGndqPK48P2QmFIQ/n2T0e3SDeWzXaCUa9nwGEOutu+TeZiUQEH5sJwX3L6N8ltsKIvDvsmV
	Ks3rdPU6fByaq0HrVAroYyw==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr147827351cf.2.1756903325650;
        Wed, 03 Sep 2025 05:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWMsoVz20vZMifq7gvXp5WENey2TR6INKN0I9TlYR/V7hgmuniZ60zIFTZtgxCrX1f0kK6Q==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr147827041cf.2.1756903325090;
        Wed, 03 Sep 2025 05:42:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0467f47d4csm173799466b.11.2025.09.03.05.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:42:04 -0700 (PDT)
Message-ID: <3c4751c3-52d5-408e-ae80-df22bcff5d8a@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Georgi Djakov <djakov@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
 <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
 <ac83c453-c24d-4c4d-83bc-9ed13f2f9d1e@kernel.org>
 <7d3e5cf7-4167-4005-ba4b-c1915c254705@oss.qualcomm.com>
 <00f50d92-e4ea-4805-b771-147fa5f5ebe4@kernel.org>
 <249f8109-31b1-4cb8-a5a4-b30c27b2e987@oss.qualcomm.com>
 <6e036d6a-f2d1-43d6-bb35-54467edd7ec9@kernel.org>
 <26e5309e-3705-4d70-a2e7-3f0e9344816b@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <26e5309e-3705-4d70-a2e7-3f0e9344816b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b8379e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=XlH8FPY39J8rQsCe0dUA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 6maehVPWeOuNUxZo_y5tX7OKQcKsvxpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX0KRmMMykyrVu
 1IjNkGMHJyGDgVHvc4lFdtDksEdz5w1kElb9St+fwDXm5/yVHvh8I4yA5XhnDutxsB/cE8vWBJL
 5wV3S232gwXaSdO+/VKmIOIHUVe1Uc0ly09JzYwt5awqNRo6pJxOCSwiejFywplajo1ArOT9yWN
 NYcTv4w02ssuoK3NDWEDx+mevgXQA6uiBZd/wZHu9Jd9PwMIES6BX7QR5r2Jh3JvFep/pcpwwV5
 3JHrugky9FHefDfS/zQ53CVu73B3bvXrfUXzxPJMlc7sGHaUsmsDfr4Ub2Bil57rNEyESrvsmpi
 mBh+lCfDZ4Zcsy/oYOmLx8Y0LCmtz0SvTgsbQScW+jV2c3g8LlRoNUtWGrKttBTZFwBOJ8464TZ
 2vm0Ax2U
X-Proofpoint-ORIG-GUID: 6maehVPWeOuNUxZo_y5tX7OKQcKsvxpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 8/28/25 11:59 PM, Georgi Djakov wrote:
> On 8/28/25 9:20 PM, Krzysztof Kozlowski wrote:
>> On 28/08/2025 20:16, Odelu Kukatla wrote:
>>>
>>>>> QoS configuration is essential for managing latency and bandwidth across
>>>>> subsystems such as CPU, GPU, and multimedia engines. Without it, the
>>>>> system may experience performance degradation, especially under
>>>>
>>>> So how was it working for the last 2 years?
>>>>
>>> The system may function normally without this feature. However, enabling
>>
>>
>> Huh? So you agree but keep continuing the discussion?
>>
>> I don't understand what we are discussing in such case, but just to
>> close the topic from my side and be explicit: based on above you cannot
>> break the ABI.
> 
> To be even more specific, if we already have some DT binding without any
> clocks and reg properties, we can't just suddenly change them from now
> on to be "required". But they can still be "optional" and this will not
> break the ABI, right? The old DT is still valid and the QoS will be
> active when the new properties are present and this is handled properly
> by the driver.

Correct and this very approach was used to retrofit QoS onto an even older
sc7280 icc driver.

The icc-rpmh core already ignores QoS configuration if the clocks are not
provided.

Konrad


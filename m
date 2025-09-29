Return-Path: <linux-kernel+bounces-836095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF24BA8C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA187A67E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951B286D4E;
	Mon, 29 Sep 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VV7PQgLg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C212D63EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138882; cv=none; b=al1KqagxpsZYBbOL4EhmBQ2GbtAsV3vVBuHxMdd7fNTeUaire7tNAelBgZ6tVhYqeAemlxz4qk7VT98n/nrJjXr3bBYgxRgpP1OLVJbmm9ElEILI/kkrJpjsj1SjbKdH3GOhFeiwMkg/EyG8ANaBegoEPwWeHkU9zAV1Lj+AJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138882; c=relaxed/simple;
	bh=XEaiSZYGUcaHCJQNcBQ9owyrPFLPILRn44ra83b033o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbNL2BVNc+xm9qtkIfgOhuHq5UmjSxmCSgJJQH8qfRtM/AjglKSSB07IC3THSbKV+orpcgiGq64q4brfvRMA5HowzhyYUg/iCRI+Z4Si5H8fZZbiPbWSDk+TRS36m666aE8mGQ33kDlz4hF3boy4pq+Uc5DY7DZU3gm1ZVC29uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VV7PQgLg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLOH9D012624
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0g50ZIP/+1LSITzGgzIqtGqdXOVUmvuN9/3KIaqoLs=; b=VV7PQgLg+TzEg9sF
	umY8mV7//iJLoQnUwkWk+pxSSXM8HmUabJtfq15djGGUoGop+33UvFyldGKK98ky
	61+djpax2r7jdaMPSLfRmcuBAhdOKAO6oGVkUJwR2/1EzPY2983L/IsziedUJieS
	utOjzTfHyFS2B3JfpGkDtzVb2AaOg7Y1IxKYPhtSknPbn/emuFJSSUz8AD1Sflcs
	HDe9o8tcdBt7w2VB5wEQdoYtPCmh2uiL1f/2qHGHCWYSEuQRYYjixXN7lykq4t8N
	ydG7Ivh2FN/pZNc+XtGmR3yooWnFv3sLjeqws+pLyOVVe+NqaHTbchcZFKtnPcn6
	7mgCkg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fvrh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:41:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681642efd9so34597735ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138878; x=1759743678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0g50ZIP/+1LSITzGgzIqtGqdXOVUmvuN9/3KIaqoLs=;
        b=wemezzhT5uC3z5PHYzeQ6VAPdx0u6uz0k3uYPmykQbG5OLPA85JMpgJkmJLr3lcWYS
         1YXc6VZRZqpML2iS5MLLYI/rgs3jGaXfPTh9+8fi9s/NJxAX3u+4nVW8vyQUO0S/mGS5
         QirNl5nZpuh4++bYx9DaLxV1szLwQegsT+jMEdB912GEiRjYW5lQY8U3IWrd9Ztqd7Wt
         jxoNeZwWn9rfEPROEJBscKMji984ioDp6pd0GXjAjfxaHp/3jfguCObHsMWVML0uIGsJ
         wwYz6PfFkphj6CgXwtLtWjDK4UAKw+eWxngtlNtnr4DNM+s/dXiNiRl3vPV2xusEvJSK
         470w==
X-Forwarded-Encrypted: i=1; AJvYcCULbZRxrjMrt3P9DXtbupE8IiQ8FDgAEt8ykNbSF9FDeFPYkwzhh4FzJCazLGEpD3zWL7nfnyGRmbKzcFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MHR+N5Z3Tgg1QW2JZ57hKH+lsnB8D/M+QIt0kdWJLob9p8kD
	ZzyOv4NJWZoRTRkQG0v8RqAii8KuU3ZWqOuER8FU0vruFu9sRt8vsCf04jFn7JHRHgbCnJ+lccz
	t68BKSVRYHu+mi3e4p/LG8JdNXUJGTu1i4Y7ppvHQZadeGfHYLVYxbt6NtT0Pa4NmSp4=
X-Gm-Gg: ASbGncsQk6fws/42YIfGHZzMUjk8XAZ1QmkdpqnKoxTs5CH9rBaLqHWZ66zbS4LnyRe
	SMuBtBI0etqL8uJ5y4ncy/zW86Iu0UwoBy6q3P52sEVxcwHJa9p20iZ+Z7excCR9qBmdyV/5uVl
	hUWY52lmbEaVv41lHIH+bseSd9Uw7hstaQl9VwEk6/X9yf4rHr6Iqd+MZIv1H+XRviCvxZVedO0
	ha40igZlqfErj346piS3szkfWhPL76uRWTTDodMKzVNPJqW/NdwV+3+0W94+0Qp2AZ1ONYz6mfV
	h4LxHH/fGyXhKGUG304VKKGC41hC6qFKpl9Q9A1VAHZ7XV/7A6Asgrzxd1lafvLqu+6Xyx26Q6O
	eSpUb5I1U+Q03/OdAlXvCyZxyDRDs5uXLhw0=
X-Received: by 2002:a17:903:1209:b0:27c:56af:88ea with SMTP id d9443c01a7336-27ed4a60a90mr138735845ad.60.1759138878273;
        Mon, 29 Sep 2025 02:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX2BDwLAFP5L6LqaHh38rh3/eLF8M2OlCmhN0N94ebznHjZi+EX/zj/NGuCgKmw15fA/eRzw==
X-Received: by 2002:a17:903:1209:b0:27c:56af:88ea with SMTP id d9443c01a7336-27ed4a60a90mr138735595ad.60.1759138877800;
        Mon, 29 Sep 2025 02:41:17 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882140sm122815465ad.70.2025.09.29.02.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:41:17 -0700 (PDT)
Message-ID: <540b1de6-c959-4911-925f-8163f5fa5147@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 17:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali CDSP
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-2-611bf7be8329@oss.qualcomm.com>
 <CAJKOXPc57_0pJ2ZWf2cKSKAcQMc3S_mHKQxJDzWH7t=mgim3CA@mail.gmail.com>
 <5820a9a9-4474-4c4d-905c-0efd9442e5e1@oss.qualcomm.com>
 <o6dzhmlicwiezmxlb5uqitx7e3pjpyuhbjqfumivbdkru42hvn@r4ksfa6m5nd2>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <o6dzhmlicwiezmxlb5uqitx7e3pjpyuhbjqfumivbdkru42hvn@r4ksfa6m5nd2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da543f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=RABRrLoboZg1DbT1noAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX2/D2I69bWp5p
 H8klICcaRlTTxXqkQfR2RocLuDEsCukG4owaZw0Iv9g0xgM/c6FzV0VfU4IGQNbi8WgM847JLto
 00TiLXgqfxFsSsngrQ/sESu3HJWjOJquLv4hSynWRrSl/caY+bQ28VcwKB8jQ7VJkDuRj/hyNrO
 3eTrx+IvTapw4Ic6laRhrjZ9cqhq6mdp40Arqren4ytmVJdPdJ9Ty/HamvEq8HYqimF6cJ4wnzh
 1Slj03BPbqZVYd0FZMeKgaBtROjCQsPx9vtcGCLkq+XTqqL9zxJFv9/zx6BmeIi4cmOco7IqvcB
 7/lNy8g91JmI7TEqNr6OXeyJI/h7JGR7BdrdYM1XsT4fwtnhGi2PE7Rdd1DuSnomsuPrGqyMfpG
 +24IaKHQveGTiVJCPy59EKvjfQMNHA==
X-Proofpoint-GUID: -HV8FQNlZIW2NNoCWjE49ncUZWe8NAV5
X-Proofpoint-ORIG-GUID: -HV8FQNlZIW2NNoCWjE49ncUZWe8NAV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022



On 9/29/2025 5:34 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 29, 2025 at 02:20:54PM +0800, Jingyi Wang wrote:
>>
>>
>> On 9/25/2025 9:48 AM, Krzysztof Kozłowski wrote:
>>> On Thu, 25 Sept 2025 at 08:37, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>>
>>>> Add remote processor PAS loader for Kaanapali CDSP processor, compatible
>>>> with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
>>>> interrupt.
>>>>
>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>> ---
>>>>  .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>> index be9e2a0bc060..031fdf36a66c 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>> @@ -35,6 +35,9 @@ properties:
>>>>        - items:
>>>>            - const: qcom,sm8750-cdsp-pas
>>>>            - const: qcom,sm8650-cdsp-pas
>>>> +      - items:
>>>> +          - const: qcom,kaanapali-cdsp-pas
>>>> +          - const: qcom,sm8550-cdsp-pas
>>>
>>>
>>> This time maybe without HTML:
>>>
>>> This looks wrong. This is not compatible with SM8550.
>>
>> Could you point out what is the difference from your perspecetive?
>> it is the same as SM8550 except for there is one more interrupt,
>> which is also described in this patch.
> 
> I'd second Krzysztof here. Your description points out that it is _not_
> compatible to SM8550.
> 

Here is the binding for sm8750 cdsp. Fallback to sm8650 but describe the
difference in interrupt:
https://lore.kernel.org/all/20250221160036.159557-1-krzysztof.kozlowski@linaro.org/

Thanks,
Jingyi


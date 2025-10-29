Return-Path: <linux-kernel+bounces-875547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF9C194A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 454324E26D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1016324B12;
	Wed, 29 Oct 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TiL73PMh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXiEXvZ0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F24322A22
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727930; cv=none; b=tsi5hxDX5M9DDq5l0xdcHRpucNPKUorHv0v9f9+fVdX/0cLIYkSLVdq8zU81wwTp9IiMDJufG6pV7E8IW5yncoz+HqzEYOPNnYBBURMVzHcxrg+06hBF3bKJVW5cd/KgBvned/8WNwCtypgpIwtWXgspidUEIBElW8Rp7qvnuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727930; c=relaxed/simple;
	bh=QPNHDWEsd2TzuY6wTUgPIRC97muVKDmMY231hqRlHkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNemWs4L1vaS/JAqKzEmxOYQSSoQ9XUMeRia8hwJVozKGKP/LP4NwuOKI9Nz2oV+ito/04LQsjN4TBPhywG4zo9HYIB+0ozx+voXz6QVGhi0XE7EgopaqomG71C+IO5RPEOSp7qFTPfwZXEQN3asDPVUIdDA3JGlyCGSfm/HpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TiL73PMh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eXiEXvZ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uoXl3757463
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	av3l7CgY2QNZB00klVJ5AYC93NCt1x2urffNIO++BXg=; b=TiL73PMhOsIwXPoC
	tHfhxg1xKUhDKFUANgnj7PFK+1hc9FfRAlPBu/orrl47t8MCZRwYUGMI4GyiDN9z
	mo7anCDBWHu4Z/Ycmc3+7icxkDlZAvd0CxYzQJ8XO1C58IYHAzi13klIKSrJ3PXM
	jUy1hugiHMVilb3U1SZnQ2NaaNttFUdOIN3OQo/pq/ejlsxh3hcUUWzrBb1NEeL2
	5zSFwFzAQNST0OwaJEV2GGGIt02xZVBd4Zcjv0L8sRXUZgIWrYm3BRO/j/IIFHY9
	kqCpU8VE2bhOVy/vJQ4dRZBZZfO7lGEiDhhu6VV41jUGUyNuDSJsyDrqdEIKOEBy
	05JQPw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y1vb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7811aa16c6bso1074595b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727925; x=1762332725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av3l7CgY2QNZB00klVJ5AYC93NCt1x2urffNIO++BXg=;
        b=eXiEXvZ0j8SF7Z9zx/cItBPkHQJwLt8c7LySyQA56E4FIRCyvO6yX46cRQjLf+QwRq
         tdqbAdz05wblTzw/WtktNHrTaQhuyjK03bUbnB8gUTS7ifc00/9aafS8W4tlPXpNDFqT
         weI4hkVL/0MqP/uL1VvgvmpQ15wmEd8Bu59be+4d7ERpftE0JMxcIwrteJoqcbN/7YT4
         9nUFgGyjw9Lj9JxqOXb5d01MoDcj+iFic4q4ZKuP5aHiCt31VCuiUEKwg6kFvjgJbxiS
         3e7c+4vHkAZp2gpKe0E26prj1yQMDQmrcLPZwFAzrn4ZoQWKbQALLk/e9cDCcCJil0M8
         mkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727925; x=1762332725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=av3l7CgY2QNZB00klVJ5AYC93NCt1x2urffNIO++BXg=;
        b=K0/ke6m6pwUGhZW1no6UkGc32PMNzqNDNQPWXum9/KjuooZTw0BechY/rfOGUzvREc
         C45FqYxZxgB6FhgcF/0c39qXjBTe+4OHralpzyqB95Y0hbye1tDXZELyr6bPNaTqmBHM
         Cyt1mJ4zGz3O9nPKzUWhdGEA2HEpT/j1Tyx8KGJFc1Z4H01n6BV0PStAeZzIqnmHe/Rf
         AS1RhFz91shfB6zxg9gxkBWQqnf6F/lp0GlwZPtI3Xkos93D1cd4187a4pueGrVl5mWb
         QvP6eQnlUQ1gWSH0OEYpj6OX3tEq3y8Nn1YW2KH4iat8f6PqbL7OXZtKTJmdSyulLgqC
         epQA==
X-Forwarded-Encrypted: i=1; AJvYcCUurMKl2goD9QZ7x8jS07HRu7Lk0csLf8tHoWdGVT/1QkuF7KohPHgh3nk9jb8mJ4Q04tFjxPEhIWPbNWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlLr6YMrE0qiG+AI06/XeIseJ+TRmxCBqYJL7Qf/C9BAxdydA
	B9xbMnMoI/Tn8OwWcXCvk9+255xg1DAjya1H/eMFp+Q32pqecdmtxYmbxXv9e+RYmtFVcyhk6cp
	KUFNiuYo7OPg68ZL4BraRaVd+NDmdRMybT2s/LkRUG5/wmOuOSm9xtDr35dSq6xzAcK8=
X-Gm-Gg: ASbGncu09aaar/WenlTBKDw50dEu7/+oNnvKhG+DwaSR+gOBWFhw8kn9x5wEZ1oS/60
	rRNGPyEN9HqP6lN1K+I5mXfD/XFjeGLPo0AhWBsr6XTll1g68ZXodyO2jhogH5l/ZP3zk7+x23R
	FkSEu04hUiOPxGytkje7HYirYsQRLdxw0LrV286pfEX7+fdIsdsXkAtgvUHQ0Be0JSgloiME/CB
	gcMZ7LLg3nYTmchj+pqXzfxwX3uVwlYRIGO+q6/i/7YEpGWNWzMzhVBNMhe9o1vhHwpPUq4vbn1
	es/DbpkzA3gUiDqV6d8pNmRVB4feMPoNxNxrfNi5zRAmUt0LlmwL/drIrRyYk7u4p/oGiC3d0QL
	jRYaOBhREZdOO1kUYva1JXzUBySaguz0JNTdhcsTHTOGyKa+S+EUsVkPePAORfmRjp91IKA==
X-Received: by 2002:a05:6a00:1ad0:b0:77e:ec80:b3d0 with SMTP id d2e1a72fcca58-7a4e4c1cf59mr1483019b3a.3.1761727925453;
        Wed, 29 Oct 2025 01:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErF2e2GenJryHvPr/6RHFg5TGcrt4MMCyAHRCvS2P23eAMSyzqRgz3/EI9LDiuXTVNF8h7rA==
X-Received: by 2002:a05:6a00:1ad0:b0:77e:ec80:b3d0 with SMTP id d2e1a72fcca58-7a4e4c1cf59mr1482997b3a.3.1761727925015;
        Wed, 29 Oct 2025 01:52:05 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bf4sm14636390b3a.1.2025.10.29.01.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:52:04 -0700 (PDT)
Message-ID: <91b0be4d-9e09-49a2-8794-2ec1f191d03e@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:51:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: display: msm: Add SM6150 DisplayPort
 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-1-c4316975dd0e@oss.qualcomm.com>
 <20251027152647.GA915648-robh@kernel.org>
 <207641b8-c272-46d5-a459-eb720a4b94a6@oss.qualcomm.com>
 <2rvypo4rvvjrtnjow37vfqifbkr7gfra5n6rnrshubtk4nxt2w@uan44zq44iem>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <2rvypo4rvvjrtnjow37vfqifbkr7gfra5n6rnrshubtk4nxt2w@uan44zq44iem>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901d5b7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=RJh-vHJcJB1ee0c-uTEA:9 a=PRpDppDLrCsA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: YQHmxhaSlZtRaZCyrWt2E9aOvvTDWqSO
X-Proofpoint-ORIG-GUID: YQHmxhaSlZtRaZCyrWt2E9aOvvTDWqSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NSBTYWx0ZWRfX6+emGj47rSz4
 INVJax2VmC9IhyLf7RCxSfHD+WDA7g5VYEsMiecXEQjWqKy2qCKQS37F0Fr+y64hsXe20d7DdRQ
 XTVRZV7vtj1Y4EZj/P3zTv5E+voEg954Qbs5ogx6n6SWbra8UfITQYqKGmV+2AfTWqGUbwo1cXc
 gAhrMiEsQPggFgeNTTPZ1BiLRkNcZ4qvkKQL+M+O56gsspWNIuy+OFFdMODWElYk1DBZRxo9uHm
 cCsFp8bkqjF0ymXK3DOaqJS7qJYh37haOf05jveBiOMNLEQXxfm1sMi9rSXlJCZDR/XC9WNEfcs
 HMk6Kv4oOmm3186eRfzMk2NCMWgLZkGYJFPJ8HWprCiPZ1Nur/l1bnP/lawtLVg/y6nZ4XuuG90
 wn1Y/O+DC4CS0KxJigleE0dkb5ocnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290065


On 10/29/2025 3:57 AM, Dmitry Baryshkov wrote:
> On Tue, Oct 28, 2025 at 01:06:52PM +0800, Xiangxu Yin wrote:
>> On 10/27/2025 11:26 PM, Rob Herring wrote:
>>> On Fri, Oct 24, 2025 at 01:21:01PM +0800, Xiangxu Yin wrote:
>>>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>>>> compatible with SM8350. Add the SM6150-specific compatible string and
>>>> update the binding example accordingly.
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml      | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..ba0dea2edea98cee0826cf38b3f33361666e004a 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> @@ -51,6 +51,16 @@ patternProperties:
>>>>        compatible:
>>>>          const: qcom,sm6150-dpu
>>>>  
>>>> +  "^displayport-controller@[0-9a-f]+$":
>>>> +    type: object
>>>> +    additionalProperties: true
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - const: qcom,sm6150-dp
>>>> +          - const: qcom,sm8150-dp
>>>> +          - const: qcom,sm8350-dp
>>> The actual schema will check the order. Here, just:
>>>
>>> compatible:
>>>   contains:
>>>     const: qcom,sm6150-dp
>>
>> My initial plan was to use only `qcom,sm6150-dp` with `contains` as suggested.
>>
>> But when I tried that, CHECK_DTBS schema check failed:
>> ‘displayport-controller@ae90000:compatible: ['qcom,sm6150-dp', 'qcom,sm8150-dp', 'qcom,sm8350-dp'] is too long
>> from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm6150-mdss.yaml’‘
>>
>> So, I have added all.
> Please use properties: compatible: contains: 


Ok, I missed the focus on the 'contains' syntax earlier. will update it in the next version.


>>
>>>> +
>>>>    "^dsi@[0-9a-f]+$":
>>>>      type: object
>>>>      additionalProperties: true
>>>>
>>>> -- 
>>>> 2.34.1
>>>>


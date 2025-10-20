Return-Path: <linux-kernel+bounces-860064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC174BEF39E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013A93A84A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351F2BE7D5;
	Mon, 20 Oct 2025 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdZhdHyj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994E2BDC25
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933604; cv=none; b=uB/j+Oo+gCJLoicHLAJmb08T2nZ7YD7LXUl7Xcqfr1uTImD6I3NEYDlLgL85MEfPIoHn2JhWvkXzHLXYSkN91l6WZC7rv0brQab9jEuCtE9iJ+8eARuvlTwfBqJuQR9/AKV1qyk1LAQOjkaY5rm17TFzf+6ZY1PilMK0kegtlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933604; c=relaxed/simple;
	bh=BZTPncny134Q64moVMUylo+dy5nEYkxcYrHjEvoeM6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeHT7jXvsloLHYq4Cd0XFDK3Rs5360p9bmIE+XcCr8vLhDp3k/eZi+8/CunQ5cMnU0YJ+hrc7AXYVYGAu3iv4HmSk8knFagv8k7TEkfcWjQxO6+S+tDJIijJejBzbUvYEMZfimFOmaaf1MQH+jX+Y0aPkgQxfyDMyhFBpwM+fAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdZhdHyj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLKUM3023441
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WvyGniKNyOGzB9jIWHr/l9yFjxDzJbHTBKbIHX8e61I=; b=RdZhdHyjGyKL7zPm
	3gTUpNGkwXhUDC58bfICpE2BFyZa/iUrGL+9bUXNnDv/7sVbyw4MEVpID805UbCR
	hl2K11gMmrPqsX+6tYpGkMommvclZIHEHBCEwXnY+Z9SiMSDR/xcV8vSdP5w1PKd
	jLZ1a05GAm1+O97hHAWclGldqD2RNhbK9MyG50SrhicHgvujssUL1KJu7Ao6tLoZ
	3aE89EPub5bKB7gL/5vnqi6BpLPAABsS6K9Ced/0cRJDrSFYtQBSPm31KH/bpnkB
	h5Ry5uLHCXlvKw1WCDR+dFUZsu8rNRYoe1du2Q++BgQ+Jisf2jxodFGBXhCYXnWH
	VOd62A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv3j4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:13:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b646768eso4408983a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760933600; x=1761538400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvyGniKNyOGzB9jIWHr/l9yFjxDzJbHTBKbIHX8e61I=;
        b=g32stMpRCM7i94jpPMCOZnIz4N/mWimahguWETAzqi7EkzFxXlzJMYYe8e7+TQqo37
         bmstQaUss5IkObp5CDxzsIrzzIHN8NPnZwfw8CVdvdXFTN9yp+veu4Gicpzkdv+hz5Ov
         gakzwZzCtFL5tWIKjzoZOrGnefxGJwzeoVhtM3EgUHyajL0zfH92FH3fcQspN/ITMpiB
         XQrij9iFIuwZC3a1B8J/XU1Omnqo95BjCN3+C1XT73vQjOU9R9teBRGyM+uacCo2T0Zp
         Zp1GZ5Ur9e9j4b1KGvH2hq8DBwblETYnHEteXb0ehn+pCIG/94t4lfQZ3LJHQLWUC48O
         kTjw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xwHlgTdIrRSBRxP5nyqTM1SAgNtSrnr5HakQuRIhqZkJFrJz/08Q7b4v0JrLuFPVWwHcd2hwQYgxFOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEaRJXEdLWc6YptoCgxbDDuFI9qFLiulTzw/TBcFANcelLJ33
	089bg4lubT+vw0Sa1R0AUHxR6Yi+vngP92V7wPRXYwdjr7FxNUH8j9M6XJpCVI9NQHUB+0VtEyb
	DO8y/uy1ZS35FQaHD5tiNs9t8ngeHUaYn5PdAXLdC84WNJeWxd3QBawhI7K1Tn4w3Exw=
X-Gm-Gg: ASbGnctp151Hd1RqBHmXAp2eHEKO/gJPlsl9G3tRVqn5dt9nCguMccMVF+2tvFLqLtt
	cNsCuC5zV8PFo2vPzA12UmJIpc1V1wAN8Nifq+jM6Vxis7cZQYCy8LXBKdcpmklF8v+SZT8widD
	G6JtqSeBzmVnc7iA6kLqMJzigsqhLDPL8FvI+Yc5c22LJBG4wYBkrzWKecrlArVnrIYHX6lwmCE
	ONt+g6eBa8vBP9LTU6WJhoVxpnbHtzhEgk5oDNlKmWpG1M6vVSfg1n2bC9ylTkGs1OCXMRznSfL
	ea8GifmoCWlZuTjOloljaO3hEYUSF//9385EEeOei+etw9KlxL+dEhdkEvGDInt11W40rrvEA5q
	OfV/btqLCyMeQRAtp/m7tHMcafklclAQA5LJD79jH7cyhNVhpWbb25YyKigplTNZv5JsFzQ==
X-Received: by 2002:a17:90b:4a50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-33bcf90e727mr17568042a91.33.1760933599989;
        Sun, 19 Oct 2025 21:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXrnkvCs+Vl2DFziMrRjV64jYus5Jn/mKHf0OBSgXeMnBzTDn3+nAHRsTlgYulMJ+HlW8Tag==
X-Received: by 2002:a17:90b:4a50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-33bcf90e727mr17568001a91.33.1760933599510;
        Sun, 19 Oct 2025 21:13:19 -0700 (PDT)
Received: from [10.133.33.77] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a228sm6453081a12.4.2025.10.19.21.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 21:13:19 -0700 (PDT)
Message-ID: <22d47da0-4912-4880-8a42-f6d4e61e094c@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 12:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
 <e2c43a8c-a9cc-46a1-9ddd-5d6dfc7e917b@linaro.org>
 <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
 <abc9d825-1e98-4838-9e9c-ca18ba191e11@oss.qualcomm.com>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <abc9d825-1e98-4838-9e9c-ca18ba191e11@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nx5HbBJlWZeQp7JOsmU54hGb_02YfecA
X-Proofpoint-GUID: nx5HbBJlWZeQp7JOsmU54hGb_02YfecA
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f5b6e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=IZI-ILkc106kMjGbKFIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX9b+X7H5e0dYD
 qdJ3qqdq0F4zD4sB1Ahez+6W0vYE49KaVi8/BsvlCTNCoSn+iRE7tdZZR9W3q8cbROPqYglDX0y
 QPA9BMOJpAQMv2WkWFOgdkaX8cFUj+3hu/DdggyfSVa7MY4UG7DGVHszxOeb3NIypq0UmyX9aeh
 ta+xtdedkL8CUK7AxiEFDdyv5cJjEY4MZFgyreuZqzchgj+nCPJNtBpGXNJxvR/9x0EZJFa75L8
 X+tXHzmhohBW0M5vBq8DE8BPVX+GfXSXsFFxl3bHiw7pqLqJxAmiP+hgXutk2Ub2bpbE/W4VFfO
 OWxytCNXaMIG2qdE94VXJ6JAqZYdrmosRSARBXu0WywkLiLMa4aK722rWNwD9cD9PJnKBg/BnLV
 qp2Pun1sn6lxbMtV0s9J2Ap0wh+g0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On 10/16/2025 3:56 PM, Konrad Dybcio wrote:
> On 10/16/25 3:56 AM, Hangxiang Ma wrote:
>> On 10/16/2025 3:30 AM, Vladimir Zapolskiy wrote:
>>
>>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>>> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
>>>> of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
>>>> aggregated into 'qcom,qcm2290-cci' node.
>>>>
>>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> index 9bc99d736343..0140c423f6f4 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> @@ -25,6 +25,7 @@ properties:
>>>>          - items:
>>>>              - enum:
>>>> +              - qcom,kaanapali-cci
>>>>                  - qcom,qcm2290-cci
>>>>                  - qcom,sa8775p-cci
>>>>                  - qcom,sc7280-cci
>>>> @@ -128,6 +129,7 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> +              - qcom,kaanapali-cci
>>>>                  - qcom,qcm2290-cci
>>>>        then:
>>>>          properties:
>>>> @@ -136,7 +138,9 @@ allOf:
>>>>              maxItems: 2
>>>>            clock-names:
>>>>              items:
>>>> -            - const: ahb
>>>> +            - enum:
>>>> +                - ahb
>>>> +                - cam_top_ahb
>>>
>>> Why is not to give the clock "ahb" name like on QCM2290?
>>>
>>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>>> and name "ahb" is good for both, I believe.
>>>
>>>>                - const: cci
>>>>      - if:
>>>>
>>>
>>
>> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. GCC clock domain doesn't manage the AHB clock but CAMCC does. I think it's better to create a new and more complete clock name to denote the differences between them.
> 
> Are there any other "AHB" clocks going to this block?
> 
> If not, then this is more confusing instead
> 
> Konrad

On 10/16/2025 6:40 PM, Krzysztof Kozlowski wrote:
> On 16/10/2025 03:56, Hangxiang Ma wrote:
>>>
>>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>>> and name "ahb" is good for both, I believe.
>>>
>>>>                - const: cci
>>>>      - if:
>>>>
>>>
>>
>> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. GCC
> 
> 
> It seems you do not see the difference between GCC output clock and
> actual clock input so some other block.
> 
> 
> 
> Best regards,
> Krzysztof

No more clocks will be added, at least for KNP. And I acknowledge the 
substance of AHB clock doesn't change. I will update and keep AHB clock 
name the same as QCM2290. Thanks for both of you. @Konrad @Krzysztof

---
Hangxiang



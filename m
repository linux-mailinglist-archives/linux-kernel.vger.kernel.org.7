Return-Path: <linux-kernel+bounces-783923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E890B3345F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3186A1B22ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4D23A58E;
	Mon, 25 Aug 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MAclPqQO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0386344
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090748; cv=none; b=qmq0OJ7l0Bk/O/hcfrgnprV1PLYc2UqGZRL8FL497QsAMGCs4r3OR7SegHn5AKNGRPnBt4U/xwop1lT7gSgvVT2AFJ8FPf2NLDAFTOZDEKbfrIIivikKaycfehmrfFfpxlz2fWXuOBjyNAz6VK7s4yDyzynJbESQnN2hecjxu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090748; c=relaxed/simple;
	bh=5TMb1g85npFy35XP/6ZEqzFaGrqT59x8sgiDs2SLlmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PE41YxydbIQtIwoo8BMhJxHfBRJV3D3tM6nJgKPrQC+ZrKLk2yhsQFKLxjHNfOG8ZpqITWxcDZ1a4bd1zeZhs/jkousoTKUwWsLhuqMlRnI2O7RfW4JstOjG+PSS/k+6vuKiclrHC1AhhQGB0zsRQAftsyC1zMfNM0CFLccAX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MAclPqQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OMdYEp029703
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pla/QjB44tiQOdRaYME4jtbNLH66yKqPkqc6mc3uXLw=; b=MAclPqQOoaCcJrB0
	MOKE/I3Wu2WONO49XLCWibfXhyT4kk7HWz4BDdUXwcZGmJd43vDuIDOhmKOgSMsf
	rTPWw0qJOXmMHpwd8DlFzLdNo0r5HWxU3dafDTZVQWovELV04R1qTw4zGmFCQFTF
	09j0AAB7jUXLCrpoZiXX0KI4Rene+i4EgyvRqmhH6Q7JpYmUw1UntETvexbx9tBn
	gHtYTzrb+Gm9mnUp7IC2WalxkNXkMo82Rezpsiikz0g/1IfMzWMUCxpD0jE1kpEN
	C612To1uFvuNQxkFV/3tbYbV4lgbRFeRgN6BX5E+FdfNikbbyEdUvHUA+B7Ex7l6
	bZLmhQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5be5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:59:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e60221fso7913084b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 19:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090743; x=1756695543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pla/QjB44tiQOdRaYME4jtbNLH66yKqPkqc6mc3uXLw=;
        b=YVHu/0dome5q/3hRbpzdkp9r+LWDY4VGE1i8umRUDa4/l+Si/DiVnfgtqAmwqTclaD
         rFf3Ui/e0nzaEDZ+zwba/mX5AQdKMhJxbSmvlHzjbnV7PfeU4pRQJvtd7UTTIQIWIEQW
         G3c5LT4W4nyxLghUdK/LMeE+H5acK24IeicB1zxGHQwBwQSKKMqgwKFg7xEeVz8+xdwp
         SXCVWzoBIMUOo1oTO9xa9rtEZt+0786mFZ9IcrrFinKf2q2qaHltkWWwWgjqbfLBdlqF
         3K8lq1t6v1BHEXmX0Zytu4BFLvnwbhtVQbI51ECVWUyzbu4RCwy2r/cCyyFsewaQ1EUX
         GC/g==
X-Forwarded-Encrypted: i=1; AJvYcCVJwY/KvZnnbNRs7Wcd+seBzfRkwHyzf2F/ZIGhmcrQElcXwIHebkgyR67QMBrO4ONydmCSfPno6lZsj5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMPzaTVulZwnHGLL5O6kBZ04NCX5P6GSLQYAJZgnE3CiE8Mop
	UNUFexSdzmzJqASNL2b4fzo/o4aDlpwoOadyR7tvhQ6auGhl9QrDGJEkYVgfaTsHdmAO1iP+gdw
	T22yPa2Vm6E8NRhb1DQLtWbHQOktz2etdnbA7zNFJtJW3U+ZdxWMYsglzGNKQ3o/xPXI=
X-Gm-Gg: ASbGncsUGZ8m7CowEaaV9+TwA/ptEKpPJ0N3O/A+Jix4xeyhDkatZSLu0aVjSAGtcr7
	PgYAgqKRaXx7L4+nRVqWJLHWXWf9XKcp999qG0f0g2qfyZjII5Km/umLRVYmJR5OWY/IiJ2/7pG
	J3EHcj+dzrpCq5iY902Nf+YGsxhxSR7ncffHleAcsn/Lxt+08sGxTGzD6g1QuQElRgckQ4YUeAT
	uwtr+sZ3dpw5IHLCrqQ7YtY+qG6+Zq4yLjr96aHjp7ITVKMd62o/rBBtgV7NXqP1L/N5fSP/icJ
	1Dqrg21zKYeZw/4XGw5apBzuGgBGB+RWMjMcXq5o6DK8yELCuJuT/DEhusIZzirbZx/rA4tIN5l
	5TOBqxqtTDBlzrVQi3vJLQmvnfjihHWs=
X-Received: by 2002:a05:6a00:190e:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-7702fa048d1mr14178780b3a.9.1756090743362;
        Sun, 24 Aug 2025 19:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCpI9lwwPj/ghs95Ybuszk8ZhygB0e+mYXnTFXl3eSB1K0RxyvY+gmOa2bAJx/E+5Zx4Bxtw==
X-Received: by 2002:a05:6a00:190e:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-7702fa048d1mr14178751b3a.9.1756090742854;
        Sun, 24 Aug 2025 19:59:02 -0700 (PDT)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704000edeasm5911077b3a.45.2025.08.24.19.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 19:59:02 -0700 (PDT)
Message-ID: <65dfd4c2-37bb-4d99-8753-ce17e17097d2@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 10:58:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
 <20250821-qcs8300_mdss-v8-2-e9be853938f9@oss.qualcomm.com>
 <3ws6xfmmrnjybn4umbbnzjdksqberzuxslz6uxpabtsz2yzyss@jwblshilyx4p>
 <b86a1759-e49f-48b1-833d-fdc37b450f5e@oss.qualcomm.com>
 <ftazymlvq7rtbesx4keuek4avmmjq5cx4clewwpmem6ta7qmti@bn24prgszc2j>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ftazymlvq7rtbesx4keuek4avmmjq5cx4clewwpmem6ta7qmti@bn24prgszc2j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8zEDNNCYoodZ
 PFkmFAIRWD3mvnKWDY4DFFwu3h/JC2zUGblte/5lXyw6em+5cMI0Ptq+ph5SmIaz8NPB4K7m/rr
 fy3oARLLGiA50d+XSBUvFJI6CXDA4+nxLrU8iqB1bLlxMUdvqjH3SmTxPAg/qZqkAe0eVwses2m
 704DmShHixd/aQfjpTX883gxo4ZJull9YFYwl+CqotPEwZsmvraW4tJ3ceDPycXA/iJ3u525DkH
 9bGrYlmihrDtlI7fcei7t1aQJkNYF3GV5n1gwCYsxUlHeOT68ZYzaQEaP5e5HrmwuFYm+s+8LMI
 NhHl0F0+TcIRJDf5LHf48RgIOt6dST3C7EgEcGvdvhflDZpFI+cEdg8+miSv1GrsSSEgZdCK/CV
 oK8e/8xj
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68abd178 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=2PmUQm8wz_2Da7m3RkIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: XE3eomWjobiWIE53BtpR0_6dqwVurVTr
X-Proofpoint-ORIG-GUID: XE3eomWjobiWIE53BtpR0_6dqwVurVTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 2025/8/22 18:34, Dmitry Baryshkov wrote:
> On Fri, Aug 22, 2025 at 11:06:58AM +0800, Yongxing Mou wrote:
>>
>>
>> On 2025/8/21 18:28, Dmitry Baryshkov wrote:
>>> On Thu, Aug 21, 2025 at 11:35:57AM +0800, Yongxing Mou wrote:
>>>> Add compatible string for the DisplayPort controller found on the
>>>> Qualcomm QCS8300 SoC.
>>>>
>>>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>>>> with same base offset as SM8650. It requires new compatible string
>>>> because QCS8300 controller supports 4 MST streams. And 4 MST streams
>>>> support will be enabled as part of MST feature support. Currently, using
>>>> SM8650 data structure to enable SST on QCS8300 in the driver.
>>>
>>> Bindings describe the hardware. There is no point in discussing the
>>> driver here.
>>>
>> Thanks for point it.. "The Qualcomm QCS8300 platform comes with one
>> DisplayPort controller that supports 4 MST streams", do you think this
>> description will more appropriate?, only discusses the DP controller, not
>> referencing the driver or SM8650..
> 
> Yes
> 
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> @@ -18,6 +18,7 @@ properties:
>>>>      compatible:
>>>>        oneOf:
>>>>          - enum:
>>>> +          - qcom,qcs8300-dp
>>>>              - qcom,sa8775p-dp
>>>>              - qcom,sc7180-dp
>>>>              - qcom,sc7280-dp
>>>> @@ -179,6 +180,7 @@ allOf:
>>>>              compatible:
>>>>                contains:
>>>>                  enum:
>>>> +                - qcom,qcs8300-dp
>>>>                    - qcom,sa8775p-dp
>>>>                    - qcom,x1e80100-dp
>>>>          then:
>>>> @@ -217,8 +219,9 @@ allOf:
>>>>              compatible:
>>>>                contains:
>>>>                  enum:
>>>> -                # some of SA8775P DP controllers support 4 streams MST,
>>>> +                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
>>>>                    # others just 2 streams MST
>>>
>>> QCS8300 has only one DP. As such, it doesn't belong to this clause.
>>>
>> Emm,thanks, i got this point. So here need add another clause only work for
>> QCS8300(one DP controller with 4 streams), and i put codes before
>> "# Default to 2 streams MST", is this the correct place?
>>
>> -          # Default to 2 streams MST
>> -          properties:
>> -            clocks:
>> -              minItems: 6
>> -              maxItems: 6
>> +          if:
>> +            properties:
>> +              compatible:
>> +                contains:
>> +                  enum:
>> +                    # QCS8300 only have one DP controllers support 4
> 
> typo, controller.
> 
Got it.
>> streams
>> +                    # MST, no second DP controller.
>> +                    -qcom,qcs8300-dp
> 
> Missing whitespace, drop the "second DP controller" phrase.
> 
Thanks for review and point it , will update next patch.
>> +          then:
>> +            properties:
>> +              clocks:
>> +                minItems: 8
>> +                maxItems: 8
>> +          else:
>> +            # Default to 2 streams MST
>> +            properties:
>> +              clocks:
>> +                minItems: 6
>> +                maxItems: 6
>>>> +                - qcom,qcs8300-dp
>>>>                    - qcom,sa8775p-dp
>>>>          then:
>>>>            properties:
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 



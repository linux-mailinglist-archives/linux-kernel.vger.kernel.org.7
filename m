Return-Path: <linux-kernel+bounces-805602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283FCB48ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2877170211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872662F7442;
	Mon,  8 Sep 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Owp8rU9F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E021C167
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329228; cv=none; b=sxv0N45XpPXE3C6gLJ0HcEjPuuQEPNKKoj7DOdfyBw6XghJCk1XrELTGqUaxwa81m1CZmYPAv3TCOY1IE7BBBaLdDe96neodieaUdAtAxx9mlEDLzqb4fAnNh3ZnvWJeWJZChB4Vf78fKKXhvnEFXl5+ib43LaKVo/PHSRuiYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329228; c=relaxed/simple;
	bh=G/Ba14Phk+5myP3ahXki98RYdzJiFF5Mu8FGZGklI4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCovGXgmMKFnw/9s98VCtmOVVGiDZHYed59+Noj0MC5TYF3QGKm/EBFV1ivQ68MdCoTNRMCwYx1lfERBvsAFlgtifxTEMDeCOGgMqw4633dPMVDjPx16Gin2vAARAHraW2Evc/hJHcHqY98NVZwrTCvJQhxDMTl/n3PjYF5RJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Owp8rU9F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58892tom008905
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 11:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SYd+/4tBi4uRuiBSAgW74S/nrmFmbZ9KidZtEig3lzk=; b=Owp8rU9Fn8ikQEhI
	71aF6aQZEr8vQ0H/3EVViSDOwCFQYIVGwlEn9vyKBKE72WlMg6uRNkO66TtczNVq
	312EV6MBrCSyqCNXnbTp6HLH7jSnQlp6ahrQCYqqGWegrVDr/nFRL6two33iEhur
	h6pzoqvwD/FduGTWCkNKjrs/X0/79cQ5GsTw+Ns1FaTbd04ixEUPDkdHjmZ+yb1H
	jkz+3R2oWOJwPtjLbmBa3/9mnIJfVSpYpXOG94WpNoNRwCxspTxFv7sT/x+hZyvs
	2m0bYgGWEjPi18sqQIgTEHrUjp1PdOJVLpknu9V94k/xdZSuToIljZOayMlmcouX
	geVGMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8vcqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:00:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581953b8so47980705ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329216; x=1757934016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYd+/4tBi4uRuiBSAgW74S/nrmFmbZ9KidZtEig3lzk=;
        b=jKrd2a2b1Gi4xi6TJDPr89RvFyU8eq8GjQZrIIPSI/mxTgS6/Vz5+/WYErLHbN/XCf
         zvXlDMdxmETlWwk6X9C7akH4LuKRSG4YmKXD1Y4hQJWiJn7nU2zFBv3hrOhrFiSeu6NQ
         lToB84xm9mNW+TFO9HriEVZgGvog93luH7VzpYgX5LWKaX5PnsuCjqfpXeOZkrcYfKb+
         u/e/CzAu6fmqrt+YlgXkh585nW8XUYAR1cFwuhgy/pmSr6ccxfhP26djpyJpk1+qJZiM
         yOm5Py4MOxY/LwsK/cAetZxeDd7PL+g3gA/PNU8zFFvMpC0yPfmLmPPiiqMZop3XQ08C
         a/LA==
X-Forwarded-Encrypted: i=1; AJvYcCU8e16uCw+LbuFa8AFhFSLNgI0EElw26WlTjEILpq/DgSajO0zvwZNFoHtqGHDkl890i4Zp2JAXWpwEqo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35TWENickM1p6OTH6NTyZiX24Gxmxelpj3azoDfsfJBwNwzs3
	/lLU0i1Jb7OjuG0lISonSfRPqE12nedSEiX3xtJcaj+6R25a79KP8qJUU2x2kBCAzyaBrH3dH+v
	FUncUYJdqxtVP4eexQrQhomOQXoQAYEXdLkPPE8xW4h26fcx5hQtioFml9EY5EmuqK3I=
X-Gm-Gg: ASbGncu+PIErmdWZoDgAQ0v5RMg6t5bPSCIru432mo3UyhfFrLWMAOXqhXUjrd+tebB
	XapkteBCCD4IVrzI5jfNTCsu4C3PwAJ2oJg8QctYNqhRIJalqhfmLbFv++BU+rJdrWuENfCpZ2s
	O/fLLwysiasnofezhyAIgHKnCcRGWaAnzNi7QySGVq8TTMJ9SUOokSWMipa/+etoRz2JQIMLZtG
	c/4z5yA3LkpgNmNf//dhF8XJSTW7X4aVzh3eUONdgSU280n3gOvy4xhKkbhLLDs+jKirryRz/V8
	41M0460dsjgxhqvDgLpkzGFpbOrPczj4zCQRGuBlZ3nuFBBBVWKDRHgirzVdiaXPYdEflXpzOio
	YhW5AZZ83XoEoavauDFJK1yR02Gu0dsw=
X-Received: by 2002:a17:90b:3fc4:b0:32b:60b2:5fc6 with SMTP id 98e67ed59e1d1-32d43f9568bmr9615694a91.18.1757329215729;
        Mon, 08 Sep 2025 04:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7lI3U3SPCn+R/cTeBjZmrLv2/beqgvDHxI/eyb2oUf8c78PZXedihCbA+yCj1T6jDeNNjYw==
X-Received: by 2002:a17:90b:3fc4:b0:32b:60b2:5fc6 with SMTP id 98e67ed59e1d1-32d43f9568bmr9615630a91.18.1757329215136;
        Mon, 08 Sep 2025 04:00:15 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d89f32ebfsm2430310a91.0.2025.09.08.04.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:00:14 -0700 (PDT)
Message-ID: <c30b4f6c-3871-48c6-8836-a087b5fa80ce@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 19:00:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/6] dt-bindings: display/msm: dp-controller: document
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
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
 <20250904-qcs8300_mdss-v11-2-bc8761964d76@oss.qualcomm.com>
 <p2okyfwfl23bip65koaqezlvhyo3z47bnugojcieuspr37xc7b@s3qwgbqmts4l>
 <d8aaff46-9e3b-4b53-a690-351253753edd@oss.qualcomm.com>
 <jdbwncstextusng5boqg4v5r7krbnjts6f3zgd65cu4rrst7ay@kkod7ihbgfrp>
 <69219cdd-bcca-4673-9a81-084184fda6db@oss.qualcomm.com>
 <pwbmqjspoyj2n7gchyaycxfp7ge46pyvm5dntkk7awkr6pblmi@wun2jdt5iehq>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <pwbmqjspoyj2n7gchyaycxfp7ge46pyvm5dntkk7awkr6pblmi@wun2jdt5iehq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68beb748 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gsM-oFm3a_Sh21p_ijEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: fvSH6ZSt89DHv-oxFRmXB1KjeLvR0vXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX4F1sx5VnugSA
 19pU43tb9akHOwcmqC6IiWfIyMVWFl009ywBJGO3+FIuQJiKaAQwQnGsoFyojmdfAa4vm2Qthem
 xqH3BaaGoOUeQByAw2QeeyA2ZbEJ2DdPYnZ6rQ8Kuf7gvOcg+McvlL9XadDFWRv6PcdLsEYv2lq
 9aosVEGfRCXJqVM+jD/6TN5XQkfqnv7iEZrWeA9fqKJ2FUl7kTkSWVNSpjrilY5fA3YXmokWj+S
 qeRsISTBwafjzQlnF43D9Cnp9FZ6g8cnSZO+Iv8eolXmLFT4ihk+/3l4M9KsXYSFHrJr0jnGBYT
 PV3stMZVNKulMxiDGwWe5ts4uox5p8ByrFNg0YQZIXPDwUZo/MJWZgl75UvtkRB7WhFZG5auVjd
 VGdLfV7p
X-Proofpoint-ORIG-GUID: fvSH6ZSt89DHv-oxFRmXB1KjeLvR0vXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/8/2025 6:04 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 08, 2025 at 05:46:30PM +0800, Yongxing Mou wrote:
>>
>>
>> On 9/5/2025 9:48 PM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 05, 2025 at 10:50:33AM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 9/4/2025 9:43 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Sep 04, 2025 at 03:22:37PM +0800, Yongxing Mou wrote:
>>>>>> Add compatible string for the DisplayPort controller found on the
>>>>>> Qualcomm QCS8300 SoC.
>>>>>>
>>>>>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>>>>>> that supports 4 MST streams.
>>>>>>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../bindings/display/msm/dp-controller.yaml        | 22 ++++++++++++++++++++++
>>>>>>     1 file changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>>> index aeb4e4f36044a0ff1e78ad47b867e232b21df509..ad08fd11588c45698f7e63ecc3218a749fc8ca67 100644
>>>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>>> @@ -18,6 +18,7 @@ properties:
>>>>>>       compatible:
>>>>>>         oneOf:
>>>>>>           - enum:
>>>>>> +          - qcom,qcs8300-dp
>>>>>
>>>>> Can we use fallback to qcom,sa8775p-dp instead of declaring a completely
>>>>> new one?
>>>>>
>>>> I think we can not use fallback to sa8775p, since we don't have DP1
>>>> controller for QCS8300. SA8775P actually have 4 DP controllers (now only 2
>>>> really used). So in the hardware, i think it is different with SA8775P and
>>>> we need a new one.>>             - qcom,sa8775p-dp
>>>
>>> The DP controller is the same as the one present on SA8775P.
>>>
>> Yes, it is same.. I just want to confirm again—even if we only need DP0 for
>> QCS8300, we can also use sa8775p as fallback, right?
> 
> What makes you think that we can't? Let me repharse the question: which
> part of DP controller (single one) on QCS8300 is incompatible with the
> DP controller on SA8775P?
> 
Sure.. got this point.. will update next version.. for the single one , 
they are same...

Thanks.>>
>> static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>>      { .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported
>> = true },
>>      { .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported
>> = true },
>>      { .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported
>> = true },
>>      { .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported
>> = true },
>>      {}
>> };
>> .mst_streams = 4 is suitable for both QCS8300 and SA8775P DP 0 here.
>>
>> Previously, my understanding here was that we might need a new compatible
>> for QCS8300.
>>
>> Thanks~~>>>>              - qcom,sc7180-dp
>>>>>>               - qcom,sc7280-dp
>>>
>>
> 



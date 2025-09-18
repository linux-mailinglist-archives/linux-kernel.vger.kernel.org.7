Return-Path: <linux-kernel+bounces-752823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD5B17B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04A31C24432
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1818FC91;
	Fri,  1 Aug 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tw6ysmaI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EF15DBC1;
	Fri,  1 Aug 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016388; cv=none; b=kllnBPsf1ZoyW0flHN/tQWEWa5lMfP7Q5zbogBFMKSW/HU2k6R+CKNdNYPFX+Ffk5sJFV9kBNkWWAdus5urnA42ViNuOA91TRQFpZfa35U9R0ZMSCgZnbIeGmupjj0GdItjJISnEoDq6Z03JFM5unmH6npBekgkP2bVGFIoh9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016388; c=relaxed/simple;
	bh=Jzj526DrcSKrwV6ABUIyd7+JYkZUnf9gdvGXhU86/ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xk4ABTL7ki08lg5iQG/kcISX4ZtqwubkPZKZ7yBQDkJMgdnkra3a+MNiisIkbADbXWnqjESm7jcRT5lmS5jIJ+VgghlpHocJqY710yjW2v8CjBGJFyWTTNIM/ycm7Xe7fhShlWPvsEDH7O97Un14nPzCgzdLpcOAq1vboCClYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tw6ysmaI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57101qVX025956;
	Fri, 1 Aug 2025 02:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	99SOTHo9KzkOHHoIVboGQvZUkwEbsDlMLdtNdsixKHw=; b=Tw6ysmaI65nQPTWx
	OZiEBv/Jag1W2R1A0iidlwQXR7amT+XUy0RrCpiBrdxgL9QQKiIX6QClUY2ls4wJ
	O5AOi2ee+0YffcIoW5gXpqKt2BgzzOxtJfGnC89KVnq2945RCIDBKrPDUzeiSurB
	EphUyYzdM9e3q6dxkdjgwzPxIO5eIbg62N0OxZrsLeWx4xPgmlAoa96/GyijdC8p
	Y1qUKNzChC51tt4AKsNNCOLQGw6yKftMlvd1OWI3KlmJ0Cf9owXrVFxCT5VjUEYQ
	w9okl0EHVO9TLSd3onyKKHzXjewIL0SyMKoa9inyjmnMspyfLQaWO6g4SjfUPQ58
	joMExg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6r27fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 02:46:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5712k0IC004874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Aug 2025 02:46:00 GMT
Received: from [10.64.68.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 31 Jul
 2025 19:45:53 -0700
Message-ID: <76b1cb9b-c90f-44bf-9d5f-67dcbb93de58@quicinc.com>
Date: Fri, 1 Aug 2025 10:45:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
	<lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang
	<jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
 <20250730-mdssdt_qcs8300-v5-2-bc8ea35bbed6@quicinc.com>
 <yhgdibfxtv3w7t7strxd2ywy7gustrff5tbjtlpeh34m2bkhkm@xosfinmgbkui>
Content-Language: en-US
From: Yongxing Mou <quic_yongmou@quicinc.com>
In-Reply-To: <yhgdibfxtv3w7t7strxd2ywy7gustrff5tbjtlpeh34m2bkhkm@xosfinmgbkui>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyMCBTYWx0ZWRfX/AXFTmMj/jwN
 99dG9jxsSwoeNapsYwwh0U8OqpN630icqHzOc4wAc4T00xU1C0LvxURD9PY527RarfZGD6rVelC
 VJn7FDVF2/UqA2yaYE0uWc8///nDG2EcBd+BQEkoHUqRpDphlk/MmrbejPjEjXBaY9D22Pl02rO
 IBCAvtVB0ETGBj8Ray5UpBMrve5VV3J7kOHSJ+QLlJHvsA6cHlUd6CkcL/1tem4fgkDvjhhndTd
 a5fy93AmgiSfCDwMlzzQpH561iGCCXzc5yMgD7I1nJ/uC3CElYXLetzlXyikI+j+S5FY+e2pUVy
 dQEj2a/S0IyW5FbcTwzk8RVns9TM6QjtjBXWze26bDQ23QiExU6XLc9L2rP7jGgpTtJ8DicM/X1
 Q9g5iY0hTePcNBv6fm7lXq/Kdmw8K5ws2VsZHQiFN8EUefvhfqu8zs63Uy2XUiccLCVWmOAI
X-Proofpoint-ORIG-GUID: -dEovQpLLwY9D2axQ2nY9DHSLSN2nXLP
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=688c2a68 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=6lSX7tRiu8Wn4JZBy2cA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -dEovQpLLwY9D2axQ2nY9DHSLSN2nXLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010020



On 2025/7/31 2:04, Dmitry Baryshkov wrote:
> On Wed, Jul 30, 2025 at 05:42:27PM +0800, Yongxing Mou wrote:
>> Add compatible string for the DisplayPort controller found on the
>> Qualcomm QCS8300 SoC, which uses the same DPU as the SA8775P. While
>> DP0 supports 4 MST streams, DP1 has been removed at the silicon level,
>> so SA8775P/SM8650 cannot be used as fallback compatibles.
> 
> "It uses the same DPU as SA8775P, but we can not use SA8775P's DP
> compatible". There is some logic issue there. Please rewrite to speak
> only about DP.
> 
> Moreover, removing of DP1 should not affect DP0 being compatible or
> incompatible with other platforms.
> 
>>
>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 2893f097df826a5f941fbb754fb4a96a1e410a70..f5930f29c91ec95e9182c7b8ee83c0549c6657cc 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -18,6 +18,7 @@ properties:
>>     compatible:
>>       oneOf:
>>         - enum:
>> +          - qcom,qcs8300-dp
>>             - qcom,sa8775p-dp
>>             - qcom,sc7180-dp
>>             - qcom,sc7280-dp
>> @@ -186,6 +187,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,qcs8300-dp
>>                 - qcom,sa8775p-dp
>>                 - qcom,sc7280-dp
>>                 - qcom,sc8180x-dp
>>
>> -- 
>> 2.34.1
>>
> 
Okay, will update it in next version. thanks~



Return-Path: <linux-kernel+bounces-781010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339FB30C44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D6A1D01907
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59599280337;
	Fri, 22 Aug 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIUevZtk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613127FD4B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832030; cv=none; b=TspmwjZvStJdIrpPHW+kKjDTdylMePrVvWmbbCJIt9DJVn6XM3wjuZBqoVkfiJM58mhAIA/ChSd51/1NGt1mj8DAXeVld3j120fKmJWQL+/V+s3LtWSUtua0W71uW3nPMFVCuWAbNpgjWwweaphn/6X7racbgeCAkxHU0xhnCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832030; c=relaxed/simple;
	bh=97WdkfwvOVNZZO+8fxrh2/H8gWINIPIfJnvZc03/Ou0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJz7VzVrUYdavbQOBsrrABnCiiET9zxu3+TjHQhl2kcCEdxFtlV34ewhurTj6iVxaA4NE0rf3fODxiOxOeytCI7VM58dHhDptTQkvncqhvI7VSvOPEEeTtqFjZ/ydrcj2DdfB6XmuRNumvD1HdJAq+ZX6IggP7TPTugDxs5Xa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIUevZtk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9Lsa010875
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pxpzoua12tLHfrXr6eKWYcgK4UktGakrNy1rHaxMHtU=; b=oIUevZtkPPeTB/UH
	YpJ80T7C80wc+AKIoXrr3blYkurTWLt+PF5mmTnnCJpBZmIO0e4gbKW1haIe2AoE
	YUD/GasEdqcoTsVf2f5bikKExuslSe7NSEDq/+G1UDM0eH/lxRcCEaiwH0xILAud
	eYDLxIqxWvBQE07yTzddOrtblZJ5tjmMaqF4a96by5QoqWtPZqcZqmCRIFJ+0tHu
	ZchrKhfBf5k0q6SMeZHD+RPdw1R3TqgKjrcN24r9h0r/HxxgBg5EuNp4wRo2SbhG
	vxB0H6AxmkbnNZeJdXtONen9a3akJjtGMIOR9TMmaSI20x4aGfom80A/pEmmXOEb
	d357OQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8ddgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:07:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77031d4636aso281943b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832026; x=1756436826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxpzoua12tLHfrXr6eKWYcgK4UktGakrNy1rHaxMHtU=;
        b=V5Y7c36zngVxAkpVi1CDLnxFptdoQj8Udwk1IXUq5J9zfQXLLuZlkVuwyRUkquoMX8
         4+EA8xWhHDxjrkuLcEctU05hhgwh2glzz0KSdCqk4QjDQFcxiLfEyUb7qANiCHQyO9E6
         +3f99+awXcovJzCZsnVbc3afg7bQHBegJuafSMrO+/YJSazyLip8ihuBfL6arATFVvcS
         hJYGwb6auCAKoOCan+LCkOf/9Tj3jIss8Gz6jWQnYqByc5p4KdHyvwxY6GdH9psxm0lD
         dV7YZZzLiRvwM8F57s4IK8Ba6T3sDC2XunwZdJ2cA5pL34IhLjMQHLvbq7JGUN3bVM8r
         x+0A==
X-Forwarded-Encrypted: i=1; AJvYcCV/tAexFW0zLPo/Qi0z5Gku6PRCy8DA30chSpcAZYKtJs2cnlr/JxGMjytclTcNi4Le03czcHE7R0+OWk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wg5T6+QAQw0nX738bHk1rN1ZPuwbl94JYu1yUP6Xd7s2VF9D
	QptJFs7YcNlckVF5HyXlvsjnkSPp/GcSoosiCFOB7FK8A4Gc11Jlri+Zud9YFHC5uM/zJYvaJvN
	Ae3UkhpA6tmy/aKVEe59yO5+l4IGJUbVVaqiXbvlFwNhHKDVtleKA/mFoPqnLawWFLcs=
X-Gm-Gg: ASbGncuL0FcMEX7e7uLy/+lbXfjJdoULiPqaySAVCIVVHuM5sAsy0P2SAvPuvwbJM/v
	5N9D6VMQczg+LK2HxRGvJEk9mrb5z4Vi/YF+rc94LBRVcfcHem76t1rb5elgRg13kJR6NyW2rVD
	bRLJvX4HBnTnLxF3d9b1TyKGWRmiMzAKGd7v2sD3w878ufjTpQAL7jAnKg6WcS6Gi7rdj8/EtK5
	knHi5+gVGGUM47K49m7i3T1r0aYOYXXC1cpPY3fZ/w4XCk0INvm/aQ3jKaY3PYrZSaoZ+hs96U5
	FBGVv1NWdcRZQrVGvdbUb69rImx/EQYAgK6PsvXt1EdoRelQEB+vVtagAIptGCJtTaSC5Y2Vr7a
	WI1eCdzIr3CPUdtJAcoCsGJcCpVaS4Hs=
X-Received: by 2002:a05:6a00:1250:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-770305502d9mr1704502b3a.7.1755832026267;
        Thu, 21 Aug 2025 20:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1JA2VCDcV2+V8VJTmn9OkNnFsSh8CLqRYnXkRkboKjGmu9lPcU6GL20crR8lgOhhfna8V2w==
X-Received: by 2002:a05:6a00:1250:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-770305502d9mr1704457b3a.7.1755832025754;
        Thu, 21 Aug 2025 20:07:05 -0700 (PDT)
Received: from [10.133.33.124] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d54e0cfsm9319484b3a.109.2025.08.21.20.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 20:07:05 -0700 (PDT)
Message-ID: <b86a1759-e49f-48b1-833d-fdc37b450f5e@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 11:06:58 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <3ws6xfmmrnjybn4umbbnzjdksqberzuxslz6uxpabtsz2yzyss@jwblshilyx4p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX+R0julucxVIh
 fkGONTXq/hpHSCeIL2tQYDPPPWzIwDziGIavMzCiDynmMPzahGMoVpOwTuktPvHvP++JxixBv9w
 R7zgc6DxhSgLY9POtxyRE/zsxi+RHPrASdTvZ8EexeYo4w02/lk35vimCJilRl/igDRflgtKrGw
 cZFudvm3CZQGe0mZL9wtaBlc0YWBHUUSBGsqM47TnLK1dUP/pryNfuCyDOUQU2e432eEVZ2Xvmi
 mdHmawn6YRBvtVYe3aNR3Cdnynt14pWyNUy+ON7soTWDdGOz6P70JVUZBWOowRgeqxJEMNVP+AW
 lMtuSt36e14qmYZwAHCfFSPXLPcmJ4e656GRXg4jFod3p5AokNrqO57OyOWhjMT3W8VKabfOfRe
 scoBANJxonJJYtcDOz7YSXMaGlHzAg==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a7dedb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=fJEs4nZSSkEPFCngLhoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: BOyKfMuq381OV--SAn2We4rpzEv0YK5Q
X-Proofpoint-ORIG-GUID: BOyKfMuq381OV--SAn2We4rpzEv0YK5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134



On 2025/8/21 18:28, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 11:35:57AM +0800, Yongxing Mou wrote:
>> Add compatible string for the DisplayPort controller found on the
>> Qualcomm QCS8300 SoC.
>>
>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>> with same base offset as SM8650. It requires new compatible string
>> because QCS8300 controller supports 4 MST streams. And 4 MST streams
>> support will be enabled as part of MST feature support. Currently, using
>> SM8650 data structure to enable SST on QCS8300 in the driver.
> 
> Bindings describe the hardware. There is no point in discussing the
> driver here.
> 
Thanks for point it.. "The Qualcomm QCS8300 platform comes with one 
DisplayPort controller that supports 4 MST streams", do you think this 
description will more appropriate?, only discusses the DP controller, 
not referencing the driver or SM8650..
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
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
>> @@ -179,6 +180,7 @@ allOf:
>>             compatible:
>>               contains:
>>                 enum:
>> +                - qcom,qcs8300-dp
>>                   - qcom,sa8775p-dp
>>                   - qcom,x1e80100-dp
>>         then:
>> @@ -217,8 +219,9 @@ allOf:
>>             compatible:
>>               contains:
>>                 enum:
>> -                # some of SA8775P DP controllers support 4 streams MST,
>> +                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
>>                   # others just 2 streams MST
> 
> QCS8300 has only one DP. As such, it doesn't belong to this clause.
> 
Emm,thanks, i got this point. So here need add another clause only work 
for QCS8300(one DP controller with 4 streams), and i put codes before
"# Default to 2 streams MST", is this the correct place?

-          # Default to 2 streams MST
-          properties:
-            clocks:
-              minItems: 6
-              maxItems: 6
+          if:
+            properties:
+              compatible:
+                contains:
+                  enum:
+                    # QCS8300 only have one DP controllers support 4 
streams
+                    # MST, no second DP controller.
+                    -qcom,qcs8300-dp
+          then:
+            properties:
+              clocks:
+                minItems: 8
+                maxItems: 8
+          else:
+            # Default to 2 streams MST
+            properties:
+              clocks:
+                minItems: 6
+                maxItems: 6
>> +                - qcom,qcs8300-dp
>>                   - qcom,sa8775p-dp
>>         then:
>>           properties:
>>
>> -- 
>> 2.34.1
>>
> 



Return-Path: <linux-kernel+bounces-873047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9FC12E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24EB34E361D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67B259CBB;
	Tue, 28 Oct 2025 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4xIB97U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672691E5724
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628024; cv=none; b=YD97nZtUstOfvNG6ACP9tHq7w7OWBxKT6+D8Im3assuQhSAbp8j1M9v/mzORXcHO5Ki6IVh4oMVKP4zwu868ImGm9kWQAtnsF/ByyuVH5Ql1kKjjQQ1Ufglv3tgwrNYjVJmK7WF7/8UnnK2ZJ9xSUp2aMEBB2htHjtUG7mU5AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628024; c=relaxed/simple;
	bh=7WS0GW5x6SfWasTVXVpP4R8gG91SxqEQc2K3YufypYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5MQlrQ/b2FG3dfMdhtNKMJBTIIBxl0Rvvfxnl3G0iCVnvvDLWUlmxr0TtAmioTFAwTyuq3lEXR7pPcIeKmHdJ8VBHMIhYTQJi5C3yV41uAZOHJ3BbaHIJ68uzRoIbDgr6lT6x2bbQ+juoWJFeX/ec95A6Jllr9wtsdpS1V1iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n4xIB97U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RL1lXs2546590
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZNW1TFGtDAWcNhp/IoE4ZPcy7N00ZT6ylN3xTPhhGE=; b=n4xIB97U2mqcnhkU
	6P5VQ680nYuUHSx4WyZJFu3ysqwpt53eRQ8DrqX3jqRyrNL36EJN+/CDWef59N7X
	Y0JookWEvHRpWEuPjg5mMwYtF3fKZghUYNSmibXPyGBwl6+ByAyess6X+KhSNk8s
	gELQfjF0aR8g0RKNWqrklLqhcvKAgteY0m8Dz6ZOnY7E77yclRr/YuE8ObqddpGC
	jwaM0LYqHwbKvWPtCV7cI5gs9bLpsp+JenjXIX5D1K+8b7uZgomAmIvaFN/QJb7n
	sMS6SrsGu7ejRLHV8lgyC4AVvYSa22bhWO3qBvoRsD1cZbAF2e12v8Y+IQYkWDCA
	x8bh8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2juag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:07:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26b3e727467so24945635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628021; x=1762232821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZNW1TFGtDAWcNhp/IoE4ZPcy7N00ZT6ylN3xTPhhGE=;
        b=p2drVU67XYh7IdrxCSYLuPi/yJhtevV75YoGHs5L2nydnm9rGhWyqicjYRdwa0HlX4
         lAb+F6IN9G933iPsAf+2RK6YgBbMdIQOe46DNuscBmNk+2nir4Mqax78SeLA1CSBcj+s
         /x4WGVWcA6FTaM/Qs0NTjA2r60JKh6wcisAeD28is85yDcsXdkHq7oqtYinc3tOK+vbL
         rMH03qADdlNeyqpHLjJAG+i13WAqmzPqG4Yqf9oQT+SbbXTtsXPt4EIzbECJ3Rf8/PDg
         UOyyY6v4TnyyyOUgT+M30/Z7bYbOqK2hPEsB198RO8XUK+wuhpjrydhdaEjDf55ANHuF
         2g8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Wi7YrRzomkubpu61MfknCJvMFOTYLpi0/Ynd35D/aJuWuzzTEHZuq6y38+Ovmt6O2Upgdi3FuE/W8Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzPm1Yfzvhk5YqnUQfr+n6jVRneWFZYE1y4T6gBK4Nb7gtLe0
	i/Uvf8EIDvbP6R3nxN270CQLQBnt+i0DV9Z5rIWlrLwByc/K4NaM6WQ/NCmV//eej6Ld7HvJVEL
	9WDndYAQFQoP84OmezuwtoIJ1q0RtI8gD2MkqVAFdiTvD8D2uFLhVxBY6Dr/CypDbfQM=
X-Gm-Gg: ASbGncvfoz2IucnKvPjFWlgnQpAgd6jYAEd1FLxSmowVB+zNp5LUuz2Kc1ZK2J9uAGA
	qJuiyGpPLqGLpPZ0n10Ewy0MEIJLfseh1o8QzMbbnfTCcN9kCoSzldsv6rfjafQQFUBQG3Ud5Ym
	ZbWhBgcxMN6j6gDubIRLTUFxj6Rim0NRXsnLUs4aaS+o+ZB5vXF7RuwyTavMDnT+RvTnBakZSnT
	w+B0J4DPHfCMfK/t0f6e+A+P1KQLY+/ZiNIqGYTjNsKOvwDyzTJErWbiV27B+LiGk4OFTXM+QDt
	BD1PyTdEIWvuLOWV4UL/teyy4R/xYfLPFqDrK6hQf605B18Mykw4R6hiAKSkoWkNpuGQZBU0ODP
	lD3TgT8u4xw4aUAGw7S9guxlRauN6ddHBFsuoqtbRV+KFD0wL6J2V8v9Phg==
X-Received: by 2002:a17:903:1905:b0:290:c5c5:57eb with SMTP id d9443c01a7336-294cb37baf2mr13570665ad.3.1761628021340;
        Mon, 27 Oct 2025 22:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHYfyFAfOxSLKOcwg5AGIho0OEXAci87txVeGZ9/S1disJk2HryFaJBGudHTWVhJDhYB5lg==
X-Received: by 2002:a17:903:1905:b0:290:c5c5:57eb with SMTP id d9443c01a7336-294cb37baf2mr13570515ad.3.1761628020813;
        Mon, 27 Oct 2025 22:07:00 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0ac07sm101578395ad.43.2025.10.27.22.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:07:00 -0700 (PDT)
Message-ID: <207641b8-c272-46d5-a459-eb720a4b94a6@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: display: msm: Add SM6150 DisplayPort
 controller
To: Rob Herring <robh@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <20251027152647.GA915648-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NrAREKi01DFP-VJBNs1iZFsu1BCSspGq
X-Proofpoint-GUID: NrAREKi01DFP-VJBNs1iZFsu1BCSspGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA0MyBTYWx0ZWRfX6HgriwNxi5so
 mYSblMnQiSsrlC46GAf19SHTaGpeuePxn8lfrD/Sa2VoBJF/YGkP8diYijJCAR+tnDEXtnnMq8R
 ngaIRo9mL0iLi7rAgRbMDWEM6uX4+S8agZtgIRS8PyHbyykCg1b1armyIB4TGkt3qbK0yfa09Yb
 3MDZgX5J8lQ3xff6rTNexZVtKSiVz7MiIQsHplvFpcq9cpFHYC4YsbeQlkA4GMO8lHX/qtsxoLA
 hFUlIMtY1BqseSrvegpSCTFUk+a19TnSLBaZiAr75KmaKNYtz5no7qQ6CkhGicTcunM5hly7+9U
 JA7aLhq1R4ZLh5qWpIwyi2fsW8BkiFQW46lS572O7qd4garQuSDyxxpMsk0cXjrk8YmMh4fjD+Y
 5+r/t6AQUvSa+Ne0uFkn7xATMHW6YA==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=69004f76 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=z2EatxdDDGNeVA2bIAQA:9 a=PRpDppDLrCsA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280043


On 10/27/2025 11:26 PM, Rob Herring wrote:
> On Fri, Oct 24, 2025 at 01:21:01PM +0800, Xiangxu Yin wrote:
>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>> compatible with SM8350. Add the SM6150-specific compatible string and
>> update the binding example accordingly.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml      | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..ba0dea2edea98cee0826cf38b3f33361666e004a 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> @@ -51,6 +51,16 @@ patternProperties:
>>        compatible:
>>          const: qcom,sm6150-dpu
>>  
>> +  "^displayport-controller@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: qcom,sm6150-dp
>> +          - const: qcom,sm8150-dp
>> +          - const: qcom,sm8350-dp
> The actual schema will check the order. Here, just:
>
> compatible:
>   contains:
>     const: qcom,sm6150-dp


My initial plan was to use only `qcom,sm6150-dp` with `contains` as suggested.

But when I tried that, CHECK_DTBS schema check failed:
‘displayport-controller@ae90000:compatible: ['qcom,sm6150-dp', 'qcom,sm8150-dp', 'qcom,sm8350-dp'] is too long
from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm6150-mdss.yaml’‘

So, I have added all.


>
>> +
>>    "^dsi@[0-9a-f]+$":
>>      type: object
>>      additionalProperties: true
>>
>> -- 
>> 2.34.1
>>


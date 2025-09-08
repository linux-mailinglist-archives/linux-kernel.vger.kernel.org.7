Return-Path: <linux-kernel+bounces-805475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B64B488FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6F4189C17C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12A2F28E5;
	Mon,  8 Sep 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBnME6tb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AD2EDD41
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324802; cv=none; b=FJxcecABD2o1s7JyxE1Tca5MWkvpzT1aFjogCDa74mQ0HpkYu69BkzrMEHxP0xJqPKqb9QjUV3qv+im9CR80ulrIfr7xmfHZ7mcfrWY+BW8pf4ZWVgA7+xHgL+Hw4yOFilj+yiLve60VwsX1UuS7gkWBIuRbZHxn6sRNjcWN2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324802; c=relaxed/simple;
	bh=pGHg4VNgHfwbIUZJAbdaa24YYr9Y8eheo6uGBDgLzXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuyUUlr3TiNc/olLdhaYi7dffMOzco+ts7iPISoAqxwTrvnekFQLDD3mPMtU9HK6kUz7TEd6MRNQmnL/Rh7xcmqi90r/mfKNyulfrZFQ6PgID4vvkyK1s/voaGovZMFH9Y0FlFn8yVOgewx2a/xUwgAVsym47M6dwXr1cSAm3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBnME6tb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889PcL5022793
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 09:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvPrAA/ICa4QmrY/uCAxXkwkNA9kjX32rCYICA7/VoQ=; b=ZBnME6tbpmgqJS24
	yts36ezMywJZSiJ05Bij+jRhb96QIhswlyExTt8qlTXs2mtCIXWZYn1M2YzjT7K1
	YW/9GqPXV6KD+VScR0SFdsF+FIvMvoMCquE2M70rIECWkOB8AyiESgLBRTqcy2V1
	826qZaLVyqJagMATL4e/0WV4S5AiqIj4QnrGZzIOFhnHvyxu8+YB4wk7NiTy8+g2
	E7MmU7QpC3+3vrqR0jcnc0M3oIdlHdAe66EevQy/qMuYba2hdvK0oxYySS0/PwUQ
	7Mej5KTrg0OqfyagH7+U5cuMGSGxW8tVThOPS2PnWyAW6jIPALGjDkA1Tq3RGjPF
	q2gTZQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8v6f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:46:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329e1e3b25bso3884278a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324799; x=1757929599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvPrAA/ICa4QmrY/uCAxXkwkNA9kjX32rCYICA7/VoQ=;
        b=DI5IJ9MEcKwlPGea1iL8kbITnFqpMST14sJoWpyrCEMb0OkDhIm9O0EPr5fYM2juTV
         HnxNIYGYm+1IOs/mDSU0nqkQD2crYzr2Zhmw01NRl6qMko+uwvl5pMzAEU+jeD94/rXW
         kUUBjvJjGz9VhswMdQNWQFhA0+UKo+xcF1w/ckTXnR2tfk9U0xMK86Xmgv/weZaHbWwk
         uwBdO+cIkn8J4cMOgzqvad8psesYucSJM8exInlT69/+JJefJK9Ml6CnCoMlOCtCt8i2
         DW19+2c7XaJ1lu5MVhLXTOJVuTKdDo1M3Ys+JonMdrBeduAgULtWtjP5ObGUn6zWrJ1K
         JERA==
X-Forwarded-Encrypted: i=1; AJvYcCWbwmuzVRE9uWrweEkY4Mtb64BrhJ7RISkGRh3TPcn72x7zXE1tLNTs8WNe5cl0n99FWSgTMJAcH46GX1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4T4EPp0FodICSl45PpRmz/JKN44qZGTEe0tVzNn0aXeN9ll7f
	27JN5RLlWr4DMn4pNH4jjOLGinoHFMPHpQa5lODNkZOz9tXfxZoDrvv+exTerBEVx2Y3znUM9wQ
	j+79YLDL1dZvURxveyqWmlDMzvBhnRxEwRzViMIlkbzbgp0jSBqwl5hZvQ1qdKXL8wdA=
X-Gm-Gg: ASbGnctdbcWmqc/UfsZm/38SJP9NUBJvtC6ycL5yNVZlll8qRVvvYSlC0p4cKV0MDJg
	cg79u5XKvTOn9EECS10TvSCFT4tf6tWtCyC1VRqZhVl8xqAWIzf1+cwpnNbI7Diyob4ZmSLo52O
	jbk8P75UwrmEvnkR4I2F7DAHy511tzYkwxcg70iSHO7wMfn/T1O3pc6eNQ6m4+Le+D4tVvY5RgD
	P0aJVn2OyjkEdi/mgojaWUmrWMv7EkGw1dfD438L8Is/KkhTP975yXQA0/w8CPSNTaizrZjtFKg
	jGAOcyp3ngVxfnyLM1UbJnUoBuuU1kyYU7ujWR7u6VYR8z1pjwZKBXx/adyZdkHfniJNpyPQyUe
	ltkgyRs4+jlZAo3MfS9sOqzKdLJVWAms=
X-Received: by 2002:a17:90b:3e83:b0:32b:dfd4:95c9 with SMTP id 98e67ed59e1d1-32d43f65178mr10004394a91.23.1757324798510;
        Mon, 08 Sep 2025 02:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvfRyf4bycr5BBpSLmxS0G+wazAJl52xcP6+Epg8zF89ELjO/ko4stTzfzCABTT6v+46wN1Q==
X-Received: by 2002:a17:90b:3e83:b0:32b:dfd4:95c9 with SMTP id 98e67ed59e1d1-32d43f65178mr10004361a91.23.1757324798009;
        Mon, 08 Sep 2025 02:46:38 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb7d391casm11944947a12.7.2025.09.08.02.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:46:37 -0700 (PDT)
Message-ID: <69219cdd-bcca-4673-9a81-084184fda6db@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:46:30 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <jdbwncstextusng5boqg4v5r7krbnjts6f3zgd65cu4rrst7ay@kkod7ihbgfrp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bea5ff cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dWyAYXQ4UQf5hrxkvz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: HL_nXR6TEtbftaLbFQ0a_jnzQYK21Loi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXzqEpYIC3Q3RG
 bL8PCdEAKphF/y69u3Xs4r5bx+dz5Q1atZ74K2zi7+ESvHb3hmCgIRiKwEZIop2om71XExP0ylr
 6pkYF8ZL6+5WaFVufG2GOeE4ATtZaYTBK8L4NpiAQQhxvJ2XTiuO0in+CNCURY0nbw7RJ1k+sbF
 NsrFd/G7tNpJGWjWrx6UggwWKyqoB9zOa+yIHf1QVjYhfHwFNGZbcMfpVTxZYgbTrHJxB0GvSG2
 +sZtckW4Xk0dBLkRQUE7S0am4piTeaG0JLA73qwYE3rK5rO/0pPF+cHnI4tLNb7gVEnIxQBH8jY
 TwIQ4vlAxD0VPrPTRnrW1Ricq+5oR7NCMbnNIIqQwV4biZl8gefgFT+dK3Ce/A/Sy2cQa/nIXLs
 c502XDD5
X-Proofpoint-ORIG-GUID: HL_nXR6TEtbftaLbFQ0a_jnzQYK21Loi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/5/2025 9:48 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 10:50:33AM +0800, Yongxing Mou wrote:
>>
>>
>> On 9/4/2025 9:43 PM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 04, 2025 at 03:22:37PM +0800, Yongxing Mou wrote:
>>>> Add compatible string for the DisplayPort controller found on the
>>>> Qualcomm QCS8300 SoC.
>>>>
>>>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>>>> that supports 4 MST streams.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/display/msm/dp-controller.yaml        | 22 ++++++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> index aeb4e4f36044a0ff1e78ad47b867e232b21df509..ad08fd11588c45698f7e63ecc3218a749fc8ca67 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> @@ -18,6 +18,7 @@ properties:
>>>>      compatible:
>>>>        oneOf:
>>>>          - enum:
>>>> +          - qcom,qcs8300-dp
>>>
>>> Can we use fallback to qcom,sa8775p-dp instead of declaring a completely
>>> new one?
>>>
>> I think we can not use fallback to sa8775p, since we don't have DP1
>> controller for QCS8300. SA8775P actually have 4 DP controllers (now only 2
>> really used). So in the hardware, i think it is different with SA8775P and
>> we need a new one.>>             - qcom,sa8775p-dp
> 
> The DP controller is the same as the one present on SA8775P.
> 
Yes, it is same.. I just want to confirm again—even if we only need DP0 
for QCS8300, we can also use sa8775p as fallback, right?

static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
     { .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, 
.wide_bus_supported = true },
     { .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, 
.wide_bus_supported = true },
     { .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, 
.wide_bus_supported = true },
     { .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, 
.wide_bus_supported = true },
     {}
};
.mst_streams = 4 is suitable for both QCS8300 and SA8775P DP 0 here.

Previously, my understanding here was that we might need a new 
compatible for QCS8300.

Thanks~~>>>>              - qcom,sc7180-dp
>>>>              - qcom,sc7280-dp
> 



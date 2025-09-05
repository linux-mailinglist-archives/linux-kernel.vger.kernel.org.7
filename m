Return-Path: <linux-kernel+bounces-801992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAFFB44C86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFFE1C81C94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA12522B5;
	Fri,  5 Sep 2025 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjPWPrKH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8423278D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044567; cv=none; b=fo5Zf9XBMK3ZMnARTrE03SLq4ni6Js+YjMEWBpla5WHbyr5eiVhYX1uTCpAvul0PpgJTT+aQUFG9vDvQDfE/bgL0oJstGJydv74VbDXUg5Nn5Bl2lRO5y4J/GpMqkmYkH+1wsrdIIWJa8qF90TVGMdKiTB+u8P1ohxTCj6UrwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044567; c=relaxed/simple;
	bh=O13uz+xmoRTqczP6OvSnqhbThs7EXaAb45mHS4qAqZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs9/JNxgS13GwaE/Nl6d2McPwrfrbiAQk5mwLoD1yzZG8sVJJg7WvZj2ZoiJmXzCwvcXazz8tjW1wV73vf81Lo2Y0Yyda+N2d0EM2UHOL2MNLGw+Jq7npDp6DlDJkWkQ5XvGwo+hBJlUhsvpxfJa3EsCAflzdSOrLxPxh5W7rBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjPWPrKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IHgkP013584
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 03:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t4U00jwPam/6fp+vB6GN6T1ZOYywfy88ibIe8PM3Pls=; b=BjPWPrKHNdQvvz9l
	nRL1EnBxmFRKejkyw5QKgATkqRSd8qLzreZAqeRTPquaVXtr5BfYdE7H7cotDivg
	rh8Hot41txmFO1PEEmi8iR34CUqg+8oU2t+b6qAwXvSIYAC6GESS7lmxLjIIJUU2
	OQmJ0sACUuqhXDCSc/KzRGdprupmVUtEUXqBOZLaaRTnOSbRRYs4kK+1V4dqn7NT
	EQ1fCy070D5B5Eg77w9MoSj/u+Ibknd8OuJArvaudI1tlEP/ebUg1HRTjyf2ZqBI
	cqse8rt5SPKH8iZybL+A1bh6w47HCplFzgXTh5xQi/XlK5Bcia9LTr5wItWgITzU
	h9AKKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wydnda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:56:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47156acca5so1464222a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044563; x=1757649363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4U00jwPam/6fp+vB6GN6T1ZOYywfy88ibIe8PM3Pls=;
        b=AgGCQSVFML95ndFLkyq7LDs7zPVWTwOQXIeThiKnQFGbWfAZMzJf1fmrk5iAIhOIgb
         u76dBzmG0tX6DlvOSodZe6yaTpqi2TfvQjfLjQ6ju06N5PuDLb1fTGpjUr4HH/glmN4K
         Ap0QfsLWOO9hBOl9KQOL8woGFGquL8VVbWRCKWWKLLc5Ti8DkVpRm1/nH6egBczj2+tH
         l5sx2o082eZhlRgqoUWdxILOdVVdG1psJiiBWMg9421/LplZvXUBK+wpvLZddWPWFfRE
         9Cv7SzZq97Yot/chZ7eDItUCKnt6rX8kV4DkNmOCPvThSt9UKxV4QW0oKD2J006+PA1w
         Lmvg==
X-Forwarded-Encrypted: i=1; AJvYcCUFxWmKPCUqPHDJONXzsunwXa1mdpIYO/Yj5o4z2bxUBbwUvB9Yuz96BC4ginZbPWUnO3emsGEipVzPQPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywri64fVGKCsGVTQTxT62iS4lnxmaFVsnS/xl72uHXf9vhfuui
	TbMZM/C6xQQp5LwVRVE2RZWGa2229t9TCUZOs19BY582GIhQyACnpSOio/WA6o/Cb/0+kIwjYCb
	YyQpZ4hyaDXf9tIGTXajYN9KZE27/iFcDwKlOcvVXRbunOgVJkZFgE/Y2zcGj0pb82fk=
X-Gm-Gg: ASbGncsDYegoeurUC6HeP+YPjjq9GPCh0SRz0Esl/OcbxJhTb/K1b6cHeYpBmfW6EiH
	rT2jg8DUcr0Q/KcWdvCjj8E08wYZTJbr+asp6/watjx2AdbPOBTie05LJuL3KJqUErucQDrnnrg
	uIz8bhKh/DR+yzTkBTmxBtJfeX2W7kqag9JXHZjsKNemWP57+q5Ekq5U2Vbp17gmpPYWdYjUhRd
	9rc6JD3zogLcCwn7gfDeF0q4uOmgueXj+lOYv/YuVemrzfaC/fSmF97RWy+ynY0wNgrJjNhhL5z
	RBwcNm0T2UA8WgazCNyX3JbcUUc32p9cy2MbsbTRXfjcwyyZGJO/weUaKkL9QVAkm0R8CpY/Ehi
	L345YLajtCOFMDCw7TWDDf28BVTxj+A==
X-Received: by 2002:a05:6a20:1611:b0:246:5be:ca90 with SMTP id adf61e73a8af0-24e7e83cc89mr2634197637.10.1757044562463;
        Thu, 04 Sep 2025 20:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqP3WckW3fa7ibrVA31oor3NOjH0qAdC4pvGViB84QmxNjn0RVQ5IS9R/kwsuVr8+x6wnSTA==
X-Received: by 2002:a05:6a20:1611:b0:246:5be:ca90 with SMTP id adf61e73a8af0-24e7e83cc89mr2634157637.10.1757044561910;
        Thu, 04 Sep 2025 20:56:01 -0700 (PDT)
Received: from [10.133.33.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d96829a66sm16860662a12.6.2025.09.04.20.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 20:56:01 -0700 (PDT)
Message-ID: <2b986468-59b3-4586-9d4c-3ec34dc36c2c@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 11:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/6] Display enablement changes for Qualcomm QCS8300
 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
 <5bc0203c-21a1-4948-96ff-8eae844bfb93@oss.qualcomm.com>
 <d2940186-7baf-41d3-80dd-fbc860ac5acb@oss.qualcomm.com>
 <f3aa35bb-5ac7-4fe3-904e-2dd97b9c034a@oss.qualcomm.com>
 <fgzptkddxhgqpsylthgo4a465jwypcu2oxo6woeihyukpn3zqd@hitdv3ujjhvc>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <fgzptkddxhgqpsylthgo4a465jwypcu2oxo6woeihyukpn3zqd@hitdv3ujjhvc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68ba5f54 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=1XWaLZrsAAAA:8 a=KKAkSRfTAAAA:8 a=_0dYuvDVJydFRCGzEJUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eB3NR1_akn-ll8J3nctPLAsna-QpYOkK
X-Proofpoint-ORIG-GUID: eB3NR1_akn-ll8J3nctPLAsna-QpYOkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX/fAfcsMJDXem
 Df14K8jlhVBaVoV14OFKQz0Acr0srbeO99ZjwHWVJNKNp/wkKIMmLuD6NvO5GSJqb6flMS39/C8
 rED4XqyjgGV+lSOUUqx44mWZYIf7iaY/myWToH/cjWf+khUYn977I8tJkgqNV87HXPbaQZJyoUw
 Kxad/k5Ip3qkS5uAiQGMmi9gF8wbFcy2QvIot1obeLg8S9Q5n829kxxryGWZsvglQQeb7vZ386r
 bTpaMRfOn6dDT8n7qlbcqZfX2KJFTcppBAzMvtuCGOX3+qkjjcSPxITfUCwQCRH2ZhN9T/AS+W6
 O09W5w+8EgIvtvAsxYwGtamDJe0WiA3EZpX+V8CRp/FJGsNNRzUgdF2k7lYMh9T5cF2EcdHlq08
 XqRyFJKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101



On 9/4/2025 9:41 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 05:31:01PM +0800, Yongxing Mou wrote:
>>
>>
>> On 9/4/2025 4:21 PM, Konrad Dybcio wrote:
>>> On 9/4/25 9:55 AM, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 9/4/2025 3:22 PM, Yongxing Mou wrote:
>>>>> This series introduces support to enable the Mobile Display Subsystem (MDSS)
>>>>> , Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
>>>>> QCS8300 target. It includes the addition of the hardware catalog, compatible
>>>>> string, and their YAML bindings.
>>>>>
>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>> ---
>>>>> Changes in v11: Fixed review comments from Dmitry.
>>>>> - Rebase to MST bindings V8.
>>>>> - Update the clocks-name for QCS8300 in dp-controller.
>>>>> - Link to v10: https://lore.kernel.org/r/20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com
>>>>>
>>>>> Changes in v10:
>>>>> - Rebase to MST bindings V7.
>>>>> - Update the P2/P3/MST2LINK/MST3LINK regions in MDSS yaml.
>>>>> - Link to v9: https://lore.kernel.org/r/20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com
>>>>>
>>>>> Changes in v9: Fixed review comments from Dmitry.
>>>>> - Updated the description of dp-controller DT binding.
>>>>> - Add new clause only work for QCS8300(one DP controller with 4 streams).
>>>>> - Link to v8: https://lore.kernel.org/r/20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com
>>>>>
>>>>> Changes in v8: Fixed review comments from Krzysztof, Dmitry.
>>>>> - Fixed incorrect description for dp-controller in driver/dt-binding.[Krzysztof][Dmitry]
>>>>> - Fixed incorrect description for ubwc change.[Dmitry]
>>>>> - Link to v7: https://lore.kernel.org/r/20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com
>>>>>
>>>>> Changes in v7: Fixed review comments from Dmitry.
>>>>> - Rebase to next-20250818 and 4 pixel stream series V6.
>>>>> - Add more description for the dp-controller dt-bingding change.[Dmitry]
>>>>> - Reorder the MDSS change and UBWC change.[Dmitry]
>>>>> - Switch to the OSS email.
>>>>> - Link to v6: https://lore.kernel.org/r/20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com
>>>>>
>>>>> Changes in v6: Fixed review comments from Konrad, Dmitry.
>>>>> - Rewrite commit msg in dp-controller dt-binding change.[Dmitry]
>>>>> - Optimize the description in MDSS dt-binding.[Dmitry]
>>>>> - Pass the sc8280xp_data as fallback in the UBWC change.[Konrad]
>>>>> - Add the DP controller driver change.
>>>>> - Link to v5: https://lore.kernel.org/r/20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com
>>>>>
>>>>> Changes in v5:Fixed review comments from Krzysztof, Dmitry.
>>>>> - Rebase to next-20250717.
>>>>> - Change DP compatible to qcs8300-dp due to add 4 streams support.
>>>>> - Add QCS8300 UBWC config change due to rebase.
>>>>> - Add 4 streams clk and phy in the mdss yaml.
>>>>> - Link to v4: https://lore.kernel.org/r/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com
>>>>>
>>>>> Changes in v4:Fixed review comments from Krzysztof, Dmitry.
>>>>> - Use the common style for the dt-bindings commits.[Dmitry]
>>>>> - Update the commits msg for the mdss binding patch, explain why they
>>>>>      reuse different platform drivers.[Krzysztof]
>>>>> - Link to v3: https://lore.kernel.org/r/20250113-mdssdt_qcs8300-v3-0-6c8e93459600@quicinc.com
>>>>>
>>>>> Changes in v3:Fixed review comments from Krzysztof, Dmitry.
>>>>> - Fix the missing space issue in commit message.[Krzysztof]
>>>>> - Separate the patch for the phy from this series.[Dmitry]
>>>>> - Remove unused dependencies and update in the cover letter.[Dmitry][Krzysztof]
>>>>> - Link to v2: https://lore.kernel.org/r/20241226-mdssdt_qcs8300-v2-0-acba0db533ce@quicinc.com
>>>>>
>>>>> Changes in v2:Fixed review comments from Krzysztof, Dmitry, Rob.
>>>>> - Decouple the devicetree changes from this series.[Dmitry][Krzysztof]
>>>>> - Drop the dpu driver changes and reuse SA8775P DPU driver.[Dmitry]
>>>>> - Fix compilation issues in MDSS bindings.[Rob][Krzysztof]
>>>>> - Correct formatting errors and remove unnecessary status in MDSS
>>>>>      bindings.[Krzysztof]
>>>>> - Add the the necessary information in MDSS changes commit msg.[Dmitry]
>>>>> - Rebase MDSS driver changes to https://lore.kernel.org/dri-devel/
>>>>>      20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/.[Dmitry]
>>>>> - Package the DisplayPort controller and eDP PHY bindings document to
>>>>>      this patch series.
>>>>> - Collecting MDSS changes reviewd-by Dmitry.
>>>>> - Reuse the sa8775p eDP PHY as a fallback compat.[Dmitry]
>>>>> - Reuse the sm8650 DP controller as a fallback compat.[Dmitry]
>>>>> - Link to v1: https://lore.kernel.org/r/20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com
>>>>> ---
>>>>> This series depend on 4 pixel streams dt-binding series:
>>>>> https://lore.kernel.org/all/20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com/
>>>>>
>>>>> and separate eDP PHY binding:
>>>>> https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/
>>>>>
>>>>> ---
>>>>> Yongxing Mou (6):
>>>>>          dt-bindings: display/msm: Document the DPU for QCS8300
>>>>>          dt-bindings: display/msm: dp-controller: document QCS8300 compatible
>>>>>          dt-bindings: display/msm: Document MDSS on QCS8300
>>>>>          soc: qcom: ubwc: Add QCS8300 UBWC cfg
>>>>>          drm/msm: mdss: Add QCS8300 support
>>>>>          drm/msm/dp: Add DisplayPort controller for QCS8300
>>>>>
>>>>>     .../bindings/display/msm/dp-controller.yaml        |  22 ++
>>>>>     .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
>>>>>     .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
>>>>>     drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
>>>>>     drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
>>>>>     drivers/soc/qcom/ubwc_config.c                     |   1 +
>>>>>     6 files changed, 321 insertions(+), 5 deletions(-)
>>>>> ---
>>>>> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
>>>>> change-id: 20250818-qcs8300_mdss-a363f0d0ba0b
>>>>> prerequisite-message-id: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
>>>>> prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
>>>>> prerequisite-patch-id: cdc3f4515ab23a8b2ce719bbdbcb56043803d03f
>>>>> prerequisite-patch-id: 048b11765f49af4a728db1525fef1eb8ad48bf88
>>>>> prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
>>>>> prerequisite-patch-id: a8185cf3ddd85b9058691500b8dc0c57c8226e97
>>>>> prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
>>>>> prerequisite-patch-id: 09ec7f51de0a65c68c2c781750177017f32747ba
>>>>> prerequisite-patch-id: f76ab0ae189df14acc851fa52f8f8e8faed9a505
>>>>> prerequisite-patch-id: 983fc8a7bea459505c5b27db1a1ef7581936555c
>>>>> prerequisite-message-id: <20250730072725.1433360-1-quic_yongmou@quicinc.com>
>>>>> prerequisite-patch-id: 2ea89bba3c9c6ba37250ebd947c1d4acedc78a5d
>>>>>
>>>>> Best regards,
>>>>
>>>> Hi, maintainers:
>>>> sorry for the inconvenience caused. This series is missing patch 5 and patch 6 due to network issues. May I resend it? The missed two changes are identical to V10.
>>>
>>> You can fix that manually by sending them both through
>>>
>>> b4 send -o /tmp/
>>> git send-email --in-reply-to=<cover letter msgid> /tmp/0005-xyz-abc.patch
>>> git send-email --in-reply-to=<cover letter msgid> /tmp/0006-xyz-abc.patch
>>>
>>> Konrad
>> Thanks for guide, when i use cmd  "git send-email
>> --in-reply-to="20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com"
>> ~/tmpyongmou/0005-drm-msm-mdss-add-qcs8300-support.eml", seems something
>> wrong, error log:
>> mou@oss.qualcomm.com>,  Dmitry Baryshkov
>> <dmitry.baryshkov@oss.qualcomm.com>'
>> (body) Adding cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> from
>> line 'Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>'
>> 5.1.3 The recipient address <y> is not a valid RFC 5321 address. For more
>> 5.1.3 information, go to
>> 5.1.3  https://support.google.com/a/answer/3221692 and review RFC 5321
>> 5.1.3 specifications. d9443c01a7336-24b1ba1718bsm64512315ad.39 - gsmtpWould
>> you mind sharing some suggestions for this? Thanks~~
> 
> When `git send-email` asks you, just press 'Enter', no extra chars. Or
> it migth be easier to just `b4 send --resend`.
> 
Thanks for the guidance — that was the mistake I made. It has now been 
sent upstream. It looks like the patch wasn't archived into the V11 
series. So does this ok?


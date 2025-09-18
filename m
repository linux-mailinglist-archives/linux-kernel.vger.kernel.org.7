Return-Path: <linux-kernel+bounces-801990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6EB44C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE745882C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4920F079;
	Fri,  5 Sep 2025 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LImjBCPj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BE4C9D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044112; cv=none; b=KRSSJWt1P1KOMGvA3ThgMYVosa6H+t68pq4iY30gL5NBaX/oZzadSiLwtccgrITA9E2RhDUWc972VmmGjytloq+h/r4vPoZy8MAt2nv0nDU7gsrqnnjyGapzT2GzGd8i7TEdq6jBvSnPUaaAvFQ3HDvb9/ECHzI7DAar2Ytr88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044112; c=relaxed/simple;
	bh=SBF+KQo4TD+bFiFeFZXLUt9bFW0An4kfQ1G0KAS0VjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZm7vWti+wp9b2T53YrbjPcyV5uUG7aQsvO2kK2++jn+zspa/YgiEmZZyapiGZCeDG8X8OJiFvQhBtVecnlpx5N9RceICKTcXjF6zhQM8mJR0Qf1TgUGL0LYaNAokBP9o2WgnY93pxwE4ddhefwj4Uolc427lowkIPa7PM+EKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LImjBCPj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JA1SJ023899
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 03:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IfIuljfusmgW05hVN8hSlfX64nFQxgfeSfL9pQ3lsiE=; b=LImjBCPj0BaCskag
	3GiURZj+7zFiKKss9CF1aEggs4qumQnLPg/C/LBGFB6uwGF6eV8sJs7oeOx+7dnf
	17816NFQWGtHr9dHR8LA0ZiS7H0sBd+XPWENodCCq9QnaTRK3aHR16ICI4kLuV4o
	UNQZT2SDZGbNa1U1inqKszTRRW3puzys+l3BX0NfDdKpi6c4+GfrvsFLUkDkMRtc
	kNCzmMd8I9G4abKQVUXI49+K1yCCGOPEX6/MLsaW0J4f+DnRs6UFwJjtmgrATOxq
	Pv9VC5cTHX0d7PW49K531uyCuowiW0DcM/xenI1htllCIjU/nVjvXHFNAS+nPJBF
	SJhKAw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fsj28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:48:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so2803926a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044108; x=1757648908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfIuljfusmgW05hVN8hSlfX64nFQxgfeSfL9pQ3lsiE=;
        b=TODlifrIo2pybaF9hx4b0xSH2PsFMsIT15JmUdowGzy91/N/RfCYOL3o21IeFAKv+G
         zH22WkhV32Y35oJtACdW25d/0NHjN051PXABTEFsNBday483FdjWJxfol1doYKeDKHno
         Uo/FnLI3l7auUQSiQDV4DuSSja/mP1EZmC7V6DJU7I0dP93xJvDceFO8Zh3jd9CqR6w1
         xQtSMU7MclobVw/VHhQRgox6HueswXwb0IHVnsyOaY7eC20dvJW+pRU4D5i//H2n0whl
         c4OfVmiPXKMsTyV71dmDvw6J870/T6qOCgcPwWR/mmcKcxIxRZfJqfkQF7aw0K0gDEAZ
         l1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUrgSQHINA4b2Z0VgRi3+8Lvs+g82Y7MGqP3Cs9nLlqNHV14WQ+sZv81oEbpgIUgVFvFQGF1f63uC8N0YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJCCNiXLqXpYeq+UfXllB43GpNuwlub97ysP3jyh7bc9V2/Yy
	rxp5TB87Teow8RIQYIfyt520BKSlo3EROXrA13LBq+6BWZoj+TXyt7WMadxi21p/NiEQmeYQ/1m
	iUXqmMAzTYZrSrTckY5NwuWogR5ebxuAl2Z8dXgvl41WxQbh32fdZIecW8RgIJM26vFM=
X-Gm-Gg: ASbGncsTA1h750k8ONgKoa4Le1Pw+9hCLRXCHyUkPqCVYPNzDh3evVxV9U80DoRpE5T
	xQa7A/uW6+K7x6Am0dq1jO48f/ljor3+95JHvEcRcSscMzIa4eK4IOGu8nphVHWjB2f/voLJd/n
	Kb7tjLj2YyL6hTNmw7VvRXLwNDI+y50f1tufrqw4kbL5S74GGIDWOWropObyE1bR88huanaj7Fw
	247sOuxDauva/1oGDFRykf1A8lIqU1GxEFhGOZHsm39t2hPhNJJedLsP/46lVblKQ5BnyTFU2nv
	6opjcSCQBcmam5dYnzugrlqb/YKrJZgnEEVwT9T99w3UoMJca6w7z7JxXpodo1eJQbi6virJmlS
	o1Y9HFlpXb4z3YF5PkQa/CZJXABgRbQ==
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-32815412c9emr27368062a91.3.1757044108363;
        Thu, 04 Sep 2025 20:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM8mklBjBEEvC0AbLw/2BFNtYpsbj99lUvJobF3anjy5uLPxTqVCD4rlCCT2kOY0rt53TL/w==
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-32815412c9emr27368027a91.3.1757044107737;
        Thu, 04 Sep 2025 20:48:27 -0700 (PDT)
Received: from [10.133.33.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm20659323b3a.71.2025.09.04.20.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 20:48:27 -0700 (PDT)
Message-ID: <3c36caba-9579-4c43-bec8-73424c9a820d@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 11:48:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/6] Display enablement changes for Qualcomm QCS8300
 platform
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
 <5bc0203c-21a1-4948-96ff-8eae844bfb93@oss.qualcomm.com>
 <d2940186-7baf-41d3-80dd-fbc860ac5acb@oss.qualcomm.com>
 <f3aa35bb-5ac7-4fe3-904e-2dd97b9c034a@oss.qualcomm.com>
 <c60ace5f-d682-4373-9c45-66782162dd25@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <c60ace5f-d682-4373-9c45-66782162dd25@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXxcz3RMRCKqDT
 4acBhvJNsZCWmfY4qaq6LCYcNwKjuO+7+YDVRzPeSNdW53MzSDu4wSBNfWLjhZqWcX3hTxthSst
 iG659eoVd/PluCoJr5Fw7q/0S5pFrI1MdmS8SRdabjeiZEDbhzmPSq90ffQBoPt6makFRdQlXvM
 zMDuaHBkME05Pe+G1hLge9ufDgs43nokQNmiG67j+jWoVsBZdMVRgeoJgT7Ax6Ek+qvObvg8FUW
 8A/P70AQ8+1RgB2C5SpzVJ3dqsu+bMlbXG16ShsitKTxNWAfMcO2bWMDrUeDnKl0glk37VSqW+P
 78+ebUfrYRo3IP2UfVJQ/iukOFKeoiIiowQBXkHG+YQ4ErPosOPETL1ZIyh7ZJAbUU00fzaCnaf
 ZwuiYuQs
X-Proofpoint-ORIG-GUID: Wr77MtlpIowBPd-sXi9ilXq7veZjW5mx
X-Proofpoint-GUID: Wr77MtlpIowBPd-sXi9ilXq7veZjW5mx
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68ba5d8e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=1XWaLZrsAAAA:8 a=KKAkSRfTAAAA:8 a=_0dYuvDVJydFRCGzEJUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 9/4/2025 5:44 PM, Konrad Dybcio wrote:
> On 9/4/25 11:31 AM, Yongxing Mou wrote:
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
>>>>>      reuse different platform drivers.[Krzysztof]
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
>>>>>      bindings.[Krzysztof]
>>>>> - Add the the necessary information in MDSS changes commit msg.[Dmitry]
>>>>> - Rebase MDSS driver changes to https://lore.kernel.org/dri-devel/
>>>>>      20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/.[Dmitry]
>>>>> - Package the DisplayPort controller and eDP PHY bindings document to
>>>>>      this patch series.
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
>>>>>          dt-bindings: display/msm: Document the DPU for QCS8300
>>>>>          dt-bindings: display/msm: dp-controller: document QCS8300 compatible
>>>>>          dt-bindings: display/msm: Document MDSS on QCS8300
>>>>>          soc: qcom: ubwc: Add QCS8300 UBWC cfg
>>>>>          drm/msm: mdss: Add QCS8300 support
>>>>>          drm/msm/dp: Add DisplayPort controller for QCS8300
>>>>>
>>>>>     .../bindings/display/msm/dp-controller.yaml        |  22 ++
>>>>>     .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
>>>>>     .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
>>>>>     drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
>>>>>     drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
>>>>>     drivers/soc/qcom/ubwc_config.c                     |   1 +
>>>>>     6 files changed, 321 insertions(+), 5 deletions(-)
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
>> Thanks for guide, when i use cmd  "git send-email --in-reply-to="20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com" ~/tmpyongmou/0005-drm-msm-mdss-add-qcs8300-support.eml", seems something wrong, error log:
>> mou@oss.qualcomm.com>,  Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>'
>> (body) Adding cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> from line 'Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>'
>> 5.1.3 The recipient address <y> is not a valid RFC 5321 address. For more
>> 5.1.3 information, go to
>> 5.1.3  https://support.google.com/a/answer/3221692 and review RFC 5321
>> 5.1.3 specifications. d9443c01a7336-24b1ba1718bsm64512315ad.39 - gsmtpWould you mind sharing some suggestions for this? Thanks~~
> 
> Looks wrong, perhaps you pressed 'y' instinctively when git send-email asked you
> whom (additionally) send the message to. Just to make sure b4 isn't broken I
> tried something similar (ignore dry-run, I simply didn't want to send any emails):
> 
> git send-email --dry-run /tmp/0014-illustrative_test.eml
> To whom should the emails be sent (if anyone)? <enter>
> Message-ID to be used as In-Reply-To for the first email (if any)? <enter>
> <lots of email spam>
> 
> Result: OK
Thanks for the guide. i think i should not type 'y' when b4 ask me.. now 
i have post patch 5/6,6/6 to upstream, thank.


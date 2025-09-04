Return-Path: <linux-kernel+bounces-800262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C022FB4358C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581741BC080E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4442C1587;
	Thu,  4 Sep 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPB3uAve"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C592C0289
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974107; cv=none; b=gccrbFJTzKHgjP9bpVjVMOrRwOWpG8OOosc5wqwHRLKpJov34JzDClPsa5Mq6I4MBnSqtnAYGZd4El/bZMmd+PM/95nxToFux/fje+B5vcKBCpfBcZUb8E4ZMXKTYykSPGk5AZyzpiwa4xo9ovHUzo+kD9q2lTOl7nyc54P5Cxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974107; c=relaxed/simple;
	bh=+0o6nanF+ouPh99kLb7isxJ2NCHwAMGXrJkRklYIDBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMc7upBFQidtc2PpOy+IXtPYZ21bP3DXRZASCMHO16NoQp4y65wOUTA0uV+Op5YngnzVBh5rABV7AigRgvYXg7Rdha2kyG3605Mp4wrA9Kd8LdSetzpNQ8I2bNBTwPCoTsXTAyKVYS4SwzPAJYyUTPl9ssg1i8/RycK8PFyJAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPB3uAve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583NCmir029545
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7vuEYezAclQnGX21qrANx4NW0HHSU2TfxUcHGP8ds8=; b=JPB3uAveMgUrSI7/
	911ArKRLgZ4O/OmBy4WFH/QceijOt6uCIoHlTldWGrpLQzwMsVDRCx663rJKZkj0
	nlv7YjWR2HP/qZ43SQ1FbT1/jcgceLFPlGXEYQ5HE7J3r39cBPZ1rCJ6UW158vs8
	3YuzBzlKlMaT/PGemRUQTo3PRCrwBgQJf9bV6Mds50ncPNxODQwc6WYHcQzNB4Op
	hTYo2KYSgzw1S+4g2kLwbU2vRgTrHLOfVA3S4Ea4qStZ4NKsIpnfwS1cN0660fqp
	sDrTX5gEV2jved0YOZmsL7nP06tAZWmctqQotuKIXcyqu51rTftjFbFUF8oO7tNe
	Ojm5tw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpewwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:21:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-715c9cad6f8so940316d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756974101; x=1757578901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7vuEYezAclQnGX21qrANx4NW0HHSU2TfxUcHGP8ds8=;
        b=iell9HulVAvJAr9DT8j19TUaxcCF8oBAYQHbyPllGhoTpqOnKiromx+CN2C7SH20FT
         kP3xUoIfVJ5rEmi5QajP9WMoZFF2xHe2geq9+fSejYhg4gWxUjOKlgkvvaSpOHRTQze7
         r46+vjYh3unQ7NVhcb+9W43TfYrLLEhYBw1aU5WJJjZaP5vNedJb1j7osXymtmJ3M+nE
         EIY22CFA5UzaMWd85hrY46loiHzOYYU6iGb57FVICFQTWlvuzu7SSrNCgwJzOJkMX2Dj
         LPU/aYdICaqgNut6DZ49dwn+SHN289NxlOb+Cy4UF/3DB+RH++EmBoK7TAS6zSGNi6pk
         jmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUliS9XtDRN5hNZX1Y4+yGp6I+vUoWbydWiux9GacvGQNX8H7m71/h8KE815qEyJ/w1ZOWBf+EmKqnmFag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85Mtp46P6C31LWCift+KyldQKdd6Vg0fN+1JmolFgkVh445w3
	tIJ6/6q/nat2uO6Av2ODEz4bkeVmWxta3E/ZMFWM3L5GJv1lFxxOMb52Tpeqp1+YPoNPRZgK/+E
	whG+So/tXHkyjMn03lIeoUi8bk2pZLBHgpr7z6qvo0E37bFMb5fsOkvx9Gvr5Mgfrd9Q=
X-Gm-Gg: ASbGncuG68EpPl1UL90GF9ExErL/DatrJcMMi6Ipd04RldgPmUDVbz4uaOjgwS1MjlC
	5mJ0z4iNI2O5zlez9j/sJ6fOPcN5VEmhVVgbYFbqdndD9NRKNJVcS5qSCkdDxhQ5oSHgqnsx/Y0
	J3VKgMgOfP4s9fV0pW6YyXF1y+91ePTCcZxXGodNKHFvbMUpt19kEiN1A/JKQbg89iQq6v8QhYK
	sqAKyQPZQOdDZ5pjz6/wZBQ1OmbGS1wBzSI4bweGissdWKUXDwwuZNUIdTJG5ajvMLYAUzcg2JJ
	5W2jbgeCsqI3+L0KR1vmUbGzJI3km6C7HbMLY/KdPPYyqZy7SGNZNuXzGL42nqM7JnBM6t+QI48
	9ZnTeoqSayZiEoGPUdA1Vgw==
X-Received: by 2002:ac8:57c5:0:b0:4b2:d4ff:9ef1 with SMTP id d75a77b69052e-4b30e91ece8mr193805621cf.5.1756974101268;
        Thu, 04 Sep 2025 01:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhpdB1EGq/rqFX09t8O7MeDdp3MZRYztL04B/dtliw3WnUXk0wRSxWriQ2b/SMaKMgYlG0yg==
X-Received: by 2002:ac8:57c5:0:b0:4b2:d4ff:9ef1 with SMTP id d75a77b69052e-4b30e91ece8mr193805301cf.5.1756974100631;
        Thu, 04 Sep 2025 01:21:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416e878a2sm1087490866b.95.2025.09.04.01.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:21:39 -0700 (PDT)
Message-ID: <d2940186-7baf-41d3-80dd-fbc860ac5acb@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:21:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/6] Display enablement changes for Qualcomm QCS8300
 platform
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5bc0203c-21a1-4948-96ff-8eae844bfb93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jXkZwIK4tyj5hK5p28Q2GS5GOOUHxCeV
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b94c18 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=QEN1f650Fdx1fgK6Dx0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jXkZwIK4tyj5hK5p28Q2GS5GOOUHxCeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX+VLccJ9CyGAa
 gO5THC+SOIBx4TrA2LIR+TLLPPGcZjcy/AWvSWgjDkmN973cCpn28ndHRq4S18cdempNJraojB3
 uzDUQLuYK3hFPB3DG+75RJ9207w3q8Ik9x949W91g9bSyTOyTpvspZNrZVGIo0I9myevIYC7550
 a+4mA89ZldBy2WE5ppTZyMzSPBu6PHyNem4lcrRBV6fYl5ZPKlaocOQQ7HWpsDrBX31c5dUg7kF
 ZZrU1CGrA3QIetPH3C4d2sCVXPM6YnM2oOv0nJ18h/6rZHFiRM+sk5pY3C3Hqni6aGXUOt/q+i8
 /y6fU/tf+2Z02kcDaQC4eDtepUlT07csnyNSKUzUw/hMqT+ziJkw0O63R8z+uxI8keggZj2AUvK
 lLP7aVzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/4/25 9:55 AM, Yongxing Mou wrote:
> 
> 
> On 9/4/2025 3:22 PM, Yongxing Mou wrote:
>> This series introduces support to enable the Mobile Display Subsystem (MDSS)
>> , Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
>> QCS8300 target. It includes the addition of the hardware catalog, compatible
>> string, and their YAML bindings.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>> Changes in v11: Fixed review comments from Dmitry.
>> - Rebase to MST bindings V8.
>> - Update the clocks-name for QCS8300 in dp-controller.
>> - Link to v10: https://lore.kernel.org/r/20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com
>>
>> Changes in v10:
>> - Rebase to MST bindings V7.
>> - Update the P2/P3/MST2LINK/MST3LINK regions in MDSS yaml.
>> - Link to v9: https://lore.kernel.org/r/20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com
>>
>> Changes in v9: Fixed review comments from Dmitry.
>> - Updated the description of dp-controller DT binding.
>> - Add new clause only work for QCS8300(one DP controller with 4 streams).
>> - Link to v8: https://lore.kernel.org/r/20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com
>>
>> Changes in v8: Fixed review comments from Krzysztof, Dmitry.
>> - Fixed incorrect description for dp-controller in driver/dt-binding.[Krzysztof][Dmitry]
>> - Fixed incorrect description for ubwc change.[Dmitry]
>> - Link to v7: https://lore.kernel.org/r/20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com
>>
>> Changes in v7: Fixed review comments from Dmitry.
>> - Rebase to next-20250818 and 4 pixel stream series V6.
>> - Add more description for the dp-controller dt-bingding change.[Dmitry]
>> - Reorder the MDSS change and UBWC change.[Dmitry]
>> - Switch to the OSS email.
>> - Link to v6: https://lore.kernel.org/r/20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com
>>
>> Changes in v6: Fixed review comments from Konrad, Dmitry.
>> - Rewrite commit msg in dp-controller dt-binding change.[Dmitry]
>> - Optimize the description in MDSS dt-binding.[Dmitry]
>> - Pass the sc8280xp_data as fallback in the UBWC change.[Konrad]
>> - Add the DP controller driver change.
>> - Link to v5: https://lore.kernel.org/r/20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com
>>
>> Changes in v5:Fixed review comments from Krzysztof, Dmitry.
>> - Rebase to next-20250717.
>> - Change DP compatible to qcs8300-dp due to add 4 streams support.
>> - Add QCS8300 UBWC config change due to rebase.
>> - Add 4 streams clk and phy in the mdss yaml.
>> - Link to v4: https://lore.kernel.org/r/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com
>>
>> Changes in v4:Fixed review comments from Krzysztof, Dmitry.
>> - Use the common style for the dt-bindings commits.[Dmitry]
>> - Update the commits msg for the mdss binding patch, explain why they
>>    reuse different platform drivers.[Krzysztof]
>> - Link to v3: https://lore.kernel.org/r/20250113-mdssdt_qcs8300-v3-0-6c8e93459600@quicinc.com
>>
>> Changes in v3:Fixed review comments from Krzysztof, Dmitry.
>> - Fix the missing space issue in commit message.[Krzysztof]
>> - Separate the patch for the phy from this series.[Dmitry]
>> - Remove unused dependencies and update in the cover letter.[Dmitry][Krzysztof]
>> - Link to v2: https://lore.kernel.org/r/20241226-mdssdt_qcs8300-v2-0-acba0db533ce@quicinc.com
>>
>> Changes in v2:Fixed review comments from Krzysztof, Dmitry, Rob.
>> - Decouple the devicetree changes from this series.[Dmitry][Krzysztof]
>> - Drop the dpu driver changes and reuse SA8775P DPU driver.[Dmitry]
>> - Fix compilation issues in MDSS bindings.[Rob][Krzysztof]
>> - Correct formatting errors and remove unnecessary status in MDSS
>>    bindings.[Krzysztof]
>> - Add the the necessary information in MDSS changes commit msg.[Dmitry]
>> - Rebase MDSS driver changes to https://lore.kernel.org/dri-devel/
>>    20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/.[Dmitry]
>> - Package the DisplayPort controller and eDP PHY bindings document to
>>    this patch series.
>> - Collecting MDSS changes reviewd-by Dmitry.
>> - Reuse the sa8775p eDP PHY as a fallback compat.[Dmitry]
>> - Reuse the sm8650 DP controller as a fallback compat.[Dmitry]
>> - Link to v1: https://lore.kernel.org/r/20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com
>> ---
>> This series depend on 4 pixel streams dt-binding series:
>> https://lore.kernel.org/all/20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com/
>>
>> and separate eDP PHY binding:
>> https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/
>>
>> ---
>> Yongxing Mou (6):
>>        dt-bindings: display/msm: Document the DPU for QCS8300
>>        dt-bindings: display/msm: dp-controller: document QCS8300 compatible
>>        dt-bindings: display/msm: Document MDSS on QCS8300
>>        soc: qcom: ubwc: Add QCS8300 UBWC cfg
>>        drm/msm: mdss: Add QCS8300 support
>>        drm/msm/dp: Add DisplayPort controller for QCS8300
>>
>>   .../bindings/display/msm/dp-controller.yaml        |  22 ++
>>   .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
>>   .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
>>   drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
>>   drivers/soc/qcom/ubwc_config.c                     |   1 +
>>   6 files changed, 321 insertions(+), 5 deletions(-)
>> ---
>> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
>> change-id: 20250818-qcs8300_mdss-a363f0d0ba0b
>> prerequisite-message-id: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
>> prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
>> prerequisite-patch-id: cdc3f4515ab23a8b2ce719bbdbcb56043803d03f
>> prerequisite-patch-id: 048b11765f49af4a728db1525fef1eb8ad48bf88
>> prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
>> prerequisite-patch-id: a8185cf3ddd85b9058691500b8dc0c57c8226e97
>> prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
>> prerequisite-patch-id: 09ec7f51de0a65c68c2c781750177017f32747ba
>> prerequisite-patch-id: f76ab0ae189df14acc851fa52f8f8e8faed9a505
>> prerequisite-patch-id: 983fc8a7bea459505c5b27db1a1ef7581936555c
>> prerequisite-message-id: <20250730072725.1433360-1-quic_yongmou@quicinc.com>
>> prerequisite-patch-id: 2ea89bba3c9c6ba37250ebd947c1d4acedc78a5d
>>
>> Best regards,
> 
> Hi, maintainers:
> sorry for the inconvenience caused. This series is missing patch 5 and patch 6 due to network issues. May I resend it? The missed two changes are identical to V10.

You can fix that manually by sending them both through

b4 send -o /tmp/
git send-email --in-reply-to=<cover letter msgid> /tmp/0005-xyz-abc.patch
git send-email --in-reply-to=<cover letter msgid> /tmp/0006-xyz-abc.patch

Konrad


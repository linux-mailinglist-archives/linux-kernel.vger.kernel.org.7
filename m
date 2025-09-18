Return-Path: <linux-kernel+bounces-754664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC3B19A95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFC118933BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC01B043A;
	Mon,  4 Aug 2025 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fxwFZqpD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE961BF58;
	Mon,  4 Aug 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754280069; cv=none; b=rYXWwjFiT/mtnOHJZs8uZaMHNHSpdTW+aEfdZ0s8u+vJZxiQVZLqsRpXbOUl1xgKruEzTSenYu9O4hn9uxZCwTg1uzXq3SltVzrfxX2roBu+vu5ShvZXU9cWvkIiYNFqX0eIicMfvqhVoMiTzoukKuJ5fWh7qFinZUwtneOAbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754280069; c=relaxed/simple;
	bh=IxBByvUsQMbosltB4YaSMa4gVCXGWD3B8Aejl80Ch8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z1tUaYcLZfUEFhi4apTT/XZJB12bDFKWWj5HclqK5arNY/Lme+q5HgK27FgY1SpB2KjyTiimxadCf0O7u4jIyQ+z1loxZ64Mkek5CeGpnp98n2cvcpMXVAmZAttqgDKT7LWmiRTiqbJZiV6NUVkWcAlWJfZnp0RSReM3AuLpyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fxwFZqpD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573LU2bX026982;
	Mon, 4 Aug 2025 04:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcIav76jDxMQjNH0hlEDlh3kXoAijWiurSJwVWt/Gpw=; b=fxwFZqpD70cHPBqp
	hoEDlHUxoXlB7zumAADM4sBvhuESjE4p64bxXkjalGpuZ8+9pBUnBo4ArSQvPz25
	qGOkSnKnBhWLoDmkKPI/JuCITO2T9eCCYei6I2M8eCTSF9xQMUoXINLAanNOEcvM
	Q7pY05NluiRFBXL+wWxMinrspljwouFrpqQFkKriRdKe5YnFUNHpcPdazAKFewWD
	Ibo+5Hl4290g7PiBRmCzriS7a3T7S74IvTzkdzqVJncUDWyk06RlNv5MT8m5RDsp
	nsJAUpLqM3ysjqVlFxPGtyObO4Hbe23HuAUyqc0cbdeqqqAY23I9dUkkWGf+YvAG
	vVgd1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqkars-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 04:00:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57440lox013230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 04:00:47 GMT
Received: from [10.64.68.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 3 Aug
 2025 21:00:41 -0700
Message-ID: <cdbe1013-4f15-4638-870b-151292920ce7@quicinc.com>
Date: Mon, 4 Aug 2025 12:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: display/msm: Document MDSS on QCS8300
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Rob Clark
	<robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        "Thomas
 Zimmermann" <tzimmermann@suse.de>,
        Jessica Zhang
	<jessica.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        <dri-devel@lists.freedesktop.org>, Simona Vetter
	<simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        David Airlie <airlied@gmail.com>
References: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
 <20250730-mdssdt_qcs8300-v5-3-bc8ea35bbed6@quicinc.com>
 <175390746243.1660386.11206814214268936734.robh@kernel.org>
Content-Language: en-US
From: Yongxing Mou <quic_yongmou@quicinc.com>
In-Reply-To: <175390746243.1660386.11206814214268936734.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qUlklVohklxLDWbjxgDX96kozVlNe_MR
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=68903070 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8
 a=voM4FWlXAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=0awkmHLjsCMGZ7zvgVIA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=IC2XNlieTeVoXbcui8wp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxOCBTYWx0ZWRfXxE0n+U69sIqQ
 JCKRyRWvNhe0pi8+zCd9AKE3+rrl/xvc+X4F31lDvINuY+yd2zf7ar24v2Itx9JWkiBm1E559ry
 Owg06WUYgRXJzIn2ohWzgYdxA7nGO3nfVPhAqJxcsLN8M+f7dXilEJxtHa5+WajWtC/z/dpIhYX
 FJI7Gn9RG7U9ad/bhFmblARDn83PWzW1fUcrLAO8jPZUY0ypXLAjFHu7OgyYp4Y73vN49QCDrCa
 UuA6XpoVhBM8IVsFdnkDvDr6cg1141GjfvCvcPGEBwSDHiBqW5C7yaXSddJye55Z7efqlRuC6Vj
 VQDnLAfgWsFJARzfYSpwRXxdSmosFKbimImlXcZxbP9k1B2opbtVqUGxOBnGh+TXUQsj4IgkNj6
 0EyO18zuS2USUdBw4mVNVN7Wx20An3xLsDbMVJ6pZ8Qgz0UrtWvwHY5bGJipQeP08v+09Rb/
X-Proofpoint-ORIG-GUID: qUlklVohklxLDWbjxgDX96kozVlNe_MR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040018



On 2025/7/31 4:31, Rob Herring (Arm) wrote:
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> On Wed, 30 Jul 2025 17:42:28 +0800, Yongxing Mou wrote:
>> Document the MDSS hardware found on the Qualcomm QCS8300 platform.
>>
>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>> ---
>>   .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 284 +++++++++++++++++++++
>>   1 file changed, 284 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.example.dtb: phy@aec2a00 (qcom,qcs8300-edp-phy): compatible:0: 'qcom,qcs8300-edp-phy' is not one of ['qcom,sa8775p-edp-phy', 'qcom,sc7280-edp-phy', 'qcom,sc8180x-edp-phy', 'qcom,sc8280xp-dp-phy', 'qcom,sc8280xp-edp-phy', 'qcom,x1e80100-dp-phy']
>          from schema $id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.example.dtb: phy@aec2a00 (qcom,qcs8300-edp-phy): compatible: ['qcom,qcs8300-edp-phy', 'qcom,sa8775p-edp-phy'] is too long
>          from schema $id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250730-mdssdt_qcs8300-v5-3-bc8ea35bbed6@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
This warning need to apply this patch..
https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/
thanks, link in the cover-letter seem wrong. and there is an unnecessary ~



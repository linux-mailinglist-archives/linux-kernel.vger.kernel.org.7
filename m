Return-Path: <linux-kernel+bounces-593701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F4A7FC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6217D174D90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A6A267F66;
	Tue,  8 Apr 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eojACxmi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0525FA01;
	Tue,  8 Apr 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108751; cv=none; b=rSdhQSJ2joO2JiOsFq9zAZ0DvqCTuLlwMCZQRes27Mi2Qh7Eddpg23sSASpr8Svk/J5RPMXzCqbRgcRYsnaWvfIeX8x5RXJiZ/BEw821JEz7tgFfz0GCRaLWalD/I97FGpJJra+F13K1RpAO1O1T9y5OU53rdIw/smM2IYoOXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108751; c=relaxed/simple;
	bh=L72ZX9dA2Duq2821IFupYiHBYIu2thE53zR7y1HFpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KETHke38Of7XMze27A3Vg+ONP/UqnRGWKmdEdlhzc0KClAFY6Xa2Op39B9f84pU+iErvzAwF7+QtAJveybzbWqw3iIC+/T3OhTz3bHvJpZju8q0LBBQnC82GU4Ou6631gXt/Zq1uxwqvlNJNdCOryAeeipPrnEIWpnll9WZtHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eojACxmi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GOTS010519;
	Tue, 8 Apr 2025 10:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ADjzn89USD7dkigsxKLtRctPWf17q4/PIP1TT/2F/U=; b=eojACxmi0iS15s9D
	QHBTHZv5Jt+/m5ckpOY9rKZpLFnmeppuI/lnpDyvPjmnN9iQ0we0kXgY8E3pjOlI
	G1/Pf8fqGzFvoqhTvogPgUcqmfoIqzIBySf7xIA9V7XQwer7jA309qYB2R68lbPn
	L7OD0Zu3qBmrWdWTwXtWZQ/ewoTGGOskUn9gvsBfR3bZ+xW2HjdXxZJXszI6SQF5
	du5FZEb3VfGeUbt71P6UXR3V2WsVTCHf1Dj3jwQoDXlq9datMhtr7XXMFUqt+MLM
	/xFfDQ5ZJ4kSBcKg56h+zrLJ0Vt5+qzXV8Vzag6rWtx197TuxeZfF+udI7bQwNP7
	Wlx+Qg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1fbjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:38:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 538AckEx016860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 10:38:46 GMT
Received: from [10.206.97.61] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 03:38:38 -0700
Message-ID: <654d409e-2325-46e7-a064-ed9e64277e69@quicinc.com>
Date: Tue, 8 Apr 2025 16:08:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] dt-bindings: display: msm: document DSI
 controller and phy on SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <marijn.suijten@somainline.org>, <andersson@kernel.org>,
        <robh@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <konradybcio@kernel.org>, <conor+dt@kernel.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>, <quic_jesszhan@quicinc.com>
References: <20250311122445.3597100-1-quic_amakhija@quicinc.com>
 <20250311122445.3597100-4-quic_amakhija@quicinc.com>
 <20250312-calm-steadfast-cricket-fe9dd8@krzk-bin>
Content-Language: en-US
From: Ayushi Makhija <quic_amakhija@quicinc.com>
In-Reply-To: <20250312-calm-steadfast-cricket-fe9dd8@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NcqhLJn_YjNX6jUAZO9TiF035QhZQKct
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4fcb7 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=jCZCQBWE56vx5fooemgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NcqhLJn_YjNX6jUAZO9TiF035QhZQKct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080076

On 3/12/2025 5:15 PM, Krzysztof Kozlowski wrote:
> On Tue, Mar 11, 2025 at 05:54:38PM +0530, Ayushi Makhija wrote:
>> Document DSI controller and phy on SA8775P platform.
>>
>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>> ---
>>  .../display/msm/qcom,sa8775p-mdss.yaml        | 188 ++++++++++++++++++
>>  1 file changed, 188 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
>> index a90a8b3f1a9e..628ca68871f4 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
>> @@ -52,6 +52,26 @@ patternProperties:
>>          items:
>>            - const: qcom,sa8775p-dp
>>  
>> +  "^dsi@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +
> 
> Drop blank line
> 
>> +    properties:
>> +      compatible:
>> +        items:
> 
> contains
> 
>> +          - const: qcom,sa8775p-dsi-ctrl
>> +          - const: qcom,mdss-dsi-ctrl
> 
> Drop fallback
>
 
Hi Krzysztof,

I couldn't understand the meaning of "Drop fallback", could please elaborate it ?

Thanks,
Ayushi


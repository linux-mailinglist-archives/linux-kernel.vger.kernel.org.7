Return-Path: <linux-kernel+bounces-860762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6EBF0E01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141CB1888A18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA62FB963;
	Mon, 20 Oct 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUQLio5n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A122FBE10
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960180; cv=none; b=WSROGULQcyvUB7XWUcum+quH8Cl74bEBKw0uzLFbky6p1D9DeE+6MctVMJvkE03o4mw9EoSJRhVQPE7ZqdlBlkkOBBrolnIjWFdUl4D7OOzV3u+KORT9QlubnUwAOsaPRteaCPHDqBG0+6KO3ZZ0V8syTTCNVOgF3eRfkQGWDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960180; c=relaxed/simple;
	bh=t51j+mgk3aQ2RGoqLwj1u5ebaMZplsQyOFhqdNf/vlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss6ZXJrMj5xQu0sONpQ8RFX9UVisLTgYz4jUxOs9D+Wuy/Pn9GczKNjeMgBI5F3EnCytg29kUE2xu9pE798Awq0S/GGw7DK75HjMZ1k6CUsumqOnRqhvzbJNdZTLhBOtOE9fDkoAOlxqgKKuktRcwhaeQtvq6VEopJHk5tFMmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUQLio5n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNl4bT019655
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GK+5rKa1ckv1Q0xDSQsg2JrLR6JcjvANAgY1SmDdptQ=; b=bUQLio5nYqY+yhTW
	sugPBh3IxjvFCDE77A33/Vy0zmWuKxMSSrIIvPjuQKOi0UW3SHP+EBqOMfvlxPTy
	QeTD8cmED3H+gE3hLrx5mkL8vhQhr0p9THQMRdGrpPfqvjlY1FjjfXoGNugMKZr9
	NWizG9S2D8TyPnFCAESEestSOSVCz5o0GqU8V1a7uCpn8GBnjrLk5SD5tckqhLyC
	KAfSN3YXpkrfIaYwxFa9NXdu1kpcsHwCneXV3ggLKZ9Ju10m1+xFu/yRNak/28Nl
	5Hc0DTaiGmJu8GYnwtgFHvAItVzbiEXUG7ByAoBmiwfi4U4cuJmAL3/lzhbzffda
	IazMWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4hy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:36:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26b3e727467so15678635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960176; x=1761564976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GK+5rKa1ckv1Q0xDSQsg2JrLR6JcjvANAgY1SmDdptQ=;
        b=bEMMs/ElvwMjVWxO2QE/ACmQbl+kvNK4TTOTfBMz9hJjgia0dK+WjSLoDwXM1GNVHT
         zfGQdDgKZdhwFDL73X2JFcrjA+XQ9PoYJIQYFDepGUn7z1XAjs0gjof3Uhu32wC4Dp5H
         0CDh7Anu2JENNAjRPWrcyhVrwwplX8czw3AdDHQZLqzETNhcntzlKVjBp+CNuZ6kRkG0
         ZkL08JHge5/sXEjyzuR8HqBHo7Czd0NoEbnIRNt5ZoScwUw+jgtd6Yc5ZPJ1Bdl2AtGL
         /E96mbzuvW76XAxS9d95h3FL6uHW/7fMoKgwdCQfIg0471wvSD4+djoKs9ue+Q9CNFyu
         y56w==
X-Forwarded-Encrypted: i=1; AJvYcCW0MgNkqJfIpgEG4hep7d4LluS6RVxqNGbTUFVUMHLxnVZCnvOyu1R4Fd6s2rZV+EwJiUxExcCadntE7bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZOwM2AARc0ftKqHMvNTKd/QWlpt+bowO3m9CUowQEyWE6x26
	Sun9mG2FQH53hPWu1pnNvO8ZZok4/kY/Myr+7vwcXBiagCYasmVNGS4IGKxThDPVIYWewrGYOiy
	STFuYaGbRjMVqEusWLAykAaXhItA3qgKRSkPwtt3zlIKt9oOvVJZCO4POK6AeJKY6+QQ=
X-Gm-Gg: ASbGncsAHarlSgk8pPKONd6qZcdM3uFUdHbqt7McpCEs1g40YztQfv0xqZJFZ+UoUL2
	jJMQeimUlY1xUA++WlF1KGByWSiBOkB7DqDy8WJqPw6KO+Stbh/hLnu8ZwbOwUY+f0ksEGKIOdS
	o/OIxYqDZW7qlPdntOLL8ggcaNo35dKP8yVyd5In9Lf7j25VXnQu8T/uCia0QdB2PBdg+5fRDPd
	6t1P391o65g5CnY9aWdEkTYX+YmcKSXek13tJj4wa+v5ei3DpFTmdjzS0OBMlaIkLkHMwhCiMGD
	1g4wUxUYooBqPP4g/mGbleJaW5RcpXq88SUa+lIIfXK+U9OaudaM50FqIiV56q3W6ukUEbI5pxh
	5f3pno0+MSHoUGgKWn9pMl3yZ1lUfsoapotGS0NbR/iMs2BGORCWqA3yAHBCFZd1S5bD3iA==
X-Received: by 2002:a17:902:f550:b0:290:aaff:344e with SMTP id d9443c01a7336-290c9d07528mr93219835ad.2.1760960175712;
        Mon, 20 Oct 2025 04:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqYXTamiz1sZaI2FXDLVVOOe09rjZU54qmwtT0sYAF4DGpiXYK7IZbq29yBk4Y3Y1cW0n/IQ==
X-Received: by 2002:a17:902:f550:b0:290:aaff:344e with SMTP id d9443c01a7336-290c9d07528mr93219385ad.2.1760960175155;
        Mon, 20 Oct 2025 04:36:15 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4d8sm77471275ad.96.2025.10.20.04.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:36:14 -0700 (PDT)
Message-ID: <e6c481cd-e084-4f5f-a75a-d1e0a254efc1@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 19:36:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: display/msm: Add SM6150 DisplayPort
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
 <20251015-add-displayport-support-to-qcs615-devicetree-v4-1-aa2cb8470e9d@oss.qualcomm.com>
 <58446b2d-560f-4a7e-890a-78ae0bb92908@kernel.org>
 <f4dihh4z2nnkjcpsrmopycm6opellvv4mkpee72xjbn26nw544@sfc4oy6c2xci>
 <a3994a92-0a36-411e-97a3-b01fd406ddd1@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <a3994a92-0a36-411e-97a3-b01fd406ddd1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g6Vk9clacBSaJDCwQ8Hp7hy1FnoZU11g
X-Proofpoint-GUID: g6Vk9clacBSaJDCwQ8Hp7hy1FnoZU11g
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f61eb1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=csQNx8weYdTNeSVC_AYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX1ucFMS9TTshU
 wacLRBNXFWFFBTNzFqp98MmiJQt/lly0/pP1Dehd5ZHvDQieMpjMdCGAxDkgsb45ThXfENwvz2X
 Pw3K+0kVPnhcy0ConxOJuHslUvtHqHF80oBVr7WZrIPSj9o7uIc1SNrGih/HK7MmcrorJiJRhLE
 kOeudJ0KhkbG+sBahJoGcEiv1ZiXDvuir6moDH8zQ/UGxtOHRviXjbzAfmxFMbsYNdIels9xdg8
 I6o22Yy5bq4w2wc7VOEyUXa6wvDSZdc/W9ZzrNPEI2NFcO1OiiUAdlriGLZh1v8+xmr94J+iyqQ
 w7tX1jtCu0CEbZgLVVBhNvpS2LQBkQK/Kojt1oxYAdDScQ/3/YYElWCIR8XLNf+gAOI4i/JOiiB
 8hSQb8kJ3hymfE6ozQLtBIHo+nKjMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023


On 10/20/2025 7:18 PM, Krzysztof Kozlowski wrote:
> On 20/10/2025 13:07, Dmitry Baryshkov wrote:
>> On Sun, Oct 19, 2025 at 07:13:32PM +0200, Krzysztof Kozlowski wrote:
>>> On 15/10/2025 03:53, Xiangxu Yin via B4 Relay wrote:
>>>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>>
>>>> Describe the DisplayPort controller for Qualcomm SM6150 SoC.
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml     | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..935eca23ce6b30b81b3ad778e5fcacc817a230c3 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> @@ -51,6 +51,16 @@ patternProperties:
>>>>        compatible:
>>>>          const: qcom,sm6150-dpu
>>>>  
>>>> +  "^displayport-controller@[0-9a-f]+$":
>>>> +    type: object
>>>> +    additionalProperties: true
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - const: qcom,sm6150-dp
>>>> +          - const: qcom,sm8150-dp
>>> 6150 is compatible with 8150 or 8350? I have doubts.
>> SM6150 has the same DP controller as SM8150. SM8150 is compatible with
>> SM8350.
>
> So if SM6150 is EXACTLY the same as SM8150, then describe it in commit
> msg. If NOT EXACTLY the same, then probably this should be just
> compatible with 8350. Anyway, proper justification is missing.
>
> Existing commit msg is pretty useless, repeat the diff. I can read the
> diff. Commit msg should explain all the background which is not obvious.


Yes, SM6150 uses the same DP controller as SM8150. We already discussed this in
'20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com'.
I will update the commit message to clarify the compatible information and fix
the indentation in the binding example.


>
> Best regards,
> Krzysztof


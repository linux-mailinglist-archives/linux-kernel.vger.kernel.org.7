Return-Path: <linux-kernel+bounces-866226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66356BFF3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8162C19C830C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EF265CA8;
	Thu, 23 Oct 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Huv+d9x9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42A258EE1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196213; cv=none; b=CjGYKyfQgcCq3iYkXnCl1Dva++bUNN+PHu0E1+8/IbmvplcIXxz8VzTS5ngR0EZnHL58vWcZFR53MGgxpJST+7MQqdL8HyVByZnJKM8h47D431EPm5xxfIwPIAPfMlTf5Ihs8baM7CqxaR/2Ayswb3A14XVDnYnDDmd4bWUH4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196213; c=relaxed/simple;
	bh=p/ddS2sSKg4RpCYpXVyJO3QkAfXeZbIVQJ3wGS7uMHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HggcVMTYhFaUvV2zsAmFDNJ9NiQ9iY3Mevld71VqUbxhMhaNCqj9etJmNmozsZg/PuAXJTvOyx0m22p8RVRf7c6wrAgJZ5eFBggqNuA2OL7SiH0aKPgrBruWaKUzWKrd9839ofhjN4evM2ROWLyv8jMxXX+VvHVZYOJc6nZEUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Huv+d9x9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIeme4018576
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sVOpM0zB9ogMep4UsRUJ6puOQkqX/C+l4ebqHw8qJuw=; b=Huv+d9x9qZmGX2fY
	T1LYTYpdJeXxWqNhtzqeaYl/yFlffczKv/uNneHwMQIMjnOlSTn0CVGxeHn6np3w
	6HcqSdWW6tHPa9uLsB2fC4MB9FAEd8URbsJ2x7e8A0+V0SgwMkaIMTOIGQrAivZK
	fp/9qYh4pfTIIm1I6h+qJGJtLOTw4TkpB0x50vU/7HAyWa71yF0N0wtXshu9iIEn
	JoW6o1GOxOL5n4KiPaErGeB0piJJnSYvnlPlT/AhFcHhQNe40Qn4ZwWKrjYl627g
	3uN8RDYjSpBwoR7v0mEaDLvEu58J1VZCR90kcvHWuf8CjPTq/J639jT0YxHvXVJo
	9RQ0xg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqacp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:10:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8bb76ee59so14092111cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761196206; x=1761801006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVOpM0zB9ogMep4UsRUJ6puOQkqX/C+l4ebqHw8qJuw=;
        b=BRPKWCfgYTgEd0YnkyXB/oJtTWTxvRoPW1N7vAUTy5bN8KszWftaZDkJzpZ0K1voZy
         6MiVIQ5eM3YK4l8sUDOtVMR0AnroAUR6HTYdI7Kbp4KlAPcujlKM695r8Js9/TVjQ8po
         IJOhNGDUg4B/PX/3glUgZ9DGz+aIE/ZPnqm9EUKNaN8/BSoa9psHPYRX+V/AFb8S20Yv
         D7K509baOarA4+v3GwrwVYO/gmLUWsykeDYG67u5jg+VFVP5R2GqL9necOqPBiyR7XW7
         MpCk0CrQljasrFU8NUVH/VdRycTEBhB0QuEIMTDqN0Uwt6UAAjxpCa32F641PhNRzrCc
         BByg==
X-Forwarded-Encrypted: i=1; AJvYcCWa/ce5CzMgYHhrF1VxAjlMdPyZrN70McgB4At2VCra//se2xF6ZKFdK9tD8aVydKyLIZLVvMBwmXnP1No=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/6MDvdvrj29FHhYDD7zqpJfwYi6wWWK+ll7qwliogJgq8WUw
	li6sQ9HAIlSX9j4dcUxM6fnuGJzVFMg6Xrnwv0Pjd0ZrKYbDFbLLAzsKxim1XXIh2+9HJdYD4/V
	1HEIJaQ2WzY6NU4hr1l3sEHGIvzgYCIzfmWJShCP4HXWMHqNntFMTLfVBDZBFn3Rj1dA=
X-Gm-Gg: ASbGncuLLdwp02YIO+oB7lv8kPgjUoBwATDK3HLV+TD5z0LEczUVVS6FaOGOdBXSzPX
	tfd2YxiS18gK5VkGvUQAEQbRg686TsQjTo/VhGX6zYOeDcg946tvqQju4gn+KuG6mFAN4KIWBI6
	ydtMDt8XG24kd8fQtu1FQoT4HxNIfPgoWKWGLaWWb5xc31KqrZOR79c1CJzM9m83I98fTsRWH93
	JBwWqEE4gjYlYBwEucr7R9saAsmsFUm3Gi0Umw+n0+PDbqhn4Y/tNSSIvQzW4Qd8Mhkt9TMtWqQ
	BP4pdWbZP0bpC2h9uTvIjbRTMeCm9C1jv7I6QA54ixFN1OLQTBUxWpDIF6tJhwq14ZvxQjIqlEH
	qlMnq6oMVJo3DNORhZ+i836J8dO9JwsApMiQ1tAyTHF4WbS60RgkIKJUZbZSs8mIdJ0rX+5losE
	PlOA==
X-Received: by 2002:ac8:7d14:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4eb815ad563mr17146121cf.68.1761196206307;
        Wed, 22 Oct 2025 22:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElx1ZrpuKVGYGNP7kr8DERnwquHFSi9hHuZxhw/hdjJ0rZpVP7WqU0TbMz0+PNl974FTh0fg==
X-Received: by 2002:ac8:7d14:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4eb815ad563mr17145901cf.68.1761196205810;
        Wed, 22 Oct 2025 22:10:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc50csm1785491fa.41.2025.10.22.22.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:10:05 -0700 (PDT)
Message-ID: <1a787fe1-20ba-42b7-a94e-cd1bf465f16f@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 08:10:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: display/msm: Add SM6150 DisplayPort
 controller
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
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
References: <20251021-add-displayport-support-to-qcs615-devicetree-v5-0-92f0f3bf469f@oss.qualcomm.com>
 <20251021-add-displayport-support-to-qcs615-devicetree-v5-1-92f0f3bf469f@oss.qualcomm.com>
 <fh7daiy5p5taaz7ifymbivfktjqngs5oashhd3osrtzspsac2z@nswaeyh3kkhi>
 <8d4184a8-4e32-43ce-a487-a195e97fa874@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <8d4184a8-4e32-43ce-a487-a195e97fa874@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX/MkZVhDG+VWP
 UVaiIT9pQnNEOyO9y9uouxjjpkCuicaGtgmWxlv8M+FYXmGeFbVuyBcryaSkuvZTlHwUVowItMM
 QuYFU6WRq/v5bUnhqbsF24OcPEpkrnXebbKpURoq227dERqtRLZAfJLJbEt4Pr4cH5g+zE/zQWG
 dAtaPz46DGsvtdNLwI/Gz/SksleH7K2l4r/xbAqvYg+Di8tbQoyfoONJlBjtljzzCn10NYwYnBR
 rKhQ0c5PWx/rcdOEacD/X4R43koiGG3KdsMr1hTU4M4AbdQjPl3UuUW7IGyfW+9M0H2cDOQxvlx
 B35UuCE9V16grDna394EXwdLriNWcNtLSEp/m6VdUIIM+h/F4FMikSaldL4+AzTSJf6kHMmEV04
 AeL/Yu6Q/S+3+qDujjE20Ucq1g6LSw==
X-Proofpoint-GUID: K4e0OlrE-Bey8w3st9KVV7NtQ8FnH5Rz
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9b8b1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=yyiXTTIM6uUZdMJXhTkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: K4e0OlrE-Bey8w3st9KVV7NtQ8FnH5Rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 23/10/2025 07:50, Xiangxu Yin wrote:
> 
> On 10/22/2025 11:07 PM, Dmitry Baryshkov wrote:
>> On Tue, Oct 21, 2025 at 11:18:07AM +0800, Xiangxu Yin via B4 Relay wrote:
>>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>
>>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>>> compatible with SM8350. Add the SM6150-specific compatible string and
>>> update the binding example accordingly.
>>>
>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>> ---
>>>   .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml   | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..89852af70de97a9025079107b838de578778c049 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>> @@ -51,6 +51,16 @@ patternProperties:
>>>         compatible:
>>>           const: qcom,sm6150-dpu
>>>   
>>> +  "^displayport-controller@[0-9a-f]+$":
>>> +    type: object
>>> +    additionalProperties: true
>>> +    properties:
>>> +      compatible:
>>> +        items:
>>> +          - const: qcom,sm6150-dp
>>> +          - const: qcom,sm8150-dp
>>> +          - const: qcom,sm8350-dp
>>> +
>>>     "^dsi@[0-9a-f]+$":
>>>       type: object
>>>       additionalProperties: true
>>> @@ -132,13 +142,14 @@ examples:
>>>                   port@0 {
>>>                     reg = <0>;
>>>                     dpu_intf0_out: endpoint {
>>> +                    remote-endpoint = <&mdss_dp0_in>;
>> Why?
> 
> 
> Oh, I think I misunderstood the “messed up indentation” comment from Krzysztof.
> It seems the two-space indentation under port@X and opp-x is the actual issue.
> 
> However, that part was not introduced in this patch.
> I will split a separate patch to fix the indentation there.

Note, you have two different chunks here. The first one is useless as it 
adds a graph arc to a node that is not a part of the example.

> 
> 
>>>                     };
>>>                   };
>>>   
>>>                   port@1 {
>>>                     reg = <1>;
>>>                     dpu_intf1_out: endpoint {
>>> -                      remote-endpoint = <&mdss_dsi0_in>;
>>> +                    remote-endpoint = <&mdss_dsi0_in>;
>> Why?
> 
> 
> Ack.

Use YAML coding style (two-space indentation). For DTS examples in the 
schema, preferred is four-space indentation.


-- 
With best wishes
Dmitry


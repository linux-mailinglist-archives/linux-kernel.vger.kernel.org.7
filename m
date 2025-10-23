Return-Path: <linux-kernel+bounces-867534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467DC02DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CD0C4EA7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25E34BA54;
	Thu, 23 Oct 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8ABAYx+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B734B1B4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242818; cv=none; b=PBH5tzCFxEIS09tI2wZ/XqyCQrNFajCVWusKo+SHGKQ68ly0IoPWjn2fP29UbqKd51G01uEeXa0cUQXjBjomvzGm+mt+HXHppSMq0txrOs0PZ2lBpIjmjAhNYKQQqx4TyAiYpxsXL0hW1qWZtrR9CAdNOogmqD5R6Jj7J/c26fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242818; c=relaxed/simple;
	bh=GDBnkPexQkkYl2bu0lUEtQtyvIN1sbxzvPo1RR+QT0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1fbG7FvwRBk/VpoNrF+QcqqCgQ4fuCfyl2HU1Tldd2u9cjUWV1Fsc46D3t6+JQJNbHltUjR6uQxefxtktiPR7N00BVu4sw81PSB7QAgXo793NQg9r0q/JS86xl2w6xpVi9uylboX+jRIzi3by9MdtvWplhTQ1w9UMsT/egWbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8ABAYx+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NF16DA027073
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WhgH/IHL/AJ70KJqzso0EUFol6jlfey6+ytRqUhjUk=; b=C8ABAYx+HbFoeNRX
	BwotEdbvwCi7KZYugul2NQv69q9tIxAy9yvUeXU5kXVE6DxqWIMc3ATBpx5pyb+v
	gQoLeckwNwokjs2XF9zg59m5bpVMyfId+wWZqxh7c7WTL0A/1BYmjQ/wikZdZivC
	tCndYGYkZdYDmZvmX+fCFoUDNMgQ5CGHbEL7WsEE9HIjwRyJq/RFIqPadLu+LWBg
	Z4qPEFsJQ6TcWrdmw3MAamlJFy1v0JF7jFq52Bl1NPS/k2sj5fWuCfZsdCnuKlUw
	PL+nbZC3VcCHYZxTKHlD9X6XAAwrzHT1BVZOKsjvK8vDaYj/oAfSil+GhnnFTD+L
	Uybyjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8kkg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:06:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso12449925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242813; x=1761847613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WhgH/IHL/AJ70KJqzso0EUFol6jlfey6+ytRqUhjUk=;
        b=WOg5SvlrJHIQ8v+UxlEkH+tolzsJ8kvVos/U3rPqKCAGokVhThGWTCTSi4YrQg0QvR
         XPQDjtsyK+Yw9un+Jc7OnYCNUdcf0piK4CJjE5GZ/dbC4CMVcE3LEPTioScgl2Or+Nkp
         dD0bXXXQyVLy/LxTEuY8+fmWRqL/bns7sOE1BlRF7fmdswSchTwv1qqW4FXh9SXA75EC
         8j2Dqh+LdA26mWpNUPlQcW0tXi82smXeqeBFaMFzkeBKVY6e1/HVGj0k8BbHkOzkHrqi
         /c5w96M8sVGKx63NSkKwPvSVW9ffxg4RPKFgGUcZLIx3CV89F4JL3kuvf62U6Y4kRbFM
         cTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4SF0LPWOhNfi6IVJ5bwI2flVBq5YZr0kFWyATif9haWJK8Y5nKKhEOqE8ws0QXDRMOZLbieAef/pSIUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAapzNKts49T3qVTcO1qNWW6XOEso8T38oS6dQ+17rgo09wt3D
	8KCS6XHUGR1g9viuTGj3hpUCNcWecu05vYHH1/wRMU3v8rVWdgJ4panIMCth0SIo2tDTKKRnj0U
	Kg0UIMd12Lc/WqbqlK+NO72lFuhYq5ISWuK2ul9aL0yFBOjqXrz5IhA106vq6/DHortk=
X-Gm-Gg: ASbGncuVAagevwVClTjYKy6rpFBxWbHQvPKxSieP5+NpjJkF3WTv/K5Kjnm/KbJWA7C
	tNu3WxjxbWcokwvyi0M/5tIeckbUQZp87s/LBm4zfQ7TwkmgBV3C7FcKtXEUKL+Nm6imPW882s4
	tUOvfJ4IMKIRfwUUi39peEzjiq7cM6ej9DEojwjbtZcFKrDjOwvKXioDHA4NeUGtp9ataQ6IlKt
	cP7TTjAWP6+OsCvWWo/VVTYzMBEgq+1+NSrhQrcoeMK5a5VFPrZJ0yhiWxne8Okb/PDP6yyNgAD
	5o6wmElBfM2aTduGPYgfKBOfQfUkAqQQbCnmsFvDULGYbwTSRmgoc3HwMtPrliafj+ossurKQd7
	ykXjhYsmw/3UCfquLpeBHkhG1XZuYJZC1FtL95HMPIV73wJgUhy2Nxw==
X-Received: by 2002:a17:903:2445:b0:246:80b1:8c87 with SMTP id d9443c01a7336-2946e220396mr41675175ad.43.1761242813356;
        Thu, 23 Oct 2025 11:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSbrj1B330BrfNNugomwZfM5VOdQUAFVqFEpA8S9lTdIDLjXk5Ys5pthq10q2T/aWnS0jpHg==
X-Received: by 2002:a17:903:2445:b0:246:80b1:8c87 with SMTP id d9443c01a7336-2946e220396mr41674785ad.43.1761242812755;
        Thu, 23 Oct 2025 11:06:52 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e243a4dsm30029685ad.110.2025.10.23.11.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 11:06:52 -0700 (PDT)
Message-ID: <c9f5dc86-3e48-44e3-8796-104e0434bbdc@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 11:06:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-2-f5745ba2dff9@oss.qualcomm.com>
 <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
 <1d6a20d8-b011-4608-a722-a1996b366a56@oss.qualcomm.com>
 <b18fc946-a249-481a-b727-7d3e49d47f8e@linaro.org>
 <d4b8cd74-0b0a-4fc8-8ed0-a9023a516b58@oss.qualcomm.com>
 <24b6ce21-aaff-4ecd-8cd7-42df71cfd222@linaro.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <24b6ce21-aaff-4ecd-8cd7-42df71cfd222@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jYHGLsWA6F19mTAuQ_ntsGOT0UO0-lC7
X-Proofpoint-GUID: jYHGLsWA6F19mTAuQ_ntsGOT0UO0-lC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfXyFMfQ7HuLY9y
 sAzl+X4QoAyZaYFVTNQn/KYbcdqvi2x+ihSQAuQDh2MDA6hr+tljsA8je/+3KhT6mhRKJYzT6lM
 W/YOdpgKn9tx/czrdJF/cf5qfOuvyvlkpuBI/BJQfY2e16kn43yQ8OTnr9a9kWUh5bEYFGnbBgc
 wc694KGj+V9Qw/gSwFiLnC6pt3qCnQSmBDfgP3Ahaspwxz2j3SqNVxSCBGl9AC/Pr1xjc7jNQjT
 dO0hp3RbtsfyUKY/zcwwRFwow4qZN8aT9FJ0zSu3HHUteUna24I/ecQq01YsBrZLuRNFmRfrrV+
 UjUu2Gr/l1cwtPa2aTzN1RbxTJO+kFHsP8AKb3sPFOzSp5a4FtIyTtaNudetxw8sy6BspJ/UPlU
 Whi8f+0uZAv2aMsJvcB/jRPYEF8Sqw==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa6ebe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=u1-GT3FIYypCIcOJEnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164


On 10/23/2025 4:13 AM, Vladimir Zapolskiy wrote:
> Hi Vijay.
>
> On 10/23/25 07:52, Vijay Kumar Tumati wrote:
>>
>> On 10/16/2025 5:27 PM, Vladimir Zapolskiy wrote:
>>> On 10/17/25 02:53, Vijay Kumar Tumati wrote:
>>>>
>>>> On 10/15/2025 12:45 PM, Vladimir Zapolskiy wrote:
>>>>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>>>>> Add bindings for qcom,kaanapali-camss in order to support the camera
>>>>>> subsystem for Kaanapali.
>>>>>>
>>>>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../bindings/media/qcom,kaanapali-camss.yaml       | 494
>>>>>> +++++++++++++++++++++
>>>>>>     1 file changed, 494 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>>>> b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..d04c21103cfd
>>>>>> --- /dev/null
>>>>>> +++
>>>>>> b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>>>> @@ -0,0 +1,494 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-camss.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Qualcomm Kaanapali Camera Subsystem (CAMSS)
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>>>> +
>>>>>> +description:
>>>>>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm
>>>>>> platforms.
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: qcom,kaanapali-camss
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 16
>>>>>> +
>>>>>> +  reg-names:
>>>>>> +    items:
>>>>>> +      - const: csid0
>>>>>> +      - const: csid1
>>>>>> +      - const: csid2
>>>>>> +      - const: csid_lite0
>>>>>> +      - const: csid_lite1
>>>>>> +      - const: csiphy0
>>>>>> +      - const: csiphy1
>>>>>> +      - const: csiphy2
>>>>>> +      - const: csiphy3
>>>>>> +      - const: csiphy4
>>>>>> +      - const: csiphy5
>>>>>> +      - const: vfe0
>>>>>> +      - const: vfe1
>>>>>> +      - const: vfe2
>>>>>> +      - const: vfe_lite0
>>>>>> +      - const: vfe_lite1
>>>>>> +
>>>>>> +  clocks:
>>>>>> +    maxItems: 34
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    items:
>>>>>> +      - const: camnoc_nrt_axi
>>>>>> +      - const: camnoc_rt_axi
>>>>>> +      - const: camnoc_rt_vfe0
>>>>>> +      - const: camnoc_rt_vfe1
>>>>>> +      - const: camnoc_rt_vfe2
>>>>>> +      - const: camnoc_rt_vfe_lite
>>>>>> +      - const: cam_top_ahb
>>>>>> +      - const: cam_top_fast_ahb
>>>>>> +      - const: csid
>>>>>> +      - const: csid_csiphy_rx
>>>>>> +      - const: csiphy0
>>>>>> +      - const: csiphy0_timer
>>>>>> +      - const: csiphy1
>>>>>> +      - const: csiphy1_timer
>>>>>> +      - const: csiphy2
>>>>>> +      - const: csiphy2_timer
>>>>>> +      - const: csiphy3
>>>>>> +      - const: csiphy3_timer
>>>>>> +      - const: csiphy4
>>>>>> +      - const: csiphy4_timer
>>>>>> +      - const: csiphy5
>>>>>> +      - const: csiphy5_timer
>>>>>> +      - const: gcc_hf_axi
>>>>>> +      - const: qdss_debug_xo
>>>>>> +      - const: vfe0
>>>>>> +      - const: vfe0_fast_ahb
>>>>>> +      - const: vfe1
>>>>>> +      - const: vfe1_fast_ahb
>>>>>> +      - const: vfe2
>>>>>> +      - const: vfe2_fast_ahb
>>>>>> +      - const: vfe_lite
>>>>>> +      - const: vfe_lite_ahb
>>>>>> +      - const: vfe_lite_cphy_rx
>>>>>> +      - const: vfe_lite_csid
>>>>>
>>>>> The list of 'clock-names' values is not alphanumerically sorted.
>>>>>
>>>>>> +
>>>>>> +  interrupts:
>>>>>> +    maxItems: 16
>>>>>> +  interrupt-names:
>>>>>
>>>>> Missing empty line to separate properties.
>>>>>
>>>>>> +    items:
>>>>>> +      - const: csid0
>>>>>> +      - const: csid1
>>>>>> +      - const: csid2
>>>>>> +      - const: csid_lite0
>>>>>> +      - const: csid_lite1
>>>>>> +      - const: csiphy0
>>>>>> +      - const: csiphy1
>>>>>> +      - const: csiphy2
>>>>>> +      - const: csiphy3
>>>>>> +      - const: csiphy4
>>>>>> +      - const: csiphy5
>>>>>> +      - const: vfe0
>>>>>> +      - const: vfe1
>>>>>> +      - const: vfe2
>>>>>> +      - const: vfe_lite0
>>>>>> +      - const: vfe_lite1
>>>>>> +
>>>>>> +  interconnects:
>>>>>> +    maxItems: 2
>>>>>> +
>>>>>> +  interconnect-names:
>>>>>> +    items:
>>>>>> +      - const: ahb
>>>>>> +      - const: hf_0_mnoc
>>>>>
>>>>> Please rename "hf_0_mnoc" to "hf_mnoc", see qcom,qcm2290-camss.yaml
>>>>> etc.
>>>>>
>>>>>> +
>>>>>> +  iommus:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  power-domains:
>>>>>> +    items:
>>>>>> +      - description:
>>>>>> +          TFE0 GDSC - Thin Front End, Global Distributed Switch
>>>>>> Controller.
>>>>>> +      - description:
>>>>>> +          TFE1 GDSC - Thin Front End, Global Distributed Switch
>>>>>> Controller.
>>>>>> +      - description:
>>>>>> +          TFE2 GDSC - Thin Front End, Global Distributed Switch
>>>>>> Controller.
>>>>>> +      - description:
>>>>>> +          Titan GDSC - Titan ISP Block Global Distributed Switch
>>>>>> Controller.
>>>>>> +
>>>>>> +  power-domain-names:
>>>>>> +    items:
>>>>>> +      - const: tfe0
>>>>>> +      - const: tfe1
>>>>>> +      - const: tfe2
>>>>>
>>>>> Please remove all 'tfeX' power domains, they are not going to be
>>>>> utilized
>>>>> any time soon.
>>>>>
>>>>> When 'power-domains' list is just a single Titan GDSC,
>>>>> 'power-domain-names'
>>>>> property is not needed.
>>>>>
>>>>>> +      - const: top
>>>>>> +
>>>>>> +  vdda-pll-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
>>>>>> +
>>>>>> +  vdda-phy0-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>> +
>>>>>> +  vdda-phy1-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>> +
>>>>>> +  vdda-phy2-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>> +
>>>>>> +  vdda-phy3-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>> +
>>>>>> +  vdda-phy4-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>> +
>>>>>> +  vdda-phy5-supply:
>>>>>> +    description:
>>>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>>>
>>>>> What is the difference between vdda-phyX-supply properties, why do 
>>>>> you
>>>>> need so many of them, when their descriptions say they are all the
>>>>> same?
>>>> Each of these supply power to a specific CSIPHY and could be different
>>>> based on the board architecture. But I agree that the description 
>>>> should
>>>> probably capture that than just relying on the name.
>>>>>
>>>>>> +  ports:
>>>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>>>> +
>>>>>> +    description:
>>>>>> +      CSI input ports.
>>>>>> +
>>>>>> +    properties:
>>>>>> +      port@0:
>>>>>
>>>>> Please use
>>>>>
>>>>>       patternProperties:
>>>>>         "^port@[0-3]$":
>>>>>
>>>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>>>> +        unevaluatedProperties: false
>>>>>> +        description:
>>>>>> +          Input port for receiving CSI data on CSI0.
>>>>>> +
>>>>>> +        properties:
>>>>>> +          endpoint:
>>>>>> +            $ref: video-interfaces.yaml#
>>>>>> +            unevaluatedProperties: false
>>>>>> +
>>>>>> +            properties:
>>>>>> +              clock-lanes:
>>>>>> +                maxItems: 1
>>>>>
>>>>> Please remove 'clock-lanes' property, it is non-configurable, 
>>>>> redundant
>>>>> and tends to store some irrelevant value.
>>>>>
>>>>>> +
>>>>>> +              data-lanes:
>>>>>> +                minItems: 1
>>>>>> +                maxItems: 4
>>>>>> +
>>>>>> +              bus-type:
>>>>>> +                enum:
>>>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>>>> +
>>>>>> +            required:
>>>>>> +              - clock-lanes
>>>>>
>>>>> The 'clock-lanes' property is expected to be removed.
>>>>>
>>>>>> +              - data-lanes
>>>>>> +
>>>>>> +      port@1:
>>>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>>>> +        unevaluatedProperties: false
>>>>>> +        description:
>>>>>> +          Input port for receiving CSI data on CSI1.
>>>>>> +
>>>>>> +        properties:
>>>>>> +          endpoint:
>>>>>> +            $ref: video-interfaces.yaml#
>>>>>> +            unevaluatedProperties: false
>>>>>> +
>>>>>> +            properties:
>>>>>> +              clock-lanes:
>>>>>> +                maxItems: 1
>>>>>> +
>>>>>> +              data-lanes:
>>>>>> +                minItems: 1
>>>>>> +                maxItems: 4
>>>>>> +
>>>>>> +              bus-type:
>>>>>> +                enum:
>>>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>>>> +
>>>>>> +            required:
>>>>>> +              - clock-lanes
>>>>>> +              - data-lanes
>>>>>> +
>>>>>> +      port@2:
>>>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>>>> +        unevaluatedProperties: false
>>>>>> +        description:
>>>>>> +          Input port for receiving CSI data on CSI2.
>>>>>> +
>>>>>> +        properties:
>>>>>> +          endpoint:
>>>>>> +            $ref: video-interfaces.yaml#
>>>>>> +            unevaluatedProperties: false
>>>>>> +
>>>>>> +            properties:
>>>>>> +              clock-lanes:
>>>>>> +                maxItems: 1
>>>>>> +
>>>>>> +              data-lanes:
>>>>>> +                minItems: 1
>>>>>> +                maxItems: 4
>>>>>> +
>>>>>> +              bus-type:
>>>>>> +                enum:
>>>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>>>> +
>>>>>> +            required:
>>>>>> +              - clock-lanes
>>>>>> +              - data-lanes
>>>>>> +
>>>>>> +      port@3:
>>>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>>>> +        unevaluatedProperties: false
>>>>>> +        description:
>>>>>> +          Input port for receiving CSI data on CSI3.
>>>>>> +
>>>>>> +        properties:
>>>>>> +          endpoint:
>>>>>> +            $ref: video-interfaces.yaml#
>>>>>> +            unevaluatedProperties: false
>>>>>> +
>>>>>> +            properties:
>>>>>> +              clock-lanes:
>>>>>> +                maxItems: 1
>>>>>> +
>>>>>> +              data-lanes:
>>>>>> +                minItems: 1
>>>>>> +                maxItems: 4
>>>>>> +
>>>>>> +              bus-type:
>>>>>> +                enum:
>>>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>>>> +
>>>>>> +            required:
>>>>>> +              - clock-lanes
>>>>>> +              - data-lanes
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +  - reg-names
>>>>>> +  - clocks
>>>>>> +  - clock-names
>>>>>> +  - interrupts
>>>>>> +  - interrupt-names
>>>>>> +  - interconnects
>>>>>> +  - interconnect-names
>>>>>> +  - iommus
>>>>>> +  - power-domains
>>>>>> +  - power-domain-names
>>>>>> +  - vdda-pll-supply
>>>>>> +  - vdda-phy0-supply
>>>>>> +  - vdda-phy1-supply
>>>>>> +  - vdda-phy2-supply
>>>>>> +  - vdda-phy3-supply
>>>>>> +  - vdda-phy4-supply
>>>>>> +  - vdda-phy5-supply
>>>>>
>>>>> Please exclude supplies from the list of required properties.
>>>> One of these supplies is required based which PHY the use case is 
>>>> being
>>>> run. Can you please advise how to handle that? Thanks.
>>>
>>> 1. Please rename all of them, reference to qcom,x1e80100-camss.yaml,
>>> qcom,qcm2290-camss.yaml or published on linux-media
>>> qcom,sm8650-camss.yaml
>>>
>>> 2. Remove all of them from the list of required properties, and in a
>>> board
>>> specific dts file add only the neccesary ones, that's it.
>>>
>> Thanks. We will try to follow the same for rev3. Just a caveat though.
>> If, for instance, two CSIPHYs have different 1.2 supplies and they are
>> required to be operated concurrently, it may be is a problem? as we can
>
> It should not be a problem, you can add two regulators, and it's fine,
> anyway all of them shall be optional properties, because it's unknown in
> advance which ones are actually needed.
>
>> put only one of those in the board specific DTS for the 1.2 supply node
>> (ex: vdd-csiphy-1p2 in SM2290). Is it not? However, if we don't have
>> such a use case requirement on the upstream may be it's OK. Thank you.
>
> Link to the published SM8650 CAMSS dt bindings, please follow this model:
> https://lore.kernel.org/linux-media/20251017031131.2232687-2-vladimir.zapolskiy@linaro.org/ 
>
>
> Please note the chosen naming scheme, when the supply property names
> follow the SoC pad namings one to one.
>
Thanks @Vladimir. Yes, this make sense if all of the reference and 
customer boards follow the internal power grid design. But agreed that 
this is all board specific. Please let us know your thoughts on the v3 
bindings for KNP. They mimic the existing 2290 and x1e80100 bindings. 
Thank you.


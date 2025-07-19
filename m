Return-Path: <linux-kernel+bounces-737447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC1B0ACBB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FEF1AA7F32
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6D19BBC;
	Sat, 19 Jul 2025 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogcVf+1M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B082110
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884223; cv=none; b=ht7JEqS9mrLAKFyhTCa+wLBlrlH3phJAR6Xt2ZOMs3sctwcsldq3FuQvd9imhzDreinDqELrWj1x0uobmpFQEBdT5znplAtDCZ+kjdObqxc8Yf1KEMv21HcFLY5HhhStFleAzTKta+H62rR2e5rR1IWPOgqq/zvxuFwiHcqdWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884223; c=relaxed/simple;
	bh=Lh0eZCPgPq794kh8u1sZbkVoI2rhofVGnEq+Pvobvzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2tZAMiZjkE8onsjVfYda42RKd9Hj30PxFw0EMg0UYvLywjruGsRCgBBsJY3/kfil9LECoKmOR2r3CQ25EddaV/JwrP2n37GSplZJOumpgfcfajPjlxV3G5/TA02MWMkHuiZD8S6PZ0lLbC/FrsIifAa5bcO696m85yocQiD5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ogcVf+1M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IM0l8Y020538
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nuzVlXIUuXiwaB1rXnj3/BisM57GE6oPUvR/VRrQ9ko=; b=ogcVf+1Mi2RJjWsm
	N4/bxGhDxJWgZEmBOPRgtXkG6XeX0sqcmyGhMFNYk+olWF3MPuliVDBYQRQfFtIZ
	3C/k+l68y/QjhuoTTllfs6oDHg4syZVN9BBwe3VaPqYIvKnmdfY844ZEcOZWnTPo
	uRGU8a6h2Xk7ATsmk8MMQBrsNPmRGh/ThBgtZ74HevpdHxQeRR+2rfI5nxZDgc1t
	1XEXuLaqG+h26EhrHWTDlu5xTJhwBVJakYvvZ70dlilfV9v3DTRZviZRt8yZO70z
	jjVRYENQmAaetturbXa+O3691tdeP8ROS8SsxPjww+iyDdOBchUDb9HEfXTAfT6c
	pCAlOw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc563u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:17:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so2295958a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752884220; x=1753489020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuzVlXIUuXiwaB1rXnj3/BisM57GE6oPUvR/VRrQ9ko=;
        b=Na4ysMnpPvD+YYzem/zFHfAmShDIQYFQaZDE7Jt09QwlBFMtY5EdnkAHu0EOTNcbor
         u+6vQi2DECh2fbqe2c7g3Qir+3mmnoTfNaHgB4qD9meL8yuWUQMJ0g+5Rn/OqIbO7Kl5
         WqV/8J2vHiDGwGLs8Oi6dEaH2c1u8pISPCsi+4IgbQJVE1t9CzAZVXx0SJbz7xpqCqnB
         xfxZclVAoQE+lByQRJfXQVMZf82oDXWxea240KkU4vVCKM16IanZugPHPds6SeOdzQwJ
         pE/ooRvlxWtfNoxEDesvMZqb/gKdW11/lj4CUEDGPmCELmEmcfphSHZzMOlZEMiWd5Kb
         /Qrw==
X-Forwarded-Encrypted: i=1; AJvYcCVkdqvevAnrge7ApGfTZqoxcGQa6Git+gy3r55gDCowCy0ufS4LP4sqrLW0LaQz6JxaI1ZzvaGBdEetEb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fOcRy1owvhcVYZ58oI1f00ZcDFxT29cRVGJ1y07jGdbaquV/
	jrUYRyTjdltIPG9ga0DRgXEZQlght+qpm4/vfWrmFNgyfXi9ZYDZ1cZ7T16gz04KeCLmzHmOw6x
	X3BJONwOUDx0s1qSE3NyY9m3ZV7odNWXWXpif4ZZ4Tfg/OEGrR9wBjxBAtiG//McAXsc=
X-Gm-Gg: ASbGnctjqohNfJ+2ZwBduX+8Tpl8q7jidDz6rExI+jf79/O9cBbEDcuRqM0NSBF4BvC
	NkRtwepPO9XSQVS/janpJGXRdY/eJfhu0f9AE2haksjLAj/h72yP+8r5RNYvU0rzDwbQ0f7V58B
	9RzHHQKkQMcHFlB8tVb32qg3pdcg1DGmgQQPsRnSrUQPhSZD/k30MVx8su2Oy4KlEg7HJuhDq93
	1HlflDiD5XOiIxqS483Z8gY/m22tiBkGIQEmxQeVVA0K9gmkvdnpBTMRPbrhFalUT8XhrHayLg6
	wgfTHT3sPpqWVbA7RwpWgG0xAJR7oGMzrxMS/qpgLEW1bIGBqo5Ve3iV3ZhNPDJESYh4XDv0yoy
	hxb+j4g2Cff/xjQhrfuaSLw==
X-Received: by 2002:a17:90b:5385:b0:31a:bc78:7fe1 with SMTP id 98e67ed59e1d1-31c9f42ea51mr19843798a91.18.1752884219735;
        Fri, 18 Jul 2025 17:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZU0AEoPTJMZYugSgAQPqMLAHd7s8fV5oFYzAqjw2f8AX6fmugw7QfAMkMHVcutfa9ueugdA==
X-Received: by 2002:a17:90b:5385:b0:31a:bc78:7fe1 with SMTP id 98e67ed59e1d1-31c9f42ea51mr19843760a91.18.1752884219178;
        Fri, 18 Jul 2025 17:16:59 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b038sm1959290a91.10.2025.07.18.17.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 17:16:58 -0700 (PDT)
Message-ID: <1b385a59-5461-4c28-855e-d2379c2a8173@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 17:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: Fixup x1e80100 to add DP MST support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov
 <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
 <unwinuwoft6sfczcjlqq5kijss3ttggfbobs6ydw5c2lkmndc6@7c23jntiprob>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <unwinuwoft6sfczcjlqq5kijss3ttggfbobs6ydw5c2lkmndc6@7c23jntiprob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687ae3fc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EOe-Aop8_12Esa9JHLYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EW-oTpvmdUfBcxcAOIyD4QguNGsnxJtd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDAwMCBTYWx0ZWRfX+wtL0HzGtwvw
 d0454sD1xb2HTLyx8qunGC57UcBVsYuftigG4ebMYeiadKc9jHVMX+lSP/I8TeP1013X3fEGZvt
 6yH9FYI+N6dkjQ5OVwIOdJNoGYivMTjcrO3UzEZAkNrRjGEB2Aj5n/bzrJEgjbJ8edt0p0NIRL+
 SslW0qo8LCDoHHPyAC4Y59i7g9NkKzgcG9SnjiHmzIL/rqA7rtiVfK4zYuWncBkDGm37VEjOZza
 MCBHSSpRDiGjmn6EJaMVWWYBxJ5++w2AR8ttps3mvuN22Ykquqo+80ZgLsD0Ilv0YRJ0OrVEEcZ
 cSs3H3qvlkptVWT8QuWe90SJ1eAs26uB8ljSxDt17C5DDCbxI16LPg7mRp11qJ7dG0tcczEGUE8
 21jUgmRtjefVCSUnaD8ZupHIeZ+QmvrGfn79H11GkuaGeI50GYZMLUdx4p2hia74q/7d0lqQ
X-Proofpoint-GUID: EW-oTpvmdUfBcxcAOIyD4QguNGsnxJtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_06,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190000



On 7/18/2025 2:13 AM, Dmitry Baryshkov wrote:
> On Thu, Jul 17, 2025 at 04:28:43PM -0700, Jessica Zhang wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Please fix the patch subject.

Hi Dmitry,

Ack.

> 
>>
>> Add x1e80100 to the dp-controller bindings, fix the
>> displayport-controller reg bindings, and drop
>> assigned-clock-parents/assigned-clocks
> 
> Why?

IIRC issues with the x1e80100 dp-controller bindings (i.e. the reg 
bindings) weren't being picked up by dtschema because the x1e80100-dp 
compatible string wasn't in dp-controller.yaml.

I can add this to the commit msg after moving the 
assigned-clocks/clock-parents change to patch 3.

> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/display/msm/dp-controller.yaml    |  2 ++
>>   .../bindings/display/msm/qcom,x1e80100-mdss.yaml          | 15 +++++----------
> 
> Split into two commits.

Would it be better if I kept the compatible/reg bindings fix in this 
commit then squashed the assigned-clocks/clock-parents change with patch 3?

Thanks,

Jessica Zhang

> 
>>   2 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 9923b065323b..4676aa8db2f4 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -29,6 +29,8 @@ properties:
>>             - qcom,sdm845-dp
>>             - qcom,sm8350-dp
>>             - qcom,sm8650-dp
>> +          - qcom,x1e80100-dp
>> +
>>         - items:
>>             - enum:
>>                 - qcom,sar2130p-dp
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
>> index 3b01a0e47333..0e699de684c8 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
>> @@ -170,11 +170,11 @@ examples:
>>   
>>           displayport-controller@ae90000 {
>>               compatible = "qcom,x1e80100-dp";
>> -            reg = <0 0xae90000 0 0x200>,
>> -                  <0 0xae90200 0 0x200>,
>> -                  <0 0xae90400 0 0x600>,
>> -                  <0 0xae91000 0 0x400>,
>> -                  <0 0xae91400 0 0x400>;
>> +            reg = <0xae90000 0x200>,
>> +                  <0xae90200 0x200>,
>> +                  <0xae90400 0x600>,
>> +                  <0xae91000 0x400>,
>> +                  <0xae91400 0x400>;
>>   
>>               interrupt-parent = <&mdss>;
>>               interrupts = <12>;
>> @@ -189,11 +189,6 @@ examples:
>>                       "ctrl_link_iface",
>>                       "stream_pixel";
>>   
>> -            assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
>> -                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
>> -            assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
>> -                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
>> -
>>               operating-points-v2 = <&mdss_dp0_opp_table>;
>>   
>>               power-domains = <&rpmhpd RPMHPD_MMCX>;
>>
>> -- 
>> 2.50.1
>>
> 



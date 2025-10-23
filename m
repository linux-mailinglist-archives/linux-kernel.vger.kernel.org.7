Return-Path: <linux-kernel+bounces-866527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2C8C00021
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025274E1BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F4302776;
	Thu, 23 Oct 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZVvmyj4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4662F6563
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209422; cv=none; b=TdxkCqIk5UzfDpOzW/2QLgnsNxBaq3sWjTftY/Jd3iPAvdjdq4jlZNr+OmcKe5HjFRkEom/5lsWaeblv0Q4GA1mfb31MB3aipn5GvI7nallEg9SaB3hz6BRQKQFymMaJmFxO71d219w8bMCk4f546hTN/c8xw7ZyfXSHoAZnp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209422; c=relaxed/simple;
	bh=OMKnxUqr9ND8NblLPWP0eOPZ9cYwdnsAwoYbevDZ5+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRlzt35bm/Nr2JxPkW+6wnvdsPW2kRwlKim/teElBvz62tI5lFQqFpim4GFDngq2Rb/At2huBMsUsYtgcA5hFQmFjYyTplnvidX25bzU9/jAbQzfgGdOp1ebQLk64LrXot5wo89RPwJR28bT+lq1zf4EUvETjgdYG6LoW3OtLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZVvmyj4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7fR6e011853
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OMKnxUqr9ND8NblLPWP0eOPZ9cYwdnsAwoYbevDZ5+4=; b=EZVvmyj4uFp0R2fV
	JeJ9KNrnXx/83rEAEnhbduhhXJ99Kz9VB4IwkB44smUXQJ61Ej3uHLYIhjIfg+Ka
	o20JMyUGs7c0tnD/nCdncT1JC0H+FFnLrKXrVoSrAMx3CDt9ZOaUX9HNlkKRy1iO
	BULRdNblK2EJ+nquSe8IbbkIivsTwtz+mWS+MP28n3A7Ep6uKFWOMSuwNLk5TAU7
	k6g1juL89YU+pgWjffzdYbirvq7TA6Lv2le6RLIPepwMfPHEdyiOSU80GcNxDfAQ
	wVL1P9MRhAmwWeSakT9qRIXYNQwbijIVCTFHgNyu9pRAkQzp5Kd0veskwt1eVe2o
	DTFQYg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5249vje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a272da5676so209327b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209417; x=1761814217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMKnxUqr9ND8NblLPWP0eOPZ9cYwdnsAwoYbevDZ5+4=;
        b=VZGZrUctrpGA5KFTv9TD15cbV4sMKcebmnTPlwayOEf7kDVTqhDGrdrqGsJGPiHytd
         AI23tScjGtJl3lYuPCRpjr5N2BGMW9JVLSENqxPJ85TjdpLWUqJjS7bzz/Xb/2/V41/e
         IQV15gEavwQ3OlfflOaraSKlI6696YsMGobBDiLpcJc55CYOSpnxcdGO++NcI8G0/VoT
         zwA7DeA2c3lHiCPx8DmAi7ba6rhRNnV16jQ4IFOZXdhIpg88rj5uvi14UgZzHGMoKDOE
         eGCZyPZpYhz593JDDRIi2jBFnzIU37UYMcFb/Cv5rsSQHl19Ug1kB+g1Ql1lRqMRaEAu
         WnyA==
X-Forwarded-Encrypted: i=1; AJvYcCWvjtyf9GP9fj46FqjDF12XH/NcocXtyk4dWd1NNw/qWPVaIdW4lK0MRIpYbqtSSxK+mkhI+33PmUSGpBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDWMTf/YR7mPSPV3VL41wk6fyrmJ/DJ073kzFOeer02+FL+4I
	tbpN94bxNSYSMWD+6LVcTzvuB6rRtsXw73RXGpAfy147fhgIBq42VbZ+ErHULim1T6SIOcNyhOK
	CIq1i90L7Kt2/8FvuFmg3EULEYdSenqtMT8yipeCvj/LzsBcD4ZRx1GV2HpX45zQX9zQ=
X-Gm-Gg: ASbGncsVfCwAWUSn8RVWCnx5Gex/GwPjAUlIKWG0x+ZIrWqwR1xcU1CwtJvlhufl1Ng
	R04C5PzdIA2bd0kKHZMv31NUOPIxSI5fOkQBQscsp2hSMWTW1V7VKW5Bqw0V7pEHdYog6+rJFjv
	FVRbFg90sazx4YEt4Tr/EER3+1X8AH4dPSHcDVim+auHy//J6RDkYQO0wYB1LP/phFRCtMJOgv3
	c+L3o/HDTDThVAobdcRgqig5YHJOYJbOtI2Ta3d8EMLLggLqJ6SDWkCteaQMi1trecHM0ikUMRT
	KQUxAegYApWAp9zVr1OBKtd/J7zNN6azHJxawF5E7lMHnbT6KtzON1+9PrhOQXqxRUhXcPdMmXo
	4KXH9BcG4bZKKNQX9DHfylZARgqLEjSTnecUh83/gpGYA/YLDfSPwHDz+KEjQfaCAdzuvXA==
X-Received: by 2002:a05:6a20:d80a:b0:2b0:ff55:f838 with SMTP id adf61e73a8af0-3393189436bmr6910803637.3.1761209417386;
        Thu, 23 Oct 2025 01:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMne+EgLkcUdrIkI1VqQAldalOI3LplCWH+quMwYft+tzjn4ldU/yUSpq3PbB/3w7ARbB6QA==
X-Received: by 2002:a05:6a20:d80a:b0:2b0:ff55:f838 with SMTP id adf61e73a8af0-3393189436bmr6910774637.3.1761209416844;
        Thu, 23 Oct 2025 01:50:16 -0700 (PDT)
Received: from [10.133.33.163] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a5fe26sm1800703b3a.2.2025.10.23.01.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:50:16 -0700 (PDT)
Message-ID: <d048a875-aaa7-4db2-9ef0-daab94bc123d@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 16:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: display/msm: Add SM6150 DisplayPort
 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <1a787fe1-20ba-42b7-a94e-cd1bf465f16f@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <1a787fe1-20ba-42b7-a94e-cd1bf465f16f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX9fi3/+eXJWmT
 281Vc/yWfTPcXP6LwKEKmSbV8UgvO3nUhU5oYUiZ1vE/BRyIq4YghJ+gE8yclzF9Jiobs641yGK
 em5yVKCvua3j0HhpB8TVHc6ArvZQgdu6pKmiE81znjyM1rZF/h30hx+DBeF6ByRnG4gDVWRyZcW
 qgnu0UaxWhGRRiPXTcovleLFb+oJhDV5MSEnI/9eSvTcGt2zS/qWOJ3Xevgvb3Z7cHwdIeO1GLI
 vdC6pDFji7ppfEAmELIGpvs8dLBx4AnVmP2pdw7diWSXZ/gC0pSLwY3B0+rLdhGhbIfx/HuHAkT
 84VKeXiB3n26tRsImmOEEefnTzbezz00H4tQO/3tQYFmbn/UXjZpLY9bPgj0n/JLwQh6AXk/RCB
 5/RHPbGtqLp8XHlaa3ZWd/GW52jQog==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68f9ec4c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Yf0QdHFY1VziTJGLG10A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Mj5zokaBeHumYjcKxAtqHDVZlS6jW0Ba
X-Proofpoint-ORIG-GUID: Mj5zokaBeHumYjcKxAtqHDVZlS6jW0Ba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155


On 10/23/2025 1:10 PM, Dmitry Baryshkov wrote:
> On 23/10/2025 07:50, Xiangxu Yin wrote:
>>
>> On 10/22/2025 11:07 PM, Dmitry Baryshkov wrote:
>>> On Tue, Oct 21, 2025 at 11:18:07AM +0800, Xiangxu Yin via B4 Relay wrote:
>>>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>>
>>>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>>>> compatible with SM8350. Add the SM6150-specific compatible string and
>>>> update the binding example accordingly.
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>   .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml   | 13 ++++++++++++-
>>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..89852af70de97a9025079107b838de578778c049 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>>>> @@ -51,6 +51,16 @@ patternProperties:
>>>>         compatible:
>>>>           const: qcom,sm6150-dpu
>>>>   +  "^displayport-controller@[0-9a-f]+$":
>>>> +    type: object
>>>> +    additionalProperties: true
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - const: qcom,sm6150-dp
>>>> +          - const: qcom,sm8150-dp
>>>> +          - const: qcom,sm8350-dp
>>>> +
>>>>     "^dsi@[0-9a-f]+$":
>>>>       type: object
>>>>       additionalProperties: true
>>>> @@ -132,13 +142,14 @@ examples:
>>>>                   port@0 {
>>>>                     reg = <0>;
>>>>                     dpu_intf0_out: endpoint {
>>>> +                    remote-endpoint = <&mdss_dp0_in>;
>>> Why?
>>
>>
>> Oh, I think I misunderstood the “messed up indentation” comment from Krzysztof.
>> It seems the two-space indentation under port@X and opp-x is the actual issue.
>>
>> However, that part was not introduced in this patch.
>> I will split a separate patch to fix the indentation there.
>
> Note, you have two different chunks here. The first one is useless as it adds a graph arc to a node that is not a part of the example. 
>

You’re right, I verified with CHECK_DTBS and it passes without it,
so I’ll drop it in the next version.


>>
>>
>>>>                     };
>>>>                   };
>>>>                     port@1 {
>>>>                     reg = <1>;
>>>>                     dpu_intf1_out: endpoint {
>>>> -                      remote-endpoint = <&mdss_dsi0_in>;
>>>> +                    remote-endpoint = <&mdss_dsi0_in>;
>>> Why?
>>
>>
>> Ack.
>
> Use YAML coding style (two-space indentation). For DTS examples in the schema, preferred is four-space indentation. 
>

Ok, will add a new subpatch to fix DTS example indentation.




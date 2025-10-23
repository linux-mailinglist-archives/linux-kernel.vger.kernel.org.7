Return-Path: <linux-kernel+bounces-866207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3ABFF2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35AE034F476
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E0242D95;
	Thu, 23 Oct 2025 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nIcSRWEF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E235063
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195013; cv=none; b=cZjQgNq7zNsGWovc3xrwv5XU2tW0Kdx+WDc6AwRfsQOnxgnzdwVoRpZKTItqh5oW+vJSypYIisc1xZiqqXwEVsAPqxLTzafDO+8Mtjm0VGdNCwjD5yx9eX1M6WyYdQjOQfzC2P+WiSpZ6puJBBoiX1JroVuEfBm2hyAAK2G/+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195013; c=relaxed/simple;
	bh=pUxLY0dYOpUEVJeLtaYHGI3zA5xCDpr07EK9bK62Xg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcW5RX9A+wolaEsAyL5lrzlDRs1NU8Lcf7MXlYC3jEQEt2B8RYKns9sNgoSTj0mJ6AB6KK6vEqUpDrQhrb/nw6okK89GedVN/KMLW7QM02Jjjvsjja9+SeaiEqdHJh9T5y8osDT+ID+swWWCrJj9lHl0m6dp++F89D6yG0SNFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nIcSRWEF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIequo026532
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ILH2Noyb/0pcF89WfVFMs9McJHKzcr01cOg5psDy5yo=; b=nIcSRWEFb7aEhO+D
	q6Z+7bd6h3rxMt5LxnPxQbTmDBCYHOqF0a2m5IO2Vml819e6lWWsUDbj769GE+t7
	CF08aLfjQ7L7kOMh1odWpJKIfP9yMfnGanczhZ12rJ94HMu+5XiAS14Qgg3Oy52L
	d6BwRafCPlqhx8CM/S2fl7yUpxcENWIX8JGV0qhyKzdsdPq0ySH9aL3qau+/RKbI
	6fzTJGkcyjKkqlH39vRh/MMKnzcuIVNTkdgfhf683FlPFdyWYxDoTBZIgBZWOI9U
	CNcY4Gg57FZgQX2DK973udaTKSnCHW5h/C+hyxt+3FEjskbSCQ7/WUKZX7cARB+2
	JaPl1w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42keuxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:50:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2698ede62c2so1447915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195009; x=1761799809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILH2Noyb/0pcF89WfVFMs9McJHKzcr01cOg5psDy5yo=;
        b=xL7hb1R532oDoEZXVlcRuVqBdF3LfFQsFGukyfaArz8cEu/0PfmVSaBtcY67HR/Csb
         QQnL26fY8qaeiN35SeKNd6pKGFrBsj+FNuULfnoitPPA/JVq6WjNf5HsJWicOtpi52FD
         5v5xTanBTG45hES7Wd2VgqhT0rhUBra1eomY1Pjz5ZUZk9h8Ua6RJt2Lc9eIzTEP5RN8
         3O0mOoMaHdO4Cu8Q/Lpb7+C7rBcXSJp20GhyeZmsfi+1ubSkCbqfBmchXJgHJik/O8yq
         kjci1QolYyn5y6jRrQj9l7ZAszmM3gZUnf/aMmjl1Mlky7gBK3hRg6Jf4klnKpoEsyBh
         HdYg==
X-Forwarded-Encrypted: i=1; AJvYcCXDwz+soHjGm1qx45TDv3QMd2VQ99cvAC9S0f/rH02eyaH+4yC1dKWOt1P+9eKlOhf9eRQG/dQeAx25rUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCZ3lAjIE+/lGIQ3vhlln8Fm/pcD+QgoXoaobKAQOqUO30d7C
	sWbQPPS7RveG4zj2XGgDCEstSaqrb6usceBPL9TLPhx+MjABnPK+LWr65t6ms1wkfPD9GplJpdE
	ln5doAvxdb9DsYlbldclCnTtXte7SL7NoDunflbRVLWj9AdrSbqQTqr+7mOJg1G3PzLM=
X-Gm-Gg: ASbGncubSOKKJOdf5rPTuUMIJed4AXH+AW2CzBsEG2Hbp+SaQgEYUYOuWFdlN3rQos0
	kYQgesn4afF9LtCUqIzBvO2HC1WgLZjk98u3IlcjcMcur8TjfHOLY4IDhoc4BUdqKTjFU2fx5Vk
	YVH6nDa4BYhrcSeenx1sUDnGzcYp86Fmlulwu5gdyxEStZ5GBsgRc9e2dFRA1fyYl+0Ra08KtiN
	/fLKyS4BlFhtjAqujGdMrklEcJob6muS722R+/i28YQ5xpmX2yCwLT+lbt8Qem+ZbN5dN5h3gG2
	s8rBazukgigfE7D6cjBNpeCf1A0g9/Y6RQzQdK6SapawLcENNX+CqLFfxYppddONh+0TDSjA7m0
	EgnwXXshs4qAovs0hNlsl0l6ycJYTsmFjz0Rnpim6A2gXbt8XVnWSZDWNUxzNgOF3+8DDmA==
X-Received: by 2002:a17:902:cec2:b0:261:500a:5742 with SMTP id d9443c01a7336-292d3fd9a38mr72508845ad.10.1761195008580;
        Wed, 22 Oct 2025 21:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJqjQ5VJXt3VI85Iu5u10F0hg2Fj8UlcAw7hs/Onz/30KSLJIC0RZtQJ73mpgOW8HVaN7wLA==
X-Received: by 2002:a17:902:cec2:b0:261:500a:5742 with SMTP id d9443c01a7336-292d3fd9a38mr72508645ad.10.1761195008139;
        Wed, 22 Oct 2025 21:50:08 -0700 (PDT)
Received: from [10.133.33.163] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946f681eabsm7873065ad.15.2025.10.22.21.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:50:07 -0700 (PDT)
Message-ID: <8d4184a8-4e32-43ce-a487-a195e97fa874@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:50:00 +0800
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
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <fh7daiy5p5taaz7ifymbivfktjqngs5oashhd3osrtzspsac2z@nswaeyh3kkhi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xoMp0Vbf2q8oNGUo_DYvR4BN-9tHum12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXye6ixVcmpm4w
 yApxap9778Q9r/uHbQ0AmDMtDKr+lndNW5z+MItsKYp/ITAOu5/ukzsJzVqVdkfTx0mCeFAbPWz
 e1sXZSa2dKXONFPMllxGrmfarDaaXQYWuK7HNiZyZYRoE842gJBln/MrSeDZa3UHW82msLE4CJu
 pCfutTVnQbgDfNtZ1XkUEjSoT0lvXE76k7igD5risOCfW7kF0DobU152gGDRPp/Yxk2KJbFQmjq
 BqEdZUuLY1OqrsFXjJcp4eL7UUnDeH/cQHidd3/uty6wNJCruQIZFTinUd0nRrlJyKkiXPZQBtS
 KjvZrlgbKy4FDJvEec515Md/NpFHFLi1Jo8wer63wufAVHCxuXkNtAD4jnnGOVdAcSQ+Sa0EC7C
 7t+afgqLspd3VZDqwBCaqH8BUAd02w==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9b403 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WzllQ2DKJnOsbc1lEq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: xoMp0Vbf2q8oNGUo_DYvR4BN-9tHum12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031


On 10/22/2025 11:07 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 21, 2025 at 11:18:07AM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>> compatible with SM8350. Add the SM6150-specific compatible string and
>> update the binding example accordingly.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml   | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..89852af70de97a9025079107b838de578778c049 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> @@ -51,6 +51,16 @@ patternProperties:
>>        compatible:
>>          const: qcom,sm6150-dpu
>>  
>> +  "^displayport-controller@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: qcom,sm6150-dp
>> +          - const: qcom,sm8150-dp
>> +          - const: qcom,sm8350-dp
>> +
>>    "^dsi@[0-9a-f]+$":
>>      type: object
>>      additionalProperties: true
>> @@ -132,13 +142,14 @@ examples:
>>                  port@0 {
>>                    reg = <0>;
>>                    dpu_intf0_out: endpoint {
>> +                    remote-endpoint = <&mdss_dp0_in>;
> Why?


Oh, I think I misunderstood the “messed up indentation” comment from Krzysztof.
It seems the two-space indentation under port@X and opp-x is the actual issue.

However, that part was not introduced in this patch.
I will split a separate patch to fix the indentation there.


>>                    };
>>                  };
>>  
>>                  port@1 {
>>                    reg = <1>;
>>                    dpu_intf1_out: endpoint {
>> -                      remote-endpoint = <&mdss_dsi0_in>;
>> +                    remote-endpoint = <&mdss_dsi0_in>;
> Why?


Ack.


>>                    };
>>                  };
>>              };
>>
>> -- 
>> 2.34.1
>>
>>


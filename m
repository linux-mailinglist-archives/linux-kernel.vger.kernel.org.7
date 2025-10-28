Return-Path: <linux-kernel+bounces-873050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7BC12EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE3351C86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB2283FCD;
	Tue, 28 Oct 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHBDugC6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B22212F89
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628608; cv=none; b=E1lLNJCq9+X1mnDm+o29LGQkjkdXz/0SugbjN4lenNRGCO9nPP98CQitrRinmGABMEZ+EpilYWObGd+ANH1GZHw/34K6NpBvb/zGYd3JwWu9YCHqx3MQQq+L2Ek8/FG+QU1VRRpGmCkqbdDieYiZi/8IbNnqNrmRFzuGmnQ4oFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628608; c=relaxed/simple;
	bh=jNGXRyeMTH3uROj4bKwqvmjkEoQJLAOhWk9meGeHXBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiV5WwBn9HmQYk+bbCDKvQfnPnHCy8S09VJ9HpJD5cfG9/R8o/9HSWdH6I/NqvkREb7xbuAdXb/oyjaZ/CeYSe0UkqNMc5ARPXrajWGwastmjJLBFwQW23F8JRiamLhPcIaCsDMfooNH8rq0pGdGMOLjKZV6lHs4cJqfPFkukis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHBDugC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S3jlJm3165408
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XUAeRsK1Hv6t+HbR9mvGhvvq8azAUXrlOwY/BXZoNu4=; b=bHBDugC6Rva9VlmR
	xzli3lJpPCJSQDGTeqKtQnGhT5tEvR/cj0JfRqkyYNHIBM00oAQSCb6FuoKwdcgs
	wXU9kkoTrMVLFPWqOTpRpX7N+Brl5gMlC2zX4POaZblmKN1Dc2bhJvg+eIu2wF80
	G9XAquv8hUo7Dzlkn0aVJgYQ9/sGpscQqhn62U2WqLsd05Kjne7YUqSmBv1Mow09
	M3cCkCncwHViHqSs6aBhlxu+XbXUHCDPqAhoykIAE8LJPx5pa0akk/szC/uIk8XD
	7uNzHc73AY0Ks6kYSb8jo66++na15q5E9JUPBjUgkqRRgoGdkrv3nq8eoL8vAipy
	rTLm9A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2bwx1x10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:16:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eadc2b473so1796813a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628604; x=1762233404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUAeRsK1Hv6t+HbR9mvGhvvq8azAUXrlOwY/BXZoNu4=;
        b=nEo3P5tdP11FdrO44eniiAKatrjJeKs9ZSLBelIrsvUSI2GpOIEA2jD38251qRfH0i
         2Qupjy2cfggqk1rLV1TPdIqjGPLG4YKDonrRNgxA0WI3+WLQcTqeopHALtHzE5ypfxB8
         Vw7ERM6amx/Ity5w+teocHZKQofa2KFh/X6LSvraXgtFWCslYGkOQbkQeYraJnWNHsJn
         VwtaGTdPtw4jEm2YxI6c+pfnL6BeJPMMk54LeRDjQGhhfKfkfxIEW4DNQQp8OccQXNwN
         0Flt6FwCk/7g3Wslxrw1Br4pgoueYPIzPrmKQTwLV2LvrmYmcvF7/rGZRXixSp9evH7K
         0etA==
X-Forwarded-Encrypted: i=1; AJvYcCW3uOzwlQ6Uvc7zujoYE/AIWEJsjaUvGNWy27D5h0QFU4PNYz5Ujy1Rp6pO+Kg8c3/DvBLrstog0yDuagU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPLxCbWmVgJblgE24N1mVdHPJwN07Jl+YojTNDFfV05CxHNTW
	uhXB/6jQIK+coKiF98yXXA+ygpMgjD3VOEQeXFQqMeDUow/OSPK+t5JfNv+ZsOXWtthCxk3pug+
	r0Am8s0j/OdMk2/cUO1bENzPt46q4ZBDRCBEFd3pJkXjDu32y+ShIPMKO1+CdRJaPhcc=
X-Gm-Gg: ASbGncsyfNaFTM6LW4hCI55j9BbGLuBU8jurKlUkMuz+HNDZNwYL3//kH75ITwxjBx9
	ZLwXkbjTmJiH8Q8QRFOx+1GrSumjm9MM/Gr3pGLC4n1WFC8iUYbe0D1T3viQLS6UHPI9TVeXJms
	KmLp8w/gVqu636sNZOzW4Mi9n5keTC5R46AXVlWkl43/UjMVQ0h4sh0XVULUmh8Xq8etFh5Q7T5
	qgVDNHh950s/fIJqNqSlhSIbvxg26NTu9VmBN8v6hiWl70m5PhBrJLKqNCRuW3FkJJ6VXMXJLfD
	LPUq+/CO7uTwHFVvVHUIM1Ra9V6j4sOuTdyySFmxZK4ocZREdvRwj9+0leNtyziUY04iqONnd5w
	p+hY8YJvy9i9JFFqnEfnrOvd+Sn19gvVueYHDOMuMwMXZn0OVG2MpQbgYKA==
X-Received: by 2002:a17:903:15c7:b0:272:2bf1:6a1f with SMTP id d9443c01a7336-294cb38dad8mr15162095ad.4.1761628604354;
        Mon, 27 Oct 2025 22:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGCtI/e0xCUDzsunj5pLCq95XvGzaYTPPAgqnYqvKPP49ZjdTjLzgLXq4j89VNN8OjcYuAPA==
X-Received: by 2002:a17:903:15c7:b0:272:2bf1:6a1f with SMTP id d9443c01a7336-294cb38dad8mr15161945ad.4.1761628603887;
        Mon, 27 Oct 2025 22:16:43 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm100614015ad.100.2025.10.27.22.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:16:43 -0700 (PDT)
Message-ID: <f34c6aaa-f3c6-4171-89e4-9f44da9a6a94@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:16:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: display: msm: Add SM6150 DisplayPort
 controller
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-1-c4316975dd0e@oss.qualcomm.com>
 <m6j3sdc4jb2jonzbpez7g3xb6cfputdz34wtydfrx736nqvrv6@o5ntg7csl7dr>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <m6j3sdc4jb2jonzbpez7g3xb6cfputdz34wtydfrx736nqvrv6@o5ntg7csl7dr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA0NCBTYWx0ZWRfX8+en2TMIpIDo
 60Vtch/8dVV3O8iafuKNonKx6yPwykgDVJ8bm8p1wGF2cnZ4ncQ0B7WSVpGYUB4moQbLjLojeIs
 aubB83GlmG/k/muMfrXttr+8VWmNj03YrzGXKfpqtkzGlWsyGIGRq40/CtYiIJQAEM48FVfpL71
 +bZJtkfVZTimTNurwyiQTiCYebku1Mg4JDGhDcwVEq7ngTLzKUuJE1QDfNEH1ojcLjbvkiyHYhU
 rHKkItPltoXV3rAqNesd36kBtMtCdscAqbX2JqRvmNnO8dihiI0JxX66d8hnGBwS3TLP33TP9Lz
 7v5kcqw2pAhV1kwlU2ro/Uky/XDUf3CBd05/HYMb64n/cORTd5LMaIK7U1zAw/abnTmGGOM+qoQ
 rua4sm36Zyv+d4pOHu7MWs9A66jWjQ==
X-Proofpoint-ORIG-GUID: lKu9CYLkhQs0maeQbnQUBtfJOY7yJz2K
X-Authority-Analysis: v=2.4 cv=U9WfzOru c=1 sm=1 tr=0 ts=690051bd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=qjA4-Y8jdfHfWDHiyvAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: lKu9CYLkhQs0maeQbnQUBtfJOY7yJz2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280044


On 10/28/2025 2:54 AM, Bjorn Andersson wrote:
> On Fri, Oct 24, 2025 at 01:21:01PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> SM6150 uses the same DisplayPort controller as SM8150, which is already
>> compatible with SM8350. Add the SM6150-specific compatible string and
>> update the binding example accordingly.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml      | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
>> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..ba0dea2edea98cee0826cf38b3f33361666e004a 100644
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
> Perhaps I'm missing something, but if sm6150-dp is the same controller
> as sm8150-dp, which is the same controller as sm8350-dp...doesn't that
> imply that sm6150-dp is the same as sm8350-dp and we could not mention
> the sm8150-dp here?
>
> Regards,
> Bjorn


I have discussed this with Dmitry in message-id 
<20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com>
SM6150 uses the same controller IP as SM8150 and should fall back to sm8350 for
consistency.

And when running CHECK_DTBS, I encountered DTS compatible warnings, which is
why all three compatibles are listed.


>> +          - const: qcom,sm8350-dp
>> +
>>    "^dsi@[0-9a-f]+$":
>>      type: object
>>      additionalProperties: true
>>
>> -- 
>> 2.34.1
>>
>>


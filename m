Return-Path: <linux-kernel+bounces-836091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F6BA8B37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD23C3B19AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CE299931;
	Mon, 29 Sep 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b9UoRDWA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407C2882DB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138777; cv=none; b=OTaC1b5OuIBirbCpTB3K+g4TKk3xvDG3mqxHUpK99+UxY1DfcC20OZbEb1kgY976IKdfrMXNwHTS7ie69NA6b6yjklY75ZGDfyWb/zZ7jUCJXTWHMktDXOk99/BuZsUTj2VTYyShJ542IRHpSfbDGx/o11MMC8ja3F+A7/tNFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138777; c=relaxed/simple;
	bh=wmaOlvumu+PGiHBM0uc3l7RnZ5fYIZJFS/xqPDKn8c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyBzUFcOEoyTMH5Y//8HwQ2X40VA6NLiUzMkmp/MboOjYWExtoqRkdVORDHLHjoL3ggQZ3SYusP3J3E9tuuNp/B1Wcyytj2hr062c5KqnhUaG/9SHhJKIFaXELrx0qWK+M6EE1ArSzPqyHuu6GhO2rAAHSV8svcf1e92VH4bZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b9UoRDWA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T98aPP025925
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JazvdgIvvnPig1J7Sp2nmitK
	8Kg19jIV07jlBIPx7Gc=; b=b9UoRDWAyoPzK/GTFxIlR94ivZ8WoFN3B38R6mra
	Tx31lzGZi/7MTQ841aI4hnxWt4k3CeELcPSYPLlzABgenKSfxuMfBPQBpxFBcqdV
	bK96fWdS+A3xk35AVAo8gUWQ6K4o/C64tnL3KagoB6hW2G4NErs0YvphwSvbxvCb
	YqQiNMgnxFC3Gs9VhYuRGbJqkGF/okZ53h4yHv5BtFCZLNeKnA2vaO7X+RI6KsQk
	iGEmiDVC5xppEBk0jlIpYQ3M5wDFrdQbMFFdw2tO0LYUIBRWfnvlZvls/eDaGzle
	bTDIAx7nWnFC7ETAdt7KHGfdsG6AeEtbDde/yfDJpIVcbA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851ckak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:39:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-857003e911fso1058818485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138774; x=1759743574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JazvdgIvvnPig1J7Sp2nmitK8Kg19jIV07jlBIPx7Gc=;
        b=xEYEhuH4E6N5ycF0cSnS+LXQ5t+0+BQwp8MyqOb/9P/4T9tyLY0+VE5gR9Gt5H77qa
         dPswu8I6yrXARRwcmw9kGgmjzYiz3vVfhZkbC6fzr2p9pK4zygc0h/YUiEhTML5XB83Z
         +SckalISvOo4kANLOvEatJmCHjzACyXiOLbr6kyFlWcfXQJtM1Hx315a9iC0aYc++Jqw
         9c9XZ7TsYna54JsxNLpNEBrI8kV/FMbdkzpkyH5I+nSSMs7fCX08+vcMyjvZIvml2elC
         7j508jMed5pDYN3Wwj9+vBeETk0T7CWaHbXaNCFrRetJK8tt8JTP1dEgiwyin/SzAZSZ
         FoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/o3BebiwBSHpSC6tPn+YJ6Sp7HwNoz4zgrjN9AYUZIjn+h2ePQs/Gh5YYgcemZJ35YUYSZcgoafIY0v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9z9IuHrCAqtEc1nCpmfUxfDmj7Hw8+IfwPuhX9rUAhX4xSoz
	NWC//zfMxE+NpOsEwzvZ3UvNGpuGeLEtq1HxxwfzTS1jAsKUc5Ka+MQ77GNifMsAhlau9oh16a5
	oaTwNurbHXD2spS5N/EmWBmRo4+j6IcBj0SvPnwSawvQ+zv89UXL+pMexY4+yBk+s6/Q=
X-Gm-Gg: ASbGnctgJURDxh8it8PFhV+KOOz/IAaiQScYxVqLhlhQYRewdA2aYEpS3p57u4Xj7qy
	kV2zOcaIONm/kxosrdQwMCi8N/nVs5TgNWVdTqmGm8gBB06fHbmGgXV+wqraL0dzppZu/T4g65Y
	KsqodLvWHsF+ZtcxUZ/HA45UC3679cgZC6niZUH3msDKjGvuresvNmBjQsyupkwdF2X8ur9OTXI
	N8CPxrRi/t8gNz6P9t4uDexZ/FoTXD1WY9ZaGTVOF/45JUVE9R1JtdkM6ul9wNjYgQyIjyUwVE1
	NdqszjdVIsRGdwoXwtKmjsILo2uzL7Ftht/080xA+8u/OX3PNPnQaSbJ+FRn5xPgeIWl1eaxDu4
	dKj3AhtXibWWZwt7GZEcPKQXMx/ztfFLCteJx3DowW6ZjlpLMcGat
X-Received: by 2002:a05:620a:29c7:b0:850:222a:817d with SMTP id af79cd13be357-85ae26a2f22mr2164878185a.37.1759138773706;
        Mon, 29 Sep 2025 02:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFspqGP3TSITY97/476JsiITLiXHo56C+x77gMdBmOfU0xXye44VDx9fxwmfyCsYh5US4mmg==
X-Received: by 2002:a05:620a:29c7:b0:850:222a:817d with SMTP id af79cd13be357-85ae26a2f22mr2164875485a.37.1759138773232;
        Mon, 29 Sep 2025 02:39:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe7fe4sm27035921fa.65.2025.09.29.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:39:32 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:39:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali ADSP
Message-ID: <maeobo6qukgzn3acwtvhfrvwrfwo4q5pzspem6htbybr5xuwlm@opagojsav6ey>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
 <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
 <d374036c-1263-42f4-b9ae-13b21427b01d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d374036c-1263-42f4-b9ae-13b21427b01d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68da53d7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tbtOcBIPLoXn284NOI0A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX5TUtvp1dxJzD
 Ap0ATpJBUbQbgyVnGRgcQGIUKSWOpzPi9iQljiOyC2EGm821rFZrqVm0u5LHndNFTSojOxZ2lFE
 d5THNukKCUyQY15g1XdLiBwBgLrGQ8b/ZuvWGFQvdbx1QeQeqVh1dvi1c/CDBZS0FMCORVY3vP9
 Fo00qC1RW3cWvZhEBT13IGHmEeCKtFqpbRDJuwT/JtVOTPgnKTG47gI8uBPsuwA/vzpyM5uef+a
 Crd1x0qgZ4VLOTrWrpKeF1HVwstqwha0PL7uuW+dS8GqUtnEnFD3XVQWYUL7bdlphw16zWxEp5j
 E8k7zHEnwXLbldL8DsGnVAy0Nv2Uw7Zha/sY/0J3mdUcNOvXNDJvcjvK/5YRFKF3ILsjoxgf3Z1
 6T5Ep5Ye9sTqSPMvAACJdLj0t8PCUg==
X-Proofpoint-ORIG-GUID: KUVdoea1lIK3Od7N7LCnwg8svInSKnuU
X-Proofpoint-GUID: KUVdoea1lIK3Od7N7LCnwg8svInSKnuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Mon, Sep 29, 2025 at 02:06:11PM +0800, Jingyi Wang wrote:
> 
> 
> On 9/25/2025 10:19 AM, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 04:37:22PM -0700, Jingyi Wang wrote:
> >> Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
> >> compatible with SM8750, which can fallback to SM8550 except for one more
> >> interrupt ("shutdown-ack").
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> >>  Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> index 2dd479cf4821..be9e2a0bc060 100644
> >> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> @@ -28,7 +28,9 @@ properties:
> >>            - qcom,x1e80100-adsp-pas
> >>            - qcom,x1e80100-cdsp-pas
> >>        - items:
> >> -          - const: qcom,sm8750-adsp-pas
> >> +          - enum:
> >> +              - qcom,kaanapali-adsp-pas
> >> +              - qcom,sm8750-adsp-pas
> >>            - const: qcom,sm8550-adsp-pas
> >>        - items:
> >>            - const: qcom,sm8750-cdsp-pas
> >> @@ -95,6 +97,7 @@ allOf:
> >>          compatible:
> >>            contains:
> >>              enum:
> >> +              - qcom,kaanapali-adsp-pas
> > 
> > This one and the next entry are redundant. Do you see why?
> > 
> 
> This one describe the interrupt:
> 
>   - if:
>       properties:
>         compatible:
>           contains:

>             enum:
>               - qcom,kaanapali-adsp-pas
>               - qcom,sm8750-adsp-pas

It's still redundant. Don't you see it?

>     then:
>       properties:
>         interrupts:
>           maxItems: 6
>         interrupt-names:
>           maxItems: 6
>         memory-region:
>           maxItems: 2
> 
> 
> >>                - qcom,sm8750-adsp-pas
> >>      then:
> >>        properties:
> >> @@ -185,6 +188,7 @@ allOf:
> >>          compatible:
> >>            contains:
> >>              enum:
> >> +              - qcom,kaanapali-adsp-pas
> 
> This one describe the power domain
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - qcom,kaanapali-adsp-pas
>               - qcom,sm8550-adsp-pas
>               - qcom,sm8650-adsp-pas
>               - qcom,sm8750-adsp-pas
>               - qcom,x1e80100-adsp-pas

Likewise

>     then:
>       properties:
>         power-domains:
>           items:
>             - description: LCX power domain
>             - description: LMX power domain
>         power-domain-names:
>           items:
>             - const: lcx
>             - const: lmx
> 
> 
> >>                - qcom,sm8550-adsp-pas
> >>                - qcom,sm8650-adsp-pas
> >>                - qcom,sm8750-adsp-pas
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> 
> Thanks,
> Jingyi

-- 
With best wishes
Dmitry


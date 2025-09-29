Return-Path: <linux-kernel+bounces-836283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7BBA9310
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA31A7A82A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C7305968;
	Mon, 29 Sep 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4PjeNaF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C02EB5AF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148578; cv=none; b=bJLg+pVhlEWO2YPc87P5THhKfK0m5KwgfSOH8udLEPpSQcARPC1F8suP0TPMfiug2nD4zi/+IqodWQ1Y1J/Cu005e+MgA5vqbfOdvCIjKtybBVPhTeE5y21wq5K28oTbmKYWVtWDrhYGBjYUtvu1IxKwjrte3cRxcC7Wp6AQEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148578; c=relaxed/simple;
	bh=sAGuc4hmJXIyaAwaPQeIzU02HACEnFbZX5F14BXo+Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLYIAPWbh7E4hbbPFuSCIOc24EG2Hm0X+EXbYdGOPR98f4YZePBrCMY5Vu6RqM0CsS8CymA7JuKZLjwPlQg6Bku3AG5vZ0G6lY9R9XP/0ijuMWAg95VX5c0GRMUH/gZjj6vSgvTTyUvwDjD5SeIrlsOCtzBI5W/DYJ3ImaDRQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4PjeNaF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TA9kYv007658
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T4SswY8XOqLvgsVeODsfA0qM
	1EnNqY56NQss7ej8grY=; b=f4PjeNaFmiG8uXxmYXyvHtxRzXd/ERlufZ3bnvqU
	PKy9ldebZfVzGbDTO43IzWabVgZY2mcMnz/uCD42F8UG5nP8lXQ1aPeAoxvvgWIE
	93yRe1MjL6yXAcV1kEOCex9BulR4lC2OL0/XmbJzmrJIar75cNMOfb5tT8MesKIw
	C3ED/t2oPZ4aC8Xtv1lTHSdHE6yGY4b+SXH9ExaUog3Kl0MHiokNmkvcsk2RX7rK
	uSbDLUh0NRfLaMCt8VWsMm+JamtIwE2Gmw7iI2l1MaR15ZYHwiOKZrC/gFpIaAjD
	JV5jDsf9rP9SrBx3feFAwt7xPQgNZHvKVzzE3lQMhq0+CQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tn7h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:22:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d602229d20so83051121cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148575; x=1759753375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4SswY8XOqLvgsVeODsfA0qM1EnNqY56NQss7ej8grY=;
        b=qBrB3Pu5ksZOBSekTMWStRVwMEcGmyo3HtANVvHkJO5O9hy5+0HskAK+s5sTUxiaEh
         nEZqAVJRxsJ4BNPhMRNA+HDzJjF4gXz4snYMbCRTPaf6uk90M6KuMNvFdtnBMWtuUl5M
         U+Xr2nKSTpoUrCgtDVT7BVR+XN6s2HknOl69/4BA0nAuc6l8RlCxHWV+GYmHvxL9pgby
         eVs3FPEcd1cYy7kJXM+JJP9MiuXZujl+5cJMZhGBNvLjPo2NUkEMZ1/dQ/itPDSkcEaf
         CThnq78aIkmZhIV4nwjQXd5gYP8Q9+81bqoBS2iIeJ3lKH5t0HQqGuaMtKM8dk+7fxnQ
         zQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQqk7l1n60TzkaQZYiO8CW5j7gw33xnch4/31B4DLSBEkcCy8cC/fsh3rwXzwcWniaI8NgEDySl3cw9fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxi3IqPwUX7mWPhgnan2QBsDICPkckFlVX74YXNCoUo6XCQWk
	3r68Dvfi1Y8o5R5GpGw/fpVTRwz80j6/CTZj5ioXI83VEQMw6uUF+uSkqq8iX0vLBDFNUZ2/IcN
	4/CY6M1HWCz+gYQPklCPmmBSymn7bW16aQuXTAsXcP1+Kpz0jqt5Z5Tdk1XJsjBXvdkQ=
X-Gm-Gg: ASbGncvaRl1SxNgEACdfm12o09AS4TlQ/FXPssTnG1MStxb5yWCVuO/s6jNaneYuwlW
	K5qt4m2MYA7/HGZ8P6k11g4mbfqKH+pbdp3XU1WQ8e4D3asYbRILr73frFMKUWvf8r0M3S612hk
	Rj3o/pZ46o4wqjtPcQnA+36EkyZmxO8oOKuvSTtnw5cmkWhl80eR7C4wlLwp/tGz1zJ2FhZMDuC
	0rlzV0hxNkpsE8UspDnaZU/sjaywkxRdDOEL+S5k5ELBzpQwLd0tSIPHxPg7ufWKp9tyFoeiIaK
	o0nefjkZeK9D6Cr9p/pZnycZZxuImFXVWXJUu0WgXPiXmcACgo3ozUkCgdIh5+yVFQf9hfK7e1H
	4Isjs0PKs8qDpa+GXWY8H6h5vdr7ddvmA+9T3WFD4Z4B8u+HFYkpC
X-Received: by 2002:ac8:7d8e:0:b0:4ca:bde6:cc8c with SMTP id d75a77b69052e-4da49348df8mr218164841cf.30.1759148575015;
        Mon, 29 Sep 2025 05:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe/xFQ41Vdyn76qTMLChRKmGI0JjKWxsygUS+t/nIPg0pTYDkgEsrKnVFqgnmMyK8XDNzehw==
X-Received: by 2002:ac8:7d8e:0:b0:4ca:bde6:cc8c with SMTP id d75a77b69052e-4da49348df8mr218164391cf.30.1759148574412;
        Mon, 29 Sep 2025 05:22:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4773451sm27480261fa.11.2025.09.29.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:22:53 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:22:51 +0300
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
Message-ID: <go2koxtabrktc2noyrgehgeddavvsdz6qu6bnwkzqtnb2k4du5@3m5le25bfmpv>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
 <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
 <d374036c-1263-42f4-b9ae-13b21427b01d@oss.qualcomm.com>
 <maeobo6qukgzn3acwtvhfrvwrfwo4q5pzspem6htbybr5xuwlm@opagojsav6ey>
 <4a25e085-39f8-49dc-85c6-7a4267689dd1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a25e085-39f8-49dc-85c6-7a4267689dd1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX8H44enI8sD8P
 +6L3TfMtUxFTEIZJwlLiM2nmYwjpwZnUeOFiF51I6ssDhdxoxiKByIvlapZgCE2pGE4rsp/a8kT
 vx9V7fJG+1MCVU3B8YCDDcMq44ujelFiF16iljyaW3y773W9AbpH5O3RowMJJ8WA3R1PWI8bfvY
 EwhaC6HAnzK8GwgO0UEgKVZfaRGGD1m3glt7In/84XvbObuyjLPsBtSWsxF4LkgmDevN242ZIvV
 8kNVxRhMU8ITHJvq0PX0k48N7SXIlgL8ICJJ0cE7+0AP/g+pAF4tU8UbRjGOaA3jdxlq8GimurT
 u+rxQwEVesEy8Qwk7hPfPKNMBSgodug9Ll7KQGMGD4BJQYQe+qvWn9dV4syl2o5JYAy0e8Y+6Sq
 59jjVaqCeU9W+1Qh2/HxSsOLgC7qMQ==
X-Proofpoint-GUID: N0zzpzq6OVbML9DhDCp_3Ihcd2UWxCc-
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68da7a20 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=f1GoqXBgz2vLpE21Uj8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: N0zzpzq6OVbML9DhDCp_3Ihcd2UWxCc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Mon, Sep 29, 2025 at 06:11:23PM +0800, Jingyi Wang wrote:
> 
> 
> On 9/29/2025 5:39 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 29, 2025 at 02:06:11PM +0800, Jingyi Wang wrote:
> >>
> >>
> >> On 9/25/2025 10:19 AM, Dmitry Baryshkov wrote:
> >>> On Wed, Sep 24, 2025 at 04:37:22PM -0700, Jingyi Wang wrote:
> >>>> Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
> >>>> compatible with SM8750, which can fallback to SM8550 except for one more
> >>>> interrupt ("shutdown-ack").
> >>>>
> >>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
> >>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>> index 2dd479cf4821..be9e2a0bc060 100644
> >>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>> @@ -28,7 +28,9 @@ properties:
> >>>>            - qcom,x1e80100-adsp-pas
> >>>>            - qcom,x1e80100-cdsp-pas
> >>>>        - items:
> >>>> -          - const: qcom,sm8750-adsp-pas
> >>>> +          - enum:
> >>>> +              - qcom,kaanapali-adsp-pas
> >>>> +              - qcom,sm8750-adsp-pas
> >>>>            - const: qcom,sm8550-adsp-pas
> >>>>        - items:
> >>>>            - const: qcom,sm8750-cdsp-pas
> >>>> @@ -95,6 +97,7 @@ allOf:
> >>>>          compatible:
> >>>>            contains:
> >>>>              enum:
> >>>> +              - qcom,kaanapali-adsp-pas
> >>>
> >>> This one and the next entry are redundant. Do you see why?
> >>>
> >>
> >> This one describe the interrupt:
> >>
> >>   - if:
> >>       properties:
> >>         compatible:
> >>           contains:
> > 
> >>             enum:
> >>               - qcom,kaanapali-adsp-pas
> >>               - qcom,sm8750-adsp-pas
> > 
> > It's still redundant. Don't you see it?
> > 
> 
> sorry I didn't get your point here, could you explain more?

For you device you have two compat strings, kaanapali and sm8750. This
schema block is covered by 'if compat contains sm8750', so you don't
need to add kaanapali to the if-case. You already hit this check thanks
to the fallback compat.

> 
> >>     then:
> >>       properties:
> >>         interrupts:
> >>           maxItems: 6
> >>         interrupt-names:
> >>           maxItems: 6
> >>         memory-region:
> >>           maxItems: 2
> >>
> >>
> >>>>                - qcom,sm8750-adsp-pas
> >>>>      then:
> >>>>        properties:
> >>>> @@ -185,6 +188,7 @@ allOf:
> >>>>          compatible:
> >>>>            contains:
> >>>>              enum:
> >>>> +              - qcom,kaanapali-adsp-pas
> >>
> >> This one describe the power domain
> >>
> >>   - if:
> >>       properties:
> >>         compatible:
> >>           contains:
> >>             enum:
> >>               - qcom,kaanapali-adsp-pas
> >>               - qcom,sm8550-adsp-pas
> >>               - qcom,sm8650-adsp-pas
> >>               - qcom,sm8750-adsp-pas
> >>               - qcom,x1e80100-adsp-pas
> > 
> > Likewise
> > 
> 
> indeed, here is redundant as "qcom,sm8550-adsp-pas" is added in
> the dts. I will remove this.
> 
> Thanks,
> Jingyi
> 
> >>     then:
> >>       properties:
> >>         power-domains:
> >>           items:
> >>             - description: LCX power domain
> >>             - description: LMX power domain
> >>         power-domain-names:
> >>           items:
> >>             - const: lcx
> >>             - const: lmx
> >>
> >>
> >>>>                - qcom,sm8550-adsp-pas
> >>>>                - qcom,sm8650-adsp-pas
> >>>>                - qcom,sm8750-adsp-pas
> >>>>
> >>>> -- 
> >>>> 2.25.1
> >>>>
> >>>
> >>
> >> Thanks,
> >> Jingyi
> > 
> 

-- 
With best wishes
Dmitry


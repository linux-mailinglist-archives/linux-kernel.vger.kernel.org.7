Return-Path: <linux-kernel+bounces-767347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7412B25323
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BD51B68530
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F72EA167;
	Wed, 13 Aug 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aed+iGeh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D02BEC21
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110469; cv=none; b=nOvUgLPrbJQm6diZLO7lX8Myidz7WqrIp2O+sjwipjkb5Cby/er9u+W2YvhDFFGrJHbvht3ZILfbsHj2foPWNJZszGbbA45CgmWHbcpCHiUQgIA0kWtA9Pheu9UlGljNzpLgtey8P6Bxy3kMg+W27rgV0Ffqv0+4YzF7+neOHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110469; c=relaxed/simple;
	bh=eH9oi9rpc+k7AxxneQYhOC0hBZYrKLHGcN0lSh1UkwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwCBsrl1ImnKz34h2RtH5jb9Q+5xS56y0q85ULKn09k+ae6r2JI7xsEszP7jqmEF9Av/Eru9pw63MWrqqReOqNHzIr+LuGr8rZf3F+zExjnO/hm6ee0h55ZWHAYmhRQX1rL19nTGTosJt7nML2hBHsELm06ubuqPRwd1P8I4J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aed+iGeh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLkJg031164
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NJMt8zZbyeh6EXv4mGiSbveA
	yKRS8h6k1z8cIBJj6Ls=; b=aed+iGehdXicoMpPnR95OeTqFraoNFsaZxfakmv4
	2LWMSU5teMYVNHh9NpnkLKGAu9jKe0kk5Bq+bwld5rIQDqNvW/Or8pWBpmMdUeXq
	8vP89WNngDLEuBKqNRYFDTohnbTjiexXrmuGVK/srs+FOVkQt+Jj32pT9t/7rYU2
	5c8Rvi9OcO+WAlJOtRuQpM6s/YrZY5z5ojlCGcy5UIdRcjpf1cg0SClcTbtDjzwq
	dawbyJRRbulB2dZo2gS75GMEZApT3sC+SeA+vfGVchciMSweXFBloaMXqX8hQlhv
	XnEF8RCNv8g6tJMrcHRL0ZjzT2GyXluMdonTBaF6mn9SfQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vqueg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:41:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c8804dso5018431cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110465; x=1755715265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJMt8zZbyeh6EXv4mGiSbveAyKRS8h6k1z8cIBJj6Ls=;
        b=kn5zAN7jMCMfsXpB/96iFqMbPcvjOVR5S1sqIQNhBBrZ4n3/MYd9quNDU1m2BVzXXp
         GI7X0fSOIJxnYh4IZctLKNEbVoO6F49tBHrlTqKoQ52uzZfMI3ujWflHW9KDcdhNww3m
         mXYyQktGtui27Voakz/gPQ0o/XGfAQuXHgWSafOO55fgGA8Tia6dg09nca6Nw6ZG6Hhk
         iw5SGMk4n9eDiK2DlOXVCuiQKHKOj9eDBS5hkoawKKL64MTVhLEaXVbtebH4ZTheTyOR
         LsUtFx4L5Xz9JXn9cgNUhj4o0OnHGT4hILUgSBMMln4vxOrzNfclkLy5BoXdcDSL8axI
         bXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf5vlvIIQ6xElC/vuauYi4JT6nxsGoQaV+6Eq5BR2mUB8EeztBoObX1Z9a1K7fYFvYnUXQ8+sKW6Dl3fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeBPmgJSTyBmAYWe9d3P8x4MzMxS7AsMi7IkkJGmlmNlxIgOg
	rzTlBHIoRYATwjjIkuDM53w2AYi4BR1tUWmK2HsHF4lFn7bGba0SrRyy/KSJaXhW0VLPdJOqYWX
	zGCWLiVx70drn6ajvAfIVT9bvLCe4UjSUZBYIleZScxiHu3SRfCYRXC3DqHO8oQh+tv8=
X-Gm-Gg: ASbGncuCIeLTyoXTvdZzaMiSyO0/KnehE4n4lbeaNPj8g+EwT4jCW3zroie+6HZRTac
	TaU8xo6tvcjC6SDbLdFYQXzOQPFFmyqR00c8zIK3pPL7QTMfKOGvDIWZvL8ZX8V39xgyLiGKvFl
	6o0iPrYFPBcRxyI6OcKzZYTlrPRXIVAjdqJ7gEADAYnPpZFKRzhv9zGuFkwifwgbyjiGus+x+Mz
	oYSzkkCvX7BRyTt7aLOcCZVfMbal4KZeFjc1qphpPSG/PF7GqD+ARnZgpDy9GEYyEFTgUfJkZbj
	BCT+ZDq9gKZ7VY0bhKlTpI827gPgAhKW39qkocwV0e7t4VrqFtc5lQZjd4wMO4rr2jeSOzWnp/O
	TzABNX0ReSMe2wf1DG2KWMASRlxuISDwcltp2MbQRagLe2kkG1N2X
X-Received: by 2002:a05:622a:19aa:b0:494:b3eb:a4b9 with SMTP id d75a77b69052e-4b10aaf15edmr3854721cf.51.1755110465429;
        Wed, 13 Aug 2025 11:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4jt90DJnLvjoalbZvV3KYe+N5pVXmPZaC4JrESoD0j4ijiK56kStPrvbXWgLx5NYrU/37ng==
X-Received: by 2002:a05:622a:19aa:b0:494:b3eb:a4b9 with SMTP id d75a77b69052e-4b10aaf15edmr3854171cf.51.1755110464835;
        Wed, 13 Aug 2025 11:41:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca30c4sm5472138e87.114.2025.08.13.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:41:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:41:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Message-ID: <2vtxgzwsr6sztu35zeebuho3ie4bbifb75v5usxfzcys2ufx4f@fnig7kqij3us>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
 <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
 <2ok6o4e5pz4ichhchycqkns2afzce5y6ppjr2av4yz3wc3iatk@m3cdck7csavt>
 <956e5828-303a-44ce-d41e-0f7b977581a8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <956e5828-303a-44ce-d41e-0f7b977581a8@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX1ve6S5rdYaqI
 2t6n63TVYI4mQ/3iv5CEMQIjTTD3jVgk+rExixWjpnMpkihhoxcGHNPE6/RHaAUucVMSUAoujB2
 lq1Z8bWilMnARNOBaG9USDTi4emPUxN9MNfys9OyX+XvqWSC8pWVrII+gKwvhAxXxF13m4MBtI2
 R4Sa8KZZ2MObqcQoll5qDHH1aAjbC8I1CqifGov64IkdKyTH8o+6GI0+edARS0ak/W+mH48j9lu
 IAsuCHqvKy+Svj9SjHRRETnZDQ0FjZJ4XsmTZtmM3cZGSomApvnNUekimpG+lH3DZFW5tXKLJMp
 P2HVv92bYhZwvIvnlPHiRJy4/IV0EuerrGpnspP2dxc661VndNFJ4yVbScBh/zuf70qrjCJM+M6
 umxPP+kc
X-Proofpoint-GUID: oyRPcx66-jms9bcUAC7yahZEDTOVqEo9
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689cdc42 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=0tCpNLKLXZv0WORs85cA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oyRPcx66-jms9bcUAC7yahZEDTOVqEo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Tue, Aug 12, 2025 at 09:01:36PM +0530, Vikash Garodia wrote:
> 
> On 8/12/2025 8:09 PM, Dmitry Baryshkov wrote:
> > On Tue, Aug 12, 2025 at 04:21:12PM +0200, Konrad Dybcio wrote:
> >> On 8/6/25 2:38 PM, Krzysztof Kozlowski wrote:
> >>> Add Iris video codec to SM8750 SoC, which comes with significantly
> >>> different powering up sequence than previous SM8650, thus different
> >>> clocks and resets.  For consistency keep existing clock and clock-names
> >>> naming, so the list shares common part.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> ---
> >>
> >> [...]
> >>
> >>> +			iris_opp_table: opp-table {
> >>> +				compatible = "operating-points-v2";
> >>> +
> >>> +				opp-240000000 {
> >>> +					opp-hz = /bits/ 64 <240000000>;
> >>> +					required-opps = <&rpmhpd_opp_low_svs_d1>,
> >>> +							<&rpmhpd_opp_low_svs_d1>;
> >>> +				};
> >>> +
> >>> +				opp-338000000 {
> >>> +					opp-hz = /bits/ 64 <338000000>;
> >>> +					required-opps = <&rpmhpd_opp_low_svs>,
> >>> +							<&rpmhpd_opp_low_svs>;
> >>> +				};
> >>> +
> >>> +				opp-420000000 {
> >>> +					opp-hz = /bits/ 64 <420000000>;
> >>> +					required-opps = <&rpmhpd_opp_svs>,
> >>> +							<&rpmhpd_opp_svs>;
> >>> +				};
> >>> +
> >>> +				opp-444000000 {
> >>> +					opp-hz = /bits/ 64 <444000000>;
> >>> +					required-opps = <&rpmhpd_opp_svs_l1>,
> >>> +							<&rpmhpd_opp_svs_l1>;
> >>> +				};
> >>> +
> >>> +				opp-533333334 {
> >>> +					opp-hz = /bits/ 64 <533333334>;
> >>> +					required-opps = <&rpmhpd_opp_nom>,
> >>> +							<&rpmhpd_opp_nom>;
> >>> +				};
> >>
> >> There's an additional OPP: 570 MHz @ NOM_L1
> >>
> >> +Dmitry, Vikash, please make sure you're OK with the iommu entries
> > 
> > We still don't have a way to describe it other way at this point.
> 
> I could validate the extended "iommu-map-masks" proposal. Given that we have a

Was it posted? If not, let's get it ASAP.

> new binding for SM8750 [1] , does it make sense to add iommus min/max as [1,5] ?

Why [1, 5]? It should be [1, 2] or just [1, 1] + your proposal.

> such that later if new property is introduced "iommu-map-mask", it does not
> break ABI.
> 
> iommus = <&apps_smmu 0x1940 0>;
> iommu-map-masks = <0 &apps_smmu 0x1947 1 0>;
> 
> [1] https://lore.kernel.org/all/20250804-sm8750-iris-v2-1-6d78407f8078@linaro.org/
> 
> Regards,
> Vikash
> > 
> >>
> >> the other properties look OK
> >>
> >> Konrad
> > 

-- 
With best wishes
Dmitry


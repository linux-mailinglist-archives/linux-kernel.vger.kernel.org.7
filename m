Return-Path: <linux-kernel+bounces-765058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26FFB22AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E443B147B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19432ECE85;
	Tue, 12 Aug 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0ZjKE3u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC62EBBA3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009593; cv=none; b=NUwnp+KB2iNN+0LBv0LfyoUm2BqNBT8qKXcNB5bDhgF3IvJNaoQfU00n8EW1n4pFOx4v+qmvwNgrQX+i/ujeBD9hZddKlHclXTpOCsjmsMIET1C0N7+9LkVV5x3s7O33Wz2cqSJYcPRXNd7mwMXR41iCJJXC7zf5FBEIFS8UXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009593; c=relaxed/simple;
	bh=XAfeo4GsE9hEqqUj30tqUKIarmQoDLaJCnklRZZJwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug4wSNdA94HfNCWeYjqYw5kNiZMTzdW/uuOvNd88vHUOS0cS8G2arCKEMFLhegciWOc3zYjF2/CKuI1krIdVJAfKWHA9Eis0R09jHlQVpgLYfHllBVNvRWR1gvBT7H7rqYpY6ijT2IjJgmB9MayEj/+EjkoGVvyhBL28/EKCd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0ZjKE3u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvrlf017899
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FcQDffu4Ht2nuqPS+dRUtr1j
	1wHDse8GaW+NYRE0/Mg=; b=n0ZjKE3uLUrCRAWLRPJif+yS2oOt0CKzTi1jI+kO
	Y6J7dUfIHpcXn6G9J705yaGSNjSlPXSyXgGUWoWq/G5prsFHQlF+PM5Nri9NyG6a
	HFMvIl0bcw+tKFACEUqREhzMAKCcYDmGFh6gloRu5ccCywWxDFCiv1fsGIAq76Pk
	biWNsEetREwePadKtwP/+OIi7B4IB+2WtlsoIgm1R5o6RvIdR2qO9Ri54Asyk7HE
	5rxp8mMsioLJlRA46gvGBwdYnK+RnFRVpO8K8UsQpNevrrXtHNdWpAnjiPG1sEeE
	1XwJvQJ+B2FF+W9wmnUj+QlPssYsogA8D8PdmMqcv8kQTw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4cfq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:39:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7075d489ff0so105342486d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009590; x=1755614390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcQDffu4Ht2nuqPS+dRUtr1j1wHDse8GaW+NYRE0/Mg=;
        b=qAZij0FCKregGtWYhJTq9NKhuxN26mQUquaM5v2iQsQgYXKg/0aSzaQxhy0amwPj9X
         vsqtI3mVy47wEhs1PMoAuKQiiyC6c3tQqiu+QemM/nSS9fCDJ3yl0cesYOthaS9dVaVr
         MWSt+Sj6SH2xKqiiZTmrbnzckJIzASFwAg8DBcOaNj3Vt1x2HcHy9+o6JrzklChTUol8
         WxSMb2XMXsCKhtrT0I1uKTiZLCXsV9yva7hshHhsxH0tdHpI3pMjWtRUICMwOtD1PmjA
         msPg0wJuRlLK/toFsCjdMYgimSN+VtJHIDSlfj5PKs3brWNg9l/uNVXLRCG8C1P9VMRr
         7Njg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOM3ovZA34se/DiJB2v3YDtARYxU8jY1kz7zKMa15A7+sxUvtpryvXfult7MEnLcYThrsRaSMHe4Hp6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z8Y9I2P2WX2SNQ+n7mGLDxjeEUWTV92vdvdu+E0KObMT9v7c
	TA+3bqPcukBief4Cl7GPFDm3ijo+MzT+jpIwWPnN6Q4Bom+O5giZMwu0xmP6h1SyQYkclLJ3X/p
	T2RjQbItUyepKZm4QQ2m8pHrosXr8NdKcbL2i6QeR/eFr1i6l5668Oz6Wnr1W9ml/TgI=
X-Gm-Gg: ASbGnctVxJS8ZGr5VAaPDS3r3/yx8KoxZ/2dJoS2mgIiIvaT200demFfEnbRgh4EA6o
	xbuVmDkUUYkx5Q3ESMChN2bh9PFH80Z6OT6L0Z510tDUeEpm1BhQTDwXMCo5HkmgJpRqPIG2VC+
	85IozV5xv2MinzoAx3t8UDxKrZVqPCfMwVqOlnnf3TUKQNjKQQlMRan70Ukg24ntPpVGs1bLVod
	UlRgAMpT0k3KfaJYXe3yfeHG3Fstgdy2l+6dT4FxhgAUz64vBoQchV/yndXVPcKMxgtkrAJgWEp
	tsxpXR6gNZuV9LgM0jRqN+SuCMhwypO3paRUUv26eoqg6+EbsZM8W2VwczTbmFde6dOjMLM1LkU
	IatynQg46C/Vl7z70O2foqCc+Vea40Do3jP8AVyYnivLQqRAhPODn
X-Received: by 2002:a05:6214:8088:b0:709:de23:aacf with SMTP id 6a1803df08f44-709de23b248mr33124136d6.23.1755009589695;
        Tue, 12 Aug 2025 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ02jwb1BJdJ0GEtq//bbH7kZ/MwabFp5DoHxh2z8a42uKVXly5Dax1fZrPydgEB7NcAq1Iw==
X-Received: by 2002:a05:6214:8088:b0:709:de23:aacf with SMTP id 6a1803df08f44-709de23b248mr33123586d6.23.1755009589227;
        Tue, 12 Aug 2025 07:39:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cce15c650sm1434362e87.103.2025.08.12.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:39:48 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:39:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Message-ID: <2ok6o4e5pz4ichhchycqkns2afzce5y6ppjr2av4yz3wc3iatk@m3cdck7csavt>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
 <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
X-Proofpoint-GUID: 6QXMwwsFbAoWMh3WsDJX2MK80_tqwBWr
X-Proofpoint-ORIG-GUID: 6QXMwwsFbAoWMh3WsDJX2MK80_tqwBWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX5tjVU7UN8oZK
 KgOtxMt5ZMPmED6lCwtjD/kZlk2Y2u9Ejxgx4iBCVt6MOXvXII3hrcFmk98xvpD7OzEQIW7QTq1
 99q9f2chSQv/7IteUGta+x+P65bOyD2tY7go5MkaQK+bAPy2KRM/WN4wcLLu899+/TVUb+WBEKn
 OvWczQddk400uuIOQzU8Di35J2jeJgxtOZyFizMAOxiw2/UJgB7wRE5tZJGq7Kpe5vU4LoePaR0
 un6wTdC1S6DZDJxNmY/FxvLEDwqSNbE8dduv98hpb8Z+xt/KzraJJ+Hd+p+liiBWJDmqWH6JzrM
 98gEGgzb871YR8YvxCkpr7QsT6niLlY2IX9aAIDLsMk6AYAMZ60JP8W9MX2KSBF/WLsRCZ3aW52
 GvMmt744
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b5236 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=NaKNMKGzfxSzMjQQXCEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Tue, Aug 12, 2025 at 04:21:12PM +0200, Konrad Dybcio wrote:
> On 8/6/25 2:38 PM, Krzysztof Kozlowski wrote:
> > Add Iris video codec to SM8750 SoC, which comes with significantly
> > different powering up sequence than previous SM8650, thus different
> > clocks and resets.  For consistency keep existing clock and clock-names
> > naming, so the list shares common part.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> 
> [...]
> 
> > +			iris_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-240000000 {
> > +					opp-hz = /bits/ 64 <240000000>;
> > +					required-opps = <&rpmhpd_opp_low_svs_d1>,
> > +							<&rpmhpd_opp_low_svs_d1>;
> > +				};
> > +
> > +				opp-338000000 {
> > +					opp-hz = /bits/ 64 <338000000>;
> > +					required-opps = <&rpmhpd_opp_low_svs>,
> > +							<&rpmhpd_opp_low_svs>;
> > +				};
> > +
> > +				opp-420000000 {
> > +					opp-hz = /bits/ 64 <420000000>;
> > +					required-opps = <&rpmhpd_opp_svs>,
> > +							<&rpmhpd_opp_svs>;
> > +				};
> > +
> > +				opp-444000000 {
> > +					opp-hz = /bits/ 64 <444000000>;
> > +					required-opps = <&rpmhpd_opp_svs_l1>,
> > +							<&rpmhpd_opp_svs_l1>;
> > +				};
> > +
> > +				opp-533333334 {
> > +					opp-hz = /bits/ 64 <533333334>;
> > +					required-opps = <&rpmhpd_opp_nom>,
> > +							<&rpmhpd_opp_nom>;
> > +				};
> 
> There's an additional OPP: 570 MHz @ NOM_L1
> 
> +Dmitry, Vikash, please make sure you're OK with the iommu entries

We still don't have a way to describe it other way at this point.

> 
> the other properties look OK
> 
> Konrad

-- 
With best wishes
Dmitry


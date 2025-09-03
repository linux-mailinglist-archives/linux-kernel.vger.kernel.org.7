Return-Path: <linux-kernel+bounces-798532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D044B41F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0667C1885280
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FE2C11EC;
	Wed,  3 Sep 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jP8bZfTk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7A2FF178
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903177; cv=none; b=K9MtTuiRul00P1ZNJyoCUIjj+3DQhHy7O0fYM+kgcuQF2KxUZiesgwNWXTWTLm8rAOpJY8a8cG97NlMGt/hYrYtewdxifukXs2CLDQegDl1Z1EBPaK6SQqdVuCaKHI6xXO+rJI/d5xR7uVNFSuVndpkiyjAwednuASP+sOU44qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903177; c=relaxed/simple;
	bh=yADNLCBdTWcxvE+19nermOxAO18JP0cn+4ambpmZ76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0VYEbT1BPMtbJ6729+H00dlVAjQyHh8WY159EZTiVc+B545JfBZiU4oT24bMvz4gpv/d9tD4eeuunc/462RJ4udy6wuIf5RGlKSNYYhZ4H78xmxkaDgCc3EoEBbcd2VXW8ne/GAiSuhhgBM73iPmZVHkS9HbGwDJUfB5WUKScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jP8bZfTk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF4c3003108
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oB5zz3RfytAZkiTmGBlOmVi4
	cyClShFOwbxdsuokSZg=; b=jP8bZfTkIU6+CM9/1SrD5yO4OdWZSsNZBiMFUweO
	rmVyZ5TMqda6N3bHDJCAfnxH5MmcliWCFu0OLbCKCGYDA/zdWhdd/Sz/hPATj33G
	GtFZGbk/S4EozmQ+ksCCkNV1aebzoLat1wMP/iwS2PcduBR+HiQNouUeTJ9iokXc
	XEhvxkdzTL0RtAxIZaK+XrkDb58wvNEKkpjFb7lo+Oie6///iTGPSjVNwyMlb4NR
	b4OrT4Uvc/lZAg0JlQXS3VMNYLUk2keeSA/KilcyF/32bZF2JTAeS01AxonLkG4a
	aN/7Qo4/P4voZE8fTljEs70fB+vVvZtGfXYlFK4+1ojtkw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03q5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:39:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b345aff439so49811771cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903173; x=1757507973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB5zz3RfytAZkiTmGBlOmVi4cyClShFOwbxdsuokSZg=;
        b=lA82vmBRAxxX9vaSeorKE5/0/px5MkVV9KRob/jJeUNwra+AjIvByHlligjUQ0yqyd
         ceQyMQZIdZVY5LLXsHxoykdHPyAILc6q+v//UhiXX67I2WTplQXzEVnh+ga/GTGgWJfz
         1yQtVVbUzlxWtuV+ufMh8WyyHPDdLojAmS5DWvh3ZBwR6OfUoZQ3Q1JUCYmVXg08B/9l
         IwUnnY+dJNgUS77NZNKNAEH6b9Xl7ACFP6f9BF0/BiJ/S2XB5ZuCJ1g6KebL3PdXQFIz
         XBnMdVGb3ezl2mccT5NVbMvUg3zBqk5oCN4aVQW7k1Hil8gRo309CZ9mXyGGJYGdCsAk
         +E7A==
X-Forwarded-Encrypted: i=1; AJvYcCXGW+dbOUIHKjdzPIjkjtOL1AawTx90st2c7V5i/y5hJ/NEzTMzLi7s+8juyeyPGVlrHtbisrB/zhR23ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcdZ5sqHBwGWAk6cmJOY917z6g9qDj6ebarRYuv7bWgdssoki
	s/gpDFiOMvDtZQtxRTSM0KJyyoHNPVZn64yiunclecVhcubXFLNbY+mrSypCvV5arArUUtIddT5
	wZgzGZbtRCD4nqFrq69ni/f+GidQ43OpkpBI5iTgWau6T5BoASmgLbOHThB9zwziyKbg=
X-Gm-Gg: ASbGncstP6bqUoRxODgj5Dsd2FdrBP4slCBsC32+3BXHQJdICMQuEnAlSuS/jCqZlQ6
	gLEPocD0Hedhb/4dOv2TW6XX4ptIXIKu+REZZFLKsV0K/xtmpuAWGr6FDyezM9a8Xbo1sqnbpak
	+Ce98nUalFjAgBpipYdvfoiEuHWy4IH7Gk+O6/4LngrZ0yXuRmb80SStaAGmfvh4wgbsfkzxwO8
	KlIDmeaJdBH2yKRCx5mQ+S1o0JGh3wv4fTgzpL9BFd0ClLRrqZ8DjQbnNj0T3quKqZUBArfENaJ
	4j5TIQ1sE+F2fbCwcHjwTvfcop8hOBw6l5cUz264RWm1oeBlcmj1J5EIfyAVfRapY150Dw518P5
	t2PhfkC6aZ1A7zHL54AU/e8HGLxjm8NCHYfFe5SWkdG7XBb+h+TQt
X-Received: by 2002:a05:6214:e8c:b0:71e:bbb8:9db7 with SMTP id 6a1803df08f44-71ebbb8a459mr109507296d6.34.1756903173373;
        Wed, 03 Sep 2025 05:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG63LR9Aapde9PYpVYUZt99aQbJ5sCqnamanQcH/5zSG/5fKAEXGXcfQRfuN5dgQfaxo69CWw==
X-Received: by 2002:a05:6214:e8c:b0:71e:bbb8:9db7 with SMTP id 6a1803df08f44-71ebbb8a459mr109506366d6.34.1756903172631;
        Wed, 03 Sep 2025 05:39:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608aba1767sm503270e87.49.2025.09.03.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:39:31 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:39:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Message-ID: <exkrgx6rdotfrrsnklsd7zk4ydehsk5vaoevibpqisyq2dwbd4@sa4kgnuexlna>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-3-97d26bb2144e@oss.qualcomm.com>
 <f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com>
X-Proofpoint-GUID: 4j3-Cpl6SVSwGIvha0W5C8jZPEbohRPQ
X-Proofpoint-ORIG-GUID: 4j3-Cpl6SVSwGIvha0W5C8jZPEbohRPQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX4tjyFw73yig/
 NwgzMtXpUyglE3sg8FkcppzCo0Eqp81qsBaNh09/yLE139JwL5wHCQraJ9DksVJvsloO8cS0NiS
 JGSCxz6Y/+kXShu2GWB++I3+NZrBAQ5bDLofIgH/83dmfuMAZmp8Rep8NMIYq547XAUpZzdFZwS
 IJUIZzgAZNvOAtNKTMh6wqUlemVu0105ln5uWvkIpD0iHaoBvEQ+SGGvAPBQD61I/g911+C0Hft
 XPD2bK16R+/rsEX2X9V5NHD8alyGr5GKZDzqLoPCZuN+uPf1r2fg86grlFl88pwKHAE0O0KKgAK
 OOxvAHuwwoEl/bNqe1xMtvxuw+UFbbKszr+fQ0GudN8NHSWtIw6iHaqo28oZhoJMEAlASjzfqEF
 qjtd1dRS
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b83706 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=eIaLAbkvAzmcLstrs1gA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 02:26:30PM +0200, Konrad Dybcio wrote:
> On 8/21/25 8:55 PM, Akhil P Oommen wrote:
> > From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> > 
> > Add gpu and gmu nodes for sa8775p chipset. As of now all
> > SKUs have the same GPU fmax, so there is no requirement of
> > speed bin support.
> > 
> > Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > @@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
> >  			#mbox-cells = <2>;
> >  		};
> >  
> > +		qfprom: efuse@784000 {
> > +			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
> > +			reg = <0x0 0x00784000 0x0 0x2410>;
> 
> len = 0x3000
> 
> [...]
> 
> > +		gmu: gmu@3d6a000 {
> > +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
> > +			reg = <0x0 0x03d6a000 0x0 0x34000>,
> 
> This bleeds into GPU_CC, len should be 0x26000

gpucc is in the middle of GMU, see other platforms.

> 
> > +			      <0x0 0x03de0000 0x0 0x10000>,
> > +			      <0x0 0x0b290000 0x0 0x10000>;
> > +			reg-names = "gmu", "rscc", "gmu_pdc";
> > +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "hfi", "gmu";
> > +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> > +				 <&gpucc GPU_CC_CXO_CLK>,
> > +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> > +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> > +				 <&gpucc GPU_CC_AHB_CLK>,
> > +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> > +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
> 
> This clock only belongs in the SMMU node
> 
> > +			clock-names = "gmu",
> > +				      "cxo",
> > +				      "axi",
> > +				      "memnoc",
> > +				      "ahb",
> > +				      "hub",
> > +				      "smmu_vote";
> > +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
> > +					<&gpucc GPU_CC_GX_GDSC>;
> > +			power-domain-names = "cx",
> > +					     "gx";
> > +			iommus = <&adreno_smmu 5 0xc00>;
> > +			operating-points-v2 = <&gmu_opp_table>;
> > +
> > +			gmu_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-200000000 {
> > +					opp-hz = /bits/ 64 <200000000>;
> 
> 500 MHz @ RPMH_REGULATOR_LEVEL_SVS, 200 isn't even present in the clock driver
> 
> Konrad

-- 
With best wishes
Dmitry


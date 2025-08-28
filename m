Return-Path: <linux-kernel+bounces-789803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7299EB39AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D92049A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1C730DEA6;
	Thu, 28 Aug 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcoRMiux"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99C30DD3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378965; cv=none; b=jwellnyBi4Knl2CWjJfj7HNlmpoxmeVKVY6aBAFrgGlC6wgrbY9yoMBMs7NTyx4iaVgcUuxFTtlHFLhWQMbx61CJ1zEU/X7jbBb1CqUnuHbnsgUKpTsN7L70WfuHekW3ZmyVrHKN9gbhiOVOcNVb1Y/EshiD5GuHQA6CjqvR3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378965; c=relaxed/simple;
	bh=CFk788CTQtHLF+TmC6dyrNyhtRC8O29w4e1pbgQIkAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek4J7aRyMYRtbSH/GMR7mklEes1SmCYhS49x1/ncjwutk84ilky/jGUvVxsFQezA2WJGliB8DvKVAuDi09RB2uqWbEO4dSHI38/EPbPNOPY3tH4yPNmdy5IM+zMx4oahzP+ryrEPl077RsyoUZtNKxm0KVNE2ZJZ5NoxpzTv6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcoRMiux; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5kfCs030104
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F2GF8m16o6OAqw5iKNI+Mso3
	sbpHt+bzz810g8okyjw=; b=XcoRMiux6ETNaIFojt+XIEkxh1TCDpuvByhdP4bk
	HVb6uhLRUWBUG0cR0DCPCUBokq5ZU8KzssJF6nGFfGsV2qpapa618Z+jAtuxf3Fb
	jXzgm5eCyGoCoEoNSyAOsgwSklF/nZy/RgHaKqm946LA5EXAdF+IpgiBaa43xBRu
	T/jImX+wMjkUefP8YPCYO2l3sNGcDVHZuZ3kG4hravoYIdtcy51LXlTl6+3sNulH
	ws/5WrVJZM8lrzV5YkWfsXFxPTLlHyOyLL8K3to7OasYlXeToMHxlesl2+6qGdqD
	mnSVs4g2bq0Q5yY/3juf5l27I4BxhRWDEowcbJFSYNCeVg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unyt6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:02:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-520d1b46f70so83113137.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378960; x=1756983760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2GF8m16o6OAqw5iKNI+Mso3sbpHt+bzz810g8okyjw=;
        b=bgDw8uZLrbrGhnSw+3D5BMUEINlbaxLc2FEI3zUh4fZMK0/KJJ3WLORP2CfHxHbT6t
         O5m4A3EO7nJt7/cQHHzEO4V/nQ6/mnFxgazehgUOhYsC7bfxsl1iOZq2rIycbXyI8lOd
         vrqMaEJpbipuYTQoqnbOEJjndICTitTJUXy5n7aP9jjKRA3l/NEwdWQdwM984X8oR3id
         VmkZdwAKGDc9FNM/Ff30Siyib5Lx1P5Gl13hjxWRYuR3JwoNRdUHJPgi8o9JpJB94LSP
         NWcsV2JQgVEvtN6Gn3mcwmeFTeWODh+A5sNdTRWutTf0eWxpHvBKGefRylnDqsUaJvQt
         4dcw==
X-Forwarded-Encrypted: i=1; AJvYcCW8e88oa6ypQVjIxK042BETd9+iFMz7aCedA7E59LMzSmFWBlDQWwbIYwoAfE313PhSeszbYG3s9kZZgic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0bAZ9b7kdr0WEDcIf8vysZitvnr2+BdNtFcBNIxRxbkkd/48
	ULidvIgf9ls/c+r1GU2XjGb49DhGzejJehZ+pnCByU7a7JGbAOwnp32haRy3hpSBDgqsmxGVkoX
	Shw4+vrJLjfH/sYBMlSPUIs1gx8Q/O8A9bichwVKfN57aroSiAskPiygQJsH/mXoaxyc=
X-Gm-Gg: ASbGncuRpajbcrTvvMJ0BhjDS5rR1LYb02RHIzvjDz0F6YEFqCWLuJ+Cl5oVAOdL/n1
	lb0bW6wVbd+/jioO/KH2Nm1OFuqSoSAoR/xXg4CSLAmEr6x4eZDziWY2dO4q6lCz8TzOXTg1FIn
	WU2MITFvOJNnO1PC5A+wLFHexYhoxAzPC9C4YSq3caUL647LURV03siMxaY4XMMk8c5thMPM3cq
	TUfsi9bZntJG98cYFiOLwL0alGlKCbfjdXQJcAGeFfcR6UFTwby2ibEYigzQ63RVdvYd6nkJ6WU
	2V1abGZDsbWq6sAEL7GJY5VfuIx80j738orisDmy8jxucJfXR9xU9nJWFUHxyYf1vha+Cpl2DrO
	VkQ+nWa8XLEx+7uX8aGFcCP60B1KpMAtoG4G9o4WBtY5e1JzQGEWQ
X-Received: by 2002:a05:6102:6897:b0:523:d0d7:b96f with SMTP id ada2fe7eead31-523d0d7f3e5mr3855087137.27.1756378960149;
        Thu, 28 Aug 2025 04:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc1YzNNZRbKF20K4DvgnG5IiKE23IMMO+7LXCQetMVhOpDeip9ruV7WUa5FA3g+kQYZ3nqzA==
X-Received: by 2002:a05:6102:6897:b0:523:d0d7:b96f with SMTP id ada2fe7eead31-523d0d7f3e5mr3855047137.27.1756378959378;
        Thu, 28 Aug 2025 04:02:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5a5d23sm30873271fa.35.2025.08.28.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:02:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:02:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fange Zhang <fange.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <snery6acisgvxtofsrbbqtpoirh5ffyha64lz4zekg3kvwrsyv@tfyydedc7ddm>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
 <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
 <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
 <zoogyjua4l6e2bgsvxx7w26n6v2hwnp2pvkizzzsds3c6cgaag@2bvqdl2z5ds6>
 <4913e937-3892-42ac-8145-cc9c2364242c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4913e937-3892-42ac-8145-cc9c2364242c@oss.qualcomm.com>
X-Proofpoint-GUID: CplLWlt9Ylv856OGKpK2e_Qw_Hrm-ZfY
X-Proofpoint-ORIG-GUID: CplLWlt9Ylv856OGKpK2e_Qw_Hrm-ZfY
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b03751 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=7kMw-FopA8EqEyJqEoQA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX+1WgAqL627R1
 t0mWs5roxioiaUoBoiBvbTHsj4BV8UAeJzDYPteyi1S63saQNtPFJtibkAbddz8ViA9rgPgjIxc
 bmY8UiPiWzTD8NuuZUG2v7Wu0bUgJ4rZpEc3yUqCOwVrzIGnKbKeiO7eipgnEPygTc5/dl8Runa
 pZgoEzu0k4VpRx5qSwSDmzxbS6/Z1ClqzIPG0R6QYTurAAiWFBVuxiXXNe9NBk8BIQjmSLp1sS2
 CKsDL0Kmm0VtnX+dpfRWNE9IE/e3k8CuYXT2L2zvI8ez/2r3xRqnq5bPixfbEFpzvqs33077tAN
 CdoZLCaiq438UHunMn5qlmqyiWaolFKMrBgnkFRjvTssCenYEFyD2xv3MljWZmGu/Ugtjpxc/PB
 dtjHRgdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Thu, Aug 28, 2025 at 01:12:14PM +0800, Fange Zhang wrote:
> 
> 
> On 8/28/2025 12:41 PM, Dmitry Baryshkov wrote:
> > On Thu, Aug 28, 2025 at 10:57:41AM +0800, Fange Zhang wrote:
> > > 
> > > 
> > > On 8/28/2025 4:01 AM, Dmitry Baryshkov wrote:
> > > > On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
> > > > > From: Li Liu <li.liu@oss.qualcomm.com>
> > > > > 
> > > > > Add display MDSS and DSI configuration for QCS615 RIDE board.
> > > > > QCS615 has a DP port, and DP support will be added in a later patch.
> > > > > 
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > > Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
> > > > > Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
> > > > >    1 file changed, 150 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
> > > > >    		};
> > > > >    	};
> > > > > +	dp-dsi0-connector {
> > > > > +		compatible = "dp-connector";
> > > > > +		label = "DSI0";
> > > > > +		type = "mini";
> > > > > +
> > > > > +		port {
> > > > > +			dp_dsi0_connector_in: endpoint {
> > > > > +				remote-endpoint = <&dsi2dp_bridge_out>;
> > > > > +			};
> > > > > +		};
> > > > > +	};
> > > > > +
> > > > > +	vreg_12p0: vreg-12p0-regulator {
> > > > 
> > > > I should be more carefull when doing reviews. I thought that it was
> > > > pointed out already and didn't some of the obvious things...
> > > > 
> > > > First of all, the nodes are sorted. By the name, not by the label.
> > > > Second, there are already regulators in this file. Why are the new nodes
> > > > not following the existing pattern and why are they not placed at a
> > > > proper place?
> > > 
> > > Initially, we referred to https://patchwork.kernel.org/project/linux-arm-msm/patch/20250604071851.1438612-3-quic_amakhija@quicinc.com/
> > > as a reference, but its node ordering seems a bit unconventional.
> > > 
> > > Would this revised ordering be acceptable?
> > > 
> > > ...
> > > + dp-dsi0-connector
> > > 
> > > vreg_conn_1p8: regulator-conn-1p8
> > > vreg_conn_pa: regulator-conn-pa
> > > regulator-usb2-vbus
> > 
> > So... Existing regulator nodes have the name of 'regulator-foo-bar'.
> > 
> > > 
> > > + vreg_12p0: vreg-12p0-regulator
> > > + vreg_1p0: vreg-1p0-regulator
> > > + vreg_1p8: vreg-1p8-regulator
> > > + vreg_3p0: vreg-3p0-regulator
> > > + vreg_5p0: vreg-5p0-regulator
> > 
> > While yours use 'vreg-baz-regulator'. Why? Don't blindly c&p data from
> > other platforms.
> 
> Got it, The revised format will be:
> 
> + vreg_12p0: regulator-vreg-12p0
> + vreg_1p0: regulator-vreg-1p0
> + vreg_1p8: regulator-vreg-1p8
> + vreg_3p0: regulator-vreg-3p0
> + vreg_5p0: regulator-vreg-5p0
> 
> Let me know if you have any further suggestions.

What's the name of power rail in the schematics? vreg-Np0?


-- 
With best wishes
Dmitry


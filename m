Return-Path: <linux-kernel+bounces-834713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BABA5575
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8D71C06295
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FDC21B9F1;
	Fri, 26 Sep 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dasVPYLA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093C4C9D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926017; cv=none; b=Fk1U+z7F2AObjcpB0jaww5r5zPG5qwdrZFHiPTRJDucJX0qRQPw2zhVLl2dQgEbLj6Ul4Oush32cTl5ag2mZz/n7Afgx7aSUUn+hSY/qjOIwMWkpdyqRXu7BrtoY7W0vOxCSaHHjdAwBnOZt5EH8CN9FNlbs1rpylf+qs1VcUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926017; c=relaxed/simple;
	bh=WihlUpCatJXzbEhdB4Jf6SOYreQac4msrJFhTInTQYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5or1S5fGouhJ4/JPTI3O2V3Qm/TenBgLWQLTIHN2foJNwrsYQri/N8P/DxBU1aJnDDPWsN/yAMICC29bak9wkGq2EAeqlPyES2IgzN95XdbNhRKiZbcdkXDhoGL1IV6UJ9sdUI4WPDc+kVwjYNHo2/fAALicWLqW0zHjKoQ2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dasVPYLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWv6E016111
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3Or5vLFDcKg6wvj7xKG6HCsm
	OnSsGxpeM7FLlYtTVi0=; b=dasVPYLAJuOpGR40LBD3NvdHO5l+Vd++4AzXaepO
	Ts02+F9OJDJZIQXAhn3DkNTqIjI9oN5t7BEAEGb8kacn6Ojdg5mzW4qA58/cKL7v
	6kW49xQk2+4MqS8+LaYPjV97FP03O2Jpsm5iI37zgp/iyVKfYEMsI5wlvePPXjjw
	XfU6reqU1CCQRVSupJOL0RUMO4jNJJYNhKq0hCv6nf9ty5NNi+RfQWeYGJwXkf3h
	sCYByKOkKcjtFeI7HQprdUotQY6Wct6rahT47RkhUcomZgK67lGSULIKFtDNqvae
	ISAZKjB/F6OttzyCZj/JtwnwMpyOdRuz+5r98j4ne22AcA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0tvamw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:33:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8635d475556so95455385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926014; x=1759530814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Or5vLFDcKg6wvj7xKG6HCsmOnSsGxpeM7FLlYtTVi0=;
        b=EYYM/SLi2jcqIvCiaXx3yeN51H9pXpLMufjuEGRe0j2+3yq4wwx4PmwVqG7pVRf9WQ
         uYMo82UPIM7bZiEwuTOLnFXtdCxG7Lcv/K39kSWUNAJTVD8LT+hAFDzP/D2TrOojaBCL
         reIOp4HJlSVscYPHr6OKSCZTmb+tNw9wWHRGSyokS/baWHUSv6lF3XUm6MY7DEy0TwtT
         GO/wdWMd2sDc9GIGyg/dA140h7zy2HfOR/pvqzOgcRiCQ+I1I0KKbmb4OKx3bECOHcwS
         6GS1Zpg1OrNexG5rSqmttxVNir1SrAugARFlamOGomCObWogCav9x9A/KH6AImCJIfxO
         7xSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTvPt0eluYxjhNGF/l+KFGjzMJmLKm8J8dk034rgfdenL2neEANu1wtDUijZ4z0GuI7Zpw9wsXBKu7zM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTTT2Na+/3HxjGKZcby5TyYiQhJJbr0X+YlE0+Qt8N3gAmMgj
	XcUCHK17R8TINkjz0OAxIVS1BltqMG6Lo68ERh+dAnJGQ24GvJR2WH4vdqaIG9xs7UeZEaq/cUL
	mPPL21kDVz1Atad31iTthY2uPRP5Lkx6AtWdL7rpPD6AZ2kIHxjaR7hfa1VG+EpN/83E=
X-Gm-Gg: ASbGnctPUhuhLFrWVfEEabfZJO3nfELSjblh/BuN0rjyiOON0T54Dqb4/TXUVYpkToF
	mnXwqgE02K5uFbMjMjY0y5yCtGFcBnzaQmq0/IadU5ZlFjqlWFFPZn3VzerS0iFjnnRP48vvZp8
	sqgXPyg5fPnUqCNrHiV8mPToCitTOQzBhI+1FAK0vjb72swFs0/2+herl1Jd0sI6KsvSg7HDs4q
	l/nvyGfo62hYD9w1QuBTtjWVx7oWkJoHleR87pl8PcJZrRFOWEAQAkr29i6DlRxZQ7GJy+1PCeR
	mr2d9/LBPZh6Dem/Z9ORAiQIDXZ1Aps7jsUQaUBLJBsHSwk8uhJs167ByBvpS5N8xZBpCDwlIYP
	/COI82v27ENjeiZvIGz5d80Ct1esXfnsSrupLl2gk9ePU+FJV91Ei
X-Received: by 2002:a05:620a:4722:b0:812:c6e3:665e with SMTP id af79cd13be357-85ae95bb3demr1259247785a.72.1758926014170;
        Fri, 26 Sep 2025 15:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGlBlVSNEdFA62HtaMvEdOqlUHk62xrdjiElYIUfi4rlEghXbDoRODtWnCJ0T2a31GZswcKg==
X-Received: by 2002:a05:620a:4722:b0:812:c6e3:665e with SMTP id af79cd13be357-85ae95bb3demr1259245085a.72.1758926013710;
        Fri, 26 Sep 2025 15:33:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710256sm14294101fa.45.2025.09.26.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:33:31 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:33:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: glymur: Describe display related
 nodes
Message-ID: <mztchl7blmp5cdjiyg2btl65o2jrydpn4m3fc2liyxjci5vish@k33bvcyvz25j>
References: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
 <20250925-dts-qcom-glymur-crd-add-edp-v1-1-20233de3c1e2@linaro.org>
 <43jgqfcw2nnasdnskfdri5swddr6kunvvp6oxzqibnlvyc4jd2@4y6x7fy5shq2>
 <r7f4zzugs3io4ho7qdjudh2ebyphtsjdnchnj7hnt7msoiylfz@dhfgzjg3sh46>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r7f4zzugs3io4ho7qdjudh2ebyphtsjdnchnj7hnt7msoiylfz@dhfgzjg3sh46>
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d714bf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=huGdDiliMdS7e7ppdeAA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3w5v5U44dUZR3ky-5L5Br7E8r5M9QR1f
X-Proofpoint-ORIG-GUID: 3w5v5U44dUZR3ky-5L5Br7E8r5M9QR1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8uLpWkDxb0uf
 WsdjF/Vu/i0O7f75KfiMFpqfwMWK8+XIqYU5HtnNUDBk5gbryPr7zQjB3HcEtpke+dA0r7eiXK1
 LzanKl6kn6iUbnmUf4JUlyR+6OZ6+y/TyRsY2GqRhWZid8PQ/Coq8hexSVzpwpABUy8JsmDBVHD
 pmBjE34PpNjxDG91NkQbYYp0pHkcDoW2uxXSHSEvU10Z3wwbX1DKAnGKc7VAzt/s3JIlDtPXCKe
 vR3fTb9i1Ke3YidNX2cQP9CXjmiRYDX7DBHQGcgugUV63zZnpgq3GQG5B4RgpHaesuMFZk4cJv7
 2i3WrRTmOLE8nGO5EmtGMko6sH7oYNdSH8xpMt1qVecL7Jvo4mJbSA+wsGrVW+TgP/UWU3v3sLU
 6c/SaDUtPE8sYW6w6VbnDI0L9OD3Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 09:50:22AM +0300, Abel Vesa wrote:
> On 25-09-25 20:11:11, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 06:02:48PM +0300, Abel Vesa wrote:
> > > The MDSS (Mobile Display SubSystem) on Glymur comes with 4 DisplayPort
> > > controllers. Describe them along with display controller and the eDP
> > > PHY. Then, attach the combo PHYs link and vco_div clocks to the Display
> > > clock controller and link up the PHYs and DP endpoints in the graph.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/glymur.dtsi | 492 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 484 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > index a131cd6c3d9e7f14ed1c4aef4b68e1860cc3bca5..41d89998b1fe14a24cd528e73afc37cf2a840bab 100644
> > > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> 
> [...]
> 
> > > +			mdss_dp0: displayport-controller@af54000 {
> > > +				compatible = "qcom,glymur-dp";
> > > +				reg = <0x0 0xaf54000 0x0 0x104>,
> > > +				      <0x0 0xaf54200 0x0 0xc0>,
> > > +				      <0x0 0xaf55000 0x0 0x770>,
> > > +				      <0x0 0xaf56000 0x0 0x9c>,
> > > +				      <0x0 0xaf57000 0x0 0x9c>;
> > > +
> > > +				interrupts-extended = <&mdss 12>;
> > > +
> > > +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > > +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> > > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> > > +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> > 
> > No pixel1 clock?
> 
> Will add it in next version. Everywhere.

Except DP3, if I'm not mistaken.

> 
> > > +
> > > +			mdss_dp1: displayport-controller@af5c000 {
> > > +				compatible = "qcom,glymur-dp", "qcom,sm8650-dp";
> > 
> > This doesn't match your own bindings. WT?
> 
> Urgh. Yep, this is wrong. sm8650 compatible needs to be dropped. Will do
> in the next version.
> 
> > > +
> > > +				mdss_dp1_opp_table: opp-table {
> > > +					compatible = "operating-points-v2";
> > 
> > Is it differnt from dp0 table?
> 
> Nope, they are the same. Will use the dp0 table for all controllers.
> 
> Thanks for reviewing.
> 
> Abel

-- 
With best wishes
Dmitry


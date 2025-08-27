Return-Path: <linux-kernel+bounces-788627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A47B38790
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89193BC083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B247342C89;
	Wed, 27 Aug 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2tooOSH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACA34A323
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311141; cv=none; b=cVVg02AQwE6NXrOfsYKSQIfLuNZsnpJljPD5TI8FgApStO3icTn4IN/mNgUywt7pgngYITyt+iYdmgBGYn/SH2HwB6SEqB6+bI+K12xgXn8iy8VDLv0oxLiXudjzLkVsaWi3h8oer7Sctr/65vL3bOUmfAP9Pl+y3dUTt1t6wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311141; c=relaxed/simple;
	bh=750cOqZxARFI7wMXGRw7BUrxICd1tIMVtD3N2B9NWn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjYAqxBg5in0ag6lB55zOgwwlAZUppqGoxQ4QBoZ4wV/qAHWh9pXKdUNW+VPVMvIHm6T4WUNK5z9i4Hm/3tiCR6dZ1Aa0NTxkw9biDvEwIdJxN80JT+2MzPKZ0Y1ijrjs6e3N11UE58sOhmAIRDvEwbtAVgkJjCYCQYCZNMXMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2tooOSH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGB8Hw027484
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UG7xbcS5Tii6txkMjvrtxmVb1b0CdEdYm68Ud4Hqmfw=; b=S2tooOSHVLC5jxH+
	5USDj1+Mi/aN5PSszo1VkCxJsEZp/x2NNSseIlr8mFtMLZt2Z9bTIhx43UIJwMI8
	XuSGehcUGTpAOnkZNGFpS7iyGXS8sDO0lS/DWDLX0Tn0fCOhNEzdbeFX/lvP0vh6
	aRnaZg1Rrbby+gHpjcSypvx1yjLPXcrNCOOGhalKV+MKRAsoSICM4WC9Ka5aiWZS
	ElUMcr2afmOO+pnp4wlqhwDeVQrUke27BL9fjUqiWiPlNML/Oda7a91QpfD1twCt
	Atn0miSKh6FSqzz832FzCbmbnd1CyqRCosKWTC4SYhjU98z8E7SSeezbCp/lvdub
	ZGo2Yg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16v95n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:12:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dd6d25609so2572366d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311137; x=1756915937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG7xbcS5Tii6txkMjvrtxmVb1b0CdEdYm68Ud4Hqmfw=;
        b=bd18cilsVZh77W8ZMR/GZHAFPzHTOIsU+aTYCeFg/KzMPX0DhjGyWBE107HTnxThmq
         +CHLeWjw8/Z8uAj5zOjACGsUV9dD4T8U3cO+grc1305EvQMnVeLjzrqqOuX7alOin1Xr
         z3R8xkEUQEzPNEX9r2Nfzfy/QcuFC/2E8m4BQq8cSCJTQGL+Nx6lNhJmdnCs9XHDDdEl
         pS1ldOrzlulZjTh89crejFTeYwaU7AOPxqK1M57wVANAVwhtznPIXq9sGRn9F/1o/o8s
         74E+4NuYDzw/ASICUw18RfKt/Y45WhAfBLu1ZSujJSEKkd8tUEH3EuT7C6g09eOz+Fhm
         nbmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzvm5Xw48LySWsTwD6KzGfeWxu/9Hgb+cEtt5IQDY/uugEKMSY6CV7fG+d2TMeheuuf9+Y89d9Sx4dGu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Q4sHEK1HRysiTX4mhPdpLgjMD2Z/P6e6+bS39WGAHEccQveR
	sDqI00SVtbWXhiqbm9x+poYPjNT4+0KIIuUKjLit2th8DFKjbfp0hewVKs6g30Jbf4WX5uW2Ea+
	mCHXg3k5io2UWkhF1olhmWuNgTf+B/dleMo2Rhb9VmJDGGfm3qFAh5KvcnCduSaomPNQ=
X-Gm-Gg: ASbGnct7g9bGnsjOdUK5N+XXczhfDH4kRF+vA8hTdK6Q1GVo5dKLiR8Ady7lNBTT6zg
	HoM1PSGsiB1wLwa9M7w1aXCbvM3iT1AyyaiIRdxtGiKpzcTy08b9hireOg8Ulppy5ZQgwej24ht
	TVSNlsEx5TUvtvPuFAj8YV75osFAB+jomH83nPM9tc2xjkqQwfohhB/IKsoor/3+Tlm7SRcvBLd
	lbeBx2G1Nl1i6C1bhsqcezFCaF8Ouxj1gCcIOzDEkmh910mzmeCLEXA6gGUvc85Kap51hM2lsid
	Q/Ovjo4yWcbLPRIa5gpjEwqxC8iaRrBvOosvl1VwyfrRNS5+fMQyPYp85VLiZmCqijdM/ZvGv4U
	MHflf6JgTQ7YcBpzMgntIjOqATCmwAlFHwV2PDAU8DHLeiat6V/TP
X-Received: by 2002:a05:6214:20e6:b0:70b:acef:3c85 with SMTP id 6a1803df08f44-70d970976d8mr247393196d6.4.1756311136338;
        Wed, 27 Aug 2025 09:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtHCsOyM9I3rbi3EujqFjTjTxiDfCaPiXddil+SIYuI0DqIfUpa9RqPP6k9YnaNKG73ul6bw==
X-Received: by 2002:a05:6214:20e6:b0:70b:acef:3c85 with SMTP id 6a1803df08f44-70d970976d8mr247392546d6.4.1756311135723;
        Wed, 27 Aug 2025 09:12:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35ca7437sm2866204e87.146.2025.08.27.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:12:14 -0700 (PDT)
Date: Wed, 27 Aug 2025 19:12:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 09/14] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
Message-ID: <hy66bjkygfz2qdhatdyxpw2cktaeohguwdg3ydowubarqebfzr@2rjjxghmhdya>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-9-a43bd25ec39c@oss.qualcomm.com>
 <3pr7ninjxr4pgsz56dr6ojjmx27fzzszmtt6mx4r6qaqt25tnc@nrgx5qiqc7z4>
 <9bf7f51b-dcfb-4ff8-848e-dcf144936f2e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bf7f51b-dcfb-4ff8-848e-dcf144936f2e@oss.qualcomm.com>
X-Proofpoint-GUID: HzlM4hvr5PAFHw3TUi_eCi_fB6rpJT0M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX5R0h81kKZtc/
 2hmUbKPmc0gDc+6W1txLEwbwfsOQZYMFXd1YtiHJ1NnYlhs5tVy39CrJVefzl4Q4Nn5Ul7II5yg
 /3IZ4bUklPkYMNhfpM83HX8wYkIoz6QCzm9DmUR7DiRvYNBdQT16++DdshnCTm+oJ2y7UNl07Xh
 JqmlT3JFsCZo9QoSHkbLImlk6x+a5xWm5hyk6MlJlwPr8Hrtf5qjeoLLU5tQx4iylU+CbUj2i23
 BKYViBGUKrv1V+Sf8E0T8Bdkmxy8QInHkCxA+cVpCBF+a0q/ovnXnWrCZdW2qMRMFb3tPE1v6R2
 0c2TuMlbvBNZS8TvyP20yyOLS8dCVFVuky/ipcGwSuHchsyZ7yIjUN0ofi5LRFbnhP/jitC+0MM
 5vHoI5WV
X-Proofpoint-ORIG-GUID: HzlM4hvr5PAFHw3TUi_eCi_fB6rpJT0M
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68af2e62 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=D5wNQ9JKZfep0icmKmAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

On Wed, Aug 27, 2025 at 08:17:39PM +0800, Xiangxu Yin wrote:
> 
> On 8/20/2025 7:45 PM, Dmitry Baryshkov wrote:
> > On Wed, Aug 20, 2025 at 05:34:51PM +0800, Xiangxu Yin wrote:
> >> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
> >> switchable PHYs.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 163 +++++++++++++++++++++++++++++++
> >>  1 file changed, 163 insertions(+)
> >>
> >> @@ -1095,6 +1248,16 @@ static const struct phy_ops qmp_usbc_usb_phy_ops = {
> >>  	.owner		= THIS_MODULE,
> >>  };
> >>  
> >> +static const struct phy_ops qmp_usbc_dp_phy_ops = {
> > Please try restructuring your patches so that there are no unused
> > warnings in the middle of the series. You can split the next patch into
> > 'parse' and 'enable' parts, then squash this patch into the 'enable'
> > one.
> 
> 
> You mean it's better to define and register new functions in the same patch 
> 
> where they're first used, to avoid unused warnings? And for things like parse_dt and phy_ops,
> 
> it's fine to split them into separate patches if each part is used right away?

Yes.

> 
> 
> >
> >> +	.init		= qmp_usbc_dp_enable,
> >> +	.exit		= qmp_usbc_dp_disable,
> >> +	.configure	= qmp_usbc_dp_configure,
> >> +	.calibrate	= qmp_usbc_dp_calibrate,
> >> +	.power_on	= qmp_usbc_dp_power_on,
> >> +	.power_off	= qmp_usbc_dp_power_off,
> >> +	.owner		= THIS_MODULE,
> >> +};
> >> +
> >>  static void qmp_usbc_enable_autonomous_mode(struct qmp_usbc *qmp)
> >>  {
> >>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >>
> >> -- 
> >> 2.34.1
> >>

-- 
With best wishes
Dmitry


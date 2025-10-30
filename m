Return-Path: <linux-kernel+bounces-878856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696BC219FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E624EEB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421B36E36F;
	Thu, 30 Oct 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZFgv9BW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVPuz5GK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617336CA98
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847073; cv=none; b=EYgj2ABhm6orqsG/68Fm3ozPla/OfpEWtdWl7pDvjI+msJYHClJurJFubwxJECLRLff73xR77oAhZl+/d9kLjXBVbFBku9qYxex7yN7q1caXVfVKaby8BG+V5QcXJCfeG5Emdf5l7Ae4co6NwnDmRBEhqbUy9MX4EwEAwK4+IAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847073; c=relaxed/simple;
	bh=EbP1TIPXCgKrJnMf9+2S7XpLlSQ/Lt0AtVMKtZ1WD08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9TcFArZD3QschMMxCc5B8yoE+QW+Oo3NQT6/KOWpObFUnydqP9csKAPoB6DonGtPFZzB48Bnp6b1wQswrs4ycbJ46uot5PVVg1LzvuEgMrL0XKu1IUUTjs8Nafk6mpdg4UL35w6/TOWGIFCtJ8xvByy3+A3U5uNzRM3ctQOLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZFgv9BW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVPuz5GK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MhLk3115819
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NXUbL/o2sn1wUE5NQyCh4jie
	IT23KtAPiSUqZFn5Wbo=; b=SZFgv9BW01+Hn166INLJytfk9Tc0qrOHMe6Tyjcq
	qw9gpkmTzNDXcgF6jt7V5uEBuxuPa+EpW4Xc+SYUBoXbwRwLKgY4nhGDPgD9EZ6v
	H+VnVuxWrh2TxX1U7ibeqK0/zqvFsPB4oEOMITYkDXKI1j5mzuKEMEY5T+zufsDa
	e1C/nFc7Rq7Z7PGajnE8QoLg038ZxrQ4R0fsazMcOPLjLH5K413XuxJpsm9Rakty
	hk9cabnqq9fwSgMnp0o6HFC6ELn0+Y45mbguGoAeMCg5S+TmwpZokpCwHKRq/Lr0
	y0lmBUPOH/jpu5au6x5iDzEUD/QmP5PALxCV7RcmzM4mUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b41fyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:57:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eba90c163cso23401671cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761847070; x=1762451870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXUbL/o2sn1wUE5NQyCh4jieIT23KtAPiSUqZFn5Wbo=;
        b=eVPuz5GK812c5b8FLb541mONNlI6hzKjhx8iQOh4Ybop1i5pecyVCAIoT1mxn0Wx9V
         aPUVN2iTNCsNAICRbj4vcchzrySlBjFnqx5QIvjE9btAy1WxA3He0IqXVncpv5sFIkMu
         VNKRfSlkX/oSHmG38MsNGGX15L2jX/25t/b4XyX89GhyKljhWuwGAd8yaausWL6rKLXl
         phyfHNsK1BEIfHrAgSYzRp11zBPjWXPNczuWxP2HzMFRGx/GsIWnuBBMoX3t0YIcFHzI
         cpCLrrV+XMuT+BXr/dBefxo15pOUCQ9+1EllaBTkNdmczZsVVNIJn5i17BvGgjS8LL2Z
         9acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847070; x=1762451870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXUbL/o2sn1wUE5NQyCh4jieIT23KtAPiSUqZFn5Wbo=;
        b=CqAdh0gHkQvl7IqJDdwQeNsQcWDIRq5wRkN/HaNW+axxRarkDWp9IBVPdo4QBE+4lu
         U0q9YrmydWMQvUG4u7HhTnmoOduiX3Rr8d16e5CYN/3jHOaQfOpYRnf4RZUGrsnm1KVL
         r/uzW75E6+k7W84eL2ZmBT9P9Epf/5/MAcjrAMW0zyWDDQNRTpRfPxxngxp2fbPDOa2Q
         n+NjAzKzEgQg7HTf1a51TFwlKM8/GEX9pzlqkTMVJSrkk7AxObZyEj3vVX+gxLzF9AXp
         dWUDja8e0Z8XE0hdQyVJPATENkZQqVzhqMnT1SCzpbdr/9NsbR7zB5nOZpCj/NQ09xOa
         sQjg==
X-Forwarded-Encrypted: i=1; AJvYcCVdBv8Y9nMB/lFSdeZJDcU5eEiYv5+4JSKYvNFMnoR4BcCiKqZG3T4bWY+jQA3sJedu6PHbi2ZMpoS2rzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKF5l+4Z7KvrScNh9ARgW9dPgBlkHpIDmQsA3aE4T5NcEV+CiS
	982/uHKa8S7z+JwJb9fs1ee7L3P89mszJ02Wl1Ee//2lG+UPluz2wSjURZDFEWAlMMFenSOpVcE
	Eh+Y6bJtu9fkafMhlGfYt1V3OSzRUMnP1gODy3qDQGKKsDIGfMrUYhAnt0gGHS2mHbws=
X-Gm-Gg: ASbGncva6+zoU+vJvWvM/zpzieNlzzv7xnllHo+tCyPnmvHIyUcBLJYbFdou4X2miFX
	wj7TZLzqibQc8hGCd7+WFmR31QiImel/MKGuKJXrX3SAp7A++D23xHUzO4JoDv1yB3tVu8crhUV
	z1+li3ztZzoOmnPi+vboyczToFAJ6EIH8EgQMAUCCzVVhXERMEsLPdLRjmlE23Mo12oYq7/+2mR
	+FFTzdIq1oaGy/WLa7ORuw2VBUC/8eFY4kiGg9QwqgPV6060RYe8Pf0KfLXZH2hxAZLwZPwLALW
	E35AyuDU0V44bKZ2cSFokn2ywqPK9WpUvkxyxK4wkVSX+EojY137NPmAGV/G2UMEoYGzbiDrspU
	iGbOFxgZ4Ycco7C7iZ9HDYhvCoXO+8OEKtt9qH9FWTMRfULzIjPgr7404EH3joWe3YtpgZ0AzxJ
	NETD+NiL6PqQsz
X-Received: by 2002:a05:622a:4819:b0:4ec:462e:242b with SMTP id d75a77b69052e-4ed30dd5e9amr7059411cf.20.1761847069912;
        Thu, 30 Oct 2025 10:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSejMKE1hkVv4Ot3up0lwT6Xym/gfPMX4mG8HNuzC+q9tmdfU3kR7miFO7Jd4zjFh1tmuVPw==
X-Received: by 2002:a05:622a:4819:b0:4ec:462e:242b with SMTP id d75a77b69052e-4ed30dd5e9amr7059051cf.20.1761847069338;
        Thu, 30 Oct 2025 10:57:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f730acsm4806939e87.84.2025.10.30.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:57:48 -0700 (PDT)
Date: Thu, 30 Oct 2025 19:57:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <r3sbg5r5pesrfrave7l6nx4ws62eogfn7m4f5c3ur2a6xkhsss@f5vfre2hd2cr>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
 <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
 <4bnvh2ydtrmejknzpsxoalxoyjpq5g5cjbrico5ezbek24r52s@u5zy6ekh6lps>
 <aQF0zzUpLeUu4lrC@yuanjiey.ap.qualcomm.com>
 <5hftxsuqz745mxxk2hjpwfxwrm73p2l3dxn2mb2uqb2c44fd2w@l5xvadj7gvvg>
 <aQLInjBCbeNJVanK@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQLInjBCbeNJVanK@yuanjiey.ap.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0OCBTYWx0ZWRfXyNj2JWh4wDBS
 sOOdhKqtMuupgcarXIZfLLWT6prRpvIfp8iW90s/Q05Us3WIF3VyrQ+se7XMVE9Qf9oRZX/T5gp
 J/NWYkVXcVGfjTvm0K9pnWBOFL5pogPtwKO8agHSLGhIoY5/i7xE6wnR2FllZ/Vp/I07eeFKTCI
 /Qr78LcEKD9N5fIHB7iz4e7LmjgpfJ/9UZhNQMH4Kk/dnHIbW2uF8SdpVigagXZPAYKB+571LHz
 Dbm7iPyZ3JVWg1u0Xe8tU4d51VnW4zRhmkQK/SzjyQwJSWNjJjNCp8f4f/jc3fDNapYUcAYqJRI
 v5ffsxqaOL5DdFrjjH0o+zEqCBaPMYMc0sVunTSjmVgCyKduDjstz5H3gn8QZWwHC3IrMtBdRf+
 DjMOFxYNBNAfBcDLOkddUMNsmypllA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6903a71e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=cUaFMJGz6fvP16gA3dcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: HIaVoVR7s_wNDEPbrQS7xOxENC56Tuvp
X-Proofpoint-GUID: HIaVoVR7s_wNDEPbrQS7xOxENC56Tuvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300148

On Thu, Oct 30, 2025 at 10:08:30AM +0800, yuanjiey wrote:
> On Wed, Oct 29, 2025 at 02:20:13PM +0200, Dmitry Baryshkov wrote:
> > On Wed, Oct 29, 2025 at 09:58:39AM +0800, yuanjiey wrote:
> > > On Mon, Oct 27, 2025 at 02:22:04PM +0200, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 24, 2025 at 02:00:50PM +0800, yuanjiey wrote:
> > > > > On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> > > > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > > 
> > > > > > > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > > > > > > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > > > > > > 
> > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > index d6a37d7e0cc6..7eda16e0c1f9 100644
> > > > > > > --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
> > > > > > >  	if (ret < 0)
> > > > > > >  		return ret;
> > > > > > >  
> > > > > > > +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> > > > > > > +				    1650000, 1950000);
> > > > > > 
> > > > > > This should be done in the DT. Limit the voltage per the user.
> > > > > Two reason:
> > > > > 1.
> > > > > I see https://patchwork.freedesktop.org/patch/354612/
> > > > > 
> > > > > panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
> > > > > so I do the same work.
> > > > 
> > > > Please look for the majority rather than the exceptions. Out of all
> > > > panel drivers only two set the voltage directly.
> > > > 
> > > > > 
> > > > > 2.     Kaanapali vddio regulator:
> > > > > 
> > > > > 		vreg_l12b_1p8: ldo12 {
> > > > > 			regulator-name = "vreg_l12b_1p8";
> > > > > 			regulator-min-microvolt = <1200000>;
> > > > > 			regulator-max-microvolt = <1800000>;
> > > > > 
> > > > > 	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
> > > > > 	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.
> > > > 
> > > > DT has to list the voltage values that work for the devices on that
> > > > particular platform. So, ldo12 should be listing 1.64 - 1.8 V.
> > > get it. I check downstream DT,
> > >   dosnstream DT:
> > >    regulator-min-microvolt = <1800000>;
> > >    regulator-max-microvolt = <1800000>;
> > > 
> > >   I test 1.8V works, So I will add 1.8V in next patch, do you think it is ok?
> > 
> > What does panel's datasheet say?
> 
> The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states 
> VDDI=1.65V~1.95V.
> 
> So I should follow datasheet to set DT ldo12: 1.64 - 1.8V ?

If the panel declares minimum voltage to 1.65 V, why are you declaring
1.64 V as the mimimal voltage for the rail?

> 
> if you think it is ture, I will fix it in next patch.
-- 
With best wishes
Dmitry


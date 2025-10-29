Return-Path: <linux-kernel+bounces-876030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE08C1A7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F724500066
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BF2940D;
	Wed, 29 Oct 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hzl6u8H6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F3/B2yoq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8D3469E4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741016; cv=none; b=n8K+uXudn3i1FdmlQ/b+nq6Zpc2bTkyLAmbG8ZkWx+GftjH9o6AlRJ94HUzPmbPdfnm7euHpaf12ZIuDCQ/tRl2lU6jKWdl4cfC+h5qHDtWcLkocmb/TFIeh0AABoBhnPO8djyCyXYVI/Z68yIyMaH6+d2TRsXGyobKZ76U/Z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741016; c=relaxed/simple;
	bh=rgJ6NViG8cB+9o/YccW1eh80dpy2wvyj9cSNU462+TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSp5m+tz9nJpDTh5jc22C/IObSzdinkCYy/uGWvg5de9rKk0DjJZKfKIoFEyXU4gHcnv84rEwMWSKfSzeOgulCJjILOwMlm/3qReC/VBP5iHI3/eS8vrupb/EfkU8r2zzmNL7X0jeq1AAKd/TEkV8H1NGvDhB78Tt0wIb1XOsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hzl6u8H6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F3/B2yoq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T8TX3c4135496
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mVO0+KaQVgEr7+VvTbIWP9Zk
	5Nqcr72UBypM4fNWPRM=; b=Hzl6u8H6z5eFAyY/8Zd2wsvdvxRx9ONJlrA2HMoL
	TzxO16oJ3wGmGPIsG7lFIOf4tDn9bX6j3znFPBP489CZ1BCj21Qfikp8RnNTiFf8
	qTL3I0SUBQLe6Waof2Fmyit3jjV3JwZri3wxgwOXt6UNgYbn4w3aS09VrqqOEVmp
	BOVpxZjkxiaY6r/xZfat1JUntV89xLcMhprRPQ5fhDPMtiWvszl5WAOzo1AMSbpk
	1IBplbbLyufxGoDF8uK0Vkwi7b7pMp4lzaM1C9vEIFpJXgJKoF05U9E+IxgB4kZ6
	PltBk3hdmWngLRhZPQOYi1dQT7I55laMplQ/3TW04cQMVQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9rnv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87fb496e4d1so263926676d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761741013; x=1762345813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVO0+KaQVgEr7+VvTbIWP9Zk5Nqcr72UBypM4fNWPRM=;
        b=F3/B2yoqTCi3IglcEe57YlwCiaGr1AsbccVg1eSfYDNM1LDn3fkiMRDuurL6EjioDY
         4tHrFag+s+6LMTWCNzCJ27naymP92r2rDgWtvEYsfCb6e46PtqG9CRfwMc+icZhE3IXF
         KK2s4lWxu9h5Qu6PaAq5xyhqoFAmQU7PC+7TDSX6UX0Jo97o7KsDjfd8qyMLf2elmadq
         v6DDBddAOrjHB3eVV1MMCAwJQZgtvtnECJ/TasXoIi6813zzKBMkW9ZEAXgPt7cwd0pw
         hC777UMRNgEbVG6Ej4Q/pPW/5KzdCB+woe3OZnk8Xs+IDwid5tQoU8BNBgaAFYRpQMyv
         cLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741013; x=1762345813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVO0+KaQVgEr7+VvTbIWP9Zk5Nqcr72UBypM4fNWPRM=;
        b=jEL52JnohvbzUCQ4bZRMRIkD69FPJB5+bqAK30KplL2YtSDIoV+uaquYR2nsuAz+fN
         oHzajMuzcks9Z4jpv0IPL7zXz6LJ1JDMYlCTMjCKluvUn8mbOWtWlnrzvb0A2jL3RFEt
         EZGybtSMGH5KcLAaC7SQblBKTxHosVYefTI2hvwzXW2NU7fNKIW4TmWF0bW6xCaCo0Cs
         Gi+aF63xHTPzysIzF7EpXbXoQK6/a5ho5yy7vR6NlHXkHUj3uGfaRU6MxRb6q7tSsCYm
         81EL7SnOzXHwsefzGj7Omy5TSLwcNDRH6qTqd9UsLNeSyz15bFT2aD5mfI2OlWlsIfOT
         SGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWWvCtvgyRalGGQDmPHHjru/o5r7bnz8LQMPVglpTLYyLCLRjFIWpLtlzjDvt9TA2aqgXoxGTAEFVQkMV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqo7f9nd7uOG79vilDKI3tj1fs9mMmlWfLYY4+IcspqFJYhJ2e
	u1ciYdsdTA9XQHPFzQvJiLKJMUjWxcD9wm4sGxLaE+di7m+7Bjorh6J14kdzN2pJSykEd4UgM5b
	PxMlwDcpGLFbNud07/snEdX6aWOrpAWaX012VLVPJk3bEyecvDwCJMjQlCYC8vU6UNxk=
X-Gm-Gg: ASbGncvDhkemHSi28vI+bhyPf2ijtQhGvbmcK47DyscT559RjbE0PgZeb3L7qPV2BcZ
	OdO6uOOSMwkkXyZ2eiAy492sHA9fvsLVonZZKJQdElHRYjkMQex7GYd6LH09cJKuDsDECeSKj7x
	Y9ahFcUtguloe2eAxYG8QSSWpoOqR2l1OtJjPQHfP0JDA828LV5QV/7M0E6LGlj+cNbdtZWrjEk
	zfRXmcpRGp+oybrHUo1ZcngGZAMtdxjMrKitmAreis116peI8cGGa1ZdokSrzZ9wABurg2OA2xZ
	Ag3QHTSyu58zz934I08DKoKqnxJRjlagMSHYPndHoVGa2HXa4D9Q9PKXkCccUj3bBjbJ+vVR2B3
	8d+8yMukDzbNlG3DfpPs2Re0DghYEuWgjRf+XbjJSYM0BcNc74230PS+cCq4vIUdJvf/z4q4uQd
	q4Z3I29s/OhroB
X-Received: by 2002:a05:622a:124b:b0:4eb:7a73:5c37 with SMTP id d75a77b69052e-4ed1fce901bmr3342301cf.19.1761741012777;
        Wed, 29 Oct 2025 05:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhCfS/Dm2Cb+iBIgEaP0oh85whr46nFpyW0rt817D+HaawIxEJB9TPLfKR3+G7zjVz7oSw3w==
X-Received: by 2002:a05:622a:124b:b0:4eb:7a73:5c37 with SMTP id d75a77b69052e-4ed1fce901bmr3341381cf.19.1761741012029;
        Wed, 29 Oct 2025 05:30:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d0028sm33087301fa.35.2025.10.29.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:30:11 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:30:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
Message-ID: <w4lwl34mtd7xv7it72nvomv6te2bcybisvirfdwzdazzqisd73@fvyusj6m5cb2>
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
 <da56lghirjcwesz4usdlfpttwcmvoql2h6bvjommoyfskjdkgk@hrlgx4ukt4aa>
 <09cbf40d-6536-4bda-94d6-5b45a5746962@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09cbf40d-6536-4bda-94d6-5b45a5746962@linaro.org>
X-Proofpoint-ORIG-GUID: G7aAgk5OV_GoNNAJJqtwzAEwzPLYTqBn
X-Proofpoint-GUID: G7aAgk5OV_GoNNAJJqtwzAEwzPLYTqBn
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=690208d5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=oS8HsMxTxrPNE9b5BUgA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=d3PnA9EDa4IxuAV0gXij:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5NSBTYWx0ZWRfX3vOuJWeNewh6
 Yxu/y/aoUJzD5OoY2bxaTxMyV1JZ8Mu4Pak6ujJcgjvxkUazzyS+LlFOybt5DcWxhdF01WwX824
 Qc3H5DFlsKqWULk43zmPL5FtRLlfbeOeQW2mPJ9VPl51lB1w06WUrhJ3CNzuYJfsZzu+6ZHS06+
 xdkqJ6vVR2BhxCXSuuAg8aVDY1JmV82WuEoJxYrMuIXsSuaU4eqNwU07JMQhKps1hc2YxFOITvE
 CeZ9ndatcyCWPMWt4dCH55XD1p32qM5MBIJdLt6U3zlHnkgwq3b+2az24z5+zPhNDjSVY7gCpXC
 kc+a/gjV/GO4iLE8M7l6P070Hh+GKlhYeRzlwfg+ipdlV33semV9+4Ix+1PkgPj8sda+VUlqU/7
 P530IFalmakJdCDiQ8cc5m1ueGZzPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290095

On Wed, Oct 29, 2025 at 10:40:25AM +0100, Neil Armstrong wrote:
> On 10/28/25 20:52, Dmitry Baryshkov wrote:
> > On Tue, Oct 28, 2025 at 09:42:57AM +0100, neil.armstrong@linaro.org wrote:
> > > On 5/7/25 03:38, Jessica Zhang wrote:
> > > > Filter out modes that have a clock rate greater than the max core clock
> > > > rate when adjusted for the perf clock factor
> > > > 
> > > > This is especially important for chipsets such as QCS615 that have lower
> > > > limits for the MDP max core clock.
> > > > 
> > > > Since the core CRTC clock is at least the mode clock (adjusted for the
> > > > perf clock factor) [1], the modes supported by the driver should be less
> > > > than the max core clock rate.
> > > > 
> > > > [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
> > > > 
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > > > ---
> > > > Changes in v2:
> > > > - *crtc_clock -> *mode_clock (Dmitry)
> > > > - Changed adjusted_mode_clk check to use multiplication (Dmitry)
> > > > - Switch from quic_* email to OSS email
> > > > - Link to v1: https://lore.kernel.org/lkml/20241212-filter-mode-clock-v1-1-f4441988d6aa@quicinc.com/
> > > > ---
> > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 35 ++++++++++++++++++---------
> > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +++
> > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 +++++++++
> > > >    3 files changed, 39 insertions(+), 11 deletions(-)
> > > > 
> > > 
> > > This test doesn't take in account if the mode is for a bonded DSI mode, which
> > > is the same mode on 2 interfaces doubled, but it's valid since we could literally
> > > set both modes separately. In bonded DSI this mode_clk must be again divided bv 2
> > > in addition to the fix:
> > > https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/
> > 
> >  From the docs:
> > 
> >           * Since this function is both called from the check phase of an atomic
> >           * commit, and the mode validation in the probe paths it is not allowed
> >           * to look at anything else but the passed-in mode, and validate it
> >           * against configuration-invariant hardware constraints. Any further
> >           * limits which depend upon the configuration can only be checked in
> >           * @mode_fixup or @atomic_check.
> > 
> > Additionally, I don't think it is correct to divide mode_clk by two. In
> > the end, the DPU processes the mode in a single pass, so the perf
> > constrains applies as is, without additional dividers.
> 
> Sorry but this is not correct, the current check means nothing. If you
> enable 2 separate DSI outputs or enable then in bonded mode, the DPU
> processes it the same so the bonded doubled mode should be valid.
> 
> The difference between separate or bonded DSI DPU-wise is only the
> synchronisation of vsyncs between interfaces.

I think there is some sort of confusion. It might be on my side. Please
correct me if I'm wrong.

Each CRTC requires certain MDP clock rate to function: to process pixel
data, for scanout, etc. This is captured in dpu_core_perf.c. The patch
in question verifies that the mode can actually be set, that MDP can
function at the required clock rate. Otherwise we end up in a situation
when the driver lists a particular mode, but then the atomic_check
rejects that mode.

With that in mind, there is a difference between independent and bonded
DSI panels: bonded panels use single CRTC, while independent panels use
two different CRTCs. As such (again, please correct me if I'm wrong),
we need 2x MDP clock for a single CRTC.

> So this check against the max frequency means nothing and should be
> removed, but we should solely rely on the bandwidth calculation instead.

We need both. If you have a particular usecase which fails, lets discuss
it:

- 2 DSI panels, resolution WxH, N Hz, the mode uses l LMs, m DSC units
  and foo bar baz to output.

- The dpu_crtc_mode_valid() calculates the clock ABC, which is more than
  the max value of DEF

- The actual modesetting results in a clock GHI, which is less than DEF

> 
> Neil
> 
> > 
> > 
> > > I'm trying to find a correct way to handle that, I have tried that:
> > > ===========================><========================================
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > index 48c3aef1cfc2..6aa5db1996e3 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > 
> 

-- 
With best wishes
Dmitry


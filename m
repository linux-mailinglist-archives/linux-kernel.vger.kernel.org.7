Return-Path: <linux-kernel+bounces-797495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363EBB4111B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F1B7018E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB06A935;
	Wed,  3 Sep 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/8geawS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08233209
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857831; cv=none; b=Lh9bPkZE3sUoFVDgEMt5kcGi8GRk2yOMB8d4dDKZ1wIXcJf39wT45trfsAWZ0L2v3tiYO+U0jSSSiJO5uktJfMQuO9wzbz4Ivojquww/I8kB/cWzfNz70F4S2y8MZpX1PFNgy+Hoh+hc83VCUlbdr7cx64R7wgLK9OWZ/9HQYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857831; c=relaxed/simple;
	bh=TDm03iwtuMVy7U1hPdffbcUQW4M7Q7mLM1pOxFqcxMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAwHUtDEj5/U3W2Dnp8Ech3Cyohi/yU2aYBS0jPmMlcIlxh7MCFh0BDcyY/yWfBJjdqTeWa0pnI6b0GR00TnKEk+0ycfR4zsqRqnDHzhgmPvrPqrQ6+c98cNYiuGk3jxFMqpDgiPYmYPA6YMZJNxbP/mpJ7KUXCPocpwnhqiCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/8geawS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqAQW018243
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 00:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ELwTy4rK8lnamkj6o0BDI8Zg
	I9xpMe8TBXkmXU6Ff4Y=; b=L/8geawSjS+VL1ZqTEgE8/z4TydMsfUSymwbusYa
	x5yqL9GceOJwG0ZxmmdLBQzB1mvsQ1HfQlUPkbvRxtEXxTmpt6RWQx/ce9nwXC1R
	eZ8dJFL5So11f0KIlnvTxYQBM01hgSFNUYwDT8rJbk+Z5ey21Zpph7dh7tB7RcX7
	KRaJSiHcstOdbbK1nJf1nFONIF4vwWckmJZ3STK2IYc+fJdXBeBq6L+oyZmfu6Xj
	jEa6R4LtlgHaEJcSDDMkTtB62xEwGgPLZqFCu7+OwMR/G4ZYHoy/YAKVIdznpTMW
	btHrcrdtCaIvwsv3H8DEeqta8NH51Q9gKWb/2qkUNHii5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvwbar4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:03:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-724ee8d2a33so974946d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 17:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857827; x=1757462627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELwTy4rK8lnamkj6o0BDI8ZgI9xpMe8TBXkmXU6Ff4Y=;
        b=VB8mEzVmnlbqAe+IFlSRRba0mpThUVttCF6DrkCHwBUe9QEaYVBTYNnNMjCPQyv9b4
         sT5ErYzlgzePYqkplCj37L+zYdujEZgBWu23jlsmS3HJn75YVsDbViGgoswr2o/mo+2R
         kVCvmmzeC8Ovws1aLxPsckKEQxGUc33jEki+Imkfq3BjAVEEHydYHIRofjUHpn6wD0s6
         Kh5KSj7mlXx4X7wM8xwxUW2swdv/GX10BLURsUyzPfDg1ejOr6yY7xanl8tZEdvaFu8F
         k0aDgDLMtCnFUHnRDSsgrpaP/BgKTFO5K1rzVt8pvreVSReeocVw+KN2dEdpj0PDtpPe
         y+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFF2xrMPJbxjIJaMELK13ibjJUqTFKUL6tvP1c//oviGLPKxGQdKd0+P7Y2j9+glFrHWj8zfE2IzKU9co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRga4AoQTzE6v1pL9Mn+9SSqpF4VS/iisW+2fP5aM0xTfayyKc
	EHt6UfWWA4VZzo0bKtCiaAnF8FdkeezQTiJnC0SglM/CaFVzS+RabxxYNh6x202c8sF073jSSgT
	SOsmvWt0n5+UUEmxAwV04gBe2Yfkqxsfp3f2snnRAH/RUiyVuqdE5HMx0tldrxKeu7Tc=
X-Gm-Gg: ASbGncsr2BAT+poHl436DzsGV2T282MQRs0DSBpHuz0k47s5H14RI2qBell7+Il1X4s
	ra/dOhdiDkVtiT+GRKTRKs7kIB0VcfsZ/vFg32xYcr0Nqmj39qyP52f2M9GldLKA81ULS2BG5Cv
	d4IeejnVGd/kr0mVRsu/2AKcAyvwe9LE9JnD4NXGNC3WWfz/deAIRbNTU901X545Ww9gzFrcJw5
	NbEDlaIZyQ65qDLzBAqIsF+uagML3+ttaqX8M2oCoAVykTm2O6W1ETh4Go8d3Ar4lJ93/XtB16v
	Zp6pKkD6cOr6DgTvmbrREIplARY4/ucYodHKDfXPlP8Uax+kLcySMwZKFPMn2Mlj909P8mkpWOO
	goVZ4S89+UAyfBPeR1xYYPQAV7g7Ex8LjB82HchXmRo5pSoRJ3hwO
X-Received: by 2002:ad4:5f87:0:b0:707:5b4e:587e with SMTP id 6a1803df08f44-70fac7806ccmr199294646d6.25.1756857827316;
        Tue, 02 Sep 2025 17:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMuG9yw8tt7JLfmbhrVrt89A0reycbHukEsCqIK+5fK6gS8LGclRbsEL6lCQ/NbdLcAxNQCQ==
X-Received: by 2002:ad4:5f87:0:b0:707:5b4e:587e with SMTP id 6a1803df08f44-70fac7806ccmr199293896d6.25.1756857826617;
        Tue, 02 Sep 2025 17:03:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc24fsm117321e87.104.2025.09.02.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:03:45 -0700 (PDT)
Date: Wed, 3 Sep 2025 03:03:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Stone <daniel@fooishbar.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
Message-ID: <pe6g2fanw65p67kfy5blbtiytngxmr6nkbazymojs4a66yvpl3@7j4ccnsvc6az>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com>
 <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
 <20250901-voracious-classy-hedgehog-ee28ef@houat>
 <voknqdv3zte2jzue5yxmysdiixxkogvpblvrccp5gu55x5ycca@srrcscly4ch4>
 <st6wob5hden6ypxt2emzokfhl3ezpbuypv2kdtf5zdrdhlyjfw@l2neflb4uupo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <st6wob5hden6ypxt2emzokfhl3ezpbuypv2kdtf5zdrdhlyjfw@l2neflb4uupo>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX0Fvq98qNwYYq
 RuQ3KxRkfOvhaVP0ZSfN3+fZsFhvcZh4O0SIY2OHaS121bii8Juf474FdjW5VLjoZoOKeGNHDeJ
 aGVt3AVydrP+82aBa4DmNtcRD+VA3IJDHz5jLB/u/uC00NUQVV9g9b3XeUbIGhOX8Bt5ppkY6Bo
 PWlfXx1Awr7SLRxowawBCkP7HIg6axQ1LL/wX/5Gn3Bqwq8jfXBXPfPag3ZACraFkY7hihiiZxE
 7YaRgRovhRCcC3r0aAOz/4Vt6c1SQ5YPRVnvfI9oL8veAjsxu1p6Nzj/7/Ey9XzSHRvHX1iWfbJ
 XVPdouJi6jb8127YxXwCTcPz488FxMX36y6V9tCTUm1bWXwg+dqFNtC9DPS/jdg5wPqbqfsoTTI
 xiPTtsT/
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b785e4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Tw3xx-O0H7r42Rls10A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: REhPE5rKblGQ5Zjcy8uKL5mM4EMaJJqp
X-Proofpoint-ORIG-GUID: REhPE5rKblGQ5Zjcy8uKL5mM4EMaJJqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

On Tue, Sep 02, 2025 at 08:06:54PM +0200, Maxime Ripard wrote:
> On Tue, Sep 02, 2025 at 06:45:44AM +0300, Dmitry Baryshkov wrote:
> > On Mon, Sep 01, 2025 at 09:07:02AM +0200, Maxime Ripard wrote:
> > > On Sun, Aug 31, 2025 at 01:29:13AM +0300, Dmitry Baryshkov wrote:
> > > > On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> > > > > Hi Dmitry,
> > > > > 
> > > > > On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > It's not uncommon for the particular device to support only a subset of
> > > > > > HDMI InfoFrames. It's not a big problem for the kernel, since we adopted
> > > > > > a model of ignoring the unsupported Infoframes, but it's a bigger
> > > > > > problem for the userspace: we end up having files in debugfs which do
> > > > > > mot match what is being sent on the wire.
> > > > > >
> > > > > > Sort that out, making sure that all interfaces are consistent.
> > > > > 
> > > > > Thanks for the series, it's a really good cleanup.
> > > > > 
> > > > > I know that dw-hdmi-qp can support _any_ infoframe, by manually
> > > > > packing it into the two GHDMI banks. So the supported set there is
> > > > > 'all of the currently well-known ones, plus any two others, but only
> > > > > two and not more'. I wonder if that has any effect on the interface
> > > > > you were thinking about for userspace?
> > > > 
> > > > I was mostly concerned with the existing debugfs interface (as it is
> > > > also used e.g. for edid-decode, etc).
> > > > 
> > > > It seems "everything + 2 spare" is more or less common (ADV7511, MSM
> > > > HDMI also have those. I don't have at hand the proper datasheet for
> > > > LT9611 (non-UXC one), but I think its InfoFrames are also more or less
> > > > generic).  Maybe we should change debugfs integration to register the
> > > > file when the frame is being enabled and removing it when it gets unset.
> > > 
> > > But, like, for what benefit?
> > > 
> > > It's a debugfs interface for userspace to consume. The current setup
> > > works fine with edid-decode already. Why should we complicate the design
> > > that much and create fun races like "I'm running edid-decode in parallel
> > > to a modeset that would remove the file I just opened, what is the file
> > > now?".
> > 
> > Aren't we trading that with the 'I'm running edid-decode in paralle with
> > to a modeset and the file suddenly becomes empty'?
> 
> In that case, you know what the file is going to be: empty. And you went
> from a racy, straightforward, design to a racy, complicated, design.
> 
> It was my question before, but I still don't really see what benefits it
> would have, and why we need to care about it in the core, when it could
> be dealt with in the drivers just fine on a case by case basis.

Actually it can not: debugfs files are registered from the core, not
from the drivers. That's why I needed all the supported_infoframes
(which later became software_infoframes).

Anyway, I'm fine with having empty files there.

> > > > Then in the long run we can add 'slots' and allocate some of the frames
> > > > to the slots. E.g. ADV7511 would get 'software AVI', 'software SPD',
> > > > 'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can probably be
> > > > salvaged as another generic one)). MSM HDMI would get 'software AVI',
> > > > 'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I don't
> > > > want to use). Then the framework might be able to prioritize whether to
> > > > use generic slots for important data (as DRM HDR, HDMI) or less important
> > > > (SPD).
> > > 
> > > Why is it something for the framework to deal with? If you want to have
> > > extra infoframes in there, just go ahead and create additional debugfs
> > > files in your driver.
> > > 
> > > If you want to have the slot mechanism, check in your atomic_check that
> > > only $NUM_SLOT at most infoframes are set.
> > 
> > The driver can only decide that 'we have VSI, SPD and DRM InfoFrames
> > which is -ETOOMUCH for 2 generic slots'. The framework should be able to
> > decide 'the device has 2 generic slots, we have HDR data, use VSI and
> > DRM InfoFrames and disable SPD for now'.
> 
> I mean... the spec does? The spec says when a particular feature
> requires to send a particular infoframe. If your device cannot support
> to have more than two "features" enabled at the same time, so be it. It
> something that should be checked in that driver atomic_check.

Sounds good to me. Let's have those checks in the drivers until we
actually have seveal drivers performing generic frame allocation.

> Or just don't register the SPD debugfs file, ignore it, put a comment
> there, and we're done too.

It's generic code.

> > But... We are not there yet and I don't have clear usecase (we support
> > HDR neither on ADV7511 nor on MSM HDMI, after carefully reading the
> > guide I realised that ADV7511 has normal audio infoframes). Maybe I
> > should drop all the 'auto' features, simplifying this series and land
> > [1] for LT9611UXC as I wanted origianlly.
> > 
> > [1] https://lore.kernel.org/dri-devel/20250803-lt9611uxc-hdmi-v1-2-cb9ce1793acf@oss.qualcomm.com/
> 
> Looking back at that series, I think it still has value to rely on the
> HDMI infrastructure at the very least for the atomic_check sanitization.
> 
> But since you wouldn't use the generated infoframes, just skip the
> debugfs files registration. You're not lying to userspace anymore, and
> you get the benefits of the HDMI framework.

We create all infoframe files for all HDMI connectors.

-- 
With best wishes
Dmitry


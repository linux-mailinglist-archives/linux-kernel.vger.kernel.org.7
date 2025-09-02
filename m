Return-Path: <linux-kernel+bounces-795495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57548B3F2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215EB7A7830
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7ED28469F;
	Tue,  2 Sep 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ev9pT7Vo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA21AB6F1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784752; cv=none; b=SWA+sd66h2GuxriwI0FwucotrFj/BzXJFY0iXQIZO5z1+jq4/FLphZ3meZOpIxLtv1gMN3QKZk82G5DLJ6Lp4XR40KlkkXtaMWyE2nxzYPJG9tiU65hQ7iToJDD4XdmkFDqMJiaoVm5iD3pqFYbZkVc/0rL6tTy/GnoVL+oXimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784752; c=relaxed/simple;
	bh=TmYw1+7gmutm1vP/37YJB5NOjarMaEoWj+WqM5xv7hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeOLjQ4MgewjrDKhl1uBL+9xXr+Q/oop6ue84TmMjRfKlFf2OZTUlKhBSXRzo+eUwbjk5OCgnRHsRmkJVUDNyCxQsviGnKVJVYxLiYZQcNC6F4k1Dr2uQkz94BSTn//7c9jWnEHYiFaPbceeycTKn7YvL8o4dZiTxlr0duWeo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ev9pT7Vo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822XJOv031628
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 03:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u6pXxYvTpFhxbjh80IOUWJOQ
	14f2Hl+NCOsXpDoJFW0=; b=Ev9pT7Vohd0UOB4LnTx/IZrhMtHulcxpfjHQMKUB
	5u/wMkziB4dzmBnAFLVx58QV1K8TDsrSiJfyBGOBWYiQCEKZkU6OUm0KbPHN4zlW
	ejptTarpiOyuDXmL03ukZbF4K1AfSDOP9b5cojzU7kGGn+BClV04TEWmHQeKybXe
	ds5k7eFix+bNnbuRSHptuH4a12WISUyNCf1IzRCib77WLOF7AjnR/HFg1ZO2y8zh
	HTnj8P/tr1VD6TDZIdCwA7tXAbgNG6NGr+0S9cAzaFa8+4JNa6K3med4PBeaeBLO
	aX+/UhkaHqV3kpC4Zc8Fud+ioRUwYoPqZlpIaooTP8WLUQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw84sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:45:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72108a28f05so5224046d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 20:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756784749; x=1757389549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6pXxYvTpFhxbjh80IOUWJOQ14f2Hl+NCOsXpDoJFW0=;
        b=r8KVHeYszW9tyhvp38EK18XpYS/qdBtsVyk7CFk4iXTgPfLnpyD9wQDLVaO6AUQl3d
         P9xhB0EdreQMT1gcE0WWCpcWD0fo7nCksA/E/cq7GTXUiuqd/4KNQh/AY/E3cehvJ8SW
         BzMvuA5TrTUcE1/22+7W5hXbaZrvySOLMUMYpwxPSKdezo4IU71gRvNBz6KCksT9scyr
         hOWVce0OKq/6960H2PqTlxvlRL7kRVnVoFiiFcyOQDxco0q7LeFLWEXmdv8P0kFBBkFq
         MSXke/5vOaZmR1E3MxKCgzHdnkA+LhOCuZn5Nry9ggbnTfkWOLeXAYnoQ3FiCAJRaEt/
         cn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVltO1McGp70dyjtiG2OblwG+JOGtNjX2VDEKYZnU5ncDoorpzm0JQcp6cvXA5vGqx0Ojm5K5K9aKbV6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRQ1chieq6lVYCHQiY0UogO6qJ1NMxpwSomE+tSQGf+W7zIwr
	5QR1/97fODT0qwpWObH6T4G+Ny7XhgZjJYwXJ/H+61P2XMtUGK4zA/olEOupCFBbPGCFl1J73g2
	+xF8KHPoERxNIVcvTLHpRbRZZLVrSNfXwPdcLrHs9SKpaqCfRgzdbsa9GOvgsB3n7V04=
X-Gm-Gg: ASbGncsr1qnZ7ZGH5CqBF2TtZQxodMCugpGEB4ENKfdosm95yqlpbe8fkOp9NZvyvuU
	3SBxp/0YD5JehoYD+EMwHqOSqZ7EzcV6u9KNJwgH1liiJxLdx1gmEmDb9hO1LUGKS9rKCNRb9Vv
	IHe6ijF/w+bZtQuULmLrybPb8UYcx1vJ8MgvqMhy1fa6dobfXxW8TbDmimvFWWvDgwyiPBuBU+U
	ibPqD9jx2NTFby/wTrgWfms8rMIjsxOP6/db4DC6iEzdnWfauBTOAOb+cF0hmtHflqHGAYAkfwY
	5R0s4jwssjiqlHKGZuZueH7AVPeC1oUWskEZwsynAqWfeL8IAD9KcYH69ZV6YUmNX3Kz/oJuNDN
	u7c5q+z4S0L3s6HKVPp42PuQLvJFq7YZc0+4JXHn9OWSZLwrGXhk4
X-Received: by 2002:a05:6214:414:b0:70d:eb6d:b7f0 with SMTP id 6a1803df08f44-70fac700c86mr114372156d6.10.1756784748531;
        Mon, 01 Sep 2025 20:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW9DgkBw+MvElYTBWkwujyNrejM+p6uDFpj7XgGpJNMn2Ua2wxQ/b8FTcUSXpCO+uXL3IIqQ==
X-Received: by 2002:a05:6214:414:b0:70d:eb6d:b7f0 with SMTP id 6a1803df08f44-70fac700c86mr114371806d6.10.1756784747861;
        Mon, 01 Sep 2025 20:45:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827900absm337975e87.66.2025.09.01.20.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:45:46 -0700 (PDT)
Date: Tue, 2 Sep 2025 06:45:44 +0300
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
Message-ID: <voknqdv3zte2jzue5yxmysdiixxkogvpblvrccp5gu55x5ycca@srrcscly4ch4>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com>
 <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
 <20250901-voracious-classy-hedgehog-ee28ef@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-voracious-classy-hedgehog-ee28ef@houat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX4IC2C8ZUsfce
 0swozCkCKs+TUXAVsgSwzCouHA0jS3nkckwQLv6bE1/NouNtexvbB+w5UKeoFY3/Mkhsf0Nw4y7
 1bfZQg2RL0WAK7Q71CqZMF/KWJAaay73/Z0rjcwQGPQv/CSpOiDKXEW3b41cfmLNKTx2rgObdVt
 aiUR6Xcpr2xh3RAvZiufyzqreLk0IB75XkQ0T1YcF2OEcb/026lQrqBR155sf2Pyye3hosCC4bF
 ZCYNQLUlqlfxOBly21ZuBnkTUoy9bH7+Cojvvv1h489jXvto4TGCHXjx1iqi2TsucrzRAZVwtUd
 2XtHO5tXK+Q5fFkWFHdKKv4A5lod0BSrxcEF/RQpvOFUAZIwVDXHix/9l8lfZbAIKW6lLxpW5LC
 SUOYehMM
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b6686e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pHNJB9hyKJ2XXRMnjhQA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: pp375CYri942RuP_1MxwOX_yOhZO_ks5
X-Proofpoint-ORIG-GUID: pp375CYri942RuP_1MxwOX_yOhZO_ks5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

On Mon, Sep 01, 2025 at 09:07:02AM +0200, Maxime Ripard wrote:
> On Sun, Aug 31, 2025 at 01:29:13AM +0300, Dmitry Baryshkov wrote:
> > On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> > > Hi Dmitry,
> > > 
> > > On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > It's not uncommon for the particular device to support only a subset of
> > > > HDMI InfoFrames. It's not a big problem for the kernel, since we adopted
> > > > a model of ignoring the unsupported Infoframes, but it's a bigger
> > > > problem for the userspace: we end up having files in debugfs which do
> > > > mot match what is being sent on the wire.
> > > >
> > > > Sort that out, making sure that all interfaces are consistent.
> > > 
> > > Thanks for the series, it's a really good cleanup.
> > > 
> > > I know that dw-hdmi-qp can support _any_ infoframe, by manually
> > > packing it into the two GHDMI banks. So the supported set there is
> > > 'all of the currently well-known ones, plus any two others, but only
> > > two and not more'. I wonder if that has any effect on the interface
> > > you were thinking about for userspace?
> > 
> > I was mostly concerned with the existing debugfs interface (as it is
> > also used e.g. for edid-decode, etc).
> > 
> > It seems "everything + 2 spare" is more or less common (ADV7511, MSM
> > HDMI also have those. I don't have at hand the proper datasheet for
> > LT9611 (non-UXC one), but I think its InfoFrames are also more or less
> > generic).  Maybe we should change debugfs integration to register the
> > file when the frame is being enabled and removing it when it gets unset.
> 
> But, like, for what benefit?
> 
> It's a debugfs interface for userspace to consume. The current setup
> works fine with edid-decode already. Why should we complicate the design
> that much and create fun races like "I'm running edid-decode in parallel
> to a modeset that would remove the file I just opened, what is the file
> now?".

Aren't we trading that with the 'I'm running edid-decode in paralle with
to a modeset and the file suddenly becomes empty'?

> > Then in the long run we can add 'slots' and allocate some of the frames
> > to the slots. E.g. ADV7511 would get 'software AVI', 'software SPD',
> > 'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can probably be
> > salvaged as another generic one)). MSM HDMI would get 'software AVI',
> > 'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I don't
> > want to use). Then the framework might be able to prioritize whether to
> > use generic slots for important data (as DRM HDR, HDMI) or less important
> > (SPD).
> 
> Why is it something for the framework to deal with? If you want to have
> extra infoframes in there, just go ahead and create additional debugfs
> files in your driver.
> 
> If you want to have the slot mechanism, check in your atomic_check that
> only $NUM_SLOT at most infoframes are set.

The driver can only decide that 'we have VSI, SPD and DRM InfoFrames
which is -ETOOMUCH for 2 generic slots'. The framework should be able to
decide 'the device has 2 generic slots, we have HDR data, use VSI and
DRM InfoFrames and disable SPD for now'.

But... We are not there yet and I don't have clear usecase (we support
HDR neither on ADV7511 nor on MSM HDMI, after carefully reading the
guide I realised that ADV7511 has normal audio infoframes). Maybe I
should drop all the 'auto' features, simplifying this series and land
[1] for LT9611UXC as I wanted origianlly.

[1] https://lore.kernel.org/dri-devel/20250803-lt9611uxc-hdmi-v1-2-cb9ce1793acf@oss.qualcomm.com/

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-795478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A58B3F29D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07DB203CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BC2DECB4;
	Tue,  2 Sep 2025 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWMSW4mD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B82DECB1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756782810; cv=none; b=YH9Ht38qxMs/emLFz+sc2ksKl9X5zU5Q5N5L1Lq+MUxWgFBttlaAEia8H27mAWRQo8cuNIpHRbZCDsZWc44idmFYedw+u4q5vvfssCxoaKKe4iKi0QPaTVu3myCqxTK2k9akyxzvwKhxN5utb8p057p6c6Ud+W51fA3evy9DP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756782810; c=relaxed/simple;
	bh=F+g5fJsht/C9TSGJLLQ7xyKaR1WfawQvm9s2sMKpxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGgwxyhFDmV6z0W7JEwO5orKbUaiEwHExHrxbgSZxaVxuKHnG2BMVRzlJBc6L21wHFXpc1D3buv631Y783wrUub9BJ6tfH2il9D8nz2dVE8/oh2xC9m91WYrAyUC5paNhZIaOlHO2s1TEhZ9OlNZ89TJMx1I6IzehTL8jPqnq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWMSW4mD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822T6VX032344
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 03:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFT7TaYN9yFmUBnkUS/DV54B
	AuRMajtXQdEYrtXcv6Q=; b=JWMSW4mD3PTluOAloZo2v2G5SpKLxOuXPtreb91I
	HO2B7mjqxjJB6HZTSE/JG8bM86XKEfm1+HRcRAGizJR1zv+x7kKsmGSkJCgDWBQQ
	hZuZfoYQgstxYme1EFXQuvAlb6T5459ib/NfGUUB/xYAxoO2tNqCndbAgmPKxE3d
	1oTL95XM0ElVnBpABJAOBFwYgig4M1fYxaSZKiEpR+lBWRrl8wbh9obSoNA22z1x
	XMM61AB5Lb+y2lYPLcYLOmBHqTufDM659xl+4Le2NcwcroQNpuDsU1XN0SCBNq6n
	l6IauTpkF2si4mrFHIiiGj1Vyh2HUa5m8BQ41a4jq74tZw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8p9k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:13:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72023d1be83so9876366d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 20:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756782807; x=1757387607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFT7TaYN9yFmUBnkUS/DV54BAuRMajtXQdEYrtXcv6Q=;
        b=jYW6ojUbojFMDurxgB3S7idJ4gI2mo+T6RgcefPcbrl9tlCFl2RgA+gGg9UycAWwgv
         Hqg9kc1R0mWtV50T9O4Gd/rNZ7TP/x/+fduMNnrmiMExHCekV5KbpxWeS27qBwninKAr
         n5lAO/vfYz1fDfKUqHCpwEEHXlwOdjKoFoDdsSpq/jhoSP/j8f5ZkTb4k+SRyH3ifTA8
         Q8roC9Bsc7+46oM+BhWTtUDAYxCrwm9XjeGxM8A/hdn1zdydRWXCaGRmKMLqZeXoY/tx
         ngLIybgs4cIDf+1lFb2i1hR9SZUObBUTdSVkwijcudProsmUcPJ8Xnup7MIGpc5Cb4jW
         ob5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPGL4l+Zzt8cCKwfb5hcmL9guQBZrKc4T2aIGdkZP5wTVRpliptLZB9CGcEfWL8D06InWevxO2PDbINpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxDCLV/lLQ0+LsPELuK7nZac1OHtdjyyh59kYVCTVI+ZOsxxI
	8cJYvW/4yw+NttjuIZr7GZTn9Et9BwUZ6MyExx0YOGtJpBuf5+bWTZDwRcRq0xp1e2I9AdaIIZM
	IravJ6N8EH5PlZ9gGMPWXZQfjVyEcJYK0dVAJPfdkHMJkr6cSblmRGqNAMYSZ47mgrzM=
X-Gm-Gg: ASbGncsI3hw2u75gl3ZayvhP47OjfiT+2eh2i3BmqPqSQ/Rgo09TyBgWR8xuKAjgyjD
	S+1KGTXRV+Jn7D2i+2BWsU0MlOc0TyFzWZfzwiGmSAjQj0hpaq/QxPbpWPisuSjDCtn25hhXU9j
	Wefy3QtW0W0JUPEyKAZ0ZZGlNuW7qWgvbFlHgpSxi1Qit56OQZYWAX725QZbK6Q4E5ggrmuUQEF
	QoZDxfDYPAK2yua2aAQpA3uuDxd9+RMuGRR6JFWp4SqweXtfjbyB5GRYZHvTcKpxmBG4NTFbSUd
	qTBYZJThMFAgYSBBJ+MYB32bWWBCH9kCK0zq52k8VVzfwQLyI52ngftPkv7l7vdRtASMc5Y/iSS
	ML27OXSAavmdoP3OcoEeQwVAnU7rie6kvvua3MVhDiYkYxI3r1tB0
X-Received: by 2002:a05:6214:2425:b0:70d:bee7:22a6 with SMTP id 6a1803df08f44-70fac90b081mr99124206d6.57.1756782807493;
        Mon, 01 Sep 2025 20:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx3s/TeSWd/gD8+0Pzv1Eys9blTUBbEzGio/Yd+gCc0H1VU32BQyJUk3uEjCaZ6DP8MJyUzQ==
X-Received: by 2002:a05:6214:2425:b0:70d:bee7:22a6 with SMTP id 6a1803df08f44-70fac90b081mr99123866d6.57.1756782807080;
        Mon, 01 Sep 2025 20:13:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827a53bbsm309669e87.124.2025.09.01.20.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:13:26 -0700 (PDT)
Date: Tue, 2 Sep 2025 06:13:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: Re: [PATCH v3 02/11] drm/bridge: adv7511: declare supported
 infoframes
Message-ID: <4rzkxynpbe7j5uyfiqscjt6l2yr4teothqcga3js7fn6e4tap2@s6npztjtbjbq>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <20250830-drm-limit-infoframes-v3-2-32fcbec4634e@oss.qualcomm.com>
 <20250901-tidy-auburn-tarsier-e7b1e7@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-tidy-auburn-tarsier-e7b1e7@houat>
X-Proofpoint-ORIG-GUID: 4hXBG65ZjLAICNvdIn29Wm-MCL1Zt4KD
X-Proofpoint-GUID: 4hXBG65ZjLAICNvdIn29Wm-MCL1Zt4KD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX5NbZeltdAXqj
 +4rKHit0X/9sPBi4Zq6t5UkXdpXleZClRI5FwD1FU4cFTkF+TgO46D/z6eM+yHeXe8TzGI7R9/F
 cFsZsgcBhCbbigcp7RIcKtl3JWWrrRTd3qk0OpOON9W2vyC5nczmDwVdNeYLG8n55jPQ8UY0TWj
 7rFP8JqWHCzPVMnJ/KFOiWFsm2KHCklbl4ulwBsqlAx6Q3GkJDvsWRbMXpN6I4V+aiyg6lO2WZq
 th+UqABouLFuRWorsL5Kmdqnlr0382pC+sxahs8fbb6JweWjOcI11q7okcgTNgK01sE1/mBWPlQ
 L7Td0pBrs+pYSYitHjtfH7Z7VzKiF2cARmKzPKRulnyGtlMH2nWnL0sBp7uPH8GBoFHcc3VGYRr
 Iv5T6MiJ
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b660d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=u7Ex-Lb6nDjXBYZR8i8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Mon, Sep 01, 2025 at 09:12:45AM +0200, Maxime Ripard wrote:
> On Sat, Aug 30, 2025 at 03:22:58AM +0300, Dmitry Baryshkov wrote:
> > Declare which infoframes are supported via the .hdmi_write_infoframe()
> > interface. Audio infoframe is handled separately.
> > 
> > Reviewed-by: Liu Ying <victor.liu@nxp.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > index 26f8ef4824235a9a85b57a9a3a816fe26a59e45c..fe30567b56b4f600683f0545ed270665e692b12c 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -904,7 +904,7 @@ static int adv7511_bridge_hdmi_clear_infoframe(struct drm_bridge *bridge,
> >  		break;
> >  	default:
> >  		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
> > -		break;
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	return 0;
> > @@ -938,7 +938,7 @@ static int adv7511_bridge_hdmi_write_infoframe(struct drm_bridge *bridge,
> >  		break;
> >  	default:
> >  		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
> > -		break;
> > +		return -EOPNOTSUPP;
> 
> We do need to document that it's what drivers must return though.

Ack


-- 
With best wishes
Dmitry


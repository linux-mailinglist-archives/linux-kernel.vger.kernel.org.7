Return-Path: <linux-kernel+bounces-837219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2030BABB84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9693A33C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912329AB05;
	Tue, 30 Sep 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7Xqqqz2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567361EBA14
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215756; cv=none; b=dD2cfoNlDoyv5G8ICPoetZd8NflctrrStbNd5JCtNFfyolyXdESO+CyzRsgn3NVtjeX3mS35lJKhUQaYkWUEMyZ+tgy5GIbUH9OK0+kdzg1Rw71sXaeylAnuIn7OXP8Etapp8VgI+u5y9YbcEK7hBKjyh8lEGn4bMWSqD0IxZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215756; c=relaxed/simple;
	bh=RdXvBcXf2rWq6Oppr+r2Gc0rOOuQ/AGi5Ct///4d10E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuXUkvkHFwB/6vMaH5ynMTLn8FoWZMF9dZJy3GTT24LF5s8xkGRQIuf8pWJoU8YUpxXcj8cXS0RciPxbQqmxN3VZs90hlNiM87IlgOrq3lCLz9g6biIfVzDj1TZd51AGhb2xUxhdZDPNcFjkElK5FiX1sOTRli2nIcupsz+agqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7Xqqqz2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4I2FD025066
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BwBI3m+DtpPGWJNxcZ6VSGsW
	WmE70r279i000rgGn2k=; b=o7Xqqqz2GLaelM8l2vQshCq8vS/qA1wR01DCw3uP
	j2PZ84IbkXZlrRyd8iXTJqcQBZndcIk42+2Es9iSpH+YdA+qAwrByWPLno/XNpB1
	ttyM4E3jp+zZ8AWWI+B8jWLgrYdbK953e84z47WlyiMjGIjsiONj4OKZ0iMo1VxP
	eg25OSyn55u6/nOvfNRHN9pYEf+Oa1SpXmTYBNkQmnnpT2wc7R2HpjuaFKSyDano
	WH/zLNf4kAB0X+ww7/DzsiXmuZx8pNWFzq66R2zB1eExJDs7izrv5YUxPiFk81+1
	D6re9C++FaZ+qn9q5EfEScHxAK6NDROfoQdFzIm5JEwacA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n0b0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd932741cfso101576071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215752; x=1759820552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwBI3m+DtpPGWJNxcZ6VSGsWWmE70r279i000rgGn2k=;
        b=RdikwBJ7QmGBs3hK2GgN2jJS+s+tglBgXZU9+ZtEiM/etcShqjE+ou04YAtTreBUs6
         zpbIxfgNiundtNiM+FJxmWruDCW7NhGovETlhUbiUv/Uz+2tpXaFai4IVgLCPKYKe8Dk
         x2c8GUPUHozXDBOWwyxND/++PFfN3EiKpe299pb3HaYO2NfLrVqFbHnv6pxcLBhFqCAp
         TbwN7kAGHZINYqP15yFGhN/FVALs09Y9lCysaHIx73JZJ/1naossPP6qg6EsuSMF09g8
         cETptXtJuBcY/IRtQqM0MY1y7nL+NdMs7GfiPnDDVybqSzUSmJXKxaGHw+6pGCNt9j61
         EMbw==
X-Forwarded-Encrypted: i=1; AJvYcCWwQBRBVwXx7/f0ze8HZx0LkRU3C6abHE44/xlJFhn3si/YafbntTZ8VYNyFN2X9InS5aBcv9cDnz7ydXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJaWCgfAvZ5wFzwvigUpiubwChAS42UEv4czQ6NSUzoZOfL36
	XDtldwM5U93wd224W1FdqR/2pl8esbP6yFwCBhjg5k4ZZPeRuK4BalNYvrycLCa9ZsAh+QMTX++
	AN17N6680SPSQt+H1IXvhn1o6Se84SwMpxCT6T4Z0AblZ8mY2buHl6ou6JGGEnJeGsOU=
X-Gm-Gg: ASbGncvqXK8S5b0EfI5d3f0woAoJ+6yZC2h4kqaAl7CIN/uqEF1vbP1MFabDX2uvMuY
	90z9GTMH+M3UaQpZtNmhDIRMrsiG0QDPV3/Gyf14q0Gf5NWUf/Rey3r6i2edNnXzpgNdR+txdjQ
	FRvoFHizzNA7/+/wv5c+UuVXmvnu5p+zvwMLKnJkOdXksFsaiWx36inglYFUdsH6LSgnig0HozO
	I6nDmlcF3IY1REN0DCmX6CGWeU/6v/cWHYkPFdDs+t00ELSlqfBwMZ3XEBWuR+he6iw/XMcM873
	y6EoRkMguZTiMEs4xX3AtRYUM4+8+r13JJBH4h9a0Gijw4KeZ8JJ3q1L7fDW5/WVN9aX6gBvfkj
	uWzlvt4+lugB/Qoica4FgQU6RV1OJH6aNL2orWEOkm0eC1mbBDO9OFe7ULA==
X-Received: by 2002:ac8:5a56:0:b0:4dd:e207:fce with SMTP id d75a77b69052e-4dde21659bdmr170058621cf.70.1759215751893;
        Tue, 30 Sep 2025 00:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb84HLLa9QgF4zWxDQfkP47jlJjmQ47Nd1Kw/rc0PP2nrv91KOwbaW913oaMecip8Zy003Zg==
X-Received: by 2002:ac8:5a56:0:b0:4dd:e207:fce with SMTP id d75a77b69052e-4dde21659bdmr170058171cf.70.1759215751316;
        Tue, 30 Sep 2025 00:02:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-588be5416c7sm900404e87.140.2025.09.30.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:02:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:02:28 +0300
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
Message-ID: <itgffxygopi7etkt7xhvmyuvyl5ad3k43nsxvjzw3ubtwiikn7@ocugfdaigtu7>
References: <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
 <20250901-voracious-classy-hedgehog-ee28ef@houat>
 <voknqdv3zte2jzue5yxmysdiixxkogvpblvrccp5gu55x5ycca@srrcscly4ch4>
 <st6wob5hden6ypxt2emzokfhl3ezpbuypv2kdtf5zdrdhlyjfw@l2neflb4uupo>
 <pe6g2fanw65p67kfy5blbtiytngxmr6nkbazymojs4a66yvpl3@7j4ccnsvc6az>
 <20250910-didactic-honored-chachalaca-f233b2@houat>
 <x562ueky2z5deqqmhl222moyrbylfwi35u4hb34dpl3z52ra4c@dyw4iayrewnz>
 <20250925-fervent-merry-beagle-2baba3@penduick>
 <qx5ashx62pufott6hnsfna3qntnoyvxwxze4rihhuxcsdxi37s@bbdvc3sfsgne>
 <20250929-gregarious-worm-of-memory-c5354d@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-gregarious-worm-of-memory-c5354d@houat>
X-Proofpoint-GUID: wtvn-quXCSLfkh2RYdymFjky8SA80TTB
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68db8088 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2KZmwtpIuq5mfTj36lQA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: wtvn-quXCSLfkh2RYdymFjky8SA80TTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX12s9jHEgBdmq
 vNxB8WpqjpatD3aoYUy+7uN+eE2vcUBmzUVVz2KAqtPaZqOgb/qhmKgrK18pZQufrLV4WUX2iMB
 3fml90KIIi4HurjKrehMxbVmzX5PoE/LjuYzQZ8CtPDh7ZsVNk9t+N1b4w26XSlu/bMIenJb/OR
 ZiYHu24mWcG3tdTFpFNH3sZvd6nFocgRxst6g68i/5MDgM7D/0e1dNtgq5SbgsaP/Kb0JXPYGOl
 6R9qMZPAaM8gZ1X31+Kh/hczKlFzPWuk8tl3GwV92LyesERfhpLsuqZfWo69GdOgQc6mlACwp2D
 bh+NmLnfHfFyearXNa4NkvUgqZU/WV9/nG/aCluFT4o+K2n+nenWOG4Z9ou4jAn3zNHv4Qafc2I
 tyOM4fSa0+e+Bmd3VwDJeMiTsxUNyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On Mon, Sep 29, 2025 at 03:00:04PM +0200, Maxime Ripard wrote:
> On Thu, Sep 25, 2025 at 05:16:07PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 03:13:47PM +0200, Maxime Ripard wrote:
> > > On Wed, Sep 10, 2025 at 06:26:56PM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, Sep 10, 2025 at 09:30:19AM +0200, Maxime Ripard wrote:
> > > > > On Wed, Sep 03, 2025 at 03:03:43AM +0300, Dmitry Baryshkov wrote:
> > > > > > On Tue, Sep 02, 2025 at 08:06:54PM +0200, Maxime Ripard wrote:
> > > > > > > On Tue, Sep 02, 2025 at 06:45:44AM +0300, Dmitry Baryshkov wrote:
> > > > > > > > On Mon, Sep 01, 2025 at 09:07:02AM +0200, Maxime Ripard wrote:
> > > > > > > > > On Sun, Aug 31, 2025 at 01:29:13AM +0300, Dmitry Baryshkov wrote:
> > > > > > > > > > On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > 
> > > > > > > > > > > On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> > > > > > > > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > > > > > > It's not uncommon for the particular device to support only a subset of
> > > > > > > > > > > > HDMI InfoFrames. It's not a big problem for the kernel, since we adopted
> > > > > > > > > > > > a model of ignoring the unsupported Infoframes, but it's a bigger
> > > > > > > > > > > > problem for the userspace: we end up having files in debugfs which do
> > > > > > > > > > > > mot match what is being sent on the wire.
> > > > > > > > > > > >
> > > > > > > > > > > > Sort that out, making sure that all interfaces are consistent.
> > > > > > > > > > > 
> > > > > > > > > > > Thanks for the series, it's a really good cleanup.
> > > > > > > > > > > 
> > > > > > > > > > > I know that dw-hdmi-qp can support _any_ infoframe, by manually
> > > > > > > > > > > packing it into the two GHDMI banks. So the supported set there is
> > > > > > > > > > > 'all of the currently well-known ones, plus any two others, but only
> > > > > > > > > > > two and not more'. I wonder if that has any effect on the interface
> > > > > > > > > > > you were thinking about for userspace?
> > > > > > > > > > 
> > > > > > > > > > I was mostly concerned with the existing debugfs interface (as it is
> > > > > > > > > > also used e.g. for edid-decode, etc).
> > > > > > > > > > 
> > > > > > > > > > It seems "everything + 2 spare" is more or less common (ADV7511, MSM
> > > > > > > > > > HDMI also have those. I don't have at hand the proper datasheet for
> > > > > > > > > > LT9611 (non-UXC one), but I think its InfoFrames are also more or less
> > > > > > > > > > generic).  Maybe we should change debugfs integration to register the
> > > > > > > > > > file when the frame is being enabled and removing it when it gets unset.
> > > > > > > > > 
> > > > > > > > > But, like, for what benefit?
> > > > > > > > > 
> > > > > > > > > It's a debugfs interface for userspace to consume. The current setup
> > > > > > > > > works fine with edid-decode already. Why should we complicate the design
> > > > > > > > > that much and create fun races like "I'm running edid-decode in parallel
> > > > > > > > > to a modeset that would remove the file I just opened, what is the file
> > > > > > > > > now?".
> > > > > > > > 
> > > > > > > > Aren't we trading that with the 'I'm running edid-decode in paralle with
> > > > > > > > to a modeset and the file suddenly becomes empty'?
> > > > > > > 
> > > > > > > In that case, you know what the file is going to be: empty. And you went
> > > > > > > from a racy, straightforward, design to a racy, complicated, design.
> > > > > > > 
> > > > > > > It was my question before, but I still don't really see what benefits it
> > > > > > > would have, and why we need to care about it in the core, when it could
> > > > > > > be dealt with in the drivers just fine on a case by case basis.
> > > > > > 
> > > > > > Actually it can not: debugfs files are registered from the core, not
> > > > > > from the drivers. That's why I needed all the supported_infoframes
> > > > > > (which later became software_infoframes).
> > > > > 
> > > > > That's one thing we can change then.
> > > > > 
> > > > > > Anyway, I'm fine with having empty files there.
> > > > > > 
> > > > > > > > > > Then in the long run we can add 'slots' and allocate some of the frames
> > > > > > > > > > to the slots. E.g. ADV7511 would get 'software AVI', 'software SPD',
> > > > > > > > > > 'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can probably be
> > > > > > > > > > salvaged as another generic one)). MSM HDMI would get 'software AVI',
> > > > > > > > > > 'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I don't
> > > > > > > > > > want to use). Then the framework might be able to prioritize whether to
> > > > > > > > > > use generic slots for important data (as DRM HDR, HDMI) or less important
> > > > > > > > > > (SPD).
> > > > > > > > > 
> > > > > > > > > Why is it something for the framework to deal with? If you want to have
> > > > > > > > > extra infoframes in there, just go ahead and create additional debugfs
> > > > > > > > > files in your driver.
> > > > > > > > > 
> > > > > > > > > If you want to have the slot mechanism, check in your atomic_check that
> > > > > > > > > only $NUM_SLOT at most infoframes are set.
> > > > > > > > 
> > > > > > > > The driver can only decide that 'we have VSI, SPD and DRM InfoFrames
> > > > > > > > which is -ETOOMUCH for 2 generic slots'. The framework should be able to
> > > > > > > > decide 'the device has 2 generic slots, we have HDR data, use VSI and
> > > > > > > > DRM InfoFrames and disable SPD for now'.
> > > > > > > 
> > > > > > > I mean... the spec does? The spec says when a particular feature
> > > > > > > requires to send a particular infoframe. If your device cannot support
> > > > > > > to have more than two "features" enabled at the same time, so be it. It
> > > > > > > something that should be checked in that driver atomic_check.
> > > > > > 
> > > > > > Sounds good to me. Let's have those checks in the drivers until we
> > > > > > actually have seveal drivers performing generic frame allocation.
> > > > > > 
> > > > > > > Or just don't register the SPD debugfs file, ignore it, put a comment
> > > > > > > there, and we're done too.
> > > > > > 
> > > > > > It's generic code.
> > > > > > 
> > > > > > > > But... We are not there yet and I don't have clear usecase (we support
> > > > > > > > HDR neither on ADV7511 nor on MSM HDMI, after carefully reading the
> > > > > > > > guide I realised that ADV7511 has normal audio infoframes). Maybe I
> > > > > > > > should drop all the 'auto' features, simplifying this series and land
> > > > > > > > [1] for LT9611UXC as I wanted origianlly.
> > > > > > > > 
> > > > > > > > [1] https://lore.kernel.org/dri-devel/20250803-lt9611uxc-hdmi-v1-2-cb9ce1793acf@oss.qualcomm.com/
> > > > > > > 
> > > > > > > Looking back at that series, I think it still has value to rely on the
> > > > > > > HDMI infrastructure at the very least for the atomic_check sanitization.
> > > > > > > 
> > > > > > > But since you wouldn't use the generated infoframes, just skip the
> > > > > > > debugfs files registration. You're not lying to userspace anymore, and
> > > > > > > you get the benefits of the HDMI framework.
> > > > > > 
> > > > > > We create all infoframe files for all HDMI connectors.
> > > > > 
> > > > > Then we can provide a debugfs_init helper to register all of them, or
> > > > > only some of them, and let the drivers figure it out.
> > > > > 
> > > > > Worst case scenario, debugfs files will not get created, which is a much
> > > > > better outcome than having to put boilerplate in every driver that will
> > > > > get inconsistent over time.
> > > > 
> > > > debugfs_init() for each infoframe or taking some kind of bitmask?
> > > 
> > > I meant turning hdmi_debugfs_add and create_hdmi_*_infoframe_file into
> > > public helpers. That way, drivers that don't care can use the (renamed)
> > > hdmi_debugfs_add, and drivers with different constraints can register
> > > the relevant infoframes directly.
> > 
> > Doesn't that mean more boilerplate?
> 
> I don't think it would? In the general case, it wouldn't change
> anything, and in special cases, then it's probably going to be different
> from one driver to the next so there's not much we can do.
> 
> > In the end, LT9611UXC is a special case, for which I'm totally fine
> > not to use HDMI helpers at this point: we don't control infoframes
> > (hopefully that can change), we don't care about the TMDS clock, no
> > CEC, etc.
> 
> Not using the helpers sound pretty reasonable here too.
> 
> > For all other usecases I'm fine with having atomic_check() unset all
> > unsupported infoframes and having empty files in debugfs. Then we can
> > evolve over the time, once we see a pattern. We had several drivers
> > which had very limited infoframes support, but I think this now gets
> > sorted over the time.
> 
> I never talked about atomic_check()? You were initially concerned that
> the framework would expose data in debugfs that it's not using. Not
> registering anything in debugfs solves that, but I'm not sure we need to
> special case atomic_check.

Well... I ended up with [1], handling infoframes in the atomic_check()
rather than registering fewer infoframe debugfs files. This way device
state is consistent, we don't have enabled instances, etc. However it
results in repetetive code in atomic_check().

[1] https://lore.kernel.org/dri-devel/20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com/

> Worst case scenario, we're going to generate infoframes the driver will
> ignore.

Yes.

-- 
With best wishes
Dmitry


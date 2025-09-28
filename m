Return-Path: <linux-kernel+bounces-835597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB71BA78A9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D2D189807E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F872BE03E;
	Sun, 28 Sep 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAL+GAJD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CC29B789
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094859; cv=none; b=KWnf3BbTUAphRjn7pjF5NljiHHLFBSXYZsImzfQd1aYJ4R6eydyzTFSWNAiyniAGhsrmcF26GiJAON2dclEKNdUF/T1MTs2efXxU8BudTxLaqJmeC4wkCzc3gSlTwD67CmA1CJv1dV7eC6oTbzbReWgaayjWSgOSR7T11lIU9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094859; c=relaxed/simple;
	bh=N0AVvN8KPymmx0lrwttsQ2iBU//2b80vkkEKAsFBF6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBG+6N5dxN1XQ7Yhi8wQiLr0fnSILNGk4JCYHZgUKOOcwNoeFSj2wEX3vE1BTlzo1RcJWetwecL0fOQoAZuBHcbKO+J/xJFD6eXo1eLnVJIFaBbNPHq8FlvXDuR4cZg8Cp9nOtf2lJQ6uwUaUaPHLBYBSasUSALqIXrbYSVQFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAL+GAJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SKiILT009984
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FaQfFaFOCtgfi/FoFC/UkQ6y
	6ObNoFB/yOWfDU1S1+U=; b=PAL+GAJD0HhMhVMaHNzW3C3EAMAcOjXGffze1CsK
	uDDHw+OwM0yB+ka31d9/zuJbovMY2r0tHatqUjceYV1dTa4hRa0TKDhQM935U1M9
	EVpAHWpK96Y+eJAsUf1Na0pK4BQ/54gx83afKRWs1YyVEKvNUQY+CUMWDIJDyMqg
	/Di/0NHnbJ+RkAxfUWrKAbLm1vdfHc4uLpUz8GYmdWeoUOfvcYoptNtluc3Bqljb
	jOZw4DJSSgvme0o7NkTB7lVChb+UfQtRRMfE3iEj03aAqxw/Y7EikAMN6qyyh0uj
	vSaN6ZASONI0LNJaRT/geCkcMNo8Z8e7vE5PHWRM5YT6/g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977k2ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:27:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de5fe839aeso61429001cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759094855; x=1759699655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaQfFaFOCtgfi/FoFC/UkQ6y6ObNoFB/yOWfDU1S1+U=;
        b=pMpBjXiv6dtWuDiUUCoR8NIx0CxI+/x6gc95Bdh4kBQp9Rz/rLInCEcLNYeSnaJpM0
         Kx8yfSkm24IDa6sCZT+ALS5G+9RIJC6E6DfYfyI2WPWwJDHYmi2rCgQf98RdnkPlaoX1
         guhZhJyM6gLb2B0ix26zbu+8BTy3U2kArM4unB2cwjW61GFA3GdhTzqj+76Sygrg7PS7
         CQibCBJlb6BztsQt5RO3ZicDf+g+fMQvx88+AYxUDSXnb1ulKh/Qe3LxwV8hKfWzpn0L
         6PtdIEqa9Xl+4YAWOHGo0gEbhdAStL+MtmukqfwsIfZimao9IBXkjFH2WzQlhTqRmQ6+
         BqfA==
X-Forwarded-Encrypted: i=1; AJvYcCWXlhozosbnNXzQAnKBFxBQ9zIzAmVraUobLWlMIKIYfaJKTEGI5OeIZhXz9tA1NpG02mNvdnVhRQWzw0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6PyaJGGf9nmyfanKBECCdYlYKeXP3nNxgpD4TYWi5eA7YCTq
	hkv6J8NHZkNXMo+30vrF4YdFq8XuYiibJKHbTsI3Eh39UKVleEEZ5+bk9sH6XVtM3ckCJ/utzwJ
	42La1gxjwRkFnWMhnt9IKB4b2nQNWUvH4JMDJ7MoD6X/Qjxc9Nz3ZYCODUD87Qt2yYdI=
X-Gm-Gg: ASbGnct9+Wan4rpDtc7iIo+nMh/8ptaZPVqPNnaiyHbRRydecSvu1Exm1L6vz0+iBsE
	86Fs44GmQPvaBIptmTAgX15TgkLXmz0gPmXVSISZTDL13SxwyB4uF5g4bWzFfRSD24VyJzk5rBY
	wDwpyjTOQtlEb3eLWloZ0oSOcNeyAe5fOKHYnTl6vrLxFsEOipzHZ8d47Vw8UJ09estyYI1yl2k
	1Rig/mst7xos5Q9Oh5eE7+q6uoeEdA5Yq7G9OKiap9giiPlJDpjoy8LAsFH4Vs35dsmNq5jmi5k
	o3jfmOwVd6YfDbZMsDaPpoTZ4G9+YS5dwKMwGLc2/oa7gyS+7SGoB7GEIDdynrfSyF6pcWwuMyl
	heSeaTp+w9R2RCYzNCC1rg0wKxag77+pCKex+wimi/88gilw/0Ppl
X-Received: by 2002:a05:622a:4c88:b0:4dd:2d5a:4c70 with SMTP id d75a77b69052e-4dd2d5a5249mr113850551cf.45.1759094855318;
        Sun, 28 Sep 2025 14:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVlSpEy9WtWa4TAoo8vOL0fbhKJIDjrX8Rm+aa/grsoe17g1Qr6IL2cUsXyuX3wvLhYBHeqA==
X-Received: by 2002:a05:622a:4c88:b0:4dd:2d5a:4c70 with SMTP id d75a77b69052e-4dd2d5a5249mr113850321cf.45.1759094854866;
        Sun, 28 Sep 2025 14:27:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-587c807ed8bsm359961e87.37.2025.09.28.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:27:33 -0700 (PDT)
Date: Mon, 29 Sep 2025 00:27:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 5/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
Message-ID: <pwk4ylrxyedq33qivpwy4kly3yx25yjkv75ja3prf5ynxosiez@lb53gculvj3x>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-6-kernel@airkyi.com>
 <idyrlzhd5sotg3ylr7vbwmczimglffc75nafxbnhhm3ot2jn4w@ixerm6elfmre>
 <ede70598-c451-4352-ab3e-0e278ce33ad7@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede70598-c451-4352-ab3e-0e278ce33ad7@rock-chips.com>
X-Proofpoint-GUID: j9N3ZFe-ACcdDIZ_c92XbWwu01BDApUE
X-Proofpoint-ORIG-GUID: j9N3ZFe-ACcdDIZ_c92XbWwu01BDApUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXyGJrH8GhscfC
 N7ivTmREoqBTvwOYyGMcJQAq+MfwRfVuPAdSNYjGUNhgPozks73VRwONLlOWOzMPgE25+FeAU/m
 BMr0wp4W8utVQBF2LBbMKTimiTKTmHnFIJdM7pACWK4YqSJC2SF39JcBhrdtFE45Y5pFUdXu3e2
 E8bxF3XsRYKXEiwEMFRJaIddqHk3WpU7x19SOHeMhwfs5LibEJRknmg0d+TkCHJYr5JHIlwkXwj
 XqYNgIadpLtT2oVnMpb3RWAvtAqd0VrlVhHpzGR49PkvQGozOvbM8Q5JLNarjV555Kf4gRR57sR
 ASCL+suVLlhJ5E05+22hbNSzU6XcWFaaMEy2CqKi0t/7BenYQR0o6CpRBlsSzZjH2XUPYCRlo6Q
 XcOyAF7+cQ+I61mNqgX3qtCuCuI0dg==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68d9a848 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=gy9Ct68RWRgD3XKeOnoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_09,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Sun, Sep 28, 2025 at 05:52:35PM +0800, Chaoyi Chen wrote:
> On 9/23/2025 9:50 AM, Dmitry Baryshkov wrote:
> 
> [...]
> 
> 
> > > +	/* One endpoint may correspond to one HPD bridge. */
> > > +	for_each_of_graph_port_endpoint(port, dp_ep) {
> > > +		/* Try to get "port" node of correspond PHY device */
> > > +		struct device_node *phy_ep __free(device_node) =
> > > +			of_graph_get_remote_endpoint(dp_ep);
> > > +		struct device_node *phy_port __free(device_node) =
> > > +			of_get_parent(phy_ep);
> > > +
> > > +		if (!phy_port) {
> > > +			continue;
> > > +		}
> > > +
> > > +		/*
> > > +		 * A PHY port may contain two endpoints: USB connector port or CDN-DP port.
> > > +		 * Try to find the node of USB connector.
> > And then there can be a retimer between PHY and the USB-C connector. Or
> > some signal MUX. Or DP-to-HDMI bridge. Please, don't parse DT for other
> > devices. Instead you can add drm_aux_bridge to your PHY and let DRM core
> > build the bridge chain following OF graph.
> > 
> I think building a bridge chain across multiple drm_aux_hpd_bridge may be difficult. First, drm_dp_hpd_bridge_register() cannot register the bridge immediately; instead, it is deferred until drm_aux_hpd_bridge_probe(). When it is added to the bridge_list, it may not yet be attached, and attempting to attach it at that point is too late.
> 
> But, if I only use drm_aux_bridge on the USB-C connector, and use my own custom bridge on the PHY device and managing the alloc and attach bridge process myself, then things would become much easier.

Well... consider a your board, but add onnn,nb7vpq904m retimer between
the CDP and usb-c connector (it's not an uncommon device nowadays). Or
add fsa4480 analog audio switch. Build all the drivers as modules. You
should not need any changes to your drivers to handle such boards and
such kernel config.

With those devices you can't handle everything inside the DP driver,
since there are two "streams" of probe events: the DRM bridge needs the
"next" bridge (in the direction from the SoC to the connector), but the
USB-C events code needs "previous" mux, switch or retirmer. After some
trial and error we have ended up with having a chain of drm_aux_bridge
devices ending up with the drm_aux_hpd_bridge inside the Type-C port
manager driver. This way the typec_* depetencies are resolved first,
going from the SoC to the Type-C controller driver then the DRM bridge
devices probe backwards, creating the chain, which is finally consumer
by the DP driver inside the SoC.

-- 
With best wishes
Dmitry


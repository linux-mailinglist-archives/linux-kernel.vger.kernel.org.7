Return-Path: <linux-kernel+bounces-756277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B392B1B231
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4793B4EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCE23C505;
	Tue,  5 Aug 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0/F8yS6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4EA41
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390686; cv=none; b=YvjsyFue8qdrxLkCuBW++Kv6Vs4vOwGgjdAZheI6UBGBNCdOJrf74kDdGPQg46lOgn9tOw4UNkSmqxQ2fUCzR1T/5Fyw+ouBy5n4NfQSwteIEW/KcqCNW98jqxBgDgQgP9BEKRQVwRuA6bODd+eZSBgeRhL843HH9bNTfCQw+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390686; c=relaxed/simple;
	bh=vAtp33loiC2OMmromK/yoEFrGTmr8r510VQ51S+OcaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEB4q2XwNmQxKDQXq3iL2O7LU5WAvhG+52oH17cLxyE6WXr4F3ijq9L9e++IPoT0whFTnlKcNgtDCOkS9eB3LRUaSCrkKR1r+U8a7XPdixKQEvZLW6VSfb5pRdma5N4msbr+R/VyjVQNa/0ufcCUdmt2S+9w/oLdd8LJhb6XEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0/F8yS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757C2gP029430
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQj3FZoctR5ZS2xg/dOfzXuT0Dr0fvmcc9XZPTdXy0Y=; b=D0/F8yS6/OcIy9ah
	7YaYrsXNvAazegfh/GMt3/QvEy/j3/9zjhmhDdSZN5eOoxX0//gOc93vmKCwwaio
	tuQrFNy8O1HrQHG+Ye3CNeQqk2LaLBk00aHITaNjZm9dy6BCLlC2vhe614Pgqm/H
	IsBydYHwgenHTj0I2Ffgd36qePbfRXGL34H7NhfPxok74Q5WUhg7qpasftnYSMPG
	dmQJO7tUjBd5FtDTP8CcORgTyjhKfOpWBJWxLmrxA5oNclvJjLAvJCoJPE7U8Md1
	iKB+ndNvnLf99f4CTyG4cDWhe9YRVij8SDgNTVpAkEC/M9eY1nlKQzoUc2CpNKqW
	JMxy1w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pag5vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:44:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707722d08d9so102778666d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390680; x=1754995480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQj3FZoctR5ZS2xg/dOfzXuT0Dr0fvmcc9XZPTdXy0Y=;
        b=lrRNwz6WV56ZqYEmajTCVzO/AlSItBggtmedpMhdgcZz5/y1z1mNPWxMIlolUFa24o
         Ba4WQUfHqXllezlTwgYYYOAIkpIe+ead5LfA/Zmp+sK5JR+a3QGeITrTOu+zxImTs9Mv
         1f5TCWb3IGTuqYN9qq55xiRZU26bhL33NmZMfXzWUcWHeSypHQzR4MS4790JymeHj+S5
         3GY3d6syohXgQjAYYgX4RmUKAoeJQM+PgsouiMpC7r4sym3BE7+UHpl9HMBWqNIviMsa
         Hc5vw1nR+wCyc4iWOZhSFLPDbmGs16oG3Rr+XMaJ0GBVrcxX2WO6QeZ5mm37b99J5ZZG
         d5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUdFp6t1pMJoMCZJnm3zcCOaysk2AVghDbRx42Pu2kpXx4/XwAOrqTA3SDhSwit+HKzHOv455uny9nhY0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDFVxe+VOJc31SjUqWJmxsmatD/ElEjRsfAUxmAs4AEgB+281
	ZOQu9cdhn1GOKJU9znW9Xe1WktQI3EuCbDIW1ikefiPqdkkrUtKtpMa2Aw8V2oAdBdCtFoD2dxC
	Hh8gWGp43D0oInW0wdrVBji4uVTeLKCng9URj4XRjYRwjtosgLYLPDCZroRTh3HSnns0=
X-Gm-Gg: ASbGnctC8amkJflnIIbOv5xihBFx2UDpXbNdlRtIJ0AVzsub81xUmWeHjp2TwLI2Lxd
	stEKwIHkDPXRIHOwCsRwRzIVchNPH0jOZJcVo5teaBgaRpyM/YhouD7C8wXwf2KShx1lhWZz5If
	g3d0HMDQE+j4Ve6q0am+KdygCNrBGPtJrO1DHeUNlJyz/1ErjhdJV2Iq++7uZXINkv7IUWfEwMN
	obiz03O1Xg7eqOizgKsUu8zshx8pdaNIs1firkhAE7g7RQr6bvpsxoVBvW7WMr4oSNSeJf1RpXR
	Fq2Ej6OL8IYaEBsR7ET9ETi+uiR5hnz5sYbAohoN3IIy5oqUy3HEcmCsTV2KxaZheZVf+ZNi7Uy
	SA2Nl0rz7YM3u5fvUIHByIJmZO9zZA+PX4RHot0EzFN+5truIJ/aG
X-Received: by 2002:a05:6214:5001:b0:707:6425:23fc with SMTP id 6a1803df08f44-709362430abmr166448906d6.26.1754390680314;
        Tue, 05 Aug 2025 03:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+lMiAsbHz8RoaMN5eHDsdtapu2Nr4qMF3fZ3qhDMKzwzlcVX/R3oTueoOHY1lwn3LqnbIIg==
X-Received: by 2002:a05:6214:5001:b0:707:6425:23fc with SMTP id 6a1803df08f44-709362430abmr166448516d6.26.1754390679809;
        Tue, 05 Aug 2025 03:44:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332389807eesm19601341fa.88.2025.08.05.03.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:44:38 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:44:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/5] Add Type-C DP support for RK3399 EVB IND board
Message-ID: <6nfmxwtwcvuyo2jaao7fele7jcgcykfpy7czbcbjmjxv7cs5sc@dmbtot73kw63>
References: <20250729090032.97-1-kernel@airkyi.com>
 <3kefqzjewmsyzfvyi33kvlgjd6jphjg3fsnixb3of7yb3xkgs2@hgi6xfkgd653>
 <63ec11cf-7927-431a-995e-a5fc35ef1ba7@rock-chips.com>
 <pk5wecbbpxn7v4bdwtghhdnm76fmrmglelytljwfb4cgvpu2i6@rk5turgyt5xq>
 <0207826d-a987-4464-b306-29bdbfac45bc@rock-chips.com>
 <3e880194-5ac8-4056-929c-ac103bedc737@oss.qualcomm.com>
 <f726862a-bd18-43ee-b307-8daef2451e6b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f726862a-bd18-43ee-b307-8daef2451e6b@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3NiBTYWx0ZWRfXyhS2hGcqEgys
 IMcOWnzTipaDSV6m7oyOFuPZp0JcuNMEYF+VksHZni/mytDIoZ+AjFcl/GTqYdQCRQXL6zZ0w1r
 FYABz+CCKCy4I/zSluiXqWa6dFlAHJMdZlksVhvneD1J9WA0eGXoABmE9mqcd5WomjrY/VF7AQb
 AQm+tms9JkeQED36ns3KD6yVWHe2cJLl4MY+dH+sm2j/ZM9WfpDvN7WsYcP7m5AbpI7E6++CDwi
 Sb5/orxI76qUj/k8sBmN/W+lBEIGq8m6sZ12kI32QOR9gU1RIPmp4wgX3WFfSQO9gVSvwEX+4JN
 bfo6egaB9DwEsDnLrozUWhSoptOLO9vfML/rMCBPiLXHCmHKb6tJ2fFbi5dFQJ1BiVLP+yQc5f0
 w08WdndmSRWjtbYOV60ZyDEQn8RQ24F9se9DlkH4t+Fwn1Fiv+Lox+oom+bdBCHi6BBvOfeI
X-Proofpoint-GUID: F-t9XAe_Xhi6WTk8qRyrhQZrPsaFUUJo
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=6891e099 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=rd-FPC7Uua5lUePm5bYA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: F-t9XAe_Xhi6WTk8qRyrhQZrPsaFUUJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050076

On Tue, Aug 05, 2025 at 02:32:17PM +0800, Chaoyi Chen wrote:
> Hi Dmitry,
> 
> On 8/5/2025 12:26 PM, Dmitry Baryshkov wrote:
> > On 05/08/2025 09:13, Chaoyi Chen wrote:
> > > Hi Dmitry,
> > > 
> > > On 8/2/2025 5:55 PM, Dmitry Baryshkov wrote:
> > > 
> > > [...]
> > > 
> > > 
> > > > > > > BTW, one of the important things to do is to implement extcon-like
> > > > > > > notifications. I found include/drm/bridge/aux-bridge.h , but if the
> > > > > > > aux-bridge is used, the bridge chain would look like this:
> > > > > > > 
> > > > > > > PHY0 aux-bridge ---+
> > > > > > >                      | ----> CDN-DP bridge
> > > > > > > PHY1 aux-bridge ---+
> > > > > > > 
> > > > > > > Oh, CDN-DP bridge has two previous aux-bridge!
> > > > > > > 
> > > > > > > Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
> > > > > > > state between PHY and CDN-DP controller.
> > > > > > Does it actually work? The OOB HPD event will be repoted
> > > > > > for the usb-c
> > > > > > connector's fwnode, but the DP controller isn't
> > > > > > connected to that node
> > > > > > anyhow. If I'm not mistaken, the HPD signal will not
> > > > > > reach DP driver in
> > > > > > this case.
> > > > > Yes.  What you mentioned is the case in
> > > > > drivers/usb/typec/altmodes/displayport.c . I have also added
> > > > > a new OOB event
> > > > > notify in the PHY driver in Patch 3, where the expected
> > > > > fwnode is used in
> > > > > the PHY. So now we have two OOB HPD events, one from
> > > > > altmodes/ displayport.c
> > > > > and the other from PHY. Only the HPD from PHY is eventually
> > > > > passed to the DP
> > > > > driver.
> > > > This way you will loose IRQ_HPD pulse events from the DP. They are used
> > > > by DPRX (aka DP Sink) to signal to DPTX (DP Source) that there was a
> > > > change on the DPRX side and the DPTX should reread link params
> > > > and maybe
> > > > retrain the link.
> > > 
> > > Sorry, I still don't quite understand your point. I think the entire
> > > notification path is as follows:
> > > 
> > > Type-C mux callback -> RK3399 USBDP PHY -> PHY calls
> > > drm_connector_oob_hotplug_event() -> DP driver
> > > 
> > > Are you concerned that the IRQ_HPD event is not being handled
> > > somewhere along the path? Is it that the Type-C mux callback didn't
> > > notify the PHY, or that after the PHY passed the event to the DP
> > > driver via the OOB event, the DP driver didn't handle it?
> > 
> > The IRQ_HPD is an event coming from DPRX, it is delivered as a part of
> > the attention VDM, see DP_STATUS_IRQ_HPD. It's being handled by the
> > altmode displayport.c driver and is then delivered as an OOB hotplug
> > call. However, it's not a mux event, so it is not (and it should not)
> > being broadcasted over the typec_mux devices.
> > 
> > The way we were handling that is by having a chain of drm_aux_bridges
> > for all interim devices, ending up with a drm_dp_hpd_bridge registered
> > by the TCPM. This way when the DPRX triggers the IRQ_HPD event, it is
> > being handled by the displayport.c and then delivered through that
> > bridge to the DP driver.
> 
> I think the issue goes back to the beginning. The key is to reuse the logic
> in displayport.c, and the previous approach of directly setting the fwnode
> has already been rejected. Is it a good idea to register the aux hpd bridge
> in displayport.c? In this way, we don't need to register it with a bunch of
> PD drivers (such as fusb302), which seems like a more generic solution.

displayport.c comes into play only when you actually attach a DP dongle,
which is too late for bringing up the display pipeline. But your point
is valid, it might be worth moving drm_dp_hpd registration to
typec_port_register_altmode().

-- 
With best wishes
Dmitry


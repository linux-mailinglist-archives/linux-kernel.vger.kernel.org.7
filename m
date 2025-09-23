Return-Path: <linux-kernel+bounces-828788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69745B9575C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929603AE5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C71321298;
	Tue, 23 Sep 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJaIgszj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BC221F00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624024; cv=none; b=JCgxdpIawtvIS7+rfN9qCcaNT+ENrCdOGzZDw3Kc4JKXpIniqZbUdwgmkORZdHFV8Ta+AjWYsrU4JSGJeKefqGB78BnJa8jaInbaGqW4f5tnODz8NqBpqXl4IY24LlT2H/L2Z0q0tvlLhtgcuFisoVcLVOVVXmtNc3GCGtdLbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624024; c=relaxed/simple;
	bh=t/MgUmpF2SYvOAf4xnKhHZYLL1MCViUD/YjvypY93/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaxCwUyrB1D1/SYVACke2U7Y7i0YFqbbZe1O7bZb57IR12RIidRub5WpKd3BCk0x5ChkpfOi9awHNZC2Sf1sQehdD2EumtL2j12PmDMqewA35TQ/1TrUKOl42+7usm3KT3Ptfb2AMR98om9IA8TaffD4B0x81WieIG4Retz2vvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJaIgszj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H892015064
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+E5Y3KOKkWK0zDB+1vYk+3d3ywUHgZdkrX5cZAXaATo=; b=oJaIgszjB28M3mxj
	6lhLnO8Fb3VirpbxnUWC/poVarpnetMttnxgUgEfOpVSwqio/SnABSwPKGpJqWWX
	MQ2YOa05Arn30ffr7nkXJxmOCR6vtHDin3UvtdGdoURr9mK+aWPmqwS4BTD5Z+Fm
	iDRKS8FL4CWimV6ILb7P4s6lOM2MsyaCltQZCMKLZs4kq/01AhxVWwQXFOM9OMM3
	udd26br4ESNXszzWnEQyFH9h5udAlwwqVNK1/z+r56yKWVDyiw4mMF86RnphhPT6
	GMKAW/APCiMWAulY62wETDgLBmye7dod8GG0helMCAJ7bhL6pl4IY+Z3+/yVTf81
	Hr1HOA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk43j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:40:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e30eaca8eso51988336d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624020; x=1759228820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+E5Y3KOKkWK0zDB+1vYk+3d3ywUHgZdkrX5cZAXaATo=;
        b=CPL9ydm9ExmMySJzu4bAo6Peex/YJQsKxaFaqb30OGAI74VPJtAXOzz3a1D/GC/QSP
         1MLQ9yBuPCI6S7S9+6G4BXb8GYNCPmYbIzgNiS7YSCCTqMcGK+RLgNR86CcojaBYpTde
         5KIP+hCARRa3OW1/c1jiYUL4Yv4BZ4M84CZXo4nxQn8otQSVI0IGm9QP/sJMUmHzImrd
         m1AUiu4LFINcjSf6bTVl0LVBppSjnGOFzVUwqW5Fj8+COBAuGijFfBbPBx3j5cI9Yb87
         lyMyBc5bVj+fLiRaSgtgJmkEmQTfk+srYlfh9oeMGKaoxc4D0h0OgVk2MaAV3sGL5+lq
         X5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXTOT0cmL7kyETuFgqzPQxwxOgYNyUSw525uZhKuVpctp2uMYPlgEdiXiBRHFda0kORMygBo9TnksUe/D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UlOGo8KIQgYvtzYXdKnyVZ1cUOae0tKg6jZ9fTH9jz15zPJ3
	HA/AtEggnmlF84SyONyI+mA3suBUs3jV2hH5Eb1O4dVBbJ84sFcXU1+V78d7JrTilncpfZ9VVSc
	E+2GObTFTvIHHIBYxw3eU8Dj/zVCCdMGX5shNg7so51YXOG51LvjNyvS/Jf8b5tWNdyQ=
X-Gm-Gg: ASbGncuUAie927H0UeHoPb1xvBAI67uMeMQLL6WP/4YMaHTBQPHYZD8h/coK7T3dikf
	L0TqQ1kj5zbfXHfEV0ISeSjM+EQbg+1B3i0cdAGUaf91ikSXtr75zmODqfQ0pUwxwjwSaOfLRJw
	jEUq6x8u8dQ6ja7J9xEk5s1qv/NK32M7t9F/cHuXuFIM3vqhmgtsan+rDm6MKY3YalDrRJoEwdD
	vVw1an9ChqSO9nJruFt3B+mZTqXein1GYu7rgqSFPZN3IfxhPIE5SaZVqR1IdIzOlIvYgCcqfDA
	y1ZPZMSIsWqfl/sXA2sKNAPf/ntFe12cNWjI+q+FiBE7sp1fBX9DCjbCN38goeZx1vcjyRPBI7K
	/B4Qfo5pnxRKVZRNOdVmrf0GQay1eHD59oegcA2kfX8VNntIOgfKU
X-Received: by 2002:a05:6214:234f:b0:78e:cfeb:c6bd with SMTP id 6a1803df08f44-7e7131d7224mr16310516d6.38.1758624019849;
        Tue, 23 Sep 2025 03:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbi1GejF7wTX1JsXq4j6SdkTsO21UfYp40RBiKDy/IT+hQUKTQSvfe5K4Sj1YB0zHaQceTnw==
X-Received: by 2002:a05:6214:234f:b0:78e:cfeb:c6bd with SMTP id 6a1803df08f44-7e7131d7224mr16310156d6.38.1758624019177;
        Tue, 23 Sep 2025 03:40:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57eafff8430sm1511470e87.73.2025.09.23.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:40:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:40:16 +0300
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
Subject: Re: [PATCH v4 1/7] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <bh73nttewwhom2pqccfnapnfkrys3zljkykgqmh4hsdalqgyzi@gbl5oejxsp3z>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-2-kernel@airkyi.com>
 <mygbqhiom6pkwsadzz2bqf5bth3ogsbd6iku5a7r5swxrakein@fjhz7udnkcks>
 <e9cf0aa8-ed32-4ffb-a755-150742455808@rock-chips.com>
 <sgvrzhbhkzxbuybmws44kyenhfyppm3blijkarypcin4fiscvx@mnajrlmicyxi>
 <18f55fe7-7c68-4982-916d-11752325c667@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18f55fe7-7c68-4982-916d-11752325c667@rock-chips.com>
X-Proofpoint-GUID: nBIWfz0CQZpkhewKr2pZ0Fj1tTih5cYC
X-Proofpoint-ORIG-GUID: nBIWfz0CQZpkhewKr2pZ0Fj1tTih5cYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX37Tt//US+QB4
 +nu5q/beGYHzmu7hwv4pb34XgILb4mDWc6jOaRrPzlF+g4Nu05Rkskl7VkU6b5dLQbco/hmQ5/7
 RpZiYnGglOyQpg2A4oR/w/tw3qN9ss1cprumTiUICmzcRm6oKeYHIbJcA2Y+2QadF4AEH7xoTbu
 2nDJZh/+svs2Gb6R6lfweo0FHpqwOXzgBJy5dui7eWI3KcZ5x4gdtYNPwouxFq4cMQ6NNVijn8O
 tc9X8eNxixTaQEMtIMv/s1LKPpz6YIj2CGT06ZFzrZmMw0Hlfk6GhkHULuNEfTMmAaaVa6jRYyl
 m4/TMuMGv+sb/6TJUSRwGAaY26uJotIfsz8GZyddmvCbQxJWrDgsoFis7Vsdy2+9lpfUF9hGthu
 wYAKODEO
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d27914 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=s8YR1HE3AAAA:8 a=gFtpxDXL42iWtS3BWrUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Tue, Sep 23, 2025 at 05:07:25PM +0800, Chaoyi Chen wrote:
> On 9/23/2025 11:11 AM, Dmitry Baryshkov wrote:
> 
> > On Tue, Sep 23, 2025 at 09:34:39AM +0800, Chaoyi Chen wrote:
> > > On 9/23/2025 9:10 AM, Dmitry Baryshkov wrote:
> > > 
> > > > On Mon, Sep 22, 2025 at 09:20:33AM +0800, Chaoyi Chen wrote:
> > > > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > 
> > > > > Add default DRM AUX HPD bridge device when register DisplayPort
> > > > > altmode. That makes it redundant for each Type-C driver to implement
> > > > > a similar registration process in embedded scenarios.
> > > > > 
> > > > > Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > ---
> > > > >    drivers/usb/typec/altmodes/displayport.c | 27 ++++++++++++++++++++++++
> > > > >    drivers/usb/typec/altmodes/displayport.h |  2 ++
> > > > >    drivers/usb/typec/class.c                |  8 +++++++
> > > > >    include/linux/usb/typec_altmode.h        |  2 ++
> > > > >    4 files changed, 39 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> > > > > index 1dcb77faf85d..e026dc6e5430 100644
> > > > > --- a/drivers/usb/typec/altmodes/displayport.c
> > > > > +++ b/drivers/usb/typec/altmodes/displayport.c
> > > > > @@ -14,6 +14,7 @@
> > > > >    #include <linux/property.h>
> > > > >    #include <linux/usb/pd_vdo.h>
> > > > >    #include <linux/usb/typec_dp.h>
> > > > > +#include <drm/bridge/aux-bridge.h>
> > > > >    #include <drm/drm_connector.h>
> > > > >    #include "displayport.h"
> > > > > @@ -182,6 +183,10 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
> > > > >    				dp->pending_irq_hpd = true;
> > > > >    		}
> > > > >    	} else {
> > > > > +		if (dp->port->hpd_dev)
> > > > > +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> > > > > +						  hpd ? connector_status_connected :
> > > > > +							connector_status_disconnected);
> > > > There should be no need for these calls. Once the HPD bridge is added to
> > > > a correct fwnode, the drm_connector_oob_hotplug_event() calls should
> > > > deliver the signal as expected.
> > > It seems that only drm_bridge_connector can do this. I'm not sure if I remember correctly. I'll give it a try.
> > Other connectors can implement the .oob_hotplug_event call. Calling
> > drm_bridge_hpd_notify() also depends on the connector setting the
> > callbacks via drm_bridge_hpd_enable(), a step which is done by only a
> > few drivers.
> 
> Hmm, let's go over this again. First, drm_connector_oob_hotplug_event() requires a connector fwnode.
> 
> On the Qualcomm platforms, the fwnode corresponds to the USB-C controller device node, so
> 
> drm_connector_oob_hotplug_event(dp->connector_fwnode, ..) can handle them directly.
> 
> But our platform doesn't use the USB-C controller device node as drm connector fwnode :(

This sounds like an issue to be fixed. Alternative option would be make
the AltMode code find your fwnode and report OOB events against it.
But... I reallly think that using connector's fwnode is the cleanest
solution. In the end, your final 'display' connector is the USB-C
connector present on the board. If your display has a USB-C connector,
that will be the socket that gets the cable from the display, etc.

> 
> So I use drm_dp_hpd_bridge_register() and drm_aux_hpd_bridge_notify() here, I think it just create a simple hpd bridge to bridge_list.
> 
> But drm_connector_oob_hotplug_event() use connector_list instead of bridge_list.

The OOB interface was created by x86 people, but we successfully reused
it. I think that addign drm_bridge_hpd_notify() calls just duplicates
the effort unnecessarily.

> 
> 
> 
> > 
> > > 
> > > > >    		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> > > > >    						hpd ? connector_status_connected :
> > > > >    						      connector_status_disconnected);
> > > > > @@ -206,6 +211,9 @@ static int dp_altmode_configured(struct dp_altmode *dp)
> > > > >    	 * configuration is complete to signal HPD.
> > > > >    	 */
> > > > >    	if (dp->pending_hpd) {
> > > > > +		if (dp->port->hpd_dev)
> > > > > +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> > > > > +						  connector_status_connected);
> > > > >    		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> > > > >    						connector_status_connected);
> > > > >    		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
> > > > > @@ -391,6 +399,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
> > > > >    			dp->data.status = 0;
> > > > >    			dp->data.conf = 0;
> > > > >    			if (dp->hpd) {
> > > > > +				if (dp->port->hpd_dev)
> > > > > +					drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> > > > > +								  connector_status_disconnected);
> > > > >    				drm_connector_oob_hotplug_event(dp->connector_fwnode,
> > > > >    								connector_status_disconnected);
> > > > >    				dp->hpd = false;
> > > > > @@ -751,6 +762,18 @@ static const struct attribute_group *displayport_groups[] = {
> > > > >    	NULL,
> > > > >    };
> > > > > +void dp_altmode_hpd_device_register(struct typec_altmode *alt)
> > > > > +{
> > > > > +	if (alt->svid != USB_TYPEC_DP_SID)
> > > > > +		return;
> > > > > +
> > > > > +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> > > > > +						  dev_of_node(alt->dev.parent->parent));
> > > > This needs at least a comment, what is dev.parent->parent. Also, the
> > > > of_node is not correct here. It should be a node of the connector,
> > > > rather than the device itself. Consider USB-C controllers which handle
> > > > several USB-C connectors (e.g. UCSI). The DRM core won't be able to
> > > > identify the correct bridge.
> > > I think  alt.dev->parent->parent is the connector device. Am I missing something?
> > As I wrote, it needs a comment (in the source file). No, it's not a
> > connector device, it's a USB-C controller device. There is no guarantee
> > that there is a separate struct device for the USB-C connector. On
> > Qualcomm platforms, the device will point to the USB-C controller (TCPM
> > or UCSI), which contain usb-c-connector(s) as child node(s) in DT.
> 
> Thanks for the clarification.

I think it should be fine to pass the fwnode of the usb-c connector that
is outside of the USB-C controller device (if that's what your platform
uses). But I think this should be:
- the usb-c-connector node
- it should be coming from the Type-C controller driver, you can't guess
  it here.

> 
> 
> 
> > 
> > > 
> > > 
> > > > > +	if (IS_ERR(alt->hpd_dev))
> > > > > +		alt->hpd_dev = NULL;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dp_altmode_hpd_device_register);
> > > > Having the function here will bring a typec -> displayport dependency
> > > > between drivers (which you didn't document). It means it won't be
> > > > possible to build typec core into the kernel, having the DP AltMode
> > > > driver in the module (which also doesn't sound like a good idea).
> > > It make sense. Perhaps moving it into class.c would be a good idea.
> > > 
> > > 
> > > > > +
> > > > >    int dp_altmode_probe(struct typec_altmode *alt)
> > > > >    {
> > > > >    	const struct typec_altmode *port = typec_altmode_get_partner(alt);
> > > -- 
> > > Best,
> > > Chaoyi
> > > 
> > > 
> > > -- 
> > > linux-phy mailing list
> > > linux-phy@lists.infradead.org
> > > https://lists.infradead.org/mailman/listinfo/linux-phy
> 
> -- 
> Best,
> Chaoyi
> 

-- 
With best wishes
Dmitry


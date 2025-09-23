Return-Path: <linux-kernel+bounces-828039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D0B93CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6555219028EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC781E1DEC;
	Tue, 23 Sep 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQP4aTFz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C71DF72C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589824; cv=none; b=SL8oSp+agw7PfklPS+1CHu1Dkjd6nxdU3zFK/goigaeRUseTznFP7rw2vElgcoawJzXf1nxJzDfTY+L9UzrailTMrCJQYMZD/eNaPFOL76HVgByP5sN81gNLVL85mTVnyYFQ2Qz+HJU3M+hKzHGH2eYlgIEapKCtruGfPtM9v7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589824; c=relaxed/simple;
	bh=501NnXw/vrwTNNKzpgjKhyMk9+1FZM3Scq0hSgAKlMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2P+OCqNZ8YS0H26jc7lG9E+RNMYLP3aLDrGPJoMY1+o+hGSXTP5otjjIxzGYwQY9WDky5E3J7giHWgJjdfTHze4qu/BXHet0LQQTGuFhdx5l4ed4uYhRjV+wdCae3eBuPdhh1ElBjoV08X2y9KVUfd46O8XaqP83oJ6v3JAMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQP4aTFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHZTLB008217
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aC6xtZ2Xq3V/aoM/1E2yl/Rv
	YTGjb8DsxBZkEhoHUs0=; b=kQP4aTFzNQ2UuzbT4ikHpSFm3WaFRyXiNs2GrX1D
	NOWQh3swouH9vJ1fAxVXC6PCPqnticuckinCgv8kquP2cFLdmTNHqGDbpgIh3ic5
	HhdSV0BKnlWkJLFZeGrTyNU2cQym6INqa8JoGWm3XQiSkQd1Fv+CWSb1KePAMs2k
	wGIvF9VgWOBP9v+kIAh4IRCzFD1nQtI8BHSCyjVKIOz8cr1W+zSd/EEDTKsqq248
	YjLoM6Pq0PFnCL7+VWkYLy7Cy/zDlG7J3Z2vOWAuA+pfn3YrzhzFUnQ9mU9MG101
	Hb90tz017gvT47+qynKe99HkOwpeaZHUOOOyb39SLXiPMw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bb07h208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:10:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e831e5a42so125212576d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589821; x=1759194621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC6xtZ2Xq3V/aoM/1E2yl/RvYTGjb8DsxBZkEhoHUs0=;
        b=iyM7s7nwkTwamBmqx0A08+8L83hNsaUoNfpgHor/uMRsPEQlskcPvY/5KBaVBNuRZB
         Q3lk0XS/lmaY0NyYrSNAngUMiTTDyCk7T8KEuoSpj23/5lUYxVC/+jMJvvFZHCXOWaAx
         2NAqDbN9aGXGnavAhp5wNoYTZd8+Nj6TzJyrjoh16jCugiCQ18FdsNXxjjLBbouyhiTS
         Y8fgKTFBFEdLEAqkrFLTKDifDrYdF4OuviyHPqc/Q/T0Zgd6TuQRh1nHhTWlgRAGAOxv
         /ed6/evYJwu8QO7/PheVOPxa0QxXae/JGi8uGUrKKFFf/iLWLYo+AHVcd+axczhV5fcT
         T+xA==
X-Forwarded-Encrypted: i=1; AJvYcCXBWe5pv0+1a68Xtiryfl0b4xszo7EGZf5VZqmOG+NgjKMV7a3/LE6osXcgV9QXqSsPCmFLSvfVm49ngd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlJkQ+STveHSN0vFzydJyVY4e7Y5VmCOuVbgDAe9WHoLT4OLP
	G8QqSTg5apyUzhAvqy8BWuIyaEnBv1d4vDNZYop9yX26kp01nElg2cvoqLZ/jtGZfa8waLfubLi
	EE1Cizg5nWjJ7DzJTooHlCukiE87MF7oe5bHD2CSxj9EhINIX7PtBSQrpA2gTCCL4pQQ=
X-Gm-Gg: ASbGncvEzkKgdlFGFyzRioxwCOFcXFH7iNOXlh4nZ0fqe/kZEIJM34UBS2Gp4fks3UO
	8Z0ardFibGZX277v7Z6jq2hddbI69SdCM5sZRdGxdpI4oVF1xm9U/dowXN29V9cUcNFXmDIWava
	r3nAhJxEcxQl5Ux0FH97XAfF3gAiT5J7ys+/sQNm6HDkHMmYQ4oSvC18LFiRr5rXfnbc7Xmd4KM
	zXkvEHB05qUpWzzNaQjkyCz1NswqRodo9NiK+0GxnnbxcxUDIK38o35bVly+amE8y71OwC4DakT
	xrwg0gCtTSXcLuFi1xHU3jWWKYlW2uLzJDA6GCH5sFPTbrgds8iQOsRg/VfJQnOQVTHLfvnmevy
	e6jgv7K0B744JdQgnjkIG/bpwXzX0E6IHYzAbhjTsrXaLhGsHnk4F
X-Received: by 2002:a05:6214:21cd:b0:75f:6116:83e with SMTP id 6a1803df08f44-7e712ef9c76mr10311786d6.37.1758589820507;
        Mon, 22 Sep 2025 18:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/AqhiaebrPXH+fi3RCpVWDIqMTUfClYaLPwNMtBGbndVg1ntx4aReI8HayNz/8sSGkQvDNw==
X-Received: by 2002:a05:6214:21cd:b0:75f:6116:83e with SMTP id 6a1803df08f44-7e712ef9c76mr10311466d6.37.1758589819848;
        Mon, 22 Sep 2025 18:10:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-579e716407dsm3036752e87.97.2025.09.22.18.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:10:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:10:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/7] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <mygbqhiom6pkwsadzz2bqf5bth3ogsbd6iku5a7r5swxrakein@fjhz7udnkcks>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-2-kernel@airkyi.com>
X-Authority-Analysis: v=2.4 cv=HJnDFptv c=1 sm=1 tr=0 ts=68d1f37e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=BpK9xR3a_xoX_XwHwW8A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: zeDOTW7sCItCxHV0Y8JRi7sXbDdtM_4Y
X-Proofpoint-GUID: zeDOTW7sCItCxHV0Y8JRi7sXbDdtM_4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE3MiBTYWx0ZWRfX1DhWaspmV8WB
 38rhm9edruAisRa61mmi3jIlhjPG2czM3KgjnZrL1CSGKo2l3Zj3Sr3jPGwPaSmGqqbDPY9DI1h
 jsJYVFanQRXdOTACGUKCA8unVWTcPxPywYGWJqd+ZzxTgDrx76Szw2gACpF4kIlHasJzrhhZsdY
 ZRC2sNBCKiiLO+tZKQp+n0TRdHm97985f6onPux807GVckHedxFzLVndlns+jTiznuj5fhPml0k
 2i9do5JgQUCa2XmNsHpLa8cJmdtYE5SByloNKtoqR34+HkyEKdz1+ye5R15+3j+JheydBsJL/x4
 KhXS3UoBTC8Qr3BpOrm913Nt8fU3MNjSqIEuLU1Ucv8AM5eg1EQZnavCGesPjhCPW1wPYfp8JQe
 Fvyp9mPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220172

On Mon, Sep 22, 2025 at 09:20:33AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Add default DRM AUX HPD bridge device when register DisplayPort
> altmode. That makes it redundant for each Type-C driver to implement
> a similar registration process in embedded scenarios.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 27 ++++++++++++++++++++++++
>  drivers/usb/typec/altmodes/displayport.h |  2 ++
>  drivers/usb/typec/class.c                |  8 +++++++
>  include/linux/usb/typec_altmode.h        |  2 ++
>  4 files changed, 39 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 1dcb77faf85d..e026dc6e5430 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -14,6 +14,7 @@
>  #include <linux/property.h>
>  #include <linux/usb/pd_vdo.h>
>  #include <linux/usb/typec_dp.h>
> +#include <drm/bridge/aux-bridge.h>
>  #include <drm/drm_connector.h>
>  #include "displayport.h"
>  
> @@ -182,6 +183,10 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  				dp->pending_irq_hpd = true;
>  		}
>  	} else {
> +		if (dp->port->hpd_dev)
> +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> +						  hpd ? connector_status_connected :
> +							connector_status_disconnected);

There should be no need for these calls. Once the HPD bridge is added to
a correct fwnode, the drm_connector_oob_hotplug_event() calls should
deliver the signal as expected.

>  		drm_connector_oob_hotplug_event(dp->connector_fwnode,
>  						hpd ? connector_status_connected :
>  						      connector_status_disconnected);
> @@ -206,6 +211,9 @@ static int dp_altmode_configured(struct dp_altmode *dp)
>  	 * configuration is complete to signal HPD.
>  	 */
>  	if (dp->pending_hpd) {
> +		if (dp->port->hpd_dev)
> +			drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> +						  connector_status_connected);
>  		drm_connector_oob_hotplug_event(dp->connector_fwnode,
>  						connector_status_connected);
>  		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
> @@ -391,6 +399,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  			dp->data.status = 0;
>  			dp->data.conf = 0;
>  			if (dp->hpd) {
> +				if (dp->port->hpd_dev)
> +					drm_aux_hpd_bridge_notify(dp->port->hpd_dev,
> +								  connector_status_disconnected);
>  				drm_connector_oob_hotplug_event(dp->connector_fwnode,
>  								connector_status_disconnected);
>  				dp->hpd = false;
> @@ -751,6 +762,18 @@ static const struct attribute_group *displayport_groups[] = {
>  	NULL,
>  };
>  
> +void dp_altmode_hpd_device_register(struct typec_altmode *alt)
> +{
> +	if (alt->svid != USB_TYPEC_DP_SID)
> +		return;
> +
> +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +						  dev_of_node(alt->dev.parent->parent));

This needs at least a comment, what is dev.parent->parent. Also, the
of_node is not correct here. It should be a node of the connector,
rather than the device itself. Consider USB-C controllers which handle
several USB-C connectors (e.g. UCSI). The DRM core won't be able to
identify the correct bridge.

> +	if (IS_ERR(alt->hpd_dev))
> +		alt->hpd_dev = NULL;
> +}
> +EXPORT_SYMBOL_GPL(dp_altmode_hpd_device_register);

Having the function here will bring a typec -> displayport dependency
between drivers (which you didn't document). It means it won't be
possible to build typec core into the kernel, having the DP AltMode
driver in the module (which also doesn't sound like a good idea).

> +
>  int dp_altmode_probe(struct typec_altmode *alt)
>  {
>  	const struct typec_altmode *port = typec_altmode_get_partner(alt);

-- 
With best wishes
Dmitry


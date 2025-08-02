Return-Path: <linux-kernel+bounces-754082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39284B18DD5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838C3B1268
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E81F1501;
	Sat,  2 Aug 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RrMHPVM7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745A78F4F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754128574; cv=none; b=AZcMG6yuiBO8jtfzs18cJL0mCG2Op45LmnPW0I6S+B8KUxbWW3oY2Dpc7jAaN8FPsbQiZKL1u2DXFNU03ZxOPMHHIx2kAFjP8/k4sN5SkaQBxvxRrBfnYnvw27Wa1dnshZ4VuqP3aKaohMSBGG0CAVh8q4uCwDCjOBmAeyzL0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754128574; c=relaxed/simple;
	bh=N0SIkcP66VmcVz6IFeyp7iT8A9fp2alWL0zKrrjmcqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwseMdtwJbt8CQ6SfqeW8ec/3lpg6A1W9X/ZKmKPmEjcVgO8bpwNMR3k3Mn4IyWJCBSZ9pWpZJETBqYpps5qcCSpeyi3JupsEZnEibEJE4NrX2HM4ETB1a3IbHnDXmGvulCGzBKgGuELYIg57UlauuczfL7x8wu42dy8xSc0INY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RrMHPVM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725fRhu005253
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 09:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Asqzu24OO8UYIDi9bC459VXzWsN/7IVQ4DWi2UawXoM=; b=RrMHPVM73DxKGGJg
	qqsIWm2Q/ZTftd8Fup41iicv4JvJklA/4eAeX7aUHbhLxKYR8ZmnvoSWb1utRHaa
	gj8mIJXbltj2Qkz7gEnelSrogPSjtGN6M+uXFhKRM1oaxxxKMCLYCnaVAL01LFhk
	YgK4QaldVVykklAyWbWn+2u9imuUvi4/ZooQeCHIbN/1AdnkMgXEX2bWgu0ts4Q1
	hf+mEcYNDhM5BWjVCLDRFiYxVCuxJGMOrpkU2GAums6U8H0OFxriXG5/2W9oTjuI
	x5OlK/Tf2KXh4u/eXDYp6X8OF/fCQrLcvyI0JZuQxznMb3WYdTAUTACFlOcannvI
	HQ79zg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqgfn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 09:56:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-707453b0307so41621006d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 02:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754128564; x=1754733364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Asqzu24OO8UYIDi9bC459VXzWsN/7IVQ4DWi2UawXoM=;
        b=L37tLLRSft7eZTCvf6OOoe4xVcBTW7dkF6YqezkfBM5hLmzxHtT3ZZs+qhqDyKhCqE
         RaZ4w+AcYnbfkF9jLcW6hwkfLcdvECrk1ThBbU4P1pAaKZ8J/l82P7fIEsmMvAmSXpNi
         MkVkAgwTchNx4SRcvPnn+7+XLVSI0nyCfS/9ZE5mgv8+KrA9pkjvlCU1Q/eT52OeWQkw
         7ztz8MI8EL5i4MlOvqDGdUSm3+xugquxbjtjalrqWmFOUelHRV3WexozV7MA/21bWoMj
         pU8DMkqnsJh9Y+g9Po4E88l++zXz4fcNLWMxuad5uFj2jx1aFYrwZ5zXBsVDNGGI4Eb+
         VCtg==
X-Forwarded-Encrypted: i=1; AJvYcCX7SZ3ra2ZZPpe8ULPJ/mPLiA4pH3Ll/8Xou700LWfmc654jbRZ1we8dpeXlylnbGGzXmGixKQNZrTftxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywznud7Wt3uXLTXBFzSP7EOee9MzLec5/aOMUCevpQC8eDJ7NNh
	GyBm0fsBFXk6o0aZKh209hSb9hxYW03QTrxhelId88G4OQNAPig6m6kfApWiMdm4eL4PgFC/N9I
	hD5S1Sj7XGgVvv5XOsw62hayyMYu3Cy2dUlTEOUtJENe5Z2E31a+j6BUtb9wpvbw0srY=
X-Gm-Gg: ASbGncsTx15G+cR98CMw33b04B5WnAO9yTTrmk6yrJr130qVtMRD4CR5T3/ATb0FMaQ
	BvOyoMITvitBx3Ws2wxyLjczDf+zF7xPADxs25MGPSg9UumtJodpFImVmc9PjWTOm1ElpsmRCQy
	5RHPUxNSJUZXF/qjtB04PwgaXkpqL2KGdwWnxKYYlMcmhAqNVkabOisA6U40Rq6izNP8KxRneHl
	tqWGoGVPgR++IqfRjjL8ISqJSa1gMssrf+kKFJeaiwP+tBXaecsn34ww0ENyzINb2pb0SGuzwKj
	6YG18JfzoI2haJW8FmdVf1bWnPXfF5CGXbWY9L6ivrHG9iSk0JN0dhRk1TK7WYuJL45jU2ixs5O
	hxKF4D6qAi5GpqY2oT4elWnD0VE3u2DYdE54+ZyHSZ8I9gMtFrquE
X-Received: by 2002:a05:6214:400b:b0:705:8d7:a0c3 with SMTP id 6a1803df08f44-7093630075cmr37002466d6.34.1754128564360;
        Sat, 02 Aug 2025 02:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOTdM2Iczyvgl46yWDi8GTyzV7HP8tA/9iXZHl881FgxKm6LV0IC4YJNQAmmZo1HrO7zCu2w==
X-Received: by 2002:a05:6214:400b:b0:705:8d7:a0c3 with SMTP id 6a1803df08f44-7093630075cmr37002056d6.34.1754128563864;
        Sat, 02 Aug 2025 02:56:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388d8ca4sm10105271fa.45.2025.08.02.02.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:56:01 -0700 (PDT)
Date: Sat, 2 Aug 2025 12:55:59 +0300
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
Message-ID: <pk5wecbbpxn7v4bdwtghhdnm76fmrmglelytljwfb4cgvpu2i6@rk5turgyt5xq>
References: <20250729090032.97-1-kernel@airkyi.com>
 <3kefqzjewmsyzfvyi33kvlgjd6jphjg3fsnixb3of7yb3xkgs2@hgi6xfkgd653>
 <63ec11cf-7927-431a-995e-a5fc35ef1ba7@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63ec11cf-7927-431a-995e-a5fc35ef1ba7@rock-chips.com>
X-Proofpoint-GUID: _ji4i8cptIYdEA3bzXdSH1ef29MTVSd_
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=688de0b5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=s8YR1HE3AAAA:8 a=GTOoGQlhK9DRF86BnBwA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA4MiBTYWx0ZWRfX2Q2xi4E5FnLv
 JuBLx9jzni46MNHgAdZGzR67WXwn+kaf5hHhryYvwE6dlV+UgrQX4/JpOnVp3juYKGl6hHFJlTD
 Hrb21qGDiMWGSaWVRid4KgEIN7Sv8kx6xPDdFBa/t4GSJQqF5p5Rxq2o/bLUI7nM6Dp/MthyMwB
 l1JdMO77CMkQlUHCaNf7f+nIBRAAZjkHqDyI7YaJ/j0bjlZtKTmNQuarqB81mVR6jHi97ySqGn0
 6XhazIq6UTNztlAlONQZpL/AXKyjw4gYwdWUWqvMGeEbott/s1CbMojlgxXR7x2FzVuccCKXX28
 IfeliYIPz3X4KhW9Z0wmFphupBeifVxPKNXANfIiuDx1ODPOeq0mG88jCh1DPk5KqQ545Mo0Rxq
 3HgkZFx0TEOl70wcOJ5x/MwyftN/1QcLLp/6WgWhqGNV57j6avQ38VA7AxRjZmOsKJms5YyZ
X-Proofpoint-ORIG-GUID: _ji4i8cptIYdEA3bzXdSH1ef29MTVSd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020082

On Thu, Jul 31, 2025 at 10:19:49AM +0800, Chaoyi Chen wrote:
> Hi Dmitry,
> 
> On 7/31/2025 3:13 AM, Dmitry Baryshkov wrote:
> > On Tue, Jul 29, 2025 at 05:00:27PM +0800, Chaoyi Chen wrote:
> > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > 
> > > This series focuses on adding Type-C DP support for USBDP PHY and DP
> > > driver. The USBDP PHY and DP will perceive the changes in cable status
> > > based on the USB PD and Type-C state machines provided by TCPM. Before
> > > this, the USBDP PHY and DP controller of RK3399 sensed cable state
> > > changes through extcon, and devices such as the RK3399 Gru-Chromebook
> > > rely on them. This series should not break them.
> > > 
> > [....]
> > 
> > > ====
> > > 2. DP HPD event notify
> > > 
> > > The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
> > > the CDN-DP can be switched to output to one of the PHYs.
> > > 
> > > USB/DP PHY0 ---+
> > >                 | <----> CDN-DP controller
> > > USB/DP PHY1 ---+
> > Could you please clarify this, can you switch DP stream between two
> > USB-C outputs? What happens if user plugs in DP dongles in both USB-C
> > ports?
> 
> Currently, the software simply selects the first available port. So if user
> plugs in DP dongles in both USB-C ports, the DP driver will select the first
> port. This process is implemented in cdn_dp_connected_port() .
> 

I think Stephen Boyd has been looking on similar issues for Chromebooks,
which were sharing DP controller between several USB-C ports. I don't
remember what was his last status. I think there it was easier since the
bifurcation point was the EC.

I think, CDN-DP needs to register up to two encoders and up to two
connectors, having a separate drm_bridge chain for each of the DP
signals paths (in the end, you can not guarantee that both branches will
have the same simple CDN-DP -> PHY -> USB-C configuration: there can be
different retimers, etc).

Both encoders should list the same CRTC in possible_crtcs, etc. Of
course, it should not be possible to enable both of them.

This way if the user plugs in two DP dongles, it would be possible to
select, which output actually gets a signal.

> 
> 
> > 
> > > BTW, one of the important things to do is to implement extcon-like
> > > notifications. I found include/drm/bridge/aux-bridge.h , but if the
> > > aux-bridge is used, the bridge chain would look like this:
> > > 
> > > PHY0 aux-bridge ---+
> > >                     | ----> CDN-DP bridge
> > > PHY1 aux-bridge ---+
> > > 
> > > Oh, CDN-DP bridge has two previous aux-bridge!
> > > 
> > > Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
> > > state between PHY and CDN-DP controller.
> > Does it actually work? The OOB HPD event will be repoted for the usb-c
> > connector's fwnode, but the DP controller isn't connected to that node
> > anyhow. If I'm not mistaken, the HPD signal will not reach DP driver in
> > this case.
> 
> Yes.  What you mentioned is the case in
> drivers/usb/typec/altmodes/displayport.c . I have also added a new OOB event
> notify in the PHY driver in Patch 3, where the expected fwnode is used in
> the PHY. So now we have two OOB HPD events, one from altmodes/displayport.c
> and the other from PHY. Only the HPD from PHY is eventually passed to the DP
> driver.

This way you will loose IRQ_HPD pulse events from the DP. They are used
by DPRX (aka DP Sink) to signal to DPTX (DP Source) that there was a
change on the DPRX side and the DPTX should reread link params and maybe
retrain the link.

> > > Patch1 add new Type-C mode switch for RK3399 USBDP phy binding.
> > > Patch2 add typec_mux and typec_switch for RK3399 USBDP PHY.
> > > Patch3 drops CDN-DP's extcon dependency when Type-C is present.
> > > Patch4 add missing dp_out port for RK3399 CDN-DP.
> > > Patch5 add Type-C DP support for RK3399 EVB IND board.
> > > 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry


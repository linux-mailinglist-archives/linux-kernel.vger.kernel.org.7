Return-Path: <linux-kernel+bounces-779659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99495B2F6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DD53A5771
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CC30F7E0;
	Thu, 21 Aug 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqrlXWmQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB3054DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776331; cv=none; b=W0ageZ5IWWaNUr3NtDMRjBScQqvoFbMxcTyS2MRoMVNQCOhz8LKhQAIefnTYOpHNfFgLvFYcT5BEf/cjBJB+OsqaNGlb/p8XvbwGMg14/wRNRnUnXQrMB+qkGPl4067WLk6L6VLm07yqJCkcUYz3DVCAukBEUcgk4kxdXhyL4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776331; c=relaxed/simple;
	bh=dU2W0mNrQrikeb2TaVbnVDgyIAnwEkdEfXBGy1AfvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzmiUhCvJP4z8ODz1Bq8CXdqS6nZdqHnWKw/f1I73NpWM2zsgocR+Ne1DKqSBSLkg3BHZtOAVrVJCFk9p8rClXXbxEyAnYUP5ihhNozyceoT8Bfv5RCaeEcsQHlVhN14p64HI+bQzE9zaid3fdUEf9NN0UXxbp+rlBZOx4H5O14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dqrlXWmQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCOA031427
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LhV/iyN2vz9S9UCj9WMIpEylKKJUmXDVwEl9OAB6pww=; b=dqrlXWmQ8VKGmkcO
	2vxgHTn0ll1pFE0aAhwHIFBENQbveoi5QTe1SgWJerKyiN0z4MSPK1vzdIIHvjdY
	I8ssoyFjHckrRL23u0k2xlDWHs/woBz+XwN0EhBQSr943yjj7A5pVeuqpFioVV+p
	jCeAGkSpZcPAFm/ztGO/Va2p/ifUNYEcCIjbb6QwMusXwheHeaOGJbml4gUfcY4d
	jHECSXhkYclqATbmSzXb2c10voHXORQLjCPFYXPobvlnv9I3wwhswLOY/Ub2tEIS
	iT0fD6cB9lqdoEOokbZzgg53uE0pTKobqcrKo9brBQllMp4j5ox/lFLmCXcFvW0P
	5Oqflw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52aw4xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:38:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88dbf013so21065276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776327; x=1756381127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhV/iyN2vz9S9UCj9WMIpEylKKJUmXDVwEl9OAB6pww=;
        b=YdXcDlN5VLOKvgI1Uukv8qLY11ex+zANWDXnreCgj13K8n7FCy8oK9SGUbA/Em5blz
         Pb1m36XAd+IgjxIc1xcvmRd5sn+oWKXV3KZcRTa/L7lDu5gMOqJ0oTkqwt6KBQsf5Cnu
         lsfazCgWB+kiwY62ZydYNsTgcx4PPj1Vn6G80yfRIfF5s8mETxMKxueLXKMY3IezOqrk
         Lhp3DO1RSPdsacII1CVSCOa20qu7M7WaFQjWwUfmADrtYzH67Aa08llY1nbSKuLTZ1WI
         AQTmQqEjVzkrx3qEGYwsWZjLChBKZBdOCjUpejFBDvpePQtc2S3p3yVFRJ9qMby8McHU
         MDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYfeOQpuGb5EZaBihaDAhDWf6LKcZaEfmt6qoPJUkCm6mpWWvu1rchlkgXSW6pRVETXlialK1SNNwP9Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaBDBS3OaVMWQC4VeZpT49mSHmtM/JwUYkJ84B2vWFezkLDaH
	saGeSe6GEDkye9hIG9wrQTOKwO+eSdqDGHseo1yxJVdvh+BSu4S6Exk/jDxc6AzcXdJaW+uijOB
	0I8g9XfTn7w0+afP5kAtr1PCg23P5D+0BwW9oIkp0H1xyMvW52hXa8HJLiw3fdsUG8E0=
X-Gm-Gg: ASbGncu4ZPQcUaLvYsadiLblUpwkGgHZDzhLbTJz5JmPeYE2oBDZeQ9TfxNI0hob009
	27l+N8eRPn+qH2xEC2srWqb3S91dQkogdzFwzXYobDgb0cPBNG6X/ubkeO+EpJopGqwIzLx3aKb
	NeKWA2JqumLtKgHIV6hGBuvJGWlk/4XhPrhVmHsAUaFH+tanYP/P80geNjr9y9maVPsjExQWlci
	tnP3aclyM30ZhH63akMcFiZONfhv7VWusxdOuf8adq9z22W7Dh+/NMViZuqE7BJbCjMaya52rx/
	10hfPYZT043WhByGfqYKlK88kpNKex8Uu1ySHkZJA53OL6G+mzFGTTORZK+mZ707yu1jV2Nb9Vr
	Chx9adwnqqL13HZCk4KRUdcM57tiwQXiUqa6BLLy6KLNFAYcCXCTi
X-Received: by 2002:ad4:5b83:0:b0:709:deb2:3dc8 with SMTP id 6a1803df08f44-70d88e96aa9mr17675816d6.17.1755776327015;
        Thu, 21 Aug 2025 04:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7jwjG1JMdr3j/LqweySCRNMMJR62FsucFpS7iLp2vys3QoG1tjFvDqJFIxcnvDKur/3ihlg==
X-Received: by 2002:ad4:5b83:0:b0:709:deb2:3dc8 with SMTP id 6a1803df08f44-70d88e96aa9mr17675436d6.17.1755776326298;
        Thu, 21 Aug 2025 04:38:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369d92sm3098411e87.64.2025.08.21.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:38:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:38:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Drew Fustini <fustini@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michal Wilczynski <m.wilczynski@samsung.com>,
        Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 5/8] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
Message-ID: <hkz5zdhy7i6tmmpntvqydck6fnpegpbletfwj6h7mtppkw3qub@bzfvf2vfcudj>
References: <20250814164048.2336043-1-uwu@icenowy.me>
 <20250814164048.2336043-6-uwu@icenowy.me>
 <sp2pdifimqych5zn3mt7pnba3vl25qflgiys76s7dwmyt3jd72@bmwkc7s6p6c4>
 <63b2ac72fe1d15d214e880f223bb3035e177a07b.camel@icenowy.me>
 <F2C43938B17FA1E1+aKLaKQfN1Ax8Blcx@LT-Guozexi>
 <7ad9a700dce9342d720740525626340237eb8d9f.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad9a700dce9342d720740525626340237eb8d9f.camel@icenowy.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX2iIhiWkQE420
 A0K3FTMZ1zOMcT4b2vAQg7kxDY1fEYIeL4erF1EuPL49gg5prbhWaIkGi5LLjxM+ClD7kzVgMpB
 +XvgysoJFplVcNxMWvVmwMfHVezrsfiEhl27IRiCMApZ++pwyOnfCl5lhfcDZ4ScGljrDx3ZFsj
 mHykHP/dDdyz/k+JqlBHpQDk+VBtkjBRIGQ3J3ru1Y+7KtgwWbgFaBKuDSbtWu8I7SdEpA7t12/
 pWLk4RaGdmoD7oZyGf2M5f0Op1PDNqI5HaFepbmWA5g08FNQa9GOZwxU+zglj48WWm6/w6HZ8nH
 G+obPDk0NuO5mN61/3IqzKT8G2c7UWzha64fh/rxJ7yM1ftFThh421zaTIPIrEVhUtTxN64JIuH
 MhysDSAvtTujr59u0ox0we4SQSMFFQ==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a70548 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=H813rAELB5ahqNAuXgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: eCkC7WGxzQ-a7ke9a3JrdBir01n6r971
X-Proofpoint-GUID: eCkC7WGxzQ-a7ke9a3JrdBir01n6r971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Mon, Aug 18, 2025 at 03:47:28PM +0800, Icenowy Zheng wrote:
> 在 2025-08-18星期一的 15:45 +0800，Troy Mitchell写道：
> > On Sun, Aug 17, 2025 at 01:10:44AM +0800, Icenowy Zheng wrote:
> > > 在 2025-08-16星期六的 19:24 +0300，Dmitry Baryshkov写道：
> > > > On Fri, Aug 15, 2025 at 12:40:45AM +0800, Icenowy Zheng wrote:
> > > > > T-Head TH1520 SoC contains a Synopsys DesignWare HDMI
> > > > > controller
> > > > > (paired
> > > > > with DesignWare HDMI TX PHY Gen2) that takes the "DP" output
> > > > > from
> > > > > the
> > > > > display controller.
> > > > > 
> > > > > Add a driver for this controller utilizing the common
> > > > > DesignWare
> > > > > HDMI
> > > > > code in the kernel.
> > > > > 
> > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > ---
> > > > >  MAINTAINERS                             |   1 +
> > > > >  drivers/gpu/drm/bridge/Kconfig          |  10 ++
> > > > >  drivers/gpu/drm/bridge/Makefile         |   1 +
> > > > >  drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 170
> > > > > ++++++++++++++++++++++++
> > > > >  4 files changed, 182 insertions(+)
> > > > >  create mode 100644 drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index fe168477caa45..eb84e36ded6d5 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -21728,6 +21728,7 @@
> > > > > F:      Documentation/devicetree/bindings/reset/thead,th1520-
> > > > > reset.yaml
> > > > >  F:     arch/riscv/boot/dts/thead/
> > > > >  F:     drivers/clk/thead/clk-th1520-ap.c
> > > > >  F:     drivers/firmware/thead,th1520-aon.c
> > > > > +F:     drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > > >  F:     drivers/mailbox/mailbox-th1520.c
> > > > >  F:     drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > >  F:     drivers/pinctrl/pinctrl-th1520.c
> > > > > diff --git a/drivers/gpu/drm/bridge/Kconfig
> > > > > b/drivers/gpu/drm/bridge/Kconfig
> > > > > index b9e0ca85226a6..f75e6ad04179f 100644
> > > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > > @@ -322,6 +322,16 @@ config DRM_THINE_THC63LVD1024
> > > > >         help
> > > > >           Thine THC63LVD1024 LVDS/parallel converter driver.
> > > > >  
> > > > > +config DRM_THEAD_TH1520_DW_HDMI
> > > > > +       tristate "T-Head TH1520 DesignWare HDMI bridge"
> > > > > +       depends on OF
> > > > > +       depends on COMMON_CLK
> > > > > +       depends on ARCH_THEAD || COMPILE_TEST
> > > > > +       select DRM_DW_HDMI
> > > > > +       help
> > > > > +         Choose this to enable support for the internal HDMI
> > > > > bridge found
> > > > > +         on the T-Head TH1520 SoC.
> > > > > +
> > > > >  config DRM_TOSHIBA_TC358762
> > > > >         tristate "TC358762 DSI/DPI bridge"
> > > > >         depends on OF
> > > > > diff --git a/drivers/gpu/drm/bridge/Makefile
> > > > > b/drivers/gpu/drm/bridge/Makefile
> > > > > index 245e8a27e3fc5..421e445ff1cd9 100644
> > > > > --- a/drivers/gpu/drm/bridge/Makefile
> > > > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > > > @@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-
> > > > > sii8620.o
> > > > >  obj-$(CONFIG_DRM_SII902X) += sii902x.o
> > > > >  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> > > > >  obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
> > > > > +obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
> > > > >  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
> > > > >  obj-$(CONFIG_DRM_TOSHIBA_TC358762) += tc358762.o
> > > > >  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
> > > > > diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > > > b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > > > new file mode 100644
> > > > > index 0000000000000..f8dddf3cb0cca
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > > > @@ -0,0 +1,170 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> > > > > + *
> > > > > + * Based on rcar_dw_hdmi.c, which is:
> > > > > + *   Copyright (C) 2016 Renesas Electronics Corporation
> > > > > + * Based on imx8mp-hdmi-tx.c, which is:
> > > > > + *   Copyright (C) 2022 Pengutronix, Lucas Stach
> > > > > <kernel@pengutronix.de>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/reset.h>
> > > > > +
> > > > > +#include <drm/bridge/dw_hdmi.h>
> > > > > +#include <drm/drm_modes.h>
> > > > > +
> > > > > +#define TH1520_HDMI_PHY_OPMODE_PLLCFG  0x06    /* Mode of
> > > > > operation and PLL dividers */
> > > > > +#define TH1520_HDMI_PHY_CKSYMTXCTRL    0x09    /* Clock Symbol
> > > > > and
> > > > > Transmitter Control Register */
> > > > > +#define TH1520_HDMI_PHY_VLEVCTRL       0x0e    /* Voltage
> > > > > Level
> > > > > Control Register */
> > > > > +#define TH1520_HDMI_PHY_PLLCURRGMPCTRL 0x10    /* PLL current
> > > > > and
> > > > > Gmp (conductance) */
> > > > > +#define TH1520_HDMI_PHY_PLLDIVCTRL     0x11    /* PLL dividers
> > > > > */
> > > > > +#define TH1520_HDMI_PHY_TXTERM         0x19    /* Transmission
> > > > > Termination Register */
> > > > > +
> > > > > +struct th1520_hdmi_phy_params {
> > > > > +       unsigned long mpixelclock;
> > > > > +       u16 opmode_pllcfg;
> > > > > +       u16 pllcurrgmpctrl;
> > > > > +       u16 plldivctrl;
> > > > > +       u16 cksymtxctrl;
> > > > > +       u16 vlevctrl;
> > > > > +       u16 txterm;
> > > > > +};
> > > > > +
> > > > > +static const struct th1520_hdmi_phy_params
> > > > > th1520_hdmi_phy_params[] = {
> > > > > +       { 35500000,  0x0003, 0x0283, 0x0628, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 44900000,  0x0003, 0x0285, 0x0228, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 71000000,  0x0002, 0x1183, 0x0614, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 90000000,  0x0002, 0x1142, 0x0214, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 121750000, 0x0001, 0x20c0, 0x060a, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 165000000, 0x0001, 0x2080, 0x020a, 0x8088, 0x01a0,
> > > > > 0x0007
> > > > > },
> > > > > +       { 198000000, 0x0000, 0x3040, 0x0605, 0x83c8, 0x0120,
> > > > > 0x0004
> > > > > },
> > > > > +       { 297000000, 0x0000, 0x3041, 0x0205, 0x81dc, 0x0200,
> > > > > 0x0005
> > > > > },
> > > > > +       { 371250000, 0x0640, 0x3041, 0x0205, 0x80f6, 0x0140,
> > > > > 0x0000
> > > > > },
> > > > > +       { 495000000, 0x0640, 0x3080, 0x0005, 0x80f6, 0x0140,
> > > > > 0x0000
> > > > > },
> > > > > +       { 594000000, 0x0640, 0x3080, 0x0005, 0x80fa, 0x01e0,
> > > > > 0x0004
> > > > > },
> > > > > +       { ~0UL,      0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> > > > > 0x0000
> > > > > }
> > > > > +};
> > > > > +
> > > > > +struct th1520_hdmi {
> > > > > +       struct dw_hdmi_plat_data plat_data;
> > > > > +       struct dw_hdmi *dw_hdmi;
> > > > > +       struct clk *pixclk;
> > > > > +       struct reset_control *mainrst, *prst;
> > > > > +};
> > > > > +
> > > > > +static enum drm_mode_status
> > > > > +th1520_hdmi_mode_valid(struct dw_hdmi *hdmi, void *data,
> > > > > +                      const struct drm_display_info *info,
> > > > > +                      const struct drm_display_mode *mode)
> > > > > +{
> > > > > +       /*
> > > > > +        * The maximum supported clock frequency is 594 MHz, as
> > > > > shown in the PHY
> > > > > +        * parameters table.
> > > > > +        */
> > > > > +       if (mode->clock > 594000)
> > > > > +               return MODE_CLOCK_HIGH;
> > > > 
> > > > We should rewrite DW bridge into HDMI ops. It would help us to
> > > > get
> > > > rid
> > > > of such functions. With it in place it will be handled by the
> > > > generic
> > > > TMDS clock rate check.
> > > 
> > > Yes, but this mode_valid hook here is part of the private interface
> > > of
> > > DW bridge, instead of implementing anything for other parts of DRM
> > > subsystem.
> > > 
> > > Even if the TMDS clock rate check is utilized by the DW bridge, the
> > > bridge's interface should be modified to expose something to set
> > > the
> > > maximum clock rate.
> > > 
> > > > 
> > > > > +
> > > > > +       return MODE_OK;
> > > > > +}
> > > > > +
> > > > > +static int th1520_hdmi_phy_configure(struct dw_hdmi *hdmi,
> > > > > void
> > > > > *data,
> > > > > +                                    unsigned long mpixelclock)
> > > > > +{
> > > > > +       const struct th1520_hdmi_phy_params *params =
> > > > > th1520_hdmi_phy_params;
> > > > > +
> > > > > +       for (; params->mpixelclock != ~0UL; ++params) {
> > > > > +               if (mpixelclock <= params->mpixelclock)
> > > > > +                       break;
> > > > 
> > > > for (...) {
> > > >         if (mpixelclock <= params->mpixelclock)
> > > >                 return th1520_program_phy();
> > > 
> > > There's no such a function here, and this check isn't used for
> > > another
> > > time, so having the matching code and programming code extracted
> > > out
> > > can help nothing.
> > I think Dmitry meant that the following code should be moved into
> > a new function, th1520_program_phy().  
> > 
> > This makes the code cleaner and also avoids one extra if check.
> 
> As there's no code reuse, it does not make code cleaner.

It removes necessity for the extra ~0UL entry in the array and removes
the post-loop check whether we found an entry or not.

-- 
With best wishes
Dmitry


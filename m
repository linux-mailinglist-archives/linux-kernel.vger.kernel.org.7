Return-Path: <linux-kernel+bounces-828032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D69B93C65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DC87A42CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF151DDC08;
	Tue, 23 Sep 2025 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FU5DxpuV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043D14C5B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589251; cv=none; b=Jeh792iWstj2HqteQCkkglAKv2CHEwTeDHznhklILRnJUOfB5o/KjbLqzw4ngkqdFYgPZVJY5vHO+jq4o2zuoO1/3K6fRW1qU62DKQsnrP3IuRh2gYg/Up9qUKaQv4J0OEVMY0X5ftBzA/G4Bc6dAqj6BOsJ27crN5WDCxXduSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589251; c=relaxed/simple;
	bh=pCM0bFCurro2QIZOl8/btqKs2g14rImnYH/RWQ67tPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf8llojfT1EnZs7zDkn8Ez57CvFZrwr0UQuTiroBf/+16s6hyL9tSXPzSyOevGzQgXtWolb8abDSN65aOD02MLLb6+KkO4iBc0HbgHryS2W2ndw+i0a37h4VeyYNShhMmsVZvzhXluOrTM/mtOGFQcj3z3/N7eTss/+vUmte720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FU5DxpuV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MENUD4028027
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uKwfwovsK6G+XL2gFR+D9Aio
	+yl6faNqELg+9kMUYj8=; b=FU5DxpuV37CkXQyWkySBCmzbs18Spc9at4WnukhN
	uyXildLccMzUTPhgNIZw/uixB/awta7Ci9TraV2ibFRX4BF7K6saJBVBOsPIPMO9
	OgHqLCI1V5b66skApMGvg65cvrcPvAMiXyHwEu5Oaj9Da1HYpB/L2r1tn7pU8US+
	yOsIDIbXTpJuepKpfNHq8T1/qHCF5/r5hc3xJ/pg9i+OFj2XdQwTxh1lXc+iQtlo
	WaqSowIxWmcW4u6r7pzP4Gc8H8i4Q/YgU6Uosg3eBBUEbrgpVW302ed37gcRn01y
	J3zBbJ3BDcHCUq592W7+IfcBI0ENUTmd3t49fb9vZrlMgA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7enqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7e90f268f62so1317016d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589248; x=1759194048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKwfwovsK6G+XL2gFR+D9Aio+yl6faNqELg+9kMUYj8=;
        b=bgtyPNJZ5aQrP/EYmP4wDrlYKj+VGK7YBDPJzx2QJrf61PBQJ0u3yhHfOjMdOgfkAc
         Qy+ckwLswN9XWnQv/eLJ6dYLkdTbofZKOrpCU8SL+9flfaUnUM1qxeU2TWxyc10ayKqM
         dpv0/ZB1vh3ODkdSdvNNxTt1gUpbv/Jf8niZlHDSqOYm9rJbJyD4SQB+uQ6RT5H2/Sii
         hOzrVU6RMW0Juu2iRyHX+NNF8sb28yC96mAYoO5dOGODOdA4p9iNM9N2AFTrwYebNiEX
         xOBWAJj3gUryYoX/sE/Eg0JOUyMJslesRQkJyV9HLiqCDCiDt01Pl4xFosarBaxCBFpf
         JXSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQGpgILAXFavPW2NKy733EuR1x4ZQ949QAB6TfMZ3PZshyTYKuFDaafs8Bs0OzGViUB+iPx+gHkhEE8v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+DTSIo6xCHaMyipJFvyNGsuHKbdSXlGr4RkcVakb7B2k3xjF
	Sko8af0KDvBWoLfquBih/H4jWaf848/26ipVK3kAfOvcIAdfGlmOANpzakkR/FW7sIz2B7TpO6R
	J1hY07GJDvV72bhOMnrciUzZf1W82179q6vzeABErGIDRX/3Mtpz+7FZ/dBYrBmL/MY0=
X-Gm-Gg: ASbGncvb0EGBopHBKGyqtGS0pc2WTr/1pNOXk0r7CvqCBlsNBDgFthZuktW0zmQMVOG
	fp161OVJykI2JnBFOXQmzO/z+BnuYONWndnHCpLodK+iu2TkT9AbbCgki/lLDK9Fs0Q/aVTbUvw
	ncwQyvbmpnIzwyQVjFbQ2C+B4I27mYUwZ1UBRf2rNXFp7uXI2VcEuXzGHm4+hTXUw8lnR9ZM5Px
	ZnbwBscuxrQvM9Roy3yf3K+Hc5Tav6Hl61cj9dcYNJNuTPcAnWfX/JqUl/Ro8ly9ai6I8nkjeh+
	7hAG7vAbMLQJZedRsCLJ/1PJsJuO0DuTbUPDWQZIw89vLbP5pso+95M4HjcFysPTEhUmTLMSsJ4
	VG4JZveij8XeKSaK9ZlFVqrrpvhIBUy4uWrQtfSDlN8Ph6I7YR6Rq
X-Received: by 2002:a05:6214:252b:b0:782:952a:9e45 with SMTP id 6a1803df08f44-7e71b334514mr6962636d6.65.1758589247047;
        Mon, 22 Sep 2025 18:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPtrX3MUMDF+zqwBkLntyAXDXaG6LVnWCjk6aDDU12rLApl7ZW7ISuHZVgo/gt3eoT+zOpZg==
X-Received: by 2002:a05:6214:252b:b0:782:952a:9e45 with SMTP id 6a1803df08f44-7e71b334514mr6962196d6.65.1758589246311;
        Mon, 22 Sep 2025 18:00:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36a98532a74sm13994211fa.29.2025.09.22.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:00:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:00:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: Re: [PATCH v2 5/8] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
Message-ID: <yy57lh5rmbubtqscpquoy3np65tm465cqbtmjw5pqiwxjnecsh@d4qbxe3d4sc5>
References: <20250921083446.790374-1-uwu@icenowy.me>
 <20250921083446.790374-6-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921083446.790374-6-uwu@icenowy.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX9UlNAxXIkwCG
 uHVRA6Nn+/1Os7YvzZTkYVxj9D5BHQ9W0nyrRfVSYNJQl2nKvFj+dCRKq9hGSyr30t4r3kdJVlC
 HxxoaBqdBv4n2V4ZO88Z82QUSg6i4H2XeoRhS3IbcEeVETdin0YRzBLnKCUtjyeWM5kpwdeitUW
 Q3y4Ba6EFyACXR3MXT1VQa42TlMvgwmHHaBh+fOO/xbOSFQjEFrIxy7z7QIacl29HSdRTs+dBHn
 qS9MH0KS8pVW/Yo+1sOLWLF/pucT1IGMih9aqBfeUZa0/gRxBuSAIYuGsONo4jmzJDXD+HiFEIk
 a7IFD//e74HsxPCdlBuWwXEVAuONv2IpIC4luyncCpAi212oL7a3hNtCrHIdGyMwW15gMbR2ENN
 l3W6E5JF
X-Proofpoint-GUID: -MQy_GSxHhyD-asdlR0WeMz1pmP_HN3I
X-Proofpoint-ORIG-GUID: -MQy_GSxHhyD-asdlR0WeMz1pmP_HN3I
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d1f140 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=kiC7nBRpPsduyw9UZ3oA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Sun, Sep 21, 2025 at 04:34:43PM +0800, Icenowy Zheng wrote:
> T-Head TH1520 SoC contains a Synopsys DesignWare HDMI controller (paired
> with DesignWare HDMI TX PHY Gen2) that takes the "DP" output from the
> display controller.
> 
> Add a driver for this controller utilizing the common DesignWare HDMI
> code in the kernel.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> Changes in v2:
> - Created a new function to set PHY parameters and refactored the
>   control flow of the configure_phy callback.
> 
>  MAINTAINERS                             |   1 +
>  drivers/gpu/drm/bridge/Kconfig          |  10 ++
>  drivers/gpu/drm/bridge/Makefile         |   1 +
>  drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 173 ++++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6206963efbf0..98af9dd3664f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21759,6 +21759,7 @@ F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
>  F:	drivers/firmware/thead,th1520-aon.c
> +F:	drivers/gpu/drm/bridge/th1520-dw-hdmi.c
>  F:	drivers/mailbox/mailbox-th1520.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b9e0ca85226a6..f75e6ad04179f 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -322,6 +322,16 @@ config DRM_THINE_THC63LVD1024
>  	help
>  	  Thine THC63LVD1024 LVDS/parallel converter driver.
>  
> +config DRM_THEAD_TH1520_DW_HDMI
> +	tristate "T-Head TH1520 DesignWare HDMI bridge"
> +	depends on OF
> +	depends on COMMON_CLK
> +	depends on ARCH_THEAD || COMPILE_TEST
> +	select DRM_DW_HDMI
> +	help
> +	  Choose this to enable support for the internal HDMI bridge found
> +	  on the T-Head TH1520 SoC.
> +
>  config DRM_TOSHIBA_TC358762
>  	tristate "TC358762 DSI/DPI bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 245e8a27e3fc5..421e445ff1cd9 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
> +obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358762) += tc358762.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
> diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> new file mode 100644
> index 0000000000000..efb27d37ff652
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> + *
> + * Based on rcar_dw_hdmi.c, which is:
> + *   Copyright (C) 2016 Renesas Electronics Corporation
> + * Based on imx8mp-hdmi-tx.c, which is:
> + *   Copyright (C) 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include <drm/bridge/dw_hdmi.h>
> +#include <drm/drm_modes.h>
> +
> +#define TH1520_HDMI_PHY_OPMODE_PLLCFG	0x06	/* Mode of operation and PLL dividers */
> +#define TH1520_HDMI_PHY_CKSYMTXCTRL	0x09	/* Clock Symbol and Transmitter Control Register */
> +#define TH1520_HDMI_PHY_VLEVCTRL	0x0e	/* Voltage Level Control Register */
> +#define TH1520_HDMI_PHY_PLLCURRGMPCTRL	0x10	/* PLL current and Gmp (conductance) */
> +#define TH1520_HDMI_PHY_PLLDIVCTRL	0x11	/* PLL dividers */
> +#define TH1520_HDMI_PHY_TXTERM		0x19	/* Transmission Termination Register */
> +
> +struct th1520_hdmi_phy_params {
> +	unsigned long mpixelclock;
> +	u16 opmode_pllcfg;
> +	u16 pllcurrgmpctrl;
> +	u16 plldivctrl;
> +	u16 cksymtxctrl;
> +	u16 vlevctrl;
> +	u16 txterm;
> +};
> +
> +static const struct th1520_hdmi_phy_params th1520_hdmi_phy_params[] = {
> +	{ 35500000,  0x0003, 0x0283, 0x0628, 0x8088, 0x01a0, 0x0007 },
> +	{ 44900000,  0x0003, 0x0285, 0x0228, 0x8088, 0x01a0, 0x0007 },
> +	{ 71000000,  0x0002, 0x1183, 0x0614, 0x8088, 0x01a0, 0x0007 },
> +	{ 90000000,  0x0002, 0x1142, 0x0214, 0x8088, 0x01a0, 0x0007 },
> +	{ 121750000, 0x0001, 0x20c0, 0x060a, 0x8088, 0x01a0, 0x0007 },
> +	{ 165000000, 0x0001, 0x2080, 0x020a, 0x8088, 0x01a0, 0x0007 },
> +	{ 198000000, 0x0000, 0x3040, 0x0605, 0x83c8, 0x0120, 0x0004 },
> +	{ 297000000, 0x0000, 0x3041, 0x0205, 0x81dc, 0x0200, 0x0005 },
> +	{ 371250000, 0x0640, 0x3041, 0x0205, 0x80f6, 0x0140, 0x0000 },
> +	{ 495000000, 0x0640, 0x3080, 0x0005, 0x80f6, 0x0140, 0x0000 },
> +	{ 594000000, 0x0640, 0x3080, 0x0005, 0x80fa, 0x01e0, 0x0004 },
> +};
> +
> +struct th1520_hdmi {
> +	struct dw_hdmi_plat_data plat_data;
> +	struct dw_hdmi *dw_hdmi;
> +	struct clk *pixclk;
> +	struct reset_control *mainrst, *prst;
> +};
> +
> +static enum drm_mode_status
> +th1520_hdmi_mode_valid(struct dw_hdmi *hdmi, void *data,
> +		       const struct drm_display_info *info,
> +		       const struct drm_display_mode *mode)
> +{
> +	/*
> +	 * The maximum supported clock frequency is 594 MHz, as shown in the PHY
> +	 * parameters table.
> +	 */
> +	if (mode->clock > 594000)
> +		return MODE_CLOCK_HIGH;

Is it the limitation for the pixel clock or for the TMDS char clock (the
difference makes sense for non-8-bpc modes.

> +
> +	return MODE_OK;
> +}
> +

-- 
With best wishes
Dmitry


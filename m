Return-Path: <linux-kernel+bounces-842497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F23BBCDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD7B14E063F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C41DB95E;
	Sun,  5 Oct 2025 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PO68gtv9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F227461
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759705620; cv=none; b=fuBwiBD1eGxBYN6KTov+cPDwOM11o8wRTatOzYFkoCE734oDLpkvM1igFeGAKPyfr7ypbFGxqPfEoH6FUO0TOnIXuNWCy5aNVohxbI6KjU2eBepWWD4APGE0nQ4a6WDYLgCMleuUJyMTRGf0/tVVf2i2DKP812lv/9jQtzaD4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759705620; c=relaxed/simple;
	bh=jIzOREwgb/liYX7KPV1j3ZRoN7eDqlJzDZMD+ipHuLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3MZ0dfuPuTMMT+KcjFdrsR35cnUdOC0A8vcHeUVbRgP8oOVWkT4QMvenZATaCAHvRwdkO5wje74kYk+0ODSOn4eQ99M+1Dk12LtBzI+4Ft2Bs/BwhVXX6c0RX83NKic6etHJZXNrs46NR7Ga/1bWuhSuMnza8qRsSMaVk3wiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PO68gtv9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595KiXCj023029
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 23:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lj6Vm+mKK72oxw8V41jzqdQf
	IYUMuRKelKPlyhtLfFo=; b=PO68gtv9XUk3Bx0aBPZXRnRFAGHD2E9NeQ0iMcdA
	6E4Hy6KTDEjmgrmB6JcPqR3/MGdlZTS0XOY0mlUTbHNI1z9rda/aIPnO0b81x4tl
	tKgyFcu6MGZwso9pgrHmfPSXywC56zhv2P7xJ5RLScNzYqrsV3ZwXNREj5Tw3O8j
	MGM4/scvgpVBg0klTenTh4JJQZYxz9r8K3xGCPd/OvRH22pJYu+YWVaL7jPDt7eJ
	GC7YmscC75cR+6bvRXcHsWbqvZsUbHaenGe6MMIegWeCnnjL5PmjVJhdeydDtKAp
	W39gcJm1grVyZFhvBARhzvRpAKGMJavuZ3yRhVCp4ezCuw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu2mqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:06:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8741223accfso92572526d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759705616; x=1760310416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj6Vm+mKK72oxw8V41jzqdQfIYUMuRKelKPlyhtLfFo=;
        b=mIT/O9E74B48TDHCQDImDz3j46oDtZjd5UH3kK4NVeaWwWQEeWi8hmSGse9z+X1cDN
         aJDAepaS4V7RoGX3Bnq3eVDbYecE2/F6y+KbM1DsuJ9FdlqNw8MFOLQvaaII+XBXptpf
         sgCL0zKPI342bEAC19erR102u+vd858ZuicUO6VATpvheaynF/1fvlOyyGAX5WzJbxnl
         bapoztaQE4rAx4jTz/yltj3+BBMgQDi7FNip+rRHoJF2wxfylW/rQdUCU+Q4tZL+3vJD
         ygL57SPAzz9VwomjeDpU53aB9+WbyRCHZhhAMR1ewdLepQdX8e2A8UF+M2wksj/qJSXL
         I62w==
X-Forwarded-Encrypted: i=1; AJvYcCXGxdwYXgHGttKc7R0bICbw3pItOlmTfy7myiZIr/Yx0f59Rq959lZdPxHwumpujz8xgRvSSwwfxPmG0fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBY+UYnZcrxJMoiYcygGYq7YQKWhdJilY5+z0a09F45vkZwBV
	FnSqkn/pHfYV3DiZYYvaHq8KhQALFLscfStrcLtuxOW0oaJAv/4DwEaMqIwj6TwSGvitZgdGtCR
	A8MZ/ybQZi6EGMpG4OdJ/ll+aJZ+nIVh3Vpe26q0JpEOCu1H2flTJ3T3LgmJ57BBryQc=
X-Gm-Gg: ASbGncsXICBdYaD4dBr4eCoK624P7o9L8TC3pZRaaNG0luK7Ks0kvx7HI7vyv1ENBZc
	CuzvQhRR2iKkLHhCl7RdoE42WA2TPCO2QA0qsrwG9pzmom7V8fXIEA9ZfV/gIdLgrdwCxQ++Ee/
	z5kOqBRgxSbpAQMLAlcwXKgzryVlR8xvnv1wd6hK61iuu6deVx/QEM78pUUm2RZZb6/TZOTC4aJ
	2lOx8zuHrLv7/dUSm9fPT0PwMYlaaeGi739vgk9G7kA3ZrRRkqekNh0YVAj6UhGE+yA0NTxRy7G
	vkN9mQbsTY3p3WttU3P/p2IxPKF/H0q9zsGADr8vXreMKba+ir/YM/22F9huvp0jxyYW8PFqtPd
	94fVrw1c7Mw0BXdJKwOvnKIHZqWJpi3B6bikkKgFWs5jDH09vuQsYTDQRrA==
X-Received: by 2002:a05:622a:1885:b0:4cb:d1cf:7f23 with SMTP id d75a77b69052e-4e576a46d4emr130938501cf.14.1759705616358;
        Sun, 05 Oct 2025 16:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0HXZrFg3IdwF2sOaMvXd8PehIlFXIFHZasdiVQwW8lsVftm02zEuP5oo42y4PfnYOPPhTWg==
X-Received: by 2002:a05:622a:1885:b0:4cb:d1cf:7f23 with SMTP id d75a77b69052e-4e576a46d4emr130938281cf.14.1759705615847;
        Sun, 05 Oct 2025 16:06:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba312387sm38140221fa.25.2025.10.05.16.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:06:53 -0700 (PDT)
Date: Mon, 6 Oct 2025 02:06:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 1/1] [DRIVER] gpu: drm: add support for YHGCH ZX1000
 soc chipset
Message-ID: <zyocr7rwdu44jwmr633yke2naitw3dm2hbcx4k64icee4taz2u@2z4zuhvqzplp>
References: <20250929063103.7375-1-chuguangqing@inspur.com>
 <20250929104831.8548-1-chuguangqing@inspur.com>
 <20250929104831.8548-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929104831.8548-2-chuguangqing@inspur.com>
X-Proofpoint-ORIG-GUID: meOi631Cih5O0h8_ybKFs8Cw1_YeQVxJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX+qT1wUrz1n+a
 S042+9Xj6AtK2XBex/zI86C4vrLr4bvTAN+T5X3zLA4M31L1+4Ai76z8xEMcrdc9PmqpN5jzrYq
 RUYYCirBynC5lwQQ0KASo1sCI1PP7k9y/LNbiPRweoCetz4585fhDXtZ6P/9jKX6Y4L1VWE3kKI
 DaPJRZna19uEtE57bvf3YJaPhh+xVX1kwAyVLhEmgAH9cCQghlbnxv00srNi5jMUipr8WpldbA6
 oVSfGVYQyTwtqUJUvYmI6A+14HYazjNmzpBuzAuwFRZGsDZDV9eSy0e0iqtsfjGAxIUw/IHnazE
 Z2bPvfWW4a+65B9krvHeRfl2RLcFDbETZhM8RL2R8vMt5ejLH72ZkPWi6nORifQmeL1FRnnvurq
 gVuIzUutM7nDsTfsjjdUB2ok194wGA==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e2fa11 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=7V44lBRLAAAA:8 a=F_93P0QhAAAA:8 a=VwQbUJbxAAAA:8
 a=TNceIUboeKl1yXBjWzYA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=YnjlFex2MTZRjtOv0BSV:22 a=v2fne3mUlQEKA94IZ0Od:22
X-Proofpoint-GUID: meOi631Cih5O0h8_ybKFs8Cw1_YeQVxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Mon, Sep 29, 2025 at 06:48:31PM +0800, Chu Guangqing wrote:
> add support for ZX1000 BMC soc chipset
> 
> The ZX1000 (Z106) chip is a self-developed server management chip of the
> "Zhixin Series" by Yunhai Guochuang. It can monitor the operating status of
> servers in real time and perform various remote management operations on
> servers, including remote system installation, restart, power-on and power-off.
> It supports instruction sets of mainstream processor architectures such as X86,
> ARM, and LoongArch, with fully open firmware and software interfaces that are
> compatible with the third-party application ecosystem.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  MAINTAINERS                            |   6 +
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/yhgch/Kconfig          |  11 +
>  drivers/gpu/drm/yhgch/Makefile         |   4 +
>  drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 398 +++++++++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.c  | 308 +++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.h  |  51 ++++
>  drivers/gpu/drm/yhgch/yhgch_drm_i2c.c  | 114 +++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_regs.h | 208 +++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_vdac.c | 134 +++++++++
>  11 files changed, 1237 insertions(+)
>  create mode 100644 drivers/gpu/drm/yhgch/Kconfig
>  create mode 100644 drivers/gpu/drm/yhgch/Makefile
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_de.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_regs.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 520fb4e379a3..8f861858c6e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27781,6 +27781,12 @@ S:	Maintained
>  F:	Documentation/input/devices/yealink.rst
>  F:	drivers/input/misc/yealink.*
>  
> +YHGCH DRM DRIVER
> +M:	Chu Guangqing <chuguangqing@inspur.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/yhgch
> +W:	https://www.yhgch.com
> +
>  Z8530 DRIVER FOR AX.25
>  M:	Joerg Reuter <jreuter@yaina.de>
>  L:	linux-hams@vger.kernel.org
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7ea8e895c0c..8e0b1d12c81f 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -396,6 +396,8 @@ source "drivers/gpu/drm/sprd/Kconfig"
>  
>  source "drivers/gpu/drm/imagination/Kconfig"
>  
> +source "drivers/gpu/drm/yhgch/Kconfig"
> +
>  config DRM_HYPERV
>  	tristate "DRM Support for Hyper-V synthetic video device"
>  	depends on DRM && PCI && HYPERV
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 4dafbdc8f86a..f344e0173b29 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -231,6 +231,7 @@ obj-y			+= solomon/
>  obj-$(CONFIG_DRM_SPRD) += sprd/
>  obj-$(CONFIG_DRM_LOONGSON) += loongson/
>  obj-$(CONFIG_DRM_POWERVR) += imagination/
> +obj-$(CONFIG_DRM_YHGCH)  += yhgch/
>  
>  # Ensure drm headers are self-contained and pass kernel-doc
>  hdrtest-files := \
> diff --git a/drivers/gpu/drm/yhgch/Kconfig b/drivers/gpu/drm/yhgch/Kconfig
> new file mode 100644
> index 000000000000..887cb66aa305
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/Kconfig
> @@ -0,0 +1,11 @@
> +config DRM_YHGCH
> +    tristate "DRM Support for YHGCH BMC"
> +    depends on DRM && PCI && MMU
> +    select DRM_CLIENT_SELECTION
> +    select DRM_KMS_HELPER
> +    select DRM_GEM_SHMEM_HELPER
> +    help
> +        Choose this option if you have a YHGCH ZX1000 chipset.
> +        If M is selected the module will be called yhgch-drm.
> +        IF Y is selected the module will be built into the kernel.
> +        IF N is selected the module will be excluded from the kernel.
> diff --git a/drivers/gpu/drm/yhgch/Makefile b/drivers/gpu/drm/yhgch/Makefile
> new file mode 100644
> index 000000000000..30de2fd27f18
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/Makefile
> @@ -0,0 +1,4 @@
> +yhgch-drm-y := yhgch_drm_drv.o yhgch_drm_de.o yhgch_drm_vdac.o yhgch_drm_i2c.o
> +
> +obj-$(CONFIG_DRM_YHGCH) += yhgch-drm.o
> +
> diff --git a/drivers/gpu/drm/yhgch/yhgch_drm_de.c b/drivers/gpu/drm/yhgch/yhgch_drm_de.c
> new file mode 100644
> index 000000000000..1a72b5517618
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/yhgch_drm_de.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/delay.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_format_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_fourcc.h>
> +
> +#include <drm/drm_vblank.h>
> +
> +#include "yhgch_drm_drv.h"
> +#include "yhgch_drm_regs.h"
> +
> +struct yhgch_dislay_pll_config {
> +	u64 hdisplay;
> +	u64 vdisplay;
> +	u32 pll1_config_value;
> +	u32 pll2_config_value;
> +};
> +
> +static const struct yhgch_dislay_pll_config yhgch_pll_table[] = {
> +	{ 640, 480, CRT_PLL1_NS_25MHZ, CRT_PLL2_NS_25MHZ },
> +	{ 800, 600, CRT_PLL1_NS_40MHZ, CRT_PLL2_NS_40MHZ },
> +	{ 1024, 768, CRT_PLL1_NS_65MHZ, CRT_PLL2_NS_65MHZ },
> +	{ 1280, 1024, CRT_PLL1_NS_108MHZ, CRT_PLL2_NS_108MHZ },
> +	{ 1920, 1080, CRT_PLL1_NS_148MHZ, CRT_PLL2_NS_148MHZ },
> +};
> +
> +static int yhgch_plane_atomic_check(struct drm_plane *plane,
> +				    struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
> +										 plane);
> +	struct drm_framebuffer *fb = new_plane_state->fb;
> +	struct drm_crtc_state *new_crtc_state = NULL;
> +
> +	if (!fb)
> +		return 0;

This can't happen, please drop.

> +
> +	if (new_plane_state->crtc)
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
> +
> +	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, true);
> +}
> +
> +static void yhgch_handle_damage(void __iomem *addr_base, struct iosys_map *src,
> +				struct drm_framebuffer *fb,
> +				struct drm_rect *clip)
> +{
> +	struct iosys_map dst;
> +
> +	iosys_map_set_vaddr_iomem(&dst, addr_base);
> +	iosys_map_incr(&dst, drm_fb_clip_offset(fb->pitches[0], fb->format, clip));
> +	drm_fb_memcpy(&dst, fb->pitches, src, fb, clip);
> +}
> +
> +static void yhgch_plane_atomic_update(struct drm_plane *plane,
> +				      struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_framebuffer *fb = plane_state->fb;
> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct yhgch_drm_private *priv = to_yhgch_drm_private(plane->dev);
> +	struct drm_atomic_helper_damage_iter iter;
> +	struct drm_rect damage;
> +	u32 reg;
> +	s64 gpu_addr = 0;
> +	u32 line_l;
> +
> +	if (!plane_state->crtc || !plane_state->fb)
> +		return;
> +
> +	if (!plane_state->visible)
> +		return;

Neither of these can happen, please drop.

> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		yhgch_handle_damage(priv->vram_base, shadow_plane_state->data, fb, &damage);
> +	}
> +
> +	fb->pitches[0] = (fb->pitches[0] + 15) & ~15;
> +
> +	writel(gpu_addr, priv->mmio + YHGCH_CRT_FB_ADDRESS);

Why are you always writing 0 to YHGCH_CRT_FB_ADDRESS here?

> +
> +	reg = fb->width * fb->format->cpp[0];
> +
> +	line_l = fb->pitches[0];
> +	writel(FIELD_PREP(YHGCH_CRT_FB_WIDTH_WIDTH_MASK, reg) |
> +	       FIELD_PREP(YHGCH_CRT_FB_WIDTH_OFFS_MASK, line_l),
> +	       priv->mmio + YHGCH_CRT_FB_WIDTH);
> +
> +	/* SET PIXEL FORMAT */
> +	reg = readl(priv->mmio + YHGCH_CRT_DISP_CTL);
> +	reg &= ~YHGCH_CRT_DISP_CTL_FORMAT_MASK;
> +	reg |= FIELD_PREP(YHGCH_CRT_DISP_CTL_FORMAT_MASK,
> +			   fb->format->cpp[0] * 8 / 16);
> +	writel(reg, priv->mmio + YHGCH_CRT_DISP_CTL);
> +}
> +

[...]

> +
> +/*
> + * It can operate in one of three modes: 0, 1 or Sleep.

What do 0 and 1 mean here?

> + */
> +void yhgch_set_power_mode(struct yhgch_drm_private *priv, u32 power_mode)
> +{
> +	unsigned int control_value = 0;
> +	void __iomem *mmio = priv->mmio;
> +	u32 input = 1;
> +
> +	if (power_mode > YHGCH_PW_MODE_CTL_MODE_SLEEP)
> +		return;
> +
> +	if (power_mode == YHGCH_PW_MODE_CTL_MODE_SLEEP)
> +		input = 0;
> +
> +	control_value = readl(mmio + YHGCH_POWER_MODE_CTRL);
> +	control_value &= ~(YHGCH_PW_MODE_CTL_MODE_MASK |
> +			   YHGCH_PW_MODE_CTL_OSC_INPUT_MASK);
> +	control_value |= FIELD_PREP(YHGCH_PW_MODE_CTL_MODE_MASK, power_mode);
> +	control_value |= FIELD_PREP(YHGCH_PW_MODE_CTL_OSC_INPUT_MASK, input);
> +	writel(control_value, mmio + YHGCH_POWER_MODE_CTRL);
> +}
> +

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-835599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2FBA78C7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF1B17703A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB4257848;
	Sun, 28 Sep 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocHIJPAw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAAB5227
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095815; cv=none; b=Om/MJjrpsHOY0hAFKnN8r9gkYqqdzccHJ5CYgxz90WEbnHdUcWlo8nd529e8uPWU+jvmqQqX4i55EO1o0/96o8eMhtKPE8ws62hez8R0PdQhk4EBAUabh8okvFThcP9FsNd4Dl9SEuIq36SaHmi4b5sozoZizdIZWEV57L5BWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095815; c=relaxed/simple;
	bh=5x17VX+8nUbU0RPcHmMYz4eFHEHqNRLsb1KYVvWQnC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL9BpXzOtCeZutS0q5kd2uNfqmn5iohEqhfRv4bHCGJq6zHuor7T/pg4ohQWsV5lf2CixsMhqFqUYRlWfqCOM0e3TIB/lh8x2waWWnzmgWxCyzsx9eqdznIq48v3axnalxFIu1Lvuxn7Gqeng8dIhca4sudwZC6wEvZtR9Laz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocHIJPAw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5USYt011806
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KdQy2Yp2ohV0GjnngARmowUI
	sH77BTTy/bT8/FnCmBY=; b=ocHIJPAwH4sSIo6of7+RZKauwulrhQJq5U1ZA6rd
	6ar0bAfnFW/YZoI1bblztIcsSZkzkbX8thZMQBWMBx3ASZVjyMNEsRInrYUcXYfU
	/xXNFiYWtvQethT6aUPZh98tUjdo9rP6EZ8zUW0yG5JrE2sUax3jdGsLaVJw//fx
	fsJNQ4b3pHnk5fMAnLGa/BiFDf+DKTvtBJHpd53dp9YZm3WwwFp6zgdAmjT5oxHG
	SQCJqIqHR3rtYJz6/VnYjMibXrBleoEK1Uefur43nPkBTQc12Uua9GXiaSI62hm2
	rCcEONRxHU/JxelA+wAFho/fHILkdqWia+ne0c/FhGdLjQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mckh6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:43:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e0fcbf8eb0so11929441cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095810; x=1759700610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdQy2Yp2ohV0GjnngARmowUIsH77BTTy/bT8/FnCmBY=;
        b=EErGqTozXidMhDGg3b74rxlRskmu5l0js38OcqXlzrk9p5x/eqd5HHnZFyQf6ntz0v
         ebLye/Fd9dXeQTpjsrk7n9IjubysgD1ZNyAlv/fmAP1Ye68M8IoBmkfr+s6zI2LASdBV
         snMV3LOgaWVdDf3/KMWeLDuQYScxyBkF6rcHeYvu+7OoNMf86Mh3tDCzlbd7mPLYX/S9
         /Gf6FD98eDAtQEaKKSQ+346PWAWQrawY7NHc02Etv8gCHQ3eOzfoX34+YoXyh3hXPoz6
         m6eQqgscavwdrJ1jV5ALEXoVXY51soxgnJ6rWv7/QpQiKqx6NzEnIUZnGjGq8iymV4H9
         Q/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWt0iZadOhyVDaiD42M8RrILgFomERtT+e/OLg8c+eETLUYHSP1377LJC1gt1UBijFcbQsGpPbPCoIMXhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gZxJT6q7OZc0w4zWq8p46HNgxK9LHX76Kl7Z8nIHE+nDs5Gb
	SbxmkrMAKd0O+QrjaV2yqfl1kw1hfXw7ecSB1FFJxoucv1VJw+GgSMY79+u3Yr9PjdhyOpvQhNP
	YsDJg8QkVtVESJJrZxtaLNWMZYqVAt+AiD/K5XkZXBtSW/N7rnmFbO6Xr0uU6cXjSPlY=
X-Gm-Gg: ASbGncsae/EXslEO6MdxAddWHcx//qo+pleVoikDycPOaoHUixCRSTynrYtEha0dv9F
	jHX+v22aKpYd7PLB61OXW1YxKk5754h3ZmNOH9GIVdPOXGzIConF3EHSJWb1t14kDMq7YT8HhXa
	gx3ALLPDX9Osg1puNFVGvmuiF7ClXslVAi3wfLpmORRUW/iZPwlaWcNCtMoyF0RM5eAuvfyNwXH
	6tVBXxpeiyWuksM6YiGPrhPR81chAilO8u5L0v1Y+NGX3T8vwHSgVTo9M4l9GK4Y8L0Xw/wyq80
	hCR1ExaFsL6iXiUBOdPuoFCqBCULR5aGu3SGCKX1i3GNk1FhuDO1ZdXrjiKAPBDCwAyWMGd6L/6
	XMDLUQQOp4YGMAu3Ob3Sc1gtIc8W4Ojsrb2bjHd3RplkPoTnfqLxr
X-Received: by 2002:a05:622a:88:b0:4ba:4bef:de20 with SMTP id d75a77b69052e-4da47dfda4bmr174584161cf.20.1759095809586;
        Sun, 28 Sep 2025 14:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlNIu3Nwvr6WYthNyk6M/pHtdrre/IKofsS+I6V30X3WWAKKVckAvqxQQHNIkmvG0f+a7zlA==
X-Received: by 2002:a05:622a:88:b0:4ba:4bef:de20 with SMTP id d75a77b69052e-4da47dfda4bmr174583981cf.20.1759095809119;
        Sun, 28 Sep 2025 14:43:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710249sm23971981fa.34.2025.09.28.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:43:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 00:43:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 1/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000
 soc chipset
Message-ID: <bvwmxalakynyfrtuns2wxvggkaq6ivbub6rv4bnrcwp7k5l3ti@slpcwysdul36>
References: <20250928054123.32895-1-chuguangqing@inspur.com>
 <20250928054123.32895-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928054123.32895-2-chuguangqing@inspur.com>
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68d9ac03 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=F_93P0QhAAAA:8 a=VwQbUJbxAAAA:8 a=TNceIUboeKl1yXBjWzYA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=v2fne3mUlQEKA94IZ0Od:22
X-Proofpoint-ORIG-GUID: NUavgBdyeuaxXjRiuQtIB1a9RgJjTVKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX1Vh/xtIfa3nX
 XJdI708QYXi6/mepyrvOzE/hNirjHrmT0JGquar8QXM7wuy5a6Q8+ADZGQQ4bX9pgsM608c9iAY
 8pz1r8ehq3I2BNV8BbQUFxh1W+R6CyPgFfBct1YGv4sWCuglRj7Xnkp4HvTBx/KwlJRDSB4cMm1
 wOVGCmrxYpQWK2Pnfuent5b3yb4lAaidnfgXcZ4Gx0+hjxf/poRAvJux6Tjyky1IoTz6WO9F8hI
 oey9hsqeOkmk7vkQeK87sB7jBxasfRji/rM9IPUDDmpMgjX7r1rM+dvyuDWE4RcUkijTkSqR95p
 ukO6/Vwj1IjQ1MHc5ibTGy6WQaslq+pG+6ZXdURqf4XMuWAXPnBXVaBLxML4NVZjn1o12StYPhE
 46iZyGorWurQUoWgwKwfttGCLQLtuA==
X-Proofpoint-GUID: NUavgBdyeuaxXjRiuQtIB1a9RgJjTVKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_09,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004

On Sun, Sep 28, 2025 at 01:41:23PM +0800, Chu Guangqing wrote:
> add support for Yhgc BMC soc chipset

Could you please provide some more details about the BMC? Quick googling
finds only a very links. What is the name of the vendor? Is there a
product page somewhere?

> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  MAINTAINERS                            |   5 +
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/yhgch/Kconfig          |  11 +
>  drivers/gpu/drm/yhgch/Makefile         |   4 +
>  drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 407 +++++++++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.c  | 310 +++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.h  |  51 ++++
>  drivers/gpu/drm/yhgch/yhgch_drm_i2c.c  | 114 +++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_regs.h | 208 +++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_vdac.c | 134 ++++++++
>  11 files changed, 1247 insertions(+)
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
> index 520fb4e379a3..18fd2e2fcb81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27781,6 +27781,11 @@ S:	Maintained
>  F:	Documentation/input/devices/yealink.rst
>  F:	drivers/input/misc/yealink.*
>  
> +YHGC DRM DRIVER
> +M:	chuguangqing <chuguangqing@inspur.com>

Please use full name here.

> +S:	Maintained
> +F:	drivers/gpu/drm/yhgch

How do you plan to maintain it? Do you plan to use drm-misc tree? (in
such a case it should be mentioned here). Do you expect others to commit
updates / fixes for you or do you have commit rights?

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
> index 000000000000..695d29409444
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/Kconfig
> @@ -0,0 +1,11 @@
> +config DRM_YHGCH
> +    tristate "DRM Support for Yhgch BMC"
> +    depends on DRM && PCI && MMU
> +    select DRM_CLIENT_SELECTION
> +    select DRM_KMS_HELPER
> +    select DRM_GEM_SHMEM_HELPER
> +    help
> +        Choose this option if you have a Yhgch soc chipset.
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
> index 000000000000..de6dbd5acca7
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/yhgch_drm_de.c
> @@ -0,0 +1,407 @@
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

This list is very limited by the modern standards. Is there a way to
calculate these values for other resultions from the driver side?

> +};
> +
> +static const u32 channel_formats1[] = {
> +	DRM_FORMAT_RGB565, DRM_FORMAT_RGB888,
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static struct drm_plane_funcs yhgch_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	.reset = drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,

This macro redefines several fields defined previously. You should have
gotten a warning.

> +};
> +
> +
> +static enum drm_mode_status
> +yhgch_crtc_mode_valid(struct drm_crtc *crtc,
> +		      const struct drm_display_mode *mode)
> +{
> +	size_t i = 0;
> +	int vrefresh = drm_mode_vrefresh(mode);
> +
> +	if (vrefresh < 59 || vrefresh > 61)
> +		return MODE_NOCLOCK;
> +
> +	for (i = 0; i < ARRAY_SIZE(yhgch_pll_table); i++) {
> +		if (yhgch_pll_table[i].hdisplay == mode->hdisplay &&
> +		    yhgch_pll_table[i].vdisplay == mode->vdisplay)
> +			return MODE_OK;
> +	}
> +
> +	return MODE_BAD;
> +}
> +
> +static void set_vclock_yhgch(struct drm_device *dev, u64 pll)
> +{
> +	u32 val;
> +	struct yhgch_drm_private *priv = to_yhgch_drm_private(dev);
> +
> +	val = readl(priv->mmio + CRT_PLL1_NS);
> +	val &= ~(CRT_PLL1_NS_OUTER_BYPASS(1));
> +	writel(val, priv->mmio + CRT_PLL1_NS);
> +
> +	val = CRT_PLL1_NS_INTER_BYPASS(1) | CRT_PLL1_NS_POWERON(1);
> +	writel(val, priv->mmio + CRT_PLL1_NS);
> +
> +	writel(pll, priv->mmio + CRT_PLL1_NS);
> +
> +	usleep_range(1000, 2000);
> +
> +	val = pll & ~(CRT_PLL1_NS_POWERON(1));
> +	writel(val, priv->mmio + CRT_PLL1_NS);
> +
> +	usleep_range(1000, 2000);
> +
> +	val &= ~(CRT_PLL1_NS_INTER_BYPASS(1));
> +	writel(val, priv->mmio + CRT_PLL1_NS);
> +
> +	usleep_range(1000, 2000);
> +
> +	val |= CRT_PLL1_NS_OUTER_BYPASS(1);
> +	writel(val, priv->mmio + CRT_PLL1_NS);
> +}
> +
> +static void get_pll_config(u64 x, u64 y, u32 *pll1, u32 *pll2)
> +{
> +	size_t i;
> +	size_t count = ARRAY_SIZE(yhgch_pll_table);
> +
> +	for (i = 0; i < count; i++) {
> +		if (yhgch_pll_table[i].hdisplay == x &&
> +		    yhgch_pll_table[i].vdisplay == y) {
> +			*pll1 = yhgch_pll_table[i].pll1_config_value;
> +			*pll2 = yhgch_pll_table[i].pll2_config_value;
> +			return;
> +		}
> +	}
> +
> +	/* if found none, we use default value */

Can this happen granted your mode_valid check?

> +	*pll1 = CRT_PLL1_NS_25MHZ;
> +	*pll2 = CRT_PLL2_NS_25MHZ;
> +}
> +

[...]

> +
> +static void yhgch_crtc_atomic_begin(struct drm_crtc *crtc,
> +				    struct drm_atomic_state *old_state)
> +{
> +	u32 reg;
> +	struct drm_device *dev = crtc->dev;
> +	struct yhgch_drm_private *priv = to_yhgch_drm_private(dev);
> +
> +	yhgch_set_power_mode(priv, YHGCH_PW_MODE_CTL_MODE_MODE0);
> +
> +	/* Enable display power gate & LOCALMEM power gate */
> +	reg = readl(priv->mmio + YHGCH_CURRENT_GATE);
> +	reg &= ~YHGCH_CURR_GATE_DISPLAY_MASK;
> +	reg &= ~YHGCH_CURR_GATE_LOCALMEM_MASK;
> +	reg |= YHGCH_CURR_GATE_DISPLAY(1);
> +	reg |= YHGCH_CURR_GATE_LOCALMEM(1);
> +	yhgch_set_current_gate(priv, reg);
> +
> +	/* We can add more initialization as needed. */

???

> +}
> +

[..]

> diff --git a/drivers/gpu/drm/yhgch/yhgch_drm_drv.c b/drivers/gpu/drm/yhgch/yhgch_drm_drv.c
> new file mode 100644
> index 000000000000..2d7588ab8e2c
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/yhgch_drm_drv.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +
> +#include <linux/aperture.h>
> +#include <drm/clients/drm_client_setup.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fbdev_ttm.h>
> +
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_fbdev_shmem.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_module.h>
> +#include <drm/drm_vblank.h>
> +
> +#include <drm/drm_probe_helper.h>
> +
> +#include "yhgch_drm_drv.h"
> +#include "yhgch_drm_regs.h"
> +
> +#define MEM_SIZE_RESERVE4KVM 0x200000

Unused

> +

-- 
With best wishes
Dmitry


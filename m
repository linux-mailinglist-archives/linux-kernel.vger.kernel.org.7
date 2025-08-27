Return-Path: <linux-kernel+bounces-788949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D91B38E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8036D36281A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2FF1AC43A;
	Wed, 27 Aug 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gS4ZBzmC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36624DCE5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333503; cv=none; b=WjvSubwltBGbqexRsGbeOkzzb2CNKLDpCu0AT8WHFN8DIVRFXMXL2IQW22wN4rQL5zN/QWtUQyODzfiIZZM50UuUPkporPwKx39bIAaW8kA6O7SzhLuxzQ1DPeyu/jW8Rr78A3gyI2dKIXV6ifgpTE8s2fug89EB80zOe0QUp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333503; c=relaxed/simple;
	bh=Z1DvAKKM2j6TgptKzaEBkJT9zaImy1drSJPHVc5HFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4LVRzUYxpWjzAadVvUANHutNqPW7LGoUOEuR/W2IF9iUPywszFP4LkdgbpPX+7RAsllu1lQ/Zg3QUClyHLhNto0aMJddV8lWpytwIQkPG0yGvtwzLzolDQ07n+0OCm5yI4K/Uy4FA1nMbrrd58HANeQoVF5NDCFu8NH9RFBoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gS4ZBzmC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57REuA1t000418
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wMabvnMiY6aI3QTnrZr9pq+N
	RKVIz1RxP9V/JHunYhU=; b=gS4ZBzmCgDeh85coVTvtc5oGJFI2VEr0B4boNmF1
	O3qPXL7qBbiAVuTr52jGhMBV2zit0RdQ5BLv12Fl+ToaZkvNk+/1F0xHIdrwbb1J
	wmQxWz6cVISIN9+voNHKu43ytyrWMVYcVBM+BS0zM8uBNyiBQvJhoLQgZ5chaMi0
	kNfVSdHggJV6j0kxpQnGhrU+rHeMZL+IDFphUzlfQdbC2LQ8TKO68RRBFZkn+mPM
	vvZN+NnKqUQIHRSN5Yg5A6scSFSLnHBxfQFuoaKEnc5sx9unDcsxRS0YWurBvaQK
	AtnOt25Q1gVPh0lff1ALoiyTYRPbFDQNtm0WgE6pb8HW2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48t47b93u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:24:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109ab2cbaso7459881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756333498; x=1756938298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMabvnMiY6aI3QTnrZr9pq+NRKVIz1RxP9V/JHunYhU=;
        b=OZuIvhyQAP33uEcUyTOsu+WEOYbpEatPujp3K3pALVNaGkPWW3cWzhQOywvNw65yIF
         BFSwrZt1oflM39WtGUZewZk5OdURRqUA2tpeh8To9YbQqKTLQDYMefunU7S55Aapclpb
         yKt6aUJTmt7CYgQlMLAmSt+6c2CNW4HNSRw3BPbCQRmOlO4/gYcSTLjtNgm00OHONqZi
         ggpy3WWUD9RckHbblVSKGKUbztQ+3UljCBJE7yIaWZ17amhS2EiaQR0B+hCuY4pxYpub
         IbIKlDiCJReF/HOIiGup+lOJrKfqJOEjKIbz7tCdaMEf9u2f6xyE+RO+TOxhsg9HErdq
         nahA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgrYry4JbhOLltYM5/YJdRECpWR+hhhQPE+TWxx0+MdknXdGmXLPAuCfb2dd8GTCucayK2EF0KbIoaSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfScGp7gSlKYzs/sdRFv9jil16Wd0yXM+Seqr0nJz9JWWSQmfe
	/oO0o42l18xQmhylJCDObE3p7Z8Xl+gl5bUvckPdZ9jl7+DG7RE/fsIcW4uXvLuVR2G2TWnOBuc
	fdOUuLZeiFfhWCisyw351xP21w9n1UYjRJUKTucgtV55DvIgIaQDq0zX5wqDOQ4A/zjA=
X-Gm-Gg: ASbGncv6NOiNnYnm2aNaAhKmZ49uwX0leIuIbQr0wLNMuBeJTc/lW2NMJyBQklsoQJ4
	7J3P/+SAbE0zsx5JvT5nWrS1jRRvmT4O5JbEJKqnRw5wCx/9HnmCjmWw3LUx1K9b3P0BVkV3REX
	SWB41f8MgWp9PjjdOt6oksymlnh8qAb1Pf6oUji0VSfgtXgSnPliQg26tJSEE0TCPwDhgYmxKX/
	9EfZXcbjv77Nuhrt1UQZdQbto+BZxrKgc1c6N9AJTM8uu6NU1xwQ71gZ4Iui7i9sdKgyVX7mBU1
	R9xqox55VHZ67wK9DlrCzxFw5fIiZdTpUwf2K2ls3LnnLCWzk5gvTaQgz96pxpP4LCRGXXeDS8U
	0hPfNdp2qRExlnv7cXXo8hmQ9Wi3I3h/Dg/uONUyq/GkkY15tQiZt
X-Received: by 2002:a05:622a:5e1b:b0:4b2:b6dd:3f62 with SMTP id d75a77b69052e-4b2b6dd4850mr141574701cf.15.1756333498281;
        Wed, 27 Aug 2025 15:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWL5d3fRji5RjCf7oZDMHi6+hAavouE1mTTu18gEHtzIXVQqcCSxTkltVNvjDodB9v6M14nQ==
X-Received: by 2002:a05:622a:5e1b:b0:4b2:b6dd:3f62 with SMTP id d75a77b69052e-4b2b6dd4850mr141574451cf.15.1756333497748;
        Wed, 27 Aug 2025 15:24:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35ca6af5sm2954613e87.138.2025.08.27.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:24:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:24:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com,
        stephen@radxa.com, cristian.ciocaltea@collabora.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh@kernel.org,
        sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Message-ID: <bochli5u37mhc6eup7h2oz3yeignofbbj4k5nrvm2k7zf6f4ov@t2sje4gmveqa>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
X-Proofpoint-GUID: Redsy2oEzVyqzOjDdkGUXFpXZH5dLhfh
X-Authority-Analysis: v=2.4 cv=CYoI5Krl c=1 sm=1 tr=0 ts=68af85bb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=s8YR1HE3AAAA:8 a=IMEu-sUR2OXSz8FBHAsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: Redsy2oEzVyqzOjDdkGUXFpXZH5dLhfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyOCBTYWx0ZWRfX5AXq4Dc6PJjj
 z+ystWbQqLCJgnbTB5Dk2zeLixXJFrPhYl/2NQZPAOIWCqcb1UKoFB7R/C230VFIO27HHbqacb0
 ewbdZRV/x9DxiC09bmSyCBXuqv8Mx+nmZSmCf6MOswEiM693BtZI8+CfxEGdqZB8xp9Wmho8l67
 zR0lp1q5helr9R1J6tVVzVr7e59e4b05zanq/+pbmrRiY7d1Tj/Nas/IM8q+tJQUnEva0777u+N
 6SDEu4Ae9L4RNkubFonbS51c6JzQKNNFHJyC8kZUBHpQKlzLULGrArqMqAcWuZWrxvmp1LL1dqD
 g4ZKB3WwID8dJf+w59Or4EDCW1ZcsBgKA4L8hjmB5yLiEKn5JPs++XEbLYaxqacfOE4n9UBzouW
 Lnal3nrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270128

On Fri, Aug 22, 2025 at 02:39:44PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> There are two DW DPTX based DisplayPort Controller on rk3588 which
> are compliant with the DisplayPort Specification Version 1.4 with
> the following features:
> 
> * DisplayPort 1.4a
> * Main Link: 1/2/4 lanes
> * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> * AUX channel 1Mbps
> * Single Stream Transport(SST)
> * Multistream Transport (MST)
> * Type-C support (alternate mode)
> * HDCP 2.2, HDCP 1.3
> * Supports up to 8/10 bits per color component
> * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> * Pixel clock up to 594MHz
> * I2S, SPDIF audio interface
> 
> The current version of this patch series only supports basic display outputs.
> I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C
> mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen and Piotr.
> HDCP and audio features remain unimplemented.
> For RK3588, it's only support SST, while in the upcoming RK3576, it can support
> MST output.
> 

[skipped changelog]

> 
> Andy Yan (10):
>   dt-bindings: display: rockchip: Add schema for RK3588 DPTX Controller
>   drm/bridge: synopsys: Add DW DPTX Controller support library
>   drm/rockchip: Add RK3588 DPTX output support
>   MAINTAINERS: Add entry for DW DPTX Controller bridge

I tried pushing patches 1-4, but got the following error:

dim: ERROR: 5a68dcf5837a ("MAINTAINERS: Add entry for DW DPTX Controller bridge"): Mandatory Maintainer Acked-by missing., aborting

I'm not sure how to handle MAINTAINERS changes (or whether it's fine for
me or not), so I will probably push patches 1-3 in a few days, if nobody
beats me (or unless somebody points out a correct process for
MAINTAINERS changes).

>   dt-bindings: display: simple-bridge: Add ra620 compatible
>   drm/bridge: simple-bridge: Add support for radxa ra620
>   arm64: dts: rockchip: Add DP0 for rk3588
>   arm64: dts: rockchip: Add DP1 for rk3588
>   arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
>   arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX
> 
>  .../display/bridge/simple-bridge.yaml         |    1 +
>  .../display/rockchip/rockchip,dw-dp.yaml      |  150 ++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   30 +
>  .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |   30 +
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   59 +
>  .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   37 +
>  drivers/gpu/drm/bridge/simple-bridge.c        |    5 +
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |    7 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c       | 2095 +++++++++++++++++
>  drivers/gpu/drm/rockchip/Kconfig              |    9 +
>  drivers/gpu/drm/rockchip/Makefile             |    1 +
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  150 ++
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
>  include/drm/bridge/dw_dp.h                    |   20 +
>  17 files changed, 2605 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
>  create mode 100644 drivers/gpu/drm/rockchip/dw_dp-rockchip.c
>  create mode 100644 include/drm/bridge/dw_dp.h
> 
> -- 
> 2.43.0
> 
> base-commit: 18b8261b84ad5462d7261617fbfa49d85d396fd9
> branch: rk3588-dp-upstream-v7
> 

-- 
With best wishes
Dmitry


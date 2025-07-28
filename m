Return-Path: <linux-kernel+bounces-747918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F3B13A38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A283B7770
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100B262FDB;
	Mon, 28 Jul 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/09t9if"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E91B412A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704321; cv=none; b=VxsB/MHFDsUckw4hFWqzW6NxKZKnAh/y7lkcLdaPNhzr0u7wVRk0wXwvjHtkVqU5tLukRti/Q/+bClZBJzNeR7T2KYx+QJYB4AzH/pKy2k20ZlWOCk3Nvfg3sSKjroEgVTC27D/QxIAgYqil/3EdlUtuuFbdtRcpIwJdYcO/xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704321; c=relaxed/simple;
	bh=k2RWxP/WKnsMkHTWmUDQ087InDb7cjcO9LVdeqkD0kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxMLUyqD/KaSymT2RJKuoFma6E99x//PjkJ+OGKxtKlsmrfF8YJ3vPVOTshqki8R0ssAokqrMNWXdfgLiuIRFXbrFwr7riuh0GmZYD4BkhCr79sA401/JXGay8dJV59fLzOICHeCusQ+/rblVpPiCC4fHXKmBaV16T/uY11w5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/09t9if; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlJvt012554
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MLMkHEXhcpE9zqxnDSOUT7LZ
	JSw53zS0jCgPn9nQ6+g=; b=O/09t9ifQZ5pb1vgPcIgB4ft+YBrnr3NSj2lG8HH
	POO+dTiTkFe87ThnmxxXAY/3hNC9AY/qkpFt9yOkTp9buD7tG5o4So5ilDJSiHcT
	IbrApJia0nx3Yk0fh44+TzLDPGuUEXrNKW49zlTd0lh5kq1A1y7H9wekO+TdyKCw
	gsdgObcQ0Khe1RgBrpY9SVIvkM+PpZOjdoX9noy6s5+Z9HqX5Q4VzEvm2G5ZQr0D
	Qkc1zYcO329+XCB6xDLDLN+4gf3uAmFy1Ngz9e1WwyYl/e0z7Pxn2c+C4bTiZOk/
	h5xJ6Tl/iUnBOO4Y2GtroCJiMPewTlVJ7tYkmCzsULqtww==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qd9vep3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:05:18 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-74127ea1e8aso1730233a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753704317; x=1754309117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLMkHEXhcpE9zqxnDSOUT7LZJSw53zS0jCgPn9nQ6+g=;
        b=BU7VgyUqw8YrZPf0cOAERevQ0z1SxH5tPZaWB+E7FKX0y0uwZLhmIiKyyPnZ1Zbq2X
         EnnWWMCKQBJZB17NqkpH9hsYhi0ys9IVSIt2glWvASlH0B79nq24cI/KXswBhxGsFAdh
         xZ2DK3BPgjrG5RhxZMmAu+oWzU9C5o9kBVQYEgJ36k8p+rJyAm+VvhmxPCQoETbY7V2u
         PpM+NOvfyQICc6OygevFqx/ULQSQHOLUo/1j19AB6yUp/P+yGxzPe7e9l5ofsfrv2Dxx
         pxkhMuyye+Zd67/1nWM2uM6yNxBrQdq5AMZ2moTnRbcqqgyRSKFUmzXVxEMO+NHz2Cm7
         3muw==
X-Forwarded-Encrypted: i=1; AJvYcCUO9lDVi84vL3jX1pZ1Eyhf250mdOoJYIxtNpgTBiUVL7zkh0bdQpPArPVA8FnmRP6fF+90jGrIUTtM9oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcVFrIF6aAv1I5vJf0xM8w4nhsvpqrZEmW7pjxnES9WLOwOVZ
	1ZAMW8X14FfGtom/tpEv0k13VZoNo10bOuo1rpgZrciKt6hNTiFdM4pzN2uMMRSS+clOOmsgQrO
	wBJkIgQvPTB4159bQLgPUswhBzBXDMEL880irfqoVMZRUSa9xBcPfO4ow9Qpq1xEPK7A=
X-Gm-Gg: ASbGncv2P+eZC92Vc3Q4ak8nOz27KH+0YaPyVpSN6xIzBTLW2XEdACDcDMbJKzo5c0s
	55sS1AGdouFX0GLJN3o06Yud4t67HH4xnSDjNzPF5b1P9R5BgsS0r2FxidzZV4o0wgz2H5MNfP8
	cy6LMfCc49xVYb/RIDKV2J4S3yDsaIy4YrUB8buLqPzmZu7APKWVdwUz23u1NQiSPJT4QN86tfR
	6OJxPly03MxIdVa42qIGYwokv860T2Nebz0dBo+ufp5IOtdsGcctwPmAodk+SCuv01mgAyYT24r
	sewQrgbaxtM2tKeZ1af+C4qjTu8HU1m/XtzRZB4cpE6NBhtNSPqCGS3NYyrdEQRa7jul8FnQEX1
	WcsKGV8Ylp+wirUzCqx8/jpqb8Mhc3UFYY2rIPpVdYPTJ8kwCccE6
X-Received: by 2002:a05:6808:1511:b0:3f9:2fdc:ee93 with SMTP id 5614622812f47-42bba1f2b8amr5993478b6e.30.1753704317197;
        Mon, 28 Jul 2025 05:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSfeWv4VHXW2+zlLwrnah8CuiseIJTrikxH8XMRdQkuCbQ7xwR1kFZq9NS64k4Bn807RS+w==
X-Received: by 2002:a05:6808:1511:b0:3f9:2fdc:ee93 with SMTP id 5614622812f47-42bba1f2b8amr5993452b6e.30.1753704316668;
        Mon, 28 Jul 2025 05:05:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63375932sm1240730e87.152.2025.07.28.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:05:15 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:05:14 +0300
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
Subject: Re: [PATCH v6 02/10] drm/bridge: synopsys: Add DW DPTX Controller
 support library
Message-ID: <soz3wrbwlogzv6pi7i2cf5iq5gxhspkrti3pcxn5cdhztghwww@xxcdbp2n5cvq>
References: <20250728082846.3811429-1-andyshrk@163.com>
 <20250728082846.3811429-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728082846.3811429-3-andyshrk@163.com>
X-Proofpoint-ORIG-GUID: KWVHrO_6yyMovpUFwxrM5-YQrVRMlR7k
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=6887677e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=rZy2__OW2t70H_ViVZ0A:9
 a=CjuIK1q_8ugA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: KWVHrO_6yyMovpUFwxrM5-YQrVRMlR7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4NyBTYWx0ZWRfX0YghVOI15s0q
 8CIyZEQ89cKdTCzKJz3nnLXxaQpEkIqdhy7y7F5ias67CNDOMFUS1e5cr+gAkfM+NQRd/RVnmap
 B0nNHDj1ZohJr33lRXP1LD7MfAtsERuJ+BBSUoE9VFB9fEgzAJzLCggmcvE3t+0hPhq/LJ63DRa
 9F8TduvR7RONJ/3tVnEA1REv064BSWKa0aNvcGLPF52UAVRUa8nLaf4claq9M9xYqtmfOJaBdq7
 ujrrjA1OVzIwG3lsSLkze2zJaZ4/9jV/kkNp502Hz+3VVaCE3wEC7N8tOYBqk8Gdxvr83QjLdIZ
 BlAVIvEjQJrAE45V0J7HyaqlzV8hYlGyOY2OgQhynrg4lC2Ui/IHtO/j3T60MP9a8yrHbiLJBOL
 tGBMpf6tUCwPxMKUN0gzYR/nM2K3eARYUcaLm9pspO2ZlgRJvpjZYYj9dB1fsTmhbf21BRzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280087

On Mon, Jul 28, 2025 at 04:28:27PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The DW DP TX Controller is compliant with the DisplayPort Specification
> Version 1.4 with the following features:
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
> Add library with common helpers to make it can be shared with
> other SoC.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v6:
> - Use drm_dp_vsc_sdp_supported
> - Store bpc/bpp/color format in dw_dp_bridge_state
> 
> Changes in v5:
> - Use drm_dp_read_sink_count_cap instead of the private implementation.
> 
> Changes in v4:
> - Drop unnecessary header files
> - Switch to devm_drm_bridge_alloc
> 
> Changes in v3:
> - Rebase on drm-misc-next
> - Switch to common helpers to power up/down dp link
> - Only pass parameters to phy that should be set
> 
> Changes in v2:
> - Fix compile error when build as module
> - Add phy init
> - Only use one dw_dp_link_train_set
> - inline dw_dp_phy_update_vs_emph
> - Use dp_sdp
> - Check return value of drm_modeset_lock
> - Merge code in atomic_pre_enable/mode_fixup to atomic_check
> - Return NULL if can't find a supported output format
> - Fix max_link_rate from plat_data
> 
>  drivers/gpu/drm/bridge/synopsys/Kconfig  |    7 +
>  drivers/gpu/drm/bridge/synopsys/Makefile |    1 +
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c  | 2094 ++++++++++++++++++++++
>  include/drm/bridge/dw_dp.h               |   20 +
>  4 files changed, 2122 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
>  create mode 100644 include/drm/bridge/dw_dp.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


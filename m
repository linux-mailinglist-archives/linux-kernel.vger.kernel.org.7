Return-Path: <linux-kernel+bounces-779655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A4B2F6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8856C1884D72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017327A44C;
	Thu, 21 Aug 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auUqoMJt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44369235BE2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776168; cv=none; b=VPhS60sjw5efPE22Poge8FytjaMj9XgPAN4U9T63AVA2XcRui/s8E5XEhuJDR1IcQl/1w9XXnemUy4iZ1tnDOMGFeAbKw2sUNbA7Sn31mOHQ5fPuPazWOtVKr/M/zurLY0ujqtX1yRGK7Yg/NruSCB8m85GfKjIzArVSA2cqaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776168; c=relaxed/simple;
	bh=Hxq+DsHvjsVBfTK9cHrubL7B4n2252MB6U6ttmFGFsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRozo08bxmX3lTTvMQ1RIR+7oJ4vVqRHdZmo3jVfobBDO1O3UBlmgZGDH7pxKqvOhJXH5PFL1IXzz/t9vwIUKWsZ3+Gp0rkhzX45tAjLz2J4eAjvuGGxnMNTC+so+wuy5KAMWDDnOC/Vf0Q0Tah1OB65CHa641LYSDirzIubvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auUqoMJt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCh5012935
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QSQPNWnbfGMjtFsswklhwMt+
	AzX+p4AHQ+dhdCLnYmM=; b=auUqoMJt+D//FknRYaolesGqAYaEt5Tz3jg+EHch
	9b0piKRxqxIqGLH1kyAu5UXmU8AIysXLWOi/wpGYGrobrr5IGLyf5wMxnt37fAkh
	FL+5OKPACmP1/CZju4gVkVn2DDVwVNQQj1xA3ETm73N1U61KvQ5eY4pfZ1uHRdTw
	F2p3b00a2ju7IJZzA31CMwE1kLpzAZTxYQvzA0IxFSX/PFubJHiiBSmRT1UJrVL4
	dkfBd45/1fbd2Wc8e5Rl4F+LALxGfZxVEoDJKI7VhwJ6OR33coeZ2VORvu8qZgVV
	Y+2r//Z3ycuHWMe10ShnG4nL3raLqC4bIlsPS/K66gaBSg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dn5st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:36:05 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d93f57c42so2487746d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776165; x=1756380965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSQPNWnbfGMjtFsswklhwMt+AzX+p4AHQ+dhdCLnYmM=;
        b=Vyb+KaIVJqQNlYdGA4dgMlrQgpIfAB78OQf9T/Hub/KP3nOb5ozbqI43Qyd6NDtik5
         9HXHYQUXlFIC87y0d9o2cPH02pOX/BHKlCoVicBK6QDktsrfGNpG+ZLBH1JUsaw17+B2
         c4B0qDdLvkZ7STsdJXDmJYRRCHjF4ctlCKR9Xw3wwAdAWUCyiDxt248S8rbUAwiX+aex
         kjr5RiqbioerB7wIVc93IM9Rc3JRqhcqWBHE8p6APIkoyvMJhXdxttbjYhvSpcTAOOZT
         0CSOt0bG4ODRSsSPr3pa1FXxIr03Q50gq/a9OporIf3mHI4UEZi93Q4to+I48bFp8Mvs
         35wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy1V7Zce9RVtFTb9CJYLb63Q2DhJyPN5CHeAuahG2FQS1gHsRM17+qSJ604A9PPuOL9RICKiM/R0p2L+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLY6j5/HfAU74p/cfMjMYMl31C7KHgKFplCMAw+YT9gPB+/QjR
	gLH5NemyjTHe4Q2sHRIQqKldUcgYCySv3XLEJzxciHCaU4KueOsAQ2wxjfOaLlScFEznA3FkzNS
	SS1P2bCJhTNB+Z22LAJGbAjr4dfWBp2U4/B88VGor9ug9Porxc9xo04640ERFsv4vHog=
X-Gm-Gg: ASbGncs1qrjnV+Hmw8HjsVs11E7q1F+iUjRosNfruT+saSKCxwND1bDZIFIFraZkGn5
	1KSuTYnHMoP4ckWYNYZYoEohlDNmd0xWh5sTZBA4Lyognm6U9vejy9Hv+a0Q04oKD2/WcRWezIr
	Jj4nmARkLgNYYFUrPSpfK50mFpwCGuAQplHlOc74n25UWR5aT2DleFOsMLQB5ILsB6+lbS96kLG
	QzNU1HWNVROGCnDZKNET7eOjXprX/M/FNNeJQlDOh9aksQZz9h98sOAiBfe6HBqnWfjvH2SzyGg
	Y1K86TBQ03FZYA16bUUwzpxNojduHjlrwjhKBByfjBTJxbzuUFz3MgMkqZUHf7ke+efN39/3vI3
	3ip3jxDViIhUTrKiaQUVbm6RgGuTlZ6+BfdQiLJygZ+Eu0FC0pnA+
X-Received: by 2002:a05:6214:4103:b0:709:edff:dcc1 with SMTP id 6a1803df08f44-70d88ed709cmr15854406d6.29.1755776164921;
        Thu, 21 Aug 2025 04:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdXhyG9Fflih5ryMZ3T7Ocp2qP4o+AYrv/JF7jOHWIB/TtXYveUPhTv4cTKVkorOvFjzpomA==
X-Received: by 2002:a05:6214:4103:b0:709:edff:dcc1 with SMTP id 6a1803df08f44-70d88ed709cmr15853846d6.29.1755776164125;
        Thu, 21 Aug 2025 04:36:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca00sm3100617e87.93.2025.08.21.04.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:36:03 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:36:01 +0300
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
Subject: Re: [PATCH v6 00/10] Add support for RK3588 DisplayPort Controller
Message-ID: <7omsdz6hjhpmzi7a2meem64dm2jrxhivczt3gdi24jyrp5lgjp@iucsgwqtjqzc>
References: <20250728082846.3811429-1-andyshrk@163.com>
 <1ebeae81.8b20.198cc3ac94a.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebeae81.8b20.198cc3ac94a.Coremail.andyshrk@163.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxgsD9kFBmZqM
 IHt+C9Dp2vA0wyO4HdD1QFjcScv9NApcP9GoqJEWH0JvIdzDQvHGwcY6k4yOCshQIx/r8b1qaiy
 Zs/HMFyG5vu3SfeoKkc/LUccpzDaKgHEwb6DRHAJxOFopsBBgWPyF1Nx1Ob19q6VG/RVG4tHfyy
 oEffPom5tWCGqo7r1uZ/h3IVL5e2APh/IZOF37Jhbx4m3ZPYMPgZqxRaaP2GA1GThzAWZCkmtgC
 2FZFbwVupwVRpWMmMDIx4ww8fWU1ZRmqMMRUVNvZ5mQY/OVXu6B/pk7NK1LDlRiy7NvrQjUMXLM
 cfGkbrengrvspoI2fafFw7QLs+0C3GQ4UNGgsw7yf+s+Iu9l+xyzthayHgqdrROLTnKCsQoTZBI
 ZF4x9JdFK8dzmkw9rUkEjvAuYPL+tA==
X-Proofpoint-ORIG-GUID: AzQu2YJ50-0XBKRc06zYN25cV_b_5tUh
X-Proofpoint-GUID: AzQu2YJ50-0XBKRc06zYN25cV_b_5tUh
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a704a6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=s8YR1HE3AAAA:8
 a=G_1y2J3ZIfkuVtfR3FMA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 06:44:21PM +0800, Andy Yan wrote:
> 
> 
> Hello Dmitry,
>     
> 
> At 2025-07-28 16:28:25, "Andy Yan" <andyshrk@163.com> wrote:
> >From: Andy Yan <andy.yan@rock-chips.com>
> >
> >
> >There are two DW DPTX based DisplayPort Controller on rk3588 which
> >are compliant with the DisplayPort Specification Version 1.4 with
> >the following features:
> >
> >* DisplayPort 1.4a
> >* Main Link: 1/2/4 lanes
> >* Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> >* AUX channel 1Mbps
> >* Single Stream Transport(SST)
> >* Multistream Transport (MST)
> >* Type-C support (alternate mode)
> >* HDCP 2.2, HDCP 1.3
> >* Supports up to 8/10 bits per color component
> >* Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> >* Pixel clock up to 594MHz
> >* I2S, SPDIF audio interface
> >
> >The current version of this patch series only supports basic display outputs.
> >I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C
> >mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen and Piotr.
> >HDCP and audio features remain unimplemented.
> >For RK3588, it's only support SST, while in the upcoming RK3576, it can support
> >MST output.
> 
> 
> 
>  Could you take this series? It would be nice if they could land Linux 6.18.

dim checkpatch complains about the DW library patch:


-:385: CHECK:UNCOMMENTED_DEFINITION: struct mutex definition without comment
#385: FILE: drivers/gpu/drm/bridge/synopsys/dw-dp.c:323:
+	struct mutex irq_lock;

-:819: CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'v != adj->voltage_swing[i]'
#819: FILE: drivers/gpu/drm/bridge/synopsys/dw-dp.c:757:
+		if ((v != adj->voltage_swing[i]) || (p != adj->pre_emphasis[i]))

-:819: CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'p != adj->pre_emphasis[i]'
#819: FILE: drivers/gpu/drm/bridge/synopsys/dw-dp.c:757:
+		if ((v != adj->voltage_swing[i]) || (p != adj->pre_emphasis[i]))

-:1754: CHECK:USLEEP_RANGE: usleep_range is preferred over udelay; see function description of usleep_range() and udelay().
#1754: FILE: drivers/gpu/drm/bridge/synopsys/dw-dp.c:1692:
+	udelay(10);

Could you please take a look and fix those?

> 
> 
> >
> >
> >Changes in v6:
> >- Use drm_dp_vsc_sdp_supported
> >- Store bpc/bpp/color format in dw_dp_bridge_state
> >- Collect Reviewed-by tags
> >- Link to V5: https://lore.kernel.org/linux-rockchip/20250716100440.816351-1-andyshrk@163.com/
> >
> >Changes in v5:
> >- Use drm_dp_read_sink_count_cap instead of the private implementation.
> >- First included in this version.
> >- Link to V4: https://lore.kernel.org/linux-rockchip/20250619063900.700491-1-andyshrk@163.com/
> >
> >Changes in v4:
> >- Drop unnecessary header files
> >- Switch to devm_drm_bridge_alloc
> >- Drop unused function
> >- Add platform_set_drvdata
> >- Link to V3: https://lore.kernel.org/linux-rockchip/20250403033748.245007-1-andyshrk@163.com/
> >
> >
> >Changes in v3:
> >- Rebase on drm-misc-next
> >- Switch to common helpers to power up/down dp link
> >- Only pass parameters to phy that should be set
> >- First introduced in this version.
> >- First introduced in this version.
> >- Add RA620 into bridge chain.
> >- Link to V2: https://lore.kernel.org/linux-rockchip/20250312104214.525242-1-andyshrk@163.com/
> >
> >Changes in v2:
> >- Fix a character encoding issue
> >- Fix compile error when build as module
> >- Add phy init
> >- Only use one dw_dp_link_train_set
> >- inline dw_dp_phy_update_vs_emph
> >- Use dp_sdp
> >- Check return value of drm_modeset_lock
> >- Merge code in atomic_pre_enable/mode_fixup to atomic_check
> >- Return NULL if can't find a supported output format
> >- Fix max_link_rate from plat_data
> >- no include uapi path
> >- switch to drmm_encoder_init
> >- Sort in alphabetical order
> >- Link to V1: https://lore.kernel.org/linux-rockchip/20250223113036.74252-1-andyshrk@163.com/
> >
> >Andy Yan (10):
> >  dt-bindings: display: rockchip: Add schema for RK3588 DPTX Controller
> >  drm/bridge: synopsys: Add DW DPTX Controller support library
> >  drm/rockchip: Add RK3588 DPTX output support
> >  MAINTAINERS: Add entry for DW DPTX Controller bridge
> >  dt-bindings: display: simple-bridge: Add ra620 compatible
> >  drm/birdge: simple-bridge: Add support for radxa ra620
> >  arm64: dts: rockchip: Add DP0 for rk3588
> >  arm64: dts: rockchip: Add DP1 for rk3588
> >  arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
> >  arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX
> >
> > .../display/bridge/simple-bridge.yaml         |    1 +
> > .../display/rockchip/rockchip,dw-dp.yaml      |  150 ++
> > MAINTAINERS                                   |    8 +
> > arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   30 +
> > .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |   30 +
> > .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   59 +
> > .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   37 +
> > drivers/gpu/drm/bridge/simple-bridge.c        |    5 +
> > drivers/gpu/drm/bridge/synopsys/Kconfig       |    7 +
> > drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
> > drivers/gpu/drm/bridge/synopsys/dw-dp.c       | 2094 +++++++++++++++++
> > drivers/gpu/drm/rockchip/Kconfig              |    9 +
> > drivers/gpu/drm/rockchip/Makefile             |    1 +
> > drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  150 ++
> > drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    1 +
> > drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
> > include/drm/bridge/dw_dp.h                    |   20 +
> > 17 files changed, 2604 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> > create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > create mode 100644 drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> > create mode 100644 include/drm/bridge/dw_dp.h
> >
> >-- 
> >2.43.0
> >

-- 
With best wishes
Dmitry


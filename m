Return-Path: <linux-kernel+bounces-745944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54507B120C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8F1C83F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82777111;
	Fri, 25 Jul 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATzB3/mc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B71A840A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456985; cv=none; b=WvidyzYSsLXE/s5Z7IL3BSQJZVv7YzLVC9YUlTS2KFkS5TFzFnjnGDeO/otH2fUmlA3fM0tlw4U7QiB7l0VelHMgyU5SRqFmHIzlqYt886LFTIR+UU1vyLSwq7mUx5RxAOhyGeY89ySZZ0GtNsS8nqz9QEHPtSfzt7OZ0P8OySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456985; c=relaxed/simple;
	bh=JjfQEpEcDJYlL8sZrWJ4hNkuZZvv9FQs9CUKa4SDujI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naCwE1aJdxdW9F6CaXJlPdO/XGM5I/OVDqvg7Xn/8MVzw51dRY+lzucKR61eTVJ0twIdlF4M/Jkp1+NRvsI0eVUlq+q6RPy5I4slm+XJq43OAh5iB8XTtpbync7M0EGcJ6wHjapGD0DzVKBdE89hrrgpZOeEbPYRfH/PLZDq890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ATzB3/mc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAXLWo000586
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eTjMO6ThCzwsibq1lFHZiZoZ
	coN7Cs449c4GQQHgyao=; b=ATzB3/mcmVV/zkia8P/vSXPv93q3nC5wTBFv+1r/
	5uWPW6GrxvL87y7HUByOa2Ttbk4hL7YBaSfy+DxR6b6lUfj0hX5m1kZvmc5AvxO0
	AMpk2yriLI+GTqVwMWwKvaLrL9SlYgnNF8fnqP85/fwYXqQM2c9y+m0xSD27g1mf
	qn4ZuW6BvJd25PDtjqTvkXpYWx1twdBna5bVHpx/j7zs+shz3AksF8RMdWsOFnFS
	YA5sstgBn4/XGQR4x7ZwuLRDg/bKcxtdrpcybdIgzboAZ3w17aki59yy5mP/qni2
	EalIrVPMU2SqA1ni43Fo7HJRtYrOo/20XSu3gg/hmb1jNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4848970sp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:23:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6face45b58dso34443016d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456981; x=1754061781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTjMO6ThCzwsibq1lFHZiZoZcoN7Cs449c4GQQHgyao=;
        b=Hel0REH0HRyZn+/oCQf9xbs785O4SD//K6wuNLO/oX7HaBb+5gyg3QsDIyXG8VWBI5
         GqPeHuCGxyPr2hdgecXUYyGzC3mTAd77fBfdipYu31KN2BsE25l75BaEhOPIHA22Qdne
         9kLqnLVzcFwmjol3XT1txpOGYCEuym/b/hXHd4evranmxJIUVaQMuRvS2SJwKEg7tEbQ
         iVWDycVVnHElWqo6d91hdr5al47KgJkPBT6tK32VuOcVPFtFmEjvSD+LR5jPc8e9YJUx
         D2VzpV0XZ++JJ3tMG1z0S6MZg2hXkJ6bBkAuW6OOgJQpjr5wBYQRpPMIAoWgbuOB3F7A
         DncQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYoViyCI380mU7at6sU1arHPCKhqsACJp4JNcic/HeXZJ9M75FtZqpADU40zfSD+/iUkbqRPN94cTr9HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBr5rW93WVkzrBEcEU0gUWtCtrTNOf1UVTCWc89+MX8XOttyae
	OFI2HeQjADx3AfE36zgtgvCOECk0Y/SkwYKdodUheaHMWVuNnyVCtFC9Grxw+xDCQ8OCjOyu7sL
	bEUfpG9xrmZNMzIF9cqb+BDWT/pjvJlOV6hqw874wJWB4oBmDC0mB0cbhDFLVxgf9XPo=
X-Gm-Gg: ASbGncthDZsWU4DulmoqnvlpSPWJxcuQ4DpBh5Rrvh2DcByMawN+IAf5hB7dwOXy7dL
	0i47Z21gd+8tDObOCgNev3f1ZbkaXD6hC3qBP1h2dBunyZG6KQrKdXfcXF97ziszu4CYyd0ckV2
	dorOTd7WvjuNel0ioRjMZ1ChUimPoEHpye/N3zo8GqjTN2AngtImwS9IwWBqbSX3QCgDn4L1Ius
	jzT7k79TC6+iDXF8ARL5njbl7huSVNqR7l1m1SEYPl998KKnVQd08TQ8DJ3UtOWb09iTedK9SQu
	Pa23FHgl4uJkzbDA7IFoj5oJjvnxR6Xk2rtkLl7e7SQYdi18f5yAIB0dYcpWjjWubzrY+j+CKtP
	LsokCrEMgQi2BLWBd04ZCK6qP4HQgEbgd9sCg5O/BwE5zkWAsieLD
X-Received: by 2002:a05:6214:1cc9:b0:705:538:65ab with SMTP id 6a1803df08f44-707205ea86cmr34752166d6.39.1753456980763;
        Fri, 25 Jul 2025 08:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5LDQ3JiR87dSBEdbMLaQa7N1rf2mWwVfPEnOCbZ2F/UBqPcJrWvG8vZus18ZIxSK6RRVlQ==
X-Received: by 2002:a05:6214:1cc9:b0:705:538:65ab with SMTP id 6a1803df08f44-707205ea86cmr34751036d6.39.1753456979758;
        Fri, 25 Jul 2025 08:22:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6336355dsm8672e87.86.2025.07.25.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:22:57 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:22:55 +0300
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
Subject: Re: [PATCH v5 02/10] drm/bridge: synopsys: Add DW DPTX Controller
 support library
Message-ID: <svn2p46qguxrpn6fhqnjffqpgv7keabwgld53uw6ckkn4piu47@gedy4t22cqfx>
References: <20250716100440.816351-1-andyshrk@163.com>
 <20250716100440.816351-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100440.816351-3-andyshrk@163.com>
X-Proofpoint-GUID: 2phtBXxpKdvgFB6EhTt0D1MkCRvrVuej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzMiBTYWx0ZWRfX+QpUdrtYp9io
 h1rGzpyz8eOUGp2Qr2cbvJqetS+J4nQHv7XLtXn2nhCoyb3AfLtYmbFjbFWG+X56E2LgQNZFG4H
 0H/AcyJ7n3LaKba2n4zaTR71QDxukZyu6AdITPkGSGlKuZMnrPItt3EclnKPVWWxIOLz2xabu9v
 tma5ZscDxi9hpW0M2q+1lZytaVcNTcr+OwRvp8aHxflSsJ/DV+nkMNrnigvh0i8j1lFAZ1QoPcU
 HMQRJ42sdSM7dmVf24nA91o6YDNk7vw6gFLb8rSCf8dll9b7zse9BEkOAl55gqNcpZ3w3iNmsHM
 PjJNU47uFOICdrBYPxfBfOPeE7hRmGbQMLdw3l4ILQGn+JiydZwDI2IZnDKLRTjS7S+GUW5NAIo
 faEOBOnRrUkKVRkkfic/Rdw5I/eDiYJ/QKqZ96aEEeUAYYPe7g41bIsq/ypR4CShjY3M7/H4
X-Authority-Analysis: v=2.4 cv=VJjdn8PX c=1 sm=1 tr=0 ts=6883a156 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=w3-XvOWwJNVOjCSRI-QA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 2phtBXxpKdvgFB6EhTt0D1MkCRvrVuej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250132

On Wed, Jul 16, 2025 at 06:04:29PM +0800, Andy Yan wrote:
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
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c  | 2044 ++++++++++++++++++++++
>  include/drm/bridge/dw_dp.h               |   20 +
>  4 files changed, 2072 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
>  create mode 100644 include/drm/bridge/dw_dp.h
> +
> +static int dw_dp_link_parse(struct dw_dp *dp, struct drm_connector *connector)
> +{
> +	struct dw_dp_link *link = &dp->link;
> +	u8 dpcd;
> +	int ret;
> +
> +	dw_dp_link_reset(link);
> +
> +	ret = drm_dp_read_dpcd_caps(&dp->aux, link->dpcd);
> +	if (ret < 0)
> +		return ret;
> +
> +	drm_dp_read_desc(&dp->aux, &link->desc, drm_dp_is_branch(link->dpcd));
> +
> +	if (drm_dp_read_sink_count_cap(connector, link->dpcd, &link->desc)) {
> +		ret = drm_dp_read_sink_count(&dp->aux);
> +		if (ret < 0)
> +			return ret;
> +
> +		link->sink_count = ret;
> +
> +		/* Dongle connected, but no display */
> +		if (!link->sink_count)
> +			return -ENODEV;
> +	}
> +
> +	ret = drm_dp_dpcd_readb(&dp->aux, DP_DPRX_FEATURE_ENUMERATION_LIST, &dpcd);
> +	if (ret < 0)
> +		return ret;
> +
> +	link->vsc_sdp_supported = !!(dpcd & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);


drm_dp_vsc_sdp_supported()

> +
> +	link->revision = link->dpcd[DP_DPCD_REV];
> +	link->rate = min_t(u32, min(dp->plat_data.max_link_rate,
> +				    dp->phy->attrs.max_link_rate * 100),
> +			   drm_dp_max_link_rate(link->dpcd));
> +	link->lanes = min_t(u8, phy_get_bus_width(dp->phy),
> +			    drm_dp_max_lane_count(link->dpcd));
> +
> +	link->caps.enhanced_framing = drm_dp_enhanced_frame_cap(link->dpcd);
> +	link->caps.tps3_supported = drm_dp_tps3_supported(link->dpcd);
> +	link->caps.tps4_supported = drm_dp_tps4_supported(link->dpcd);
> +	link->caps.fast_training = drm_dp_fast_training_cap(link->dpcd);
> +	link->caps.channel_coding = drm_dp_channel_coding_supported(link->dpcd);
> +	link->caps.ssc = !!(link->dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5);
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry


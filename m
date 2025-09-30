Return-Path: <linux-kernel+bounces-838134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DEBAE84A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576B13C509F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56B241663;
	Tue, 30 Sep 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KC4LMGSI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C219F40B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263511; cv=none; b=ssvkZ2plvHL38HH4XLvFKHpaauM6vZkhHA/hkUufh+G1cDTOaugoNDa7rSFWZ4JfrOxEQ/g+jCD9O2YXqe6/SFZEXebE4JFUSGIsOJ7QTkFEXPaVcoBU8P/e4vXWEyzQxIcdrchrQitdi0p6idn9VDg3i7Qx25HSzL3getkjIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263511; c=relaxed/simple;
	bh=19Hz00kX8MN/UwLgGZs3ik+Bv4UHYCuYG/rd08f8cyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbvySindsCIlcFhuDoKoN+23caehl/UNjAj0G3aOPdeTfXYLDX1e9A6To5WIpTbXbB2B6nRuaC9kJbHpi+evoETE0/n5RXBfBJd6s/2vDUlMlF2xpF4PMylmyH7k8i+R5rbBDo0+4hP9n3LMND2L0S1s4IGSYLBdcT97gz/5pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KC4LMGSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKE4R2027384
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n8MgadJhrhV1HSlrIC9UJrgh
	Bv6+bn6nyOEgzE424I4=; b=KC4LMGSI/MkfGts/Zkvpo++UDTVu6cGxuLJRMZN6
	B3V3ISoLz+WZKqAOjUMg1ITb///6JCiV70XD/NnyJP4qb8hEt23JcKTMhFQlytzk
	WFRy4OOmGC+cv2PTMqMUgxUVX+O4B41wIOhjLvHhgRZrJZqg47a31LzD9X6TSHwx
	66AqZTneRJW3OwKZZGG1tMul6aPdINuXo220OJlxMO3cLlRixLKH09JCmuddVpKQ
	XaH+Du6KXizvQnTqc5ct2MX+9rfjAf42liLu+8BTrYS0AOO/iR2rEEwzsalGWn0P
	YQE10RDlZZ01gGBQiahlpcF2hMToLxvPI72MqumAKq9Fmw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851ja6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d6a41b5b66so163533051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263508; x=1759868308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8MgadJhrhV1HSlrIC9UJrghBv6+bn6nyOEgzE424I4=;
        b=bWKt4V+Tb0qzzAlpYaUUT7DRgiihAE89Tm/vAgBBXVRlTuihYJ8AkPq4MiBICdjK7x
         uGZH5w5NhjgLqot6RlzCHznEAP9w8svkN1TX/F2+PtlxFgcKznodbHVf6WgaOD+KoW+6
         YwLhOCUApsqUkGDoOJqfLw1Ac7zeCuf8mfDUgaqsKxRkCEz5NWm75BOtCXHX0zuYcOo8
         i1cX65KzEjmb81nPuclzOowUPHak4sjhiRO79lz0kIDKOc1ClRlcTcoMMb36/DSATL7D
         oNn3+QJVuBJSFRXASbIND0mND1XcD/Q9yvDlhVchS91UB/9xW0p/oriJEkaTU1Ffek8U
         rxAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMhZku2gJcxNwLfiqRqUCI50WUF8pLc8BmfUFzo/sBr2I0sut2PT1bnMtQRaT/f8vnc0afhOEtBvFkV0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lpa+5Y3Ty6P/qhswG35B7gqVaGJ7VLdZCfzRX2NNe/tYkJXk
	QObmToWecq/NsWm7DTpaVk8EeueCoA6lvwAVLaluLP0qlbmvo2E1vep/lzNIUsA85t98ZNx2sjv
	ev0GpfHjl9keasOkhSLSEYoyqpRmz+pvHzpsI9ThFPXaq+YYaKlEzePP83w9FrJD7zzE=
X-Gm-Gg: ASbGncurpnWMxkIVfO1xOuUW5LyXIvtTVDVjhtCwTJCE7gpOLrs7KaFNU9LHow+9qB1
	cC7fEOSotmy3xfBdso9tGjUXDVJv8nDL7itpqWiH4zf3LZ0y+rWK+ue6NZMYhg2c1jI74d3Ffr/
	MW/yYfRoMSfD1s3Emwej1eoqr9lKGEiUYN3MWQ1y0zM1bYhYiz0aO4MiH11a1pEZMIn8WGfZXth
	GLNvznsFcTU+Dxl1XY9ANYEJS6562RIkNRFDOhoxCQIrCMLU7KCbnrGWtPjwmsxo8qlxzbe3Z/q
	PxIAY5CoyE3gE2cAjI6xD+YYMIfG2gt2MpJugUSUx871PiTps3w8h3liCS6uLCPIv5mzpmKLgUR
	bn8rRZcSvJYXjG+7q0/5HEbwgTRTL7hpHxRpb1hwCmJNvNHm37TbJqAUe9g==
X-Received: by 2002:ac8:594d:0:b0:4d9:1d03:83c9 with SMTP id d75a77b69052e-4e41c733801mr12497591cf.25.1759263507541;
        Tue, 30 Sep 2025 13:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETZ6omCmx9fZgdyWrCa0U77D6Uv9hU6fSO42h/F5hPLOdENOJ0bn/O6k9+KhYjIKci/Pfe9A==
X-Received: by 2002:ac8:594d:0:b0:4d9:1d03:83c9 with SMTP id d75a77b69052e-4e41c733801mr12496841cf.25.1759263506980;
        Tue, 30 Sep 2025 13:18:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316ff5bafsm5186157e87.136.2025.09.30.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:18:24 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:18:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
        dianders@chromium.org, m.szyprowski@samsung.com,
        luca.ceresoli@bootlin.com, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 09/18] drm/bridge: analogix_dp: Move the color format
 check to .atomic_check() for Rockchip platforms
Message-ID: <5ed4lpdjqru6fbjl5ulaqdex7kppk7bsze2hv37mzgq3c22qir@2srh3jc7sqnf>
References: <20250930090920.131094-1-damon.ding@rock-chips.com>
 <20250930090920.131094-10-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930090920.131094-10-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dc3b15 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=0r3lTzsetTvyPaIB0MAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX8Sw28nQCBrTq
 RrNzh4YbAhpdQIXiGKNq2ntZAf1wJW1ooZbXvoGI8U3IhApsdj/8qzEZyX4KB5JUe+O9tGM5USe
 MqlTB8j606TG/d/lIwWHAHGYBal95C3fDyF11Bs68qw6MuMjcUXw+YZeT9tMnz1BD6Ac1Nw1OJJ
 dnAQKiq+b4cg7uv7A04IyuS5TAf8Fdf8GLY9VS8IzOYvzjSY7zfQowp8P5O/+Mrmk4Wo6QZWkl6
 dWbVgUeVIK9kfeMSkYq/tE5AA7aP2E3R/mu173FKEITqCr1FfWHhh+4LwG5KASgdeEaTxE763nK
 FFLh19RbuwZchuzygGY4mWI8Laww+YLfPc0tvHdgjPf87VljaU5QT5p0BJNm+yrJ9vqmcIthuig
 zka5Y0LCBDJH+P1IQTxW3kqw7MSgig==
X-Proofpoint-ORIG-GUID: o7_kZe5lwuFzsx-0v__z_vof8jKyV8Ht
X-Proofpoint-GUID: o7_kZe5lwuFzsx-0v__z_vof8jKyV8Ht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Tue, Sep 30, 2025 at 05:09:11PM +0800, Damon Ding wrote:
> For Rockchip platforms, the YUV color formats are currently unsupported.
> This compatibility check was previously implemented in
> &analogix_dp_plat_data.get_modes().
> 
> Moving color format check to &drm_connector_helper_funcs.atomic_check()
> would get rid of &analogix_dp_plat_data.get_modes() and be more
> reasonable than before.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c    | 18 ------------------
>  2 files changed, 11 insertions(+), 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


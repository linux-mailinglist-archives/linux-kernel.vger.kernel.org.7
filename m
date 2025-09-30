Return-Path: <linux-kernel+bounces-838125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14050BAE7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C93251D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91612857C7;
	Tue, 30 Sep 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffJrJ0PS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F082773FB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263018; cv=none; b=YWcYDncjju7T2brrP5FyY1gASsbyC0IrA6BncSBQlkztyh+Q3r3sgqhTFC04M6gMKK/BgusY0ohzsV2rR8HIh4TiP/DFyCsaQYEffudLgDtquSYlrn4ldxQEOyOTEX7GhT708xljCafu3X69H5iq/KJiQaPy3kPy2d62pTdILYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263018; c=relaxed/simple;
	bh=B13kSDZYJQFkU0t1zC9c3G3HWldP0y99UADm4IFZCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q53exqFhxLQT9qSSca2qj9QGvldcQJWYAlj1KY9T8zCw4HbzV2OKUwk9k/AK8O62I6knibvsbFGmcoSfc/z+LT13TmMIMUbyxqE48GwjWNKFTa2podj/B5wi7/67Bn3UIy4hBPKhqWBy7ralpRfI9hd6ldVtxHvH5bDqZA6i5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffJrJ0PS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBm6E5010694
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HUh15XTlHhQ6Q1q/DhGrQFrr
	yiPIaucH02PqHMC1azU=; b=ffJrJ0PSTxvIAskznd1HN89PYvrtK1jPtX4SKcyO
	n9M360aQdp97l/HD2LB0hM7I3AIBClvyVjFNX4Pe/4gDkw4p9PlD04eunPSwsfaU
	bBZ2YMmmJnJdJ/GcYahlQn8cIUTUvbx1ueAUfOYhx8IYeK88/xQZh9o48wuAIdXR
	ijxVM3znvZbccrA6V9xUPuFJsIrCrN59afxk7F0fEZttLODdeHJQTFWQBJf6Bxa5
	gtEUZJv9MH7ZwXBQq/ay7K9XBo1P0u8OSz4pSDBjqaBB/TGe9u3vSOB94F4KoOj+
	jyc8+qidoq5LZ/0oKAzmhM9or2F0L1OrF6O3XA/5b+R9VA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mctpeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:10:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4df80d0d4aaso98297271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263014; x=1759867814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUh15XTlHhQ6Q1q/DhGrQFrryiPIaucH02PqHMC1azU=;
        b=hFYWXpoVXgAJu1fX+P+7k/2HEFUW10Ot2bQJ/RJ0/dp3A17MN9x+vDWBQOZhfdBBXH
         DdgsNJX4QJY4guJz5ZVPzD9P9dByIlUQvggam25bev41vL6vIReTkBd1d2YfszXLnQd3
         esRPXhfJaIHnuVUjCB/0+Yl2oZk7qhDVOhwXOtoWue2zoz21awj1sTm72Lf7zw6rSQrh
         CVEDmnLfE20pAztlF0CGd7GWqLShLCu+sGoIOUkVQc3uSCETOIqX7kgWSrdUaGPcb3/X
         ISc2W4vgDl6cLZus0g/IYvuVoyZi+KozGWOe/kRgDgX8t/82d5XrOp/pulXc1nH5bYRu
         ZviA==
X-Forwarded-Encrypted: i=1; AJvYcCV8gXfyZIU4q6/Q3KIpTLb2nPOGNS9ebuVqJ/QJKpHQgFo/giojGtXoGNrSAeDnWeRzqazK/lmOkI5nMSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztC4H4TDdJk96gc9KV37SiqL56talXUrNkRRHu7pv/7NwKdvQq
	rqr5s4vuug1CTU2Mf9aZwPCsg5glPy+MUs6zbTf96Awd+YJR4FcWBRFHMxfYgmvufexJ/h6Nppr
	Vnl2pZ8sSQcHafk6Li5sRR7DH33Rdl7i5QS8DD4geHOww44cAzt8MviVVkGeROi8L+2U=
X-Gm-Gg: ASbGnctRsZ2D85ZscleI3VQYtufLkivdrh0/Bq5p5DzTQs/9jLf921TZn18brnnSbl1
	qgbOXHBRWh5YxCYb0QsHHagWuQThFTHic3ZElCQR6X9vKW4NTryK8j2RayShnSf61L3QP0/aSGb
	w5PG3nNsG4Wvu1L2k4fHP7wOn7fvpAm42lljaiQxvCrZUBNWnPytetnKLr6KOip7p5ylHEqLaaI
	aNCXE2QFRWaM4TafHrkKg6gyLAaRPEN7/xy2uEh8vyLfG3qBIfdHKrvvuyaNzzXMj1MNZRq1Hmu
	itmJH6uSNXnTTxGYkeRNTFOH9I+mNDdu5wDNbOrYytbXf6LFedFM3VR3nAzq6U02Bl7MVik30ag
	j4/AdX+y511lQefx563fGENoZHPmVe6Uh8xzmlPOOY13HBHz3Y7lmBrtTYQ==
X-Received: by 2002:a05:622a:3c6:b0:4b2:f4e5:8eb1 with SMTP id d75a77b69052e-4e41eb14998mr12847891cf.55.1759263014283;
        Tue, 30 Sep 2025 13:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkOHi3Cw4K9bHAEsEdXynVuyKt+2OCerw8APvAAWKM2bNTs+Ga5p28b3x5snKdH664Kuc9Vw==
X-Received: by 2002:a05:622a:3c6:b0:4b2:f4e5:8eb1 with SMTP id d75a77b69052e-4e41eb14998mr12847201cf.55.1759263013780;
        Tue, 30 Sep 2025 13:10:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-586b0c1f9d4sm2610582e87.49.2025.09.30.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:10:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:10:09 +0300
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
Subject: Re: [PATCH v6 04/18] drm/bridge: Move legacy bridge driver out of
 imx directory for multi-platform use
Message-ID: <x2fpm4rb7ermb2tyjefdwwbvwvzt6uosd45ad7ku3tp3yqkmqc@bayzgz3jsqkp>
References: <20250930090920.131094-1-damon.ding@rock-chips.com>
 <20250930090920.131094-5-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930090920.131094-5-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68dc3927 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=_9FxbLpkiinsEApfcMMA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: -9fkp3G0BqLKSeH_Bq6pqeMJPj2QwFNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX1a/fxOvPZYls
 w1cI27JPJ5H2MPA4Txe119LHqDnkMXA5KKSevdENdM0bWErK6/NwkTB19kgOZ6NpV8/xVUlIsGU
 pzW3ESWp+dsLUwKofeDRHn9NaoxEWQU8NSbAqi6itWOdBCyI6amEmYP9focQIbwV6VKrDeKKxg9
 gAwj0wq3zBmIoZh8YntJqb2IyYI9AWhtXs8q2SeV91bYfAIlNNdRFHiExvJwJ4dw5kzVsUAO/rS
 wA+p1iey8aalnXk98PS4x0rnb+HfXvXHO9+GAeJREpeQBjjcz79AU0+iLAmL8XG6a7RsBlbOZUF
 FltXPOmUbBGFxACwAhsp3JlKxkXlQ4AysPKvoXjJb+EmACsuLlAI5ZUY2lBh+2WHj5rQemgUpVE
 HgEhuDl48DBmtHYewBSVOCHHB/ty0Q==
X-Proofpoint-GUID: -9fkp3G0BqLKSeH_Bq6pqeMJPj2QwFNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004

On Tue, Sep 30, 2025 at 05:09:06PM +0800, Damon Ding wrote:
> As suggested by Dmitry, the DRM legacy bridge driver can be pulled
> out of imx/ subdir for multi-platform use. The driver is also renamed
> to make it more generic and suitable for platforms other than i.MX.
> 
> Additionally, a new API drm_bridge_is_legacy() is added to identify
> the legacy bridge, allowing specialized handling for such cases.

Why do you need special handling for it?

> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                | 10 ++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  drivers/gpu/drm/bridge/imx/Kconfig            | 10 --
>  drivers/gpu/drm/bridge/imx/Makefile           |  1 -
>  .../gpu/drm/bridge/imx/imx-legacy-bridge.c    | 91 -----------------
>  drivers/gpu/drm/bridge/legacy-bridge.c        | 99 +++++++++++++++++++
>  drivers/gpu/drm/imx/ipuv3/Kconfig             |  4 +-
>  drivers/gpu/drm/imx/ipuv3/imx-ldb.c           |  6 +-
>  drivers/gpu/drm/imx/ipuv3/parallel-display.c  |  4 +-
>  include/drm/bridge/imx.h                      | 17 ----
>  include/drm/bridge/legacy-bridge.h            | 18 ++++
>  11 files changed, 135 insertions(+), 126 deletions(-)
>  delete mode 100644 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
>  create mode 100644 drivers/gpu/drm/bridge/legacy-bridge.c
>  delete mode 100644 include/drm/bridge/imx.h
>  create mode 100644 include/drm/bridge/legacy-bridge.h

I'm slightly concerned with the name of 'legacy drm bridge', It was fine
for 'i.MX legacy', but now it might be a bit of overkill. Maybe
something like drm_display_mode or drm_of_display_mode bridge?

-- 
With best wishes
Dmitry


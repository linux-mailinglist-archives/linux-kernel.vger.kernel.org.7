Return-Path: <linux-kernel+bounces-747191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E4B130D6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12288174969
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE90218858;
	Sun, 27 Jul 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GjWlHz6V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FE610D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753636064; cv=none; b=cRENnv7juhIZcIqo0zPxQcBzALQoy2GFZFxcRGn6oAq9K7XgEDi6qEXn+X9ALvZO/MxRFD3twcNsPMKzhgJefMFia6FcTiyO0RvWREwfjF01SE0Lr9+0syolKxpn5+VtSLKHo5F6Gz6ytHMBwGDoHDDNnkXIMATE5oqYoDm3M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753636064; c=relaxed/simple;
	bh=wdvQvZOCUJ/q5uIVaqvSjkbGbQL15jJ/+mzkMqjWgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ricwZoglmmCN5FjS9Rst6+TBiTG1H+irgYkGJ+baMYbOzf5ywQKOHKT8RrKw5VeQNYgA9dVJFJhLaPv2LhZvhCy4Hl1wVpF8LJIikjEHiVW+6dQ4PKtgTk15Z1P6DCpEwoeR/s2rUQkxmk+bXUBGoKf4a4i/pzAEbViG1BUS8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GjWlHz6V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REqUec014727
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ixTGCGDVVyYZCVMPENu9+cSJ
	CMoukZrCFUWQs6e8nEs=; b=GjWlHz6VsRKE///7RZP+5J6nheAUZYr6XJ1Pn8y1
	9PG8KwFozIyqCuM0kPniLOFb4DCi1tJP4COnQrtVj9R6dr67Ztcq0s+9PYkW5pDA
	D/aLW4F3wevb9eSFNy9tvV3KB+YZuUNkRfCqUKfaw5vjYKFoh1nas4aPogtn3L5L
	Z6ev0yhdRShYYdS86oXSMRGepuBXhBvFrDeMLrr+2Xdx4Bc3AmvCvdMzUXt7HjxD
	iGjajE0qEdOACM8yy2YkzM8HtLLhRmk8dkCf+mAdMYgOevhNemt2k7TsJpeBrNn8
	/nRDW8qbacMN0rvUJMEeBuzs/lVthIi3mFB1XWdo3RciEw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbktcv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:07:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70749d4c689so2443956d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753636060; x=1754240860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixTGCGDVVyYZCVMPENu9+cSJCMoukZrCFUWQs6e8nEs=;
        b=go12chvkhbU4wBQwWrUh6bZvg9fJEetoPHdj7P3bmTo41fcnvbJf/vt0P1369N/Pt9
         yTXDqzPCtfib0RNTwY8brkwkLqRcRYtsKgaJzIgjPRURpUeUK9IO75y7tkR/eyrCNf7+
         BDfr+g+XR0QPXYp2HBIn8P/DLLo+Ne4LtOlH7q4BmCpjj6skg/vKDUIEELuyyfkN7Z4D
         +/FhGB1fDaWjYT3SW8CMM5st/xPs6YT7L6Zxd4AJpsYmlYmu7dleBj4OYHVIjXYYz0TC
         91XbgodEB9P02AyYdgYDG7W64RwbnIBbHqEI3QIENycjHQdNj9/slPUM0IZ7RslwNo2o
         kIQg==
X-Forwarded-Encrypted: i=1; AJvYcCXvWx9G31MRp5SRDhTZPQrVuGe2vZcE9REFZg9MiZ2x21OtLGCYZ2d6FmC4ZNrm+gzGwlTxGV3Sgfw8bSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDshfHA8lhdM+2i8g+cXe88SC2yZk4Uh/2mMpk6QoWlEerqA9
	yutuCO4KwD2kPOu7k4KY+GAJly9avB3sRSqYrDIIdyCQJtjBtq7VqziR8I5mNpdJvAFc9d+LCvB
	6hHcHsnMUuoiv+CwI0B8QjwqfuL+z/IVCJVUPTsbNz9BNlW1VvTl0CYG2A66pbOOE4jA=
X-Gm-Gg: ASbGncutyo+MWqqg2LSIZcdcoXFpJ1IFtsRirjLecu/3ty0QDYzoHeNNwVNicVoNg2D
	PTUvGB+461wnWYqxBT3cahiMASRHDu8Elqogkuntxj7Bfvj3qYLAAOLUnHOwtRw0/RXz3mhUpId
	1LwYc5quBDzi4Sjjr7y24QyXhcrX4We8NfoXKGLxmhLoht7jviugXmuyzexynjV06MSsbSTeSTk
	Vp2sczWsF6Hai1mcA5T895/ZurpHusYJdkfVIOlq6hh6VK3HoSNSFSd5vCPyigWm6/0eafQCede
	nflUyU8In+H7tlXIA/BFXFuqKveZraQZS87dN2+U1y5lKdxCVBmqEMTsesTJs8EaxL3DLCZ8t5R
	MqMeaCXYeEczx0TQ8khjST5mXQIg1EpIUg1NYLj99zq27xXX/lx5l
X-Received: by 2002:a05:6214:2589:b0:707:4537:694d with SMTP id 6a1803df08f44-70745378ec4mr29537426d6.40.1753636060359;
        Sun, 27 Jul 2025 10:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEXLKqoDY1SG91obuUTr/s+jXCYfFkccduE+r6jszKozvG4bsVHcYbTsAuHs4gKScMQt334Q==
X-Received: by 2002:a05:6214:2589:b0:707:4537:694d with SMTP id 6a1803df08f44-70745378ec4mr29537026d6.40.1753636059860;
        Sun, 27 Jul 2025 10:07:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633760e6sm878179e87.160.2025.07.27.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:07:38 -0700 (PDT)
Date: Sun, 27 Jul 2025 20:07:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
Message-ID: <ldhyfuczwtwydwnvno4xn6ppjtt7mtcj35fp52xrqaajtfbtpb@2pgkytczb5k5>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <20250724-exynos4-sii9234-driver-v2-3-faee244f1d40@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-exynos4-sii9234-driver-v2-3-faee244f1d40@grimler.se>
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=68865cdd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=he5a5jZawRGK-0tMrGoA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE1MiBTYWx0ZWRfX89I/o9nLa/v/
 t6QDMaMCkF4oftbjmarCpqj7fTsqYnxsozZw1q6xBVGesR7Sx1nzwUKiUevmnMy3PYsvxCyA9NU
 cQ6Lbjbnl3oWP7NZJA0mLyooDHaSTm2X0dMAKYOEtczHAgn6WAacRdxOMseC5dBKLSCqeKjwsZ/
 oY6zkYOSKK2xnbYwTsxibkgU6gcKxtn4YdFZ5OUXCudy5+oTcUHb4d6lHMjOdGKX/1P5/1p1z0a
 YuoG4ffwNeixHiv1FGjBpiLP1dRvpvAF/byQhONRjH4CPhVACOpkMfMxRy2Z/StmNyg2F4lgNyW
 G9zfmVxcGuxPKPFV4nxXQbQbMWmzS6+ACcjfuAh+/+oYLYb2lXKAnwcndvvwYPa60qV5c3VYFRa
 Zvu701jBVAqA+CgJtiXdtfx/mqFRKvm1CH9mAaFj9elPgusI9wH9GHllSlSNwrhGk0Sjf82D
X-Proofpoint-ORIG-GUID: s7nNGWxNda1KcO667H-PPw40VK63RL0-
X-Proofpoint-GUID: s7nNGWxNda1KcO667H-PPw40VK63RL0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=886 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270152

On Thu, Jul 24, 2025 at 08:50:53PM +0200, Henrik Grimler wrote:
> To use MHL we currently need the MHL chip to be permanently on, which
> consumes unnecessary power. Let's use extcon attached to MUIC to enable
> the MHL chip only if it detects an MHL cable.

Does HPD GPIO reflect the correct state of the cable? What is the order
of events in such a case? Should the sii9234 signal to Exynos HDMI that
the link is established?

> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> v2: add dependency on extcon. Issue reported by kernel test robot
>     <lkp@intel.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig   |  1 +
>  drivers/gpu/drm/bridge/sii9234.c | 89 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b9e0ca85226a603a24f90c6879d1499f824060cb..f18a083f6e1c6fe40bde5e65a1548acc61a162ae 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -303,6 +303,7 @@ config DRM_SII902X
>  config DRM_SII9234
>  	tristate "Silicon Image SII9234 HDMI/MHL bridge"
>  	depends on OF
> +	select EXTCON

Either this or 'depends on EXTCON || !EXTCON'

>  	help
>  	  Say Y here if you want support for the MHL interface.
>  	  It is an I2C driver, that detects connection of MHL bridge

-- 
With best wishes
Dmitry


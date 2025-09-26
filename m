Return-Path: <linux-kernel+bounces-834716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A15BA559F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050227453DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75724280338;
	Fri, 26 Sep 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUbTzr1y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA615278E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926384; cv=none; b=ZbxC7OZNTDw1MoW0VzYB/vsNu9/yYAm7duqXsRSkzgOcvEXBBAwgB5KsV0/gX1fccQMb+5/8hHGRyeeTESgltyqaQef9f1VsLupoa5HTWFgVLWaMVtEVkmDRQLDoU+Np5tQJBWBltxJZ95UN8c7QySBIhuTv8I2QCQksHEs8vIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926384; c=relaxed/simple;
	bh=PPX6/OLLzb7TyBqZiTZ5Bw7YmY1q3pqcuRpbBx31Wms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtoUk6L9/yac7uUQWGg8tU3/6XRo02R2Px33Vz5TI4UYtepd7W9LEDO7Apgr0uN/enRzcKkJVkdC436Bl/Rd1R9zQo5hXPngYBnM6ZOMwvpEsKgbgZznLtGReOvbYtgXCIVxQXtE3GcsmAKCuHvGJaNQqsczvGDN6gDMMRFX6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUbTzr1y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWoDS010377
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24B+Vz4/U0yEjaNWEtgpTbaWRtur5Gt5Ec3dIyDAQL8=; b=hUbTzr1y2OQ3GzGl
	vLzy1KdIUV6H/hHfFRsKZQDJASMzn9/8rPTyOjYsceJvawjNRHwTsHchB42saWmR
	6ddxTMiAtTcDYbzykEs0NSBR1zzdPOrGxjvzkcTmeRK1/c9SNsdkoFvtr3Rrgnz8
	HR5XdHYNM7E2AA3/hh0kadA3shQmrp2qCDRVIsISTE7kYVdphGJ0r1QoYjsgrCh5
	yCDBl1X/4zdWgQr4ASOOwaYzwcDzjZClFAZm3h+g4+Z9L5r5GgsZ1WW2DEHS8ptA
	JSDF/wzVCuKxAfvC+jvkIbXOX8+0kh1wvpXhv1tBO0GUmwwVzvnncvf0GoLszzcY
	610eoA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db3249mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:39:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ddc5a484c9so27712701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926381; x=1759531181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24B+Vz4/U0yEjaNWEtgpTbaWRtur5Gt5Ec3dIyDAQL8=;
        b=TZMQrJ3IC45LszRolWNsmZG75Ffqo4XjBle8MDVUfKrKQjN3c+c9pwINUpYL5F7hHS
         u0qz7Z2trhNqJiixaQxtsoYvEnbkKEyj/slpWO1+dlGgHw+Rn5aXFCGxHe7xkgAha2T5
         X7pwjAoTWYRtMefMwZTkcfKj4Dr04FqgTESACpwFU6KyeKfJjDnW2l0OmAtxFiWXyJT7
         4GsHSwl1yAn3hZj7oD3YApLNH9lwSaWhz3AyFk0UfFBOCSHfpm1tf9JJ4v/I8duviJmm
         2812lXNs7gM6dVHVPoDBUD3vuu6+xygI77sW1sUcV0VyBECTRkqvGWBREZMSb7oUdYVe
         0uYw==
X-Forwarded-Encrypted: i=1; AJvYcCXIxKshneBcNB4graRHloqmlZDzo8I2xat94/Xod3K6FFMxw9wucoixkw1PNGKgI1FRUeWqs0J32OF5iQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioS3q9MdREzwqJIvLaURhTU/tWBfOSbfOSYQsq3ElfPXKzXRm
	RTdqASKZs6/ubG2lJ/Ig7VHSEoZMcMDpOxE5GvJD+qM35rGsbpp/WkOEPK9JFidijaJqoyVhaWG
	tZDCqiQM1kzsVjpj1Gld0WNMiXYKcaJACs745T2FsC+pCPDgfRu1kcJu/I7DO+PD/kkg=
X-Gm-Gg: ASbGncuSaTcKGpH5tUbkkjUDryIiy40vAfAEcVGdy/+RYax+ZmPBDsmK9SPanisKJiS
	yQRcDGt6IE8MWqhscpQr9KKIDbB6Tfh1KdmI26UL+r+byKRZIyIfERg1D6N1zuI+uaKjWlSL1RN
	6Xg/AeXwHlOz4TH+E945bX2B2+Iom8pPWXpPKDOP3O4OubolUDQjUKsspx/GwV/9bxPnTRZ3IQ9
	0sagtvaUA48VD+dqg1YPZEavrvX32VE96h/vqiRrqD6cAcZBcKt0Ovm8tGcKJ7AUMrAvaJS+U9H
	U8R5NVpLjgRH6HjdL6F99Ch0n+hEwY6WdGQFU7wlkL/piejpECwQPhMUjAH2bEE7GJyoGKFdbYC
	avahyjH1YJmOvjFDfNPIf95H/m4W41K+1uONbpZV0xmbnLgq7m9DW
X-Received: by 2002:a05:622a:1e0f:b0:4b7:9f86:8705 with SMTP id d75a77b69052e-4da4c592ee3mr134211591cf.65.1758926380598;
        Fri, 26 Sep 2025 15:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFULKcswbecIMJxJdKm6lG7MR0cO0tulN2B73lbhlln9Tivc+4c4xrQ0vP6iGEuXEcs3svMLQ==
X-Received: by 2002:a05:622a:1e0f:b0:4b7:9f86:8705 with SMTP id d75a77b69052e-4da4c592ee3mr134211191cf.65.1758926380083;
        Fri, 26 Sep 2025 15:39:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656702sm2157148e87.93.2025.09.26.15.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:39:39 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:39:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hui Pu <Hui.Pu@gehealthcare.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: bridge_connector: get/put the stored
 bridges
Message-ID: <ucuzhhlqs23bcunjdhashydaxlgjpqvp3aezqfw25pkcbppg4l@4rltyxmfbm7w>
References: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d7162e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=bV7b8LOMf5y5Q0lBeo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: PYP1vJHUhW0rCE6fF5nG83vvjJVFFcOx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfXxVwW3+1FX2vq
 u//2UHQz6wds03iyVqwJG/rGq9UNaCYPUCxxFgfzK+MB+U4QtFw0RIUZNrkQu9D5wXZbPM2wIKY
 B5Hy+J+/4zCsadn9Hai/12iME+gGgTz+5p+ED/N0Ih6fGHNhwXiaw6XfEaPxMvrMl/6nzHYr2vN
 sN0EpxE0Ksn2EWPh3eSuj9DBXnFMI4EdBX/LtB5djzDd8u2iXCF0zFb26MMdvLIiC1Csk1TEqUz
 6Wvb4CDwLSjWvjvhsq0F4HRuzgvcrr6z4SyMreflWJlNK1ihzV0a1MTg8uz2BKpmjIcdj3y/FBY
 Zxxa2WaeLDyOtSsF9Qp/vaSszW2/SuW/A7/UfW0BODAPDL+HTKzE6gqTbznBXqNp69TpfhWeVEo
 hOg9bj0BKQ5Rx7a+112GwGesXIU2nA==
X-Proofpoint-GUID: PYP1vJHUhW0rCE6fF5nG83vvjJVFFcOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

On Fri, Sep 26, 2025 at 04:59:40PM +0200, Luca Ceresoli wrote:
> drm_bridge_connector_init() takes eight pointers to various bridges, some
> of which can be identical, and stores them in pointers inside struct
> drm_bridge_connector. Get a reference to each of the taken bridges and put
> it on cleanup.
> 
> This is tricky because the pointers are currently stored directly in the
> drm_bridge_connector in the loop, but there is no nice and clean way to put
> those pointers on error return paths. To overcome this, store all pointers
> in temporary local variables with a cleanup action, and only on success
> copy them into struct drm_bridge_connector (getting another ref while
> copying).
> 
> Additionally four of these pointers (edid, hpd, detect and modes) can be
> written in multiple loop iterations, in order to eventually store the last
> matching bridge. However, when one of those pointers is overwritten, we
> need to put the reference that we got during the previous assignment. Add a
> drm_bridge_put() before writing them to handle this.
> 
> Finally, there is also a function-local panel_bridge pointer taken inside
> the loop and used after the loop. Use a cleanup action as well to ensure it
> is put on return.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> This series ensures the bridge-connector gets a reference to bridges when
> storing a pointer to them, and releases them afterwards.
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [1].
> Here's the work breakdown (➜ marks the current series):
> 
>  1. ➜ add refcounting to DRM bridges (struct drm_bridge)
>     (based on devm_drm_bridge_alloc() [0])
>     A. ✔ add new alloc API and refcounting (v6.16)
>     B. ✔ convert all bridge drivers to new API (v6.17)
>     C. ✔ kunit tests (v6.17)
>     D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
>          and warn on old allocation pattern (v6.17)
>     E. … add get/put on drm_bridge accessors
>        1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
>             (drm-misc-next)
>        2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
>        3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
>        4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
>        5. ➜ drm_bridge_connector_init
>        6. protect encoder bridge chain with a mutex
>        7. of_drm_find_bridge
>        8. drm_of_find_panel_or_bridge, *_of_get_bridge
>     F. ➜ debugfs improvements
>        1. ✔ add top-level 'bridges' file (v6.16)
>        2. ✔ show refcount and list removed bridges (drm-misc-next)
>  2. … handle gracefully atomic updates during bridge removal
>  3. … DSI host-device driver interaction
>  4. removing the need for the "always-disconnected" connector
>  5. finish the hotplug bridge work, moving code to the core and potentially
>     removing the hotplug-bridge itself (this needs to be clarified as
>     points 1-3 are developed)
> 
> This was tricky both because there is no central place in
> drm_bridge_connector.c to put the references on disposal (handled by patch
> 1) and because of the complex code flow of drm_bridge_connector_init()
> (handled by patch 2).
> ---
> Changes in v2:
> - Use drmm_add_action() instead of hacking the .destroy connector func
> - Removed patch 1 (where the hacking the .destroy connector func was)
> - Link to v1: https://lore.kernel.org/r/20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 114 +++++++++++++++++--------
>  1 file changed, 78 insertions(+), 36 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


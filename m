Return-Path: <linux-kernel+bounces-845946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DCBC68DB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C82402511
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7627B358;
	Wed,  8 Oct 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEafHjNq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56A26E16F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954693; cv=none; b=PsSRYCSya0q/7kN1f0I1MbbjlDvoglFtjjulXutVpAL17IgJef9dCSWDK/ZMU2t9YZH9HRtrKV15+JoFddgZvt26+Y4MVJn1yvgJGtSZWIdcafkdKTqh5AuO4Exq+JQmfOAWcCAYaCZBvSAjmYJ/+o64kmPET6sDHTkzD8Z2lU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954693; c=relaxed/simple;
	bh=CBClApV4PJtkcbyrryj277H+RpsvH4JtIbjMR20m/4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnveliFteSAVnXdbMO6nTFrVQ0acLVIvHLVbc3ndJKNpkjoFRPlbq5GlaUE27Aa+HY7tpYtyUBOqxTAx2jH5pg2k3xsP5rrU2Z9w6FcLHC/vz4067Du2OxTWmXqAT0FNFNofWspBfqJEV9iKfWZpi/e/zbO/PanaREhH0glhZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEafHjNq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Iji002413
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kNooSgQObBXHDW2EZd4lPNQf
	XkC1kUoaAl1kKd85Nyg=; b=EEafHjNql4kicFMEu1N4GmRpeEnZWAOvK1cv4hst
	W8sT2ELEpo++OmEEPV/jMOCexj6+RT+uSOWFjKYQ2SZdEdkd/WEEmxlpcSdk4iP+
	ASpBwRKpl/8IGMuL3qaxVijU1Q170qAk/2Ywq5qnFc0AoGbxq+/B9pqH446OP5KR
	0Q1xyRxsil8ASV24lpPLV6ioRoj9yQFeEnIy2Kzz85j4mkC3KQv5xaAXPlLNhURz
	uCQATreTatxIB7q6GSio1iJVTd+Vg7ZMyWXN2k0uUxiwNBNPbhOWM8tTYPTAnpZf
	kyHk+ANWLcqApzl0o9zrh7ytDf6Yv41VaT1dI63dg1amxA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m0gqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:18:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e574e01ed8so7084771cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954690; x=1760559490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNooSgQObBXHDW2EZd4lPNQfXkC1kUoaAl1kKd85Nyg=;
        b=HasCRuUOHz6U14XpswODwqMTaN3ieBS7XroiZfPeA4Mt8X47w8bwj2TsgaHVSOeo+M
         iFK3Wi3LYnfa/YAqheCC1fanU0IecCK7+eelTinh6FoGetu10Qi/wUcXj4ysODF6Zasy
         yZWZlK5L5bZEo1s63AvwBNulVzm/PKzo/JBX1gBoZBNN5KVohaVHFRCMELAS0m50Aklc
         2x+eRnFkd3Jr21weMkmGfhpS+i4kH0aSjsPXOXukcqTfjlylgnizfcUT5ssVuX49DpJN
         d4TUrAy0w+KIeJrC59ibxK+gWRB672mJ88rl0A+zGAA2Ox3SwJOy7KqazFbPMtCV+pzd
         ehbg==
X-Forwarded-Encrypted: i=1; AJvYcCX0kD0LRtLhls5jZmbNFx1AEkBBx9RiwVRiNDDyLCsr5GizSWX9LqDc6v17iIy4EDAKhe8hqILLjSeDd0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmk6Pz2/n0mHIvlcpi4LDJUdB6zUf8AgFlislpdwT7dqaTACo
	ooWBegXoZ2dn5ES3xoimbvg4GI0ilN2FNDN/BcXp7/14hcm+iFbhNfdlP75WWRO8oiN+vKUCkxm
	Ny5ZtX6K/KfR1bIJf4YmpohG+0rOEY89khhRZfw5rjWGZRxRUazSyXQWN8oZozvkwWUg=
X-Gm-Gg: ASbGncu4Ock2iEJMRJ6kIdLAZfxY5+VUjH0yv6Z2iQSjo2jmROOK9oEPYhHuYtMztlU
	Es3UvTfd2CyLtTgAN6asV8H6lmpVRNpF74N2Ogv5/Gyo6eUOc6cQ3EP385istlmlz4JiI9TZaw3
	pAxC91H+YIzvBS9u+aCnpAj2CEMgDF40bqFOkKRmW2wZR4DwtyP0YgqCktj+hOnIcFigjlL/s1h
	qiNVpeSGxgpcrhBmDy58MdXv5YpD+zmRosFTiUly+GrmFS+jdBuRD6eVdQe5DGnmqlJzSkyyIey
	8GlPuOKXKqh62eot9Bxp9qi7izI2JtR7TQqnwojC97r1YpU5UiHkTA18K+Ga7/ervV9B3HZZ8Q2
	9pO8pfllUyUeja40MdQqgJghupPwuXvtNnEk34K1FvqJalqYZgCeloKL8Tg==
X-Received: by 2002:ac8:6f13:0:b0:4e6:d87a:280 with SMTP id d75a77b69052e-4e6ead55458mr70978411cf.55.1759954689762;
        Wed, 08 Oct 2025 13:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxqvReUu2GqoRvVHckRUinvJTU/UNQ6t7PoprPmB+pZQtpos6Wn/tSoiodgEp8Lq4K561kw==
X-Received: by 2002:ac8:6f13:0:b0:4e6:d87a:280 with SMTP id d75a77b69052e-4e6ead55458mr70978041cf.55.1759954689320;
        Wed, 08 Oct 2025 13:18:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b8213csm22079521fa.48.2025.10.08.13.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:18:08 -0700 (PDT)
Date: Wed, 8 Oct 2025 23:18:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        airlied@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
        simona@ffwll.ch, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, praneeth@ti.com, vigneshr@ti.com,
        aradhya.bhatia@linux.dev, s-jain1@ti.com, s-wang12@ti.com,
        r-donadkar@ti.com, h-shenoy@ti.com
Subject: Re: [PATCH v3] drm/bridge: sii902x: Fix HDMI detection with
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Message-ID: <4rbyxn2jr4nsogt4wfdin3jpzumjqj4mcplq7on6yyqvq4wu34@qng22gczlfyn>
References: <20251007112309.1103811-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007112309.1103811-1-devarsht@ti.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9vwT+m45ZKWZ
 eWcd4wvmCk7utcg+uT2IPTRy4W2zZp4qIEJ0BQEUB4gIVB6qNnVLm9xGNj73l6pk9T5ZGBRxcH8
 shymynZJjH29izZ2U9MtsxUMGsOceq+rNngstomeidD9QzBTxuCdCTFHgebAfOvI9zSast1Wl5q
 sIWvQsCwufNHfoUUUT0kY9kVXrCPPSthZLBZ/mfZdpnCzgwO8YPEgN6GSOulhktiyJxSzy6BXA4
 07vcTKyx0yJGpdgKIJvvyWg62u3BT6izaaMUB8/6M+rnScaMgps6QTB4enJ9CbMKKbkmbJvw1xz
 ulBh1+GfZDW8OcSBOdXXPVY5ZzMkTAZxHby6i28Z6s3cxa1rtNpH8uadIVsPCi5/rqOg9ZtcrOW
 ItAp6E4QFkxCBu3DKNRfe7KSSNBdjA==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e6c703 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=WDkIgKykSkWkz4MvAP8A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2Xj2vhv48HNOB0RElPsbNYvJzRXIldMb
X-Proofpoint-ORIG-GUID: 2Xj2vhv48HNOB0RElPsbNYvJzRXIldMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, Oct 07, 2025 at 04:53:09PM +0530, Devarsh Thakkar wrote:
> The SII902x HDMI bridge driver wasn't working properly with drivers that
> use the newer bridge connector architecture with the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, like TIDSS.  This caused HDMI audio to
> fail since the driver wasn't properly setting the sink_is_hdmi flag when
> the bridge was attached without a connector since .get_modes() is never
> called in this case. Fix it by setting sink_is_hdmi flag when reading
> the EDID block itself.
> 
> Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V3: Use drm_edid_connector_update without edid NULL check
> V2: Use drm_edid_connector_update to detect HDMI
> 
> Link to V2:
> https://lore.kernel.org/all/20251006150714.3144368-1-devarsht@ti.com/
> Link to V1:
> https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/
> 
>  drivers/gpu/drm/bridge/sii902x.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index d537b1d036fb..bb613d4c281f 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -296,6 +296,8 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
>  	mutex_lock(&sii902x->mutex);
>  
>  	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
> +	drm_edid_connector_update(connector, drm_edid);
> +	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
>  
>  	mutex_unlock(&sii902x->mutex);
>  
> @@ -309,14 +311,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
>  	int num = 0;
>  
>  	drm_edid = sii902x_edid_read(sii902x, connector);
> -	drm_edid_connector_update(connector, drm_edid);
>  	if (drm_edid) {
>  		num = drm_edid_connector_add_modes(connector);
>  		drm_edid_free(drm_edid);
>  	}

The EDID read / free can also be dropped, they don't serve any purpose
now.

>  
> -	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
> -
>  	return num;
>  }
>  
> -- 
> 2.39.1
> 

-- 
With best wishes
Dmitry


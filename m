Return-Path: <linux-kernel+bounces-833348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0BBA1BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69632560D75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0B2EA491;
	Thu, 25 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYVM4wR8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2346B5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838053; cv=none; b=R1lzkXE65k5+TmAy6DmfFgzF0CejX5eER7c+OLBXubV75+pMLiNc8Dd01KD9QjkxR2lohVlcMUL/uV3Mr8sk8D6AFp75EqoViXUQjEQyPSrncTANnHwvEJ26yAMGqfkpJvldNrEKpf0XRwF9vzBESowkjL+PKACXouM2sVf4EBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838053; c=relaxed/simple;
	bh=ieyYodZ9Ttan4EgWf3O3arMBEsUN3+HWD1UxStvOQ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdCYlmH3fs68h5Ecqh3u2XPURGGa3EP5BXdKqYVzmly/KY8+D2avY0du7vjlKp5iTpZvUJWK/VpDxvlIEpcSMFKZzTpWDY9iv2fkt/ULrpK9r9u4xuUdpEiWPa7lxw63mLyb1OU1F1UYYikQrWMs+l7dgjWBCAzuRrArTJZxxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYVM4wR8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPZ1B027516
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GnhBNlMLToijg17nNqJ1S6A4
	kSgBLyw9c+uskKRflGQ=; b=TYVM4wR8VvW2O/i75QaPcilIuMM91cXxdTPax7I9
	+2uHfpEve16urYdgGOKhgG5U2n76sFLJ1dUylFZB+A+jMjqrY6ZeKrcxdI3U7IDU
	foBYLU4h5Ew1HcQefw0sY25n5ukE0x/dp7T7+H8kb3P1Iyi1ssrG5tbCyj1vMuI2
	vE6goOjZH6g9eUQ77h7rVTon+k+fPXHj9AJ5A4IaZtv6oCl7jj0kwGHIg9tEwqRP
	ZuZw7D7ZXjXa5TWiRSt7SVeyiEbQI97cS0I9GtscDL/M9NypyEBVw6rZ+nWZi+QG
	77RZNSMWd3ZT5XnGgoPtt7Y/LgBjQx2CyrxlVm42np1g0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0ha3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:07:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso33905261cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758838050; x=1759442850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnhBNlMLToijg17nNqJ1S6A4kSgBLyw9c+uskKRflGQ=;
        b=nANBZFYRlSmPX95tiGb2o1g6bX25j6m120ewS/s3VJT6lEgSSZR1dnnH3mWI/xEbi5
         j+a1oVF2wVttH+xrk5JeHQFZYyXSLkvmhv3g4XmTUokZ62X6qICTv1ocbmtxhCuEuJqW
         eMxQAZL2oEuRefGzZWp0cCwrmxjD7R+K6Atcf8bOURwAsUcOsElivVWRVtE35xOXx4+L
         +GU6eTIYA9xC7iyq9iCqGJjyFKSCzFQ6BMWDUfR0yfNeCDda+kHzZCU48ITKKO+b5S+u
         EqWMveDV92eazyvGTDBtHIWSEna/YlJsRyHMMqH/7izFVJxWA++4S/VndsRa9xdRPeMT
         kR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwbKT6dluJGAM1CKkuP+2gkpM1FpBbWRnRfLUe1ID3nDH1ajxZQJg1FLc3tGEfaDCtqpPj3Du2KDMAt/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjbYmCK6xppb3EfaBiE38vsfCCV7oZUEm4dVqPBA8hjYMmoci
	+0rBXFuKudSEhxdwBHfoFjtMPmNGN+C3ALoS7y+pWLtRBfq0KoQfyXTu4e/aL7jMwucXIEwtxOL
	lzUFDoyo6+dydbJo4jAkNjO5NmkuKGTrqXFgCLRZ40K1SxXUqSu1HgEUcsHuX5zk0hLE=
X-Gm-Gg: ASbGncuPDmWN3inZG4vH15M744lBf0k2Rrh39hFpiHa7ItZCj4XGSKrwQUZbtj2SrOz
	ypscAMEgtI0+VWvruURuodt1UbqsiWxAnr3W5ElU8rWMd3Yw7thfAfw6PcNSuMUh4G/7jPkCVoO
	rx1/dLRSmgalQMHN5NBgQ0xKl3x/jG9dh6Z1WAHrVkQW1XTb33ZKJtvnCrpkuAI0+cZGH+Rf2DY
	14mpCAFuuNPtoohHSB1PfMo5Fx6Pzd8A9RHwedjOQRwFVbW+xAUcv9Pix/aPzUv2rbaYBTY5SX5
	gPNUGqGxXNJq4CMs8JfC9lsOdOACDErMmrXOAMJbmhgiVmOCj4PHZIJZB77/tyOWNcUpbBtC3TR
	uVXsB7KoE9keotFVKy2vHGKtGhcpAQBk0vMrnJVs2CJG7vTaihYUP
X-Received: by 2002:a05:622a:4012:b0:4b3:4f82:2b2a with SMTP id d75a77b69052e-4da4744e220mr69209891cf.4.1758838049451;
        Thu, 25 Sep 2025 15:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+kiDioj7XNNOSUiRVIvZJf7NJTXJJKSATGhjuKbjf+uCQ8OyI87CrBJMN/jv48N8Iqu/Vnw==
X-Received: by 2002:a05:622a:4012:b0:4b3:4f82:2b2a with SMTP id d75a77b69052e-4da4744e220mr69209361cf.4.1758838048863;
        Thu, 25 Sep 2025 15:07:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430bd6sm1169840e87.21.2025.09.25.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:07:27 -0700 (PDT)
Date: Fri, 26 Sep 2025 01:07:26 +0300
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
Subject: Re: [PATCH 1/2] drm/connector: allow a .destroy callback for
 drmm-allocated connectors
Message-ID: <ycbx4fxqppxuopcd64i6lt7qlcsa75iv4z6q4aka7igt7pntc7@bf3toot46wxo>
References: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
 <20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX7r9Rnt3pnwc+
 8f83nsHxJ3ETBoCtjB1uPCDhX3Ps5GwY57Odanr2D5vHNpiSi0XYG0WHVCo4g33xzfXiMi+XbdE
 LbG1HzQSbKKH/0Fw6xxjpkEXS9lMCXkNKylzeC99IBssOZugKP+6hbsq++S7fneSVQQIXU98res
 wa2t8FijXs1w3i0K5bWLxSB2fo8c+pGCjv6u7VN9wi4YoYU2/TtYoA6B51E8SpwFCwWaeIRnh63
 yTKhVaVQN3PyKmoH4AKSmdb1bz6BLtrIVw1NkaTSKGGiTrZEg9q6mYyfogLjL11FlwNBRM2z4kk
 8o0euaexrXcq4QnrALu9ESYVQ2Ek1OTRVYiH8lzBVxtqNpcQwINWU/3r4VK91y4PD7Hepzg9dAd
 s7RrivfiCLNTY/+rrwsc5oK+eQJE5A==
X-Proofpoint-GUID: a3ZPy030-VNMvBBld8YEYKQPHIx7INVk
X-Proofpoint-ORIG-GUID: a3ZPy030-VNMvBBld8YEYKQPHIx7INVk
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d5bd23 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=LsQKV8oFGlUMgrd0jhAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 07:19:49PM +0200, Luca Ceresoli wrote:
> Some code is going to need connector-specific cleanup actions (namely
> drm_bridge_connector will need to put refcounted bridges).
> 
> The .destroy callback is appropriate for this task but it is currently
> forbidden by drmm_connector_init(). Relax this limitation and document it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> The other obvious approach would be adding a separate .cleanup callback for
> the cleanup-only actions. I tried both, they both apparently work, so any
> arguments and opinions on which approach is best within the overall DRM
> design would be very useful here.

Would it be better to use drmm-reset actions. I think the check here
makes much more help overall than harm in your case, so I'd suggest
leaving it in place.

> ---
>  drivers/gpu/drm/drm_connector.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 272d6254ea4784e97ca894ec4d463beebf9fdbf0..bd0220513a23afcb096b0c4c4d2b957b81f21ee1 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -513,7 +513,8 @@ static void drm_connector_cleanup_action(struct drm_device *dev,
>   *
>   * The connector structure should be allocated with drmm_kzalloc().
>   *
> - * The @drm_connector_funcs.destroy hook must be NULL.
> + * The @drm_connector_funcs.destroy hook must only do connector-specific
> + * cleanups if any is needed, not dealloacte the connector.
>   *
>   * Returns:
>   * Zero on success, error code on failure.
> @@ -526,9 +527,6 @@ int drmm_connector_init(struct drm_device *dev,
>  {
>  	int ret;
>  
> -	if (drm_WARN_ON(dev, funcs && funcs->destroy))
> -		return -EINVAL;
> -
>  	ret = drm_connector_init_and_add(dev, connector, funcs, connector_type, ddc);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry


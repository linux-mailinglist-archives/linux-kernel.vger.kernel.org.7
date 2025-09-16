Return-Path: <linux-kernel+bounces-818624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EFB59437
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978E0483F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EA305E32;
	Tue, 16 Sep 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eD+NRm78"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F22C2375
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019668; cv=none; b=qX4e8d1fCTFqJ0mjxOjuAJYY7BT/rQxCkrZRZyGeKnFL/kwOvCFtATIYLujNoecYytnDPbeDVpQ4G7MEmwMYEPrGHQrp7UvX8ubEOMN8Mw+axYgLG0tXgUMEwEJFBG2ocnia+fC20VMS1Vc8rluRgIF/xOf44fiZa9v0rJatOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019668; c=relaxed/simple;
	bh=eql8uEF54XlS+jiNL5gQJ246kEimmvf+QHDfTR66IBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8L8GRWtCdAn/VWgLiyi3Jpv8yqIEU36gK8WZxjDMpYexug3gCq+D66VbmVimcr52kmW0O8JraAVkkw4oxkXfvIfM52ZhRXOqEAHbkAkw87svC1QTb/bp1iHM3YaQqyL1v9SuX/gsHNCutc4DILpD0vPi7+yueM+zFzPwhYAcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eD+NRm78; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAAHP2010542
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=il1ylO5UElnP2PjAWM+meiZk
	z9ec0WNfLUquacAr7yg=; b=eD+NRm78QVVxDtrtLm44FJmkEyKnUaWx8h/F6NvE
	RIwMh8ltikkaGXSpFXjSgvBdfUA4FfJkpICFvqszTLUzounuZMnW0VvzkPYlaUMs
	mMXsDnfxX/AE5i9R0M9PVxK5ZL2STuD5nScet6mVpcCInmFfrSdvsEVmvps2UiC/
	ooquqEyPzc5XryW6rLfsV/NiIEWHTSmsMUam5iT6wQlfrmYfH5uAuc12H1It5ISy
	z4O/xvvE/iZh0ZYf7CNbJZZZay48C+TClwZTlSUXq6CELI5T9x+DPxj7j2m6yMHE
	xvh6v/1jxgeHIemJPeTGwAj9XzDmrumKU04Y/vJLmR3GNw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrc97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72023d1be83so161644076d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019664; x=1758624464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il1ylO5UElnP2PjAWM+meiZkz9ec0WNfLUquacAr7yg=;
        b=UXwySFO+++JsUuNudqLk8IXwjyBaQescuiRop+45y5p9N4DhnU3mnDBxbA0VhcV8V+
         sv65ILIHOGwatfk4ADNEzK1mKAZcOAcrHcb9LBT6UOlkIDjvRsVxb8d7SbWUBRXN/KAy
         wVo+c2p+E+A8pPSbeYjEDrhKRq/6H6g3/nTPuARmiVr/ReYQgSz3SlzJyf+mOzl+dZfC
         5AmXuPWmqbD9sjo7dybBRGhzl/k+IuIIEj7J1H0R9nmWUP5/wKvIo/bl8BKFcR88eWmF
         Isi70k6BikpChEkuHAPpuoz5DGDa4PHI1hF1732opEx+HgsGIczF9KVL8i7YAvSSaI8X
         GP1A==
X-Forwarded-Encrypted: i=1; AJvYcCXFr/N6V2hPrJX390hCbqH57JShmrhdqG+BjAJemQuS1smCvnJjlM8nHoN+JSV4qqSDOfqB0B2H7rzGt9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FJTPRM5p6Vm3KCpvE5Oz+PEkCspnLqubJse1pgU7O8XDB7K0
	CZ86a8aINW6iFhAxoRDahh3dIwgOOKGzSXDH6Z5xnKwcXs14/ZT7C2M/BtqlNpn4DfGWKqYlgtZ
	EiJKvJ9eynfGLqYCg7Us8oSGPay2cQftFwyx4uotzG2aQyeHnItX6rM6oBma+4hKgpT4=
X-Gm-Gg: ASbGncsOGaRXRODqbb4YA9fW+9a3ST1mhYgxMTDaHcvQZVhCIJer8uhopv/SKjQ9aGU
	mgjbIq4hbprKXyyhOAeWGi/eemxwv19sTJ0T+hF/gUeNe/WGuXS70nnasRNAXYyB0O1iyzEmYa3
	vTTa68DqzdVn0ooXrXZ10GXo1k+tGDClO/Z6Ct5uD1oaG60bdEJwauexFWdl2xDrEotcbmqOUbG
	zOvET3owZMkBoX62sfXiKEsJ5Beq4uhYHG7JWO95IptxNdgtAdRJE81ZX6ZIdPe8da5cNwSs2ee
	2Xbqf0agvQgt1wg6PgFajG6iYSlhTbPYSXVSfDDDj44dmbZWul3ZngBssskPXyIwt/odyYWY2DL
	3upe8QQ0yOBBBC+/Kx5dQfO+wvk/hpFZg2E8u3nJRniui4QSVByZk
X-Received: by 2002:a05:6214:5192:b0:728:854:6c5d with SMTP id 6a1803df08f44-767c1f720camr187319416d6.40.1758019664006;
        Tue, 16 Sep 2025 03:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcF+9+EVEVyFkGibcgDFcmq8UYwcsHfhxQRgJtqpwnGTS/igxMZNVub2ptM4Dj++CblB7lZw==
X-Received: by 2002:a05:6214:5192:b0:728:854:6c5d with SMTP id 6a1803df08f44-767c1f720camr187318856d6.40.1758019663329;
        Tue, 16 Sep 2025 03:47:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-570340058c8sm3904023e87.62.2025.09.16.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:47:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
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
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 5/5] drm/bridge: it6505: skip auto training
 when previous try fail
Message-ID: <6n676e7a22sxdvvqxjjv2hcxcq3lg4hdvdmwewneeb5zhy4m2y@2ovapkawanjm>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-5-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-fix-link-training-v3-5-0f55bfdb272a@ite.com.tw>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c94052 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=bPpkopM70cy9w_l897MA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-ORIG-GUID: PXyhmTsRqqQAtKcIxNq4eW4Nrd4R6ln0
X-Proofpoint-GUID: PXyhmTsRqqQAtKcIxNq4eW4Nrd4R6ln0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfXxf2GVtXtioD1
 WVcIl3q0sY8sG2fOeB71FDQj728zlqUpdTjKLQdUFq8qxuMFoq4UfqiZV8KM4fUOwxluNB6EhOS
 NEAtCOCrWosz+ngs9WLIzdos4i9GPmp4rN872qKJVAoc501dWyBCBQnIOmWfBrPt1vmQtANHe0x
 FITektPvJLAii2DpXQntUvHG0KfK4AP9x/UxK6OydAsyP/X70ok2cK+MkCW/93dzCM5nA30BVIu
 ehZjn0Fp6lpM6WzGrbLZl/S2/NNuAge7/waOKljX/L1Q7sEoNkRsECZdj6l0hqEmrZljG26Dsff
 qbhI7z4/vmx+leLatbecW9rEMqALLx0jTjnEof3zPa6GSLFzxJmWQneRpQ8+BE8NIuayM0JeU6e
 NYt2m1DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Tue, Sep 16, 2025 at 12:47:45PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When connect to device which can only training done by
> step training,

> skip auto training when link training restart,
> usually happen when display resolution is changed.

Please expand your commit message for it to make sense to somebody who
doesn't know the issue. If I understood it correctly, it should be
something like 'The driver performs a full cycle of attempting auto link
training and then manual link training on each modeset. Save time by
skipping the auto training if it failed previously for this monitor'.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-831706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F349B9D5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B96416F974
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E2252900;
	Thu, 25 Sep 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SS3bjb8P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DA2B9A4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758773069; cv=none; b=P3Nj6m0E/oG6+Rt4BsXy/aztScwojiXDEGtbe3CUhNzX4R2ditQyR+RilB0y02Q0VaDXc0veszNm7zwB89/g9GFPMksO5Km7H1q/jPBiEioSY7I1ATK5cBGmmLtfJf7L8jtuAhR5yjqKpMdiOjd28dKBhlTAXPJH7dwPU/87qfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758773069; c=relaxed/simple;
	bh=NP6xBYyItRKVxpXgwkXl9wwLuBwVaQNWS7ukNXgmuwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvWOW1JEAS2EbiEtiuW2xNupUJ7Fv36OHrfqSa9SsCEaeWIddIPuMixOGnyAeaz7lSWfk4gzHqMDH7ncdy5rJUMvaChEh8/H9k72Ks/NXttTmxdrAgdC2ODLdb5HFwUpLKaRiDM4bwxxPZ72FDKFY3XFgyF481Ja5gGRxNml/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SS3bjb8P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONaxaN018026
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e/kCFXkZ+FKSmrJKU9OVI2V+
	ZwjvOZTNrmccxledYxc=; b=SS3bjb8PJZ2ejl3zDtHflvWwht01loKTAzhHBxjz
	vGz8Q8/4UXjt51Ur7x1y1X4atNwGD/9ezFgsdhxPew0xeurKfU5+DFCxN7+wzNuz
	DtEK5ejr9iFpdc0u79LR4NJofBIZ/LL7GMyX1skABN2inQAHTzoASGMRlOMrwsy2
	zzX9sEyqlsOCTHOkpAuFLtKHmqq7XbQ8DuVAwb10tC4cGzSn4xn8gISK1TSKq6tr
	dfG6lS7ToJpCXgmUBdcUPAfs/ZGyx9TTdjb+3vjh/Lt/I92eXpRZKmx/AwTXJEYb
	dxgOnyGKdpH7yC4hKBAap9U7ddoV8uFBesXSUnrS0gut+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkan8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:04:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b60d5eca3aso19766461cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758773066; x=1759377866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/kCFXkZ+FKSmrJKU9OVI2V+ZwjvOZTNrmccxledYxc=;
        b=mjtBq4Pq9H48ClEudVi75ysAyRUhxwuHh6rR1l195QBhKB7U1SdRL4PVHcf/wqtNA6
         asMk8fvW/4DFx2WoBv3ujdr2hl+CSCggOOJiXqkQReS3xJEQEOcZ7h/5m4DEl4qYzrvt
         l3s2igEKZHhPNnGPuYUcW64YIfQo/YA41Kla5iUw75HLlXS4BNCaYS0WmECjGn4RDbe2
         e+gQodFbBs1+LaF0CgmCtMj5Ty6b2XFhNwjaVASRC+SuSuZ0Ji5ROr0XcvGqFj0MCrn2
         yAr6F+GNp+m30OyFlAzg1vZfvfuoFqvYt7pNEU9PO9dLn9/Z183D+Vhp4Z4DHB+wf7gE
         MYkw==
X-Forwarded-Encrypted: i=1; AJvYcCWb4viZwps7tggGQhjzaIO6RC7cT5aSSqkU6BukZBc6kilaRpYZJLTVl15nsTYkZQ2vY9w2KXPIYykv1Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycON7GUkjrA0IBC1BmQ3JS08SvNrWlgbpQqymGphAWpD5qfwlE
	mJsXdwQMVIP6utBenuS0mnx/1yDC2YsxFSWwQnv+YwWSlLCb+CxFVQXA+TTQEd+0VQdseMzobm1
	3GvlKvDmeXtobKUq7kCr+0ohqHGx55egyPNdZSvcytndv5i76z2ycIEl4a9jgMwBlcik=
X-Gm-Gg: ASbGncvbXdsQsKOYBxoPqI+BnRmqLexwcuFaiqn5PvC5uiXjWLXv//1Vt3yFYuAEoW9
	/ceLdQQeFzB6Z0wcVmp7L6tri8fBKS5G3wITxv0lQFpjWD9zu5c757f4IJYgSCMoMw6RWszzpJp
	6ePUCstPorMcKgWnIpgiSXiYlgz0EW5eaoYHcjweuVR0FPif7m0RhtyjJqtHj4w4u+oBbXPjnxq
	R4KCJhDaTDMBnWboFyncsil70aLEE+As3im50tcpoNVNKtlLEqwt6ByvyVVuAos9ymq9unwGvza
	rGfAoJcoDJXPdBdodyGh9NJPbOkGMdrTxxCVDiRDIqB4pujSC0iTA7G2BgPGakK8PF5n4SZOPJ9
	QcgCs+PLQv0QynMYIJt6dlvI+ly9KrStiPkMcqaptHwpJ/xE3pvWH
X-Received: by 2002:a05:622a:587:b0:4d7:7dc3:19f0 with SMTP id d75a77b69052e-4da4d507e34mr28165601cf.69.1758773066200;
        Wed, 24 Sep 2025 21:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFswezEZS6cRTNrQbdK0fzLxE9P7vB+2rzULg2QuEV/2IByTm7hQCGVr/ysUeLXu4ScDxEJw==
X-Received: by 2002:a05:622a:587:b0:4d7:7dc3:19f0 with SMTP id d75a77b69052e-4da4d507e34mr28165371cf.69.1758773065734;
        Wed, 24 Sep 2025 21:04:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313905292sm323267e87.41.2025.09.24.21.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:04:24 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:04:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, simona@ffwll.cc, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000
 soc chipset
Message-ID: <euw3dhb4453dzlvh3hxnn5qsu6awj3jzimm776fj4zesezvw7y@2jwxktc2m6ca>
References: <d518790b-a224-443a-bbd2-1dfb41f8b0bd@suse.de>
 <20250924064954.3921-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924064954.3921-1-chuguangqing@inspur.com>
X-Proofpoint-GUID: 1yL5edxZtOKa9UKM-8IzcJfpdO1XJJPQ
X-Proofpoint-ORIG-GUID: 1yL5edxZtOKa9UKM-8IzcJfpdO1XJJPQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXzg1v+ExqpdXK
 haLhAmYOJ0+6bsi4qmQkabza9fz6XYTBDjsZK+I+I9XyoYwyGMNlSXJ2CBVAap5dIagHIWRU6pJ
 yoqIAH+1ixVLsXrrSBM1Yksu4etezZhJ4lCVKul8FkH7doigJ07DGq6gwuL9acheKuSHW/IFfbQ
 2xohB2JNyNa9Ml8BnKVdsSd1TlI9uF6+qUNlA/MEnO9Cq1AWuGVeowPREbkMoHBAT4aI25JATAL
 f6/puCAUNsHgiGLjnECSObkRk2O3zggR4mB7+JpIlS0T8VvfCMDhiqcYVhrI8tI+tfuFJJ4ikmy
 2TbhliUu5gpdYIpLuyrxo1kxL77xUVrMPdMnWbjU86EmNNmBb67XYPZ3mjY7x2vV9pj4ytm5M0h
 DSnULKtp
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4bf4b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8ZZN_PGJ1yOBtuberj0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Wed, Sep 24, 2025 at 02:49:53PM +0800, Chu Guangqing wrote:
> Sorry, Thomas. The changes have been made this time.
> 
> >Hi
> >
> >Am 10.09.25 um 04:23 schrieb Chu Guangqing:
> >> +    select DRM_VRAM_HELPER
> >> +    select DRM_TTM_HELPER
> >
> >I told you twice that VRAM helpers are obsolete and what to use instead.
> >
> It has been modified.
> >> +
> >> +struct yhgch_vdac {
> >> +	struct drm_connector base;
> >> +	struct i2c_adapter adapter;
> >> +	struct i2c_algo_bit_data bit_data;
> >> +};
> >
> >I've asked you several times whether to adopt the coding style in
> >ast/mgag200 for the DDC.
> It has been modified.
> >
> >No only that you not respond to to any of my reviews, you keep on submitting the same code again and again. Linux kernel development does not work like that.
> >
> >NAK on this driver until you get your act together.
> >
> >Best regards
> >Thomas
> >
> 
> to Dmitry:
> 1. use plane_state->dst instead of crtc_h/w/x/y.
> 2. delete duplicate framebuffer's atomic_check.
> 3. use FIELD_PREP() directly.
> 4. use dev->mode_config.
> 5. delete unnecessary drm_atomic_helper_shutdown call
> 6. add AUTHOR
> 7. using .enable instead 

Please read Documentation/process/submitting-patches.rst.

> 
> Chu Guangqing (1):
>   [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
> 
>  MAINTAINERS                                   |   5 +
>  drivers/gpu/drm/Kconfig                       |   2 +
>  drivers/gpu/drm/Makefile                      |   1 +
>  drivers/gpu/drm/yhgch/yhgch-drm/Kconfig       |  11 +
>  drivers/gpu/drm/yhgch/yhgch-drm/Makefile      |   4 +
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c    | 423 ++++++++++++++++++
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c   | 310 +++++++++++++
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h   |  51 +++
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c   | 114 +++++
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h  | 208 +++++++++
>  .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c  | 123 +++++
>  11 files changed, 1252 insertions(+)
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/Kconfig
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/Makefile
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c
> 
> -- 
> 2.43.5
> 

-- 
With best wishes
Dmitry


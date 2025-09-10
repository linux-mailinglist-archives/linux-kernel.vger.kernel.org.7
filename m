Return-Path: <linux-kernel+bounces-810909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D4B52161
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DCB562146
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918942D0618;
	Wed, 10 Sep 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GjYLx7WN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E92192F5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533641; cv=none; b=kUP4NXDSoN8igISPYKb1+aruyvl5Hfbhsu1S3ESjYIr2HGrIUiokk/ZMxRjMWcWl1ENshPVKxaSItaG7Hy78tIkgyZGeua+H4XcYpWi5Bmbel+XohXZn1LvWnQenn8AZgoOAj+OfYIAHMlEPtDFNFJeQIXxuo+2qajoPE2fQeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533641; c=relaxed/simple;
	bh=npGzIDwXLExMInt2yrKS5c+f4ljnI5Lwz0v8E6W6QFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnA/ndnpMUMwTGHJaS18nFbTBRKImUICMINEYgMPYoUntG1h5dDBn6eSnEBTy1kppa5dKVWGQdyENy9njWHB0l/h8XuglYncU69VXjuO/fnhNoxPeisZ2S5QPeYUxAb/si8fKyT6uaBL1gZUwkby+Hp1kFOWA2YyvyOGyKAKCiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GjYLx7WN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGFk0B018824
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YLXhPL9FJVDyu6T4fbEau8ar8ycdMYElzWEHqqMo78U=; b=GjYLx7WN5XLj2V7C
	pl8EgH38N29bOv7WLwGL0N9OYxijUxefqMyNLPw0YgNa0E9tBHA4wEHMvjrreDdH
	Ld/pmFiUymLijafanjQTJM/UG88FZ4AjimW6B35xXwVnvly0iubeh/RWFVIstVhE
	YHzrDBo7w0xBweCQK5MdANnLfjOjG/MDXOYhSfNIKSEg+rxW/bPRWypkszIyA4yJ
	dRaGs1LcHCrKNkfllMeCNDkZPxJunAb7BRLSWn6xv/XXhvecVMEwpkHTD3ZzLnQt
	pwpvH2hdhMXYwtwMVKzFKiLZqgVz2tGCmjLfpPF5H5XD/AgtR4gZKdfBfShjlipA
	FE6IqA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493cpb0m73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-718c2590e94so25124756d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533638; x=1758138438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLXhPL9FJVDyu6T4fbEau8ar8ycdMYElzWEHqqMo78U=;
        b=oHwgWmTIKvgGS9nA8Ct6KV782dupLIeo4nJxK0+Qp755SZ1W7F4jn9JH1zxO1Xkw0J
         cYMjnIQf02xTMn6eQfPE6cEAkk7mYsc/He9D038UbGYpDkXQnFjH2vhFx7LdWw8VChRD
         i95AY/89rFnWnSwiwXkA/9ra/GLdqaZ4Rr2dzomPqLj4GYqb0zGgP1NYbDdQxYT9gPgX
         Zitb5zBBED70OpxOJvFpq4zLXC9VHSeiWJtDFtSZMETxMCRIa174SHjpnfCjPU/hB/xr
         5YxZfGmc4U9S2JToDsuEFuoHVZjm7UhJwa4OmKe2T3UK9Adx2SZ+EZZ0j4J1AbBZFSyK
         rV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwgvCzUL/6BL7LSiSZwfcRXS+TOz5WohQPz84nBew0+lkp1Dspf0tuUadX4gzP5pydK3UReQHyBOnCFqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vJAsmFazp4l5rX6+rr15GrqIxbScCsL3iNVfoP6qo9rxDfuh
	NcSW3ov+pdeZAwpKiZIAuN0YBw8yErFyLnBGzUu6rAvrvGljeWuW/5Lx2xlCdmBBanJ8hz68UMM
	JsWsFiIP0eTLyBmk1ZxrNDZ+7SnOLpRPcAe/wPNgfozyUsoPJkmzq7xQCuJoyjQmETJk=
X-Gm-Gg: ASbGncumaAUk+0Ghh5qX7vUZDeudZwZ9IAdBJItSQRuqwQO65vonDRX+Ek7zKmhmUf8
	CqHtkaLN7C4lELITiDHRW/B3bAm/WNUTJmpTpPDyspP7B0SzjtzV2TA2Bm1RFRHhdU7uZtcukfn
	+idjg5ljStYPEv7OV2Cg8ZHVmlcwPd9wXbeuw1IqfgkNOyKnSu4KSo1N7w2VhhK18aoajvrfwQ4
	bO1KwFMB1QGDhLY2lMlmkkiABd36L1fGd0A4QYrFk3hWgHIcGw0QLyhIWGAUmRkuYBHHzS9EjPw
	bMMhW2PN8gSpCswfEPC9z9JYugWpUcVUDwpwfstGTnrMxAuJAeBYsEiH5IkFY9JUME3yd8ocLmX
	mUVfVRWz9bz0/ewDvlQqYHSNTg1MXtNvFqK2JiFvxOCOUIlFAZOEK
X-Received: by 2002:a05:622a:15cd:b0:4b3:48f5:88b2 with SMTP id d75a77b69052e-4b6348b1c33mr10716961cf.37.1757533638392;
        Wed, 10 Sep 2025 12:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPgNXrsRUYzdbRq9wwySHuZY+rdXhThZXn2B/OhJ//KGcMcId9h/P8g2t2/gTV7ZLqZAlLuA==
X-Received: by 2002:a05:622a:15cd:b0:4b3:48f5:88b2 with SMTP id d75a77b69052e-4b6348b1c33mr10716641cf.37.1757533637954;
        Wed, 10 Sep 2025 12:47:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56db8911114sm57652e87.20.2025.09.10.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:47:17 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:47:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthias Kaehlcke <mka@chromium.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/panel: visionox-rm69299: Don't clear all mode
 flags
Message-ID: <memqypjg544vwevucbo3ot4yp2ooblbpjjc4vz3zj7exvjamkh@y2yj3effj2e4>
References: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
 <20250910-shift6mq-panel-v3-2-a7729911afb9@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910-shift6mq-panel-v3-2-a7729911afb9@sigxcpu.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE1MCBTYWx0ZWRfX/uIbceTEzFrx
 NEe7x0mNZkcIPjWAfcXuATCXg530Nx26wv20IDmAKdmC09tFKR/C2SfwUmlh+6fwOCblCgpXi88
 TAFEAomiKodnSp4Mof/VmIixI3Z+ruJLYnPvnZLjVt5fuMsPqROBWnHrzSwUtmTLymw/Yo8MDNr
 fc7uJ4u5gCuQRugVmFn8JpKsjISMaQWS3rBuzuFMfa9sSzSlUdEmRNBot1Qt9T0UB61I8DRSUsM
 sROnQidI4/B0fiIyaZqxW3kUmu5EH31k8A+gvHehM62g3H9hzJX66i28RQpJAOCC+LH3MY/2o4/
 6GXV4DPLgcdt3ZFcVNTTOSf1UNoljni0Udryd2ZoEoVsxEFS1/QTQejXjjiyikKSqAOjstNil6p
 eD0Xtn8q
X-Proofpoint-ORIG-GUID: Kc38dj59P8FglpKWrUU3YufEoY1q7ujU
X-Proofpoint-GUID: Kc38dj59P8FglpKWrUU3YufEoY1q7ujU
X-Authority-Analysis: v=2.4 cv=P4k6hjAu c=1 sm=1 tr=0 ts=68c1d5c7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=ze386MxoAAAA:8 a=EUspDBNiAAAA:8
 a=feprlWPuZVWlgCd5a1gA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100150

On Wed, Sep 10, 2025 at 06:39:57PM +0200, Guido Günther wrote:
> Don't clear all mode flags. We only want to maek sure we use HS mode
> during unprepare.
> 
> Fixes: c7f66d32dd431 ("drm/panel: add support for rm69299 visionox panel")
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


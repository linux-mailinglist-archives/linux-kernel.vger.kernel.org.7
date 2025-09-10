Return-Path: <linux-kernel+bounces-810907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A28B5215D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5499C564EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129422333B;
	Wed, 10 Sep 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWhsjeUI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E05265298
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533610; cv=none; b=nFYtvCeB6jPMHAAXHGfof1H4sFa+/vumbWkzcOFHSIJCgvrpjXmRE00npMc3pEYfLg49atX9h8j5yMhiwmXbgPQXlRZqYxqh8ZohFaT9MJhpfr0bptAN9Pw1hYRaJUrsfhokYrgPYvBi0OOgUYIuTtjjZdU6ZkoG4xhFV6qDD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533610; c=relaxed/simple;
	bh=qCXkeX/+7V8Jarxvq4G+sJ4Dnz6tG5XwsJ8yBdho7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTozQ++bayWx3eWbdy5pfULW4sWlwkK29LZw7UYhMrUTbby8Z7huXK7IH6OkgB2Tk8DteqZav4Opo2HSC4atdA6EkOFLa86Mmd8m1IexJ2xbp6Diz68a7DECJl0+jgfL139NWBzSSmsXiWhVbUttrFENcQh1/EqiipMGaUpIIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWhsjeUI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AJ6HWT024503
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PpSH4cB6sYP2RTo+n4KKNJOi8FnpNbuj7itluUrIaUs=; b=mWhsjeUItIp0k0en
	Zkmqtlr8D1Csozjmsj0ub9VyuKwG2nsLpFIRoOa/iSlyAYubLasdHdkTUed9Jrbl
	bQA6c8todY8M7n6GOyw8gI5TMAnB5+VaygehzhNZJDvmSHKunG/lJgV5iPgySH/1
	a66cQiKagtBBm4MjQkFxwxy6GnODV3ZT7uQoqiqIuP2ytdYmafsGQ4yoDh6W4dEP
	2TIeiz9UD/UfI1fdhFCNIZjIO+6nl5p2eDqMuggRJgsHD8pezNxQCLQ+Fttc3Wxw
	GRF3kon5SOliEhUSE4RjaYGRGXEYDylolz9BaHQeLiM5wiLdfeCdBivtwZdD0Cku
	UyhL7w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h0373-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:46:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70fa9206690so20349686d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533606; x=1758138406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpSH4cB6sYP2RTo+n4KKNJOi8FnpNbuj7itluUrIaUs=;
        b=UPYxdjRi/Vp4LK0bCOR0FHi2lWYUkW7SQ/uPA8pnR9q1r9BXuEg/g+hTRXn2WkLcNB
         4fSKNiFf+IAgGZZmIyvDhuDDC7bSfPqvpjpofHcyxNVutTvV0J0anLbtucIqaV1xHtfx
         XO4brWfR+pEwEtjnrRj/o7Q9aLEcJrYTJ2Szr4k1cKL8XJ6/U/3rMLC3p+NgYkI3PB+Q
         ApiBNfgLqI4i9Cd8cjRr7CEtVhhtbjZymlK+E2gl+jKhJUGc29g433BUPhO/5pMpyTgs
         aZFZt93br8LlG8wxONGfG0DjS7TtYM43IAD1X2pzUGAjpoJsPSJtj3g4hLA5aKnc58ws
         9BtA==
X-Forwarded-Encrypted: i=1; AJvYcCXWfXnaPuXbfWJH2MOfFITRuYDODMF2HGkxoifXPiJRmjvDRSJ+dS2sQ9facQ/R59aMJmQDtNw6TAuDjjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInqIbquZX1mzmyi8edZbNVQ0XYsVOY63ikvFtnUOaWLKbYFHd
	uo/eExJpldPwUdO9D2KgrrqQ+NXrclWQGYNQ8d9QvOj4YPEQX8c19galnBQPMUPfu1JeccHZVQw
	2KU8hi4sE7d3bHTtcH8Rol2ENrR1ingy2oxHdHX4bLGkE+jKQd7Uk/s6110j1LItu7FI=
X-Gm-Gg: ASbGncuIyQlI2cgbm8nZ797NU9RBkYCgFeAW4jwf8fiPCsoGCy9zBNPeArroLATZ5v2
	smxjFCh0iG/4uw8XCBFfIRAB5yj1ZhVd3r3SCGUeOKeZq0WLmFu37PIxQzbQY/Gbn2EOyM5t35d
	uYR1CJHynpuxQC0wbqWl2K3bGGuXhgC6M9tZSYxZ8kEynDtqyinTezvmh8lhSx6kgL64PITELjf
	GDLGOj5JoLMNUuRPnwfZv97j0mn9iVbvHcyy8dGMn3DsQyb9mONLusM6VD+J1w2VBpOGBHwdeBj
	FBZ205oUclMmg3ck1zwz5h2hZskbVTPh8/UXVHIKiq1o/BbLtt7HXvCfVI4GjdCqkoPxyCF3aOq
	pmg7vxZngnTZKYLaQ2Jzq981iztGOWMJ9k5GyVKfPLsj54HMXjf4r
X-Received: by 2002:a05:622a:130d:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4b6346f39e1mr12762291cf.12.1757533606244;
        Wed, 10 Sep 2025 12:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtJNlip6unYyAFEHPH8m7ysv5kXijpQm5w+h7Po8npKifdCR5iLzClbPTHw8tWnlyExjczeg==
X-Received: by 2002:a05:622a:130d:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4b6346f39e1mr12761961cf.12.1757533605755;
        Wed, 10 Sep 2025 12:46:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56db8911645sm55335e87.9.2025.09.10.12.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:46:44 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:46:43 +0300
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
Subject: Re: [PATCH v3 1/3] drm/panel: visionox-rm69299: Fix clock frequency
 for SHIFT6mq
Message-ID: <iarovbkt5vpzxpkxyvf4d2pwfa2i737vxridggqwfoxmvljyzp@mnhr4sgadfrq>
References: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
 <20250910-shift6mq-panel-v3-1-a7729911afb9@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910-shift6mq-panel-v3-1-a7729911afb9@sigxcpu.org>
X-Proofpoint-ORIG-GUID: RB6tqkwcmmuvhB8W2l7GzO9SXaXN4zvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX/gktonLC8c5W
 pYwNdweOdA1RlKl/+X4r4x1QGHom0o2qTYqkC/uHyXTq7usdcxQ5xFAcLIogfgDlgglj+SbdVV8
 zkUPaRmFs9vMFHUKN+bJzdExdbPefv8qF5ShI6RaGGN2uxCafoK3FLBHDu53B7ZG9OFI9jutHIy
 4EIrDDRAKoRsN1thDO/9V/HxXB3UPyAXsq0JT0ESfcARw8WRu8rsglP9adMHJ+cWAedzGppVRQ4
 RsBBnGCdQrZD/LdFt/cMuoyyiTbhzwBqDI9oRAifF2c5Djf6hQ04ErOfP3PBIrlzEUq1HBT6rmk
 607Vgiv3o8KrBTKK0pirq9YmwRuC6SPxi5ATshFg/0/3CG8pt/w+MTcwyD8uwGuahsroixd+H4Q
 70uv1Aoy
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c1d5a7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=ze386MxoAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=v4Hecdos7qkWo24Wf8QA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=iBZjaW-pnkserzjvUTHh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RB6tqkwcmmuvhB8W2l7GzO9SXaXN4zvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On Wed, Sep 10, 2025 at 06:39:56PM +0200, Guido Günther wrote:
> Make the clock frequency match what the sdm845 downstream kernel
> uses. Otherwise the panel stays black.
> 
> Fixes: 783334f366b18 ("drm/panel: visionox-rm69299: support the variant found in the SHIFT6mq")
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


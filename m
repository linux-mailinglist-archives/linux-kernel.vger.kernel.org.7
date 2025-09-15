Return-Path: <linux-kernel+bounces-816733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9BB577B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4105189F8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01572FC86A;
	Mon, 15 Sep 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8lPHVRl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2862FAC1F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934698; cv=none; b=dlMY/44ML39hP7KxDwBvn6gASIm062ylSFJgnZvJ0EG8DxU8ndCgBXtc0uqFqd5MODzW+7k4s7rP7ZhwsnfH3JRTwUZbz6ouwv+li8R81xZhGZqs3OM7TSESSoV+/Q3Mm0yUkHyLQmDtma08LoJqF+nN27lhPXPqFa4E53J64Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934698; c=relaxed/simple;
	bh=QwQxSAAeBlvaUMXjHQi1tPtJVO6+Xzp8Xz4RKXXn9R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brZcVmCysGZMuBhdwDfYGX2KKkEOm4KdWKQwSwHLfkPbXhRQEZnIBq4HSGKuv7y3M3s7pEr1HTdAN+NkeTX+c1JOtdEfbpvgRVknZF1Mi4mn1wD5uAaIaaIUAvXP7A67ftuoG9uOPmT3MhjJ1pIk4o6Js5Z/ENCQDMvntjOHQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b8lPHVRl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FhZ5027228
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XdB3ee82a2VvLPTM8C2BPhUv
	8QQP4Ys9XkdbXnW+eOQ=; b=b8lPHVRlg58D7grObMkFW2yhxHYUpSReSO//bFgt
	K1aPjRR7J4L3lRfXgQNWz4WNwK2QpCBReGkAlR1ZXvXlHCTLmsbHvxe9dFU3fVhU
	ewylHzFtHiW8t05WXwmLq4c/67lZUZXTWjs4CcgC3fTJ9Ng6j3zT2D2QVycPLtTd
	M1zAUE3tFEXc/hW0xkLgZVnqCUEHYTUvZlpaAGUY90kF9eVRD75BThmSVkptX5YM
	HSu3MpXvUo4tN9LxZlaMhnIKe8GhtFSU3zf8QosHclgN8eJeP5yFBCsJIVXZ8TI+
	f6SBjAJq1eVDMG5aJ+JkxKeiF7Ahl/+r6LolX9UoLgsP6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072mpav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:11:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-77d39d8f55aso18518166d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934695; x=1758539495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdB3ee82a2VvLPTM8C2BPhUv8QQP4Ys9XkdbXnW+eOQ=;
        b=IZnCt2K8q8XVgrIguV/sAkR+WB1bEaOpmncB0bqhf94JjIhUBv5lA0YxsaB9w8boTE
         e3XtL424HcuV0KJVipUzxcfA4Pl+zulDurXcz0+eUnfVJXFvJA/KN1Lzhv5q5Dt1wzyb
         mDdMSi8vxqifsS6UHDiBicjT0AoWssod31MR5XMJA9X7nUAm29QULJri6p722AqPGlzR
         +dmKTmk0AWyBjHrzaryJh0ODntvrKUv1IIZ7yeFPlqq4dNW+0XftN0nSHkKpKyz4WGRw
         wyXUGcU0GH7tXW0KjAtXk/U5q5DDsv7ZcL4NycyDyhqTLpOkqA7MYc8ofU+ej+uKYoMp
         7OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxNCFLsr6RgJgj6v4eC5vFd/k3KGQ0CjpDeD83J2HDAE2POYr9k6knWbqESdXI/0HOmSj8q0x7powvFmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEy/1ktTIVYVhDs6ozT++HmMwj+y6VAl2E6Htx3jlPFV2WR0lu
	VoIDuxUfmT1fRW1NW2zty85bdCVpiqy97+a2xhiE4IOrAuQecrv+3pVhc4h8PudwJKdkkH327Tr
	3cy2tRhyeM5MV6zkd0GKxAHpZw+kaIPRnJAVwSHDDnfKfq96nNLki2LNW0W9OJaAxb7k=
X-Gm-Gg: ASbGncsk5nAWXhw370xRLJSWuVex2QZaASjOehp3cX5xJlVnMBoKtCSlIAa0YJGK5Uw
	uNMzw3qvYuY13wPcc95PKTq8VQ+WTCDY/IfsOuhjvx8jYA01dyc0Ckygfe1H3vnjg0SKSZkDvcK
	casOCXnra6Ojp16z4Sl3eXy5UFVP14amMESx3xqieXHY1SoJmrOBrDRz4NayfVHvuciilohH6wo
	nvKrmDSdLXxBHRgtzjEHeC/fyrdxR4JtjYzZilYtUHNESoHfcI9UO1MtHg7ZYdfWkrKibqYkzUv
	fDW6qHSOcR+rwtAP5sVtleaZzzl/sUjmeOkVJcIR0ONFqPfYXExBhHO3xZRlzZxQ+WxfWd3i+7t
	eh1vRiLN3lGch4VVlwjCGWXfSxTN+s1z+DBsLyFZuUnygqxzLWg2K
X-Received: by 2002:a05:6214:9ab:b0:784:b299:9c29 with SMTP id 6a1803df08f44-784b299a052mr15325456d6.26.1757934694558;
        Mon, 15 Sep 2025 04:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT3PDb/ZyytqoXXQM/9aC2/b+zBIr8oo77lrn1IuoMlX4o8MvEYE7fMWu3HsGJjprRAtyb1Q==
X-Received: by 2002:a05:6214:9ab:b0:784:b299:9c29 with SMTP id 6a1803df08f44-784b299a052mr15324886d6.26.1757934693893;
        Mon, 15 Sep 2025 04:11:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d4b5sm3552605e87.97.2025.09.15.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:11:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:11:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v6 2/3] drm: panel: nt36672a: Add support for novatek
 nt35596s panel
Message-ID: <a5zz3piadpmi4atnnafa5bfz32da4nioob7xsmqtyhgpjpqz5c@zzoa72rgwaet>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
 <20250913-nt35596s-v6-2-b5deb05e04af@ixit.cz>
 <xi65tabv4sgblzmw52wxci5wsrdahshvos5we5wko4kfcfyozp@y3vw5gt3elwv>
 <ad1764a3-12b3-4c30-9b79-313d9c1d37eb@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1764a3-12b3-4c30-9b79-313d9c1d37eb@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX0iz2dZTnKkas
 JI4+APCZQddNoiRfHgZmkjecclTLzgpu0hXn4YcbCRuAexp3EI5XKvcbhXFvr3Yju53rCq2+VH6
 kJHJcGhfN5V/UseV4792U9Zk/uDwgMV76FPZYOLqGsHU4cznIJIgXg3wRghk+HM8m1I5J7GZXCl
 o5J2s3qte8hyTmnzgRqAYOxOib3Vm/3rxLX/nEN3l8zVJGpgf8oZ1y6JCSu3osmvJ/T/FV9/jYe
 UmR3vCyQgILs8Yqr6yR7cpmDIBqzYdc22nuBkadKy1kUkkB7SJdmeqNWjSgNp9jvEt9tWjKSu5q
 OAgsWmPdCnEguJyZ3LjhzDj4t+NU9e+CwSN9VFfNd4lPAtlZsSq5GQMhr97DNnj2O/UcGOiccKO
 R8IJ3iI/
X-Proofpoint-GUID: vrDZv6gUplIzU6DMSw4L2u25tvSNDp20
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c7f467 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Vt2AcnKqAAAA:8 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
 a=QX4gbG5DAAAA:8 a=KKAkSRfTAAAA:8 a=mCu-rAxjWtjh-wTS5UcA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=v10HlyRyNeVhbzM4Lqgd:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vrDZv6gUplIzU6DMSw4L2u25tvSNDp20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Mon, Sep 15, 2025 at 12:11:49PM +0200, David Heidelberg wrote:
> On 15/09/2025 03:29, Dmitry Baryshkov wrote:
> > On Sat, Sep 13, 2025 at 09:19:48PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: Molly Sophia <mollysophia379@gmail.com>
> > > 
> > > Novatek NT35596s is a generic DSI IC that drives command and video mode
> > > panels.
> > > Currently add support for the LCD panel from JDI connected with this IC,
> > > as found on Xiaomi Mi Mix 2S phones.
> > 
> > Why are you adding it to the existing driver rather than adding a new
> > one?
> 
> Hello, originally it started as a standalone driver (see v2 patchset), but
> got merged due to similarities.

I'm not sure, you had to get rid of the two command sets. On the other
hand, adding a new module will add a lot of boilerplate. Let's keep it
as is. Please add some notes to the commit message.

> 
> v2 patchset:
> https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg404290.html
> 
> If it's desired, I can switch it back to the standalone driver.
> 
> > 
> > > 
> > > Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> > > Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   drivers/gpu/drm/panel/Kconfig                  |   7 +-
> > >   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 225 ++++++++++++++++++++++++-
> > >   2 files changed, 222 insertions(+), 10 deletions(-)
> > > 
> > >   MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
> > > -MODULE_DESCRIPTION("NOVATEK NT36672A based MIPI-DSI LCD panel driver");
> > > +MODULE_AUTHOR("Molly Sophia <mollysophia379@gmail.com>");
> > 
> > ??
> 
> What's wrong with it?

I thought that the module can have only one MODULE_AUTHOR declaration, I
was wrong. This is fine.

> 
> David
> 
> > 
> > > +MODULE_DESCRIPTION("NOVATEK NT36672A/NT35596S based MIPI-DSI LCD panel driver");
> > >   MODULE_LICENSE("GPL");
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-845854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582CBC64E9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4CCC4EF2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC32BE65E;
	Wed,  8 Oct 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBn02Xab"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25429D29F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948383; cv=none; b=ZCyg8wvjNHvZ6AWlRNL0lRLTq5uOj5uBY4T4kQdPgyk/eccYYf1dCmcG+/p1THBcP79czYZhf4ohcVCi8We9+CDi6Q67L9OWnGg9T9662oRaGkjD16hyKT7vUuf8YbvyNf9KUK/QRIAdCtuLv/i7wVScsl0+MRFngUW5N5iCPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948383; c=relaxed/simple;
	bh=qDke/BM2wmbXha3fCsJTXgNDkLrvuoMC8xxXT54rWIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDzlA3rBcaDESxAVtHsM6TwHwZnLqJM5DUx26IRluRZ/imb4jgg41CeIc9pvMi7gbTMxSquPSJw+LGb/LT4Lzyr7zbn+EvrW7fhMqhSDtWUOzjHOgBMjtOjgVFnc99U3Hpw0UR8VSPH27+aJuVoQUZ/in7QPrZ6Z3eUxNDBIwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBn02Xab; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Nvk006858
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uFD4df5RVTDSBvx+9GtUJ4Q7
	lrBDG5kW26hkOSa8Kxw=; b=kBn02XabcCGocFusnfHbgnDuQWz+udQzsY6QxV/X
	NupzML/17+PkjCXr2TSO/QNts0KXHKmDsfrVRZVlWrjKwchjJqKrHN/Ilyar6hCT
	xMojJyUMw91HgYHLcATnP8bgAg7jrMH7JMszaDxhljK0bcHJy6WYwIQ3kyaWlDX6
	Ttczkfl1vHfXeVDWzrs0Zx/MJrY5WGnvnjJZuvF6JLb/MoRUjI/aqTs0o5bYQBU7
	RZMWR1QEnHl9XskyXNn24Y/VFx4nj9IymCenT2n9lg9pCjxeRyGDywL5RaHEOuir
	BbHeKmry/irlA05ieDpKqINMpVTA1teSnErBr7N13Wi0oQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ng8bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:33:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e002f413e4so1413681cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948379; x=1760553179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFD4df5RVTDSBvx+9GtUJ4Q7lrBDG5kW26hkOSa8Kxw=;
        b=pKDf8KcuyiHy0qWdSlhQLmEKl0/VK4kHRLJuf/kExvGrHvpkpREAmGeEEmTtzr0jVY
         sAHk2VUbwUcvyszcOZkujCCbCu96xsbT/WOAXPtfHfS8fKylpRfSnXw0Zv3FL7SBvnLl
         uFSQFbEWVrduGVJM5mAXzHHqM225lJqDW+k++ixI9uTUlHBaYh9nOyhotEJR6iNcVWkD
         d/KNi+Df7H+NHKWZT3LeWYYP5VUdIc3o7dlso4lkVWadYJwW0e+Zwx2D4OPzuckp2oje
         cmjw5DvPT+ubZw/k4nFwwhyxZKbNSwKt7cV72o4xg+NGFnDXKW3JsfY/PMfS43SRfcOf
         MhWg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KsLpB2zd5F5s19E0vBG3nK9bQ2Ag8gu+LPyP3jOGW1ArXv4bAOFlyZ/dedv5d0WsT7NmM4/xakQateg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQHscWPLtVcbze0rLAL6K25yMyD88c5e8w8AAicbxy9cjNodq
	1NQiW1QKYN0H2N+xZE68OuUnMc/U6nMkwsBybBkCvu2x6LC6eREyFOEFH0TGCHkcPRae6soQFH7
	30zfowpQl/t1Nh2wqf6pSQACMUoBXWRmR2i8vVpRgcoI7K2LZCN/2yi5uwz6SRbMFls8=
X-Gm-Gg: ASbGncvY5H8fbDNy7sHockTjTcmf8ZI7f7Y+b+ZO2rVO1dv8te8RB6sNfYNXr3FqMNt
	mQZ02fOaUWYjrZ3Ybb9ueSlYd79Zr40AymlEsW54Q20nOBeirBphEWEcvM40nyqga0Ge3CjqIrr
	1i8lKS08yWsnQEfisqj0hH1BG4g32qZL6k/mxYWmtA8FWOwT3zRRM88h0AzUZcWwTHg4o7cB3Lq
	2mcqHsdkCngT5D9UxOnkNBqhBTuXgQvqGw1sBly9bGRRUdMNZ+LJnjup+S04JVVfMKYS1t43wR6
	67MNUMsau7tBUvfCVN6kuosTVp/D1fReAweN8nlvhVukAx8jwN/IYg5P3n2E/PL9rv1St0ra1mS
	7DxsbwI5QVYipfc7PXIyt5H4cBDsQMZGc2szXt9lcSI09fCIZXLfCfWj94w==
X-Received: by 2002:a05:622a:4243:b0:4b7:aff5:e8c2 with SMTP id d75a77b69052e-4e6ead657c4mr64863751cf.58.1759948379384;
        Wed, 08 Oct 2025 11:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr6nmjALj73kuexerv1ij3pJGq6WPs4p5tau95RG0qWiEpKmUR81JMI62GzhoYVdRJukhxfw==
X-Received: by 2002:a05:622a:4243:b0:4b7:aff5:e8c2 with SMTP id d75a77b69052e-4e6ead657c4mr64863281cf.58.1759948378796;
        Wed, 08 Oct 2025 11:32:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3bd2f3csm22438751fa.59.2025.10.08.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:32:56 -0700 (PDT)
Date: Wed, 8 Oct 2025 21:32:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-asus-z00t: add initial
 device tree
Message-ID: <q6iwjhhzr3gp27jnytm3xa4cxi7tw6h4x6grpvtnnxjwfhp2p7@25vjxdyzy6jz>
References: <20251008182106.217340-1-xerikasxx@gmail.com>
 <20251008182106.217340-3-xerikasxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008182106.217340-3-xerikasxx@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/puLlUaS8nA3
 XCC14Yk5cmqxdqX4UVGdK+IUssz0qI3MLG9Yz38VfoB7p1cmsavTvwyhBbiklBvGEJ43x4dW08N
 Cct+1AKzg+9aQ2e0SOwAkG9cWr234j4unVegxGi+wWsBlWSl27vKxlvC0UpLoYIA+yRDF2KZsPb
 GYgL1zpg5ggWNkwrF6sj8qtVwKov0Am1D1qmgql1HgRrMjKV8Rn8YUJMPZQuG0JvsozFb6BOIA1
 DYO9H/8LSP9F3XcwZz441H8dE21XFS15U9HA9wc5Sppp/FwmfPI1lvokKHNrC2t87tuVmHILWC2
 uc4wjcnKxY9mHaa72gYF2uYtxwhVS/HXTB+LH1Vn5vYgFwhvqb3e3Bdievx23SNzAUC0JGhmNBE
 P4i57oYJK1tl7+kbYKGoagTKyvp7eg==
X-Proofpoint-ORIG-GUID: edUzbILIMiiUcr4pBRcyJPuSNW3WxOsd
X-Proofpoint-GUID: edUzbILIMiiUcr4pBRcyJPuSNW3WxOsd
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e6ae5c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rlI1ognr9DFfacYL9GkA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 09:20:20PM +0300, Erikas Bitovtas wrote:
> Add an initial device tree for Asus ZenFone 2 Laser/Selfie. This
> includes support for:
> - UART
> - USB
> - Internal storage
> - MicroSD
> - Volume keys
> - Touchscreen: Focaltech FT5306
> - Accelerometer: Invensense MPU6515
> - Magnetometer: Asahi Kasei AK09911
> - Vibrator
> - Audio input and output
> - Modem
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> 
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../arm64/boot/dts/qcom/msm8939-asus-z00t.dts | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


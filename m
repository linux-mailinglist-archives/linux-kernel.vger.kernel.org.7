Return-Path: <linux-kernel+bounces-737226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F262B0A978
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1873958360D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED342E716C;
	Fri, 18 Jul 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hL3fYOQC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC262DEA74
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859709; cv=none; b=uMhDpM4u5AtKE/4zYO6MbTiIam2IkzC8qgtWvAvG2BIHxXtjzdsQW113u1BWGRSDA9o5JDRi1gZKS8IzdG5D6dm9d4cONTFt9fLK3qt5fdtfhEZYp5hv29aPXE1OuMimWbGQ7NuVlRWWhT5jlREE0LWPLOh8cZKcwbm5XufPS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859709; c=relaxed/simple;
	bh=90B31psnyuDI6zcbsl6GMlpN4O29mgnxLtJPusFpi1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz+LBP5fxXzq2fAYUsorm6VFhcNCGoNQl2TaMoIeTsXHK/lOwenZSfM5e+ixDE3geeHDhdXOdnEzjYVZVZGFhQhfbDyS69t/3NBnjsxLf7VyUubyJag2dealCN0oqkNg+ey9DMQ3nJLbMs9KmERoUDnm3DdDu57jDfYFEWUFs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hL3fYOQC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGbMcL016545
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3LoWx9DJ0TyeqCc/zXgNGefaOcySK/itM7vHhC503E=; b=hL3fYOQCMSzfdzZe
	ARYdewThhNQpHTxU9N5K5FEGaVx+b6EyURyjSKgeEY05Surk9walCPC6uH3da5kM
	moiRe8ECpMYOhbwKNv2N5EZQP99VZA8OMHEFDTFQkoM6/eThJPecHLpCq6DZWWt7
	zLe7E9CkPzejy4CdqKdIifKZEA6CUdob6+dbeWyHbNUXJyxyzuRpmYtrYWX8XYnx
	Jmv9Zq/6pNmnNLa2Tug6NgWZTA+7oXWZn90cUMOOkoFhaz8iYAL1xILGlbSG6zMQ
	vjuQwEXALfkTvBftllkkaBt9BreiI61wcEFH6BvwLbyNUl7JPgYwRBEnUJgifCGx
	XJbQ8g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyyc6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7da0850c9e5so353367885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859706; x=1753464506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3LoWx9DJ0TyeqCc/zXgNGefaOcySK/itM7vHhC503E=;
        b=hcqGZ5kbH7zLFlxTTxmP1ODsSKQw1FA3r0QnNViaK9yYB+EpkMfymtPmNPkvpUvNXh
         lBaEwjuYDtXU9rFP3i2FoQSuVAmH4jd9Bg7qy9+J4luXI/L5zPSu+nkkzOsehUSkwYIx
         qpinV6X6SnflgxZWIo8Wvr+kqmEYnjk3SVWpY1OpO9hSWpQCPUokHm0wxW2+SIK1a0eW
         M0keML7nyL5jzbcZytFANSFqd1IMTx5YA5+8KmVDUncgaEeP1LCtrRZs2fid8YZE02lg
         3TSXGqBd06K6ORKWu5JUo1GKP5AVyP8kg0vOOFLppMAeKfHbLCwKPg/S2ZTEAbkniFHN
         +M6g==
X-Forwarded-Encrypted: i=1; AJvYcCUiugiWjteYuOGNIQFReSDeSPJcqsOqPaI6tMTk2zPYqqMEENqlj12i7JiR0GZ3YjF2qhAq879yT4v9Rz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVTeQ35NPimzW6OAG5/mkuJbMHWh7elj0iG8Mmb6eqpFWZu0B
	5uHZmJx9sO7+bHpOSzA7nUiy+wlFv/ju5rMkQ7QSjsnVWpGSoukj547byVWN7CGr9OSBG0yqu47
	6zNzL/95jiDJt0UoOixigBZncdXw/NaJpKRVF7gYtg4/sJg8cnL6Xh5GwnFMtbnQ+AJc=
X-Gm-Gg: ASbGncsukG6P2Nkx6rpfV4O9YBJ/s3JDV5kbhrLgjPhsfqkdvQWKqOtSXLXSbbDu2UC
	hcBIszz3unxI5eYizrQ4jeYf4V/0Dzi/8uEKPrnV8cw0HX8D5gCJ4/mSg9Si3eOQWGgoa251eF4
	SBh8Fg3LajuOO8RCnfqfZ3N8sQq6VsFPvTW5JBw3agrqwfOsd6kwf4pqR11KidLAafGTVy2Vfpc
	kKV3y7y78fOjxp/Nofwg0YysAKuiVqN7yhjDU+S+ac+xLy3Bf5Y8p2bHnrp9AFvUaOBZUhVSSFg
	jjqXuVTBCfojiCQ5djLhHyVLLc7CWv619M0gcTAw7FP9Ez8ZoYSQRbAB38SsVllvoBCLDmUsbxJ
	Sd6tP0gwfO5LYjRDmoxcoduR4vm9knO1yA6l1ZGDUXmiYDMSoH5Zx
X-Received: by 2002:a05:620a:31a2:b0:7e1:ef9c:551b with SMTP id af79cd13be357-7e342aaa43cmr1705214585a.14.1752859704716;
        Fri, 18 Jul 2025 10:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi1fx7XAxIa0TvF/aFCXfwm8ex0+eb4Ytu8ukrsy0ujfZiAFNB/UKSTVvQ3I4n6jhoSky01Q==
X-Received: by 2002:a05:620a:31a2:b0:7e1:ef9c:551b with SMTP id af79cd13be357-7e342aaa43cmr1705206985a.14.1752859703989;
        Fri, 18 Jul 2025 10:28:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b71esm334910e87.30.2025.07.18.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:28:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:28:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: Don't use %pK through printk
Message-ID: <kb7m3ybmvpt6ywbzawjeqzzxpinc2k7b5hgm5333gay557hxrv@swg4dz4sh7ft>
References: <20250718-restricted-pointers-drm-v2-1-3d9f8566f927@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718-restricted-pointers-drm-v2-1-3d9f8566f927@linutronix.de>
X-Proofpoint-ORIG-GUID: CAlX2st0ThPCj_SRIG-TGceIsh8JgW2f
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687a843b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FzZ3ZiyTMWqXPo3om_sA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOCBTYWx0ZWRfXwFPNuKFvvxlB
 x5/4s2Nj4Ud9B//XJYdm4v0pvSg2XjtTic+K7s1BW1Me+KknNcdLY4H+RToCGdRuSAzGHuVHfY5
 lG/El52LRLyTtGRFDBzCS3dS4vAhDVKV1uDiGY4B87LxGfnD/G9wVcQ2LCMKF5fIA+zlv2tlOJb
 bWKIQ/5vI21JdoWycp2MaXaHez7UkfqREGPqDG7GPfK7sgQTelTmFs1TZIyFAQnpGioEeCPxNGq
 4fYjG0u8YSmJBOyT5ByR3Um/jFzq3H1pIehxEImGCS6z7SmedpKQaNQzG+fXDextWgS760YvCkL
 3hqnFRF85l9xo/WqaEcieGxD+mZRnoH3ilex2RdIcWtz0dpf1ROCnAiuCcK2tPdm4XshmwC/jne
 T3SkVxnNU8JD3mSp1Htxu6PsX645nFEEBecIhBQe+n/7wvK0df5xAy1TkTYVUpCZMZGtpzvD
X-Proofpoint-GUID: CAlX2st0ThPCj_SRIG-TGceIsh8JgW2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=947
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180138

On Fri, Jul 18, 2025 at 03:27:37PM +0200, Thomas Weiﬂschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Drop already applied patches
> - Link to v1: https://lore.kernel.org/r/20250618-restricted-pointers-drm-v1-0-781e0d88cd92@linutronix.de
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 4 ++--
>  drivers/gpu/drm/msm/msm_mdss.c              | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


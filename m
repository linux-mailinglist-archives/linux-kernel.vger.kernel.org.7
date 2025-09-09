Return-Path: <linux-kernel+bounces-808497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D88B5008D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F47C3A8A72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE19302759;
	Tue,  9 Sep 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fq5ymuoA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C583350D6C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430106; cv=none; b=usT3FQh2bd47FG5A1wkLN63KAF6C/9MVpSul4HaEKyQh12eDjRVMfDPHs/E46OroCxX+pCbmRBwTWcLaI4J/kOhniDmLqnbB+hVm5jEzqsK0P1BM9QhBp/XmuF2MgsrtATM4xDOq4OOjwpf31ydduoGgCX82qntboabXQm1nQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430106; c=relaxed/simple;
	bh=C1KSsn2fwC2E/SLQEDeJ174av+Kw/fJ8vG0zw/sGLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/ruIqVpA3SQ4CfZ5ufE7X/1C/8iVTe5c8pxInykLSY2LzMPrm5j6p2MOcgrhSq3sdLV22GJ8qtBsoXefBPObD3Q2h8Sn99sNbRmN7kVxro8vTqo+JsP/if5xTH8CqSmELbE4mevBrxbmd2LhZgxmmicdcg5QzVkjIu2OCMQsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fq5ymuoA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LSuT029173
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+YAkGp0Was8SY+eD78frAm2r
	kjGCrvc6KWsSn1t2uZE=; b=fq5ymuoAhCxfolSJ7QsAym0GWLEar7BQu4+tpmuq
	o+JzNNpJQxs4yIecyqSOB/xNjJQlO9N347rAkP7ZFcqiuZXPMbMv+zwM2Y9GhVV/
	s5jvxgSEGG+IQlKe3s34ii9GYGguXNOhEqSWacsDMmxW6uPYXgHJ1xkJPHTRcuAb
	nz1n8yUcCxfG0OMnlj6Ys8VvJc6+OXo+9M9mmAFMRgzffJbiNTXrRV/np8G8P+XM
	zY0DcvMHF1f3ILkY8XU6FWhMUDZ2pkBiGe1uZ3Vi1XTNW1Y9JIPzcK+cLIPm0jCV
	Vwer4dyuWdpJ9jlYLXCtjGGJoGAiJZw77FiF+xC2R0ogAQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8gmfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:01:44 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8972110658cso10878807241.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430103; x=1758034903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YAkGp0Was8SY+eD78frAm2rkjGCrvc6KWsSn1t2uZE=;
        b=MIi8uYhG3jqfHHC4XABMRKV29kbFBtf81DQh3Lg/IebnW2BhU/Fnxi7hTSFypa+HOf
         uZKlmVY9Z/xt54SKnXIBXDkIr12O6Daq3kFcaumHD8RQqwRft5k0cX+KP6UbYzSyCAfU
         eLl1kMFTnHPGZf58H5IVqjy8//dzsjpsQZWTQx1Decru1CAuqGiAPNiKWCqBoxKzeCO0
         b3Bneid+0bC/7Fdgg/3Pa17HsKqt3FX4bDyRjG6jZ/jX91fLzJDuwjmiqpOkcwP1qqUS
         xNbw4v126+ExJK1Fdwf7u4zypn5YhGr+mWjJSkdiScjqeA40NOMOin69Z56FH1mpP62b
         Armw==
X-Forwarded-Encrypted: i=1; AJvYcCWoz2Nbv4kiwt6G8vznd3mqeVpWXR49Kb5Y1yvUk9g1svQiK3H+/WcPIDAqktJNMbzplaCGkKFhc9hMwTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/c6s0Bues5XC6AeR6b8SeJtz+3nq7dSWdGFJIbC6l6/1N5uD3
	eWSkvfyYmC8iP65JYWXuixcSJ5hjkflSNbnperO2Yz/FyiO+F/YPuIgkaGKrq/Cd/nRDwJc451k
	sLtMHM6T6LzObt+6cS82i6Fb20TNbzlzmuFtSLDYNFdTjLmIKjuN+ulCjvQBgxs8h8Yk=
X-Gm-Gg: ASbGncvF+6zaw4EmnGKOMZ5cvRRJ7j3b7+AVm1P5oZ2HBMy4rIKCdcRZctW4u29GZhs
	mm/bVGDZKumCFgJmiEXDaeaglwkJulNZwWPJipgjTYnhL5uy1JIN1p2+vqKJy83EMJUovSMrdoP
	d5Ix/iXF3hmZRf3qvMp3d/Tw/b4SCoaoEo482b9sreQWoe18j49tO6TQ9e4IGgQpqT1sXEOwrA1
	MvcfQb91u7jFDAd0ROfwU2Cz+VzUETFFFlnLxuYUQi+nILjPjVi0oLqh6h+V7lD+Mq7PGHhWlgt
	M9LPLaJ++NoX1XXzOwm0m527peVeA0rEKO8isgzSRmAk5UT0SuN8mqjzbC5+x30eacEkL51D+W9
	F0wgZKqwn60CXG7KQ0AgMkQlyYlTRPxj0XQr175K4AGg11beBK3eW
X-Received: by 2002:a05:6102:809f:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-53d1c3d661cmr4304923137.9.1757430103276;
        Tue, 09 Sep 2025 08:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbmFVS3O9rFOkq1qoy/EYq4X6azRKsts/lxojCWvOsI6IFbFnDvbit2/OPl1wUqGZICszRTA==
X-Received: by 2002:a05:6102:809f:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-53d1c3d661cmr4304813137.9.1757430102638;
        Tue, 09 Sep 2025 08:01:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm587402e87.61.2025.09.09.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:01:41 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:01:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Karmjit Mahil <karmjit.mahil@igalia.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] drm/msm/registers: Sync GPU registers from mesa
Message-ID: <2rlos7qjnawikqhotu27svqyo4yevpc25cugscc7tihxz6go73@rfas2xavrn2n>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
 <20250908193021.605012-6-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193021.605012-6-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX9p7K7ARuFkZA
 JEJBBrgdqLfc6LdbPKFbMDt8aG9L8OjmXUnoJfSLH7sqcrpYz4KQSQygGOTGFqMHZaKOYgzL5IS
 dBhH2GhMlDKUKlEeswOg4euB89nv7QzZgGVfkjepxSyhX3TVAKe3Bbhz6UzygK28J1+tQJWcYYq
 XjQqZxwwu/s+NcpjzZTIa/JKUk6Nsg1kNYOFQVJQhj0FGNJoM09BdJxy3o9EJ2zlidsty+GcvR9
 8Dw2SnxBluCKq+qaW0GIgde2myltg96l0HeWl7edH1+3s+kpogmkGi2oAtRlAjud2B/VjzXlOzW
 haBIhIUd9bY3prjHI9a9PZFn9e5X58y2dMv+yUfMrWVGQF93XkfPfzmisianr1eb9ZUnqxjQFaN
 CG8G1lLT
X-Proofpoint-ORIG-GUID: 0KlCUuSt7Pb3LgY4T6xPBWBLB6DKQdBn
X-Proofpoint-GUID: 0KlCUuSt7Pb3LgY4T6xPBWBLB6DKQdBn
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c04158 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8 a=rLiRm7ZfGlefp7lywOQA:9
 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Mon, Sep 08, 2025 at 12:30:08PM -0700, Rob Clark wrote:
> In particular, to pull in a SP_READ_SEL_LOCATION bitfield size fix to
> fix a7xx GPU snapshot.
> 
> Sync from mesa commit 15ee3873aa4d ("freedreno/registers: Update GMU
> register xml").
> 
> Cc: Karmjit Mahil <karmjit.mahil@igalia.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |   8 +-
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |   4 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 702 ++++++++++--------
>  .../msm/registers/adreno/a6xx_descriptors.xml |  40 -
>  .../drm/msm/registers/adreno/a6xx_enums.xml   |  50 +-
>  .../drm/msm/registers/adreno/adreno_pm4.xml   | 179 ++---
>  6 files changed, 508 insertions(+), 475 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


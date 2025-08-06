Return-Path: <linux-kernel+bounces-757143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE597B1BE45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B2862251E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA5155333;
	Wed,  6 Aug 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZnCqWYl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F4145346
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443500; cv=none; b=nXwqb2yW6RMfYfjw2ViHdrdG9mLDxzXpKUbmSuf6Tv7wUIYj6rcEtVZK5z2N6MRrNLQE5iAjGgasaCAeV6aSG4pJxUYuUJh7TKV2NBnhVEkZ2OZEXQpXlXOlHVgVSQZD+/3on2Bf9mwthgYSqGOXu2tgaCHmpbev3TnskIayLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443500; c=relaxed/simple;
	bh=HCT/kQxVqQeqfQIoLauEB1vhRPzOM+Zsco4uWo2vpBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD2j0f/93HtkEBxxK6yHezzqMijp2KJl21QyDDrnfuxHeAf7tcaqi2uNY0LddgQ8wtE8/yyJfO+deBOUilG5Pgjzxx9FAWHM09hmnJjPhypPH2tqvuFIxJVf3409Dy0qnB7pwe/XFVUXLi8+NYrQGBLG5qMiJjJdwG3Jshd5Cgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZnCqWYl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I2whK015889
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 01:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cECZSFy3qa0bHjy4EhDWe8hr
	H3jcwRS+Y/cAXNikEvM=; b=WZnCqWYliZrXAa9l0D6gS08pZD5aOk4pHsA8w3uo
	3uTmfTchrXSBEkKnkjwWSMeKduOuZkvtqsz+1bARX/fIgrA8CWE68l8vp7eaLMIB
	27oIU6mFPGP4icayA/sIi02FU5i0aun/Bl2YU1miEv1Px4UYEfUfNhdKOSwpilNe
	wJMUDlWXY7xvzbtFKLcRyp8ZAGG4Q2FBTE9gmKxCdMebYO24kgh1L2vC5BS6V/nM
	Fr8FRFnGPk1O83SoAlmGdIDlNMSgB6UQ22G9gbniVfqhjTl9+LqohAy4JRgYu7VK
	YOIPrrKwF9uc/KAoiqECqUceMmNI7drFKQLrgu2mp7Uyuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvxryen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:24:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c790dc38b4so120751385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443497; x=1755048297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cECZSFy3qa0bHjy4EhDWe8hrH3jcwRS+Y/cAXNikEvM=;
        b=JCAq1yVUBOuoxwVOdt84NdOQ5CTrJoAd1py81N+6pXy2I/GFl7MZ/UQeRoIs8Pa2zN
         MzkQoKPAE9XkSkVJgeDtUsHAMcbTSrEZe+Njfr/r2nIAdAO5mw4T1UcgP3Gn/l0WuREa
         AQ4U+hDaATWh9S3qgpqUjQkyld3j2rQhqPmdkcIfFp8nXmS4IFvkS01Dnf6ogT1D89B2
         d3Kh1ZdqRWdccE5PVTBIuz/0mkDNKzzBCAJbEsfoXp922i4pHBMdRPhEHHSh4H5X2v4C
         2/wm9JhCi5a1X85MwnGBSm+RYSVVAE+w2qgDAVGN/6++++AZLYsobUEqWtbQoN13++Nl
         +6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Toq6VmQpJpYNGR1SNEGdkmpcw90y5WKIdeTDHirMwBs/ZOvdZdpqheYVO+0udKsDkQ84nN0Lwh+Eqm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+4ekL/0KWs0pxF2A+IOOsut7Px95rB42OSWAcRaLy8hW/48F
	s1qFPQbvWTvM1dHe07O5G3jbveg4/sBIlYbnAv9m8PebMxiwmWlThw9bNZAHNUsRMBh55KKnPnj
	EIoMSbNWS5V7A8pP7CnQo1BLkKf0W7cOpNl5qEfDxAdg8MEQ77aXePifEKBotyWWCm+c=
X-Gm-Gg: ASbGncvSfrzEUrl+GN45++NNWkrPj4rrD+rCr0EO6c7TZfug3DWClk5+je0pRMBSDtm
	PaHxwLV+pQVkK92xlYuH4tbGhPKCw4ZW/ZdLtS5ixlM1nsM6HLR2T/AtYibYvpIlUywA0qob3/V
	8+B1O92nK0XBt5hofUMe61Prx1u77+/YnW7lE161SI/bdR+eZMV6zUyJzf2cCD9KrW8KtDCV662
	Jn5tJBTIRl59iREoSDAII//V51qhhqjQVYwIqoOLodtAXNrnodVHDZiuI4eXx16q/canf6nsEFR
	C61Y0yKK5IHvScBeEuD82mhE2eKQ38VpFjTWThPJWDy7GOfWH9VPZ0kLmKfMrR6H08KtitjjRJX
	En7qO8uoMfBrSwNQOm8eLbMJLaYK9tLahksHJSPbVxJUnCAa3xR0B
X-Received: by 2002:a05:620a:1a95:b0:7ce:ea9d:5967 with SMTP id af79cd13be357-7e8156eaa4amr154496085a.15.1754443496834;
        Tue, 05 Aug 2025 18:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE3iln/vIeJH6XAQFmoLvafmfwZ8ex6TVrHNRQ6JVSz4HJUlvRexPyLHQYfDNi/TLCH3K+5w==
X-Received: by 2002:a05:620a:1a95:b0:7ce:ea9d:5967 with SMTP id af79cd13be357-7e8156eaa4amr154489885a.15.1754443495580;
        Tue, 05 Aug 2025 18:24:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382b55d2sm21196351fa.31.2025.08.05.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 18:24:54 -0700 (PDT)
Date: Wed, 6 Aug 2025 04:24:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Fix a few comments
Message-ID: <mwfrgvslnbfxegxqhfx4ldshqqxyfgm6cwbopm5hk4srgeza4s@vohmu53ettad>
References: <20250805164308.23894-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805164308.23894-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwNiBTYWx0ZWRfXw+Oqrsr9KuSW
 BDAigko2jfZRhnC0vppWkOEoQc7o3xvJIMmiKokZG69YTOy9ECPZ/M5bkil3PbuTZpc5Z7QddJx
 khuAiLsRgFxVFIK5RhudNrxarekx839u/CYu+eT387/sJdtsRRTs47J0E8zPZdUr8GfJvQxzOP4
 S3EYRF7kziYlrDTeXeqs4xKFfhVE/PgM+20K6PBzlHNzel7dRs/A8vxcKp31NuYV7/xIH5svaL6
 mHD6YK8/WWolfqHepfM8tRGxfyPz+cnA1BZUS+M+3nF70BqoK3FCkg4ecueWmafx0Cg/x+mecSi
 2iLKtX7Iv7jJa8fYqyrsKu0gSxVGFBrUYwf9Ane0zss5dn86QiYy46Ci/K++u2eGYLZam0QGF7K
 F+N1gYI+/XTsrLzgjkVeZRPD6/f2TIqyEtxFkrhNqJLBs0a00GhyBi8j8GdPf4Ou0jJuAyDZ
X-Proofpoint-ORIG-GUID: MbB9_qo7W6tK0FlXxDOd-w5yl-qDMYxF
X-Proofpoint-GUID: MbB9_qo7W6tK0FlXxDOd-w5yl-qDMYxF
X-Authority-Analysis: v=2.4 cv=U5WSDfru c=1 sm=1 tr=0 ts=6892aee9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=GOsSNTHw1BKba07vPD4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=856 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060006

On Tue, Aug 05, 2025 at 09:43:08AM -0700, Rob Clark wrote:
> Fix a couple comments which had become (partially) obsolete or incorrect
> with the gpuvm conversion.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem.h     | 2 +-
>  drivers/gpu/drm/msm/msm_gem_vma.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


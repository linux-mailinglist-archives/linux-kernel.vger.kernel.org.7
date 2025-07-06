Return-Path: <linux-kernel+bounces-716080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB41AF8193
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 21:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A031CA199D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33691E0DD8;
	Thu,  3 Jul 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRsJwaD4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9542224AF3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572032; cv=none; b=P+uKRMZewLMPWj4QKjimu+gwOF26eFNpXJgRXZQHsEu2g7AfFGROF/DHXKe93CNRmuQjwGr02gt2lLaIjuzskpr0PGqMI5jjvAIBqartRtGCpEKqzuLjWk05uIo78pjLYcbv+Dpq1oE+oyZpL1ns9uyf5zoeDY8jB0vTig0bSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572032; c=relaxed/simple;
	bh=dVrI2uRTpPJyEYGggSErauXb36AaLTMk0AYHXyC3+bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOpOgD1gM59CAQl9M7aSR0nVq27BQvxc/97pWjvFpdeGpUXhus/iSzTiEhHA5Qxr4I0QR57Bn5P94zo/A5af6XhVzKGELFAl3NBxmvTGstbaVzKjNugo3/8cUfdN4uPrrGzbgJ609J+E19X1bOyIB+qOuRFnhPeHtVh1rTEfbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRsJwaD4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563FY03v008123
	for <linux-kernel@vger.kernel.org>; Thu, 3 Jul 2025 19:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kyjs9KtRSFqqWdHu/SnN7ykY
	05Jh3LfVZ1F5/zy/um4=; b=RRsJwaD4JTLFe9in0afKI1Ngl1YV4Ai1WnVCglxl
	jmf4tzEOSUWJtM3sVCUn0xHaEPn17UUXb4Jn89i8W3YfCa7gQSUcbSIyoMLx5nuc
	pqoQlTnGS6AR6OfyHlc5z47Y6QpMZA4WuL60a1tlRsB+b1J9tvL4HUI2pqPUKy7A
	St/p8y5SjWwVFzHE7zQfiPXWn8EoRKK+26Dt8+noAx9uyh3pJ6JoPEdJd5tVZsT3
	1s53SRBsLzqqKvuUWIY6XJa6zyPSpTXJQ8UmnKVo8jn/aZ60i3jZnj8yJAxCfc4i
	ZWhJxVkz7tni9RYBoihlxpkzcWMHiDlxA9YGIE7cdCZK1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jp2gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 19:47:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3d3f6471cso32367785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 12:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751572028; x=1752176828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyjs9KtRSFqqWdHu/SnN7ykY05Jh3LfVZ1F5/zy/um4=;
        b=aBsLsfdmVHKs7BTiSXVdexvHvW5lb7yaKtJkIImDeRBFY0EZKyCOXNkLNXIMylmdyT
         QnlKqfz4rx2NLBt1I94Vfj32+uqKcJrmiWR5EgIo0IFp6cZV7NL1WbTevFGTApcjuwZ6
         xuWN/z9FiVOJyxVuzfDVtw9ZKPO/pmOhNjaABpauS/YyVXJsiAdDcVFUmxvcj83aAsWX
         6eW6j8F2SiGj7B7n6AQyKN1hQR8VpouuW9oq8iGE9TeHeV0ALXngASi8j5usptN6iaXX
         uNw1AcrldTY+R3n3lJxdEbq0UcQqmnqn0cicnQEN5TL6rLy45nSZmRQFGTnXDHDZNOgV
         p0pA==
X-Forwarded-Encrypted: i=1; AJvYcCUX2bk0HgroMLwqV/UHoaBfkUXu65DU4YhwtNS7lPyWiAPd1Z6yFKm/AYHHzCEjbMs3IciIwyiVMCsmKes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTR+Q6jYeDw/4PtJwpzG29BLPUnqlJOPVvSke3trTz54ErDicD
	U2OmrHYLzXv7pT8YONBY5nrnEI+vVBXe5ZiCThqtq6kevkwNxCToPO8MIaTeHawaACOdqAwmg4j
	6roCDmMDja6fMGddYn9Nv2d9n+Two/9Bo7d6McHF1HUB9W++XJWnIV+H7yMTy8fCgA/0=
X-Gm-Gg: ASbGncvUzWWyPGfF9dZsJvWGpOttsTTB/BzJUgt7N4iZkE/V6iOPDUfF1F2lhvouT94
	eDEb3QT4xIZ+eFWn2IDb5ByY9vGORdlHqJAuFqwwlHZaG/E1NlZXl1R4Vxx9zikpsb1w5zAYzfU
	JWTICj81dmFLyPnkeAq+sJc00843uNWub5j8BzqhnVB0T8CkFfdKp+RhbRXNx2GODNMbOE+nLL4
	4SBOMA3g0K1bvNwoFDaXwkCEfv2IdEkn3Mq7tyqK+52ePs2CEMX63ZtE0VuxJgjaKo7VrW6tdam
	KBHpoLBfLCqOJkU3HBouqNt9ClLt2vkmjeLXxzosugel57n9g8zczfXpH8AmocEJHMHSILkWU0O
	9ALKWWjH1Y0DsTx0vpRtkLSKP4P9S0VKB5QY=
X-Received: by 2002:a05:620a:27c2:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7d5dcc7603emr30091485a.11.1751572028364;
        Thu, 03 Jul 2025 12:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj2tRf9bBt4hGhXkfgtHAuEkZL3reD1egDOqsmHrUX4JA7cNn7ybYXWLKFG4hgzOlB5osvWg==
X-Received: by 2002:a05:620a:27c2:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7d5dcc7603emr30088485a.11.1751572027963;
        Thu, 03 Jul 2025 12:47:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b141ea0sm391081fa.78.2025.07.03.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:47:07 -0700 (PDT)
Date: Thu, 3 Jul 2025 22:47:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Update register xml
Message-ID: <kwexjh3eaxerlfbzpsmd6nim5si6zdjpdthrpzcpakhwmodasl@vosfzxpkehxv>
References: <20250703175125.598687-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703175125.598687-1-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=6866de3d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VrLyofq7WMs6qTrs2fUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Jo8K303jHIvmRPARwyVWdTW-Hb1jzpQV
X-Proofpoint-GUID: Jo8K303jHIvmRPARwyVWdTW-Hb1jzpQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE2MyBTYWx0ZWRfX97PTvATeK09u
 KBVI7pcNmw7+uhO5UC8nGfriu1Jl/gRd248yV0W0PH6u16tAWOh2vYyQxNY7O5NaEsV8QrpLQ2z
 d21wYiLmmh2f/dSo6wVbJwXRSe8idJt8N+qaPZE5H4Y3DGS1fTmqTrMLIfTMneOs7oe3QATz9MY
 W7o4f3r61n/YBDImoo5WMQxZW2oWZ+ju8uVvfZmiI2ga3y+T278oGBGDl/Is8LjTooRQpumt1vj
 Vpeau4TQaLftSYWfDIoviR1cu5VZa6fS3eP+TpNM0tGIbrJAcDN+qQqUlelRTRZujLojTNeFRPQ
 RZAApA8zzQa4T1byoaALyvI5TRHBlIb4UhMi+ULhdK4q0VqbUBxXGxp+XsAOUDzfK4kZ8O7Q7MZ
 o+icVT+rEpPix6hFLPOzBkKJ9QNQf3jvKdyCbBfBRPJ4FJzyc1IhgoHzzHx/VM9FsqV0D0Zf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_05,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030163

On Thu, Jul 03, 2025 at 10:51:19AM -0700, Rob Clark wrote:
> Sync register xml from mesa commit eb3e0b7164a3 ("freedreno/a6xx: Split
> descriptors out into their own file").
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                  |    5 +
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |    2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |    4 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   |    2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h   |    2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |    2 +-
>  .../drm/msm/adreno/adreno_gen7_9_0_snapshot.h |    4 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 3582 +++--------------
>  .../msm/registers/adreno/a6xx_descriptors.xml |  198 +
>  .../drm/msm/registers/adreno/a6xx_enums.xml   |  383 ++
>  .../msm/registers/adreno/a6xx_perfcntrs.xml   |  600 +++
>  .../drm/msm/registers/adreno/a7xx_enums.xml   |  223 +
>  .../msm/registers/adreno/a7xx_perfcntrs.xml   | 1030 +++++
>  .../drm/msm/registers/adreno/adreno_pm4.xml   |  302 +-
>  14 files changed, 3312 insertions(+), 3027 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_descriptors.xml
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_enums.xml
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.xml
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_enums.xml
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.xml
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


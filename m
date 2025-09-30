Return-Path: <linux-kernel+bounces-837263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CFBABD08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC51F4E2427
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF62BE657;
	Tue, 30 Sep 2025 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emTznH3e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C622BE647
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217139; cv=none; b=GfsMuCJUN+PIIverSOPzFnRTivsDWoFu5sX9UyrgCbq0FQrHUJHj4zDzemsEvfoMUvNL6nBYQG5X0KGavYI2VXX1u9Isj+UIK+BwKxa8Igxwt6Him0XFk659SpobY6BNH0sp27J1ktcd35gCsl615t5XBvHv7GwyCWhJkxzSjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217139; c=relaxed/simple;
	bh=UifeqzVk0GLJECvUJICZt5cLmzDj39F0UA0bNvr9UcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZkI2QMhw+i16DRP8JQZRHDag+CvggZ9LcTW5kc7I1qVET4OOE2miwAt9vk52dlAHBsMA421pA12/aKvzRj1mlGOMqmEtcnY9uu8nbr2mBNgaOl8vZ9AS0eP0q+4QlI7WuSuKVXGTaSzUY15U3TWKpHMXJMo0cbTnTWSFMTUw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emTznH3e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HjbY009556
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=geMF67s9lK2e1WUJdGTKamsD
	rkDJzWkQ4J1/vFsh4MY=; b=emTznH3ez3asNBmGW+AXo+80/eVD9rTybYFwZcg2
	ts9ACxZQR37p41NlYT55EjyOJhRAHavX2BiBFPHDQsJcD7H+ENH/w1/x6puGBB0w
	sBfNaHAii2RLUAeLz8lS8fUB+Fbf36NbOk8tZ1NnIF3/2F5xB1HP+xW6G8fGXWyB
	BmQUgrs0JdGiqNhgBfHoF++3COil3V/aguBgKHGrVpNAk+RoUj3M+e+5U0zba0cO
	kvzGZI8AmCfNx1OJah+khh0Bd1l9fQrB2ggTVxgF8dQW4ITzr7A/SBHbVlVUA9Yv
	UbF3C7sYepsLZ56hGJW/x/ZqkxoJtbiyhgRX27XPf8n54g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977qta1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:25:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d9ec6e592bso114637441cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217136; x=1759821936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geMF67s9lK2e1WUJdGTKamsDrkDJzWkQ4J1/vFsh4MY=;
        b=Xb2fYAVWdl8bmR7cMdWqk1Xzlgt8sZQqtyJs9BpWnKN7aJeJ7ZFTIZ5bIbjbUyzJTW
         MgzZXfeUanrTDyVdUeyJ4o1hKAKhsoKXiGoyhhicYR/VJJSLdjMytg75LCTWuVHC2szL
         uHZjJGxF5zo+VzkyF3EXaQA0KuqTrPEKuOGjLDIz8mbzdihAnuWTLtluH+9TeRToWVuL
         P//3XS0uJobRzeHRqee+ZDLizs7FEz5aemzfZaHXWB+DfRyTkIS4H84JpDtHmnHtCqRj
         LRNdU2gzCOw5SOCJAK9OxyjFZG5V662EdjlU3AxtldzFBs6rQJ0MOxFO4vCo8EKzNPQd
         Nf0g==
X-Forwarded-Encrypted: i=1; AJvYcCVes8zTKQbtGTIBe9wF1PkGxOWKdzFNns6dFJyMMSixj6IccY41PKTIrdjZCdDtBXBRJ8i+vUo33vpC/pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0w5ntlndaClrCZadZodau7BvW4kh1pePVG0H24zz4a0O3dnZp
	10T8fV5CW39r8FQAqlfp3sGQtbtae7wOoh6mqzrdQ59HpcIG8FjAbirdwyN3ZV0X3NYjQhyx9Nr
	3BWC7X5ylziHALLaScSu6wK4wsS+F5AUipLSPYeJgwpNO/4NTzQ8oKLQ2rSy+CTx3LLo=
X-Gm-Gg: ASbGnctv4orewTk9O1z1Np9FwqPsx9XDm8ABC4dAKgRJs1k6UbVeDcuixPGZso4ULeM
	VbRWdkDUHKRQnCbIwJbtCdMCEFNKj+26MyLqn5gCZ6ITI6uh0e8APC3w6GdFDMKFaxWz4M1s6DP
	etFGSU+aF3sG4MVWiC1rlyWlMpDS6zdaknzZyzRLyEDaE0n3lI1J3rQuxIf6PebHUvZoB57807x
	0sEpPx9gwR77baBxmXxfYZrT/v8EyjxG/AjLfBmdvK6EuNQkld78CwUoH2BeQ4+0hByqjzD07bN
	4mLeZu04PDg9eRIMgkV0UKXLVDudg+G5hyRaqou7HvhVV3oQ0RxHKV/BkZi6KogSkUZElvs6Xuo
	N5J+0bVnwM6MZ85cc/9AYSFb2YRTE5MwNRmmA8DA2ejF7dsn82pMipWrAeA==
X-Received: by 2002:a05:622a:4b14:b0:4d1:ae10:5b1b with SMTP id d75a77b69052e-4da4b42cbe4mr262137611cf.50.1759217135794;
        Tue, 30 Sep 2025 00:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFydm8Witpz9fh7gZQkdonO45FlyJzofDOb43m9RJWVluGKuEzZbINbtIf8sGlgSFb0MqlQSQ==
X-Received: by 2002:a05:622a:4b14:b0:4d1:ae10:5b1b with SMTP id d75a77b69052e-4da4b42cbe4mr262137431cf.50.1759217135307;
        Tue, 30 Sep 2025 00:25:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58619e6c530sm2504496e87.93.2025.09.30.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:25:34 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:25:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/17] drm/msm/a8xx: Add support for A8x GMU
Message-ID: <thvn5qhq6lhweceoofuj23bzyteesdorjvnhpves3bbszsm7ni@zgvdn5utrafo>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-11-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-11-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: tiBqg3YP4Rm4fiM_eKFl5sK7b5fd7gla
X-Proofpoint-ORIG-GUID: tiBqg3YP4Rm4fiM_eKFl5sK7b5fd7gla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX4bWgi71ioctP
 aZ4SFg2eEoaTfz+N7xnOKX/DOX2EPJ9v56er2hS4kN0bitpCJQwS2jmhA5N2yx3Bjk+1UIeiaY4
 oewmD1oLJoutYJsk/+ZQ+ilREKqkqPnnBvOovJwLnP9nOz5K8U41KAUV8z+zJbpRn9NCGjkGHbY
 GARP5thTzJSUQ9l2+Nv4FHKU8ZIVW4IeP15e0CDkQcSnjGMWs0eWXDrIAHc3S8Df03g6aStpi20
 769EAlAytqbyblSJ8SgmVD8XU5OFg/WLePinPuaZCjjdZxCxu5WQTEI+JII5kFaXEGM/ICdIG0v
 ogTKBhmifdt9ZJCUTvCNd1pZ1liXO56XGWxcwkfZj39EXii7FdDj6FQkguwp9tMIhKZxini+XU1
 ynO+i+uTZxqtIuTyvE8d/YOEdfvRpg==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68db85f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Yh7iuwBG_BicX8m7FkYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Tue, Sep 30, 2025 at 11:18:16AM +0530, Akhil P Oommen wrote:
> A8x GMU configuration are very similar to A7x. Unfortunately, there are
> minor shuffling in the register offsets in the GMU CX register region.
> Apart from that, there is a new HFI message support to pass table like
> data. This patch adds support for  perf table using this new HFI
> message.

Documentation/process/submitting-patches.rst, look for "This patch"

> 
> Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
> to simplify handling of MxG to MxA fallback along with the additional
> calculations for the new dependency vote.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 161 +++++++++++++++++-----
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |   5 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  53 +++++++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h             |  17 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h           |   7 +
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  48 +++++--
>  6 files changed, 242 insertions(+), 49 deletions(-)
> 

-- 
With best wishes
Dmitry


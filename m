Return-Path: <linux-kernel+bounces-779550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6807B2F582
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DFF175493
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1637305E24;
	Thu, 21 Aug 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOwsiioD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C43054ED
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772692; cv=none; b=N2Pb1cf8Dzr+LiCrHJUizSGy4CGdLRjGdfZdaio/3avprjf+8hLMFBlQ3CEUsyGQm+6jd9TbhYWjPeU1w3l7kHcsXPbTh1mj5INJw9QgNz95RUld7mlS58aLeJAPP8xGUiLmVJ0MWBBuAh2PDl4k5e1kWduAWYI2corwXc0hXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772692; c=relaxed/simple;
	bh=6B2gofMQeXaFIxttJOCL+Zl7gixeHkUQAMPgca1dQAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP2iOAIDhJOIBR9ANQPd/R/JXto39ugfeM56LWv37JNYaRwBUgfadmn0h4vRE7rG5M1rI/gk0iIRhs6U2rE5t8hTI+or8bgJkZHBwVk6fjU4dNxEQ6I8HRpGeFXpFqTHaIwykBiOCFosTcQaZA8R4vQQKzigrZIppge5bDMMgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOwsiioD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bIOH013281
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r914EYN2oHqG39oPT8nQaNOs
	AXvKl/bytIkZsYAvQVY=; b=DOwsiioDOlsSL104WqMxnj2XV3DqmzE7CeRShTyE
	wDqeftQd3Vz+ACmdeVP4+HwfkhmMH0U9ORUHKNVFrnko+HNulb7/LJpiWofgCspD
	lSgjAqB1LNfXPRLwx1MSKoWCshW+ZDYJ2oNc77x7fuLc7vrK5ZxMUl34yy6zjOqD
	kQscF2TreHZ3msQmxZQJYfThzTCw9H/7BK2r2E6VSp2aUT6dcQPhl70t/gxygUgd
	WWLoDKfB1tbQl3VyEetdumST3BYf4+aPMQsdKkuRmYLh3dIM5BAYuh2Yk42DUBfq
	WGz5lhraaGeHq/FTlarD9ZFn9vXeAfdRfRBWkVk4iPzMPg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dn18y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88de1e26so26603386d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772688; x=1756377488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r914EYN2oHqG39oPT8nQaNOsAXvKl/bytIkZsYAvQVY=;
        b=TjkW8jDvhwbrdJUAIDSKNqcDWLRAHwdx4fD3xMXPo6ehyjQirAqQBYkNIPSHxn78IC
         lbmHBzrzqBK0+Cr3vqhzwDqI8E6x8J1ZTYvkReufMF6+TdaiPmtrgMXRi0eu3uj4H1Bg
         Zv0EXnRMFDZDSxac8M2ohLpdTfBBnG9LC+9MvQCExxzewKZ95oz4DbjZ/mmGe609sdWc
         WZ0CFMJKa5Vk6Wo0YnHBFr8ruzidCxw7lzpcB7xKghrKRFj2e7mkx9uLFpvPbpuRrDrX
         DETF/yvecNGKD4wglCAfv3Pe7TKPeD4M+3hqstYGdVP0WvXaXOXB8prgxtSh92finUoH
         eBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWk1O59hnYSJYFTgwYgHsgo3dcThCWCXuHKTQUyZn5GZv7hVxoS6G/m1t8LPz8AxFXBPnCWRaA33hPeQQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRdiJzgI2KZk22yc/NmJtyYGF7/d0q+SrMsborHsBOsdeIefk
	M1KwkOh1d0C6gYgr+IwuNjNbRmAW0RLnlAvyogaRqmwlonGKD+lqeJ45EIBCZGPSXazCbn+9Q6c
	UI0ly2pPei94rFczGQWWf2rX+9hvq/PkkbnY24MwA+mw1sQZKWUGbW2iN4uwV8N199wF8FkxEAo
	I=
X-Gm-Gg: ASbGncsBA5r2He2CFtwkM1mds0l0CLXduNX4zHLs6p/nrc6Kyp2MJL89nCvfdMrhTge
	P5XGswoWZ9OpghsMcFO0JW4DSGrVxe0M04mg+nlgNlmdYsDYb2tQiWtaSNviCPaxLiLPpJBJv0q
	74+SR9ZvJnww5LZwOp1aHU4+wHVD8I8NgrtYHwNSc1AuVOOq1l/xlOZk2qyj8Onwpe/kVNs2W+B
	XsVtz2+ji+aSN0XqrR7Wgzw4r49+3CWj2/cd95eioEv3DsfwgEBthnZT2lLQ8CsTTg5DcNELwpz
	75I73mGu8/aS6VwZBZs0Ktpcro5dCewbzq7h0zebCCouGEpZJ/UT1Fs63wdmOyHhxWnExM6hfQF
	lmPICbwnnawkQMlrDsBwkGAC1vDZ8XD1LqrTyB0WUQ2ombPR2wxVU
X-Received: by 2002:ad4:5c88:0:b0:706:f753:6b14 with SMTP id 6a1803df08f44-70d88e3741emr15983666d6.4.1755772688275;
        Thu, 21 Aug 2025 03:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEa7hNzXAx5DgTP1u13ijsgfOsTyYMteNBIqzj5N6IcVZ3PMpHJWc/EQSHJlepAFEYsq9ykw==
X-Received: by 2002:ad4:5c88:0:b0:706:f753:6b14 with SMTP id 6a1803df08f44-70d88e3741emr15983356d6.4.1755772687617;
        Thu, 21 Aug 2025 03:38:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef368d34sm2973505e87.58.2025.08.21.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:38:06 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:38:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        "open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER for Qualcomm display hardware" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/mdp4: remove the use of dev_err_probe()
Message-ID: <kefrdoyd5dr4rjvz4lmtznxw552wzuspk3pdse63zm2kmtnpvi@wzzddue2acrm>
References: <20250820131300.499727-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820131300.499727-1-liaoyuanhong@vivo.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX9lpplUtcdN2k
 noarrfYkW+j9RfZDR5kgrnXoKp0EUoptY/5JA1xGf+adPpjnxsq7o8bUU1TcMBHqOEorVokTu95
 WsCHVIpg2rFpoao90ZnllFe08SzQPMvjrWT0XIVHLFsEuUgPJF3Dm9mMNBTRwbavpyvgbgtSPHi
 1BUHWuvbpy5RVthuEQ4rQkxTsRw/vHgYYx/6UNIldDyY6gzenLV36UKW0nCx7V3r8ArauW/8kkK
 avv6gi6GzHLEUzFacHIURErz1oDbitdf/XVxZWCh0sZzXa0PuxQgeJlTSG69dMvdQMZUN905l8a
 6UOYATDRCwXcIwWOmuwrnSPNjDkMpDhxmWJhZoErb67DPf5lRvBbXiiPedYWYpn/1onzMT/4aIc
 L9EEI1EZX4sW6xV8J68pGqx+PztHSg==
X-Proofpoint-ORIG-GUID: YCVPuRgjyU152sOBXNMtK5sksphdsciQ
X-Proofpoint-GUID: YCVPuRgjyU152sOBXNMtK5sksphdsciQ
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a6f711 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8
 a=i0mAgyhDueMVXABGR-YA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 09:12:56PM +0800, Liao Yuanhong wrote:
> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
> 
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
> 
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


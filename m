Return-Path: <linux-kernel+bounces-740940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B4B0DC27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176B5566F47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E712E8E0F;
	Tue, 22 Jul 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OuBseHBs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7D2B9A5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192527; cv=none; b=TfqGpPH61pJsnlrCI3bahWbDNgkLpwl6i02g3lYsB0TB3ZZOR6eIlF6sK7glLnDb51ihS5K7ymnM3WcSADdc7PXlP7uqehY+s1UE7tq+bt5O5OJzF9AfuB+im19f9Keo0MfbuZvjspNDcwDY/IRbTufEqvsSI2YphnayOLa56zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192527; c=relaxed/simple;
	bh=GBTzSlcaDzz96MR9va1WR5wV7oiVzBZYPUB4IHnpsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dml4P0WKv9m6mmH4ivP6p6oDGU5SeKoMzwRTSzI/9hSEbCJ9HDWJFyGuuU9LbiFkbs1i08y5V7xfYVoxMKZhjsdKcG+4M9hPIkUvutqtTQkG5JqgW6GXQkR/buWWUyMhp6lDi7kxSc2A5+gMLEN6N86gSQUAcRdvS8SN/xNfBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OuBseHBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCsbP6021550
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8FxxfuLmav3rtJMFdmgEGtcB
	RN24c33Z4J181Ntj5cw=; b=OuBseHBsJciLM9V9eyKUMsshokS4fXHHtBYtObDQ
	1NdSZffq9+hHUkMoF9P/gVIzXe6oS3TMwvf0kGptLxR0m0xY6UdjXJ5+wnQfRvnd
	kwlUputlxh/BL4WFsnFcBQdD9wV+soilJFXZWTTfucdvl7J3Z/5Lh5XE3C6T/ir6
	UeuIhDVoLfHUnif9UfbNQlnOLpQuoeyZHk2CSjr7ajPFblgK3/XVybnKWGzMeZUF
	N5Xb871llrP6vGQb1l3/q68sDjsDjQKV6gKqyRHomf8IDLkqk2QYkWwkmgwe/y+B
	x4Dz4EhTl6icbUxvwiODIWTZ2KA3AvXy6u13LgoRJaVTAw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1u85xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:55:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e1aeab456cso643200185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192523; x=1753797323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FxxfuLmav3rtJMFdmgEGtcBRN24c33Z4J181Ntj5cw=;
        b=EasNXQx4d4WmoOs8IFA0h6oNNEBV2Gdkjgzx167fdj7j7iCc9Vz069ZLGmOnH18CUZ
         P4Skmx1UoaWY0sQNu70GuUrKJ4075MuxwxmHsFy06c5mbYFhvvS3xwJqQ3f786WxEquZ
         thqycxUj/1OBLX4yC+G7QCxqay4xKjskp83Gokc3VaRT/bCCcG80CDWgoUOEW6YZYA+p
         K2jZmJQ7j8JW9efJLN6aenbOYH6uvNHBoebUwGpv5gAupcU8s7k6hYL8x0oJLLTd0unU
         GBrF9oauvNdb5iA78CrsRROrZyE98OeqR9UbHaygNH1HB3J8TGeAO2T+cTmxlzJwZXfK
         Rm2g==
X-Forwarded-Encrypted: i=1; AJvYcCUyoQCFy6J+G96XHSAQORI0JbWUlOeShuFG8j6C0DRw2IcGe6CICvL2Nax9YTEu8u5WBhPLAKbFpZnS+UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI81453AAfz10bJ3rUixB324XXQ37RvFrU8Ov6Mc8TGt/YBRh
	i4gnmxez9bpjnFWBE8lBwgYLhz/WLr9v0G/6GV4KHV5oJWolSY1R5o3GDjStxgnZZ+T8ne71UXq
	5TN1u7dQ4A0rLsQzihK2NWvlbtZm8QDneUSPqX94txm+32IRlTJs+DVv/p53C7SUJYxQ=
X-Gm-Gg: ASbGncuOu28y+5dTBWcSA196XwbmvkAuZFGdiwUFTzk62pLiX2F00V/V/ySvRA/OhO5
	E0UHE+mCVTQFc+pMRqHpgh72HCXQ2gPFzH8mwTvEfiqeJl2lpVV9kiR0RUUtI/QID++gU9Si4TP
	vPYQpTmGtc7kwzIdBSdKKUuIdM92VcyYUwAtHr4+zZ77JGyhGc7VkTJIsQxy+c9ikaiU++Jm6Tt
	pfe8esidDFRkdW/zxWkzKS+LfyvGjp+p1VOFG7VXDWWsCJd0VKGStXp/hsRtfknbeSNj9sQzscE
	GNAZqE/xtRQKa+USASEgNPQez0My5CQ1NuWL48bDgmUni0vl3EP5puMbmgPxYV87aoDxJqpWj+4
	wjOVbhW9uCT/57MBigWlrZFHraCu205kWNr/vHy541eQXo7HMl/fG
X-Received: by 2002:a05:620a:31a2:b0:7e1:ef9c:551b with SMTP id af79cd13be357-7e342aaa43cmr3564066085a.14.1753192523334;
        Tue, 22 Jul 2025 06:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTMlUUIcQ5GQ34bJaL5Zr/uF8zkXIHPl/bxOYdlNcBILtA/tK5Op9PqoPa06PAlpWzt9uJQ==
X-Received: by 2002:a05:620a:31a2:b0:7e1:ef9c:551b with SMTP id af79cd13be357-7e342aaa43cmr3564062785a.14.1753192522837;
        Tue, 22 Jul 2025 06:55:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31dadfbdsm1951812e87.216.2025.07.22.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:55:21 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:55:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
Message-ID: <37nuk4kevhpwlzbpgm4tyhnmk6vi3a75oosz7l7xbvvn7qwq22@oomdnizhc673>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=687f984c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dsTHFzNMvnhyJiqkEZwA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExNCBTYWx0ZWRfXxeBYZNi6l0mS
 SD1vEYCwd6+cvf3Wz8lIVaSKZMjQDcCTRngWoYqNCRAuPLBmmVRx+CPoSKMqkAAW8H0Sk1jfy9C
 BYgURmHbl27Ps+1HZ495qE6NnbpaMRq1VLoKG3UOoFGKyudhGNCNBQaZJDfQwhF6KB3FQBxcMpy
 C1/qJ97PtT6lvHlO6l2YiuGt0g5LP4je8XOFWw1V77I08i0XeA8gxMlJbJtVsc+y/BFpTiPMPXZ
 7hStBCHh5OwzaSg5iSnTnLX3qbNLcJ+rw6TCle9HeQpaCSNFZV6vPWGE5hpK6jE//a58/gZBOxQ
 fTMwZSRziMnBwWhVl2jzpcUW+w625M94DLaDFv7vKJKe/w+PsWDHubSMMLCjiEpR6QuqkpgC/Fc
 UmYZcSlE0MZn/QUFTvCwbX3cvnhqqCoDAJmhCopGtwrN3HU3yKM8jJ0kmNAByG2hcO7/qjD1
X-Proofpoint-ORIG-GUID: QRkauIti-oUGjSsN4WuF7-RPotjXHzbU
X-Proofpoint-GUID: QRkauIti-oUGjSsN4WuF7-RPotjXHzbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=614 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220114

On Sun, Jul 20, 2025 at 05:46:17PM +0530, Akhil P Oommen wrote:
> Add the IFPC restore register list and enable IFPC support on Adreno
> X1-85 gpu.

Nit: GPU

I can't stop but notice that KGSL enables IFPC for a bigger set of
SKUs, starting from a630v2 and a615. Is there a plan to get IFPC
supported on those platforms?

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 67 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 15 +++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  3 files changed, 78 insertions(+), 5 deletions(-)
> 

-- 
With best wishes
Dmitry


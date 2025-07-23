Return-Path: <linux-kernel+bounces-742315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F66B0EFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C661C84611
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17E28C035;
	Wed, 23 Jul 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiVLRDt6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740728B7EC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266502; cv=none; b=nbymASptZzWGhK59G1mS441/oSt+Q5OcHBMhj3Tb711x2HLEbBCz4h3TRHxN25sysSLqbAgcNW7rzAZpJ0pdhzY5teFgfqjrIVNsAxuzo/WTIrDFosJvD9ht2XNKXrcT9sCz4KdM8axtXS2fvnDJCVJNjVJ33gmDq+6SwaW+DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266502; c=relaxed/simple;
	bh=z5lfG1EpSl/3RZ9cuRBoEl4NtbYs4VztWV2/3vhxbQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sn8VJ/WpwJSWoGP3Z+awID2GWC4Fr8uz/DGwwJOMj/nExVyXoldFIlRve7u1Xv4Fm7bB4NkPigLQDQg801ZXL0W+kp4PpFWc5mMruPbI1LJYzSMrgjjcNcyEKZ9Z8FEw1bLaFbnczXAuR03b614bLalcfDMo61R95NqcWZ/MBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiVLRDt6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9F5H5021749
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzR/vX7Xl3wBXcTUtNpoHInSR+HaYsHrGxjxbc/TMBQ=; b=ZiVLRDt6zu3B3KDe
	ujWkglWD0BULfoZK8aDE0iM7y/RNm6W3KcRaX239CA49O8hyuIjMGe89LV89fNri
	SmEiKP1XGZD/geJVS9w1ntu2a3sssHMQsCMPhSrR+6INDMEDnk88kxQpn0DDXw+t
	gZECXNyun+ijKZ0yxCxO23dLJ94v1gIlyIjrNuuWsFBamYwrHlW0ZUrfVqU8DuId
	TNVUJV+kr4JRGLGwRnlc6pL399Zy7UmgTkVbhUnoMtG48ICjZAyKhP1zcB57MlLj
	UEAefD2h1HrsSTBgEBEXX5JZ5NOKyAMdcBsBhG4ZSi9aIxoFxbOc1uDepMRKb7NC
	2JP7jg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3eqm86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:28:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fabbaa1937so13900596d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266498; x=1753871298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzR/vX7Xl3wBXcTUtNpoHInSR+HaYsHrGxjxbc/TMBQ=;
        b=CdRGYhDgtcVH8d1DvcUYs+feQy/PTHRGs4/QW4P1RDsiapTn4wpizxdBzYT8xxS19N
         Quprkyg+hhQYPuWkogH5V9mnE8Pz0VS0M1Kki+kmKBsfmmBfBcQTlzg9ldVUhvT3Jo3s
         aTGn8k8RzOVp8yCB0iARL1GnHuzvYaE1tPpOlmxeRNfMp73y2q2lOSlGaGSDvYo4XfoX
         0hhg9Q72Y/UEdlOPhM1+32JUxP0UIzXzGLHFwvXUyc35oXRllkVpj2tmFQ7tME8X0rtP
         q6z3AzGG59kcu/wOPRb8/fsED8d0T4ABXGLIGIK/guBuuwUQhs4tgquatlZPHiSDbUbI
         Kjbg==
X-Forwarded-Encrypted: i=1; AJvYcCWjfjoOZK15E4m+b4f/8LVgk1l2G1rmJPy1yJ3oNteocS5iz7retZELnTgD/wxNbvju4R+poGmZyNVp+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9L25aRuWzKFGBHdH63xhLW9slWAeXFL7Y3VgAMtE/ZQrmHaV
	s247ZsZTtdOI0M3QSi17ul8W9YXyg9zHAfDML0QfxVce+dXyipr7mHlkSIKXtTzxvf0I6j1pv6F
	nwG8Yp1f3GsjqLzR1rdy+66FjdBze5ALwfAyz7mLDxtOOewJYBw4dj+e2bKFl+zkD/qI=
X-Gm-Gg: ASbGncu2PRGKbCshTRoZgbmIlKH3GluqYj42HroWb71Y1shrz67vcyc6BuntD8wsLPV
	jDe1AnfXlHmBWr4TF/MvZCkl7XBIhvslCAgBGcSYLd+ILFXVZgstxk17RBp49uSg74za332Xl+R
	XQ5+hhaJDIxTu6o5/9jZ6CwMOsDhUwI5g5h+d0O/G8x16jT14TFduqx3rw+LvWdsVX+yDSnq48Q
	uNP6LNn9Ibhio7mJMFbCaSFEldFeHs+RHhWA7ksuXY04iEGaYG3tfbQcFtM659CI9k6ELC0wT6i
	nZh2f7j5gEIg7UF1RZv6+drH+71MBIYNqoba3M2YwvnXjh0MC3VZAnmf5ZxYBcSNbJArZvKQwSV
	fT+dXlk9RooarwCOmuA==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr16607106d6.3.1753266498259;
        Wed, 23 Jul 2025 03:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbL39UtPO+SV8wf9+PGiKf6rdU9y7bVc7YUr8WF8xNy4i+xE+jtF/o/Z3VWa+cAEKKOMUmAw==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr16606856d6.3.1753266497737;
        Wed, 23 Jul 2025 03:28:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f09da6sm8325019a12.5.2025.07.23.03.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:28:17 -0700 (PDT)
Message-ID: <8267f6b9-2929-4dac-9e55-f2838ab64f50@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm: Skip devfreq IDLE when possible
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -DDWLW2XmY19-uy1Glzcnru__WuRQkDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OCBTYWx0ZWRfX14nTPCQN4uF7
 b2mOw/aX5M4ZKicAgo+2NiA87N0PXyVsB4acuaagWTt5AtRLSfIfZb7ydFUmZ3MoXwNcC5CRNuZ
 IZXCbA069EocJO6eF2MP1Q9wBTKpu56f3rs9wdfVL3Z7+ogZioR+lyEWnovUi0WU7kcmrjoFAAE
 8cygvpSE8qFE7ygE6r5YnHLaZKQ69UdNB3mAp3I+72JXrbb3ClA4aJJe6xx6LcJjrGI6Qaz8jzx
 nsGquPMLOcJXf47WVPqOpjIU8PaaXZuXiE830DU9qbK2akuLX4VWOl+RC1b7a/aSu/g+Z21Itwp
 N75toimCAhRHjz8Jo8c7LeZ6hHQ/spWtZKYw3OM++XJnwSS6EKVn02a5LoVxIP4wkrOkcX5XH+u
 ksYyenJggzkqAC5gmhef5FJojoIePKgxxjOvt4pgR2bYQODaFAGotpX0C4nEKsObqUNmsohZ
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=6880b943 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=ZrogrxV2tr_2hvHNPc4A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: -DDWLW2XmY19-uy1Glzcnru__WuRQkDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230088

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> When IFPC is supported, devfreq idling is redundant and adds
> unnecessary pm suspend/wake latency. So skip it when IFPC is
> supported.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index 2e1d5c3432728cde15d91f69da22bb915588fe86..53ef2add5047e7d6b6371af949cab36ce8409372 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -4,6 +4,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include "adreno/adreno_gpu.h"
>  #include "msm_gpu.h"
>  #include "msm_gpu_trace.h"
>  
> @@ -300,6 +301,8 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>  	if (!has_devfreq(gpu))
>  		return;
>  
> +	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> +		return;

Do we want a static_branch here instead?

Konrad


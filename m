Return-Path: <linux-kernel+bounces-772538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EFB293DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD82A1326
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139528982F;
	Sun, 17 Aug 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJ83e8V/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D878F36
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444746; cv=none; b=ob3SPUm9BVpjzR0HOqwnCSvX/QaQk1w3wcE8fcfeJ9PItT7AXhrVFzxPlUtsmXaY+EfDFLtvyOH3QU61FGd+4zRlnu6ZLDZVg/N+G/cE5+ofPXoN/UTac3ilTZTqMg7CAohYLPpY9MIJecJ8nQcJLfT8wLaUFRE4pr4D5ekbawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444746; c=relaxed/simple;
	bh=rKjWof8IOo9EKIpsRUkpr94EtMOwT+SozpHlubPhckw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uraU3Omao8pfN3yWr5dVrHnuKRHxmPhusUOOwPj6jST3ocgvgVp7DnD8+UUftkksM3c3CspWrT/43MT7HUe51bfqRnNquuGfw8280TsdVP6s4BHh8K9GgibtX/pNM9nxXtPbYqBV/T2iQmV7QoGVNdQsEbRTRPEVHsBOw2XSMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AJ83e8V/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H9BRLg008544
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tIq0lQ5Y81zCr5DJhpJdXmzG
	cuPpY0NM141yL5+C8T4=; b=AJ83e8V/7t+wwy1QENEzy0Naa40H3CE81mJ6Dgvs
	ikdMnDu/N9FymRgAZzScGUhIb27aP6FQEbGtS+i0spcBb8XuqNj1WSfIrRlKWzgm
	ghvbqfriYF2EK3chvn7VXrY37RPTbORU5MK8zcs0ZJAarVS8wFlTSk0Rk6+RBCcc
	5py84mSDkXkpJ+9b0ipkOXK40+Z+4/ntzjq7cJHpJOCg4XTae70Kv/LAVPcgpgXc
	nhvbpO6Ar/EBp4bLuJZjypGOdaQBI0SarIoaIO5MuuXkpuO9+C1R/1vhYc/QfyCE
	fAKJWRkSSw8N55BKvQZP4DAKbbiU72OjyL4/YMBrmvuyOg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7t7p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:32:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dd04faso126917696d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755444743; x=1756049543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIq0lQ5Y81zCr5DJhpJdXmzGcuPpY0NM141yL5+C8T4=;
        b=MwMqLUe86bSH7gJiLHD5tNyQXoH1ToC5f274p+7Z1mOUN4jsHpa4m7DqGwekC8uWaz
         Uj806zqpbdC5NZPDuE8pXr49QIGSrkqBYrii7SDM+6zZcybd0zMgEGCl6dN4bqaF74ad
         h2N7pwNrgMkbtibfyTrZhyeJh3Sg5cNgLzS9RxkDe2Bm3vm6ecJanzOhFb+PZfxdZrkr
         emswZSbsh/Xhgzd1eYmedqleiaj4bbJn8IlcIgRDbQJExlUNVgF+SU+ebdiiHaWvD1BE
         loyoU4MXIIDI7kkIIbwqIHidhdFIUjrZSZ97CK6a0X4nZ+RUHMVc7NQmwckBabkrSogf
         SHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PxRVGIvnJ4PUAAjcWFRo5GUU23HPaOdMvQdxwUW0Rznt+zvm7GfsuZiPwQV1UlrtE9pIu1Pb/1qP2Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSj5QrJPJQOG40uCdlo33Ozcbm7kGDp6C0r9pyGVRSChZXalD
	nSfLKAEi0DHTiHV3hAr3Qb3xvMB2/IPF6An4DXYcvMlaz0rfr1rsUvrhGTt/7RP1maRIMowZd7F
	df2sSmoqIkn6jDush2kf1ea6ehdqkBFE8f4ubJAxF76ClUzyKbZ8AuFpY8np+LSHhpWs=
X-Gm-Gg: ASbGncteeZXbMBvLeCss8vnD/kkZW8dqznesbGrObEweGU8ZCm2cZI4Ypima96aXRHv
	Arj0QHQv3p7eXcmAh9xRMuL7UTKOZJJR1V3rLz9wu4kc40iuHl6liF56dekb+pXPFUXmVAEkuXy
	8wMiaapNX/B3+BVGdhYmyE7hpzpesFvm9aX9sQZlgwsQnCL2vTX8MiPSUu1bvhl2OJPTBVJEwM3
	qYiTUzqWlIoBWsrUnKvVFngP40DgU7hF7is4sV8gG88w3x+Yt3t2uMD5j7mta1T0ERKkiUYMywi
	HqD0vC3kRaKQnSRPEdMlbowquTpOAHdrClkW6+X/2xJUht+fx4EUDsJiFjgLyPCmjiJVJcsoQur
	GhGmMcRiwT/VTWWctgGozZqq5gtvQ+Ho6gJsMSBOLBiJatSCyFipV
X-Received: by 2002:a05:6214:130d:b0:702:d7e2:88b7 with SMTP id 6a1803df08f44-70bb0587ce4mr66254906d6.6.1755444743088;
        Sun, 17 Aug 2025 08:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+GmUjL4G8jQ2Ku/XY5att1CCbyiSmu0VNnVdSr+1FVcC6LLBtVeoceSl3rp6RU/5nYzREQ==
X-Received: by 2002:a05:6214:130d:b0:702:d7e2:88b7 with SMTP id 6a1803df08f44-70bb0587ce4mr66254596d6.6.1755444742703;
        Sun, 17 Aug 2025 08:32:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a64d34asm13858071fa.73.2025.08.17.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:32:20 -0700 (PDT)
Date: Sun, 17 Aug 2025 18:32:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 06/11] drm/hisilicon/hibmc: add dp mode valid
 check
Message-ID: <x25nogehjvydrccphxic2qyigu4kvrysti4uai3h7ea3vk2dxu@yxpgqhfmcyen>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-7-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-7-shiyongbang@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXyQ1563Wenh4n
 BpeW4e3dimgrXu3HfcPYJYGk7IsE8IXl5YE4+/ffeETskx4vFRPKv0unVk0+gVUjrHr+6sZnYYn
 i3i7Vi1gIXpoZdl2tmaxCIZvJgxlleFWD+R6tRdw/HBCtCdaTEBpqg13tJGfAjo7ahFrVMdB0wF
 VuccoekX7RbvpI24l9ZUSfZoUeXs2csv/3yJAFO0AH0XEMlZV1JeCJZEfkRtBYsjifhIPpdAxsU
 L3xzR+AWVZOzxIC9I9cFe2rMngT2fv3DmASPsqYPySzzcBbcvSNc5cbz3kudOmUy+zqM6UmQ+0S
 OCp9EYprUkgH0e9590zgUS4Vx6AUcGLFuunl7ihp3+cC1ozTK6/oHmgB7AOEYkcXRDFw+sUbtqk
 Ep8dXym4
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a1f607 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=DyRxv8TpKIxDVovpxSwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: VGweOVkS2iCTupZihiEWhw3KCk2llpWA
X-Proofpoint-ORIG-GUID: VGweOVkS2iCTupZihiEWhw3KCk2llpWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

On Wed, Aug 13, 2025 at 05:42:33PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> If DP is connected, check the DP BW in mode_valid_ctx() to ensure
> that DP's link rate supports high-resolution data transmission.
> 
> Fixes: f9698f802e50 ("drm/hisilicon/hibmc: Restructuring the header dp_reg.h")

Why?

> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - Remove the clock check, suggested by Dmitry Baryshkov.
>   - ( I'll add them in next series after redesigning this part)
-- 
With best wishes
Dmitry


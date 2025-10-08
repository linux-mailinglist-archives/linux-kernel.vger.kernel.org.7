Return-Path: <linux-kernel+bounces-846004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF3BC6B32
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 557D334F7CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15822C0F8C;
	Wed,  8 Oct 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBU8802L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A627144A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959617; cv=none; b=k8wcHElYIbaTRd91DOjK5yICnL/EagSQ0YR9Cia+1S6CTvHL9oDd2ajarjW8RFiknu3T+4UO5BOBLE2pU8jLUlwK4b54gv95qGmx4Zb4zSKPruwW3TyvaDIrBceATzuHmImCENIR9K7+9ai8KykKLU5pk38/IfVrNFQ7n7pJ3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959617; c=relaxed/simple;
	bh=P6MYsDyKSQQppO7lodOuDjuPRQwhsjU6QET6N51+qlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDmQwdizcZ52/JOszZqzzpizloYvqCeVhvGnZxyESigZiY5yEXZS6+SdKcixsSo6rtmF4Qqn9ABNunsCWXqf6XMpTYB8KqvS/H7eXREhMYp1nVTOVgvDOLbN2IPWPHwkVlwfx1QBFfW8R/lds3CmPodyfnl6GJGirbOhTFVYOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBU8802L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HDx012815
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 21:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8PqFyFEB6Vdzy/Ws3S18XYPm
	NAlesFbDUqjTCNEtSp0=; b=kBU8802L1DozH4D73b8pf6uGldSd8MEH2QJC1a2V
	P3O/fKC4BRyXuEP5ValpF1U/7JxeTqKqKB7weVRLgvh9G9YxgHkqc7HcB2WeHw8o
	d0qPYjzt3hFDP2HcfKsTtnfVmJs2jP7Wild93IWUCPnnrSKWAXA8XxYwVsBn7sVw
	IEehhVKSfKup3yw9P8/e+4UCgYMwbsou+LOjELiLZq0UrJjsgvVC9+eiSMUkqXY9
	r72oXfDaAXUh4v0ZFSE5CdK44KKVJvCFx1vpnufc2Rtjb+41XOk6RpRqx4j7w2Re
	mH5ZwH0N5BUdm2MirDTzxr4KnkT7DZHRvOjrw9KXrzUidg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j0p50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:40:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d8b8c3591fso10044251cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959608; x=1760564408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PqFyFEB6Vdzy/Ws3S18XYPmNAlesFbDUqjTCNEtSp0=;
        b=hrGyEdXV6NXd4KBsmBuETAhLq4BS8Grmn0mc3zjDF20WottnhLoa7tyfpVawbkpozl
         CpLbYyjYVxfQWCgd+tSRW9uvIDJ015gxLoMYqPWckrpXiDooj5rJk9nu8BqoNLEEW84H
         kmOuM0vRa0imypcxXZt48otuIet0Og1yJ/jp41c/8uO4A+MI+d+QL01IIw8on3pXjiuP
         D/eYCwjFsd1DQLdYaYqZa/RmHiOeokkxwktBRQtU+wx8W9FLWXm0aYdZFwkAKjwbwTQ+
         B5gZs7J83SqfdhKFWuhlORWzRK4aHRGZYbBvARSX4FXSLY2BrxuVHx5DtUq47brzsyZ/
         530Q==
X-Forwarded-Encrypted: i=1; AJvYcCW13tIXM4T4er8jUzWjBOS7JauihCVuZc//YOQIcU9rUQCbTn2XCxbxQCFjE8U1JPDgw+LrF8hMfutowOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkkr+EmjzDQIr0b/rFno06oi7nRhFlkcEWLh/g0E8PQwQvlOLO
	EwuRtGiLuh/Y8YPvftf1IdsHZSC2HNwjQye+uPPQ7Y+R6hcM+MylQaYvQ+sbZ2eVVniOuUkWE9s
	Pd9VVZUCusmmUKW47v+ExDHRLKdIbndPeBwjl9rJoD3Ve/GHsnkZkyDlad9enhVMCrKc=
X-Gm-Gg: ASbGncu9FyuA3yqA573g8pYcatlLBEK2hPkBFbtRJApr6/7zB87k6etyBll/5WeXGz4
	5ntMBK5boIfXaLOQ/9sx1qNej8P0clCsBRTGX5KNg6hchlJrfBuj9dVY4T8P8WmuTM2xxkqeSME
	XtoSTTxwvZ19rxzMAHcKZuG+wizn8xBTz9j6uI/+dsiDJ4Zgxyzz6atquAE4VWqilA1S6bOv+Iy
	Ilcyf5t6/fdc+odAFdpV24ft7Qup+p2yTaZr7nJXZxugbzWQmcx4jJSd7YxOLKBXw6ec12flpjo
	lQRYUvErG2Sx0iyEsbXSNkrOSy2ZTHTnjhFSTH4qSqS+3ELre7cInQqpEeN+eBsNQvP2Rjxd0UC
	QxW+b1dwBYXLq9gCgPY5kdZCQm9aO1/mYjqYINF8zQrUrz1Ef0N6f90TTOA==
X-Received: by 2002:ac8:5751:0:b0:4de:74f8:b2a4 with SMTP id d75a77b69052e-4e6ead7789cmr70880251cf.53.1759959608104;
        Wed, 08 Oct 2025 14:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtsj8agBcjTN5kFH9CtNM0OzQ1jTxuKqFj+4DXfwj0ka8iE7f9si9r17U108+0JLIV8tG54w==
X-Received: by 2002:ac8:5751:0:b0:4de:74f8:b2a4 with SMTP id d75a77b69052e-4e6ead7789cmr70879791cf.53.1759959607556;
        Wed, 08 Oct 2025 14:40:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb2512sm375052e87.94.2025.10.08.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:40:05 -0700 (PDT)
Date: Thu, 9 Oct 2025 00:40:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 drm-dp 1/4] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <w54im5c6zbeoik44jrzvwnfrcxpbf3pzke74a7r4kcgq6balvh@d33v6xpmua6s>
References: <20250926011500.2545817-1-shiyongbang@huawei.com>
 <20250926011500.2545817-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926011500.2545817-2-shiyongbang@huawei.com>
X-Proofpoint-GUID: xBgtbXFSX_PGWStOV6_ZFVzeZ0MBjsKK
X-Proofpoint-ORIG-GUID: xBgtbXFSX_PGWStOV6_ZFVzeZ0MBjsKK
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e6da3f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=QVYvikxniASighArfegA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/d+m9khjf5H7
 HLPJZumlRkYJQLUzx1ealPhx1mAipF49xdPCCV9WCFV93af+WHciPYcmEIHoMgvUUBAtgeDRh6k
 PjEpZWd1CcL1K1wkBVx5Ywu39L9watdXWThpS0aAcI62ABF7YJsnupU+YRG4yJf9EFeOUTatTfb
 QER6gBdhQadRRcedkyWGxLkjOa5cVG76+jKmWcf1NK8ydWEy9/HVYPMw0u29AnvY6cn5JFnA9u2
 YyQdROSYobxg6tw+ZoN99UutjdPb5VpStsTPrIOFGq0keZyxm0p9NDTP7ZPOZ6A+nVUkVFLF8RG
 EeGjcFC81wXQUrmyeHLVtzBRjBngzR8HUjqfnjSQWAm5PAF/Yw53aaPd5wwiTt66rSg+J+RK1zh
 uTeYwLaCTD9ag7tXnaIHO4+kxuA3YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Sep 26, 2025 at 09:14:57AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> The issue is that drm_connector_helper_detect_from_ddc() returns wrong
> status when plugging or unplugging the monitor. Use HPD pin status in
> DP's detect_ctx() for real physcal monitor in/out, and implementation
> a complete DP detection including read DPCD, check if it's a branch
> device and its sink count for different situations.
> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v7 -> v8:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202509241625.o4mNleVb-lkp@intel.com/
> v6 -> v7:
>   - add the check about branch devices, suggested by Dmitry Baryshkov.
> v5 -> v6:
>   - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
> v4 -> v5:
>   - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 12 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 +++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 48 ++++++++++++++++++-
>  5 files changed, 71 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


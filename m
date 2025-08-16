Return-Path: <linux-kernel+bounces-772288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E7B290E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A9F1C20160
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E892211499;
	Sat, 16 Aug 2025 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anMot4ex"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CB1865FA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755383645; cv=none; b=tewn/UxsTsyFTwJFDj0IMr3EAFYMNC+uTN1KkMBAzZXtguURZJEyd/vIsy2CBa1h9lX8aIjhEXvmUT9gH7dlzN5K1hAsQA8l5J55Grqi+cK4cKIMxhhlPNHU7RHoO67JsXmoQxbLGTcPh08n++XXPuOmaKFjGZRHWPblh2JcKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755383645; c=relaxed/simple;
	bh=aesbt3AXx03IQaal2YIdWuWsJyM8gXq/T8FJFAaza0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK3E+56kSMSMU73oA5ldtq37dCfCK4CnNqxjmyFlPAB6E63xL681nNzH2cP70vGsleefY643HhnYmPqgxqCbKrUxTlrnVE5kCX9gMPmhsX+VGUW7zm+W/Pc54miT/Lb+RMzAR08jU7S/MyJi43ITX4aEc1Vkx57r2GaH+sqzPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anMot4ex; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GMSUjE016084
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q4t4Yq7nWJACKnGzqsWuoGmd
	BNwwxCbWpfOo7w97CnI=; b=anMot4exsa8UK1ZlsR5eoepruRKhxrgGpSUcIbs+
	cXW279sNzixs4wvcGtUivhVnFbngvjNatnLVi2ZkVUimGnCwVBeFpvvAhoR7BEj8
	UUw3+shcz2I1mtV6D66z8Xjm0awFdYqkGT7koRMZDCoJJbw9gDPeaf4gVT8jSZ8N
	yxF77B37LbFH0fDJN5CSxSkotvHtlqszUO3PUQGkRdi7MEqd3PUF3MaEmsfLrLW+
	iUHPRLlc6jAh881Yn3ohaQFi1Llwc/Y748tmZIRY0VJKryfkcsgM2zgrM4wqgLba
	wcB7GI5OT3mV/XMYZkoz+4ENmYoqvWV1euiu7FXa9NRJJQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7s8ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:34:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f55836dso71304956d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755383642; x=1755988442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4t4Yq7nWJACKnGzqsWuoGmdBNwwxCbWpfOo7w97CnI=;
        b=GfQswQLELgfj9RG6UuzgHqr5WisdAggOqU4xc006kAkE/YLC7N7vX5rVs67vK3o6Vs
         xGPidkhsvol7LgwCvPvra/O2gdqxKNm+HavjBkkKC6zfEjr9QAq4htTHMijZzr5YvMqD
         ztrM7V22qBqc9Ln6f5iH9yd+ejie01Ve0DosddXVIKkkzgu+kMtfasOarGsqkKJTnhRO
         JKjD8+qUiJ+E+Ki41rl38K9KE4TMW0+G0F0++dgTu3rzL0TOTQO/vuxxaVMiu6ZlNEBb
         oterMMpalOIuG4rq0vdNbJ3BmkA+vNaniSHt/u8QZQAJYgmPa29Ag37c3g8Y3+QILpjm
         Bc/A==
X-Forwarded-Encrypted: i=1; AJvYcCUrSA5H9ot4eElGJkE1J3bC9+0z4oA+jhUxjR+x7BM+lwFM97LjOYJHaY1va9hR6MhqmwdqG6udbHI4lGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsA0zm+eP9GVvHmkCQCsdE77e87xx6ug8jsPsIDypJvgu9VH1
	0TOqVpR2QmEXoheXTo8wVpQhmrGtXsjqYas7/9kB+pvudyGfTO3QG2Ektw0jAfBTEStrlVymYlU
	TMx64yaYq/qwc+f07pAhBYGiwNMvKDE3m+zlGtTu3pyYMv0eauoBC2oVv/O44khxPMlE=
X-Gm-Gg: ASbGncuTRbYVC1EodcPZzELVbj1YFCYTeP1GS9ME19jhy5aDa3HcHRKtiJa7o0Pgo8M
	rNRQhGtRu4a3dxICiYCiKnSxCEGLatunofMQ8ObfCneW7pRUrbbEzbzhmJpDdRG3VtAc+D3noeZ
	hEaXOY9Pn0tiyrX316AQn4wS3o3O5VCOkE+pdt49043eisGeS7AwwIcomH4nz1Qw9XUQooOemr3
	U24pSJOLTRC8s7G07TzAPTfaTk5ne+rGIRapqJbbwhnWIE9D3F70NUfQm7E1+ylmmhAVaKATQkf
	5dZvlX4tSxQcpnDah9XFv4XFVX6RzC+Ofb1WPqjqw/7nM8OqGVqJW0AD+7eW0PhXCR2O69e1hPl
	VXp8SbRxcX+oc4VpBeDe6bxwqddZ9/k2dW78WPBWYmXWoNco3kGyW
X-Received: by 2002:a05:6214:21a2:b0:709:f376:4633 with SMTP id 6a1803df08f44-70ba7c3f8c5mr73425186d6.40.1755383642129;
        Sat, 16 Aug 2025 15:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+7ayQ8Rky1f/DO4Bq30+OAnsmEz8AWyvR9WH7mytwag0di1uEUNMP9LjsZkcGzpWOZG//Sg==
X-Received: by 2002:a05:6214:21a2:b0:709:f376:4633 with SMTP id 6a1803df08f44-70ba7c3f8c5mr73424976d6.40.1755383641738;
        Sat, 16 Aug 2025 15:34:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f346bsm1023490e87.113.2025.08.16.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 15:33:59 -0700 (PDT)
Date: Sun, 17 Aug 2025 01:33:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 05/11] drm/hisilicon/hibmc: fix rare monitors
 cannot display problem
Message-ID: <6yd7injgxprrwnvtl6rbmqyiglmxo7vhrkt5ntsxx5gza6dbkr@3ea7aqnynptn>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-6-shiyongbang@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX0QMpeZSPRYh9
 e52EOOCBZeWDA6AuToYcds8xwb0bdqV9AmqiBWgytI+48gSR4Q2nyWhypH7KaG23sNnXaRtgioF
 WawI4zXOsl9MwZYj8YValrTQIT6k7jdAACWR2jeDFW+skeZgyqvXXHk43wg6gGvFbOGyY+uYdeF
 RZSjStX3snqyKFv3PYCDZEDpTAEa49nGshoGdqwx9Kyb3I8LhzSb9KRDt7H4v5w3fwceGaf4e6j
 mD05kZrlo/VO7HxhA8pgHVEjjaEVLEn5itfBthx+OHZYQr+X1VTh5QYZsYpzMHYljsAcyz0zXDv
 P4wclsx9dJ5u17YptjF/bdaJ/InD/4Ydrt0H12TGyihT27zfoQlIGl4uoS1FIaoKtdfSadrh2i4
 Zl/dqTzn
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a1075a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=iEpkLIqRWSW7oLCy194A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 9KpO-IUdiopEHQH0hV2OxtV_ntxRg5F8
X-Proofpoint-ORIG-GUID: 9KpO-IUdiopEHQH0hV2OxtV_ntxRg5F8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

On Wed, Aug 13, 2025 at 05:42:32PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> In some case, the dp link training success at 8.1Gbps, but the sink's
> maximum supported rate is less than 8.1G. So change the default 8.1Gbps
> link rate to the rate that reads from devices' capabilities.
> 
> Fixes: 54063d86e036 ("drm/hisilicon/hibmc: add dp link moduel in hibmc drivers")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - remove non-related changes, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


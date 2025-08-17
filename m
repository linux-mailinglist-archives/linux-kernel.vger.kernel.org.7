Return-Path: <linux-kernel+bounces-772531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9CB293C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EFE20587F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528522264D6;
	Sun, 17 Aug 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NtXSiUtH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043551DED42
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443887; cv=none; b=tNKn2ti6qr1iYIIgRv2rLWgqeprHQIEmij8qItw1dJA5voJ8ihfvwtjzN/o1twSGX/TsD9LG182FzVJSvVuZ0VGfY2IDJ8EZSO0frqP7cf0oBUUBsGSiX3Pn3Y6eH76UYJpnH5hXVNihLNxuDlH/m8hQI4E5U3sgdRxGyAPPDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443887; c=relaxed/simple;
	bh=2ZuRyEbuyq+0YSvoDJJLQbZxh1Ce1UWh+dcD8RCeI1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu+iqtKvaVpdM0f14y9Bkgasg1w7XbrqjN5ZZ6aTLQyle3H2j4yKEO9qHdaisss1DamvP2glB76pR3GtijPXh81TdS2iiIduCXZWXrw5cy8wW77gW1TJL/TCLZ6TjQqr46uzUFp149zbRAUcxrxid+UMAkgKPGkLJiY22+euCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NtXSiUtH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H1jmnb032401
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DVtq03N2eWvCYxoFDoVCfdAv
	7zK0fqf0gHFxZ4lyj/E=; b=NtXSiUtHlgu86gRWOaeG2MIGJW1umoVM3jpGMIRe
	gm9UqHxvnfg3l0Zp4Wx5/ixylGwi3gPsl17vO7iVQCg9126+qoTkWdxklxIA1Mth
	vUgZ31FsqytD7DjwGMxoenBxaovRcJZcMJQ3Ou/APMyL42rsvq4xGAwIsar/72TP
	au6UP5rRZC0jl3SZMHWv1DQv5kwoeLdrI/FCdYFn/DFZSJReB5n8FmdGMgVaSXVf
	0V9XtNngQtjS4gL3bdzFZu/WwLiuwlOkGgnDAK/FDBTPHc2Wurj11Z+24ZbMqNEE
	foWvwxl0HTMLmlulYcQSNdGA16kjitW6hQuQTIQyx4A/jA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ua8rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:18:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109bc103bso96482331cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755443884; x=1756048684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVtq03N2eWvCYxoFDoVCfdAv7zK0fqf0gHFxZ4lyj/E=;
        b=s0LY+YvHs7wlRX3EBJKhfJXNdjLsjuGEjn7n7c+rBPODPhSfrF2HWkWk2iwKj5A/RZ
         hejuoXvLg3o0mq1dQpOatE2JSnHtLgIDBDxmwMBYwHv3mkcl1/2oXu3IcyxMGtTumc7Y
         HzU4sy+VRaI6vYmj1hVjAuDVmzQQpVdTFndo1E8uMTRNEyibIWLJMUZvs9zDJB5YaAM6
         fotWEqGEP/J1tWi+PLN+YbacLyeK1f7Gpbsn5X+YmG4t4gUDT+dzujEbyIflDl0rbg40
         XAF6zoDlFLdHCES+zi9aW42ABlsnGOsj3gH2NxOItgYwxnL52lfe61Uyk1gOJoReMAtH
         TNEA==
X-Forwarded-Encrypted: i=1; AJvYcCW3yl4Yzb1j1FaiMQL/tQxlH1Lt6eJfPMr4lh/UIJ/pbM2G50h80GSgjVvX392cRoKSKl2h5gweh/Y5il4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4ddYLgXz+qEt+pSi2Zm+xnn5JEQo4V7ZvP2qIjSNDwj3YHn9
	BvcEexkoa8534HqvdkQ1oJoJiN700/lRQO0olRX/TPFFDSGhLQJ0cV1PI0s8w3J3uGwHjtcOPiD
	PUnJf69/4bRXIe6LgwpA6auTIR6zgA1gYo5IzVocKFNaa8dXI+Ud/i2uUFPoMd+y4iZ4=
X-Gm-Gg: ASbGnctecvfPWMLbJtc/LZuzuhcDJczfPzSybsg1DqHxPD2wV70JgzZBnPxDbMYEdC4
	jqPAxpbmuWxbdLDuUXHQF81+/G5g5LeSgWiaJAYpVvr5yzg8RCjb/xKPcZJbrTsTGerkCqWK8py
	p9etDTRi4WUhF1uoNiXfxixxU9/J/gOhKC6S7ZNqhrxQWyEDl+sxC43wezkIRw7kqe5HzD0nc5Y
	Hlr+nXe7sgepE5nRf16TjkmlDxoIiEL/VlcZNAZ6EoQFGzv+wWroDvQECDZVphlGu8WxwmziccN
	Yi96p1bcN5yY5PZtc63+LPe/3NBj2pjT6U5ThQwaOKQOW8uzaRxsCRFm1IONjk0jaOmKwZbj7pY
	qRhdi6ufZJLz3dGmPNGKVdy+4i2wMOgCD9yDkiELLlfKwz/Avl2zK
X-Received: by 2002:a05:622a:903:b0:4b0:83b4:5965 with SMTP id d75a77b69052e-4b134078a61mr46289781cf.14.1755443884035;
        Sun, 17 Aug 2025 08:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHltDHiuCeZCVwTwOe74kK1SRRwV/gj6QEhYgm9ibUJb+8rvx/XnMr2jEUmNikR+oL3wjFGZg==
X-Received: by 2002:a05:622a:903:b0:4b0:83b4:5965 with SMTP id d75a77b69052e-4b134078a61mr46289391cf.14.1755443883561;
        Sun, 17 Aug 2025 08:18:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351a15sm1267137e87.2.2025.08.17.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:18:02 -0700 (PDT)
Date: Sun, 17 Aug 2025 18:18:00 +0300
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
Message-ID: <uvujumkyv7kkynuepwfmth4oveeiuwb7x4dbcouebkgigbxkyr@woz7syyedvwk>
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
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a1f2ac cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=xc3yqRnLLWJKpjLMMokA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ze3pqVCfsxFvIdGxJ5pDxmlSO035gRG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX1XFrTZDvNsZq
 SOjT8gjcYkShFIUeFrPN4ZDDrrl3QLywokEOwGv3+ryna2/uIMgq3chRR8cARd1qgNy3FjYtxHc
 brI7eg7MxtZRf6sEar5eDTXBcE3dp8GL5tN0ag02vawg/iwS4waiEQ1V54+SpJfr4Umj61w3iwT
 Ya1vJqDMO95xOjby/BLKUtAUV8lAJcrkVdtXAtluIb+WS7EcrvpFDVCaiON15fJ4f4be9nOyIFZ
 LqHhfcHOxtkkzBrC8iNjjJ6AS9WmXkBEjAsobKE5Gmu241DApw0Q70+zHq36aEkFQrm7og/6xb2
 UgZpqYo3W2OG9JtaeRp8Nr3q/JOB2hgp1s/X081LHMQbKAtzCbKUetcMuiiv9GQofdUPjQWpzK0
 4NCw69ZR
X-Proofpoint-GUID: ze3pqVCfsxFvIdGxJ5pDxmlSO035gRG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

On Wed, Aug 13, 2025 at 05:42:33PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> If DP is connected, check the DP BW in mode_valid_ctx() to ensure
> that DP's link rate supports high-resolution data transmission.
> 
> Fixes: f9698f802e50 ("drm/hisilicon/hibmc: Restructuring the header dp_reg.h")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - Remove the clock check, suggested by Dmitry Baryshkov.
>   - ( I'll add them in next series after redesigning this part)
> ---
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 10 ++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  2 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 +++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 

This more or less matches what (some of) the other drivers do.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry


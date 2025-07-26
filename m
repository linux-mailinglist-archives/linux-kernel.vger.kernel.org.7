Return-Path: <linux-kernel+bounces-746541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B160AB127EB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42237AF9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B335957;
	Sat, 26 Jul 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtUz99jy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087662E36F6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488911; cv=none; b=cXNkD1XBgCmPfeVGKBBTidd3tCnP/Rf56a91705HdwVgst8g/GaMu4f9lrGZl+jdMz5gwz6zUbOcgZ/+vt6XY6PMK2fp2YZa5GpraL2ZLXBaVmCab5L3te3brVg0lWeCoUKmdpdua/RawW0cFyE3yZnGDpntfv+sS8qRq1JS+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488911; c=relaxed/simple;
	bh=E8MY0MEYREs0aE/K+PkdhfREa5nigD8HeuZ9Ki+MYhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOkfL3866oL9GGFQdpp/VqcY5ST/5o/uHUZIe00ub8Wc5HMsiFXec2sIpgPgjnxTHMU8GqlJe0yMaeGD33Amwtq3J2VFbSpSY45sWbiCTsQVqAC6Wot1kcS5waJcev7pS8qq2aX2JwHG8w/jhj6IUz0j76hRI+68rqH67f+K+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtUz99jy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PCW9ok020076
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EtYLr/SHernycwo/uLJDpSmW
	e/0fY0sBOUuxVsASxyo=; b=YtUz99jy4hrPtvY31jcLkeAuD8BdeWHNdkfy6UYV
	2VbnSKPbS8S6BXSvbrAQAKy5QvUUbO/LgJeBEqDWq9NyYHtpzohVGT17gDrFYl04
	1II9/temRvO2Q1rcgeRtwpKpWOnAgndJpLjCLXO66x4hwpbHreCCJMb1KVprJ3l7
	zG9Y85rggGeq8SUG8GZYjNAApYZV75MJdaS3oOk0NIHKIjZMmvLwSsC7454HuQzY
	IsOdPnVtrsEbkrKGFGZlVmgiYuBd5TThQYdcSogkC1pVDcf39gYdQLNoQiUF8JUZ
	2sDXjdq/EgTAQov5j/LtyoeiBlnOJseAWEs31sIrAD7LgA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xkpny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70707a55da1so81147796d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488908; x=1754093708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtYLr/SHernycwo/uLJDpSmWe/0fY0sBOUuxVsASxyo=;
        b=uWJvdAh3bFcT3IQWUjQBfoBb34DRiAC2Eah41eMwB0AQnmRfUjKbcc3uFrcFXFriFO
         tLzeGHSuGJT1e9Wuihm7X9ZR6mu1gE1OJ5j/0m3nJSnDKrFfgDFed2zQtoxP32VM5yQG
         cjl4i6Jfvjijw2tClr3CMhLWfFGf+/GWOfyPTrLAHxXNttl+uJG3rKRmb7XaBFkWKMQA
         gokmOtsOJof5aLVwsUJZqLWZGJIjkkz6wB0ClciLjnrbkAkpBzfy8TROvC6HOvigtZUs
         cVimvujofnIOUfegy8uv3o1srm+1RE2/4iEfodOQ/PwBUSHUUCGmFN9eWOCHFCMOhyJN
         tcSg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCMQ8HwxvTKejI1Iv+o48+9VReYS49Ned/7vHMHg+73R0UUm2G3DJ11JzZLX7BC1IAENaryLv+R6hi1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSHTQU7NHjp5wGv/ztYHPocWl/tdIEPM1jsicBpJj+zDlzuiS
	GikLqJtI70c2Vr/VdbanP7+wZUg1SOhwVJye5v8bTKsBg6lp3DICZa1XwFBU+Q46EP3Crm+cx/i
	oMaaHFB+3fbFj6QBH3o8vT1rqIufj9DQXGPm39NS7ogvv6seScCQ7+ukSjMZThOhGIx4=
X-Gm-Gg: ASbGnct1YXcwo3VKZtzgIeUG2fV1g1feJuSS1P28KPf04aAKQeln5OMH1N1x8+3dg5G
	jxg2L/0bOAczDIw0Vp1zU4jbp+UBRNazDuoIkWO4KDp3VYTX9ZykPBdi4fGsZ+oeuQS6PfkJ9SO
	dbHR/fs2y3sLl5mM0vGcx8XMlwc+8Z0FTSTFkfoH2ilUhSjo/7yl4+BCGqt6LUG8qTfswupMhUw
	b92nEOkjMo9iJNQ6z06vQAm5aXHnig7gsm0FuOiJ9nlMcqZTeGqt0o8o9pX3iHG6L6KcGKD1NmT
	7aFueHQfBAlR3t7+usIYuTEjhlblKcXPntP/TRTunGxuY3rH56vw4ie/fxE6eQi867P0Qc6ubAD
	oLRnYuYasSNdG2xV9Cc4NsuQHTMzcBlciZZ0SqW9jOn5XZgo34NDf
X-Received: by 2002:a05:6214:76d:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-70720534e2fmr63158486d6.19.1753488907818;
        Fri, 25 Jul 2025 17:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7feK2RtwupaGDRpvYsF4Rqy8R6n6ic8d0JslPO41UFKrxITuNTj+z6HJSoPo9gemAdVjoA==
X-Received: by 2002:a05:6214:76d:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-70720534e2fmr63157946d6.19.1753488907363;
        Fri, 25 Jul 2025 17:15:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d99asm197710e87.31.2025.07.25.17.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:15:05 -0700 (PDT)
Date: Sat, 26 Jul 2025 03:15:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 05/14] drm/exynos: exynos_dp: Remove
 &exynos_dp_device.ptn_bridge
Message-ID: <fkfivnqxpecqpqlk66nadp2lpmr6jxgudraiyu7skebb5qhnpd@i2jga7s4gqeh>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-6-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-6-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: sKKZadwPD8T9rWBhEzcu7e4zIEIHBMV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwOCBTYWx0ZWRfXyoWkTvlZzKOa
 X0enMZpUL90qCuQiVtat1zYx4Xw6Nm3fF64ecT22nmpYSrp5V2UT6+/tmrteLfmXcG5FpH1OSsB
 R0AXUBaZwd9D5PZYWAJRZ+fkLQb5fHvVggH0oYWM+difI7lZzOYA2SK/HVKTpPBa+fiz0Cgf3H4
 RDC98CwvacRcSYJ/NfNTR8/zyPtjTe+rQtWNZDdmbyOo/9BUm/tQCFS+5BqsOLjMaJR8H3CjYjv
 qjC/PI7UVnpyhbj1HRQPw306lt4F5B4fB2A+20TeManvs4dAoa/F+JtJ6DV4SvAorSvU2xwfQX7
 NQExf5Nh8BUmeNhsQrwyU4nzWK5MFmwLZxIEA5z4NZTN7i7jgVEPgr1ZPSQKMgXMCtjvWhJusJJ
 s/wB3lHQSMaxJuvnxBIUHYXNXCjtjGKHVNk1xkE6//5M54cYugI95cay66pG0T/ZKj1nIMGx
X-Proofpoint-GUID: sKKZadwPD8T9rWBhEzcu7e4zIEIHBMV9
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=68841e0c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=r8lg0YXQRZsV-nIv6pAA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=867 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250208

On Thu, Jul 24, 2025 at 04:02:55PM +0800, Damon Ding wrote:
> Use &analogix_dp_plat_data.bridge instead of &exynos_dp_device.ptn_bridge
> directly.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ------
> 
> Changes in v3:
> - Fix the typographical error for &dp->plat_data.bridge.
> ---
>  drivers/gpu/drm/exynos/exynos_dp.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


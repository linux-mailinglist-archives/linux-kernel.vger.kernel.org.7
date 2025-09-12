Return-Path: <linux-kernel+bounces-813732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094BB54A10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204C21886903
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945A2EBB8D;
	Fri, 12 Sep 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWrtb5M8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69381547C9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673585; cv=none; b=k/q8GNo5HiF55LDoetlj4GKWv9wzuM+M4DINxKtY7dpEIYmPEMawI1Km/+YEoCLYnhu2wqdGlE2kznJENywV0ywPDTW0gppbIcsnaGBUL9NxZanQ/siIsptupK+BqC+u9C5vZC1Yv3NDvFmFSzRL1yrUzPxZn6IMpajCOTioiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673585; c=relaxed/simple;
	bh=EPRqwnvVq7RFG6+168lPn3q1JyblPKu+9pU2ZTAP/d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOSFW9mv2vVBMa5ahZscnI7oiljXgSG+rg7yuHduUk5GsSubC6wH9l40UjQlsLZT+E9QlsoYZ0dE0FqeItEvY4Jy1ZxHHUi7xOKUo3k+FXkGhDQuBZfQUBKe/0aTAt6dq6JRLR7CoyjTgB6MWrWZadqtUyX4wr7TiMOH2YmulD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWrtb5M8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fLEn017819
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JZO37LOsBsf5QkQB3SdvehHO
	fE6O/aUfSqad1UHXEXY=; b=CWrtb5M8zWyJSZV0/SCddrssbyxp3WZ1WDxot9Vg
	96inzXhFYQOhvwakMdUZGf4q+RGMpVo7jrokQVN28Bd6Pj4++FlJOsPI/v6TIjYt
	y3VcRTNY/d+4FI8e/A0duerWbuBDAluaxBSNPVUTmSnoTFbcYkR0gX77Hig1Busq
	uEbHxm6i+l6yaBF38szdLXWwaBMKXxZDVslxqxwHRzVNzSFCpC/EluaZdWFETvcy
	R2yW+EYjq1d3sphNTXfe8e7Dyz8KGVc/W61OCSHI6h22VdHTifat51MXBQ8bJfJ+
	hNtxjJj5WrImWUPVWIrPcnogCkToZa/z9hLDmuLUy36HHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8u97d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:39:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3415ddb6aso69279401cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673582; x=1758278382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZO37LOsBsf5QkQB3SdvehHOfE6O/aUfSqad1UHXEXY=;
        b=kk8PGHu+/jsIDNzk2DVMty6by6cziNmCSRScqIGqDUBvUP7jj9dtzHXTM5JbTC6Vs1
         SvyXpGJ6DUiEdFnAozvtvw0DxEEGNh8EgHRKjCYRe/vUlhjPW8Pc2Blf0O9SEOLZtptZ
         n8biy8qALCCsZUhibdJcScB3UZ1ULFeOTuhM4Po4sMDdmz6R7dbwmo1Yg32qjl3xs4jV
         3KUx/1z3j/M7Ff/2Gkrlgm2NOq9xc4ksP6aJz+7qkb4FQc3lWS3npq08IP15WhmiADm3
         fW3nzFUd2WgpzQcLyLX1hfR/wZrhtpuDfZJnZMPuPIt0mdAtcO/i2fqUUnNxZ+CTt9V2
         eSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUAXfYpPjolgD4DFMI0n3nLX89EV69fTFMVypPCQkHgbR3zBpuVERsHlLRzw1yHs1XA4guF706BwXFnhAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwS9JhO85EbSOoh11Bn/Z5cr6rmyuBnbLTNxR9UTK22XN7CgK
	xMmy+UHqjX0vZaQpLf42nTc7fMTALZmdnylQlQmBonl2wvi5wGgIoD18uChtxuLlWkb9hR75HP0
	LJJtPfHOttsylAmlqC35OhnHbtw1PJViHOX6krovJTRU+0ZL52phgJnKBDwEIynDEQx0=
X-Gm-Gg: ASbGncvfGFuCZxr3wb8N4YBR6Wi355sNhL7vflj3QVcJQgT1NFpJFxMHCggh/lAcKGT
	DVXIDS5s2dnyxfTVvRjAKHYlflTIkJS0WgGnnou8YPMvxzYqx7eNujLeuwBQxwHycBsh+scfRyx
	5PcGgvlMs5rVbVmLBefl7WQz4Ffr63RN+wYDYiPBo2WmZKTp6NUQTVP/La/zJ8m214Iq3XpIlNB
	nM6+j8sLJjkRPN+Bq/Wcavtk2TI96LaxwAfm6heUn54+F5iBCYSf2K79qPuuENA76yxIff+C4pc
	RuKRhqlL1xC9LjjPgOMKkyVUfVEg9FenIC7zWVubBNxtq9OSrBfehiS00M0O8E6zJXUbudwxAnC
	4IfDOhUVm/n7Nxxuc7BirFHVlUQvkDPPDQl/C/2hU+J6s2YD1pguL
X-Received: by 2002:a05:622a:590c:b0:4b3:4fa9:4cd2 with SMTP id d75a77b69052e-4b77cca8d4emr39186031cf.33.1757673581465;
        Fri, 12 Sep 2025 03:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElx+sIo2TyNNDSZKhdIXfRdT6OrkK5agLSxJeNhZFAzJExqCsm6/N6pZpW9c9ZnhxyWSL7dw==
X-Received: by 2002:a05:622a:590c:b0:4b3:4fa9:4cd2 with SMTP id d75a77b69052e-4b77cca8d4emr39185691cf.33.1757673581028;
        Fri, 12 Sep 2025 03:39:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e646135b0sm1042248e87.110.2025.09.12.03.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:39:40 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:39:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 12/13] drm/msm/dp: move link-specific parsing from
 dp_panel to dp_link
Message-ID: <4kajb4imv4mvpf4bdzoqfw7f4qoqxsu3ca4pbgsunhxnortfig@kmsqgsj547hi>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-12-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-12-2702bdda14ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXxE2OpQ7g3vTJ
 2ysZWzn4WYLxPVKoXpfYPYy/WNkrCa5JIuCPL0DDTFa3eY2Q4vvwvfPHnLjLiAlHqBUNcz4w9JT
 RkNymF/T0riaB7eX7y7J4ylPQrVo7UeAz6u+Ed8u0t5eutIIos1eQJ5XIEpdO8lEXWdLn32vQei
 2P/mbHqlPd9l7EKrruloBsBYx7JTQyoVttKWg4h/DbzOJhuVQYC72FCQHsgxFbYbZnEzFmpKDoM
 9DLoVZu2x/aKzD1xA4ciU+Xz506FIjMkeQ5zu9lB1ErR74jZf0v3AZ2YoJNum1MGzU2iDpyiJor
 SPFWSDsMg0W/pN0UKlMc3R3ld9ePUFK/10JTxnub7g7mz+U5a2Z6yCawJZbe6HvCyJDkH9Euilf
 ruhSh+Cj
X-Proofpoint-ORIG-GUID: R69FZH_9EEDoHwwT0AclfnldC1YuItpA
X-Proofpoint-GUID: R69FZH_9EEDoHwwT0AclfnldC1YuItpA
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c3f86e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qgWfkWmIk_iXozLJbygA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Thu, Sep 11, 2025 at 10:55:09PM +0800, Xiangxu Yin wrote:
> Since max_dp_lanes and max_dp_link_rate are link-specific parameters, move
> their parsing from dp_panel to dp_link for better separation of concerns.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>

I thought that you've split all DP patches...

> ---
>  drivers/gpu/drm/msm/dp/dp_link.c  | 63 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_link.h  |  4 ++
>  drivers/gpu/drm/msm/dp/dp_panel.c | 78 +++++----------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h |  3 --
>  4 files changed, 76 insertions(+), 72 deletions(-)
> 
> @@ -1225,9 +1283,14 @@ struct msm_dp_link *msm_dp_link_get(struct device *dev, struct drm_dp_aux *aux)
>  		return ERR_PTR(-ENOMEM);
>  
>  	link->aux   = aux;
> +	link->dev   = dev;

It is only used during parsing of DT data. There is no need to store it
inside the struct.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


>  
>  	mutex_init(&link->psm_mutex);
>  	msm_dp_link = &link->msm_dp_link;
>  
> +	ret = msm_dp_link_parse_dt(msm_dp_link);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return msm_dp_link;
>  }

-- 
With best wishes
Dmitry


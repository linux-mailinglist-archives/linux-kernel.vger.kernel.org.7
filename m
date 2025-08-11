Return-Path: <linux-kernel+bounces-762354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F118B20559
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3552F3B7A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E221772A;
	Mon, 11 Aug 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbTh0PHL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60F3C465
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908252; cv=none; b=YgzhvQQLGAHe5SXHK1oykStn/mvI+NoBAClFSqu+utAgVANjV5kkjqU5+uPTrDkaFIR14Kd+z0vFXu6fqrhdsJ0qXDJ7+b6PSGrMV+EsIWxHdWaBcm0NZRPllP8BO5zXJqe/4uMjeFq8ZNBnd3dfJXIO8qZG4VoMmF4TSa8Y/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908252; c=relaxed/simple;
	bh=x9cOwHUhHXPY8X4ZtckPJM8tLZN1B2IsS7ENoVbe01E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6XwE4hkWyUNb+syN/U/gBDXZXQt9Gf6wLJMoMc2AfUPgfm0knea1/5OYlTCob4ZEagqiRl2KEEkyPyqx/aExyXIftc2iwG+MQHJVkNhFdOWttgTN81d2FBI8kLJBDwyszu9P6R/Ffed1tjnhwXCgyKnrknz7G1zjbpJWwe3FE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbTh0PHL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9G6000605
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UnmCHPZVrs6fp3g1DtME56zq
	8DIGelnQr7GBLyjo+J0=; b=AbTh0PHLe6Hqp2GF83C7oLkqY+xVq55GoHfPraLC
	j0nzYRel48zZlDChdvMVVHR2hzfMm+batlJn5gCFSWgYWDzChUfisDZKLkY6vCaA
	JjuWic6QnXKJ2g6RoAUnFptBuh9sW+s4YIHwLdhdhKZN8+x4Fx1oEX0iQpqRxnaU
	ZBzhCI8dFXCgdv8znKcS7AHTCLpzrzZuqCGHLiysVQPP+aGJ60O2pddpOo9r7rfI
	EkuHER38D9Rhz1aPFplGkdo3WP8+Ay5N3BFaqpoaf3gZFIJ+onRvoPIYC41ZCdlc
	EKPyYG1AAkYdweKK4EPOIoLPEzwXXElv2SnANmtSc/gu0Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6uyd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:30:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b076528c4aso45955561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908249; x=1755513049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnmCHPZVrs6fp3g1DtME56zq8DIGelnQr7GBLyjo+J0=;
        b=i60CY6c6lHrp7IncWOh1ni8L436P1KkUuMVpyY9LLPk7Z3P+5xQd2tvhONqhQD4X2e
         gIfHnuVcWFJXGjuyAzn8QEqNStH3Bh7YTVcgGbnsjKpl0+5qlJaqqcbiCMe/AdHEpppp
         NVS/q7Hzt0kJ4TAUfBej0nUgpqwH0+fr9Yvqjz7mE5wuk79Fmkyoia3husn8R9gKMOEg
         Nc7QplDlqtQgkj5///dlgaNWapP4XeDhzUE1cWQcyNy1eL8q5IjGSek29f/iFJwllS2D
         Jo8sYQ7esZ+gVADwqInL2GMmWX4KupXSzVDnzuINAQsJ1Rg2LfhKHxuWV/4+r8U1mQ1L
         Qi+A==
X-Forwarded-Encrypted: i=1; AJvYcCXubkX4UQ/umZu8iNyZzRaloKQ0yYK4QmCrEQjD70NjtrB6FJWOc1wfL+JM64ig2VRaR+hZqpWhLEnYzzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRIy4tHFttvK07i/DZV0dcTeCvem3ZIuIapVw/7cyMTBkdLN2
	MsJNNnn6QPti4waHj/E43y2CjEmNF861LmqT/v4PkFuUmsZZMJvyx8bmV1HuCjNsynwY6LEY6H1
	E9209+0OL4HPU31np4pt8j5hgAcnxbyUBpsOmAuGzQhpuiTj+54Z7uunTCRwuIdnhgKg=
X-Gm-Gg: ASbGnctCQxD/pyEMUDxjGkg4F4Tc+zRQZbgvI7PWQoO2cAHLlPXeajwUxtK+zvllfOe
	BvZvrTR2u86ctcnH/FhoRAIjUZ7n/eXqbytES0ZsCIhGVoAn0wio/YPxtxaYYNYlKttFvd22L1E
	4oVCuzh9Bo2F6lhQaMmb/YejPN+Dkk75ar6l9aRrqZsUPWQZ72KlEHAhFPEDuX2gNTbUx9qPLbS
	KxEkipu1xx9W9/qoGVu/AdmtNtf8qrW0Jq3ek1PpsQdZZRf0NIF+gAdXxyS5dxpmQYskxYisu0A
	krbAcK+Nsy8O8ZikIJePZ5ucENOfRb9kjOzQb/NaLmVbTLKUJ8fm+9NIUs4x/GUJD5FB49g8qpj
	nBFhwntC2crimYpr+kZkOmXCos0tfICkMdM9l62oe2qnozf37OiOd
X-Received: by 2002:ac8:5806:0:b0:4ae:8835:3ae1 with SMTP id d75a77b69052e-4b0aed41babmr187407961cf.19.1754908248542;
        Mon, 11 Aug 2025 03:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuf5qtoUnT+tc8B2ICrvl8IAPGTKvOtw3BZsZTanNw0atI/DIbb3U6d2sGEsqxH83orNUAhw==
X-Received: by 2002:ac8:5806:0:b0:4ae:8835:3ae1 with SMTP id d75a77b69052e-4b0aed41babmr187407401cf.19.1754908247969;
        Mon, 11 Aug 2025 03:30:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ccccf88dcsm938218e87.55.2025.08.11.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:30:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:30:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] drm/msm/dsi_phy_10nm: convert from round_rate()
 to determine_rate()
Message-ID: <conbpmqs2cdgyu2oub57j6oq562yzlfvdkidfbetgsobndya43@wj75ikipfz6x>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-1-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-1-0fd1f7979c83@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX4d1Iv7cnPlOn
 MyHFY7jxD3AzbjIjjC+/g53ZltF3yNhS0nUdXnK3pU4+nYFUMPcI6uK9MTSF1sLwvhEA5AeWwXZ
 uc1KR0AwzYv9UAxFfkL/nSR4a2oKBCtPNji5zRmB71kYl2oL+3heYTUaQpSRAy6Yrxqy/qIQMxg
 ikh/sjAh/k2X27+y4i3YBaWI+n1XVNRWarE9CUn9pAkmbJ5ZOQrmFhF4qB6ExsJ0Cy5TuKlUCia
 +r8aVq13kRg11GJhtIzrg4H13hut9ycERyTgy653Ln1sgxB6YXzDSpSytHsRlXRhWTYf5lZDRhm
 zTVXqIZINhOHPVx3/2TiovEnFC6eFXBFRpI/ggskqv1tkEYKcbHan0XVfFE6mirHJu6n1RCSuPl
 YNs/DUG8
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6899c659 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=dIVbyNGrPfH0ZhoiaTEA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: XD7eB8tQw4YK9zN9MvYScwlhmrwHFad4
X-Proofpoint-ORIG-GUID: XD7eB8tQw4YK9zN9MvYScwlhmrwHFad4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

On Sun, Aug 10, 2025 at 06:57:25PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> index af2e30f3f842a0157f161172bfe42059cabe6a8a..ec486ff02c9b5156cdf0902d05464cf57dc9605b 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> @@ -444,21 +444,19 @@ static unsigned long dsi_pll_10nm_vco_recalc_rate(struct clk_hw *hw,
>  	return (unsigned long)vco_rate;
>  }
>  
> -static long dsi_pll_10nm_clk_round_rate(struct clk_hw *hw,
> -		unsigned long rate, unsigned long *parent_rate)
> +static int dsi_pll_10nm_clk_determine_rate(struct clk_hw *hw,
> +					   struct clk_rate_request *req)
>  {
>  	struct dsi_pll_10nm *pll_10nm = to_pll_10nm(hw);
>  
> -	if      (rate < pll_10nm->phy->cfg->min_pll_rate)
> -		return  pll_10nm->phy->cfg->min_pll_rate;
> -	else if (rate > pll_10nm->phy->cfg->max_pll_rate)
> -		return  pll_10nm->phy->cfg->max_pll_rate;
> -	else
> -		return rate;
> +	req->rate = clamp_t(unsigned long, req->rate,
> +			    pll_10nm->phy->cfg->min_pll_rate, pll_10nm->phy->cfg->max_pll_rate);

Nit: I'd prefer if there was an EOL after min_pll_rate, but no need to
resend it just for the sake of it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +
> +	return 0;
>  }
>  
>  static const struct clk_ops clk_ops_dsi_pll_10nm_vco = {
> -	.round_rate = dsi_pll_10nm_clk_round_rate,
> +	.determine_rate = dsi_pll_10nm_clk_determine_rate,
>  	.set_rate = dsi_pll_10nm_vco_set_rate,
>  	.recalc_rate = dsi_pll_10nm_vco_recalc_rate,
>  	.prepare = dsi_pll_10nm_vco_prepare,
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry


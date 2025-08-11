Return-Path: <linux-kernel+bounces-762372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F5B205B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124C21889C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF02586C7;
	Mon, 11 Aug 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTqmBZqL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2517258CC4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908558; cv=none; b=P8QZ7CDbpalw2qQR8z3+Qr5E7jfok24NfPbmUCfp26gN7g4mD6KfyL88rgvvh5LZM0kHJ+TyleEbv43aLsOjEG3DJEfXQ2Ms9KfKjKXf3wc/+xlr/Fbs3C9WjGXsZk7J64kU/PBSogzdr+Kcbt7xsmpmXQwWgNWURZfRb+6AEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908558; c=relaxed/simple;
	bh=mwmkjas/PoJspIq5BCg9bX0zU3aIDV1rw5FUo9Xgi8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBCw0dgwnmz01owvjyrTOQXhlQQF/1KspZ8GkdSYKRB/GoRAslVzROgXe2HiJSjg6lQEgHZYg7YuOYXKyocTR8ieGa4iuqwok2Ph3klxCpCSAlJSnFSAdY34AanLeDuZwk9QOheKHZDYX4x0ME6toy5r7vZvFTqkwH1FjY/YrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTqmBZqL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dADm029203
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8L9FpvsfDpsj4VZq/OufIKbL
	+DTyr83VxTwATCE/HEA=; b=dTqmBZqLmGIfBWZJKBveSUIWlAT5tG+uvmHYJqQe
	Bkvc8Br581Q9qZNHpVI6L9Xzl5tKPGW0vNlBiiK1/Q8MejUyXmoHXTD7BcAhG91W
	wjajFi+2gqeiC4JdNr6MA2gJWE7xpdkBQ1C42Rz3N3dh6OC1EyfT8KgLK14R71g7
	Gz0DpAHLmm+g50WogaaU5SXhSJmAnwTT/dQQhOpNt62ykFxRwzGG7x+/M021sWpx
	3Re7dqn9dtv5cgz/kazTxkJ6l+TJtnGaaM0dbAOtKr3Iy9vNw1n+wfeA1F5AUKwl
	oHyAatjE3pzm5TfKHwNbKtuz5KoLhxatdIEoYu1Bb8RQsg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbysv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08a2b3e83so128417361cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908555; x=1755513355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L9FpvsfDpsj4VZq/OufIKbL+DTyr83VxTwATCE/HEA=;
        b=q6FD+Dd4Gh8HJlgF514iRqkpEJay5OBdVjRjm5pV5E4vx42IWQgPep8Bc/Bce5JEs8
         2vdwMLV1TjO9cpUjLeFcMVt/fwE1HTzQABTUYHrr85JsgaZQT64NQFf5NMYZzidLdr6D
         zEiAWe2Pea4M3x751fCv3wk2VJsF3vnZU+KORrQ1yRmY6gJu/zE0EyNRv/hLrYurWbgu
         TsZgcUfq2dFAjEEIbAhC3j+lwghx1kuUekGUBg2ahxjrlQ0V28VTCp48MIl19G3qPAp8
         gMDke/noGs1g4QW2IwvZ3OOSSXZAYLq1v40zxexE90VyWc2CK1yzWTqw5m4f02fYBCFT
         kdqA==
X-Forwarded-Encrypted: i=1; AJvYcCWaHeqPSJHv/Qw3mOfAki4GZOsBtRlwrqjQaYb97sb+Q5zyGXLm1D2kyfNBblXSoo+Fgov+7ogmFUSKN8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvV2nYr+2VcxSNm6ENbl2DnMoOgFv61FO5b/Po2EYwr/dPopv
	DvHrULFhUpps0TyCXr6C2ZSqbNuXNAIwhWQroq+puikxTbZQcCzLBFgkjWWCxYWNwCgUTMOi7wY
	Dv1034SfC4CuLdMquhIKKB0nQsecMaSAZBjqWM1GWktJ4X5gTYFowSh+5ldvja2vvovE=
X-Gm-Gg: ASbGncvMAj49+VwXe8RXHURtDb8aZe40jjhLigbBg8zec2xk8tQVAL6rjTIVeV1XwmR
	a79HP0Ttml0WEp+ky3fYQ42K+zAQRbhUGr/ye/b+lFEIOY9SCuKSbV+DLwOZw5Pqi7NTs7CUDqJ
	jKlg9Vhh/41EMTmXkFBT3zed7VaH3iIerFBQgs/qAtH6HWADJQMANvXfa2f6xov4Iq/wRF9fNjV
	N9f1/VvjM09EWsNlipaiPbpIyiGzSRI2rFgWi1X1B+ccHzXUm1SQqR/s0nTPkdOJdTyB3hsgqaa
	jWrGg4FXoyjEZGsA61ygOT+CWsM5ZpyoBrGmL6xtSaee3erpymg6eO9BtiY+KP9brnT+ENqAYFM
	gM9usHxlbWhZGWojj8h2fnGItD2NL8dXU5mrNOlrDwp7Ic/E4LFsk
X-Received: by 2002:a05:622a:4083:b0:4b0:bf67:3517 with SMTP id d75a77b69052e-4b0bf673f18mr121726991cf.50.1754908554705;
        Mon, 11 Aug 2025 03:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGSGkWKky4fViZdB9BU2n85HeQbATJIlEfA7+ozin7bCsrRVF6S+s11E+zYmbw4+o2YtN05g==
X-Received: by 2002:a05:622a:4083:b0:4b0:bf67:3517 with SMTP id d75a77b69052e-4b0bf673f18mr121726581cf.50.1754908554193;
        Mon, 11 Aug 2025 03:35:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99083sm4268055e87.94.2025.08.11.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:35:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:35:51 +0300
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
Subject: Re: [PATCH v2 6/7] drm/msm/hdmi_phy_8996: convert from round_rate()
 to determine_rate()
Message-ID: <snpidtke4k7cekzsbhs7vytr7gaoc2zmxadixgmedo5gtne7tn@laybummcgllc>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-6-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-6-0fd1f7979c83@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXysajbKpvqPyk
 sPEk7/Deh6NKf3fH49OQtFuZpFeAtasEiCZzFjg0K39QnKsOnaPvOjJjB0qOYbMbESkVQ/07OHx
 k7ANC1B83y7zCAGptn0o25y7qb0JvIq70gt8/PhrMSCxCTRhWoGdho/VCZX/g+j0fB75V4psLqI
 /f/WJKtC6GREq7efXUDiRGT92FPrO07OmdPUgPLRn4zIiEdyZsXpOEhwvbSAjPAzc22KXHDXRcH
 HzH/nuHTR+SWizJGNsfMyNp6bttNwoA2Iq8/xwUieMl9/pXNzA8mwqTTCwDhMcPAS7c4DhWp70U
 H1CDUOgbsF3qzmzL1uy1oX0FbKCRhP4VZ7W0m5uRXqVQIgHIRlmKzEqyxNLfx957eB30S8EWPhJ
 /jLTt36m
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899c78c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 91eRHoF_5BmQyo_0OPRe2905SMaWgV4C
X-Proofpoint-ORIG-GUID: 91eRHoF_5BmQyo_0OPRe2905SMaWgV4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Sun, Aug 10, 2025 at 06:57:30PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry


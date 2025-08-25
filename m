Return-Path: <linux-kernel+bounces-785318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C55B34900
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEE1162001
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E22303CA3;
	Mon, 25 Aug 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="figFNp7y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D39303CAB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143284; cv=none; b=cDgsbE3mdG/VlUldIDRCyqOMAo503Z2FzwZ5YwdycS0Ajf3M1MV6SJRpFzKUTBqjI1tf0g6iKw6jkJ3stMsysBFz0IAF6VtrPpAZFpNhm/Wcad7QmvlMSH/KyDkaLs6qjyCpokVwmlGnVHeiJIVOg7bMXL/+0tO/I4DKIzUv7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143284; c=relaxed/simple;
	bh=OFdR0RBMiGakp3f+hBLV7rkCrWnpRSrcV+oyx2l6vFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df1OcO3hZgZzgxtzejmH20CiL2E21poIcc/HEXsurKHpxcTgvfEaK7lFggrt7FeLgknsQs9BSvAPi2PI1YcJodWB9Jek/5q782/YW2sRvoOlILatjcKRfovMnBMMPBcz6iX/g23/ZPxzdw10hUoASeOhrESOHI5AbHMeB93vRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=figFNp7y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFm3H7004580
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=921Bzr011b9Fk2gqlTe/2ABf
	oYFpWqrFuSDN0tU0Jcg=; b=figFNp7yWDmkIdmseVps3EgfXJ5gryeuXcWD5lyA
	dH6bFvW3l5NbJR7L5OgFMRuNQo3oGOcKskZlSty0IY1fKF9ykdU9jEj6S3fUCi7Q
	RNObZIodLFJffFaph0aMvFbXWMDylU7ucoGsmJiWL/rRLKyf0nL/oUvXNqg+OeLs
	TcuxO4AURjP/0wxo357YcbWhk0doJ2GXWmgG7shNBND79+8EbCODQ2iBGDz/X7Z8
	6EdPd6etAuIhn3Bf+Mw3nTXSLwq21OvOZHZvqjYsU9/WNZSgfUTnMCl9VE/f3coU
	4D7gy5gEiLbq3e3vTUDoU+ZT5/ptJbzeaRec6izeZqlfRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um61tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:34:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2dab82f70so19502591cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143281; x=1756748081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=921Bzr011b9Fk2gqlTe/2ABfoYFpWqrFuSDN0tU0Jcg=;
        b=pSh2RtwIEi0thBFR0/HEjH7+L9akS6HPODU0117Anz7RllwZiziAj4J+00LTYAtpSg
         zR397WxpqqzQjEElo+Vqxe9nsQPZNMQepy0239AzaSCNdgxPdF+JH9q0hRXZ59Kfjv34
         Gr1Hc5QJhXd7pq6ZolGTl2ysld6bg1VxBNLtSowD6BfffcbUl0UUEUSbKOMvgMTF3F95
         t+uJwVse4152YjwlNaWQfesdkeXiNEKqJkB0K+xPJi6GK1fDbjt3icisHqvbY6f59nfJ
         cTzmUlSqXhNEDedeoHNY8dyAX+8tyJI2+iIJdrHirWqqGKmsWZ+dvD46P7eo7mbwq42S
         6bNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCIZjZbkLOg/bEB9xX1x62FPhSlKNC1edrGxP80fhkN2yIOsojY2UyOAQL6DQWvJ0UIXDF9HMM+el1WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8nNDYd1cwXZlmQwEZNN95tFeFWO4HAyu6o3dXD0xOEx9pK8b
	qGkt7uRxfbEmgj6olGwPIgTDIkQrMBMUkHtObLqXYgvWhUDzLpESFG1q9bS+Eah65ny3WD3k+fW
	H/9+IGGsju4zhJvfKBbd7CqNEg1UHGfxZB8R5bY9foaEv70rtiZczxdsIG7JECgVoIB4=
X-Gm-Gg: ASbGncvwYeU/nwLM7ISO8vTGat4bPhQL3zrVNVq8kJfszBK8+AB2GjHND6qRH3jf+L1
	9PBSrMZgMibO0IylRBmg2XpxC5IdvEoc9WH8x9STqNFIPDGRebxhbGYG7Dxc+S87+cr/TwmUUVF
	bsLm1wCCerXR6kKEBlzv4IsR7a153CXti6t8mYiI78+U4vwORAGFsK+XtKoLnUtpwNCaW34dU7X
	FmdziWIQpORcpHVaRuPriF9X1gHSdul3MQ9LdE3Zm09g/oulTGnUZDiFtInqh891X6ZeqDO2Orq
	c/rlJ83hX+cteG2J51yjV9s5HMN6SjFIvQMZ0K7tMDIOt3z3SAzgEAlNUiPnCw6ndB42+npiSfu
	4+YVdMOvYxkSMf44hQJk1OUcyoyo8WyyGLI9lcsSGV3h7ykXOOl3W
X-Received: by 2002:a05:622a:5c9b:b0:4b2:d220:4211 with SMTP id d75a77b69052e-4b2de83cb2emr22826231cf.83.1756143280799;
        Mon, 25 Aug 2025 10:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6WH+r8iVC5X6v7K3eW/AwuiBzcHaMNlP04RqOd75xHftv58SkM/HMIMyfwMINBYuS6fANA==
X-Received: by 2002:a05:622a:5c9b:b0:4b2:d220:4211 with SMTP id d75a77b69052e-4b2de83cb2emr22825741cf.83.1756143280341;
        Mon, 25 Aug 2025 10:34:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f46dc5a16sm544219e87.125.2025.08.25.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:34:39 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:34:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 08/38] drm/msm/dp: move the pixel clock control to its
 own API
Message-ID: <tmbatmfixhm4axvor3xliq75774vuz5w4ard42serfuwejs624@wh3sk5ug2u4a>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-8-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-8-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ac9eb2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YadZbbKFZxuD_lQ-BoMA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX+9ti2oIjgQlZ
 +sJ7HINiMehpxQACac6hgiavQ3SqPwMwoPn9CDtHkMdp0oQVWBzTClwjq57lB/6VimZkAVEIhID
 TjQOIh/OoK/eO39nVY79XT1BmgKYgJGPN2IUDjKZg8M2sxn3uS1q9RpQJvTwptuipiYiCinwcvT
 j2DtH6D2P7bHLQkkBt3QvqttdqD6JOPEWm9dQQwFjiNwxnjmM5H8wnhX4mGyUPgdkno20KAQfoq
 lAoSL7xehLDZUdEIjb4aKEAwajDTUvxTK7Vuos1HYvKWeIQz+7FN75tuOg+uppb6adqz9eD2sDg
 MvvpoV0E8z5PjwU8IDI5WZLRqeoHleIDwb+zKDnCUD8KDvUsgBtooynJD+Pw3kEM88eTWxVYWoj
 0PjRFlZ9
X-Proofpoint-GUID: y4jnrgGBC7fP5PRs7oB3JjgLY_jXqhnv
X-Proofpoint-ORIG-GUID: y4jnrgGBC7fP5PRs7oB3JjgLY_jXqhnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Mon, Aug 25, 2025 at 10:15:54PM +0800, Yongxing Mou wrote:
> Enable/Disable of DP pixel clock happens in multiple code paths
> leading to code duplication. Move it into individual helpers so that
> the helpers can be called wherever necessary.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 77 +++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
> 
> @@ -2518,21 +2539,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
>  
> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
>  	if (ret) {

Nit: unused curly brackets.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> -		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> -		goto end;
> -	}
> -
> -	if (ctrl->stream_clks_on) {
> -		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> -	} else {
> -		ret = clk_prepare_enable(ctrl->pixel_clk);
> -		if (ret) {
> -			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> -			goto end;
> -		}
> -		ctrl->stream_clks_on = true;
> +		DRM_ERROR("failed to enable pixel clk\n");
> +		return ret;
>  	}
>  

-- 
With best wishes
Dmitry


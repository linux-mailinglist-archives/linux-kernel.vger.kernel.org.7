Return-Path: <linux-kernel+bounces-760985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67BFB1F29F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825F73BA98C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFE27781D;
	Sat,  9 Aug 2025 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmVEU8wo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856218A6AB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721980; cv=none; b=lKbMUeZfiIHmR2iwU/U+C+YAC288drndFyaM4svOFJfbkzH3Tn9AT14PATAjWxLEAKbqFgEss1orQ3lLD3iKpARKBWwVuMMss6eMhjgQKlnA3xTKHa0JpYdhwqeRy+QIyrKKMXoGjnNrJmDvvIck5V95rN3M9iK3vlKzLVvOH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721980; c=relaxed/simple;
	bh=yhJEpZc9/+rKyHYywabR5inzJ5a8t3/gkXf9XM1kwlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onc6kdufnRC5WSS8aGNGM7S5ODyi10z8KCfOJsYtveKad2Bs2Po/i34j6Ffm2ggHicuPrKY3V3KzA8I51KoLj5DGdm4Bryki0CNzPAbE6eP4XNrkJxGNs9ky0yDwdidlsbF8S0iMSEX0DIqimzf+CcJOzX8W89arKbY9BJc+iUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmVEU8wo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794dlEE009287
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 06:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XqIzyO03+Zog8XVeXGSU4+9P
	xhsWU2JVSDy83gBx3+Y=; b=VmVEU8wozQFb73br1lONVGOPVLjL8QIsmsaKBUWr
	UX55++1WzarJEEFxbE1+VxoS+FOJUoxyHKTX9CS/pbaNrBcfo3keJ/hL95DD7nHm
	ZX0evIO1T5/C89z7BflaWGN+C0m5MNSuoBnlOZ9GGSyK0i9nW5Nra0dwKjyHuYD9
	TKCkJ6rtiUiZtl/CZQ35iWMv/E1PnPCDagpkkyfaI+rdudoT9zH3LdK1QjZ+jjxA
	Ou7y3XptnFeLALCxWWnfnnW64IFRR5ODzY3qDH+q/2eysyaweCYQSxhk/0/7kiCW
	epWcBZQzqQ28PKMPdA36oJUbV42vjpMyDiFDG2Aa3c+wQg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm84gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 06:46:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08d73cc8cso70545021cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 23:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754721977; x=1755326777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqIzyO03+Zog8XVeXGSU4+9PxhsWU2JVSDy83gBx3+Y=;
        b=QAiuyePXGnBXUkA1pMLU+xgbKaO79ziMlYSt5GxvXnhgaQaJr+M3IrR2pCPvwodv8R
         fglo+sCGdwRrrKD3LANPR5aDAqQES+PVQFjnr5GwYO+nmaggq2N5n6otrjYuDUAVbaTc
         EoRFllRu2YbsBFJRw7lHYaOgeYnskPCp71cTtqa7SuV1+TLGPiKve0FB7TS9VACX6fmb
         NVbCAr6rPBZaQNdDobWIBPQnDu5B0uqqOMznu5AjodMaA5YDRfZCDM9D2LqCOrBawlGx
         PiatXh4DEjMYw1DEDxt6AYNTg4HyhUgn3w7fr2QCwgkPpICECZK9nKoc/gRZkJQfq7/S
         xzNw==
X-Forwarded-Encrypted: i=1; AJvYcCXUhOYETPQuqDFYlul4Esz3xxy7Lz/LozcZlEyL121xuAbfjaaJehWtKUeP7LlxN1I2FNo/uGFHnvfMiWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Igr6F2T+1nkcnaaOwng1/IST8DXOgB242mWzQk/QqWR4Pjrt
	ZkwJ8pkijC7c7GTPsW1X23X7TvdfeYiBCDe5YQpnMZQt5FvqFyOQjnNqCavp1NFMf4AopFG46Nu
	vtCET5uyhSqxWwrjRDpCFNodm9Tl63S5R9WjXh6qrZmiEKgm8iROc7ym7xbHOGP8hM8E=
X-Gm-Gg: ASbGncvq1P9bcIPDRqscKbS2eTVQ1LWWMSvEVrET8uz3sXtZjWW8R4ZwnDkiR3ECQuF
	dWBnzdAjvsYvWQUz2I0jTRxjlbXfo0HBaxP+MUfxRSfJAPBuSV/nk9pg+RFqFRquOdgetTxIJbi
	brjhOIh+JW2kPazKL5Ei+LucJ3KA+ussrnYupw/xWGlHFQwUjmECcAe1iQN1z9QLCEgp6hEQQkP
	ifHxSg8pBhs9Fxxp5FYos25udlaa5HOKoIPi4HbAKtgKtL8YNZR27SHIWR2zad5+XWx60qQbnhW
	Ny1ttfRywcY/1+kYv4hfy0AD+RLxGYqdW04s3ezBJG66oLKsAqru1A6+llqG+7g4lFWX9QnyH2Y
	4ZnPw1A4u9xRMt1AGfk6m+sP1Ka3fZuypowerXaRToCCrORyxf9Ic
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id d75a77b69052e-4b0aed29dfemr82029831cf.13.1754721976616;
        Fri, 08 Aug 2025 23:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7uzAueb/H2T7wTR91arcTcUMFSM/xMGIdUJ3vbQ8Trxnz26AgjAqlfb42BhcAP9WpwSKUYw==
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id d75a77b69052e-4b0aed29dfemr82029661cf.13.1754721976092;
        Fri, 08 Aug 2025 23:46:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fb356sm31344371fa.61.2025.08.08.23.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 23:46:14 -0700 (PDT)
Date: Sat, 9 Aug 2025 09:46:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v2 06/12] drm/msm/dp: Use drm_bridge_hpd_notify()
Message-ID: <6ve3hpbcki7k2erktnaxkouyxxzeuii46hgeqscqrmurya2cld@e24gp6viluhd>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-6-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-hpd-refactor-v2-6-7f4e1e741aa3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX9hXkQmKTlaXB
 tvnYRPfUGMGjInCnSrMb8nFJ01ajYgFV3+7V/liOJ8cYqCagnnXa+M4baPelhndN+mniufF73F+
 2OaqiRRLDsumNhmpRd1DKOJSBnj7QvkSHXGtjTK2Ex9kR7xXsI94rWQ2oocIfZDhziWrPPZFFr6
 E/3LmMDCgd2jQn6OOJiMVx7U9yHMscrRZiK+Ii+vCk4DRNXxJ30q5NuI22yi2MaJIo2Cm48TfjC
 78Ykd+VDO3TpB270JOJWbY9tFcdJCvFMCdfuHBkO8/Ueniqfmhrq0+IIE9b+WAHthV59tINJ5Of
 lme895xGnv9jnyOPc5VZxWvUoKd94gjcZ+b8IKu179uBp4uPP4f4760vZw/a80J45rCr2eHGxzL
 OxTlExgv
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6896eeba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QNbhuYZ5RTNpGKTg7GoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: V_oLuXjcIU8Rl06V0a3BlGwTsaZVND71
X-Proofpoint-ORIG-GUID: V_oLuXjcIU8Rl06V0a3BlGwTsaZVND71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Fri, Aug 08, 2025 at 05:35:18PM -0700, Jessica Zhang wrote:
> Call drm_bridge_hpd_notify() instead of drm_helper_hpd_irq_event(). This
> way, we can directly call hpd_notify() via the bridge connector.

I can't understand the sentence.

Please start by describing the problem and why do you want to perform
the change.

> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 17 +++++------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 55fe8c95657e..8779bcd1b27c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -333,17 +333,6 @@ static const struct component_ops msm_dp_display_comp_ops = {
>  	.unbind = msm_dp_display_unbind,
>  };
>  
> -static void msm_dp_display_send_hpd_event(struct msm_dp *msm_dp_display)
> -{
> -	struct msm_dp_display_private *dp;
> -	struct drm_connector *connector;
> -
> -	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> -
> -	connector = dp->msm_dp_display.connector;
> -	drm_helper_hpd_irq_event(connector->dev);
> -}
> -
>  static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *dp,
>  					    bool hpd)
>  {
> @@ -367,7 +356,11 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>  
>  	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>  			dp->msm_dp_display.connector_type, hpd);
> -	msm_dp_display_send_hpd_event(&dp->msm_dp_display);
> +
> +	drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> +			      hpd ?
> +			      connector_status_connected :
> +			      connector_status_disconnected);

I'd really prefer that at the end drm_bridge_hpd_notify() is called
directly without extra wrappers.

>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index cc6e2cab36e9..60094061c102 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -16,6 +16,7 @@ struct msm_dp {
>  	struct platform_device *pdev;
>  	struct drm_connector *connector;
>  	struct drm_bridge *next_bridge;
> +	struct drm_bridge *bridge;
>  	bool link_ready;
>  	bool audio_enabled;
>  	bool power_on;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index e4622c85fb66..f935093c4df4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -340,6 +340,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>  		}
>  	}
>  
> +	msm_dp_display->bridge = bridge;
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry


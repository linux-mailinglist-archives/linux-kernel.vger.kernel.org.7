Return-Path: <linux-kernel+bounces-871652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA17C0E00F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 936544F5941
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAC286D73;
	Mon, 27 Oct 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dwIVjq4x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADA284674
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571230; cv=none; b=Q952xrvWw45/Sq8KqqTbMJHqCwQv0ikG4N8rXNMaVVF77ihXSV60Wm8qIMe79q8XeEzG99uzJNDlF9ZrRy6yX9cZ5tCnx2+fkJmWTXvT1FiUrO/agBcgI/ytC0pP27WR+QULUGZD8v6OPwgWx2prbHkg4QFBLs9AyFa+8iMDWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571230; c=relaxed/simple;
	bh=Urob1Ql2OoSZQJEmH8LGBF3EbghWZmcg1Jd3ENagKWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhwB7guaVg8obp7XbC1D3bjHywmndqdQHkmJQvaaktTBDP85mEKGyFzTbpQETdK6ZLJxHCzW2C12RG/GW/s5GW7N774cqosGJaYcr3ikG8HH/krBwliRKq+UMxovnmbtP2O5ujobpwKVGPtjAf2zh3J0/vi9q/EtRQIU67Ny+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dwIVjq4x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RCTpqA2752119
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2Kj22k9fvRGgrx/wBkPeuGzy
	xbWnEzFTmd7/uwZJCyo=; b=dwIVjq4xhUDZCJzwxE3ZOMyH4nR3tEZKNUzWKmWL
	BYF30w9mq6/zytpBeT8+02bz/FS6qUpm4ueaf7G7rKzX8cU6PsdcM8fHy43ppRLJ
	AlBbhSFJVYTtNJ29IByKTesZUlRG0/qIyvj1sJdOxmNQbhyjF/SDaPp/Oqkl8TYs
	vQsup9ySY1bW1uZkN51tYm4sUEzLERKGquf9TAtH9oc9krrbewD6ICg9L5WCq3cj
	/STxRRCRouQWW5O/ZeFAq2QwbPl7iYvlctf51PLeIEqNHVl8TUqRg26zp9kfpXCd
	56FxdozwSlcDrWxog7nosV2lKd8dQZCFMvkaQIAqu+THdA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swg4gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88947a773so251412651cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571227; x=1762176027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kj22k9fvRGgrx/wBkPeuGzyxbWnEzFTmd7/uwZJCyo=;
        b=kaA52vjwFjUQdSSMpbMNgp1gtM+1x/tB299jU7isn+fpicETR977YS6jWMfQNiGEjR
         vYgYa9ECOBUMO5ZwIjB5gKX4lDmhJ24EqEIl6X0tp9zMt454j+GizPu1lqAYdZH44dwY
         9ir1Cv0WhlgJoan1nkgOFPBFs/U7EMEOJde9hFacmqFvqBvTz3uveaNSXQneB03SlDZw
         ZDCJixaL82hW1UvOBWKBwN9OoQBuny+TXPosZRqpXCNmVEoj7RDPgJc0Yg07kvA2MzaX
         rwNLGYeFXcJ7ckJMgQqU47MHibzmkS2ikD+4Mz9YO7ZQ365/WxOtq2RTpw559MVweE7I
         DrrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJL0P2wWiPegSqsJdgAZ5xV1DR4vQUcUoILOIq8wqbpcOjpUEpfwETW/COo3nJVYpijiLCfN+mdYZiReg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIgL0loosWTwBs5n0nAXO+FPCsQPXKAv+aYE1pVoHOFxz1Phg
	PmTfucCJxOhILhl40ir0aPyBgZCQvp19dBKnkcTXGtvjhg5moU0QKstI4uoA54T4TJM2eGyF9K3
	2FWM2+UbXZY+rHfrvIWHo6Ip3EqMm+KPz4Xnjkx5J2abwBBiEr5P5ozrIrjC0AJwmVXw=
X-Gm-Gg: ASbGncsUusW7KZzQ9+nLgzG6kNgqTTfkv/N7g+ym5y8iFfFZNa24//QlTPnu1eVhgDj
	wwMI1ZHKJGJXvgC38p9q7WdQCHMaoPvXSypB4LvPJY66UF9Zb+E8Jgty9OVHoFN3w8KIdjRrKvH
	5ypUyvpPcbI8OLRkEgNtAN2gczgnApswXG69wjv5oHavo8NRR2Ex97oPCC6wMts5sWIwN7+2ZmV
	hTc7uYFkQUSuknYmjoZnKbqOVTbTICUEjWP4+JOnwcTW1i/WoFZdzjYV4jMAgNKTKBtdSGjKBk7
	Z1TH1oQg6y9AeoS2kB7N5lRk837V+0wAffOGe5LZ8zT8+6hm1x6OQxGaSAKjzkzqdAEkY7DuiuA
	qSNnpW1xDZ605uI7n6OVuaW91Z37o5slL0MVZN80txi9J1dHIVmVOPEjfwcCMYrBCprRIPzFENd
	sF5qepkKTyAJBX
X-Received: by 2002:a05:622a:1a94:b0:4eb:9c80:f68e with SMTP id d75a77b69052e-4eb9c80fb64mr120719691cf.35.1761571225588;
        Mon, 27 Oct 2025 06:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHBc2C7TR7QhTEGEcw9us4tkFC7f4Ut/FGoqtIIC79l1JnmcHizx0ypgFkWMXTqqEaPMgwhw==
X-Received: by 2002:a05:622a:1a94:b0:4eb:9c80:f68e with SMTP id d75a77b69052e-4eb9c80fb64mr120717821cf.35.1761571223545;
        Mon, 27 Oct 2025 06:20:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09213fsm19983561fa.1.2025.10.27.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:20:22 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:20:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: dsi: fix PLL init in bonded mode
Message-ID: <wg6ncd4zyoh3lrrxtpjm6bup7ymyy3v3notzvvdssoptveblxq@4g4shyi2xqar>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
X-Proofpoint-ORIG-GUID: 7DOAEt0sZSuqeDZz2PEeSXzws0-noodI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNCBTYWx0ZWRfX7tpROLXQ31Hi
 tOS/vmh4fTghllXYegjSc0KTn3Zv5jCsRCZpWx27jvrxOe1XL1FCoqukflB91bg134pPdud4Hwc
 3HLZga/45srB/KF3CgwJBocsqCz3PTMnWVzmrBpsOJ+FINh8bIarevzOfCCVMPeD++s9c0Pb3lx
 dewGEG4NUaLEiOxZzNltJWniCA3gz4hSTL8miMnZT8TtDjQO/ksbBJPB/za9Mps7pHZDpnuAbo0
 nK3HUrthNxdvDQnI72dR3brv9l7eQ1lpCRoGyFM8ky14IG4rPX79TEkgjK5NffuSnmjr0/yewld
 phrnHqwHlY41SXf/VfLTq08HBh6yUFcW67RtCuX8uKWSCaYjiehQbGY1Ff3N7LeAv7CfzqBpijG
 V10kVXUUJelhviWB9rKyASz8Cmnm+w==
X-Proofpoint-GUID: 7DOAEt0sZSuqeDZz2PEeSXzws0-noodI
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=68ff719b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=kAMrfz4tof1vowKnfp0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270124

On Mon, Oct 27, 2025 at 02:09:48PM +0100, Neil Armstrong wrote:
> When in bonded DSI mode, only one PLL in one DSI PHY is used for both
> DSI PHYs, meaning that parents of the secondary DSI PHY will use the
> primary DSI PHY PLL as parent.
> 
> In this case the primary DSI PHY PLL will be set even if the primary
> DSI PHY is not yet enabled. The DSI PHY code has support for this
> particular use-case and will handle the fact the PLL was already
> set when initializing the primary DSI PHY.
> 
> By introducing a protected variable pll_enable_cnt in the commit
> cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared"),
> this variable is only initially set to 1 when the DSI PHY is initialized
> making it impossible to set the PLL before, breaking the bonded DSI
> use case by returning 0 when setting the PLL from the secondary DSI
> PHY driver and skipping the correct clocks initialization.
> 
> But since it was already possible to set the PLL without enabling
> the DSI PHY, just drop the pll_enable_cnt setting from the PHY
> enable/disable and simply increment/decrement the pll_enable_cnt
> variable from the dsi_pll_enable/disable_pll_bias to make sure any
> PLL operation is done with the PLL BIAS enabled.
> 
> Fixes: cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared")
> Closes: https://lore.kernel.org/all/50a49d72-2b1e-471d-b0c4-d5a0b38b2a21@linaro.org/
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 -
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 18 ++----------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


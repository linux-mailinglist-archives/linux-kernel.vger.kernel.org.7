Return-Path: <linux-kernel+bounces-818628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5CDB59449
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1CB48720B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABACB2C158A;
	Tue, 16 Sep 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g90p2kal"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9D2BF002
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019720; cv=none; b=mCk3t1cRbB/VPwwCi8r1/a78otkT/SRzqoLK0535SQRc6PimnjI89nfhEzuwHcIuAC1AXbgNSQZ+oinTCzL8iyHWOKG4117DNPLOOiIH059Tdv2d+Xf7PkxSaoLxFaqlLpUTglUgfmqaQXJYxjsuQUzYRFVf+XQ7wf+iZot4zng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019720; c=relaxed/simple;
	bh=eXGnibUXPKj5nd0zhRLiFwogdondw8pTLn76k58Odj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbPor98S4iW8QGyri6RRAg5D2me9odVZdMosn2UepklTpGN4KdseW7WHobrxX7jeYVTWTvXeJ0tzw7nXCRwbbCPEC4aaEwjUBN3e/fyWsTMbtSqsyMXLCYksQHqmcKKzuupYnQ+no26HXbT8Nve7LfcZ4d8CnkwWBhF8n+UKu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g90p2kal; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mNrD013761
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7DAdHo/0Wzj909FzY2ncH6Uu
	2y9IDBRWUgZFM00a07U=; b=g90p2kal3gzVSzs3+vPyi8MHn/7rzNV8SzRlfO7G
	gIYDv3ZzYqQBJfymnoittZ2zxjfnA+uaXVGMou1SjCiNBRLK/7NmsjCqPZpSwov+
	uZm13iYlfKl3qw+rN0rthoeU1YhFhEXrFE6UfC3ISmCKNspNr9Rykmo6AMYPAH2t
	e5XCm17hY7zbG50C59VSs2kYy1AtSOg2t1ODG4+IRJpn0KlWMPAeZHrhdHY8WS2q
	cpBs2eL3BA1Kiv6IArLzjfC5oknWw9IGOLXk6+buiBPHOAJY/OkdVd7w6U0xOTFq
	nN03I2k7pPHGUXw/uapuBmeMK4eIW5aGD2q+Bacxc46F4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5aspsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:48:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-817ecd47971so1388372585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019717; x=1758624517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DAdHo/0Wzj909FzY2ncH6Uu2y9IDBRWUgZFM00a07U=;
        b=CWbrnE2qliMXPmzcJAXaKxgcJYiumcwEUv+vfrJ7RrJboSxZ6mZR8//L8FGxLIp8RA
         dNqgz6CTa5PoJdb9bb9TOBY36K2+PZizRe28w++EG0iNzJaP8vm7bYgV3RMumnU0hbp2
         Qi7xH6BZ5wob0UGst5dTz61tayQXd8Tvu5BG5ajbJuAzO0MDQ0HAOawXrxTbfWo0A5Ka
         h6r7xJiPd8WuIDEcU3/gBz4qF8HSrABgYP9y0erP1Ym1UOoixwVT3xm2mFqQB6xxBRB/
         zieTgMIN57Hgq+zKdb0NlbWBWP9GBy+3N9wRcQ/FTSi5FtuOUVePMkvP2z7GqcC/l1S3
         2k4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1wnxsXwR0WtegFNASXoBvSayInFu+Rn54wEL6MXSyoKdhqU4FR7cnzSU0W5pLN0IJsOzjK4/7Vw2njM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TVY/CuATdFE1dKo9AyO/XTGftVrae/jf1BQkBIdMZuL5RI4b
	cYdQ7bxMCNr31ZfJtgKeGizKLc+9bbbvLSn6n/Hpkg6qW0/ITMXMOgpnpzGdS4voIk0CatSPPOy
	NayE07FYNCnt7WBn0vs2fY4qMzvINPhNd6IRccA32I79hxEUu+uBjNnkK8r6t7wrl09I=
X-Gm-Gg: ASbGncv3ruvA0KqFvawIXgZ4/0puQeqgNonSAsYQsm9vgnwNo0ToyvTkCww94+0wn2e
	e+n2D8Vq2VutnvuuY5V5nwckagD7bCTK9O4RQjQfxUtYAEHF7vDpVr+MmbqBKssppM/APuv1VwL
	TKkCqt3pRUZqAGl/9np0Ml0Fy3WtR0SKeHc9bJXEBtRa8aFjpPgLwOb877JX+ohT5sSnASWj3e+
	+tBtRpKCbTJ4m25YbiG+yYNP90F+APKWtHHuIPORLsA/LQjQ+AnUY20fH/+MTDvljK/Kb6OMFv1
	CcSSbemFEySTUozSkkPtmumjfravjHQSq2Wm8rtnwYxyyOKGZfhfIf0pDoWrHytNn4ez2ZoLPD5
	tBYOXSjIK3/F4J54pkihpkn7PpfcuoDbNI9aiIqsgYIBZp9dbJgOd
X-Received: by 2002:ac8:5882:0:b0:4b7:9807:83c8 with SMTP id d75a77b69052e-4b7b444f8demr17631411cf.17.1758019717380;
        Tue, 16 Sep 2025 03:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwD+EcuTK6nnc7ChKCSQixdeeULdoHQMpddScgT8o1eqraRF7VFL5CVZ10kzXY790VwjcUqQ==
X-Received: by 2002:ac8:5882:0:b0:4b7:9807:83c8 with SMTP id d75a77b69052e-4b7b444f8demr17631041cf.17.1758019716761;
        Tue, 16 Sep 2025 03:48:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c692d10sm4377747e87.8.2025.09.16.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:48:35 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:48:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/5] drm/bridge: it6505: modify DP link auto
 training
Message-ID: <2bk6t2uibhbqtreavimigffzp746rnui4ohqk6sxcpolf4skjh@ddyma4omo6k7>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-3-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-fix-link-training-v3-3-0f55bfdb272a@ite.com.tw>
X-Proofpoint-GUID: pK-PyPx8rcHA09ZpV1MGZ9asSmjk2C0N
X-Proofpoint-ORIG-GUID: pK-PyPx8rcHA09ZpV1MGZ9asSmjk2C0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfXwd7AnQ43FZxJ
 HgvdjNpj3pVUnXy+fw2eV0MJFeWU+W02Vt7DG0iNlkg3Oudzvr4Io9BB6dG3NizGmHgeoQVZV1Q
 xj1i30zxMce2+IGvVdqFLEnuYGqjelEj/8bO3gfkthldzEKwE4SQ+pjzKbh2pmW3ptPHm6PaTll
 bDa8lVLA+0OT6mhu9SnPiPa2bkfCLxztiJIUxu2EtghwSN81ccCQLyIEdN8aRtup1AkEl8oZ9G7
 j6addMmqKAbN3b2bcTZldoNvIZtW2Cp3AhlQy0XlOa4PI14uu8xyXUbmeMmwbRuy4kz/u4rho8/
 JRQRklKYGbeARoPmJ9YQYlBT6f374cmUXm5Mi20nSGHULRO/VrzRTstSy4lYuat7Jh7vDQJHrZF
 J29Z1vqt
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c94086 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=fBcVJbpbova0GqNcjyIA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

On Tue, Sep 16, 2025 at 12:47:43PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> IT6505 supports HW link training which will write DPCD and check
> training status automatically.
> 
> In the case that driver set link rate at 2.7G and HW fail to training,
> it will change link configuration and try 1.65G. And this will cause
> INT_VID_FIFO_ERROR triggered when link clock is changed.
> 
> When video error occurs, video logic is reset and link training restart,
> this will cause endless auto link training.
> 
> Modify link auto training with disable INT_VID_FIFO_ERROR to avoid loop
> and check INT_LINK_TRAIN_FAIL event to abort wait training done.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 7f6227c278a51358c70a3de93454aafeef64f2bb..f9b99c70789eea6beb3c6513155c9a4ca103d219 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1806,6 +1806,13 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
>  	struct device *dev = it6505->dev;
>  
>  	mutex_lock(&it6505->aux_lock);
> +
> +	/* Disable FIFO error interrupt trigger  */
> +	/* to prevent training fail loop issue   */
> +	it6505_set_bits(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR), 0);
> +
> +	it6505_write(it6505, INT_STATUS_03,
> +		     BIT(INT_LINK_TRAIN_FAIL) | BIT(INT_VID_FIFO_ERROR));
>  	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
>  			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
>  	/* reset link state machine and re start training*/
> @@ -1818,8 +1825,10 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
>  		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
>  		int03 = it6505_read(it6505, INT_STATUS_03);
>  		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
> +			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
>  			it6505_write(it6505, INT_STATUS_03,
> -				     BIT(INT_LINK_TRAIN_FAIL));
> +				     BIT(INT_LINK_TRAIN_FAIL) |
> +				     BIT(INT_VID_FIFO_ERROR));

I'm really unusure about this change. Judging by the description of the
problem, it's fix for the issue, but the issue gets introduced in the
previous patch.

>  
>  			DRM_DEV_DEBUG_DRIVER(dev,
>  					     "INT_LINK_TRAIN_FAIL(%x)!",
> @@ -1837,6 +1846,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
>  		timeout--;
>  	}
>  unlock:
> +	/* recover interrupt trigger*/
> +	it6505_set_bits(it6505, INT_MASK_03,
> +			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
>  	mutex_unlock(&it6505->aux_lock);
>  
>  	return state;
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry


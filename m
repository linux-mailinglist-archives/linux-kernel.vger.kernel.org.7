Return-Path: <linux-kernel+bounces-788630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA711B3879B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78E83AC93E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BEA24466D;
	Wed, 27 Aug 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WgVXKxWV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519825D533
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311303; cv=none; b=RXyGno8D7r2XoPGuGIlaGSkr/cnUOkfpKcELe38stPnUYRlhar6aJFHwca8BHoOyMNTm5SKV+kzRM6b+MX0167Th52zGl7xS/lb0D43uNVYt7GK77kSLf4lwwbedrZTwdo2nVNFAQTtfZpmyuNHUXH3g5yMsLetpHVFtM3B4L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311303; c=relaxed/simple;
	bh=gpUlzt4Na+WwKgd1hRi5gsdeAaG9Ll65uQiPj5/AZiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buW9geChitdnjdyZmGMLrXS6dtTimo2WP3VmWKNjZfe9jd+fGtNqWgxfHnp71OOdgngqcgN2Ld1ouaLQwUDW5DugpDxaR8ISEepHMudEl8dbumRh3nRGkVwZ4rCusBuYJ2im/mzKuRRbwwyxT/arsfvEnjGgNJeuiWb6Ee9zqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WgVXKxWV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGAbx8030216
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	72Snl19eM9SG13obf5lnpG+wAP1deg4gz5g3WQbmbnU=; b=WgVXKxWVJuRBsVz9
	XHDVQMH89DBN52LZM0i6JeZ4HCO9BuZ+WqFlW+VLMi/eo3WJWoTOFmZ9dqk7WD9n
	gexfdNriIyYI+ZBpsbjCX4VcJO5mNo7yVDWfCqBgY56v6EMaaU5mFcaXO4gXKKYt
	5kr87RDxfNTDSA28KzPnSE9m32vauXAfpsRUCw8xgtrmcVg30I815WVOQI9ZKNVh
	4MeJ0ttIpcouCf9Z659WXuzLiGmyIfWFPZgmr4piBzXGSGSMWEsFvc3FWa/70htd
	AXv3ABUIQ9tWJTgnkg+GQtG6wS6Zoc5CqDYoAOVFPLieKtbT710xZQVDaqWZ5eEv
	ZjXmDA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unw37k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:15:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bf1f37so146181921cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311300; x=1756916100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72Snl19eM9SG13obf5lnpG+wAP1deg4gz5g3WQbmbnU=;
        b=OS+01sk1nhoio4tNO6DroPQjLFWfpLg1LNboFtbV7zl8a0oqoU1MF5BoeHtciWUiVr
         8vmm1Ij1kqUfbpBpl0gnlhcKbFATWmHAFKkWxCDae4mbHxLwsORQfW4WSY0GifHj3ojU
         3LBdeQ4pZzR1buiFh96/wUZHww8Z9qPFS7fvAkCBN8LTjKHIAOI5UwxIk+DbhO63zHWu
         HTs33JAa6FKQQnyUpUlpMZhBB+XOpvv2FwhYMo0SX6ivPfOnKWiLfWwgXVHiArOiadYn
         6ghwf1nl78NLlFa+kPiKdBpB/0EPybyIv7kn2iBmXb4O5spE0V5AewRs91sUqgQ9kC4X
         YETw==
X-Forwarded-Encrypted: i=1; AJvYcCWoL2ak4acVvS+g9NvXYDXA9DS69L76ERn10PmqOQjv8HD85NG+sgw+KXBVuDzNRPuZ8GFcySKOs8M7zVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEdH4JctjtrA4gYhf7P1GGMsp4OCnFRVe+92D+/oaTwiqDe8z
	1AF3q14/oRoHexI5R7kbWsWkKbKi817lXIJT4vZjYk7ptyRLS62sSG4NncmrR1BQhCsznM6Fzc2
	+FJtJxXmDnynM7fBpeynvnQGELQMWqBc3pr8kaXc7GL3dB4qiLi2WUYrNJbLyg4kQwfk=
X-Gm-Gg: ASbGncvmP25Gx8M77iOQNCSVaTcsySvNPzd8WPz+MJdhcFA7DHbzm2UKJWpJzlsQMyH
	7OnDDuYEVpAJkQowzz1oWePH5LwNkDUfpQgKDOgpShspHmdWj6dttGgaP3KpUqyl2yZbt9WoRX2
	f91dyo4ZC7vnGFzdlZO86EGw6BrsL2FaVKl3rU9k/NSc89l12Z1fEL2hzrxjzKSysp7aRkPimbS
	jpjqedbhsrgNOBpEn9Ac/1JGq0JVZr3aR9JghoWDUYpWBBIvqAZL79mqI4y8FZwNbW5A63LJ9US
	T8w+vz3FZJ8QjBaQOj3NhQo2uGCPBmU73kbvPHNWt3wUwksxTTpoQl657VaFb5h71gZ9JjQp8q0
	CxgGdwYI3pVwMXd1q3Qhx5BxNbHi7p9ZG7/M36FlE0XTeOfpZ1iIa
X-Received: by 2002:a05:622a:4ac8:b0:4b2:e0ac:63b0 with SMTP id d75a77b69052e-4b2e0ac6451mr82573101cf.77.1756311299619;
        Wed, 27 Aug 2025 09:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPzGcbfBYbuRl3Du92a0zsaKioL4MbDCRH7YFgTAKCluORsEyl5ZX6nTkAvEBJ0xy1YynMxA==
X-Received: by 2002:a05:622a:4ac8:b0:4b2:e0ac:63b0 with SMTP id d75a77b69052e-4b2e0ac6451mr82572361cf.77.1756311298937;
        Wed, 27 Aug 2025 09:14:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02020sm2863442e87.29.2025.08.27.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:14:57 -0700 (PDT)
Date: Wed, 27 Aug 2025 19:14:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 11/14] phy: qcom: qmp-usbc: Finalize USB/DP switchable
 PHY support
Message-ID: <inxoswyre3qalrb3dj3lz3b5vmnpnkyy3hh4oum3z6p7yqlo2v@7g67yvvb25tc>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-11-a43bd25ec39c@oss.qualcomm.com>
 <jjsijdmh4hdbgd2boebtrmzvblvhz2hnl7mtv5ga76ine2fnsb@i72dz3r4lbjp>
 <82d19340-b887-4093-9d24-4b2e19b99f8b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82d19340-b887-4093-9d24-4b2e19b99f8b@oss.qualcomm.com>
X-Proofpoint-GUID: 323cBhfF8mcmWTxlik9eT9xFdkBwfDOj
X-Proofpoint-ORIG-GUID: 323cBhfF8mcmWTxlik9eT9xFdkBwfDOj
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68af2f04 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M2k1YX_etJ5cuwz7zUoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX3h0bH72hEnge
 n9F9lSjqXxjYxtFBK6JDB3fBewc/Hy6N2mYFFznDyLGYpPgTV8bnRcoM6+DQC0oRdmdfG/28o+J
 EEH1F79w/hYTeCHm45Jd1ArnbDN6RxRwjY4i7qMHaJMs2OS5MD1LgdAiLCaKUVyNH5Ysdjdgc65
 4I5K6nQihpaNdprPsAQPuZg2WGOwbkJfMpl1piR17wmboRur8tEBLGu46oec+Q0UCmdfzzQ4E34
 lZhNXJ0i+6FgkS5/gDkobmHT8pfs2PGvUJjJPlJCvGDWg8KWhI5n6+QTbcs6nYsAtF6Fo6dPtrr
 DUzqmVPmBV9A1XEZQuiVrAoWWUytFmnMR8VKlp9kAbPUAJg2AaLyDs0YVs/nUj+VGhU43geufx3
 j9ewpULr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Wed, Aug 27, 2025 at 08:34:39PM +0800, Xiangxu Yin wrote:
> 
> On 8/20/2025 7:42 PM, Dmitry Baryshkov wrote:
> > On Wed, Aug 20, 2025 at 05:34:53PM +0800, Xiangxu Yin wrote:
> >> Complete USB/DP switchable PHY integration by adding DP clock
> >> registration, aux bridge setup, and DT parsing. Implement clock
> >> provider logic for USB and DP branches, and extend PHY translation
> >> to support both USB and DP instances.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 331 ++++++++++++++++++++++++++++---
> >>  1 file changed, 299 insertions(+), 32 deletions(-)
> >>
> >>  static int qmp_usbc_probe(struct platform_device *pdev)
> >>  {
> >>  	struct device *dev = &pdev->dev;
> >> @@ -1703,16 +1944,32 @@ static int qmp_usbc_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	/* Check for legacy binding with child node. */
> >> -	np = of_get_child_by_name(dev->of_node, "phy");
> >> -	if (np) {
> >> -		ret = qmp_usbc_parse_usb_dt_legacy(qmp, np);
> >> -	} else {
> >> +	if (qmp->cfg->type == QMP_PHY_USBC_USB3_DP) {
> > Should not be necessary.
> 
> 
> Got it. I’ll merge the parsing logic into a single qmp_usbc_parse_dt function.
> 
> Also, I checked the compatible strings in the dtsi files for this PHY series
> looks like no current product uses the legacy binding. 
> I’ll drop qmp_usbc_parse_usb_dt_legacy in the next version.


No. It's _legacy_, it has been implemented in order to support old DTs,
which existed at some point but then were refactored into the current
state. You can't randomly drop DT support.

> 
> 
> >>  		np = of_node_get(dev->of_node);
> >> -		ret = qmp_usbc_parse_usb_dt(qmp);
> >> +
> >> +		ret = qmp_usbc_parse_usb3dp_dt(qmp);
> >> +		if (ret) {
> >> +			dev_err(qmp->dev, "parse DP dt fail ret=%d\n", ret);
> >> +			goto err_node_put;
> >> +		}
> >> +
> >> +		ret = drm_aux_bridge_register(dev);
> >> +		if (ret) {
> >> +			dev_err(qmp->dev, "aux bridge reg fail ret=%d\n", ret);
> >> +			goto err_node_put;
> >> +		}

-- 
With best wishes
Dmitry


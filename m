Return-Path: <linux-kernel+bounces-820897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF6B7F991
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27996200BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549733593D;
	Wed, 17 Sep 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UDzL9NTq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09132D5C2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116831; cv=none; b=ZZeb+3TH4wwwweeGGlvwq+mdomBGa459PhbrhI3m4xRNxjGIKxxjXw1wHAyy/3d1OLrETr5lCLXi9zlOZWmZKS8YHLsxOJyWYTFlxeMDh7mJ7pUMXkAGi/0sRZVem3L9GK5qLZljsxyreQ128yzXw4IziMYg0ggfGtKFTBBjeaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116831; c=relaxed/simple;
	bh=2yQiKDpTK9neTRF8yPN8BWml/BMWi6JowDZommLNK5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbQFbv1Y4KByH81pnTsk4MpUEvXyFTflEGE62F+x+txfAfHjxrPJ0NM0lIzkFnrinznJkKKmnSkwaM6SlR5uUcJ6OPgQVwylQKl+XTAIlTJ7YaPXaCQedPqWjQ7NqgCKo9NDfczlfV4GF9f9LTibIvrNMdhAz06zeGydLuoN9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UDzL9NTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8Xcdr029909
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U+1FYSzFPulCZwhYK8uuFP4RJbaCiDqOUmY+x+avlIU=; b=UDzL9NTq019eYDfU
	ZpBgeA34jHGfjZLp0QyNsys5dqfc8BRpCNJLdokShV3UI+vfIBuWb2wK+fMLGclq
	FDOXD6w6zlvTr34m1ZmU/82QIijC29BQUPWl9FD1AZRcvpVX8kAcVxUtnQnBGlrt
	7L1O1pEOkjX7wT60rz59+k3ss5DAqUgp5nlH0Xaf8srH31Pb97W9QFIfFJsImqww
	X97PQNEpSP3inzHvTlFEKqcbiq5OZedOsiL/VP7aG1YFlFuwPnRE7MwOZWYQcuVv
	F19v/xDysU1/IEYTNNr4EHl00oFhKA8f5z9yrCs2uDVewYCAIEP6hkYAhUzCMgXG
	9jj9Qg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxjjs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so180817341cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116827; x=1758721627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+1FYSzFPulCZwhYK8uuFP4RJbaCiDqOUmY+x+avlIU=;
        b=nqo/GaUsUV7Fqxo6z42o48ozDjsE5epke4sVgLVI+OTgGhHxyveBObWBuOIUANsREh
         pY0Rwm9yK1wgyGfRC+tcxhFLiOmhb7FWz8aIQtJBpcJEYIMVqJZR3HAVlNOgmSWkRBc1
         g4YXUZ1MhGaDG85caQXnYNP3IMfOP5Oky86mLkkhzfbSWLKSq5DdtfgX7DEQnu6uCbjL
         QAgOMwFk03W/5zhL5UH0GuC7OYawHK2gs0LmyWto3tyxq6avYICxZ3WfAFfMbxfY1z3F
         e/4UYorMZH+VYZGOU1CGmpaVWB6rF9inygKP+R4lKbAFFWFXr0ZFC7wxrLxprgKsWvkc
         oBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUqHQR88U6qSRRiOFzNp7X9qengVB2NJ9zDmhtezxAWjNi6T9WyVTCVDZtmicOxhs+z+4dmNKUirpVq5Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wVrO16h3JQiy6cJUZW/wxrzAFTe4o/erNKqBRV/SDLiKw3ar
	fz095au/jzj9yqr8SOyERNLeq8HFyqIl4WSuNbg+6Lj05NoGc9yv7VRN0kyqM7+VsGsDUJc7ZdN
	Rmq4jGi71k6K0Vx/VlBArrj2cODQbgLPkyqYCyKXZvlX5ijDGymEVtS3LBy9D7ROYy8s=
X-Gm-Gg: ASbGncs2uzLOmDFTio/JA4oLW9FXSAzybOyntpIO1A7B9iXwQ00zEJ9Rjr/+wmMdmJZ
	zIyaCRJPGOPe4Fu1H4YstRCMLIdO4ZDBAxOdHsTmYV81t5R2QUK7vKe9LMuRRJiMfB/ukesp06G
	DCFiy0CsPZ3nFEdz8xFliHphFD5YIrriHmzwq2RnnYz8V20iK8UcCrogxfAd9iYUnUx3/VUJ3+t
	jHpHWhmeEvYEFSioBL0Visa+MKIo348ELG+35wEkzAxifTKUhmqZINXll+QZnKwYngp6IYZX5o1
	d+2cp2+jBhTXef/6a4AP61m9744Veunw9rt1D8Gvnb5O1cjkD+ArcvT9odwUYnHKditoyJLZFgm
	yj37I5dfCjJ4QBACLpJlJDDKPkUNCEQRvecRkosE1TGKjWD09IqGr
X-Received: by 2002:a05:622a:1822:b0:4b5:ed1b:74a9 with SMTP id d75a77b69052e-4ba6ac99828mr24107111cf.41.1758116826997;
        Wed, 17 Sep 2025 06:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtXlZuFQreMzb64H+tnz5zGrRTbMmy49Axu1iq7yKRAfklZROJk01Ls9kms99uRsAwPum0Qw==
X-Received: by 2002:a05:622a:1822:b0:4b5:ed1b:74a9 with SMTP id d75a77b69052e-4ba6ac99828mr24106611cf.41.1758116826295;
        Wed, 17 Sep 2025 06:47:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35bcee2ce08sm12429401fa.54.2025.09.17.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:47:04 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:47:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.Wu@ite.com.tw
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw,
        treapking@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/5] drm/bridge: it6505: modify DP link auto
 training
Message-ID: <nh3mxefaqznbirhez4c5xtkvs756cjasmb5bdsxol7cai7u4da@3nmtq6figidw>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-3-0f55bfdb272a@ite.com.tw>
 <2bk6t2uibhbqtreavimigffzp746rnui4ohqk6sxcpolf4skjh@ddyma4omo6k7>
 <b1d7dcc0ad6e40309677058f8affa5a5@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d7dcc0ad6e40309677058f8affa5a5@ite.com.tw>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4/r4hy9/eHwj
 i4X0b8l4IyJiQihuZ/w5Dklo59a1PzBIX1ZVNs5Peg5jSP1gQqJRCOm5xzy8wO5752FCJz84BMc
 hi5U28GZEbkSZSgnS7zsNE6dycZpfSTAGDrPlTGid+f2r4YO5WKst+pxLc0T87yx8AkDsecaK01
 eOBcrUnc7DBnb+2B/RgDgX0bRc/WA2r4wecW+tiMcTEdMf0g7sRjGZumxD1x2wFFLDEfUUXMR/W
 Lv8YDxnmyHpM8y+l+If+0gEPFO1kmfCy33ZE8yetqfvG28whHBP2ZxrIgmnq5/05YhDIDEtAquo
 28ryWPHiwKmugsiklFmB1fIXG44GlD4F6uY8mG5yhwiyR5xDgpEHWk9CBXycJLTqmcaupHAMtEU
 7LxS2FiJ
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68cabbdc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8
 a=cm27Pg_UAAAA:8 a=e5mUnYsNAAAA:8 a=zgMSu1BmLbmheqphp-cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=LZLx1i01EnjtqRv10NxV:22
 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: CML2cd-66fF8bdGQ4svUtQKpJ4U05BzD
X-Proofpoint-GUID: CML2cd-66fF8bdGQ4svUtQKpJ4U05BzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 08:37:10AM +0000, Hermes.Wu@ite.com.tw wrote:
> 
> >-----Original Message-----
> >From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 
> >Sent: Tuesday, September 16, 2025 6:49 PM
> >To: Hermes Wu (吳佳宏) <Hermes.Wu@ite.com.tw>
> >Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Pet Weng (翁玉芬) <Pet.Weng@ite.com.tw>; Kenneth Hung (洪家倫) <Kenneth.Hung@ite.com.tw>; treapking@chromium.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH RESEND v3 3/5] drm/bridge: it6505: modify DP link auto training
> >
> >On Tue, Sep 16, 2025 at 12:47:43PM +0800, Hermes Wu via B4 Relay wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >> 
> >> IT6505 supports HW link training which will write DPCD and check
> >> training status automatically.
> >> 
> >> In the case that driver set link rate at 2.7G and HW fail to training,
> >> it will change link configuration and try 1.65G. And this will cause
> >> INT_VID_FIFO_ERROR triggered when link clock is changed.
> >> 
> >> When video error occurs, video logic is reset and link training restart,
> >> this will cause endless auto link training.
> >> 
> >> Modify link auto training with disable INT_VID_FIFO_ERROR to avoid loop
> >> and check INT_LINK_TRAIN_FAIL event to abort wait training done.
> >> 
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index 7f6227c278a51358c70a3de93454aafeef64f2bb..f9b99c70789eea6beb3c6513155c9a4ca103d219 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -1806,6 +1806,13 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
> >>  	struct device *dev = it6505->dev;
> >>  
> >>  	mutex_lock(&it6505->aux_lock);
> >> +
> >> +	/* Disable FIFO error interrupt trigger  */
> >> +	/* to prevent training fail loop issue   */
> >> +	it6505_set_bits(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR), 0);
> >> +
> >> +	it6505_write(it6505, INT_STATUS_03,
> >> +		     BIT(INT_LINK_TRAIN_FAIL) | BIT(INT_VID_FIFO_ERROR));
> >>  	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
> >>  			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
> >>  	/* reset link state machine and re start training*/
> >> @@ -1818,8 +1825,10 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
> >>  		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
> >>  		int03 = it6505_read(it6505, INT_STATUS_03);
> >>  		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
> >> +			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
> >>  			it6505_write(it6505, INT_STATUS_03,
> >> -				     BIT(INT_LINK_TRAIN_FAIL));
> >> +				     BIT(INT_LINK_TRAIN_FAIL) |
> >> +				     BIT(INT_VID_FIFO_ERROR));
> >
> >I'm really unusure about this change. Judging by the description of the
> >problem, it's fix for the issue, but the issue gets introduced in the
> >previous patch.
> In this patch serious?
> 
> This patch serious fix this FIFO error issue, it change link training algorithm first then fix wrong FIFO error status.
> 
> The link training process start after video status is stable, and when video FIFO error occurs,
> video stable status will also lost, link training will reset to idle and wait until video stable again.
> 
> IT6505 HW auto training will process link training automatically, which include CR/EQ DPCD setting, link status check,
> and try lower link rate is the 2.7G cannot pass training.
> 
> In some case, DP connect to a DP sink device which cannot pass IT6505 HW auto training. 
> when link auto training fail on 2.7G and IT6505 HW change link rate to 1.65G and retry training automatically,
> at this time video FIFO error will occur because of the link rate change(chip issue), the video signal from SOC is not lost actually.

We seems to be misunderstanding each other. I pointed out that your are
fixing the code that was introduced in the previous patch. Would it make
more sense to reoder or to squash the patches?

> 
> 
> >>  
> >>  			DRM_DEV_DEBUG_DRIVER(dev,
> >>  					     "INT_LINK_TRAIN_FAIL(%x)!",
> >> @@ -1837,6 +1846,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
> >>  		timeout--;
> >>  	}
> >>  unlock:
> >> +	/* recover interrupt trigger*/
> >> +	it6505_set_bits(it6505, INT_MASK_03,
> >> +			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
> >>  	mutex_unlock(&it6505->aux_lock);
> >>  
> >>  	return state;
> >> 
> >> -- 
> >> 2.34.1
> >> 
> >> 
> >
> >-- 
> >With best wishes
> >Dmitry
> >
> BR.
> Hermes Wu

-- 
With best wishes
Dmitry


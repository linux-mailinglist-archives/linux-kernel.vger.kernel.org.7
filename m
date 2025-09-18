Return-Path: <linux-kernel+bounces-822771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4DB84A32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63AF1C28408
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE22FB62B;
	Thu, 18 Sep 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8FRs7Hd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E791C5486
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199486; cv=none; b=SbCfLwTDVCADb+FuxTx/bfooOXzU2C1vePA5/tI+Sq5M5tiG1BFg4oq/Q4WJqOc7w3wP3ZZm6b4By3lwtU2Q9xE2YrtDAGz58g7h28Mjrx/4RWDf/EFCYpmO2CKKyISVYRcYmQ+EtjwkkKMfxZtHiCc41TuS4mvscKoMAMqI7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199486; c=relaxed/simple;
	bh=SsXRo8kCqscjhshXq14m6HJzw41Z2fXRqIGQy5xmqIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZJ6fwTa9YPmbK961zXmr7Kz+kgw94rnflY6dLBGkr3mndG/DD0B9tMOfksUTVQ/1y0KRhVS7tGL+9VjXwvCI+/FLpZH0rE6YbRikqJWtXZ/MCL77kJFlYmxD7wjSDD/68AjbS0yxpPnercwrExGMPjMaxC/S5C8opJvjCXO91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8FRs7Hd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAe44T019523
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gTvAFZglIDLXccaiTU38RHxk
	+SuGPsy7AO+qEcLGz6Y=; b=d8FRs7Hd+QPWtZ250pPxbPEAX+3kOxb8tkFu2csh
	KNNbfH6unOrwii4HppsaC8oo1KsZkY183GO6+Cx+Aqtfcv50rPYSuuywC/slNdVe
	J3bB24nWBlVzyWRss9XMIusP2UN7hEmJmS1xtFYzJnI3rervKFl1+VbX+Jkbmq7Z
	FS9kSU+BCHGEWRdIvXRxloxokAP/i2E+iECFzLlPNiC+dFLLLylix0uJPKfMXz+q
	5rXB1wfrM+YNMOFEjTiBqBDQe75eZYXMll/KoNZMoHbnCtTVlS4NdOQpQIM9DyQZ
	wTDES8GFRwI2hmTtMDSajDr99rZ4Tw4TaR6sA/R53ZInWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1xf7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:44:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b548745115so19765891cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199482; x=1758804282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTvAFZglIDLXccaiTU38RHxk+SuGPsy7AO+qEcLGz6Y=;
        b=WKIwkjPVVADKq0aXBOo8WotdjEKjmH5Xjfm0dvaEiiE/psPU7jnKBY4Yq0OBiCYI+I
         eXR5iMO00X7eZDfWYbLVjOISCSiDr+BKSaEiMvdVCriVTQDSllL777Ypt9VeiFUPKxrv
         4xpffPQnvVyEID/eiq91bJ8v9P17baN3XkdNgKi8GUr5uPadLgQjUzPzDDc6KqqdWJyM
         EZXA39z2297B90DJo89Uy2ZdQX23ncBFClFXfZ9RTCWrpmg/OH7l8EPCUuh0wwfLnJMX
         gXRA7QXZYXOHWsJUDV2XwAQVvJShkifd8Q1IUk47rJDWuB5dqKN59cnfjSqFy0AUmmPi
         KsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+3z7wqOaWOdzo+uqF+IIY4QG98s4BwzgPGG1ud/8+rRmq+/BOfYWYu2jKA1crfmbPiwQMGil7ACt6Foo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyyZns3h3iBfQQaHScBgdsYB7xxRMw/7YQXk/QpMS9Qh2Ztg4
	Vpys1gq+1fuI2sudRY8TEK2NDtsDTTtMIT9TkXmEAStmKJJ5i/Yv3hHU9f+Mndu/iaB457yzC4c
	XvTX/XH/TgiDBr8pwIHTHbudqGZbb0/hRYYqrBEO6gPawDqWE1AdSJ8XbE3b+2Rbi19g=
X-Gm-Gg: ASbGncvkuoqxE9tdCj4AYjDMkP2bJGpkT+7H5ThsEvb1x2UlNGU3q6bINOIZ3nW3gOY
	QEMQ/imwPXPGoC2GawkpE1eq5MCWEH7WZw4hSLBbpjSTIdjYk5Rpox/xGA2y2mmG2XbAkNLPyn9
	xTYFKlbGaP/1DMnfjTUMY8YByPHRFHGLwg8MmlPWMlLyMqOo8szkddhjEKUVALyfDkpjE6ByyYI
	30+/asFNmIJGl5LQkqG/MQ2bD7NfpJYhQwvwKKN7bPhk3Y3wwHU+bGQANeBxdnj7Y/lFGKWHCNb
	EsKYkDKhZTSvkIFCx6u/lLYwNZtlCeFqkQvK5QMyWiNCfxGTtCnRCPT87uNzFOenwj1oDabQGPY
	+4yRuQUjSSbs9x03aLhXPHzJw9HDHE7xBm9FvBkSbAj3cdbp6hKrD
X-Received: by 2002:ac8:5dd1:0:b0:4b4:9531:8a8a with SMTP id d75a77b69052e-4bdaf240cd1mr33763481cf.38.1758199482427;
        Thu, 18 Sep 2025 05:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIuCnR0wlykqroSVkf4rW0lxyHm2OgbEsL7t1lJhmH/oI+45dByOMaQEegu8/0HBWxjOJL5g==
X-Received: by 2002:ac8:5dd1:0:b0:4b4:9531:8a8a with SMTP id d75a77b69052e-4bdaf240cd1mr33763051cf.38.1758199481860;
        Thu, 18 Sep 2025 05:44:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a28b56cdsm5723341fa.25.2025.09.18.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:44:41 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:44:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, qijian.guo@nxp.com
Subject: Re: [PATCH] drm/bridge: waveshare-dsi: Fix bailout for
 devm_drm_bridge_alloc()
Message-ID: <n43pa62bneykoeo3c2ne53ksrozftohmo4dnq5ifnchgrvwcdn@qqbbur6uiuxl>
References: <20250806084121.510207-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806084121.510207-1-victor.liu@nxp.com>
X-Proofpoint-GUID: 8iXx4sd6HDSf3LLShdX6gqGshbapwmMk
X-Proofpoint-ORIG-GUID: 8iXx4sd6HDSf3LLShdX6gqGshbapwmMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzHHsCZ4fw8KT
 aiNxVsT06UFgxk68gSJkdeQoULrLEDd00SoV31e1cTaQVCl+ij4cAowzNHb28fUY1Rt6idgbqHG
 vgxmHY8DUAhq3xpe3vR5OjrJwgu7pqLi1RtmrbbhGXissrri5yypsnLWrt8330VrSHBbft7CKOq
 87vQzkXgvfG6HyQkvKU07nU5Yv+mzs8TRHMbcCvVCqOvC8858bwRz3PKgCyBtShJVyqFUx7t8sB
 Yr07oENw65S3zbXqvKfRFaWO+kihWwy72mtMZ157eHLLOAlI/vaIbwdqoxX2Bbph39+bQRctb9Q
 s+a2rEGj15YOHn5TeTkYurF4y0Pvouvn6sdjScBJb2VWNwrsEhY2yPw4RxcABU1Qb29SSppKlAq
 Us8ttm1t
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbfebb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=3EkQX2vGk4wexuzDa8QA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Aug 06, 2025 at 04:41:21PM +0800, Liu Ying wrote:
> devm_drm_bridge_alloc() returns ERR_PTR on failure instead of a
> NULL pointer, so use IS_ERR() to check the returned pointer and
> turn proper error code on failure by using PTR_ERR().
> 
> Fixes: dbdea37add13 ("drm: bridge: Add waveshare DSI2DPI unit driver")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/waveshare-dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


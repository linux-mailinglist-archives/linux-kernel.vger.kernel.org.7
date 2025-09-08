Return-Path: <linux-kernel+bounces-805478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3476BB48903
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00780189C85E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63A2EBB80;
	Mon,  8 Sep 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ncyq0gAI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92C1DDC2A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324890; cv=none; b=lQgkUTw7AOgnwttAnsQeU94Rsm2OOhlLDxHLF57OG3RCN1O37/+w3OCNvCVtaM7vQrkjcLE9Wkd0HlNVPHE8J21xdl78jmYULSiedI8vM10ZfIaGqAhIgZD10HRk0URXviUViqM2ozGoLthPY1XNO0nlCIY7fAVqoF6/FLAyZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324890; c=relaxed/simple;
	bh=bWoPTqdfq2Z5itISj5h3T8LZVUE4R8Krkv83QbMaoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxj6KsFAHuWtcLV9l6lYsSYQPbTNzZAP9Bebn42fqG24ld2l1StK5PxpQeA9QQN7h2ztseJY3CV/rHkljB3sda+vT+16MWDRz4bEopTNw4Qe1toYjpulKFKacsQcX2e36uLz2mPMK4cb+m4fjuwWFzlrUXjZsyZsjKstXHXCHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ncyq0gAI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889O3ch001510
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 09:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LhfhHap5hYU7xmjyTW9F9rXA
	9Whxyp4HeZGrijVcxzE=; b=Ncyq0gAIPuWEPH/DyS6X9PoHfbYjT9sBIjoie6G/
	doMu2uQh5g8KAWMMwBaBXuc6RkJWKy9IAKrqYUY2bYBL/Kt3v/zJfjomGJMr+LIK
	zQHBPqXgosk/m0N1ILf8T51Wlxny1qCY1xvbNEOYiSngUtY1xw7ioRLvcC+2oB7F
	clrxM3ZMQ50cHXn2h2p8yGXWDKxYl5GWNjLaNa498v3KvmXVQE43QkVrwFJ4b3ic
	IK9QFhVbW4aXu1LC5Byi8ESlsI8ap/ss1OWeklfDWJCoiMnIUZUzu8niEDF7h674
	K4S/lAZKHaRCj/uloj14L5U18LZd3oGxPUd22nK6cn0Y2g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8v6kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:48:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fb1f057fso19152111cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324887; x=1757929687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhfhHap5hYU7xmjyTW9F9rXA9Whxyp4HeZGrijVcxzE=;
        b=N+pHjCZ0kbfiadzDqRBorySHLpiZptL5waio/9fPFxYfM2fDOzcvdawh2JpEA17r0M
         vj2ZwZFE11q0vqNTBJfAq2+9Ze7XvDv1BlOqAiKmqDI1jyc0Kr3W745BT7l4uR//OXiS
         hGHzDuGJ/t4/QcgL1I8ZCPAWAEB0R3M9JShlNHaM99/IqLlYVfL0amUO0o6R5vhgkNxW
         UX1CxIv4Qkwbf803ObQz0UTuTfURHQ+JdZpNLMycGgcHLJqscjDCQctCvFHcj6tyrAHB
         +FVxPy5l/RZL7H8u9Q2NpmWe7LHIw40MGWtxITkTNXz3pqX4gSoGRXJMn+qp5M0XCvvW
         6DkA==
X-Forwarded-Encrypted: i=1; AJvYcCU1A2q0ZAnTv5v0A2EtaaoBWF1+vWHZ7JTc+ftIgfRmTEZK2kD71mwaJySDZQV29tL/v4qCf9f4f5P8xh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUj1F3A48hfwYndH3DWGhrm4PD/SIqLMYWyGh1FOgXZbUJLi++
	C35svFrSgIN3MSJ/s3YgKYvKIt7F6kgLsxm1GRM+ZoU6OIiD9KaNCRK88tzLqblrrSrxe7rEZQI
	5XmTZ7q6X9SqgGRYb00QCkRv9XUhwdZ1wDV3tTsDbOEcRVnGykw7nDvGWmBeOkVM/uz0=
X-Gm-Gg: ASbGnctUHBy+but5g8018i6k8oZTJKF9G74FA2VziPshbU9FfqZcr2kZ5GeugKgKt5e
	2Bhrzy7opbKcgGR7Q2CZsCnbsXDBzf3J8ScyhRVkdXK9/F6j6JHZKv/2EeyT8L/9ujXmgkyexWO
	y3Q3shCBFev/zrzT6GeZ0lQ2KV8kZKGjn8hZClmILBcSTRlZQQNkkw9LgArUlGZ6r2E9n5GUbMb
	RsjHjr6+jd+m/fCbteEWz7gqDDHrrUMfB19yNjGA97sihapkmJtUlzt+yz3IGP+PditaqGZpwz4
	zV8+J+4Q047reGZvG/YcerP+py+mQa0K1CPzmF4dtoDTqCaE8d5ReHcTSnZh/3ClwKmcg60U8ga
	5frANc1AsdwGQgn4x1zib1J6r/ZAWkGirXgPoSoWXb5BkyIGRTand
X-Received: by 2002:a05:622a:5012:b0:4b5:ee26:5362 with SMTP id d75a77b69052e-4b5f834e673mr62482191cf.8.1757324887223;
        Mon, 08 Sep 2025 02:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwW5yW9mmwUX414xMr4F3g7FOeHsQ908LynTz8dWVo8Jm54hMcp9b0uUEfgpV9Rx6Uqxf/EQ==
X-Received: by 2002:a05:622a:5012:b0:4b5:ee26:5362 with SMTP id d75a77b69052e-4b5f834e673mr62481891cf.8.1757324886625;
        Mon, 08 Sep 2025 02:48:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c50317sm35222401fa.2.2025.09.08.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:48:05 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:48:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
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
        Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ite-it6263: Support HDMI vendor specific
 infoframe
Message-ID: <3ll7uxguykwufscftok7kxexfx7w33me5py4qejup2r6jsymxu@37jycbpwodng>
References: <20250908-it6263-vendor-specific-infoframe-v2-1-3f2ebd9135ad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-it6263-vendor-specific-infoframe-v2-1-3f2ebd9135ad@nxp.com>
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bea658 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=6IanCRA773FJqE2TFJUA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: qfC-HS2-CHyAnCgK0HGCVAyOezH53MKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXzOd3L5Oy65gv
 l5FCPfAPdprFFObMqd0ZsnLi/hanGraIa2X0Uw2Rr4sR6bpCGHBY2lFDvjaq92WBq02aSHRcRhm
 BJYQ1G1RQ3QsxCHgg72z52Llea2zLauIyqu8ClERyBKTRjEEZnbsElOVBuq9+rO2MejbEGRuVIP
 trPMqiCzLAuFXyTlT6pvuymejAzMXUa2UKS9RgOQB2eVH4gp833I/xdai715OMfLA/cnhSsdfW7
 g6uLNc7i7BDj67NJUyUYR0GBTtrTgzv8DEsH6JykmPHFT68mF+4IEfLzIHVbh6Ql4ZURAuX0jUF
 kCmi0qAP69iXIzv23efBFOs5AzlRRu/oak50qaWdk7BKxalfFAy4MDjJ41tfsTIK51AdkpSgHPm
 A6uzbKaU
X-Proofpoint-ORIG-GUID: qfC-HS2-CHyAnCgK0HGCVAyOezH53MKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Mon, Sep 08, 2025 at 02:05:48PM +0800, Liu Ying wrote:
> IT6263 supports HDMI vendor specific infoframe.  The infoframe header
> and payload are configurable via NULL packet registers.  The infoframe
> is enabled and disabled via PKT_NULL_CTRL register.  Add the HDMI vendor
> specific infoframe support.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Changes in v2:
> - Drop zeroing out all NULL packet registers.  (Dmitry)
> - Drop no longer used HDMI_PKT_HB_PB_CHUNK_SIZE macro.
> - Link to v1: https://lore.kernel.org/r/20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com
> ---
>  drivers/gpu/drm/bridge/ite-it6263.c | 64 +++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-751236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2EB166C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503147B6BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C82E0916;
	Wed, 30 Jul 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EImQmiXD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852261624C5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903107; cv=none; b=Mt8P7krCTIeRpPXF7JzgmA8bHASYeAjZSUeTJFfzPuIovsUYdPoyjqCCqiWXXnzxND4DW7QGzGxCQyPIkEvrJ1iij3JLzXaxHqTpS73vDlITg7lVagxXBGxdDZbkuo/ipnoCabN+dhd+3ZiSMfsLluRD72Jz2rAXYNJjzTWbZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903107; c=relaxed/simple;
	bh=Xm4UgStoDHQihhefy9SdSJ2oHAtctJhnFfvdo4aTM3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iap3Ey/zMxL0dq1cwCDNFDnIaTAKuudms9MVlEXaAeGbrhRAKaKiiLMgw76eUasfknE+sFCBUot7R/rXCXlDZ/Ja/TMJS9ezGuu/FsjigasrmOA+RrWiF2Ed/rnJAA2No3Pw+Kv0X5zCMLfRF6SpzJMDar57Ak+a1LryrRIlu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EImQmiXD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb6Ud030186
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FanBCw5BLoPwtDxkGNTUqhlX
	8TW+RlQwVcVVxpLhSWw=; b=EImQmiXDzkiRn46ydjaUn017FBJzOGg+snH8HvIk
	CVE8cvPzeHighmIGP9tu+QOOxBZyAMgg2IN7vLE8eICGAgy0p+hjDA6NYxyuGqrE
	4aCrHPM93FhkdDrQHVE58ji3zjGl82fS/qQA4YX882A0e++kjUlUgbdTF83tJzC+
	Y2APKePWBKnxe2L5P9oAlfflSNtpt9heIomYL9rVxpve0aXUYhdiZiZHS+2Xn6V0
	vKbzD29arggM+itUX6fxPD4t3EvJu6Z0RDPleP+4agXtFDTdSK1OBG4+wjF6/kY9
	Lb2/51tWJq5MqLgwQvUT242YWin5FNkH1+9hGS7PSikqiA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwesfa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:18:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7074f138855so1562066d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903104; x=1754507904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FanBCw5BLoPwtDxkGNTUqhlX8TW+RlQwVcVVxpLhSWw=;
        b=ZB+H4jrtJ3B6yKGC6sbybMRYvkoeUPVzEXUGAjka0tir00BVDt24EH5nKbqQGgZOIr
         6sxuPrKZVvFCVuP34dgq3rwQ2r965Fd1rejx2B+1DQ35gjiijRB0vLDTq+lOgDkxWVIU
         GYoCCnBEFmLeZFqoNf8gv3eE+0ncnN9Ae5jJBv0FnrxfOHdgAmuBerltVdRsJtO2pmVG
         LdhjMlJ7i96ALUdjKbOxCCpCxovxtUsH6KRmToWmGslHrMQf0UIrJ5F7YzSkel8FVchJ
         ZpddufQkXl8k7LBWR1UJ8qGJhbxGQpQOtxySC9HM7BIWaghWGbS8laIpRDeEZex3hVlO
         jA1A==
X-Forwarded-Encrypted: i=1; AJvYcCXBpsDiXakMgYp5W/hCISeWRcfPgtvRUbcYuKuddme7yJXQyr0YNZ2hDdSsE+xKxmfGcDWQbe7uzV5C5L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbw9XpfqU2dj25aXEAodG9W+adTQisWLtFfHtDIjbloq2b+Bt
	nGw0LaLLTFFhnMGscPe/31Vqr61qD4afFG7pV7Jgi4Ag8NcnhKFMTKqD8X3XI1fTYpo9fGNrg9s
	uz9DxX5BW6l6ufz3lospU3mvM4nu6w1zzLrYI2Y8yIQBTIvutrp12sjaIdrAIIzx9PHU=
X-Gm-Gg: ASbGncvjVobox0Qm7psP8DVoj/os4zWRmMSsQQY7tSEkrdYxuxCyyJOBwVOKz2bK2t0
	Ucb+SNDbt7yd31c9WvRglDv9I9iZHmWr1IumYCAHgJsdWN5FoQmp1PzV0HO6gNdf1amf07zGRMY
	yn5nw6kCSy4YrRxlaQI4VZzsqbA5qHzkORwCltxkFoOf/ofg8IsOsJV+ol9H5HnJQj5c3iANYZn
	dulQhLGN2v8OQtn6qRXt4DTnwayrkkZ594vk+LounvEm08Hf2teHBm4IaX82GFbL07DFcVEubF7
	9uqvjG6Fg0Cue4AbB14ll4ZeRZ7tVblYKcXIJTY6S9YFElyujT5dWl7M9xMxtAzA1lrELy83rt7
	kreq1QmjB1mHAXQjYHotXiFmm4X+ca+AN6pBuC5alp1pw9LUbTA0F
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr67685536d6.18.1753903104416;
        Wed, 30 Jul 2025 12:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl8eNJMjl5UHD4Y7oHflbvKCvMNV3/wEu2j4m9V/ZDllzbIpyv02lYi/lD+mXFIvB4zqunEA==
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr67684826d6.18.1753903103812;
        Wed, 30 Jul 2025 12:18:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63363865sm2226014e87.83.2025.07.30.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:18:22 -0700 (PDT)
Date: Wed, 30 Jul 2025 22:18:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com
Subject: Re: [PATCH] drm/bridge: lt9611uxc: reset edid_read on disconnect
Message-ID: <bffxdqrltd7tlyvl5feoo7iriyw3kdhemeljbj3wvjzis7phkp@agztacm2jusr>
References: <20250730-lt9611uxc-reset-edid-v1-1-3ea4d5b16197@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-lt9611uxc-reset-edid-v1-1-3ea4d5b16197@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Qo63h5BKB2OwdVbHRtnoPDti5Cmr4ShL
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a7001 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=shrNnMrm9754DlGR998A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: Qo63h5BKB2OwdVbHRtnoPDti5Cmr4ShL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE0MCBTYWx0ZWRfXxRQ5QykkjVYw
 vDBsgU5diXOkRFIT6K9CjfiesQkyYpl8l6wXInNZmKdTw8FMvQ9Xt+lQJk2QHXn5wvskTMcb25s
 ZsZUXCjJ2OPldb1b5ZB+3TSxsjTMxVBpadUPr20qgMrKPwxaAHA8t5wNWafMEVjXeNN6M3M4sUd
 mzVgbWaqo/RBhlymBzCoTXA0d1xw7+q8Z9bR1ESCle8TXAWadCRJ2UCG9T4XKsEsnfOHWUMQsM1
 UL6QF8bLnW+hyonJh3AiRwpOQPN850iamcY9M37hJqP1dTDC3sMAw0tMGWldRLrcam1RHK7ufoZ
 cY6n5ITehNz+nDTmHs2GnvjQ/szqtikEW3VpNnuynfyf02PtpYRU3m4JY9N4R6ZhZ0nW4iOL8N/
 ldO5my0CXUbGaVIGkhP/9XSgg2hXvSqC9BeErpG40iu3olZ/oPvoIvuvSZ5OfAw+pa57KkuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=975 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300140

On Wed, Jul 30, 2025 at 08:01:10PM +0530, Nilesh Laad wrote:
> Currently edid_read has value from previous connect session
> and resulting in drm using older edid before new edid is available
> in lt9611uxc.
> Reset edid_read so that correct status is updated and correct edid
> is available for drm.
> 
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


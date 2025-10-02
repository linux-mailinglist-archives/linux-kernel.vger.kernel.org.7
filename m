Return-Path: <linux-kernel+bounces-839844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC3BB2907
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E128719241FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CC25DCF0;
	Thu,  2 Oct 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WIwqQBCo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647871482F2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384330; cv=none; b=hokLVLZQWML8zCOYOZcCngmtiEp4jBxZfPFu6A6PfX5Irp3sQKszHqUwCeG4pxmInyyUfUCQyLm9ZXaWdFJq/7oy+OOFSvy8FjT0XZKonOaVgFxWf58VHHIGyv9YXryvlYyYY6jTMxl/AiRlsCearWlc6hIp5RGYs4ttniAA/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384330; c=relaxed/simple;
	bh=Agg+E4DIFeHcuBl0hIxPmI2qeA1bZ20Km7tQRUz5yMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS9du2UziI9zNpMDaQFi7T1CFXxkgjFh5WPP0BDcj/C/VHIBsNSu5xeJs5ubN+dhapf8fBIhzjotBmFOI94A28QOokt5XEucl8gHLhB2FRdCkXLMV+HB99/kMXZlqEQrrDZtoupac9/5W38IU1QWEo+kBH3SJoglEEau+IlmtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WIwqQBCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbwKb017638
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 05:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WdABpfF7OkNfgDykEBK+TNid
	8dXX225sHpffd9eNLq8=; b=WIwqQBCokKCgNxQ3pI5lNTJaNOkRiWOC0T7idosG
	3A8ZMrvk6RGRfkgz9a7z/v4r+H5jnsw8rcvfQH12372nqpQ6xiIWJjUhA7vi0Cfn
	h9vWM8jyIbUJYLuUlpUnMtXWW0ebSXuCeawqSBqNaES8gCIPb/t4sqZgWDS2POYl
	gRLnD04bkekDvgGv/ZbU8W0yDfYg22BJoga+CZ0f8AA8iiAvGAijgbKtPP+UjzEw
	MiMUGWWsH4fNPIvjYwQcyrD+ZAjAam8ZpdAcYOgYbbwbsmWhRy0UHSFbMCuzw8aB
	HbK6H//2ubOI2fS1z7EobRVKS/PoJ9ol/j5Omai3Uhd+Iw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf8cqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:52:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de801c1446so16613381cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384326; x=1759989126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdABpfF7OkNfgDykEBK+TNid8dXX225sHpffd9eNLq8=;
        b=vWvZ7XUCsXC7vwbp54mlZvZj/t8xoFRCpTC/zVTJrhkDxuOSZpONS1U0KwpLLD3J26
         djJVvKgVHTCvutK2Jp7HO1bZr0VGOzHB/ho2JCY8XsqoYi1mjJqEfx+j8XPdcvYZt5ZU
         +SUqxOujVNsqPy5Z3uHqaF5UH9co9BedejMPkM1vkT4vl50dVrZkZtd8RWluZ/ZzVy9V
         61gIom1PooExoAjoWOyH1Ks/k9/UyPlVPlvc7+pvoxA1IXp+2337qWa0hL9LzxEWAU0R
         ytwglAbQngkdkup8Aa1O2hHdUlDwu8k4LS6LgGdKOQSCXnK+YXPVptGvcmCmXk+M50zC
         ZBCg==
X-Forwarded-Encrypted: i=1; AJvYcCX8rjJdQbgQtORZ3UmavurjjumSRmTvqGpqgLw9YNMtaMGqPCHDOEXnE3mq7ZN6uyzO1cZiJwz7XRIkfSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68djsltYxHOInkei5X/upbwNHraNJBxFmVuMfHasQ4qJfgF6c
	CNknya7xfzARgEZ4VduedsPX7VAreUyBz4uv2CwkoAYXgN2nCPnC4f9o1kQct0sJGLWejQu71qC
	DkKty7dGUmtTwIwFUA1lBz2MC/nTcDpVp4yDUT2a2plRDamrOilVGLnN0/zrqgq1nayk=
X-Gm-Gg: ASbGncs1ohcQApwEiCkH8UnUsdG3Lcvdu/vv9v1+5+8b5HAlMd+PYumwSIa3owspLA9
	i+F05PuLVlwaBUL/3QuuJczm7pjX49dlapMUyOBQvBswEoV7VcfYektTWZuqPl6k3tuoqRYU4TX
	W8Ur4OEY9+Qb2towArPgHhQyKIv5m9syMXAorAv94M9GEmR+Oa42BnvKSd47s4DBt3XKdlFSMpO
	L5gnTlBe2xltynO8q9UsNW7qUQQy//sbzjhky8qerTCPYFAgAzVO9J2LbJw/HAZfwaRuGuglfyc
	ijS8GXe+Fyi2J3+4n9QxDXtLgStwADMi1VO/ItlqGFCid2ZqhDaP2Rpf1r2BofM0cJaFDrR94PK
	FqVv1QB7+pH3t8VArOWnpRYFxlOJfyi64I1iTofUhC7z91x8UUz3nfOwc2Q==
X-Received: by 2002:ac8:4750:0:b0:4d8:afdb:1266 with SMTP id d75a77b69052e-4e41e15df2dmr63014301cf.45.1759384325976;
        Wed, 01 Oct 2025 22:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7M3wajxRbMA9ybuJM3HAEueisvDG+vjhfv/Zrn+Q6Om5w1ydX1jy3VPsPX7ig1Lr6pViCDQ==
X-Received: by 2002:ac8:4750:0:b0:4d8:afdb:1266 with SMTP id d75a77b69052e-4e41e15df2dmr63014071cf.45.1759384325457;
        Wed, 01 Oct 2025 22:52:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01194e59sm523439e87.75.2025.10.01.22.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:52:04 -0700 (PDT)
Date: Thu, 2 Oct 2025 08:52:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
        Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v6 01/11] drm/fourcc: Add warning for bad bpp
Message-ID: <vj3budjobsehi3hl2mcmondt2f4giups6cxeiraeo2ensgw3du@smxivopyzfez>
References: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
 <20251001-xilinx-formats-v6-1-014b076b542a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-xilinx-formats-v6-1-014b076b542a@ideasonboard.com>
X-Proofpoint-ORIG-GUID: glFdSm85Q9uKsiEKi6uZ99yQKLmOzE7Q
X-Proofpoint-GUID: glFdSm85Q9uKsiEKi6uZ99yQKLmOzE7Q
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68de1306 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=P1BnusSwAAAA:8 a=EUspDBNiAAAA:8 a=iDPJBouE--3TGtnIlUQA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXwbRgHQsfyT9r
 XMUQNP5/bm5eV9ZPqZpmryH4zdtTKg2RoqPNw9JPXBeELRULgPGcseg5XMKHOIO8vLWJ/XpESXN
 4lpc6kfl7sykW6Rtqhy1y0UTv9gDK9Oj4SQUbyCJaQ2vGajaJNkpCxTzfamMXEC5fD25xMgfr3j
 NBa9ZZbv98kOlzZQzfj2cSe6ms/Nlp9EybWmx2oE5XYyjNiik1JsAkleflzPPSJ/FPXrECBGcOs
 BRU5XutekNPpmOyNOd7LoSJIEEU5U6mxw2gj8SGq3P8AFEViqkk2XT24Rf0AMAD5dz8fA4H87E9
 qtRZ5n7FYL5LTgcQW8PGZfkH31p/UrVzSH+KlKmgVLWKXBYYUc4DERQ+jqfCHMBuqmLg+RWUBvC
 3Law5zGRw7lgAgqlt85cHap145AF1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Wed, Oct 01, 2025 at 04:22:13PM +0300, Tomi Valkeinen wrote:
> drm_format_info_bpp() cannot be used for formats which do not have an
> integer bits-per-pixel in a pixel block.
> 
> E.g. DRM_FORMAT_XV15's (not yet in upstream) plane 0 has three 10-bit
> pixels (Y components), and two padding bits, in a 4 byte block. That is
> 10.666... bits per pixel when considering the whole 4 byte block, which
> is what drm_format_info_bpp() does. Thus a driver that supports such
> formats cannot use drm_format_info_bpp(),
> 
> It is a driver bug if this happens, but so handle wrong calls by
> printing a warning and returning 0.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


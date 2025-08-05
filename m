Return-Path: <linux-kernel+bounces-756282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A680B1B243
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E43180CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319823816E;
	Tue,  5 Aug 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuUOtBWU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264A3D544
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390985; cv=none; b=IsvbvRFYu/cjoeAwvZDZZjOqfwB1Jib2UEM2RQ39UA91znwzKE2bwtRYcmMu+cFVhfCW3271Guy4bML3zKAPzhfySmj5XeLQwJvGwXVXQVUXvGL5qEUlRD4Db8J8z6K//oD7WcfUJKpWR6LLvOe44J4Y4/PFU3dhUuKv3t1SifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390985; c=relaxed/simple;
	bh=fqEe3cY5rnN21WNoCqtMng+k7RSLJSnRCtZjXcggtZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skz+Qk4aVbAvg5Ze+wSaW1aiokRPdfmb9MJSvOqAw09YkwXOr+cYK2ZdgG1Kh27vFDozbdEUVU3u+ft+TL0HvV7ROQD7vbZpDBUvVXPnmLPI9HiOYi6aaSNtMFjucYqkM/N3JyiAN9weyYVKbKkomAbc/SZHq7kCXrzz8NTikYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuUOtBWU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757I5Ni012229
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LILgYy0C41MzDzL71EJVum+V
	SwDZcGW+zNtWfWKsOEc=; b=cuUOtBWUez5snHeq8nRz24hT8XyGV5OZZBObwBMH
	YoGuujpfcMHI5bZRrwoCdxTMjETOffNhzK5iNAkdG9gNTgh9Qobi8JI0hJNmBG6Z
	Gza9X6gaTX4oHUCVrO6XNh6lZtZwyMmbrIiGYc4wSYlzd5mInAr7s8aAanrW8OMK
	QTxr8PhogdnGo6uzvOYl5Xqp8WGyfsFQVnaTLX3DG9sx5d3QXrIi3Io3IMOrfegJ
	Pgk8eAnlY6WjShD1lx/26PE3kOMAJnwuQoJdP/uXSos29DSY5iM1NIEE4NzYa7Mc
	6nYiJdqXKxPxBxGBHigu1hTJdhcdpcf28dFiCBoLf/or4w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rrcxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:49:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7074bad04efso95621806d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390980; x=1754995780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LILgYy0C41MzDzL71EJVum+VSwDZcGW+zNtWfWKsOEc=;
        b=BBFBXYnej0Xm558xJe/HDjY8/cyKRLA36h/MeHUa1fhWaXOYe9Rcof7cNfwGvJenB5
         vXrPsxosQAJEzAMYuU2K+5dLYAtCrhTcHwsw5zwArfdGt2o6hffVMYlmogr7i8GvUgnS
         X+IX045gUSHOoCXpiic1XK5mH/k3x/3TID4eALAxJQSAeTsUnGM+26RpK77l3m4UjUIo
         2lBC4ldqjuQp0t1CO8PBFy7t5/1HWnKkEw/XEzRQ2nHQlA+4Me0eYWKnObbDqS+yB8Ao
         Th/rqxQUOWHVT+ENazRjmIywXtYdnsUDaKEBq3ULiUZGpztOCmYgdSje0E1fS4r82d5t
         5lyA==
X-Forwarded-Encrypted: i=1; AJvYcCX6oJp3MFYXYY/Rk0WjsXaZfzpvsIICoH87NE7ovB0IHaw1D1UtwLXvT7OBDPvDqCVRMN2xWyYcIQhIxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsT2TXLhfRCJMSvwXeFBWAgm1oWGmnnsibuShkZpWL2qcygnqE
	EWRR71wLuHszHaTKaLqwWsWE/qOr5Fz7PoljqtXA/seHOMh8xa/xIIfWTwnbt5D1u28HEH8WnKS
	M5QOEdl+GifzueSTa96bu5jpH1rttDXuuk7323RnDsNIpndhbtUtJM5gj1qUYuraB8qk=
X-Gm-Gg: ASbGnct6E2QImgw8XWlj6FSCQwbTA3B68QuQxXyMUWaOX/n3nFWK2cpJZeCRW5Tt3rb
	luZtZrSFFwoTn70S7kQkTGH6/fYwxIa3XYdKOX6iVYnjkm0g3CRO6zWu3FjwZuQXDKCLnotuWpq
	ebzWJfZu2AHnL0i+jWSqigN/g79ZDKEOY0skUNhTbtcZJoOIsS/Fh2jwSg5WWyREZnkZuPxnGRG
	aAizbI/csL55zGjhOhjiGZAZpZdSlHmmG9j8dWgtYRi5Qfgbj4MlNddKeziNjuuoLzcg/v8KU5l
	ARTAu6m7xs83El6R2Jq6ItfrXPfN5QP1SK2950y82Y8B9hOoaRRdEXWhc6nzkvKYRQUaqK7lUF6
	n6Vu9CyD/kOWky69ypdsCbMJTAXXZP5FyYWqcx1vvipc4t2zR61DL
X-Received: by 2002:a05:6214:2a46:b0:707:76ad:ca75 with SMTP id 6a1803df08f44-70966a41ed7mr33963706d6.14.1754390979931;
        Tue, 05 Aug 2025 03:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqYQkkoM4YKECcXArJk/1KXL78jF6AOwH67QNzaCG0gVxBltojkCrIgodg8FFNgsd6Tp9IUw==
X-Received: by 2002:a05:6214:2a46:b0:707:76ad:ca75 with SMTP id 6a1803df08f44-70966a41ed7mr33963506d6.14.1754390979514;
        Tue, 05 Aug 2025 03:49:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88db3b70sm1902054e87.182.2025.08.05.03.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:49:38 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:49:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Javier Garcia <rampxxxx@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Add directive to format code in comment
Message-ID: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
References: <20250804212902.22554-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804212902.22554-1-rampxxxx@gmail.com>
X-Proofpoint-ORIG-GUID: OqPBoXmB8jj0G2g9lfw0oDbUtgt_3FKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3NiBTYWx0ZWRfX9/nniHFcSTeT
 us85fwuWCLWMGEyVJczOmyKmHeTftwaOLv4DyK1FsAOGy0RqL2CNMN7aToH1Y5xgEFxOhQBQiko
 /CFjBiRG0rJZNWe7evzo2juoI4Nl9GKXA3ug8s/uaOYIATEY0oTRtPx7sCJPKqbEH2n+BbGcM1S
 zoy3dwoGD+3ydwYVQ+3Ck8k93KGV2NVs5hXSHWVT6Ddo2ef4MD+UryipcUiYvOKkrHLmhC54S+c
 dCX1KI4kWzqTVAWzUXJua9aT24nmLq5uVsI69Wc5GS+ysNIJHUw65E6zkFpZz3bs9IUvBES0pLo
 wjzRajUs7UNIzhR0tKiXlhNvVDv4ZP6OkJxx2vveOageFE6Hy9E+aXqvBzf/vz3M7bsEmP3YqXh
 3BqIZ35+vcuINuAEK2ojfhn/qIFW9wePBRzQlaTGhCc0dO7uyFyWvSnE/KILKMjLZGAzqPFb
X-Proofpoint-GUID: OqPBoXmB8jj0G2g9lfw0oDbUtgt_3FKO
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6891e1c4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=opqW8GeGsme4dWKjAOUA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=805 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050076

On Mon, Aug 04, 2025 at 11:29:02PM +0200, Javier Garcia wrote:
> Fixes the warnings:
> 
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Fixes tag?

-- 
With best wishes
Dmitry


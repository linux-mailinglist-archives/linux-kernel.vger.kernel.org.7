Return-Path: <linux-kernel+bounces-754195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE287B18F9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919B0189BD3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F224E4C6;
	Sat,  2 Aug 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxBEt47R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07824DD15
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754156711; cv=none; b=lkGtL/mUFl7zfwxh9JGYxqgygkIo4CrZ9UaSeUP6j1TIcBooSwrK5lmZbfNoDlzgZTSulSD7YVxO/yO/6W89QZ9/bFWr/maRr0IyCeiNYqOZ6W7OZ7MvphTSayngk/jFER2/hcz6OKYHtnPxCJUzChjDUAwn2J/d1v5qpck/P7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754156711; c=relaxed/simple;
	bh=/BZ45ilZEXy2U9DBGekioZDIbHuKRJOt+fmpxyAzyXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmy1SAttgWJktphpfSKPhlAnYs0SJSrewGRxC2WYFw3C06YeybO3ETtdIfmkUTy7ZiduTX6Zsqu/wcrRMIk/3o7+UO8gWy19O3yqbu/436epoyIhv9P5chCdiEHbVieIgivOe2GuW9qw024ZK+xSfHtEnFWpxPxcEDDQJUtFgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxBEt47R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 572HgOHU002720
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 17:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0EbUAvWWQpPrO+h431DyWvyK
	NZekIvD59gM98+lMufs=; b=CxBEt47RdTWU3Bkrzu8hTRDxdKAyTeDdJ+M94Fqk
	aZZyWpjFaS/0zV8tYY4VxVqAZLiQKKqs6KTAUEolyo/E/uuelYKj0nZizyYhYtOZ
	Q/lSP23WLsu8bXj1vPWYO4kFGwQhXcDhU4SchzzDbrZ1pgtHx6pdZmgHM7yIRh2x
	6c6shGIb/o8B+qOCR8W/52htHsdip59GvITUuRx3cyxx/Sk7k9Thk4noE9mBuNcr
	VSTmMu7h1y9c/gIyIJNmrWz8H7KPRKXy7H1uzDMu8NRXXFKrTxfaqAjGIrKS6yCo
	oREGLh1YP22CdIWvBI/Z8WZttROA+aOnxZ21ux1Bh+nHbA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899mvs7rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 17:45:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab801d931cso64003291cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754156708; x=1754761508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EbUAvWWQpPrO+h431DyWvyKNZekIvD59gM98+lMufs=;
        b=nJ2+hZD49wlCH4FA4TDO9c90HNsFLBDuR98OZ+iJ4H4MKl5MCPYTKjqjd6lsGmS/Np
         cMSI4sNECsF8CZtSONXYcZ88poUw+nzbfc+3ZaGKOQYItw8kmBjgh8dvWxOAlmyKXBML
         G8k5nIHj+Kju6mWb1aQiotYKJqsDXzNvjDwcKld5a/PqeNzCA6HEnztDb+AQgxhpeNut
         GtZ67qinUJp7xDgwO1tlrKIu914UXZTi3PrcdyWo/wb8z6m7TBDHTZu7rkbODSeXtf+0
         7gzAZOYsUNvZUkCS6IdbzN/icsY7ulHRldS9yDDblOLn79V2IgQuYI2QJTBE6eaLwIkg
         JQfw==
X-Forwarded-Encrypted: i=1; AJvYcCWCUyrLMijePmTalV4EOy6v7Y2fqEojDxyGzeTwpeAAuJ7o+iJBQdaU2FOP1YlnK3UnqM5aG5csFnonkEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhe9ty2gWCbKIqj+VLjwXxGwHrG15ITYMmLmxU2T3h2skIPsks
	oEGbNgFew2ZUj5yt1TUrR0k6SpFbIlCOHEkC0JnAwUCYd6Ba+L2OaDbJa8VqPR3wI4aZFV7GyyO
	fR5P6VRoYbOV+Awh2aPQYWx9eW8Deu12cFHpvU0dzm4r6wnBlce/24QzON1JJv2OFnLg=
X-Gm-Gg: ASbGncsL2y7MHtO7OCszFADN7GYXLlkIn/C9e1YqwFLJsvLVnLP/UdCFTtOoAUVtVPQ
	FTFxB546GhX0VsldMCN1vuZMj+O9eXSzCJpMY5dzgCELBHstY8ly6F+3bpxOBvi0ZejuoJ2KbY7
	CaSgE94wA7JT/Mr8GEVSktBLo/4N56o7wS0GyMRJNqJ++lBRa6cX+UbYVCIoY0hvlXcEvT5+sZG
	TZ9HATal5ZtJvE6W7tjXFlU4WCFwKppm2YkeGffcT2hPz0xoSeh2wMYbN68+FRxxj/8qFpeLLPn
	EDuS2GJdGosx/obDmOW/x3YNMpKcN34VCxlYIbJ734mYIe6AjUl8mvt05+BWF/I0jdO0ob4QU7Y
	sQhxZvBeeSFiiSHt04iqYDit7WPVipy+/Y+ziPywybmsu5CLZ7RoC
X-Received: by 2002:a05:622a:6090:b0:4ab:95a7:71d2 with SMTP id d75a77b69052e-4af10d77e73mr60076321cf.56.1754156708018;
        Sat, 02 Aug 2025 10:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZFJ9ZncMv0GBgEG7PbQ/lsOlmBLqt5+Q9IM7PyWYnWZaynQup7F4KuR6kPQ1X6ByQ9G2Qog==
X-Received: by 2002:a05:622a:6090:b0:4ab:95a7:71d2 with SMTP id d75a77b69052e-4af10d77e73mr60076051cf.56.1754156707629;
        Sat, 02 Aug 2025 10:45:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bfdcsm1065014e87.1.2025.08.02.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 10:45:06 -0700 (PDT)
Date: Sat, 2 Aug 2025 20:45:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
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
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: fix OF node leak
Message-ID: <n3pu5ninfmknkde5ntn6hrybshhkhd7iorehfj4pv5zj4lvsyd@6z7v2h3amvri>
References: <20250708085124.15445-1-johan@kernel.org>
 <20250708085124.15445-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708085124.15445-2-johan@kernel.org>
X-Proofpoint-ORIG-GUID: nrj8kfT9aL5oV11TRq5Nyotzv2dVfTAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDE0NiBTYWx0ZWRfX/mxygJBZNmee
 QjQXlDPr+KtKHRMiLII1M1Kq5/gnUQPuNiZ6rICaoFcb19DKTCw0P0AcTP+jYoD8i4+I//Fm2yq
 TDow3Rv8Z7oY+8Y48MS/EFhmZLi2VXjIgo0XfSq0bcMUozvym07ss3INwL6jzJQCvaEuj7x+l4Q
 bbeX5IhXbFk3O9VzZ1FQDXbTohdkz65UM7XM1r49D6a+d9yz2wjpZgpT5gtUPANTUbETnNA6PFQ
 PYWdx0jwpzmXb7YAaWRTLpwwdKsL/5XKFx3CQv/nGqYsn16ATDgCPwgxLyE7YfY6ZgRWv5NYvOD
 RqyYqr0FaruGysjrBpvOlvHPe5NOt8kRE9t+uXVxip6CgJfsdCAoSjp6JFeVlH0g9RkqiIGRCjh
 isW+a9eEAKYksOqAKDZukk/sPjPBluaAlY9Geeb5bbI05UqfGBxnwfBTbZOIgG3sabDpgAUc
X-Authority-Analysis: v=2.4 cv=duXbC0g4 c=1 sm=1 tr=0 ts=688e4ea5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZKwWdIalRbw524GBQUkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: nrj8kfT9aL5oV11TRq5Nyotzv2dVfTAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=974
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020146

On Tue, Jul 08, 2025 at 10:51:23AM +0200, Johan Hovold wrote:
> Make sure to drop the OF node reference taken when creating the aux
> bridge device when the device is later released.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/bridge/aux-bridge.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
PLease excuse me for the delay.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>




-- 
With best wishes
Dmitry


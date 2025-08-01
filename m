Return-Path: <linux-kernel+bounces-753716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F81B186D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1223BAB1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0A28C860;
	Fri,  1 Aug 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nh+ZeRmT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DFF1A08DB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070122; cv=none; b=lXuH8YQfG4LtvI766md1xwj5aB/NlnjDas9PlOsvl0mjb5UwtKxj1YWrc3rESOYMT4c2IxOPeClb3LEmYp35p/p1oai1PneHGCuIN/jaGTHwDaUce2jIa7afLhub0+aPCPGFBEo2LoFZ2v3EFJOy23V8jdYDqvx0uXNInqR3/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070122; c=relaxed/simple;
	bh=MjIo352WqpQR2z0hIEvwzSfkfO/tgHtMOcawPBa/DLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avuMyQGocPdmr48enNU69YPJwrf172v2XvW09gIvNX47auKEJey7lQ9u5vd/TwDQW6UWygiOKFUYNIUHLJJnWijI4GMjqDPv3isPNhG/+e9wISOpLc9MNGIJHuu5Nn3Vxshx1/Q9VEcKoNnxcVZ89KvoHBhpp3EIX3EtDle9JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nh+ZeRmT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfgoT019984
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 17:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mQpZu297GrOahwaw/VEhcnsV
	4khl4o9Em5OSPsyffWU=; b=nh+ZeRmTP3xeUxvNw3fR80rBxHT0jaMSDNXtJ8OJ
	HO5DU/1U6/zqBABcmXqKVDWDK0rGZMnH3SnBafQ/QthML2hLKOBc8j9Y5sS4Hhn7
	xR4d/Y7D9BeV4wIYGDdkWmxPlJfAqul0SbrDGBtARwPnHwO3SE81f/Ie+dVQCe5q
	tSmzpTGE8DhKLi9WyYmhgCy84+793Tj3JauQr/w52lPf9Y52b2e70l8V3jgebK/N
	7KD9y9cjWeWxiWJ3OTz2IkrC/TIeH5yAcOekvhfCdkNigwhPmRKJVInfdHpV7ycd
	QqDiNHo+wW+s9IF4j+lJIicQgU/9AJAr9XgmQCmFkyHeNg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g58mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:42:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab99d1a223so49095871cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070119; x=1754674919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQpZu297GrOahwaw/VEhcnsV4khl4o9Em5OSPsyffWU=;
        b=bdzMkWhCL3oSe04anogpyV1E9WhVfcmsXCae6h0Xns73Zdp0svfzk03YJPdSb0x4vZ
         dsRbG5eDmApKcbzNMbefX4wVUhVEc0WBD87MxLTPb7n4atQJSguOJpfit4O0flBLprGa
         jebfC6iaSkS/0w5fwFQsviVbpt7mFEI8/zXKu2f2fdBZTELcIqhHMqmiZbWsN1Hw3Drm
         bXCL24lgLGqXhq7DCt+Dyx03fl0oF5u0A9y4nkVPjxGmByjzJlA5TawgHE7nyxJ+YDCM
         VfO9vf7GbhrJWKC3u2k34rQ9lYhk6y1g3LlPHFqTbkIlwSd1sukSCUdyUgOny5Vcg3Nn
         OMbg==
X-Forwarded-Encrypted: i=1; AJvYcCVXKAUOSmVtVFVPFnycAjjmnkuWwUPg9Lt4sWbI7osmtdOKivv6jLrFgeJ2I13cqp5s1pItUbtd4UlU624=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVemd//a2/UHlWmFLIGzv3wK2WKN8Akc4+SWVGa52WNWvv2v/
	Gtrdyv/FltIfUl9TFa+wRP3VStG4UvN8NoYuvUKiSGyqA9iV28h8ykKuyLK19J6anqqkLewp2Vn
	Qlj1RsARPMlXehamwrPkJkbEr6CCf5ZivXuAR+lllDqBkERMeRKG1DN5Ck5NiVG/Of/U=
X-Gm-Gg: ASbGncvwgoe4Ng2effTQjAlUNXoKdUTf/hlEg/2GSgKuZcOBx8PveKa1mHw8ZLp0MAh
	8PgqU1vXue+JhXpvk2nfgxcVQlzQPlP7PIoMciAodFsQDC38q2oX6+RjACOoRdd1ln73aVm6/tz
	P6kxOr/eV9oz8hwd9tWJvaEYqRsa6A6dh84HPyBRcfgdGUZfh9ENpfoAhWEeWWFFF96sFzcEeTs
	ywTPkg9hdTCETqgM+GaHy2Kta0imqvuiJZCQbZK7wOnK43sq6ZkBqmwPqhaOdsXFzo0V+1lTz3D
	l1JdJCbCSr6XEY7Nl965smnrwT4z4beGBMMUuM+z37OYRNzMq5rye8SwE4BWHpKJkHIpOvxddDk
	ZXM3CHoFt3amzfJBTNNSywG1ETsWjPvfTcbHNbNfLAgaIsV5/NGGH
X-Received: by 2002:a05:622a:110a:b0:4ab:66c5:b265 with SMTP id d75a77b69052e-4af1076bf9fmr11281981cf.0.1754070118713;
        Fri, 01 Aug 2025 10:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv9K/9Mrcl2aEP8DkEGqC5ecwKIA835bE0VNaNM98VN6YobWwCpiPGo6+PwfkoAmPywEoKnw==
X-Received: by 2002:a05:622a:110a:b0:4ab:66c5:b265 with SMTP id d75a77b69052e-4af1076bf9fmr11281531cf.0.1754070118210;
        Fri, 01 Aug 2025 10:41:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98a7dsm676692e87.85.2025.08.01.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:41:57 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:41:55 +0300
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
Subject: Re: [PATCH] drm/bridge: lt9611uxc: add support for 4K@30 resolution
Message-ID: <yhj6q4y62yzvhnxjm4g6sx3552g6mwz2uk3kvwfewi5hcknebp@euy5iosfilux>
References: <20250729-lt9611uxc-4k30-v1-1-cacab6843f9d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-lt9611uxc-4k30-v1-1-cacab6843f9d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688cfc68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QkhM9EBQO5yHTPfk-M4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: xWDqaII3QI7oIvBiul9VZLM9G8iEXvjZ
X-Proofpoint-GUID: xWDqaII3QI7oIvBiul9VZLM9G8iEXvjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfX1nKxNSKAD2hk
 MU6RFIxyiSkPWG36itdyCEuYtfp6Mbaml3zIeYIhZgAl/0kqlnfqmnQ8ryt4Hx7XJjqJK6T/c+H
 Hpv3IzxZt/7+FpuTSlOqUDx4r+KRvJt+s0vRaqQgxCJh5K35Ota0RtJp+S4bHiQU2xN8peXVVq5
 4Igw1FksJif1edVNpLyVG04+CzeeOxTfBhWHQ9DhKknp2+xB6wULqaAMGYt3lPy+96Q3Cs9TzVW
 cPhYYGzvv21iiXcUDNm0KRYc2YdxSdgPLocDig2AezfVMvzc80wyVzDDrOS17LhLD4JVhzhQE8i
 7PciYD2Dr0Gs0L0gcBrPwAXpnfepnpjVp0L+W84Dqaip1mb0Nq3qx+9K/XBtphsSQkSDNqskbrA
 JxRUqFy85WX9r3haqHNu3Bmp01+BN3VBqZ9VG65ZiMCW3Lwv9O/qjkWO5fybaqB5OR+H/z3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=895 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010138

On Tue, Jul 29, 2025 at 07:00:30PM +0530, Nilesh Laad wrote:
> Add 3840x2160@30 mode in lt9611uxc modes to add support for
> 4K@30 resolution.
> 
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index cfe389b4c25c..ac53da6c9711 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -100,6 +100,7 @@ struct lt9611uxc_mode {
>   * Enumerate them here to check whether the mode is supported.
>   */
>  static struct lt9611uxc_mode lt9611uxc_modes[] = {
> +	{ 3840, 4400, 2160, 2250, 30 },

This should only be applicable if both DSI links are used.

>  	{ 1920, 2200, 1080, 1125, 60 },
>  	{ 1920, 2200, 1080, 1125, 30 },
>  	{ 1920, 2640, 1080, 1125, 25 },
> 
> ---
> base-commit: 9744cbe3603db5dbd6e63da9c3bed8df68a6d3ba
> change-id: 20250729-lt9611uxc-4k30-6175bb8a0570
> prerequisite-message-id: 20250725-lt9611uxc-modes-v1-1-6a13b181927d@oss.qualcomm.com
> prerequisite-patch-id: 6c7107d0c8810b85d722fd32e45f736fff81860b
> 
> Best regards,
> --  
> Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry


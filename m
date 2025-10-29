Return-Path: <linux-kernel+bounces-874937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42597C178D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEED9355D53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB72C2376;
	Wed, 29 Oct 2025 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEkOydok";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyffjzDH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD22C21CB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697853; cv=none; b=TYVik424GYeJ/60l5nB7O6r12t50YN4YroE1CKWVnDItIQguzo3evznBH8nXTl49cdsOSv8frEFGRx4HNrukHV4zrmjXiRyRkFtCaBNrTfyoWCBHE6gX6HtoUZ/U0nFcKEn8PtU6mlwj+Y1sRn5oa26LAgdN0HiFG9kY2FkTiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697853; c=relaxed/simple;
	bh=9qgGv0i5pja2BOANc8s8On9La64eHzUUc9FhCRqGf38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQqkde8/IR5u/TO3Na0AbtiUGLOk/9mUGKfleQucgoUTWKH/5cD53i9KgTWpg2vMqTFvKPy1rGZqXBmmpz9JIj3NGIj3o/QDOKSrG2yo8eakHrokZRKRHdZEKceS1DtAw0v46ZO/+/TlYC3+m1TLRnKocOU5y0GUw+5n/RHy1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEkOydok; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyffjzDH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJldZi2622948
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/WIa6RkBloD5ztrGJJT0zLrD3gSyVrhoMmTumwjlzqg=; b=CEkOydok2jsuebK7
	kpCmaL52MeJ5wtd83KVpZ93pw6a8ivyGoAe4/IN62UwP8/CC0AvwFH31OWtXDb3R
	HntjABQQEzPVs6jIDdUi920cdXtHZUjmZ7vpD2t13AiUCb1tYkuM8++zHyqQyGz4
	VAWTqoL0HUBHbmw8jKPBQ0FhxLILRGO5YDR4dYOTSOHFpz+ib9IeEZk89HCjfty3
	zWOn28mMtKlB9l81pecqJPZpEsvpZTmrVxMVhZ5ywNeBqm/26CEHiwhbznmlnCJk
	6MO6Yb6K3aTwRV6ALQRiPldh5+gyok1mObEd2sD00Jw/z0WUPq+/L1XDlYcMDXwa
	O8EZxg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a10mvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81d800259e3so57563876d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761697850; x=1762302650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WIa6RkBloD5ztrGJJT0zLrD3gSyVrhoMmTumwjlzqg=;
        b=CyffjzDH/WzcBSH89lN09mGuJ2Yn+YLvZh/Skqj8H+95wUTgIoIJKFiiiNL4C2ukEI
         AZ3Vz/qW4k1XAt30IbjV+Ks4VShOyQ4QRUarOFR5th5SxMGTD5ZtWHjwTX9dkb2JT2z1
         Q49wTuKNGrMklUiKVXX8vEyLqoZkVrBV0e6FG8MoVIKWjxiVkaBrjaCVghDwbotRwAUU
         8Y3Sl8639WBKOcwOYSTEbOGXMXJ02FYYO8pIPxlOGfbFCP2MYxBUg7a01y3eYinMlwH3
         eC1yxFehs7CTYxAfL3D5bBdN/Uy7ZchXcSuMQcgg+rVGZBfVNyeIeAxlOxDIqQgQm9g+
         1rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697850; x=1762302650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WIa6RkBloD5ztrGJJT0zLrD3gSyVrhoMmTumwjlzqg=;
        b=RaS4rCyJ+TqdfiH+rwKl7JqhZWGvE2F0GfjkLF+eYdSW7WMKTzXgqP7IczQ85GgFMc
         v0OcomYPZ6rCGb0lPRhY8JRZnHZk7ohMprN42EHuA+BRIhRYR1HQZDCtyYOz+qtxOUkF
         F/ssiaxkqrPiSr5vN74w7JzgMeivctaV456lY+Pked6zXzYdGcLnQqW0Z9C8A2qhr5Vm
         owP98CCZdIandHp9UKt3kvU7lV5sPAUkk3pCRAthNIwee7Wg5KEnFdez4PwrtDqWAyJ2
         er2D1vA6ibUekF0flDEC26x9ClYDJyKAUiW35WQxcYsJ422PNYdsR9r7H7jSRdhy1erf
         8n3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJGQLuV9jc3iIBrnBWc00LUazz/n9REHfyYQz+65dIeA05y1bFmnugbseXUVVtP5muFYRAXhJTfs4OSms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgyCmETrtOuom8WhBvi+/gXKDuyxC14sFGTVyFY8WeZScn5a/
	S+uWejV2vpvK5wNXqy5BLAto3Fj2nrymlEiT2UGQ932rZXoKHUF7JYK95dSu4/43PEhdCgudM7t
	0UNhoIjtmwXqvyCQthIIvZiTCWVAXrv2wOfbaiuyFypbWnYIqVhmouEOw7Gibrk6uq80=
X-Gm-Gg: ASbGncuspP1Rn4Hj9jHWN2QqsF8WlHxcREN9Eu4w9IDXHaDUyk6PM+OIMXJxW8gk8Sl
	SaMImO0V6a2PQiT9VvpoVw8m+XRCr0Z17ji0gznF1LtSgf4JOKtnSsGavKlG0sjbZXIwpZ6rYDC
	RzfjwYx7GVxqUR2FHElWUS+fuhSea+XrESiU7ewGqZOSVKN/7Ro/bBNgEXddoXsUxS/tgrX+zSB
	wyYhK5DxZ3mZRmt+Ekv9kGeMWdF8PFOs2hY43lgr+Ux1vAQCD0icoSUfnO+hX2xlw21bMvjRW1Q
	6jp3EPw9RYY9fcarayfnQvhBDcGHn+6l4YpMIE44/GHf9HyYzFtC9dMU6fl0r3N36BRz1qiKWx8
	p3eAWDbmTgzCAi48d3KwOJMDDgEwcAjy3L/1ixV3ZPq1fxH8gH0JnkCovDe6+vlkrPqFdqwvE3M
	pLUSnU/Z34PPr5
X-Received: by 2002:a05:6214:d62:b0:87c:2805:9fa0 with SMTP id 6a1803df08f44-88009c38648mr13965026d6.65.1761697849720;
        Tue, 28 Oct 2025 17:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSnLbnquq7Efq2KCwiEYWEnFhYg3Vhkyj2eKpcDAg1Bjm2R9tCzuRidVUDhLFOw6pKZFqx3w==
X-Received: by 2002:a05:6214:d62:b0:87c:2805:9fa0 with SMTP id 6a1803df08f44-88009c38648mr13964546d6.65.1761697849177;
        Tue, 28 Oct 2025 17:30:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee092042sm32141621fa.6.2025.10.28.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 17:30:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: dsi: fix PLL init in bonded mode
Date: Wed, 29 Oct 2025 02:30:42 +0200
Message-ID: <176169780826.3761968.3488141100025074954.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ruuR-ml2WxhtWnGFL_4b8h9dUX2JqMa6
X-Proofpoint-ORIG-GUID: ruuR-ml2WxhtWnGFL_4b8h9dUX2JqMa6
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901603a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=8BgOjkq8Mluc09TWGxQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAwMSBTYWx0ZWRfX3QqY9zVkEJ6G
 7PBsZ98iKjB7IwTtyDSL0Kdx7ALhu1oYk3g9fiyvCgbW2SUuqlNwvlDYV1jVJdFcQr1a+AyQNHU
 fr56850fBvxw0L7w7VLy5XUL4RrAAclk+9/jG0Y5H8ZaMu0kfaVhzHrlU+tRIVgDq7JSWyokK77
 gl4r4IwWwwDmEw50NySchrGnDtVcLMwZ8roFZ4ke+itkmaCmPaXhQvyvqoGT+nulYY2aEkZgvDZ
 uYcUEjKZDKLGuIP1uu3qmmQXAYlc/xbqxzjnYlKxKgBc8zbjODeTKDoe4ealBLgXVQOEsBMlppu
 hhpcS0qit4uTvy7NRg2vo/vghVGU6PhdLhmkJ7fmijLBcgqCG3lFSAVRNp3hAvK6nexMUjbygre
 fvqYSefEP11vrmcg7zRGMxbg7K7YPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290001


On Mon, 27 Oct 2025 14:09:48 +0100, Neil Armstrong wrote:
> When in bonded DSI mode, only one PLL in one DSI PHY is used for both
> DSI PHYs, meaning that parents of the secondary DSI PHY will use the
> primary DSI PHY PLL as parent.
> 
> In this case the primary DSI PHY PLL will be set even if the primary
> DSI PHY is not yet enabled. The DSI PHY code has support for this
> particular use-case and will handle the fact the PLL was already
> set when initializing the primary DSI PHY.
> 
> [...]

Applied, thanks!

[1/1] drm/msm: dsi: fix PLL init in bonded mode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/93c97bc8d85d

Best regards,
-- 
With best wishes
Dmitry



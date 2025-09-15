Return-Path: <linux-kernel+bounces-815984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA047B56DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC853BC10F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0E1EE019;
	Mon, 15 Sep 2025 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVnqfOo2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC416132F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899959; cv=none; b=BhfKLQh0JxaIDP3ctprVo8DwY/RQGqVSfHQ+NhApbP4Gn1GffCJzEYK+ZY7h4DKalUuPK9r3ycYmI3DjezTuqHnINYpHRuQtLGUz8A/CKbKjRVfPzFlBIBUTy1XF1F/aWOBdWYxJkP/gM0BavGHd7vVSlrj2XuEteWNUcSx/Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899959; c=relaxed/simple;
	bh=Osm8FwzEWwTqvyEjxQO/4DTu7yE2VnXDsm1zoEyTR6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noCWxkrBCwnS45AHbo0FSiwsrII2JMBHHT9gfZYlvfORy9Pi3xiwtzFubC0DsUqyLAxjw50bbzblR9BSAmGLJIxpAS5nBYwE7bwoUmcPyg4FS70vJPfZA2OUkkXT5gaO01j2jh/ij6veDFVxgFcacCQDITOrOqjyI0r5sGNvgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVnqfOo2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMfBDq027999
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ST3b2cawpRPH0esQ1Wf7O32r
	gHyNnZ9xY4/CHojqj8A=; b=IVnqfOo2L2+IlbTtpVvJS9WC4nooZaTrPoOhUi3M
	uLZHFfd4HzCc5wup10LrwEZmNgmHNbEHApCOgQ1boxPLjo8B770uy0HNEJxEE2BC
	wWD4GA4Emvcf1WlzO1mTmuSsiU+YnC0D9YFEi5An29CVsAJExR769Xu29/NWhlF0
	OzM8MKcmwdM9+bhubbb/kntaLNrhLaJ4WmhurTqTG/Y4fwqJr9ykHGMMr25MwDSj
	1OcJFfuas2bp68GsrfjG31KH0jogi4nK48m81f4VR8D7Wi5yPLD6Yy+g/JrbYCtr
	gDLsQQWe1e38V1bTLi/ZDXkh+Xa08uuxkkDvlQqIREqdcg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snjx7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fbf0388eso51937651cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899955; x=1758504755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST3b2cawpRPH0esQ1Wf7O32rgHyNnZ9xY4/CHojqj8A=;
        b=NGjIWUTdpE2CHfVg5vmWI/d/IgyoiRXapDBAGRpZxcsb3faxlTR9nJcGM+mA1dMFUG
         unL1SfoL73n9juKR3lirsaG+weD9qGxG2dtArLy5MvZRZWkCZg616ZzvXMxUGJuBcppm
         JrANlldxTIQfsWgY2weD0UJY6mxwrkTXaWtWrZ5+9UHKDJZXMsMR46+Iv5ukO/r1U7AB
         ETUDJvrQfsgZcKirK8erp928IvOG9C4Ik44YOU+WAvBc5sWbhTwCl51BB3j5FhqWLCCH
         /vvCrZOQRe7XUVgqNXdkJZv/qfcO1s/Uh+ZSLxgF5LrLY4O51weG6JuaUSyf90b3OqKP
         8Znw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5dzgocfOq5BOxUCAJp+/kx/qdoRTRKtg2TklaA5nhLnOvNQScvLKHuszt5eutQ7Yf0hmSWVKX5eEp5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZ8Cw/9jtcnTtHXpM4RiOzR3icC3hNx+KlTCurmMyAzhq38QX
	0LFnDYoI2/a/LdH7nCqizhyUgosZuRkUYnxw0LDto+NxZTrdwOtwcaqsK3fAz7Uf47uuwqjeB42
	Ow/rxfG3iLS3lDUBWMOdB1dAuXoBRyHBnXEY1+CJ1GRwiOaVGPbocUIjZV5hvGEJowRg=
X-Gm-Gg: ASbGncufKvB96uIjRGGyZvjYCIhwPtTmTNKRGDIogADwwrbbutioBWm21WURO/FHuBV
	2wLoSZEPgkUFevmfMNI2X+rq4trt4ZVX9XE1zma5IOYRLmqjWoD36DwlIjBWif3IBp8xUNuhq44
	tJuJvJb1fktihpEULU7bzNcs2bvHnCSk48wTOXIERRL3nfBR1O7kVXd4UiYahZhaHMRWevGMznE
	1289bP7PAbj+5gPLVENFytHFO03bSCkvbIuGv6zeaS6LeY/8zXJK686RlScMTs3hu8iU3G4PB6p
	caZ+rOMYI8jtvukPohtgXK1xiKUTTw8zA9GCgQEZTrnSAYn2G47DTzAROh4kAhj70UIsYN0wmlg
	Yp29nJqLpnWMBvefP8fPXvhTAHzD04auf18WHoFVab5V9Q0N7UfOd
X-Received: by 2002:a05:622a:190f:b0:4b5:f244:6657 with SMTP id d75a77b69052e-4b77d088cfamr151799741cf.42.1757899955144;
        Sun, 14 Sep 2025 18:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6cF1o+2QP6A8Gn1xpsG9Czqm7Mk4MfMcoDav/2V478LjICYRPSnx2Q6cFIGxKJYVHTsTaw==
X-Received: by 2002:a05:622a:190f:b0:4b5:f244:6657 with SMTP id d75a77b69052e-4b77d088cfamr151799041cf.42.1757899954420;
        Sun, 14 Sep 2025 18:32:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5dba7604sm3253156e87.59.2025.09.14.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:32:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:32:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dmitry.baryshkov@linaro.org, l.stach@pengutronix.de,
        dianders@chromium.org, m.szyprowski@samsung.com,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_channel_eq_ok()
Message-ID: <tttt4dlt4qptu74yoqoit7y74agp7miwkohttwaru5moiohlpl@svhtznao7ujy>
References: <20250911112756.4008435-1-damon.ding@rock-chips.com>
 <20250911112756.4008435-4-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112756.4008435-4-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c76cb4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=DaZMDFdP1wNoyf6mN4IA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: bekhkWd0n58saXZ1WXIv7K2Vc24ZLrL1
X-Proofpoint-GUID: bekhkWd0n58saXZ1WXIv7K2Vc24ZLrL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX5WqivsVUfOtf
 RwOpzBqf7Yy/pwwfNCfjV4OYSdPH34HlOIsbKWKS2Tng3uQmHvlfV0NZsv1GuzxK0ITmeTGfqKg
 pcnq5aEywqK4k7oYKEOVC7r4UxM1a7R+xRGiiDdVQt7kxsimlD3XuIyeCVUB9S4ztIwUrveHB3k
 dAsltX669rzU9IMTuDcjBsCM9wKvkiOlL+3uaX4kcyN3CBSHdkSX3Gck+/DSnOK0fHmQUpwtRvG
 0iceEdCs/fPA7G5iI2dIjQBsEkqFKviYQ8S6hCy9pYrSEiRQKPmqyTBpi1GctNK6iUw7Zux33/1
 HIlyTWRZXzIdTJf6emWgtc1eMskXJ79Waw9m1wIBjwf4Afy+yrt4YTwYb+/loAhH8h0122PAU51
 s2IzrKbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Thu, Sep 11, 2025 at 07:27:55PM +0800, Damon Ding wrote:
> Use existing DP helper API instead of analogix_dp_channel_eq_ok()
> with the same function.
> 
> In addtion, remove unused function analogix_dp_get_lane_status()
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 49 ++-----------------
>  1 file changed, 4 insertions(+), 45 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


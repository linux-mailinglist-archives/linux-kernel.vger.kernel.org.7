Return-Path: <linux-kernel+bounces-746716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF0B12A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AD154664E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17CB243367;
	Sat, 26 Jul 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uic5+gBJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823221D5B6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531446; cv=none; b=cxQzi7hb6Y583EOQA9PdRmXTq5TUG0PqQ9Q0cSRBpli1bgPeJ11fBhirMjc2hR6f5lY17iU6QNrJyEWJ7s8G+QgtZWOU/8vRxRTD0Dr6aVRcExjBBds9CZrPfh4NM2OEQP4pARa2oLds+euk61MlBPM1VW1jQtz8sbYYZnbCgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531446; c=relaxed/simple;
	bh=SUqmgY85eJXAlsObLamKQHNIuUnUl+Ry5O/dMG3DM0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idgRiQMMj26JSA8SyNq26DydLSnTLteCqw+IGkUI3ZIOT0ypcRDjZ9wF3bHJS3hlb06P5KRBgmsVNglbFfLIpPArWJFUG6eri3ckmzjSi3R/66QsQRtcjMhWRv2VRe1BWoCyrG5Txk6UxtOqWkCWhcspM9pzy/0UrhyMwjIZNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uic5+gBJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QBRwZN024777
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VoyOpXRtg8gribBcwI2od48J
	idopHaqstqRQI8GRAvQ=; b=Uic5+gBJ9Cg+damRxJqNwUobzHWxb0WUFthMrxQ5
	82CAhudDKkbCP1zzrv/qSse5/vBH405bLWg/Zt5Z/h2L7RgyrDAO/2dJi4Upups1
	23cW9WrrbUVAiVKjQOd8HXVmMdEJNZkKlTZGXc1Ze5GqNdNhRFFuIwHUcXJnxB01
	CSDLSBgXOZA2skOgtyuOOgv2F9Pb3wNWpaTcLA6j0dINwirELFTURIs8MVIPmcXB
	LGSuTAzFxblbw9a4VNTarVC32W1p2HUdmCrW7Sg6a9toI4PQZicsjHYyaVa0iuI3
	onYYM6JuMSpfi56WDDAtDVSfogo/7h3X969T26iYpa9aRA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr0tuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:04:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7070645452dso43457456d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753531442; x=1754136242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoyOpXRtg8gribBcwI2od48JidopHaqstqRQI8GRAvQ=;
        b=aH08Qd3tCljap1fV+yRVd7s7D2EhnhynTP95vfff+mLQvDhHWlCa/UruPfG89degfR
         CeLf/RdwmHF4K0h8+1TOHAetZEf8QK2XprxrkCCC4UBHl87/PYe+omAfXTTgHxKs8Hm0
         ttpTiu31l5XhLMSwQLSG/DZECrWSf72ws9jbgk4omfL55tsrPPek+uMGrV626NWuNJIx
         fal2dOxid3ZAwm84lYqNQIQow0Z4bOdRqutQXhCPV+qyD3zDOWGbAUGKx5DrqTJLEp5A
         SrfvU81KvfGwym5NQRvBoFDf0ZbZ6LOfanpeRupRp5MvLMbEw7OdlDax8x2Nloo5BAfp
         ykOw==
X-Forwarded-Encrypted: i=1; AJvYcCUwIzLL2PyLh/l6MCrcjWKtJKfxwhd8iPOt1+lKDKXbnp+HAWggsIt3uKPyC0AQHgm1/EimtJ3YHOHOpfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTd1NdF/5Ma0A/R8+GRBQsUYmyHGxVxT3LZbRuLWduETXAdFCz
	qA0AVgYNXFNEKFHerDFxhw4f5JYHNlwHIYrnUoqAaPqUS7D6ql72TgTD3T9kl+363jqDDV5j/81
	1PIlWpuaKqE5bGsI15uMnEXEy5dx5oehmjQffVhBCjeBE3DKbk2mcL70NScJP7zUAH2Q=
X-Gm-Gg: ASbGncsdaF8GSpQdFJ+f3XlSPfNHlOpTKNa3PgQ8cFfFZE3kCoDMJbbIAxm9pHCfpVz
	iV7BIgzroo7EONh6x6nmQ/LSBlG8+kO5EH0qbvlrWovwELEG915pCohAwWcmnE4mKjC/yPb6e95
	8pJgeh8VLUNc3+Mr1cniKdgYq8G5h5u3ui2CM3bA7hZSEx677oKNJ949ur8g3xJls45ss42XZJD
	Jzn+ijitASq6/9nV2w2gM13sWFzPQuut3AjP6VX967tKO4VwYlMNk2PdKaWWKq77bOCbYXGnWi/
	2Ktqm4xX8GjYafFYDQ9niKbJ9LjXouKEGA2qVUbnBtXtu+KyY0U7c+QTeHSabdEblWVCNtUjVkz
	4gq5H/jO87jVeepgCodqA8xrYSosnXLpZDFB8wsw6i+3o3IwgRHFU
X-Received: by 2002:a05:6214:21e9:b0:707:2c79:e7d4 with SMTP id 6a1803df08f44-7072c79f177mr39705226d6.7.1753531442348;
        Sat, 26 Jul 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE58ci26k7CLxO9KIg2k91tBSPq0VEHMytUV57ob5dO9j8+ZCHVsrHrzcPy3gVkj6+ng5cHLw==
X-Received: by 2002:a05:6214:21e9:b0:707:2c79:e7d4 with SMTP id 6a1803df08f44-7072c79f177mr39704146d6.7.1753531441626;
        Sat, 26 Jul 2025 05:04:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d924sm413275e87.43.2025.07.26.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 05:03:59 -0700 (PDT)
Date: Sat, 26 Jul 2025 15:03:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 10/14] drm/rockchip: analogix_dp: Apply
 analogix_dp_find_panel_or_bridge()
Message-ID: <c3a7fptnm7vxpcz3ouzyov2woi4btknb2so7np6z4iq4anyodp@ajgkwlc4khga>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-11-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-11-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEwMiBTYWx0ZWRfX6q5q/sXEftPz
 Co1+2kvqAKTagyagdMh+Tif3FCwBgrifJ4VLAFBEeFYr2aN8MxJUJ3IORldowg6TvkbHeULiCXR
 umuMLTe3DyxmJfam4NmAyu0GTM7gwO19g+aDOlMbIl9+/Xid4Q4AHJcI/lMfu1EpO5qrvtDS/Sj
 DmNyYGP/8ez8sC0m77CsphVMZFUvMETtDoqEyEmIwUOpJvgzabawc8OHvgtqHR0azXDNG2EoBkA
 K5qCE0psMuA3HaN7OvNwknomw9NWRrFWSnlZLBGMO/X3/eWPzVH6uTbP/itHEhG0G3SU+k/wdoN
 Qlj5lnjFJ8Nv7Q5UQIv+aufTf4VPecAX2JC4/TU3rStEZbYxaa8jYuwgTTYWfS3tZunHAsHsG94
 RhITVj1kdsUcxqUq+iIA1v2YxekA8L9XZnbRlGiH9RGAnzFTYHHNt6MLR5ZXpUPGk+mcfYnR
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6884c433 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=23ZsHGXRUfRepE-eGp0A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: rXf7sN7WSV0OxAB9tu3u_nEHSKGqEN1_
X-Proofpoint-ORIG-GUID: rXf7sN7WSV0OxAB9tu3u_nEHSKGqEN1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=718 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260102

On Thu, Jul 24, 2025 at 04:03:00PM +0800, Damon Ding wrote:
> Apply analogix_dp_find_panel_or_bridge() in order to move the
> panel/bridge parsing from Rockchip side to the Analogix side.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 38 +------------------
>  1 file changed, 2 insertions(+), 36 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-753450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E441CB18334
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761F917AA1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11308267B02;
	Fri,  1 Aug 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rh4XrDsc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD0265CCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057175; cv=none; b=tBsDJ4XiW7FR4ZbdRdXcIqtQUD/P+rOTDEys/Z+RG1cBsL/5DZz4xis+eYKxOwabhdlpS6Leaw/aic7d3WS5XbovN/bHTZeRHgWMKe5EoNaJPbNFffLhD4STz5yYEtBD3qdUglSVq5LV1YWx9GCezyHG6D42lmuSjCycaIKfNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057175; c=relaxed/simple;
	bh=VLSSPUAEgf/21a0FI9FkMbIoNE5G6WCgHQNfx871jwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCB1J08EW6ue7jrd2Tk87GKZ1I5Hy34CA1OXsH9rzZNNm7+0bXkdl4YZcebX2lRHruP7/bftkct+BXmSvkLIQBfk5iHxjKGoK9vudeD5+NqI5PxFRMIF4V1+3PKHtHrDLaX1CAgt0XRb3DG5vCKewqb8eeSWbOg5vtICvDI+F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rh4XrDsc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718wPOq024692
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 14:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X5mYO9TNcqG6LvwHvkvNnoW7
	mrgbAWbzpJxMDANF+yw=; b=Rh4XrDscXyf2Oo02oBHA4UuChG3U+1dh+T7OZAib
	VOuvM1m8SWmIm9s0HizjkP+In4P+XyxFB4XZx7IO7Jk/zzYjW/kIu9MAoHDfanDt
	ZK6ZqoVyXjZ4oZ9aQZ//45SiMCQnN1Md4SWDUjpVylMLrsI6fDTO6e1lMPCbcul0
	oj45dL+plcwt4ZOUYWeVSm6+aXgBwJX1E3S9fNMRuKw5jxIHAfkXX8Cu7W2h2xE2
	KUNOSM2i5MN6SzVqn+zzuAD2NNXnZ3nFwYlKDBiFE8zuStZ6F5rYuv5nXO0iq51Y
	M0bXcC1Vu0z1BSpGM0cpy9kLcSbf0lYPsu/KiiErHey7GA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g4h29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:06:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bc511e226so1831047b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057171; x=1754661971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5mYO9TNcqG6LvwHvkvNnoW7mrgbAWbzpJxMDANF+yw=;
        b=K/AE68SOOUnGCrd7h5hOC+df2vkv7nxyyoswEioZYnpDXOJWGRiLydYgIDuot2YvHD
         Y7j+oB/guD3eCOZg0O1EaQFjI0xrbUBI3C+gDcCD55Ms4n9BkFk2zPrySrdjNlMUKtMK
         flwWthR9yMNuuOkyvpjhH2nCHIEtcFTHntV61dnxza+2CAj6mQazkVM1xs9ANIu+c6U3
         oonMMXvPrzqk3p5hw7zkx5c63qKOQrsWkGenHwJytXB3jO9QIqGYJ7BrKC8L1I279gfX
         6tiXj3Ur4bpVIQfD4ze1PXAjQO5B0yDA5S8tpKw422w9nJAnm56ZvoJSSTAmgL3Ep3ap
         uFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4RkMnpbmTGdtTA2qt1OBFtvguBEe13LvfC1yufES674SESCN9VxxUVmaHpOIBRk0yimn/51iu6CHRB3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PgPnqNw7+Fbpr+vtHpZhPZB3EkcKalG7AUMnAgm1gUSdIea0
	A8c+aMP63esbv+nL/fGSvoAEqjTJGe30IpNhh3i1NNmEWVUOjszLGWqFzv5aQjbNCT+x5LJV/Tr
	nUtskt8DkAaOM80tmgrMwJ1SoBZ4cXMfKW+sgj53hQFtwtS65lINUDTgOq8dlNnGwsWo=
X-Gm-Gg: ASbGncuP/xEebD7MckURDxwXDWIBS0Its8oBuqHJrEegsjMllD88i7a653r4pvKL200
	5LyHKvABSOQqgS5shnEjfLc7KYwOrLZsT5TvCjU8gN9VqupTTvcHBzSFaLRhqezB9ucZYOn+A3+
	j6H/ZULCAPiJx2mka2J5oT1C7+KFxev66e9+S/neSI3D0HQWaUr5vKxlC+YMp9FWuyxfM6tbcGi
	ZxLwnY6GIDG8eRKnGxTagQkA9dOX276R3YZ9pBtld5gXWkITgtKzfuOshAeAZ2g9ydkhcdevuzL
	W9D+LBG1ubaGdUP1uITSaXXOu7VfcJVS1KOdv9vx6HVJCMD4tZQUbn6+LzAyGNotOd+3ZNOMBHU
	C/G6U0iSLw/Y2dxCiGwJzxQ7OshuKuMAmgeUCCnAldcFfLQNpU6gS
X-Received: by 2002:a05:6a21:33a5:b0:239:29ea:9c97 with SMTP id adf61e73a8af0-23dc0ec463emr20483674637.24.1754057170890;
        Fri, 01 Aug 2025 07:06:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGitYNtTnXOBq8raaQNZX9YeStN7g/CeoibFIFiLag1gYHl4anqkXU57qCgbVhM4DI8a/qNMg==
X-Received: by 2002:a05:6a21:33a5:b0:239:29ea:9c97 with SMTP id adf61e73a8af0-23dc0ec463emr20483562637.24.1754057170060;
        Fri, 01 Aug 2025 07:06:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fc7d0sm5621721fa.59.2025.08.01.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:06:09 -0700 (PDT)
Date: Fri, 1 Aug 2025 17:06:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <z4ewbwtrqnem3af2tuket4wpgsulo6f6vy54hnhxrcx56hdx23@i5nuuiw3j36g>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688cc9d4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=noEQxEA5MoPOL7h678AA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 6j7ToCRRQ3j2QCWill-UQN4XMjMJziiW
X-Proofpoint-GUID: 6j7ToCRRQ3j2QCWill-UQN4XMjMJziiW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfXxFDnIFyuzjuR
 eFZcFyZXyrFqJ/YweyNIPcBYvgRAjSLJilmJU02Y4RyVkdYKFv0BQMlqRDhaUHuTSfFEshxcsHF
 H9hWKxywctmwreEWP1LyYnCoOIatCGcOhqSOklj5/xG1Xm2lwb2HxFTYzX1b6LHSOjSoA/7TvH+
 kvJijV53FaZYGsuM3/hqfLNQZwQzm3OgdiC8iKaaHLUMsfPLITEPmVP4K4jTjSM91Zxc7bKCnwG
 0Zb6Qi8PeudfjAEKblwkYE+VPCmJklvbeNWzjpZ2ZyHYFYNkwrvjtgX3XHcu5GGF4wEJWAzgcOa
 xdj45lUTUXi0Gd8KDSEgy6ub0t6y34wTe3Wbxh1ZHOc5XIVLG1Bx4JyLemjfuilMU63gaZZCy9l
 3/LmJ/KXa75hwxqyFQ2PPlLBxkAXn+rZ47AvpKOJ9Ab4JgSkGdPhK4zgGN95ouLP40NRoC5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105

On Fri, Aug 01, 2025 at 04:51:13PM +0300, Dmitry Baryshkov wrote:
> Use drmm_plain_encoder_alloc() to allocate simple encoder and
> drmm_writeback_connector_init() in order to initialize writeback
> connector instance.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)

And I used wrong subject prefix here... I will fix it for v2 after
getting feedback on the series.


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-810905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE5B52159
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A537A8FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0312D8DDD;
	Wed, 10 Sep 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="avc37zmE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8261272E7B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533482; cv=none; b=UIx0Z2i+J2gGJjDICxIv43MMCvUPWvE/hZhA6uQz200l7Mw3cL5d5cA3jiKelyhX95P9lUlh8DJkWE1KDSFjhwNIBWhWAzokkRaulBGEb4n/tMLLE9qm/OQc/Y6ck2YkmMWy0ltdNFPQwOPUfsU9kx1qA/kj4X0nmxARfT6K9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533482; c=relaxed/simple;
	bh=TvvbGJhGoXgTGsOsVrfYtmt12BEe2nakx6B6C3BC+qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMub5LZwftWtUTBm30pIj37GJUwnAji9pga/sJWTIvG8TAagZa8hRrV8l6PMAJAmUajD4YRq4nA6fW5L4Mc1Zo8Spd9Cb/ljcS0S5xEeTN1kgDO4QZGtsfLIZ/xDI8Y67/BrmPR4KU9HZLNkEO8RGUh6HV0RX8k6Emltg3/M21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avc37zmE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGEoCX017247
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MRFwGcw4G0+ktZMni3vfLtmQ
	O/YRU2ZQtqpoFx/hjaA=; b=avc37zmEzVW7YjVsxItPhtWI22GJZQQOvskkWisI
	fAPD0eUnTWrwGwoiLO6/vxsGmyPbq3IOT3bDNSVNVJ9Cb2MPH1f/YAmv7QAcY8Lh
	yTzmcpRFSSiZfYNDmLTj7y+7A+m6xea7WQH0GmwOe5wmaLw5jv5tY2TEC0YocBab
	CzOvW1/dr2D6JZc7kOT9YGSwQkckprDcudn/1rdT9By0GObcCpBRtPZxTT2b7c1e
	QPuKJ5WTYEV9Uc7qEOByIVZQUFjqVgbtBlcdN/okWE5aChurpHzl8cLP8lDRQrBc
	PU9xSiqsSMWBtA8NUcn7IkT2woCXAPQ+JlIxcIPC+4K4PA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493cpb0kyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:44:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-728a71d8fd9so12623216d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533478; x=1758138278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRFwGcw4G0+ktZMni3vfLtmQO/YRU2ZQtqpoFx/hjaA=;
        b=rVqqqCRGvXXbBgvBXA1NiBABfaCos7BTeBgxCMnAFMnmMNl1+GbZOqRzvZXCDePB2b
         cIjtW33/WY1sHli14ReA7OILUdJ0kZuWciTB3BriOJi/kLKuYmLf0a/34eyRaAGWwe1r
         0+EN0NOb6IRHzRX22uaTx5bR3JiXWeg6OSYMrHGIX+ieztIiS6rBPJSSm9j3a73bTs3A
         fTBNrjMzCO6jTKih4XscvjKG4vAOqxNuG2tb7hy8QPwaoJkrIkGhjnMe+SUXGIlDuXkW
         19M5u9e2AMORd14JmO9K5t2PDaGdVhsUwjVF/m+eRDFpyrbIhmXpFNq+Jnl/xRl08chZ
         5b+A==
X-Forwarded-Encrypted: i=1; AJvYcCVZlhmz5iHNMjosNbLiJqCDgQO/FIErNPUrY9P7oBj2+0P5KUvwZUmrHYio7T/OUYgtBw3vy0K6Ppoq9Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygqu8ii3Ho13I6TiR2uvsCWPE7CkheQaUPQhw8Kz6o9xvHWS7H
	AWMoZuryd1LYowLQ3EdDlHpc1kCmF+OzWjuFDRG5BCCcDJ+90Pqs7kO6iOe15pcz46SRhrhx/cT
	1AWPWvyZWgQ/7QTYKsFP+D8jb6aPt2WBB2MAjhO5GtAUNSOmw41pLfkT0DKniXb9yEHs=
X-Gm-Gg: ASbGncsHeZO3ejTUywwxokFQZFiABKVjky9WI7R2rWKX1k+j3yZmU+tJs3MGxnI80iE
	FEHa2gjh5NNSUcBKzU1zEY17is7TOIlhZU/h0tIEaaHdua5c8NPUIMyUZHuWAvBvrh7SVDB29d/
	ZQYsiKNjNzXOL8tpn71rBvmlC2uhx3UibJd2oxSqZknZmB8Fl1+20d7Ls7FbcdhlADs+Sey12lG
	knEWuenQYbwq9dDo/bkl+HqfOFC/MzZbcT7gt5dTy9sGoiE/VMlgqQZ2Ao6heVBF2zF14+CyZS5
	iewYExhIQixCyUQlpwSt5nBEEsN3/JBQeYCTcAKw9m2V0s8VxFQH0e9tXPHDdmfdoDOPBo4UnMd
	ueWWXhMfUg8alh7rzUD5uZe08Jnid8dMtjjVJejSJsgzCMf6wv1OY
X-Received: by 2002:a05:6214:d83:b0:722:4cf0:43ca with SMTP id 6a1803df08f44-7393ec165cfmr207442996d6.36.1757533477906;
        Wed, 10 Sep 2025 12:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLTybLfL00fFfCA42iPicU5GPH+S6SfBfiUJaoauFhGCNadtLOwQ0vunk0e3CAte+J5/R2vA==
X-Received: by 2002:a05:6214:d83:b0:722:4cf0:43ca with SMTP id 6a1803df08f44-7393ec165cfmr207442566d6.36.1757533477313;
        Wed, 10 Sep 2025 12:44:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c4ffd5sm43997081fa.14.2025.09.10.12.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:44:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:44:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
        arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
        harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
        liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, robin.clark@oss.qualcomm.com,
        abhinav.kumar@linux.dev, tzimmermann@suse.de,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org,
        laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
        dave.stevenson@raspberrypi.com,
        tomi.valkeinen+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [PATCH 2/7] drm: writeback: Modify writeback init helpers
Message-ID: <nw4ehd7a655rzyf6g5yxb3z25en45esja2i5uowzy4wpmb2el6@orycag5iccho>
References: <20250909100649.1509696-1-suraj.kandpal@intel.com>
 <20250909100649.1509696-3-suraj.kandpal@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909100649.1509696-3-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE1MCBTYWx0ZWRfX3az9d/ydLWzi
 JFjUHjQwH3fDKuK+CZMum9eZrXE2XdwlSR9+V/BmvokTBRBQ8XBVuvc/3wT+MuRwhFDPSi5RNb6
 27/SD/d6IlUKBuxDPHNkvV5xzLkce/iezo9ahuLuDfs4Kb48UPivaVqnVd8dPjzfiHIYznv6MGN
 fUBSgfo8Jgk3R4nbHCxIPDn3ZChUwWu/gz8LTX+x6uTpxoxqs49KZDIbbPcBWVG81ndYHEVz6gi
 h29p/vOnMBWPk4N9ATx7yJfRbNIhVSNQOigopLOmjZOkaklilNlPtYl8syupN/tgJwlUbgUrQaK
 WVSevVvkrQyYS3Liw73vo8AqqtRqFAGZe/iRBb8ccgVwRayJScvD6PBp739gjBAtWfQZJljRvWK
 xXTRR4MS
X-Proofpoint-ORIG-GUID: Pb8k2S2QG6Q0-TqbuGe4DmAIjT3i5pGR
X-Proofpoint-GUID: Pb8k2S2QG6Q0-TqbuGe4DmAIjT3i5pGR
X-Authority-Analysis: v=2.4 cv=P4k6hjAu c=1 sm=1 tr=0 ts=68c1d527 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QyXUC8HyAAAA:8 a=T65gB5C1oy4ZwBZl7KYA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100150

On Tue, Sep 09, 2025 at 03:36:44PM +0530, Suraj Kandpal wrote:
> Now with drm_writeback_connector moved to drm_connector it makes
> more sense use drm_connector as an argument rather than drm_connector.

than drm_writeback_connector

> The writeback connector can easily be derived from drm_connector.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c |  2 +-
>  .../drm/arm/display/komeda/komeda_wb_connector.c |  5 +----
>  drivers/gpu/drm/arm/malidp_mw.c                  |  2 +-
>  drivers/gpu/drm/drm_writeback.c                  | 16 ++++++++--------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c    |  2 +-
>  .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c  |  3 +--
>  drivers/gpu/drm/vc4/vc4_txp.c                    |  2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c            |  4 ++--
>  include/drm/drm_writeback.h                      |  4 ++--
>  9 files changed, 18 insertions(+), 22 deletions(-)
> 
> @@ -338,13 +338,13 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   * Returns: 0 on success, or a negative error code
>   */
>  int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>  				  const struct drm_connector_funcs *con_funcs,
>  				  struct drm_encoder *enc,
>  				  const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector =
> -		drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector =
> +		drm_connector_to_writeback(connector);

You can use &connector->writeback without extra wrappers.

>  	int ret;
>  
>  	ret = drmm_connector_init(dev, connector, con_funcs,

-- 
With best wishes
Dmitry


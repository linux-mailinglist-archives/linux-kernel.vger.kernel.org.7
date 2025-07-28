Return-Path: <linux-kernel+bounces-748282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A05B13F06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A7B3A3C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF25273D76;
	Mon, 28 Jul 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZkElJdW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8E270577
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717302; cv=none; b=dGtX3yGttcZONXhfEZzyil/sco/9ydAc+Wmm9aF9URUMj7Zs75PJahUJmHOdcZaX3j7Sq9NLZMzNqhclUjrLQo9jf/Dup2u1vRBDYksGYLC86BMSmxHsFGoKkOHt8Qegbj+dcYAk+++jzNmSV1DQnZms5tu8DwwUZYHoBeOUGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717302; c=relaxed/simple;
	bh=hdJsDJKPyr75+ph9h6TokU4Xwpapg7kRvrcQrLntIW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG+b6jat3Fvf23aSXzE9RLecG8hao9zWODAflzjB+CXXQ/67p3Wg5WddH/g9qtaEcR8BsFDr22JqYOuYaGaz9rHhkMukkkqV7KusR1GwqkiX94mkSV2mE9bEBzlKcRYAyCam9uZampdbh7K4KRgyfWAh+N0Mzxcei5A8zrOLfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZkElJdW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlNnv028210
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EXq6VEpL7hYqGBW2WEJQ4EO7n31vxijncodySag+8ro=; b=NZkElJdWIaPOV+oH
	a1qltXjv0wJHJEAuu/lNAxBmzPvVFTb/6Zuor1TJ0yzyia3WtSWf2L6hb6jzZJMS
	1gSkUtpnPYeRHgz+lVoXC+ryYz/JQChoGW4p3xt90ypRL5J6oiWeGJOQhxYjVP9H
	PVtlREepbaDx62KB+iRIRb6oNSgmBVFjZ523vf4hawckgHA13a6VXgo8gkxCn1D5
	llQgKzA6PyVzHi4s/Kw3muWJ4I3/kkE9UPrqJgJt3scGW0BRdA4rqSAx1AfT+5Yu
	mLg2Uf7p2jeYd3N/5w2b8ntMiy3H/ZMEByo2pbpUJXKhUvpgVU3QZb6ZykFzuIJK
	xvqKhQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2d12m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7048088a6fdso74992046d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717298; x=1754322098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXq6VEpL7hYqGBW2WEJQ4EO7n31vxijncodySag+8ro=;
        b=nEqDDBvZA1fU9cFsvUYWad4G436V/k8bSNsA43ubSTIofVba/nRq4dxrggvh6LcflA
         +TtgdHYH2phAQhddWOfXEfUJXOSBnQC6sjnR2bOqAFvGzFWyOg8QeqCLWkgn0DmYZPPK
         Ee8l/1mU1wu9siLtDzv7dMoyy14wxMFMpuiF1EAabFwM7+ScOfFtKLVPZULCBIVjKPRB
         bJtHA+qlAbaMRjiQuhk0Q7GdyZIrn0ewheEU+T5kjWRiuyw2J+JRMxMuhoyRr0pbqAi9
         DLJSNNNPra+MKSvJ5AR/fb8RUg5llKi+P7RDtbg2QutB8BBHlzGH2K8qX9DyyU5Fe7Ti
         mIUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFlZGA/LrQPrDclYqgA8y/0SU5pHcQqWdaQcSl4R0m9aNmsOeLcr/uVvsfNtD58hMu1x+NsFXrnzEFFHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITM+8x8eqbfJ1Z17a/W83Zf0Gp9tW/D4qAErx7Cyzpon4z62I
	io1khP1GW7RRUdiOxZlHH565rga+64bIFfiPzwVeC1khWQWfJXlAaqAMRzxFZj2B0CACz7gOKFV
	/NNkqSOYbgTkmk9T5veEh95LTAcZIaG5vgIL8SOSmorkJRACJ4hLkRjKG5EF0nrFpR5I=
X-Gm-Gg: ASbGncuDM8dR2EcZbz0fH0izx/UdVon+f+lxNiHO2kIkq/ztk35lMmKsjs/Eq9RlSmJ
	AGgs8v3inumcHeaeeNxV9eRh/Ktxru+d9PfFjMUoCrzCN8K9F0Fnc693Rqyfl0wcTztlc8Bcqk4
	hoi7tTcke19SCI+8AIcBcySjiFIxsmf4RAkCKHxRr4lKFo4c0PfEwgueE/ZW7FOOodUAcAL8iQc
	Dp31n4EecD9NUS/OQw9kSWazHw1SXLIOdAGOljEhy17Me3G2qRoc7yfKTuUPEFEnjsmcFETMjen
	ZOII7mUH/D1nrH5WCXYKnbxcNwrQ1V3UHzWaL0DwEh7yMx2N29bPizPgK4EupZQx8HQmtGZt5qK
	TCquluNfmqiUAfm8DXMVsHT5bfqEOmFIantl6LUxpwPE+oq493buV
X-Received: by 2002:ad4:5cec:0:b0:702:b805:276b with SMTP id 6a1803df08f44-70720550e3dmr176120106d6.20.1753717297826;
        Mon, 28 Jul 2025 08:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpkAaEPkqVbrDhK504iZlESPvKjw5q7ogUAbju/dv5ZjpgMNtfNlbQNxM17o0MaH509yAzQ==
X-Received: by 2002:ad4:5cec:0:b0:702:b805:276b with SMTP id 6a1803df08f44-70720550e3dmr176119496d6.20.1753717297082;
        Mon, 28 Jul 2025 08:41:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63363508sm1329723e87.116.2025.07.28.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:41:36 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:41:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] drm: sprd: remove plane and crtc destroy callbacks
Message-ID: <wtzu7loep4cacjxe2b2bv2xcwac5sq7v7b2cun2sgeaxisqehm@hrlk27wejnny>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-4-e4344a05eb3d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719-ums9230-drm-v1-4-e4344a05eb3d@abscue.de>
X-Proofpoint-GUID: j93RvltO4YCONpSgTlgtaKQ3Uap24Awg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExNCBTYWx0ZWRfX0R9/AcbdSIsR
 6oSc8Wxh6mLwBKmgjFlX5rWIwpXmC7wyzZiUAZk+zQPxrs2tR8tDBwnq5R/CHTkJko2ZB9QcOir
 L6vhG/gwcoNgUBFB4TkmdbLwBSHV2+6kvyxUkCxjWfI5Z0Vn4G4vXXB9oXEd0etLcraqlqy1Au8
 xgUViGKTVoeFnaaaHf6SVRI16hLkRUrfgGQDRpc9sNnPD9vdrjumYv3wwRuDs4oR0WA+G6JZDIR
 YhxY7GJ6L6fTdM70p8L6jWB8ttg4c3HWHtrTLP8uzxsQzWALFm+XgVymHpoAuyLAx5sDSCVgWYo
 ndIXm3EA4h3BU5BQ/tW3R12rwTkDqsQSto8U8kAHDkWvR4dyRrkgt9hd4Um8AlzsCbaVfwEpKcH
 +hXlwMzFpfj/U4ElHhTMLxUGvb+mhmNXqugMZvyQyx3ZqGipJiFhd/p+mc2sOF3xpi8A/UQ/
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=68879a33 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=mw97kSRHHgrdNCgrsq8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: j93RvltO4YCONpSgTlgtaKQ3Uap24Awg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=829 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280114

On Sat, Jul 19, 2025 at 02:09:40PM +0200, Otto Pflüger wrote:
> These callbacks are now required to be NULL and trigger a runtime
> warning if they are present.

Fixes ?

> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index a3447622a33cd612e34be038e833222567bdcd2c..0d9eb778794d92418b39f8535d94abde3566de43 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -577,7 +577,6 @@ static const struct drm_plane_helper_funcs sprd_plane_helper_funcs = {
>  static const struct drm_plane_funcs sprd_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
> -	.destroy = drm_plane_cleanup,
>  	.reset = drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> @@ -704,7 +703,6 @@ static const struct drm_crtc_helper_funcs sprd_crtc_helper_funcs = {
>  };
>  
>  static const struct drm_crtc_funcs sprd_crtc_funcs = {
> -	.destroy	= drm_crtc_cleanup,
>  	.set_config	= drm_atomic_helper_set_config,
>  	.page_flip	= drm_atomic_helper_page_flip,
>  	.reset		= drm_atomic_helper_crtc_reset,
> 
> -- 
> 2.50.0

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-842499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC6BBCDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7A189519B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035231EA7CF;
	Sun,  5 Oct 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvC5j7I4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047D158538
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759705949; cv=none; b=aHoxuhqDQefkpqTrN0TZwqjCybQoexqsV65cBD755JpgaCppL9/TrorVFZ2M7349rtctGBJk3DZuZIXZ7rWIxpDaadUWbDxHLZTlbf/XFU1Bt+7PaD1pB1sHC206VDAwz8+zeB8VFzQZuaWSaAJoYxLoz94LPLL8KYvtO/98aAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759705949; c=relaxed/simple;
	bh=Y3Ht7f7nrEpHtlFNdZNsllmb1x0yPFEHbbueGl26KJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9GlM+pK3a6v4YDorSxo/fsWSh+L8QFxZ+PpsVWocv5hNYUwFO7kD3kUgM/JcZz4nGpPaKnK4zTaXLcdzaX59PXfA7poJiA9L1atouLBkNJsyE13nZGieo4ZsEq5DZRN5Ulo9j9OMP5C7+7AQ68cWXWxGQo1UOABtZJKcmdZAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvC5j7I4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595MpcIa022724
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 23:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HHz1XHRoPTjYuq1eGLoVmJz+
	8qY4LFrDTanivRV6fFo=; b=hvC5j7I4Y3cfgL2cAabLQxLD6LV8G+NnR546DdL1
	gulUx+Z/m+83VrNRoFhJEHHjS2FjBpJ7GaF/6wJdmj/aNIUokBAmxVGDYFdYFa+9
	VuLYzCe/n1Q3/4nQH63M9lWX6TQkJxRw7KZhUbFKwqWff8zXcGU+7IqN1tzt0avV
	1peo6TVLJnkrJD7li+sM/Xjb6/3ZTVkGbMahytdnmBn1svTWxQL9AoSaFUSSfqrp
	6WTuKMXfwZLyyxhAFvnFc1lKxeBb2W4PBSrAzmEjak1Z9nLgufmrJWTPRAVY6oet
	V4HRyiS/M3G2VkhOAjDvQx1WvFAU6F6ODKa0ABJEdcuzdQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6thdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:12:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e484dccaafso112194781cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759705946; x=1760310746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHz1XHRoPTjYuq1eGLoVmJz+8qY4LFrDTanivRV6fFo=;
        b=hHqt24KG2uQI8Dv7mCqGSItK+jXoyLQ1jBF4/XV99ay7UAFE+dyBnGF5+5sf8AYfnn
         OAhYNeP/dAbIGZ9SwxQq8Px/GKbYZPbC5cS2vilmQxiY8ZzyDNAwvaDlUmVGg+qfpzfw
         pvnd6oTZK61dG/eBipwoUpPw+qEM6CMIFuGsNovrHNbvrWAkDtgeSWGV1bBoNi7Phme7
         C7zBjQwaknJ3l2++VNx8CULNlYO8ZfEwWQKaCEuMOxN6sK6GzXjPm89RlxUHQj93BC8t
         TCb1wGVqqZcO5jUU2p+GHzN7iefKsyaNr0AKPAu547Shhv1kxEOtc1I9ZTnyIsSXeW/O
         jzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM+19oDW6fYNSvxspPFk4jZgsYfxOaSaIGqs81J0ity3IqoesFtAGf6y5SiTlD/DzmxQnUCQzRgV4ZYKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvDstwuc61t34ToLzHJFkMGEkKg7Cr3H0nHppR40cX0mU8+ng
	6li9HKpTBq9rlzvPFWEUBcBJwgS9kmsTpjX3tmyBDlJPy8Q/ntMYtDCIL2qSHY4m2NL0OMOsVPn
	TF0ICq2aXBbfFQzRVYRlni4dWpt0mK5tynVPKjiOt755F/o7iM44hdL7Cpu+AwsheZr8=
X-Gm-Gg: ASbGnctx/d9xOWztL04DmfJw6/n9ZQJ7VvLqjwOZrCAnXeQOCBFokhBUz5MaIQqjySP
	VTXBcRD0RGdUDCGqDQ0PUODXOXApIJapdJJUKbypXHVLXXdYoUz9D6VHpoKGXoH1jT9R7CcOvKk
	l4FMaWYfhzjMrlG03SVs4KgMpMFNXtwXpP6d7SSjl72yMHIITAm9wfI4SBjtF7RedcO2k2vLNsH
	pWPhCOSrGNqY8PzvXaQq2RxXfK/6Rq5uCTYvh9NyDCOfkxslXmkJCI1l0iGKDzlsLGfVB0r9cCk
	qkoaHa/Z+nqenvtE4Lun+gK7iwRCtGmKtBVQi3wVKspAIq4spVdXvcTC44WSy2Pi8PlNpv9WLgt
	hVeZ1JttbqTbWoMnjESkRe5TlBmOI/QowTIGjmQh3y/hYnEEYxh7/87qoVw==
X-Received: by 2002:a05:622a:612:b0:4b0:6a6c:c8cf with SMTP id d75a77b69052e-4e561bc866cmr187860421cf.15.1759705945754;
        Sun, 05 Oct 2025 16:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvSrZ9fGfo4WCllM+4UshMyxEsLlwrMoEfa4edaPi+oczMnlRj/hsY1Ofr3AbckUjsmQn/OA==
X-Received: by 2002:a05:622a:612:b0:4b0:6a6c:c8cf with SMTP id d75a77b69052e-4e561bc866cmr187859961cf.15.1759705945225;
        Sun, 05 Oct 2025 16:12:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011243f0sm4414769e87.27.2025.10.05.16.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:12:23 -0700 (PDT)
Date: Mon, 6 Oct 2025 02:12:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
        andy.yan@rock-chips.com, mordan@ispras.ru, linux@treblig.org,
        viro@zeniv.linux.org.uk, aradhya.bhatia@linux.dev, javierm@redhat.com,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
        s-jain1@ti.com, lyude@redhat.com, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v7 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
Message-ID: <gtj43rfr2dgegutffma34w5bhvdmvx44jhwxgxb3ficqh5tm53@2iyr6ho3qfdh>
References: <20250929083936.1575685-1-h-shenoy@ti.com>
 <20250929083936.1575685-4-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929083936.1575685-4-h-shenoy@ti.com>
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e2fb5a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=sozttTNsAAAA:8 a=DjEzn2y0vucNjJZnUoQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: A06pyHgosrXfEeRoWRCc1LXRWApGbs-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX5TrKw3vjQVUF
 DlCQTXh/OoVb71238TR71dq0Va9i8LHSMI/EhUvByMWaAg41iRFloW85TwB5P5YiWYDqqCQTL+g
 xHFI/SdmMmTTaLBk3XMpvEB+VnXSrbjdgJ7hTBJ4UEOoKT/jwpBffN0iEgN5OTrzC0A87TvIAPL
 T7wMLDMiRmEybtHQvTwzrSeiE8DplsZ1McfjiGXdTdcFIBw1lrQj+FX8+euzkUZNatYgbBY0KD9
 IYswjgPVj4cBjKP7GanqRJRpqpftgcMVteSXKHqYdsi1cKrFn+jw0x+PuVAqt052OypxSSPMGh3
 QXTZtJHpIorArT1n7r4H7LA6rY3EVm1qG5yxczEyvpVN/wGgP1lOGEOhGalD4a/9BS9QdsAaB5D
 zEWKd4sowkwMI2HWeniY0ZKYLDTW1w==
X-Proofpoint-ORIG-GUID: A06pyHgosrXfEeRoWRCc1LXRWApGbs-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On Mon, Sep 29, 2025 at 02:09:33PM +0530, Harikrishna Shenoy wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
> in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
> NULL pointer while trying to access the mutex. We need the connector to
> be set before that. Unlike in legacy !(DBANC) cases, we do not have
> connector initialised in bridge_attach(). Now that we have the connector
> pointer in mhdp bridge structure, so set the mhdp->connector in
> atomic_enable() earlier to avoid possible NULL pointer dereference
> in recovery paths like modeset_retry_fn() with the DBANC flag set.
> 
> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")

This Fixes tag means that this patch can be attempted to be backported
back to v6.5 (even w/o cc:stable, etc). I know that it is a pain, but
please move all Fixes to the top of the series. Yes, you want to drop
non-DBANC case first and then fix everything. It doesn't look like it is
a correct approach for the sake of maintaing the -stable branches.

> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-813761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD9B54A69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270A91887809
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5872FD7AD;
	Fri, 12 Sep 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KglbGKZy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17842FD1C5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674325; cv=none; b=TKlVmhD3k6YXq+qllHAAf5FsnGmezt0kNwsksJ0q16G2w8pXuP+Yja237zKZ8R63EVQlSuV4MIhO5VFaqq20QhT1v82neCOVHzLGW8Mb2flf0WUS84Ekv8hTSv+peJNdXaHBocGYhU5UKoZ3XLK05pVnL1Pn3pHDmqdRkpEWyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674325; c=relaxed/simple;
	bh=2mCcRgYLTkoEeIMBvhxFuKdvbYMACke7RCFFtoEnbNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwJDPWNsuaLMOKnxj4GnyNhtdFS87GB3mBZW/LhzhGXcR3CPKt3UuTtHb0J6ZoI9UTPxBIr1XM//4jGJImLWGIYllVDurhan+DXALDW5f02emap/uW/Wr3nn5kZtTmCHOa+QK0jbT7nu8kAQboQBAdmrbH1j5KpWSDizfC34Fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KglbGKZy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fH6t019772
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sc6ZaRdU870GtUz0ddcaJRC5
	N+bG/TcHWfDRb085fYA=; b=KglbGKZyau0m7rAfBtql8TcV3fcXhTM7IRNfHSM4
	rF2R3h55HNvAAehUvUeSIJipGzrkTmsIXkpAP4Zp3ct56EckVcUgbSE37bG3m9/x
	DZE8ngbQ2V+07qXuBQAu/PWgi7Ae3u+9Pgjz2t4qDH7+QpdpkOgfSStc1tPR/BIO
	AEqVJgKVNn4mXEAeb1xuKqynNrJoi25eFFzp+dtMBenfkCxG1f80DWz+E1ezUGv1
	3wbBWm6QU599/45i10OCayUyfxJJTYNsHoo6wq/EdlS4qID7rmiAtrd7iK4qm469
	gteRU/oxWdaTh+ANAeoDnrxfKWeYpEBhUjqu0ctuhdO17g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t387nws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:52:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b6090aeaacso48892321cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674320; x=1758279120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc6ZaRdU870GtUz0ddcaJRC5N+bG/TcHWfDRb085fYA=;
        b=WXnzuUnvRaB9vmKtoOCOG9BNpXxftoQ4QlDpW4BvV4Yyvyh4d6CzLVARCDbpOgvPAd
         mlC2DfWIbpnJ8jNzXgm96xqd6LFGOCyUXeEe6eU1Gftbqyae9pLQ7afJOjgksryjuDoX
         yWOmHnrCxMunAbAobfCiljiZgyY7y/4fPmx/ivGRiyEhRqch7Cze2F6Fixc6v0rb3rAh
         uGdpc01uTsP0e3SRCQ+3XmpMoyxP0UKhHWhJhJWNAobEksWUlZlfCoe7Qxw5fJvdqqlW
         vdlNkTS7wxs4S3NvNKjfk6n9aY3K/4zKqH2E5a9m0ZxOC2SDnjmtVaZ+yTdSDF43etLM
         +lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTzg1s79MGskRiKMTvb3aiqyvZAu1c0ojJJNM1QBkqxCCDvDSgiMoNeU8JSIYXTPIVCFPvosMQ1LqA1yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMd9oks41B33dBow8dgEIVks0UEqV5eurCHAz8CeLGSZoeHGG
	TGEkeavkxkshDKsfWw/fxdjPvFruKo8h66DqzF5HLEBgsFL+0IZ++nqgytRcUIJ5AAS16Hw/NXO
	gfmk9G5qwcXsv0DWwgs2i0GXDdU2kVlZ68kQBbua0kh8rWmuMGSAwreUA9JfJpYbuORY=
X-Gm-Gg: ASbGnctDXfAvF+pZckOS8czI64O57hIVdoW0wIMy3P327sKEjIZwn7QR1qw/ovanfTQ
	GB47YYeAquYoxzgwY/rRryC5Zg1z9E39SSgWAr1RG62n7Z8eHUyH15VvzkqCdlznXPrHmJO5lhA
	spQpEKW50iCZ4RRC3HAvigL2136GdqGrZ/hKsE/ieJcuTB1Gn70ur1Sw8uU8XbwST7lR7DNeZrh
	YkfOtt94+idG7SN29O3skp0rUopvEDadnvyC5+vqOXD81IrIjXwF4W5LkJWNVC6FPrVZ+J2rFqi
	JntF8Hd9dqlnLXNgpdMIahhQtFOxqyepDpBuFoGmRyIjG6rzPpmIsUHIsavJKWefSedwGDvT+Iy
	q+pqoxT0dgxa1cnRidKGBWzpkcuXPf7NfMEN/VO0olJ2jyhxKzS7W
X-Received: by 2002:a05:622a:355:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b77d14cce4mr29097581cf.56.1757674319900;
        Fri, 12 Sep 2025 03:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1+roIEGAbRV03P+o9D7MGOVoPmamN2QAkYmfx/FAe0qn4B/Og1foVsAi/kIVH/xOLtFDijA==
X-Received: by 2002:a05:622a:355:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b77d14cce4mr29097151cf.56.1757674319346;
        Fri, 12 Sep 2025 03:51:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a821180sm7960691fa.32.2025.09.12.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:51:58 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:51:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, dianders@chromium.org,
        m.szyprowski@samsung.com, luca.ceresoli@bootlin.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 07/17] drm/exynos: exynos_dp: Add legacy bridge to
 parse the display-timings node
Message-ID: <xwenycscalzdlpuxytorbiyvej3k7pv3lhxwtadilxq65ipwsv@x5rxm53w5e22>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
 <20250912085846.7349-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085846.7349-8-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: ueKkFQig9hbrbly3DANKuiGSKIEajV7n
X-Proofpoint-GUID: ueKkFQig9hbrbly3DANKuiGSKIEajV7n
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c3fb51 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=xJsYSp2GQeFlw7CnCu0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX53r66DPP+oOC
 oe/16Pbv4DqtTiHUBT/dvu0uw/aEI262z+meFfimhuxl663E+WBeIV87AXt2Cf4GxZfVyCuzfsh
 AwypVff1d8RG3j0Cz9GFc8hvxV00q3SDfPpkmo0nb26qbJWBBBqXXNQidwOEBwEu12vbLRRtz5S
 1jniZtXLTp1nqcJ8R+u0J8EywCCLiBfup/ngrrUYxN2aXLLA8ofU01QYMryzypAHlNI5OjIMIBw
 w8qYf7+sSj9F4GLrWUnmvOzaYGaW/kkxsnD+QW3crU87AAnE8D+FkYnYIMeEXzZkFLrhqlVuwli
 pznYaaQ1izhShScI0CJDedcVL2bC+SHln2MTTGlrmRb8B6JH1LH3xwQs53oJ2hhQjjpXPkUfbXZ
 QCKw/CbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On Fri, Sep 12, 2025 at 04:58:36PM +0800, Damon Ding wrote:
> If there is neither a panel nor a bridge, the display timing can be
> parsed from the display-timings node under the dp node.
> 
> Adding a legacy bridge to parse the display-timings node would get
> rid of &analogix_dp_plat_data.get_modes() and make the codes more
> consistent.

If it's the same as imx-legacy-bridge, it might make sense to pull it
out of imx/ subdir and use it as is.

> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/exynos/exynos_dp.c | 132 ++++++++++++++++++-----------
>  1 file changed, 82 insertions(+), 50 deletions(-)
> 

-- 
With best wishes
Dmitry


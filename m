Return-Path: <linux-kernel+bounces-813780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45643B54A93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B22A1C236CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E322E9726;
	Fri, 12 Sep 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CuqdSLRN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF82DC778
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675052; cv=none; b=Ei/2inc3LGrSNrf1ZrTL2w5ZxNhr51jbna/4lMOyBE0SmhkULFOYJMOGJ99CuXjIk4igulDHgJMGOi3B8WaWLUspN1bzGBFbTqbtZc+fbg5A7JHqN02fGQW/bML5Tzxbj/5hf0PEdr5y87tfF10V23D29x0HN5hYqE4S+SRn43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675052; c=relaxed/simple;
	bh=gn4IolZQ5hLKpwPjMDyK3Q0CgUaBvu71w454l60Hmyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOTntDeNCQvUh6/HRzZZPx6qcx3jKKW2PtGeKkjJLnAfBkId/7fHQIFYwjeKk6pj566UChdX3yDpA6Ltc/3SIZE2veYzTtaBpqhiYMJqL8WP19KbH0tG0POjZno4/tLuaMEOgQFrT7ZgTg3QFBxRiSm/SCqZCKYcMyP+viZCkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CuqdSLRN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fsJi019689
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uRiYWVeZhrzAaBhip5FSqu8N
	Vj+JbFtrHaupfkSzC2o=; b=CuqdSLRNCdEV/s+X64vOANtGFRmvkltCIFvt4Ewy
	xOYei2Qeg/sF/VMSdAIlrYtP0/Ce5tdo3BTI8sjsWbQtVqOH7W5E7tPcmPu9iu8/
	eITClcBMzIpIMk2mIyA5aMxHzUroJLDOa4HqHAjHJZnLe1H+ZHZPZz6fh1Mre9dz
	rntPktZakUi3N9DjqD6Cmo/LpbDd3fq5URTE4RmTc8deNRHN1yp+Q9Fm4Bl+2kv1
	P3e3WY3zVsNLoVfrAzvtQ/RwG+M3sqJCf7iFn8Y/AkbrGmSFGK+Mo7YdzGM+Qu23
	Y4ghqbneuIMryL05pvUv4oEoRShSO1sKFxJzjgbgpMvmRw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8akdaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:04:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7273bea8979so31407486d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675049; x=1758279849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRiYWVeZhrzAaBhip5FSqu8NVj+JbFtrHaupfkSzC2o=;
        b=gCo3Gic6pB8CYnQBvAQwKEALzfdJbEB9n9ChYVm9skQIFtHAOGrMXyL7Bz8zsRAtU6
         S+Phsb8NTVXQxcpdUgQSR0pyb1LscvqPaNKmSz/mNh61QZxQRJbSuj3IgPFsugb/finm
         1F+cnw9ru/Vd5froWuT8UGu7UKmUBn3vUKYQF3k59d8i2iyWigARn8eYVVZ5iHRkua59
         1/CVHgnJ+WjtoyLeme5WZuw3VNxRJzZnh5XlZYyude+qo2wStlopwL3hVZwNlh328Llk
         i1R7tDSi7ttR14aBmGBhf7uwTEGKj25pD246oxaMwVP2sM/4h8NMNphIqOyc5Ow3S6SO
         F8bg==
X-Forwarded-Encrypted: i=1; AJvYcCXw+YGvRPCors72dlg5L9a5eyreApbqsU9A2sK1Qkz5MGuCZ6aSaTlBrux1Kvy2rwC3546Ngx8MVgpB/uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95bbV4KcS3LCNuCAK4XIwStd46RDAlzXIbGUPjIK9BjSbDeG+
	wZnk156p6mw5NcxxRDY8ruMZyaDYR/4Q60ZQVjDTRIPyY5LHIbJ12mvPBi0HWRYCwQwhT1H/EUq
	VVvatiPyUepvCJ5LeQ5UGLKuKZw6IIJxBsAtmzwojEdRNvAZdSVJEM+VXYEJBq/nIcDc=
X-Gm-Gg: ASbGncu1+jK2JieMxnMduNrdRBs/2Yk4X/xa6qyHMdh5BMCKmJAKSF41vfc1SwOrLIq
	Z4PKzi+z2jkF/K0yaj7UdXm7vNX4EErfm4jHh90XvPRT9xSV49eGrUXDaZDxlMOeCQnhI8YdTv0
	F4/g7DbGKdK9QIAJogrFItcVvGRfKTppRFoRTKoa8c/V7KBOr5YSsp512W40wE2InypPpMKkG8t
	BrGj6V73YlF3kp3VSBlA9lJcqrnQ3TWRT8J813agIgm4Jr4gG7SJdhXaBpijJ6ToM0v5rZqbu/T
	Lglk555htl6RmzJcNkHB7ch4dNBJoSz26mOTC5TD5/p9Go/i/pb04coEaT/HCPLGLUT6YRNhmLC
	6bBYOENTaKuOL8NpwW3qKqci1CppHtaQJPiaQbb4/ldOAPyTMNk7h
X-Received: by 2002:a05:6214:20a1:b0:70d:d8e8:c5ad with SMTP id 6a1803df08f44-767c50643c3mr31653776d6.50.1757675048159;
        Fri, 12 Sep 2025 04:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWK5ie/2oncU/4OssIMnMH7lHSxzphQkEo1qeToGVNk2BXrTzFDbaZYLruQvm7dYwaukXQA==
X-Received: by 2002:a05:6214:20a1:b0:70d:d8e8:c5ad with SMTP id 6a1803df08f44-767c50643c3mr31652086d6.50.1757675046952;
        Fri, 12 Sep 2025 04:04:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b622fsm1079317e87.2.2025.09.12.04.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:04:06 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:04:04 +0300
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
Subject: Re: [PATCH v5 11/17] drm/bridge: analogix_dp: Add new API
 analogix_dp_finish_probe()
Message-ID: <xaasoza4346jao6ihbdb4payecfi73qekaynkfa2vqqdp2slb4@2onoar4qvw6c>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
 <20250912085846.7349-12-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085846.7349-12-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c3fe2a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=RmiVBL_TxkOMKIEFt2wA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: zyVC_xTFdoKAg6Yv-ALaEDiV2pDku0qb
X-Proofpoint-ORIG-GUID: zyVC_xTFdoKAg6Yv-ALaEDiV2pDku0qb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX8ykvCMqNuUV4
 cjKxMSRdQ7HM43NEb8BWOR6tbDKCrnCs0rXOpdZbcHEaIFmjup96tTW3PCu1/Ws6n3LETAS3s8X
 OpAJPK/iZQ1DNc1hxKTO0l6zwBXIIz9vRTXowPkLedSFNVt8kOWnElsquHvVJ81wUSZ7KKOLEXh
 mwZlsIRutkOTiZI0tXlS59k4NZaDpK9/o2SK6FDx+u1+m1ZEyayGPTQbnaHKD3GwpP+ZCgBstyD
 UZYnDxX/SpjMjcE9y2/rwzUj4zepFYtFhbO2IglYmIpUCXbEUkXos5hzAmSWCbMW/VfcsADlOLB
 z3u6N/ECoEnNCAV1RpSvNL+xJhIkvBRiDGAqB9wHhZI1IcGPMK5e/Azq/VOVZsa7BL1WTwEgdv9
 /ZmqVFer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Fri, Sep 12, 2025 at 04:58:40PM +0800, Damon Ding wrote:
> Since the panel/bridge should logically be positioned behind the
> Analogix bridge in the display pipeline, it makes sense to handle
> the panel/bridge parsing on the Analogix side. Therefore, we add
> a new API analogix_dp_finish_probe(), which combines the panel/bridge
> parsing with component addition, to do it.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


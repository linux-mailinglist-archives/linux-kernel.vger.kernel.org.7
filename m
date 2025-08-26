Return-Path: <linux-kernel+bounces-787115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F09B371A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF1C18864C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1733768D;
	Tue, 26 Aug 2025 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfKd+GfV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FA2C15AF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230301; cv=none; b=QIxhJ66kAKjtT6zSLcnl6W7IvMdHhWCgLZsUIYGU+38VN8etVN846j3tlAYw/6j9hw07o9IZX+voj3ca31CFaIA2Cqd32uBNezjm/ah0G6aDfOafDEumM1Sn01+aqr9iYrFiO9VSbu4TVOqcoNoCljgRDDGX5a6qdiLdl5muRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230301; c=relaxed/simple;
	bh=peeJCLSFmB9Be70U5qh+hzXe+fh//AVaBy3veqanqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQzUEsf5lJRv9QBVW1M9022cxDOTPBeiEr2HUyeRbXw/F9pvZ1NdSD2Y+O+aePz12s2hk5L4dxprokVE17LPp32+4Dskyur1kax2OoERKUa8cIT+5u4QXsRwTGLu8eT88onjt4cSVWQM1gSXAONJsyfAbFPYGoAhVTItoa+apgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SfKd+GfV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFLdIG011572
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fo1/9Ip6/4Cnz50sym4R0+zd
	sohgsrtps0QIg0lGkcM=; b=SfKd+GfVGy8xCvuGCGOvIj5jNVwjV4HE7/RKfpyy
	V0BQCWKndvp1G/yRrXqPDmnB+T7L2ulJyIajRk7Yubf3pD8RLLLFuMschKiNMo9X
	+oUkU9fPk2y+oOxhzbJoiXdadeS0kuOppSq51pT/IcJHDJwVapwSwJlTGDMdWwGU
	Wdho7eX2MfubXdAJHcYcSQILGGnoDtpvEU1SE4n8+RV33oOaAgmstJGRNRoZGeOg
	X9UyB+7pbha40sDq2IwR0kSg/qwP1oDvHeJXROmhvMrck+aAUL78RVbCAmNQ2HR1
	U2FlXdz0WGfpw00kVOLjhSPT4gzbAIXaauzZh0dAeAmxCA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615hse8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:44:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dd6d25992so15653296d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230298; x=1756835098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo1/9Ip6/4Cnz50sym4R0+zdsohgsrtps0QIg0lGkcM=;
        b=IVVop5cDfxjtSxKAnBywZ9+N8rCkDYrCbHIUxL43gO7cQsBxMY9Cog4YP7vj1AqhcZ
         B6yHlzW+rptbzD2u+XCCi3kG9DgBWdRFvbB32QAcNzEfKHcD4GvYI+4XJ5q38VAiQ3I3
         gPkf2lxbttnmdgVXHePKrf9FcKlr95wSs1V2PZGlHtjGpyVfG2CE5N/m2sApHKxh0fdt
         QS+y9xq7oWvv1Gx8JRGiVeu3nBNve4clE9pE65krdztskhONIYeesr6eoyqMZhDGDKUH
         5bBO+NzwkN+kcfhqDwQF6BFsRvbV595vyptyJ5JeHMisBX8Cm6BgLCpnWzECeP9w5+cD
         /Saw==
X-Forwarded-Encrypted: i=1; AJvYcCU7VeW9tZGDQg1SZ3i4Fvb9AwDHUtxUOqVO08GgKPPVkpRHpA+dgTJYJC+tuUmLqtFm85k1WE16gQaEMxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxJJEJGjGo731Vg1G631kTff5/vjvDL+gnz+uDepcp3cbneuQ
	a+iNo/lFnAlv41pzVXZbSh/rV0iZPCbbRfHA8GDbReAntXQ54eOrAL5KLRNZng7EQ1yKcJtYszv
	dtYeGk2pZlpH2SzJkm7b9pxWO7LlkImmnZkHhJTQisuMLbCBqxuvwplPP8HWeJl+bS7LWYCop2z
	U=
X-Gm-Gg: ASbGncs1yxEb7BJLIsRqzlIyQExOxkwPgoMGJjVHUWKg3VJEJ6LdJwYOhVGYiHhk5ki
	ZjbnolT2kc+nI6iF13GssN4V85kEaTRr1p5yAMC+vY/Fga0gLJzCLQXRy5wA5PQEjk5oIXQeSKq
	MSYPGlcjQ4FAMhTpuj4BKbntiisxdsjmFTAtxCcTY3TvVJF/VLP8aNfSM5+V7E9knZACGnRAYiz
	5YRhxNxp5R/Nr8l+Kefo36DzEBqJHfOY5wLo8hsLpX85WknUyVHzzTNV6yqw31ctoqKUa5D+4K6
	K/jkHzocI3Ibyu/+67XSKUTqjChcb3vE6vwzeBs33Vp/ilJeJRiS1Fh4QY7Jh/czxLX2wm3RIvl
	tP+b+xvlNNvGOtVjQfbmC4Jkl0Zbok8ztqtYnV+JgMAxwOA/epMZh
X-Received: by 2002:a05:6214:5283:b0:70d:ae3c:b712 with SMTP id 6a1803df08f44-70dae3cba60mr119353596d6.26.1756230298122;
        Tue, 26 Aug 2025 10:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqr7erg1723NCR76J53tDrWLPj6Q4rsJqNLBT87HEUC8VXg2JCngL3ZutGor5JaNkJQe0UUw==
X-Received: by 2002:a05:6214:5283:b0:70d:ae3c:b712 with SMTP id 6a1803df08f44-70dae3cba60mr119353156d6.26.1756230297529;
        Tue, 26 Aug 2025 10:44:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3f260c7asm1945645e87.126.2025.08.26.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:44:56 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:44:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 29/38] drm/msm/dp: add MST atomic check to
 msm_atomic_check()
Message-ID: <lp7yv6w2ofbohmhfusroetk6dy4hbcegdfuuzo2bywmngccefd@q5ssvwe545g6>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-29-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-29-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX9ED7Av5/FAJF
 YE9Xa4fjEUlH1rpJqYoL2IGojhOqSER0yNrfDnyZRIJZhZppi3N3B3acjEFxLlpfFcyAF9zuIa/
 9f+zo6ySVuPRPhRVQ8cvlP+BWIojricrY6nyNbX2mICUY34djwvcQtV3JtbKxCe6d6xbVQuYizv
 BdmnnaCYWx69fy5fkD1NaxAJ+Ekzzrg7J3gaASW2/p7q52RNDEx4GYGMMcbEYHiXuYs2sYwRpnq
 wT9oinizD9nAa2UDRJlMaGiqaLoUQEhIQBFLpXORbePUvhWIMTjSLgutaTZztdM6Wk+hnbbcEN4
 i6e0IErwgY7zY8QpOoOdfM7yFbPMZywQfN/pY2YVFm/RY1I2902FQalGGYlH6dst6aRvr8X2pQ5
 ZyXgZz/m
X-Proofpoint-GUID: L-Nnff8ZcsgHPfiCldipnPn9FvH0GSoc
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68adf29b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=AVsrb5vlp7rL4eKdMZ8A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: L-Nnff8ZcsgHPfiCldipnPn9FvH0GSoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 10:16:15PM +0800, Yongxing Mou wrote:
> Add a call to drm_dp_mst_atomic_check() within msm_atomic_check() to ensure
> proper validation of atomic state changes related to DisplayPort
> Multi-Stream Transport (MST).
> 
> This complements the existing drm_atomic_helper_check() and allows the MST
> framework to perform its own consistency checks during atomic updates,
> such as validating connector states and topology changes.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_atomic.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


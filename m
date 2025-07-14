Return-Path: <linux-kernel+bounces-730834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C6B04AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811CA4A3023
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE344277CB0;
	Mon, 14 Jul 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mAIJedhU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9823BCEE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532095; cv=none; b=KFcrHUbYiVALzJ4aubIJPUAc7ayc1Mx5vXBFc8doKqfkSpMdSAPUjfFFdFor9qIh2uyk7ZuZOwDJKwaFqOyVqr8TumOQdozAeSmlH4zn3+2fMgH0xsTuGjQo+h6vEodlwQcMrb4SHb43vY8sIcPu2Oc0QVgif6pbuIi2svetAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532095; c=relaxed/simple;
	bh=bqhSuK8Fneo7nRioVo3qzSPoFYLUkfRiuOuKAj8ljQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGFIDsAR3ji4d5VySsRGNfoHimwIqxFRSPlpyRTeoXuIwnTAcwhBUhCtCC+AAl7BeXzNJlz3sAKnjjYVYqNG0belVFhn0Snda1UTEvMhssOIYxYTETOLk5HQ5ptt/lPh1yaA6NhQQ1LscQcLn6m1pQt1t4wM1qY9DsCBGZ15YC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mAIJedhU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGJsZC015971
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g58Cwy9wjp0YmHwQ5wI0oyKa
	mpOyzB7ETzY1FZOvoHQ=; b=mAIJedhUanJ7jP4mKdvJ6tRPoyd+7plz2X6m9FbV
	Zvhr2F1k9wtyF7hxTZgtRf1/0wpipMaTjmq9HwzAbzetO/xoNaNJMlhQo+kZNjZS
	XyXIY6tEEBBflXcE48EiI9I80vHVn+tAuao51E658I4vlp0RveJN85MHvtdEU/7G
	4heeLbD94Xovb+zTwgmNZF0PBkDpdjFO+JV7e4KFuiy39CFgGzlUrgXjmhc1JgF7
	oW0NwgUUzekoS2SPs3W4j9bD08v44m8Cq9jp+r3++vh9ya4GXmdaK0wDZ/BryP6X
	mSURlvxegggCAKZdLXbilUSadw02PS7o1z9AOS/r4Xb0+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxax3v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:28:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e207330b6cso376180385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532091; x=1753136891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g58Cwy9wjp0YmHwQ5wI0oyKampOyzB7ETzY1FZOvoHQ=;
        b=nvogfFU/FJ67A0V9cv63HXoCYabQIbymifGA9kA4B+pRymPTnnqdh0myd4WfzTiowU
         IyP3xIYBltLlivSKhdB2IIQN+6SM28fXSjY2JBWb4Mk4anqttTK/Fa+K1+OEY2azEDsz
         TgaGwnBpK2T256qcLyGxdkvzLongR+klQQl1o8LlaaoTbcTbLW7yD9q54yXcb7ZO1XZV
         Axa63Z5wwvfurtxK+HlRDqBkSH2+3/Z/u9Q3WttNfWSecvV2+Naan+WpqYGlB0lgNRVU
         AmgNBS2/Qfx9NC4ME5op6JwhznRyw/ovwsZmQu17wNxTBmVofzkdXb3m6YSb4g36WhQK
         JS3A==
X-Forwarded-Encrypted: i=1; AJvYcCUMg1OyiAP48gs4EWVYf9WOpcMmJu0rQK30SaZ1bp0s1noRQ081U9ZPPM2DoLmwhCMypQOHa8q/0xqMCJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WcGsf4gMP7TWJicLwRzrwOlaY0hBwIVeNOBDQIBD4DM1DOYl
	j5eT6y0HDBl3i4BMnL1to25mRsA4evlyTzSehJLVXuf1ONJvE1khi+TFpCl0d1ILZT+Flq0GVps
	O4LrdzFQ7kSgk8DGXtRmgNHiAVsKyxbXTYmYHaUDypAfPcYW01p573MmKolPsAoonL64=
X-Gm-Gg: ASbGncu8TFeK5z25B97bquzHjDgDcU3Z9Gmn8eJ9HA0HVk4yKRie57urZHBRmVkGZNL
	In5MZvo+jsdKWYPmNtA/F4ggPnmIlPlBcN6gyk4ALKeXt1lNJPzdn854Rvqn/8k2rnPcawM6AZ3
	IxjQY/w8ddT/hrwzG45w/me9rFpcGQupSckBAbQGXkTqQYIupbHB+GagDQ7xcg9q38hSYyufO/N
	phxFQexYpnWqtMR1AnTZXq+DNY7DDRRaRDaxVjbsc+gfwAk/qiazxJu3Ijb86SQpdYVj5KKzxmZ
	Mcxqh3PWw1uFeSr7C7CpFEHi1IUiDl04NCpv5TvLXvvW2eDeTO5bC1r8B3f5+6aB3so01j4y1Zt
	56oNVx5xZhzkMCWyAsbXgX52sO/1k7OT2+XUfiuPiIwGn+DlSQZy0
X-Received: by 2002:a05:620a:318f:b0:7da:e6e:dac1 with SMTP id af79cd13be357-7dded000eb0mr1982781185a.58.1752532091242;
        Mon, 14 Jul 2025 15:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBbqen6Ycp/DBPIss3IXszYn/5lvf6AcTyj9CEOFH1Zo5pXcdZ/lkHLybnpi1M0aIYwXscAQ==
X-Received: by 2002:a05:620a:318f:b0:7da:e6e:dac1 with SMTP id af79cd13be357-7dded000eb0mr1982776885a.58.1752532090674;
        Mon, 14 Jul 2025 15:28:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b72f68sm2093423e87.203.2025.07.14.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:28:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 01:28:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH 04/19] drm/msm/dp: replace ST_DISPLAY_OFF with power_on
 in msm_dp_hpd_unplug_handle()
Message-ID: <ux7tbizguenr33odq2utqdrdanih2ez6gvm2dcss37uuo6pi7y@qnh4rwrgqept>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
 <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
 <6883f346-452a-44b1-b670-3bd514f57b08@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6883f346-452a-44b1-b670-3bd514f57b08@oss.qualcomm.com>
X-Proofpoint-GUID: WiXKBtGatNn1pLK1WzqQKnLS2A3NZjWW
X-Proofpoint-ORIG-GUID: WiXKBtGatNn1pLK1WzqQKnLS2A3NZjWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1NiBTYWx0ZWRfX0QPyXOplT8LE
 IgnFAf2TfXl41BZiW/VQa2g2XJoBz53mpkR4cZBaAEmTnN5cBWuw9SDcmKwN+oTVNBbR/XOSRkB
 9fPiLKY5lUsozznWboQz2e0hwzKWDDFIdoXHCayDLuR+BodONDm/XcwxYhAvGRqlj0Y4+TtMgNS
 ymL5p2Ge06vCYY8l2gkc/t33yAl9tncYeyRkdcSN0TTtG5O4criZoAfZ63NBrr/OfRy7vN1UwMm
 S0pMWecVmuQz0EIy4M1yjCTHDj3CpPKZ4ZmHJiFKdDOPTTKg/G8mfYtL7d5TByVOVfnGXBOELfx
 JFfpdyoahi5k8FHhX5eDDk0wNt53azUSo829J6404VTy2Civ1MExtHFHgc77x9MqOZlaHaWSPgm
 qAw9NcWqA8K/gbhSHfo6ejNmdUkdXWmFbtVevrOkb4zUBJE+oQD/8Dvk1p0WiBRg81QquPkq
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6875847c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=V1oTyKxzMZC_ZlTkUykA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=696
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140156

On Mon, Jul 14, 2025 at 01:38:55PM -0700, Jessica Zhang wrote:
> 
> 
> On 7/14/2025 5:27 AM, Dmitry Baryshkov wrote:
> > On Fri, Jul 11, 2025 at 05:58:09PM -0700, Jessica Zhang wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > msm_dp_hpd_unplug_handle() checks if the display was already disabled and
> > > if so does not transition to ST_DISCONNECT_PENDING state and goes directly
> > > to ST_DISCONNECTED. The same result can be achieved with the !power_on
> > > check.
> > > 
> > > Replace ST_DISPLAY_OFF with !power_on to achieve the same outcome.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > > ---
> > > Note: Taken from https://patchwork.freedesktop.org/series/142010/
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Please squash all state-related patches into a single one. It would make
> > it easier to review and more logical.
> 
> Hi Dmitry,
> 
> Ack -- I'd wanted to keep all the patches small, but I can squash patches
> 4-16 into 1 patch if that makes it easier for you.

I think it's easier this way: we get rid of the HPD state machine and
use flags all over the place.

-- 
With best wishes
Dmitry


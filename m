Return-Path: <linux-kernel+bounces-783060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C349AB328E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FE01C81919
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F391A9F82;
	Sat, 23 Aug 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nio6dpSU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A0E552
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957029; cv=none; b=O+blm3M1NtXf3lY2WWVstBUz6WA3gMnfiLZDZPGK8hznD6xkQpsd4wbIo40Z2d9a665ND+dDOFKUt+f3R8wp5VJTrfTmfr4XKR07a2d8PcCUD+FqJcz/DLScdtcJKMS57vVfZTxEsQb2B1dpV0YwLN013xAx8AkgULbmP22musk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957029; c=relaxed/simple;
	bh=0c9fKwJEac76vUKl4fSZcqrh7KtjfzOgupgDadZFO0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzxGLzIEJHdaQIf9DLVBW2gA+DRQRWWJ4jJbpN5iIPkZ9Q99FCKAHhuCG20rA6MYY+Tc/yZmKorTZsmSl02SD4Z7H911SwhBoPvUvexHEkaop8sR7pT+VZptxN2QQ8+GHb6NZt4HbOdXTrxnzKY0mi8eVQgzS0LK/hxLdgITBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nio6dpSU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NDdEhK005978
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U6vA7pywJ2vttXsunG5ab7QCq7Dn4Mr2hiEppiVxLW4=; b=nio6dpSUo4+XzYvb
	+g4FAc6M4J86Rqhz8jovolyoTvjXpbL5SvbEeT5bcZGCLfRV1jt7p94B2D8XmKcu
	uVsmbW1JNSfcmo/UgULX9OD/zMNy9DUbM/HbQAlusOIzocf3GbYS9aJ2mMjKsgYM
	hn/mWo+V5FaYFta55RHDn+p3i8rXgZkvUXNLhYI9YGYQdhS8sKJRP55NcgSZWTy2
	t8Gzm424GUGWs2emuFalUSt6LQjYC+SpgJLJI/GeOPEZ2jJ/zjszfJ0XFmyHAQW4
	ju/qT+oiftxCiDsPfV0kw2g+bWwDRGXSyXtXtIQGrbISV0I0iAIV/b7DM5+bm6rW
	2bh2Cg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xf8wcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:50:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d93f579ceso46410896d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 06:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755957025; x=1756561825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6vA7pywJ2vttXsunG5ab7QCq7Dn4Mr2hiEppiVxLW4=;
        b=FLxgI5HU6ocx2j9W+Nit5mWyw2JPxYfB4TZlpBWski9nP+q2K3rpqfXIKo3DwoXuL/
         crZt9Em9Od79LEkXI2voymvtYB84OmSGtJJGj34WQoiS88trnGUfRL5osFNb235yRsKU
         z5J15KBhUL0nj2gDkX82692gbqp5uDoZEXK4+yHAYSPNianf3jYyNIGJo/y1zNJyio51
         J6HNnclL5Mop4UDcI1Nx6mM0Bf6lBNsRnDcUcy8u1jytrCFA/MU+SWNWYAzQt6s1WyMZ
         yrtQ+l4igOoFDSkyMoVreyZ0CW0wfjHeAVwTu2s/zXbCd83HbOSJvtOPCwJeDtDVJT/0
         DcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTiSUbUQ1hRGbopoZfrA/8jbsWD/04qhSWF9+x7OPQhaWHhhTGqiLjRmHAl+pixNqcCWsmlN66d3bvr+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHZmi+Hu2AHniI++MY28Py3GrloHdtgMll04VX4w53RV83ReW
	G4lDQ3+F0h4WeP52Mdp+THpAZI6+HcYp1OvjnM2JM8nC/pEInD0xLeWe3WvS5HxHLmcBo0sjp6+
	4hUAndFYeWUB6zvxHJSwpF2Ch9MGyqnL+iybIuRSLIijKl12EvAfHKZEfVMGWL03pbbE=
X-Gm-Gg: ASbGncsxLTkjXA+y6N2WVjuDkHOOtebq7RIHH5u3OCwvnhrrHb8bO4B/cG3JKPFZ0iL
	sCHqCL2GeAixLTh/uGxd0txCHjtbhVpiwubxq7b+7uU60TXmP2sg61wjy1JH/W0pQidmXyI+2zi
	hvQtA+kUh/6NquI1FDAi2xUYO4hBAqV8WYVZ4leiQ94yfw+71w8T6RpfKnCvYo7/aw2bkK3zue5
	7H2QLE7hpauldaqCrhaF73hTiGO8ZeUxDiUH8P9dvz3TAkCYDJiOFoirRvjRsI1OKf4lqSUkMg5
	rOZL+WLcVFL0ZjtgYTjKV0c730/kE6UMIq/Uu1Vdq7laWwspFcH1zxHUUywSbys+8Rgxcqemo5A
	Ook46pJ0AJgQOauDe0OdsWavvAKCuyWfj8LIeDET0Rm+UWfCysWWu
X-Received: by 2002:a05:6214:c81:b0:707:4753:bfa0 with SMTP id 6a1803df08f44-70d971f69ffmr70804716d6.13.1755957025504;
        Sat, 23 Aug 2025 06:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyTpNiIvNNs3fPAEjRcZ3bS7cPtXKDiw2pj/9JSAEBFNfi1voXXeGw+P9flbkF2otl4ev4xQ==
X-Received: by 2002:a05:6214:c81:b0:707:4753:bfa0 with SMTP id 6a1803df08f44-70d971f69ffmr70804426d6.13.1755957024980;
        Sat, 23 Aug 2025 06:50:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5fc05bsm5159881fa.69.2025.08.23.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:50:24 -0700 (PDT)
Date: Sat, 23 Aug 2025 16:50:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danct12 <danct12@disroot.org>
Subject: Re: [PATCH] drm/msm: fix msm_gem_vma_new() allocations for managed
 GPUVMs
Message-ID: <qpde4x3tcultagjpflm6u4xulm5b3xs6ek54kek3sriyrneefk@tgygc5zeoxfk>
References: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
 <CACSVV005RPPoB=o8-Arvteaqbpr9n_ey7LMp7c6WOg16euxh5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV005RPPoB=o8-Arvteaqbpr9n_ey7LMp7c6WOg16euxh5w@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXweiPZZyylRLP
 2BEXzo16rbiNXYcjoiT96rPkUsnCIvJ6Ii6cqJSgIAIi3qsJp4W3J9RXkX0WmuZg3XRwnzeLleC
 o6U1fWPQtbzz9HR7DO6XdZQ51jg7+uy+iyY8TpdSQVoKl4lLdKOJe6maIUDqo2x6y35dP9YIDk+
 23gTDW+CeUGNfDkpYlchY/z2ytGcPkRjBVrRErW0NzxrYmwpCiGnxYL9WdJD3PPc6g+9YgAq6rX
 zwO5g9/9mdDJFmAArWLV2O61byzj6pWN6J9K4Khn4iMNdZ/T6QgJokFsnoVbSUBVLedXPeFCEZV
 5fWPN7Oh7tL6fnklD81O6rlnJ/5qHunSNLDliYjP348SH/j3fRiOjx9LMdhZFc+XLC6N41M6oqT
 Ku2ucETW
X-Proofpoint-GUID: ulRevul1dBAdjRMSZDS8LfwZIz1PUh3e
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68a9c723 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=LpNgXrTXAAAA:8 a=e-On7NsmxptUPx_5N0QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-ORIG-GUID: ulRevul1dBAdjRMSZDS8LfwZIz1PUh3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Fri, Aug 22, 2025 at 05:14:02PM -0700, Rob Clark wrote:
> On Fri, Aug 22, 2025 at 5:12 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
> > driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could not
> > allocate memptrs: -22" errors. The mentioned commit reworked the
> > function, but didn't take into account that op_map is initialized at the
> > top of the function, while ranges might change if GPUVM is managed by
> > the kernel.
> >
> > Move op_mode initialization after finalizing all addresses and right
> > before the drm_gpuva_init_from_op() call.
> >
> > Reported-by: Danct12 <danct12@disroot.org>
> > Fixes: 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()")
> > Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> 
> Thanks,
> 
> Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

I'll also need Acked-by to merge through drm-misc-next, where the
offending commit is.


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-753259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0BB180B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02ED17A2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE9238C2D;
	Fri,  1 Aug 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dohDivY4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241741FE451
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046398; cv=none; b=RtLdw4WS6/ShzFqkHmd/+Yj+Px3j12UcGLosZQTV6aMF/KPE834yHjySHsI0E1T9u1A8M1mDnloxnLqNEOqyQX4qrKV4d9sf5vFEDXxuw6iwL0y+NncmFQ3aeAeQ3IaQxbvKsFmmaqaQR5p4zDIlhww1kR30XnJx5CS6pgBRehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046398; c=relaxed/simple;
	bh=Q2ZZC7eAw7ekUxPgB+ZWGu4sti7oHieVjvDAo2dtteI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfpYnXouG7flzetR4d1IlSeznC9Mz7SAuF6+x7NKPxLv58a/qB8mSvvkwtqow07BTGtOJ8dEYwRMSKAH4jXSUel5AfIcZQgaG5q+fQ+3GOUZrlmvrwNK7e3oIDu/hoqHgc6vRG/rjCFmiz7AMiH6m5A37Z99hoORoXjRLt8Lv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dohDivY4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719gBn8007014
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ohWu67k8HbB1UHHgamfp/0d6mH0sfNTpA38ZH8ZkldA=; b=dohDivY4oMDnATkk
	9f3S5ewE+CnZH6drV6sJiaPFu79g8KwUmK1qSZotlj7Jz6PpXUERiuce7hPYY/0E
	sS4oMIM43AuHQUY9wkgmjUFAoNrxyNQ001t0hhrEvuRTou7AD0uGLLPw5T47nty5
	ZAs1EaEOE50dT7TkJTx5AFYM3nB7RD8CzIZZtoSF2v9GjawdM5N1pNDQ/9BuClr2
	JwzP/xWTJ6v5xrOv3yz7BKLY6SUlrEERx2JD5DXT4Z0AI8oerg7FLDeGpQCUSDjo
	VZIjgx3ye3rXw9eLv+wa/tWoomrd2QkFh1e1zDK3cXC3ji/11SjfaC1Q60mwXjE2
	2Ysz+A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488u6509g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:06:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4fbffa43e85so298612137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046395; x=1754651195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohWu67k8HbB1UHHgamfp/0d6mH0sfNTpA38ZH8ZkldA=;
        b=BFb5DMBpoB1I3k2geFro4+wFgkzZNkscogWRo3U4WVwykkdhpJ7hRIeZZcr5VVyxrF
         MDjTjSZ9xFn7GPq00cnG2AmD7lJCUus0azarb/XsivAZyOLpAtpS8EZBMB7TSZPOQqSk
         dRkTgiX/TVuNR1DUn09nim254QrC9UYuEiEh55jcvBlcmNnKoVf/xkdX267LeBMHvxcV
         SMtZH3vksIH27SrCaSFND42dHlSnFqUhTq5oEumtYOOd0JpTqTRSGeTqbKg+n+MGIH0m
         ReWyvgk6OuYehKuPqK1PCpQgPKddJHNhUKr2XEWWjEbaDH38L5KAd+IZ/ZMrXWTjWQKk
         x8fA==
X-Forwarded-Encrypted: i=1; AJvYcCXwGXTfLbP8nWjtstTVJbpCxP8E5yo6BXHnFz2kHbNlhzlDPe6b7IxWx+13+O+F5hYk3yhYOMQjiCx0q8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PQZwSVOiDR7svpcVqfVDBrrucsWmlXN9dHLGfCco7M83z7tX
	SZoMm23TnDG10VSJnuZjaR9CvWalxPo7NFy6RwRLl6OCNHy7W3t1vMoPJBWsaSXhPBiRWuT3Rap
	NRg9/s2JiJALBfv2ioFAY+XZtOVat/GeoHV9y0YLjNgGsdXjO46Na0j7WMTp2/5sN/4U=
X-Gm-Gg: ASbGncsQAeAM8WQQzfxxqW9dAhdbzXzoTVphBkniiFkktMh6/h/UVXa0ynFICUM320m
	nEQ8fVQhCAUQoCRw0qdDMM96FtEPz9qX9Lymta6qSNLkMJglR+5FQhj+gLLOYdo8FIMduPJIj/o
	lr73ygCsdiW2Gny6kRMfwDSfNhB3FR3H/hdzTEoKWSHOR4m63vkJDN1m8nhBOBPO5o11auhn+p1
	nqz0FMKv7FQvQxVc7aCz750fj4BkzIED8AlKGnzE7xxMlPJtraAz/z488NQhfvAFGlCL3aBnsXF
	sa2ZReFkzcSRDp6b7P+Tk7lM4qfzDuO8cZRyxkYcwdtfMOkFslamcDp1m/1KmrMWpC5lXDG+5mk
	Q0Iu8CVxxlp3viaH8t7CWoT9tftJPoeeYIOcEsGDfq3jo/oEzdY4t
X-Received: by 2002:a05:6102:d8d:b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-4fbe88fea36mr6776826137.23.1754046394968;
        Fri, 01 Aug 2025 04:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXu+i98JlBWaD9NFVhCHmgXrDjDlJp2pJeGlNotCFdOuNkns+rDbVOGaCSxMcLE/OBy1MTg==
X-Received: by 2002:a05:6102:d8d:b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-4fbe88fea36mr6776774137.23.1754046394479;
        Fri, 01 Aug 2025 04:06:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac767sm537574e87.68.2025.08.01.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:06:33 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:06:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 10/12] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Message-ID: <akxp2lpikvslacz72gvp3ctzdgsrbfnth4ugqfhbxvflmr6ssu@f4ebi3tyz3am>
References: <20250728-v6-16-rc2-quad-pipe-upstream-v13-0-954e4917fe4f@linaro.org>
 <20250728-v6-16-rc2-quad-pipe-upstream-v13-10-954e4917fe4f@linaro.org>
 <4dpeif7wynynbsccbhc253wkshuylnsjslsosmrnyld3bmot5l@yqrmpln44qe2>
 <CABymUCMa06E0zavQsKeDw_rjTW5F9o4ancxWuQynMO3wsHKFwA@mail.gmail.com>
 <4c492060-cdde-43c6-8351-d969b0f9322b@oss.qualcomm.com>
 <CABymUCO63-V7MoWpgCTEV_8R_4rVHM-1=eyRP34=OdKGpYSLDQ@mail.gmail.com>
 <c7346b52-c5a0-4aa2-a8d4-92761e33b011@oss.qualcomm.com>
 <CABymUCPgXAaJCLTiN1XxK1JEjxnr9qPye_E6gMLSMvEhgXJk6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCPgXAaJCLTiN1XxK1JEjxnr9qPye_E6gMLSMvEhgXJk6w@mail.gmail.com>
X-Proofpoint-ORIG-GUID: IIwCAqo9m-_0FnlHA3asOfFql9SzNH5Z
X-Proofpoint-GUID: IIwCAqo9m-_0FnlHA3asOfFql9SzNH5Z
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=688c9fbb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=K2Uce_oDiRnA2C7xoV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MSBTYWx0ZWRfXyX6RmXHPSGs/
 J0ggn8g8QIpYyMRBHWmsBj6iePhiNKlA9+6RfwNbXjDalY0rcKpPPF5Lgmwl3ggxTi4vQmubeTe
 wCpALVfysEpbRgGAhfIGskZCaWHZKNaegeEMY4V6Orv7bkwZGGVC39qpRoLc04/yHKma16wtQQg
 INkR8dQZFYl6NDT4VT9QNl5SB6b+YZklDpg9AUZP7LvF7cPfe6Afitt57J+/03ZMw//Fna/8JN8
 fZbXG/20ROYj6bVTWw0csPEp3Wm1c0ZNGGAoZVcFFjCrr6PVkurohfe9TilFUSVzBzBa0/kvqA8
 ahBCzOc/3XoYZS4aE1bBzV3mzBaLdhJhtuFvHKfWKyKAfVJ2OKsMgBjTJ1nkOpr2BetUXF3/u1Y
 KR0E4Ddvh5XeBXWXebzvSY2mlqqibydQEm9vqfCMUIvl8QetcyUijk4xBYV39URxlQq6aZhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010081

On Fri, Aug 01, 2025 at 09:19:41AM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年8月1日周五 01:08写道：
> >
> > On 31/07/2025 18:37, Jun Nie wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年7月31日周四 22:22写道：
> > >>
> > >> On 31/07/2025 13:52, Jun Nie wrote:
> > >>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年7月31日周四 02:52写道：
> > >>>>
> > >>>> On Mon, Jul 28, 2025 at 09:14:34PM +0800, Jun Nie wrote:
> > >>>>> Currently, SSPPs are assigned to a maximum of two pipes. However,
> > >>>>> quad-pipe usage scenarios require four pipes and involve configuring
> > >>>>> two stages. In quad-pipe case, the first two pipes share a set of
> > >>>>> mixer configurations and enable multi-rect mode when certain
> > >>>>> conditions are met. The same applies to the subsequent two pipes.
> > >>>>>
> > >>>>> Assign SSPPs to the pipes in each stage using a unified method and
> > >>>>> to loop the stages accordingly.
> > >>>>>
> > >>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > >>>>> ---
> > >>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 160 ++++++++++++++++++------------
> > >>>>>    1 file changed, 99 insertions(+), 61 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > >>>>> index 55429f29a4b95594771d930efe42aaa4126f6f07..e1e16a8d5ac55ba52a0f460d62901dced65e3a9e 100644
> > >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > >>>>> @@ -959,6 +959,30 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
> > >>>>>    }
> > >>>>>
> > >>>>>
> > >>>>> +static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
> > >>>>> +                                            struct dpu_sw_pipe **single_pipe,
> > >>>>> +                                            struct dpu_sw_pipe_cfg **single_pipe_cfg,
> > >>>>> +                                            int stage_index)
> > >>>>> +{
> > >>>>> +     int pipe_idx, i, valid_pipe = 0;
> > >>>>> +
> > >>>>> +     for (i = 0; i < PIPES_PER_STAGE; i++) {
> > >>>>
> > >>>> Why do you need to loop here? Is there a case when pipe 0 is not
> > >>>> assigned, but pipe 1 is?
> > >>>
> > >>> Loop the pipe in a stage to count the valid pipes. If there are 2 valid
> > >>> pipes in stage of the current plane, this function will return false.
> > >>> Or you prefer the below coding?
> > >>>
> > >>> 1029         pipe_idx = stage_index * PIPES_PER_STAGE;
> > >>> 1030         if (drm_rect_width(&pstate->pipe_cfg[pipe_idx].src_rect) != 0 &&
> > >>> 1031             drm_rect_width(&pstate->pipe_cfg[pipe_idx +
> > >>> 1].src_rect) == 0) {
> > >>
> > >> Yes, this is better from my POV. But the bigger question is why do you
> > >> need it at all? What is wrong with the existing check? Can it be that
> > >> pipe0 is not used, but pipe1 is used?
> > >
> > > There is no case that pipe0 is not used, but pipe1 is used. Existing check
> > > does not filter the plane which contains single pipe in a stage, which can
> > > be a candidate for SSPP sharing. If the stage contains 2 valid pipes or
> > > no valid pipes, it is skipped in dpu_plane_try_multirect_shared(), or it is
> > > skipped to be stored in prev_adjacent_plane_state[].
> >
> > Oh, I see, you need to check both pipes because you might need to skip
> > it completely. I'd really prefer to have more explicit code:
> >
> > - check for pipe0, skip this part of the plane if there is none
> > - check for pipe1, if there is none, it's a candidate for sharing.
> 
> Yeah, this is the logic of the current implementation. So the your only
> concern is the loop. Will remove the loop as above code.

Ok.


-- 
With best wishes
Dmitry


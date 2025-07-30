Return-Path: <linux-kernel+bounces-751224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B034AB16692
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB96E3B3CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496152E172B;
	Wed, 30 Jul 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0DUD4au"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0512DFF19
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901533; cv=none; b=X8bH3xDpWam6/0U9HX72Bbq6woAxcrXOlC4AI3aITBldFaMUUt9y2XDrwU+AVYt9eDr5wgTvbLcUZVZaESFcNvuj+TL1/R/5fsmw1poG2I/bV+neQVe/oUq1NwxRU/VrWfUMj4r8pB5raNygWUbhzd/1zEG5fay5NsbXCPgQ37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901533; c=relaxed/simple;
	bh=IbxbUNtJRhezbHfWoj4hG0QyJlDf9fcOcWlxfpdd9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcQ0Icy6kWyJgkb4ICSciX/C4V5Ip+15IETsFPjCt1oM/3fzWRgk0wCA4PzQ4ZgO4agvgOIb+CVefZWXVKzgtSQUndO5cVJGBeAQEMT9BP/rQEnN5U3IHI+iiH9LQpDNsrbtfSkomaehv7T8Kbo2GEBPhG2XFwVMdUkaxOcfFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0DUD4au; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbFkx017794
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cTwARdfCwgr/NlvTGtGlbkJb
	A7lOmveqZjNQjd5wXok=; b=n0DUD4augujSkO6bHRI09Nvi0ovzhYVKV406vdZm
	1j36mDe6URlq9d1gCKduKh5g5Gjvi0RaNRO4gS51Jid8RtmWK7ZMKM5IVxqOYn/Y
	tXxP2hRnON5fIJzVoeuYiqrw1pps2k/NokVnNUJTfUac8UGP5Q9TqAEGtvFxFKcC
	fQEIpmEmspTvjgxnbSuo21kkqTF2Y+uhH956B0IN8t18u9S4+5+PyZqE6w3edFJ2
	P0THcwqcQfm1dZZ/dBeKgf+VW9PrF77PfnF6/K3wbohYOUhQLiQ8NTVUiVPfjCpu
	/35EuiwqCl3SMLL/7V17BUS4Ccmy+31RZsQIgCOAbYk6bw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda4wjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:52:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-707722d08d9so1553616d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901528; x=1754506328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTwARdfCwgr/NlvTGtGlbkJbA7lOmveqZjNQjd5wXok=;
        b=lNL16k2ydSEWw005j/xkwI035ksjWkuxD1KINAm9ySnD/Fo6MyfM3hpEqim2nklP+B
         wJAAvGeMJKO97ueqcSl3xk/EMSBf1aO7CGmtLJwfWK1Q45OCe67mXPQSXkVAaHcCbC06
         K0MG1TL/OhSsdCc4J9oN6EwN98QgzkxKz1zUrMPvOO6lwGOQNteQaBrW3BH/4bJDt83J
         DedfixdSRJvwUuGw5yOl1aj/1v61dLxzk0jq1OiL9jyy+lYL/kXrO2wR47GC9VVp+NPS
         Fqu5tNnrZiKNEzjzYiPRCfpQ/hKbbgaS4/4Vu9vUbdS+cY5rSsIXl3kLBEe732/QekE6
         Dl5g==
X-Forwarded-Encrypted: i=1; AJvYcCUqt5EHDkQknzXXajQd8qFS9NFqKOrnGe5FNdRa7x1bWEQkdzrknBQgDRzQqDJc/quyxBqVWlkqAH6bo+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8pA2qNDaT0Rw70ZIkLbGlwRoF9t518fpJloxHIT+2QOZuqLE
	d7foVlEDi4yMUGtfTHRIL+INnCwOfEjUeOtLpF6xHrmvHderM42Lj40RRS1qxZtsjvUToCrUgmf
	uZDrF29XokRyeUlNc16y3gOaWDTRpigH0frEnRjjCZL7WokGuIqr2l6J1bjgy3Yjf6ok=
X-Gm-Gg: ASbGnctKitfp0gdb/PvD9Cs+oO454FuX+HNwRemSU3Q9adptixFYGqXaXljoXJwlUUh
	lLXTkmIsfYCv9N1ftR5JIpJ/HGsVxF+l4C7mAKiy/ts1W6TStdAD/Mr1x/muewdIVwtrjpSZZYI
	McAXGrRfhKmfdERmYZy9xiN1InYtuxN6BVqcW7pbI6nChj1j7RMtUnO6ZlwP9OdggWEyPSvN9Pq
	ssGabMvyRhcLIGB2nOOsyUzEzvkN+Prni/0rqut4RZuzMjwjZSOSE0IcKMHNmW1D7I25nqe52p5
	hsQddfAeGoxYbhU2WiHpddzfREgZf4aXvwAdMQfYc6et04+rkwdulWdL7oc4u1FobXK2vkFqGva
	GmvNJIShGsnTnQyoe3zDXrDgek8/i1qqt4dzqqlGIqbetfkFlwVgW
X-Received: by 2002:a05:6214:301a:b0:707:5d28:5756 with SMTP id 6a1803df08f44-707672d5bf0mr58691326d6.38.1753901528450;
        Wed, 30 Jul 2025 11:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUgQbxh6ti7IV0IFdWPPJtqJvpimYqQzIhvgqG6WDSshQjaXtEIX2BkDqpxJvZ79BtOUo2+Q==
X-Received: by 2002:a05:6214:301a:b0:707:5d28:5756 with SMTP id 6a1803df08f44-707672d5bf0mr58690726d6.38.1753901527818;
        Wed, 30 Jul 2025 11:52:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b828b9999sm263879e87.182.2025.07.30.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:52:06 -0700 (PDT)
Date: Wed, 30 Jul 2025 21:52:04 +0300
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
Message-ID: <4dpeif7wynynbsccbhc253wkshuylnsjslsosmrnyld3bmot5l@yqrmpln44qe2>
References: <20250728-v6-16-rc2-quad-pipe-upstream-v13-0-954e4917fe4f@linaro.org>
 <20250728-v6-16-rc2-quad-pipe-upstream-v13-10-954e4917fe4f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-v6-16-rc2-quad-pipe-upstream-v13-10-954e4917fe4f@linaro.org>
X-Proofpoint-ORIG-GUID: 36KzQa8RAAqQA78xx3C-Ox4E9tLtIjKT
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a69d9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8 a=_amKiFhVn6yWzfpbwTQA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 36KzQa8RAAqQA78xx3C-Ox4E9tLtIjKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzNyBTYWx0ZWRfX0IoYNTD8lcf5
 ffqW7tBa8fWIGYffUi+9y61yX6VhA35Ern+jupTbLvRlytFTxIgqFHv8kpiIyxUxS5bvpB/D4sD
 QfxTn6+8OlXkJQxeF/PDaYWRYWCkKT/72kwOchtShsroB/J4CRV8BQxPHRLyOxD4AD1MUjaXPdE
 qp0wvYdx11D05ZN8VcJ52UNneOI3s9VOMli+apjjNa4fKsM8lX7b57Q1GtAkvvPgx8jb9PN9Zy1
 MxZBRTtJuGj1u1wdJeZ4iWp9HcB7UrAnTkhL33Yj4Krwi1VUHeDq+FprORSLImCH2lSATg9lHBD
 D95rYsI+9cOmA+h1BwuMbG8V3lYfrQLYoBsXju/g0RXcJqvXrJIIHPP1wpbZAYAreadqOtgJBkr
 Xm8X8K6mUoDoDUH5NHoLO55ir91bi6z5ED+bEqRHbj2ej02qCgAXlzjU0SH5bETMk8aXdDgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300137

On Mon, Jul 28, 2025 at 09:14:34PM +0800, Jun Nie wrote:
> Currently, SSPPs are assigned to a maximum of two pipes. However,
> quad-pipe usage scenarios require four pipes and involve configuring
> two stages. In quad-pipe case, the first two pipes share a set of
> mixer configurations and enable multi-rect mode when certain
> conditions are met. The same applies to the subsequent two pipes.
> 
> Assign SSPPs to the pipes in each stage using a unified method and
> to loop the stages accordingly.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 160 ++++++++++++++++++------------
>  1 file changed, 99 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 55429f29a4b95594771d930efe42aaa4126f6f07..e1e16a8d5ac55ba52a0f460d62901dced65e3a9e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -959,6 +959,30 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
>  }
>  
>  
> +static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
> +					       struct dpu_sw_pipe **single_pipe,
> +					       struct dpu_sw_pipe_cfg **single_pipe_cfg,
> +					       int stage_index)
> +{
> +	int pipe_idx, i, valid_pipe = 0;
> +
> +	for (i = 0; i < PIPES_PER_STAGE; i++) {

Why do you need to loop here? Is there a case when pipe 0 is not
assigned, but pipe 1 is?

> +		pipe_idx = stage_index * PIPES_PER_STAGE + i;
> +		if (drm_rect_width(&pstate->pipe_cfg[pipe_idx].src_rect) != 0) {
> +			valid_pipe++;
> +			if (valid_pipe > 1)
> +				return false;
> +
> +			if (single_pipe)
> +				*single_pipe = &pstate->pipe[pipe_idx];
> +			if (single_pipe_cfg)
> +				*single_pipe_cfg = &pstate->pipe_cfg[pipe_idx];
> +		}
> +	}
> +
> +	return valid_pipe == 1;
> +}
> +
>  static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
>  				       struct drm_atomic_state *state,
>  				       const struct drm_crtc_state *crtc_state)
> @@ -1023,17 +1047,20 @@ static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dp
>  static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>  					  struct dpu_plane_state *prev_adjacent_pstate,
>  					  const struct msm_format *fmt,
> -					  uint32_t max_linewidth)
> +					  uint32_t max_linewidth, int stage_index)
>  {
> -	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
> -	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
> -	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
> -	struct dpu_sw_pipe *prev_pipe = &prev_adjacent_pstate->pipe[0];
> -	struct dpu_sw_pipe_cfg *prev_pipe_cfg = &prev_adjacent_pstate->pipe_cfg[0];
> +	struct dpu_sw_pipe *pipe, *prev_pipe;
> +	struct dpu_sw_pipe_cfg *pipe_cfg, *prev_pipe_cfg;
>  	const struct msm_format *prev_fmt = msm_framebuffer_format(prev_adjacent_pstate->base.fb);
>  	u16 max_tile_height = 1;
>  
> -	if (prev_adjacent_pstate->pipe[1].sspp != NULL ||
> +	if (!dpu_plane_get_single_pipe_in_stage(pstate, &pipe,
> +						&pipe_cfg, stage_index))
> +		return false;
> +
> +	if (!dpu_plane_get_single_pipe_in_stage(prev_adjacent_pstate,
> +						&prev_pipe, &prev_pipe_cfg,
> +						stage_index) ||
>  	    prev_pipe->multirect_mode != DPU_SSPP_MULTIRECT_NONE)
>  		return false;
>  
> @@ -1048,11 +1075,6 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>  	if (MSM_FORMAT_IS_UBWC(prev_fmt))
>  		max_tile_height = max(max_tile_height, prev_fmt->tile_height);
>  
> -	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -	r_pipe->sspp = NULL;
> -
>  	if (dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth) &&
>  	    dpu_plane_is_parallel_capable(prev_pipe_cfg, prev_fmt, max_linewidth) &&
>  	    (pipe_cfg->dst_rect.x1 >= prev_pipe_cfg->dst_rect.x2 ||
> @@ -1181,36 +1203,69 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
>  	return 0;
>  }
>  
> +static int dpu_plane_assign_resource_in_stage(struct dpu_sw_pipe *pipe,
> +					      struct dpu_sw_pipe_cfg *pipe_cfg,
> +					      struct drm_plane_state *plane_state,
> +					      struct dpu_global_state *global_state,
> +					      struct drm_crtc *crtc,
> +					      struct dpu_rm_sspp_requirements *reqs)
> +{
> +	struct drm_plane *plane = plane_state->plane;
> +	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
> +	struct dpu_sw_pipe *r_pipe = pipe + 1;
> +	struct dpu_sw_pipe_cfg *r_pipe_cfg = pipe_cfg + 1;
> +
> +	if (drm_rect_width(&pipe_cfg->src_rect) != 0) {
> +		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
> +		if (!pipe->sspp)
> +			return -ENODEV;
> +		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +	}
> +
> +	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
> +	    dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
> +					      pipe->sspp,
> +					      msm_framebuffer_format(plane_state->fb),
> +					      dpu_kms->catalog->caps->max_linewidth))
> +		goto stage_assinged;
> +
> +	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0) {
> +		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
> +		if (!r_pipe->sspp)
> +			return -ENODEV;
> +		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +	}
> +
> +stage_assinged:
> +	return 0;
> +}
> +
>  static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>  					      struct dpu_global_state *global_state,
>  					      struct drm_atomic_state *state,
>  					      struct drm_plane_state *plane_state,
> -					      struct drm_plane_state *prev_adjacent_plane_state)
> +					      struct drm_plane_state **prev_adjacent_plane_state)
>  {
>  	const struct drm_crtc_state *crtc_state = NULL;
>  	struct drm_plane *plane = plane_state->plane;
>  	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
>  	struct dpu_rm_sspp_requirements reqs;
> -	struct dpu_plane_state *pstate, *prev_adjacent_pstate;
> +	struct dpu_plane_state *pstate, *prev_adjacent_pstate[STAGES_PER_PLANE];
>  	struct dpu_sw_pipe *pipe;
> -	struct dpu_sw_pipe *r_pipe;
>  	struct dpu_sw_pipe_cfg *pipe_cfg;
> -	struct dpu_sw_pipe_cfg *r_pipe_cfg;
>  	const struct msm_format *fmt;
> -	int i;
> +	int i, ret;
>  
>  	if (plane_state->crtc)
>  		crtc_state = drm_atomic_get_new_crtc_state(state,
>  							   plane_state->crtc);
>  
>  	pstate = to_dpu_plane_state(plane_state);
> -	prev_adjacent_pstate = prev_adjacent_plane_state ?
> -		to_dpu_plane_state(prev_adjacent_plane_state) : NULL;
> -
> -	pipe = &pstate->pipe[0];
> -	r_pipe = &pstate->pipe[1];
> -	pipe_cfg = &pstate->pipe_cfg[0];
> -	r_pipe_cfg = &pstate->pipe_cfg[1];
> +	for (i = 0; i < STAGES_PER_PLANE; i++)
> +		prev_adjacent_pstate[i] = prev_adjacent_plane_state[i] ?
> +			to_dpu_plane_state(prev_adjacent_plane_state[i]) : NULL;
>  
>  	for (i = 0; i < PIPES_PER_PLANE; i++)
>  		pstate->pipe[i].sspp = NULL;
> @@ -1225,42 +1280,27 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>  
>  	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
>  
> -	if (drm_rect_width(&r_pipe_cfg->src_rect) == 0) {
> -		if (!prev_adjacent_pstate ||
> -		    !dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate, fmt,
> -						    dpu_kms->catalog->caps->max_linewidth)) {
> -			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> -			if (!pipe->sspp)
> -				return -ENODEV;
> -
> -			r_pipe->sspp = NULL;
> +	for (i = 0; i < STAGES_PER_PLANE; i++) {
> +		if (!prev_adjacent_pstate[i])
> +			goto assignment;
>  
> -			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -		}
> -	} else {
> -		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> -		if (!pipe->sspp)
> -			return -ENODEV;
> -
> -		if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
> -						      pipe->sspp,
> -						      msm_framebuffer_format(plane_state->fb),
> -						      dpu_kms->catalog->caps->max_linewidth)) {
> -			/* multirect is not possible, use two SSPP blocks */
> -			r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> -			if (!r_pipe->sspp)
> -				return -ENODEV;
> +		if (dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate[i], fmt,
> +						   dpu_kms->catalog->caps->max_linewidth,
> +						   i))
> +			continue;


if (prev_adjacent_pstate[i] &&
    dpu_plane_try_multirect_shared())
	continue;

No need for the goto.

>  
> -			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +assignment:
> +		if (dpu_plane_get_single_pipe_in_stage(pstate, NULL, NULL, i))
> +			prev_adjacent_plane_state[i] = plane_state;
>  
> -			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -		}
> +		pipe = &pstate->pipe[i * PIPES_PER_STAGE];
> +		pipe_cfg = &pstate->pipe_cfg[i * PIPES_PER_STAGE];
> +		ret = dpu_plane_assign_resource_in_stage(pipe, pipe_cfg,
> +							 plane_state,
> +							 global_state,
> +							 crtc, &reqs);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
> @@ -1273,7 +1313,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>  			       unsigned int num_planes)
>  {
>  	unsigned int i;
> -	struct drm_plane_state *prev_adjacent_plane_state = NULL;
> +	struct drm_plane_state *prev_adjacent_plane_state[STAGES_PER_PLANE] = { NULL };
>  
>  	for (i = 0; i < num_planes; i++) {
>  		struct drm_plane_state *plane_state = states[i];
> @@ -1284,11 +1324,9 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>  
>  		int ret = dpu_plane_virtual_assign_resources(crtc, global_state,
>  							     state, plane_state,
> -							     prev_adjacent_plane_state);
> +							     &prev_adjacent_plane_state[0]);

It's exactly the prev_adjacent_plane_state.

>  		if (ret)
>  			break;
> -
> -		prev_adjacent_plane_state = plane_state;
>  	}
>  
>  	return 0;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


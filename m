Return-Path: <linux-kernel+bounces-778381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31AB2E4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E75A3AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18B225EFBF;
	Wed, 20 Aug 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVwmuNsw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F024DCE8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713849; cv=none; b=rmdaOLT9PvWQnaQs+aWupyIgQNdzGv/pLAsaI9avf+mvvtk4vYHCMAKD7lNrB2ICOq08GNHHhkCvZncqTr+XUWheUJy4b8zKKrB1LPx+54927WQQXKwgztbvFWsUVahqzqHRE1LlSOLH3w2eeC7HZOLKWJ6MlY0lwQCSM39R7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713849; c=relaxed/simple;
	bh=wIJ7lZ1d6yxKebG3gjmd5iF2qkByG75ZQtl0f9ycVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG2e0OvRyWTUdkkGMIcQLWEfXAVrsrPtDoVKlbKZoDQcFrK2+TiqpUM8uahpGLq1hbCc7biVdgUWaJgKrBBY1aCDM2AqV+Ui/PII+8zU5jGXaJNbXPbuXT82fMBcsTwPVRYuOEm80hRbAgz4ML2eUiRjz6QJAOHqbRFB+Va9cRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVwmuNsw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9rLWM025141
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u9C4HcHZFJD3vmjoUygj7UtzPAmRgrML/pdAAaTHg3Q=; b=kVwmuNswf+oEjk7V
	v8mDqF+5C2cFqzM2C3MSDZ+OQrUGXDFv+43oe/dQEMdXOgurMXe6VcS00cUXAybt
	akbmXc94WNBDbR49dPAl9NKf0gn9FFoKlxdXLfEv1SmD/uKCFC2OJu4AMa9xT56g
	up7J8m/km2BPvDhVPXd1cms1FgEyt17qRqlzUv7PfTGevMfTcs7YZarS2E/6zqeT
	S4ITKxoUM9w5WZjaNyG6tXe2Bh8XZDZiHETRTAvzQzG05OECDB2xi4NRf23s4LQw
	Fl+U9kZ29zfFq+YP3x7MKcD2ixA8MNSG+5ZY2tIje/eVX3jjGTEXFxOIk+CDwaCl
	YPpIOQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52aary3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:17:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-245fb4c8789so1508065ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713846; x=1756318646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9C4HcHZFJD3vmjoUygj7UtzPAmRgrML/pdAAaTHg3Q=;
        b=Wuicc4YIVuQzebh+sxoiNErB3hciyR+SHd5lNf/cK+ScuilzVmQmRFrkyZqTMu7s4N
         XtrOQgwrcCau5pcaViaVkRFWSEQLqgp9tBtA+ZwZFvemqQAopwl/xOUWdEJD62XdsGsl
         WQF2WEl29x4Q3mOnEANRXPQitM0J+NvZh9J+SdPZ7i/7QdGIlW85UDsoXjBTXnMlV48I
         WGSUv21fDLE/HLjxONMIMj3KjOwd7XNDNykxIa/TJYv9dvbon/hT+GkvH3c0GCfmbFa4
         2AVG9J6BMk+sgXPf/bCzvEgV4/nQ5+NV/hsmvJagBr+HdTYYdCJxMstQ9aahNYt1Gt19
         d0zw==
X-Forwarded-Encrypted: i=1; AJvYcCXSETUOQmGkRs8hZXoG7qb4WCSoHuEt6rEgkvVCUwJ98H4NzZjKE4jkTpbKLBV7hVuttQTmW7t2q0g6Ibw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Uz0z/K0qvdKO9cttd/vXC1f31XGm6TAv+zXiZECg5djYy2mc
	SKqyUvXrGpWfKdlOHzfFxOQajeLk6Yy+9tFqdbUSiKTPePDPCcLWZAAjZWWlx6CtSUHCzve9Mfv
	5HJgoqHo/nAYYXHr2xPVLCSfEIwF09BYcFt3r3OwtSbJqXALgcJTnyYbcUW1jypxIskA=
X-Gm-Gg: ASbGncumzV8pK58H3iUCNfILcZ6PizsWX6M4pf6pCFCIcly7x16lcCX7PRvETpIOw3i
	cbTpE8y1oiveUtK3ziwrZL/Gu8X7L70GuYyRTPM2m+ElWC+us0YOt2N0tkUtXwMPpaBP0kU8xXL
	kbrGo4cARP2sF+fvCFSJoYLGTaOKasVx3QoGm/6IQx2nF2s/XKBdbw96V9zHNrTST2S/Phx1W3+
	oFDCnPcI3QGp48mtahmdbcUUD3YdUgHh5heNlXncqM9+NMtz1y7g+NLPxngoBf3JHexVXOFSuiF
	lR9kImjWUs3mF55vO0lrn9itZxDXEQ1Th4ENcn+8gT0jw+vOQDfdRoqy0/RY/aUc7mcEyCnXLVD
	gtEOJRqgpC37EZOjx9xmyxw==
X-Received: by 2002:a05:6a20:939f:b0:240:356:f06e with SMTP id adf61e73a8af0-2431b548d5emr5936058637.0.1755713845994;
        Wed, 20 Aug 2025 11:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7kNMYod7lUaGEFx3dQzs4iGueuU+k5ArmIHT2LqamjvyXxSYWC8c5WozSF+SqY3xVBlkjcQ==
X-Received: by 2002:a05:6a20:939f:b0:240:356:f06e with SMTP id adf61e73a8af0-2431b548d5emr5936005637.0.1755713845242;
        Wed, 20 Aug 2025 11:17:25 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe7335sm2831365a12.14.2025.08.20.11.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 11:17:24 -0700 (PDT)
Message-ID: <4a5cab2f-1d04-4824-85b5-2f94725a0d32@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 11:17:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/13] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
To: Jun Nie <jun.nie@linaro.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
 <20250819-v6-16-rc2-quad-pipe-upstream-v15-11-2c7a85089db8@linaro.org>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250819-v6-16-rc2-quad-pipe-upstream-v15-11-2c7a85089db8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AV7ebyT3iO2yf1uzjsT1yl1UJ69Aj0jP
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a61137 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=6Bcxc3Uyk3af_q7fPysA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AV7ebyT3iO2yf1uzjsT1yl1UJ69Aj0jP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6ofQcIWR13/5
 goYwMV4ecHBOyJJEbTrwJAbBjTfFImp8EkLb+KuyJpDBlFD1U6mI4bMtYr7W7rULXwxIPT82YCt
 y0P3Ykg5s2i+wtuwFIor6OD8YoDk/eCRRMRfOjeqsNvFQTEGJxXiN68KQNPCji5vkAZnDI3SEqq
 GByO4yDWbGh3siEfZEJPLSrlVfJqU5EvVu8i0ldurLWyPUdkNQykO0fLfe0LMMELDSZZodApsgE
 C1UGhCXMYt/KxRTASsSBs20Vp37VZD9pFWqc77MLFmLjbKgRlCqHuL3csULzVEdZEuu8BuBNF7s
 NwJant3dbOmglQD2PJLfuLkrC/cu3pQcu6Ti4Hz7EqzfzkCC0kuYBAdkqNXO5nHrMqUTc9FeEms
 /dFpnMivqkY4KBD0nZmRLyFRWxBfoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/18/2025 6:31 PM, Jun Nie wrote:
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

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 150 ++++++++++++++++++------------
>   1 file changed, 89 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index d3db843d324efcda5477a7eac73a8872a55e95e5..99c902dfa7e0256028d294113a3e9bad0e1a0069 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -957,6 +957,23 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
>   		dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth);
>   }
>   
> +static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
> +					       struct dpu_sw_pipe **single_pipe,
> +					       struct dpu_sw_pipe_cfg **single_pipe_cfg,
> +					       int stage_index)
> +{
> +	int pipe_idx;
> +
> +	pipe_idx = stage_index * PIPES_PER_STAGE;
> +	if (drm_rect_width(&pstate->pipe_cfg[pipe_idx].src_rect) != 0 &&
> +	    drm_rect_width(&pstate->pipe_cfg[pipe_idx + 1].src_rect) == 0) {
> +		*single_pipe = &pstate->pipe[pipe_idx];
> +		*single_pipe_cfg = &pstate->pipe_cfg[pipe_idx];
> +		return true;
> +	}
> +
> +	return false;
> +}
>   
>   static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
>   				       struct drm_atomic_state *state,
> @@ -1022,17 +1039,20 @@ static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dp
>   static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>   					  struct dpu_plane_state *prev_adjacent_pstate,
>   					  const struct msm_format *fmt,
> -					  uint32_t max_linewidth)
> +					  uint32_t max_linewidth, int stage_index)
>   {
> -	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
> -	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
> -	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
> -	struct dpu_sw_pipe *prev_pipe = &prev_adjacent_pstate->pipe[0];
> -	struct dpu_sw_pipe_cfg *prev_pipe_cfg = &prev_adjacent_pstate->pipe_cfg[0];
> +	struct dpu_sw_pipe *pipe, *prev_pipe;
> +	struct dpu_sw_pipe_cfg *pipe_cfg, *prev_pipe_cfg;
>   	const struct msm_format *prev_fmt = msm_framebuffer_format(prev_adjacent_pstate->base.fb);
>   	u16 max_tile_height = 1;
>   
> -	if (prev_adjacent_pstate->pipe[1].sspp != NULL ||
> +	if (!dpu_plane_get_single_pipe_in_stage(pstate, &pipe,
> +						&pipe_cfg, stage_index))
> +		return false;
> +
> +	if (!dpu_plane_get_single_pipe_in_stage(prev_adjacent_pstate,
> +						&prev_pipe, &prev_pipe_cfg,
> +						stage_index) ||
>   	    prev_pipe->multirect_mode != DPU_SSPP_MULTIRECT_NONE)
>   		return false;
>   
> @@ -1047,11 +1067,6 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>   	if (MSM_FORMAT_IS_UBWC(prev_fmt))
>   		max_tile_height = max(max_tile_height, prev_fmt->tile_height);
>   
> -	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
> -	r_pipe->sspp = NULL;
> -
>   	if (dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth) &&
>   	    dpu_plane_is_parallel_capable(prev_pipe_cfg, prev_fmt, max_linewidth) &&
>   	    (pipe_cfg->dst_rect.x1 >= prev_pipe_cfg->dst_rect.x2 ||
> @@ -1180,36 +1195,69 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
>   	return 0;
>   }
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
> +	if (drm_rect_width(&pipe_cfg->src_rect) == 0)
> +		return 0;
> +
> +	pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
> +	if (!pipe->sspp)
> +		return -ENODEV;
> +	pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +	pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +
> +	if (drm_rect_width(&r_pipe_cfg->src_rect) == 0)
> +		return 0;
> +
> +	if (dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
> +					      pipe->sspp,
> +					      msm_framebuffer_format(plane_state->fb),
> +					      dpu_kms->catalog->caps->max_linewidth))
> +		return 0;
> +
> +	r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
> +	if (!r_pipe->sspp)
> +		return -ENODEV;
> +	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> +	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +
> +	return 0;
> +}
> +
>   static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>   					      struct dpu_global_state *global_state,
>   					      struct drm_atomic_state *state,
>   					      struct drm_plane_state *plane_state,
> -					      struct drm_plane_state *prev_adjacent_plane_state)
> +					      struct drm_plane_state **prev_adjacent_plane_state)
>   {
>   	const struct drm_crtc_state *crtc_state = NULL;
>   	struct drm_plane *plane = plane_state->plane;
>   	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
>   	struct dpu_rm_sspp_requirements reqs;
> -	struct dpu_plane_state *pstate, *prev_adjacent_pstate;
> +	struct dpu_plane_state *pstate, *prev_adjacent_pstate[STAGES_PER_PLANE];
>   	struct dpu_sw_pipe *pipe;
> -	struct dpu_sw_pipe *r_pipe;
>   	struct dpu_sw_pipe_cfg *pipe_cfg;
> -	struct dpu_sw_pipe_cfg *r_pipe_cfg;
>   	const struct msm_format *fmt;
> -	int i;
> +	int i, ret;
>   
>   	if (plane_state->crtc)
>   		crtc_state = drm_atomic_get_new_crtc_state(state,
>   							   plane_state->crtc);
>   
>   	pstate = to_dpu_plane_state(plane_state);
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
>   	for (i = 0; i < PIPES_PER_PLANE; i++)
>   		pstate->pipe[i].sspp = NULL;
> @@ -1224,42 +1272,24 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>   
>   	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
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
> +		if (prev_adjacent_pstate[i] &&
> +		    dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate[i], fmt,
> +						   dpu_kms->catalog->caps->max_linewidth,
> +						   i))
> +			continue;
>   
> -			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> +		if (dpu_plane_get_single_pipe_in_stage(pstate, &pipe, &pipe_cfg, i))
> +			prev_adjacent_plane_state[i] = plane_state;
>   
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
> -
> -			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> -			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> -
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
>   	}
>   
>   	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
> @@ -1272,7 +1302,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>   			       unsigned int num_planes)
>   {
>   	unsigned int i;
> -	struct drm_plane_state *prev_adjacent_plane_state = NULL;
> +	struct drm_plane_state *prev_adjacent_plane_state[STAGES_PER_PLANE] = { NULL };
>   
>   	for (i = 0; i < num_planes; i++) {
>   		struct drm_plane_state *plane_state = states[i];
> @@ -1286,8 +1316,6 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>   							     prev_adjacent_plane_state);
>   		if (ret)
>   			break;
> -
> -		prev_adjacent_plane_state = plane_state;
>   	}
>   
>   	return 0;
> 



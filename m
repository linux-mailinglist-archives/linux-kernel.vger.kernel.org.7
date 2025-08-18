Return-Path: <linux-kernel+bounces-774560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714CB2B42A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD645E56B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39724276038;
	Mon, 18 Aug 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2j6AD8O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54E223324
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556797; cv=none; b=C9+WIr/D0TuGzvqy1rNSwabIBpBEl6ePBjMJC5iMcP1FQD9SkCiWF9KhgG/0dYbIpNvxdC2h6xWVbyBDdOLqH9ocdQfgBJ9w2Yu8P/eiu/DI6nkNhNQi32CPxR+cKPqzayqWfq+5nGOvFXp4569vwOxizGNp0UqtpDnckLbRTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556797; c=relaxed/simple;
	bh=d999L0ENxwKRKD09Up9YO2/uPKobSMZ7vD0z9k1BeG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFHYF3AO7nf+sFD3orp4ibNDGhth5somha4UzfQn5yZR32tv1IJfzUqZnY5kmjKwzsyk5lYUhJFdWoUJwZZEibOmIbxN7j/tPk3o6F29bqS5u3H+JaH9QZoafd3zHruPGBSJrHUltYw+AdundR8T8DaASaelL8t7zUXxJ4lWW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2j6AD8O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IFfhZv026671
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BY1hgucLdkNvv01XAwo6wMbgTIX6hQM/0OVtxlQdU3E=; b=N2j6AD8OZFna85lc
	5ERyzh/bddCRfREKd9K8KJlnazErW5hUvVlEWfUyyLTH7rp0pjbWOXZyH36leg/h
	HgHiY6yINFPTn9CKmzeVRR4bZoyrlqLamcp5qX0eCZt0pRdVf5c/Ns35PKzhD7we
	905oulXH+G9eiCLNlG72goh0tIDtatL+tjWfQvxSxe06m+PJh4s8vaEEnRSjG58u
	4yq6kM7MC4moR5eqwRgWFR3tmjAb3G4puOKwhzAR/i9/Ed5qpn04H8U5731YiY32
	TQrSdTQH/3kwZteoLoy2hEyNFM/U4KPhSO5zaPH6qsz0Dvi2OTK2ni54CAcO7xQG
	SAdWGA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71ch4pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:39:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4731a95beeso6062387a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755556793; x=1756161593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY1hgucLdkNvv01XAwo6wMbgTIX6hQM/0OVtxlQdU3E=;
        b=PUQ9TfzdF3BPjZ0ifMzA+uCVLzzMuhrwpQ0JF7DJlbAyhqKWZT/1XCtzrk7O03HZdu
         YBh9MNXB705vZSijghtX1dwIg0Q6UCY0zpE8gA9wm+CZceVZFzVz6mBJ9z3JVbK2tTnb
         /hZputsskzNlk2AcjS9ho5lRF3CQGeJrP/Xt2LmtnzZPvT88L+6mLb8vd1IxFJJL/Auv
         P4MdEy9FTVobsWNujg4y3gDF6lpWZSQGsl41nU6Zd65DKU/rLjf7m33OjJVci9rTZ+e1
         wkhYUuiSv771RCmqeFiZopKh8xNDGYIsyuUgXxb2uMPlln0glWiXxpoGJf/MERzLH1tI
         2OtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0meK/ixMuyvfZ5BC6ig1YjTfrOkSzmi7UN9ZrRFgWUmsg4/yoPF1aPb485qCpVXO/UziUSt/4ea1Gug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1htTemyGvGIoTaSK0inv+00y3eknK6XeL94axCzOaui5/GY6H
	M9RTgFm97+IG9B4G+tBVhEXVC2DoKv7Lq755hLmjl6EjYBkXjYwdMTsQWfsylwaDuHiDvoV8ztN
	qqmP2kdvJgXe6GW757pQZTbdxFLHTnsDxzGYf0Xi/0uMKp1SpHaYlLCT9VxGR4QRgbH0nwlS1ss
	I=
X-Gm-Gg: ASbGncuIfLV4HI1mxK17I52me6FoeDd/EgNObWtU+VNXD4LkdFBxm/KH8J8qf0JZCKs
	Z1I+54IJAIYhJnbrjZHaG31UIiJqq0z3w+IXPWA10UoHWZKbPuS9bKp4CLrH4dMt0BCgw6nWBYP
	vbXg14RsmT3Pjeo9ygAxDGdMoSi2ZIWB+R6Pi5bLuS7peiwk3duKD9UVstPHgRaucNedw5kha4u
	pKdDiEshHhr645yApQ1QbBjNvvSI7MkKoPTZJkr97ihjlp2HHIH5XNt742aXfKoxp4zTHEVSzW/
	2TM4Wh616mDsmH4FM/B/3Qvw/WJc9zXSbTSqhWLFYTb9uV+JZ2NPqc4JvsCVnomjjhSyFAqJh3G
	wCkVz8dyYcCMPn7cepk6N5Q==
X-Received: by 2002:a05:6a20:3d89:b0:235:2cd8:6cb6 with SMTP id adf61e73a8af0-2430d491e52mr384038637.34.1755556793509;
        Mon, 18 Aug 2025 15:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq6QzQ92Ms9MWn6tK7XtdYkvkgmvMQ1omaaWBGATwca5iSKcTllJphXcM5JkwhGnaMgdjCwA==
X-Received: by 2002:a05:6a20:3d89:b0:235:2cd8:6cb6 with SMTP id adf61e73a8af0-2430d491e52mr383994637.34.1755556793043;
        Mon, 18 Aug 2025 15:39:53 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e81227473sm122042b3a.51.2025.08.18.15.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:39:52 -0700 (PDT)
Message-ID: <5572e441-750d-4f91-b08b-5e50f4f79ac4@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 15:39:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/13] drm/msm/dpu: split PIPES_PER_STAGE definition
 per plane and mixer
To: Jun Nie <jun.nie@linaro.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
 <20250801-v6-16-rc2-quad-pipe-upstream-v14-8-b626236f4c31@linaro.org>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250801-v6-16-rc2-quad-pipe-upstream-v14-8-b626236f4c31@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q2JszBvVWeRxOXZtEfHAXb8qG03HppBf
X-Proofpoint-GUID: Q2JszBvVWeRxOXZtEfHAXb8qG03HppBf
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a3abba cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=lKL-FtN6G_pLEYU0NVEA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX20PfrzTln8bV
 xKh2+c5GGZT1X2K8i/sZ28g2k+5MExXihVNxxSPJVt3y7vg4b31yiq0f/QcuZQFc5g9Eky4vVqC
 aPImFIst9O8VrvNX/l9+LftCAm6FAur4dbL6SpSFhy8omufY4eq6ljxQr9NladePNtT71eg/Y16
 iX5HYf7nVEhvJx+4xOYheomdZdpARBMyEuaAKTMi4Eh/zC0PGZeJO3JG+4rqrrhZpnZThhB91Me
 I4Y32YQT8fotoJkBLWvHuCfCsN3kZ184GN8hW/SMDtmfgq1TBjr1DtIOw+iOY7/oZscVWVNcEgh
 otxf3VLEGc0DWrW8zGFEVSWJvLW10Ml+ekqXMItE4VmUyZNcLVT17+EAARh9j0Twzt6pOBafvPI
 jrnqYnQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147



On 8/1/2025 8:07 AM, Jun Nie wrote:
> The stage contains configuration for a mixer pair. Currently the plane
> supports just one stage and 2 pipes. Quad-pipe support will require
> handling 2 stages and 4 pipes at the same time. In preparation for that
> add a separate define, PIPES_PER_PLANE, to denote number of pipes that
> can be used by the plane.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  7 +++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 18 +++++++++---------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  4 ++--
>   4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 121bd0d304b308bcd7226784eda14d7c7f5a46f4..30fbd7565b82c6b6b13dc3ec0f4c91328a8e94c9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -472,8 +472,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>   			bg_alpha_enable = true;
>   
> -
> -		for (i = 0; i < PIPES_PER_STAGE; i++) {
> +		for (i = 0; i < PIPES_PER_PLANE; i++) {
>   			if (!pstate->pipe[i].sspp)
>   				continue;
>   			set_bit(pstate->pipe[i].sspp->idx, active_fetch);
> @@ -1305,7 +1304,7 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
>   	return ret;
>   }
>   
> -#define MAX_CHANNELS_PER_CRTC 2
> +#define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
>   #define MAX_HDISPLAY_SPLIT 1080
>   
>   static struct msm_display_topology dpu_crtc_get_topology(
> @@ -1663,7 +1662,7 @@ static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
>   			state->crtc_x, state->crtc_y, state->crtc_w,
>   			state->crtc_h);
>   
> -		for (i = 0; i < PIPES_PER_STAGE; i++) {
> +		for (i = 0; i < PIPES_PER_PLANE; i++) {
>   			if (!pstate->pipe[i].sspp)
>   				continue;
>   			seq_printf(s, "\tsspp[%d]:%s\n",
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 175639c8bfbb9bbd02ed35f1780bcbd869f08c36..9f75b497aa0c939296207d58dde32028d0a76a6d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,6 +34,7 @@
>   #define DPU_MAX_PLANES			4
>   #endif
>   
> +#define PIPES_PER_PLANE			2
>   #define PIPES_PER_STAGE			2
>   #ifndef DPU_MAX_DE_CURVES
>   #define DPU_MAX_DE_CURVES		3
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 5e8703b0e2abb89887a5661adb3542a0c10d2b32..55429f29a4b95594771d930efe42aaa4126f6f07 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -634,7 +634,7 @@ static void _dpu_plane_color_fill(struct dpu_plane *pdpu,
>   		return;
>   
>   	/* update sspp */
> -	for (i = 0; i < PIPES_PER_STAGE; i++) {
> +	for (i = 0; i < PIPES_PER_PLANE; i++) {
>   		if (!pstate->pipe[i].sspp)
>   			continue;
>   		_dpu_plane_color_fill_pipe(pstate, &pstate->pipe[i],
> @@ -1158,7 +1158,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
>   		 * resources are freed by dpu_crtc_assign_plane_resources(),
>   		 * but clean them here.
>   		 */
> -		for (i = 0; i < PIPES_PER_STAGE; i++)
> +		for (i = 0; i < PIPES_PER_PLANE; i++)
>   			pstate->pipe[i].sspp = NULL;
>   
>   		return 0;
> @@ -1212,7 +1212,7 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>   	pipe_cfg = &pstate->pipe_cfg[0];
>   	r_pipe_cfg = &pstate->pipe_cfg[1];
>   
> -	for (i = 0; i < PIPES_PER_STAGE; i++)
> +	for (i = 0; i < PIPES_PER_PLANE; i++)
>   		pstate->pipe[i].sspp = NULL;
>   
>   	if (!plane_state->fb)
> @@ -1345,7 +1345,7 @@ void dpu_plane_flush(struct drm_plane *plane)
>   		/* force 100% alpha */
>   		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
>   	else {
> -		for (i = 0; i < PIPES_PER_STAGE; i++)
> +		for (i = 0; i < PIPES_PER_PLANE; i++)
>   			dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
>   	}
>   
> @@ -1468,7 +1468,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
>   			&fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
>   
>   	/* move the assignment here, to ease handling to another pairs later */
> -	for (i = 0; i < PIPES_PER_STAGE; i++) {
> +	for (i = 0; i < PIPES_PER_PLANE; i++) {
>   		if (!pstate->pipe[i].sspp)
>   			continue;
>   		dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
> @@ -1482,7 +1482,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
>   
>   	pstate->plane_fetch_bw = 0;
>   	pstate->plane_clk = 0;
> -	for (i = 0; i < PIPES_PER_STAGE; i++) {
> +	for (i = 0; i < PIPES_PER_PLANE; i++) {
>   		if (!pstate->pipe[i].sspp)
>   			continue;
>   		pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, fmt,
> @@ -1501,7 +1501,7 @@ static void _dpu_plane_atomic_disable(struct drm_plane *plane)
>   	struct dpu_sw_pipe *pipe;
>   	int i;
>   
> -	for (i = 0; i < PIPES_PER_STAGE; i += 1) {
> +	for (i = 0; i < PIPES_PER_PLANE; i += 1) {
>   		pipe = &pstate->pipe[i];
>   		if (!pipe->sspp)
>   			continue;
> @@ -1623,7 +1623,7 @@ static void dpu_plane_atomic_print_state(struct drm_printer *p,
>   
>   	drm_printf(p, "\tstage=%d\n", pstate->stage);
>   
> -	for (i = 0; i < PIPES_PER_STAGE; i++) {
> +	for (i = 0; i < PIPES_PER_PLANE; i++) {
>   		pipe = &pstate->pipe[i];
>   		if (!pipe->sspp)
>   			continue;
> @@ -1680,7 +1680,7 @@ void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
>   		return;
>   
>   	pm_runtime_get_sync(&dpu_kms->pdev->dev);
> -	for (i = 0; i < PIPES_PER_STAGE; i++) {
> +	for (i = 0; i < PIPES_PER_PLANE; i++) {
>   		if (!pstate->pipe[i].sspp)
>   			continue;
>   		_dpu_plane_set_qos_ctrl(plane, &pstate->pipe[i], enable);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> index 007f044499b99ac9c2e4b58e98e6add013a986de..1ef5a041b8acae270826f20ea9553cbfa35a9f82 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> @@ -31,8 +31,8 @@
>    */
>   struct dpu_plane_state {
>   	struct drm_plane_state base;
> -	struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
> -	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
> +	struct dpu_sw_pipe pipe[PIPES_PER_PLANE];
> +	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_PLANE];
>   	enum dpu_stage stage;
>   	bool needs_qos_remap;
>   	bool pending;
> 



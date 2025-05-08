Return-Path: <linux-kernel+bounces-640460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF6AB0507
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E5E5011BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8B21CA12;
	Thu,  8 May 2025 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xy4lvyE1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFE4B1E72;
	Thu,  8 May 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737764; cv=none; b=Yk2Lf75cL5eaKsyxpdjZ1MlCVRpnYehvru3+V4rlbx6ROkWFmYo3Hfeqe6Icz6/wxNme+guPt13kt4VtWTz7QcVVGm+JwGie5h5G8Bl+OATn6I614ia3qetJV0cY9noJt0ZOqQZ0G88Bs/yvqJr+uyXKYYBTf6Oiw8uO1nmzV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737764; c=relaxed/simple;
	bh=obTiOEUdBWsOb3bQ+1OntKQQZw6cZ+XDIirVRO6li/U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qiOOLy49L145KG0oQc0ROWqYfkMkxuW1KaFpeY5c4zxzAHqz7LpWtx2Tdyqqi19g4Rm1u0MMpVewEC3rxzKYnHQ8XguroPL4Q51xsJ7RW8sQ9k2VZGcwMozLTUzynoGvSPTCIemot2bd58DWVS0gFHCtUmP50IBlJvPioWpejiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xy4lvyE1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Ck9h9025053;
	Thu, 8 May 2025 20:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzOI7LfRJd6r+1sUxk8p8aS+DvCjFCD9LE5InxZfQIw=; b=Xy4lvyE1+QX4t3+A
	on7e65GZQVd3XX/uWxKpWsaz84oPIP3bo3KqRrtmxuToBueaTMdW8YP9hIdXsXVr
	HAjuzYahun4KcEufKEajz4pEkLw0izq8YDDG62ou3JwCiylplB4Esa4txcpfDhQU
	hutR9MosOwrMlSKtSYauyYFlARnXStL8t8dZJxe2MbJduRpF+REaO41dz+pEUgKB
	c4XD9nKK+EYirW/UChz28zWBIlwYT1Kds15EE1LAJG3CBTMWP1UQAdDgR7OMSfrB
	2ZDG+tjqdc/eyV00ak/DV3HEE68GSsgOmtSXpQzqexOQ6h5I2glGbv2X4MB4juck
	udwNgg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp12kjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 20:55:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 548Ktoi0001919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 20:55:50 GMT
Received: from [10.134.71.99] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 13:55:49 -0700
Message-ID: <0fcad5ac-e1b3-41ef-9d29-0c801aa4fc51@quicinc.com>
Date: Thu, 8 May 2025 13:55:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/14] drm/msm/dpu: split PIPES_PER_STAGE definition
 per plane and mixer
From: Jessica Zhang <quic_jesszhan@quicinc.com>
To: Jun Nie <jun.nie@linaro.org>, Rob Clark <robdclark@gmail.com>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        "Marijn
 Suijten" <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <lumag@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org>
 <20250506-quad-pipe-upstream-v9-9-f7b273a8cc80@linaro.org>
 <0dace5ee-8c81-4181-ae0d-7f317b7f5ac9@quicinc.com>
Content-Language: en-US
In-Reply-To: <0dace5ee-8c81-4181-ae0d-7f317b7f5ac9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE4OCBTYWx0ZWRfXyzT5IlcipPCJ
 mOjETHNFfm/v1+uc8Sg//AEaqpbtdQbqJM4VnouXPjoTxaLYX6EI+PWaBHUBT6MtjU8qE3Pw3c6
 BN9mGR/ga/+7WI7o5pOgoHXSBIzxDYx0ahTWE+A7+KzKOs0iQKNGa+NLtVtTzVKRG/kgTPcdYAf
 blEfANN+uqGmXJGABCfiaEwH1Noz5Go5ZTG9lKFjpM4HNbYs3J+1Ac59/UAFvVA7Pqsn7NVGKRc
 iBFy6CoCQHBhY4AJdHQeUapVufQs2/H6lU6wSqAoVwV0jlqKC6gmId4dVVZ4io/C2k8qTbUKwjD
 BZwcUH6ZOZv6w4/uGJGvQS0WoXk2lMeMSrGbKZNYDN2+e8RG8mNMfZhxc3vU5XJLqGlJsoHvP8Y
 yDW3wAZvY5c/c4S4ojXneCi5As81B/HrqrjnOXrg8YI2heepZdBhR4vvh7qI4OhSyDjBHEzz
X-Proofpoint-GUID: -bLl04JoBD_5RIGsLlMNFbbSsYdgpD4c
X-Proofpoint-ORIG-GUID: -bLl04JoBD_5RIGsLlMNFbbSsYdgpD4c
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681d1a56 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8
 a=KKAkSRfTAAAA:8 a=bTPyCqm97e257EEOoakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_06,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080188



On 5/8/2025 1:42 PM, Jessica Zhang wrote:
> 
> 
> On 5/6/2025 8:47 AM, Jun Nie wrote:
>> The stage contains configuration for a mixer pair. Currently the plane
>> supports just one stage and 2 pipes. Quad-pipe support will require
>> handling 2 stages and 4 pipes at the same time. In preparation for that
>> add a separate define, PIPES_PER_PLANE, to denote number of pipes that
>> can be used by the plane.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Hi Jun,
> 
> I think the comment from v7 about propogating the PIPES_PER_PLANE change 
> to _dpu_plane_color_fill() got dropped in this version [1].

s/propogating/propagating/

> 
> Also, any reason PIPES_PER_STAGE was kept for 
> dpu_plane_danger_signal_ctrl()?

I have the same question for _dpu_debugfs_status_show(). It seems to me 
both helpers should be using PIPES_PER_PLANE.

Thanks,

Jessica Zhang

> 
> Thanks,
> 
> Jessica Zhang
> 
> [1] https://patchwork.freedesktop.org/patch/640534/? 
> series=139762&rev=6#comment_1171802
> 
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ++--
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 14 +++++++-------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  4 ++--
>>   4 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/ 
>> drm/msm/disp/dpu1/dpu_crtc.c
>> index 
>> 6338603bf8be9fcc4324b098d5d69d20235cdbae..d710b4eec7ad946a4cf74d6ac5f4db90e8dcf1fd 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> @@ -463,7 +463,7 @@ static void _dpu_crtc_blend_setup_mixer(struct 
>> drm_crtc *crtc,
>>           if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>>               bg_alpha_enable = true;
>> -        for (i = 0; i < PIPES_PER_STAGE; i++) {
>> +        for (i = 0; i < PIPES_PER_PLANE; i++) {
>>               if (!pstate->pipe[i].sspp)
>>                   continue;
>>               set_bit(pstate->pipe[i].sspp->idx, fetch_active);
>> @@ -1272,7 +1272,7 @@ static int dpu_crtc_reassign_planes(struct 
>> drm_crtc *crtc, struct drm_crtc_state
>>       return ret;
>>   }
>> -#define MAX_CHANNELS_PER_CRTC 2
>> +#define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
>>   #define MAX_HDISPLAY_SPLIT 1080
>>   static struct msm_display_topology dpu_crtc_get_topology(
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/ 
>> gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>> index 
>> 8d820cd1b5545d247515763039b341184e814e32..b0ed41108a32158c0bc3be2e25fc229b218fd6c5 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>> @@ -34,6 +34,7 @@
>>   #define DPU_MAX_PLANES            4
>>   #endif
>> +#define PIPES_PER_PLANE            2
>>   #define PIPES_PER_STAGE            2
>>   #ifndef DPU_MAX_DE_CURVES
>>   #define DPU_MAX_DE_CURVES        3
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/ 
>> drm/msm/disp/dpu1/dpu_plane.c
>> index 
>> 4cb81a6a692be51d342d9a6f322b632e5fd07b2c..ea7e3fdf52f726737941ad33218a843dca17280b 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> @@ -1078,7 +1078,7 @@ static int dpu_plane_virtual_atomic_check(struct 
>> drm_plane *plane,
>>            * resources are freed by dpu_crtc_assign_plane_resources(),
>>            * but clean them here.
>>            */
>> -        for (i = 0; i < PIPES_PER_STAGE; i++)
>> +        for (i = 0; i < PIPES_PER_PLANE; i++)
>>               pstate->pipe[i].sspp = NULL;
>>           return 0;
>> @@ -1129,7 +1129,7 @@ static int 
>> dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>>       pipe_cfg = &pstate->pipe_cfg[0];
>>       r_pipe_cfg = &pstate->pipe_cfg[1];
>> -    for (i = 0; i < PIPES_PER_STAGE; i++)
>> +    for (i = 0; i < PIPES_PER_PLANE; i++)
>>           pstate->pipe[i].sspp = NULL;
>>       if (!plane_state->fb)
>> @@ -1240,7 +1240,7 @@ void dpu_plane_flush(struct drm_plane *plane)
>>           /* force 100% alpha */
>>           _dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
>>       else {
>> -        for (i = 0; i < PIPES_PER_STAGE; i++)
>> +        for (i = 0; i < PIPES_PER_PLANE; i++)
>>               dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
>>       }
>> @@ -1363,7 +1363,7 @@ static void dpu_plane_sspp_atomic_update(struct 
>> drm_plane *plane,
>>               &fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
>>       /* move the assignment here, to ease handling to another pairs 
>> later */
>> -    for (i = 0; i < PIPES_PER_STAGE; i++) {
>> +    for (i = 0; i < PIPES_PER_PLANE; i++) {
>>           if (!pstate->pipe[i].sspp)
>>               continue;
>>           dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
>> @@ -1377,7 +1377,7 @@ static void dpu_plane_sspp_atomic_update(struct 
>> drm_plane *plane,
>>       pstate->plane_fetch_bw = 0;
>>       pstate->plane_clk = 0;
>> -    for (i = 0; i < PIPES_PER_STAGE; i++) {
>> +    for (i = 0; i < PIPES_PER_PLANE; i++) {
>>           if (!pstate->pipe[i].sspp)
>>               continue;
>>           pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, 
>> fmt,
>> @@ -1396,7 +1396,7 @@ static void _dpu_plane_atomic_disable(struct 
>> drm_plane *plane)
>>       struct dpu_sw_pipe *pipe;
>>       int i;
>> -    for (i = 0; i < PIPES_PER_STAGE; i += 1) {
>> +    for (i = 0; i < PIPES_PER_PLANE; i += 1) {
>>           pipe = &pstate->pipe[i];
>>           if (!pipe->sspp)
>>               continue;
>> @@ -1518,7 +1518,7 @@ static void dpu_plane_atomic_print_state(struct 
>> drm_printer *p,
>>       drm_printf(p, "\tstage=%d\n", pstate->stage);
>> -    for (i = 0; i < PIPES_PER_STAGE; i++) {
>> +    for (i = 0; i < PIPES_PER_PLANE; i++) {
>>           pipe = &pstate->pipe[i];
>>           if (!pipe->sspp)
>>               continue;
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/ 
>> drm/msm/disp/dpu1/dpu_plane.h
>> index 
>> 052fd046e8463855b16b30389c2efc67c0c15281..18ff5ec2603ed63ce45f530ced3407d3b70c737b 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
>> @@ -33,8 +33,8 @@
>>   struct dpu_plane_state {
>>       struct drm_plane_state base;
>>       struct msm_gem_address_space *aspace;
>> -    struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
>> -    struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
>> +    struct dpu_sw_pipe pipe[PIPES_PER_PLANE];
>> +    struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_PLANE];
>>       enum dpu_stage stage;
>>       bool needs_qos_remap;
>>       bool pending;
>>
> 



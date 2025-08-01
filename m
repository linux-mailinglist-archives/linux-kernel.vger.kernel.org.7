Return-Path: <linux-kernel+bounces-753689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA3B1866A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C47AFBB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33F1DE3CA;
	Fri,  1 Aug 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HcaSaINw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862719C546
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068646; cv=none; b=H1ZX7Qqn9bj4RbNqaRk3FFYb3GSbk4ryLNNCcooS3vMqUlp7tHH2h1wfow13tQ3gP+CVtgsUOJl0AN9gi70a5mVMyB4F1rt1OJoB5gC9XHW05u20Owwbya7/SwYKpICiH4rxew+Jbf5SUB7g0uouaJm+NPXyf2g/U7ogo78JkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068646; c=relaxed/simple;
	bh=gau3zInaz8TfxyhE6UquwFBWoLVAXo7PE7fMYClHbOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPzDCg99NMCzpx/sfQUsD9MuEGELkAikwx2k0WfGftzZ8RhlURTeZ3YSsY8/c3C5NxEj+EF47rdzpyRGwWOoE6qTRb3Qkk4fS0COAtfdgsJTvzPURXS936ezQk2sBAc0vDb/ZraR3whbpNaChLpWd/0N4tvjGI2ZZdaYOf4/jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HcaSaINw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719PB9E020320
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 17:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tcHaBQuDwa1ZE5v+k3+Pq4tj
	ndoraV1eMdugB4VbHQk=; b=HcaSaINwoYx9biLMK6dAfKkUszEDfQRgOjaUIsli
	4VaIeuyS5hVeUoQvAobR5bDB9dnjO2lc88wICa5WI0Cq0pBWgVLwT55/lkl62Kax
	2k+AhSwgtMJoMdSIHrmSk+8nUVNqzjrA+VaFj7mcaeOLb2vkrafJ+eFOyAbM2Vc0
	5x9A/dA9HuG5CPJlpe92M+g+5I9u+P+ROVK3p60lfHs1RDv2TEH7Nr75k5QOpgJF
	LLdXClIacAlu3UrlTlEE8NpfHeL6dInTTWlC0pKmqIS59Ady0FJmo5ym2ASGzhkh
	uWkOxTskjsvCAWXOvQlu+PhoRc7t1ZfrisTWgIqbdw6RFg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1avhd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:17:23 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-875af9a84d8so1000840241.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068643; x=1754673443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcHaBQuDwa1ZE5v+k3+Pq4tjndoraV1eMdugB4VbHQk=;
        b=Z14zyXEBHXWmUjPputapllhR2wfAHQtdW6opEQZH/aC3k1x8VOatl13w2OaMKHCw+0
         3CSJkntToiVYVjoKdAO2ir9dZlyvzP/KHWO5wSykZ3qZUX1ZigPhLJ9lNyrYii82h5OH
         9Vny+mlwWXmNKDgzb3mvDCP/sbBw3iEC0ibod9I/+NRzHIN+R/72mp89scgqLkFXAoIE
         wvKP+jJnT3Wmud71TTH/3kyPUD3vSLdZvjD2Nvsq7la7cT4OJXJ3263aYu/VtnTiXvwy
         rtNdhR9T48TNLb8X4+qUqa60U74zu8mI7yXLSn9pIp9JcnGrB27I3GPRiC0VX33NWwHQ
         oHxw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+jY5sfq30nuYYi2olNXiFRwyH7R9ghe/rtiXGF7jXcwzplwrCMAAnDjcBcmAa8hRFZLGa3RX7EkD0hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKdzEJ0lchSkIg+hYXOJlyQtpOVfd/RwE0FvKVXWSED4MCZYV
	HSeXpNLvxPrKTY6UAIfp4g/wAMNQjltuxPeXhfA9E8JJR26q07r7okfeDmH5dPXYEH4wQEeHtP9
	3+FBGmP8LbbFrFgM8pJyngt3HwJHUDUx3pw+G6242V/tKbju4iCBfquCpWfzU5Id8YTc6mfP7rd
	E=
X-Gm-Gg: ASbGncv3495Tsjt6Z5dQcefC7Jr2Ox+RJ8k9U/gYksACNUW7aP1+z9KAa1cxwLW3CTj
	SBcUZwAr0LEoQQdwzKUW4KUhpyVeXu2YfB3y/vWm9EwqMYgJ/JgtOkTdLDHx0rEqfwocKO1hPrP
	97hDS37l+Av+wMysfe07eGy98aXdjfL3zfZmarv2zUIagVs4nHQr0xmXaTj9jH1UvD70OnBINDM
	OE+2Qy+IgeQkRUiXye2uLAUN898isJG0sFTkLXcmgsZ1e3pZxFsicq0naS7DiX8gYpOQAVDkA/A
	aJnSHXo9izSxE5BMRL7A4pXS+e0u+Lc6at8sF5oDSHXBrd3oKhNxlfWJHMgNAMDl+NR0cES759k
	qDnzS7FwAJyaHE0wu67rUdd3htRIiWDRd9Ebxofl+vLCTJCJWiTzd
X-Received: by 2002:a05:6102:dcb:b0:4db:154f:aa02 with SMTP id ada2fe7eead31-4fdc1f384f4mr101989137.1.1754068642844;
        Fri, 01 Aug 2025 10:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVuQPnE9jDf3e0O6nex/ypiEGC/lp11qe6uAM8yV+lPx1/MwQJoC1CoJZFxb4EtvLk8nU0Rw==
X-Received: by 2002:a05:6102:dcb:b0:4db:154f:aa02 with SMTP id ada2fe7eead31-4fdc1f384f4mr101949137.1.1754068642360;
        Fri, 01 Aug 2025 10:17:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb8asm668546e87.145.2025.08.01.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:17:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:17:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/13] drm/msm: Do not validate SSPP when it is not
 ready
Message-ID: <3pkmepbcppjtgr2pavxzh2becu6r3ddqkgzyn3av2uwipbrvia@4cjijtbfvfo5>
References: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
 <20250801-v6-16-rc2-quad-pipe-upstream-v14-1-b626236f4c31@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-v6-16-rc2-quad-pipe-upstream-v14-1-b626236f4c31@linaro.org>
X-Proofpoint-ORIG-GUID: 5MJQ0OX5tEgqiV1PwaVmQCGS4VG1HVaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzNCBTYWx0ZWRfX5yCYxviBF7vY
 wD4M61lqAEx1Be274TK3Q5V3ChTgUtCjrWLhF4j1DbjJismkrdV3TuWrXNQW51wunq0mrdSdLTv
 HZcdoNe4N+XbqI7LvAw7eR/iF9o2903VP9YhSu/Z1AKd3jhL1XYN+Zu+3VHWeHQbMtg+NnZrLX7
 B7Ct6dHuYB0+spF6865uV/jM5Vo8gNkKzLPrIBJgwYwcJtUKbauldTFIvXPUgqDqZIFlGoyam2l
 iDqIeiVlr2loVrm0BdgK4E54hXybYZ4TLPWChWGg3XuqEZWuusKZpiIEJZh5JJxrEFYbm+72Lde
 UtCMaj55NnFn22o+SyHQbmEsxaawFNw+f8aaJA/4XqSCu68txMgdVz4z+qAeFUnhjRecp0G69lv
 kUMaGzVnbyCXz52BV5Ije13h8EJF3MoynbXyad+Za/0VI/xmuL/eVGqykMfoi5yj/EmP21Co
X-Proofpoint-GUID: 5MJQ0OX5tEgqiV1PwaVmQCGS4VG1HVaR
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688cf6a3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=R_82AcX6jhCS_hus:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=2eMu2khG-ckBsvoFBtQA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010134

On Fri, Aug 01, 2025 at 11:07:25PM +0800, Jun Nie wrote:
> Current code will validate current plane and previous plane to
> confirm they can share a SSPP with multi-rect mode. The SSPP
> is already allocated for previous plane, while current plane
> is not associated with any SSPP yet. Null pointer is referenced
> when validating the SSPP of current plane. Skip SSPP validation
> for current plane.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000888ac3000
> [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in:
> CPU: 4 UID: 0 PID: 1891 Comm: modetest Tainted: G S                  6.15.0-rc2-g3ee3f6e1202e #335 PREEMPT
> Tainted: [S]=CPU_OUT_OF_SPEC
> Hardware name: SM8650 EV1 rev1 4slam 2et (DT)
> pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : dpu_plane_is_multirect_capable+0x68/0x90
> lr : dpu_assign_plane_resources+0x288/0x410
> sp : ffff800093dcb770
> x29: ffff800093dcb770 x28: 0000000000002000 x27: ffff000817c6c000
> x26: ffff000806b46368 x25: ffff0008013f6080 x24: ffff00080cbf4800
> x23: ffff000810842680 x22: ffff0008013f1080 x21: ffff00080cc86080
> x20: ffff000806b463b0 x19: ffff00080cbf5a00 x18: 00000000ffffffff
> x17: 707a5f657a696c61 x16: 0000000000000003 x15: 0000000000002200
> x14: 00000000ffffffff x13: 00aaaaaa00aaaaaa x12: 0000000000000000
> x11: ffff000817c6e2b8 x10: 0000000000000000 x9 : ffff80008106a950
> x8 : ffff00080cbf48f4 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000438 x3 : 0000000000000438
> x2 : ffff800082e245e0 x1 : 0000000000000008 x0 : 0000000000000000
> Call trace:
>  dpu_plane_is_multirect_capable+0x68/0x90 (P)
>  dpu_crtc_atomic_check+0x5bc/0x650
>  drm_atomic_helper_check_planes+0x13c/0x220
>  drm_atomic_helper_check+0x58/0xb8
>  msm_atomic_check+0xd8/0xf0
>  drm_atomic_check_only+0x4a8/0x968
>  drm_atomic_commit+0x50/0xd8
>  drm_atomic_helper_update_plane+0x140/0x188
>  __setplane_atomic+0xfc/0x148
>  drm_mode_setplane+0x164/0x378
>  drm_ioctl_kernel+0xc0/0x140
>  drm_ioctl+0x20c/0x500
>  __arm64_sys_ioctl+0xbc/0xf8
>  invoke_syscall+0x50/0x120
>  el0_svc_common.constprop.0+0x48/0xf8
>  do_el0_svc+0x28/0x40
>  el0_svc+0x30/0xd0
>  el0t_64_sync_handler+0x144/0x168
>  el0t_64_sync+0x198/0x1a0
> Code: b9402021 370fffc1 f9401441 3707ff81 (f94010a1)
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 3ed12a3664b36 ("drm/msm/dpu: allow sharing SSPP between planes")
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 01171c535a27c8983aab6450d6f7a4316ae9c4ee..4371c8e1602126bdd0860c5de263db3dd2d3291a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -910,7 +910,8 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
>  
>  static int dpu_plane_is_multirect_capable(struct dpu_hw_sspp *sspp,
>  					  struct dpu_sw_pipe_cfg *pipe_cfg,
> -					  const struct msm_format *fmt)
> +					  const struct msm_format *fmt,
> +					  bool validate_sspp)
>  {
>  	if (drm_rect_width(&pipe_cfg->src_rect) != drm_rect_width(&pipe_cfg->dst_rect) ||
>  	    drm_rect_height(&pipe_cfg->src_rect) != drm_rect_height(&pipe_cfg->dst_rect))
> @@ -922,6 +923,9 @@ static int dpu_plane_is_multirect_capable(struct dpu_hw_sspp *sspp,
>  	if (MSM_FORMAT_IS_YUV(fmt))
>  		return false;
>  
> +	if (!validate_sspp)
> +		return true;

if (!sspp)
	return true;

> +
>  	if (!test_bit(DPU_SSPP_SMART_DMA_V1, &sspp->cap->features) &&
>  	    !test_bit(DPU_SSPP_SMART_DMA_V2, &sspp->cap->features))
>  		return false;
> @@ -945,7 +949,7 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
>  						   const struct msm_format *fmt,
>  						   uint32_t max_linewidth)
>  {
> -	return dpu_plane_is_multirect_capable(sspp, pipe_cfg, fmt) &&
> +	return dpu_plane_is_multirect_capable(sspp, pipe_cfg, fmt, true) &&
>  		dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth);
>  }
>  
> @@ -1028,8 +1032,9 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>  	    prev_pipe->multirect_mode != DPU_SSPP_MULTIRECT_NONE)
>  		return false;
>  
> -	if (!dpu_plane_is_multirect_capable(pipe->sspp, pipe_cfg, fmt) ||
> -	    !dpu_plane_is_multirect_capable(prev_pipe->sspp, prev_pipe_cfg, prev_fmt))
> +	/* Do not validate SSPP of current plane when it is not ready */
> +	if (!dpu_plane_is_multirect_capable(pipe->sspp, pipe_cfg, fmt, false) ||
> +	    !dpu_plane_is_multirect_capable(prev_pipe->sspp, prev_pipe_cfg, prev_fmt, true))
>  		return false;
>  
>  	if (MSM_FORMAT_IS_UBWC(fmt))
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


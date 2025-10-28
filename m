Return-Path: <linux-kernel+bounces-874321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597AC16073
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 606FA4E7773
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC81345CAF;
	Tue, 28 Oct 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5WeeqEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sdo6NvXn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385E28AAEE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670967; cv=none; b=arMeFi3F7kWwF8JQFpmDrZR0dbIdkviWXUzZWKlK+cdUfzkMhXz4z9BtZkyvE1bPcapvTdRZh0stDd7ZGlNtiYyko/9aDljUVwNjdnAyAsZidBe8VIIV6z55yukRoHWm99ITmH9A0Gsi2brJI0k8mK/NVb0l8GUXsCQ1iW7d3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670967; c=relaxed/simple;
	bh=b6bFiqRfaqkqduCHw5Jtu3028bY0/oBvz28HabqE+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdI0E5YmQ5MYAOyg0xFKpfkhIWnDqfz+VcyzWB66r9PiwxfDyy31O8VpR0thhPxj86QxueRQ+sTMTymq4+Krq8ojX9YsKVIldL2CbL8Td92R+0V5I+6RrO22xINurzxCcbtgKLUU7iqukaZ2PmUi6nN2wQr9XhYceKjHAjAXbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5WeeqEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sdo6NvXn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEoOPI1861142
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cxkp5uN1hgEm1U7CQUVNW25h
	7bex2SPSJGWvI/3+x5g=; b=O5WeeqEgym/Ed2fgGBQMV6HSxphMhBfeNluJHd1n
	YEfHstEthnB/DoPpsTjyRIiu7yldRCJRYfWemRT/RMH9gtf0tVNsP/tAXpt+5iQh
	hwktCzhnbuYqw+zjjS5OGwp9l8GhWImoC7Du3RAPAvCgGMh++TzymCbLvQ9P/JQ5
	aSFvcfJlBFQM2gEDnxsW6ff/lNqaNaJNhv3CiDTQ47cbi+VZslZ/r7obTzZpN9iU
	qk3P9N7WZUBUkNUPZU+3+xuGdxx3+yTZzgVwfGICkeaz2KfO+gWwMRqbB0C6KRWJ
	AMhsWaVNvtEggSym9aXFtPjW9op3o80FLZ+yK5tdocunEw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2ur3h9vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:02:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54aa7b50e26so3675318e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761670964; x=1762275764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxkp5uN1hgEm1U7CQUVNW25h7bex2SPSJGWvI/3+x5g=;
        b=Sdo6NvXngu5dp/SXvY0jbfQa1J7pneUiLGl4nx88GmdOzRcYLzIPMfjxQ0auFr4ESk
         tRv+UGWW2LD17cRCv+30+EEx2BXjrVWqf+qVwQIyMyVQr/1paWn/HcBkY1+ql9SRXtRr
         wGEshfXYW9Dzy5+5XsD8wtCGZOtqvs9ax9nboQYKyiyhJ+gdRW9wEezaCnX27EH50t6P
         raqMTJ0nM3FRS667Nd+9W/d3NYi8dHUWUaLcvau0892dng1ycLJYIAgjv9oDZjIBYNGH
         L/UEhUnquAuSecREQxODVPZgJVufy2Jgc71dKVwCVMK348jZwSurtT9JyLmXWKcwSTB8
         vZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670964; x=1762275764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxkp5uN1hgEm1U7CQUVNW25h7bex2SPSJGWvI/3+x5g=;
        b=dtG6+qaINdBJG5Xg76h9RaeT/Pib6qGMhsi5GoPoaMiZ1U2Dn5V2DPOA1Vzb1+y1d8
         uMlqGdPICaLpINh+C5cemhD8wkWaIunJ3GFoKmOA0T2PgjD9jVXtva8zsKbAoOyCCgCY
         gfefpXMrdT7FEbDetSib9Je7BeJwEsxxmnB6qYPyn9GV+LI4bk45SxKJ48xGPTQg5bjz
         VKYniltWpI8lJhTbqyHOWHncByOqFwyzrDwL+brcqPbUC6ifRGcHOYGR6cYWigWaDFmS
         9RKp+SVje5Iv4PCepV02nM8+Yf1B/oOS26nC9iJQ+fLGLbWzDqV3RZGsO6IAm02Q5lYO
         0Yog==
X-Forwarded-Encrypted: i=1; AJvYcCV0VWCfPaGUbI4IWcTla01IME0IoSYnD+3roxKVvnQXCQPhXZl0uuSSo7saFnSL//IpxYB3vCScVfbliFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwk96q3cW1R46how1NYBgbldQif7PUC4I01ea6qUF6jv7bKFYR
	bdieNDFMKJX5/DT4boDt/IkKz07+I4ucOxOHafotYvrLnnhpEswvguCbFuP7K/cva+nCcp4jybN
	r2WCDIhkPGM5LzuxCmZkcHUnIIh/bO3nyISebw0ECUZ8x+0BwqMN9LfLevZBwdLHOZFo=
X-Gm-Gg: ASbGncudfWPR3oQTiilbPO/E2V7E5X63+0UfPRuASG85gfY3Bj1H8Vb/s5GIa375JF/
	zMUCJObxyIJSzaYVrJgj77mtJM6IDs6xFbbB3f/MmSIy4SGMLYUCxG5dGeuqmzrs29XJlaKQJL0
	xOKa1TvrsDfPtwEy7KTsTJZrUTXPN5OQelCLFQZNit0iaWLTd60EB0vIszkiz25rxccyvFpF5en
	MvRb92cTW8xPpuHP3PHePgFkMwudE7OVPIyPcpB/fW4KkB/zN7urRYLJr/wENc4dhL5vJjDSQPU
	Bh9IOIVKg9Ai/nzcviRCEqd+HS5CTgCoOPnzf0tJkQa9Lcm9BAjshyOZM1eQUWrSlRYvWyUbie1
	qVVEvcSCMCJ2fBfEP/u4KpdNJDwJmHrLf1cnDqNH9ZP7Qpk6UfZCwabbNUnMfOTuqiYKhxzUz7g
	8YuFGIfceM3v5F
X-Received: by 2002:a05:6123:2eb:b0:544:c8bf:6504 with SMTP id 71dfb90a1353d-55812a5716dmr211461e0c.12.1761670959978;
        Tue, 28 Oct 2025 10:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFylu7+GWulmg8QmGwQJyndA+hF5O5s0KQz/TRjUhN57ySnCjdNwxNX2a1vWTcx0/uWdHcc3A==
X-Received: by 2002:a05:6123:2eb:b0:544:c8bf:6504 with SMTP id 71dfb90a1353d-55812a5716dmr210602e0c.12.1761670952807;
        Tue, 28 Oct 2025 10:02:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0c61a7sm26970681fa.28.2025.10.28.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:02:31 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:02:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Teguh Sobirin <teguh@sobir.in>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Set vsync source irrespective of mdp top
 support
Message-ID: <ukz4djjytsne3y2w3epkdc7gzegmeeijpcqblvftcx73ccs43p@es6b4ew4nrzx>
References: <TYUPR06MB6099CBBE5090DB12A2C187E3DDFDA@TYUPR06MB6099.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYUPR06MB6099CBBE5090DB12A2C187E3DDFDA@TYUPR06MB6099.apcprd06.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NSBTYWx0ZWRfX1wlD0e9UUKCg
 G6JP7hQLYDCNzGcq3NiYVV9TofxMENHi4ZnbrO8fDJf2gUGGGpPVGNeo5dF7t9s/UFjQfyflHQm
 RGn+uaweG99ejKrYEfp8m+nFNzNN5SqcjregUG0cRsScKr74Y27w49h+4FufOoN+13rDQL25Nv2
 iLJPHvn/5FcPqW3OTL6UyHCzqXz4W2tSVVmhAv8XPZydM9owC1INR5DPyYUzh6Nvbx+N7TlDmA6
 sAeLZRv/GXCzmKIo6UP1+hiMPSftSB1M8U/iJ1ApwsjmFbC7IxT/vBeEdMauv7YwWa4cDxBB6rC
 93dnzbELO1/nxZYnLqp4ynAdRFsKUeG4zPu0gYquW0Um6jlmW/KPo0PHgubHhHQ3l2gM7zzg9SZ
 xLlWpplpH8IsCXXi8ZfwHRgl7MVCbA==
X-Authority-Analysis: v=2.4 cv=Jub8bc4C c=1 sm=1 tr=0 ts=6900f734 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DMwz6m7ubag84I2EhSAA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: z2PS4bKzJizqtbMe5_CPiFSLn10AzgNX
X-Proofpoint-ORIG-GUID: z2PS4bKzJizqtbMe5_CPiFSLn10AzgNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280145

On Tue, Oct 28, 2025 at 08:36:35PM +0800, Teguh Sobirin wrote:
> Move the loop over phys_encs outside the
> hw_mdptop->ops.setup_vsync_source block.
> This way, vsync_sel() is called for each interface.
> 
> This change ensures TE vsync selection works
> even if setup_vsync_source is not implemented.

Please see Documentation/processs/submitting-patches.rst. Don't describe
the change and pleasw wrap the commit message on 72-75 chars boundary.

I can suggest something like this:

Since DPU 5.x the vsync source TE setup is split between MDP TOP and
INTF blocks.  Currently all code to setup vsync_source is only exectued
if MDP TOP implements the setup_vsync_source() callback. However on
DPU >= 8.x this callback is not implemented, making DPU driver skip all
vsync setup. Move the INTF part out of this condition, letting DPU
driver to setup TE vsync selection on all new DPU devices.

The patch itself looks good to me.

> 
> Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 22 +++++++++------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 258edaa18fc0..f36c5c7924a3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -784,24 +784,20 @@ static void _dpu_encoder_update_vsync_source(struct dpu_encoder_virt *dpu_enc,
>  		return;
>  	}
>  
> +	/* Set vsync source irrespective of mdp top support */
> +	vsync_cfg.vsync_source = disp_info->vsync_source;
> +
>  	if (hw_mdptop->ops.setup_vsync_source) {
>  		for (i = 0; i < dpu_enc->num_phys_encs; i++)
>  			vsync_cfg.ppnumber[i] = dpu_enc->hw_pp[i]->idx;
> +	}
>  
> -		vsync_cfg.pp_count = dpu_enc->num_phys_encs;
> -		vsync_cfg.frame_rate = drm_mode_vrefresh(&dpu_enc->base.crtc->state->adjusted_mode);
> -
> -		vsync_cfg.vsync_source = disp_info->vsync_source;
> -
> -		hw_mdptop->ops.setup_vsync_source(hw_mdptop, &vsync_cfg);
> -
> -		for (i = 0; i < dpu_enc->num_phys_encs; i++) {
> -			phys_enc = dpu_enc->phys_encs[i];
> +	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
> +		phys_enc = dpu_enc->phys_encs[i];
>  
> -			if (phys_enc->has_intf_te && phys_enc->hw_intf->ops.vsync_sel)
> -				phys_enc->hw_intf->ops.vsync_sel(phys_enc->hw_intf,
> -						vsync_cfg.vsync_source);
> -		}
> +		if (phys_enc->has_intf_te && phys_enc->hw_intf->ops.vsync_sel)
> +			phys_enc->hw_intf->ops.vsync_sel(phys_enc->hw_intf,
> +					vsync_cfg.vsync_source);
>  	}
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


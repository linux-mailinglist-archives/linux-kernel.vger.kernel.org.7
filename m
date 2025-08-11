Return-Path: <linux-kernel+bounces-762351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287FB20547
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A2F1896BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D9228CB8;
	Mon, 11 Aug 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pWvBRDlF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1622330F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907997; cv=none; b=XrLAur4BH/aZ2hXo9hkrH18VB67mRTfhtFkuoPaWA/NzfW20T8bzTRmVt8Df+uxpS2zbTCHyaoJn04rwCHPYGFLltDY7Bvc0WJ1HmM/h4qfWFwfLfyCS2e1af/LeifslAa9+aOusLXhXaFVZYAZajr4D9yG1ZF56ZT78dIPxEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907997; c=relaxed/simple;
	bh=iL4TDSQgL3Bbu/0mgzsxzafVNRhS2cEI44d3kZHxXb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYV5gvDQgZQP0tsj45bKUhe8YHGpAkvzPou0KpwoxWo4JRTl1E0WRhse29QdQL/knkNGpo524sfU4FQbNepKg4X7gYPCDIn/4ZcVA58lhJpRQOFAZuoHlqZcUwynGm2CCuzAf97ijjaTRLO+DvO88NV+SUruxMXa9h6+qqdNBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pWvBRDlF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGQj4024342
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/4tDhgxFTFm32rKj8OsdQCqN
	y65/pv1+di1cZhSEdpw=; b=pWvBRDlFziWWj5HuLW6H45HJTcZttvz9ESkLk0uM
	NtbaIchPIMRUyLPnyIR695bRbOQWNCjwWRwgAk98kCYBnBk2qh5jQ9es6go3Dgpg
	SX0ssCGAI/alg9bRIIxq88G2InB6hzr1moD5U2QhV8hcyL7P2ZOnVtuws4dAJudD
	P4Vl5Qf8a60HnW3Xrnv7Nj+bn70KreoYJvyxCBy2nKp1EHBjp1VEjRzZoYaV7NRR
	wr8dg/RegWDNJIexQISYO07Ju5oRebJOEov79b/yNy4tD2rXH16OGqiewyhKLbnP
	XhaGft8cga81AclHPne3cWxWUUNOydlCvoPt9MBVsTVZ1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem480q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:26:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0a3557d05so87815811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907994; x=1755512794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4tDhgxFTFm32rKj8OsdQCqNy65/pv1+di1cZhSEdpw=;
        b=q1SS/dOESWdF7KOEN3RySYl1uyxfu1hwVtYA/+HJJ+sAWpyLvgo9WDX4c0hRbDKDNZ
         QFt4Yg4/1XsgdE3FDiAb1Ha8TrnM9vjzZKieFHGILZhEGy24CWbL8AbK1nNBgNdA74pM
         YSgyc8RMRiK5yRlvk1lej9V6tjuFNUcG87oJFO+VxWlyMRGW/y/qRRo3UtuUJTfMUCQ0
         ofShLbGIyRbF6eRu2fKPmlTRPefdZQBeaK/oPKgUXwpFQIE5ek6ZTbJWM0eyLQDpyhPf
         rGadTKYJ8AfK2O/DBaglTprWIq/i11WoY9B36tYvr6XOmLcgwVcPMNAH93xmv4bsBI35
         gfdw==
X-Forwarded-Encrypted: i=1; AJvYcCW8n7WlYqECvtLQQGdsR8uLrV1ZznYePnhA+MKrjEFd02y2i7Fk9ngKbJzqY/E+W+csdHkMFy4WXfoVuq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzjKGUlqir/gDd+JkNlHvKHa7ie6zRutguP7DSuF/wC3AHetM
	gSIyF7c86okoHK0FvLg1/oQuJhEA/P2sr8uIJkVevEGhFKZtSW5YxNABL+B3G+cNnXiMhS+5JYl
	+17EmCe6/P0jAazMfpkbIw8/8YPSMBAuK1xWkhmV4Wk+UySODL0oOq4cCGg4BVjmdzeY=
X-Gm-Gg: ASbGncseY0gMdrrxOoXDl8EuebH+DJfkNd+5c8ewbduW0WRmFLhN2Y/fksWQVzKDkhO
	wtP3wFTY8RwTLnZ4ogqFopuqqaboJb0fmhHZ+Gj0/rADVVwTHJ3VWjzQIae00WV7bRhBw/3rT//
	Ub19RqbXQUadubt7aCC8pnNHuL9elESTM9TYirONoR2O2DGknKZNoeNNKqShZTYfhVZptCYzoAl
	cWwE/YqaBoSc55I35Pk0OzoM8U/YmaM9kordlnsMyhV8ulWLPYFfkh6L24Iq/GrkL/NJuMIDUbb
	3iqNELn4eLpcCyC4Z5+xdxBdyRtIuEKD0uz6Af40mrXRUDTUjs+yGkxEfgtCM0jDiDfcCDbZqIo
	t2ibGsRpohltgmzj3Ix32G1LjHIdI4b2L+7tA+Ak2ZDmgZlFHc7wT
X-Received: by 2002:a05:622a:ca:b0:4b0:80c2:6674 with SMTP id d75a77b69052e-4b0aec9df57mr160251121cf.26.1754907993641;
        Mon, 11 Aug 2025 03:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBtZfXQ4QunBGnECg8IgNPTThfg2oORkBUD9GYQsf+7kkjIYq2XXmXZ3mbOFg4UkIpF+IRdA==
X-Received: by 2002:a05:622a:ca:b0:4b0:80c2:6674 with SMTP id d75a77b69052e-4b0aec9df57mr160250851cf.26.1754907993170;
        Mon, 11 Aug 2025 03:26:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fef31sm41894971fa.70.2025.08.11.03.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:26:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:26:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
        arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
        harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
        liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, robin.clark@oss.qualcomm.com,
        abhinav.kumar@linux.dev, tzimmermann@suse.de,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org,
        laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
        dave.stevenson@raspberrypi.com,
        tomi.valkeinen+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [RFC PATCH 8/8] drm/msm/dpu: Adapt dpu writeback to new
 drm_writeback_connector
Message-ID: <ag34es6qm4b22qti4hbsju6sk5ny7ixq5fiwtni22vf7tvx5ba@ficntlx6i2hs>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-9-suraj.kandpal@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092707.3986802-9-suraj.kandpal@intel.com>
X-Proofpoint-GUID: 4IH-XHmL13Qf6IsFOEwp26QW_YgKlUSL
X-Proofpoint-ORIG-GUID: 4IH-XHmL13Qf6IsFOEwp26QW_YgKlUSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXzyl/2/spb0gO
 Q9o1cqJomhzcQ/AYKvdCKdO41VrECy3hrcutmhFM5vShIFEG2n9GyadZmvFWVYHziKZ1XkfvcD5
 oPMdtdpfzzFYA3J70fxHymyGbLceBXI0v5HfhVyLQcoWd3vSARNbI+Z5TtpzyGEKHk3sCyqq7v5
 MvDz0F0m3U1e8QvTDbXQn7H9eZhYBV5nZAjRWP204aCeZlH7PsA+vgBjspQkQZA4F3YLGHeEUw0
 w34DLWQEVVsjC+Z58B54wi99MQOdk4p4dxZ5Ls/H3X8LLo+LcnQ+vCNpRFBF6mMsQrb9j20R2V+
 8mBjMPa0oZdGDZHKFB+njL6EPucmz/LuEwE/IxJjip9Em/mNOuo3G5YjxSsA7mgLIyJZe2LmJHo
 znWbQ2I0
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899c55a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=Fxrl8DOH8qgm06HfJ5gA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Mon, Aug 11, 2025 at 02:57:07PM +0530, Suraj Kandpal wrote:
> Now that drm_writeback_connector is embedded with the drm_connector
> adapt the dpu writeback functionality to this changes. This
> includes changing the drm_writeback_connector to be changed to
> drm_connector within the dpu_wb_connector.
> Some other changes are done which are a result of the all the above
> changes mentioned.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c  |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c    | 16 +++++++++-------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h    |  4 ++--
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 56a5b596554d..0e60c1ac07c5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -484,7 +484,8 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
>  		return;
>  	}
>  
> -	drm_conn = &wb_enc->wb_conn->base;
> +	drm_conn =
> +		container_of(wb_enc->wb_conn, struct drm_connector, writeback);

Just store drm_connector in dpu_encoder_phys_wb instead of
drm_writeback_connector.

>  	state = drm_conn->state;
>  
>  	if (wb_enc->wb_conn && wb_enc->wb_job)

-- 
With best wishes
Dmitry


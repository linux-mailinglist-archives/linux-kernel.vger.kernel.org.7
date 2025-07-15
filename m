Return-Path: <linux-kernel+bounces-732642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFAB069FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890A51AA2D94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AD2D4B7E;
	Tue, 15 Jul 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ke/TAz21"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C42C08AB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622852; cv=none; b=QkdFvSGZ7ASfrfeiz4RuNSe9hWXRFfWU7sRXCBTE2WNU6nJl4yANEK6fQQFr7UoCQe6BgHxPP9dkiv7rG3hVqmDVRni1hgnd2x+2D+RRGRXz1wgqpCA5/UbiUbLD7i4r0074ubT1yq24UrKAualdca5FNAJBnmW8MolnimBQK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622852; c=relaxed/simple;
	bh=LrPqnDq/SpvFDLZ7HSbGNtZeDMrK/0XptXrDEMlwKiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NamGoX4DJh8Izz3LtQmf/59L3IKQZzseYxAwqZwWhMfWnaiqmsiKg59FrewyuAq8vMcqvvpHy5umeXcZz8xI3iHeMmkXFMbyXtkP1dWnm7hbEa0MLadBCURvHPXujbA6CxttiKn3qIlg1tpymYNPde4aY4JLPAzgGAXd4sRAoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ke/TAz21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDJTl026146
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U74p2NgokusBYICtX+RuOyJ/0ZE3xSV0oX91XuR8eNw=; b=ke/TAz21O+HjjcTw
	SlaGcYjyLsajIpFyU7Kq9fVWzI3pBXIM6yDYkXoxirJwGLy7GDuH8qe2gnv36SLj
	bYX/XvAqfgI+fFsaoZYzEZKMc/RWLn3Y3c8TywRYqs0gj/YU1o+i0dP/fwn7TmCT
	+ZTsAmrJXfPnC/r3o2GgR0c2TgEh8fY9r9A4pcrpE1K/SKhwLBC0UUYb4Ke8Rg9v
	EDLGheYUGiKpQr5+csF761XIFOPc8FKjuYp6QksIhTSRHy9kpdtjfXJ7Q0VBg9Uo
	8wn4Qv/GuhdrigYlzJDhJMsOisF0/lBB64aMTbhakpLFjeIq7gBCXdrNbWbwXjy2
	zf82xA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca35uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:40:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso7745490a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752622848; x=1753227648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U74p2NgokusBYICtX+RuOyJ/0ZE3xSV0oX91XuR8eNw=;
        b=r2lwx1Auij7iYsV4TgRPr0VB6MMdSAVkyN+CXs6R5lUkuAJ9EnlMiyyls2C76uCPjs
         qSv0aJpiC+ygYTe5v6zaBp2d166euQuBhHbEywIBNWyDW/J2O53C3fZe6A8kMWKWvh7Z
         iw1bRJPDq3Qa/mhnPC+5kT7vtZzp89rTInmYPDj2BwFOUmRfjJDcr9vAK/FtczLu0lm6
         490cs6+tX8jJbxpjj6bVuKxlcGLmQAvThvtQ5LUvuUYxfcuKKvOsyeEUN7oM2CX25Ye4
         /PaNoMw0OCtgX8FTd5hex4/LBVAwTl9FwUXu0dbzhuimxIEHx0+zRM12p1HqrFUM6PU3
         yfqA==
X-Forwarded-Encrypted: i=1; AJvYcCV+wldWU3blJnf5rBEx9NdfkxOpcnqHm9YnmUL+T9R/ZtLYXUPLb8/BzDCtTZAJidyL6DlAXwA9wJzpubw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj8IULtwpvqZH8tDORRJn9Toi3NRiI0bvWJMuvFmpsokRyYF0
	OeoVLRmtZuoi08hQ6bdwfXhi3wDjPSwAIte4S6lDo2U0EI6qku6lxmyMjOdqkQ91u2+hRCsH5Fn
	h5g5+LektE+YFhAUgVCH2TWBx9tBGiQwagsvCakvmZWmPSSKugJNURuN6qGom76Xm4B4=
X-Gm-Gg: ASbGncsu+81o+O7w3Ij0rOQgFHiZKDM4Ug2rgOIClTotKVTvo/lZ0OspVOfysV4Nrnx
	3LtaJITRi0r7oZBeA6b5k/4UqnaXVrdWzvaV885CEOAAM03uqRoin4rlVT/+lpBclaHJdXIfgyK
	8to8pblVfvax8dNVLRHVRxO1R6lerP0ZWHr0KIIpBWxWnCSJYTuoo9RZMcJQtO0FXExcguOre2m
	4T6k7zAr4FWKe2NYncUUGkjT1Ix4PwDQCpzFI0Ogcm7gnQMwvXYmljfqdu9yoRQeNL4GTZ7HjqE
	3KfmPdx/QgAAmfTrPUvVAmU6jMc/z/B2Y1eOobSwTjKsV7sfKdUB/23glGRjKYCVeDxMQp4x0xE
	bwc4syHOoZ7pmGRrIe/iCfg==
X-Received: by 2002:a17:90b:4f47:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31c9f489b00mr504229a91.32.1752622848230;
        Tue, 15 Jul 2025 16:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTTJbpQZuVeL9T10AqTmZygZig9Img276JHEdkFxvJJ/A1KoaAeYTrUG70jqOz6RxoHxwmBA==
X-Received: by 2002:a17:90b:4f47:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31c9f489b00mr504193a91.32.1752622847720;
        Tue, 15 Jul 2025 16:40:47 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6c5660sm12492300a12.48.2025.07.15.16.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 16:40:47 -0700 (PDT)
Message-ID: <5ff344a4-cbc5-45a6-9258-9d51c73c24e0@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 16:40:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: correct dpu_plane_virtual_atomic_check()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20250715-msm-fix-virt-atomic-check-v1-1-9bab02c9f952@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250715-msm-fix-virt-atomic-check-v1-1-9bab02c9f952@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIxOSBTYWx0ZWRfX7lmacjDK50GO
 KFCr+62w2d59UH9iHerQpJyWYAHGLZgoG/GDwoSM2PtNNmzF6+9/iQl1gDtq5rxV+DWj/rGrhe3
 GIdhHkRDxtFhZHwsU4jQv6iV0UMOatT/w/IF1zXE3ftLn4Dvd4hAmcY8QT0GZvZk4RQvqebHtVn
 zRZFtNx0wg9/8v8BP94txI24mpXZXY30TKrODN+kD48XYUy3Mx3nzuZv0rEgmyU/f30o08/Vx2/
 29kbcLtn3TeG7AnLhdJlnBb6alQhQbE99cSI6LvWxPHzlQQmi15KZmb9fbXm6trlq69YoL68vaq
 ClUuVUwy22QnioSTUrApTRmWRF41IPbE/uR92xyx3Rurx3WCnz31JTNicM9AilEqrhOXgz0uPTS
 vZDRp6wOi1mS2o9C27SVtDzEZ9oXZ0+1A5eGAgP+Um8KRAdri4jdKdxnywWFPSJxssY3+erj
X-Proofpoint-GUID: 7u3zYvZKgVsiEHRDMzlCEIeZrs95FNa1
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6876e701 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kWyCMJcj1dDTDgwf64UA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 7u3zYvZKgVsiEHRDMzlCEIeZrs95FNa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=847 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150219



On 7/15/2025 10:28 AM, Dmitry Baryshkov wrote:
> Fix c&p error in dpu_plane_virtual_atomic_check(), compare CRTC width
> too, in addition to CRTC height.
> 
> Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507150432.U0cALR6W-lkp@intel.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 01171c535a27c8983aab6450d6f7a4316ae9c4ee..c722f54e71b03b78f3de82fec4f2d291d95bbba3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1162,7 +1162,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
>   	if (!old_plane_state || !old_plane_state->fb ||
>   	    old_plane_state->src_w != plane_state->src_w ||
>   	    old_plane_state->src_h != plane_state->src_h ||
> -	    old_plane_state->src_w != plane_state->src_w ||
> +	    old_plane_state->crtc_w != plane_state->crtc_w ||
>   	    old_plane_state->crtc_h != plane_state->crtc_h ||
>   	    msm_framebuffer_format(old_plane_state->fb) !=
>   	    msm_framebuffer_format(plane_state->fb))
> 
> ---
> base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
> change-id: 20250715-msm-fix-virt-atomic-check-ae38fcfd9e08
> 
> Best regards,



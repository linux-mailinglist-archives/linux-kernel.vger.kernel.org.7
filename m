Return-Path: <linux-kernel+bounces-815979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765A0B56DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254EB3A6396
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353F16132F;
	Mon, 15 Sep 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEoQcX3X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5702628C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899914; cv=none; b=sW+wXiR+WMDA1JOiHvE+SX7D/hdj+ldPukOX3ohfnAqFph/0zBVQUgBPIMiyiWk6p1MkqvBbSYO2NuLLvdOj/i3GFjah5TyQtFQBKHo7HhIRu8cs/9/EEObVqLFLKuDv0Y5PINpk0ZBuQpL4ZhnUjAZF1eRey4U+6NmvkUDFlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899914; c=relaxed/simple;
	bh=oGI5Z9lAnet9N6X8u/EPYinGq8RHkjqJLSdrS0DnU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkhJcGWEh6BdOnm3ifmQRJRGhHw/WjrI7cpz4JgyLknsYXCKP/HhVFtZuz2OvICcm3yKJzve8Z9nc8Jhu5rqrseKsAgHvfhGq1OJ6AgaSFs066ZUAC78VulUcHrRsBsvD4R5fUlGMsLtj6+O6itApEagkCWDV70sUH7cmmWj2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEoQcX3X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMkUnQ018191
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TcJ0ybloGvHGKF4GG02Qp+Ji
	unAoDyIz1wNa1WR0eJ0=; b=aEoQcX3XjDiwxFNZVXI/9dQ5qPZhBipw7/PSlXKx
	p7qEJLH6mJ6mxLXEkxyFjnexu6ilfHagrNTNoaulggzOVQACuAgkotDVJ9ijNKWg
	5nrJ9jVlEQwm0S7z9bwt0lRs90ReByPIaF4McT9tP39EnsLnUB6VWtk2CTHSvfGH
	xvLZwwFHd6Ww1pB1DuuibePEpWOwqNHCjNEFCDeSV52Bfz3qyL90xb+Jn8bfd3CJ
	r5QG+s37WMrt6AEw7Aw5h2URdlg0L5tMWmE8hwOzlqbw89nRL7aAlziAVdi3xKKm
	B1cmNk/CO7r2TyGpjjWtSG9A7YuAa3f5w4NxVC5ESdIoVQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072k206-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:31:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32d323297so84178041cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899911; x=1758504711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcJ0ybloGvHGKF4GG02Qp+JiunAoDyIz1wNa1WR0eJ0=;
        b=SNxjo0ejqNElXExEdipG9E/ycV6xefI5w7dD4vXOuftU7XYYgDI64PgUZtPyftjS+d
         ZOI7JkSuKBiJaHA0CqTYpqBP14uz75UnNAsZMXPC/NepmONg6ggul3otgay9YSbanKAx
         u6S/pxlfockKoxYJDrYmmscBhhQD5OBJFYMOoiSajyAlz/VfzRNElnGriYNm8Y1u1Dhn
         QK2sUeV67XyYb4jvVCpBtq9wTBuB+4tRB19Z3duMXePlo09zP/hRZJiJtRyAZOknDva4
         bTlMzJBY9wKPRLe17fTBvTIzRCn2K5dp+NvEGLmIi9qvDDaYK2Np5n0Snz2h1fIzVCQl
         QBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhVOM0455QE2dtYawVbZqY1EwkESEhDVwFe++N0XZjRKK8qRaDwCDVb46h822gKeWZvnCRmhJaWIiPKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO609NX2WHD1VzummXeKglJIRHlJR0Tr/blVyrOGPye+ksfZeb
	6UAfVOyarCbHNJW9BIUthEyKNt+n+B2Q4HQQBnpg3xO/GUlpVaekZ2jPQgtmF+93DXMhACVXRWt
	pljx31fckIt1jxs54QpFfzPSrpSu6k5xCyQbpYkaVQm3IP3CI0gYSLNWdERJpC61e58w=
X-Gm-Gg: ASbGncu5lOOZSOpoy2NQoGafZsSDlZd57s937YAK9bXfi7rk1fBGmMhr0yqXdj+Bn1L
	Kozl0W6MWMk4ogHqkf3lGpTSX0sd3z5rumtWRiu5FQzGI+5GWUAaY2x73NmUz6RNmxt8e62DiH5
	PMDlCAZ3m5RpOiE73mq3xb2d9h36Ml7b5pU90ZyYtke3SPV6JcNzY0lh7tNtgaqlVWnltjPAzs1
	mb1iquL//uBdHVkCpr8IFGyFOn7jFljb3lvTbGtE1CQesxS40laJ5jl4+jnaE+9UUEaNNuWUAZq
	kn7jtOxxgqq8Ly9Nx9yJysF5ukc2zvE3rO8TPb7RKyIjtf/1t2JTY6x5qOcKBl1mbXRzsSeeQH7
	TelvFN4m4ZRA8uqwOp+xJJGHcEMXOFziJwIgNQjxvy/+DJPIdlTkU
X-Received: by 2002:ac8:7e96:0:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4b77d12a31bmr122322721cf.47.1757899910641;
        Sun, 14 Sep 2025 18:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVrMreE7OMj8MxiWmIm0GBSOu7bo6i+Ps/Q4ehmdYwNOXPVmtMmMD9KbYt/UgI4ov3lbfN/Q==
X-Received: by 2002:ac8:7e96:0:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4b77d12a31bmr122322381cf.47.1757899910134;
        Sun, 14 Sep 2025 18:31:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5d20df19sm3261383e87.48.2025.09.14.18.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:31:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:31:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dmitry.baryshkov@linaro.org, l.stach@pengutronix.de,
        dianders@chromium.org, m.szyprowski@samsung.com,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_dpcd_read_link_status()
Message-ID: <fdzw7qfha5h7luvpxvgr7vvdhlpvc2dzkkfxbp7fv7obnvmurw@tf7jefpjatsl>
References: <20250911112756.4008435-1-damon.ding@rock-chips.com>
 <20250911112756.4008435-2-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112756.4008435-2-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX/QrM6dATAziR
 SfJISzCy6bjiM/TtQ8pZMWa6STw0CLRLc+QVDxA6ToQwLRGKqpiqlrK6zZ7uN/rfvLiNY4mJc7N
 Z6ybzQMIBU8lr9zoA5OpWaYwNZZnePCybwxt9ykeqXTwDK2WrYlxL64lYJWwbOZhgoTkYNHXUwh
 lzggmiMj4CfdQ8CCVTM02aXAWmhuArdkkFvX76av4yZZ1enVDrWqzgH/ToZgUi0PgRNh0J2EXjU
 lg+o0qmx3pbV0UNqYeynhdoqRLxzvzbmYPUrXJJEiSY4DtoG11D+MwufR6sJyHPDSqF86d5Un1s
 NwdggNfue8op/YuFLX/bN7km6JyPoQCnPpg8Mr6XrxuMx+SpugVC8OVmRVhJh+c85YHD+vgSYHL
 zWivEFvS
X-Proofpoint-GUID: 5b05orRW2nOJv9M7Ow-aiAPNrLAmvYHu
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c76c87 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=_6liaYtLipVCF3ugnXEA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 5b05orRW2nOJv9M7Ow-aiAPNrLAmvYHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Thu, Sep 11, 2025 at 07:27:53PM +0800, Damon Ding wrote:
> Use existing DP helper API to read link status related DPCDs.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


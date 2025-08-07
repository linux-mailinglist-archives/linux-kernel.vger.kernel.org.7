Return-Path: <linux-kernel+bounces-758805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33727B1D410
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990C4189592F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57864241686;
	Thu,  7 Aug 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKN/qU05"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0D25484B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554186; cv=none; b=CtWssj1Rkv/UFmcfpd5lR3nKdgb9VpA2MIxOrsMMsz+NmutEmnEWVqdsIkhBbD2qy2t5U2Flb3vqCWwRbyMT3I++qBq69hM+t0qhweXym0wfJMgm72Mc7RmPx3IXJXl47/gXb0GU84EkUDfJLyoo4VejDID9OUKbLj9b+X1eSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554186; c=relaxed/simple;
	bh=+iIt6eJa5z7/55bGmPf8SfWqrqAcCKwMujezRMcSbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7oiM1ThL0hA7VodXmYKyGYKzyyzAqV4013Mx9yT0uHnfiebaB4qJy2dr10BdnSdfzXijqBOEYJ1YgcHdGyWjrryHCQNlDR115NtUCqd0VjBOycdbqzGhoyb7DsEansK57xUx+fenxiQavgP2X2jArHFLLPjSRzoM/XZZA+1AyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKN/qU05; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777fVRo017136
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 08:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8cnnTCr0BqMwDmRXCSiVDYTd
	XzHaxhvasLyMTbeTJIc=; b=CKN/qU05FMQA+gzujiFPkSAKQUw6MA7hFbZGfL3B
	hOfHfrjY3mla9zEmM0PjyM57K7HkoioE9acrkNfsUaBTtJge7/QBPTvcYOXIL8f1
	QVZvtg9CUrlX6CYJLTRuuvNW880rVGXreMyKdtc44/H7VyKif3trXulIayw6wIaO
	0nMYOcx9hlb6Ps2NAbkacfPZAnobsaw/eYlQqkHXGWxPpHghEg1+ch/rclvVyCT1
	E+Ol65SLHeArr0UkQD1v8tzbPVeFeLQseQYC07yB/xTsUyjSzGhtJEqt34ca+Vyd
	Kw5gm8TEYCxoYJvmdczmncr3aJQYCyhBBsS6U2ay/g+kMA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1dkpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:09:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af22e50c00so18146091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554183; x=1755158983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cnnTCr0BqMwDmRXCSiVDYTdXzHaxhvasLyMTbeTJIc=;
        b=p4/OEFYsmH/iICZMglEtRDwjWvJR3CP7NfJ0b9QYbtQa3yDLBfvaVnnQvHdFOU7WCw
         4R5CLHo7ijBeeaI+T8GVkOq+MtCwHzMBQUAyM+FoE9SHKCZB3FF4xIzQ3RUmxWPniksl
         2frzOT+8tjIFWK+096MvX3V+xvNW/LjaybgCbNS0XPtHNPQ1HUeTL4MxYy2SXx6RrBz3
         cKkACa6RMkKNIA+DQ0AgZ4FntNCUvLkKs+kAYwg7ZI4uwd1WN5+ONQU6vhWXFCO/RJGh
         pPy0vVL+tG23dAxu6/AbDVThbCHmbg2DJDCrqM6BmQXd8KIymT4Eq+b0cxi1Xj8WrItx
         PcNA==
X-Forwarded-Encrypted: i=1; AJvYcCVQQkYbSluL3MFOwdJwQH1Hs0fGpIljbTyJkuLVYtg9hy3WzFn+HVmJciFuRF59FnhX8WXA7gE3NsdNhAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwScJgCg4pnRd/8RE3uL8mzpoBgYHDJals4MIxzf9vkmEN67Z
	OhyFCLBBt0OFtHpfmFqmoxm9o1ynBUeRnHQZ9xQwU5rhHu+Tp9s98QxJkoSvUHPO2vRJiaPTNmq
	VNH4vmpMRvNxG4YRbgzpIb+AtMoE1n+XqL3+GKYtsglOjT2LzXGzXhC5bBACG6UXOE78=
X-Gm-Gg: ASbGncsdh6MoaFw3bFtFZ0znjKDhPCHl0ZkiSB7Xdbm8YvNqqlahdPIoxAk+VbFx8dy
	xEHyIv9DYAA1stAkuLikhi9aVCsa7vOvgUgQbkRgJlDI8ZxEnjmPH4g0tYE07rzPp4/zgFTn41K
	kLYbktr8LOiHkXiRbgXe3xXdnZzuBHrRAwswTnMm/HdTQd163+KxY5v0StGdXQQ8qAEN9verTAZ
	JJUDK3nv1r8cSpyt4CtLse2aS1xX+JuKBLJ0xAXAWH+Yydbe762kqCgBfPEMIXVg2PYoLG365H9
	mfhEZ4VuAdbex38kNJqebgUhH2b0zHnGNcn5B7FlsNTpboV+3tbiGtmzkB4bPKQ4hlRAG9YtpxS
	cq1dMi7YV9yuwGHtX6NXt59eLULRuaAAF491gnGAP8cWgW4OM+/q5
X-Received: by 2002:a05:622a:1a93:b0:4b0:77d7:c8b4 with SMTP id d75a77b69052e-4b0924fe2a8mr88796311cf.14.1754554182842;
        Thu, 07 Aug 2025 01:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr6oBPT/KIywasjRNJMXRDMeHau1nVtpgPLjvj4ivB0nSsqqEOpEjGcFvOQTtB3vlNCloQQg==
X-Received: by 2002:a05:622a:1a93:b0:4b0:77d7:c8b4 with SMTP id d75a77b69052e-4b0924fe2a8mr88795771cf.14.1754554182037;
        Thu, 07 Aug 2025 01:09:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fce24sm27550341fa.66.2025.08.07.01.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:09:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:09:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jun Nie <jun.nie@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/msm/dpu: avoid uninitialized variable use
Message-ID: <ouan6tfmoefwuvs7wmhpzjdwmxfhqh3ad26j5tmwdugnq7ieda@ddw6dfqtq27g>
References: <20250807072016.4109051-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807072016.4109051-1-arnd@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX/MXXt1KYRJ//
 sPqJ/vHXoy2UJ8W8WfMnI9G3nFB67zYTFwBWaspkB5JVMHUdSDHlq9VJjerXFjcPVdJbFmFcxrd
 Z9uabJfB0UGeLflEv7Prh3iOLHLN9veU6pfj2ezMxzJNPzgeiCBLSbZ4Acs6V5QH6+9SpcSlbfi
 3M6VRnrED2gKF7O8tNXxupnczlEZADO0RoIJ8w8lPj45/flyO30nhELF3kwwvNh0XMt0PpRZtQl
 /b3v+Rarq7JbvHlejQCEH2YMSwhGmefXzDRVMsM6gef3uHcNrm7zOni3L5Yj1q+otnUzFNS7pR+
 WM7NaPjql0wfNcxPvbsLTF1rVatFZUiGA3R9pPIVQkfnVdiTBSVwbZvofdlECU6gZW8wEmsZPDx
 ha6/eQxN
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=68945f48 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=qCxGkQd1JP7TPUfVb20A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: cnSxY0SyVLdLNfYbEWnobhQ-oJ80Fvxc
X-Proofpoint-GUID: cnSxY0SyVLdLNfYbEWnobhQ-oJ80Fvxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Thu, Aug 07, 2025 at 09:19:48AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-21 points out a variable that is conditionally initialized
> but then dereferenced:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1138:6: error: variable 'crtc_state' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>  1138 |         if (plane_state->crtc)
>       |             ^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1142:58: note: uninitialized use occurs here
>  1142 |         ret = dpu_plane_atomic_check_nosspp(plane, plane_state, crtc_state);
>       |                                                                 ^~~~~~~~~~
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1138:2: note: remove the 'if' if its condition is always true
>  1138 |         if (plane_state->crtc)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
>  1139 |                 crtc_state = drm_atomic_get_new_crtc_state(state,
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1132:35: note: initialize the variable 'crtc_state' to silence this warning
>  1132 |         struct drm_crtc_state *crtc_state;
>       |                                          ^
>       |                                           = NULL
> 
> The bug is real, but the suggestion from clang to set it to NULL is
> unfortunately just as harmful as dereferencing a NULL pointer is little
> better than uninitialized data.


Having no plane->crtc is a valid setting and it is handled inside
drm_atomic_helper_check_plane_state() by setting plane_state->visible =
false and returning early. Setting crtc_state to NULL is a correct fix.
Could you please send it?

> 
> Change the function to return an error in this case.
> 
> Fixes: 774bcfb73176 ("drm/msm/dpu: add support for virtual planes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry


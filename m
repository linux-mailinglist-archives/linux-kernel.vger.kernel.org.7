Return-Path: <linux-kernel+bounces-779630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC002B2F68E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23791AC4155
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A130DD34;
	Thu, 21 Aug 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CO4IqZYJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481962DCF68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775313; cv=none; b=Ez0PL+TySqcmEDerRbVJ2gPA+m77/HyFUaHpxd7yfI7LSCv2NiVgp2e2fDC2bbDLR4/i/ugrJrXjiOgXoeFBaqLHPEpazpUWHgApJDHY0BDmQy4AoR06V/vowKX99aAOKhJv2ejUkne2wF9/zKh+RnDmmB3q5k6N8TTGuFI+gxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775313; c=relaxed/simple;
	bh=g3qpW+yJzy5s7Kd00X4jbSHN+zhfm0nv4cFtjBHJDa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDuqzsGTi472xd1evuMrK50NSnhS2mUWLXbDL6bgqR9+7ZEvegBIyl6lNYAeBpZi0cC2TlsVMPO5GNZ4F5P6zc3lnUPaaGESpOWBMwsb1xH1DiDaBiFC4p/1h660Q2FljABDFSL/wvt/mCcpcO48e7q5VTUi/4CZUVpmhq4/PVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CO4IqZYJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b8es003637
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zonI9zf6V3fVEPfNtYwfqKy0
	ZS/GQ3VH3Sfpylh+OmU=; b=CO4IqZYJPlfAJVErHKpC2/oi7tq3LS7dJ7xyiha1
	EJdrRGUKno3AoK77n0wm7ZJ1zerKjWqcaeQ4kRA42l8XbTI5vhWlUMlxVj8f+unT
	YGMu/QQL6CAnj4CYWoJYIybqJug57vvMFMpqSB/sXPZYBxbmKe4fSUVYB5rU0bbc
	hwCinx4/cx+/r+ZR8fYwnpcQOacju5cENe7j2zZYAjPg/j2plHPdeE4RS9OGpImx
	0YKdlRlNTU9F7W5n2uISfaZshRcPYtcM7iYgkTDaiqr2RH2RIv8YAW5E3S6CVN0Q
	0TdNzPjViD14jSSr5lQl66fJc6skX/tuBgpn+87Ry5Wh1w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdk25h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:21:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70bc9937844so21374386d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775310; x=1756380110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zonI9zf6V3fVEPfNtYwfqKy0ZS/GQ3VH3Sfpylh+OmU=;
        b=miBRTeCiOo2vaLLhjJe/+NrRvkB8FPiA7fweFrxkQlZvI5Ux3gztR3WZFZEwUjBBS5
         MXetIE7ThzFebaCXrAUN26nXYYSk48HtvhB1eRgFRMBjThbqQhUpta1AvmfdB5ufUmRd
         ygBK/anWrztFgxSiIuiTmbyZD/60L5/T6J5c1pZnTKhrFQZeTl2v7Fq5VNWtUkA8kGnS
         f2O26XcHVR87x6dsmUps1R5mlqYRQqzaT6A6i1claBRMNBhaQUG77z3ex3UeJcaS+LMM
         jZGT226gjul2ld8xyp6tqrMp+olPomh5fgq6u6+AcvcpybYVMUYShdMIQo/haXckWuWI
         Bc8A==
X-Forwarded-Encrypted: i=1; AJvYcCWxAPAa1J22XHz5eXdUbpF/5WjSdER/ut2TYdR2GNR83OHfuIniAI1+oLCMLD6UxReB+COj8uTfTErN55s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OCRmKec9w044u6v4Zl5AM06Pq4ch25U0Wr0L7b+aIk3AmEFH
	tHHaW684gt6l+HbzRLZ9kiAVs9s4RVirolXfxWQ4RKDMimOWjWT3q+ES2UuAf6aQ58s/rOArXvB
	JBWFJd+C9oe+RjQh0W89rNhI9nXzhbVdyhCrd6P6xelEPmWkZ06f5zTftg6duSUctlT18bBMs8r
	g=
X-Gm-Gg: ASbGncsbCYEY/+daik4rDn4vp88MJkpli5WvWKZELKoM/zT28sqlWu8xEhE/+zheKpA
	ZG3w4lqLPc5O86xPYE2QZhVRNtGrNM7l6QHpImx4zw3kD7Oq5SiCcwkNOKU3uIev/nYAsv3pHhX
	3JhBGR90AijIuDNk754hy3cFC1JPtwmJyl9OYqijx0w68H/T+V+cecv+Gtl8e1OdUgrKcFOmx6O
	4QrVIKxI1rqvz/4WBlc6WRGIIYQVTmzR0PzpqgF3z2QwPMRzW1LaulSrYDLVK+jDfeNuVK1vwTZ
	qxHdXtecaIFqy2m8XpK6jTSC9jyXPFJ7UhmQqMedhaMJW90H16Ia9f5NrdJWtS38odlFa5cuU0k
	MLHncHGWPn4aZQ/1LcH0tCAZBo62KXi/lNwL7PW7tpaEpoNwqH71s
X-Received: by 2002:a05:6214:2249:b0:70d:657:e6a5 with SMTP id 6a1803df08f44-70d88fde89dmr18528506d6.47.1755775309774;
        Thu, 21 Aug 2025 04:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF/C+D5ck8SnHsMpLfWrHvRO2/uQ1fp+kAA7zaA6wAh315PaUy9SeWMpDSUALjBQx2xcDCuA==
X-Received: by 2002:a05:6214:2249:b0:70d:657:e6a5 with SMTP id 6a1803df08f44-70d88fde89dmr18528116d6.47.1755775309221;
        Thu, 21 Aug 2025 04:21:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef36acffsm3000969e87.66.2025.08.21.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:21:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:21:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tests: modeset: Add drm connector
 atomic_[duplicate/destroy]_state
Message-ID: <nr5dbddxfr24c2g3ybq3pkg45krjlqrs3wjovaglu75ofvz6r4@q4qdfg76ngvr>
References: <20250811063403.98739-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811063403.98739-1-xiaolei.wang@windriver.com>
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a7014f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=EUspDBNiAAAA:8 a=r0MfjTZIDPvKbUZ3oGwA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: atLwkGlPgzRFXODztFfZ8tDj8Z5njpv_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX/R9n8G/vLHOd
 kxdDqDbdZCwapvOtUnYo9Ff39iEuB0hvNw8as+A7tB1WOt+xgUOYnupyj18KSETx6nfrMKuxjoM
 CP9dtLnMKkhUt8c6yKPRpTJTCMERnE72N0Ie1sti9zDMklucG3oglDgDPrJKslwXI3G1eUwk+1z
 FXKBVJJs3IIMSH0IKt4xRLtZ2lkV+9r/rYG/mrtNjHoEKEQo9EGYHoIikEoEQ5ALGYZilF2Afx3
 V0IzDc8Wfv2k8a5Af1zhMZFaZiS/kA64TkGEOENVk3KDQNx7StNF4HB8uE+jvO5hzMLIjDCV6cu
 UTrADi+rZGPh1Z9AJXT5h7S1WL79tMWLkMbOvEgtd0q2EgsNWE7uzuXADc5wdyncU0gKKfTScug
 tPWq4EwMrwcLsXxNO8KElWdeObzr3Q==
X-Proofpoint-ORIG-GUID: atLwkGlPgzRFXODztFfZ8tDj8Z5njpv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Mon, Aug 11, 2025 at 02:34:03PM +0800, Xiaolei Wang wrote:
> Commit 66671944e176 ("drm/tests: helpers: Add atomic helpers")
> added the atomic state path, so adding the drm connector
> atomic_[duplicate/destroy]_state is also necessary.
> 
> WARNING: CPU: 0 PID: 96 at drivers/gpu/drm/drm_connector.c:234 drm_connector_init_only+0x934/0xee0
>  Call trace:
>   drm_connector_init_only+0x934/0xee0 (P)
>   drmm_connector_init+0xe0/0x1b0
>   drm_client_modeset_test_init+0x290/0x534
>   kunit_try_run_case+0x110/0x3b4
>   kunit_generic_run_threadfn_adapter+0x80/0xec
>   kthread+0x3b8/0x6c0
>   ret_from_fork+0x10/0x20
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Fixes: 66671944e176 ("drm/tests: helpers: Add atomic helpers")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry


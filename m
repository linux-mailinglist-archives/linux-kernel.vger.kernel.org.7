Return-Path: <linux-kernel+bounces-874745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AFC16FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B2C420EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42033563DC;
	Tue, 28 Oct 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmSI8K4O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="an+8UsnA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06802DCBEC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686674; cv=none; b=IGKS7dXXAZFQK76dVddmtpU8HiDO53IjhUgyE4vyJh+cx4f5o+1ppRFpOOMKBbtZTWjt9ZcdeDHAi0a7p7dAYqZMxXZQiU93VRf/AMF+rN5iCE188K0SH+2OxI13aaNDvrNCybeIgipYDgiTpkMAzfZY6B3v6fgFOsWeHNrUskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686674; c=relaxed/simple;
	bh=020c66iB5+y76ZpPyIScn5I1clx+uQ9g19ghiNqRlrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTYUZhOfG4pFd/+SWKso3d7fQZ2sK1jQg/auT/tU19ttHuP5o+aMaAlcmj5GpCYcBp00zS7TSRLe2t/uPTSRMY0GQL6rU0NTN9gmZH+ZX6mSF4jvpAXRk+Six/Hc+Xy4f3/+Hb7pXMf3r9KrFTIlXGZcD/phTaPAl1k4nU25uvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmSI8K4O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=an+8UsnA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlkmF2524093
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5bCRTQJFB2jbiTAQ3zVXCAwQ
	bMubibaIIePdt5viwpw=; b=DmSI8K4O+klfJJd0zhAhhLGDaPEn8oddq2IUfYrT
	xMlsqPVmIQlMF6WLM/k/t9He7ORjoZGFZGkMpOPiKXzCAvtUML51/8yFjP/QxoRf
	7dgAAqQ7Y6Xyi+kUcVCO5WjI+x/s8WAZbZQiChB58tmdZy+H6cHhq2ig8GGpFxk6
	GKE72zBgfsEliGBirgDvigZyYWamL/NWuH+iSnay65YEH73ykIyK4FPguQctPjTm
	5P7QMHEMYuwmdKpjBUhi5up5mYwOq69CvYzzwhUKELSiz/Y08U9wZmlYVfUpivD7
	GxQiSUY1/arwbrQOsaE0RzHXJ7d8TlZeLVn9/9d08pCtgw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1r7ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eba120950fso110571971cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686671; x=1762291471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bCRTQJFB2jbiTAQ3zVXCAwQbMubibaIIePdt5viwpw=;
        b=an+8UsnA+Ostqk7hemmqjGK9tquFl5tX1zCAhBvEJiUP3Q2JqnA5x5kZZdyExZaKHB
         w7a2vjVW/Vcg6QqviX2dR7iW6Hi7Udt0YtynnlIQ5tjY9x7gxc6RdGlqyXXgw3EA5ALf
         QxmhHQnmft90ce8LSwA2SbgsUxiM6vKVmSB8zyfq7QrHp5C5i1U1yShwfeF413aL0nYy
         7sRzG9I/thQXAMJEYN7XqTeImThQYmZLspNp0J7AnkSSOycjsPH4vezkywfC9IaSOHuW
         mMbBuWMU3CoMLDnaw1jVBJW/QAwIasbT4ChQLBZaZMxqm0c6ZNUDx25egH2Fsg7Utdv1
         iD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686671; x=1762291471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bCRTQJFB2jbiTAQ3zVXCAwQbMubibaIIePdt5viwpw=;
        b=ElDiy4rhd0boVYTk+qnEo8OaB/TNN4zRm/1sTaKFPaFUhqnJ5vNudUh+TqXI7CSYUr
         lxbApinqbg/LDHP6LvpCAkE5FP+wSkWaC7XXKTWZLhRPp00HXd3HjF2846cFxzYSBVvN
         DMt9u6DlWL8uTEBCAwOXO0wnmFrr3oripyCXXvflXY8CSOVECrvewaR7ek6yiOvmQaK1
         qjqqzfOE3aUoFZiwMDo58bzM+Ethw9xZDFV+23tblifVuJqfhy6VJ7mTl0FDwqLaEqUQ
         avGeczbfH0oAoNzBuwRusDLky+JKehZ3R7rXrUm3T3xAeW2lFM61hEbE08nMFFjOB3iA
         H4yw==
X-Forwarded-Encrypted: i=1; AJvYcCUDHEWyHr8WtfYY4kXc4XJqn4MoFtaMk+/3lkNTsj9ZTFelGao8hv8vQIoHkM0tp/f0Rr6NroiK6PeLtoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3Y3Zh027S2einNiGxXEO31AxisMy+noRzaI4ZQYtoXjbR2eo
	TCM3ThQoQuir8VZJDu2ZGcNKjkryB2KiRM5Wt1D+a+QTpS8yTNlxFqI5k4ENgzocSM1G1DTrn82
	e3cKk47oXHnLbmKuL8c+FwNKb4tNQSS261d1pUQkbFQFFQE8c9e2Uny0j6AOCuDfcBTA=
X-Gm-Gg: ASbGnctrHVQG3wK2Ydo2WxA1fHw+tImcRxdaSBXiyETSb8sSh7kwP+W2CRcQDeNIiMF
	9nyO2JX5e+3WomCyqLAX5O8KVRL1sqEZNC0dBm8YTZBSusdtpukuPTL56t8otEtniZtBWLTI4XN
	ikymtoa4kir6Ow7WYjNVxC1CZx5Hkxinz/XuwV2nItf6O1pTx97cHNAA9dEHueIigRtgFa5QCnk
	fFMzun31eOhDfM3Urwcl6LkARynbXfRa4YJswKIr8eBjb1o485mbjZ78ZoPL+oy2T5e7m6EbHMQ
	ItPW3YEjkhoW3LTmGMlys1aE8ZUwan8zxlWelpU7TD0oJotEl0Qn0foQMOeXd7bxaQ2fWCCHWPl
	yMNMG4zoqYCJs0JMdqqzkt7hcZSyySDnzSiRLNbxMj7rr4jZfEfxpL5W8GtS/wDEyA06W+xIYyx
	iatdu2jGY9BruI
X-Received: by 2002:a05:622a:a10:b0:4e8:a464:1083 with SMTP id d75a77b69052e-4ed15bebdd1mr11272891cf.54.1761686670469;
        Tue, 28 Oct 2025 14:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhLEma2o8DN4JeaTECNRsXH69AeLPm0uhZSZqLEEuM6h5foWAcfY/1Wv1k1KF+xWA3zvGPcw==
X-Received: by 2002:a05:622a:a10:b0:4e8:a464:1083 with SMTP id d75a77b69052e-4ed15bebdd1mr11272461cf.54.1761686670038;
        Tue, 28 Oct 2025 14:24:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59303f54e6fsm2934578e87.94.2025.10.28.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:24:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:24:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/msm/dpu: Propagate error from
 dpu_assign_plane_resources
Message-ID: <t4muz37yg2n56pdai3rzslunnsgq555yb5hnpnvjwyavtaneyd@7b3eofc5afex>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251017-b4-dpu-fixes-v1-2-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-dpu-fixes-v1-2-40ce5993eeb6@gmail.com>
X-Proofpoint-GUID: 6GkKlC0ZL8vVLeZSeYXeKdXg5hR2BLPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfXwsDjE2ItCjOJ
 kGP1S908hjSpoaZ4IXa27BGjtu9suL9ySZcRYrMD43BYGkkVS4YKnX0TwfMgigahlPVBs8q0Roq
 TiKhwIDE7GKiVr1N7frGLih3hbC6dZLapw37Z+DOBjnlfhmZdZpyyrHgvKqVm4rtZhYOod5cYh3
 8DCFLTUM9bQhoXGa210/hINcwapkc0VAtX/iUlUJxfKr8ED36fN5Bp51RqhKUgFlCJysLCj8wtj
 Alkzbh7BDh8AuvIYHDUpEF/3FVSWaLRWoI7Attfk1gsLFhKA+WiuNwb8FKDX8b/kxoH8YWEakJL
 DYffcBNviXyVtG4SfRBDk2Hx3YTQTRqknq+mxKobyEeNHYq5UvLen46LT9GIm7uXmMpL/1n+OyW
 j/mppVbBY/rWF0FmZ47Xlr2tD5gzlw==
X-Proofpoint-ORIG-GUID: 6GkKlC0ZL8vVLeZSeYXeKdXg5hR2BLPt
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=69013490 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1xg4ZLFJ8Ga65Luw_zUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280180

On Fri, Oct 17, 2025 at 07:58:36PM +0000, Vladimir Lypak wrote:
> The dpu_plane_virtual_assign_resources function might fail if there is
> no suitable SSPP(s) for the plane. This leaves sspp field in plane
> state uninitialized and later leads to NULL dereference during commit:
> 
> Call trace:
>  _dpu_crtc_blend_setup+0x194/0x620 [msm] (P)
>  dpu_crtc_atomic_begin+0xe4/0x240 [msm]
>  drm_atomic_helper_commit_planes+0x88/0x358
>  msm_atomic_commit_tail+0x1b4/0x8b8 [msm]
>  commit_tail+0xa8/0x1b0
>  drm_atomic_helper_commit+0x180/0x1a0
>  drm_atomic_commit+0x94/0xe0
>  drm_mode_atomic_ioctl+0xa88/0xd60
>  drm_ioctl_kernel+0xc4/0x138
>  drm_ioctl+0x364/0x4f0
>  __arm64_sys_ioctl+0xac/0x108
>  invoke_syscall.constprop.0+0x48/0x100
>  el0_svc_common.constprop.0+0x40/0xe8
>  do_el0_svc+0x24/0x38
>  el0_svc+0x30/0xe0
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x198/0x1a0
> 
> Fixes: 3ed12a3664b3 ("drm/msm/dpu: allow sharing SSPP between planes")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


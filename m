Return-Path: <linux-kernel+bounces-785290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6FB3489E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B542203D80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAD238C23;
	Mon, 25 Aug 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aiMuOHWn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FD1D5ABF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142757; cv=none; b=hm710beCA2Elp/yirC3+OD9EBv/3oN9OJedMSMZdw5AYkwwUVQiBaQwfKez/Rr2n1/YW4blIf/FDxgybp/SFMzBMqKs9BMBEUbBevGAxIgpMV3THSBIu7Z5QvLnCowA6KvgixL6bBmOWZE8+Id6bpjETJFbpgVDVcd/yi5StZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142757; c=relaxed/simple;
	bh=KS+fBEyFqHgrkcFLa9H69HUcs4Ca3HGJ3JuLeS1cvXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAd1LowRGncoNAthyrtM4qBFa/Cabd+AQGaLsyCnSEbGjkZEwimhCEkkalx2xMrTmkrTI0VkLL3Aizf+oITMLYmAu/HFcO1FWB0pkNGOG8gfYczJL7OgLLR46fgloFRwQ6y3m4dU74UljKxRpH98KFrYTEVcwlotbqg6PXrsI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aiMuOHWn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFeVKd019419
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ihvTWrm11MUKAQSxwlSq5xe
	EvcCp7RJaL1CqX8wMzA=; b=aiMuOHWns1NJzoywgUneVEmQ2c/6snoKkNz4yiF9
	5t3/lof2GXO/P6yQZiNeI4wducHW/xmhUsLYkn95Ht5OhnXE4rDAEr2Gj65mxHAG
	883yvQRWi3U9gYL7ufyftSLgI1bVGj9iNaQ+3H2ERMaR80Kd8DKOrkj5IRMhICqm
	n1AB7NgSCx84781yh3TIRSTogsmsCLOwJZs6U0FuBJqY0PNofTHBJ+5Pts/WQF1D
	GspDON6x6r2fgaHrf9s0naumx0dyrdiNEIXi3eHKkivPtd9Ws9dCxpH5KIyjho2R
	vRHEMFKY9VrM5N346gkw7RjP+iofVStmRN9oHW+5F+7rrg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85xak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:25:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b1292b00cfso45869451cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142753; x=1756747553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ihvTWrm11MUKAQSxwlSq5xeEvcCp7RJaL1CqX8wMzA=;
        b=gmAJETPnWBHzc2+6VM8I7SjpirqutG+7R7MiiRWNKnVHTve3f1qeIq3/qEpvRsGEI/
         iUji5Gb8aoz1q1lLIW5f4YM0Pve6LqMIJinfTZUnxhyXsHghWjuBq1z7EV2j2Msxip5F
         lOrztx/BNzVkNKz8jdXduiIir4x/bJmf7QeV01A3+2yKeM0FbWjBT9g2IsE09wyYLbbr
         XMxwiueA2qsF/AhPlM8CwwklLeRlDPGP3m89/8w9dpTip8nrtBwKqH/aA9eKaSZIxZ58
         m7A2zyiWvdv7sTj5IVIZVGx/ErFoXy5/WAa363eewLFROCA55X1Lt7VscUUwlQV1QJTF
         WtcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq8YIstM0cRMQH65FR2lHQPEwJ+POJ/O/2eBwVwSj7Zb1fkiGmA4y21FJIHtmFRnHlY8JvbQYXRPaRHRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFUQ2ruYmEmhgQ2tpvx6uaPH3cdsoc3NYcVe03rZG8OT08Eb5
	9O91H5ssbv+7PdtWJPm3bzQRQmGYzF+l0eVNHFD8cUuZgzoISc9SXHr1iaoDt7kvZ/5mtF0+az9
	68GY6GLMpWtG9R+8r3+hfloRhEzQGgZ62RX+sHvIfkfR47Yrgh8QnkKsCxDY0sm5VsLI=
X-Gm-Gg: ASbGncvXIRmxFZ19okCurxwxDo1KLLse66wK4pwT/7pVVdLz1EBTkHE/n5/EIhwbehq
	ffP0CUnQnUL5EI+whTeuA/ilP9Utyrcej8OX/s5clkR8yOfh2PF4CX/C8t+F6axLJzX4uPURZCO
	9d8WUIZerC0CEVs/M+/MzAW1k8W0byt6QoBwHFEvi6LlOlM8Tvkpnf9S0l3vBRaA8xzSEDRJYKf
	zaf5ig4y7LZ7I4tP4J1/jKxOQs9CCCEV+kmZcVmnBQxCgADaN5xzjZYOhvVcKl/kWAmhQwkOGIh
	lneN1uRwprFaoX5fiqyvYzJqGKKJtvuISO9qOUg+AUmWiko3GcCyo0mgLyustjiFxMFe/quxSM1
	x8LFEh/bwx4CgcflCgDwouWxV/b7rxKdCpJ/E/CszuHKfch2qO5FA
X-Received: by 2002:a05:622a:408:b0:4af:21e5:3e7d with SMTP id d75a77b69052e-4b2aab20a5bmr188355421cf.38.1756142753371;
        Mon, 25 Aug 2025 10:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaaJSnlDTCsOVk6vybE2eySYvDUVhffQEmr4Tj8nbzRC3viCjZnGQfkVbLytk3PKPOgFsSyw==
X-Received: by 2002:a05:622a:408:b0:4af:21e5:3e7d with SMTP id d75a77b69052e-4b2aab20a5bmr188354841cf.38.1756142752721;
        Mon, 25 Aug 2025 10:25:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35ca6713sm1738580e87.136.2025.08.25.10.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:25:51 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:25:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 04/38] drm/msm/dp: re-arrange dp_display_disable()
 into functional parts
Message-ID: <gxhf3hexw3acfgfyyiarucrsjdhxqmctpoq4xxve2j2i3frime@ga6eqec3lrd6>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-4-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-4-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1Zglv1ew2agL-DZELlNZ4cl7iWjwH2yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX2H9oUx7LFDl0
 mjVGaik+x3USgR3JnlaID/lHb+5A/B9kTcsP3pPSU7zyzHfjXzgK4NOz+UoldyFcSxxa2GPaoOQ
 knIIHR+v0QzsqFlO2XAz+a2CVZl3kuwat6k0rSB+H1dBszBKHyabB1VM+eovpYBORoRV4GjqrRH
 svJeTf2T3lMX2XcD/ybqBEW1TrRtVf90YLSTkhoR+ZHc8uB7STybhUwsuo1gRPFMioyRc2zcayO
 50v3gvWXZe3YdeSWN64/MbFpgaWy0VGbkZQV98qUF0MZpepwt3kSEHgxfMbARKfEsNBAknSwuiG
 6BnlKfWNa1WvFaJAk/X4o9V3/M8iqMdhMdTrCdmbcGqT5kkHmbIIKXkXjaq3q6pgC2C7KkwjvE9
 XGKvE+my
X-Proofpoint-GUID: 1Zglv1ew2agL-DZELlNZ4cl7iWjwH2yj
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac9ca2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QFyoUhfU7BN0Y13r8iUA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Mon, Aug 25, 2025 at 10:15:50PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display_disable() handles special case of when monitor is
> disconnected from the dongle while the dongle stays connected
> thereby needing a separate function dp_ctrl_off_link_stream()
> for this. However with a slight rework this can still be handled
> by keeping common paths same for regular and special case.

I'm mostly sure that this needs to be reworked by the HPD patchset (or
as a part of this patchset). The DP controller and the AUX channel needs
to be on for as long as there is a DPRX connected to the DP port. The
atomic_enable() / atomic_disable() callbacks should only be handling the
data lanes.

Nevertheless the patch on its own is correct.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 +------------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
>  3 files changed, 12 insertions(+), 20 deletions(-)
> 

-- 
With best wishes
Dmitry


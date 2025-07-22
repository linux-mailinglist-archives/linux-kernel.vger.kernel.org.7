Return-Path: <linux-kernel+bounces-741475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD6B0E49F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DF57AC6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C522853EB;
	Tue, 22 Jul 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abEMxOQl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BC284674
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215248; cv=none; b=jLMBZ3xZdOCqZrstI6k/Gvz3c8BwMVA2ffSab/4pxYpAulx+lYdGbV7gJYOv9Qjx0DdTWLArTKRL1gL5gi6aCyNPERKZMekf5RXorbllRZvRmtRi0ev4Hvub1JuHpPKkOSHFnBUCbLnFeQvr/+dZAcmElHl9Ds1wYeQfoOYP0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215248; c=relaxed/simple;
	bh=nG3j+TKBEBa0wv2W3QoXKtILsgLTnZbud3R5SU9tZt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr5GsiEFUClPIy871ncJHpN8JYcwXMZlZexRHpNAT2Oebb3ei8/8zWuVgTwCxZ4gVGgKDFfW06VPUFuuyS6IoHrGBEPTpyv3a6nQgqT7OZFo8AZ/d8LmftN6aa8O9RS3XTZhxQOhtLDBWbvjpe7P8DfV0me1n8GvF/ZMJLdyog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abEMxOQl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFJmgA003605
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=8stxXKOwM0cdX2+Hk7JZb+wP6e0PjVEkB1BIKQ6OkUU=; b=ab
	EMxOQlbIye5IyDYIVRYHKHyrh7d0fIUPvDupUlUSzKRJqQ2pKh0IUoYZw8fAqN9R
	fwF0uvNqCOMHssewh0YxGnzxy+OvtAVvj+oUwlCTSJzlhKdJCS1Ms+9a2XcQLOd7
	mK5vW7Qnk5gsXqP1tQJy2tNFbOQCQhh5Fmyl8D89I97h3f5eA7+M7ecwqO89uAJJ
	AzUHah4KylF1a9SUW4aVd2D5Pp/xvDzhdPt6dAU15H7coBQUwNpR7QFrNRJwNA2H
	7WwFz8y0FFW6VNfy7sBxpc7yDStp7Efj2eHzhtve0odiSO0VtVGDjh4nawq4EKnQ
	PYH9N43+QAjpYovmPXFg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v92j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:14:05 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-615c6bacd06so1520242eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215244; x=1753820044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8stxXKOwM0cdX2+Hk7JZb+wP6e0PjVEkB1BIKQ6OkUU=;
        b=dpd3eOhetpJJLwqCKf6+CSFw+jKSMPk3jcVhno7blRMZkavtGaY5cHM8tmKFB+Rz1D
         mqr9EZdjzqp9b0oH+gEhhNlRQmvshcpU/ceGm/VCA2FNeNgow6o67r9ZEUEX0ibQ0iUt
         8XzyxhPNUXEw2zB0jNeo4g8CeB2fioyl3PGkI/bkYxM23zLkEsEM+S5KVQqSsfmMLHa0
         HXZw1gECN6PBLYwEbCplmvGWSZrth8wMuqksSf2BWRebDHwe+3gCbeu8nSMmgp9Fys7M
         /KIPng0Co7j7nphZ415mHQh7Z9pt25aZ7XtTlGHxb0JIgOiM/ijm4eOJ9Q0j40SCW7Wx
         1jSw==
X-Forwarded-Encrypted: i=1; AJvYcCVD96wMh0DJioO4+47hZEmwYA4I54DxJTMgopJBKXJt/o/Wd7gG9kQRb+Ggz2+srdzDAbYKnIkSCNbSTJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52ilDGWQulvtZ6ARXl9G90NZghg72+Ha8DOpbNKzaEFMP1o9X
	Y58+B0vUm57FhuDMIXKTjptyNAyvBrawnNNh/wHBaEzvTlymMOVcqx7Zodi96sYqTGzBkDKDGc1
	Q9JxpAvM61ZT10ncpUvncJRH96MhhGmKoYcM8pTqxiyVf9JWsBWKF9uR6lFisKcjwd7YUADGOCc
	wKJz3rwvzlHMcdvlGzTvEaWiE0ZzXaTWgMX9/haMRsZTVVZHcYMw==
X-Gm-Gg: ASbGncs45s6W9QqJYJ6zVLBcgDjQSibgZHC8rxalHt9EwB5iRpX1BjPq7GSVdg4VIyk
	oxIfFOYXfCuBG0mQZCA0Rjut+fqsyqb4TLNJGgjcam59wUm8wQcynIxTFaMNDRk+32ovQz2VJr9
	YXtHohuSDAhp59vhHYVBu3Eroadq6kl6XyiIZ/JE1FhdA+fTbvUli8
X-Received: by 2002:a05:6820:a0b:b0:615:ac59:7613 with SMTP id 006d021491bc7-6187d8bb150mr216592eaf.5.1753215244318;
        Tue, 22 Jul 2025 13:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRLfuP1mZvVGnFE90xA1qN98KJGEEZE/W+UJS6YZQ2+JoDxvhTQ5iyKIyEb8QPf1XuzCh9CdlUZbBrwge/XuA=
X-Received: by 2002:a05:6820:a0b:b0:615:ac59:7613 with SMTP id
 006d021491bc7-6187d8bb150mr216565eaf.5.1753215243967; Tue, 22 Jul 2025
 13:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com>
 <vng6tut4sv3zfbwogsb74omqsbqutpeskqdnezbs4ftsanqyb4@nv35r7mqmcva>
 <CACSVV01EhWWohUDQ8n=FQeDuaDcgmYnMBJDMJ8D1Gist1NR4QQ@mail.gmail.com> <800f8c9d-5586-46a7-aa83-dfb3b97633e0@oss.qualcomm.com>
In-Reply-To: <800f8c9d-5586-46a7-aa83-dfb3b97633e0@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 13:13:53 -0700
X-Gm-Features: Ac12FXxPdajDniaWioq_6FbnrOl577Rcgtye0_PYpxo5MDWq0dAn_9MbJWgKs3E
Message-ID: <CACSVV00d4rbNDOLVZJTBNRmUsGyY6Tkwzv0cHRomeYyMXWHZVA@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/msm: Skip devfreq IDLE when possible
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: cs7yIlduDckx4aymefwIGjrf9Uw1co4f
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687ff10d cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=DNA1iQAdpGljtBPL7O4A:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3NCBTYWx0ZWRfX1QqlPNfcyfZD
 peI5W7DedJ1YAcuKayWXCOlwi2MuXySeqlf/O0uvgTHCpjeymvRTxi/9ExS7iL97tsJeiMraeSf
 rYMW9zAu83EpJ3GzV2Zgh+9HG5DdnhIznrIQ5O5QT91c2kP+ziJIfVW3xs1DDGN5XquARF2ERkW
 retevHQZKClOfa5WML4XCCKfCu0Hk9OejUUfTMl72bnyDlV4SeGwQFPFATb7IqFsZqdVOzgTQmq
 ii1FIDrIeuLwm2+iP40L6Zdc7jEP/RGctKeBLxOC67r61G768R7B+g6jT+9Tk/eolPzqQ+Tfr5D
 tMT37HnXVxIismAd5mRQgEPGqaucNgwsPUQiYcGBEWH8N3q+1btYFbVsWnLzipcX3oAxM13Xpmm
 IPlmmdIeWhVylayQYqJ4uRKCtH2DsUM8zWI23tP6t2MovqhuUOMeRDLKNEVhNyIL1W1/RfRl
X-Proofpoint-ORIG-GUID: cs7yIlduDckx4aymefwIGjrf9Uw1co4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220174

On Tue, Jul 22, 2025 at 12:23=E2=80=AFPM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
> On 7/22/2025 9:08 PM, Rob Clark wrote:
> > On Tue, Jul 22, 2025 at 6:50=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Sun, Jul 20, 2025 at 05:46:13PM +0530, Akhil P Oommen wrote:
> >>> When IFPC is supported, devfreq idling is redundant and adds
> >>> unnecessary pm suspend/wake latency. So skip it when IFPC is
> >>> supported.
> >>
> >> With this in place we have a dummy devfreq instance which does nothing=
.
> >> Wouldn't it be better to skip registering devfreq if IFPC is supported
> >> on the platform?
> >
> > devfreq is still scaling the freq.  What is being bypassed is
> > essentially a CPU based version of IFPC (because on sc7180 we didn't
> > have IFPC
> >
> > Currently only a618 and 7c3 enable gpu_clamp_to_idle.. if at some
> > point those grew IFPC support we could remove the trickery to drop GPU
> > to min freq when it is idle altogether.
>
> There are 2 functionalities here:
> 1. Clamp-to-idle: enabled only on a618/7c3
> 2. boost-after-idle: Enabled for all GPUs.
>
> With this patch, we are skipping both when IFPC is supported. In the
> absence of latency due to clamp-to-idle, do you think a618 (relatively
> weaker GPU) would require boost-after-idle to keep with the
> UI/composition workload for its typical configuration (1080p@60hz)? If
> yes, I should probably create a quirk to disable boost-after-idle for
> premium tier GPUs, instead of tying it to IFPC feature.

Hmm, yeah.. I suppose _this_ patch should only skip clamp-to-idle.  It
is a different topic, boost-after-idle.

BR,
-R

> -Akhil.
>
> >
> > BR,
> > -R
> >
> >>>
> >>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>> ---
> >>>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/=
msm/msm_gpu_devfreq.c
> >>> index 2e1d5c3432728cde15d91f69da22bb915588fe86..53ef2add5047e7d6b6371=
af949cab36ce8409372 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> >>> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> >>> @@ -4,6 +4,7 @@
> >>>   * Author: Rob Clark <robdclark@gmail.com>
> >>>   */
> >>>
> >>> +#include "adreno/adreno_gpu.h"
> >>>  #include "msm_gpu.h"
> >>>  #include "msm_gpu_trace.h"
> >>>
> >>> @@ -300,6 +301,8 @@ void msm_devfreq_active(struct msm_gpu *gpu)
> >>>       if (!has_devfreq(gpu))
> >>>               return;
> >>>
> >>> +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> >>> +             return;
> >>>       /*
> >>>        * Cancel any pending transition to idle frequency:
> >>>        */
> >>> @@ -370,6 +373,9 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> >>>       if (!has_devfreq(gpu))
> >>>               return;
> >>>
> >>> +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> >>> +             return;
> >>> +
> >>>       msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
> >>>                              HRTIMER_MODE_REL);
> >>>  }
> >>>
> >>> --
> >>> 2.50.1
> >>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>


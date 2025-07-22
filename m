Return-Path: <linux-kernel+bounces-741151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD22B0E0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820DD1C818E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796D27933F;
	Tue, 22 Jul 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWBVwOIA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDF265CAC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198711; cv=none; b=uLLWwS9oiwWIUR1mNfNZsMgzcVCqsnxh08D1D/6WG/Q9oUC9ceboRTU6fwRG1mMg0E0vgd58z8dfkqyQXaIqxoLCMFW6ECb3dMrWwCBQt+85Y/uSeTs9AVpkWqJhJ+WUYdlrGb6Fop+E29kXn0DT+iSG+Z4Dv7/Z9HQepiX9V6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198711; c=relaxed/simple;
	bh=Se1qNxd0/PJHDHrQnmbz978qyVDnEVYemj1tOhBLP/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCNFz3YE371n+dylhMGvHdd/PJbOLG9vUK8Ck9Cp9exaxpxDpawFxI9yMWQ/EOLoERFIfDqai15D22kr1uV+EU9J1/V87HSQ2jZgJxxXjOzp9CzOeKwvnyVk1BgXvypKcAe37prR74lcxeXNVyu7Qf496fAh0+bFBX2Xw6YLUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWBVwOIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7W5wE009759
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=5v7ZQEbIAiB0+2jIBiZJ/zlAz5qzyamJW6N+8IwXK2g=; b=DW
	BVwOIAfZamAYOhpztOGGNnXgLreZMfJCH5mBPagIOcmoQtv0nLI8Pa0HO0quJCLN
	6Wi5edUrWF31LX6kjoCOtQuQhE43+E0HUqaXGGKjot+d3RpcjeDgjnf4lxKYGK/J
	MlP643aCQbvi0Adpa3rW9FFu9ZiNWV06gvJGXWAwV96fJ65UGvl8y6WxC/IKl38u
	JDbG08GBvw5qD1ohkOR1YoJVUFd6qD9vS0dlCal0awFo4rMqfifnEVS9g45Gfbq3
	tpjwgde6iVAr6OIro43Q73w/4iatt9HgaWmod/QXC7tPo3x1ua6DEDlDm201eHMm
	OfX1PfU/HsHKvQzByM/w==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3emsya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:38:28 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-41b2bd86407so4650696b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198708; x=1753803508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v7ZQEbIAiB0+2jIBiZJ/zlAz5qzyamJW6N+8IwXK2g=;
        b=tO6t7LC2xwFUxk1HrdeoDvbdzSv7xb+F/8bpRihVx2anqY+q1HQTCzQXsyQxIQKihh
         h6cwudBXzyV0V6CLCcq6XFk5TNYVHa6S+Ektx6JpB+cdk5o3aMnHkycVuljm4FpH5tvy
         j0HIAmXDIUjMi3/3NqNWzof9RZobIUnjOnJu4qZcZGJnAitMxqdU23VGp5mYIIvPcBHB
         qrpPGZNFxCvLR1Y2002Z/8QuEN/lUUXtSvFAHAGgm/Pf1OtLS8rO5OxBcbmdU7sADi6E
         GJkgXyOhFcV+01GoQf+YKu0IFMQWD+xetb3q23uVWSS2A2D7T1ooRSg+Y2yUW9Am7Lwz
         Ygdg==
X-Forwarded-Encrypted: i=1; AJvYcCUXnVyimyogx2NYi/BQ3VioroBkcnjl9G4qYsglFJLrwq2CBQl0pREcVXmDmlBJmd3oo0u95sN9yxRGibI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvperwuCyyIvNTfiPv+wnR8Qg+vncyYM0FyOkftSWuoyLNuvBw
	ykCOW0nwn7zNo12zHbfZFL9ZmXqowfAUKFZrFQvnwS5iC5N99DlVbDMM8RDZyxbJYpGIdApgkf9
	Vlo7+Qwaj3wWkiMmjxjcS+D8VU2Igc3Y3MrK9hqDMVg4vSXmkkJnSsfg644lwQdgSvQto+DFNql
	jqBcpz3tkLJMaaV8W3mswKnvz0yZ246xVjBhQZ4CgeqRRpAqN8DQ==
X-Gm-Gg: ASbGncsUESCI3GITMWwoq1Cdz0I4RWQEvHHEg2K/auaiCFyTrC/LoSIoT8WrHuwp/Sv
	mKiS8Ea1GLqf5gvc7e/OywPdueInoazhKcabeIx/fUnhlFlwiIx5zxzV0YU2vr+U8sBwh9COhqE
	O23pBuJ7oi3wUNyWQhBYBOyOgFeQNYcp5+QS5e+nCGIvOU3MOEqm2N
X-Received: by 2002:a05:6808:680a:b0:40b:2566:9569 with SMTP id 5614622812f47-41d04c92c9cmr13430200b6e.24.1753198707608;
        Tue, 22 Jul 2025 08:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1GJFYfKEf/2vfcM24SVmmRuQ+5KIZBxPBd7aDQfDJlhTZLhTkv+JowWe/tlkItYgNDaaLaguNHER2f1sJAMA=
X-Received: by 2002:a05:6808:680a:b0:40b:2566:9569 with SMTP id
 5614622812f47-41d04c92c9cmr13430177b6e.24.1753198707155; Tue, 22 Jul 2025
 08:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com> <vng6tut4sv3zfbwogsb74omqsbqutpeskqdnezbs4ftsanqyb4@nv35r7mqmcva>
In-Reply-To: <vng6tut4sv3zfbwogsb74omqsbqutpeskqdnezbs4ftsanqyb4@nv35r7mqmcva>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 08:38:16 -0700
X-Gm-Features: Ac12FXyqViKjRhthyqXadlDIINRduJGIQgMSW9SK6xnSnnCzfXGivfqsWQaTERE
Message-ID: <CACSVV01EhWWohUDQ8n=FQeDuaDcgmYnMBJDMJ8D1Gist1NR4QQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/msm: Skip devfreq IDLE when possible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 47KgYsul5XIWGqiZjn0fGtu4fKTev4w3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzMSBTYWx0ZWRfX5yct6gwk5Gv/
 JNdpQmORtuTm7cYTShTq5C27oASXdHb/Lizrs94/iUbVzyozt5OVCkmIgUw2ojxSPrN8YkbpbqM
 tmYnITlbrevwhmnzC74+yDl/hmlJ2Ofkgc86EghGlbrph4RhLEh8viw+oLaXWBz7pZZhdQMVRmO
 8vFMaV3//F+B7x0rE8MMIKbR92lURWO335urj2ImwIF3gguWWoUJ6Ukrf9xMn0liI5MSY5rPFEX
 fWQIwF2cxPAHPQr+ChO57ZR3xS1MHttPRhR/gHRtQV/l7cnJOruivkKfuAgRwUXZTRV6zTJcF2p
 XbGzmi+pUw5A3YqlOq3ffTEedGrWFNN7ojeaCkdVgFqkFmhI6m9crMkp/P9g5N9ptJxPeVShw+/
 7J4BP8iK/PrMH8MsaYfKMPRHetQ0U3ycdwmxYnl9GvCs2lR3pJ+l1aqB1+ho/36GrqIL8tpC
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687fb074 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=19W1w_CfSDR24Ta8X3MA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 47KgYsul5XIWGqiZjn0fGtu4fKTev4w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220131

On Tue, Jul 22, 2025 at 6:50=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sun, Jul 20, 2025 at 05:46:13PM +0530, Akhil P Oommen wrote:
> > When IFPC is supported, devfreq idling is redundant and adds
> > unnecessary pm suspend/wake latency. So skip it when IFPC is
> > supported.
>
> With this in place we have a dummy devfreq instance which does nothing.
> Wouldn't it be better to skip registering devfreq if IFPC is supported
> on the platform?

devfreq is still scaling the freq.  What is being bypassed is
essentially a CPU based version of IFPC (because on sc7180 we didn't
have IFPC

Currently only a618 and 7c3 enable gpu_clamp_to_idle.. if at some
point those grew IFPC support we could remove the trickery to drop GPU
to min freq when it is idle altogether.

BR,
-R

> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/ms=
m/msm_gpu_devfreq.c
> > index 2e1d5c3432728cde15d91f69da22bb915588fe86..53ef2add5047e7d6b6371af=
949cab36ce8409372 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > @@ -4,6 +4,7 @@
> >   * Author: Rob Clark <robdclark@gmail.com>
> >   */
> >
> > +#include "adreno/adreno_gpu.h"
> >  #include "msm_gpu.h"
> >  #include "msm_gpu_trace.h"
> >
> > @@ -300,6 +301,8 @@ void msm_devfreq_active(struct msm_gpu *gpu)
> >       if (!has_devfreq(gpu))
> >               return;
> >
> > +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> > +             return;
> >       /*
> >        * Cancel any pending transition to idle frequency:
> >        */
> > @@ -370,6 +373,9 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> >       if (!has_devfreq(gpu))
> >               return;
> >
> > +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> > +             return;
> > +
> >       msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
> >                              HRTIMER_MODE_REL);
> >  }
> >
> > --
> > 2.50.1
> >
>
> --
> With best wishes
> Dmitry


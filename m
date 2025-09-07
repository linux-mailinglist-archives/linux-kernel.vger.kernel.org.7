Return-Path: <linux-kernel+bounces-804626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E1B47A95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C2D3C2BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76F25B1DA;
	Sun,  7 Sep 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HcHGEupK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14E2264AA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242670; cv=none; b=bez89NPbIhIBoOCbuknmwktvyK+Gupm/iu6BAlvxTELtAmzm44nC2g9zbH7NMQ7VRQFVfPDmW2tDEWq/KNCnkxWpPuk5sZ7+04cDd+wG1MKG1WRML4aJe3dXsTAzcL8XXRN4y9zb5pKyumKbhKMg9LaGhE5+Zm1PCEeBAJXCusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242670; c=relaxed/simple;
	bh=RPSfmxAwtSFuCLXc5bdEwSA4YdITVnQp/8VJP3TNPz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZfN6EUDTCdN5Vy2t21Elisy0ocB0oV8WfjICaGcxuEY6412/0xXHmekiQVf+W5rO1dgFZGOMiKk6DtikYfTPKrcH7pIul6TMRYM6wUkMVKxq3KIBXUGc3uqTJww6gFnIBvaodxk9/dJNlHq35fFYXEpyO5TjfSfvdU/aBwvT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HcHGEupK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5878jP3F002716
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 10:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Utiwmvf7x+ib9aisS1Pi13DrFz7GSmiEyGwpkMiTHUI=; b=HcHGEupKcXYaoVUc
	QoJz2YXnCAJB6vwcxdVSqlUcYD9PyqGiHfH/BPE31XTRUDQfzpQJoI9IEPOEJhDj
	UrEOzbgoLxuK+2V1pqipwvVQ6/2oHylhtzNoklEGJpFBzFT6Kfhnoe0XmwmwbUtD
	LIgE+FGlDcvebMANa5dSwvRIV/F0/XAO2jBpQ94RMTIUwUeyaAQF2hXPPy4nRUb+
	cDG71JBruJnAXI6cHa9+YeI8B08IcwU2C5Bj+95CLCj6ybR+22QUp6DtXfqouRn2
	zc4lem4XcQUCKgtlfLs4Awdc1sE2ing+r2QjJYl0sZRP5dHXjJ+VhF1GV0+9vW4z
	pcYYiw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j21yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 10:57:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-728f554de59so101835056d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757242667; x=1757847467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Utiwmvf7x+ib9aisS1Pi13DrFz7GSmiEyGwpkMiTHUI=;
        b=pU6+Pix6eNrTWdbPjK90/47w8a8jDfbiGMqrenBBStUPShlwErHFhfePtLhrlf6xU7
         J2LBu7XD/XjLWZF/hiR0s0hKjuuH9K+qWC3yD7xphVqfvLiOMibCEbbeTV+f+RNjoTfb
         t/Bc1ous7hd7S52hOfajqxdg1cKh9cV0ou0jIzmkQdUcULj1kOxhqC5V7zAbbuqyHD2b
         WhxELuTZJPpEtsbTwDjmkPXetdBNXvHa+xZ8Vgr93TWfI02dZr+lBlZdTycu3Qc3MZn5
         aAtP/SEAuWI+Tiu3/xI7NOYhn1/7SwH2vrBWfKi7Kdp+gRGP+GyATR6E5JDpHj7FAp05
         ewUw==
X-Forwarded-Encrypted: i=1; AJvYcCUrkPJ/Z8S3d7WC/GJzbtmWRdRSp0w3Y8bWsKrM4KTiuUQ0t9mHOjiRhXq0oYS3sKm2EL3jhG9VBL/llTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcc4kADoGK/Cg23H9xXD5gpIL/zPVoXl/zlhQH6nf01f2vQPw6
	OrfyGtGnSMQcDF5B78RzvxiXx2ba5vwlR/5dzz3AGrJCNC+XxG4juzROyfCU0XT1jYgYDWFsUpx
	mq2Nlerar2ajkpJmipuTQ7y1cNqxfZngB75vICSzZAGnodoVyoXLT4arMk9KtDcwtwfA=
X-Gm-Gg: ASbGncvjLLTprTg4IRaAo4CwnPaI6vkfOgQpOozS3oEfAPgF+peJBlAYyEjpIy9N4Aq
	oYXYV/E7+7cNVOF6nbuKdZqPhkkVU/S2B6QGWPa2aqwrx7fUj5Sp4J5YpPo12ptMtcf6uP2qExh
	kgH8EG8iBtHvzLXhHkhX/sg9yPsaZ2joW088n4kLpFWLWi3Pqeb+oAyZAr+WXx5HUSXkcFabjHQ
	h8OA3guZ2Kq7KB0S+YC3467M5sWq/WINTs5LdvvfcHCByl2p+T3wYqi3jWTS5KzLdzWUVoJUzrH
	HPwhvN2Z/9dU0EARIovgqzr72a0A3A/MB04S9EgDmxT296a1U7dCqjiiMIwmpxSahBA6qFvNlR+
	5PyQDX/PZjHB/cjBwnqO1T3iXghn7Gixs/2iIXJyybIeS+xvBkGRH
X-Received: by 2002:a05:6214:e48:b0:70f:a8a4:e987 with SMTP id 6a1803df08f44-7393ca985e0mr52737806d6.44.1757242666784;
        Sun, 07 Sep 2025 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH67snNXBDbOrGPpeIUXj3nTtQsTDZBXe0/FNWFzMKo22DEE8TPYZk+Wta8WeNkI8sjpu08A==
X-Received: by 2002:a05:6214:e48:b0:70f:a8a4:e987 with SMTP id 6a1803df08f44-7393ca985e0mr52736756d6.44.1757242664396;
        Sun, 07 Sep 2025 03:57:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm2850443e87.147.2025.09.07.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:57:43 -0700 (PDT)
Date: Sun, 7 Sep 2025 13:57:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Ryan Eatmon <reatmon@ti.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: [PATCH v2] drivers: gpu: drm: msm: registers: improve
 reproducibility
Message-ID: <eoqcx4cjrfuf5a447c62ydrrvxncbya5iw3jgpvfdeijp6be6v@goctbvocjywa>
References: <20250524-binrep-v2-1-09040177218e@oss.qualcomm.com>
 <6mgmrqmixjdftpjz2hvwjnsyh3wwylxuaih7yez2mdgjpcp3l2@zjr4ai6kkjxn>
 <CAF6AEGvJnSiyUJvBPusBZ+mriiP_vRiAgZnTyLSseu8Sdf9PXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGvJnSiyUJvBPusBZ+mriiP_vRiAgZnTyLSseu8Sdf9PXA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX2almMlqpRj3G
 zdFofca4ldQOOEK8sioqD8e62eosgkDKdrXkvAkOPDFvd5D5x37AHeN8t1cFPE7E+3uUEj4rcPX
 e7eVeh1GSz3ms+/RbFMfBJZHtJlA3GFOQK4pW/Rq0fz4uCI3RUYHiSegZPJT1cysGn/7ps68XZM
 1k8MTo1HnUCvKcCcoBQCmQUZqvXyKgP+QYvtEdeEiZCI8aplRG8kRe5pWZfBZgAnstNmZB1Kcs6
 Ljj4Flq/Soy23GY5twqGIgtIfPF1jrunZNp/Vj3YvyuDda+vTScBAuF8OBVUK1TWNROqtyy2kpT
 FTxlqaYWmv/KKLQwRIYiY8rDxxIX0EMV6WtWZ1I3TFVexe3MbFfh0arC6TEhWf4kvQP2xDUrnAh
 Ey5Ogj74
X-Proofpoint-ORIG-GUID: XNIBOxka57gGlgmpVgO0WCiWxVJO1CM2
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bd652b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=iGHA9ds3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=-TsAvhh9eNYMg2Gy3vkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: XNIBOxka57gGlgmpVgO0WCiWxVJO1CM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Sat, Sep 06, 2025 at 04:24:29PM -0700, Rob Clark wrote:
> On Sat, May 24, 2025 at 10:15 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sat, May 24, 2025 at 09:25:37PM +0530, Viswanath Kraleti wrote:
> > > From: Ryan Eatmon <reatmon@ti.com>
> > >
> > > The files generated by gen_header.py capture the source path to the
> > > input files and the date.  While that can be informative, it varies
> > > based on where and when the kernel was built as the full path is
> > > captured.
> > >
> > > Since all of the files that this tool is run on is under the drivers
> > > directory, this modifies the application to strip all of the path before
> > > drivers.  Additionally it prints <stripped> instead of the date.
> > >
> > > Signed-off-by: Ryan Eatmon <reatmon@ti.com>
> > > Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> > > Signed-off-by: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
> > > ---
> > > The files generated by gen_header.py include the source path to the
> > > input files and the build date. While this information can be useful,
> > > it inadvertently exposes build system configuration details in the
> > > binaries. This hinders binary reproducibility, as the output will
> > > vary if the build environment changes.
> > >
> > > This change was originally submitted to the linux-yocto-dev kernel [1]
> > > to address binary reproducibility QA errors. However, the fix is generic
> > > enough to be applicable to the mainline kernel and would benefit other
> > > distributions as well. So proposing it here for broader inclusion.
> > >
> > > [1] https://git.yoctoproject.org/linux-yocto-dev/commit/?id=f36faf0f9f8d8f5b4c43a68e5c6bd83a62253140
> > > ---
> > > Changes in v2:
> > > - Corrected author id
> > > - Link to v1: https://lore.kernel.org/r/20250523-binrep-v1-1-c3a446518847@oss.qualcomm.com
> > > ---
> > >  drivers/gpu/drm/msm/registers/gen_header.py | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> >
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> > Rob, WDYT?
> 
> I'm revisiting this one, in the context of trying to re-sync
> gen_header.py with mesa.. but it is only changing the contents of
> comments, so it's not quite clear to me how this ends up mattering for
> binary reproducibility.
> 
> That said, since the generated files are no longer checked in to mesa
> or the kernel, we could probably just drop all of this if it mattered.

SGTM.

-- 
With best wishes
Dmitry


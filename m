Return-Path: <linux-kernel+bounces-806749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653ABB49B50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911D27A2AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3272DCF41;
	Mon,  8 Sep 2025 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwsAPDy5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D41C3C11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365111; cv=none; b=UOMM5UPyNEwsQoBkp/Ytwh9lq1lFzIJ1LCjPbiqsV9v+/tVMjtGaUyv9gl81wV4SOjSKFKszxdxNUrgcNe3Ta5pcPUKQJxAkqIuQqLyTABaIRM1eADngX1zzOWpuBoCon2AYhd0X9XiHOGkA6+BJQbb5OxDGMrOoFyIeqMyVdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365111; c=relaxed/simple;
	bh=NcjVrFQ/EeFSpDSdolgFk6WEv6hRfjhGaFe8s7KW78w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqhmH/zxQFldQ45SOGnHxE7ruWboPZ4wQLE7atImov+kaU0x0YpnSsw6+Yu04dxzmCr/ilwl0H20MZZu29XMBKgG/VQGfB49wPnnNxIvmWbsytZB58jJuEEtU0gWUEniXo1TgxxjQQMF23lR5VQ91qpkIl3SN8e3Khm1EqG5jRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwsAPDy5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GI1WC014458
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 20:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XT4D6Rl6xH7fkqut4jVRGRITzuU+VSPL2bAYsUG2sK8=; b=fwsAPDy5ELsm5PqX
	Fro65gKobXPjGVoAHUBkPxR0EE9A7aLm7onUviGKb37+JaUjjsWiBlZepLTJRWii
	2gShlA3u8TTcS56DxxoS/AkQS55kqxTu+Eb1FfXJ4taHz+m5d51VfizsvrANYptr
	LL2BOw2Y8lMqH3ykncbGTt1l9paupuF43t//RGdTL755WhZykTmjT6KGyKalOt3b
	KDe79Ugy1RP3iSdXSymD/+Tt9AxWsWxHUPTw8nXUoQ8sMBDh29genLN1OO2Od06X
	9r81FgOvnQ1SLSxPiWpD2x5soj78B8rl1XyFTjcGgzIzD2UvkfBMjzS4IAXqw0Na
	J4+nUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aape6jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:58:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so89206911cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365101; x=1757969901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XT4D6Rl6xH7fkqut4jVRGRITzuU+VSPL2bAYsUG2sK8=;
        b=opemC/Kt4PXY74byZUsMh6uucdJn6qtvslszd00vOtWl2/dZ9YQajA0ULD2e0DTkfi
         hppSudjWfdGEjzsnyEf0/3viUZoZiIM6dYne/79gUvXdlqnz6dXJmqD0WwP4s7REUGpf
         uITLAGgG0yFYI0FzOnB9BS6E5INrXw8W2xYKaAWB4G7qafcemMWbVTEknlIHLDVN3bw+
         4gcQgGItvvKcf2kCs2amqRHIkkqVXLNfhRDB0SUXNGg9ui+zGsorm2Hz7vRaee9jBDLx
         pLJ57cpgSpTkHnz8sWzClfLQZgZ5f53RvEqEMUUwVCZTnOH8cRNwyqqu2ZM05QDQbGbC
         a/bw==
X-Forwarded-Encrypted: i=1; AJvYcCUQErOlgibBxLe8L7gSp3g0nYvH1oA7esyqTbb0PUd7zlcrzMaAalubE26VSxvd55ANtjdfVBkhZmD9XOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4f5VMEZpCogt+lrCk8gjncNFNm2e0AsmbgPVmVkTuyvi3YlY
	j4ImtY7CR28/QU8DZaliww3An/THXyB0QISyzozp1IC/VCAY4THY9uwqocxo7FQV6kBDDMwR3yw
	tC6i/ImjDCBdEzCN1bi1cxaPktu6+GZO4AmB1glXh1iqPZg5GSwhe1wU+E0CMdZtd7mk=
X-Gm-Gg: ASbGnctdjbKD1gMqXWJOUkGR3TUQJ/mljUBRkSkHFw3trsZbMiEMEh828a/plrb2gjA
	D2GhMxQnZ3kf9GvYHHNLXuU/uX0HYpFrtj+0+D4pE72gIuDoNthY4+qbKQjKDnCAjW6NsE+tqog
	XB2aRPuwKdA+buJdPRyxpWM0Sch+j4GqW4Whcuxt4pnDk1IccKQj5pDEXmCVY0w9ZP9GEdT9YsR
	dHfnrW2qh4rBQT1cZHTAtvXLpH2z0Op36EmH3XwYpE3QSbxpS9lXJjczNoHlz7ldSEVhMlwaO7M
	SpxfsGKBFVBhzqRQELCJ57Whgr3+jdt3F556bra899O1hvmF7hFhdw2tyCyizPmj4IS3MIFfsOM
	LtIIv11Nk22/WnRyJg2V2391XWUQWGO9fJr+HXL2GD56M51n83R+e
X-Received: by 2002:a05:622a:164a:b0:4b4:8f35:c902 with SMTP id d75a77b69052e-4b5f8386268mr101015461cf.4.1757365100923;
        Mon, 08 Sep 2025 13:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgGo4AskYYA97bXQw5ZnjKY3trY7Q/2Y1T6Qh64u6FXmuTPBJyX/pqKAgqBTyfCqSsjgeyRA==
X-Received: by 2002:a05:622a:164a:b0:4b4:8f35:c902 with SMTP id d75a77b69052e-4b5f8386268mr101015111cf.4.1757365100187;
        Mon, 08 Sep 2025 13:58:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50bfda3sm36656851fa.62.2025.09.08.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:58:19 -0700 (PDT)
Date: Mon, 8 Sep 2025 23:58:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ryan Eatmon <reatmon@ti.com>
Cc: rob.clark@oss.qualcomm.com, Rob Clark <robdclark@gmail.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: [PATCH v2] drivers: gpu: drm: msm: registers: improve
 reproducibility
Message-ID: <dm22fmz6yuxrn7cwsviwg6djnbbwr2lq7aamatz3rjeeqf7r2q@mdmnolrb3ytq>
References: <20250524-binrep-v2-1-09040177218e@oss.qualcomm.com>
 <6mgmrqmixjdftpjz2hvwjnsyh3wwylxuaih7yez2mdgjpcp3l2@zjr4ai6kkjxn>
 <CAF6AEGvJnSiyUJvBPusBZ+mriiP_vRiAgZnTyLSseu8Sdf9PXA@mail.gmail.com>
 <51cdf832-95a2-47bf-bc27-d43097883701@ti.com>
 <CACSVV02YrpYrvbFxKc808a=GjdxVjO=FjRG9gs_6qe5W-v=a9g@mail.gmail.com>
 <858dea80-1bd6-4bbc-9b98-9f959c00b304@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <858dea80-1bd6-4bbc-9b98-9f959c00b304@ti.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bf436e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=iGHA9ds3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=7zjSVlYyKO-sLu-dpfcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: Bym5zntJZjlTpyAabrElvv0YPZB7wIew
X-Proofpoint-ORIG-GUID: Bym5zntJZjlTpyAabrElvv0YPZB7wIew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4RT6CnzLvdbY
 t0iZJI+FhXBm8G7eC/bGjXv4YbjYxVBO/5pUttYCNQ5oAgtpAPqwa7akZo2r0fVGgcE+wqbSrMO
 GQjvAgjRQ6dmqQmjAfcClglqmkLyR4iNA4L9MJdSNDXrKMQfasAaCGwM6griAwBtLtlUkxnqvRe
 25TWkSWRL9I4lv7Boiqx9vgsOLrUchzMUObvhwWxZfcUDzpOd+qWoHHbD3mmIchqUuleT2quMcr
 jrZnnM0O7Wv9epBaYhVPm+xHnI3SxPLJQkGjf28ZFBwcW13OeX4wUFPCUXhO2qtlfrPxx053AK9
 EUmglScOng8lGPEETZ4s9jPbIryGZdSN4M+81xi/pMquP5oRZ0uPQ2hXZsXp2RPePZ41zHf5ruP
 zKrDq3N2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 12:59:37PM -0500, Ryan Eatmon wrote:
> 
> 
> On 9/8/2025 9:19 AM, Rob Clark wrote:
> > On Mon, Sep 8, 2025 at 6:39 AM Ryan Eatmon <reatmon@ti.com> wrote:
> > > 
> > > 
> > > 
> > > On 9/6/2025 6:24 PM, Rob Clark wrote:
> > > > On Sat, May 24, 2025 at 10:15 AM Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > 
> > > > > On Sat, May 24, 2025 at 09:25:37PM +0530, Viswanath Kraleti wrote:
> > > > > > From: Ryan Eatmon <reatmon@ti.com>
> > > > > > 
> > > > > > The files generated by gen_header.py capture the source path to the
> > > > > > input files and the date.  While that can be informative, it varies
> > > > > > based on where and when the kernel was built as the full path is
> > > > > > captured.
> > > > > > 
> > > > > > Since all of the files that this tool is run on is under the drivers
> > > > > > directory, this modifies the application to strip all of the path before
> > > > > > drivers.  Additionally it prints <stripped> instead of the date.
> > > > > > 
> > > > > > Signed-off-by: Ryan Eatmon <reatmon@ti.com>
> > > > > > Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> > > > > > Signed-off-by: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
> > > > > > ---
> > > > > > The files generated by gen_header.py include the source path to the
> > > > > > input files and the build date. While this information can be useful,
> > > > > > it inadvertently exposes build system configuration details in the
> > > > > > binaries. This hinders binary reproducibility, as the output will
> > > > > > vary if the build environment changes.
> > > > > > 
> > > > > > This change was originally submitted to the linux-yocto-dev kernel [1]
> > > > > > to address binary reproducibility QA errors. However, the fix is generic
> > > > > > enough to be applicable to the mainline kernel and would benefit other
> > > > > > distributions as well. So proposing it here for broader inclusion.
> > > > > > 
> > > > > > [1] https://git.yoctoproject.org/linux-yocto-dev/commit/?id=f36faf0f9f8d8f5b4c43a68e5c6bd83a62253140
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Corrected author id
> > > > > > - Link to v1: https://lore.kernel.org/r/20250523-binrep-v1-1-c3a446518847@oss.qualcomm.com
> > > > > > ---
> > > > > >    drivers/gpu/drm/msm/registers/gen_header.py | 8 +++++---
> > > > > >    1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > 
> > > > > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > > 
> > > > > Rob, WDYT?
> > > > 
> > > > I'm revisiting this one, in the context of trying to re-sync
> > > > gen_header.py with mesa.. but it is only changing the contents of
> > > > comments, so it's not quite clear to me how this ends up mattering for
> > > > binary reproducibility.
> > > 
> > > The reason it matters is that for Yocto, the generated header file is
> > > identified as a file that needs to be installed into the sysroot.  All
> > > files going into the sysroot are checked to make sure they do not
> > > contain dates and/or paths to the build directory contained within.
> > > Since this is a generated header file that is included in the sysroot we
> > > needed to strip out the path and date.
> > > 
> > > The idea for the reproducible builds are that the same files on a
> > > different a machine at a different time should produce 100% identical
> > > files.  Including paths and dates violates that tenet.
> > > 
> > > Hope that helps explain why we needed this.  So long as the
> > > gen_header.py is being called to generate header files then we need to
> > > maintain the reproducible aspect.
> > > 
> > 
> > My plan is (was?) to just replace the entire comment header with simply:
> > 
> >    /* Autogenerated file, DO NOT EDIT manually! */
> > 
> > That said, I'm not entirely sure why these files should get installed
> > into the sysroot?  I'm not super hands-on familiar with Yocto, so
> > maybe there is a good reason.. but if there is, maybe the plan to
> > remove the license/etc from the comment header isn't such a good idea
> > after all?
> 
> The generated header files would be part of a linux-headers package that
> would be needed to build other packages as part of the distro.  And so the
> header files are all checked against the rules.  A linux-headers type
> package is common for distros to have available.

I think you mean linux-libc-headers here. No, as Rob wrote, it is not
(these headers are not even under include/ subdir.

Do we check the work-shared/kernel-source and kernel-build-artifacts for
sysroot paths?

> 
> 
> > BR,
> > -R
> > 
> > > 
> > > > That said, since the generated files are no longer checked in to mesa
> > > > or the kernel, we could probably just drop all of this if it mattered.
> > > > 
> > > > BR,
> > > > -R
> > > 
> > > --
> > > Ryan Eatmon                reatmon@ti.com
> > > -----------------------------------------
> > > Texas Instruments, Inc.  -  LCPD  -  MGTS
> > > 
> > > 
> 
> -- 
> Ryan Eatmon                reatmon@ti.com
> -----------------------------------------
> Texas Instruments, Inc.  -  LCPD  -  MGTS
> 

-- 
With best wishes
Dmitry


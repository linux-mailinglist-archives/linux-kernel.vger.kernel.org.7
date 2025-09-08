Return-Path: <linux-kernel+bounces-806036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D483FB4911F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5F189002B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE1309EF2;
	Mon,  8 Sep 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhMGD9bD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8322F757
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341198; cv=none; b=dDsXMBv61g+S6qyV1jbVhEJzWw1NY4OhZxIJtu+C7EC0VGCH+xMb28+9ogse9jZjaft8CdoTiuKMFTEQCra/Mufzr9tvfU/b9y1S1M3cqW9zOi/nkGQNNTN9hdplXBpa2fqV1gb/SQEuFCi9KR1O6/MjNRXYoiqwt+okqSaCB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341198; c=relaxed/simple;
	bh=TpfEo4KR+IeKvYBbNIbfmMIAuowUTN/DTG1JtQ4Kkjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzZO9OGkbWmvnzQKc7f3kk+KsscRlmUivS5KgRiddq34iftpro4AzSvLcOfHeDjE6W3OPbodKgVAgRmV4v2oUjTeSHbACaW65RunWVNFEzaXeQGpuQIicDaSYaFZjC++uyOJWD6WrQpmGfE4DGgyb5GK7R/r5c/mgUcobmn524U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhMGD9bD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889RrL1031220
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=btuLMB/CAC/ZycWyoLU8mXnMfT5xBCHTrrEXhmbeoBY=; b=Vh
	MGD9bDs/crOhZ2Qdox/JMNz8I5TEkqFW2c7xDqQFrGvUbgTxS5RDdREZ83FVIzX0
	/aFccM4m+C48YYFOVTMoW7exDsXz8elP/Psrm7T4HV3q0aGAe06B8IDEz0uRY+Ks
	L5JGeWu0Czt7lgbttgpoOghbF5mZMmhGC+n1GW6aA8UMh/3bG4PWOildgRCNDXrm
	QLwMuzsqnRxUqwecyvz2fDas2a2fj9QTn8goyNbU0mpuY7FYsyPEL1MVeAkVW7sW
	9lVZW0cGF551cfHGsgAmTe1XQQFzEVBc9VzNqimxWvUvYJ7raOb6n0p4ntpYM1aC
	9lb25ryPoPE5NajVJ10A==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j4xyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:19:54 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-329b1e1d908so222205fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341194; x=1757945994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btuLMB/CAC/ZycWyoLU8mXnMfT5xBCHTrrEXhmbeoBY=;
        b=cHqdfIzKlCQEyvZ54cZPuSmCX6+AK2apNdCFXsSgmeq7AVSA8R7yzAYZEEgXzisjCL
         Gcvh5je1vcneSfuWFvjINi99W+t2+05ZsOOMnpahOo2aKb/BE2vNAnG5s9LpZMyCTah9
         yck+m9Afj/GuYjwJlkgvIHRaDw0h3rBfHm7xdsE8/QPdjxsSyqCoeytNN6v+3gmO5qqu
         5QHOARIWpycE3nf1MghuM0FMRHwNG6plj9/9PAqSyqAc3TdbpH2xKDvcqp5g0FXo7lwT
         YUfS0++X2U6k8ALfzyPWRmZ81DqqL566l6aCUFkJqPGUVDELIU7HixV8fQK8v++jxLuH
         Nn7g==
X-Forwarded-Encrypted: i=1; AJvYcCUCCfGUy7s93ZJl86jfWp0eSy9wPp1+er4CfhPp75oa0m95/q7uNSZNWTg5k3pxZW13aWFhCeOKDIUuxqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtgb9LMQDFUI+FPXgp/bKpnEXS48OZk0+Kdisx8tS1nfSIosDS
	tAnJsu7uc/1J/c1aju+Ln8mNFgqxY7N3flZJijVaoUqRbLZYacH1C5kNPpQpTqjHV23aJLxzYn/
	cfWTTfhdlYpNxioqNxN3NwATfT1huE864Ha930QKjZ0+2/DeufeqUay7828XJlwLNwbn+MCQph8
	BwvU9gkcf2S4WSvi8TKT9cEtm4UQ7RvktVfjA+3GORxA==
X-Gm-Gg: ASbGncsy/BIlC4CDPyhbPRgnOnEZ69OZYzAgJ5vtIVly/0E/W8QP009f7V28qQAkIeV
	1Hu9bsfxw0+7nbclTU+VvYdUO5fNqkP3hU7pvQGgoC87BupwzEfanyXiVXI/uWEhIhURqlD5sOk
	s6MvB7MPubrlAQtb93sj/PktWh2mxWMT0IaZ/5y59vd2mzg+WZ+mcf
X-Received: by 2002:a05:6870:1e89:b0:31d:6467:3ddd with SMTP id 586e51a60fabf-322626446aemr3778316fac.3.1757341193975;
        Mon, 08 Sep 2025 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTNvBd4kHJ2BnKznwqM+jmbGwcy/k3UWsvd2ldCKNZNQmupE4lvVSNxcIQw2N6Yuv5svQqGxpPyiy7oLfCu5k=
X-Received: by 2002:a05:6870:1e89:b0:31d:6467:3ddd with SMTP id
 586e51a60fabf-322626446aemr3778298fac.3.1757341193225; Mon, 08 Sep 2025
 07:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-binrep-v2-1-09040177218e@oss.qualcomm.com>
 <6mgmrqmixjdftpjz2hvwjnsyh3wwylxuaih7yez2mdgjpcp3l2@zjr4ai6kkjxn>
 <CAF6AEGvJnSiyUJvBPusBZ+mriiP_vRiAgZnTyLSseu8Sdf9PXA@mail.gmail.com> <51cdf832-95a2-47bf-bc27-d43097883701@ti.com>
In-Reply-To: <51cdf832-95a2-47bf-bc27-d43097883701@ti.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 07:19:41 -0700
X-Gm-Features: Ac12FXxslNmNXRsbTxmU1Iy_jtvuzXP9Loe6WDYzQOeLeHFE1_OVc4JUJB4dkzA
Message-ID: <CACSVV02YrpYrvbFxKc808a=GjdxVjO=FjRG9gs_6qe5W-v=a9g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: gpu: drm: msm: registers: improve reproducibility
To: Ryan Eatmon <reatmon@ti.com>
Cc: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX/pcbR6nmcIrx
 qt+jGH6faBWarsZz9kOoRCD7X0bB++7uTULrnyis1RmPKVf2+9/1fxLJ2LEENdKp9OWg/E+DPCF
 8CVshLI9uiqaL0PN4YGo6/JKmc4VVFmRT3MArVyxsDEtS49uoeArrVpvldLMCqU7rc28NWCq+mx
 XA8pBmLgEvyxyRNCWjf7cH0BmEGPGTxQSLv0mMgjHttZB7wgV97Bp317BMjdSrlqWrSiuO/c574
 6ye3mS9oL0ay19OJxp3m7bcUedn6jJ5vHiviJSQaobs8Hc/gIc8psm6ZybLnKqLDmerxk7qws6D
 prV3JLQ5KGeieR5+RbFRp+zmnrn9ny6DOggYbK9h9UWXCKZukPTq2UgGzNlM7SwiyXkVdoOOKKI
 bAdSrodr
X-Proofpoint-ORIG-GUID: g7dLl5uuN3GZxXJZk82tfcyFSeMzeAox
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bee60a cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=iGHA9ds3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8
 a=pGLkceISAAAA:8 a=UuwjNODqMk2Ng1o2D8wA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: g7dLl5uuN3GZxXJZk82tfcyFSeMzeAox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Mon, Sep 8, 2025 at 6:39=E2=80=AFAM Ryan Eatmon <reatmon@ti.com> wrote:
>
>
>
> On 9/6/2025 6:24 PM, Rob Clark wrote:
> > On Sat, May 24, 2025 at 10:15=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Sat, May 24, 2025 at 09:25:37PM +0530, Viswanath Kraleti wrote:
> >>> From: Ryan Eatmon <reatmon@ti.com>
> >>>
> >>> The files generated by gen_header.py capture the source path to the
> >>> input files and the date.  While that can be informative, it varies
> >>> based on where and when the kernel was built as the full path is
> >>> captured.
> >>>
> >>> Since all of the files that this tool is run on is under the drivers
> >>> directory, this modifies the application to strip all of the path bef=
ore
> >>> drivers.  Additionally it prints <stripped> instead of the date.
> >>>
> >>> Signed-off-by: Ryan Eatmon <reatmon@ti.com>
> >>> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> >>> Signed-off-by: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
> >>> ---
> >>> The files generated by gen_header.py include the source path to the
> >>> input files and the build date. While this information can be useful,
> >>> it inadvertently exposes build system configuration details in the
> >>> binaries. This hinders binary reproducibility, as the output will
> >>> vary if the build environment changes.
> >>>
> >>> This change was originally submitted to the linux-yocto-dev kernel [1=
]
> >>> to address binary reproducibility QA errors. However, the fix is gene=
ric
> >>> enough to be applicable to the mainline kernel and would benefit othe=
r
> >>> distributions as well. So proposing it here for broader inclusion.
> >>>
> >>> [1] https://git.yoctoproject.org/linux-yocto-dev/commit/?id=3Df36faf0=
f9f8d8f5b4c43a68e5c6bd83a62253140
> >>> ---
> >>> Changes in v2:
> >>> - Corrected author id
> >>> - Link to v1: https://lore.kernel.org/r/20250523-binrep-v1-1-c3a44651=
8847@oss.qualcomm.com
> >>> ---
> >>>   drivers/gpu/drm/msm/registers/gen_header.py | 8 +++++---
> >>>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>
> >> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>
> >> Rob, WDYT?
> >
> > I'm revisiting this one, in the context of trying to re-sync
> > gen_header.py with mesa.. but it is only changing the contents of
> > comments, so it's not quite clear to me how this ends up mattering for
> > binary reproducibility.
>
> The reason it matters is that for Yocto, the generated header file is
> identified as a file that needs to be installed into the sysroot.  All
> files going into the sysroot are checked to make sure they do not
> contain dates and/or paths to the build directory contained within.
> Since this is a generated header file that is included in the sysroot we
> needed to strip out the path and date.
>
> The idea for the reproducible builds are that the same files on a
> different a machine at a different time should produce 100% identical
> files.  Including paths and dates violates that tenet.
>
> Hope that helps explain why we needed this.  So long as the
> gen_header.py is being called to generate header files then we need to
> maintain the reproducible aspect.
>

My plan is (was?) to just replace the entire comment header with simply:

  /* Autogenerated file, DO NOT EDIT manually! */

That said, I'm not entirely sure why these files should get installed
into the sysroot?  I'm not super hands-on familiar with Yocto, so
maybe there is a good reason.. but if there is, maybe the plan to
remove the license/etc from the comment header isn't such a good idea
after all?

BR,
-R

>
> > That said, since the generated files are no longer checked in to mesa
> > or the kernel, we could probably just drop all of this if it mattered.
> >
> > BR,
> > -R
>
> --
> Ryan Eatmon                reatmon@ti.com
> -----------------------------------------
> Texas Instruments, Inc.  -  LCPD  -  MGTS
>
>


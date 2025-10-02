Return-Path: <linux-kernel+bounces-839710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A68BB237F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F35192886E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB154723;
	Thu,  2 Oct 2025 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAJ89+YB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DD381AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367303; cv=none; b=CAOPqE1NY/zJarofK0f4Fyg9y4BU1oCdyWn61BFgnGKimKdHX6KoGvpP2HMm+OJTToE8/m1nTwG2NjqjQl+86oWNSu0YS38TeCbDBTqn6qxEbSn5ZJsVTwreKeNWSFf15eZkYNYi8n96uVaocwue8gtm3dVO9L7ca25onIGnQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367303; c=relaxed/simple;
	bh=dW/DhybowRWYXC14CYAhqVflEVfToZvAKXTfoTEob2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnptk5jCOa7hvXVpe/z7foFBaQ+hQ3qnpn4201TPvXWqol59zMCKitmzJRj7glfqCFzCdIbjcREHiyESstvx75/cCjSmt6i0h0xtxG0/2Hm+Hy8crAkzJE9SLlphHH5QU1SfwJGIdhEcT226g4FYTQ/hNgkGB79q8h+VzKmEluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAJ89+YB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibun0018672
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 01:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D7Od5VFbcggRAlxWiQ0g5qlG79Lv/bUugfwD4ZphtXA=; b=kAJ89+YBtKdwEXA/
	EY/RUK7xmEzz0FzDZ2y2M4hb4nQW03UXjthgmqSMXl+ImeN+/c84JPJ4z8HcaqVC
	kGm6fdGj+l1I2rULN2UIyh4O0pChAybfBTc2nvMX6YO2tP3e98hlyY8LXxg1tNTg
	I6mEJCb8nERgWCIcFpiOcFKzJDTd5H28k1sXGIA9xlSAKhN7KwaLxPqz8+4ohQD1
	3kyP7S9zQp4J6FXn7fQft5TSCY9om/mTj+QadQk92PpVlwgMtKE3eM0d+RdDtAvD
	p3aHvlMB+EW/WNAI6VhRrzWF84AJR+Fq4DrZ8/VFS+Vy6CAfjtmkjdeGxqD+XI2m
	Vg80gQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1am7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:08:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4deb67c61caso14559021cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 18:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367298; x=1759972098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7Od5VFbcggRAlxWiQ0g5qlG79Lv/bUugfwD4ZphtXA=;
        b=lqWNXxvmSxQWzeHxZ0+/csqLLyNrYwfcT79I6oZL+wCm4Vvz6hjEm0Vh5h0m8uXNAr
         o3COXMMR69tKr3CcXtfjgujCWB8zvXH+EtFJuRn10/k9+yxlliRkPBk6DQ1Ae+/cyLWQ
         MbaRgS915/BK1Y+G0KkO0dOP7QcQL0WvQVP9ENWBmxZ6hQ4Uhzfdpi0BQJzrNlFfp3mr
         5BbcPwnuwipM387Oom8A1bAQTAQtFDWbIeKgrhy2XmIMJyaw+GMW8mkcdD7wTKmmAqj6
         3jq2YLQhufciX+aW+t7ByyUydpr7zNqKUU/QMxRaQQKdv2sjKQDkuLS7QBrkDMxxwsDT
         oXmA==
X-Forwarded-Encrypted: i=1; AJvYcCW8dAbOFQY0Ta2WWkE6jyIS9Yv0nivfm3Fs1HLz6jxrb4cG6QQpiWJgjIhOrKS538uRzMNKEIYeqOSkkjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBlquSgS145YWVPXd83/e8Yq468B34y1DSG14NE64u51q/ArR
	mwYqQcZZkRL08klxQN7fb6JT35pnNdZeYkSzivkAAOgkqW1v4hWGXBaSkWlGpYcuiI2qSaIMgRp
	CsxgUjw323ilHAqrA/3YeDp/c1mDz1yYXxWPHiYAHKL1IESbKWXiKgCVWJs3+XsaCs5k=
X-Gm-Gg: ASbGncugflcP8l+/f0pH6i1GD8WQjcXQjaNlz/06O7mBoAxoHFYskmjwU3QJYJXxy7V
	EwvTlkBl22AfzR+0wmYIB/C6QZSTIt1YS6qO9bldddaKNqA+sOXqQoeJu5OTy4+kMEqt3OzBjWh
	Sr1bGWrSrXAKRf242fiuFOcbMSKZpApS+IQxC+gC76fQX3B3xDUDcgdXACIZcvhg22me4x4TEq7
	GNBoLhz20lCDPDO8k1AGs6WZaWhuSDp8nmwevu73/Qg/gI3qKA/cUuvQ9EaxMOtsLsnSSPdUHlF
	a2Cvvt1WxJ8irX5Z5au45Cip7wdCfLkm/19+zot7rElJRi4HeeCOQWoZR3rRgv8TlmfEHC3SRAJ
	Mxqm6dKZEp8AHdzo9WTz9VqNEPQ5FZ+CbZ3KjbFJfYsYdzrhsDWJAqlGmIg==
X-Received: by 2002:a05:622a:53c7:b0:4b7:aa52:a6f3 with SMTP id d75a77b69052e-4e41df6e97dmr78906461cf.39.1759367297937;
        Wed, 01 Oct 2025 18:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrZaqEqf2UGQPe+mVMDuKAcfgbDUzaQ4FB8Nc046Mcl+O0GtaoEhYIkuD7lCFi+fSNe0W6CA==
X-Received: by 2002:a05:622a:53c7:b0:4b7:aa52:a6f3 with SMTP id d75a77b69052e-4e41df6e97dmr78906061cf.39.1759367297485;
        Wed, 01 Oct 2025 18:08:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba273eeasm2860421fa.9.2025.10.01.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:08:15 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:08:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Connor Abbott <cwabbott0@gmail.com>, rob.clark@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
Message-ID: <o55el5zduao57uomzm6zeqslxjg7rtzfbttk7gq6gvsatapktx@5lflwspish24>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
 <ks3ppjsy35wka2at5nxrr74l5mvzr4l6ovm5ncohanu2gn3ytl@gt2mzwjehq73>
 <CACSVV00AFEJVti7BryA-_sosmBKCuDtX7+NEi4aL4X98AqR1Qg@mail.gmail.com>
 <CACu1E7H0Y9wLwN=ztx+YSQLMQuqOF0hYPqvF-VdXyFW65og6og@mail.gmail.com>
 <845ea929-d245-44b1-a0f5-2ea67ca595d9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <845ea929-d245-44b1-a0f5-2ea67ca595d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68ddd083 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=3yd5t0Cfpw69QvuzZ3oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: wqaC1_kKjA7WRKICIKVCi6KEsUejuMwY
X-Proofpoint-GUID: wqaC1_kKjA7WRKICIKVCi6KEsUejuMwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX58P+U6K5VEdj
 YA9XC0c0076+j6BGBv2aj+btsB/QNJcLoFkOHZ2/BLmWbKzMTZCt+X0iGNDS2D+C68e4rGr1mVj
 7QmwuHsnBfn1fTFB/y9IhB4Znjh9KD98XnL4orZgUhhwxRiOqNRTBsjocXdsvSAOcmYvl7IadKp
 ATxO+EiBbxsJpM3f0HHB4t8wB2T7AcZd36jj/PMriMhw6R9Q2ajTnfEmcz/hEHQM9Az9nSTBuSi
 aVOAvcx7qJJiopnQI1ErLvX9BBybG51Ylsl5+nqfJeXxyylOVF2vN1mJ5A/PkNrFcPfHy46S1xq
 65+UYogBlz9qJb/fLGZzp3E3f6huD9wL1X9wDBjO76HU3XuMv2xcbPWgOZBssUwO0DZZdFMGXcs
 hZCJbIK/PXPuiO/yfHpWZXIwY51lZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

On Thu, Oct 02, 2025 at 02:32:21AM +0530, Akhil P Oommen wrote:
> On 9/30/2025 2:11 PM, Connor Abbott wrote:
> > On Tue, Sep 30, 2025 at 10:08 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> > > 
> > > On Tue, Sep 30, 2025 at 12:43 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > 
> > > > On Tue, Sep 30, 2025 at 11:18:17AM +0530, Akhil P Oommen wrote:
> > > > > A8x is the next generation of Adreno GPUs, featuring a significant
> > > > > hardware design change. A major update to the design is the introduction
> > > > > of Slice architecture. Slices are sort of mini-GPUs within the GPU which
> > > > > are more independent in processing Graphics and compute workloads. Also,
> > > > > in addition to the BV and BR pipe we saw in A7x, CP has more concurrency
> > > > > with additional pipes.
> > > > > 
> > > > > From a software interface perspective, these changes have a significant
> > > > > impact on the KMD side. First, the GPU register space has been extensively
> > > > > reorganized. Second, to avoid  a register space explosion caused by the
> > > > > new slice architecture and additional pipes, many registers are now
> > > > > virtualized, instead of duplicated as in A7x. KMD must configure an
> > > > > aperture register with the appropriate slice and pipe ID before accessing
> > > > > these virtualized registers.
> > > > > 
> > > > > This patch adds only a skeleton support for the A8x family. An A8x GPU
> > > > > support will be added in an upcoming patch.
> > > > 
> > > > Consider this lands in a commit message. What would it mean in the Git
> > > > history?
> 
> Commit text is not just for git history. This sentence is for a reviewer who
> is going through the patches one by one.

You can put this in the commit message (in the git tree) under three
dashes:

----- CUT ----
drm: subject

Foo bar baz.

SoB: you
---

All the notes and details  that will be ignored by git-am.
----- CUT ----



> > > > > @@ -2561,10 +2583,8 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
> > > > >       adreno_gpu->base.hw_apriv =
> > > > >               !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> > > > > 
> > > > > -     /* gpu->info only gets assigned in adreno_gpu_init() */
> > > > > -     is_a7xx = config->info->family == ADRENO_7XX_GEN1 ||
> > > > > -               config->info->family == ADRENO_7XX_GEN2 ||
> > > > > -               config->info->family == ADRENO_7XX_GEN3;
> > > > > +     /* gpu->info only gets assigned in adreno_gpu_init(). A8x is included intentionally */
> > > > > +     is_a7xx = config->info->family >= ADRENO_7XX_GEN1;
> > > > 
> > > > Is A8xx also a part of is_a7xx? What about the A9XX which will come at
> > > > some point in future?
> 
> I think this is okay for now. I have a separate patch which reworks the
> cx_mem initialization. That will completely remove the above ugliness.

Ack.


-- 
With best wishes
Dmitry


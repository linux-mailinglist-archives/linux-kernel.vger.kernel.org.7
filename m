Return-Path: <linux-kernel+bounces-837245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D47BABC56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC383192590F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9692BE04F;
	Tue, 30 Sep 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7dtSxAA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615D1F462C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216333; cv=none; b=bUFuPodd7+Kjh8msTR62tXP4UcxLnNJzQ/wjduxNemYxhTGP1zLfOhd0DcD0yWBWZ6g11R/IV0CW5qJIYXcR4Q3q0KXFzSstdBFXfFHDR4PxdKxhuW50wdoSbEdxNG7C6fMnywDSt9he1eusraEea7udvI4yEkmPIY/8RzCmku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216333; c=relaxed/simple;
	bh=Anj5GTS1zAfDof36rgl72NYBu2y16TB6th5Ejufy6kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmKTviWboi4U0noZOqGup1LNB3NgCZMzw+FW9PfHOnVpSZwlIc+zeJWA4l2Dcu6RIPJ3VRgWIYRhQugBoP+xjrRY4lSHA7ZfflSeeAJfODd5BEktbn6DmCWqxhOZUbSMGxtLo7aD7DY0nY4OakTljplF/4+kada7x3lTwdjLQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7dtSxAA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4I9O3015470
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aWG8L06mAn41deSqSo+E7yGh
	W76hJZ2Ee3eCES/ASh8=; b=P7dtSxAAUpSrQS6/yJuuLSp9MXXBagIUU63eyHxY
	BDwxk8Zq5coSRul7FNXnLHiLMlgrRF3CYd1VrL4+wNCDypEi/OI2uwEfhZ42EiSQ
	fnxkqeKaizh+eDLrDjUsTOL8AZKDr6+Ru1y51TA1po9l7aFEYSbankaBqDWfQvB1
	JmeKlDi8jRn3DqHsZskcXlsU71+gGEpveKvPm0BAabH7PDBJUlPkY+ZleUDW1Mo0
	rJbDnfYg9J8TEAfglTsrAHOfS8y4UesFIVUbs9qkL4hP6R8in+u0bx6sWLcDpr2B
	llQibxDyLKuXD4//T2Mz+W+CjMxnHXIugB6CVEaj5Rzw2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr013u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:12:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-854bec86266so1784194785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216329; x=1759821129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWG8L06mAn41deSqSo+E7yGhW76hJZ2Ee3eCES/ASh8=;
        b=RQqGpH5+IJk226hbyrV/C18R05lrrSSxZuisV1vWSpCroJiftl3hJin2FSDq5cXCKc
         0LHnlYYrs0hsPPcenmFzcU2RFnJ9QEQh6K9of82b+DFaEGjvDjp8gTkqAzne6Jz+mdQS
         A5U5QrjxeHW2P2SHJ/4pulAnhrPu+rLKk1II6E/PJyoBFxQC/SN4nFNlaKkmcRGJEu60
         hSOCMPQxUP0P1jZULqSoO+eXKsDcQ8mC6AMDA2ECZcN3Gfq8n6wCvSvtzVGBNvceAn8q
         jQ/08YtFY6jpCImwXzU/FymNJBqfaTUUBwwslXTVdHtN6r5n5qoc1N5CPA8MdwHz0Q13
         qVFw==
X-Forwarded-Encrypted: i=1; AJvYcCUsoi2lFeFEaX0gy0TWcBWTdN7IFoG1AuoGHHDPhLgY6LJZfUp8EWFIuUL/Au7DEACXyX00IiBNq9UIGyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI26zHd5cAZsZbs/lfYFKjGOxvm0I8xbKmN/8oNhnbk6+A+OZs
	F8/I9M4ONyic/iLg20MEG1YSfRe1U4BeAzB5DoweaGkPDM0oeC3dOns6o55H47nDdak2PAtCcFi
	iinvOuq2jITRCB0z48etoWp3rr4HLvmvfqatf5KgM+BmnQifl70cbMPbWJcIEK71mZeg=
X-Gm-Gg: ASbGnctQUogxVbsfBwWpX7d52u9fUcm0o0a59elW7CB+J380zWiC4AXcZG3IDO031mK
	nRxVMh/ot3ndZ/JA/BibCBrgDVNRRHYnoAb2z5JIbbeMtC4FdKyZ+A1OpJek4YZAU2ySuvU23Z/
	ONtX0J3vz7dKzBjspTJnsi1lkhrPNYX5AETIQUMnpahNueEB1AGyBItxiq+7Nkh0KwFs83lVzwH
	9LzfdWj2BeKhKlvaAXjZYlLeSVVKtvNW69++cR8DzHCyzxwKHWo5e6PR1LO1+EdaxEyFM68OqgQ
	g5anW3C8V0AnG8zQlaw6l7hcDmzCJ5V4+5Y/GRc3aByxuEkb7+wjJtQx3Pvcqaued8TPzK70yRP
	mroHPWK50QZSEuXCXeFPz/4Qx1c/tSnzcoIQPvYdmvsKSl48CYBEcYV+FRQ==
X-Received: by 2002:a05:620a:450a:b0:864:48eb:356 with SMTP id af79cd13be357-86448eb076cmr1401386185a.25.1759216329476;
        Tue, 30 Sep 2025 00:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl9dt1djyaC7zQdYtSaRmLXdGdPGvu1aHOByc+II7EPG2uXYQd9OC3qlxjl8GonAKh2YHTJg==
X-Received: by 2002:a05:620a:450a:b0:864:48eb:356 with SMTP id af79cd13be357-86448eb076cmr1401383185a.25.1759216329045;
        Tue, 30 Sep 2025 00:12:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4e39f3csm31049191fa.23.2025.09.30.00.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:12:08 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:12:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
Subject: Re: [PATCH 08/17] drm/msm/adreno: Add MMU fault handler to
 adreno_gpu_func
Message-ID: <srutubksxfjwb6hd3x6oqduyapzo7qh5rjqgvdt36jzqxdegig@o3ukylxtgiy6>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-8-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-8-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: jTdYrpyUIUsYiAeQSfuGiF3E3-0kp1ko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9MOL8Y9KJHG1
 qvjg7tMSvy7gdQK4/yky1ddlfjQb/8vBbuVSV1sn0QDWY3lBqR4mHEmdeHVQ/IA7fsY77U1f7Ad
 gQIafR3cbaioF3GFbxO3gEBgTEqHV/WAXIa5A4Br4z1akC+YQbyLZukAFqDX6gSowmP8pz1yt4l
 zDwlrDOWwz751bRbrNTpJ2KNYVDZxYlM1Zkqt53l9phHQP5nrtc8IfLsueDBamgAFyg2jsQ/CPL
 AvQoxr/LDzRdxKlsyCPx5NGfME0JvMb4Q1a95hkHFVnzU8ZUh7ozyR0sjLmpoIlE18eR5ZZP9ht
 B82kUoO1601WbS2S47dmG4ihsDIcC3xaloj3kmXTkCJz2fqx1P9/kfno5wgpY+0RBlM6d9v+h0D
 0DM/o59s6rJR3VXQovQnz7B9y9BtiA==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db82ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=scbeE0iXsUk0x8BJeo8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: jTdYrpyUIUsYiAeQSfuGiF3E3-0kp1ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On Tue, Sep 30, 2025 at 11:18:13AM +0530, Akhil P Oommen wrote:
> Move MMU fault handler for each generation to adreno function list. This
> will help to use common code for mmu pagefault handler registration between
> a6x/a7x and a8x layer.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 5 ++++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


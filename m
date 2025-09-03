Return-Path: <linux-kernel+bounces-798150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351AB41A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6607A4F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0181A9F99;
	Wed,  3 Sep 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emsqakHi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E151BC9E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891817; cv=none; b=CNl0ZsFBcYUWVAu91KqEMIgvQcaWT+0IkFgWGdeTdCmPGTDUb+9HfnRW5spNJPwbkZhdRCJCzUGUxsWzwSZ7c7cjIhgBh+Bpday68uj1geBj2RoBtgjlXylm9iwGe7uvttDfjOui/wDWLYDTqXRbamiELyyApbNTOtgaXse+9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891817; c=relaxed/simple;
	bh=p8csoE+g9i/JUYrP0reNQc0pKV8iCq/C5fgj9xtySvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyTUOLkreM0iBlImsJaOns9NNyFjNAhvyKy4hdxn+lw4WHJ4R8ePzMwb3QHbqQd6AVtk9DA3107IfOaaxq9gqM5gIatC16qBrVObs7OMyImrVU/qhIIMlGnl27UkkQT59WjCaEXkeeSahAfcCDoTjPHPLparYE9niTMTIDUtgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emsqakHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831npG7021309
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VR2iqlpPGndqBZFzRTnrJAZ1
	ADEc/HrM9Jf0+mHC/Lg=; b=emsqakHi2lzXHfrsTQNrTMRswHsZGuewjNcTD1QV
	2ICTx+HhdBoUYNDVgySPULe+BZ/oZNBBM+6QzAywjXPj5nwqwDjD4ZenKRjqQDBP
	P0EJC9B7LTYdtE+a9sAzLxYcC61a7MT0u9L1Hw4riZGb9oU2YUAgLBe7QwUlNpQA
	lVpbAEQc2iErpMPjUV5MLxJo9ZjGo4Yb3nA6fjLRiqmL8Lj7iHVXIc5/keMxMtkS
	Tjh17+Pqx8ocUTAGOK94lUxjvSRLaazFhIizbqkrm84Cxh7OS4eWV5HuP2HceGVO
	n1Ds7KmD9hIl3v0UaC8nQarf5T+Ybr5CQ5IEBTFqR2Fx7g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s341s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:30:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72631c2c2f7so3855306d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891814; x=1757496614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR2iqlpPGndqBZFzRTnrJAZ1ADEc/HrM9Jf0+mHC/Lg=;
        b=T5wXlC4wOn4C5sfP9P+JwICCVvpYBJ57T4fia3ugXAFYhl5KuLKy0CXZORSzP5bgy9
         ccsvkN5UcXULxTHJzEZIBzPoMLAcLf9645s9KnhE2mIvTpiuEAHpmXi7zig1KpEQkPk4
         u84DXoOhYh2n9rr5XnXyvelgBAJx7XUursICNzbSGh+9D3Uj4qyB37SVEzCyL81mERju
         AIBroHQWnqIuu0vOwM5V+73ipiew1V5hRhIfvOBj6axb2Ytv6Y8QUS3DVicvqkadiDPl
         5+JMBTP+2cdj4Rlnf2CFZEWlaox5bC5iglC4gVXLViOBMULuwkG2xAvfi8ljzZX28Kjz
         vsVg==
X-Forwarded-Encrypted: i=1; AJvYcCUbpGgT8DHfLyiT44cRZqNeskj29GDb8EVHQ4GCOr/YthLkuQf44nB32rfz2IeKwBtgnwjHKAWLUNGoUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZY9deJuzq/HBJTSCvbF5uAQaf9NtV2SLwj6b5D4SpfasnwJGR
	Yw0pcn2lFHIkScUoydXFNPgOIWP/oC1ZuOhEMbVOjktncvJsIEQSXWcgA3DYLGXyvUAN60XBSSy
	2j+mL7pde979fIcrvlfUwwtU1Zcjpx7ZeLGfb36gglEFTzzanayjOG05vw5QAejQAa58=
X-Gm-Gg: ASbGnct/O/ORRuj3JU7kEIOdNCc96FS1UwwzTy9boK1Ah3Z+u6rLZ1+7T93nQnqS9pn
	l/xNHzUje87V0uv1bhec/8xU06Erqg4TF6d6iDfsjBCr7YS/3JuFcQP2cgJv1CBS39a8cc+UmSw
	6/LQ/wPHAUkiIbBXtd1o/pAR5jrO2gjRldIeS9gMoFrHaHKB4YnoMC4m7PiSsublE/gXuDSU2Sv
	SYWdOAJ2/3/gyRBgCHYM9VBri/IiFJt00NKeBWjCJPe4k4MgEqWOWylIQ0Fz9aoTeE7fxbCer1A
	aJoZswW2rZrg3nYO1SCKOlyRe7v3Oj/kF0WLo96YIgLNyKYJrrckeIHzl24LgtgqaZCCCf9Gm6o
	5Za2rMV/X8EUXwz2FK3kg7cJ9mbO0qhc/rkQzgUdKl0ExfZTGxgOX
X-Received: by 2002:a05:6214:cc1:b0:71a:a3be:a900 with SMTP id 6a1803df08f44-71aa3beaf2bmr97801736d6.53.1756891814023;
        Wed, 03 Sep 2025 02:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpD2N/3qjIowrxvQnC6imiMX7OAFJFGHqei1Jwm2q0yHkKx6yG1SLbJKLYa3X8+eZrl0XbAQ==
X-Received: by 2002:a05:6214:cc1:b0:71a:a3be:a900 with SMTP id 6a1803df08f44-71aa3beaf2bmr97801396d6.53.1756891813408;
        Wed, 03 Sep 2025 02:30:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfbfa8sm400984e87.96.2025.09.03.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:30:12 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:30:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v5 2/5] drm/msm/adreno: Add speedbin data for A623 GPU
Message-ID: <vit4he67rvz2yjihjz6lio4cnkfr3eqydcayspijssn3o3mgqf@6eyxrpkwvfhp>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
 <20250903-a623-gpu-support-v5-2-5398585e2981@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-a623-gpu-support-v5-2-5398585e2981@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXzwHq5kUs3OEx
 J80yIdvQ0O9WIicDaeo/f98sxgKPHaAf7D61dYYAkYzKxXoYWaKOxNMyAV8AS0SpA9fZtXPPpIP
 DiyzXO/VNUQv/oTOfNIPG0KfwJCxJmyJ1DAYC0avbqWbjcVIh6pX/3w9O/ksylH8YhMQc+F7HPz
 PdzQP1JWK4mwnjMLMarMXelaekb+MeAuJhJO6Qcf2K0G5dz6bGg6XXMI8Ox7vzYUPXtaVgUAtei
 YnxEjnuF2B95oJOWEmAOJWRd+kHeckkNUKhvIxxOBB6kfDbYvfyKDV8foI1CkbAublRZS/CjRn6
 IINltLqMpQU6Dgf+dKWqSFDKSOW5ivPp1FKexyFDnkSZGF+O7RnE0Gs8ZJBs+ujCOFPcyLJs6kb
 dLBo6W0r
X-Proofpoint-GUID: hNvih85mIUHlWTcJ8Bn28K-3yBnTukLq
X-Proofpoint-ORIG-GUID: hNvih85mIUHlWTcJ8Bn28K-3yBnTukLq
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b80aa7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fAZFXs4-8VxaQHOqD40A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Wed, Sep 03, 2025 at 12:49:53PM +0530, Akhil P Oommen wrote:
> Add the speedbin mappings for Adreno 623 GPU.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


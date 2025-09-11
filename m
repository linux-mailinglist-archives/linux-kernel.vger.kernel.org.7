Return-Path: <linux-kernel+bounces-812157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5143B533C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96BF3A469C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9130F93E;
	Thu, 11 Sep 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUiT6jJz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D7D27E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597399; cv=none; b=bYuopTg1fQPL7efxW6oFajptbPlHpwEDx3aLbNkR1o9pDpsDJ4iwKg3bT6AUjkYyoEkqSN2rrGfSkE2Uf93lxDirJtEl2ZAqgAMj8oJU3LR2xVzKClF6ktcbqAyTmrE5wjsd/HdPFjc4c55ZxulR+XxDKoT++y+yzKiVCvfHuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597399; c=relaxed/simple;
	bh=PmlOO5iv5f9fXOncJO2MDvuoQfGMnyKJMo22ffxT/S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBY6xqLG23OztwytmHgvHJIU+yb53jXl2/ECsEfvuGy754ePx0+8gdpe5KDZVjilvilrBs5MqU59g0OR+Wc3NqCKAjftiYcbgEhqJj2cOReYEGzjziEd8kQwK7PmOgWf4pldugMSES7gzkY6EzIz+xt2x1F5hmD6w/8zRa3hlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUiT6jJz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB1i00026347
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ey2Z4JMsId+WF9VnovhxbF+7
	8pVNuM6IZRJDnfyjy2I=; b=IUiT6jJzIUMzkChyaP0MALicLXWe5kSE8M37EaXc
	/mgBwHrMxAmKtBjT0Vr0FlrxLbmVRH2evnfOqk/tj5WHnDLAMX1zze4sHhcqTuF+
	gw9bTymHdDo1qRGZZdHoR38rncoHRpzWuyXwBO4ndj2vXbCHNkLIr8WJf0HacWCL
	fmAEWKKZdlgqvSKvHb0k8uMdl05K8/rdeKo7sKvLDxlObBPFV4aaaJkipSbnB84N
	pyyv9MOk03u5IaaF9/eKO1lH/gl68ChvV5+D6InBUDSlRPwsFnt3gPRvjbQsImmc
	87i/SHOhIMJzkGSa9YU14HC93lqV7ig+1wACQSMDrrx+aA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0yqyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:29:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5e91fb101so23395821cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597396; x=1758202196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey2Z4JMsId+WF9VnovhxbF+78pVNuM6IZRJDnfyjy2I=;
        b=DAklwNOi5s42EeCXgVpj0w4TtRVFEEx/7i5fqZJ2P5xvC08ewLPUPnRGnbPK9awFrf
         rTp7B4wyDP6mHPrgSzI4GXPnH6/CBJSX0HCBxsCNPf0JmY3MqBEvaFdXwc0pizCiRC19
         IAW4T+qlB0n9L1czOKQjNNCRrjPFtqnSNSLx3D2fIWNOS8LSN1J6x16nKyHBDkSpnRBk
         t3OJjdgf1uD212KDkirDgcMrLac2tAXe+xkrDdqLhr4lAI2/s46owQmQr/Jm44VSQWj1
         7i2qWoqLgXcrseFQlSv2XDCF7VOFr6319fDYf9h6h/bpo+4DwNM4ufZuOajSA8y2JS8D
         a+ag==
X-Forwarded-Encrypted: i=1; AJvYcCXREWn+LlVYwxCL4Ro6fZm3ZWdRaPAx5//UN58wWcAxyHwlkakb4LFCv5ACYO/F6qPf6kn0YNzIhWhWoTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNBF3ywe7OhG+taJAn7R3u/UozA+ll/3R9nWIxHF2GFdqxemZ
	3i8kTnSRt02o/r8pU03RhBL7OSxLRWqrL1szeOeh8Vrhvh1VnjjoFNwfDD/GfbnBZb2U1KxV7Sv
	t4e++MnrqkvQ+/bygu7SCZwj9W2PZfjYtUD1IQrxLQLxyf/HZ778ZBxMIm+qms5NNZAY=
X-Gm-Gg: ASbGnctzssBgl8nxQ8zLag5rbKQue5G4OUtuPv+CufhOUwA7F0k2rey3mkH2P/VU6dr
	ou6jQNLb1YgLQ9MJvZARmv5I6/U/3AER8O1MOaYssH4MN/oEB7Xb5ul3WfE3Ufk/H9eOBuHElXL
	xysGexuN3pn48QtdvZ9s9W3XF8fvYJ80R1pq3kNdzygNkoulE/e1rpJtCglAvPut5Sy49thcOfI
	xJLO3ZTCkOOOGpjoef4DMZnJOkV9I1qTh2x455Qf0bx4V9Vw4/MQrFIJIXuV7feu16FbZz3/R9o
	aNO4jTF2erR70E4fduoEWMvz/YEh63SYltoPi5J+ZvMUly/XzMqShcIXsY524/XIeev4T+9LOSA
	MLGqyY0YiQp73ZUN7H+jaGIwPeYWyagjYiPZpt4JiRjz9RSjEYXV3
X-Received: by 2002:a05:622a:5c92:b0:4b3:122f:89d6 with SMTP id d75a77b69052e-4b5f8445a73mr256204281cf.45.1757597396132;
        Thu, 11 Sep 2025 06:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOBNwwY5vu2F6YDZFmUYGcnQ9hxKYIQ7ZgYbQqAmh+km6PDS9gBX8NbKd9eTG/XrE/5BOGWg==
X-Received: by 2002:a05:622a:5c92:b0:4b3:122f:89d6 with SMTP id d75a77b69052e-4b5f8445a73mr256203741cf.45.1757597395496;
        Thu, 11 Sep 2025 06:29:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fadsm438580e87.6.2025.09.11.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:29:54 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:29:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/msm: Add display support for Glymur platform
Message-ID: <4qrmzpxbuptm2x42qa74hbulb5k4sfyxmu5ji76j232elo7dnm@pkclmnxb2ijx>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <xjtg6emrb7svloz2fkaotfbj4m2wzmddxdsdnjk5wkbmocqzmd@l656suk46pkd>
 <kasmte3rxr3ukz2eqbwlzbpeam2qq2qimzdqta5dl5xsthnokc@smvts77lhirb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kasmte3rxr3ukz2eqbwlzbpeam2qq2qimzdqta5dl5xsthnokc@smvts77lhirb>
X-Proofpoint-ORIG-GUID: -sQrLgsA3O6UZueA1FQCj6Go3DYUUWq4
X-Proofpoint-GUID: -sQrLgsA3O6UZueA1FQCj6Go3DYUUWq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX5JmdL5DLDa2o
 vbELQmDVMWvYdq+EzjyL09ggD3AMC+CdK8JSuP3TMl+7lCj8pI7Fg61tcgILm3nq469Ke9vlBSo
 y1unsdgt5IGPFYT4vm6BVse3iFqfC+VeINpRIRRbJnKJ6iAk7Ze3e/06ukqtAmso03vd6twozOJ
 7gbv8gQdFTX1+bbfcUdiZYvhERv1hFWGBBXZyZ0RLaNVjqOquLYCahtqz/2EqTGKu1/5C9PyqTM
 N1cTpMs0KGIeGa36ec4y5ReBy2k5brLkp1RVETFiTozeTuSOske7AVlWuADGuSqlTpUDgOgerQq
 oWj+uB0PhaZqAVlf9XIZyAFmPthr0vLPXM+0DxJKh3jljuoSQDyu2KgQ0VOkKk2FVuH8MY2h8rh
 CJZwBdH6
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c2ced5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=E1lcnybXH_NDbzajFtMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Thu, Sep 11, 2025 at 04:10:50PM +0300, Abel Vesa wrote:
> On 25-09-11 16:02:40, Dmitry Baryshkov wrote:
> > On Thu, Sep 11, 2025 at 03:28:47PM +0300, Abel Vesa wrote:
> > > The Glymur MDSS is based on the one found in SM8750, with 2 minor number
> > > version bump. Differences are mostly in the DPU IP blocks numbers and
> > > their base offsets.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > Abel Vesa (6):
> > >       dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem
> > >       dt-bindings: display: msm: Document the Glymur Display Processing Unit
> > >       dt-bindings: display: msm: Document the Glymur DiplayPort controller
> > >       drm/msm/mdss: Add Glymur device configuration
> > >       drm/msm/dpu: Add support for Glymur
> > >       drm/msm/dp: Add support for Glymur
> > > 
> > 
> > This will not work without the UBWC config for this paltform. Please
> > include it into the next submission.
> 
> Ofcourse it won't work, but wouldn't the UBWC be merged though a different tree?
> I thought I should send it separately because of that.

That depends on Bjorn, currenyly he has been Ack'ing those patches to be
merged through drm/msm.

> 
> I'll add it to this patchset in the next version.

-- 
With best wishes
Dmitry


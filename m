Return-Path: <linux-kernel+bounces-833332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98748BA1B16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E91386544
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23492798F3;
	Thu, 25 Sep 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbaTtvra"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6720CCCA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837258; cv=none; b=cOyqicRkBuV364h6GufaG4uu94lghnJJR985/Q42DaznHdrqQB0J8s9UM5mj5MzzOgidNCgkstO+MWnADijKjsh7Xn6G4GJ1zGhPOI85wllqlrHPEEOIrWAyqaMjmhWh1XlArvADxnpHlUHqQbPXs8O21sZpbKV2MkPV70UddfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837258; c=relaxed/simple;
	bh=QeCnORvLJZs/1yAIK5MJvGXh77e73NS4/ETlZdo7tfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpR/izl3WsGlIpTr2LSkT6x8E0yNUzDqDhucZ8jDZqtTfMSb5ru7K5/upylPxlkn+Vlpx61Z6v3wCGZySy2b+xFvMBf8hMLXDLKc0tl6ChjY5KEN67d1l59DKa4i+tQbDswzpbaI/VSn+5Jmrx+5pbBQesj7NIeLqioLDZ6mUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbaTtvra; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQYA2026601
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V77Z5Ho34wRfniMvExHw0L93
	ufuCYBEpuq3QobQDp/w=; b=lbaTtvraUQayXHdkdf/MuJVtN5609Gsu2GmI7Hb5
	gcfmYkWM5XUxTaHzt5TGMeg62HIZfX/rsZsKHXsV+bvLp7/Lg1NzvLWH+A2qr5a3
	Te/HCFlvsOOpdA17HBEgzTCWJs8/NVckMd0WiTCBqWQmt1KAbOgqMFik0OrlorwN
	9JdyOiLjKtR6nuxbgY79eRKQcWfD4m1SPJSpAUT1xz+cRfWkhxo9Vds/RVO+cVkv
	0Hac2LP0/f7c8CiSClOfSAPsGWkfn9/u9UEExcTMjLHFu4ooSlo3VQXYwQL4AAgf
	kctlhSr8mP/DTa4Hhv14X6I99W9gLs451RIRgfumhDJ/7A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0gtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4bf1e8c996eso30693361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837254; x=1759442054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V77Z5Ho34wRfniMvExHw0L93ufuCYBEpuq3QobQDp/w=;
        b=LveHVKdH+TUvlrHiL+xLPSQiJEN9XY3p5huW4GvxInEc560Q2Nv9wHJDeoZdH1DRCL
         3qelm0HWimaTlwG2QKJAjh4zjOE8QYzucuseQ9RnXDxwvM/KXBNpJVofEid9Iw0aEiT6
         Yay3bt4LnPPKDyrfUtvkkxrjMy3eaUAcD59uPWco6k+KLeCdRk+a01CYiDLzhuLBA1nD
         imAA1tocGyFk+12tqUla8q216e5T/tdZ+qKfR6CiS+9gWcXEQA1EpSqqFgSxyV3ER8ki
         cNTzMJdhqBuVQh1NvG/kMiCetRf8n6SiQoMSuwzx6cABpms/GF8k9DMa1roIhWwIdooJ
         +kig==
X-Forwarded-Encrypted: i=1; AJvYcCX1mObDwcN8NcuElmmQ7oYVsGjFVhOl3kyw0GcDzhWftkEBge7LTmclTuPN04j0b/Fz0YxsF1C6qMydT24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77FYwTeMkdhS/DGNKaN3aOMQiNRj+3DwQcwt6OAw1ZAjYytlG
	YveGBF04JIoUCbcIlMBil8WqWu9mTWZYYYcAHtt74Gm5Do5A0xndh85rEF8mhXRLwHWSNUWliPW
	kfD5oq1DwZGn7dHetvHDhYz1v4/Q4zUzKvlpENKMF/PAiIUI/g20EN4hDi5qXuRkcz5I=
X-Gm-Gg: ASbGncsobeikDh9RXxpiJfQp0oNzFw0pDJhWdd/NGSCc1UIK2EU1Zp3FjO47p0jPelz
	MtCdF9x/kA2jSOeKqNDlLATjSAtJ+sdxD+LQBebChzeTk5BajW/yqyrAnEZMZMxeDuxJQRH2EqN
	Yc/Ib2H8w90UciPIJygXS6PQ5xBTmPKGyuluvjBS/Fynpq89z9bVlqh3JYowy09lmU48xAzI1KB
	k5OrkMHABsiqFIviGpw7qWpouIw7SKlfXLe0uw6tXTJaeQrkLFBKSuNauI1xWkG8OMi357DCU1q
	npuQIrzHawVnqRBPeggs+DlQewwQOEonSFDS6Tk1UaxnmA2BvVN9HH5HVY1Kkt75/Tz95ufHfXI
	dmMcx8LH6tNS5nIKU/K/YXKrEVBaBhMx5wEgaRnWWKR5ZMCr29nrd
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr67870331cf.3.1758837254465;
        Thu, 25 Sep 2025 14:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyFRxoSrrZVyL5ZFN8zm6WyGWU2qPELuXqbOoO1z14tsOOdtn0pbtF7AxjejfvrN1FriBxtQ==
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr67869871cf.3.1758837253974;
        Thu, 25 Sep 2025 14:54:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4e38b04sm8222961fa.15.2025.09.25.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:54:11 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:54:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v6 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Message-ID: <d72npzj56ng2lxsmbmu2l43ebag4cfyhou5322kbpsutn3nwwf@oi5ibgajlfos>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
 <20250925-add-displayport-support-for-qcs615-platform-v6-5-419fe5963819@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-5-419fe5963819@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Br_w6kanBsPlv_HMTJgzs-IHmf1I3QWF
X-Proofpoint-GUID: Br_w6kanBsPlv_HMTJgzs-IHmf1I3QWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXwMeEm0BLdovc
 YE42/ltoQ9c1VRha18Ra2kaJnq2GPF7QNCKplqZO9nkTT6HE7UHrla9fo5EXDyKsPsR0I6Ohi1U
 Ro1GwryqIsH/reBzzRllHY5Z9aiO4/1+FAEA4YtuhhapSLXm1f3L+LWtppgnVnCCtKEiYRKVh/m
 Ywz37zEBc4DDhtGeTMVrmbmSA6A8upqXIClM3HuGssLscJwhTfI9jssYGWDq/RaK4y85hQIK+RZ
 CGDxcesNJ4NoDVU+3SanfJwhYAmT6+XqsHfjh2JwTQTrBbqwz0eVVCT49cONtSLDrTA2UJxUDqI
 RdeGAXk48sfoBz4nLwNNZbW5E/5L0Wvbmg1umzYVey5uy6WIpj2gtz33wOMccVINcfoiuAJDlXH
 1myeC6oKSVCMByL37/tnd0qINHpMRQ==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d5ba07 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VJ1vJixsNvIt-2Mg1ysA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 03:04:51PM +0800, Xiangxu Yin wrote:
> The original reset list only works for USB-only PHYs. USB3DP PHYs require
> different reset names such as "dp_phy", so they need a separate list.
> 
> Moving reset configuration into qmp_phy_cfg allows per-PHY customization
> without adding special-case logic in DT parsing. The legacy DT path keeps
> using the old hardcoded list, while non-legacy paths use cfg->reset_list.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


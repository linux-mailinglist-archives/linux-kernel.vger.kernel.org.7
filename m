Return-Path: <linux-kernel+bounces-866895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FDC00F45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF053A70CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1D30F805;
	Thu, 23 Oct 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ek4YFsd9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254F30F54C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220967; cv=none; b=NB7tDZMlKMr9WH4cOergwGuZnSwOkBMdfsByiRt2LFxh/64j7QxrB9U+BwtuIMXogGy7W41hqVWR17l7XU2XQYUjUsux0qgSD9Qzr3dghRlZPvj7An9+wgywU2k1vVpKN/Uat2qSiTchi74bZUtZQswjZJegap20jN6oRSvIhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220967; c=relaxed/simple;
	bh=J93UWrskigf/yWa/7D8kaxnKuSVyaZx4r26DdZCXwRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFXgeZZ+CXTKy62ZZH5DtiQlGQTY54UmaQ5yYShOCmdta8hRvlQ/sGfXDQwIYtu7wpFsrVRrHRWyvSbwkwywXQ/ACkPbyDxbWMI0dacQv29yw80SNHFld5Ketb2AZc2F/gO087hFzYgABRRk8IM84viQsfqQOw+eQisIEPHQ+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ek4YFsd9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6fEX6018576
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M81zeVL5vCT2BNHUGaKZfq7O
	ZSW446AfEB/X68ESVy4=; b=Ek4YFsd9WhBLUNX1u/ZkUa1H2LUhmwgQN02YkkRd
	DQVoXLd4/qTfR9ulGVsYZWj+fDOB2ZLUeLzmg/fFciUgkNc3dGDtmCorw3YrlCq7
	uVTMofWObMsEhTabwKctqFnEtFzNG98Ps5wTG1Gev3hseyR82tsxPj/mkqfEfzcH
	6PLAzLnuWE3L6u/0l8WpZ2DiG0XtSJ0r/eg6rhgvREEWwbkU8x8CYjhBIBoQD2Gu
	RYHA8fOuEQT+Am2W2HfXNYfhe/dmAbNrTkKyWnDBQ7u9MR8x87XZOQKfsBXK6Pub
	oEZT1B9hEL6sGHxTYH84mK7Tve4wBRgQ9qDHcVm7hKLb1w==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08prh9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:44 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54a7c3c3157so329396e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220964; x=1761825764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M81zeVL5vCT2BNHUGaKZfq7OZSW446AfEB/X68ESVy4=;
        b=ql+ITKurJdirJt0ADr3AIyBOuybK73u2cS+Ux1VyF38e/jj77lxUr9HC9L7o98o9M/
         Ln7+FenyGx7A3+yjIisEIFwSajEpifCp4w2s2Rn3TLpzvpLMO2H8Bw8KyLH08lSaIMYe
         oizIM0oxi+qkvFnrehNu8q11Qjrcqa1nuBgsj97f4lKYTSijpS4Zwxs8ZrG4ibtXGxSF
         rLafy5nJ1UsvFBdILCpT7m2NJ8zCxQnoY0ttdxuIeCDW7/yiLYGkSm6eFt6GMv50bBgG
         EUuvCOeYM9i4Sm4E9q7xx5LMb1Y2pQBq2aA7hyXiIQJDvDsh+oaBvNX+m9s8NNfrCZLA
         jlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX77sg2kK8mLnKaJG6Ze3tUicxGjfnPDnDM92bTMr4SSxUXKjmUe02QmyVE92JcH/AAsQwRVE6QvlluRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmMLBd0Di6KbZyNS1eQZo9/B0FDIZG+wif3Qh94N5E8Ruyjqu
	E/bsLwt8ykcPYWY1DHccrMgZopKQSrchzS8aYF/ib17bWS+y2EXnW6FvMqPQi635YWkY2milNgW
	mL+sYhMGabhvaZITOxlLswVSq0iWLguwbbICUtgObEGyKXg1ei5tFIZxZKm0ioGCcyiI=
X-Gm-Gg: ASbGnct4efa4zQ6UUdPjxWwfdzx5jLvpZFczA47TGKkvbv0b4tOLUxWaI00MeBL7Msv
	8G6f2TM2caXX8Kru5yl/baPUTuwC0zQyHU4+qa6YplRVIw3KBbPQ7YSGzNlkcDnpzTuQXPvaja4
	Pq13fSKCJelxx2Chn2qclgWHU9jRoxE1yVEgbjiMURY6PvW/D7fkUPXvhABG3B3QsDtRDWkkMG7
	FhTwtVOSFBSaHJy8i3U75QTwMmvK8rDUGoC2jHXXCcOe61sDfnGGhBdG1S1c+ITR/HnEd0zBdVY
	HJn3AOTNfvXtrwrsiGHEFKzdRJmemtb2V0eDhxHoTGPNbBxKHJHXgyNuqzq9zbxYvOzwUcItgKP
	7R4845BSi3Xk2M1X8n1QwGlT1KxNwAnfQhbWoAqSdJUqcCzpV9PwXZYuxdE5WjuxRpI230V/p5e
	9454pVddTDQhgp
X-Received: by 2002:a05:6122:d8e:b0:544:9a46:7c85 with SMTP id 71dfb90a1353d-5564edaa58bmr7102760e0c.4.1761220943315;
        Thu, 23 Oct 2025 05:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeYf4cRCjfFBuC8sO6FcOxLi7vaZ8cGTF8QrhwklAMfIk2LsC1fPJF0Hqf+fYEtQZaBheqJA==
X-Received: by 2002:a05:6122:d8e:b0:544:9a46:7c85 with SMTP id 71dfb90a1353d-5564edaa58bmr7096044e0c.4.1761220913364;
        Thu, 23 Oct 2025 05:01:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67097casm4150311fa.22.2025.10.23.05.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:01:51 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:01:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 05/12] drm/msm/dsi: Add support for Kaanapali
Message-ID: <trkt26sv7tpucjzgguv6ww24jsbs37ppimppyvhqvy4drtqtj6@uf3m3rcmrg46>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-6-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023075401.1148-6-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXxIaofRf5gl1w
 vd/aOTi6syGzNLsaiqq6ollJRIe4Hg89W2S/DEdoxDQxh1Tu3jc6QQG0PrYBwgDCxjQbIfOt6kn
 lncLrooLJU2AxMISWUOY4gZCsoI48JaEh2J5PZTQp9NuYCQyHCqWQshVJEZr1EWAZasTcXQGDl5
 l+EWkLX1ndQfKAKS/G8aICs8/Vh2FBZyPLL+lRZCEyC7m4C5B8ROOf8jbszU/N91nxQqZC1Sqqi
 PCZlgeAmrZkFbvh//NawbULx5ODUpNEH1WDK3olh2g+4Zs0Q619lkONPqR4tYculpN4DjLvf6LM
 Qj5kO/lTRw8p6A1NC32MnHGO+U/G9itdUXy3XuONBl0dMlPL7Pt6dKRQGy7eM+LKYenYLce31Wz
 8YctnFj7kK3eiJIscG3pmKP1IhsUOw==
X-Proofpoint-GUID: xXa7fXIYcYB_1Id_1yqxU064FImHTjVf
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fa1964 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=A-_Rx2uNxy_47QfWGsAA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: xXa7fXIYcYB_1Id_1yqxU064FImHTjVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On Thu, Oct 23, 2025 at 03:53:54PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Add DSI Controller version 2.10.0 support for DSI on Qualcomm
> Kaanapali SoC.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
>  2 files changed, 14 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


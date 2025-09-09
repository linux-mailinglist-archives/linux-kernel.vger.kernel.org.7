Return-Path: <linux-kernel+bounces-808494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF5B50085
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8AC5E3D07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327AD350835;
	Tue,  9 Sep 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctUGAk9m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DF34F465
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430089; cv=none; b=VNDN0OFz7/d5S7qgluwfS60BFFNBGJrkdJYvOWbeTm87m4qBVLUpyxlR2be4amBFdjeqG98CPU11dxtMj67/sIe1OK0N5JiCPlyEqW1ZGm0O21A0MwamVotKo8g1ulr6R1vQPl+SPnBpWQXIav+0pvvafeRi3dVTW4ue1fKJADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430089; c=relaxed/simple;
	bh=hTogHYn4Bs7eYKX2bQcxoYiKlhRUc0ZQ/bj6t0Z7yiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqtBQfTOaR6BgngXry8ny1OjojNi/sUi9Skj7viCv0XIZQxZvhs4MtbcA9tA8QxvaGPWzjubpc+BSMwjnwSfan8VzCsqsg6KCqlP81cXVESFcYNzd7d3A5lsBenDZhCBtIUUdH5xwYgwld4ZQxPdntnAJAmLUcztgObFGmNZHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctUGAk9m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M0YA004741
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 15:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u0lgli35YLNS03kPoYJ/ICz4
	vDSP8Kg9w05gBdHJbis=; b=ctUGAk9myr8+w6NoQvAu1jAZqPtUDtOgbSNbw8OB
	I4dHfBkmcwVK+bDv1pP1X1CsFfxO8vtbMbpt+ys57Qszvovc7EBAln/R+q+X+WeY
	ljkKidtjP4Zb5RZOk9g7iPWfXV1gVNZiMpfEfp4jLs9LoXrSAenS4K5G+ZPBdEA0
	YHRCCcljtfjf47vuyu5+AXTBfrnJUqi3Ub3me39B596udqxP9ZRCvi/HzZmj11To
	nPOW1LwPwcrpYVlYPUI2OA/j0w8C5tSuSF8hRm35ROoRZWZwJEHdtzwrt/gNHJP0
	9nrg2R8k46dQDfAwXvmSEtb3Lt8/z+BkBP2XPpg3dWZJSw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapgw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:01:20 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8921abd6c84so8530210241.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430080; x=1758034880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0lgli35YLNS03kPoYJ/ICz4vDSP8Kg9w05gBdHJbis=;
        b=Xszqb6pqpb7iG7RZr0IoxKnCMwIWBRR5Z0QdfcWmCM862eKkeyIxzPm16W7Q/Fljqr
         wHZtAZQYKxaBBXzpkYDo62ZEVkrVm6ZSwDxVAt4/TByz84nWvFqzh10r+PnhblzYQo8D
         cDhM/iwlDszaMxRI/MVd5ttAadhqcTnjw8dAOSUCEqwjnhKowvBjnwjhmJyRItfZIcA9
         Jq3qvaTyIiR642ETyOwoV8y+r2+LlrCUlm2skvUqpN2UCazTcssjKXPgJPeRVKv8Yn5T
         YaDxHe1DutqsFK0IOL5dL5qMfbXEiLkyTlURaMU4kWzLQNC3SZKS1XCIRWMzlFd1VzS7
         4LGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnd4ASyeGamarINJ9UZAJB+6wydkYSDdpqAli0pGUlsYnIQGQ+mz7Rf+By1a/heiqeJ8GM/FezhVvlS3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZ/JYtaddpdeftY3fyi0o0cDR5tx2XYZaNoF/AljVLOejQYAp
	Rp/7uUgrjdl0hiUo9SDbC+xZM+ts2HM1PD6Uf6a0pe5dMKlvPbJXgbvPm9f1K/IGoKy4kB9dTDg
	5dhBK1dRGScF5S59QJJre3cCkPYBmdgcJwz/wrwVGHFuEJh3cqd7cJTUX0GgkREy0pbQ=
X-Gm-Gg: ASbGncuvNtLCLijBnKRt4Tno8eCZ7Zn8NnW8Ips8GWxXXHw2bNZlXOALWdGWE2yel1p
	wqX+Nv3PYob+6ZL/393T+gLLIrVMfG3zZY6kFMWWKVksJEigC+q7e5maUahojflCs+vwbsQE9fk
	yKXD/OQeFM0rIfkOUuv0deREjyXAeJySF85EHzxqnUxwYUe/BtKJTA2kys/u9LEN9qODoLhYvty
	z6AoFXY/PtXSjq/XOIT6xzI4r1y/kcP75Z6MF5wEbLLpKMKAtsQ9UgA6+M971r9j9Zz/9hxxuJM
	x9aLCGVKBNUDf6+nJdYjQAKeYrvKEcNCfw+GwVSUqh0L4RUANpx+QtrbtU9RUzeUapoeMUpagS4
	CRAjs9CCohoEpSWV3BKuKEnICq1JOKBGj0Nm4FDNxpjG5QhjGom6N
X-Received: by 2002:a05:6102:5f04:b0:524:4800:77a8 with SMTP id ada2fe7eead31-53d1aeacabbmr3521015137.5.1757430079411;
        Tue, 09 Sep 2025 08:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXQrC/3gfSjePsXH8DNK69GxDOTHZaV8vPPCw8jrU6FISo45tmgpgz+khuABN3mbrRzq6IZw==
X-Received: by 2002:a05:6102:5f04:b0:524:4800:77a8 with SMTP id ada2fe7eead31-53d1aeacabbmr3520861137.5.1757430078265;
        Tue, 09 Sep 2025 08:01:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d5cbsm561765e87.74.2025.09.09.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:01:16 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:01:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] drm/msm/registers: Make TPL1_BICUBIC_WEIGHTS_TABLE
 an array
Message-ID: <onhosploceq2ksu7vxjh5e6phg7h6lasjdloxkirgps3tbkaqe@7vfqdbojjnts>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
 <20250908193021.605012-4-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193021.605012-4-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c04141 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sIHAvruKwB1gmBPwbjEA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: OhlVaEiQdXpOr2wbjUHXKZgnCFYNJnTy
X-Proofpoint-ORIG-GUID: OhlVaEiQdXpOr2wbjUHXKZgnCFYNJnTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX16Wsx63VF83j
 8sHX59FNxf6Z/zVgbK6bX5LKvG1SvBPMAK9gHA/4o3ZoLuMpooX28JRb/EUBksStRSlaADUGaEm
 Zo9Rqm6JFIdBBXHnu1EPd0nkF8CHoryZ6jj+TBm616LVzvgulZkslEqCl3HEkZjrRZyaJCSlcKi
 lXdWMfFm4ZQgV08r72/acQ/ueksxja/LE9BBsSgZFR+qis3sn18GYVbMAoBmAzlLcmHXPW0NOr+
 ee8eV4GwGChV38z+hwjvnUlovaKERI9am3s8f9F4K92aQY3z6MPiOrsml4GxtzdnOM8VaVR/xN1
 8B3nQqDeZxNcLXKKHBAel7sdPtkZRuO989knmnJtI6fGryjsgL0Xa0vpp0FET/2S8Hr1mwHeGzv
 9vfGXX+B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 12:30:06PM -0700, Rob Clark wrote:
> Synced from mesa commit 77c42c1a5752 ("freedreno/registers: Make
> TPL1_BICUBIC_WEIGHTS_TABLE an array").
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 10 +++++-----
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 10 +++++-----
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 18 +++++++-----------
>  3 files changed, 17 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


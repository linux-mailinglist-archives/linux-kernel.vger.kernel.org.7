Return-Path: <linux-kernel+bounces-757221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B2B1BF5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA197183B77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512A1C8610;
	Wed,  6 Aug 2025 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ky5hYJjO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96521C84DE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451284; cv=none; b=cPFtDAUnqvXaBI/tYsLVRu1d+Drgojv2FbkEl0rFa+n769VMJry/WdBR/Y2Am+BHSTJkBZR8hD1KTY8TpOwZPCy1ougd7EmrYI8LjSQM5R72RTXxX21x00wg+Tj96JnaYpZuHfBOab00/Ah9OwYhy/XYgNlw2fFrfT6HhrEahB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451284; c=relaxed/simple;
	bh=NzrlrfT7twieWqubi3dpeNuoCN+FVi0qfUc+p3YFJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXkOPCn9QCk7ywMv/yZyyNLbEMyJi/l4kMDA4N/WeIl5F0mJE1HY24gjYIY5pnkcXJ8ArIAOnTIPtjb8xPE6WHGnlBrqSTxj3bMJyhZAm4JaCly7nNJyOcfmIT3aa0+2r2AELkZnTFLK4nXoG4/KYI6455QBUbahAqcJUmIzxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ky5hYJjO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761es5O012623
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 03:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vth/2Y/jgsPixg8dhAKuw2SN
	Go8Ue+WIsJu8g0n76us=; b=ky5hYJjOnww1R/xoC4N1pXPVFWroBLAe5pfNyjWy
	66AqCAs3NHStzYDJ1JJoL1iWs74SksGM36HfTCwAAgFPNjW1KEV7oTQAeJA00FMx
	yzDWagytDuOdPwbVUdq6SD68LVW1P/Kb9epzZcap+Jo+d+xDmUyB7PCv/XhUiKrM
	3Pmv6UvuVH8x+0DhWSROpkExfXOF0dukgqXa7sZ5PbCxQT/p7c0/cPJ7UOKQqdVG
	XlmsoePLIo7su/iy0Jt2gdYAo7pHIJ38NZpU1i2Yoc4CMNqkICZ8ssML8FKMKj7N
	+x7uoip+lMbk/nGPVUqZpRgm59TpRWPfsYsqcNIgYxdGZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvysa43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:34:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b096d8fc3bso917831cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451281; x=1755056081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vth/2Y/jgsPixg8dhAKuw2SNGo8Ue+WIsJu8g0n76us=;
        b=Mx7c+DVDReOGBZHZrbInbUw1dREz5Kc1Etm/p1dTgflLfBrGX5QM2Zs/RHV7fUi17G
         bvEEuW4u1tpNjgaPNb7djNjXbbOtmBi219hkzOrL0T0Ti2lspmKX23U4eS7R0GlrZ3qP
         z6mP/2pvPrPrMO+TrjvtqE7nRgRuU4n2KPqm5Z9YII9ezl2w/iI3y2gQkXQOsFODHjVy
         fxOI0KWkDSqipctG9q36IHzTf97qT7JfM5HF0J67J7MXg+K2hY3JYSonXLgoQF6c9Df2
         xAn2Mecvn59dXBGrnaYt8i2DMbVDhuH/VpQnmOwm4/b+lUboAPo+7QRPT9U4eWDwZRBn
         JafQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGzTNPwtMc9G7DsDWmQ33ovGaajIgbrY1cjj3bIQvjnyRVd83bzEU6CyB/0ctvZ3Jub4UGNpJA/aqDyKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+V92tT/1XURix/ljWocO9U4swVCKXBdnclmenSPoor5/MkPW5
	dQWvlnLrQYSrIl+czhELygngF9utmSWbJ8BDNYYFX3g08oB8BjQQNiLOxYNTKs7FMfFfjUBUpLd
	vyzCcszcO5ovPmPOmmMGqdZraEiit8GfH+JtdF3LLsEyoO3kCjiK44dxc2tg5SU3ysdo=
X-Gm-Gg: ASbGnctQvJiP3AGSUDGjI220kXtHYoxdX8GxI57wfjdVpM5IL64/nj1GWWjEA6mrruS
	OKNE8kvpVygVUYu9UknA9F14+VJ2omJowEFg2ivjTq6yjTqYiHBBVTnEZQtBOxWqYBYHYcrGcgU
	Te9VjzzvqTlwoR5akCTQOrY6bqaY+WJITHoDMWlDe25Yq6QIEjiI/XZZ+cA3uk71njLiPw6+VHt
	/slaZTIbBpIM20ZeadH8jkL5JeLu3KNRRuOUF46gYBgdlTt1rdnJDRuG6TJlZBwkOjdeWKhAfly
	EsD9M0XMXCAA5fn71HXJhDb9u7lqVH1oBFKu7oKpnl8Dxhe0MJnQ/XFEhv5whyY/rRHCMb8KBd7
	hsHu+lfYTnBlcXzD0fE3VgVP5g8gscyqDoH2UjyiVTA7hz9fmxpLT
X-Received: by 2002:a05:622a:5a99:b0:4ab:5c58:bb33 with SMTP id d75a77b69052e-4b0915e48abmr22499121cf.49.1754451280663;
        Tue, 05 Aug 2025 20:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7vcXFUJ30iJDUbRPzNDGIhCemggG/HQOqpvhQreed4gLOPOyKQ2xyiSwmnN889jRgtv0Jfg==
X-Received: by 2002:a05:622a:5a99:b0:4ab:5c58:bb33 with SMTP id d75a77b69052e-4b0915e48abmr22498721cf.49.1754451280181;
        Tue, 05 Aug 2025 20:34:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beeesm2165977e87.17.2025.08.05.20.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:34:38 -0700 (PDT)
Date: Wed, 6 Aug 2025 06:34:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] drm/msm: mdss: Add QCS8300 support
Message-ID: <edsul4zxzcgg2lglxpor5xlzfq35c7r6gmw4o3iermf4z7ftpr@elzstjjft5m4>
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-4-dbc17a8b86af@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-mdssdt_qcs8300-v6-4-dbc17a8b86af@quicinc.com>
X-Proofpoint-GUID: f-OACiI6-uJCF_UnhsFPn7emHDWn4Jp5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX/CRMylHOI6lu
 pGaYiJaBmmtPqIcwlEkHUAZ96JhCUK6KalrtDuayjqF9chROE5bzGH1rbgBbsLnmLYp5B5e1qMQ
 R7QMEly5YZEeBYTksAbOb9OK+tDB6S1WR0CVy8zJZtRIHVtLCJ+4tUfJZckm6f3okJw/jp2p3q3
 KZbf334lVkClFlARxt/gstRwJsl0MU6M06bi/BGlGbYsVx7HgDpNvtYuXrzdMeHC+t8tn4uauTj
 bOyrkFJA1mspcqyiQCPop/RCV1HoyldcE9YjeSXri30Ou4nchYSII+Ba79UCicW3osb9hhHCR5v
 2g/bJHDgeBSmpwosU0NnLUVVJ08+In/c+J92nL+jfvTuQtoA8OeP/v/3NmTkt5K4GSZLkFE1Zkc
 RJ/jIbcb
X-Proofpoint-ORIG-GUID: f-OACiI6-uJCF_UnhsFPn7emHDWn4Jp5
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=6892cd51 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=FdNK5TKXhCwMvpUfx80A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 11:16:48AM +0800, Yongxing Mou wrote:
> Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Nit: the order of patches is incorrect, UBWC should come before MDSS. No
need to resend the series just for the sake of this change.

-- 
With best wishes
Dmitry


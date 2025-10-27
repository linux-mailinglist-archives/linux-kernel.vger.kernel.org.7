Return-Path: <linux-kernel+bounces-871965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FCC0EFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C00B3A6447
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4430BB8F;
	Mon, 27 Oct 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXl9Ky+8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B472ECE80
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578930; cv=none; b=iuf37ZaUJDzMkN9U0xTq4pwKyVUEL1HSY/qdyCmyXGLiu+cPyOKaQzx+VEGg+7rhcP5J2lrrPS6VtwIuL+T117v24BK1G5qpFJbvQ/7EBju9qLj2tBKK6rDt6hN5UnAu1HY3Wlrfgs5E6BLH0k0JOVXONBFh8wA66rvQv15b0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578930; c=relaxed/simple;
	bh=No0vFhtPKdnYI043Gk+ECuIMyLsdn51FVS0+isuiu3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPlfkZH5yAvHR84VZ4Mq5kCJJ656TEE/0S2kuIdTEscsBk7BIZtU8+jLv4nmErhV+6uykStf3TeF2uzJOPgQnhhIRp0nwKYmLuZrlJQBjKSPw48AzVboLR1SGxsAlewTBJ4vpk5Ir7ZoBsdZ+TBEoZ8eanomi9yWefQn8dyapw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXl9Ky+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RCU3OT2752636
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YrpC/Eij51oIcLt5fwITYt7x
	pzA6N/JSreOhEW3wMcU=; b=fXl9Ky+89oD+F37ykbRqhqQ3dkXcpSACYzcYskik
	WZpI/aMEkH22yOmFh3SshHaNj9KDqs3bYZMDF0FpbTiUvgplvZ5feNcCBjya0//2
	O5sidI6HDx6bqtPtAPvyJuTkzXVvXxQiTGul73MyoFNxawgFtKM4S9SAcuah67eo
	8D7yfw6QNSzjonTu2dLuVJSb5g9WKOpkfn50GypsFIy0E1tYhFsztJFosY4kXZM1
	LWsnrHSUdtvQXV4lY5iGbr28GMrUbUOWqUFENIXUyh40M/lLLfDzZ32VqR1DLWjm
	4fULpVLiCOuhYh0xxIcY8sNWyoR9zVkXmDi4C6B3f12xsg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swgp69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:28:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf5d3b758so39538911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578926; x=1762183726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrpC/Eij51oIcLt5fwITYt7xpzA6N/JSreOhEW3wMcU=;
        b=NazoHeVnQsl93Lb79bVtXcereKHm+fuqLBiBUnY8zuJirOCVAe7AjcNNJ6SMI8MNGx
         gJvbBOAYZHzIJENnLvHRgq09y6xa+UIMh02XAxawCG/ZdACgEm0DrEbFDhFI+cIhkcRZ
         lxesAgll4nhzme1vaRVTPKYYO7b47PRlz7t0uz6pVa7bUpTQEqjULi8vlum8mNqhQVur
         Ne9f0aFVaw/JUxP772Q6ET5u4TQupKiff95sRxFrrJNuLuyz5Z7K7auBr3Za2F8S4W6K
         GjRZKHogj31z5ywGR2HPaHagXj8ZWZaJHw3c9ARypdGR3mWeHy4D4HU7gviB7goC+0cA
         ft4g==
X-Forwarded-Encrypted: i=1; AJvYcCVvIPbqLZ1InjHNwcZT/uDqUkO+J9QhIWJpEcRUaO02BwSy4ZF7cCWjpCppmJDW3FFGaCMsuqjMoc+Gdec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGFSJhkQUQ1FueZNo7kUFxgSEtmSqUzH5opU/+OXEMtgLRADb
	wdQJ3Ax9NM4xBkiuvvo25tIwPGPJKFktYjD83eB98FgtGTzeA2UJdgu+nqccqt8jLcabb6VfUSt
	/0nC6JUqyiPdtzw2HbRZKLnKdk+7rAKu8Pr4Bp0h4kZrN2vWDCZG8aVnOqUON4YGRL0w=
X-Gm-Gg: ASbGncucO0K7CAVXLvqMtZzgbnwZjhagGvsviclgQlh/gEASX7FcdXn8UN+VQrHT2jj
	sR1jfoVSOwZtPa4+VnCWGpwXAn/yJMHEjJHJkjPjZAJIAxKnwiPCM/gxJBgMTMKU2PAl1lLAxJY
	RXsOCK1jYMjrQvYE1OIpvwrYYkBuhoE0PmMMG+30/eUJ5eI8XvE8d/FpyFOJolBp3ZWNC4aXHFy
	TZobFGCQJMtPIfU836EGgtt1fAYnuDcgODAyefV1bFi4d709eipQ3kSHXWNrjlepfpJmhy9cKB4
	Ms+q+UM9SYFHenzZ1Ulb5S9zSQ4GCwnu8pHA1bu8RdHO4akwU+VZAv1UIb7OHAk475btaLCaDqj
	hhp/co7gnpBawK9c2RtsA6KtxPTcU8LtWcvJFRVGXmfQc7uPPqv32qmBOWRi23X1fYBwBrNDQDt
	qrocZGPiR9c+su
X-Received: by 2002:a05:622a:210:b0:4d8:afdb:1264 with SMTP id d75a77b69052e-4ed075ae66amr5031601cf.51.1761578926131;
        Mon, 27 Oct 2025 08:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjv+f9Wm8zIpfZr0CI4TlRCnBPRjNZSJNUnKZu9weamrR66/3k2l4bfVFcQ9Uy6J4XGbePmw==
X-Received: by 2002:a05:622a:210:b0:4d8:afdb:1264 with SMTP id d75a77b69052e-4ed075ae66amr5030901cf.51.1761578925321;
        Mon, 27 Oct 2025 08:28:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f700fbsm2410946e87.81.2025.10.27.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:28:44 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:28:42 +0200
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Message-ID: <2ppfdoqa3fyjysfv4kiincmpbdstkgfwxso7tlfcfyfmwsndok@7krfjzdvsozv>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
 <7dxq62ltoeerb4g2fgchb2hd7eomvlexfgyvamxsuuirblavtn@4bg3dy2bukdq>
 <vngf7cnsj36ddg4pdm72airm2nketxk3m34qw6f65ompimpcfl@r3lbv73tmutj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vngf7cnsj36ddg4pdm72airm2nketxk3m34qw6f65ompimpcfl@r3lbv73tmutj>
X-Proofpoint-ORIG-GUID: ivx4Y-xwrz0dVBR0LAmuEtzCh9Il-fph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE0NCBTYWx0ZWRfX6TN/62zdky9F
 nbfsijCW7fXhTTGISmHEEw+4uRImlXuZOqXZGB64DTf85tEUUittPXiNiNGbo7wfrTBSccD80I9
 aQVppJ6RBvYOXLrUg1QUbzL2uVQfG9ZfWoIqBXMIRg8BBWV1ZKIcrokNRx1IPGWDqqGbMDTZdX4
 QDyBQ5skWTMMe0VNRW51vytxwRvb6W4DknOYPqw/b8po/Xd2zN9Sz/wKDojgJ3ap0Du6KY7rLyM
 /ctCvbhcao9z8h32iyYE3Prl8LJZIk4rm6n3WTFW+KjXQzO6prC35xXF2b/XVk9P4TSgoiLhXH9
 HHaPyfxEReJGbnxxrcg8xVjbJxtYxjXAkRLPm4qrjD3EzhRFng9lef56p/4EIjPA3MhQSjigopn
 tPbJ1wDRwGw4hijlE2e+UnZlllbITw==
X-Proofpoint-GUID: ivx4Y-xwrz0dVBR0LAmuEtzCh9Il-fph
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=68ff8fae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=L6mQZqrAOGHZejgJyMIA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270144

On Mon, Oct 27, 2025 at 05:03:43PM +0200, Abel Vesa wrote:
> On 25-10-27 14:29:01, Dmitry Baryshkov wrote:
> > On Tue, Oct 14, 2025 at 03:38:32PM +0300, Abel Vesa wrote:
> > > Describe the Universal Bandwidth Compression (UBWC) configuration
> > > for the new Glymur platform.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > 
> > Bjorn, do you indent to pick up this patch on your own or would you ack
> > merging it through the drm/msm tree?
> > 
> 
> Please note that v3 is out:
> https://lore.kernel.org/r/20251027-glymur-display-v3-0-aa13055818ac@linaro.org

Thanks. The question is still valid though.

-- 
With best wishes
Dmitry


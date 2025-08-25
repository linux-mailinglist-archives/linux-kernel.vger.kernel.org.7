Return-Path: <linux-kernel+bounces-785293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DEB348AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845253BE762
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA2303CAC;
	Mon, 25 Aug 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tt3DgFih"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD830498D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143025; cv=none; b=qRPWm/eKFt/WOFxSefqOhnV7r3EjiCzDymxyL2qqKiW74CrsJ7NFb0KoQNXz+5TERM578CW1YHsWBV4yHA7VqFhXByEoohDFUpoNOt3VI/RsSB48x0A9ndbgWhu2NytbR6WKgYyJZeXxlOktBdh3/DtbvGyETjn95BMkt5t0y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143025; c=relaxed/simple;
	bh=Q934RHEWNvER6kGBGv/SCyzwSRVggyRVlz01jdFWjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2oYvBvQOj3j/+Zzbl6ugWxGY7yBGnU1CqxMs62V251kDcg1llPPfnvsidmZVidICZCg8dRxcGODevtz9v+GsOo0Gdrp0Jj+fQ0OxEJ7bayHHw+3K+jlyRasUAcZcKiPtjlPeev1nNL2dal69DgcXN9uHVoBBbCn6dvNk561w6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tt3DgFih; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDejuO021344
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=neFHy6pBsQ6WKu78LyU0YORv
	KojYkODY55mUj+tWBZo=; b=Tt3DgFihIWZWpb8M2OycE6c3K9q+17l8lBS2LmWB
	LjYJf25JSmO0wFd9sSymNJRegve8fnxCBe4K8ixVPASR9chvfzHmI8aAg+zjzWhc
	8S22LMYfj9W8ptiA4ZQ8pjkU677sc8ibmJ+XtUAseTTuSAs8crDeMq0rixCww7gG
	KdtULlz8rvKFV4ywGPmZvoCwRoKZZlHooJgladeUP9R9ulnpC87wjBXHMMsoJoZj
	0Q3Pmc6EKeSCgTduueV38xX8h91PC6eC891+vHNGc5Ts5p5CGjkHGkLigdRgc3uy
	vESihqsZM889I8qmIC/Rdvzy7/+re5fUc0JQOFn18LpEoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615dv7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:30:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2dab82f70so19401801cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143022; x=1756747822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neFHy6pBsQ6WKu78LyU0YORvKojYkODY55mUj+tWBZo=;
        b=iPsniMXTq11MWbjVx6czXSLNBfpRRqDkl4gkIzpetaUyLFhTGWebs3RmP6VdUYTvSo
         K53CFzndlBZYAStR8/0Jsg63zjIrUNyYczZZ2TP3nNA3PfOG3f9ApOp6ap7PAiWhxAig
         Oy371QgK1JlfOfjPUL+yYmaLSFzCqOF83Let6L+fhCAnvju52Yg9F1MqfzRuv2sSj4kG
         8yIHn63p41llb44+a0tzEka3iW+C6+822rE+dN1bXIicBGmX3mz61ypiqyrplI1xuuW1
         AmDQQVo+sXiJ8MW28RDnYkECM9mT58uua60nBEypA88Pm+VukP4CCH8L9O9mD0rtpqZG
         2qGw==
X-Forwarded-Encrypted: i=1; AJvYcCX+YeL2QDsI7bRjxCGIbuNpkfHWyDxnBkttQ32ShfR70a9a6VcecrZBLE3L6RDlgEsiqNT/ZYdVtQPawyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90Qg02W5DMCanAg21WV7XTgu5rntys2G7L7KN/qgbLssrp6jR
	q3XCtDIsiOoH+3RgGLZGPzJNTSbMW/ylHpxQANBTwwNzJT4eHlFXmisut1NerBc44vFUAB/qn+V
	Fpqe5FuvY1s4xwTrkJFu2QQPpLEATmkLyoEJjLlMa0V0HbGD+c8FGhWEvKrSlEawIx84=
X-Gm-Gg: ASbGncuVKdOPqpOXVWilVUTCwGEQsVV7aVss1yoIEMytag/y0t4GhxjEpUeTFBlKz/I
	sWf80jQ0uxjptfBG61nwaBdM+VTZ+B7vQCgU2du5w84O2zzznzRc7qdXPk7Gzadnmh1FTvF+DXl
	Qzh7oYXnvI7gnT9AF4Zb5etZqmgI4WQ4Py+1nT0+xRio+8bk8kSW7+2Xj4ofzZlUSMnAci4lPvk
	mWxLwHNS9dF8rsstaSzq5YxpYG9TtnILYxPvuB0d7NSBG5n7bfqygzonHb11kRqMFyA/FQd9slv
	ef1s2wYAJOYJ+Ah0RValmuO2bQqLZ0tdnrOS8V01fqzcmjXKsQcDh4D5sUpMjmN0oXcPvaFGOBe
	RUblU3AfVJR+o37xnex3JFEFNn56gtQXEJgxu+/kFb0KhQEwmwd2V
X-Received: by 2002:a05:622a:2cc:b0:4b2:e13c:7fee with SMTP id d75a77b69052e-4b2e13c80ccmr3483181cf.17.1756143021896;
        Mon, 25 Aug 2025 10:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELS/2d5+L9lLpB0VeTUT8WkNv8ohXmJEbk9C/iG2W8QoPWz1VZXbRnGVLPIHh5rG8YSI3gDA==
X-Received: by 2002:a05:622a:2cc:b0:4b2:e13c:7fee with SMTP id d75a77b69052e-4b2e13c80ccmr3482741cf.17.1756143021326;
        Mon, 25 Aug 2025 10:30:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3b946df6sm1466108e87.36.2025.08.25.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:30:20 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:30:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/38] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
Message-ID: <sxn2uecmqxbfqkmuzj33pythn4qhxzofbweacrpht3muc7djnv@nd5i4zzt3up6>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-6-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-6-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXwTeO0NcIexR6
 95A4Wh9K/kd7Hhhl4748r0JqV/IDZcIqbsm9hLeUiysyy5MPYH6sAMudWYunExXYndSoZ+MWCkH
 q1GFg28Sk+uLXW9wBohfBbRh9fo5gA+tYbzczAiL5T8ThsaaRtgBnCi+sA2ttCpiTiGK6tRQWSb
 KqTD8MwB3WzaQ2AslLqXcNSLAmPdcbdCVW38fE4Qpr1mZaTO2NshA9gvgG9gUUBvPArkXyacIfn
 zJEGBb9eUZWMdjhtLuKYRsv0+W34tMup5hRBT66gyL9J9v0FEYLl0OuH2uN3hbxclOHfFaNKagR
 PQL0dvmA9HAS1uDmnvfiIYPekTE1YQRQBxLpFQWjraWlrSwGxrQ0jvGMc6GmMn5IZcO6fTMn4Gh
 cKoRJHZ9
X-Proofpoint-GUID: 6Pp-NRRZ30JGSL7aoqpcejYNHYE0Rfdz
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac9dae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=JkHNupl4tvVLzN8DOdMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 6Pp-NRRZ30JGSL7aoqpcejYNHYE0Rfdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 10:15:52PM +0800, Yongxing Mou wrote:
> The MISC1_MISC0 register contains stream-specific configuration bits.
> To improve code clarity and modularity, this patch refactors the related
> code into a new helper function: msm_dp_ctrl_config_misc1_misc0().
> 
> This separation also prepares the codebase for future MST stream
> programming support.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

With the commit message fixed (see previous comments, I won't repeat
that again and again):


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry


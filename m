Return-Path: <linux-kernel+bounces-845899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3EBC66E8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E760F350AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14492C159D;
	Wed,  8 Oct 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TS/+3fj3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE31F9EC0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950659; cv=none; b=n7ZKCY2nVjXhFFlUD95INpKKgFun8aYYfbexJYleKkOjg9rVLm6EJwT06L3xui4lrrW4WlpM4wSdpWsEKkW6/43jnoliCT4nopEDUyTx7PB5QYjYHssBhTrrj25rHtyvhquGpJcO9yW6bBFSpTrWRnGz6sFopVinoallBZdVAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950659; c=relaxed/simple;
	bh=3393mM6j+zRP6aM0V23h5dXXACKdbdldLNfjY/xfisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2xunwCQ3xqYYe5hltD0YT+qldmUrIaxZ9v+9PEZA1hi6lmcKdd9ni5ip1nP9IoEj1fRe+MxJC5R8aIQgHAyB/Muzry7TEORAOSyime+bZLqXRYKdu9HqTtwSsREHm9qyOGfzgMog0UoxwXH12BkO5HiP5kbRdM/KAdHDkYtwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TS/+3fj3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5JfC014308
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Mzh8Mrx9XBniXDY+QCxqv+ig
	jEo2apLpJTr9CSk/4oQ=; b=TS/+3fj39ikimruvs9n7Tjc/boB6Pc6NpdraOeml
	nvljvfpRtK0Y6RST7K7uELbx47tB3LpsFtEQNHlOm+gdE5+m3zyBy23rOo7F3MKQ
	SjJZp9Unh+k/7RkCCdseMKLwl7CXXsEUCeD5K4jB1yC8fGDpVX7AykMKErSeGkBk
	bMROR3CZQuezSRlswcV79uxyvy411/k2DeqN4VGQIiAzvnxhsegFygpcPojmUUqA
	cwKqwlRS/+EFtJWQF/exXMXrh9uPcDzkjN3PI4Ar8Rcr1dEBi+1iPDHAZ+F4cXpn
	OECcvPNZLaQ1Ci0ouq2BO8grVpUOBs6lc6hUD9c1Yn/Ykg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u0bhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:10:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d6a82099cfso4133521cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950656; x=1760555456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mzh8Mrx9XBniXDY+QCxqv+igjEo2apLpJTr9CSk/4oQ=;
        b=pj4IIZpIItqM9AgPxKK1JW4BDsWIeAeemxtFUYioOPfut/IN7WnbiNlF/TJCRhh/2z
         WvW7ZQ+GSKyk2v21arrZ51amRy5m2KAr7ZDm53TmcMgzuzTfMWmFlepC0aY1GLTQoXpR
         d70U/Jxg190zvcKwmZcB//K1QAJX5yO0C97GehaC+q5X1jcyxM6vjBikVLvCxWuRRqv1
         Aey2aYAPfJ837+3oO6IBl4uQBT1gpiEzTOOXRsOMpqqY69QheQEKtA4HEWIeGfyRCXB2
         Gra9YhfIR2WAp/2R4UvolBUAA1yGN8dvfoVw4VmBTaJ+KwOIwrb3v/hpGYm7OClZGqLD
         IbYg==
X-Forwarded-Encrypted: i=1; AJvYcCUO63/UPE0TjW03lzh5Tcue1zvkzyUsKwR8gaCUgxL0CU9Q/oraJGU/921F1wr9pDEmH0Qamw2mFI95k4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53kVC72DjduQllEJJVVtigsB1LtNyYzMaQ+ePX7vVr/gIFcUU
	ifD1ni4yukD0HFJbcwVyr2l7e48L2bSlk6dJWAzUeKPS4haLuatzAFEsqxgQGGUz5Plxqb7gPlq
	77AdDN+e/FiGHK0ipnt3w2SpbpJ+BVJb8opuLbsSe3if6qC6+UE5oYRyfdCuOB828ZGQ=
X-Gm-Gg: ASbGncs6sEOy46Jvqwb0WkkbvTu1Vyl+xE0Kfh/9T5zBGfhMQJ2yNADPeBZWHu4xI2s
	XcXJjmKqYLjEJoIXbWROn2ZgkJe2be8ZyfUyh/jnvb/9J/sRcXLXGSBzo/TFXL8PoLyllckPgR2
	BdGXsQ8mqTVN7VzvPI4shsTN+otTBOv2NUc9ZxewFQYLmVgeiLi21oVY2UQ4smBgWfXnI3ORHbi
	cU9BOIs/D+TIWMY4PGc/hKhgPt38EGw7WjV9m702CInOrCfjEDCPAOB4NP35doQEcEnoU03awAA
	LiNM/g3vJ5GUG1UCG2fogZCcGm0Mgh25ZrUyUwSTOx0iBf8Hfy7a5gSAxCwRGCFUB9eTDUn1SOQ
	cUEy4kyVp24DLBxmtC3hOAcfjhH4b4k6gd6XTVXjbOksKd+Pf1G1nZTf3Aw==
X-Received: by 2002:ac8:7d41:0:b0:4b7:9abe:e1e4 with SMTP id d75a77b69052e-4e6ead8011emr63168471cf.82.1759950656047;
        Wed, 08 Oct 2025 12:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNjZ8q/pme0xqe30pUUGYIGQ12Gl+haC3BRzE9Uf6qMFoFnkdGOaRBmsKs07f1ZOvC8HGxuA==
X-Received: by 2002:ac8:7d41:0:b0:4b7:9abe:e1e4 with SMTP id d75a77b69052e-4e6ead8011emr63168031cf.82.1759950655543;
        Wed, 08 Oct 2025 12:10:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907aeb3b15sm260834e87.117.2025.10.08.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:10:54 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:10:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] media: iris: stop encoding PIPE value into fw_caps
Message-ID: <p2kbhv5ybdqethvwspupezeivrdpqzk5cdwmw3cwurga4mo6wa@34yu2us322ux>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-4-def050ba5e1f@oss.qualcomm.com>
 <d9b6ed42-d70f-46d2-a0c6-a98df4b46607@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b6ed42-d70f-46d2-a0c6-a98df4b46607@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e6b741 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=13i--0rwG8f77gcSRFgA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: i8GZflpEeifXbV_HF-6H8TSEeiY4lCjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8ttI+uKITqaZ
 wOZE7J3EUxmRgtvkBLAGWpR1vC780PYW6GtTdUWEerQOsEa+/FyWv4kdjmKGYokipCnubtq6Ql3
 /QZBI8obwOaBKF2iGWfnj2+AlTw5oUfnHpSU5NgGp8/a6fXEWVEN/rdZxzPeflMD9S1Y73xlxBb
 67ulK1VVji9MYFgRLEyuMWdUFV/7VwzBJDrtn9FUWE9y03BREyVwonDILFWwjUPWVpJRKih+i8X
 dU1t0TGLe4pKRZuq+hjfrgr0BfKY1E+WL4kGrKAK6diSrKQw3jpGqbVMHSaeTsxWJcIcn/+uIAL
 irfm9T1e/YtRZy2XR4wpLSNj6mrrfgK9AIjP5t27J78pD2a15WkHDOm34os7dy9Eu4EEp4TX4XL
 N+5s1D6If2DRjMC/4cPHUIT7XxkbuA==
X-Proofpoint-ORIG-GUID: i8GZflpEeifXbV_HF-6H8TSEeiY4lCjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 10:03:49AM +0200, Konrad Dybcio wrote:
> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> > The value of the PIPE property depends on the number of pipes available
> > on the platform and is frequently the only difference between several
> > fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> > iris_platform_data rather than hardcoding the value into the fw_cap.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_ctrls.c            | 6 +++++-
> >  drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
> >  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
> >  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
> >  4 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> > index 0e9adb3982a49cfd7cbe5110cfd5f573f0f7bb38..8db3fa222bdb92a7ffff3dfe62d33f16c0550757 100644
> > --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> > +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> > @@ -318,7 +318,11 @@ void iris_session_init_caps(struct iris_core *core)
> >  			continue;
> >  
> >  		core->inst_fw_caps_dec[cap_id].idx = i;
> > -		core->inst_fw_caps_dec[cap_id].value = caps[i].value;
> > +		if (cap_id == PIPE)
> > +			core->inst_fw_caps_dec[cap_id].value =
> > +				core->iris_platform_data->num_vpp_pipe;
> > +		else
> > +			core->inst_fw_caps_dec[cap_id].value = caps[i].value;
> 
> I really hope this if-else won't grow in the future

It really means that PIPE and several other caps should be converted to
explicit code sequences. I think, only V4L2 controls should be a part of
the caps array. Everything else should eventually migrate out. But it's
not a subject of this patch.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
With best wishes
Dmitry


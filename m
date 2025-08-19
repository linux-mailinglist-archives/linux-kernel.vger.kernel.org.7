Return-Path: <linux-kernel+bounces-776379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B1B2CCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B525B16BA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19626A0E7;
	Tue, 19 Aug 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNOTwsmK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957E2EB86E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630071; cv=none; b=TcveKCAUpbtTGjP1mNLKgejWY1nijf4XWg/6h94YPXdVIPULYhYiMCLxVlMGv3fymNldfuzzBS9FN381IaQjrLIQqLzy3elhEUGAH04WuUPPXTjogzoi38GQR5Hh+82Gm8c+9SCGf/kxsReTGvUXaZoWAg/lX0RD7genIxBh+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630071; c=relaxed/simple;
	bh=eez9nhfnJuw5MkH35eQYyBdqbDZ5HL8bveapjFesaOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGq9buQ53StAFGaHO6ZBrd2uW95WKh1Z4YjbZOYEjMP/d+YxO9kCmrn5uq35kyEjlWMvfFCf1/3NSmX8eJEabCMFDW/JHBVuRDCzco5aYQSRGDlU+h6DKE97GchL4nmkHoesllzw/zuddXDORIE/vaGwRJ6zsbWt6SpffX8pKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNOTwsmK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JGxC0l023322
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eSDc9BAB3b8+b7b3/+MDQM9E
	BEAEmQchCpTlVTVH4Ro=; b=nNOTwsmKxmiAAPv1CaIr7jcGE7rJUarSvvDl0fFw
	2vOcYRSEyqJ6z0bw1sI/tw5eGGR2SMmqV48HP2AXM7SOqjQH5mTNXLfpY9zNn/4Y
	/r79/dDwqOgYdW1wjwD1b1hyR91ItzIuYKdS/bKtYclVd5ROt6sVSfDrOLHerYck
	3ja5ntGtPKSXflcnhIvDPduVrodYB7tiGbDWh3nMjpnpY5p8r+Y25hNIX4BOV1t2
	iN3SxuUmFL4Wk2xc+6GOPUJ2jn5TH51q0IaVL5AVyHpg2/o3KYfFkggjy6tjC+yF
	cqBJP/DHJy6JXqoMjHQM0og9CLI+w/Z2iIZDuviGHNvDSA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vmn0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:01:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70ba7aa11c2so94728076d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630068; x=1756234868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSDc9BAB3b8+b7b3/+MDQM9EBEAEmQchCpTlVTVH4Ro=;
        b=IB7xQ+uQBJ+BfTjTNBTTP6/OO1r7jah3Hiza1c/3rmaNLyHnTs2Ty7gQo60jZreBvH
         yGCDPSAdzdVvyCRjZZvwUCCmr/HKobz3KNDNPNio5yA1xSPkXzR3EEPWgxhuaP8Y647P
         POdra0A1Hf9wQd5reuDcZZXTUwyJ9IfqL0gr+uXvUQEJLkhhHlBBD67wgkTx93r6roRa
         /l0MsrXeX0h5U0Ua4e9Zba3WrLjhd9pIABZSP6Wz7AoDPM0/PLlDDTvy+p0rrhN631yE
         iOT0aNSEAkHAm7Mx1V8cutLEFtoch4ebvb2a4Bcf8k+IpnCRnuSS1d2z/pBQeL1mCK//
         pNgw==
X-Forwarded-Encrypted: i=1; AJvYcCWCm4Fopc1dHgvuUrTVbWeLMRDXT/cbBbawGh6TJeh3XCxmQWiSBu1jemhj5yL1X6TPRICA7lt2zDz61Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/CKpJnulH+TvLRVHhv9dyf5YVNkc8IORs0w9Xh84bWZlZXHW
	Sz44AlpZn1F8jdzc8KXwLJE5LaxajlCP+3j5ysvAxXS4PLOrKdc+AoBYkDXv+7D9NuVBW6QW0FC
	eOlLO/c0D5skJ43FkmXLDYb2AQhJSiIC4jclnNHgTl+udaIbmQkVI6cFmKv5uFJKxhVw=
X-Gm-Gg: ASbGncvH6qYv7z0AkqcFbsYRsjQy1S7iLZAycP5+6qJYTwoljFicv+pI2SPs50JFlri
	KOGUKRwOvUUxA5KENDHPzlnAPWIrl5r8pwKRoZQz+Cn82PhvS517bk/ZXILc6dRdEp6X/k+68Qr
	+iNm0VwmywxiybQGN6myqZPs5S1If/Su1LZ78CFp7eWF0nLHdI3ZhyKengLJT9ji/HWjQlCSMVG
	53Ww9Pz+mrkdJISraH2uVKDMbAEnJ53lT8dB0Tkt+EOnAey+WJJOXVrD56xdpGmhe+wpg2ua9pi
	8EA+jCdh3rDrpuICocKLI7Evko8376v4+tS5N0tH7wL+VJgw5UAhTDs4ptl82MLv7KWzQ3K2Rqu
	SVHbr2TMzwWK5xQXCAA7NqZWcSQkn2whngiiYkXiRHgKtjfANhXAX
X-Received: by 2002:a05:6214:5086:b0:709:b691:c9b3 with SMTP id 6a1803df08f44-70d76fb432bmr1090326d6.21.1755630067787;
        Tue, 19 Aug 2025 12:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEzyh25IcZixT1XrdjSA5oTENrZfRkUdENPuOBeZx3C/0fuWIV+BjW3wFDLEBMFAfYSgCcXQ==
X-Received: by 2002:a05:6214:5086:b0:709:b691:c9b3 with SMTP id 6a1803df08f44-70d76fb432bmr1088806d6.21.1755630066382;
        Tue, 19 Aug 2025 12:01:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a4758bfsm25257681fa.32.2025.08.19.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:01:05 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:01:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 11/13] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Message-ID: <hrcp5pcjkqotexrnenm7dxojcmmzx2fl6ybxxofbtcot6q2hxu@3w4vyod2n74r>
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
 <20250819-v6-16-rc2-quad-pipe-upstream-v15-11-2c7a85089db8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-v6-16-rc2-quad-pipe-upstream-v15-11-2c7a85089db8@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfXy5a8tsgcDrGw
 UoOW4HJACovz0dR45/3KCtDoN0q8z6HjVTUpVeoZ9sX4Gyt5Eyd/V7/tOue3Dlrg862vNssDcrH
 f6RvPlgBckQ5e4N7tVSXkQQlUSgsfYLIN1jVFeNvIuvMjYgJPaPCL9nTzDvukocFtQdW1nFIZMJ
 Tsf4NlDFnt/r9XuSW6avw8cdzulOoAcfghOs+plhGsfjsS0R4lBtdWDj+iiqvbngwUg3h16A0uk
 VJ2swlaNPWSYynnmO0R/OJ1bUEemr6YEoAwZ0Cz/guL2omdagSqlQItKupcRn8v90QbvvfID69s
 kcB5K/MwLSoUzF1yrbzwMCEzOeJDsvqHfh82qn+O4/NDWrL2yMbUOb9D2IqSky4qtABvcL1ynW0
 2jDxHiSl
X-Proofpoint-GUID: L86lOtGHFmbJy5rKJ-fJORJQh8VMrX2x
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a4c9f5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=nT20EUERFaLimiOwrcQA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: L86lOtGHFmbJy5rKJ-fJORJQh8VMrX2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

On Tue, Aug 19, 2025 at 09:31:05AM +0800, Jun Nie wrote:
> Currently, SSPPs are assigned to a maximum of two pipes. However,
> quad-pipe usage scenarios require four pipes and involve configuring
> two stages. In quad-pipe case, the first two pipes share a set of
> mixer configurations and enable multi-rect mode when certain
> conditions are met. The same applies to the subsequent two pipes.
> 
> Assign SSPPs to the pipes in each stage using a unified method and
> to loop the stages accordingly.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 150 ++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 61 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


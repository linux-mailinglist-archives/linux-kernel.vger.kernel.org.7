Return-Path: <linux-kernel+bounces-751347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72AAB1681B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB1E18C5BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868312236FA;
	Wed, 30 Jul 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nogoDOgd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86323741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910024; cv=none; b=aSb2sYBWyp4WYr4vT6yBku+bVFSQ+0FijFQXscGYwMCnwfUAI0yvhqI+N1rjF4Gtey47dLko0XDyE8IjrKKOzh6h7NYxepYHZNRKqZcEPZo+HriX1FOJ6E14GJENfZYfzOT5z6L+s93PxWbKXFvVEdMk2dBuvVvXo2ieFeuZ+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910024; c=relaxed/simple;
	bh=1LcPcxbhZM4yOkaYvP1O9+mZX0u6/JWqhX3oLAYGDfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSzQtaTGLgc3/jVdSB8WDEVtkYSzPW9RjTiGw/q7EntnMAQK3L2ISCMp16HeJhemAN+U+jCcPMwpyHjG66Sk8vppKaXD0vNIROqXowKpqlcFCWRJ/FE7MSZc43JRPCgS2i0eTnlzD2sLQrbhqwJvUVd4f/YK+8QvnvDdLtwoa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nogoDOgd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbE5Z013012
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fXtpTkNa9ixIqMihCOW6HnG0
	oh1UILRjnqAgqagtS2E=; b=nogoDOgd8yykYGOh+cM0k7HaETFlhODxZGksPPgE
	5DQDp8LJJKMOBbouCRwZixr6XWytKlHOB2jKosoAAd7Mz7eVHTgZQCX7BPhTpZ5g
	3KBKy/I6QhXTrvpiaQFQd35TiRXnjJMaaEGao9KSqk45/GaPj4MBOzH+nRf0UV6C
	xpvV1GYYKkY1dch2GMA53I7jB3gz99irod6ycw3duu8nC6BkJUlZO7O4SAjTC2vP
	xhwm6+eLeP+QGBAVDq3Uw2OMNYoycy6Z2GmWXI5qEE3xSCsC0cCExJ4OF4Sl4sJF
	4yCAv+unYOZCLLHMMXXUILbJfssbx1ePQrVlaML5IwvExw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2n89q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:13:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70743a15d33so4103556d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910021; x=1754514821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXtpTkNa9ixIqMihCOW6HnG0oh1UILRjnqAgqagtS2E=;
        b=rLPCRaygofaGVkBfEyx7/A8JunJNNh+gK0gby4Cvr2cTPpd2qrX2KSN7tWVJ1CwWl1
         8djPD0KwwfUHP3GqSJ6SW7iBPRYU7gfCW2I8HbOH98C4OmY6fhKEPMcoFvCBCJ6id7Mc
         Ap6gCFfYSC+zzAc4XpS90vCBTpr2FZ2WOlhToY5sDBZlV2QglRTZb6f/0yRoVRXpyy4M
         Wm4ehnsS9cHKIbnXDW2I2Mkj9h625a0yR8EubNAOy7qvzbiOvvSadU22qz4iRhgvCmxp
         d3zdO2WM6gN6o/xDjdTe0VnB643kHydzG/M0fV7kei9GlUI+sSva3yTTi9Dox+8TjkCp
         6PiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzpwFeRwJKNTfrkGyfo28eNlb/reEi6SbGYb0zfqxWFoLkQx/fdV7RTaHqmu+sy5s7UHpSNYqEnQnLJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGBRjbEAFma7NVPPmxBnSneST2FYQm2TFOI+i/Kpam+p07B0H
	mtE49UnFUj6aTvr3af/SODv5IdcHw4P3eThhd3TAdF0GbX5/nnrK9JnvDQGo3lUCcSVR7ae7Xb1
	/II8Eyk2hcZWxqPs/c2/h1RaFB8wiomGNL4h0cUANtiAsk+gJPM+9czqR4ZJgBnjIGN39k4ali+
	LAxQ==
X-Gm-Gg: ASbGncvUGMte6mfr5aOfO1bYKvkTOojpYJvt153mSLiskWVDngSdlrGTHCy9R+td5QH
	jmcVkurT9aggQnDcsF92wl2kuvg/I1omTVzBaTSWy0bhrLZQjrJx0Ii9JFX4w3ts7cwXA6o7XGP
	WrkKJ7w7KD1ftSe6nS6WvRZrVFAZN045Y7IZL9xSRdYGp3APMijD0VeRAL0NZC3v8TeoByuq6fE
	qpcl48DaAsHHJGnBdHauAm/J90ht7AdA5U0ioEE4fmRM2/8kXFDJ1GMBjCDmL2JmGKeMiNgZqk3
	TOjx4NZt/7MffZeDtLZ3L/xlCGSh0QPgTD1O5GZhIzfz7Hg96yxQXoq9yY8dJTtysecVfe/iOwn
	E5mH8/oLcl4749p1SzB1VybIe4/pevBUnK9z06wdSS++5T+FcK0MO
X-Received: by 2002:a05:6214:234e:b0:707:1b24:f305 with SMTP id 6a1803df08f44-70766de7f4cmr84934296d6.18.1753910020784;
        Wed, 30 Jul 2025 14:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWB8L182re/bULdoRULiJTw6vJ/ov9hLNcga+nSA0chZ9lErd2CZL8T8na4vtzKQPA8PNdHw==
X-Received: by 2002:a05:6214:234e:b0:707:1b24:f305 with SMTP id 6a1803df08f44-70766de7f4cmr84933856d6.18.1753910020278;
        Wed, 30 Jul 2025 14:13:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332383c7ec5sm60931fa.35.2025.07.30.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 14:13:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 00:13:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] soc: qcom: mdt_loader: Deal with zero e_shentsize
Message-ID: <if2ttmi4v7erdlqihsjk73vmzfurkadk7jb7fg5x3zjvns4tpw@ghoglmrjl2vw>
References: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
X-Proofpoint-GUID: EKU9RIuKaN27g6Gaj-fjQhHIKa6NZ0HH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NCBTYWx0ZWRfX2yEz+1RqFyPG
 +c6y/DlM0FNTTsSwKBrqGda3jkeoZXyh6EghZJEEx08rN85M2Eav20kpH+hEuRbB36sEpaIsL7p
 eMj8p4vdWQR8vYbn22hpTsy5R2J2JCSRLxSRv4WVcGN5fHgfDHHY8TVF8OZKtQCq0lgXWLASWgf
 2wcRE6q1cY5Mgc1wA820At1DDPQPAwV2Sa1cz1GdLrmH5YH1egmf34uJ9OqZUXTLrkUy3qOd+Ik
 kKHOHhcS7sgPeoUhHSC/dEB26Mhlf/MyQUXFewgUmxhhoOdP7SezrfWK+nIDWIdJS6lDuXb6wYx
 WjLWDypBbHwC47hNJF+6VsiH47KjaIKnDfKN4gjAasbDPgBs1k1p/VeYvNm2VFNHh8+N3MH/Kag
 qEd+PqO1FhmVOyN/5IwkBuF2My//uX74UqUI5ZAqZtuNsR9X6oMg/TbdyW+8s6v7gNuHf/74
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688a8b06 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=2EBCKPX80TafROE6MdgA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EKU9RIuKaN27g6Gaj-fjQhHIKa6NZ0HH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=757 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300154

On Wed, Jul 30, 2025 at 03:51:51PM -0500, Bjorn Andersson wrote:
> Firmware that doesn't provide section headers leave both e_shentsize and
> e_shnum 0, which obvious isn't compatible with the newly introduced
> stricter checks.
> 
> Make the section-related checks conditional on either of these values
> being non-zero.
> 
> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://lore.kernel.org/all/ece307c3-7d65-440f-babd-88cf9705b908@packett.cool/
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Closes: https://lore.kernel.org/all/aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


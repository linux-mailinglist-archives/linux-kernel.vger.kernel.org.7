Return-Path: <linux-kernel+bounces-839760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C2BB257A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED5417788D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59917126F0A;
	Thu,  2 Oct 2025 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayRPN5oL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511E8634F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370803; cv=none; b=jte87PLz3MbNvX8VVtg9Ev74Bb1PavZU5VeLp/kaL0PbBCbh1Srp+paB2jnUWreikstYo7kQRieVLhMYF+Bazihz0U1oMEJDDoHF3UxJAIXUFKmhluXIXeQWTv5pWagRfzNkDtXfmnLWGrLCbunBTTda+VYm4lfF9gRfgaHw7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370803; c=relaxed/simple;
	bh=kV6O/7xr+ozWsJJbk2YUXyEa+iKmtdPky6IvJGU1gXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flKOsZigvTeGzRWGyMi6YI4uxMSF/rbkT7ZHOb0/KNMQ/Z33/onqhMVdpi7lC+wYIidMQQVXq0KC9QGBuAlOtQZIjmUuiEWBerJxVdBM+jgmC+FhIq8jfmZso7OuX3VCe7qqFqxBg8Cktfk/h1rEp1A/6nr8ck1lsxp0LAL5zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayRPN5oL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcYWS024866
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 02:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Es0e9pv5niRRIId7gi4sYI/e
	tClgkXkV5fl6Ta1xdZw=; b=ayRPN5oLVePtSw7ld1xYRluIOFQLJk5WFV7us4Pw
	56WBYICkCiR+KarEqSVJg2SeC1aaCGbfAhJIZhfljSotVzGBylrvyf5T9pvBp+1K
	iaSjmO0EKC+0qXaCmIwN9bHOKHSIEFAb5x65o0Dhe2XguIgkSXAKk+14LZgEo0xG
	sTyYc4T1eqKxQlM+BW5hanIY5vkAvdmjOt34wqmnNvSDW0Um4iyHpmUIJAwlxiu+
	eXsHIVAesy7SAeWnvkgkSwcDw7TAsa3cvZ0D2qUYPuy1Xzfe+4xbCGHi79WTJwE4
	xxyKdcNV0E8O7djFg1GCkMFchAK2E6M+lSMRtB1148QSfA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977x8dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:06:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d6fc3d74a2so16015311cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370800; x=1759975600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es0e9pv5niRRIId7gi4sYI/etClgkXkV5fl6Ta1xdZw=;
        b=DUjunVyKvADcKpYh72dTvLIWtUdUcA/u1V9MCKZSSPSh8JJxG1R65innFpfJ0mKsc3
         h8udV9u06Zsi+OPkS2wU1tHzf/PrB7jRTvThex13XV7ixx6bOL5+kKrYNEE+u6nBJRbM
         W+zaJ0AwSouf0dFSANHIyJn1nLLj66uAwafXC4X5bSnIoAL82B++DE4x2wmbJT1SYDKO
         qKsOayc95pr8fZzhhqPGMNb4KTQSbKgFxIrks2JRUTVZpCh6wOYd+x933uEc7U24VFQ7
         GWYgE+B01wnYpEHbMKPhO2fgdFByR3vPYok0H0DsKB34m6mWKuPh4aU73qzsnBp/xHNC
         MsHg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKEiT6TegrLPnIyP4bg6751VaeZ1MxuWsVDrfnNBLk5JeGZyTJ+6roPghgJcPp1ApSdIGCm+Mn50Fv/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWYhaNSnY/3Y9R5dxob1AV51JzL2OBGRDoCj5wPRxR6OW7nMI
	8jJAhk/3Gdv36tYm17QhbqdfHt7YIET3d2y+zEFR618lxeTwrErr+kFJwLLyeii0KOjxB/TyKI1
	lum7OOTgl+dzYQhCKdHxp89vY/9QaN+x5B24dLUZx2n6jaPk0QI7VLYwny0pi7zGzJO4=
X-Gm-Gg: ASbGncsevOwdaCSo80Fp2w6BZIUd64ugytSnrE51ExEhYDcYCDzDG/zSYq5FtaTDAMD
	IwRwmJBoes8wqINYhIknx3Lz95kjR4RbqzkEXNtA+0lrbNqLNlPu1PabXSNecRFMxAvRD+bVcuE
	A0QD3TFNDIuQS0l6GdojtpCD13l7F5PNBE2lxujAN6yG/SaGEd0+jDVc0hhgLXP0LgD5XVlMjPR
	YyEfdbhyf4MtVnD1rB0+gT20HR8TQQWtxw0WRKBlg+9l96IIMs2JlnooKgnxTFM06LcfN3Qqked
	Ie33sCeJ3aaqYagduoLnrIy651AJax78cwPUVLjm9AjD/ppnL8MET+2YMqnGXkLX8EKEgyTqWOo
	wR94fCJsDKb1z5Qydvqk01z60Qw5OA5Y3O2ED+xBInCwxdk5nlrrJh/UfiA==
X-Received: by 2002:a05:622a:514a:b0:4d8:2245:e247 with SMTP id d75a77b69052e-4e41d8a3201mr84427431cf.54.1759370800163;
        Wed, 01 Oct 2025 19:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvECAJBZExthaTuqlaw1tux8fLUgY4bEAQ97CI/RX30reaxMonreDyaN02w4PUzNOLGdujtA==
X-Received: by 2002:a05:622a:514a:b0:4d8:2245:e247 with SMTP id d75a77b69052e-4e41d8a3201mr84427151cf.54.1759370799692;
        Wed, 01 Oct 2025 19:06:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d33fsm374381e87.91.2025.10.01.19.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:06:35 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:06:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 8/9] arm64: dts: qcom: ipq5332: add pwm node
Message-ID: <fbkpfbgkn6ycwfdmgqy3hzqu2lg2tin5gsw5k7ezn6o5fqfa54@hv5ge3qzojcl>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-8-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-8-300f237e0e68@outlook.com>
X-Proofpoint-GUID: p_AOOPdSLH3Fu31dYUeGom8KgIUv8Xpu
X-Proofpoint-ORIG-GUID: p_AOOPdSLH3Fu31dYUeGom8KgIUv8Xpu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX99fWNBuOZlsO
 CrZv+AK34gNX1Fy+abgxCWrb0gIP5sbuzC75nGy80sicMTgccd0634Gk53mhH0PWbT1gIo09w0v
 hj8yFi9I+PGOsl5E4mEtArN0WwrB0YrX1L+DTrn1p065SJHlymCQjkbyK+cBgw/Xftus2HgZldw
 IAuELcFZHNgnrL9mJc0O1TkfPioe+ooPg7ff/iSd0zrYe+wSQk9d+9SV1k19oHZ3xLQk0HV5rBP
 tXFxZBdZE6SMk3xhGn24KwQRvtlf3OLtpipWGoXT/NlA9G684+33FdASK/cTRPkO7YwQyTeLtnC
 fz91GlB0Yg67R57N1NPa2be7vyovl7waGdyB0L1QyAX0e766QpESH0/xKKpPR76o/b6Nu2UJrCi
 8T0xSYXmljEmDZ9UvunLMKnO3QHRKQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68ddde31 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=W8KEJANZPcvdmftmyl0A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Wed, Oct 01, 2025 at 06:04:24PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5332.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


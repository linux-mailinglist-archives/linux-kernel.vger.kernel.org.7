Return-Path: <linux-kernel+bounces-891650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B616CC43289
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC82F3AEF40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24426E16A;
	Sat,  8 Nov 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehE8VltP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXpMLMFt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD195FE8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624063; cv=none; b=b1yTrkVYHz5CC+12xhM+RsN+rF3G9xSbCOExy3pMvKkjWIqESgoUtYhhvNNLbu6K+Y6wYU0+nysCmjXaKHhQHaYlTPfeQThROSga1cxsqY9aGU9m983f3XGvpNM1pQxA6jENq1yxzu3fe9OtwdqV3btmssAW+U6PuZ4g9YjsYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624063; c=relaxed/simple;
	bh=HvpMmGW03dxYZC0YZr1+D/jVHMgv5z2Ip3dLnOgqI58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLh01afQ+qeBfHbCNixNl8tvYvYOs2cOS4fp4PKpJcyD3tf7wPqozcoaxjnrwQJTCOpIYBmx/1NaUlfQo6R008ZQuWGCUfZs1tiHFxrCTJp11Es/3yl1a5Kdl7XSvHhpCcNEtxo6pif1EzG7w5B468hYbtVc4QO1w41BPp9vU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ehE8VltP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXpMLMFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88P6w91189389
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 17:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ap8lj9Sm9uVSu2cLhXJsylRK
	Em7Ck7Un0+RpreSBVWk=; b=ehE8VltPXhudhLonqwFbDy4yuE1PuVRx0IRFivnl
	E5RNygneHI2ThVrziuVdwuP1y6tLymkZfRB67749jZitmFn1Y0VaSYDpkljAiaHs
	Xz/QG8Bl1i7hdhGLJjjd1A15n365VduJmNzIrYa/N8oPGPwiJa8/++2ctl2BCPuZ
	lKUVoc4el2dbrpARRftAyht74KvnHQ1Y/ziXwsIntQTwvINJhU3SyDfblnsx6Jyb
	ZRdHG3E54HyqTXBMBImBEIFo70N6HS0e1teXUmgnGmEdpd4W9hisrDOShIUf5oat
	PT0nG1IJSV05NdWZwj16BM+WIQ3gXUSGry55BpyKyZ6WNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs78yat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:47:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882376d91beso30883276d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762624061; x=1763228861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ap8lj9Sm9uVSu2cLhXJsylRKEm7Ck7Un0+RpreSBVWk=;
        b=WXpMLMFtgS1bn9grrnmsr4YxEHL7sNGIowbwZe/HlQNzg+H5Wpc8f8dbdar1vme+xS
         pa6tO8wb1josEo/mLVwUZ2YpN6226qDDUooBake3m8F7yvw0rbkLFM2i14SQsZP9BSOZ
         d3bmYRdIStnPf0L4cd5xel3MdomoKLDgWNKiexc/fjlYAFCcp27RDC12bTcKyyWosgDo
         BYkjqmV5AFHWV7JINJ1DSFK7tVDZ830ySraRaEAyOmrvi9OXEqP6HjvEED3WJeGILvA6
         llW+wf00QviwfO6f9KvLMMOoem/D2UlNztf8vz2qEpbxEJHMm1C1aGOWLsV1kgXM0jC/
         U4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624061; x=1763228861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap8lj9Sm9uVSu2cLhXJsylRKEm7Ck7Un0+RpreSBVWk=;
        b=JJjVBxaASMFyAGt9sbD+ScL8jLGxShfnr7MUYWff9mrgpM7h374BSH21BBBM86bdxE
         ECJifqlR4b/uIKD9/hrSiHMlph68VGp8Bpz3Q4tZSSGsB9RxlpLdH5A6luXM12yi6t3G
         okIuINMY8n+1/cn0n7gw1/SIo0jt2RvfrKMPfYSWFXogbUrrcjt1PBlsVvFYOmBMsIuQ
         m3c2VFwKKPkxYvrXjjWLpa+GVPK8uF/NsrcZ/NWUQWcCpuMhzRhlJI+Im8ndOlY/Gbds
         y/H+VceAY9C0taQ/w/U0DhWtjbvrQpdNQiIcV6gjSVHMaB/ScC9OUOr2ENqRS9MnM555
         lsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlP8JXykmGunfKeNy5OrFK+Pg9jBU0K4eCffEn+U5puqcnfsFCFrQVjfX15XvAc8B0L+ogx47rYsWckRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmYr65uADEi0e9WbQ5l2tR0Ha7450UJ7oFqlZN8S3OSSr1Y8U
	bqZcT/GYpQyheLP0VabNvT1Cr4e1e4xcLUqm0+N2RXMRiQ3StaJHxNSIg9RopSqj+dqHZrZBlhZ
	4l6cf2Fffu0qoC2dW+8dkldAGGa5O8AcEM4rWTmMweH2olRv/eCMd3V+s/DZ6e32vlFk=
X-Gm-Gg: ASbGncvKlYm1Mb4MxEyU/LMtgK9YpRafoGMV6X1OO/8SY3UGbCph+vKEkyBxF3vn0HY
	+iLxq3oW7n2QQxXjhe/Tb3v0qZAhhu+VFLVBVGLR8RSb7wsmNIGJUJQCL5Ngm0/KloTZZ1tdG4U
	uVhHvhB7wbTqV82nNLOD8M6SBY6UqgYKaM2D0yQwiIDu/4vmnuive68kYv2HlZEWsJBv9ZfXWLJ
	ZAHpBMKoNaqKtKh14/TecbJMW7/r4SupYLtGwGCq4dw4tzhrfG1sHUin/CS4pGuP6mUbHfooanB
	lzKBUv5XwdigQhcMYTEk32IKNNBE232WLzS0aOZefpEw/KhExyS2ZjtHxjfrV5ElcL7VkPoKX2r
	4yafMdRURMgs6uR9XiUoNzO3Q3vZwFYqFrKRtfNWFgA9+QyI00DmvIdtVWRrRa6Kb3s6R+JMvNq
	DKtQX4Lsq2Oqt+
X-Received: by 2002:a05:6214:f2a:b0:880:4f97:d17b with SMTP id 6a1803df08f44-882385c4948mr35733406d6.19.1762624060724;
        Sat, 08 Nov 2025 09:47:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9L3CuPYnBcr11YnGCLvWOHvYxkY0YKpO25F22jI6Vbwp5Lf3pvefb6cGn9JxaUMlq18tqcQ==
X-Received: by 2002:a05:6214:f2a:b0:880:4f97:d17b with SMTP id 6a1803df08f44-882385c4948mr35733216d6.19.1762624060312;
        Sat, 08 Nov 2025 09:47:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd168sm19909131fa.33.2025.11.08.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:47:38 -0800 (PST)
Date: Sat, 8 Nov 2025 19:47:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] interconnect: qcom: sm6350: Remove empty BCM arrays
Message-ID: <h6zyw66l75p5zvaztc3piimbu3iiusvjjxmee3yrlxh5xtievu@lme6idh7ja4q>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-3-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-3-8275e5fc3f61@fairphone.com>
X-Proofpoint-GUID: mA3aZJXh7qIHuflooFTiECJnU8fHbBwP
X-Proofpoint-ORIG-GUID: mA3aZJXh7qIHuflooFTiECJnU8fHbBwP
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=690f823d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=AgmifABs4vawdm9268kA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NCBTYWx0ZWRfX14y+UMBh4p8U
 nvtC7vEMKmYz9nyGmpQM0vwNes2q/41uKQTqJDymGx9eriGbkAIYBAVsKjm9kX3tfeR0coJks1Y
 +yX0kHXcRHE2fJTIiXFFxBGLbJ0gveNa9DtXPzBv4XB0+I7qIFc5eAqsKRo96GURzi6sTJGwkTK
 TGLJ1LZYCf5FxQyFKK2Uwwx7K97ssVQb4Xg8IEkEW5FfxIdLXQhUtqPKbu8GM1RbEUaqoJuLBNZ
 GXmVTXzZEBkEJtw4ebjEIg+4sJGnBjxPzr0O6Y3+vH2a5Rp/yC4u6i6SMYZn3MZnmIbtRx523zc
 leGgxM5Ni2pm4wy3qXOJxfetPkBHe8pNj2ntyYr8Dqy9pMriOZsxpYeyKK0ofmIwAkxqXO4dfIv
 esJifpm/Cg2wpJRQeoUCMbU+x7u85A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080144

On Fri, Nov 07, 2025 at 05:08:49PM +0100, Luca Weiss wrote:
> Clean up the code by removing empty BCM arrays to save some lines.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/qcom/sm6350.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


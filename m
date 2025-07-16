Return-Path: <linux-kernel+bounces-733781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E7B078FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D17B4960
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D504262FC5;
	Wed, 16 Jul 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENtc1zwP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95931264615
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677994; cv=none; b=H5gLLV95hhGrRsvWZ+dH4NGtjcYjeJYyLM4BJgYj3RScLgyQixaHg0bzpHkMrC8vu2ByZk0vVWeVl/qeT4RrVdGp+U7usLG49Owf2SlbkgMT4FWx9308xRjVo9QSWd7I958cdehH18eWprYAQkWR1zaEZajD7FLT1/4h/6pFDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677994; c=relaxed/simple;
	bh=z1xOyLsQ2NEWMuv9agDhfAfh5K0V7Ewcvyd/GS0+6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ2v/dklORgMO7I1wgmS9xmTXHossReRWoDWlm+5ioK6oQLiUHpuEpKghQTAqPuUKPmo+shtRnA3KwxD2/OIuSjSxVy2K+d75EzLZhuGPp1xlRQEszIx+zOx/TIQ0xGgPgflN6qPARzVbcTXfgSDN81U1z7tlQkaa7KMnC8i5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENtc1zwP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD83KE024478
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WuGVsQmvruWGoUm+mN8dqEDE
	dXmWp9FBOHdzNsiopKc=; b=ENtc1zwP2CYrmFozXCdyLayBkERMsj2s/7G34aSN
	HyX4xgXLwHznVkN7gctFe2V1lOe199NQDClChQkb+lEj3ikyGQK2X82bWSx7jCdR
	1+qhvcZm4+lARKCBxmWYz/nuXwR44w5Vn50d6ToX8klOxuRp4M3KJOeo70GE6r1S
	1SRvikl6XdloQH/hP1jsavqiitAvMV0HAg3ebf8NI0XlqTwKW5BMPVZhNmIv0h8v
	/0XsIq6ZDhHxM6seeeZa4grmfKsEmL4FK+AsOo4inG6DNLU5DU4CQdDin2hb0uVJ
	VbMv7ZKhpx2q5agYS5IWmwuEjgA8UUHBsvMEg16yaKHYQA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpfb8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:59:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33af599bcso317496485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677990; x=1753282790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuGVsQmvruWGoUm+mN8dqEDEdXmWp9FBOHdzNsiopKc=;
        b=GcM5k5X8cDRZfJOPlIw61jHR7/CL5nBbgAVfZTcytfAE0satUthDgTETRmbKhaTLjq
         3rBODNQe1CmsMDvA5124RSil8VieXwHssR/qMXnPdMSuGzp1Hc5/Mhh/WF7o4zqmq+0B
         UJND9BPG+8h1mRXPPSzyGxkgdQ5TWd0xXzCsWFFZJzMeM5pR8t02vOto8b5FzQgpqI9W
         Hs6btwwe3rWxpkHxxA2xUo6Nq2YKj4QNQuuLgiS2vEBR1Uxhv7uB32Ik93rBKeQGaZKU
         WZl6T9H9v4wcR1q8kLxJ5teE7DaYqq9TyYGT1HBaZ9gxkPb3p7ufA+bqlnQFAZz9SG0+
         LJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUuCo/jcUl9HwN3h0pLBIa1299h/8LtlyFfJLVltI3UtOaji9JnJQXQasmgfdjpG/pkPzt9qo2ArSTWmtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SEO4jV1AYZCpRvr5bVa/5fwRG8NKbOvJ2hdQ045oTzY3eSBz
	U+DvPqvlOEoEzZIsoopeWyyUv30uZTtTFmh/lKYbYHbz5HgYED2wkEjaphpdGP9DtjgoRdP+LE7
	9Udy03roTrbLRRAnwk0W7pYmw/tlTFAgm+t0FFurRYs2yst9ijs2YUDtg3PyrZR9OKvg=
X-Gm-Gg: ASbGncv28s/pmQKcuxR2eOVgy3Nf3n0K0AeP1TWJfdNFUnCIfqt5HaC94DgIozjAQ8k
	p3qsxM4LtX96mZSFC2/SiB/iZcTHlGS4R2zBmJmj1w4lSM//Zx6kUPsgBLq1YZ2Pv9fFZS2gIUg
	PF8/VluURE6zOoapnTtU2C+ZfU4ZEjx87sE2yoEVEuSRSDLYjjwN/czHM/tJnQ4fUWsAtJLFaer
	TDpptSqTVpSesWfK8IS/wVMjTXLDk3SUgb34nhRrc48+9qMXqKDtmHBGMi/ZgnkqexHqj0dlPu8
	gP7o4hdz4H2PIQ/raZ5zbAqMDnFNn2EZsRoYh+m1qFBshXC5/tecbZWTZA/D6j9QFIQBcm42hJy
	xtmrRqoIXJagbi8s5u40hsJg5KiyTdP6oYV97XfUb6XDSr6N1KG4f
X-Received: by 2002:a05:620a:6501:b0:7e2:814c:1128 with SMTP id af79cd13be357-7e342aaaa08mr434964885a.18.1752677989740;
        Wed, 16 Jul 2025 07:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrHmKHxpa624AnnTtpLvo+zOY8qqGnIXbP2uifVTrJp40Mq8mYDsdHQz7DZhfYPOjT98n0og==
X-Received: by 2002:a05:620a:6501:b0:7e2:814c:1128 with SMTP id af79cd13be357-7e342aaaa08mr434958885a.18.1752677989068;
        Wed, 16 Jul 2025 07:59:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b635ecsm2658518e87.166.2025.07.16.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:59:48 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:59:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8250-xiaomi-pipa: Drop unused
 bq27z561
Message-ID: <c6od65q2e6bnz6jxq65ox7burhjavjmooe3vq6nhhfq3ikglz7@4ufcxbjhp23o>
References: <20250716141041.24507-1-me@adomerle.pw>
 <20250716141041.24507-2-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716141041.24507-2-me@adomerle.pw>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfX9g7kGqAw+NO0
 4aFw1Io/3isAoVxKZ31Wh4a2PSeOpxPKHTgpLhjq5bnFYV6nSqSjH8LWponFazyjagDNKkOffhi
 26UGp5Mf6kk6+Ff6U1YOLGEuxpET8E3Kd3mLYLMLlwYaBtADT5LdpDwWYhRpYE9NrKYyEha5VbV
 3N7kidg0SPS181ZEmixjx5rZCUKdwtK1PKgLi4483c5Hjl6N0ZsfwD73cdhHXgkyAnSgvvk685E
 UtJujdrEoG1hACVdE9xJunUKIRRYlUUnXVqxQckeHFvnMXIpeeZ2fzZqOZVJUmThMGZTlO3qgdH
 cYVgXz0UaPWMpKLpK2JkSzVJ9TawK9n4kQ2CCSS6lKot37yU0EhB1U50wV1ToWJ8t4fqqBlbtvP
 VxRewznb5mbbkGAq/Az3LQops+0dihVVfyVzS5/ikGC/sDdhxQDYN3TKy5yRIBdPdQCZNpp2
X-Proofpoint-GUID: y1Aaqo6rLGjJ3Vh3fv2tKAm_h8VgEArH
X-Proofpoint-ORIG-GUID: y1Aaqo6rLGjJ3Vh3fv2tKAm_h8VgEArH
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877be67 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=9pW74NbYAAAA:8 a=EUspDBNiAAAA:8
 a=N_Z-4l7e5lD0AiT6xuMA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=67o8LzlnqLyy2xoPAWJp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=875 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160135

On Wed, Jul 16, 2025 at 06:10:40PM +0400, Arseniy Velikanov wrote:
> It looks like the fuel gauge is not connected to the battery,
> it reports nonsense info. Downstream kernel uses pmic fg.

If you have to repost the patches for any reason, please sched more
light on the 'nosense' you are observing.

> 
> Reviewed-by: Luka Panio <lukapanio@gmail.com>
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  .../boot/dts/qcom/sm8250-xiaomi-pipa.dts      | 22 -------------------
>  1 file changed, 22 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


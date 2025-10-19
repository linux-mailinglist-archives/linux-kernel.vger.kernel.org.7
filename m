Return-Path: <linux-kernel+bounces-859777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6ABEE8C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB391898775
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BA2EBB8B;
	Sun, 19 Oct 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcntXBQu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467ED22D9E9
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760888232; cv=none; b=dT2OVsudCsK4Ig04oHug72Mk0AUSG/B1S3cwUIhc3ewjYShiQhA9WMCxNKg5KKV7MEx9BC8tmr1OGwERIUHcYBKFE+EmD3bT4MVDpBMd0Jz+Am1Oh+uGvtAo/p1c8F2sv1Pgzvh+TbAwsIgn8CtOqAWHDjDvDcrwXTeVOsN3+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760888232; c=relaxed/simple;
	bh=hEg0Yf5DlxazGnnjSpW/iDt6B0Pv1nMwGAFG4Zj4n4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9FIK317ayiHLLxZrFOQ8HfqhuQOrFHdkfigFu73d9+8r8OyJgZC8dePfiN7MEqxeAogzxt7bJMVrV8t1+bIDp1xcbnfiY44H8YPCNkEDaS3DyWSOnR1/1xtkEOeFNZhDlP8NX3EEu8WqOJpwvdt6afXVmNQFw/sL5z48vKkE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcntXBQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JEiFYO022270
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RL1Dojucgmcs5IbhdQTmfeBq
	uHEdKHvcZ4h5XAH9v8U=; b=JcntXBQuK98J117bXuEzc0MMlkGUc+okL818sRX+
	vh4EwV6K30es2tqhm1w7GEpBxPstcAfnqsfZ40cPCHTYrCWpzLPWs/Kc8VgZtmpr
	ovt6s9UslnAxBUsLkU5iLs+DEfVKZTOS+z6htFrbIyO7JHuN6/k91BI7uhFV/T+r
	FfRRljLwdsLn/q5ik8O6rOLDJ5ToDX7MGpQtmQaB69FsvRE1mYaR/5XAiYald9Kz
	QlonOnuJShCQGHcmOnWW5Q+4BqSygTrKL2pW1y10Pmh3pFTWY07utaG6wSVPzWSA
	YwuljvRJ8kc66/HXcrDMvmpH0MwiAf+xGuYg8Qgv3mbawg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7tncf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:37:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e5b6f1296so108214486d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760888228; x=1761493028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL1Dojucgmcs5IbhdQTmfeBquHEdKHvcZ4h5XAH9v8U=;
        b=nm4DzbflDhiCyIAdHGJCYaq18w2kXrsG7i56wx0qvdFzhP0ybz2g3Frd1HnYd7lNm1
         oomnvCnA3m9wd3QFAEPfMOpmWtlrqBe0W/XZqDs71/idbun9kh03iwbnyOu37zYDqAp+
         c2xC4UOBieuQ96LEu3k9bjLmzM/gvoWFyHKbw6G8J4J4UXdrj7OfWtf6c8/uTgJymsOx
         WTU7C8ei1CCEXKnUHQqWvf7U3D5mn9S7wCc7iJjlZimHlMkdW5AA1ordZ0ZrXTX7BV+x
         IAHCqgykyqpqRm0HFu8+612wNqLlLBc1URljLUZPx0oP9PsaTuwQyQO6lK234Bg59KAE
         G+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFM1tWJy2x1Ed/qMkoq3huuAAFzV9pePR3C71bYsW92QEumEcD2RniVezAnOUmJZqBQ9LnP2RdYThJGSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDfooDDPZm4du/9nOIyo6ar1e2Wd1vXWtGcKhi9quyjvWToT7
	ETmlk58hrnQzmsKL5LgzX2o25qw1/IUsyG2AQH6uwrQlOAi3AokIg8LgLNVPymQSMwlBsJ4bsuA
	gtcJvp5doDaSlYKJ3WGskgqecBOd1aIa8u23/F0CNktOmagsa/OydX6cTQIdPbj4SOiw=
X-Gm-Gg: ASbGncuYgMU4xV/wWslJhy1Aah3mLaee32BkYPbmpyyjk11Dqil9gxBJ26rYVbQg6o2
	j+xGeVZ8kI49wjuLvIcyu+/aKSu2kMmrwHzoQGRKZzwU3nj6j2ssNu9prg9SiU13mm6E05w0+N3
	ELn9xcQHg9/K1Z3Vw4T8mvGFeATwtMJDVQ4cqbkV7prZzg1No+zzoAIZN02OUuonuAAnrjurgRO
	3r0PgFefeFNFGunA1qcJZvFY6Yd0kyeKF9B/FVvtTbGkJLMclEtRVW7x5sXJVfyGUssg5kBe2Lg
	0OCgcPyVOer1t8pIBdEKPS3LhOa1p2GyZXI8gqynzyCL084GHJQMwpLwNwHbxr0sEj5ch7BmXGJ
	s5I2umZIpxeDJEsVguZ1OrXFoEGfp3ap7TVCUXh0VTiS0l5DBbZR/DHWpu6pP42CGXJwWo9KLKq
	d30tz1n9uBxX0=
X-Received: by 2002:a05:622a:1351:b0:4cf:a3fa:47a0 with SMTP id d75a77b69052e-4e89d263e40mr127009041cf.15.1760888228262;
        Sun, 19 Oct 2025 08:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSXAeyNtiUxZMmTENJ6PxpIf0/vFPNuiwpyiUppu7120CbuRClJJ/SHmE9tFl+nmG6N6HwKA==
X-Received: by 2002:a05:622a:1351:b0:4cf:a3fa:47a0 with SMTP id d75a77b69052e-4e89d263e40mr127008631cf.15.1760888227802;
        Sun, 19 Oct 2025 08:37:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deea8765sm1671336e87.7.2025.10.19.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:37:07 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:37:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
Subject: Re: [PATCH v2 3/3] remoteproc: qcom: pas: Add support for SDM660 CDSP
Message-ID: <sasjgm6pua77syu5qjbr5zxl37jorvhs4dx75lbiqlisr5aq4h@zjxu4k2wcfye>
References: <20251019-qcom-sdm660-cdsp-v2-0-0d3bcb468de0@mainlining.org>
 <20251019-qcom-sdm660-cdsp-v2-3-0d3bcb468de0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019-qcom-sdm660-cdsp-v2-3-0d3bcb468de0@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXw50FeTEjvxaD
 m+vBG7YCx10Yr1nx4Zq4GU8D7Q8wVYQubLGfM7oFTkVPfLJqru6Kr7eLXpzOgY/wSiZ7dzCnG3a
 b0cHoj6fjb5j83TR8LX5GKMV/j31Q9pDeFemL3vC4P9XiQWB6qnU2k0T4wEqzgRGA2x200lmgEe
 TIAAHVHQBYQqRWHN5p8mALmrlrlAAK1/s3DhJjfjJuD7OL9SNhyjpOMpeDYH77JE8yPkDR7eSm7
 w5fhWxq+APFl4bwPl70yNYlZQCO7N9SguOb64S1uf0s2qlqJcOBFXxC8Wc8Mu0NmXkJQHHDx3x8
 Cz9wghzG4D5mU/uviB8EVLG6IfzrwnGjnwfAWPmHdfJ7Xq8mb2O3CS+zUz5ejr1YTAKx1B87z9K
 QITyCO2BZl0B0jA0bHbKKnjQAV3bAQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f505a5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=X1EvOAfQj5F5E2kYnQAA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: FjQW5jES6fA63cN9566IZT6hUVIzKrzj
X-Proofpoint-ORIG-GUID: FjQW5jES6fA63cN9566IZT6hUVIzKrzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On Sun, Oct 19, 2025 at 05:20:21PM +0300, Nickolay Goppen wrote:
> Compute DSP in SDM660 is compatible with generic cdsp_resource_init
> descriptor.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # ifc6560

Please send DT patches too.

-- 
With best wishes
Dmitry


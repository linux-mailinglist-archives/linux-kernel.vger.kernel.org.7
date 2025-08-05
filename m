Return-Path: <linux-kernel+bounces-755933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1DFB1AD91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A233AFCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE161DDC3F;
	Tue,  5 Aug 2025 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6m1CGtr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685C1B960
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754371330; cv=none; b=VuTeVrnnJl9u5AWfAtK6MBfYGxg2sLgZ4CMpN67Ja6pPoHyDRkU5W4AQDG6rtDS974gHN4RmcbK6QclCBGlfu25GIx+4Xlfi1ixUIfNA2JEj3qB4S+e+m6m0EfM3rYmlSkW7vsxFVCpQopEImcMMDqthcOdIdkEm8cc/hnKvSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754371330; c=relaxed/simple;
	bh=n0hJY4w1kDyeyT48tVdbgBIl+jSvO4TXWsC4olFT8nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfQN3CE1p5Xv50xbqWvHJ0DbO5I59Qv9Chh3AhbpV+UI1zThsneUa2gZF9VvlEPprSSNWfrvY12Mo9O7qPIOzT3Klp/8HBh3BgIR5LtDGIA2lfVqtyDUVylGoC5pffkJ5zm9hZXvtBQ5O/ZBgJTm4hPYL0a+DEeP3ChgreuwfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6m1CGtr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574FTb9U019944
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 05:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U6r0duZ6z0j4LUAgrh0bZTc8
	SiFlhfG4hKd7EE2kjRo=; b=d6m1CGtrMlUPqNuTjx/N7iJyEjn9bdFB44lpZj/K
	0uMWGz8jyJ0HsVb5sWsQMtIpJN/COLnanaHgqOjjDyuekrAlFCqZu2qbeGVaMNeC
	m5hNiYN7eOi3CYLG74LnLURYqfLNEYw/vPJJ8AB1w97fdxzwQEsn9pTOhAnudcNK
	a2hI11jrp25AEzW78T6Z46w3HDLmAWyHsWYVkLxAq6SfzLKrXDDvIAp/zrpVgYDi
	PPqYuC0J9ALzDjg8wUrL6oad4ZVeRi9ByZlP1E+bUFenf+wziI0vSX2b1wxdbjfd
	WvG9rD9VjZuw5tbFLJYbtMWk4q+UPcJCzlRdxwwtovhwiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqq8x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:22:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af199d0facso61452961cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 22:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754371327; x=1754976127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6r0duZ6z0j4LUAgrh0bZTc8SiFlhfG4hKd7EE2kjRo=;
        b=obitJFinyO7ijjNFCv/MS7gU2Loe3kp3jmaU0cUcYrGk35f/4vo8KcQ0BMjoguTP32
         78gFMbUAvhfnnfjHq9SP5X3Gr6f2QfJEjw+H7t+EUBdN1NHuhs/GpMxpAbL15NrvT0Cg
         2wnOcMwNecmCEouX9Kx/Gp+m3fvSb/pyjUi9GFtbC5Bmwi+ZvS3V0s1gL2NRTgWpCB3A
         ZZBAczwZB82Tz/zDdnWUWMQ7E3eDPjSHr1ACA8kZWTB+dX1EHsZBfnDVs5c99xFh/jce
         hpu1Dv5cvs24iSp3brQ5OOcw2xUzUIsx+lgn7kL4GyoaPJUXIW7DKYoj3o8F0xDWk/N2
         Dt3A==
X-Forwarded-Encrypted: i=1; AJvYcCU7rW2/lj9g2YlF2HSAMFBcR12okLtJsfzN4uUgO+sziQRgKr+BlHp97mRoikzrCC+iaa2sV2OvwNGpKME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8KoiV9oeo0FwaNCFjwnpl3z83c2TF4uODSVKHpdSClAb/BZ+
	nrXf/YUkS3WMvlG2Em2Eg+oA00bS7A3tYDe+3H1DBotLc15kiUpRKME013goJKjav7E8Xc6Xsky
	pToFhGyIcjrcKXcazAwYCiwkeXkHCkviUZSDQKBUy/UywzUznBf/TJWM4hi+aSandvPc=
X-Gm-Gg: ASbGncuEYHzTLySyFd9zNIx6UMflrtBk2LR2QLAoHGQtvE1yQaU6qd4sX9DIAI/8uE3
	pPZrfGjSHjPZRvBVhiM0dTvuUAtmt7HnxVi17mRwA4UTpCvGdNfhEfOLHtQS6OH9xZY/QR9TlyB
	msIn1TFYa+leiCcHwDGLQmQM2pfzW0v0vRm6FetVHbXfwdrxoEXv4TCcAltgx8eadJ0xelzakuZ
	dD/oK4jHlHfXs2i4LrfM7NU4R2F7wD6e4fYVASl6Ecw7klxRSMMrSZCnC49drwiaYjJY/ax+ZOx
	aaVI9RjJHi/5Nw2wgHqCS1zoR+GVOluSU8ApiGnDCxUmemtaG55skU32y38fy0OCNhwydVmGMKi
	A80IC+0qAy25OwGCrDB+UVlXT8DJK7vxz0gBb+vitdPppK/VEzpzH
X-Received: by 2002:ac8:7d12:0:b0:4ae:cc49:e9ac with SMTP id d75a77b69052e-4b07fae5b1bmr39730341cf.29.1754371326743;
        Mon, 04 Aug 2025 22:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5FJGvEMEVRGjBRQoDRmCsXP+IaAhppJskHK2nnNuEQyHdtWleUEx2knWsRZd8WEk2HmV6YA==
X-Received: by 2002:ac8:7d12:0:b0:4ae:cc49:e9ac with SMTP id d75a77b69052e-4b07fae5b1bmr39730161cf.29.1754371326307;
        Mon, 04 Aug 2025 22:22:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac341sm1797075e87.60.2025.08.04.22.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:22:05 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:22:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
Message-ID: <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
X-Proofpoint-GUID: XP-I48L-TpQomsEw0y7D8zHAWUpfZYiZ
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=68919500 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TWSoFropmgQjW9t56BUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzNiBTYWx0ZWRfX3o55rGolJn6L
 anKmYDjNGUAFle1XBTFLo5B1cg1z+nfD+4gJgCa3EJ7/7VCHPvU3yl9bZ17pFWCSMl9oM5OO+8c
 hnWxZEp8XTJCDpU8cwGaElccMSsvUew8M6KQiTLkqLl0S2qi4AFEJbCPfy7feo+PhTB+Wv0ZIsf
 smdujH1QoepBZyLyV7hgmw1DFwcuksD7akW9/10bKUJdX6wbIFn4R08IXsYijK35FmxvozCOKrO
 2x8qoNh7FlI1LG8mupDKJJClbxi8t7XN1kUFeLgGkQ/nwfLToebNPUpgyYAQYQ3z5nfrlnu5J70
 NleP/mAk/TF485rSPjf/+r+KaICy3yFiWTV7VRtrW3DUhXiqacREANLHecYDmHn9i3Ad8JRewXX
 hPZ5drQuGPkOiWQ8AywDlQqPXvtX3Y57VuP+hCrIIVjF3l2yX2uEVYfx7sg5ohK6yFXrsqYv
X-Proofpoint-ORIG-GUID: XP-I48L-TpQomsEw0y7D8zHAWUpfZYiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=971 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050036

On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.

This has been working for other platforms (I see Milos, SAR2130P,
SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
seem to use non-shared ops). What's the difference? Should we switch all
platforms? Is it related to the hypervisor?

> The shared_floor_ops ensures that the new parent configuration is
> cached in the parked_cfg in the case where the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gcc-qcs615.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry


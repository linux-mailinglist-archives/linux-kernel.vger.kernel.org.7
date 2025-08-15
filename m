Return-Path: <linux-kernel+bounces-771500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59228B28804
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F74B5C71F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF625A633;
	Fri, 15 Aug 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSsfgeBq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EB24C68B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294770; cv=none; b=oEKVyT1D1LDW9qNE2K42Cjh2jRZj4i2bPqHGQtYycAKD/XrluSTUhtyRIsnjwaeESfgOls4hBfDA+wU9YjzkfOrDCrj+jUbVzq7I36IBt16LgjOittOUysImaJ5YNNpdKj3fVETk13b88uQrKuv6jL/r9ul5z9Q7sTvWMvhWddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294770; c=relaxed/simple;
	bh=gSjoCkpGQO2hO7lhbivtChUUCThBql0jPA14fGQjWzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMDfJu4F3Ei99dTRzmQ/i3hsWusxujLlGOtmgRl9jeUY6/7kYOxaDSkUgNYuEmx+/WX9AE4xx1xBsPfi5uSz7DtEl24VAaCJSEGel+sNnnhl9RdpF5CufskT9G3uaC4vfilZIzEnwbIqFR5eKtsE9MvLz+rpmrdScZxlCkhF0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSsfgeBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIpqU027226
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ucY422Zv59eyle/8tIZ1eTA
	qJLZoYCyEZljqLnbYhE=; b=dSsfgeBqib3EBhRt3kCVLvF94VAfd6AttarohzKV
	HK8kwYNAjZHr/WFdDzsar1Tra8fUJp0w2rMBGVvcRUmgogsDaB5wEQr+mIbRQ7z6
	S9cOhsQVStI4TFY4GypCDxtBkZgYitxH97DI1aWTrDyQSVDJlAR+Nw9dsw8fgmsP
	YuGo2q8QOqYUXygBX9lRKXhDXZ/m8y0KOl0mRsXYDQvutj3GFbjbWFzEFPcUQh/B
	rdxfmIqKm+hvuHK3/pCnnOCbuObrYg5c3zqiHmHN7C7c7RIyEfAXO2blQhJvqw+X
	oFatoJMO6mdwjqq5M2NJvcznsaabWhEzZLAOh/dSflNtNw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9t4gjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:52:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f57f950so49108766d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294767; x=1755899567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ucY422Zv59eyle/8tIZ1eTAqJLZoYCyEZljqLnbYhE=;
        b=dXWqAB+cQd76Q7Vtwm+oKyTmB+/sXsnBwJKtG57cDlNlWW8i1vrv9NqS6R9TRUIN1c
         A04sGGBdyUYjKcQuOkZu0lrLMS9SpRWpgGyszDGErzX9rGbh0brI6zEN88nSpln5rqwK
         KddFt86ThJGlW01sMkev2yXC/UnuZ3mGXz5xtHH9Bu5c7QM+Xt0ycOHwa5gMlnqgAQgp
         +xyUh+CEyZsBUBkaRVqIzZeabKSiMHG+FDdJd0CmgtCU4yHSCUjfKUlLCmC8fQsoh5GV
         +7U4L7Or8oxEvUQZ7AIqzYONKOSf4GrUl9xS7u+fb8zpruoo0O5Bwm5IJeU0ZiaTLjrP
         bsOw==
X-Forwarded-Encrypted: i=1; AJvYcCV6jv8cnI++u65lOuqm+vOl/bZ0gGkQa1IKJ6o3OtV3r0eg7z2a8TwNemmp7yAJFNkR9b1qc1Bikt/rewk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMBpv1ESqkFawd62o3Ugugspcm0YeOQ2RERv4/WuYvuNvVfaJ
	qLUWqUS0d9o4XXPHjhLatGluOGrMshtqsrWMa6DTtRk6K8ZhssBEyNr2Ssy4tGlJRfxFB5WhXPr
	svY3MCTvbPq0UnyejoRP5uDaaRAaRWQI1Nn2+QLht7BYcDT6jpz5mESiEVWYUGT+u+Ac=
X-Gm-Gg: ASbGnct/ZK1rOaaLlcECWElUW3ESmIUTOkTA+4qsWgzNo1nnMRDI06OTcGqfj8WZIPK
	qB+p2+r4VrekhrTmUngu83aQH4dJtoAIgQYjgCztI/yRDC8BX4YfQzY0AZMGI+60yGm25zFci0u
	EVLnu/Q2v++brZdMLq3GmFocN5SLY7IMhT1u3RvzFp7r0WNOJ7zx9/7sTTDOUoIplI+ea5b+dF9
	UnafroEh1QWhOZzLrmPeTLaHThfBh0NN0un++mwPizrMUsfJTzulHUfi8ZG93DjEWri/Cn6osNd
	Y/xWsoddLxFP9C4qDxJnSFqHD4B5VYWyBpjdTcl6kCTazJVoSqEtl/t0Dxo6y4oJ/pHQPjAG32k
	glzih6LId3iYDzSqxomrgaXb6UUgGJpNHiOmesnJhkKysYh6iwk5o
X-Received: by 2002:a05:6214:c8b:b0:707:a430:e01b with SMTP id 6a1803df08f44-70ba7a5ebe0mr42596326d6.3.1755294766972;
        Fri, 15 Aug 2025 14:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyBgvbgFRklSHyhj3CH97naQZBMoVWHYIh+7R80r7kXCtbNHUMb1dOMvYdSmX8rEDFDg6bNQ==
X-Received: by 2002:a05:6214:c8b:b0:707:a430:e01b with SMTP id 6a1803df08f44-70ba7a5ebe0mr42596136d6.3.1755294766500;
        Fri, 15 Aug 2025 14:52:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ffb0esm495523e87.135.2025.08.15.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:52:45 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:52:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: setotau@yandex.ru
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sdm660: Add missing LPASS/CDSP vote
 clocks
Message-ID: <gg3pzvlxgvcfqkl4ko65dgyf4jv7umsdthcpyrb3orgmix6xfm@3obaewnzgat2>
References: <20250815-gcc-sdm660-vote-clocks-and-gdscs-v1-0-c5a8af040093@yandex.ru>
 <20250815-gcc-sdm660-vote-clocks-and-gdscs-v1-2-c5a8af040093@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-gcc-sdm660-vote-clocks-and-gdscs-v1-2-c5a8af040093@yandex.ru>
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689fac30 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=vaJtXVxTAAAA:8 a=EUspDBNiAAAA:8 a=FM-fRCrO_02lKpoybmcA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: s89OFabUfXR7A7ucQdmx4Yh6tGh_ZzCI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX2cwMuFsacX3m
 fnKmx+1EAIkftg+Z7aCi8t/20bipHKvYP6YwbdrmMGSkabJf8fsrF+7nFSYbm01bznkzbwapr1f
 NBNQs0UUdImDDkPd2rEMedkgbk2jJZLScsTqfgdQoHsl0GUTxIH9JuBD57MyrxinEXTtDmJBpcA
 h1NuMbKv6VXUnps1Vd76yMqpttYXzGKEmzhdOTuAOdjHQ6uV8ln01FZjvjhZ27BxXLRGDJZzI95
 joemLQq2RrRPpHY0eGyL/36l+2DSucEIypqLpZ5Owj5H/IBvW0Fuj6X6fmdXqkwDdmUzVjFM5gw
 +oQfK5ybxi3SNshxC5owzB5WynFzvHyHbP2bFcKl08r2Fw5pACRKcte2nsXRL2HIAAvSwAb/1HR
 HZM/fUGr
X-Proofpoint-GUID: s89OFabUfXR7A7ucQdmx4Yh6tGh_ZzCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On Fri, Aug 15, 2025 at 07:56:52PM +0300, Nickolay Goppen via B4 Relay wrote:
> From: Nickolay Goppen <setotau@yandex.ru>
> 
> For the proper functioning of SMMUs related to the audio/compute DSPs,
> it makes sense that the clocks and power domains they rely on for
> communication should be online.
> 
> Add the vote clocks & GDSCs that, when enabled, ensure all such
> requirements are met, through various internal mechanisms.
> 
> Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> ---
>  drivers/clk/qcom/gcc-sdm660.c | 72 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


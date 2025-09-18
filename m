Return-Path: <linux-kernel+bounces-768053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17195B25C67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38843B6012E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D225E448;
	Thu, 14 Aug 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZD7Az6h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFF25CC73
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154569; cv=none; b=li/4vYPRiJeyYLInV99isQOgheC98IiTHA0s25eGsdsRHLU9RpLb1Gx3rLOD7iRQmozwJG4JZg5og+CCy0tI5/Pu5M2VxotWL1Kwvc8u6/SapAH4rquW2+RyqEjgZA6JVS+LK9ZnBCoMW39i3/q6BnJs8u6ZKaa+0NqXGy4J3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154569; c=relaxed/simple;
	bh=Z0U7PjtN+kG7WBV1dWh9tbgD5U+ORVUekeXfSD0DKxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvTyCR7qwxyrZAQtKstOz/QKYuI8qAKFcirY4zKxjXFeK3JGXSUPuZUGFulkza7/dB998sf8Vm5t9UAK4Avf/qsDkI/+j/2BRRxpAjN+CTeRCKv+OD8QT4omE6gadxGosl7c4OZp4cvuSqV9hw4ljhFBt2xFTejW0nOoXveTHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZD7Az6h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DN0SBN029571
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=446NGPC4IHTmfxm6TNEJ0F5d
	cdGOD5iAOKWcZQN3Tyk=; b=OZD7Az6hQdCV3hnFFaBeTxMouTOtSCMGZRTKyvfr
	CkcjX5ZJBlI46LCZnKcLbqGoMfGf1MGiKv6wkjzEPOgT7EhAaT7MG8oCsBwYI+kK
	VNe4AH22aVSyV2fw1q9ZbtrUbkSo6Y26Lm902j9Z1tbaR1tDeCylk4hXm/o9Fz6A
	Fgbr9adslP6BkVhiuRGFFKcQ4HeGxVkbICawX8v6TXxfPGgNybsIFe66VTBcXGh3
	KmZ4szc5c3TPmD9TXM7zcSn8ttke7uRRwT0cWGjXS5vHzBZaCX6KJcdRT4PE0ur/
	+pPJcGP0WQKqkC9B7P79HnhE/Zs0QE0NZPuYcVl3GftKEg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9wr2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:56:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87031ae4dso56770685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154566; x=1755759366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=446NGPC4IHTmfxm6TNEJ0F5dcdGOD5iAOKWcZQN3Tyk=;
        b=vxHEfoFBQnZmyVXT9+oWdadYHty1qxX8+npQ9Y5lcVTgwoYKguxh/3eL4l1Sea0BOO
         /SJOMVXsLIQ5YxF6uCA57wzz9RofUSNzEID124by0wVjpkp/HeB8EAqTkm0UZj3akFyE
         MvlhUmM5BSFpNK6oTEWOCji5qg/dBALpzxTwU5oDEWGXHu6ECQyzV6gsk6goDWV0wBRX
         gol7EovpYBCqvXGxz57fmj/Qt2i97dzOad7eWHyvhHz5iUOvSq+6kKea62W+m362dMav
         Uaq7bZbbDek1v9J8m7SBOdkVOgzSieiG40ETSPHYOA3IE7MDHBLP1Xm3GwJQlYPBJC6T
         PHyA==
X-Forwarded-Encrypted: i=1; AJvYcCUFURZM7tH58MYREIskAeB4tJZZHepXm6dWn5DWSnPcMeNNvSjmEahdJNuBpiLbVQE04oneLGn4W/rEf94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DE5WY5FJR8juxpWz1e/S2GvgoSL8iQpqY53fHkml3Oelwu8K
	NkTcYDKf/6fNU86MohJXsXKgVIt60tAgDnB6YJenzd6gH6gPAOidubr0dhG5aKVSUpofpQTco32
	Mq/WNAe9CjQ9fcblzma1RBrQjMMiH25qj3FQ36J9zmMhGBUPrA9LN4zVcFk9b3OcAiSM=
X-Gm-Gg: ASbGncuBf/CbgY90aVbWE2pjcszGjwWp68Ju7CAg3mB1e+/DNfqnvtql+GvpVgTiYuo
	9S1vE7xkDIVW5qC5TBrfGhtQdvRe27ua8XCrC9KDzB2KgqBYXJgdU3fxDYhJIPchCKgX7YewQgm
	xPli6Ql3OnKXTswtQeAk21+oiXDISuFQAhfyoHv3dgiF32njTIKW85eRedhf2q+joSv441Sk+9b
	4Vs8OLTW1EvPRijjNz9lnyalM2V3dDhBHLVQRJyMy5b6AoJIJs1TlVOuKJbiyPUv6khsdwX23Xf
	78mZL3qKj9KIg+CFTHYeJgZ2YyjVy7FEOb4OToPcih9bFurG0+yOWmbX14dGz9b0NWip04nmV8K
	rEGJ922CXtjeP4q4gXMdGpczWjR7C3y1GOy5nB5WFfexEx2LNUBa0
X-Received: by 2002:a05:622a:1887:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4b10aa6271bmr31968921cf.37.1755154565823;
        Wed, 13 Aug 2025 23:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4eE3QLS9jnWgL6hZSYfORd2c5h9kWoE1NL/aOYxfZybe6CsmPBNHqWg40mW34hJP+Uy4Ww==
X-Received: by 2002:a05:622a:1887:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4b10aa6271bmr31968791cf.37.1755154565366;
        Wed, 13 Aug 2025 23:56:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc859266dsm2374101e87.38.2025.08.13.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:56:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:56:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: marcus@nazgul.ch, kirill@korins.ky, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, andersson@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: describe x1e80100 ufs
Message-ID: <iezjm5d5o7ec7jqweyip2vcqtjv3icidw34yq36k7blxuff2sf@ou7ub3cpwx2k>
References: <20250814005904.39173-1-harrison.vanderbyl@gmail.com>
 <20250814005904.39173-2-harrison.vanderbyl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814005904.39173-2-harrison.vanderbyl@gmail.com>
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d8887 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=2WfLOqSWa4--05Z-PRIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: wRFvao43IPQz0f6cDHhC3OK5nVjLNWPG
X-Proofpoint-ORIG-GUID: wRFvao43IPQz0f6cDHhC3OK5nVjLNWPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX5SA+PKq6Ba+a
 NARw++Fa4EBUSwRgY3pUNwxo07xVCrPXMHu4a9VWa8AiBS4L4fDPM2V9pXrV16Aym3YV2mLCJQy
 NJvTHxy8hFaZG4kRp1y3Sqq9ANFV5RJMJRghRpxh546Uqd4LSvyBmSpz0DUeV255FVdhzX/06Wo
 A6BsAbF7IVwizwNoqbGdqnBMFsqlpPeHEEO2gs/Y7sZb3aKfQYgCvroCXGsuEROTuCm703Ez+BI
 YJ2BzzNh1mbeyHWMtT1fLGFSHMCtkCwAlwlybPI7RmwTogy89PgSva337gbJdC/ICBEJIpv+YRH
 /VyEh1cG66isAYOHnVNebuaWrC4Dc7DL67H0pScttmwh8O1JQHobfsvcI8CUJFLjwBGEYLp/wj2
 B4FRwvO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

On Thu, Aug 14, 2025 at 10:59:02AM +1000, Harrison Vanderbyl wrote:
> Describe dt-bindings entries for x1e80100 ufs device
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

EMpty line before the SoB tag, UFS not ufs.

> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml             | 2 ++

These two files are going to be merged by different maintainers through
different trees. Please split into two patches.

>  2 files changed, 4 insertions(+)
> 

-- 
With best wishes
Dmitry


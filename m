Return-Path: <linux-kernel+bounces-855293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1282BE0C45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35474353E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD42D320B;
	Wed, 15 Oct 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLq1ZTSF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567562D7DDD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562731; cv=none; b=fw2KUwLX5WCJhO8KegGzkUkzKAe80P9n76vrBV/JUKuXieFKkqHvBA+xMYcsddbkxYzz09GeFOdl7S2Fm7lFi1WncCFzdyXlJEVzauCoDRQ4/4CjXbPHZJUku8q+/AmtCp+aerPn/xV+aER3T7tgw8/xugifoRDHCXdGMCBpt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562731; c=relaxed/simple;
	bh=LWv2ta2RyH+poy61wit683v7fn0Osa1/eWBRxGxfyNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHPS9UNNf0QpcDZmRVIvrM5d5TkReMwPBrJY0Cc0eZBmXOS0kypFH4zk5FoDd0qYS2CQv21dtmjUWu8mkqu9jLGrnbJ/n/yuCvNLzp25NGpIZOmNmzSQNOgmOK9uIjgY42u4c/a1559x7sgywnBtESFmW1Ta8sXTiJnXFmE81KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLq1ZTSF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIPwwJ024777
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5QarBm3/FBTaPINCPchmgBMz
	MFWymhf3LhCoHGlEe58=; b=OLq1ZTSFcgtqTvn8xWUhmUuzlC1iw4+6plHbX4cZ
	8Hgylely1tQnUINm6rkeimpthUAg9vE+5M6an8TRJ7etQg9wY7HKGEv7qVLP4IJe
	Rf7/GQQSGOXLtALeOykNbmP6h7SGIcErchxu3cYmUET46kqf1MoIcx/lN6lmfIiv
	BjMYT9opMxmqpli+PskjQeE2hmhk8wzBF7SSn93UZsvb/xXsRZ12v/EjmIjsKHgq
	J6Znd1YymEoftCIZYb8Hj1QsfBJRnZ6hALiqTnMpatM0aHPc3I7UTyGTnuVhD4FQ
	XfOgEokYz+TyHieV52gUu5rfChmVrvtfj7S7n1Jke6xJug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0wwpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:12:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c14264340so291646d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562727; x=1761167527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QarBm3/FBTaPINCPchmgBMzMFWymhf3LhCoHGlEe58=;
        b=HJAWj4OMGRxXjLjew4bFqSWblTj7+noNgBDpRlWdM9neUXS/8pMgn7QJQ41NytYonV
         iuyUUSb4Gzr8bmPIiaMHK2Rn2WnmsQUSbQeTSdAzRA+XySg3dvrAlCJWWoGClVZFZKjg
         Nisl2d+oaCx+RBiQFDAnD/4wu+0dZfKeLKvvUCrH91bwBbFZd7Ma5t4jN7b8uqK7YffV
         NaUkECiKZWlhSJ2kkcEahbidvAAdfJfzTfobbnPnGBikIy7Za8ysrkVg75Ot9Za/lcVv
         m8v6lv4N8BlYj2jnKCGXzx5UWw4QY3B9AFVugy+XaAt5sUCqQIrDecqYEu323lSYKHcb
         xlBg==
X-Forwarded-Encrypted: i=1; AJvYcCW53oRmI7kwvidduMpSFkLczoM8tuCML1PULV5ovFjeMVgiuQOxsnrL5Mqa495Pn2k+o2iM85CcOtASPZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81E+EBO1agw1PoHQZeIkHOFLaihspqXlYplS1JvKMNFcUfZuK
	nU6ua2xn4Zlr0O8wAiNdbg2UYtyceVPDVjyh8pLIiHi4T+amXlbC4KcFGV1WTKuQtz8U9Dh/tx8
	2CW+c1WUvBl9YC0eedar3vBLfbZ0eOgc0Zb+HaO6ZtPXehBeV52tV94OrL9aJmYZ7lHs=
X-Gm-Gg: ASbGncvC9Dah9CLK/04/K0vLEFp9pgr6KRXpmYLtWLGDud0A0bkvUuiK7uCSrL1BJUt
	pseyd+gcXFyCF5Y1ZhvhjaTol4Tgwspu7boYuB2KMTgWOvjo4PqqTbETAPPFlp9mMCjtHoJ6dz2
	lMZUeHhMjBiBfaa/o6eMmAs3VuNQHWV/An52MzhJ+M5O+OUhREY2YEqQl2lodz844SHi/MQRI+1
	0u82aZHqEqwiyaqpnpnB/YRZaAm0udytRZQhaAMGpH4v4Sd25HDh4T79qisYV1v1w8beyjT2TWk
	PDN7/dtYnf4GrW1pO5dsIvpj7FAHZMPKM//IS4ie4+IJqM5smSiGImkMNn0OIcBgRQfDZ05e57U
	IuOySqGSySzZjqJnwU599DBqENTkzSlgFWTCF0boRzWHPYqkPWWcqlUJwLWpwLiEgx7XjHQjPxT
	IepL4vo750wao=
X-Received: by 2002:a05:622a:4c18:b0:4d9:f929:1531 with SMTP id d75a77b69052e-4e6eace963bmr482626401cf.23.1760562727106;
        Wed, 15 Oct 2025 14:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0LHBOSbJEn+k23yLcJqtRiqQ+DR+KSHqYFpB6WhOFy5EPBlYMUm+Vj2w/1rwTr8n8KTdMLg==
X-Received: by 2002:a05:622a:4c18:b0:4d9:f929:1531 with SMTP id d75a77b69052e-4e6eace963bmr482625951cf.23.1760562726575;
        Wed, 15 Oct 2025 14:12:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea44326sm50043791fa.52.2025.10.15.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:05 -0700 (PDT)
Date: Thu, 16 Oct 2025 00:12:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/6] phy: qcom-qmp: qserdes-txrx: Add complete QMP
 PCIe PHY v8 register offsets
Message-ID: <7knbppndo4pbrbowacjbes2z6suigxwdlv6ejxib6lgkeuqrrt@lozxd3nvpf2d>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-3-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-3-84fa7ea638a1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1Y3qbGUTqr/r
 nZ3uLDGrFd+Z8xQINaUcOEXNA3aGyP1FuXIayfpgUtZFjFPuUOv+czRQISwtC5NbuJG+rq2LfzN
 XQtAoN/bWdCuQpYAAyT8ARCqX6E3E6HnG/rXzT7nSzy/x2/zqD+76XnGlPOAwH4OMXvt63/DQo3
 nkcwRwksQMKxMzAVJoylcyCxGr4Q8XEJYXAWaUkFOaUpx5EHCg4uaaBbrm2/2l5nsOWhvl1OLi8
 ZdV/lYBGXPsvGxqjnGmdc2AJBq7tTyGAnCvHGHBpgBHe7p8OLvbpxlU4yOOKG/i/OIIWZb/Klyc
 ywzXcN9SmYqgLe9XB5IP6SacnBq1nbt3WhXZ/R1Hg==
X-Proofpoint-GUID: xigpKxVZrpr_0yosymu2ixbK6Gdl8vR4
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f00e28 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=GXffbDEdBvPQuLycA38A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: xigpKxVZrpr_0yosymu2ixbK6Gdl8vR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 03:27:33AM -0700, Qiang Yu wrote:
> Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but requires
> a completely unique qserdes-txrx register offsets compared to existing v8
> offsets.
> 
> Hence, add a dedicated header file containing the FULL SET of qserdes-txrx
> register definitions required for Kaanapali's PCIe PHY operation.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


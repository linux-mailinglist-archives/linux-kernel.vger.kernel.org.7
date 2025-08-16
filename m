Return-Path: <linux-kernel+bounces-772017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E768B28DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C91CE0864
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB02E424B;
	Sat, 16 Aug 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWTsFUKl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635B23ABA8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348223; cv=none; b=uKIFR23257LsFpLEqH8/ppo/HzvXJoaCn/Y7hrapjPfMpVHPEZsjcrli/Vl0z3/QLg99DBSc8UmFqdRbcQg3oIVoUJnII0kJB2UCCztHLc/yI3HXlUZYQgytyaUYo6uKcEeH9UjAsmsOm5hzsH1jL6Fq64zeDLeo61xSSyZrNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348223; c=relaxed/simple;
	bh=6TgFYNP1lEjsHaeBStSQCEGmt5hICkmmUy4Bb7K6JPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTNFkAkllPFkSLavTwHuAYWqv73JOxWMgFLXMI8krvbhxQD8Cwe0aGkTlt7F2/fP0x3n1/TKzONLvmC8ntcMdzlvcgD1wbu+eDt267yQ+Hb62yQzCuw6M9mBbOxDwxt0+oPQ1Sk2CWpTR6t8ZPBpIejEC6aNvJEN1Ts5h23Pdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MWTsFUKl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G9PlUE009350
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wnbZRQQ9mMuQHPLOu5zBC74Y
	XEciAewoZhL2vFlk+pI=; b=MWTsFUKlqALOj7OfW8kciknPt6Q2q7IBhyKAx6lR
	8R8UQt+XD2B6i/wqbq9AJAdtA7mk83xLw1EshRKsQLHVorllDv+sna1QGdACfRQZ
	d5ixMq0HD3D6AS04dI3jAXAftt449vEnEA5N/4f0Ws67eZpVoXkUOaGdeuXNLuq2
	99MwRNkWF3mzd/4pi3Colxt/raiuscoKnS1S2FSspkqIv6QnZABBOdvhn2gSemv+
	Wy1NrVf3MKfW0yMRUO61eIb8c8t2+/LqKiHZv3KzQ2eNq0+CX/lNoBlg6yqqvB+9
	vUkrHWiqEcJckb0sa0mTZKb110vnpF7i4PvqItXKwL+stA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99ghs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:43:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f57ef93so56675166d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348220; x=1755953020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnbZRQQ9mMuQHPLOu5zBC74YXEciAewoZhL2vFlk+pI=;
        b=d4bC0Fc+zLvJb8VPoUYsala5DNsKZa3tODBgbupt2tSdjDVyEne126jzfpF2FVcUHF
         Ey1VqQHjWTIeQDf+/EiDiXtwQ92P0wH+1T3FofkFWqFs/YBCIY96HUXZx6KWjLkiFTLD
         rJgXPAngblGwEiHcaLNvtiZ/nP7uR6AmwJnHepO4TFL0um7r4UYjJijFo0vT1ToTStRS
         PnSTd3oC0KhTqUtah9pCrrOOdkiC+Pe/2SU1D8raHEc7eFWIlwPjGrWCqE6gnTSzdZOp
         bpu5qvpDvvvqKdKj6zIxpIC6EMCi90362cw8yDSsNkGZ2pJ3dRxkBrKV6cecZNSPQ/te
         LyUg==
X-Forwarded-Encrypted: i=1; AJvYcCWCqpYx52CcCk0rbrQmf6ekjwRZzHMQBYY5ELGP6F5/Rw/EslrrBLWxWEbBLMTltRmsRleQeaypdzd/nQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBq0NN1MtFNkESZ5cMDTBkmO5I6hLffGROMmWzZF1u19vz2ROI
	cSKQ+6JilQc+5lK7AeAM6LwE7d5LXwT6MAUp7cAHJgdwRyrM/F3cCXKrsR3hghcTcsuBtaSgGtK
	mE9i1EOM5N0zA4VfUiO/4pBZsoBW3wvi5LTF3h4ocqG/rUfYasdhJFpyub8/HVLSXS94=
X-Gm-Gg: ASbGncsN2fDLlazz10eJXQ0H5+PXk9Xm+IY9r0oEeqJstDXzy8YytduRDklV4MFvEOn
	JG1hYoIVW6SQJ4qg5mkQeb0LQJp35raIhAVaxV2yq4FCE5LD5Ccqcbu0VzIwOW1ZH5O+uxZlMef
	ezCRUJ3v+bjyR6yCy9CR9+8k7408ufltXFJbcLdnY5ZWHZBZcF2lnZwSsXo9hi/Svfm6MyoKDr2
	y4DsI4xJsRXq5M3VspTkQT0nCkAtqJ4O40HmxRKmeHj2ymU4e2nGhwIz1vUeX8PnceLiHlbNQ1V
	xkbLYiXz0FOXPhorFoglJR0/LHYp3CcOY2ayu2rfjdUFNzi7AERvPiLmk2MVZFOutoaccZjCfuf
	KyAJdvu8r0O5SxPvyQyTvJ7sykW1GI1meI2paTGLeOPYiDPmS7PU2
X-Received: by 2002:a05:6214:5299:b0:709:b6d0:946e with SMTP id 6a1803df08f44-70ba7be61fdmr64078856d6.27.1755348220213;
        Sat, 16 Aug 2025 05:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mxaGHMBAq3flMOYhfAbZP1Br65//td+kAgSqcW5C7HRLHSAZm5covXfrQFeeIoI2toC0TA==
X-Received: by 2002:a05:6214:5299:b0:709:b6d0:946e with SMTP id 6a1803df08f44-70ba7be61fdmr64078656d6.27.1755348219799;
        Sat, 16 Aug 2025 05:43:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a625b59sm9446991fa.59.2025.08.16.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:43:39 -0700 (PDT)
Date: Sat, 16 Aug 2025 15:43:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] interconnect: qcom: add glymur interconnect
 provider driver
Message-ID: <ncay3hc6jqabm2r3wflzxza2g4buc6tbyc77tl4nfjctjmbxal@22e66ed7aswm>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-3-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-glymur-icc-v2-3-596cca6b6015@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: zcXwEJIxhiuoJDI29Ydt5HYZBoV37AaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX2Z6kZaQLM2t+
 3Ur6zVu6ac0+zDbESpr83Bal6IgyinJ7q5NvI7ss6y9Z7ipVLXTLXLErp0YSgASJ3fYfYbOMcbz
 fsjHxRX73pxyq6kBWLHCpy53mEl5Y++y7WVtDYRWwoJJkXvPQ2Dttt0jp9oAn7gs93HXexBGQ6E
 TL/nk7QhqkDndUMYnrDLVt/lRHoPDmb9Ojr0UO+djCrAPHpRSmyB8BMpetcr/o1uCovsMmVD3lF
 Gleg0Ptl7YBp7caUBqgcUFWTWO3lA144WtkQ/dXdMkQ17f4qzYwoMRT/TBM0eR7h2Lv1NOCm6fK
 WvJ7e5tz+MCl5U8cBDihQiujqzULgftSafwBcIzxWbp2wRbCNoA0StG91AalqVGwauBr7pTr3J/
 6ApSQHb2
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a07cfd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=88ugLqT0w4BtEkFF6HEA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: zcXwEJIxhiuoJDI29Ydt5HYZBoV37AaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

On Thu, Aug 14, 2025 at 02:54:21PM +0000, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in glymur
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/glymur.c | 2543 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2554 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


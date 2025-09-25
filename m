Return-Path: <linux-kernel+bounces-833249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F335FBA187F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8641C24A08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A532142E;
	Thu, 25 Sep 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8sZz5an"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFF2D0606
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835693; cv=none; b=Sp9iVDMIYOXYODgHRKixEfCwLA0+B8zjFjJY4MutkklQGz8765SU+u+VePeeqRHiYlpbNoOxKpXpC4B6FOsHZnAobWm8wRoaWenyeLwgoGEw2aNA7J4TPdC0+kgAHjI1wuuLZJJGW2khpuxR0O5L9KHX1fCYQg3i5iJb+AGZ5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835693; c=relaxed/simple;
	bh=mGf87w9ZJVllgijc5JEtI9vZxiYgE1xsayOGWYC3GHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrrPQU5OyDn+cQoA90iYRDVEH8yH9a6+FifM136TVHsQ9ROIu/79BxhciRydy+lG4qOaDS17ltwcbgQdWael0+K+SrY+G2KjLFUZUpepcJNWxM1x5yXIV7uD8c2o9NRh0ifdJ4VvnbSoBOga9xIitU+aw07WirI0LYxjjSghBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8sZz5an; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQMvU022820
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xVJa3hRBr3b8zN4SyC/HCbPD
	O2Mv7vIE7SFYZLeD+YA=; b=B8sZz5anXZPlbzTc9hWAN039PM5eI/vPGLR9keVD
	lp79P3PfevuRe+d5Kc1Zaz8mlSd11QLO931d5PcKqGVijyYlGPGB1nXoKRUwNdBF
	r3mDHD73DhqAZQh3wDMrj68lJ+5USVUq75bsLx66tk2WZrp/3QORyHSOEcvLe9wf
	y8omFZDmX2TZuDBkSmtRMFPvf83NQiUaucsmNvvZSrZGrMqRnyJixksO4+y1EztY
	VnHysQoE83yxbJZqAyvpNyBOsYtcUUGmarQWl/TG5ay+HJFznS5hOU4wO+7GGm46
	GcJtkNrDyZm9WdrSfEoFfeVC0G+0eeIKz5SsHpJie/v9/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qrews-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:28:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dbd8484abbso17768351cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835690; x=1759440490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVJa3hRBr3b8zN4SyC/HCbPDO2Mv7vIE7SFYZLeD+YA=;
        b=QCQZzA22yMgsY+QjMGDq73EkmLdSzCrarj9Q5Z6BeR2INVeLkCzZk/4DIu0FEKNRqT
         0YJODr/2r4Zkl2VXbDyzp9cPOEgo3GYyuvIrFkzB+B5oX7soVnLtj2G+GVSrm8YSp5Bc
         q0WRr4TiaDTDLHIsy1xPSVp7MBWghiIJFAGbOGZvMwguX6heTnLVrnVWhTvfb8rK7vjB
         V6+lIGRLmuiYUyBKHqaq/LsS8KmX6WXmZFPPszgWY/Yp/Py2SzEpVeu5ikGxojhqGkKo
         X7jgiP6r78L9azzMEjZePV9xkugBzDsAvfecM9t/CqAPBFFZx8wDnHQ53xreUsFjNoV2
         gJTA==
X-Forwarded-Encrypted: i=1; AJvYcCVHvT3PMJH84NqMs5A0SApCrkBQgplpMuecmKMQEi5kwn4SEyt+Dp1NeMKy3uujtA7JC+MELf2KCm4jf2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsmkhfvdEGxG6QR3PM//lKmYpvyVu5KduVvVANpLK1cWqSx61
	AKy2iFhUhOhBP0aUhGFucdMZgflD/e98NRQXJozSfeLrqenuQ6GuihUqvpsyaxC2elQDfq9zjNE
	D84sFIJmOV3MBHzdPgPESZv8ArpRPI19BA45ijtWigsQYTZ64hiynjG0uN736DBZ7Tec=
X-Gm-Gg: ASbGncsoCPSGPTo1V3nSPD3Lb8ZhueI8nuUca5B0XXSqBUfbi1Cs/iK3exztV8pDZn5
	BhptdnvmXdQQnuPfxT0pogYgZU4rn010Rp2PZGyIY1OYzUsDiFQdaIvOwrcepZW/SPMCs3EwWlP
	bq0GlJvqbe1dBYKkWb3yGWDLC+Be9/HJPHfav5EGy76IKRBJwV+nPVZJMctyEhMDtBBFeKN1gFz
	WkAzX7wk24i2GeRU/i6f0rYFt6jW2wHss6lt6AngHWikBhRV6jjNdux1cVANKZrkYPUDGJlmBXo
	hrA7uDo9hUBc93n9iLNQ4Wt9zmYleE6i9hmJv0GjJlvqT3MgbzEb+KustZVWiWoRWTSci8JQbZb
	lsPnTJgwg2v5wLBGXkqjeuPSTtkE+hEtEiUqlODFu+pus76Kz1mnu
X-Received: by 2002:a05:622a:4208:b0:4b6:2360:accd with SMTP id d75a77b69052e-4da4d125b3bmr70727611cf.79.1758835689966;
        Thu, 25 Sep 2025 14:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERpLILMpHgYah/4YChT5n6vChPATcZxT+HTlD/SkOj7T7pjCCewNbSF+lhHTpWFPOyyIoKdQ==
X-Received: by 2002:a05:622a:4208:b0:4b6:2360:accd with SMTP id d75a77b69052e-4da4d125b3bmr70727131cf.79.1758835689375;
        Thu, 25 Sep 2025 14:28:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd66fesm1132195e87.54.2025.09.25.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:28:08 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:28:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 7/9] clk: qcom: clk-alpha-pll: Update the PLL support for
 cal_l
Message-ID: <wbabc2pjwe2ir6pb2nd5s3hfaf6y7nd6baabjl3rdgawtsdxq3@ncedo6jio7rz>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-7-29b02b818782@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-clk-v1-7-29b02b818782@oss.qualcomm.com>
X-Proofpoint-GUID: JCuXPPFeJcJDurqZ8nMS158Juv3NupkY
X-Proofpoint-ORIG-GUID: JCuXPPFeJcJDurqZ8nMS158Juv3NupkY
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d5b3eb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QDpnt0wtCZc4EWvjjt8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX0BFCENaMbKAp
 qs8zuM7hLa+hdda2WPdQuyoSmQzc5NH+Py+2iGzK+ezW0BSegg7GPYhf+uwmE+HK7tdwJlX3cw4
 0fO3DYk3tpZC2nz3AANi/vm3jr5m2r1h1FCgbjOxa3P5QDboiL1mTXYubdxIeS53mkpXzllaxN7
 RiPfqSO3xYvk7NQ6VFp1bWocwU3fcmjDc1dlBCy3UR82lqpok5sWnDuhKLkw/eikJUOIeBd170o
 urjp6lZ3pmOV1Qr0j10aNBHkHFwZMogPE5cZGVJtMs770dAezjyaHMQ4doq4OjVnoLphkqZrkro
 eCbCx+/ubs2d2HFbvOCbJgaaqqRFB2Qf+vX13bBbK2kVI36uC6yoQAeUuetswvOMJabcXKZRF44
 BvgB/upLl0Lhaa8UQaLHKhU3TqX7Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Wed, Sep 24, 2025 at 03:58:59PM -0700, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Recent QCOM PLLs require the CAL_L field to be programmed according to
> specific hardware recommendations, rather than using the legacy default
> value of 0x44. Hardcoding this value can lead to suboptimal or incorrect
> behavior on newer platforms.
> 
> To address this, introduce a `cal_l` field in the PLL configuration
> structure, allowing CAL_L to be set explicitly based on platform
> requirements. This improves flexibility and ensures correct PLL
> initialization across different hardware variants.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 6 +++++-
>  drivers/clk/qcom/clk-alpha-pll.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


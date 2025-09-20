Return-Path: <linux-kernel+bounces-825751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA9B8CBAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F71F7E0076
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105482236E9;
	Sat, 20 Sep 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bawthGkb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183678F4F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382390; cv=none; b=EJof6Q3VUMAxYzjrT0AU9OLNbLYQKd6dQ62wC26YYv+nYKqQLdVCxIPjO5B/WKXUTdLvOILt6ts/Db1drkOZHVFwULevKazB2+++dS0LW3vmEChB1NXYtzL7xoV8ISqGAsiZj3JNs/QJuPYLc3h0xvopQS0IbVHX/NYgDF1Nrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382390; c=relaxed/simple;
	bh=oxlPFphhvCPjKkEPOgU7to0mFE3Z7RnHaXKvEgUGOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHMGgMdDgSxsmkzk/9wmYk1Rt3Ed6BjWAAl9kfXkdH48kuaGyUim6cdivC+vhQ5SXobXTOkxJl6oAuTuPAhbmbFUZrXEQ3Kz02gq92M4jEa5mkYnLJsWs8C0SBPby8FycOIM4rCiUlyJ9Vn0L76q0MGwbXcn9PXsAitFcD46xvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bawthGkb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K4eWJZ001310
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8bnu4f5gPl5SUZdfwK3pQt59
	3FcrClm0g4bcABq+Y74=; b=bawthGkb4c/dfaIvvDVYLHg82YXoESMSj8qYYBtN
	/Cj1OHZ93axMaIAZyp/GYAuB8b0zKIQr8ln7xC6yi4JcUXv0CSvGoEs4qSku3dc2
	KtzGCOZiSlK8W1+BK6Zkvg8bhYk4cDRJY9pbAz+NtBVmmYN49qkHEWnyGASt9Kgi
	DXjH5P6ErnQN2Uml2twtia+r8BuGKtVBmDHTDiHSMVCEeL9XQo236+I9SKAtp9vf
	uwh6raavFqsW8I5+0hvtgHPK53TiZqt7cHpTYpcX8o/s6oUeNaj+Nse/Ms60Wk7j
	uPLNbikb1neY+/D5kEB5A0yRnHxalNb4blwDJ2kfjLSehw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nekrrxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:33:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b793b04fe0so57987391cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758382387; x=1758987187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bnu4f5gPl5SUZdfwK3pQt593FcrClm0g4bcABq+Y74=;
        b=LZXaiqWquSiMN149z14Q+e667iU4nf3mWsto444MwcAqZZWTXbbSzLUdQENcD1RR3f
         kasE9mM4bD6m7GQl5TuUaXfBrPOO5uPo3R7XJ7NsdBHLgQrajF+dQ+TH9LBSO5reMj90
         xrkt/TqzntIC8+bz3+Kz02X8whdN6IevhQbuMv8bPHRvqXf4BhvXtJTPaYrKpa05AIYe
         kTd4flHYNY8vaXI2kUIGsKV4ANxqcmKZeKZ41m0VhriRaxReXkvUnOgfUEPQc+yzcX4y
         Z4DYkDRBjYVlJjq97ZVmEYreSY/Gyat8+PKRH+5dS4e33hwhpIOauFI9yQ/IyJr4Rv/Z
         +dOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsoWLwlFLVW9+lnSAQKDWwYskIyIWZzBYmEoPEA2YSBw3RF3J9ll1L3cJE/H6HxwaamVQwvA10D2sgM0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkRApxcFT0YfeHT0JC2hgvx01IWh7V/MlhCIOGJZLcKGclFTv
	nQS821v5btwivB6QS7iiclDZJ5WTPZnrFbn87I14JjEPVz/LOTEx/S/PRmfw5Ih7RKxpDLKweSf
	hoOnRVXP/ecITKcGk0cI9j/AF5csPZ9eZQOf6B2/CyEcvnL8DB5w5qqkpQhxNMjUraVQ=
X-Gm-Gg: ASbGncv3M9TTMki7PiP5XYHSgXzhqwOwSyOvg2YPQlVupuR29KU5zeG6mNZWBSIAGEs
	P1IXO2s7StvtDk8csUN3yqYmeujA2+uqSWlFPY/BxhgXTqenUSS9x59h4uFU7l6d/ji5s0sB4oc
	3NwHEI2ynwVnJQUOWVm3YyaHtqOJnd8rFNEoObHL1JVl9uZXqDyLOAnOS+wTr5szCeW62Z6Ik0J
	Y00tkkGj3vEGM+/dbZll2tDLMCMCkNdVzJiDnn4axssL/gJBafNUkxfPdNMVXtBkHzr/rSeRzdz
	u9b10t0lVOHsoY/iJCUYnxRFgHWsKAxMJL8DDghUDrkfdWOc4yJAevBhct9zjllRJP1ty0M/wuU
	dwZYBVbIo05lGE3FgNAvnlRInwAxGiYvBdmQ+Htxp6M8pgwAsgePU
X-Received: by 2002:ac8:7d92:0:b0:4b5:e644:67e with SMTP id d75a77b69052e-4c06fc182ddmr108612561cf.16.1758382386804;
        Sat, 20 Sep 2025 08:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhsq2yGXKWZNR1YFIQu7K60DKJhHDOBc3PQQe0AV272Fv69oDaxzvCOqzXIvhTLTtKvwRmCA==
X-Received: by 2002:ac8:7d92:0:b0:4b5:e644:67e with SMTP id d75a77b69052e-4c06fc182ddmr108612231cf.16.1758382386385;
        Sat, 20 Sep 2025 08:33:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a28b9e23sm18579691fa.27.2025.09.20.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:33:04 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:33:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 8/9] phy: qualcomm: m31-eusb2: Make clkref an optional
 resource
Message-ID: <nimhwt5glueufk3c7br7f3gzxrch5dklelod3sh5lbj33tg5hv@j4u5hdtspdv5>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-9-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920032108.242643-9-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: lRVLsRrW7W38lSd8j7IKY4tLnqgou4WN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MSBTYWx0ZWRfX+IBv/2yOzbJk
 vI4TmQGbANni4eZDfvk1uI2fhr4bxIRlIRpuMy2XpOVTERWvOrjZs2Aziw2bhQxmLyvcgB7S+nc
 ECegmtPjI60c9M6dEn+JUwtAwlr4kTlxkAnfbprWnYsr4xiiQSWIvoU0OCXh5MPzqrjgirWcaL5
 yibx76YczIxfuxNIZy1XDZQPI8E2XCLfqNhYrizfTy7PQuTTt9LlM0yNo+iMy7dYKDIATgTNmlE
 sGNt3eiZOmP8cK49bN/Lmb7RNUe/tKWXgWlKmgskiicxuTALFuIWl4ztgNTrQgqsX6Vd8S0I35/
 U2XCTBAvovufLVKeMWwcpcNHH386G53IqWiEzhq57JmnVN/6XjnK27T0yJ+0Off5/KnAOyZQbuB
 Cx7WtKfr
X-Authority-Analysis: v=2.4 cv=b+Oy4sGx c=1 sm=1 tr=0 ts=68cec934 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ugsTjJi9MLqOfrGJaKwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: lRVLsRrW7W38lSd8j7IKY4tLnqgou4WN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200041

On Fri, Sep 19, 2025 at 08:21:07PM -0700, Wesley Cheng wrote:
> Some USB subsystems that utlize the M31 eUSB2 PHY doesn't require a clkref.
> One example is the Glymur platform, which contains 4 USB controllers that
> all utilize the M31 eUSB2 PHY.  However, PHYs associated to the primary
> and secondary controllers do not require a clkref resource.  Due to this,
> mark this as an optional clock.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


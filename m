Return-Path: <linux-kernel+bounces-767344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B9B25319
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17668819A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155A2ED17F;
	Wed, 13 Aug 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCVOMLEp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE32ED17A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110048; cv=none; b=Dt7Zn3Swv3Sgyg9YuSuF7hpNbEPP2IweAVaf4eArhUgU2n6K/v+A9SMq7cijxJF7Gs5pUN8vxNDS/nQvR+n629uXQYKuaDMYPrmeGDhSACEkJO+8gBIZYhwzGe/d2EjaAtSnhhZDCsnGZQGFTYaEKXM+SzFTjlJI2FL1dVvdeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110048; c=relaxed/simple;
	bh=kUmQTWdk9V+1tTkKm03spgwkSbz/zp993Uf4kyI6qYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVJcnDAMbeZQWbrRtedKsTUcdk9scUwG+ObKG0t5lH3Y0vlZaTwdxTLZhwBMHcfx1LCymm+jvCoCClzcuJDHnTXTTQaBxPvc0XMvWY7636qPsQMas0MDBexRat9pzoXJnPRbizVqzhQezjg+UKApeqhxP+D6MnN+UrZa+T5zbZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCVOMLEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBM2Q3024302
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RbbIuH/sdpYQmEVk3y27yRzP
	CIaqKohYYi4Lma8EvHc=; b=CCVOMLEpwjoUeubYXUwgO60fK4fGRxqJBt2VopID
	af+NFinWfYPdSmcS9Mvx/E7oYUqhlbR7a3+uUb7KZgYdpU5xLO9vGnzJAQNX5edH
	3e6Belg++OcKiag242j34WVcC0An4GP0AQGUqRic03FyXRx3ntrO6Bhjhy+wGbRy
	+YaL/20GC3xr/hWKG0hdO4ZX37V1GpA9YaROn7Ox1NVw2Dmof741zf6egnIvZk8F
	RRSVbwzZOV8LZI+dMFschkzTUX+mN63gOWjOS5wSNInEKmODJqa6btfjChksVZfy
	O+MZBn9IVb52WqGooiGcbrFDMIJw49cfRuZAz+fxSjJ6CA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rsj45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:34:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109c629f1so2148321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110045; x=1755714845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbbIuH/sdpYQmEVk3y27yRzPCIaqKohYYi4Lma8EvHc=;
        b=dXr/DHYiZMtJJBtzVpYzPqjMmib0WpCcGfOHYO2OXzU/416XxGJDV8d/CVgA4fza9G
         +n7N0TbuM7lrNnqaRvfd+Ebf1hhJ/05BvQ2SEFuHp72YR0q6T3SJmJf4oSiRyWX/aKHd
         PLCwyrP/wLDAcj1HXTT7gpzNM2GQ0WPFvNelV3WFPHkCVK+aM59jeDnqSGigASrlbn8i
         7a/dedwbD3l46xvYpCyRTu3NwBr9x7D6c3KVhsU2JaPIQJ3DVQthEeh1kBeloOHXsZ3B
         v+v/Y7z8NAyEWj0IyZHvRrtQH7hJztb7Z+lX9HrrRPdh2PRPibecgdOGfuq92Tg/Tmwz
         /suA==
X-Forwarded-Encrypted: i=1; AJvYcCU0E6s1TxhOkPE7vVaSUC9MGpqn0yUg1dNA9u6+UbEZ9daly8qYrKwEkre3fdWXM7morqMIkVVkO2c1e0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGc07bxRGiL1GQqP5XHICXBnOGBDea02RpRAWyUl4TYuAcQerj
	Iy3wHrkLGapAi3N2rxBsi0wUoQTwH3IPQGn4/4++BDAFWtPFUQePpZDu9G5nc2I7tqQkObN4SBz
	LdFVLU/ayghHs7sxaOSUHA6kJF+apFsDdUVcbmRU33Op3rTtI5FjnxvO6W1mI2KLeEJ8=
X-Gm-Gg: ASbGncuW2TxXKgF0HZ1+KGDcQYystakBD/UeWav4RjDlpcE5mbZaO0Re61QkodrJaaF
	6ZZvi2NIscHxGIeiqIAAqaf6VkqNvgXBcw8DaUODnN5RqlCFJWPCTALbeW5IBDcDgyBbWhpD41k
	9JKdLLAFz1AxaOcQ3DsRP8yf70y+zwsS1uz4cDnZ3uQjrKY/GrQo/kMt73wCh7Giz0372Q2Fqd2
	KycGQFDExtVd0yvWtwYpGlwDv58+SzwKezDCNT9ANTILQQlq//CMudHY656b5evhG67rtiEF7Nd
	6zI6JbekxLFp/Bl3dH6n/800kayZXOdSF6eU7sjBnJEThBGB4p/DPwyH+Ii2JohflFME5yiUX+0
	+6z1EZgyqMcSgQ7AILC1DNH9TeH20eUhH9YYNLIO1O2DpGzuyTEu6
X-Received: by 2002:a05:622a:260a:b0:4b0:6b56:a8b1 with SMTP id d75a77b69052e-4b10aa62697mr3869901cf.35.1755110045037;
        Wed, 13 Aug 2025 11:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECb9y3wiMWwr7oehL+bvxb51ZpRU4zKOSDOO+2W9vdTGyFjzC5xHK+xSAYLOp0JqjmIz0mkw==
X-Received: by 2002:a05:622a:260a:b0:4b0:6b56:a8b1 with SMTP id d75a77b69052e-4b10aa62697mr3869231cf.35.1755110044494;
        Wed, 13 Aug 2025 11:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9fd163dbsm4427551e87.156.2025.08.13.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:34:03 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:34:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8450: Fix address for usb
 controller node
Message-ID: <y3uw6fcpv23cy2ghn32pqoz636dvd26s3y2yk66m6ivnm3qqvk@vi34nhwhusoz>
References: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfXzWtBCABQph0H
 cjywWKPW6qG7IPwjMJP3KCKkx9q+7RNiOAl071b5ukg+hOB5ZKmZ+WBAnJaZoaYgqMf4+n7lo5L
 BwQ59a8WOocCUdFAhqK7a+l7S9eLOD+9xsJwO3co/OrHm9ksvFjXIivHEKKvPFbdAkTkvIGQPTE
 lJWRle6WVZ4XbjP2AL8ZDLNLG3fx0OGKSXuMBaASJtUrp1DH1ecOIgth70ton+TWr1+aRYr3nFC
 ZcGW/N5sFrCwOYpi5IJJ8mBzfny9cQUv1UNlFe5Awbnmg5tIkZwJZXpiogO8Q/lgPGteZpaRgX7
 EcykGUFn1q2a2yrBFi1mxyC1UUa7iCBLNnkyktVOdcFNB1nA4sVP8FrOwD4pww8XTfrMDRInz5H
 QoETkbl1
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689cda9e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=jh6GGb6eVuZbO_8R6MYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: A5_sWDntHdsIm2IezyPipa2-kuw9lt1D
X-Proofpoint-GUID: A5_sWDntHdsIm2IezyPipa2-kuw9lt1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On Wed, Aug 13, 2025 at 09:39:14PM +0530, Krishna Kurapati wrote:
> Correct the address in usb controller node to fix the following warning:
> 
> Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
> format error, expected "a600000"
> 
> Fixes: c5a87e3a6b3e ("arm64: dts: qcom: sm8450: Flatten usb controller node")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> This change was tested with W=1 and the reported issue is not seen.
> Also didn't add RB Tag received from Neil Armstrong since there is a
> change in commit text. This change is based on top of latest linux next.
> 
> Changes in v2:
> Fixed the fixes tag.
> 
> Link to v1:
> https://lore.kernel.org/all/20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com/
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


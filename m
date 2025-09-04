Return-Path: <linux-kernel+bounces-801299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74943B4437A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA4A162624
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4930F813;
	Thu,  4 Sep 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OodcnVPr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E53093C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004214; cv=none; b=tofLjiXYJuhgvB+ZtlhhsLxZEsPCba7M5SpXndN+BsclTjrLlMYFwYrtBw9GyBOoUBasvtUlkNiblvF/4adRAyD+1GiISq1b1bYEzYkOb5kCnn9Wcjv1kxJCWsJtN2AKJt5zfZdUGWMdXpV6sFID6Gh6cMlXMaW/6cyVX3LpUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004214; c=relaxed/simple;
	bh=w2dejdkgkOfnR6ZZTToOeg39YeTLEfhrSvr2kuE6Luk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4SLhyPBO2Ol9YsYJz8uuEPkcau2ZOn2vDOr5uPkRydWPaAH2hb0eS5nU0QpMfLYCgsLogX/7VtdSEjInUBHcP6GLH3m+2lIqjfCrd7iyxZW9V8GWJ0HPFjoTEIb11mB2i/b5FJZ0X9jShK69AB3OG5qS0kEguOab0Qp3xW4TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OodcnVPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8dL032207
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=194cO1GmvVxOIcn8RfAnyM1k
	UF1gEHExRQSWfZpXVr8=; b=OodcnVPrmCsLxy2Ifo65URS3b/n7rJGtjCtQrPr5
	W0/TwIJsPKYuipsemCHLWxwqDYvck4Q65+3QQ3Nu59kBnc+YuocNLB7DqX54Z7k7
	5PPbczjGmEifemYZq/NRv2bV7ySZG/bNC79Ftn13pmGDQCzolsfjT9CFjFFnmMqe
	b6Va5R3e1WqqbePZYivyGv728YorPdGIWJQOxfuTezpM0gO6ZWtdUJL6eTL527T0
	A8wC9B6xhzsxwnJDnb4cuVC+b7FeKUyz8LuKD3LK1vXkcka4grf9Mae0Doo+UtmK
	4z1dnxQfgzGfHWIBRhWArTqtx1X1rnQoEedB1BbWcpHk6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpgcdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:43:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b47b4d296eso26086091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004211; x=1757609011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=194cO1GmvVxOIcn8RfAnyM1kUF1gEHExRQSWfZpXVr8=;
        b=TyGhbyG9jFGGgPJQE2LbV6JNkb6FKxfvKVfHnLs0GpedLri4Yn6PconwbmdzihxbaL
         Kkg+k8vu6H7cQvlFTN1wHHoCAxJZXW0mubxwdf7fwo57hJPJRgCmCyflyy6pHukM4PGu
         xFcPDtElejqGBUMGflPcaaonj7ouUBhRUzUpcAVzLDz5i3Pt8uH3PRktXQDlAPZAaZ2u
         D2pG14aspWH/ovUf2OljjT3/58qLvD58lDFKYGCtrofD59Er2/Q10kHUFYIHaW+aWGu7
         Z3vGNG9aPfOq5FnTfYitjPmpYxf/09+24o1VwosRI0jwN4RJ6MJaSXuB0sezEE4g7ATF
         dhUw==
X-Forwarded-Encrypted: i=1; AJvYcCVL6evTVar6gx1oSu65DZuFDNqDqytzzOflmFcewC7NvNPpJtyH38u8KZnPDKXpcT+OZw8fPbmjOCK8q+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/gr642zt1hZ9fDeC7IhEt5+Fnd9QezKaFQwpdMbD9dXnGlCO
	sEIZAhPqMteCFw7CZh0PBY5TJWaliT2AUEiVp5UGFy7/Wum7/2vuOx9HA3ynFn7PD/pjVeJa32m
	pQY/pVAlOG4mD4ywV2CWrzWqgCHv44XJb++ZGKhBTEqNNqwRuyDgVnWkoGZ7KXXiF3Ik=
X-Gm-Gg: ASbGncvNu2uFnh+0CGC2FsRgz0Zt79rrnaffVYY8AZ3KusZPhxrlxBSVxOcXSrckq7/
	kQXObtjckVoYDvAD1HzfvbG3ZLGnzhhZ8RD7wfdF+lOeeZWjSTSEPUYdXP6iqRvebzDhUGay2GU
	hh204+SyXbEJSaPHkprqmAI1uO4rx0wfJYxyq1vRcuzegMa9wOys/hBOtwfMF/PiOSMqAfPLr6Y
	0uUf7BzDumjFcBIk5/2cExYLdMyqgL5josjy7G+KfoopCoyrU1fzuyMUlhhiw+S4seLbMJjS28o
	tcCKI5CytgB1yWnualB8X2V0Eyih0t3ZN6hQuWFgy9P89QHKCm9ahYcMzcsnOmz2WPFKYL3rn6j
	72dFtUQn2FVJFeXprSE/vKis/1zX8ZJoEOlIpMSgcI9Wj69A5o+jt
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64210781cf.50.1757004210441;
        Thu, 04 Sep 2025 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoXhcaDoqYlrzIzgBJXwbTTQZl4p3OH3mRMEaeJAudeMwawR3Sn0KzCcUZMEdXKJuLkxKt0g==
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64210331cf.50.1757004209938;
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e28csm1307921e87.17.2025.09.04.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:43:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
X-Proofpoint-GUID: JRYb-xbF5aClQEo20zjfbvKc4Ty-upVt
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b9c1b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E0jHSIb16-xZ11K09xUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: JRYb-xbF5aClQEo20zjfbvKc4Ty-upVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7oH132eY6vD9
 z142Xqul9dgAUIe5Ra47/qEZubqHkEVcHR+V8QsiBfCDb0kxKObzat37/gRHifdLx8W6XdsHLV+
 mO1C+SJCCvpbzA1P5GPQrAuSDb0XOyFezVLetl+0FMhQOH1CLq/9jixdx2jU+e+roM1AhZbQGpT
 /acDH48LbLvOjs5yAZzTLk+cbsWKJ57hzKTRsGuSR3rINKYXJ7U4U46AofNc0wgHK3hgqt2Zg8z
 hH1n0+K7mE7cOHMYEakuCypBmLfH/hKR429k5tQvInEOrraYVhPk0mIWVn2R9zr4xjkI0zZC+5t
 5oHZQcPS0y8GNXwKcLzffUkArZYfG1CTNRgSuNttbZRii/MnBqWHg5QZZIQL3gaBeXX9vJADIbe
 /JePTz3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> Add the compatible for 256Kb EEPROM from Giantec.

Why? Don't describe the change, describe the reason for the change.

> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index 0ac68646c077..50af7ccf6e21 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -143,6 +143,7 @@ properties:
>            - const: atmel,24c128
>        - items:
>            - enum:
> +              - giantec,gt24c256c
>                - puya,p24c256c
>            - const: atmel,24c256
>        - items:
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-833215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CFBA16F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E87BAD30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02432128C;
	Thu, 25 Sep 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FXUzJHpY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A2320CBA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833516; cv=none; b=gEwMJUQeJWCjoUKMFLfL5nIyhy31tjKtB9e6CG4P0PkgJKAIsqY26BNH9zMq84XiqdfIUJLyx11Y2Wunkqn6kD6u6UGcHD7Thb6MFwSberB9noNRjwVq+JS7H579FdHRxzRqRNOpCL5gCywhq+GtESpq+xPWaH921BoSHdcdY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833516; c=relaxed/simple;
	bh=60h+PvBhk9ZCE1dSaYvz/x8//Zfi4LUenDLYPEMUE7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsELp8G65EXpXD8pbZiTClpBrr9B/jNDzxNtY+BwyT1Uly4FyWcsHmjvr4l3Yu1kzQNZ8ijV10Vz48bIvHFPOQGb9RAE8UXwZQfRv8u1Sl+8yjPrYoaTFAB3a3TKLl8fudXe7vhC8ezpPnIBlwY6QmXiXEjpy3tTxAsXQ2nZdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FXUzJHpY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPYZq027513
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B1RTyPEbqMfs/M5EeZCCAWjw
	5x88kEh2vuNN32oz2GY=; b=FXUzJHpYu348w/mgaXf8/0uvnYFcbJEqSliTBTPt
	zTGCstM0WZVIM7M8GrsGavu+lwOCgZ/RF0wpVXNtVOT5x+r7/DEdr71Par6LH1Gh
	wKnwwtqE6YlVQ5A2LBbUaivNBJ/RMNq03Cn7ci2B/wK092g/UovboP903xs4Du+r
	K1v6KOiz0OvuvGVoYoHHTwiHSXjUU4VDbmTFSHTAihcks3Ly9BR4Yu2ksZ+SPp0v
	vrXw7MMUHizrjugYAkjEyWVBsYldc91QbYbqYPE5JyTayRa3fESYAyTzpz60J/xy
	rNFin6fnuwYKPWnqaWk+ml3DbqIl5q90wFYbde4byiqMIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0bxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:51:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so33700851cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833512; x=1759438312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1RTyPEbqMfs/M5EeZCCAWjw5x88kEh2vuNN32oz2GY=;
        b=Nu03sJHiVtqakHlKf8OVcp/F/w/cU+SiqxIC6/wyRljUcblKFZPGNtcFPeZGXjfKL6
         0RySfImilAQP8aXE5b1w9YKkVF6PVOOo1JzB22uFy8ApEyVBeJM2e2qvolxnPzTTbeLU
         odeEQmJKfDFuBafzSX6r5C0B/pi0WGm3g4cIE1GqPm9OdF/oZNFJLC5+ZLR9R0U7XQ6U
         zlu87JCzEsPJwINXXx5aSBde5iGPyR4iZGCVIemtcJ3xuiP+HCrZXYuxwxXNN9Uifm5J
         DEekCZjRyqB0FKzxB4DMcXJ3L+6wsLxkbWHxQ6kIn+14pqCix95UCa3m4DFtDdd1P5T/
         g2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpb2AJ/nKzj8/J2RbPo3CIJ1CNGLoi2zyW8hi9530AXgIKYnJ6eUd+BMvRLfCYnbkYaolMnIkJTGPUFFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsp3zo2OjowY6Rm+vdc8ylPQIVneVBDsqun74uonSslW6+aI9
	0xT4ULETZ5KNw+zvVOBjUSYCwP7WPoHth/wEviObMvKSbsRo8W6xozHO4FFvspqLmLMdGLyDKxn
	avYwhenilmbVOtrgRy/CD+EqqoNsqN7L6mC5VuOq0KTWE9I8hWiIU8ptZM9kLnedRyAM=
X-Gm-Gg: ASbGncubyGvUBnRrwtniRqeRfu0GET1INbb+KNHqu1hv3Kr2AL7j2gmJQBPFJvQ3gBn
	b7pEsKdEsfTvc1kgHimQ+w49r1VaxDNkwyONB6koeVwTfBNd+JdfAEmBK3vQb9B6KK6bj3MDKlk
	175z0YYLMed2g7Js+wwMvOdtaKRU+u2yuDXcUBhyGGXfB+r2LMfx1jP0LqvmJIGaHpAjszJ5RyN
	lFBPzMzp4VW8wqv0Am2LuZ5JwQs9YFmZglsDSGCh3g3B4Lgzkdl1QR6uOH2BLBFGHThxpNSooAH
	10J6yI2R7zzRMd0UK11qWS7TMgOxQOAITNUTDAL5vaZfNkDvg/L7eX8vrj/KOkfjimoukw3QSZ5
	cEL/lxQWrV0TMHiXUmodoObA3oJFBjJ7x+ga6Tfd27A7qbgNCrwg/
X-Received: by 2002:a05:622a:14:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4da4cb59235mr61629831cf.58.1758833511685;
        Thu, 25 Sep 2025 13:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKR5yjoppC91j/VvrgzF8NVXXjanhDCZEwgkr9/7TQbyr8UNZPPV3fhtTNkrc+EffTq5DWqw==
X-Received: by 2002:a05:622a:14:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4da4cb59235mr61629311cf.58.1758833511042;
        Thu, 25 Sep 2025 13:51:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a31e48sm1076929e87.110.2025.09.25.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:51:48 -0700 (PDT)
Date: Thu, 25 Sep 2025 23:51:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: display: panel-simple-dsi: Remove
 Samsung S6E3FC2 compatible
Message-ID: <mdgdqm4qurstamxyt4nvkrabf2k57sf6so7qp7plmhtpqh4qtk@vohj4ofwhyt7>
References: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
 <20250925-s6e3fc2x01-v1-2-9293016768f7@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-s6e3fc2x01-v1-2-9293016768f7@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX7nzC+Oq3Hikq
 n/3sXb4WaeqNeQzY8lIp/ubcC/35c+2WI7Kd23lqUQvhIBmFe/4cOfXrg2eZCzo2vVQaC1NtC/W
 gv1ezvADh67yl891PrL9pC/sSBik5BhSWCAZQdMwGiOeThQ6AvRcosg+QH6hBgjeqmXcQHkHJC9
 D5XhpgiE3e3KTx7LChUWGAAPV0Lbs0O/Iv9yHa8pI8ZUq7cKXs3+YSXbKg+KtjOVs7hjM9xYBMz
 ISENFeQy6pHp960ol9p7QvmfQotDMGqRaTz9qKTVHCLks2IOrlUcPta+so6ki/RG0GczY2fMLVJ
 pcphts9Mp7i5flMUyFhDZrdDYhlFXR6JdqdvqdPWvmT+WgtAIbRbm2NQwWJNkfoU1ZTNSvt5f1L
 I349/du45Udx9Ytff3hNF2+wDjpNiA==
X-Proofpoint-GUID: j_8j9T4Arli7lByPRlIzplxFwOqpVBBQ
X-Proofpoint-ORIG-GUID: j_8j9T4Arli7lByPRlIzplxFwOqpVBBQ
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d5ab69 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=RREAxZkodCCEBgaENwQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 11:12:48AM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Follow up commit introduce the proper device tree definition for the DDIC.

And the reason being?

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> index 9b92a05791ccf99061ab7a1e01937bb832a96fe6..6c1249a224c8a170b33fd3f331f985f16914cb2c 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> @@ -56,8 +56,6 @@ properties:
>        - panasonic,vvx10f034n00
>          # Samsung s6e3fa7 1080x2220 based AMS559NK06 AMOLED panel
>        - samsung,s6e3fa7-ams559nk06
> -        # Samsung s6e3fc2x01 1080x2340 AMOLED panel
> -      - samsung,s6e3fc2x01
>          # Samsung sofef00 1080x2280 AMOLED panel
>        - samsung,sofef00
>          # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

